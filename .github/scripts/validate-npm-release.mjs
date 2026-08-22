#!/usr/bin/env node

import { spawnSync } from 'node:child_process';
import { createHash } from 'node:crypto';
import { readFileSync } from 'node:fs';
import { basename } from 'node:path';

const expectedPackageName = '@weppy/roblox-mcp';
const requiredPaths = [
  'package/package.json',
  'package/dist/index.js',
  'package/dashboard/dist/index.html',
  'package/roblox-plugin/WeppyRobloxMCP.rbxm',
];
const forbiddenPrefixes = [
  'package/docs/',
  'package/.agents/',
  'package/.claude-plugin/',
  'package/.codex-plugin/',
  'package/.forge/',
  'package/.git/',
  'package/.github/',
  'package/plugins/',
];
const semverPattern = /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*)?(?:\+[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*)?$/;

function fail(message) {
  console.error(message);
  process.exit(1);
}

function parseArguments(argv) {
  const argumentsByName = new Map();
  for (let index = 0; index < argv.length; index += 2) {
    const name = argv[index];
    const value = argv[index + 1];
    if (!name?.startsWith('--') || value === undefined) fail(`Invalid argument: ${name ?? ''}`);
    argumentsByName.set(name, value);
  }
  return {
    tarball: argumentsByName.get('--tarball'),
    version: argumentsByName.get('--version'),
    registryIntegrity: argumentsByName.get('--registry-integrity'),
  };
}

function inspectTarball(args) {
  const result = spawnSync('tar', args, { encoding: 'utf8' });
  if (result.status !== 0) fail(result.stderr.trim() || 'Unable to inspect npm tarball');
  return result.stdout;
}

const { tarball, version, registryIntegrity } = parseArguments(process.argv.slice(2));
if (!tarball) fail('--tarball is required');
if (!version || !semverPattern.test(version)) fail(`Invalid SemVer: ${version ?? ''}`);

const assetName = `weppy-roblox-mcp-v${version}.tgz`;
if (basename(tarball) !== assetName) {
  fail(`Unexpected asset name: expected ${assetName}, received ${basename(tarball)}`);
}

const entries = inspectTarball(['-tzf', tarball])
  .split('\n')
  .filter(Boolean)
  .map((entry) => entry.replace(/\/$/, ''));

for (const requiredPath of requiredPaths) {
  if (!entries.includes(requiredPath)) fail(`Missing npm runtime file: ${requiredPath}`);
}
for (const entry of entries) {
  if (entry.startsWith('/') || entry.split('/').includes('..')) fail(`Unsafe npm tarball path: ${entry}`);
  if (forbiddenPrefixes.some((prefix) => entry === prefix.slice(0, -1) || entry.startsWith(prefix))) {
    fail(`Forbidden npm tarball path: ${entry}`);
  }
}

let manifest;
try {
  manifest = JSON.parse(inspectTarball(['-xOzf', tarball, 'package/package.json']));
} catch (error) {
  fail(`Invalid package/package.json: ${error.message}`);
}
if (manifest.name !== expectedPackageName) fail(`Unexpected package name: ${manifest.name ?? ''}`);
if (manifest.version !== version) {
  fail(`Unexpected package version: expected ${version}, received ${manifest.version ?? ''}`);
}

const integrity = `sha512-${createHash('sha512').update(readFileSync(tarball)).digest('base64')}`;
const registryState = registryIntegrity === undefined
  ? 'publish'
  : registryIntegrity === integrity
    ? 'noop'
    : 'conflict';
if (registryState === 'conflict') fail('Registry integrity does not match release tarball');

console.log(JSON.stringify({
  packageName: expectedPackageName,
  version,
  assetName,
  integrity,
  registryState,
}));

#
# WEPPY — One-line install script (Windows PowerShell)
#
# Usage:
#   irm https://raw.githubusercontent.com/hope1026/weppy-roblox-mcp/main/install.ps1 | iex
#
# Interactive 3 steps:
#   [1/3] Setup — install WEPPY Roblox Studio Plugin via npx
#   [2/3] Register MCP with AI apps (user selection)
#   [3/3] Setup WEPPY AI Agent Plugin for Claude Code / Codex / Antigravity (best effort)
#

$ErrorActionPreference = "Stop"
$script:InstallLogPath = Join-Path ([System.IO.Path]::GetTempPath()) ("weppy-install-{0:yyyyMMdd-HHmmss}.log" -f (Get-Date))
$script:TranscriptStarted = $false
$script:NpmCommandPath = $null

# ── Utilities ──
function Write-Step($step, $msg) { Write-Host "`n[$step] $msg" -ForegroundColor Cyan -NoNewline; Write-Host "" }
function Write-Ok($msg) { Write-Host "  ✓ $msg" -ForegroundColor Green }
function Write-Warn($msg) { Write-Host "  ⚠ $msg" -ForegroundColor Yellow }
function Write-Fail($msg) { Write-Host "  ✗ $msg" -ForegroundColor Red }
function Write-Info($msg) { Write-Host "  [INFO] $msg" -ForegroundColor Blue }
$script:AntigravityCliRequiredMessage = 'Antigravity CLI is required to install the WEPPY AI Agent Plugin'
function Write-AntigravityStatus($Status, $Message) {
    switch ($Status) {
        { $_ -in @('installed', 'updated', 'reinstalled', 'repaired') } { Write-Ok "${Status}: $Message"; break }
        'fallback' { Write-Warn "${Status}: $Message"; break }
        'failed' { Write-Fail "${Status}: $Message"; break }
        'skipped' { Write-Info "${Status}: $Message"; break }
        default { throw "Unknown Antigravity installer status: $Status" }
    }
}
function Stop-InstallTranscript() {
    if ($script:TranscriptStarted) {
        try { Stop-Transcript | Out-Null } catch {}
        $script:TranscriptStarted = $false
    }
}
function Pause-OnFailureIfInteractive() {
    if ($Host.Name -match 'ConsoleHost|Visual Studio Code Host') {
        try { Read-Host "Press Enter to exit" | Out-Null } catch {}
    }
}
function Abort-Install($msg) { throw $msg }

try {
    Start-Transcript -Path $script:InstallLogPath -Force | Out-Null
    $script:TranscriptStarted = $true
} catch {}

trap {
    $message = if ($_.Exception) { $_.Exception.Message } else { $_.ToString() }
    Write-Fail "Installation failed: $message"
    Write-Host "  Log saved to: $script:InstallLogPath" -ForegroundColor Yellow
    Pause-OnFailureIfInteractive
    Stop-InstallTranscript
    exit 1
}

function Confirm-Action($prompt) {
    if ($env:CI -eq 'true') {
        Write-Host "$prompt (Y/n): Y"
        return $true
    }
    $reply = Read-Host "$prompt (Y/n)"
    if ([string]::IsNullOrWhiteSpace($reply)) { $reply = "Y" }
    return $reply -match '^[Yy]'
}

function Resolve-NpmCommand() {
    if ($script:NpmCommandPath) {
        return $script:NpmCommandPath
    }

    $npmCommand = Get-Command npm.cmd -ErrorAction SilentlyContinue
    if (-not $npmCommand) {
        Abort-Install "npm.cmd not found. Check Node.js installation."
    }

    $script:NpmCommandPath = $npmCommand.Source
    return $script:NpmCommandPath
}

function Resolve-OptionalCliCommand($commandName) {
    $nativeCommandNames = @("$commandName.cmd", "$commandName.exe", "$commandName.bat", "$commandName.com")
    $candidatePaths = @()

    if ($env:APPDATA) {
        $appDataNpmDir = Join-Path $env:APPDATA 'npm'
        foreach ($nativeCommandName in $nativeCommandNames) {
            $candidatePaths += (Join-Path $appDataNpmDir $nativeCommandName)
        }
    }

    foreach ($candidatePath in $candidatePaths) {
        if ([string]::IsNullOrWhiteSpace($candidatePath)) {
            continue
        }

        if (Test-Path $candidatePath) {
            return $candidatePath
        }
    }

    foreach ($nativeCommandName in $nativeCommandNames) {
        $resolvedCommand = Get-Command $nativeCommandName -ErrorAction SilentlyContinue
        if ($resolvedCommand -and $resolvedCommand.Source) {
            return $resolvedCommand.Source
        }
    }

    $resolvedCommands = @(Get-Command $commandName -All -ErrorAction SilentlyContinue)
    foreach ($resolvedCommand in $resolvedCommands) {
        if ($resolvedCommand.CommandType -ne 'Application') {
            continue
        }

        $source = $resolvedCommand.Source
        if ([string]::IsNullOrWhiteSpace($source)) {
            continue
        }

        $extension = [System.IO.Path]::GetExtension($source)
        if ($extension -ieq '.ps1') {
            continue
        }

        return $source
    }

    return $null
}

function Invoke-AiAgentPluginCommand($commandPath, [string[]]$arguments, $stderrPath) {
    try {
        & $commandPath @arguments 2> $stderrPath
        return $LASTEXITCODE
    }
    catch {
        Set-Content -Path $stderrPath -Value $_.ToString() -Encoding UTF8
        return 1
    }
}

function Test-AiAgentPluginAlreadyReady($stderrPath) {
    if (-not (Test-Path $stderrPath)) {
        return $false
    }
    $stderrContent = Get-Content $stderrPath -Raw
    return $stderrContent -match '(?i)already|exists|installed|duplicate'
}

function Write-AiAgentPluginStderr($stderrPath) {
    if (Test-Path $stderrPath) {
        $stderrContent = Get-Content $stderrPath -Raw
        if (-not [string]::IsNullOrWhiteSpace($stderrContent)) {
            $stderrContent.TrimEnd("`r","`n").Split("`n") | ForEach-Object {
                Write-Host "    $($_.TrimEnd())" -ForegroundColor DarkGray
            }
        }
    }
}

function Test-McpJsonConfigured($configPath) {
    if (-not (Test-Path $configPath)) {
        return $false
    }

    try {
        $config = Get-Content -Path $configPath -Raw | ConvertFrom-Json
        return $null -ne $config.mcpServers.'weppy-roblox-mcp'
    }
    catch {
        return $false
    }
}

# Require an explicit `@<tag>` so the installer can upgrade legacy bare
# entries (`@weppy/roblox-mcp`) — those reuse npx cache and trap users on
# outdated versions. Tagged entries (`@latest`, `@2.6.4`, …) are preserved.
function Test-WeppyPackageSpec($value) {
    if ([string]::IsNullOrWhiteSpace($value)) {
        return $false
    }
    return $value -match '^@weppy/roblox-mcp@.+$'
}

# Add the MCP server under the canonical `mcpServers` wrapper in the Antigravity
# config and strip any legacy flat key left over from earlier versions.
function Add-AntigravityMcpConfig($configPath) {
    $parentDir = Split-Path $configPath -Parent
    if (-not (Test-Path $parentDir)) { New-Item -ItemType Directory -Path $parentDir -Force | Out-Null }
    $env:MCP_CONFIG_PATH = $configPath
    try {
        node --input-type=commonjs -e @"
const fs = require('fs');
const path = require('path');
const configPath = process.env.MCP_CONFIG_PATH;
let config = {};
const exists = fs.existsSync(configPath);
if (exists) {
  const raw = fs.readFileSync(configPath, 'utf8');
  if (raw.trim().length > 0) {
    config = JSON.parse(raw);
  }
}
if (!config || typeof config !== 'object' || Array.isArray(config)) {
  throw new Error('Antigravity config must be an object');
}
const mcpServers = config.mcpServers;
if (mcpServers !== undefined && (typeof mcpServers !== 'object' || mcpServers === null || Array.isArray(mcpServers))) {
  throw new Error('Antigravity mcpServers must be an object');
}
const next = { ...config };
delete next['weppy-roblox-mcp'];
next.mcpServers = {
  ...(mcpServers || {}),
  'weppy-roblox-mcp': { command: 'npx', args: ['-y', '@weppy/roblox-mcp@latest'] }
};
const tempPath = configPath + '.weppy-tmp-' + process.pid;
if (exists) {
  fs.copyFileSync(configPath, configPath + '.weppy-backup-' + Date.now());
}
fs.mkdirSync(path.dirname(configPath), { recursive: true });
fs.writeFileSync(tempPath, JSON.stringify(next, null, 2) + '\n');
fs.renameSync(tempPath, configPath);
"@
        if ($LASTEXITCODE -ne 0) {
            throw 'Antigravity MCP config update failed'
        }
    } finally {
        Remove-Item Env:\MCP_CONFIG_PATH -ErrorAction SilentlyContinue
    }
}

function Test-AntigravityMcpConfigured($configPath) {
    if (-not (Test-Path $configPath)) {
        return $false
    }

    try {
        $content = Get-Content -Path $configPath -Raw
        if ([string]::IsNullOrWhiteSpace($content)) {
            return $false
        }
        $config = $content | ConvertFrom-Json
        if ($null -eq $config) {
            return $false
        }
        $hasLegacyFlatKey = $config.PSObject.Properties.Name -contains 'weppy-roblox-mcp'
        $server = $config.mcpServers.'weppy-roblox-mcp'
        # Accept args[1] as the weppy package regardless of whether a version tag is appended.
        $hasCanonicalArgs = ($server.args -is [System.Array]) -and ($server.args.Count -eq 2) -and ($server.args[0] -eq '-y') -and (Test-WeppyPackageSpec $server.args[1])
        return ($server.command -eq 'npx') -and $hasCanonicalArgs -and (-not $hasLegacyFlatKey)
    }
    catch {
        return $false
    }
}

function Test-AntigravityMcpRegistrationComplete($configPaths) {
    $foundExisting = $false

    foreach ($configPath in $configPaths) {
        if (Test-Path $configPath) {
            $foundExisting = $true
            if (-not (Test-AntigravityMcpConfigured $configPath)) {
                return $false
            }
        }
    }

    return $foundExisting
}

function Test-AnyAntigravityConfigCandidate($configPaths, $dirPaths) {
    foreach ($configPath in $configPaths) {
        if (Test-Path $configPath) {
            return $true
        }
    }

    foreach ($dirPath in $dirPaths) {
        if (Test-Path $dirPath) {
            return $true
        }
    }

    return $false
}

function Test-AntigravityIdeSurface($cliCommand) {
    if ($env:WEPPY_ANTIGRAVITY_IDE_PRESENT -eq '1') {
        return $true
    }
    if ($env:WEPPY_ANTIGRAVITY_IDE_PRESENT -eq '0') {
        return $false
    }

    $specificCandidates = @(
        (Join-Path $env:USERPROFILE '.gemini\antigravity-ide\mcp_config.json'),
        (Join-Path $env:USERPROFILE '.gemini\antigravity\mcp_config.json'),
        (Join-Path $env:USERPROFILE '.gemini\antigravity-ide'),
        (Join-Path $env:USERPROFILE '.gemini\antigravity')
    )
    foreach ($candidate in $specificCandidates) {
        if (Test-Path $candidate) {
            return $true
        }
    }

    # CLI 전용 재실행에서 installer가 만든 공용 설정을 IDE 설치 흔적으로 오인하지 않는다.
    if (-not $cliCommand) {
        $sharedConfig = Join-Path $env:USERPROFILE '.gemini\config\mcp_config.json'
        $sharedDir = Join-Path $env:USERPROFILE '.gemini\config'
        if ((Test-Path $sharedConfig) -or (Test-Path $sharedDir)) {
            return $true
        }
    }

    return $false
}

function Migrate-LegacyAntigravityEntry($sharedConfigPath, $legacyConfigPath) {
    $env:ANTIGRAVITY_SHARED_CONFIG_PATH = $sharedConfigPath
    $env:ANTIGRAVITY_LEGACY_CONFIG_PATH = $legacyConfigPath
    try {
        @'
const fs = require('fs');
const path = require('path');

const sharedPath = process.env.ANTIGRAVITY_SHARED_CONFIG_PATH;
const legacyPath = process.env.ANTIGRAVITY_LEGACY_CONFIG_PATH;
const canonicalEntry = { command: 'npx', args: ['-y', '@weppy/roblox-mcp@latest'] };

function readConfig(configPath) {
  if (!fs.existsSync(configPath)) return { config: {}, exists: false };
  const raw = fs.readFileSync(configPath, 'utf8');
  if (raw.trim().length === 0) return { config: {}, exists: true };
  const config = JSON.parse(raw);
  if (!config || typeof config !== 'object' || Array.isArray(config)) {
    throw new Error('Antigravity config must be an object');
  }
  if (config.mcpServers !== undefined && (typeof config.mcpServers !== 'object' || config.mcpServers === null || Array.isArray(config.mcpServers))) {
    throw new Error('Antigravity mcpServers must be an object');
  }
  return { config, exists: true };
}

function timestamp() {
  const date = new Date();
  return [
    date.getFullYear(),
    String(date.getMonth() + 1).padStart(2, '0'),
    String(date.getDate()).padStart(2, '0'),
    String(date.getHours()).padStart(2, '0'),
    String(date.getMinutes()).padStart(2, '0'),
    String(date.getSeconds()).padStart(2, '0'),
  ].join('');
}

function writeConfig(configPath, next, exists) {
  const tempPath = configPath + '.weppy-tmp-' + process.pid;
  if (exists) fs.copyFileSync(configPath, configPath + '.weppy-backup-' + timestamp());
  fs.mkdirSync(path.dirname(configPath), { recursive: true });
  fs.writeFileSync(tempPath, JSON.stringify(next, null, 2) + '\n');
  fs.renameSync(tempPath, configPath);
}

const shared = readConfig(sharedPath);
const legacy = readConfig(legacyPath);
const nextShared = { ...shared.config };
delete nextShared['weppy-roblox-mcp'];
nextShared.mcpServers = {
  ...(shared.config.mcpServers || {}),
  'weppy-roblox-mcp': canonicalEntry,
};
writeConfig(sharedPath, nextShared, shared.exists);

const legacyHasWeppy =
  Object.prototype.hasOwnProperty.call(legacy.config, 'weppy-roblox-mcp') ||
  Boolean(legacy.config.mcpServers?.['weppy-roblox-mcp']);
if (legacy.exists && legacyHasWeppy) {
  const nextLegacy = { ...legacy.config, mcpServers: { ...(legacy.config.mcpServers || {}) } };
  delete nextLegacy['weppy-roblox-mcp'];
  delete nextLegacy.mcpServers['weppy-roblox-mcp'];
  writeConfig(legacyPath, nextLegacy, true);
}
'@ | node --input-type=commonjs
        if ($LASTEXITCODE -ne 0) {
            throw 'Antigravity config migration failed'
        }
    }
    finally {
        Remove-Item Env:\ANTIGRAVITY_SHARED_CONFIG_PATH -ErrorAction SilentlyContinue
        Remove-Item Env:\ANTIGRAVITY_LEGACY_CONFIG_PATH -ErrorAction SilentlyContinue
    }
}

function Test-CodexConfigConfigured($configPath) {
    if (-not (Test-Path $configPath)) {
        return $false
    }

    $env:MCP_CODEX_CONFIG_PATH = $configPath
    try {
        @'
const fs = require('fs');

const configPath = process.env.MCP_CODEX_CONFIG_PATH;
const serverName = 'weppy-roblox-mcp';
const expectedCommand = 'npx';
// Require an explicit `@<tag>` so the installer can upgrade legacy bare entries.
const packageSpecPattern = /^@weppy\/roblox-mcp@.+$/;
const headerPattern = new RegExp(
  '^\\s*\\[\\s*mcp_servers\\.' + serverName.replace(/[.*+?^${}()|[\]\\\\]/g, '\\$&') + '\\s*\\]\\s*(?:#.*)?$'
);

function stripCommentOutsideStrings(line) {
  let inSingle = false;
  let inDouble = false;
  let escaped = false;

  for (let index = 0; index < line.length; index += 1) {
    const char = line[index];

    if (char === '"' && !inSingle && !escaped) {
      inDouble = !inDouble;
    } else if (char === "'" && !inDouble && !escaped) {
      inSingle = !inSingle;
    } else if (char === '#' && !inSingle && !inDouble) {
      return line.slice(0, index).trimEnd();
    }

    escaped = char === '\\' && !escaped;
    if (char !== '\\') {
      escaped = false;
    }
  }

  return line.trimEnd();
}

function countTripleQuoteToggles(line, quote) {
  let count = 0;
  let inSingle = false;
  let inDouble = false;
  let escaped = false;

  for (let index = 0; index < line.length; index += 1) {
    const char = line[index] ?? '';
    const nextThree = line.slice(index, index + 3);
    const isOutsideStrings = !inSingle && !inDouble;

    if (isOutsideStrings && nextThree === quote.repeat(3)) {
      count += 1;
      index += 2;
      escaped = false;
      continue;
    }

    if (char === '"' && !inSingle && !escaped) {
      inDouble = !inDouble;
    } else if (char === "'" && !inDouble && !escaped) {
      inSingle = !inSingle;
    } else if (char === '#' && !inSingle && !inDouble) {
      break;
    }

    escaped = char === '\\' && !escaped;
    if (char !== '\\') {
      escaped = false;
    }
  }

  return count;
}

function advanceTripleQuoteState(line, state) {
  const next = { ...state };
  const tripleDoubleCount = countTripleQuoteToggles(line, '"');
  const tripleSingleCount = countTripleQuoteToggles(line, "'");

  if (!next.inTripleSingle && tripleDoubleCount % 2 === 1) {
    next.inTripleDouble = !next.inTripleDouble;
  }

  if (!next.inTripleDouble && tripleSingleCount % 2 === 1) {
    next.inTripleSingle = !next.inTripleSingle;
  }

  return next;
}

function isTomlTableHeaderLine(line) {
  const normalized = stripCommentOutsideStrings(line).trim();

  if (normalized.length === 0) {
    return false;
  }

  return /^\[\[.*\]\]$/.test(normalized) || /^\[.*\]$/.test(normalized);
}

function findAllCodexBlocks(source) {
  const lines = source.split('\n');
  const blocks = [];
  let activeLines = null;
  let state = {
    inTripleDouble: false,
    inTripleSingle: false,
  };

  for (const line of lines) {
    const isHeaderCandidate = !state.inTripleDouble && !state.inTripleSingle && isTomlTableHeaderLine(line);
    const isCodexHeader = isHeaderCandidate && headerPattern.test(line);

    if (isCodexHeader) {
      if (activeLines !== null) {
        blocks.push(activeLines.join('\n').trim());
      }
      activeLines = [line];
    } else if (activeLines !== null && isHeaderCandidate) {
      blocks.push(activeLines.join('\n').trim());
      activeLines = null;
    } else if (activeLines !== null) {
      activeLines.push(line);
    }

    state = advanceTripleQuoteState(line, state);
  }

  if (activeLines !== null) {
    blocks.push(activeLines.join('\n').trim());
  }

  return blocks;
}

function parseStringAssignment(value, key) {
  const match = new RegExp('^\\s*' + key + '\\s*=\\s*(["\'])([^"\']+)\\1\\s*$').exec(value);
  return match ? match[2] : null;
}

function parseTomlStringArray(value) {
  const match = /^\s*args\s*=\s*\[(.*)\]\s*$/ms.exec(value.trim());

  if (match === null) {
    return null;
  }

  const body = match[1] ?? '';
  const values = [];
  let cursor = 0;
  let expectValue = true;

  while (cursor < body.length) {
    while (cursor < body.length && /\s/.test(body[cursor] ?? '')) {
      cursor += 1;
    }

    if (cursor >= body.length) {
      break;
    }

    if (!expectValue) {
      if (body[cursor] !== ',') {
        return null;
      }
      cursor += 1;
      expectValue = true;
      continue;
    }

    const quote = body[cursor];
    if (quote !== '"' && quote !== "'") {
      return null;
    }

    cursor += 1;
    let token = '';
    let escaped = false;

    while (cursor < body.length) {
      const char = body[cursor] ?? '';

      if (char === quote && !escaped) {
        cursor += 1;
        values.push(token);
        break;
      }

      token += char;
      escaped = char === '\\' && !escaped;
      if (char !== '\\') {
        escaped = false;
      }
      cursor += 1;
    }

    if (cursor > body.length) {
      return null;
    }

    expectValue = false;
  }

  const leftover = body.slice(cursor).trim();
  if (leftover === ',') {
    return values;
  }

  return leftover.length === 0 ? values : null;
}

function collectArrayLines(lines, startIndex) {
  const collected = [stripCommentOutsideStrings(lines[startIndex] ?? '')];
  let bracketDepth = 0;
  let inSingle = false;
  let inDouble = false;
  let escaped = false;

  for (let lineIndex = startIndex; lineIndex < lines.length; lineIndex += 1) {
    const sanitized = stripCommentOutsideStrings(lines[lineIndex] ?? '');
    if (lineIndex !== startIndex) {
      collected.push(sanitized);
    }

    for (let index = 0; index < sanitized.length; index += 1) {
      const char = sanitized[index] ?? '';

      if (char === '"' && !inSingle && !escaped) {
        inDouble = !inDouble;
      } else if (char === "'" && !inDouble && !escaped) {
        inSingle = !inSingle;
      } else if (!inSingle && !inDouble) {
        if (char === '[') {
          bracketDepth += 1;
        } else if (char === ']') {
          bracketDepth -= 1;
        }
      }

      escaped = char === '\\' && !escaped;
      if (char !== '\\') {
        escaped = false;
      }
    }

    if (bracketDepth <= 0) {
      return {
        nextIndex: lineIndex,
        text: collected.join('\n'),
      };
    }
  }

  return null;
}

function parseCodexBlock(blockContent) {
  const lines = blockContent.split('\n');
  let command = null;
  let args = null;
  let hasConflict = false;
  let inTripleDouble = false;
  let inTripleSingle = false;

  for (let index = 1; index < lines.length; index += 1) {
    const line = lines[index] ?? '';
    const sanitized = stripCommentOutsideStrings(line);
    const trimmed = sanitized.trim();

    if (inTripleDouble) {
      if (countTripleQuoteToggles(sanitized, '"') % 2 === 1) {
        inTripleDouble = false;
      }
      continue;
    }

    if (inTripleSingle) {
      if (countTripleQuoteToggles(sanitized, "'") % 2 === 1) {
        inTripleSingle = false;
      }
      continue;
    }

    if (countTripleQuoteToggles(sanitized, '"') % 2 === 1) {
      inTripleDouble = true;
      continue;
    }

    if (countTripleQuoteToggles(sanitized, "'") % 2 === 1) {
      inTripleSingle = true;
      continue;
    }

    if (trimmed.length === 0) {
      continue;
    }

    if (/^command\s*=/.test(trimmed)) {
      const parsedCommand = parseStringAssignment(trimmed, 'command');
      if (command !== null || parsedCommand === null) {
        hasConflict = true;
      } else {
        command = parsedCommand;
      }
      continue;
    }

    if (/^args\s*=/.test(trimmed)) {
      const collected = collectArrayLines(lines, index);
      const parsedArgs = collected === null ? null : parseTomlStringArray(collected.text);

      if (args !== null || parsedArgs === null || collected === null) {
        hasConflict = true;
      } else {
        args = parsedArgs;
        index = collected.nextIndex;
      }
    }
  }

  return {
    args,
    command,
    hasConflict,
  };
}

function isStructurallySafe(source) {
  let bracketDepth = 0;
  let braceDepth = 0;
  let inSingle = false;
  let inDouble = false;
  let escaped = false;
  let tripleState = {
    inTripleDouble: false,
    inTripleSingle: false,
  };

  for (const line of source.split('\n')) {
    tripleState = advanceTripleQuoteState(line, tripleState);

    for (let index = 0; index < line.length; index += 1) {
      const char = line[index] ?? '';

      if (!inSingle && !inDouble && char === '#') {
        break;
      }

      if (char === '"' && !inSingle && !escaped) {
        inDouble = !inDouble;
      } else if (char === "'" && !inDouble && !escaped) {
        inSingle = !inSingle;
      } else if (!inSingle && !inDouble) {
        if (char === '[') {
          bracketDepth += 1;
        } else if (char === ']') {
          bracketDepth -= 1;
          if (bracketDepth < 0) {
            return false;
          }
        } else if (char === '{') {
          braceDepth += 1;
        } else if (char === '}') {
          braceDepth -= 1;
          if (braceDepth < 0) {
            return false;
          }
        }
      }

      escaped = char === '\\' && !escaped;
      if (char !== '\\') {
        escaped = false;
      }
    }
  }

  return (
    !tripleState.inTripleDouble &&
    !tripleState.inTripleSingle &&
    bracketDepth === 0 &&
    braceDepth === 0 &&
    !inSingle &&
    !inDouble
  );
}

try {
  const source = fs.readFileSync(configPath, 'utf8');
  if (!isStructurallySafe(source)) {
    process.exit(1);
  }

  const blocks = findAllCodexBlocks(source);
  if (blocks.length !== 1) {
    process.exit(1);
  }

  const parsed = parseCodexBlock(blocks[0]);
  const isConfigured =
    !parsed.hasConflict &&
    parsed.command === expectedCommand &&
    Array.isArray(parsed.args) &&
    parsed.args.length === 2 &&
    parsed.args[0] === '-y' &&
    typeof parsed.args[1] === 'string' &&
    packageSpecPattern.test(parsed.args[1]);

  process.exit(isConfigured ? 0 : 1);
} catch {
  process.exit(1);
}
'@ | node --input-type=commonjs
        return $LASTEXITCODE -eq 0
    }
    finally {
        Remove-Item Env:\MCP_CODEX_CONFIG_PATH -ErrorAction SilentlyContinue
    }
}

function Set-CodexMcpConfig($configPath) {
    $parentDir = Split-Path $configPath -Parent
    if (-not (Test-Path $parentDir)) { New-Item -ItemType Directory -Path $parentDir -Force | Out-Null }
    $env:MCP_CODEX_CONFIG_PATH = $configPath
    try {
        @'
const fs = require('fs');
const path = require('path');

const configPath = process.env.MCP_CODEX_CONFIG_PATH;
const headerPattern = /^\s*\[\s*mcp_servers\.weppy-roblox-mcp\s*\]\s*(?:#.*)?$/;

function stripCommentOutsideStrings(line) {
  let inSingle = false;
  let inDouble = false;
  let escaped = false;

  for (let index = 0; index < line.length; index += 1) {
    const char = line[index];

    if (char === '"' && !inSingle && !escaped) {
      inDouble = !inDouble;
    } else if (char === "'" && !inDouble && !escaped) {
      inSingle = !inSingle;
    } else if (char === '#' && !inSingle && !inDouble) {
      return line.slice(0, index).trimEnd();
    }

    escaped = char === '\\' && !escaped;
    if (char !== '\\') {
      escaped = false;
    }
  }

  return line.trimEnd();
}

function countTripleQuoteToggles(line, quote) {
  let count = 0;
  let inSingle = false;
  let inDouble = false;
  let escaped = false;

  for (let index = 0; index < line.length; index += 1) {
    const char = line[index] ?? '';
    const nextThree = line.slice(index, index + 3);
    const isOutsideStrings = !inSingle && !inDouble;

    if (isOutsideStrings && nextThree === quote.repeat(3)) {
      count += 1;
      index += 2;
      escaped = false;
      continue;
    }

    if (char === '"' && !inSingle && !escaped) {
      inDouble = !inDouble;
    } else if (char === "'" && !inDouble && !escaped) {
      inSingle = !inSingle;
    } else if (char === '#' && !inSingle && !inDouble) {
      break;
    }

    escaped = char === '\\' && !escaped;
    if (char !== '\\') {
      escaped = false;
    }
  }

  return count;
}

function advanceTripleQuoteState(line, state) {
  const next = { ...state };
  const tripleDoubleCount = countTripleQuoteToggles(line, '"');
  const tripleSingleCount = countTripleQuoteToggles(line, "'");

  if (!next.inTripleSingle && tripleDoubleCount % 2 === 1) {
    next.inTripleDouble = !next.inTripleDouble;
  }

  if (!next.inTripleDouble && tripleSingleCount % 2 === 1) {
    next.inTripleSingle = !next.inTripleSingle;
  }

  return next;
}

function isTomlTableHeaderLine(line) {
  const normalized = stripCommentOutsideStrings(line).trim();

  if (normalized.length === 0) {
    return false;
  }

  return /^\[\[.*\]\]$/.test(normalized) || /^\[.*\]$/.test(normalized);
}

function removeCodexBlocks(source) {
  const kept = [];
  let skipping = false;
  let state = {
    inTripleDouble: false,
    inTripleSingle: false,
  };

  for (const line of source.split('\n')) {
    const isHeaderCandidate = !state.inTripleDouble && !state.inTripleSingle && isTomlTableHeaderLine(line);
    const isCodexHeader = isHeaderCandidate && headerPattern.test(line);

    if (isCodexHeader) {
      skipping = true;
      state = advanceTripleQuoteState(line, state);
      continue;
    }

    if (skipping && isHeaderCandidate) {
      skipping = false;
    }

    if (!skipping) {
      kept.push(line);
    }

    state = advanceTripleQuoteState(line, state);
  }

  return kept.join('\n').trimEnd();
}

let source = '';
try { source = fs.readFileSync(configPath, 'utf8'); } catch {}

const withoutCodex = removeCodexBlocks(source);
const canonicalBlock = [
  '[mcp_servers.weppy-roblox-mcp]',
  'command = "npx"',
  'args = ["-y", "@weppy/roblox-mcp@latest"]',
].join('\n');
const separator = withoutCodex.trim().length > 0 ? '\n\n' : '';

fs.mkdirSync(path.dirname(configPath), { recursive: true });
fs.writeFileSync(configPath, `${withoutCodex}${separator}${canonicalBlock}\n`);
'@ | node --input-type=commonjs
        if ($LASTEXITCODE -ne 0) {
            throw 'Codex config update failed'
        }
    }
    finally {
        Remove-Item Env:\MCP_CODEX_CONFIG_PATH -ErrorAction SilentlyContinue
    }
}

# Add MCP server to JSON config file (PowerShell 5.1 compatible — edits JSON via node)
function Add-McpToConfig($configPath) {
    $parentDir = Split-Path $configPath -Parent
    if (-not (Test-Path $parentDir)) { New-Item -ItemType Directory -Path $parentDir -Force | Out-Null }
    $env:MCP_CONFIG_PATH = $configPath
    try {
        node --input-type=commonjs -e @"
const fs = require('fs');
const configPath = process.env.MCP_CONFIG_PATH;
let config = {};
try { config = JSON.parse(fs.readFileSync(configPath, 'utf8')); } catch {}
if (!config.mcpServers) config.mcpServers = {};
config.mcpServers['weppy-roblox-mcp'] = { command: 'npx', args: ['-y', '@weppy/roblox-mcp@latest'] };
fs.writeFileSync(configPath, JSON.stringify(config, null, 2) + '\n');
"@
    } finally {
        Remove-Item Env:\MCP_CONFIG_PATH -ErrorAction SilentlyContinue
    }
}

$script:AntigravityPluginSourceTemp = $null
$script:AntigravityPluginReleaseTag = $null
$script:AntigravityPluginPreState = 'absent'

function Get-AntigravityPluginSource {
    if (-not [string]::IsNullOrWhiteSpace($env:WEPPY_ANTIGRAVITY_PLUGIN_SOURCE)) {
        $source = $env:WEPPY_ANTIGRAVITY_PLUGIN_SOURCE
        $required = @(
            'plugin.json',
            'mcp_config.json',
            'skills\weppy-roblox-mcp-guide\SKILL.md',
            'skills\weppy-roblox-sync-guide\SKILL.md',
            'skills\weppy-roblox-assets-guide\SKILL.md'
        )
        foreach ($relativePath in $required) {
            if (-not (Test-Path (Join-Path $source $relativePath))) {
                throw "Invalid WEPPY AI Agent Plugin source for Antigravity: missing $relativePath"
            }
        }
        return $source
    }

    $tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("weppy-antigravity-plugin-{0}" -f [Guid]::NewGuid().ToString('N'))
    $archive = Join-Path $tempRoot 'repo.tar.gz'
    New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null
    try {
        $release = Invoke-RestMethod 'https://api.github.com/repos/hope1026/weppy-roblox-mcp/releases/latest'
        $releaseTag = [string]$release.tag_name
        if ([string]::IsNullOrWhiteSpace($releaseTag)) {
            throw 'Latest WEPPY AI Agent Plugin release tag is missing for Antigravity'
        }
        $archiveUrl = "https://codeload.github.com/hope1026/weppy-roblox-mcp/tar.gz/refs/tags/$releaseTag"
        Invoke-WebRequest $archiveUrl -OutFile $archive
        & tar -xzf $archive -C $tempRoot
        if ($LASTEXITCODE -ne 0) {
            throw 'WEPPY AI Agent Plugin release archive extraction failed for Antigravity'
        }
        $manifest = Get-ChildItem $tempRoot -Recurse -Filter plugin.json |
            Where-Object { $_.FullName -match 'plugins[\\/]weppy-roblox-mcp[\\/]plugin.json$' } |
            Select-Object -First 1
        if (-not $manifest) {
            throw 'WEPPY AI Agent Plugin payload not found for Antigravity'
        }
        $script:AntigravityPluginSourceTemp = $tempRoot
        $script:AntigravityPluginReleaseTag = $releaseTag
        return $manifest.Directory.FullName
    }
    catch {
        Remove-Item $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
        throw
    }
}

function Test-AntigravityViewHealthy($Root) {
    $required = @(
        'plugin.json',
        'skills\weppy-roblox-mcp-guide\SKILL.md',
        'skills\weppy-roblox-sync-guide\SKILL.md',
        'skills\weppy-roblox-assets-guide\SKILL.md'
    )
    return @($required | Where-Object { -not (Test-Path (Join-Path $Root $_)) }).Count -eq 0
}

function Get-AntigravityTreeDigest($Root) {
    $rootPath = (Resolve-Path $Root).Path.TrimEnd('\', '/')
    $lines = Get-ChildItem $rootPath -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($rootPath.Length).TrimStart('\', '/').Replace('\', '/')
        '{0}  {1}' -f (Get-FileHash $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant(), $relative
    } | Sort-Object
    $bytes = [Text.Encoding]::UTF8.GetBytes(($lines -join "`n"))
    $sha256 = [Security.Cryptography.SHA256]::Create()
    try {
        return ([BitConverter]::ToString($sha256.ComputeHash($bytes))).Replace('-', '').ToLowerInvariant()
    }
    finally {
        $sha256.Dispose()
    }
}

function Get-AntigravityPreState($StagedCli, $CliTarget, $StagedIde, $IdeTarget, $RequireIde) {
    $pairs = ,@($StagedCli, $CliTarget)
    if ($RequireIde) {
        $pairs += ,@($StagedIde, $IdeTarget)
    }

    $seen = $false
    $missing = $false
    $damaged = $false
    $outdated = $false
    foreach ($pair in $pairs) {
        if (-not (Test-Path $pair[1])) {
            $missing = $true
            continue
        }
        $seen = $true
        if (-not (Test-AntigravityViewHealthy $pair[1])) {
            $damaged = $true
            continue
        }
        if ((Get-AntigravityTreeDigest $pair[0]) -ne (Get-AntigravityTreeDigest $pair[1])) {
            $outdated = $true
        }
    }

    if ($damaged -or ($seen -and $missing)) { return 'damaged' }
    if (-not $seen) { return 'absent' }
    if ($outdated) { return 'outdated' }
    return 'current'
}

function New-AntigravityNativeView($source) {
    $nativeView = Join-Path ([System.IO.Path]::GetTempPath()) ("weppy-antigravity-native-{0}" -f [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $nativeView -Force | Out-Null
    try {
        Copy-Item (Join-Path $source '*') $nativeView -Recurse -Force
        $claudeManifest = Join-Path $nativeView '.claude-plugin'
        if (Test-Path $claudeManifest) {
            Remove-Item $claudeManifest -Recurse -Force
        }
        if (-not (Test-Path (Join-Path $nativeView 'plugin.json')) -or
            -not (Test-Path (Join-Path $nativeView 'mcp_config.json'))) {
            throw 'Invalid Antigravity native plugin view'
        }
        return $nativeView
    }
    catch {
        Remove-Item $nativeView -Recurse -Force -ErrorAction SilentlyContinue
        throw
    }
}

function New-AntigravitySkillOnlyView($source) {
    $skillOnlyView = New-AntigravityNativeView $source
    Remove-Item (Join-Path $skillOnlyView 'mcp_config.json') -Force
    return $skillOnlyView
}

function Remove-WeppyAntigravityMcpEntry($configPath) {
    if (-not (Test-Path $configPath)) {
        return $true
    }

    $env:MCP_CONFIG_PATH = $configPath
    try {
        node --input-type=commonjs -e @"
const fs = require('fs');
const path = require('path');
const configPath = process.env.MCP_CONFIG_PATH;
const source = fs.readFileSync(configPath, 'utf8');
if (source.trim().length === 0) process.exit(0);
const config = JSON.parse(source);
if (!config || typeof config !== 'object' || Array.isArray(config)) {
  throw new Error('Antigravity config must be an object');
}
const mcpServers = config.mcpServers;
if (mcpServers !== undefined && (typeof mcpServers !== 'object' || mcpServers === null || Array.isArray(mcpServers))) {
  throw new Error('Antigravity mcpServers must be an object');
}
const hasCanonical = Boolean(mcpServers?.['weppy-roblox-mcp']);
const hasLegacy = Object.prototype.hasOwnProperty.call(config, 'weppy-roblox-mcp');
if (!hasCanonical && !hasLegacy) process.exit(0);
const backupPath = configPath + '.weppy-backup-' + Date.now();
const tempPath = configPath + '.weppy-tmp-' + process.pid;
fs.copyFileSync(configPath, backupPath);
const next = { ...config, mcpServers: { ...(mcpServers || {}) } };
delete next['weppy-roblox-mcp'];
delete next.mcpServers['weppy-roblox-mcp'];
fs.mkdirSync(path.dirname(configPath), { recursive: true });
fs.writeFileSync(tempPath, JSON.stringify(next, null, 2) + '\n');
fs.renameSync(tempPath, configPath);
"@
        return $LASTEXITCODE -eq 0
    }
    catch {
        return $false
    }
    finally {
        Remove-Item Env:\MCP_CONFIG_PATH -ErrorAction SilentlyContinue
    }
}

function Install-AntigravityCliPlugin($source, $agyCommand, $sharedConfigPath, $mode) {
    if (-not $agyCommand) {
        return $false
    }

    $nativeView = $null
    $cliTarget = Join-Path $env:USERPROFILE '.gemini\antigravity-cli\plugins\weppy-roblox-ai-toolkit'
    $cliBackup = $null
    $stderrPath = Join-Path ([System.IO.Path]::GetTempPath()) ("weppy-agy-{0}.err" -f [Guid]::NewGuid().ToString('N'))
    try {
        if ($mode -eq 'hybrid') {
            $nativeView = New-AntigravitySkillOnlyView $source
        }
        else {
            $nativeView = New-AntigravityNativeView $source
        }

        $script:AntigravityPluginPreState = Get-AntigravityPreState $nativeView $cliTarget $null $null $false
        if (Test-Path $cliTarget) {
            $timestamp = Get-Date -Format 'yyyyMMddHHmmss'
            $cliBackup = "$cliTarget.weppy-backup-$timestamp"
            Move-Item $cliTarget $cliBackup -Force
        }

        $null = Invoke-AiAgentPluginCommand $agyCommand @('plugin', 'uninstall', 'weppy-roblox-ai-toolkit') $stderrPath
        $installExit = Invoke-AiAgentPluginCommand $agyCommand @('plugin', 'install', $nativeView) $stderrPath
        $listOutput = & $agyCommand @('plugin', 'list') 2>$null | Out-String
        if ($installExit -ne 0 -or $listOutput -notmatch 'weppy-roblox-ai-toolkit') {
            $null = Invoke-AiAgentPluginCommand $agyCommand @('plugin', 'uninstall', 'weppy-roblox-ai-toolkit') $stderrPath
            Remove-Item $cliTarget -Recurse -Force -ErrorAction SilentlyContinue
            if ($cliBackup) {
                Move-Item $cliBackup $cliTarget -Force
                $cliBackup = $null
            }
            return $false
        }
        if ($mode -eq 'native-only') {
            if (-not (Remove-WeppyAntigravityMcpEntry $sharedConfigPath)) {
                $null = Invoke-AiAgentPluginCommand $agyCommand @('plugin', 'uninstall', 'weppy-roblox-ai-toolkit') $stderrPath
                Remove-Item $cliTarget -Recurse -Force -ErrorAction SilentlyContinue
                if ($cliBackup) {
                    Move-Item $cliBackup $cliTarget -Force
                    $cliBackup = $null
                }
                return $false
            }
        }
        else {
            Add-AntigravityMcpConfig $sharedConfigPath
        }

        if ($cliBackup) {
            Remove-Item $cliBackup -Recurse -Force
            $cliBackup = $null
        }
        return $true
    }
    catch {
        Remove-Item $cliTarget -Recurse -Force -ErrorAction SilentlyContinue
        if ($cliBackup) {
            Move-Item $cliBackup $cliTarget -Force
            $cliBackup = $null
        }
        return $false
    }
    finally {
        if ($nativeView) {
            Remove-Item $nativeView -Recurse -Force -ErrorAction SilentlyContinue
        }
        Remove-Item $stderrPath -Force -ErrorAction SilentlyContinue
    }
}

function Write-AntigravityResult($PreState, $Message) {
    switch ($PreState) {
        'absent' { Write-AntigravityStatus 'installed' $Message }
        'current' { Write-AntigravityStatus 'reinstalled' $Message }
        'outdated' { Write-AntigravityStatus 'updated' $Message }
        'damaged' { Write-AntigravityStatus 'repaired' $Message }
        default { throw "Unknown Antigravity pre-state: $PreState" }
    }
}

function Enable-AntigravityFallback($configPath, $Message, [bool]$PreferRestoredPlugin = $false) {
    $cliTarget = Join-Path $env:USERPROFILE '.gemini\antigravity-cli\plugins\weppy-roblox-ai-toolkit'
    if ($PreferRestoredPlugin -and
        (Test-AntigravityViewHealthy $cliTarget) -and
        (Test-Path (Join-Path $cliTarget 'mcp_config.json')) -and
        (Remove-WeppyAntigravityMcpEntry $configPath)) {
        Write-AntigravityStatus 'fallback' $Message
        return $true
    }

    try {
        Add-AntigravityMcpConfig $configPath
        Write-AntigravityStatus 'fallback' $Message
        return $true
    }
    catch {
        Write-AntigravityStatus 'failed' 'WEPPY AI Agent Plugin for Antigravity and the shared MCP fallback are unavailable'
        return $false
    }
}

function Install-AntigravityIdePlugin($source) {
    # Windows IDE plugin global path는 아직 실기 검증되지 않아 direct MCP를 유지한다.
    return $false
}

# ── Header ──
Write-Host ""
Write-Host "WEPPY Installer" -ForegroundColor White -BackgroundColor DarkCyan
Write-Host "AI-powered Roblox Studio integration" -ForegroundColor DarkGray
Write-Host ("=" * 40)

# ── Node.js check ──
try {
    $nodeVersion = (node -v) -replace 'v', ''
    $majorVersion = [int]($nodeVersion.Split('.')[0])
    if ($majorVersion -lt 18) {
        Abort-Install "Node.js 18 or higher required (current: v$nodeVersion). Upgrade: https://nodejs.org"
    }
    Write-Ok "Node.js v$nodeVersion detected"
}
catch {
    Abort-Install "Node.js is not installed. Install Node.js 18+: https://nodejs.org"
}

# ═══════════════════════════════════
# [1/3] Setup — Roblox Studio Plugin
# ═══════════════════════════════════
Write-Step "1/3" "Setup WEPPY Roblox Studio Plugin"

if (Confirm-Action "  Run npx -y @weppy/roblox-mcp@latest --setup?") {
    try {
        $npmCommandPath = Resolve-NpmCommand
        $npmDir = Split-Path $npmCommandPath -Parent
        $npxPath = Join-Path $npmDir "npx.cmd"
        if (-not (Test-Path $npxPath)) {
            $npxPath = "npx"
        }
        $setupWorkingDir = Join-Path ([System.IO.Path]::GetTempPath()) ("weppy-setup-" + [System.Guid]::NewGuid().ToString("N"))
        $previousLocation = Get-Location

        try {
            New-Item -ItemType Directory -Path $setupWorkingDir -Force | Out-Null
            Set-Location $setupWorkingDir
            # Isolate stdin with an empty pipe so the stdio MCP server does not inherit
            # the interactive pwsh terminal stdin (which would cause it to hang under irm|iex).
            # The @latest tag forces npx to resolve from the registry instead of
            # reusing an older version pinned in the npm cache.
            $null | & $npxPath -y "@weppy/roblox-mcp@latest" --setup
            if ($LASTEXITCODE -ne 0) {
                Write-Warn "Setup encountered a warning (non-blocking)"
            } else {
                Write-Ok "Setup complete"
            }
        }
        finally {
            Set-Location $previousLocation
            Remove-Item $setupWorkingDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    catch {
        Write-Warn "Setup encountered a warning: $_"
    }
}
else {
    Write-Warn "Setup skipped"
}

# ═══════════════════════════════════
# [2/3] Register MCP with AI apps
# ═══════════════════════════════════
Write-Step "2/3" "Register MCP with AI apps"
Write-Host "  Automatic registration: Claude Code, Claude Desktop, Cursor, Codex CLI/App, Gemini CLI, Antigravity / Antigravity IDE, Antigravity CLI"

$detectedNames = @()
$detectedTypes = @()
$notDetected = @()
$antigravitySharedConfig = Join-Path $env:USERPROFILE '.gemini\config\mcp_config.json'
$antigravityLegacyCliConfig = Join-Path $env:USERPROFILE '.gemini\antigravity-cli\mcp_config.json'
$antigravityCliCommand = Resolve-OptionalCliCommand 'agy'
$antigravityConfigCandidates = @(
    (Join-Path $env:USERPROFILE '.gemini\config\mcp_config.json'),
    (Join-Path $env:USERPROFILE '.gemini\antigravity-ide\mcp_config.json'),
    (Join-Path $env:USERPROFILE '.gemini\antigravity\mcp_config.json')
)
$antigravityDirCandidates = @(
    (Join-Path $env:USERPROFILE '.gemini\config'),
    (Join-Path $env:USERPROFILE '.gemini\antigravity-ide'),
    (Join-Path $env:USERPROFILE '.gemini\antigravity')
)

$claudeProjectConfig = Join-Path (Get-Location).Path '.mcp.json'
$claudeGlobalConfig = Join-Path $env:USERPROFILE '.claude\mcp.json'
$claudeCodeCliCommand = Resolve-OptionalCliCommand 'claude'

# `claude mcp add` stores entries under ~/.claude.json or in local/user scope,
# so prefer `claude mcp list` as the source of truth when the CLI is available
# (the JSON path checks remain as a fallback). The entry counts as configured
# only when its args carry an explicit `@<tag>` — legacy bare entries fall
# through and get re-registered with the canonical `@latest` form.
function Test-ClaudeCliConfigured($cliCommand) {
    if (-not $cliCommand) { return $false }
    try {
        $listOutput = & $cliCommand mcp list 2>$null
        if ($LASTEXITCODE -ne 0) { return $false }
        $line = $listOutput | Select-String -Pattern '^weppy-roblox-mcp:' | Select-Object -First 1
        if (-not $line) { return $false }
        return ($line.Line -match '@weppy/roblox-mcp@')
    } catch {
        return $false
    }
}

$claudeCodeConfigured = (Test-ClaudeCliConfigured $claudeCodeCliCommand) `
    -or (Test-McpJsonConfigured $claudeProjectConfig) `
    -or (Test-McpJsonConfigured $claudeGlobalConfig)

if ($claudeCodeConfigured) {
    $detectedNames += 'Claude Code (configured)'
    $detectedTypes += 'claude-code'
}
elseif ($claudeCodeCliCommand) {
    $detectedNames += 'Claude Code (CLI)'
    $detectedTypes += 'claude-code'
}
else {
    $notDetected += 'Claude Code (not found)'
}

# Claude Desktop
$claudeDesktopConfig = Join-Path $env:APPDATA "Claude\claude_desktop_config.json"
if (Test-Path $claudeDesktopConfig) {
    $detectedNames += "Claude Desktop"
    $detectedTypes += "claude-desktop"
}
else {
    $notDetected += "Claude Desktop (config not found)"
}

# Cursor (detect only when mcp.json or binary exists)
$cursorDir = Join-Path $env:USERPROFILE ".cursor"
if ((Test-Path (Join-Path $cursorDir "mcp.json")) -or (Get-Command cursor -ErrorAction SilentlyContinue)) {
    $detectedNames += "Cursor"
    $detectedTypes += "cursor"
}
else {
    $notDetected += "Cursor (not found)"
}

$codexConfig = Join-Path $env:USERPROFILE '.codex\config.toml'
$codexConfigured = Test-CodexConfigConfigured $codexConfig
$codexCliCommand = Resolve-OptionalCliCommand 'codex'

if ($codexConfigured) {
    $detectedNames += 'Codex CLI/App (configured)'
    $detectedTypes += 'codex-cli'
}
elseif ($codexCliCommand) {
    $detectedNames += 'Codex CLI/App'
    $detectedTypes += 'codex-cli'
}
elseif (Test-Path $codexConfig) {
    $detectedNames += 'Codex CLI/App (config)'
    $detectedTypes += 'codex-cli'
}
else {
    $notDetected += 'Codex CLI/App (not found)'
}

# Gemini CLI
$geminiConfig = Join-Path $env:USERPROFILE '.gemini\settings.json'
$geminiConfigured = Test-McpJsonConfigured $geminiConfig
$geminiCliCommand = Resolve-OptionalCliCommand 'gemini'

if ($geminiConfigured) {
    $detectedNames += 'Gemini CLI (configured)'
    $detectedTypes += "gemini-cli"
}
elseif ($geminiCliCommand) {
    $detectedNames += "Gemini CLI"
    $detectedTypes += "gemini-cli"
}
else {
    $notDetected += "Gemini CLI (not found)"
}

# Antigravity / Antigravity IDE
$antigravityDetected = Test-AntigravityIdeSurface $antigravityCliCommand
$antigravityConfigured = $antigravityDetected -and (Test-AntigravityMcpRegistrationComplete $antigravityConfigCandidates)

if ($antigravityConfigured) {
    $detectedNames += 'Antigravity / Antigravity IDE (configured)'
    $detectedTypes += 'antigravity'
}
elseif ($antigravityDetected) {
    $detectedNames += 'Antigravity / Antigravity IDE'
    $detectedTypes += 'antigravity'
}
else {
    $notDetected += 'Antigravity / Antigravity IDE (not found)'
}

# Antigravity CLI
if (Test-AntigravityMcpConfigured $antigravityLegacyCliConfig) {
    $detectedNames += 'Antigravity CLI (configured)'
    $detectedTypes += 'antigravity-cli'
}
elseif ((Test-Path $antigravityLegacyCliConfig) -or (Test-Path (Join-Path $env:USERPROFILE '.gemini\antigravity-cli')) -or $antigravityCliCommand) {
    $detectedNames += 'Antigravity CLI'
    $detectedTypes += 'antigravity-cli'
}
else {
    $notDetected += 'Antigravity CLI (not found)'
}

if ($detectedNames.Count -eq 0) {
    Write-Warn "No AI apps detected"
    Write-Info "Register MCP server manually: npx -y @weppy/roblox-mcp@latest"
}
else {
    Write-Host ""
    Write-Host "  Detected:" -ForegroundColor White
    for ($i = 0; $i -lt $detectedNames.Count; $i++) {
        Write-Host "    $($i + 1). $($detectedNames[$i])" -ForegroundColor Green
    }

    if ($notDetected.Count -gt 0) {
        Write-Host ""
        Write-Host "  Not detected:" -ForegroundColor DarkGray
        foreach ($item in $notDetected) {
            Write-Host "    - $item" -ForegroundColor DarkGray
        }
    }

    Write-Host ""
    if ($env:CI -eq 'true') {
        Write-Host "  Select apps to register (comma-separated, 'a' for all, 'n' to skip): a"
        $selection = 'a'
    } else {
        $selection = Read-Host "  Select apps to register (comma-separated, 'a' for all, 'n' to skip)"
    }
    if ([string]::IsNullOrWhiteSpace($selection)) { $selection = "n" }

    $selectedIndices = @()
    switch -Regex ($selection) {
        '^[Nn]$' { Write-Warn "MCP registration skipped" }
        '^[Aa]$' { $selectedIndices = 0..($detectedNames.Count - 1) }
        default {
            foreach ($part in ($selection -split ',')) {
                $part = $part.Trim()
                if ($part -match '^\d+$') {
                    $idx = [int]$part - 1
                    if ($idx -ge 0 -and $idx -lt $detectedNames.Count) {
                        $selectedIndices += $idx
                    }
                }
            }
        }
    }

    foreach ($idx in $selectedIndices) {
        $appType = $detectedTypes[$idx]
        $appName = $detectedNames[$idx]

        try {
            switch ($appType) {
                "claude-code" {
                    $claudeUpdated = $false
                    if ($claudeCodeCliCommand) {
                        $claudeStderrFile = Join-Path ([System.IO.Path]::GetTempPath()) ("weppy-claude-{0}.err" -f ([System.Guid]::NewGuid().ToString("N")))
                        try {
                            # Best-effort remove any legacy bare entry so the subsequent add can
                            # install the canonical `@latest` form.
                            try { & $claudeCodeCliCommand mcp remove weppy-roblox-mcp *> $null } catch {}
                            & $claudeCodeCliCommand mcp add weppy-roblox-mcp -- npx -y "@weppy/roblox-mcp@latest" 2> $claudeStderrFile
                            $claudeExit = $LASTEXITCODE
                            if ($claudeExit -eq 0) {
                                $claudeUpdated = $true
                            }
                            else {
                                $stderrContent = if (Test-Path $claudeStderrFile) { Get-Content $claudeStderrFile -Raw } else { '' }
                                if ($stderrContent -match '(?i)already exists') {
                                    Add-McpToConfig $claudeGlobalConfig
                                    $claudeUpdated = $true
                                }
                                else {
                                    Write-Fail "Failed: $appName (exit=$claudeExit)"
                                    Write-Host "    CLI: $claudeCodeCliCommand" -ForegroundColor DarkGray
                                    if ($stderrContent) {
                                        Write-Host "    stderr:" -ForegroundColor DarkGray
                                        $stderrContent.TrimEnd("`r","`n").Split("`n") | ForEach-Object {
                                            Write-Host "      $($_.TrimEnd())" -ForegroundColor DarkGray
                                        }
                                    }
                                    # Fall back to writing the JSON config directly when the CLI fails for other reasons
                                    Add-McpToConfig $claudeGlobalConfig
                                    $claudeUpdated = $true
                                }
                            }
                        }
                        finally {
                            Remove-Item $claudeStderrFile -ErrorAction SilentlyContinue
                        }
                    }

                    if (Test-McpJsonConfigured $claudeProjectConfig) {
                        Add-McpToConfig $claudeProjectConfig
                        $claudeUpdated = $true
                    }

                    if (Test-McpJsonConfigured $claudeGlobalConfig) {
                        Add-McpToConfig $claudeGlobalConfig
                        $claudeUpdated = $true
                    }

                    if (-not $claudeUpdated) {
                        Add-McpToConfig $claudeGlobalConfig
                    }

                    Write-Ok "Updated: $appName"
                }
                "claude-desktop" {
                    Add-McpToConfig $claudeDesktopConfig
                    Write-Ok "Updated: $appName"
                }
                "cursor" {
                    $cursorConfig = Join-Path $env:USERPROFILE ".cursor\mcp.json"
                    Add-McpToConfig $cursorConfig
                    Write-Ok "Updated: $appName"
                }
                "codex-cli" {
                    if ($codexCliCommand) {
                        try { & $codexCliCommand mcp remove weppy-roblox-mcp *> $null } catch {}
                        try {
                            & $codexCliCommand mcp add weppy-roblox-mcp -- npx -y "@weppy/roblox-mcp@latest"
                        } catch {}
                    }
                    Set-CodexMcpConfig $codexConfig
                    Write-Ok "Updated: $appName"
                }
                "gemini-cli" {
                    Add-McpToConfig $geminiConfig
                    Write-Ok "Updated: $appName"
                }
                "antigravity" {
                    Migrate-LegacyAntigravityEntry $antigravitySharedConfig $antigravityLegacyCliConfig
                    Write-Ok "Updated: $appName"
                }
                "antigravity-cli" {
                    Migrate-LegacyAntigravityEntry $antigravitySharedConfig $antigravityLegacyCliConfig
                    Write-Ok "Updated: $appName"
                }
            }
        }
        catch {
            Write-Fail "Failed: $appName ($_)"
        }
    }
}

# ═══════════════════════════════════
# [3/3] Setup WEPPY AI Agent Plugin
# ═══════════════════════════════════
Write-Step "3/3" "Setup WEPPY AI Agent Plugin"

if ($env:WEPPY_SKIP_AI_AGENT_PLUGIN -eq '1') {
    Write-Warn "WEPPY AI Agent Plugin setup skipped (WEPPY_SKIP_AI_AGENT_PLUGIN=1)"
}
else {
    $aiAgentPluginAny = $false

    if ($claudeCodeCliCommand) {
        $aiAgentPluginAny = $true
        $claudeMarketplaceStderr = Join-Path ([System.IO.Path]::GetTempPath()) ("weppy-claude-plugin-marketplace-{0}.err" -f ([System.Guid]::NewGuid().ToString("N")))
        $claudeMarketplaceExit = Invoke-AiAgentPluginCommand $claudeCodeCliCommand @('plugin', 'marketplace', 'add', 'hope1026/weppy-roblox-mcp', '--scope', 'user') $claudeMarketplaceStderr

        if ($claudeMarketplaceExit -eq 0 -or (Test-AiAgentPluginAlreadyReady $claudeMarketplaceStderr)) {
            Write-Ok "Claude Code marketplace ready"

            $claudePluginStderr = Join-Path ([System.IO.Path]::GetTempPath()) ("weppy-claude-plugin-install-{0}.err" -f ([System.Guid]::NewGuid().ToString("N")))
            $claudePluginExit = Invoke-AiAgentPluginCommand $claudeCodeCliCommand @('plugin', 'install', 'weppy-roblox-ai-toolkit@hope1026-roblox-mcp', '--scope', 'user') $claudePluginStderr

            if ($claudePluginExit -eq 0 -or (Test-AiAgentPluginAlreadyReady $claudePluginStderr)) {
                Write-Ok "WEPPY AI Agent Plugin for Claude Code ready"
            }
            else {
                Write-Warn "WEPPY AI Agent Plugin install for Claude Code skipped or failed (non-blocking)"
                Write-AiAgentPluginStderr $claudePluginStderr
            }
            Remove-Item $claudePluginStderr -ErrorAction SilentlyContinue
        }
        else {
            Write-Warn "Claude Code marketplace setup skipped or failed (non-blocking)"
            Write-AiAgentPluginStderr $claudeMarketplaceStderr
        }
        Remove-Item $claudeMarketplaceStderr -ErrorAction SilentlyContinue
    }
    else {
        Write-Warn "WEPPY AI Agent Plugin for Claude Code skipped (claude CLI not found)"
    }

    if ($codexCliCommand) {
        $aiAgentPluginAny = $true
        $codexMarketplaceStderr = Join-Path ([System.IO.Path]::GetTempPath()) ("weppy-codex-plugin-marketplace-{0}.err" -f ([System.Guid]::NewGuid().ToString("N")))
        $codexMarketplaceExit = Invoke-AiAgentPluginCommand $codexCliCommand @('plugin', 'marketplace', 'add', 'hope1026/weppy-roblox-mcp') $codexMarketplaceStderr

        if ($codexMarketplaceExit -eq 0 -or (Test-AiAgentPluginAlreadyReady $codexMarketplaceStderr)) {
            Write-Ok "Codex marketplace ready"
            Write-Host "    Restart Codex, open Plugin Directory, then install WEPPY AI Agent Plugin."
        }
        else {
            Write-Warn "Codex marketplace setup skipped or failed (non-blocking)"
            Write-AiAgentPluginStderr $codexMarketplaceStderr
        }
        Remove-Item $codexMarketplaceStderr -ErrorAction SilentlyContinue
    }
    else {
        Write-Warn "WEPPY AI Agent Plugin for Codex skipped (codex CLI not found)"
    }

    $antigravitySelected = $detectedTypes -contains 'antigravity'
    $antigravityCliSelected = $detectedTypes -contains 'antigravity-cli'
    $antigravityMode = if ($antigravityCliSelected -and -not $antigravitySelected) { 'native-only' } else { 'hybrid' }
    if ($antigravitySelected -or $antigravityCliSelected) {
        $aiAgentPluginAny = $true
        try {
            Migrate-LegacyAntigravityEntry $antigravitySharedConfig $antigravityLegacyCliConfig
            if (-not $antigravityCliCommand) {
                if (-not (Enable-AntigravityFallback $antigravitySharedConfig 'Antigravity CLI is required to install the WEPPY AI Agent Plugin. Install it from https://antigravity.google/docs/cli-install')) {
                    Abort-Install 'WEPPY AI Agent Plugin for Antigravity and MCP setup failed'
                }
            }
            else {
                $antigravityPluginSource = Get-AntigravityPluginSource
                if (Install-AntigravityCliPlugin $antigravityPluginSource $antigravityCliCommand $antigravitySharedConfig $antigravityMode) {
                    Write-AntigravityResult $script:AntigravityPluginPreState 'WEPPY AI Agent Plugin installed for Windows Antigravity; restart and verify skills and MCP'
                    if ($antigravitySelected) {
                        Add-AntigravityMcpConfig $antigravitySharedConfig
                        Write-AntigravityStatus 'fallback' 'WEPPY AI Agent Plugin discovery in Windows Antigravity IDE is unverified; MCP fallback preserved'
                    }
                }
                else {
                    if (-not (Enable-AntigravityFallback $antigravitySharedConfig 'WEPPY AI Agent Plugin replacement through Antigravity CLI failed; previous AI agent plugin or MCP fallback preserved' $true)) {
                        Abort-Install 'WEPPY AI Agent Plugin for Antigravity and MCP setup failed'
                    }
                }
            }
        }
        catch {
            if (-not (Enable-AntigravityFallback $antigravitySharedConfig "WEPPY AI Agent Plugin source could not be prepared for Antigravity; MCP fallback preserved ($_)")) {
                throw
            }
        }
        finally {
            if ($script:AntigravityPluginSourceTemp) {
                Remove-Item $script:AntigravityPluginSourceTemp -Recurse -Force -ErrorAction SilentlyContinue
                $script:AntigravityPluginSourceTemp = $null
            }
        }
    }

    if (-not $aiAgentPluginAny) {
        Write-Info "WEPPY AI Agent Plugin can be installed later from Claude Code, Codex, or Antigravity"
    }
}

# ═══════════════════════════════════
# Installation summary
# ═══════════════════════════════════
Write-Host ""
Write-Host ("=" * 40)
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "  Next steps:"
Write-Host "  1. Restart Roblox Studio"
Write-Host "  2. Look for the WEPPY button in the Plugins tab"
Write-Host "  3. Click Connect and start building with AI!"
Write-Host ""
Write-Host "  Auto registration: Claude Code, Claude Desktop, Cursor, Codex CLI/App, Gemini CLI, Antigravity / Antigravity IDE, Antigravity CLI"
Write-Host ""
Write-Host "  WEPPY AI Agent Plugin: Claude Code installs automatically; Antigravity installs only when Antigravity CLI is available; Codex installs from Plugin Directory after marketplace add."
Write-Host ""
Write-Host "  Docs: https://weppyai.com/en/install" -ForegroundColor DarkGray
Write-Host ""

Stop-InstallTranscript

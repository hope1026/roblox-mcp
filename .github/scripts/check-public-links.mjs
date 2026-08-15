import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

const installShell = fs.readFileSync(path.resolve(process.cwd(), 'install.sh'), 'utf8');

if (!installShell.includes('Docs: https://weppyai.com/en/install/${NC}')) {
  throw new Error('install.sh must separate the canonical trailing-slash Docs URL from ANSI formatting');
}

console.log('✓ Public installer links verified');

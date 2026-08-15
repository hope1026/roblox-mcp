#!/usr/bin/env bash
#
# WEPPY — One-line install script (macOS/Linux)
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/hope1026/weppy-roblox-mcp/main/install.sh | bash
#
# Interactive 3 steps:
#   [1/3] Setup — install WEPPY Roblox Studio Plugin via npx
#   [2/3] Register MCP with AI apps (user selection)
#   [3/3] Setup WEPPY AI Agent Plugin for Claude Code / Codex / Antigravity (best effort)
#

set -euo pipefail

# ── Color definitions ──
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
DIM='\033[2m'
BOLD='\033[1m'
NC='\033[0m'

INSTALL_LOG_FILE="$(mktemp "${TMPDIR:-/tmp}/weppy-install-XXXXXX.log" 2>/dev/null || true)"
if [ -z "${INSTALL_LOG_FILE:-}" ]; then
  INSTALL_LOG_FILE="${HOME}/weppy-install-error.log"
  : > "$INSTALL_LOG_FILE"
fi

if command -v tee >/dev/null 2>&1; then
  exec > >(tee -a "$INSTALL_LOG_FILE") 2>&1
fi

# ── Utilities ──
# shellcheck disable=SC2059
info()    { printf "${BLUE}[INFO]${NC} %s\n" "$1"; }
# shellcheck disable=SC2059
success() { printf "${GREEN}  ✓${NC} %s\n" "$1"; }
# shellcheck disable=SC2059
warn()    { printf "${YELLOW}  ⚠${NC} %s\n" "$1"; }
# shellcheck disable=SC2059
fail()    { printf "${RED}  ✗${NC} %s\n" "$1"; }
# shellcheck disable=SC2059
step()    { printf "\n${BOLD}${CYAN}[%s]${NC} ${BOLD}%s${NC}\n" "$1" "$2"; }

ANTIGRAVITY_CLI_REQUIRED_MESSAGE='Antigravity CLI is required to install the WEPPY AI Agent Plugin'

report_antigravity_status() {
  local status="$1"
  local message="$2"

  case "$status" in
    installed|updated|reinstalled|repaired) success "$status: $message" ;;
    fallback) warn "$status: $message" ;;
    failed) fail "$status: $message" ;;
    skipped) info "$status: $message" ;;
    *) fail "failed: unknown Antigravity installer status: $status"; return 1 ;;
  esac
}

pause_on_failure_if_interactive() {
  if [ -t 1 ] && [ -r /dev/tty ]; then
    printf "\nPress Enter to exit..." >/dev/tty
    read -r _ </dev/tty || true
  fi
}

handle_install_error() {
  local exit_code=$?
  local line_no="$1"
  local failed_command="$2"

  trap - ERR

  printf "\n${RED}Installation failed.${NC}\n"
  printf "  Command: %s\n" "$failed_command"
  printf "  Line   : %s\n" "$line_no"
  printf "  Log    : %s\n" "$INSTALL_LOG_FILE"

  pause_on_failure_if_interactive
  exit "$exit_code"
}

trap 'handle_install_error "${LINENO}" "$BASH_COMMAND"' ERR

# Y/n prompt (default Y)
confirm() {
  local prompt="$1"
  local reply
  if [ "${CI:-}" = "true" ]; then
    printf "%s (Y/n): Y\n" "$prompt"
    return 0
  fi
  printf "%s (Y/n): " "$prompt"
  read -r reply </dev/tty
  reply="${reply:-Y}"
  case "$reply" in
    [Yy]*) return 0 ;;
    *) return 1 ;;
  esac
}

# Add MCP server to JSON config file (path via env var — prevents shell injection)
add_mcp_to_config() {
  local config_path="$1"
  local parent_dir
  parent_dir=$(dirname "$config_path")
  mkdir -p "$parent_dir"
  MCP_CONFIG_PATH="$config_path" node --input-type=commonjs -e '
const fs = require("fs");
const configPath = process.env.MCP_CONFIG_PATH;
let config = {};
try { config = JSON.parse(fs.readFileSync(configPath, "utf8")); } catch {}
if (!config.mcpServers) config.mcpServers = {};
config.mcpServers["weppy-roblox-mcp"] = { command: "npx", args: ["-y", "@weppy/roblox-mcp@latest"] };
fs.writeFileSync(configPath, JSON.stringify(config, null, 2) + "\n");
'
}

is_json_mcp_configured() {
  local config_path="$1"

  [ -f "$config_path" ] || return 1

  MCP_CONFIG_PATH="$config_path" node --input-type=commonjs -e '
const fs = require("fs");
const configPath = process.env.MCP_CONFIG_PATH;
try {
  const config = JSON.parse(fs.readFileSync(configPath, "utf8"));
  process.exit(config?.mcpServers?.["weppy-roblox-mcp"] ? 0 : 1);
} catch {
  process.exit(1);
}
' >/dev/null 2>&1
}

# Antigravity 설정에 canonical mcpServers 래퍼로 MCP 서버를 추가하고 legacy flat key를 정리
add_antigravity_mcp_config() {
  local config_path="$1"
  local parent_dir
  parent_dir=$(dirname "$config_path")
  mkdir -p "$parent_dir"
  MCP_CONFIG_PATH="$config_path" node --input-type=commonjs -e '
const fs = require("fs");
const path = require("path");
const configPath = process.env.MCP_CONFIG_PATH;
let config = {};
const exists = fs.existsSync(configPath);
if (exists) {
  config = JSON.parse(fs.readFileSync(configPath, "utf8"));
}
if (!config || typeof config !== "object" || Array.isArray(config)) {
  throw new Error("Antigravity config must be an object");
}
const mcpServers = config.mcpServers;
if (mcpServers !== undefined && (typeof mcpServers !== "object" || mcpServers === null || Array.isArray(mcpServers))) {
  throw new Error("Antigravity mcpServers must be an object");
}
const next = { ...config };
delete next["weppy-roblox-mcp"];
next.mcpServers = {
  ...(mcpServers || {}),
  "weppy-roblox-mcp": { command: "npx", args: ["-y", "@weppy/roblox-mcp@latest"] }
};
const tempPath = `${configPath}.weppy-tmp-${process.pid}`;
if (exists) {
  fs.copyFileSync(configPath, `${configPath}.weppy-backup-${Date.now()}`);
}
fs.mkdirSync(path.dirname(configPath), { recursive: true });
fs.writeFileSync(tempPath, JSON.stringify(next, null, 2) + "\n");
fs.renameSync(tempPath, configPath);
'
}

is_antigravity_mcp_configured() {
  local config_path="$1"

  [ -f "$config_path" ] || return 1

  MCP_CONFIG_PATH="$config_path" node --input-type=commonjs -e '
const fs = require("fs");
const configPath = process.env.MCP_CONFIG_PATH;
function isJsonObject(value) {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}
function hasExpectedCommandShape(value) {
  // Require an explicit `@<tag>` so the installer can upgrade legacy bare
  // entries (`@weppy/roblox-mcp`) — those reuse npx cache and trap users on
  // outdated versions. Tagged entries (`@latest`, `@2.6.4`, …) are preserved.
  return (
    isJsonObject(value) &&
    value.command === "npx" &&
    Array.isArray(value.args) &&
    value.args.length === 2 &&
    value.args[0] === "-y" &&
    typeof value.args[1] === "string" &&
    /^@weppy\/roblox-mcp@.+$/.test(value.args[1])
  );
}
try {
  const config = JSON.parse(fs.readFileSync(configPath, "utf8"));
  const canonical = config?.mcpServers?.["weppy-roblox-mcp"];
  const hasLegacyFlatKey = Object.prototype.hasOwnProperty.call(config, "weppy-roblox-mcp");
  process.exit(hasExpectedCommandShape(canonical) && !hasLegacyFlatKey ? 0 : 1);
} catch {
  process.exit(1);
}
' >/dev/null 2>&1
}

is_antigravity_mcp_registration_complete() {
  local config_path
  local found_existing=0

  for config_path in "${ANTIGRAVITY_CONFIG_CANDIDATES[@]}"; do
    if [ -f "$config_path" ]; then
      found_existing=1
      is_antigravity_mcp_configured "$config_path" || return 1
    fi
  done

  [ "$found_existing" -eq 1 ]
}

has_any_antigravity_config_candidate() {
  local candidate_path

  for candidate_path in "${ANTIGRAVITY_CONFIG_CANDIDATES[@]}"; do
    [ -f "$candidate_path" ] && return 0
  done

  for candidate_path in "${ANTIGRAVITY_DIR_CANDIDATES[@]}"; do
    [ -d "$candidate_path" ] && return 0
  done

  return 1
}

has_antigravity_ide_surface() {
  local candidate_path

  if [ "${WEPPY_ANTIGRAVITY_IDE_PRESENT:-}" = "1" ]; then
    return 0
  fi
  if [ "${WEPPY_ANTIGRAVITY_IDE_PRESENT:-}" = "0" ]; then
    return 1
  fi

  if [ -d "/Applications/Antigravity.app" ] || [ -d "$HOME/Applications/Antigravity.app" ]; then
    return 0
  fi

  for candidate_path in \
    "$HOME/.gemini/antigravity-ide/mcp_config.json" \
    "$HOME/.gemini/antigravity/mcp_config.json" \
    "$HOME/.gemini/antigravity-ide" \
    "$HOME/.gemini/antigravity"; do
    [ -e "$candidate_path" ] && return 0
  done

  if [ -z "${ANTIGRAVITY_CLI_COMMAND:-}" ] \
    && { [ -f "$HOME/.gemini/config/mcp_config.json" ] || [ -d "$HOME/.gemini/config" ]; }; then
    return 0
  fi

  return 1
}

add_antigravity_mcp_configs() {
  migrate_legacy_antigravity_entry "$ANTIGRAVITY_SHARED_CONFIG" "$ANTIGRAVITY_LEGACY_CLI_CONFIG"
}

is_codex_config_configured() {
  local config_path="$1"

  [ -f "$config_path" ] || return 1
  MCP_CODEX_CONFIG_PATH="$config_path" node --input-type=commonjs <<'NODE' >/dev/null 2>&1
const fs = require("fs");

const configPath = process.env.MCP_CODEX_CONFIG_PATH;
const serverName = "weppy-roblox-mcp";
const expectedCommand = "npx";
// Require an explicit `@<tag>` so the installer can upgrade legacy bare entries.
const packageSpecPattern = /^@weppy\/roblox-mcp@.+$/;
const headerPattern = new RegExp(
  "^\\s*\\[\\s*mcp_servers\\." + serverName.replace(/[.*+?^${}()|[\]\\]/g, "\\$&") + "\\s*\\]\\s*(?:#.*)?$",
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
    } else if (char === "#" && !inSingle && !inDouble) {
      return line.slice(0, index).trimEnd();
    }

    escaped = char === "\\" && !escaped;
    if (char !== "\\") {
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
    const char = line[index] ?? "";
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
    } else if (char === "#" && !inSingle && !inDouble) {
      break;
    }

    escaped = char === "\\" && !escaped;
    if (char !== "\\") {
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
  const lines = source.split("\n");
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
        blocks.push(activeLines.join("\n").trim());
      }
      activeLines = [line];
    } else if (activeLines !== null && isHeaderCandidate) {
      blocks.push(activeLines.join("\n").trim());
      activeLines = null;
    } else if (activeLines !== null) {
      activeLines.push(line);
    }

    state = advanceTripleQuoteState(line, state);
  }

  if (activeLines !== null) {
    blocks.push(activeLines.join("\n").trim());
  }

  return blocks;
}

function parseStringAssignment(value, key) {
  const match = new RegExp("^\\s*" + key + "\\s*=\\s*([\"'])([^\"']+)\\1\\s*$").exec(value);
  return match ? match[2] : null;
}

function parseTomlStringArray(value) {
  const match = /^\s*args\s*=\s*\[(.*)\]\s*$/ms.exec(value.trim());

  if (match === null) {
    return null;
  }

  const body = match[1] ?? "";
  const values = [];
  let cursor = 0;
  let expectValue = true;

  while (cursor < body.length) {
    while (cursor < body.length && /\s/.test(body[cursor] ?? "")) {
      cursor += 1;
    }

    if (cursor >= body.length) {
      break;
    }

    if (!expectValue) {
      if (body[cursor] !== ",") {
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
    let token = "";
    let escaped = false;

    while (cursor < body.length) {
      const char = body[cursor] ?? "";

      if (char === quote && !escaped) {
        cursor += 1;
        values.push(token);
        break;
      }

      token += char;
      escaped = char === "\\" && !escaped;
      if (char !== "\\") {
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
  if (leftover === ",") {
    return values;
  }

  return leftover.length === 0 ? values : null;
}

function collectArrayLines(lines, startIndex) {
  const collected = [stripCommentOutsideStrings(lines[startIndex] ?? "")];
  let bracketDepth = 0;
  let inSingle = false;
  let inDouble = false;
  let escaped = false;

  for (let lineIndex = startIndex; lineIndex < lines.length; lineIndex += 1) {
    const sanitized = stripCommentOutsideStrings(lines[lineIndex] ?? "");
    if (lineIndex !== startIndex) {
      collected.push(sanitized);
    }

    for (let index = 0; index < sanitized.length; index += 1) {
      const char = sanitized[index] ?? "";

      if (char === '"' && !inSingle && !escaped) {
        inDouble = !inDouble;
      } else if (char === "'" && !inDouble && !escaped) {
        inSingle = !inSingle;
      } else if (!inSingle && !inDouble) {
        if (char === "[") {
          bracketDepth += 1;
        } else if (char === "]") {
          bracketDepth -= 1;
        }
      }

      escaped = char === "\\" && !escaped;
      if (char !== "\\") {
        escaped = false;
      }
    }

    if (bracketDepth <= 0) {
      return {
        nextIndex: lineIndex,
        text: collected.join("\n"),
      };
    }
  }

  return null;
}

function parseCodexBlock(blockContent) {
  const lines = blockContent.split("\n");
  let command = null;
  let args = null;
  let hasConflict = false;
  let inTripleDouble = false;
  let inTripleSingle = false;

  for (let index = 1; index < lines.length; index += 1) {
    const line = lines[index] ?? "";
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
      const parsedCommand = parseStringAssignment(trimmed, "command");
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

  for (const line of source.split("\n")) {
    tripleState = advanceTripleQuoteState(line, tripleState);

    for (let index = 0; index < line.length; index += 1) {
      const char = line[index] ?? "";

      if (!inSingle && !inDouble && char === "#") {
        break;
      }

      if (char === '"' && !inSingle && !escaped) {
        inDouble = !inDouble;
      } else if (char === "'" && !inDouble && !escaped) {
        inSingle = !inSingle;
      } else if (!inSingle && !inDouble) {
        if (char === "[") {
          bracketDepth += 1;
        } else if (char === "]") {
          bracketDepth -= 1;
          if (bracketDepth < 0) {
            return false;
          }
        } else if (char === "{") {
          braceDepth += 1;
        } else if (char === "}") {
          braceDepth -= 1;
          if (braceDepth < 0) {
            return false;
          }
        }
      }

      escaped = char === "\\" && !escaped;
      if (char !== "\\") {
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
  const source = fs.readFileSync(configPath, "utf8");
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
    parsed.args[0] === "-y" &&
    typeof parsed.args[1] === "string" &&
    packageSpecPattern.test(parsed.args[1]);

  process.exit(isConfigured ? 0 : 1);
} catch {
  process.exit(1);
}
NODE
}

set_codex_mcp_config() {
  local config_path="$1"
  local parent_dir
  parent_dir=$(dirname "$config_path")
  mkdir -p "$parent_dir"
  MCP_CODEX_CONFIG_PATH="$config_path" node --input-type=commonjs <<'NODE'
const fs = require("fs");
const path = require("path");

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
    } else if (char === "#" && !inSingle && !inDouble) {
      return line.slice(0, index).trimEnd();
    }

    escaped = char === "\\" && !escaped;
    if (char !== "\\") {
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
    const char = line[index] ?? "";
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
    } else if (char === "#" && !inSingle && !inDouble) {
      break;
    }

    escaped = char === "\\" && !escaped;
    if (char !== "\\") {
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

  for (const line of source.split("\n")) {
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

  return kept.join("\n").trimEnd();
}

let source = "";
try { source = fs.readFileSync(configPath, "utf8"); } catch {}

const withoutCodex = removeCodexBlocks(source);
const canonicalBlock = [
  "[mcp_servers.weppy-roblox-mcp]",
  "command = \"npx\"",
  "args = [\"-y\", \"@weppy/roblox-mcp@latest\"]",
].join("\n");
const separator = withoutCodex.trim().length > 0 ? "\n\n" : "";

fs.mkdirSync(path.dirname(configPath), { recursive: true });
fs.writeFileSync(configPath, `${withoutCodex}${separator}${canonicalBlock}\n`);
NODE
}

resolve_optional_cli_command() {
  local command_name="$1"
  local npm_prefix=""

  if command -v "$command_name" >/dev/null 2>&1; then
    command -v "$command_name"
    return 0
  fi

  npm_prefix=$(npm prefix -g 2>/dev/null || true)
  if [ -n "$npm_prefix" ] && [ -x "$npm_prefix/bin/$command_name" ]; then
    printf "%s\n" "$npm_prefix/bin/$command_name"
    return 0
  fi

  return 1
}

is_already_ai_agent_plugin_result() {
  local stderr_file="$1"
  [ -f "$stderr_file" ] || return 1
  grep -Eqi "already|exists|installed|duplicate" "$stderr_file"
}

ANTIGRAVITY_PLUGIN_SOURCE_PATH=""
ANTIGRAVITY_PLUGIN_SOURCE_TEMP=""
ANTIGRAVITY_PLUGIN_RELEASE_TAG=""
ANTIGRAVITY_NATIVE_VIEW_PATH=""
ANTIGRAVITY_IDE_VIEW_PATH=""
ANTIGRAVITY_PLUGIN_PRE_STATE="absent"

prepare_antigravity_plugin_source() {
  local tmp archive marker release_json release_tag

  if [ -n "${WEPPY_ANTIGRAVITY_PLUGIN_SOURCE:-}" ]; then
    [ -f "$WEPPY_ANTIGRAVITY_PLUGIN_SOURCE/plugin.json" ] || return 1
    [ -f "$WEPPY_ANTIGRAVITY_PLUGIN_SOURCE/mcp_config.json" ] || return 1
    [ -f "$WEPPY_ANTIGRAVITY_PLUGIN_SOURCE/skills/weppy-roblox-mcp-guide/SKILL.md" ] || return 1
    [ -f "$WEPPY_ANTIGRAVITY_PLUGIN_SOURCE/skills/weppy-roblox-sync-guide/SKILL.md" ] || return 1
    [ -f "$WEPPY_ANTIGRAVITY_PLUGIN_SOURCE/skills/weppy-roblox-assets-guide/SKILL.md" ] || return 1
    ANTIGRAVITY_PLUGIN_SOURCE_PATH="$WEPPY_ANTIGRAVITY_PLUGIN_SOURCE"
    return 0
  fi

  tmp=$(mktemp -d "${TMPDIR:-/tmp}/weppy-antigravity-plugin-XXXXXX") || return 1
  archive="$tmp/repo.tar.gz"
  release_json=$(curl -fsSL "https://api.github.com/repos/hope1026/weppy-roblox-mcp/releases/latest") || {
    rm -rf "$tmp"
    return 1
  }
  release_tag=$(printf '%s' "$release_json" | node -e "let source='';process.stdin.on('data',chunk=>source+=chunk).on('end',()=>{const tag=JSON.parse(source).tag_name;if(!tag)process.exit(1);process.stdout.write(tag)})") || {
    rm -rf "$tmp"
    return 1
  }
  curl -fsSL "https://codeload.github.com/hope1026/weppy-roblox-mcp/tar.gz/refs/tags/$release_tag" -o "$archive" || {
    rm -rf "$tmp"
    return 1
  }
  tar -xzf "$archive" -C "$tmp" || {
    rm -rf "$tmp"
    return 1
  }
  marker=$(find "$tmp" -path '*/plugins/weppy-roblox-mcp/plugin.json' -print -quit)
  [ -n "$marker" ] || {
    rm -rf "$tmp"
    return 1
  }
  ANTIGRAVITY_PLUGIN_SOURCE_PATH=$(dirname "$marker")
  ANTIGRAVITY_PLUGIN_SOURCE_TEMP="$tmp"
  ANTIGRAVITY_PLUGIN_RELEASE_TAG="$release_tag"
}

antigravity_view_healthy() {
  local root="$1"
  local skill

  [ -f "$root/plugin.json" ] || return 1
  for skill in weppy-roblox-mcp-guide weppy-roblox-sync-guide weppy-roblox-assets-guide; do
    [ -f "$root/skills/$skill/SKILL.md" ] || return 1
  done
}

antigravity_tree_digest() {
  local root="$1"

  ANTIGRAVITY_DIGEST_ROOT="$root" node --input-type=commonjs <<'NODE'
const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

const root = process.env.ANTIGRAVITY_DIGEST_ROOT;
const files = [];

function visit(relativeDir) {
  const absoluteDir = path.join(root, relativeDir);
  for (const entry of fs.readdirSync(absoluteDir, { withFileTypes: true })) {
    const relativePath = path.join(relativeDir, entry.name);
    if (entry.isDirectory()) visit(relativePath);
    if (entry.isFile()) files.push(relativePath.split(path.sep).join('/'));
  }
}

visit('');
const digest = crypto.createHash('sha256');
for (const relativePath of files.sort()) {
  digest.update(relativePath);
  digest.update('\0');
  digest.update(fs.readFileSync(path.join(root, relativePath)));
  digest.update('\0');
}
process.stdout.write(digest.digest('hex'));
NODE
}

classify_antigravity_pre_state() {
  local staged_cli="$1"
  local cli_target="$2"
  local staged_ide="$3"
  local ide_target="$4"
  local require_ide="$5"
  local seen=false missing=false damaged=false outdated=false

  if [ -e "$cli_target" ]; then
    seen=true
    if ! antigravity_view_healthy "$cli_target"; then
      damaged=true
    elif [ "$(antigravity_tree_digest "$cli_target")" != "$(antigravity_tree_digest "$staged_cli")" ]; then
      outdated=true
    fi
  else
    missing=true
  fi

  if [ "$require_ide" = true ]; then
    if [ -e "$ide_target" ]; then
      seen=true
      if ! antigravity_view_healthy "$ide_target"; then
        damaged=true
      elif [ "$(antigravity_tree_digest "$ide_target")" != "$(antigravity_tree_digest "$staged_ide")" ]; then
        outdated=true
      fi
    else
      missing=true
    fi
  fi

  if [ "$damaged" = true ] || { [ "$seen" = true ] && [ "$missing" = true ]; }; then
    printf 'damaged'
  elif [ "$seen" = false ]; then
    printf 'absent'
  elif [ "$outdated" = true ]; then
    printf 'outdated'
  else
    printf 'current'
  fi
}

stage_antigravity_native_view() {
  local source="$1" native_view
  native_view=$(mktemp -d "${TMPDIR:-/tmp}/weppy-antigravity-native-XXXXXX") || return 1
  cp -R "$source/." "$native_view/" || {
    rm -rf "$native_view"
    return 1
  }
  # agy 1.0.0은 이 manifest가 있으면 Claude import로 오분류한다.
  rm -rf "$native_view/.claude-plugin"
  [ -f "$native_view/plugin.json" ] && [ -f "$native_view/mcp_config.json" ] || {
    rm -rf "$native_view"
    return 1
  }
  ANTIGRAVITY_NATIVE_VIEW_PATH="$native_view"
}

stage_antigravity_skill_only_view() {
  stage_antigravity_native_view "$1" || return 1
  rm -f "$ANTIGRAVITY_NATIVE_VIEW_PATH/mcp_config.json"
}

stage_antigravity_ide_view() {
  local source="$1"
  local staged

  staged=$(mktemp -d "${TMPDIR:-/tmp}/weppy-antigravity-ide-XXXXXX") || return 1
  cp -R "$source/." "$staged/" || {
    rm -rf "$staged"
    return 1
  }
  rm -rf "$staged/.claude-plugin" "$staged/.codex-plugin"
  rm -f "$staged/.mcp.json" "$staged/mcp_config.json"
  antigravity_view_healthy "$staged" || {
    rm -rf "$staged"
    return 1
  }
  ANTIGRAVITY_IDE_VIEW_PATH="$staged"
}

ensure_weppy_antigravity_mcp_entry() {
  local config_path="$1"
  add_antigravity_mcp_config "$config_path"
}

remove_weppy_antigravity_mcp_entry() {
  local config_path="$1"
  [ -f "$config_path" ] || return 0

  MCP_CONFIG_PATH="$config_path" node --input-type=commonjs <<'NODE'
const fs = require('fs');
const path = require('path');
const configPath = process.env.MCP_CONFIG_PATH;
const source = fs.readFileSync(configPath, 'utf8');
const config = JSON.parse(source);

if (!config || typeof config !== 'object' || Array.isArray(config)) {
  throw new Error('Antigravity config must be an object');
}

const hasCanonical = Boolean(config.mcpServers?.['weppy-roblox-mcp']);
const hasLegacy = Object.prototype.hasOwnProperty.call(config, 'weppy-roblox-mcp');
if (!hasCanonical && !hasLegacy) process.exit(0);
if (config.mcpServers !== undefined && (typeof config.mcpServers !== 'object' || config.mcpServers === null || Array.isArray(config.mcpServers))) {
  throw new Error('Antigravity mcpServers must be an object');
}

const backupPath = `${configPath}.weppy-backup-${Date.now()}`;
const tempPath = `${configPath}.weppy-tmp-${process.pid}`;
fs.copyFileSync(configPath, backupPath);
const next = { ...config, mcpServers: { ...(config.mcpServers || {}) } };
delete next['weppy-roblox-mcp'];
delete next.mcpServers['weppy-roblox-mcp'];
fs.mkdirSync(path.dirname(configPath), { recursive: true });
fs.writeFileSync(tempPath, `${JSON.stringify(next, null, 2)}\n`);
fs.renameSync(tempPath, configPath);
NODE
}

migrate_legacy_antigravity_entry() {
  local shared_config="$1"
  local legacy_config="$2"

  ANTIGRAVITY_SHARED_CONFIG_PATH="$shared_config" \
  ANTIGRAVITY_LEGACY_CONFIG_PATH="$legacy_config" \
  node --input-type=commonjs <<'NODE'
const fs = require('fs');
const path = require('path');

const sharedPath = process.env.ANTIGRAVITY_SHARED_CONFIG_PATH;
const legacyPath = process.env.ANTIGRAVITY_LEGACY_CONFIG_PATH;
const canonicalEntry = { command: 'npx', args: ['-y', '@weppy/roblox-mcp@latest'] };

function readConfig(configPath) {
  if (!fs.existsSync(configPath)) return { config: {}, exists: false };
  const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
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
  const parts = [
    date.getFullYear(),
    String(date.getMonth() + 1).padStart(2, '0'),
    String(date.getDate()).padStart(2, '0'),
    String(date.getHours()).padStart(2, '0'),
    String(date.getMinutes()).padStart(2, '0'),
    String(date.getSeconds()).padStart(2, '0'),
  ];
  return parts.join('');
}

function writeConfig(configPath, next, exists) {
  const tempPath = `${configPath}.weppy-tmp-${process.pid}`;
  if (exists) fs.copyFileSync(configPath, `${configPath}.weppy-backup-${timestamp()}`);
  fs.mkdirSync(path.dirname(configPath), { recursive: true });
  fs.writeFileSync(tempPath, `${JSON.stringify(next, null, 2)}\n`);
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
NODE
}

install_antigravity_cli_plugin() {
  local mode="${1:-native-only}"
  local cli_target="$HOME/.gemini/antigravity-cli/plugins/weppy-roblox-ai-toolkit"
  local cli_backup=""

  [ -n "${ANTIGRAVITY_CLI_COMMAND:-}" ] || return 1
  [ -n "$ANTIGRAVITY_NATIVE_VIEW_PATH" ] || return 1

  if [ -e "$cli_target" ]; then
    cli_backup="${cli_target}.weppy-backup-$(date +%Y%m%d%H%M%S)"
    mv "$cli_target" "$cli_backup" || return 1
  fi

  "$ANTIGRAVITY_CLI_COMMAND" plugin uninstall weppy-roblox-ai-toolkit >/dev/null 2>&1 || true
  if ! "$ANTIGRAVITY_CLI_COMMAND" plugin install "$ANTIGRAVITY_NATIVE_VIEW_PATH" >/dev/null 2>&1 \
    || ! "$ANTIGRAVITY_CLI_COMMAND" plugin list 2>/dev/null | grep -q 'weppy-roblox-ai-toolkit'; then
    "$ANTIGRAVITY_CLI_COMMAND" plugin uninstall weppy-roblox-ai-toolkit >/dev/null 2>&1 || true
    rm -rf "$cli_target"
    [ -n "$cli_backup" ] && mv "$cli_backup" "$cli_target"
    return 1
  fi

  if [ "$mode" = "native-only" ]; then
    remove_weppy_antigravity_mcp_entry "$ANTIGRAVITY_SHARED_CONFIG" || {
      "$ANTIGRAVITY_CLI_COMMAND" plugin uninstall weppy-roblox-ai-toolkit >/dev/null 2>&1 || true
      rm -rf "$cli_target"
      [ -n "$cli_backup" ] && mv "$cli_backup" "$cli_target"
      return 1
    }
  else
    ensure_weppy_antigravity_mcp_entry "$ANTIGRAVITY_SHARED_CONFIG" || {
      "$ANTIGRAVITY_CLI_COMMAND" plugin uninstall weppy-roblox-ai-toolkit >/dev/null 2>&1 || true
      rm -rf "$cli_target"
      [ -n "$cli_backup" ] && mv "$cli_backup" "$cli_target"
      return 1
    }
  fi

  [ -n "$cli_backup" ] && rm -rf "$cli_backup"
  rm -rf "$ANTIGRAVITY_NATIVE_VIEW_PATH"
  ANTIGRAVITY_NATIVE_VIEW_PATH=""
  return 0
}

publish_antigravity_ide_plugin() {
  local target="$HOME/.gemini/config/plugins/weppy-roblox-ai-toolkit"
  local staged="$ANTIGRAVITY_IDE_VIEW_PATH"
  local backup=""

  [ -n "$staged" ] || return 1
  antigravity_view_healthy "$staged" || return 1

  mkdir -p "$(dirname "$target")" || return 1
  if [ -e "$target" ]; then
    backup="${target}.weppy-backup-$(date +%Y%m%d%H%M%S)"
    mv "$target" "$backup" || return 1
  fi
  if ! mv "$staged" "$target"; then
    [ -n "$backup" ] && mv "$backup" "$target" || true
    return 1
  fi
  [ -n "$backup" ] && rm -rf "$backup"
  ANTIGRAVITY_IDE_VIEW_PATH=""
  return 0
}

report_antigravity_result() {
  local pre_state="$1"
  local message="${2:-WEPPY AI Agent Plugin for Antigravity}"

  case "$pre_state" in
    absent) report_antigravity_status installed "$message" ;;
    current) report_antigravity_status reinstalled "$message" ;;
    outdated) report_antigravity_status updated "$message" ;;
    damaged) report_antigravity_status repaired "$message" ;;
    *) report_antigravity_status failed "unknown Antigravity pre-state: $pre_state"; return 1 ;;
  esac
}

activate_antigravity_fallback() {
  local message="$1"
  local prefer_restored_plugin="${2:-false}"
  local cli_target="$HOME/.gemini/antigravity-cli/plugins/weppy-roblox-ai-toolkit"

  if [ "$prefer_restored_plugin" = true ]; then
    if antigravity_view_healthy "$cli_target"; then
      if [ -f "$cli_target/mcp_config.json" ]; then
        if remove_weppy_antigravity_mcp_entry "$ANTIGRAVITY_SHARED_CONFIG"; then
          report_antigravity_status fallback "$message"
          return 0
        fi
      fi
    fi
  fi

  if ensure_weppy_antigravity_mcp_entry "$ANTIGRAVITY_SHARED_CONFIG"; then
    report_antigravity_status fallback "$message"
    return 0
  fi

  report_antigravity_status failed "WEPPY AI Agent Plugin for Antigravity and the shared MCP fallback are unavailable"
  return 1
}

# ── Header ──
# shellcheck disable=SC2059
printf "\n${BOLD}WEPPY Installer${NC}\n"
# shellcheck disable=SC2059
printf "${DIM}AI-powered Roblox Studio integration${NC}\n"
printf "%s\n" "════════════════════════════════════"

# ── Node.js check ──
if ! command -v node &>/dev/null; then
  fail "Node.js is not installed"
  printf "  Install Node.js 18+: https://nodejs.org\n"
  exit 1
fi

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
  fail "Node.js 18 or higher required (current: $(node -v))"
  printf "  Upgrade: https://nodejs.org\n"
  exit 1
fi
success "Node.js $(node -v) detected"

# ═══════════════════════════════════
# [1/3] Setup — Roblox Studio Plugin
# ═══════════════════════════════════
step "1/3" "Setup WEPPY Roblox Studio Plugin"

if confirm "  Run npx -y @weppy/roblox-mcp@latest --setup?"; then
  setup_tmp_dir=""
  if setup_tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/weppy-setup-XXXXXX" 2>/dev/null); then
    :
  elif setup_tmp_dir=$(mktemp -d 2>/dev/null); then
    :
  fi

  if [ -n "${setup_tmp_dir:-}" ] && [ -d "$setup_tmp_dir" ]; then
    # stdin을 /dev/null로 격리: curl|bash 파이프 모드에서 stdio MCP 서버가
    # bash의 남은 스크립트 바이트를 소비해버리는 문제를 방지한다
    # The @latest tag forces npx to resolve from the registry instead of
    # reusing an older version pinned in the npm cache.
    if (cd "$setup_tmp_dir" && npx -y "@weppy/roblox-mcp@latest" --setup </dev/null); then
      success "Setup complete"
    else
      warn "Setup encountered a warning (non-blocking)"
    fi

    rm -rf "$setup_tmp_dir"
  else
    warn "Setup encountered a warning (failed to create temp working directory)"
  fi
else
  warn "Setup skipped"
fi

# ═══════════════════════════════════
# [2/3] Register MCP with AI apps
# ═══════════════════════════════════
step "2/3" "Register MCP with AI apps"
printf "  Automatic registration: Claude Code, Claude Desktop, Cursor, Codex CLI/App, Gemini CLI, Antigravity / Antigravity IDE, Antigravity CLI\n"

MCP_COMMAND='npx -y @weppy/roblox-mcp@latest'
ANTIGRAVITY_SHARED_CONFIG="$HOME/.gemini/config/mcp_config.json"
ANTIGRAVITY_LEGACY_CLI_CONFIG="$HOME/.gemini/antigravity-cli/mcp_config.json"
ANTIGRAVITY_CLI_COMMAND="$(resolve_optional_cli_command agy 2>/dev/null || true)"
ANTIGRAVITY_CONFIG_CANDIDATES=(
  "$HOME/.gemini/config/mcp_config.json"
  "$HOME/.gemini/antigravity-ide/mcp_config.json"
  "$HOME/.gemini/antigravity/mcp_config.json"
)
ANTIGRAVITY_DIR_CANDIDATES=(
  "$HOME/.gemini/config"
  "$HOME/.gemini/antigravity-ide"
  "$HOME/.gemini/antigravity"
)

# AI app detection
declare -a DETECTED_NAMES=()
declare -a DETECTED_TYPES=()
declare -a NOT_DETECTED=()

# Claude Code
# `claude mcp add` stores entries under ~/.claude.json or in local/user scope,
# so prefer `claude mcp list` as the source of truth when the CLI is available
# (the JSON path checks remain as a fallback).
CLAUDE_PROJECT_MCP_CONFIG="$PWD/.mcp.json"
CLAUDE_GLOBAL_MCP_CONFIG="$HOME/.claude/mcp.json"
CLAUDE_CLI_COMMAND="$(resolve_optional_cli_command claude 2>/dev/null || true)"

is_claude_cli_configured() {
  [ -n "$CLAUDE_CLI_COMMAND" ] || return 1
  # The entry counts as configured only when its args carry an explicit `@tag`
  # (e.g. `@latest`). Legacy bare entries fall through and get re-registered.
  "$CLAUDE_CLI_COMMAND" mcp list 2>/dev/null \
    | grep "^weppy-roblox-mcp:" \
    | grep -q "@weppy/roblox-mcp@"
}

if is_claude_cli_configured \
   || is_json_mcp_configured "$CLAUDE_PROJECT_MCP_CONFIG" \
   || is_json_mcp_configured "$CLAUDE_GLOBAL_MCP_CONFIG"; then
  DETECTED_NAMES+=("Claude Code (configured)")
  DETECTED_TYPES+=("claude-code")
elif [ -n "$CLAUDE_CLI_COMMAND" ]; then
  DETECTED_NAMES+=("Claude Code (CLI)")
  DETECTED_TYPES+=("claude-code")
else
  NOT_DETECTED+=("Claude Code (not found)")
fi

# Claude Desktop (macOS)
CLAUDE_DESKTOP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
if [ -f "$CLAUDE_DESKTOP_CONFIG" ]; then
  DETECTED_NAMES+=("Claude Desktop")
  DETECTED_TYPES+=("claude-desktop")
elif [ "$(uname)" = "Darwin" ]; then
  NOT_DETECTED+=("Claude Desktop (config not found)")
fi

# Cursor (detect only when mcp.json or binary exists)
CURSOR_MCP_CONFIG="$HOME/.cursor/mcp.json"
if [ -f "$CURSOR_MCP_CONFIG" ] || command -v cursor &>/dev/null; then
  DETECTED_NAMES+=("Cursor")
  DETECTED_TYPES+=("cursor")
else
  NOT_DETECTED+=("Cursor (not found)")
fi

# Codex CLI / Codex App (share the same ~/.codex/config.toml)
CODEX_CONFIG="$HOME/.codex/config.toml"
CODEX_CLI_COMMAND="$(resolve_optional_cli_command codex 2>/dev/null || true)"
if is_codex_config_configured "$CODEX_CONFIG"; then
  DETECTED_NAMES+=("Codex CLI/App (configured)")
  DETECTED_TYPES+=("codex-cli")
elif [ -n "$CODEX_CLI_COMMAND" ]; then
  DETECTED_NAMES+=("Codex CLI/App")
  DETECTED_TYPES+=("codex-cli")
elif [ -f "$CODEX_CONFIG" ]; then
  DETECTED_NAMES+=("Codex CLI/App (config)")
  DETECTED_TYPES+=("codex-cli")
else
  NOT_DETECTED+=("Codex CLI/App (not found)")
fi

# Gemini CLI
GEMINI_CONFIG="$HOME/.gemini/settings.json"
GEMINI_CLI_COMMAND="$(resolve_optional_cli_command gemini 2>/dev/null || true)"
if is_json_mcp_configured "$GEMINI_CONFIG"; then
  DETECTED_NAMES+=("Gemini CLI (configured)")
  DETECTED_TYPES+=("gemini-cli")
elif [ -n "$GEMINI_CLI_COMMAND" ]; then
  DETECTED_NAMES+=("Gemini CLI")
  DETECTED_TYPES+=("gemini-cli")
else
  NOT_DETECTED+=("Gemini CLI (not found)")
fi

# Antigravity / Antigravity IDE
if has_antigravity_ide_surface; then
  if is_antigravity_mcp_registration_complete; then
    DETECTED_NAMES+=("Antigravity / Antigravity IDE (configured)")
  else
    DETECTED_NAMES+=("Antigravity / Antigravity IDE")
  fi
  DETECTED_TYPES+=("antigravity")
else
  NOT_DETECTED+=("Antigravity / Antigravity IDE (not found)")
fi

# Antigravity CLI
if is_antigravity_mcp_configured "$ANTIGRAVITY_LEGACY_CLI_CONFIG"; then
  DETECTED_NAMES+=("Antigravity CLI (configured)")
  DETECTED_TYPES+=("antigravity-cli")
elif [ -f "$ANTIGRAVITY_LEGACY_CLI_CONFIG" ] || [ -d "$HOME/.gemini/antigravity-cli" ]; then
  DETECTED_NAMES+=("Antigravity CLI")
  DETECTED_TYPES+=("antigravity-cli")
elif [ -n "$ANTIGRAVITY_CLI_COMMAND" ]; then
  DETECTED_NAMES+=("Antigravity CLI")
  DETECTED_TYPES+=("antigravity-cli")
else
  NOT_DETECTED+=("Antigravity CLI (not found)")
fi

if [ ${#DETECTED_NAMES[@]} -eq 0 ]; then
  warn "No AI apps detected"
  info "Register MCP server manually: $MCP_COMMAND"
else
  # shellcheck disable=SC2059
  printf "\n  ${BOLD}Detected:${NC}\n"
  for i in "${!DETECTED_NAMES[@]}"; do
    # shellcheck disable=SC2059
    printf "    ${GREEN}%d.${NC} %s\n" "$((i + 1))" "${DETECTED_NAMES[$i]}"
  done

  if [ ${#NOT_DETECTED[@]} -gt 0 ]; then
    # shellcheck disable=SC2059
    printf "\n  ${DIM}Not detected:${NC}\n"
    for item in "${NOT_DETECTED[@]}"; do
      # shellcheck disable=SC2059
      printf "    ${DIM}- %s${NC}\n" "$item"
    done
  fi

  # shellcheck disable=SC2059
  printf "\n  Select apps to register ${DIM}(comma-separated, 'a' for all, 'n' to skip)${NC}\n"
  printf "  → "
  if [ "${CI:-}" = "true" ]; then
    selection="a"
    printf "a\n"
  else
    read -r selection </dev/tty
  fi
  selection="${selection:-n}"

  # Parse selection
  declare -a SELECTED_INDICES=()
  case "$selection" in
    [Nn])
      warn "MCP registration skipped"
      ;;
    [Aa])
      for i in "${!DETECTED_NAMES[@]}"; do
        SELECTED_INDICES+=("$i")
      done
      ;;
    *)
      IFS=',' read -ra PARTS <<< "$selection"
      for part in "${PARTS[@]}"; do
        part=$(echo "$part" | tr -d ' ')
        if [[ "$part" =~ ^[0-9]+$ ]]; then
          idx=$((part - 1))
          if [ "$idx" -ge 0 ] && [ "$idx" -lt ${#DETECTED_NAMES[@]} ]; then
            SELECTED_INDICES+=("$idx")
          fi
        fi
      done
      ;;
  esac

  # Register selected apps
  for idx in "${SELECTED_INDICES[@]}"; do
    app_type="${DETECTED_TYPES[$idx]}"
    app_name="${DETECTED_NAMES[$idx]}"

    case "$app_type" in
      claude-code)
        claude_updated=false
        if [ -n "$CLAUDE_CLI_COMMAND" ]; then
          claude_stderr_file=$(mktemp "${TMPDIR:-/tmp}/weppy-claude-XXXXXX.err" 2>/dev/null || echo "${HOME}/weppy-claude.err")
          # Best-effort remove any legacy bare entry so the subsequent add can
          # install the canonical `@latest` form. Ignore errors when nothing
          # exists.
          "$CLAUDE_CLI_COMMAND" mcp remove weppy-roblox-mcp >/dev/null 2>&1 || true
          # Capture the CLI exit code immediately so it isn't overwritten by the
          # subsequent grep check (which would otherwise leak its own exit code).
          claude_exit_code=0
          "$CLAUDE_CLI_COMMAND" mcp add weppy-roblox-mcp -- npx -y "@weppy/roblox-mcp@latest" 2>"$claude_stderr_file" || claude_exit_code=$?
          if [ "$claude_exit_code" -eq 0 ]; then
            claude_updated=true
          elif grep -qi "already exists" "$claude_stderr_file"; then
            add_mcp_to_config "$CLAUDE_GLOBAL_MCP_CONFIG"
            claude_updated=true
          else
            fail "Failed: $app_name (exit=$claude_exit_code)"
            printf "    CLI: %s\n" "$CLAUDE_CLI_COMMAND"
            printf "    stderr:\n"
            sed 's/^/      /' "$claude_stderr_file" || true
            add_mcp_to_config "$CLAUDE_GLOBAL_MCP_CONFIG"
            claude_updated=true
          fi
          rm -f "$claude_stderr_file"
        fi

        if is_json_mcp_configured "$CLAUDE_PROJECT_MCP_CONFIG"; then
          add_mcp_to_config "$CLAUDE_PROJECT_MCP_CONFIG"
          claude_updated=true
        fi

        if is_json_mcp_configured "$CLAUDE_GLOBAL_MCP_CONFIG"; then
          add_mcp_to_config "$CLAUDE_GLOBAL_MCP_CONFIG"
          claude_updated=true
        fi

        if [ "$claude_updated" = false ]; then
          add_mcp_to_config "$CLAUDE_GLOBAL_MCP_CONFIG"
        fi

        success "Updated: $app_name"
        ;;
      claude-desktop)
        if add_mcp_to_config "$CLAUDE_DESKTOP_CONFIG"; then
          success "Updated: $app_name"
        else
          fail "Failed: $app_name"
        fi
        ;;
      cursor)
        if add_mcp_to_config "$HOME/.cursor/mcp.json"; then
          success "Updated: $app_name"
        else
          fail "Failed: $app_name"
        fi
        ;;
      codex-cli)
        if [ -n "$CODEX_CLI_COMMAND" ]; then
          "$CODEX_CLI_COMMAND" mcp remove weppy-roblox-mcp >/dev/null 2>&1 || true
          "$CODEX_CLI_COMMAND" mcp add weppy-roblox-mcp -- npx -y "@weppy/roblox-mcp@latest" >/dev/null 2>&1 || true
        fi
        if set_codex_mcp_config "$CODEX_CONFIG"; then
          success "Updated: $app_name"
        else
          fail "Failed: $app_name"
        fi
        ;;
      gemini-cli)
        if add_mcp_to_config "$GEMINI_CONFIG"; then
          success "Updated: $app_name"
        else
          fail "Failed: $app_name"
        fi
        ;;
      antigravity)
        if add_antigravity_mcp_configs; then
          success "Updated: $app_name"
        else
          fail "Failed: $app_name"
        fi
        ;;
      antigravity-cli)
        if migrate_legacy_antigravity_entry "$ANTIGRAVITY_SHARED_CONFIG" "$ANTIGRAVITY_LEGACY_CLI_CONFIG"; then
          success "Updated: $app_name"
        else
          fail "Failed: $app_name"
        fi
        ;;
    esac
  done
fi

# ═══════════════════════════════════
# [3/3] Setup WEPPY AI Agent Plugin
# ═══════════════════════════════════
step "3/3" "Setup WEPPY AI Agent Plugin"

if [ "${WEPPY_SKIP_AI_AGENT_PLUGIN:-}" = "1" ]; then
  warn "WEPPY AI Agent Plugin setup skipped (WEPPY_SKIP_AI_AGENT_PLUGIN=1)"
else
  ai_agent_plugin_any=false

  if [ -n "${CLAUDE_CLI_COMMAND:-}" ]; then
    ai_agent_plugin_any=true
    claude_marketplace_stderr=$(mktemp "${TMPDIR:-/tmp}/weppy-claude-plugin-marketplace-XXXXXX.err" 2>/dev/null || echo "${HOME}/weppy-claude-plugin-marketplace.err")
    claude_marketplace_exit=0
    "$CLAUDE_CLI_COMMAND" plugin marketplace add hope1026/weppy-roblox-mcp --scope user 2>"$claude_marketplace_stderr" || claude_marketplace_exit=$?
    if [ "$claude_marketplace_exit" -eq 0 ] || is_already_ai_agent_plugin_result "$claude_marketplace_stderr"; then
      success "Claude Code marketplace ready"

      claude_plugin_stderr=$(mktemp "${TMPDIR:-/tmp}/weppy-claude-plugin-install-XXXXXX.err" 2>/dev/null || echo "${HOME}/weppy-claude-plugin-install.err")
      claude_plugin_exit=0
      "$CLAUDE_CLI_COMMAND" plugin install weppy-roblox-ai-toolkit@hope1026-roblox-mcp --scope user 2>"$claude_plugin_stderr" || claude_plugin_exit=$?
      if [ "$claude_plugin_exit" -eq 0 ] || is_already_ai_agent_plugin_result "$claude_plugin_stderr"; then
        success "WEPPY AI Agent Plugin for Claude Code ready"
      else
        warn "WEPPY AI Agent Plugin install for Claude Code skipped or failed (non-blocking)"
        sed 's/^/    /' "$claude_plugin_stderr" || true
      fi
      rm -f "$claude_plugin_stderr"
    else
      warn "Claude Code marketplace setup skipped or failed (non-blocking)"
      sed 's/^/    /' "$claude_marketplace_stderr" || true
    fi
    rm -f "$claude_marketplace_stderr"
  else
    warn "WEPPY AI Agent Plugin for Claude Code skipped (claude CLI not found)"
  fi

  if [ -n "${CODEX_CLI_COMMAND:-}" ]; then
    ai_agent_plugin_any=true
    codex_marketplace_stderr=$(mktemp "${TMPDIR:-/tmp}/weppy-codex-plugin-marketplace-XXXXXX.err" 2>/dev/null || echo "${HOME}/weppy-codex-plugin-marketplace.err")
    codex_marketplace_exit=0
    "$CODEX_CLI_COMMAND" plugin marketplace add hope1026/weppy-roblox-mcp 2>"$codex_marketplace_stderr" || codex_marketplace_exit=$?
    if [ "$codex_marketplace_exit" -eq 0 ] || is_already_ai_agent_plugin_result "$codex_marketplace_stderr"; then
      success "Codex marketplace ready"
      printf "    Restart Codex, open Plugin Directory, then install WEPPY AI Agent Plugin.\n"
    else
      warn "Codex marketplace setup skipped or failed (non-blocking)"
      sed 's/^/    /' "$codex_marketplace_stderr" || true
    fi
    rm -f "$codex_marketplace_stderr"
  else
    warn "WEPPY AI Agent Plugin for Codex skipped (codex CLI not found)"
  fi

  antigravity_detected=false
  antigravity_cli_detected=false
  if printf '%s\n' "${DETECTED_TYPES[@]}" | grep -qx 'antigravity'; then
    antigravity_detected=true
  fi
  if printf '%s\n' "${DETECTED_TYPES[@]}" | grep -qx 'antigravity-cli'; then
    antigravity_cli_detected=true
  fi

  ANTIGRAVITY_MODE="fallback"
  if [ "$antigravity_cli_detected" = true ] && [ "$antigravity_detected" = false ]; then
    ANTIGRAVITY_MODE="native-only"
  elif [ "$antigravity_detected" = true ] || [ "$antigravity_cli_detected" = true ]; then
    ANTIGRAVITY_MODE="hybrid"
  fi

  if [ "$antigravity_detected" = true ] || [ "$antigravity_cli_detected" = true ]; then
    ai_agent_plugin_any=true
    if ! migrate_legacy_antigravity_entry "$ANTIGRAVITY_SHARED_CONFIG" "$ANTIGRAVITY_LEGACY_CLI_CONFIG"; then
      if ! activate_antigravity_fallback "Antigravity config migration failed; MCP fallback preserved"; then
        exit 1
      fi
    elif [ -z "${ANTIGRAVITY_CLI_COMMAND:-}" ]; then
      if ! activate_antigravity_fallback "Antigravity CLI is required to install the WEPPY AI Agent Plugin. Install it from https://antigravity.google/docs/cli-install"; then
        exit 1
      fi
    elif prepare_antigravity_plugin_source; then
      if [ "$ANTIGRAVITY_MODE" = "hybrid" ]; then
        stage_antigravity_skill_only_view "$ANTIGRAVITY_PLUGIN_SOURCE_PATH" || ANTIGRAVITY_NATIVE_VIEW_PATH=""
      else
        stage_antigravity_native_view "$ANTIGRAVITY_PLUGIN_SOURCE_PATH" || ANTIGRAVITY_NATIVE_VIEW_PATH=""
      fi

      if [ "$antigravity_detected" = true ]; then
        stage_antigravity_ide_view "$ANTIGRAVITY_PLUGIN_SOURCE_PATH" || ANTIGRAVITY_IDE_VIEW_PATH=""
      fi

      if [ -z "$ANTIGRAVITY_NATIVE_VIEW_PATH" ] \
        || { [ "$antigravity_detected" = true ] && [ -z "$ANTIGRAVITY_IDE_VIEW_PATH" ]; }; then
        if ! activate_antigravity_fallback "WEPPY AI Agent Plugin payload staging failed for Antigravity; MCP fallback preserved"; then
          exit 1
        fi
      else
        ANTIGRAVITY_PLUGIN_PRE_STATE=$(classify_antigravity_pre_state \
          "$ANTIGRAVITY_NATIVE_VIEW_PATH" \
          "$HOME/.gemini/antigravity-cli/plugins/weppy-roblox-ai-toolkit" \
          "$ANTIGRAVITY_IDE_VIEW_PATH" \
          "$HOME/.gemini/config/plugins/weppy-roblox-ai-toolkit" \
          "$antigravity_detected")

        if install_antigravity_cli_plugin "$ANTIGRAVITY_MODE"; then
          if [ "$antigravity_detected" = true ] && ! publish_antigravity_ide_plugin; then
            if ! activate_antigravity_fallback "WEPPY AI Agent Plugin replacement failed for Antigravity IDE; MCP fallback preserved"; then
              exit 1
            fi
          else
            report_antigravity_result "$ANTIGRAVITY_PLUGIN_PRE_STATE" "WEPPY AI Agent Plugin for Antigravity; restart and verify"
          fi
        elif ! activate_antigravity_fallback "WEPPY AI Agent Plugin replacement through Antigravity CLI failed; previous AI agent plugin or MCP fallback preserved" true; then
          exit 1
        fi
      fi
    else
      if ! activate_antigravity_fallback "WEPPY AI Agent Plugin source could not be prepared for Antigravity; MCP fallback preserved"; then
        exit 1
      fi
    fi
  fi

  [ -n "$ANTIGRAVITY_NATIVE_VIEW_PATH" ] && rm -rf "$ANTIGRAVITY_NATIVE_VIEW_PATH"
  [ -n "$ANTIGRAVITY_IDE_VIEW_PATH" ] && rm -rf "$ANTIGRAVITY_IDE_VIEW_PATH"
  [ -n "$ANTIGRAVITY_PLUGIN_SOURCE_TEMP" ] && rm -rf "$ANTIGRAVITY_PLUGIN_SOURCE_TEMP"

  if [ "$ai_agent_plugin_any" = false ]; then
    info "WEPPY AI Agent Plugin can be installed later from Claude Code, Codex, or Antigravity"
  fi
fi

# ═══════════════════════════════════
# Installation summary
# ═══════════════════════════════════
# shellcheck disable=SC2059
printf "\n%s\n" "════════════════════════════════════"
# shellcheck disable=SC2059
printf "${BOLD}Installation complete!${NC}\n\n"
# shellcheck disable=SC2059
printf "  ${BOLD}Next steps:${NC}\n"
printf "  1. Restart Roblox Studio\n"
# shellcheck disable=SC2059
printf "  2. Look for the ${BOLD}WEPPY${NC} button in the Plugins tab\n"
printf "  3. Click Connect and start building with AI!\n\n"
printf "  Auto registration: Claude Code, Claude Desktop, Cursor, Codex CLI/App, Gemini CLI, Antigravity / Antigravity IDE, Antigravity CLI\n\n"
printf "  WEPPY AI Agent Plugin: Claude Code installs automatically; Antigravity installs only when Antigravity CLI is available; Codex installs from Plugin Directory after marketplace add.\n\n"
# shellcheck disable=SC2059
printf "  ${DIM}Docs: https://weppyai.com/en/install${NC}\n\n"

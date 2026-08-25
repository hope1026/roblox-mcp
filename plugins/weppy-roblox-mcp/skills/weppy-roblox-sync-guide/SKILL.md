---
name: weppy-roblox-sync-guide
description: Use when working with WEPPY Roblox MCP Studio-local sync, effective policy, bidirectional file mirrors, multi-place project folders, conflicts, reverse apply and delete safety, sourcemaps, detector recovery, or Roblox Explorer context.
---

# WEPPY Roblox Sync Guide

## Overview

Use this skill when local files and Roblox Studio state must stay aligned through WEPPY sync. Load only the reference that matches the sync problem.

## Workflow

1. Inspect the current place with `manage_sync.status_current_place` and read the effective policy with `manage_sync.policy` before changing files.
2. If Sync is Off or the effective policy does not allow the intended direction, explain the current state and ask the user to change it in the Studio plugin; policy editing stays in the Studio plugin.
3. Confirm the relevant semantic scope and effective direction: `forward`, `reverse`, or `bidirectional`.
4. Use the v2 nested directory format when reading or editing mirrored files.
5. Treat play mode as a sync suppression window; reconcile after play exits.
6. Resolve conflicts according to the effective policy, not by silently overwriting both sides.
7. Confirm destructive local deletes before applying them to Studio unless delete auto-apply was explicitly enabled.
8. Verify by checking sync status, changed files, sourcemaps, and Roblox Explorer when relevant.

## References

- `references/sync-workflow.md`: status, effective policy, workflow scopes, apply modes, and runtime lifecycle.
- `references/sync-format.md`: v2 nested directory and file naming rules.
- `references/conflicts.md`: direction enforcement and conflict resolution.
- `references/sourcemap.md`: Place sourcemaps and `luau-lsp` integration.
- `references/roblox-explorer.md`: VSCode Explorer view over the sync mirror.

## Guardrails

- Do not start sync while Studio is in play mode.
- Do not claim that MCP or the Dashboard can edit Sync policy.
- Do not migrate or delete old sync roots automatically.
- Do not assume one active sync root per place; the project has one active `weppy-project-sync` root with isolated `place_*` children.
- Do not treat `__MCP_*` temporary test instances as synced game content.

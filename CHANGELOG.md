# Changelog

All notable changes to this project will be documented in this file.




























## [2.13.1] - 2026-08-13

### Features

- **Explain the new Asset organization options in Dashboard What's New** — The latest announcement now covers folder browsing, the flat All assets view, All scopes, category filters, Grid/List layouts, and thumbnail sizes in every supported Dashboard language.

### Bug Fixes

- **Remove outdated June announcements** — Dashboard What's New no longer lists the older June entries, keeping the release feed focused on current guidance.

## [2.13.0] - 2026-08-13

### Features

- **Browse Dashboard Assets by folder or as one searchable collection** — The Assets page now shows the folders created in your asset library, with breadcrumbs for nested navigation. Switch to **All assets** whenever you need one flat list across the selected category and scope, including **All scopes** for the current Place and shared assets together. Existing category filters remain unchanged.
- **Choose the asset view that fits your workflow** — Keep the familiar Grid or List layout and choose Small, Medium, or Large thumbnails independently. Your organization and view preferences are remembered when you return to the Assets page.

### Bug Fixes

- **Keep the Assets toolbar in one place while changing scopes** — Rescan, settings, scope context, and category filters now stay aligned when switching between All scopes, Current Place, and Shared assets, even when one result set needs a scrollbar.
- **Keep folder navigation usable in narrow Dashboard windows** — Folder navigation now preserves focus and avoids horizontal overflow on smaller screens.

## [2.12.4] - 2026-08-13

### Features

- **Keep Open Cloud uploads in the Asset Library** — Uploading an image, audio file, model, or video through Open Cloud now creates or reuses the matching shared or Place asset record automatically. Existing non-Decal Roblox assets can also be linked to a local file without uploading them again, and repeated requests return the same library item.

### Bug Fixes

- **Resume Project Sync after its WebSocket reconnects** — If the local MCP server restarts or the command connection drops while Sync is active, the Studio plugin now reconnects, cleans up the previous session, and starts a fresh full sync with the same one-time or continuous intent, direction settings, and preserved-file choices.
- **Keep one stable folder for each Place during Sync** — Concurrent starts and Place ID promotion now use the same canonical folder. Duplicate folders are archived only after a successful full sync, so interrupted or failed syncs keep recoverable local data.
- **Keep Project Change Summary writes reliable on Windows** — Concurrent history writes and cleanup now share one file-access queue, preventing transient Windows rename locks from losing a session or stopping later cleanup work.
- **Reject unsafe Open Cloud library writes before local state changes** — Disabled uploads stop before creating a local library item, links require a verified matching Roblox asset type, and concurrent duplicate links converge on one item instead of producing duplicates.

### Stability

- **Safer local MCP restarts during Studio development** — The local stop script now targets only processes listening on the MCP ports, so an attached Roblox Studio client is not mistaken for the server.

## [2.12.3] - 2026-08-12

### Bug Fixes

- **Correct spatial results for rotated objects** — `bounds`, `spatial_map`, `collision`, and `find_space` now include each object's rotation and all descendant parts when calculating world-space bounds. AI agents will no longer overlook collisions or blocked space around rotated parts, models, and folders. No tool schema or configuration changes are required.

## [2.12.2] - 2026-08-10

### Features

- **Attributes that point at another object now sync** — Roblox recently added the ability for an attribute to reference an instance directly (currently a Studio Beta). Until now those attributes arrived empty on the file side, and applying a file back to Studio could silently turn the reference into plain text or remove it. WEPPY now records the referenced object's location — including which one you meant when several objects along the path share a name — so the reference survives a round trip in both directions.

### Bug Fixes

- **Repointing a reference between same-named objects is no longer missed** — If an attribute referenced one object and you repointed it at a different object with the same name, the change could go undetected and never reach your files. These changes are now picked up.

### Stability

- **Attribute values of unrecognized types no longer disappear** — When Roblox adds an attribute type WEPPY doesn't know yet, the value used to be dropped during sync, and applying that file back to Studio could erase it there too. Unrecognized values are now kept as a placeholder that records the type, and applying a file back to Studio skips them so your Studio value stays as it is.

- **Unresolvable references are skipped instead of overwriting your data** — If an attribute reference in a file can't be matched to an object in Studio, the attribute is now left untouched rather than being cleared or replaced with text, and the reason is written to the plugin log.

## [2.12.1] - 2026-08-03

### Bug Fixes

- **Apply Luau syntax validation changes without reconnecting MCP** — Turning Luau Syntax Validation on or off in Dashboard Controls now affects the next supported script write in already-running MCP sessions. No `/mcp` reconnect or server restart is required.

## [2.12.0] - 2026-08-02

### Features

- **Catch Luau syntax errors without starting Playtest** — AI agents can now validate raw source or an existing Script directly on Basic and Pro. Turn on `Controls > Luau Syntax Validation` in the Dashboard to check the source that was actually saved after supported script writes. Valid checks keep normal write responses compact, while syntax errors include details the agent can use to fix the same script. Automatic validation is Off by default, and script changes remain applied if validation finds an error or is unavailable.

### Bug Fixes

- **Keep MCP and Studio Sync running when Windows temporarily locks a history file** — WEPPY now retries transient file replacement failures and isolates a final Project Change Summary save failure instead of shutting down the MCP server. Later Studio Sync work can continue without restarting the session.
- **Save Dashboard settings through temporary Windows file locks** — Dashboard setting updates now use the same bounded retry behavior when another process briefly has the settings file open.
- **Keep duplicate-name Sync paths consistent on Windows** — Same-name sibling objects now use the correct platform path mapping, preventing the local files, Explorer tree, and Sync index from disagreeing after a collision rename.

### Stability

- **Include Project Change Summary save failures in bug reports** — If a history file still cannot be replaced after retries, WEPPY records the failure for that Place and includes it in the Dashboard bug-report ZIP for diagnosis.

## [2.11.3] - 2026-07-28

### Features

- **Less cluttered storage controls in Dashboard Settings** — Project Change Summary and UI Studio storage policy details now stay collapsed until needed, and only one panel opens at a time. Expanded controls use a compact desktop-first layout that remains usable with a keyboard and avoids horizontal overflow in narrow windows.
- **Clearer storage cleanup actions** — Full deletion is now labeled `Clear all`, while `Run saved policy` explicitly runs the last saved cleanup rule without applying unsaved changes. The updated labels and guidance are available in all eight Dashboard languages.

## [2.11.2] - 2026-07-28

### Features

- **Control Project Change Summary storage per Place** — Dashboard Settings now shows the actual storage used by completed Project Change Summary sessions and lets you choose a 100MB, 500MB, 1000MB, or Unlimited policy. The default 500MB limit is applied independently to each Place, and you can preview the cleanup, save the policy, or run it immediately without deleting active sessions or unrelated Sync and UI Studio data.

### Bug Fixes

- **Recover Project Sync after an interrupted index save** — If Sync starts with a truncated or invalid index, WEPPY now restores a valid saved copy or rebuilds the index from the local mirror instead of failing with a JSON parsing error. Unrecoverable files are preserved for diagnosis, and recovery details are available in Sync status.
- **Keep Script and LocalScript file types during incremental Sync** — Updating source no longer changes a Script or LocalScript into a ModuleScript when its optional properties file is absent, so existing `.server.luau` and `.client.luau` paths remain intact.
- **Prevent duplicate same-name objects during forward Sync** — WEPPY no longer mistakes its own local mirror writes for user edits and sends them back to Studio as restore requests. This prevents collision suffixes and same-name siblings from being duplicated during rapid create, rename, move, and delete sequences.

### Stability

- **More accurate storage cleanup accounting** — Project Change Summary and UI Studio cleanup now use the bytes actually stored on disk, retain complete records, and protect active data while removing the oldest eligible history first.

## [2.11.1] - 2026-07-24

### Features

- **Read only the script lines you need** — AI agents can now request a specific line range from large scripts instead of loading the entire source every time. Range reads are available on Basic, preserve the original source text, and report the actual returned range when a request extends past the end of the script.
- **See when a tool request includes unused options** — WEPPY now returns a non-blocking warning when an AI agent sends options that the selected operation does not use. The operation still runs, while the warning helps the agent correct the next request instead of silently assuming those options took effect.

### Documentation

- **Refreshed Dashboard What's New** — The Dashboard now highlights recent preflight, script-reading, request-warning, and Playtest report improvements in all supported languages. May announcements have been removed from the bundled feed.

## [2.11.0] - 2026-07-19

### Features

- **Cleaner Project Sync files with a reviewed v3 update** — New Sync projects now use a canonical file format that avoids unnecessary Git diffs when the same Studio state is synced again. Existing v2 projects stay unchanged until you review the exact metadata additions, modifications, deletions, and blockers in the Dashboard Sync page and explicitly apply the update. WEPPY creates a runtime backup before applying it and does not modify Luau source files. After a place is updated to v3, opening that Sync data with an older MCP server is not supported; projects that remain on v2 continue to work normally.
- **Read-only Studio readiness checks before AI work** — AI agents can now use `system_info.preflight` to check the selected Studio connection, place identity, Edit or Play state, publish status, screenshot readiness, and security capabilities before starting a task. The check reports specific setup actions without changing Studio settings, the DataModel, or DataStore state.
- **Read-only Open Cloud upload checks** — Pro users can now verify the saved API key, Assets Read and Write permissions, Creator target, requested asset category, and local file format and size before uploading. Running `manage_open_cloud_assets.preflight` does not upload or update a Roblox asset and does not expose the raw API key.

### Bug Fixes

- **No duplicate events in completed Playtest reports** — `manage_studio.run_test` no longer records the same logs and signals twice when a completed test reports them through both the final result and the live event stream. Timeout and cancellation reports still preserve the available partial stream evidence, including intentional repeated messages.

### Stability

- **Less Sync metadata noise in Git and Dashboard history** — Runtime files such as session and timestamp state are ignored by WEPPY-managed Git rules and excluded from game-change history, while generated files can be distinguished from user source and canonical mirror changes. Existing user `.gitignore` rules and already tracked files are left in place.

## [2.10.4] - 2026-07-18

### Features

- **More natural and controllable environment generation** — Existing terrain generation now combines large landforms with finer surface detail, separates ground and cliff materials by slope, and shapes water and shorelines around the terrain. Pro users can adjust results with six biome presets, apply ten environment moods, and place tree or rock templates with slope, water, spacing, rotation, scale, and seed controls. Each operation is recorded as one Studio Undo step, and reusing a seed reproduces the same terrain or placement.

## [2.10.3] - 2026-07-14

### Bug Fixes

- **Reliable Antigravity plugin reinstalls** — The one-line installers now use Antigravity CLI as the native plugin prerequisite, replace existing plugins with the latest public release, and distinguish installs, updates, reinstalls, repairs, fallbacks, and hard failures without treating an existing plugin as a skipped install.

## [2.10.2] - 2026-07-13

### Features

- **Antigravity plugin support** — Antigravity and Antigravity CLI can now load WEPPY's Roblox workflow skills from the shared WEPPY AI Agent Plugin. Antigravity uses the verified skill plugin plus one shared MCP connection, while Antigravity CLI can use the native plugin when its MCP startup is confirmed.
- **Expanded Roblox workflow skills** — Added dedicated guidance for Asset Library, Creator Store, generated assets, and Studio or Open Cloud uploads. The MCP and Sync skills also cover Multi-Studio routing, UI Studio resources, delete approval and Undo, sourcemaps, and recovery workflows more completely.

### Stability

- **Safer Antigravity installs and upgrades** — The installers now keep Antigravity and its CLI on one shared global MCP configuration when needed, migrate older CLI entries without overwriting other servers, and prevent duplicate WEPPY connections. Native plugin failures fall back to the shared MCP setup instead of leaving a partially configured install.
- **Stronger distribution checks** — Release validation now covers plugin layout, skill references, native and fallback installer modes, legacy configuration migration, Windows and Ubuntu installation, and npm package contents before deployment.

## [2.10.1] - 2026-07-04

### Bug Fixes

- **Improved Test and Run state detection in Roblox Studio** — The Dashboard now reports Studio targets as Running or Paused more accurately when you start Test or Run from Roblox Studio, pause the simulation, or let WEPPY start a playtest. This makes it easier to tell whether an AI agent is working against Edit mode, an active playtest, or a paused simulation without changing your setup.

## [2.10.0] - 2026-07-03

### Features

- **Use Roblox Studio model generation from AI agent requests** — WEPPY can now call Roblox Studio's model generation feature and create the generated model inside Studio. You can review the result in Studio, save it to the local Asset Library as RBXM, and upload the selected model when you need a Roblox asset ID.
- **Save generated Studio content more safely as RBXM** — When a generated model contains mesh or texture data that does not yet have Roblox asset IDs, WEPPY asks before using Studio-local upload to preserve that embedded content before saving the RBXM. No manual migration is required.
- **Safer Project Sync delete settings** — Sync now separates "local file deleted" from "delete the matching Studio instance." The default is to ask before deleting in Studio, and you can switch to Auto Delete from the Sync direction controls when local deletes should be treated as Studio delete intent.

### Bug Fixes

- **Undo local-to-Studio Sync changes in Roblox Studio** — Script edits, created instances, and local delete applies made by Sync are now recorded in Studio history. If a local delete removes a Studio instance, Roblox Studio Undo can restore it instead of leaving the action with no response.

### Stability

- **Cleaner Dashboard controls and danger actions** — Dashboard buttons, tabs, help actions, modals, and destructive controls now use a more consistent visual system across Assets, Sync, Connection, Playtest, Tools, Settings, UI Studio, and What's New. This makes repeated dashboard work easier to scan without changing existing setup.

## [2.9.3] - 2026-06-27

### Bug Fixes

- **Recover from invalid licenses without leaving Roblox Studio** — When an existing Pro license becomes invalid, revoked, or needs manual reactivation, the Dashboard and Studio plugin now keep the recovery controls available. You can enter a new license key or reset the old local registration instead of getting stuck with disabled license buttons.

### Stability

- **More reliable Project Sync restart cleanup** — If a full sync fails or is restarted while Studio reconnects, WEPPY now recognizes cleanup requests from the same plugin process even when the temporary client ID changed. This reduces cases where a stale sync session blocks the next sync attempt.
- **Clearer sync conflict details in Studio logs** — Sync ownership conflicts now preserve the server's detailed message in the Studio plugin logs, making it easier to see which connection or sync session is blocking the action.

## [2.9.2] - 2026-06-23

### Stability

- **Stability improvements** — WEPPY can now verify MCP launches with an additional anonymous operations check, helping us spot release-health gaps sooner while keeping Studio workflows unchanged. No setup changes are required.

## [2.9.1] - 2026-06-21

### Stability

- **Cleaner Pro upgrade links from the Studio plugin** — The Pro guide now shows a shorter plans link that is easier to copy from Roblox Studio, while WEPPY still records the visit as plugin traffic on the website. This improves purchase-path reporting without changing the upgrade flow or requiring any setup change.

## [2.9.0] - 2026-06-18

### Features

- **Multiple Roblox Studio windows from one MCP server** — WEPPY can now keep several Roblox Studio windows connected as separate Studio targets. This helps lobby games and multi-place experiences: open each place in its own Studio window, then tell the AI which `Studio ID` or `placeId` to use. Requests without a named target follow the Dashboard Studio Routing setting.
- **New Dashboard Controls tab** — MCP behavior settings now have a dedicated Controls page. Use **Controls > Studio Routing** to switch between automatic recent priority and a pinned Studio window, set the priority target, and copy Studio IDs. Project Root and General Settings also live in Controls, while Settings stays focused on license, data, environment, and language.
- **Clearer connection view for Studio targets** — The Connection page now shows Studio targets instead of a generic plugin list, with Studio ID, place, connection, routing, and in-flight request details. This makes it easier to see which Studio window will receive AI requests.
- **Place-aware Dashboard data** — Dashboard areas that read saved data now keep the selected place clearer, so tool history, reports, assets, and current-place context stay tied to the Studio target or place you are working with.

### Stability

- **More reliable multi-place routing** — WEPPY now preserves selected Studio targets across routed requests, handles disconnected pinned targets by returning to automatic routing, and keeps asset and Playtest work scoped to the intended place.
- **Larger multi-place sync cache** — Project Sync can keep up to five place contexts in memory at once. Existing `place_*` folders are preserved on disk, and no manual migration is required.

## [2.8.2] - 2026-06-15

### Bug Fixes

- **More complete Dashboard bug reports** — Bug reports opened from WEPPY Dashboard now keep the Roblox Studio version when Studio reconnects or refreshes its plugin metadata. If the Plugin cannot report the Studio version, WEPPY also checks the installed Roblox Studio app or executable and marks that value as an installed-app fallback in the GitHub issue prefill. This gives support reports the Studio version more consistently without requiring any setup change.

## [2.8.1] - 2026-06-15

### Features

- **Playtest controls now live under Studio actions** — AI agents and direct MCP users should use `manage_studio.play_start`, `manage_studio.play_stop`, `manage_studio.play_pause`, `manage_studio.play_resume`, `manage_studio.play_status`, and `manage_studio.run_test` for Playtest workflows. The older `system_info` Playtest aliases are no longer the documented path, keeping `system_info` focused on read-only status and diagnostics.

### Bug Fixes

- **Fix Play Stop cases that required a retry** — Stopping a Playtest now handles cases where Roblox Studio creates multiple plugin connections after Play starts. WEPPY no longer relies on only one connection for Stop, and cleanup checks the Playtest status when it needs confirmation that Studio returned to Edit mode. This reduces cases where the AI asks Studio to stop but the test keeps running until you retry.

## [2.8.0] - 2026-06-14

### Features

- **Experimental Dashboard Assets page** — The WEPPY Dashboard now includes an experimental Assets page for local Images, Decals, and RBXM files, so you can review saved assets, upload supported files, and insert saved RBXM files into the connected Studio place.
- **AI-generated image upload support** — When using image-capable AI agents such as Codex Desktop or Antigravity, you can generate an image, save it into the local Asset Library, upload it to Roblox with Open Cloud, and use the returned Roblox Asset ID or `rbxassetid://` URI in your game.
- **RBXM export and insert from Studio** — You can export selected Roblox Studio objects as RBXM files from the WEPPY Plugin Assets tab, review the saved files in the Dashboard, and insert them back into the connected Studio place.
- **Local Open Cloud credential storage** — Roblox uploads use API key and Creator ID profiles stored locally with encryption. WEPPY does not store API keys in an external service or send them to a separate WEPPY server; the local MCP server uses them only for Roblox Open Cloud upload requests.

## [2.7.18] - 2026-06-08

### Stability

- **Clearer sync disk-error troubleshooting** — When Project Sync cannot start because the local sync folder cannot be written, WEPPY now keeps the underlying disk or permission message in the Studio error details and server logs instead of only showing `Disk error`. This makes support logs more actionable without changing the sync workflow.

## [2.7.17] - 2026-06-07

### Bug Fixes

- **More reliable Codex Play testing controls** — Fixes an intermittent issue where starting or stopping Play tests from Codex could miss the active Roblox Studio play session, leaving `play` or `stop` commands stuck until retried.

## [2.7.16] - 2026-06-05

### Bug Fixes

- **More reliable full sync for large places** — WEPPY no longer lets the server-side sync cleanup timer expire while Studio is still actively uploading a large Workspace in chunks. This prevents full sync from stopping with errors like `Cannot read properties of null (reading 'setClassName')` during long-running project syncs.

### Stability

- **Longer wait time for full sync completion** — The Roblox Studio plugin now gives full sync completion requests more time to finish, so large temp-folder swaps, index saves, and sourcemap updates can complete without being reported as a `/sync/init` timeout.

## [2.7.15] - 2026-06-03

### Stability

- **Release package cleanup** — Rebuilds the v2.7 release line from the last stable baseline while keeping the v2.7.13 and v2.7.14 stability fixes below. Existing Dashboard, Sync, UI Studio, Changelog, Playtest, Tools, and Settings workflows continue to work normally.
- **Unfinished Dashboard Assets work rolled back** — An in-development Assets page and Roblox upload controls were included in v2.7.13 and v2.7.14 before they were ready. v2.7.15 removes that unfinished surface from release builds. We are sorry for the confusion this caused.

## [2.7.14] - 2026-06-03

### Bug Fixes

- **More reliable sync for imported models and VFX assets** — Project sync no longer stops with `Can't convert to JSON` when a Roblox model contains non-UTF8 string data in values or attributes. WEPPY now preserves that data safely and continues syncing the rest of the place.

### Stability

- **Clearer chunk-sync troubleshooting in Studio** — When sync encounters unusual data, WEPPY now points to the affected Studio object, field, and byte length in the plugin logs without exposing the raw value. Generic `Internal error` responses from the server also surface the detailed message when one is available, making support logs easier to share from the WEPPY UI.

## [2.7.13] - 2026-06-02

### Stability

- **Stability improvements** — WEPPY now tracks first-time MCP usage more reliably for operations reporting while keeping existing Studio workflows unchanged. No setup changes are required.

## [2.7.12] - 2026-05-28

### Features

- **More helpful Basic-plan alternatives for Pro requests** — When a Basic user asks an AI agent to use a Pro-only feature, WEPPY can now complete more of those requests with the closest available Basic behavior instead of stopping immediately. This helps common work continue across selection details, object browsing, Workspace summaries, property changes, simple multi-object edits, UI creation and editing, lighting/time/effect changes, and safe script lookup. Requests that truly require Pro still show the Pro guidance.

### Stability

- **Clearer repeated-request handling** — If the same request is sent twice, WEPPY now reports it as a repeated request instead of letting it look like Studio is taking too long to respond. This reduces confusing long waits and makes retry behavior easier to understand.
- **Clearer error reports** — Connection delays, Studio response timeouts, and repeated requests are now separated more clearly in WEPPY's error reporting, making support and troubleshooting more accurate without changing existing workflows.
- **More reliable Basic/Pro checks** — The validation flow for Pro behavior and Basic-plan alternatives is more stable, especially when testing a connected Studio session after switching between Pro and Basic.






## [2.7.11] - 2026-05-24

### Features

- **Polar checkout for WEPPY Roblox AI Toolkit Pro** — New Pro purchases now use Polar as the default checkout path. Existing Gumroad purchases continue to work without migration, and users who cancel Gumroad and subscribe again will be guided to the new Polar payment link.

### Bug Fixes

- **More reliable installer upgrades** — The one-line installers and packaged setup scripts now handle Codex configuration updates more safely, including repair installs where an older WEPPY MCP block already exists. Windows installs also avoid PowerShell shim resolution issues when locating optional CLI tools.

### Stability

- **License provider stability hardening** — WEPPY now treats the license provider as a generic backend detail instead of assuming Gumroad everywhere. This makes Pro status checks and dashboard license display more resilient while keeping current Gumroad licenses usable.
- **General reliability cleanup** — Internal dashboard, plugin, and release-package cleanup reduces stale artifacts and keeps setup guidance aligned across supported languages.

## [2.7.10] - 2026-05-21

### Features

- **Antigravity IDE and Antigravity CLI setup support** — The one-line installers and packaged setup scripts now recognize the newer Antigravity configuration layout, including Antigravity IDE and Antigravity CLI. Antigravity CLI users get a dedicated global MCP config path at `~/.gemini/antigravity-cli/mcp_config.json`, while existing Antigravity and Antigravity IDE users continue to use their current config locations.

### Stability

- **More reliable MCP registration for Antigravity users** — Installers now check the current Antigravity config candidates separately, update existing files when present, and create the canonical `mcpServers` shape when needed. This reduces false "already configured" states and makes repair installs safer across macOS, Windows, and Linux.

## [2.7.9] - 2026-05-17

### Stability

- **Clearer failure diagnostics for AI tool calls** — WEPPY now records more precise low-cardinality diagnostics when Roblox Studio commands time out or fail inside workspace state sync and script editing. This helps support and future fixes identify whether failures came from queue delays, Studio connection state, script edit input, or a specific workspace sync stage, without exposing script source or raw Studio paths.
- **More resilient workspace state sync reporting** — Workspace state sync now labels failures by stage, so a problem while reading scripts, viewport metadata, tree data, or change history no longer collapses into a generic runtime error. Existing workflows and tool behavior are unchanged.

## [2.7.8] - 2026-05-16

### Features

- **French language support** — The WEPPY dashboard and Roblox Studio plugin now support French. Select **Français** from Settings to use the dashboard and plugin UI in French, and French systems are detected automatically when the language setting is set to Auto.

### Stability

- **More reliable localized setup guidance** — The dashboard What's New page now supports multiple localized setup links in a single announcement, so Claude Code, Codex CLI, and Codex App users can jump directly to the correct install guide for their language.
- **Language selector consistency** — The plugin Settings language dropdown now uses the same supported locale list as the localization runtime, so every shipped language appears as an option.

## [2.7.7] - 2026-05-14

### Bug Fixes

- **Codex Plugin Directory installation** — The Codex marketplace entry now uses the installable plugin metadata expected by Codex and appears as **WEPPY Roblox AI Toolkit**. The MCP server id and npm command stay unchanged, while Codex users can install the plugin and load the included WEPPY skills from Plugin Directory.

### Documentation

- **Clearer Claude Code and Codex setup names** — Install guides now use the same plugin id and display name across the public README, one-line installer guidance, and website docs, reducing confusion between the MCP server and the agent plugin.

## [2.7.6] - 2026-05-14

### Features

- **Skills for Claude Code and Codex** — The agent plugin distribution now ships ready-to-use skills for Claude Code and Codex CLI, so AI agents pick up Roblox-specific workflows (sync, game dev, UI) automatically when the plugin is installed. No extra setup needed beyond the standard install.

### Stability

- **Stricter validation for `batch_execute`** — Commands sent through `batch_execute` are now validated against each tool's schema before dispatch, so malformed batches fail fast with a clear error instead of partially executing.
- **Better error reporting for `execute_luau`** — Luau runtime failures now surface with structured classification (origin, recoverability) in tool history and dashboard logs, making it easier to diagnose why a script call failed.

## [2.7.5] - 2026-05-12

### Stability

- **Stability hardening** — Internal reliability improvements across the MCP server and Roblox Studio plugin. No behavior changes for existing workflows.

## [2.7.4] - 2026-05-10

### Stability

- **Stability hardening** — Internal reliability improvements across the MCP server and Roblox Studio plugin. No behavior changes for existing workflows.

## [2.7.3] - 2026-05-09

### Stability

- **Stability hardening** — Internal reliability improvements across the MCP server and Roblox Studio plugin. No behavior changes for existing workflows.

## [2.7.2] - 2026-05-06

### Stability

- **Stability hardening** — Internal reliability improvements across the MCP server and Roblox Studio plugin, including more robust instance resolution, unified metadata serialization, and structured error classification with clearer origin and recoverability information. No behavior changes for existing workflows.

### Improvements

- **Dashboard UI polish** — The dashboard has been refreshed with a consolidated semantic color system and refined analytics event tracking, giving a more consistent look-and-feel across pages and cleaner navigation context.

## [2.7.1] - 2026-05-05

### Improvements

- **Stability hardening** — Internal reliability improvements across the MCP server and Roblox Studio plugin. No behavior changes for existing workflows.

## [2.7.0] - 2026-05-05

### Features

- **UI Studio launch** — A new workflow for iterating on Roblox Studio UI design together with an AI agent. From the UI Studio page in the dashboard, you can now use:
  - **History tab** — Compare before/after snapshots and design suggestions for each request, side by side.
  - **Analysis tab** — Snapshot comparison modal with batch selection and deletion.
  - **Design Check** — Reviews your UI against design quality criteria and surfaces concrete improvements.

### Improvements

- **More accurate property types when syncing local edits back to Studio** — When you edit synced files locally and push the changes back to Studio, the server now resolves property types via class-aware metadata instead of guessing from value shape. Edits to enum, color, or vector properties on specific instances are no longer silently saved as the wrong type.

### Bug Fixes

- **Claude Code detection on Windows** — On Windows, Claude Code could be mis-detected and even a fresh install would fail with a confusing "already exists" error. Detection is now correct, and an existing valid registration is treated as success.

- **Dashboard tooltips no longer clipped** — Tooltips inside scrollable areas (Settings, UI Studio history) were being cut off. They now display in full regardless of the surrounding container.



## [2.6.4] - 2026-04-22

### Bug Fixes

- **Fix MCP server crashing on startup** — The MCP server could crash immediately on startup, preventing any tools from loading. The server now starts cleanly without any config change.


## [2.6.3] - 2026-04-21

### Bug Fixes

- **Fix MCP tools failing to register on Claude Code 2.0.21+ and other strict MCP clients** — Starting a session with `@weppy/roblox-mcp` configured returned a `400 input_schema does not support oneOf, allOf, or anyOf at the top level` error, causing **no WEPPY tools to load at all**. The server now sanitizes `tools/list` responses so the schema passes Anthropic API validation. Users on Claude Code 2.1.x were unaffected (the client already worked around the issue), but users on older Claude Code, Cursor, Cline, or direct API integrations will now get a clean tool registration without any config change.


## [2.6.2] - 2026-04-20

### Features

- **Help & Feedback in the dashboard sidebar** — A new Help & Feedback group has been added to the bottom of the dashboard sidebar, giving you one-click access to report a bug, request a feature, join the community, or open the official troubleshooting guide. The bug report link automatically prefills your OS, AI client, and MCP/plugin version in the GitHub issue form so filing a report takes seconds instead of minutes, and the troubleshooting link opens the official guide on weppyai.com in your current dashboard language.

### Stability

- **Improved overall stability** — General stability has been hardened for a smoother, more reliable experience.


## [2.6.1] - 2026-04-19

### Features

- **Dashboard design refresh** — The dashboard now has a cleaner layout with a slimmer top header, an updated sidebar using Lucide icons, and a new Upgrade widget. It also supports light and dark themes and follows your system preference by default.
- **Changelog shows before/after values** — The Changelog page now displays the previous value and the new value side by side for each property change, so you can see exactly what changed without digging through raw data. Added and removed items are highlighted more clearly too.
- **What's New announcement for the 2026-04-19 release** — The dashboard What's New page includes a new entry covering the design refresh, light/dark mode, and Changelog before/after display.


## [2.6.0] - 2026-04-15

### ⚠️ BREAKING CHANGES

- **Legacy sync folder names removed from spec and runtime** — `roblox-project-sync` (the pre-rebrand folder name) is no longer recognized by the MCP server, dashboard, Explorer extension, or playtest/test-report writers. Users who still had sync data under `roblox-project-sync/` must manually rename the folder to `weppy-project-sync/`. The `wrox-project-sync` → `weppy-project-sync` one-shot copy migration remains in place as transitional compat code for users upgrading from v2.5.x but is no longer part of the spec and will be removed in a future release.

### Features

- **Edit-mode screen capture** — AI agents can now capture the Studio viewport directly in Edit mode, so they can see what you see and give feedback on layout, lighting, and placement without entering Playtest.
- **German (Deutsch) language support** — The dashboard and plugin are now fully available in German. Switch to Deutsch from Settings → Language.

### Stability

- **Improved overall stability** — Tool execution, error messages, sync operations, and the dashboard "What's New" page have all been hardened for a smoother, more reliable experience.









## [2.5.1] - 2026-04-12

### Bug Fixes

- **Fix installer failing when run from a directory with a local `@weppy/roblox-mcp` package** — If the install script was executed from a folder where `@weppy/roblox-mcp` was already present (for example inside the package itself or under a parent `node_modules`), `npx` could pick up the shadowed local copy instead of fetching the published release, causing setup to misbehave or fail. The installer now runs `npx` inside an isolated temporary working directory, so it always resolves and installs the latest published version regardless of where you run it from.


## [2.5.0] - 2026-04-12

### ⚠️ BREAKING CHANGES

- **Project sync folder renamed (`wrox-project-sync` → `weppy-project-sync`)** — As part of the `wrox` → `weppy` rebrand, the default project sync root and the app data directory have been renamed (`.wrox-data` → `.weppy-data`). Existing folders are **automatically copied** to the new location on first launch — no manual migration is required, and your synced files are preserved. The legacy folder is left in place with a `.weppy-legacy-path.json` marker so you can clean it up at your convenience.

### Features

- **Property Panel for VSCode Explorer** — A new dedicated property panel inside the WEPPY Explorer lets you inspect and edit Roblox instance properties directly from VSCode, without switching back to Studio. Open any instance and you get a Studio-style editor with grouped categories, dropdowns for enum properties, an expandable CFrame editor for position and orientation, per-property tooltips, and dedicated Tags and Attributes sections. Property values stay live with Studio, so edits in VSCode are reflected immediately and vice versa.

### Bug Fixes

- **Fix installer failing on Node.js 24** — Running the install script (`install.sh` / `install.ps1`) on Node.js 24 previously failed with module-type errors and never finished setup. The installer now works correctly across Node 18, 20, 22, and 24, so users on the latest Node.js can install WEPPY without downgrading.
- **Fix Property Panel appearing blank in the published Explorer extension** — The Property Panel rendered correctly in development but showed up blank when the WEPPY Explorer extension was installed from the VSCode Marketplace. The panel now displays properly in the published extension.


## [2.4.1] - 2026-04-10

### Bug Fixes

- **Fix playtest commands not working** — Resolved an issue where Play, Stop, Pause, and Resume commands in system_info tool failed due to inconsistent command string handling.


## [2.4.0] - 2026-04-10

### ⚠️ BREAKING CHANGES

- **Tool statistics and changelog history format updated** — The internal storage format for tool execution statistics (`tool-stats.json`) and changelog history has changed. Existing data will be automatically reset on first launch after upgrading. You will start with fresh statistics — previous history is not migrated.

### Features

- **Dashboard "What's New" page** — A new announcements page in the dashboard keeps you informed about important changes, breaking updates, and tips. Accessible via the bell icon in the sidebar, with unread indicators for new announcements.
- **Improved blocked-tool feedback** — When a Pro-only tool is used on Basic tier, the dashboard and plugin now show clearer outcome details (fallback, unsupported, failed) instead of generic error labels.
- **Connection stability improvements** — Added handshake timeout, connection cancel button, and license reconnect race condition fixes for more reliable Studio connections.

### Bug Fixes

- **Fix `ws` module not found on install** — Replaced dynamic `require("ws")` with a static import, resolving installation failures where the `ws` dependency could not be located by the bundler.


## [2.3.1] - 2026-04-07

### Features

- **WEPPY Sourcemap support** — Added sourcemap builder that generates and refreshes sourcemaps automatically after sync, enabling luau-lsp integration for WEPPY users
- **Dashboard improvements** — Added agent activity indicators, last-seen/last-command columns, process termination, and active place path display to the connection and sync dashboards

### Stability

- **Sourcemap generation hardened** — Fixed multiple edge cases around sourcemap refresh timing, redundant rebuilds, and state persistence to ensure reliable sourcemap output
- **Sync reliability improvements** — Improved sync history diff recording, collision index mapping, and error handling across sync and camera operations


## [2.3.0] - 2026-04-05

### Performance

- **Dramatically faster tool action execution** — Switched MCP ↔ Plugin communication from polling to streaming, eliminating round-trip latency and significantly improving response throughput

### Stability

- **Hardened connection management** — Streaming-based transport replaces polling with a real-time bidirectional channel, reducing dropped connections and improving reconnect resilience

### Bug Fixes

- **Prevent OOM on large history files** — Tool history and sync changelog reads now use reverse-chunk tail scanning instead of loading the full file into memory, preventing out-of-memory crashes on long-running sessions
- **Auto-trim history files** — History files are now automatically trimmed when they exceed 2 MB, keeping disk usage bounded without manual cleanup


## [2.2.2] - 2026-04-03

### Features

- add configurable MCP message polling interval and related options to plugin UI


## [2.2.1] - 2026-04-03

### Features

- implement command acknowledgment and in-flight request tracking to ensure reliable command delivery and timeout handling


## [2.2.0] - 2026-04-03

### Sync Stability

- Redesign sync algorithm for large-scale instances — snapshot-based scanner replaces legacy chokidar detector for improved reliability
- Add throttled sync initialization with retry logic and session cleanup
- Harden scanner lifecycle transitions: startup cancellation, resume, finalize, and queue ordering
- Close full-sync detector lifecycle races and preserve snapshot kind transitions
- Improve reverse sync path resolution with snapshot-based scanning

### Features

- Add client-mode idle watchdog with configurable timeout for automatic shutdown
- Separate health check and polling failure thresholds for better connection state management
- Add upstream permanent failure detection with graceful shutdown callback

### Bug Fixes

- Fix cancel-pending license state incorrectly treated as inactive
- Fix detector activity reporting and status exposure in idle responses


## [2.1.3] - 2026-03-31

### Stability Improvements

- Improve overall system stability and reliability

## [2.1.2] - 2026-03-31

### Stability Improvements

- Improve overall system stability and reliability


## [2.1.1] - 2026-03-29

### Bug Fixes

- fix Windows install script (`install.ps1`) to resolve `npm.cmd` execution policy issues by introducing `Invoke-Npm` wrapper


## [2.1.0] - 2026-03-29

### ⚠️ BREAKING CHANGES

- **Sync directory renamed**: `roblox-project-sync/` → `weppy-project-sync/`. All existing sync data will be stored under the new directory. The old `roblox-project-sync/` directory is no longer used.
- **App data directory renamed**: `~/.weppy-roblox-mcp` → `~/.weppy-data`. The old `~/.weppy-roblox-mcp` directory is no longer recognized.
- **Project sync resets from Studio**: After upgrading, project sync data is re-initialized from Studio as the source of truth. Any local-only changes not yet synced back to Studio will be lost — ensure your Studio state is up to date before upgrading.
- **License downgrade requires plugin action**: If your license changes from Pro to Basic, you **must** click "Refresh" in the plugin UI or deactivate and reactivate the plugin for the tier change to take effect. Without this step, the plugin may continue to report the previous tier.

### Features

- **Dashboard project root switching**: Added the ability to change the project root directory directly from the Dashboard overview page, with restart and path migration support.
- **Dashboard Place UI improvements**: Redesigned the Place summary display for better visual clarity and usability.
- Dashboard place summary API and persistence for active project state
- Sync root switch flow with configurable overrides and path migration

### Bug Fixes

- Harden sync-root switching with error handling and fallback resolution
- Preserve and surface dashboard sync-root restart errors
- Normalize observability sync roots and honor override root in runtime paths
- Cover remaining legacy runtime paths

### Documentation

- Expand documentation with project rationale, use cases, FAQ, and license details across all locales
- Update sync data path documentation to reflect project-root-based storage


## [2.0.10] - 2026-03-28

### Improved

- Improved sync logic with play mode detection, suppression, and post-play reconciliation.
- Enhanced plugin UI for sync collision resolution.


## [2.0.9] - 2026-03-27

### Improved

- Enhanced stability and reliability


## [2.0.8] - 2026-03-27

### Improved

- Updated dashboard settings toggles to use switches for clearer controls.
- Improved overall stability across MCP and plugin workflows.
- Fixed an issue where the MCP server could fail to shut down cleanly.


## [2.0.7] - 2026-03-25

### What's New

- Published WEPPY Explorer to VS Code Marketplace and Open VSX Registry. Install directly from your editor's extension marketplace.
- Updated installation guide to reflect new marketplace links for Roblox Explorer.


## [2.0.6] - 2026-03-25

### Improved

- Enhanced overall stability and reliability


## [2.0.5] - 2026-03-24

### Bug Fixes

- resolve sync path resolution errors when launched from filesystem root


## [2.0.4] - 2026-03-24

### Bug Fixes

- Fix deployment script bug.


## [2.0.3] - 2026-03-24

### Bug Fixes

- **Fix install script failures on macOS/Linux**: Resolved a path resolution bug in `install.sh` that caused the installer to fail when the Claude or Cursor config directory did not exist yet. The script now creates the config directory automatically before writing the MCP entry.


## [2.0.2] - 2026-03-24

### Features

- **New one-line installation method**: Install the MCP server and Roblox Studio plugin with a single command. On macOS/Linux run `curl -fsSL https://raw.githubusercontent.com/hope1026/weppy-roblox-mcp/main/install.sh | bash`, on Windows run `irm https://raw.githubusercontent.com/hope1026/weppy-roblox-mcp/main/install.ps1 | iex`. The installer auto-detects the Claude/Cursor config path, injects the MCP entry, and opens the plugin install page in your browser.
- **Dashboard data clearing**: Added clear buttons to the web dashboard for connection history, tool execution history, and sync history. Each section can now be reset independently without restarting the server.
- **Plugin and MCP stability improvements**: Hardened the HTTP polling loop in the Roblox Studio plugin to recover from transient network errors without dropping the connection. The MCP server now retries failed result deliveries and surfaces timeout details in error responses for easier debugging.


## [2.0.1] - 2026-03-22

### Bug Fixes

- Fix setup scripts (`setup-mcp.sh`, `setup-mcp.bat`) failing to resolve MCP server path on Windows and macOS
- Fix project sync directory path resolution when multiple MCP instances share the same workspace


## [2.0.0] - 2026-03-22

### BREAKING CHANGES

- **ZIP users**: Package directory structure has changed. You must re-run `setup-mcp.sh` (or `setup-mcp.bat`). The MCP server path in `.mcp.json` has moved from `mcp-server/index.js` to `plugins/weppy-roblox-mcp/dist/index.js`.

### Highlights

- **Built-in Dashboard**: The MCP server now includes an embedded dashboard. Access it at `http://127.0.0.1:3002/dashboard` — no extra setup required for npm or ZIP installs.
- **Unified deploy structure**: npm, ZIP, and local dev environments all share the same `plugins/weppy-roblox-mcp/dist/index.js` runtime layout.

### Features

- Built-in dashboard with 7 pages: Overview, Connection, Tools, Sync, Changelog, Playtest, Settings
- Multi-language support (en, ko) with auto-detection
- Real-time SSE updates for connection status and license changes
- Unified tool and sync changelog extraction
- Sync apply modes (auto/manual per content type)

### Bug Fixes

- Unified MCP server path across all setup scripts and guides (6 languages)
- Tooltip clipping at viewport edges


## [1.5.5] - 2026-03-16

### Improved

- Enhanced overall stability and reliability


## [1.5.4] - 2026-03-16

### Improved

- Enhanced build pipeline stability and plugin artifact verification
- Improved production build process with additional validation gates

## [1.5.3] - 2026-03-15

### Bug Fixes

- Fix expected cause of playtest stop not working properly on Windows


## [1.5.2] - 2026-03-14

### Improved

- Improved tool invocation reliability and parameter handling
- Enhanced file name sanitization for Windows reserved names, trailing dots/spaces, and control characters

### Bug Fixes

- Fixed Explorer view not displaying instances correctly in certain sync scenarios


## [1.5.1] - 2026-03-14

### Improved

- Overall stability improvements and internal configuration optimization
- Restore tier comparison UI overlay
- Refine telemetry parameters


## [1.5.0] - 2026-03-13

### Features

- Play Test support — run, stop, pause, resume play tests and monitor output directly from AI agents
- Log streaming with incremental cursor-based retrieval (`sinceSeq`)

### Improved

- MCP server stability improvements and license refresh logic refinement
- Plugin connection handling simplified — removed redundant connect-refresh cycle
- Enhanced command routing and error handling


## [1.4.2] - 2026-03-11

### Improved

- MCP server code refactoring for better maintainability
- Enhanced license check logic for improved reliability
- Plugin internal stability improvements


## [1.4.1] - 2026-03-10

### Changed

- Simplify authentication flow — legacy auth paths removed for improved connection reliability

### Improved

- MCP server internal stability and observability improvements
- Plugin internal cleanup and configuration refinements


## [1.4.0] - 2026-03-08

### New Features

- Add Roblox Explorer VSCode extension — browse Studio instance tree directly in VSCode sidebar
  - TreeDataProvider for real-time instance hierarchy visualization
  - Auto-refresh via FileWatcher on sync data changes
  - Icon mapping for Roblox class names (dark/light theme support)
  - Copy instance path, open backing file, reveal in explorer commands

### Improvements

- Refactor MCP server deployment pipeline and build configuration
- Improve camera and terrain sync stability and accuracy
- Enhance plugin UI icons and visual consistency


## [1.3.1] - 2026-03-07

### Improvements

- Improve sync robustness during rapid consecutive file changes
- Enhance incremental change processor to reduce false-positive conflict detection
- Strengthen sync index integrity checks on startup and reconnect
- Improve LRU cache eviction to prevent stale place data after session switch

### Bug Fixes

- Fix sync stall when file watcher emits duplicate events for the same path
- Fix reverse sync occasionally skipping files with identical hashes but different timestamps
- Fix collision suffix (`~N`) not reindexing correctly after instance rename
- Fix sync-init phase hanging when workspace contains deeply nested empty containers

### Documentation

- Restructure README for faster install path (Quick Install and compatibility table at top)
- Add troubleshooting guide
- Add compatibility matrix (supported clients, system requirements, Basic vs Pro)
- Add `llms.txt` for AI crawler discovery
- Add community health files: CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, SUPPORT
- Add GitHub issue templates (bug report, feature request, install help)


## [1.3.0] - 2026-03-06

### Breaking Changes

- Sync file format now uses nested directory structure for all objects — each instance is represented as its own directory (e.g., `Part/Part.props.json` instead of flat files)
- Duplicate sibling instances are now distinguished using `~N` suffix encoding (Odd-Count Tilde Rule) — e.g., `Part~1/`, `Part~2/`, `Part~3/`
- Existing sync data will be regenerated automatically (no migration from v1)

### Improvements

- Enhance sync stability and performance for bidirectional file synchronization
- Improve sync child indexing and collision handling
- Refine analytics tracking for tool usage

### Bug Fixes

- Improve error handling and resilience during MCP tool execution
- Fix license token cache and Pro auth flow issues
- Resolve sync errors on concurrent file changes
- Fix duplicated instance name handling in sync index
- Fix various edge cases in sync change processing

### Plugin

- Improve plugin icons and UI refinements
- Clean up unused files and modules
- General plugin stability improvements


## [1.2.3] - 2026-03-02

Other Changes
-	improved UI, security, and overall stability


## [1.2.2] - 2026-03-01

### Features

- improve sync conflict UI and tier defaults
- update icon paths to use PNG format and enhance file visibility handling
- add IconResolver for managing icons based on Roblox class names
- Add ManualChangesDialog and ManualSyncPopup for handling manual sync changes

### Bug Fixes

- remove dead run_command action from system_info tool


## [1.2.1] - 2026-02-28

### Other Changes

- UI improvements and stability enhancements


## [1.2.0] - 2026-02-26

### Features

- Update documentation and scripts for CommandHandlers structure and verification process
- Implement extended handlers for Roblox Engine API access


## [1.0.3] - 2026-02-24

### Features

- add restoreToken support for license management

### Documentation

- update tool documentation to clarify sync actions and add `progress`

### Chores

- add initial planning and task documents for manifest-driven codegen architecture
- remove unused license server deployment workflow and coverage reports

### Other Changes

- refactor: remove FooterCard module and integrate reset/feedback functionality directly into SettingsTab
- refactor: centralize UI localization handling across MCP tab components


## [1.0.2] - 2026-02-23

### Bug Fixes

- handle blocked devices and improve graceful fallback for Pro license checks

### Documentation

- add script-based installation instructions to setup guides

### Chores

- update `.mcp.json` to use relative path for `mcp-server` startup script

### Other Changes

- update


## [1.0.1] - 2026-02-23

### Other Changes

- refactor: standardize data directory path logic across modules


## [1.0.0] - 2026-02-23

### Sync

- Implement bidirectional sync between Studio and local files
- Add per-type sync direction control for Scripts, Values, Containers, Data, and Services
- Add per-type apply mode (Auto / Manual) per category
- Add Full Sync and Resync with local file preservation option
- Add real-time sync progress tracking and place promotion support
- Add change history with per-change detail view
- Add multi-place sync with LRU cache (max 3 places) and isolated storage per place
- Add reverse rescan to detect missed changes on direction switch
- Add SyncDirectionCard UI with inline descriptions and hover previews
- Add PreSyncDialog for pre-sync confirmation and local file handling
- Refactor sync state management with runtime and default config handling

### MCP Tools

- Add `batch_execute` tool for running multiple commands in one call
- Add `execute_luau` sandbox with stricter service and path blocking
- Add tree mutation support for instance rename and move operations
- Add sibling index support for duplicate-named instances
- Add per-type sync direction and apply mode to `manage_sync` tool
- Add `trackToolCall` with action and error type tracking
- Improve path resolution with robust Roblox path utilities and root confinement

### Stability

- Add comprehensive MCP flow tests and E2E sync test suite
- Enhance dynamic endpoint handling, reconnection logic, and error resilience
- Fix tooltip positioning in widget-local space
- Refactor settings UI with categories and tooltips
- Improve AI client detection and connection info display


## [0.1.11] - 2026-02-14

### Other Changes

- Improve stability


## [0.1.10] - 2026-02-11

### Bug Fixes

- Fix MCP server registration error in Antigravity


## [0.1.9] - 2026-02-08

### Other Changes

- Improve stability


## [0.1.8] - 2026-02-08

### Fix
- Improve stability


## [0.1.3] - 2026-02-07

### Features
- Add tool history and statistics tracking system
- Add version info display in plugin UI


## [0.1.2] - 2026-02-03


## [0.1.0] - 2026-02-03

### Initial Release

First public release of Roblox MCP - AI-powered Roblox Studio integration.

#### Basic

- Create, delete, clone, and move parts and models
- Write and edit scripts with AI assistance
- Change properties like color, size, and position
- Work with selected items in Studio
- Add and manage tags for organization
- Control camera view and focus
- View output logs and debug errors

#### Pro

- Bulk operations - create or modify hundreds of objects at once
- Search and insert models from Creator Store
- Environment controls - lighting, weather, time of day
- Terrain generation and modification
- Find spawn positions and empty spaces with raycasting
- Visual debugging with area markers and highlights

#### Highlights

- **Real-time Studio control** - AI commands execute instantly in Roblox Studio
- **Works with popular AI apps** - Claude, Codex CLI, Gemini CLI, and more
- **Secure by design** - Localhost only, no external network access
- **Basic tier included** - Essential tools, free forever

[0.1.0]: https://github.com/hope1026/weppy-roblox-mcp/releases/tag/v0.1.0

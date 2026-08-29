# Playtest Reference

Use playtest actions when verifying runtime behavior, collecting logs, or creating dashboard-linked test reports.

## Control Flow

- `manage_studio.play_status`: check whether Studio is in edit, running, or paused state.
- `manage_studio.play_start`: start a playtest. `mode="play"` maps to F5 and `mode="run"` maps to F8.
- `manage_studio.play_pause`: pause a running playtest.
- `manage_studio.play_resume`: resume a paused playtest.
- `manage_studio.play_stop`: stop a playtest.
- `manage_studio.test_session_start`: start a structured test session. It defaults to Play mode and one client.
- `manage_studio.test_session_status`: read bounded progress and step evidence without copying the full result.
- `manage_studio.test_session_stop`: cancel a structured session and request teardown.
- `manage_studio.run_test`: use the legacy `executionKind="raw_luau"` path as an explicit advanced diagnostic opt-in.

## Locale Test Environment

Player Emulator settings and the in-experience language are separate capabilities.

- `manage_studio.test_profile_get`: inspect whether the selected Studio target exposes a public Player Emulator profile provider and, when available, read its effective profile.
- `manage_studio.test_profile_set`: request a persistent Player Emulator profile patch.
- `manage_studio.test_profile_reset`: restore the WEPPY baseline saved before the first successful profile mutation.
- `manage_studio.experience_language_get`: observe the active player's Translator locale. The response keeps Player, CoreGui, system, and country-region values in separate fields.
- `manage_studio.experience_language_set`: request an Experience Language change through an explicitly enabled desktop adapter and verify it through the player Translator.

The stable plugin does not use private Player Emulator services or CoreGui input automation. When no public profile provider or opted-in language adapter is available, set operations return structured `test_profile_manual_required` or `experience_language_manual_required` failures. Do not treat requested values as applied values.

`manage_studio.play_start`, `manage_studio.test_session_start`, and `manage_studio.run_test` accept an optional `testProfile` patch and `restoreAfterTest`. Profile application must succeed before play starts. With restoration enabled, the selected Studio target's snapshot is restored on success, error, timeout, or cancellation. Use `manage_studio.play_status` to inspect `activeTestProfileResult` and `lastTestProfileResult` for a manually started play session.

Read `mcp-actions.md` for exact params and tiers.

## Structured Test Session

For ordinary runtime verification, use `test_session_start`. It defaults to Play mode with one client. The scenario is JSON-compatible data, runs sequential steps, and never carries a Luau function body. Choose Run only for an explicit server-only scenario.

Poll `test_session_status` with the returned `sessionId`. The default page contains at most 20 step entries; `stepLimit` cannot exceed 50. Use the opaque `stepCursor` for the next page. Call `test_session_stop` to cancel a non-terminal session.

For UI interaction checks, wait for the target UI, capture semantic UI structure and geometry, then use VirtualInput. Keep input delivery and `GuiButton.Activated` observation as separate evidence, and verify server effects in a separate server step. Play-mode screenshot capture is not supported, so do not substitute screenshot evidence for semantic UI or interaction evidence.

## Legacy Raw Luau Runner

`manage_studio.run_test` requires `script` and represents the Raw Luau explicit advanced diagnostic opt-in. Optional fields include `mode`, `test_name`, `timeout`, `testProfile`, `restoreAfterTest`, `contextId`, `contextSummary`, and `replayMetadata`.

The runner wraps the user script, emits `[WEPPY_TEST]` log signals, collects `manage_logs` output, stops playtest during cleanup, and stores report artifacts under the active place test directory.

## Screenshot Limitation

`manage_camera.screenshot` is Edit-mode only. If unsure, call `manage_studio.play_status` first and proceed only when the state is edit. Play-mode screenshot capture is not supported in this build.

## Sync Interaction

Play mode suppresses sync updates. Do not start full sync during play mode. After play exits, sync performs post-play reconciliation before normal incremental sync resumes.

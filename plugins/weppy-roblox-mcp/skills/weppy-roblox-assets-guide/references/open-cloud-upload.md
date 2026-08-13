# Open Cloud Upload Reference

1. Choose `scope="place"` for the current game or `scope="shared"` for project-wide reuse. Place scope uses the current runtime Place ID unless `placeId` is provided and fails before upload when no Place is available.
2. Call `manage_open_cloud_assets.preflight` to check the upload toggle, credential authentication, Assets Read/Write, Creator target, and optional file readiness without uploading.
3. Call `manage_open_cloud_assets.credential_status` only when credential profile metadata is also needed, without exposing the raw API key.
4. Call `manage_open_cloud_assets.capabilities` and confirm the file extension and category pair.
5. Confirm Creator type and ID, ownership intent, and expected upload fee when required.
6. Use `manage_open_cloud_assets.upload` for a new remote asset. It copies the source into the selected Asset Library scope, tracks upload or processing state, and returns the stable Asset Library ID with Roblox metadata.
7. Use `manage_open_cloud_assets.link` when a non-Decal Roblox asset already exists. It verifies the remote asset and connects the existing ID to the local source without another upload. The link action rejects Decal wrapper IDs because the Asset Library requires the backing Image asset ID. Do not call `upload` to backfill an existing ID.
8. Use `manage_open_cloud_assets.update` only when the user explicitly asks to change an existing asset ID.
9. Use `manage_open_cloud_assets.operation_status` when a standalone operation must be checked. The Dashboard also resumes bounded status refresh for Asset Library items that remain in processing.
10. Verify `assetLibraryAssetId`, Roblox asset ID and URI, operation status, Creator, scope, and the preserved local source.

The Dashboard lists local Asset Library items, not every asset owned by the Roblox user or group. WEPPY does not expose remote Roblox asset deletion, archive, or restore actions. Never pass a raw API key in tool parameters, logs, or skill output.

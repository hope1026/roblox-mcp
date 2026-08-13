# Asset Library Reference

Use Asset Library for local, inspectable asset round-trips.

1. Choose `scope="place"` unless the user explicitly needs a shared asset.
2. Export a selection or Studio path with `manage_assets.export_selection_rbxm` or `manage_assets.export_path_rbxm`.
3. Use `manage_assets.review_model` before registration when model structure or bounds matter.
4. Use `manage_assets.generate_thumbnail` for an existing Asset Library RBXM item.
5. Use `manage_assets.import_rbxm` to place the reviewed item back into Studio.
6. Verify `assetLibraryAssetId`, scope, Place ID, source path, and imported Studio path.

`manage_open_cloud_assets.upload` automatically copies its local source into the selected Asset Library scope and records the Roblox upload lifecycle on that item. Use `manage_open_cloud_assets.link` to register an existing non-Decal Roblox asset ID with a local source without creating a duplicate remote asset. Decal wrapper IDs cannot be linked because the Asset Library requires the backing Image asset ID.

The Dashboard lists these local Asset Library items. It does not query the complete Roblox inventory for a user or group.

Local Asset Library deletion removes only the Asset Library-owned local item. It never means remote Roblox asset deletion.

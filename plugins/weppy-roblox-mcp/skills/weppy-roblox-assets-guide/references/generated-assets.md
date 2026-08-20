# Generated Assets Reference

For AI-generated image files, first confirm that the calling agent has both a callable image generation tool and a local image output channel. Do not infer this capability from a model or client name. If either capability is unavailable or remains unknown, use a user reference, reviewed project asset, Creator Store candidate, or assetless fallback.

Local image generation and Roblox upload require separate approval. The first approval authorizes only the bounded local image batch described to the user. Present those local outputs for selection. Before any remote mutation, run the upload preflight and obtain a second approval that names the selected files, asset count, and target Creator. Generation approval alone never authorizes Roblox upload.

After approval, save a supported local image, then choose Studio-local or Open Cloud upload according to the requested owner and workflow. `manage_open_cloud_assets.upload` registers its stable local copy in the selected Asset Library scope. Use `manage_open_cloud_assets.link` instead when the image already has a Roblox asset ID.

For Roblox model generation:

1. Call `manage_assets.generate_model` with a prompt, schema mode, target parent, and review policy.
2. Treat the result as a Studio model path, not an Asset Library item or remote Roblox asset.
3. Run `manage_assets.review_model` when the model must be checked or registered locally.
4. Ask before any temporary embedded-resource upload or remote upload.
5. Verify the model path, bounds or review result, generated textures, and any returned Roblox asset IDs.

Do not invent image, mesh, texture, or model asset IDs.

# UI Studio Reference

Use UI Studio for Roblox `StarterGui` work instead of hand-rolling many GUI mutations.

## Runtime Resources

Before creating or redesigning UI, read `weppy://ui-studio/guide`. Read `weppy://ui-studio/tokens` for optional palette, spacing, typography, motion, imagery, and composition examples. Read `weppy://ui-studio/functional-rules` when interpreting deterministic findings, evidence fields, profile context, and non-finding boundaries. Treat these runtime resources as the current guidance; use this reference for the action sequence and safety gates.

## Product Loop

1. Read the governing UI/game spec, project UI manifest, token source, and approved asset manifest. Build visual direction from explicit user intent plus game and project evidence. Pass relevant evidence in `projectContext`; do not ask the Studio plugin to guess repository facts.
2. Start with `manage_ui.design_brief`. It may accept no brief, a partial brief, or a complete brief.
   Keep the accepted `brief_id`, `design_contract`, and advisory `layout_plan` through create, update, preview, and check. The contract uses `quality_priority=primary_view_first`, identifies the primary profile, and records whether responsive review is recommended or required. Treat role, placement, flow, surface, avoid-region, wrap, region anchors, and responsive behaviors as evidence-backed guidance, not a hard tree preset. An explicit user layout choice outranks project evidence, existing UI, and WEPPY fallback. For an existing target, follow the analysis-first redesign or targeted-update scope returned by `design_brief`.
3. Inspect callable image tools and the local output channel, then pass provider-neutral `agentCapabilities`. Do not infer support from a model or client name, and never include provider credentials in evidence.
4. If the response is `brief_incomplete`, use its complete first recommendation or next question to fill missing intent. Do not dump enum lists at the user. The recommendation is non-blocking and can be accepted, edited, skipped, or replaced.
5. If asset recommendations are returned with status `recommended`, ask the user before using them. A `project_asset` candidate outranks an existing UI asset and Creator Store search. If `imagery_strategy.intent=required`, a placeholder keeps primary visual approval ineligible until a concrete role asset is resolved. If `asset_generation_proposal` is unavailable or unknown, continue with its existing-asset or assetless fallback and report required imagery as unresolved.
6. When generated imagery is recommended, ask for bounded local image generation first. Present the local result before a separate Roblox upload approval that names files, count, and target Creator.
7. Create new UI with `manage_ui.create_tree` or update existing UI with `manage_ui.update`.
   For meaningful region roots, pass optional `layoutMetadata` with the `surfaceRole`, `placementBand`, `surfaceMode`, and `decisionSource` returned by the Layout Plan.
8. Run `manage_ui.preview` after creation or meaningful changes. Inspect the representative primary-view screenshot against the reference evidence and Design Contract.
9. Run `manage_ui.check`. The calling agent submits `visualReview` with the exact saved `snapshotId`, a non-empty critic summary, and one verdict: `recompose | refine | approved`. Recompose when the presentation or composition is wrong; refine when the direction is sound but needs another pass; approve only when the representative view is visually complete and required imagery is resolved. Repeat create/update → preview → critic until the verdict is approved or an unresolved dependency is reported.
   Set `reviewContext.interactionStatesReviewed=true` when the reviewed evidence covers the required hover, focus, pressed, and disclosure states. Set `reviewContext.gameplayContextReviewed=true` only when the evidence includes representative gameplay or a reviewable gameplay focal region from the Design Contract. Leave either value false when that evidence is missing and report the matching `skipped_reasons`.
10. Read `primary_visual_verdict`, `functional_safe`, `responsive_requirement`, `responsive_ready`, `required_dimensions`, and `readiness` separately from mutation success. Primary visual and functional safety are always required. Responsive evidence blocks readiness only when `responsive_requirement=required`; recommended responsive work remains visible without blocking an otherwise approved primary UI.
    `structural_only` means visual hierarchy and identity were not fully reviewed; do not call zero findings a complete visual pass when `visual_status` is `not_requested` or `skipped`.
    Preserve the preview sidecar's AnchorPoint, UDim2, constraints, target profile, simulator result, and Design Check context when reviewing responsive evidence.
11. Treat every UI quality finding as advisory. `priority_high` is reserved for observed functional failures such as unreadable content, meaningful overlap, invalid visual geometry, or primary-view occlusion. Style-only hierarchy and identity findings stay medium or low. Technical schema and safety gates can fail a request, but quality findings do not block UI creation or updates.

## Tree Encoding

- Root should be `ScreenGui`.
- Omit `parent` to place under `StarterGui`.
- `targetPath` accepts both `StarterGui.MyGui` and `game.StarterGui.MyGui`.
- `UDim2`: `{xScale, xOffset, yScale, yOffset}`
- `UDim`: `{scale, offset}`
- `Color3`: `{r, g, b}`
- Enum values: item name string.
- Modern tree classes include `UIScale`, `UIFlexItem`, `UIShadow`, `UIPageLayout`, `UITableLayout`, `CanvasGroup`, and `UIDragDetector`.

## Quality Rules

- Keep primary text readable and primary controls touchable.
- A transparent interaction target can contain a smaller painted visual surface. Measure spacing between hit areas, keep the visible affordance recognizable, and collapse secondary mobile actions instead of inflating every painted button.
- A readable, localized word embedded in an icon asset can serve as its visible label; do not duplicate embedded action text with adjacent text. Otherwise give ambiguous controls a touch-visible, focus-visible, or contextual explanation path.
- Distinguish action controls from status and data surfaces through role, affordance, and state feedback. Choose one interaction family that fits the brief. Intentional flat controls are valid when their action role and input states remain clear.
- Keep bounded non-modal surfaces away from the gameplay focal region with edge placement, condensation, or contextual hiding. Do not enforce one screen-occupancy percentage.
- Use a transparent group root for non-modal HUD regions and keep opaque chrome within the local bounds of readable controls or information. Contract-backed modal, fullscreen, and diegetic presentations may use a backdrop.
- Map `persistent_status` and `resource_display` to compact top-edge regions, `navigation` to a side rail or top edge, `slot_action` to a bottom-center single-row flow only for real slot semantics, `contextual_action` to a transient lower-center or target-relative control, and `objective_tracker` to a collapsible side-edge group.
- On touch profiles, keep a `slot_action` bar between touch-left and touch-right reserved regions. Preserve explicit user placement or surface choices and report only observed functional risks.
- Account for Roblox safe-area properties such as `ScreenInsets`, `IgnoreGuiInset`, `ClipToDeviceSafeArea`, `SafeAreaCompatibility`, `UIScale`, `UIAspectRatioConstraint`, `UISizeConstraint`, and `UITextSizeConstraint`.
- Do not enforce one visual style. Minimal, ornate, retro, cute, horror, simulator-like, flat, immersive, or no-imagery UI can all be valid when coherent with the brief.
- Do not invent asset IDs. Use user-provided references or accepted asset search results.

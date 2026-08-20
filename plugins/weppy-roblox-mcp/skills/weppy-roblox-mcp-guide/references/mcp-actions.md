# WEPPY Roblox MCP Action Reference

<!-- AUTO-GENERATED from tool-codegen/tools.yaml and tool-codegen/tools/*.yaml. DO NOT EDIT. -->

Use this reference for exact MCP tool/action names, tiers, routes, aliases, and parameters. Public marketing copy must not reuse this raw action dump.

## Tool: `query_instances`

Query Roblox instances: get, children, find child/descendant, wait for child, class info, search by name/class. [PRO] file_tree, project_structure, descendants, ancestors, search by property/tag.

### `query_instances.get`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to query (e.g., "game.Workspace.Part"). Used by: get, children, find_child, find_descendant, wait_for_child, descendants, ancestors.
- Optional params:
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for resolving duplicate-named path targets. Used by: get, children, descendants, ancestors.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for resolving duplicate-named path targets. Used by: get, children, descendants, ancestors.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.children`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to query (e.g., "game.Workspace.Part"). Used by: get, children, find_child, find_descendant, wait_for_child, descendants, ancestors.
- Optional params:
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for resolving duplicate-named path targets. Used by: get, children, descendants, ancestors.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for resolving duplicate-named path targets. Used by: get, children, descendants, ancestors.
  - `recursive` - boolean - If true, returns all descendants instead of just immediate children. Used by: children. Default: false.
  - `maxDepth` - number - Maximum depth for recursive traversal. Used by: children (default: 10), file_tree (default: 5).
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.find_child`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to query (e.g., "game.Workspace.Part"). Used by: get, children, find_child, find_descendant, wait_for_child, descendants, ancestors.
  - `childName` - string - Name of the child instance to find. Used by: find_child, wait_for_child.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.find_descendant`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to query (e.g., "game.Workspace.Part"). Used by: get, children, find_child, find_descendant, wait_for_child, descendants, ancestors.
  - `descendantName` - string - Name of the descendant instance to find. Used by: find_descendant.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.wait_for_child`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to query (e.g., "game.Workspace.Part"). Used by: get, children, find_child, find_descendant, wait_for_child, descendants, ancestors.
  - `childName` - string - Name of the child instance to find. Used by: find_child, wait_for_child.
- Optional params:
  - `timeout` - number - Maximum time to wait in seconds. Used by: wait_for_child. Default: 5. Maximum: 30.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.class_info`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `className` - string - Roblox class name. Used by: find_child/find_descendant (optional filter), class_info (required), search_class (required).
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.search_name`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `query` -> `pattern`
- Required params:
  - `query` - string - Search pattern for name search (supports * and ? wildcards). Used by: search_name.
- Optional params:
  - `root` - string - Root path to search/scan from. Used by: search_name, search_class, search_property, search_tag, file_tree, project_structure. Default: "game".
  - `caseSensitive` - boolean - Case-sensitive name search. Used by: search_name. Default: false.
  - `maxResults` - number - Maximum results to return. Used by: search_name, search_class, search_property, search_tag, descendants. Default: 100.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.search_class`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `className` - string - Roblox class name. Used by: find_child/find_descendant (optional filter), class_info (required), search_class (required).
- Optional params:
  - `root` - string - Root path to search/scan from. Used by: search_name, search_class, search_property, search_tag, file_tree, project_structure. Default: "game".
  - `includeSubclasses` - boolean - Include subclasses in class search (e.g., BasePart finds Part, MeshPart). Used by: search_class. Default: true.
  - `maxResults` - number - Maximum results to return. Used by: search_name, search_class, search_property, search_tag, descendants. Default: 100.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.search_property`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `root` -> `rootPath`
- Required params:
  - `propertyName` - string - [PRO] Property name to search by. Used by: search_property.
- Optional params:
  - `root` - string - Root path to search/scan from. Used by: search_name, search_class, search_property, search_tag, file_tree, project_structure. Default: "game".
  - `propertyValue` - unknown - [PRO] Property value to match. Used by: search_property.
  - `maxResults` - number - Maximum results to return. Used by: search_name, search_class, search_property, search_tag, descendants. Default: 100.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.search_tag`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `root` -> `rootPath`
- Required params:
  - `tag` - string - [PRO] Tag string to search by (case-sensitive). Used by: search_tag.
- Optional params:
  - `root` - string - Root path to search/scan from. Used by: search_name, search_class, search_property, search_tag, file_tree, project_structure. Default: "game".
  - `maxResults` - number - Maximum results to return. Used by: search_name, search_class, search_property, search_tag, descendants. Default: 100.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.file_tree`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `maxDepth` - number - Maximum depth for recursive traversal. Used by: children (default: 10), file_tree (default: 5).
  - `root` - string - Root path to search/scan from. Used by: search_name, search_class, search_property, search_tag, file_tree, project_structure. Default: "game".
  - `includeServices` - boolean - [PRO] Include Roblox services when root is "game". Used by: file_tree. Default: true.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.project_structure`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `root` -> `rootPath`
- Required params: none
- Optional params:
  - `root` - string - Root path to search/scan from. Used by: search_name, search_class, search_property, search_tag, file_tree, project_structure. Default: "game".
  - `depth` - number - [PRO] Maximum depth for project structure traversal. Used by: project_structure. Default: 3.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.descendants`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to query (e.g., "game.Workspace.Part"). Used by: get, children, find_child, find_descendant, wait_for_child, descendants, ancestors.
- Optional params:
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for resolving duplicate-named path targets. Used by: get, children, descendants, ancestors.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for resolving duplicate-named path targets. Used by: get, children, descendants, ancestors.
  - `maxResults` - number - Maximum results to return. Used by: search_name, search_class, search_property, search_tag, descendants. Default: 100.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `query_instances.ancestors`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to query (e.g., "game.Workspace.Part"). Used by: get, children, find_child, find_descendant, wait_for_child, descendants, ancestors.
- Optional params:
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for resolving duplicate-named path targets. Used by: get, children, descendants, ancestors.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for resolving duplicate-named path targets. Used by: get, children, descendants, ancestors.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `mutate_instances`

Create, delete, clone, move, rename, or pivot instances. [PRO] create_tree, mass_create, mass_delete, mass_duplicate, smart_duplicate, scatter.

### `mutate_instances.create`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `className` - string - Roblox class name (e.g., Part, Script, Folder). Used by: create, create_with_props.
  - `parent` - string - Parent path for new instance. Used by: create, create_with_props.
- Optional params:
  - `name` - string - Name for the instance. Used by: create (optional), create_with_props (required).
  - `properties` - object - Properties to set on the instance. Supports Vector3, Color3, CFrame, UDim2, Enum types. Used by: create (optional), create_with_props (required).
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.create_with_props`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `className` - string - Roblox class name (e.g., Part, Script, Folder). Used by: create, create_with_props.
  - `parent` - string - Parent path for new instance. Used by: create, create_with_props.
  - `name` - string - Name for the instance. Used by: create (optional), create_with_props (required).
  - `properties` - object - Properties to set on the instance. Supports Vector3, Color3, CFrame, UDim2, Enum types. Used by: create (optional), create_with_props (required).
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.delete`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to operate on. Used by: delete, clone (as sourcePath), move, rename, pivot, smart_duplicate.
- Optional params:
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.clone`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `path` -> `sourcePath`
- Required params:
  - `sourcePath` - string - Source instance path to clone from. Used by: clone. Alternative to path.
- Optional params:
  - `path` - string - Instance path to operate on. Used by: delete, clone (as sourcePath), move, rename, pivot, smart_duplicate.
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `targetParent` - string - Target parent for cloned/duplicated instances. Used by: clone, mass_duplicate, smart_duplicate.
  - `newName` - string - New name for instance. Used by: rename (required), clone (optional).
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.move`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to operate on. Used by: delete, clone (as sourcePath), move, rename, pivot, smart_duplicate.
  - `newParent` - string - New parent path to move instance to. Used by: move.
- Optional params:
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.rename`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to operate on. Used by: delete, clone (as sourcePath), move, rename, pivot, smart_duplicate.
  - `newName` - string - New name for instance. Used by: rename (required), clone (optional).
- Optional params:
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.pivot`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to operate on. Used by: delete, clone (as sourcePath), move, rename, pivot, smart_duplicate.
- Optional params:
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `position` - object - Target position as Vector3 {x, y, z}. Used by: pivot.
  - `cframe` - array<number> - Target CFrame as 12-number array [x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22]. Used by: pivot.
  - `offset` - object - Relative offset to move by (ignores position/cframe). Used by: pivot, smart_duplicate.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.create_tree`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `parent` - string - Parent path for new instance. Used by: create, create_with_props.
  - `tree` - object - [PRO] Instance tree specification for hierarchical creation. Used by: create_tree.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.mass_create`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `instances` - array<object> - [PRO] Array of instance specifications for batch creation. Used by: mass_create. Each item: {className, name, parentPath, properties?}.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.mass_delete`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `paths` - array<string> - [PRO] Array of instance paths. Used by: mass_delete, mass_duplicate.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.mass_duplicate`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `paths` - array<string> - [PRO] Array of instance paths. Used by: mass_delete, mass_duplicate.
- Optional params:
  - `targetParent` - string - Target parent for cloned/duplicated instances. Used by: clone, mass_duplicate, smart_duplicate.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.smart_duplicate`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `spacing` -> `offset`
- Required params:
  - `path` - string - Instance path to operate on. Used by: delete, clone (as sourcePath), move, rename, pivot, smart_duplicate.
  - `offset` - object - Relative offset to move by (ignores position/cframe). Used by: pivot, smart_duplicate.
- Optional params:
  - `sessionDebugId` - string - Optional same Studio/plugin session debug identity for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `siblingIndex` - number - Optional 1-based same-name sibling index fallback for verifying a duplicate-named target. Used by: delete, clone, move, rename, pivot, smart_duplicate.
  - `targetParent` - string - Target parent for cloned/duplicated instances. Used by: clone, mass_duplicate, smart_duplicate.
  - `count` - number - [PRO] Number of copies to create. Used by: smart_duplicate, scatter.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `mutate_instances.scatter`

clone template instances onto natural ground positions in a region: ray-snapped to the surface, slope and water filters, yaw rotation and scale jitter, minimum spacing, deterministic seed, grouped under one Folder.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `templatePaths` - array<string> - Template instance paths to clone. Used by: scatter. Multiple templates are picked uniformly at random.
  - `region` - object - Placement region {min, max} in world studs (XZ used for sampling, Y bounds the ground raycast). Used by: scatter.
  - `count` - number - [PRO] Number of copies to create. Used by: smart_duplicate, scatter.
- Optional params:
  - `seed` - number - Deterministic placement seed. Used by: scatter.
  - `maxSlope` - number - Maximum ground slope in degrees for placement. Used by: scatter. Default: 30.
  - `avoidWater` - boolean - Skip points whose ground is Water. Used by: scatter. Default: true.
  - `alignToNormal` - boolean - Align instances to the surface normal (yaw jitter always applies). Used by: scatter. Default: false.
  - `scaleJitter` - object - Uniform scale jitter range. Used by: scatter. Default: {min: 0.85, max: 1.25}.
  - `minSpacing` - number - Minimum distance between placements in studs. Used by: scatter.
  - `parentName` - string - Folder name that groups the results. Used by: scatter. Default: WeppyScatter_<seed>.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_properties`

Get/set properties, attributes, and tags on instances. [PRO] set_calculated, set_relative, mass_set, mass_get, modify_children.

### `manage_properties.get`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `property` - string - Property name (e.g., "Size", "Position", "Anchored"). Used by: get, set.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.set`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `property` - string - Property name (e.g., "Size", "Position", "Anchored"). Used by: get, set.
  - `value` - unknown - Value to set. Supports primitives, Vector3 {x,y,z}, Color3 {r,g,b} (0-255), CFrame (12-number array), UDim2 {xScale,xOffset,yScale,yOffset}, Enum strings. Used by: set, set_attr, set_relative.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.get_all`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
- Optional params:
  - `includeReadOnly` - boolean - Include read-only properties. Used by: get_all. Default: false.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.set_multiple`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `properties` - object - Dictionary of property names to values. Used by: set_multiple.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.get_attr`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `attribute` - string - Attribute name. Used by: get_attr, set_attr, delete_attr.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.set_attr`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `value` - unknown - Value to set. Supports primitives, Vector3 {x,y,z}, Color3 {r,g,b} (0-255), CFrame (12-number array), UDim2 {xScale,xOffset,yScale,yOffset}, Enum strings. Used by: set, set_attr, set_relative.
  - `attribute` - string - Attribute name. Used by: get_attr, set_attr, delete_attr.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.get_all_attrs`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.delete_attr`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `attribute` - string - Attribute name. Used by: get_attr, set_attr, delete_attr.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.add_tag`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `tag` - string - Tag string (case-sensitive). Used by: add_tag, remove_tag, check_tag.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.remove_tag`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `tag` - string - Tag string (case-sensitive). Used by: add_tag, remove_tag, check_tag.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.check_tag`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `tag` - string - Tag string (case-sensitive). Used by: add_tag, remove_tag, check_tag.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.get_tags`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.get_tagged`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `tagName` -> `tag`
  - `root` -> `rootPath`
- Required params:
  - `tagName` - string - Tag to search for. Used by: get_tagged.
- Optional params:
  - `root` - string - Root path to filter get_tagged results. Used by: get_tagged.
  - `maxResults` - number - Maximum results for get_tagged. Default: 100.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.set_calculated`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `expression` - string - [PRO] Mathematical expression to evaluate. Used by: set_calculated. Example: "baseValue * multiplier".
  - `propertyName` - string - [PRO] Property name for mass operations or set_calculated/set_relative. Used by: mass_set, mass_get, set_calculated, set_relative, modify_children.
- Optional params:
  - `variables` - object - [PRO] Variable name to value/path mapping. Used by: set_calculated. Example: {"baseValue": "workspace.Config.BaseValue", "multiplier": 2}.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.set_relative`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `amount` -> `value`
- Required params:
  - `path` - string - Instance path. Used by: get, set, get_all, set_multiple, get_attr, set_attr, get_all_attrs, delete_attr, add_tag, remove_tag, check_tag, get_tags, set_calculated, set_relative.
  - `operation` - "add" | "subtract" | "multiply" | "divide" - [PRO] Mathematical operation for relative property change. Used by: set_relative.
  - `propertyName` - string - [PRO] Property name for mass operations or set_calculated/set_relative. Used by: mass_set, mass_get, set_calculated, set_relative, modify_children.
- Optional params:
  - `value` - unknown - Value to set. Supports primitives, Vector3 {x,y,z}, Color3 {r,g,b} (0-255), CFrame (12-number array), UDim2 {xScale,xOffset,yScale,yOffset}, Enum strings. Used by: set, set_attr, set_relative.
  - `amount` - unknown - [PRO] Value for relative operation. Can be number, Vector3, etc. Used by: set_relative. Alias for value in set_relative context.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.mass_set`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `paths` - array<string> - [PRO] Array of instance paths for bulk operations. Used by: mass_set, mass_get.
  - `propertyName` - string - [PRO] Property name for mass operations or set_calculated/set_relative. Used by: mass_set, mass_get, set_calculated, set_relative, modify_children.
  - `propertyValue` - unknown - [PRO] Property value for mass_set and modify_children.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.mass_get`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `paths` - array<string> - [PRO] Array of instance paths for bulk operations. Used by: mass_set, mass_get.
  - `propertyName` - string - [PRO] Property name for mass operations or set_calculated/set_relative. Used by: mass_set, mass_get, set_calculated, set_relative, modify_children.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_properties.modify_children`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `parentPath` - string - [PRO] Parent path whose children will be modified. Used by: modify_children.
- Optional params:
  - `modifications` - object - [PRO] Properties to set on children. Used by: modify_children. Contains propertyName, propertyValue, filter, recursive.
  - `propertyName` - string - [PRO] Property name for mass operations or set_calculated/set_relative. Used by: mass_set, mass_get, set_calculated, set_relative, modify_children.
  - `propertyValue` - unknown - [PRO] Property value for mass_set and modify_children.
  - `filter` - string - [PRO] Class name filter for modify_children.
  - `recursive` - boolean - [PRO] Modify all descendants, not just immediate children. Used by: modify_children. Default: false.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_scripts`

Manage script source code: read, write, create, delete, edit lines, search, and validate Luau syntax. [PRO] replace across scripts.

### `manage_scripts.get_source`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
- Optional params:
  - `startLine` - number - Starting line number, 1-based inclusive. Used by: get_source (paired with endLine), edit_replace, edit_delete. get_source requires an integer.
  - `endLine` - number - Ending line number, 1-based inclusive. Used by: get_source (paired with startLine), edit_replace, edit_delete. get_source requires an integer.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.set_source`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
  - `source` - string - Script source code. Used by: set_source (required), create (optional initial source), validate (one of source or path is required).
- Optional params:
  - `validate` - boolean - Requests full validation details when Dashboard script write validation is enabled. Used by: set_source, edit_replace, edit_insert, edit_delete.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.create`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `scriptType` - "Script" | "LocalScript" | "ModuleScript" - Type of script to create. Used by: create.
  - `parent` - string - Parent path for new script. Used by: create.
- Optional params:
  - `source` - string - Script source code. Used by: set_source (required), create (optional initial source), validate (one of source or path is required).
  - `name` - string - Name for new script. Used by: create.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.delete`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.edit_replace`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `newLines` -> `newContent`
- Required params:
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
  - `startLine` - number - Starting line number, 1-based inclusive. Used by: get_source (paired with endLine), edit_replace, edit_delete. get_source requires an integer.
  - `endLine` - number - Ending line number, 1-based inclusive. Used by: get_source (paired with startLine), edit_replace, edit_delete. get_source requires an integer.
  - `newLines` - string - New content to replace specified lines. Used by: edit_replace. Can be multi-line.
- Optional params:
  - `validate` - boolean - Requests full validation details when Dashboard script write validation is enabled. Used by: set_source, edit_replace, edit_insert, edit_delete.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.edit_insert`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `lines` -> `content`
- Required params:
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
  - `afterLine` - number - Line number after which to insert. Used by: edit_insert. Use 0 to insert at beginning.
  - `content` - string - Content to insert. Used by: edit_insert. Can be multi-line.
- Optional params:
  - `lines` - string - Content to insert after afterLine. Used by: edit_insert. Can be multi-line. Alias for content.
  - `validate` - boolean - Requests full validation details when Dashboard script write validation is enabled. Used by: set_source, edit_replace, edit_insert, edit_delete.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.edit_delete`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
  - `startLine` - number - Starting line number, 1-based inclusive. Used by: get_source (paired with endLine), edit_replace, edit_delete. get_source requires an integer.
  - `endLine` - number - Ending line number, 1-based inclusive. Used by: get_source (paired with startLine), edit_replace, edit_delete. get_source requires an integer.
- Optional params:
  - `validate` - boolean - Requests full validation details when Dashboard script write validation is enabled. Used by: set_source, edit_replace, edit_insert, edit_delete.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.search`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
  - `pattern` - string - Search pattern (plain text or Lua pattern). Used by: search, replace.
- Optional params:
  - `caseSensitive` - boolean - Case-sensitive search. Used by: search. Default: false.
  - `wholeWord` - boolean - Match whole words only. Used by: search. Default: false.
  - `usePattern` - boolean - Treat pattern as Lua pattern instead of plain text. Used by: search, replace. Default: false.
  - `maxResults` - number - Maximum results to return. Used by: search. Default: 100.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.replace`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `pattern` -> `searchPattern`
- Required params:
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
  - `pattern` - string - Search pattern (plain text or Lua pattern). Used by: search, replace.
  - `replacement` - string - [PRO] Replacement text. Used by: replace.
- Optional params:
  - `usePattern` - boolean - Treat pattern as Lua pattern instead of plain text. Used by: search, replace. Default: false.
  - `dryRun` - boolean - [PRO] Show what would be replaced without making changes. Used by: replace. Default: false.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.get_dependencies`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_scripts.validate`

validate raw Luau source or an existing Script path without starting a playtest.

- Tier: `basic`
- Route: `internal`
- Execution mode: `readonly`
- Param aliases: none
- Required params: none
- Optional params:
  - `source` - string - Script source code. Used by: set_source (required), create (optional initial source), validate (one of source or path is required).
  - `path` - string - Path to the script instance. Used by: get_source, set_source, delete, edit_replace, edit_insert, edit_delete, search, get_dependencies, replace, validate.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_ui`

Create / update / verify Roblox in-game UI (ScreenGui / Frame / TextLabel / …). Always start with `design_brief`. For ambiguous input, it inspects Studio context and returns candidate brief patches; Do not dump enum lists at the user. Pass relevant repository evidence in `projectContext`; explicit screen job, visual thesis, forbidden defaults, tokens, and approved assets determine the direction without a built-in subject preset. `design_brief` returns a primary-view-first Design Contract and an advisory Layout Plan with neutral regions, AnchorPoint strategy, and responsive behavior; it is not a hard tree preset or style quota. A calling agent may declare provider-neutral image generation capability through `agentCapabilities`; missing or unavailable capability must use the explicit existing, user-provided, Creator Store, or assetless fallback. Keep the returned `brief_id`, `design_contract`, and `layout_plan` through creation, update, preview, and check. The asset recommendation gate considers user references, project assets, existing UI, and user-approved `manage_assets.search` intent; do not use a recommendation until the user accepts it. After each meaningful create or update, preview the representative primary view and submit a calling-agent critic verdict (`recompose`, `refine`, or `approved`) with `visualReview`. Read `primary_visual_verdict`, `functional_safe`, `responsive_requirement`, `responsive_ready`, `required_dimensions`, and `readiness` separately from mutation success. Responsive evidence blocks readiness only when the Design Contract marks it required. Read `weppy://ui-studio/guide` for the authoring workflow, `weppy://ui-studio/tokens` for optional visual examples, and `weppy://ui-studio/functional-rules` for machine-readable advisory evidence rules. Design Check permits `priority_high` only for observed functional visual failures such as meaningful overlap, unreadable content, invalid geometry, or primary-view occlusion; style-only findings remain medium or low.

### `manage_ui.design_brief`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `brief` - object - 완성 또는 부분 design_brief 구조체. Used by: design_brief (optional; partial allowed).
  - `projectContext` - object - Optional project-specific design evidence used by design_brief. Explicit user and experience evidence determines recommendations; WEPPY does not infer a subject preset.
  - `agentCapabilities` - object - Optional provider-neutral capability declaration from the calling agent after it inspects callable tools and output channels. Do not infer these values from a model or client name. Used by: design_brief.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_ui.create_tree`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `briefId` - string - design_brief 가 반환한 accepted brief 식별자. Used by: create_tree/update (required), preview/check (optional).
  - `tree` - object - UI 트리 선언형 JSON. 루트는 ScreenGui. 스키마: {className: string, name?: string, parent?: string, properties?: {...}, children?: Tree[]} parent 생략 시 StarterGui. className은 Roblox GUI 계열(ScreenGui/Frame/TextLabel/TextButton/ImageLabel/ImageButton/ScrollingFrame/TextBox/UIListLayout/UIGridLayout/UIPadding/UICorner/UIStroke/UIAspectRatioConstraint/UIGradient/UITextSizeConstraint/UISizeConstraint/UIScale/UIFlexItem/UIShadow/UIPageLayout/UITableLayout/CanvasGroup/UIDragDetector) 한정. In-game UI 기본 구조(HUD / button / toast / card / 대부분의 menu): ScreenGui > Frame(BackgroundTransparency=1) > 실제 UI 요소. ScreenGui 직속 풀스크린 불투명 Frame 은 modal 용도에만 사용한다. Property 값 인코딩: UDim2는 {xScale, xOffset, yScale, yOffset}, UDim은 {scale, offset}, Color3는 {r, g, b}, Vector2/Vector3는 {x,y}/{x,y,z}, Enum은 item name string을 사용한다.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_ui.update`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `briefId` - string - design_brief 가 반환한 accepted brief 식별자. Used by: create_tree/update (required), preview/check (optional).
  - `targetPath` - string - Path to existing UI instance. Both `StarterGui.MyGui` and `game.StarterGui.MyGui` are accepted. Used by: update, delete (required).
  - `changes` - object - 부분 변경 스펙. {properties?: {...}, addChildren?: Tree[], removeChildren?: [string]} properties는 `Instance:SetPropertyValue` 호환 키·값 쌍. 값 인코딩은 tree 설명의 Property 값 인코딩을 따른다.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_ui.delete`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `targetPath` - string - Path to existing UI instance. Both `StarterGui.MyGui` and `game.StarterGui.MyGui` are accepted. Used by: update, delete (required).
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_ui.preview`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `targetPath` - string - Path to existing UI instance. Both `StarterGui.MyGui` and `game.StarterGui.MyGui` are accepted. Used by: update, delete (required).
  - `briefId` - string - design_brief 가 반환한 accepted brief 식별자. Used by: create_tree/update (required), preview/check (optional).
  - `viewportMode` - "current" | "selected_profiles" - Viewport review mode. selected_profiles uses profileIds from the accepted Design Contract. Used by: preview, check.
  - `profileIds` - array<string> - Selected Design Contract target profile IDs. Used by: preview, check.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_ui.check`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `targetPath` - string - Path to existing UI instance. Both `StarterGui.MyGui` and `game.StarterGui.MyGui` are accepted. Used by: update, delete (required).
  - `briefId` - string - design_brief 가 반환한 accepted brief 식별자. Used by: create_tree/update (required), preview/check (optional).
  - `visualReview` - object - Optional provider-neutral visual review written by the calling agent after it inspects one saved manage_ui.preview screenshot. Findings are advisory only and never block UI changes. Used by: check.
  - `viewportMode` - "current" | "selected_profiles" - Viewport review mode. selected_profiles uses profileIds from the accepted Design Contract. Used by: preview, check.
  - `profileIds` - array<string> - Selected Design Contract target profile IDs. Used by: preview, check.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_lighting`

[PRO] Configure environment: lighting, atmosphere, sky, terrain properties, time of day.

### `manage_lighting.lighting`

set Lighting service properties.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `properties` - object - Dictionary of properties to set. Used by: lighting, atmosphere, sky, terrain_props. Supports Color3 {r,g,b} (0-255), numbers, booleans, Enum strings.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_lighting.atmosphere`

set Atmosphere properties.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `properties` - object - Dictionary of properties to set. Used by: lighting, atmosphere, sky, terrain_props. Supports Color3 {r,g,b} (0-255), numbers, booleans, Enum strings.
  - `createIfMissing` - boolean - Create Atmosphere/Sky instance if missing. Used by: atmosphere, sky. Default: true.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_lighting.sky`

set Sky properties.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `properties` - object - Dictionary of properties to set. Used by: lighting, atmosphere, sky, terrain_props. Supports Color3 {r,g,b} (0-255), numbers, booleans, Enum strings.
  - `createIfMissing` - boolean - Create Atmosphere/Sky instance if missing. Used by: atmosphere, sky. Default: true.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_lighting.terrain_props`

set Terrain water/visual properties.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `properties` - object - Dictionary of properties to set. Used by: lighting, atmosphere, sky, terrain_props. Supports Color3 {r,g,b} (0-255), numbers, booleans, Enum strings.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_lighting.time`

set time of day.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `time` - string - Time string in "HH:MM:SS" format (e.g., "14:30:00"). Used by: time. Provide this OR clockTime.
  - `clockTime` - number - Numeric time in 24-hour format (e.g., 14.5 for 2:30 PM). Used by: time. Provide this OR time.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_lighting.mood`

apply a complete environment mood preset (Lighting, Atmosphere, Sky, ColorCorrection/Bloom/SunRays, Terrain water appearance) with optional per-property overrides. Idempotent: existing instances are updated, never duplicated.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `preset` - "sunny_day" | "golden_hour" | "sunset" | "dawn" | "night" | "moonlit_night" | "overcast" | "foggy" | "stormy" | "eerie" - Environment mood preset. Used by: mood. Applies Lighting + Atmosphere + Sky + post effects + Terrain water appearance in one call.
- Optional params:
  - `overrides` - object - Per-section property overrides applied on top of the preset. Used by: mood. Sections: lighting, atmosphere, sky, effects, water. Values follow the same conversion rules as the properties param.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_selection`

Get, set, or clear selection. [PRO] context, details, add/remove items, watch changes.

### `manage_selection.get`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_selection.set`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `paths` - array<string> - Array of instance paths. Used by: set (required), add (required), remove (required).
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_selection.clear`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_selection.cached`

- Tier: `basic`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `maxAge` - number - Maximum age of cached data in milliseconds. Used by: cached. Default: 30000. Set to 0 for any age.

### `manage_selection.context`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `includeSource` - boolean - [PRO] Include script source code. Used by: context. Default: true.
  - `includeProperties` - boolean - [PRO] Include all readable properties. Used by: context. Default: true.
  - `includeChildren` - boolean - [PRO] Include immediate children. Used by: context. Default: false.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_selection.details`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `maxDepth` - number - [PRO] Maximum depth for descendant tree traversal. Used by: details. Default: 1.
  - `includeAncestors` - boolean - [PRO] Include full ancestor chain. Used by: details. Default: false.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_selection.add`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `paths` - array<string> - Array of instance paths. Used by: set (required), add (required), remove (required).
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_selection.remove`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `paths` - array<string> - Array of instance paths. Used by: set (required), add (required), remove (required).
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_selection.watch`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_camera`

Camera operations: get info, focus on instance/position, suggest view, capture Edit-mode viewport screenshot (Edit mode only; not usable during playtest).

### `manage_camera.info`

get current camera position, rotation, FOV, viewport size.

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_camera.focus_path`

move camera to focus on instance by path.

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Instance path to focus on. Used by: focus_path (if not provided, focuses on selection), suggest (if not provided, uses selection).
  - `distance` - number - Distance from target in studs. Used by: focus_path, focus_position. Auto-calculated if not provided.
  - `duration` - number - Animation duration in seconds. Used by: focus_path, focus_position. Default: 0.5.
  - `offset` - object - Camera offset direction from target (normalized and scaled by distance). Used by: focus_path, focus_position. Default: {x:1, y:0.5, z:1}.
  - `respectAutoFocusSetting` - boolean - If true, only focus when plugin Auto Focus setting is enabled. Used by: focus_path, focus_position. Default: false.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_camera.focus_position`

move camera to focus on world position.

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `position` - object - World position to focus on as Vector3. Used by: focus_position (required).
- Optional params:
  - `distance` - number - Distance from target in studs. Used by: focus_path, focus_position. Auto-calculated if not provided.
  - `duration` - number - Animation duration in seconds. Used by: focus_path, focus_position. Default: 0.5.
  - `offset` - object - Camera offset direction from target (normalized and scaled by distance). Used by: focus_path, focus_position. Default: {x:1, y:0.5, z:1}.
  - `lookAt` - object - Point for camera to look at. Used by: focus_position.
  - `respectAutoFocusSetting` - boolean - If true, only focus when plugin Auto Focus setting is enabled. Used by: focus_path, focus_position. Default: false.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_camera.suggest`

get suggested camera view for a target.

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `path` -> `targetPath`
- Required params: none
- Optional params:
  - `path` - string - Instance path to focus on. Used by: focus_path (if not provided, focuses on selection), suggest (if not provided, uses selection).
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_camera.screenshot`

**EDIT MODE ONLY — DO NOT call during an active playtest.** Captures the current Studio Edit-mode viewport as a PNG image (MCP image content). Pre-check: call manage_studio.play_status and only proceed when state == "edit". The handler will fail with a clear error if a playtest is running. Requires Studio Mesh/Image capability. In Studio, open File → Experience Settings → Security and enable "Allow Mesh / Image APIs". v1 does not support Play-mode capture because Roblox blocks converting CaptureService temporary contentId into EditableImage outside the edit DM plugin context (confirmed by Roblox engineers on devforum).

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_tween`

[PRO] Tween service: create, play, pause, cancel tweens for smooth animations.

### `manage_tween.create`

create a new tween with target properties.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path to tween. Used by: create (required).
- Optional params:
  - `tweenInfo` - object - Tween configuration. Used by: create.
  - `properties` - object - Target property values to tween to. Used by: create. Supports Vector3, Color3, numbers, etc.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_tween.play`

play a created tween.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `tweenId` - string - Tween identifier returned by create. Used by: play, pause, cancel.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_tween.pause`

pause a running tween.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `tweenId` - string - Tween identifier returned by create. Used by: play, pause, cancel.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_tween.cancel`

cancel a tween.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `tweenId` - string - Tween identifier returned by create. Used by: play, pause, cancel.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_audio`

[PRO] Audio management: play, stop, pause, resume sounds. Set audio listener.

### `manage_audio.play`

play a sound (creates Sound if needed).

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Path to the Sound instance or parent to create Sound in. Used by: play, stop, pause, resume.
  - `soundId` - string - Roblox sound asset ID (e.g., "rbxassetid://1234567"). Used by: play (if creating a new Sound).
  - `volume` - number - Sound volume (0-10). Used by: play. Default: 0.5.
  - `looped` - boolean - Whether the sound loops. Used by: play. Default: false.
  - `playbackSpeed` - number - Playback speed multiplier. Used by: play. Default: 1.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_audio.stop`

stop a playing sound.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Path to the Sound instance or parent to create Sound in. Used by: play, stop, pause, resume.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_audio.pause`

pause a playing sound.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Path to the Sound instance or parent to create Sound in. Used by: play, stop, pause, resume.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_audio.resume`

resume a paused sound.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Path to the Sound instance or parent to create Sound in. Used by: play, stop, pause, resume.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_audio.set_listener`

set the audio listener type/target.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `listenerType` - "Camera" | "CFrame" | "ObjectPosition" | "ObjectCFrame" - Listener type for SoundService. Used by: set_listener.
  - `listenerPath` - string - Instance path for ObjectPosition/ObjectCFrame listener type. Used by: set_listener.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_animation`

[PRO] Animation: load, play, stop animations. Get animation tracks from humanoid/controller.

### `manage_animation.load`

load an animation on a Humanoid/AnimationController.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Path to the Humanoid, AnimationController, or Model containing one. Used by: load, play, stop, get_tracks.
  - `animationId` - string - Roblox animation asset ID (e.g., "rbxassetid://1234567"). Used by: load.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_animation.play`

play a loaded animation track.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `trackId` - string - Animation track identifier returned by load. Used by: play (required), stop (required).
- Optional params:
  - `path` - string - Path to the Humanoid, AnimationController, or Model containing one. Used by: load, play, stop, get_tracks.
  - `speed` - number - Playback speed multiplier. Used by: play. Default: 1.
  - `fadeTime` - number - Fade time in seconds when starting/stopping. Used by: play, stop. Default: 0.1.
  - `weight` - number - Animation weight (0-1) for blending. Used by: play. Default: 1.
  - `priority` - "Core" | "Idle" | "Movement" | "Action" | "Action2" | "Action3" | "Action4" - Animation priority. Used by: play.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_animation.stop`

stop a playing animation.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `trackId` - string - Animation track identifier returned by load. Used by: play (required), stop (required).
- Optional params:
  - `path` - string - Path to the Humanoid, AnimationController, or Model containing one. Used by: load, play, stop, get_tracks.
  - `fadeTime` - number - Fade time in seconds when starting/stopping. Used by: play, stop. Default: 0.1.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_animation.get_tracks`

list all loaded animation tracks.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Path to the Humanoid, AnimationController, or Model containing one. Used by: load, play, stop, get_tracks.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_physics`

[PRO] Physics collision groups: register, set collidable between groups, list groups.

### `manage_physics.register_group`

register a new collision group with PhysicsService.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `groupName` - string - Collision group name. Used by: register_group (required).
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_physics.set_collidable`

set whether two groups can collide.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `group1` - string - First collision group name. Used by: set_collidable (required).
  - `group2` - string - Second collision group name. Used by: set_collidable (required).
  - `collidable` - boolean - Whether the two groups can collide. Used by: set_collidable (required).
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_physics.get_groups`

list all registered collision groups.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_effects`

[PRO] Particle effects: emit particles, clear all particles, toggle effect enabled state.

### `manage_effects.emit`

emit a burst of particles from a ParticleEmitter.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Path to the effect instance (ParticleEmitter, Beam, Trail) or parent containing effects. Used by: emit, clear, toggle.
  - `count` - number - Number of particles to emit in a burst. Used by: emit. Default: 16.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_effects.clear`

clear all particles from a ParticleEmitter or all emitters under an instance.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Path to the effect instance (ParticleEmitter, Beam, Trail) or parent containing effects. Used by: emit, clear, toggle.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_effects.toggle`

enable or disable a ParticleEmitter, Beam, Trail, or other effect.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Path to the effect instance (ParticleEmitter, Beam, Trail) or parent containing effects. Used by: emit, clear, toggle.
  - `enabled` - boolean - Enable or disable the effect. Used by: toggle.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_terrain`

[PRO] Terrain operations: fill shapes, clear regions, replace materials, manage colors, read/write voxels, generate procedural terrain, smooth terrain.

### `manage_terrain.fill_block`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `cframe` - object - Position and rotation for fill shapes. Used by: fill_block, fill_cylinder, fill_wedge.
  - `size` - object - Size in studs. Used by: fill_block, fill_wedge.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.fill_ball`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `center` - object - Center position as Vector3. Used by: fill_ball.
  - `radius` - number - Radius in studs. Used by: fill_ball, fill_cylinder.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.fill_cylinder`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `cframe` - object - Position and rotation for fill shapes. Used by: fill_block, fill_cylinder, fill_wedge.
  - `radius` - number - Radius in studs. Used by: fill_ball, fill_cylinder.
  - `height` - number - Height in studs. Used by: fill_cylinder.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.fill_wedge`

fill shapes with material. clear_region/clear_bounds: clear terrain. replace_material: swap materials in region. colors_get/colors_set: manage material colors. read_voxel: single voxel. read_voxels/write_voxels: bulk voxels. generate: procedural terrain. smooth: smooth terrain.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `cframe` - object - Position and rotation for fill shapes. Used by: fill_block, fill_cylinder, fill_wedge.
  - `size` - object - Size in studs. Used by: fill_block, fill_wedge.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.clear_region`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `region` - object - Rectangular region with min/max corners. Used by: clear_region, replace_material, read_voxels, write_voxels, generate, smooth.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.clear_bounds`

clear terrain.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `min` - object - Minimum corner for bounds-based clear. Used by: clear_bounds.
  - `max` - object - Maximum corner for bounds-based clear. Used by: clear_bounds.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.replace_material`

swap materials in region. colors_get/colors_set: manage material colors. read_voxel: single voxel. read_voxels/write_voxels: bulk voxels. generate: procedural terrain. smooth: smooth terrain.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `material` - string - Terrain material name (e.g., Grass, Rock, Water, Sand, Slate, Concrete). Used by: fill_*, replace_material, colors_get, colors_set.
  - `region` - object - Rectangular region with min/max corners. Used by: clear_region, replace_material, read_voxels, write_voxels, generate, smooth.
  - `sourceMaterial` - string - Material to replace. Used by: replace_material.
  - `targetMaterial` - string - Replacement material. Used by: replace_material.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.colors_get`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `material` - string - Terrain material name (e.g., Grass, Rock, Water, Sand, Slate, Concrete). Used by: fill_*, replace_material, colors_get, colors_set.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.colors_set`

manage material colors.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `material` - string - Terrain material name (e.g., Grass, Rock, Water, Sand, Slate, Concrete). Used by: fill_*, replace_material, colors_get, colors_set.
  - `color` - object - RGB color (0-255). Used by: colors_set.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.read_voxel`

single voxel. read_voxels/write_voxels: bulk voxels. generate: procedural terrain. smooth: smooth terrain.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `position` - object - Position as Vector3. Used by: read_voxel.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.read_voxels`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `region` - object - Rectangular region with min/max corners. Used by: clear_region, replace_material, read_voxels, write_voxels, generate, smooth.
  - `resolution` - number - Voxel resolution (studs per voxel). Used by: read_voxels, write_voxels. Default: 4.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.write_voxels`

bulk voxels.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `region` - object - Rectangular region with min/max corners. Used by: clear_region, replace_material, read_voxels, write_voxels, generate, smooth.
  - `resolution` - number - Voxel resolution (studs per voxel). Used by: read_voxels, write_voxels. Default: 4.
  - `materials` - array<array<array<string>>> - 3D array of material names [x][y][z]. Used by: write_voxels.
  - `occupancy` - array<array<array<number>>> - 3D array of occupancy values [x][y][z] (0-1). Used by: write_voxels.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.generate`

natural procedural terrain: multi-octave fBm, slope-based materials, smooth surface occupancy, optional water and edge blending. Presets: mountains, hills, plains, dunes, islands, canyon.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `region` - object - Rectangular region with min/max corners. Used by: clear_region, replace_material, read_voxels, write_voxels, generate, smooth.
- Optional params:
  - `preset` - "mountains" | "hills" | "plains" | "dunes" | "islands" | "canyon" - Biome preset for natural terrain. Used by: generate. Explicit parameters override preset values.
  - `seed` - number - Random seed for terrain generation. Used by: generate.
  - `baseHeight` - number - Base terrain height in studs. Used by: generate. Default: 32.
  - `amplitude` - number - Height variation amplitude in studs. Used by: generate. Default: 24.
  - `frequency` - number - Noise frequency (0.001-0.1). Used by: generate. Default: 0.01.
  - `octaves` - number - fBm noise octave count (1-8). Used by: generate. Default: 4.
  - `persistence` - number - Amplitude decay between octaves (0-1). Used by: generate. Default: 0.5.
  - `waterLevel` - number - Absolute water surface height in studs. Used by: generate. Empty space below this level is filled with Water.
  - `edgeBlend` - object - Blend generated heights into existing terrain at region borders. Used by: generate.
  - `materialPalette` - object - Material palette override {surface, cliff, shore, underwater}. Used by: generate.
  - `layers` - array<object> - Material layers by height. Used by: generate. Each: {material, maxHeight}.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_terrain.smooth`

smooth terrain.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `region` - object - Rectangular region with min/max corners. Used by: clear_region, replace_material, read_voxels, write_voxels, generate, smooth.
  - `intensity` - number - Smoothing intensity (0-1). Used by: smooth. Default: 0.5.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `spatial_query`

[PRO] Spatial queries: raycast, find ground, check placement, multi-raycast, scan area, find flat areas, find spawn positions, analyze walkable, spatial map, find empty space, get bounds, snap to grid, check collision.

### `spatial_query.raycast`

single ray.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `origin` - object - Ray origin as Vector3. Used by: raycast.
  - `direction` - object - Ray direction and length as Vector3. Used by: raycast.
  - `filterType` - "Exclude" | "Include" - Raycast filter type. Used by: raycast, multi_raycast. Default: "Exclude".
  - `filterList` - array<string> - Instance paths to filter. Used by: raycast, multi_raycast, find_ground, check_placement, scan_area. Alias: filterInstances.
  - `filterInstances` - array<string> - Instance paths to filter (alias for filterList). Used by: raycast, multi_raycast, find_ground, check_placement, scan_area.
  - `ignoreWater` - boolean - Ignore terrain water. Used by: raycast, multi_raycast. Default: false.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.find_ground`

ground below point.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `maxDistance` - number - Maximum distance for ground search. Used by: find_ground. Default: 1000.
  - `position` - object - Position as Vector3. Used by: find_ground (cast from here), check_placement (center), collision (hypothetical position).
  - `filterList` - array<string> - Instance paths to filter. Used by: raycast, multi_raycast, find_ground, check_placement, scan_area. Alias: filterInstances.
  - `filterInstances` - array<string> - Instance paths to filter (alias for filterList). Used by: raycast, multi_raycast, find_ground, check_placement, scan_area.
  - `offset` - number - Vertical offset for ground position. Used by: find_ground. Default: 0.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.check_placement`

collision-free placement check.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `position` - object - Position as Vector3. Used by: find_ground (cast from here), check_placement (center), collision (hypothetical position).
  - `size` - object - Size as Vector3. Used by: check_placement (object size), find_space (required space size), scan_area (area X/Z dimensions).
  - `filterList` - array<string> - Instance paths to filter. Used by: raycast, multi_raycast, find_ground, check_placement, scan_area. Alias: filterInstances.
  - `filterInstances` - array<string> - Instance paths to filter (alias for filterList). Used by: raycast, multi_raycast, find_ground, check_placement, scan_area.
  - `rotation` - object - Rotation in degrees. Used by: check_placement.
  - `checkGround` - boolean - Verify ground support for placement. Used by: check_placement. Default: true.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.multi_raycast`

batch rays.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `filterType` - "Exclude" | "Include" - Raycast filter type. Used by: raycast, multi_raycast. Default: "Exclude".
  - `filterList` - array<string> - Instance paths to filter. Used by: raycast, multi_raycast, find_ground, check_placement, scan_area. Alias: filterInstances.
  - `filterInstances` - array<string> - Instance paths to filter (alias for filterList). Used by: raycast, multi_raycast, find_ground, check_placement, scan_area.
  - `ignoreWater` - boolean - Ignore terrain water. Used by: raycast, multi_raycast. Default: false.
  - `rays` - array<object> - Array of ray specifications. Used by: multi_raycast. Max 50 rays.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.scan_area`

heightmap generation.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `size` - object - Size as Vector3. Used by: check_placement (object size), find_space (required space size), scan_area (area X/Z dimensions).
  - `filterList` - array<string> - Instance paths to filter. Used by: raycast, multi_raycast, find_ground, check_placement, scan_area. Alias: filterInstances.
  - `filterInstances` - array<string> - Instance paths to filter (alias for filterList). Used by: raycast, multi_raycast, find_ground, check_placement, scan_area.
  - `center` - object - Center point for area scan. Used by: scan_area.
  - `resolution` - number - Grid resolution in studs. Used by: scan_area, analyze_walkable. Default: 4.
  - `maxResults` - number - Maximum results. Used by: spatial_map (default: 500), scan_area (default: 500), find_flat (default: 10).
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.find_flat`

flat areas for building.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `searchArea` - object - Bounding box for search. Used by: find_flat, find_spawn, find_space.
  - `minSize` - object - Minimum flat area size. Used by: find_flat.
  - `maxSlope` - number - Maximum slope in degrees. Used by: find_flat (default: 10), analyze_walkable (default: 45).
  - `tolerance` - number - Height variation tolerance in studs. Used by: find_flat.
  - `maxResults` - number - Maximum results. Used by: spatial_map (default: 500), scan_area (default: 500), find_flat (default: 10).
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.find_spawn`

spawn positions.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `searchArea` - object - Bounding box for search. Used by: find_flat, find_spawn, find_space.
  - `spawnSize` - object - Size of spawning entity. Used by: find_spawn. Default: {x:4, y:5, z:4}.
  - `minSpacing` - number - Minimum distance between spawn positions. Used by: find_spawn. Default: 10.
  - `preferOutdoor` - boolean - Prefer open sky positions. Used by: find_spawn. Default: false.
  - `count` - number - Number of results to find. Used by: find_spawn. Default: 10.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.analyze_walkable`

walkability grid.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `area` - object - Bounding box for analysis. Used by: analyze_walkable. Contains min/max.
  - `maxSlope` - number - Maximum slope in degrees. Used by: find_flat (default: 10), analyze_walkable (default: 45).
  - `resolution` - number - Grid resolution in studs. Used by: scan_area, analyze_walkable. Default: 4.
  - `characterHeight` - number - Character height for clearance checks. Used by: analyze_walkable. Default: 5.
  - `maxStepHeight` - number - Maximum step height. Used by: analyze_walkable. Default: 2.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.spatial_map`

all BasePart positions.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `path` -> `rootPath`
- Required params: none
- Optional params:
  - `path` - string - Instance path. Used by: bounds (optional), snap_grid (required), collision (required), spatial_map (rootPath alias).
  - `rootPath` - string - Root path for spatial map scan. Used by: spatial_map. Default: "game.Workspace".
  - `includeModels` - boolean - Include Model bounding boxes. Used by: spatial_map. Default: true.
  - `maxResults` - number - Maximum results. Used by: spatial_map (default: 500), scan_area (default: 500), find_flat (default: 10).
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.find_space`

empty space for object.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `size` - object - Size as Vector3. Used by: check_placement (object size), find_space (required space size), scan_area (area X/Z dimensions).
  - `searchArea` - object - Bounding box for search. Used by: find_flat, find_spawn, find_space.
  - `gridSize` - number - Grid snap size in studs. Used by: snap_grid (default: 4), find_space (default: 4).
  - `gridSnap` - number - Grid snap size. Alias for gridSize.
  - `padding` - number - Minimum distance from other objects. Used by: find_space. Default: 1.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.bounds`

bounding box.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `path` - string - Instance path. Used by: bounds (optional), snap_grid (required), collision (required), spatial_map (rootPath alias).
  - `paths` - array<string> - Multiple instance paths for batch bounds. Used by: bounds.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.snap_grid`

snap position to grid.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: bounds (optional), snap_grid (required), collision (required), spatial_map (rootPath alias).
- Optional params:
  - `gridSize` - number - Grid snap size in studs. Used by: snap_grid (default: 4), find_space (default: 4).
  - `gridSnap` - number - Grid snap size. Alias for gridSize.
  - `axes` - array<"x" | "y" | "z"> - Axes to snap. Used by: snap_grid. Default: ["x","y","z"]. Use ["x","z"] for horizontal only.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `spatial_query.collision`

AABB collision check.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `path` - string - Instance path. Used by: bounds (optional), snap_grid (required), collision (required), spatial_map (rootPath alias).
- Optional params:
  - `position` - object - Position as Vector3. Used by: find_ground (cast from here), check_placement (center), collision (hypothetical position).
  - `ignorePaths` - array<string> - Instance paths to ignore in collision check. Used by: collision.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_assets`

[PRO] Asset management: insert models by ID, get asset info, search creator store, insert free models/packages, export selection JSON, generate/review Roblox models, round-trip .rbxm files through Asset Library, and generate local thumbnails.

### `manage_assets.insert`

insert model by asset ID.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `assetId` - number - Roblox asset ID. Used by: insert (required), info (required), insert_free (required), insert_package (required).
- Optional params:
  - `parent` - string - Parent path for inserted asset. Used by: insert, search_insert, insert_free, insert_package. Default: "game.Workspace".
  - `name` - string - Optional name for inserted instance.
  - `position` - object - Position to place the model. Used by: insert, insert_free.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.info`

get asset metadata.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `assetId` - number - Roblox asset ID. Used by: insert (required), info (required), insert_free (required), insert_package (required).
- Optional params:
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.search`

search Creator Store.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `maxResults` -> `limit`
- Required params:
  - `query` - string - Search keyword. Used by: search (required), search_insert (required). E.g., "monster", "tree", "car".
- Optional params:
  - `maxResults` - number - Maximum search results. Used by: search. Default: 10.
  - `category` - string - Asset category filter. Used by: search, export_selection_rbxm, export_path_rbxm, review_model, generate_model, import_rbxm, generate_thumbnail. upload_asset may omit this and use assetType/selection auto-detection.
  - `sortType` - string - Sort order for search results. Used by: search.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.search_insert`

search and insert first match.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `query` - string - Search keyword. Used by: search (required), search_insert (required). E.g., "monster", "tree", "car".
- Optional params:
  - `parent` - string - Parent path for inserted asset. Used by: insert, search_insert, insert_free, insert_package. Default: "game.Workspace".
  - `name` - string - Optional name for inserted instance.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.insert_free`

insert free model.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `assetId` - number - Roblox asset ID. Used by: insert (required), info (required), insert_free (required), insert_package (required).
- Optional params:
  - `parent` - string - Parent path for inserted asset. Used by: insert, search_insert, insert_free, insert_package. Default: "game.Workspace".
  - `name` - string - Optional name for inserted instance.
  - `position` - object - Position to place the model. Used by: insert, insert_free.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.insert_package`

insert package.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `assetId` - number - Roblox asset ID. Used by: insert (required), info (required), insert_free (required), insert_package (required).
- Optional params:
  - `parent` - string - Parent path for inserted asset. Used by: insert, search_insert, insert_free, insert_package. Default: "game.Workspace".
  - `name` - string - Optional name for inserted instance.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.export_selection_json`

return a JSON snapshot of the current Studio selection.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `readonly`
- Param aliases: none
- Required params: none
- Optional params:
  - `format` - string - Export format. Used by: export_selection_json.
  - `includeProperties` - boolean - Include all properties in export. Used by: export_selection_json. Default: false.
  - `includeChildren` - boolean - Include children in export. Used by: export_selection_json. Default: false.
  - `maxDepth` - number - Maximum depth for recursive child export. Used by: export_selection_json. Default: 5.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.export_selection_rbxm`

serialize the current Studio selection to a local Asset Library .rbxm asset.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `category` - string - Asset category filter. Used by: search, export_selection_rbxm, export_path_rbxm, review_model, generate_model, import_rbxm, generate_thumbnail. upload_asset may omit this and use assetType/selection auto-detection.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `scope` - "place" | "shared" - Asset Library scope. Used by: export_selection_rbxm, export_path_rbxm, review_model, import_rbxm, generate_thumbnail. Default: place.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `displayName` - string - Asset Library display name or Studio upload display name. Used by: export_selection_rbxm, export_path_rbxm, review_model, generate_model, upload_asset.
  - `description` - string - Asset Library description or Studio upload description. Used by: export_selection_rbxm, export_path_rbxm, review_model, upload_asset.
  - `thumbnailMode` - "none" | "auto" - Thumbnail capture mode. Used by: export_selection_rbxm, export_path_rbxm, review_model. Default: none.
  - `uploadMode` - "auto" | "model" | "embeddedResources" | "localOnly" - Studio-local upload behavior for .rbxm registration actions. auto uploads the selected object as a Roblox Model asset first, model requires that path, embeddedResources uploads only generated Mesh/Image resources, and localOnly skips Roblox upload. Used by: export_selection_rbxm, export_path_rbxm, review_model. Default: localOnly.
  - `uploadTemporaryAssets` - boolean - Explicit user approval for Studio-local CreateAssetAsync uploads before .rbxm registration. Used by: export_selection_rbxm, export_path_rbxm, review_model. Default: false; set true only after user approval.
  - `creatorType` - "user" | "group" - Optional Roblox creator type for Studio-local temporary asset upload. Used with uploadTemporaryAssets by .rbxm registration actions. Omit to use the logged-in Studio user.
  - `creatorId` - string - Optional Roblox user or group ID for Studio-local temporary asset upload. Used with uploadTemporaryAssets by .rbxm registration actions.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.export_path_rbxm`

serialize one Studio instance path to a local Asset Library .rbxm asset.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `category` - string - Asset category filter. Used by: search, export_selection_rbxm, export_path_rbxm, review_model, generate_model, import_rbxm, generate_thumbnail. upload_asset may omit this and use assetType/selection auto-detection.
  - `sourcePath` - string - Studio instance path to export, review, or upload. Used by: export_path_rbxm, review_model, upload_asset.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `scope` - "place" | "shared" - Asset Library scope. Used by: export_selection_rbxm, export_path_rbxm, review_model, import_rbxm, generate_thumbnail. Default: place.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `displayName` - string - Asset Library display name or Studio upload display name. Used by: export_selection_rbxm, export_path_rbxm, review_model, generate_model, upload_asset.
  - `description` - string - Asset Library description or Studio upload description. Used by: export_selection_rbxm, export_path_rbxm, review_model, upload_asset.
  - `thumbnailMode` - "none" | "auto" - Thumbnail capture mode. Used by: export_selection_rbxm, export_path_rbxm, review_model. Default: none.
  - `uploadMode` - "auto" | "model" | "embeddedResources" | "localOnly" - Studio-local upload behavior for .rbxm registration actions. auto uploads the selected object as a Roblox Model asset first, model requires that path, embeddedResources uploads only generated Mesh/Image resources, and localOnly skips Roblox upload. Used by: export_selection_rbxm, export_path_rbxm, review_model. Default: localOnly.
  - `uploadTemporaryAssets` - boolean - Explicit user approval for Studio-local CreateAssetAsync uploads before .rbxm registration. Used by: export_selection_rbxm, export_path_rbxm, review_model. Default: false; set true only after user approval.
  - `creatorType` - "user" | "group" - Optional Roblox creator type for Studio-local temporary asset upload. Used with uploadTemporaryAssets by .rbxm registration actions. Omit to use the logged-in Studio user.
  - `creatorId` - string - Optional Roblox user or group ID for Studio-local temporary asset upload. Used with uploadTemporaryAssets by .rbxm registration actions.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.review_model`

QA the current selection or a Studio path and optionally register it as a local Asset Library .rbxm asset.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `category` - string - Asset category filter. Used by: search, export_selection_rbxm, export_path_rbxm, review_model, generate_model, import_rbxm, generate_thumbnail. upload_asset may omit this and use assetType/selection auto-detection.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `scope` - "place" | "shared" - Asset Library scope. Used by: export_selection_rbxm, export_path_rbxm, review_model, import_rbxm, generate_thumbnail. Default: place.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `sourcePath` - string - Studio instance path to export, review, or upload. Used by: export_path_rbxm, review_model, upload_asset.
  - `displayName` - string - Asset Library display name or Studio upload display name. Used by: export_selection_rbxm, export_path_rbxm, review_model, generate_model, upload_asset.
  - `description` - string - Asset Library description or Studio upload description. Used by: export_selection_rbxm, export_path_rbxm, review_model, upload_asset.
  - `thumbnailMode` - "none" | "auto" - Thumbnail capture mode. Used by: export_selection_rbxm, export_path_rbxm, review_model. Default: none.
  - `uploadMode` - "auto" | "model" | "embeddedResources" | "localOnly" - Studio-local upload behavior for .rbxm registration actions. auto uploads the selected object as a Roblox Model asset first, model requires that path, embeddedResources uploads only generated Mesh/Image resources, and localOnly skips Roblox upload. Used by: export_selection_rbxm, export_path_rbxm, review_model. Default: localOnly.
  - `uploadTemporaryAssets` - boolean - Explicit user approval for Studio-local CreateAssetAsync uploads before .rbxm registration. Used by: export_selection_rbxm, export_path_rbxm, review_model. Default: false; set true only after user approval.
  - `creatorType` - "user" | "group" - Optional Roblox creator type for Studio-local temporary asset upload. Used with uploadTemporaryAssets by .rbxm registration actions. Omit to use the logged-in Studio user.
  - `creatorId` - string - Optional Roblox user or group ID for Studio-local temporary asset upload. Used with uploadTemporaryAssets by .rbxm registration actions.
  - `exportToLibrary` - boolean - Whether to register the reviewed model as an Asset Library .rbxm asset. Used by: review_model. Default: false.
  - `expectedUse` - "decorative" | "interactive" | "vehicle" | "character" | "unknown" - Expected model use for QA heuristics. Used by: review_model, generate_model. Default: unknown.
  - `expectedGroups` - array<string> - Expected child/group names for generated or reviewed model QA. Used by: review_model, generate_model.
  - `maxDescendants` - number - Maximum descendants to inspect during model QA. Used by: review_model, generate_model. Default: 500.
  - `maxDepth` - number - Maximum depth for recursive child export. Used by: export_selection_json. Default: 5.
  - `readiness` - "ready" | "review" | "blocked" - Optional readiness gate for Asset Library registration decisions. Used by: review_model, generate_model.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.generate_model`

Generate a Roblox Model in Studio with GenerationService and return the Studio path/review metadata without saving or uploading.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `prompt` - string - Text prompt for Roblox GenerationService model generation. Used by: generate_model.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `category` - string - Asset category filter. Used by: search, export_selection_rbxm, export_path_rbxm, review_model, generate_model, import_rbxm, generate_thumbnail. upload_asset may omit this and use assetType/selection auto-detection.
  - `schemaMode` - "predefined" | "custom" - Generation schema mode. Used by: generate_model. Default: predefined.
  - `predefinedSchema` - "Body1" | "Car5" - Roblox predefined model schema. Used by: generate_model when schemaMode=predefined. Default: Body1.
  - `schemaGroups` - array<string> - Custom schema group names for generated model segmentation. Used by: generate_model when schemaMode=custom.
  - `size` - object - Requested approximate generated model bounds in studs. Used by: generate_model.
  - `maxTriangles` - number - Maximum triangle budget requested from Roblox GenerationService. Used by: generate_model.
  - `generateTextures` - boolean - Whether Roblox GenerationService should generate textures. Used by: generate_model. Default: true.
  - `review` - boolean - Whether to run post-generation/review QA. Used by: generate_model. Default: true.
  - `targetParent` - string - Studio parent path for imported/generated instances. Used by: import_rbxm, generate_model. Default: game.Workspace.
  - `name` - string - Optional name for inserted instance.
  - `displayName` - string - Asset Library display name or Studio upload display name. Used by: export_selection_rbxm, export_path_rbxm, review_model, generate_model, upload_asset.
  - `expectedUse` - "decorative" | "interactive" | "vehicle" | "character" | "unknown" - Expected model use for QA heuristics. Used by: review_model, generate_model. Default: unknown.
  - `expectedGroups` - array<string> - Expected child/group names for generated or reviewed model QA. Used by: review_model, generate_model.
  - `maxDescendants` - number - Maximum descendants to inspect during model QA. Used by: review_model, generate_model. Default: 500.
  - `maxDepth` - number - Maximum depth for recursive child export. Used by: export_selection_json. Default: 5.
  - `readiness` - "ready" | "review" | "blocked" - Optional readiness gate for Asset Library registration decisions. Used by: review_model, generate_model.
  - `anchorMode` - "none" | "all" - How to anchor generated BaseParts before review/export. Used by: generate_model. Default: all.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.upload_asset`

Upload the current selection or sourcePath through Studio-local AssetService with automatic Model/Mesh/Image type selection, without saving a local .rbxm.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `mutating`
- Param aliases: none
- Required params: none
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `category` - string - Asset category filter. Used by: search, export_selection_rbxm, export_path_rbxm, review_model, generate_model, import_rbxm, generate_thumbnail. upload_asset may omit this and use assetType/selection auto-detection.
  - `assetType` - "auto" | "model" | "mesh" | "image" - Roblox Studio-local upload asset type. Used by: upload_asset. Default: auto, which selects Model/Mesh/Image from the selected Studio object.
  - `sourcePath` - string - Studio instance path to export, review, or upload. Used by: export_path_rbxm, review_model, upload_asset.
  - `displayName` - string - Asset Library display name or Studio upload display name. Used by: export_selection_rbxm, export_path_rbxm, review_model, generate_model, upload_asset.
  - `description` - string - Asset Library description or Studio upload description. Used by: export_selection_rbxm, export_path_rbxm, review_model, upload_asset.
  - `creatorType` - "user" | "group" - Optional Roblox creator type for Studio-local temporary asset upload. Used with uploadTemporaryAssets by .rbxm registration actions. Omit to use the logged-in Studio user.
  - `creatorId` - string - Optional Roblox user or group ID for Studio-local temporary asset upload. Used with uploadTemporaryAssets by .rbxm registration actions.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.import_rbxm`

import an Asset Library .rbxm asset into Studio under a target parent.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `category` - string - Asset category filter. Used by: search, export_selection_rbxm, export_path_rbxm, review_model, generate_model, import_rbxm, generate_thumbnail. upload_asset may omit this and use assetType/selection auto-detection.
  - `assetLibraryAssetId` - string - Asset Library asset ID. Used by: import_rbxm, generate_thumbnail.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `scope` - "place" | "shared" - Asset Library scope. Used by: export_selection_rbxm, export_path_rbxm, review_model, import_rbxm, generate_thumbnail. Default: place.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `targetParent` - string - Studio parent path for imported/generated instances. Used by: import_rbxm, generate_model. Default: game.Workspace.
  - `name` - string - Optional name for inserted instance.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_assets.generate_thumbnail`

generate or replace thumbnail.png for an Asset Library .rbxm asset.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `category` - string - Asset category filter. Used by: search, export_selection_rbxm, export_path_rbxm, review_model, generate_model, import_rbxm, generate_thumbnail. upload_asset may omit this and use assetType/selection auto-detection.
  - `assetLibraryAssetId` - string - Asset Library asset ID. Used by: import_rbxm, generate_thumbnail.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `scope` - "place" | "shared" - Asset Library scope. Used by: export_selection_rbxm, export_path_rbxm, review_model, import_rbxm, generate_thumbnail. Default: place.
  - `placeId` - number - Place ID for place-scoped Asset Library .rbxm round-trip operations. For other manage_assets Studio/plugin actions, this also acts as an optional Studio target selector.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_open_cloud_assets`

[PRO] Roblox Open Cloud asset upload: preflight diagnostics, credential status, category capabilities, Asset Library-backed upload, existing asset linking, updates, metadata reads, and operation polling. Does not expose delete/archive/restore actions.

### `manage_open_cloud_assets.preflight`

diagnose credential, Assets Read/Write permissions, Creator target, category, and local file readiness without uploading. Credential guidance: In Roblox Creator Hub, create an API key, add Assets under Access Permissions, enable both Read and Write, then save and test the key in WEPPY Assets settings. File guidance: Check that the selected asset category, file extension, and file size satisfy the Roblox Assets API requirements.

- Tier: `pro`
- Route: `internal`
- Execution mode: `readonly`
- Param aliases: none
- Required params: none
- Optional params:
  - `filePath` - string - Local file path on the MCP server machine. Used by: upload, link, update.
  - `category` - "image" | "decal" | "audio" | "mesh" | "model" | "video" | "animation" - WEPPY asset category. Used by: upload, link, update. The link action does not support decal because it requires the backing Image asset ID.
  - `creatorType` - "user" | "group" - Asset creator owner type. Used by: upload, update. Defaults to saved credential metadata when available.
  - `creatorId` - string - User ID or group ID for the asset creator. Used by: upload, update. Defaults to saved credential metadata when available.

### `manage_open_cloud_assets.credential_status`

check local Open Cloud credential status without exposing the raw API key.

- Tier: `pro`
- Route: `internal`
- Execution mode: `readonly`
- Param aliases: none
- Required params: none
- Optional params: none

### `manage_open_cloud_assets.capabilities`

list supported upload categories, extensions, and update capabilities.

- Tier: `pro`
- Route: `internal`
- Execution mode: `readonly`
- Param aliases: none
- Required params: none
- Optional params: none

### `manage_open_cloud_assets.upload`

upload a local file as a new Roblox asset through Open Cloud.

- Tier: `pro`
- Route: `internal`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `filePath` - string - Local file path on the MCP server machine. Used by: upload, link, update.
  - `category` - "image" | "decal" | "audio" | "mesh" | "model" | "video" | "animation" - WEPPY asset category. Used by: upload, link, update. The link action does not support decal because it requires the backing Image asset ID.
  - `displayName` - string - Roblox asset display name. Used by: upload, link, update.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `scope` - "place" | "shared" - Asset Library scope. Used by: upload, link. Defaults to place.
  - `placeId` - number - Asset Library Place ID. Used by: upload, link when scope is place. Defaults to the current runtime Place ID.
  - `description` - string - Roblox asset description. Used by: upload, link, update.
  - `creatorType` - "user" | "group" - Asset creator owner type. Used by: upload, update. Defaults to saved credential metadata when available.
  - `creatorId` - string - User ID or group ID for the asset creator. Used by: upload, update. Defaults to saved credential metadata when available.
  - `expectedPrice` - number - Expected upload fee in Robux. Used by: upload, update when Roblox requires an expected price.
  - `waitForOperation` - boolean - When true, poll the returned Open Cloud operation until done or timeout. Used by: upload, update.
  - `operationPollTimeoutMs` - number - Maximum operation polling time in milliseconds. Used by: upload, update when waitForOperation is true.
  - `operationPollIntervalMs` - number - Operation polling interval in milliseconds. Used by: upload, update when waitForOperation is true.

### `manage_open_cloud_assets.link`

link an existing non-Decal Roblox asset ID and local source file to the Asset Library without creating another Roblox asset.

- Tier: `pro`
- Route: `internal`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `assetId` - string - Roblox asset ID. Used by: link (required), update (required), info (required).
  - `filePath` - string - Local file path on the MCP server machine. Used by: upload, link, update.
  - `category` - "image" | "decal" | "audio" | "mesh" | "model" | "video" | "animation" - WEPPY asset category. Used by: upload, link, update. The link action does not support decal because it requires the backing Image asset ID.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `scope` - "place" | "shared" - Asset Library scope. Used by: upload, link. Defaults to place.
  - `placeId` - number - Asset Library Place ID. Used by: upload, link when scope is place. Defaults to the current runtime Place ID.
  - `displayName` - string - Roblox asset display name. Used by: upload, link, update.
  - `description` - string - Roblox asset description. Used by: upload, link, update.

### `manage_open_cloud_assets.update`

update an existing Roblox asset through Open Cloud.

- Tier: `pro`
- Route: `internal`
- Execution mode: `mutating`
- Param aliases: none
- Required params:
  - `assetId` - string - Roblox asset ID. Used by: link (required), update (required), info (required).
  - `category` - "image" | "decal" | "audio" | "mesh" | "model" | "video" | "animation" - WEPPY asset category. Used by: upload, link, update. The link action does not support decal because it requires the backing Image asset ID.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `filePath` - string - Local file path on the MCP server machine. Used by: upload, link, update.
  - `displayName` - string - Roblox asset display name. Used by: upload, link, update.
  - `description` - string - Roblox asset description. Used by: upload, link, update.
  - `creatorType` - "user" | "group" - Asset creator owner type. Used by: upload, update. Defaults to saved credential metadata when available.
  - `creatorId` - string - User ID or group ID for the asset creator. Used by: upload, update. Defaults to saved credential metadata when available.
  - `expectedPrice` - number - Expected upload fee in Robux. Used by: upload, update when Roblox requires an expected price.
  - `updateMask` - array<string> - Metadata fields to update. Used by: update.
  - `waitForOperation` - boolean - When true, poll the returned Open Cloud operation until done or timeout. Used by: upload, update.
  - `operationPollTimeoutMs` - number - Maximum operation polling time in milliseconds. Used by: upload, update when waitForOperation is true.
  - `operationPollIntervalMs` - number - Operation polling interval in milliseconds. Used by: upload, update when waitForOperation is true.

### `manage_open_cloud_assets.info`

read Roblox asset metadata through Open Cloud.

- Tier: `pro`
- Route: `internal`
- Execution mode: `readonly`
- Param aliases: none
- Required params:
  - `assetId` - string - Roblox asset ID. Used by: link (required), update (required), info (required).
- Optional params:
  - `readMask` - array<string> - Asset metadata fields to retrieve. Used by: info.

### `manage_open_cloud_assets.operation_status`

read Open Cloud operation status for upload/update processing.

- Tier: `pro`
- Route: `internal`
- Execution mode: `readonly`
- Param aliases: none
- Required params:
  - `operationId` - string - Roblox Open Cloud operation ID or operations/{id} path. Used by: operation_status.
- Optional params: none

## Tool: `manage_sync`

[PRO] Project sync management: status, history, direction settings, read/write synced files.

### `manage_sync.status_current_place`

get sync status for the current connected place.

- Tier: `pro`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params: none

### `manage_sync.history`

get change history.

- Tier: `pro`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Place ID for sync operations. Used by: history, directions, read_file, write_file.
  - `query` - object - Query parameters for history. Used by: history.

### `manage_sync.directions`

get per-type sync directions.

- Tier: `pro`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Place ID for sync operations. Used by: history, directions, read_file, write_file.

### `manage_sync.read_file`

read a synced file.

- Tier: `pro`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `placeId` - number - Place ID for sync operations. Used by: history, directions, read_file, write_file.
  - `instancePath` - string - Instance path for file read/write. Used by: read_file, write_file.
- Optional params: none

### `manage_sync.write_file`

write to a synced file.

- Tier: `pro`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `placeId` - number - Place ID for sync operations. Used by: history, directions, read_file, write_file.
  - `instancePath` - string - Instance path for file read/write. Used by: read_file, write_file.
  - `content` - string - File content to write. Used by: write_file.
- Optional params: none

### `manage_sync.progress`

get real-time sync progress and bandwidth.

- Tier: `pro`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params: none

## Tool: `workspace_state`

[PRO] Workspace state: full sync, snapshot, recent changes, viewport info, clear history, metadata, scripts, selection info, clear cache.

### `workspace_state.sync`

fetch current Workspace state (hierarchy, history, stats).

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `includeMetadata` - boolean - Include metadata (instance counts, timestamps). Used by: sync. Default: true.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `workspace_state.snapshot`

get full instance tree structure.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `workspace_state.changes`

get recent changes (added/removed/modified).

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `limit` - number - Maximum number of changes to return. Used by: changes. Default: 20.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `workspace_state.viewport`

get camera position, FOV, viewport size, selection bounds.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `includeCameraInfo` - boolean - Include camera position and settings. Used by: viewport. Default: true.
  - `includeSelectionBounds` - boolean - Include current selection bounds info. Used by: viewport. Default: true.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `workspace_state.clear_history`

clear change history.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `workspace_state.metadata`

get workspace metadata.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `workspace_state.scripts`

get script list.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `workspace_state.selection_info`

get selection info.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `workspace_state.clear_cache`

clear state cache.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_logs`

Output logs: get filtered logs, poll incrementally with sinceSeq cursor, clear buffer, get recent errors.

### `manage_logs.get`

retrieve logs with optional level/limit/since/sinceSeq filters.

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases:
  - `level` -> `type`
- Required params: none
- Optional params:
  - `level` - "all" | "error" | "warning" | "info" - Log level filter. Used by: get. Default: "all".
  - `limit` - number - Maximum entries to return. Used by: get (default: 100, max: 500), errors (default: 20, max: 100).
  - `pattern` - string - Text pattern to filter log messages. Used by: get.
  - `since` - number - Unix timestamp in milliseconds. Only logs after this time. Used by: get.
  - `sinceSeq` - number - Return only logs after this sequence number. Cursor mode returns logs oldest-to-newest and includes lastSeq/oldestSeq/hasMore/cursorStatus. Used by: get.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_logs.clear`

clear internal log buffer without resetting seq.

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_logs.errors`

quick access to recent errors only.

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `limit` - number - Maximum entries to return. Used by: get (default: 100, max: 500), errors (default: 20, max: 100).
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `system_info`

System info: ping, connection status, usage tier, and read-only Studio preflight diagnostics. [PRO] place info and services list.

### `system_info.ping`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `message` - string - Optional message to echo back. Used by: ping.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `system_info.connection`

- Tier: `basic`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params: none

### `system_info.usage`

- Tier: `basic`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `system_info.place_info`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `system_info.services`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `system_info.preflight`

diagnose Studio connection, identity, state, publish status, and security capabilities without changing Studio or DataStore state. API Services guidance: In Studio, open File → Experience Settings → Security and enable "Enable Studio Access to API Services". Mesh/Image guidance: In Studio, open File → Experience Settings → Security and enable "Allow Mesh / Image APIs".

- Tier: `basic`
- Route: `internal`
- Execution mode: `readonly`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `manage_studio`

Control Roblox Studio state for playtest lifecycle, automated test runs, and editor view/rendering QA workflows. Use it for state-changing playtest controls and Studio session-level View settings such as UI preview; it does not edit game UI objects or their properties.

### `manage_studio.toggle_ui_preview`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `enabled` - boolean - Boolean value to set. Omit to toggle the current value. Used by: toggle_ui_preview (optional).
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.test_profile_get`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `readonly`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.test_profile_set`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `testProfile` - StudioTestProfile - Optional Player Emulator test profile patch. Used by: test_profile_set, play_start, run_test.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.test_profile_reset`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.experience_language_get`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `readonly`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.experience_language_set`

- Tier: `pro`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `locale` - string - Normalized locale identifier requested for the active Experience Language. Used by: experience_language_set.
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.play_start`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `mode` - "play" | "run" - Playtest mode. "play" = Play mode (F5, default), "run" = Run mode (F8). Used by: play_start, run_test.
  - `testProfile` - StudioTestProfile - Optional Player Emulator test profile patch. Used by: test_profile_set, play_start, run_test.
  - `restoreAfterTest` - boolean - Restore the profile snapshot after the play session or automated test finishes. Defaults to true when testProfile is provided. Used by: play_start, run_test.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.play_stop`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.play_pause`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.play_resume`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.play_status`

- Tier: `pro`
- Route: `plugin`
- Execution mode: `readonly`
- Param aliases: none
- Required params: none
- Optional params:
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

### `manage_studio.run_test`

- Tier: `pro`
- Route: `internal`
- Execution mode: `unspecified`
- Param aliases: none
- Required params:
  - `script` - string - Luau test body to inject into ServerScriptService.__MCP_TestRunner. Used by: run_test.
- Optional params:
  - `mode` - "play" | "run" - Playtest mode. "play" = Play mode (F5, default), "run" = Run mode (F8). Used by: play_start, run_test.
  - `test_name` - string - Optional report display name for the automated playtest run. Used by: run_test.
  - `timeout` - number - Timeout in seconds for the automated playtest run. Default: 60. Maximum: 300. Used by: run_test.
  - `testProfile` - StudioTestProfile - Optional Player Emulator test profile patch. Used by: test_profile_set, play_start, run_test.
  - `restoreAfterTest` - boolean - Restore the profile snapshot after the play session or automated test finishes. Defaults to true when testProfile is provided. Used by: play_start, run_test.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this call to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.

## Tool: `batch_execute`

[PRO] Execute multiple commands in a single batch. Each command is an object with "tool" name and "args". Commands execute sequentially; optionally continue on error.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Required params:
  - `commands` - array<object> - Array of commands to execute sequentially. Each command specifies a tool name and its arguments.
- Optional params:
  - `stopOnError` - boolean - If true, stop executing remaining commands when one fails. Default: true.
  - `placeId` - number - Optional Studio target selector for the entire batch. Per-item selectors inside commands[].args are rejected.
  - `clientId` - string - Optional Studio target selector for the entire batch. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.

## Tool: `execute_luau`

[PRO] Execute arbitrary Luau code in Roblox Studio sandbox. Blocked services: HttpService, DataStoreService, MessagingService. Cannot access CoreGui/CorePackages.

- Tier: `pro`
- Route: `plugin`
- Execution mode: `unspecified`
- Required params:
  - `source` - string - Luau source code to execute. The code runs in a sandboxed environment with access to game services (except blocked ones). Return values are serialized and sent back as the tool result.
- Optional params:
  - `contextId` - string - Optional execution context identifier. Used to continue an existing context for mutating actions.
  - `contextSummary` - ExecutionContextSummary - Optional structured execution context attached to this tool call.
  - `replayMetadata` - ExecutionReplayMetadata - Optional replay-ready metadata attached to this tool call.
  - `placeId` - number - Optional Studio target selector. When multiple Studio clients are connected, route this Luau execution to the active client for this Roblox placeId. If no matching active client exists, the call fails instead of falling back to another Place.
  - `clientId` - string - Optional Studio target selector. Routes this call to the exact connected WEPPY Plugin client. Takes precedence over targetAlias and placeId.
  - `targetAlias` - string - Optional Studio target selector. Routes this call to the connected WEPPY Studio target alias shown in Dashboard/Plugin, such as studio-1. Takes precedence over placeId.


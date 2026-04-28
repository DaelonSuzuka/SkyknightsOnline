# Patterns & Practices

## Autoload-as-Service
Every autoload is a globally-accessible service. No dependency injection — access by global name (e.g., `Game.world`, `HUD.WeaponInfo`, `Settings.connect_to()`). Load order matters; declared top-to-bottom in `project.godot`.

## Path-Based Extends
Ship/weapon inheritance uses path strings instead of `class_name`:
```gdscript
extends 'res://src/ships/common/BaseShip.gd'
```
Common in Godot for scene-instantiated scripts where `class_name` can cause conflicts.

## Data-Dictionary Pattern
Complex nested state stored as plain dicts with `duplicate(true)` for deep copies:
```gdscript
var data = { velocity = Vector3(), speed = { current = 0, target = 0, ... } }
var base_data = data.duplicate(true)  # backup for restore_data()
```
Used by `Engine`, `Afterburner`, and weapon configs.

## Modifier/Decorator Pattern
Components implement `apply(data) -> data` and `remove_at(data) -> data` to modify engine data in-place:
```gdscript
func add_modifier(name, modifier):
    modifiers[name] = modifier
    data = modifier.apply(data)
func remove_modifier(name):
    data = modifiers[name].remove_at(data)
    modifiers.erase(name)
```

## Input Relay Pipeline
```
Godot _input → InputManager → FakeEvent signal → Player.handle_input()
Player._physics_process → composes input_state dict → Player.apply_input (RPC) → ship.input_state
Ship._physics_process → Engine.calculate_forces(input_state) → move_and_slide()
```

## Settings Reactive Binding
```gdscript
Settings.connect_to('Controls/Mouse/Flight', self, 'flight_sens_changed')
# Equivalent to: settings[path].connect('value_changed', self, 'method')
# Plus: immediate initialization with current value
```

## Blender Import Pipeline
`*BlenderImport.gd` scripts extend `EditorScenePostImport`:
- Auto-assign materials from textures, cache as `.tres`
- Create trimesh collisions for terrain/structures
- Rename/reparent nodes for game conventions
- Currently disabled (`import/blender/enabled=false`)

## Render Layer Convention
- Layers 1-5: Game world
- Layer 6: `map_icons` — visible to Map camera
- Layer 7: `minimap_icons` — visible to Minimap camera

## Ship Equip Flow
1. Ship defines `slots` dict (category → type → name → scene path)
2. `equip(category, item_type, item_name)` instantiates and parents the item
3. `inventory[category][item_type]` holds the reference
4. Weapons report `firing`/`reload` state; ship delegates from `input_state`

## Scene Launch Safety
`Game.fix_direct_launch()` handles editor launching a scene directly instead of Main.tscn — reparents the scene into Main's World or CanvasLayer container.

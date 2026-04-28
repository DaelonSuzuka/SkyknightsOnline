# Scene Management

## Scenes Registry

`Scenes.gd` provides a name-to-path mapping:
```gdscript
var registry = {
    'test_world': 'res://src/scenes/VRTraining/VRTraining.tscn',
    'hangar':     'res://src/scenes/Hangar/Hangar.tscn',
    'city':       'res://src/scenes/City/City.tscn',
}
```

## Scene Loading

`Game.load_scene(scene_path, spawn='', _continuing=false)`:
1. If `scene_path` is a registry name, resolve to actual path
2. Remove old `world` from `world_container`, `queue_free()`
3. Instantiate new scene, add as child of `world_container`
4. Emit `scene_changed` signal

## Direct Launch Fix

`Game.fix_direct_launch()` handles the case where the editor launches a scene directly instead of `Main.tscn`:
1. Detect `scene.name != 'Main'`
2. Remove the scene from the tree
3. Switch to `Main.tscn`
4. Re-parent the saved scene into `Main/World` or `Main/CanvasLayer`

## Available Scenes

| Scene | Path | Description |
|-------|------|-------------|
| VRTraining | `src/scenes/VRTraining/` | Test level with terrain + collision |
| Hangar | `src/scenes/Hangar/` | Ship selection & weapon outfitting with rotating pedestal |
| City | `src/scenes/City/` | Large city map (buildings, river, domain blocks) |

See also: [autoloads.md](autoloads.md) | [../scenes/summary.md](../scenes/summary.md)

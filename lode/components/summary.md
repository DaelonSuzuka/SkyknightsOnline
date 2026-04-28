# Components

Reusable components attached as child nodes to game entities.

## Health (`Node3D`) — Placeholder

Current implementation is a flat HP pool. Will be expanded to support the full defense layer system (shield, subtractive armor, % armor, threshold mitigation, auto-repair). See [../plans/game-design.md](../plans/game-design.md) for design.

```gdscript
var current: int   # Current HP
var maximum: int   # Max HP (export default: 1000)

func do_damage(amount): current -= amount; if current <= 0: emit death
func reset(): current = maximum
```

Attached to ships and destructible props.

## HealthBar (`Sprite3D`)

Auto-discovers parent's `Health` node. Renders a `SubViewport`-based 2D progress bar:
- **Green**: > 66% HP
- **Yellow**: 33-66% HP
- **Red**: < 33% HP

Hidden when player enters a ship (player sees HUD weapon info instead).

## MapIcon (`Sprite3D`)

Tracks parent node's yaw rotation to orient a world-space icon. Visible on render layers:
- Layer 6: `map_icons` (visible to Map camera)
- Layer 7: `minimap_icons` (visible to Minimap camera)

## AmmoSource (`Area3D`)

Trigger zone that periodically calls `give_ammo()` on bodies inside it. Exports:
- `trigger_delay`: seconds between ammo grants
- `shape`: collision shape override
- `offset`: position offset
- `ignore`: nodes to exclude

## SpawnPoint (`Marker3D`)

Simple position marker for ship spawn locations. Referenced by scene loading code.

See also: [../ships/summary.md](../ships/summary.md) | [../scenes/summary.md](../scenes/summary.md)

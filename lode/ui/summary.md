# UI System

## HUD (`CanvasLayer` autoload)

Exposes named references to all HUD elements:
```gdscript
@onready var Crosshair, ReloadIndicator, HorizonIndicator, HeadingIndicator,
  PitchLadderLeft, PitchLadderRight, Minimap, Map, EngineEditor, WeaponInfo,
  Debug, Radial
```

### HUD Elements

| Element | File | Function |
|---------|------|----------|
| WeaponInfo | `hud/WeaponInfo.gd` | Weapon name, 4-digit magazine, 4-digit ammo |
| Minimap | `hud/Minimap.gd` | Top-down camera, zoom, toggle size, waypoints, context menu |
| Map | `hud/Map.gd` | Full-screen strategic map, drag-pan, zoom, object picking |
| EngineEditor | `hud/EngineEditor.gd` | Live engine parameter editor — walks `Engine.data` dict |
| Debug | `hud/Debug.gd` | Dynamic debug field display |
| FpsCounter | `hud/FpsCounter.gd` | Simple FPS label |
| HorizonIndicator | (shader) | Pitch ladder via shader params |
| HeadingIndicator | (shader) | Heading display via shader params |
| ReloadIndicator | (ProgressBar) | Weapon reload progress |
| Crosshair | (texture) | Weapon-specific crosshair image |

## MainMenu (`CanvasLayer` autoload)

Pause overlay with network status, connect/local buttons, settings access, quit.

## Spawn Dialog (`Spawn.gd`)

Ship/weapon selector combo boxes. Emits `spawn_pressed(ship_data)` signal.

## ChatBox (`ChatBox.gd`)

Multi-group chat (Global, Team, Match), history navigation, DM support. UI exists but network integration is dormant.

## Settings System

See [settings.md](settings.md).

See also: [../system/autoloads.md](../system/autoloads.md)

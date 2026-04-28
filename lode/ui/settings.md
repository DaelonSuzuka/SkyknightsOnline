# Settings System

## Architecture

`Settings.gd` (extends `TabContainer`, autoload) provides a persistent settings framework.

### Registration Pattern

```gdscript
func register(setting):
    settings[str(path)] = setting
    setting.connect('value_changed', Callable(self, 'request_save'))
```

Each setting widget calls `Settings.register(self)` in `_ready()`.

### Reactive Binding

```gdscript
func connect_to(path, object, method):
    read(path).connect('value_changed', Callable(object, method))
    object.call(method, read(path).value)  # Initialize with current value
```

This pattern provides **both** signal subscription and immediate initialization — consumers never need to manually read the initial value.

## Setting Widgets

| Widget | File | Purpose |
|--------|------|---------|
| SettingSlider | `settings/SettingSlider.gd` | Range slider + text input (sensitivity) |
| SettingCheckbox | `settings/SettingCheckbox.gd` | Toggle (inverted Y, etc.) |
| SettingTextbox | `settings/SettingTextbox.gd` | Text input (username, etc.) |

All emit `value_changed(value)` signal on change.

## Persistence

Settings persist to `settings.json` via `Files.save_json()`. Auto-saves on any `value_changed` signal (debounced via `request_save`).

## Key Settings Paths

- `Controls/Mouse/Flight` — Flight mouse sensitivity
- `Controls/Mouse/Freelook` — Freelook sensitivity
- `Controls/InvertY` — Y-axis inversion
- `Player/Username` — Player display name

## Tree Widget

`settings/Tree.gd` provides a tree control for browsing/organizing settings by category.

See also: [summary.md](summary.md)

# Marauder

The only implemented ship. Extends `BaseShip` via path string.

## Loadout Slots

```gdscript
slots = {
    'weapons': {
        'nosegun': { 'none': null, 'colt': 'weapons/colt/Colt.tscn', 'vortek': 'weapons/vortek/Vortek.tscn' },
        'pylons':  { 'none': null, 'tanks': 'weapons/tanks/Tanks.tscn', 'rocket_pods': 'weapons/rocket_pods/RocketPods.tscn' }
    }
}
```

## Swing-Wing Animation

Wings and engines rotate based on current speed:
```gdscript
var target_wing_angle = scale(_in, 0, _max, -90, 0)  # -90° at rest → 0° at max speed
wing_angle = lerpf(wing_angle, target_wing_angle, wing_turn_speed)
$Model/Wings.rotation_degrees.x = wing_angle
$Model/Engines.rotation_degrees.x = wing_angle
```

## Afterburner

Dynamically adds/removes the Afterburner modifier from Engine:
```gdscript
if input_state['afterburner']:
    $'%Engine'.add_modifier('afterburner', $Afterburner)
else:
    $'%Engine'.remove_modifier('afterburner')
```

## Weapon Firing

Delegates to `current_weapon`:
```gdscript
current_weapon.firing = input_state['fire_primary']
if input_state['reload']:
    current_weapon.reload()
```

## Health

3000 HP default.

See also: [summary.md](summary.md) | [weapons.md](weapons.md) | [flight-physics.md](flight-physics.md)

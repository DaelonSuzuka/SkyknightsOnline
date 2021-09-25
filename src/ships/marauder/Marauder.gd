extends 'res://src/ships/common/BaseShip.gd'

export(String, 'none', 'colt', 'vortek') var nosegun = 'none'

var wing_angle = 0
var wing_turn_speed = 0.05

func _ready():
    ship_dir = 'res://src/ships/marauder/'

    slots = {
        'weapons': {
            'nosegun': {
                'none': null,
                'colt': "weapons/colt/Colt.tscn",
                'vortek': "weapons/vortek/Vortek.tscn",
            },
            'pylons': {
                'none': null,
                'tanks': "weapons/tanks/Tanks.tscn",
                'rocket_pods': "weapons/rocket_pods/RocketPods.tscn",
            },
        }
    }

    inventory = {
        'weapons': {
            'nosegun': null,
            'pylons': null,
        }
    }

    $Health.maximum = 3000

    $Afterburner.data.vert.up.accel = 2
    $Afterburner.data.vert.up.max = 100
    $Afterburner.data.speed.accel = 2
    $Afterburner.data.speed.max = 348 / 3.6

    $Engine.data.vert.hover = 45
    $Engine.data.vert.up.accel = 1
    $Engine.data.vert.down.accel = -1
    $Engine.data.vert.up.max = 50
    $Engine.data.vert.down.max = -35

    $Engine.data.speed.accel = 1
    $Engine.data.speed.brake = 2
    $Engine.data.speed.max = 200 / 3.6

    $Engine.data.pitch.force = .2
    $Engine.data.pitch.max = 1
    $Engine.data.pitch.lerp = .05
    $Engine.data.roll.force = .2
    $Engine.data.roll.max = 1
    $Engine.data.roll.lerp = .1
    $Engine.data.yaw.force = .1
    $Engine.data.yaw.max = 1
    $Engine.data.yaw.lerp = .1

    $Engine.backup_data()

    $Engine.EditPanel.create_labels()

    if nosegun != 'none':
        equip('weapons', 'nosegun', nosegun)

func switch_weapon(number):
    print(number)

func give_ammo():
    if current_weapon:
        current_weapon.give_ammo()

func scale(number, inMin, inMax, outMin, outMax): 
    return (number - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;

func _physics_process(delta):
    var _max = $Engine.data.speed.max / 3
    var _in = clamp($Engine.data.speed.current, 0, _max)
    var target_wing_angle = scale(_in, 0, _max, -90, 0)
    
    wing_angle = lerp(wing_angle, target_wing_angle, wing_turn_speed)
    
    $Model/Wings.rotation_degrees.x = wing_angle
    $Model/Engines.rotation_degrees.x = wing_angle

    if input_state['afterburner']:
        if !('afterburner' in $Engine.modifiers):
            $Engine.modifiers['afterburner'] = $Afterburner.data
    else:
        if 'afterburner' in $Engine.modifiers:
            $Engine.modifiers.erase('afterburner')

    if current_weapon:
        current_weapon.firing = input_state['fire_primary']
        if input_state['reload']:
            current_weapon.reload()

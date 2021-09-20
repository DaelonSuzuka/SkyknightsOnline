extends 'res://src/ships/BaseShip.gd'

export(String, 'none', 'mustang', 'vortek') var nosegun = 'none'

var wing_angle = 0
var wing_turn_speed = 0.05

func _ready():
    ship_dir = 'res://src/ships/reaver/'
    seating_diagram = ship_dir + 'reaver_seating_diagram.png'
    seating_diagram_outline = ship_dir + 'reaver_seating_diagram_outline.png'

    slots = {
        'weapons': {
            'nosegun': {
                'none': null,
                'mustang': "weapons/mustang/Mustang.tscn",
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

    $Engine.afterburner.vert.accel_up = 2
    $Engine.afterburner.vert.max_up = 100
    $Engine.afterburner.speed.accel = 2
    $Engine.afterburner.speed.max = 200

    $Engine.vert.hover = 45
    $Engine.vert.accel_up = 1
    $Engine.vert.accel_down = -1
    $Engine.vert.max_up = 50
    $Engine.vert.max_down = -35

    $Engine.speed.accel = 1
    $Engine.speed.brake = 2
    $Engine.speed.max = 100

    $Engine.pitch.accel = .2
    $Engine.pitch.max = 10
    $Engine.pitch.lerp = .05
    $Engine.roll.accel = .2
    $Engine.roll.max = 2
    $Engine.roll.lerp = .1
    $Engine.yaw.accel = .1
    $Engine.yaw.max = 1
    $Engine.yaw.lerp = .1

    if nosegun != 'none':
        equip('weapons', 'nosegun', nosegun)

func switch_weapon(number):
    print(number)

func give_ammo():
    if current_weapon:
        current_weapon.give_ammo()

func _physics_process(delta):
    var target_wing_angle = -90
    target_wing_angle += $Engine.speed.current / 10
    target_wing_angle = clamp(target_wing_angle, -90, 0)
    
    wing_angle = lerp(wing_angle, target_wing_angle, wing_turn_speed)
    
    $Model/Wings.rotation_degrees.x = wing_angle
    $Model/Engines.rotation_degrees.x = wing_angle
    
    if current_weapon:
        current_weapon.firing = input_state['fire_primary']
        if input_state['reload']:
            current_weapon.reload()

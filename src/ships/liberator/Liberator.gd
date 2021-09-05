extends RigidBody

var ship_dir = "res://src/ships/liberator/"

var slots = {
    'weapons': {
        'nosegun': {
            'none': null,
            'tank_buster': "weapons/tank_buster/TankBuster.tscn",
            'vektor': "weapons/vektor/Vektor.tscn",
            'spur': "weapons/spur/Spur.tscn",
        },
        'bellygun': {
            'none': null,
            'shredder': "weapons/shredder/Shredder.tscn",
            'dalton': "weapons/dalton/Dalton.tscn",
            'zephyr': "weapons/zephyr/Zephyr.tscn",
        },
        'tailgun': {
            'none': null,
        },
    }
}

var inventory = {
    'weapons': {
        'nosegun': null,
        'bellygun': null,
        'tailgun': null,
    }
}

var max_speed = 50
var acceleration = 0.6
var input_response = 8.0

var hover_thrust = 10
var up_thrust = 20
var down_thrust = 15
var vertical_decay = 0.98
var up = 0

var velocity = Vector3.ZERO
var torque = Vector3.ZERO
var throttle = 0
var throttle_accel = 10
var throttle_brake = 15
var throttle_max = 100

var forward_speed = 0

var pitch = 0.0
var yaw = 0.0
var roll = 0.0
var pitch_speed = 50
var roll_speed = 25
var yaw_speed = 20

var pitch_input = 0.0
var yaw_input = 0.0
var roll_input = 0.0
var input_state = {
    'pitch': 0.0,
    'yaw': 0.0,
    'roll': 0.0,
}

func _ready():
    linear_damp = 1
    angular_damp = 3

    for action in InputManager.actions:
        input_state[action] = false

func equip(category, item_type, item_name):
    if !(category in slots):
        return
    if !(item_type in slots[category]):
        return
    if !(item_name in slots[category][item_type]):
        return

    if inventory[category][item_type]:
        var prev_item = inventory[category][item_type]
        if prev_item:
            prev_item.queue_free()

    var item_dir = slots[category][item_type][item_name]
    if !item_dir:
        inventory[category][item_type] = null
        return
    
    var item = load(ship_dir + item_dir).instance()
    inventory[category][item_type] = item
    if item_type == 'nosegun':
        $Nosegun.add_child(item)
    if item_type == 'bellygun':
        $Bellygun.add_child(item)
    
func check_inputs():
    # if input['fire_primary']:
    #     var b = Bullet.instance()
    #     owner.add_child(b)
    #     b.transform = $Nosegun/Muzzle.global_transform
    #     b.velocity = -b.transform.basis.z * b.muzzle_velocity

    if input_state['vertical_thrust_up']:
        up += up_thrust
    if input_state['vertical_thrust_down']:
        up -= down_thrust
    up *= vertical_decay

    if input_state['throttle_up']:
        throttle = min(throttle + throttle_accel, throttle_max)
    if input_state['throttle_down']:
        throttle = max(throttle - throttle_brake, 0)

    pitch = clamp(input_state['pitch'], -1, 1)
    if input_state['pitch_up']:
        pitch += -1
    if input_state['pitch_down']:
        pitch += 1
    pitch = clamp(pitch, -1, 1)

    yaw = clamp(input_state['yaw'], -1, 1)
    if input_state['yaw_left']:
        yaw += 1
    if input_state['yaw_right']:
        yaw += -1
    yaw = clamp(yaw, -1, 1)

    roll = clamp(input_state['roll'], -1, 1)
    if input_state['roll_left']:
        roll += -1
    if input_state['roll_right']:
        roll += 1
    roll = clamp(roll, -1, 1)

func _process(delta):
    check_inputs()

func _physics_process(delta):

    torque = Vector3(pitch * pitch_speed, yaw * yaw_speed, roll * roll_speed) * delta
    apply_torque_impulse(torque)

    var vel = Vector3(0, up, throttle) * delta
    velocity = Quat(global_transform.basis).xform(vel)
    apply_central_impulse(velocity)

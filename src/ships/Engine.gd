extends Spatial

var velocity = Vector3.ZERO

var vert = {
    'current': 0,
    'target': 0,
    'hover': 0,
    'accel_up': 1,
    'accel_down': 1,
    'max_up': 10,
    'max_down': 10,
    'damp': .95,
    'lerp': .1,
}

var speed = {
    'current': 0,
    'target': 0,
    'accel': 1,
    'brake': 1,
    'max': 10,
    'lerp': .1,
    'damp': .9,
}

var _angle = {
    'current': 0,
    'input': 0,
    'target': 0,
    'accel': 0.1,
    'max': 1,
    'lerp': .1,
    'damp': .90,
}

var afterburner = {
    'vert': {
        'accel_up': 0,
        'max_up': 0,
    },
    'speed':{
        'accel': 0.1,
        'max': 1,
    },
}

var pitch = _angle.duplicate()
var roll = _angle.duplicate()
var yaw = _angle.duplicate()

func calculate_forces(input):
    var angle = global_transform.basis.get_euler()
    var attitude = max(abs(angle.x), abs(angle.z))
    var hover_factor = 1 - (attitude / 2)

    var accel_up = vert.accel_up
    var max_up = vert.max_up
    var speed_accel = speed.accel
    var speed_max = speed.max

    if input['afterburner']:
        if speed.current > speed.max / 2:
            speed_accel = afterburner.speed.accel
            speed_max = afterburner.speed.max
        else:
            accel_up = afterburner.vert.accel_up
            max_up = afterburner.vert.max_up

    # up = hover_thrust * hover_factor
    if !input['vertical_thrust_up'] and !input['vertical_thrust_down']:
        vert.target *= vert.damp
    if input['vertical_thrust_up']:
        vert.target += accel_up
    if input['vertical_thrust_down']:
        vert.target += vert.accel_down
    vert.target = clamp(vert.target, vert.max_down, max_up)
    vert.current = lerp(vert.current, vert.target, vert.lerp)

    if input['throttle_up']:
        speed.target += speed_accel
    if input['throttle_down']:
        speed.target -= speed.brake
    speed.target = clamp(speed.target, 0, speed_max)
    speed.current = lerp(speed.current, speed.target, speed.lerp)

    velocity.x = 0
    velocity.y = vert.current
    velocity.z = speed.current

    pitch.input = clamp(input['pitch'], -1, 1)
    if input['pitch_up']:
        pitch.input += -1
    if input['pitch_down']:
        pitch.input += 1
    pitch.input = clamp(pitch.input, -1, 1)

    pitch.target += pitch.input * pitch.accel
    pitch.target = clamp(pitch.target, -pitch.max, pitch.max) * pitch.damp
    pitch.current = lerp(pitch.current, pitch.target, pitch.lerp)

    yaw.input = clamp(input['yaw'], -1, 1)
    if input['yaw_left']:
        yaw.input += 1
    if input['yaw_right']:
        yaw.input += -1
    yaw.input = clamp(yaw.input, -1, 1)

    yaw.target += yaw.input * yaw.accel
    yaw.target = clamp(yaw.target, -yaw.max, yaw.max)
    yaw.target *= yaw.damp
    yaw.current = lerp(yaw.current, yaw.target, yaw.lerp)

    roll.target = clamp(-input['roll'], -1, 1)
    if input['roll_left']:
        roll.target += 1
    if input['roll_right']:
        roll.target += -1
    roll.input = clamp(roll.input, -1, 1)

    roll.target += roll.input * roll.accel
    roll.target = clamp(roll.target, -roll.max, roll.max)
    roll.target *= roll.damp
    roll.current = lerp(roll.current, roll.target, roll.lerp)

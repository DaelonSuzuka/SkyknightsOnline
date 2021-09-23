extends Spatial

var velocity = Vector3.ZERO

var vert = {
    current = 0,
    target = 0,
    hover = 0,
    up = {
        accel = 1,
        max = 10,
    },
    down = {
        accel = 1,
        max = 10,
    },
    damp = .95,
    lerp = .1,
}

var speed = {
    current = 0,
    target = 0,
    accel = 1,
    brake = 1,
    max = 10,
    lerp = .1,
    damp = .9,
}

var _angle = {
    current = 0,
    input = 0,
    target = 0,
    accel = 0.1,
    max = 1,
    lerp = .1,
    damp = .90,
}

var pitch = _angle.duplicate()
var roll = _angle.duplicate()
var yaw = _angle.duplicate()

var data = {
    vert = vert.duplicate(),
    speed = speed.duplicate(),
    pitch = _angle.duplicate(),
    roll = _angle.duplicate(),
    yaw = _angle.duplicate(),
}

func calculate_forces(input):
    var angle = global_transform.basis.get_euler()
    var attitude = max(abs(angle.x), abs(angle.z))
    var hover_factor = 1 - (attitude / 2)

    # if input['afterburner']:
    #     if speed.current > speed.max / 2:
    #         speed_accel = afterburner.speed.accel
    #         speed_max = afterburner.speed.max
    #     else:
    #         accel_up = afterburner.vert.accel_up
    #         max_up = afterburner.vert.max_up

    # up = hover_thrust * hover_factor
    if !input['vertical_thrust_up'] and !input['vertical_thrust_down']:
        vert.target *= vert.damp
    if input['vertical_thrust_up']:
        vert.target += vert.up.accel
    if input['vertical_thrust_down']:
        vert.target += vert.down.accel
    vert.target = clamp(vert.target, vert.down.max, vert.up.max)
    vert.current = lerp(vert.current, vert.target, vert.lerp)

    if input['throttle_up']:
        speed.target += speed.accel
    if input['throttle_down']:
        speed.target -= speed.brake
    speed.target = clamp(speed.target, 0, speed.max)
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

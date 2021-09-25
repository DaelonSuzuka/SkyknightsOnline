extends Spatial

var _vert = {
    current = 0.0,
    target = 0.0,
    hover = 0.0,
    up = {
        accel = 1.0,
        max = 10.0,
    },
    down = {
        accel = 1.0,
        max = 10.0,
    },
    damp = .95,
    response = .1,
}

var _speed = {
    current = 0.0,
    target = 0.0,
    accel = 1.0,
    brake = 1.0,
    max = 10.0,
    response = .1,
    damp = .99,
}

var _angle = {
    input = 0.0,
    target = 0.0,
    current = 0.0,
    force = 0.1,
    max = 1.0,
    response = .1,
    damp = .95,
}

var _pitch = _angle.duplicate()
var _roll = _angle.duplicate()
var _yaw = _angle.duplicate()

var data = {
    velocity = Vector3(),
    vert = _vert.duplicate(true),
    speed = _speed.duplicate(true),
    pitch = _pitch.duplicate(true),
    roll = _roll.duplicate(true),
    yaw = _yaw.duplicate(true),
}
var base_data = data.duplicate(true)

var modifiers = {}
var active_modifiers = []

onready var EditPanel = $EditPanel

func backup_data():
    base_data = data.duplicate(true)

func restore_data():
    for property in data:
        for k in data[property]:
            if !(k in ['current', 'target', 'input']):
                if typeof(data[property][k]) == TYPE_DICTIONARY:
                    for j in data[property][k]:
                        data[property][k][j] = base_data[property][k][j]
                else:
                    data[property][k] = base_data[property][k]

func apply_modifier(m, d):
    for k in m:
        if typeof(m[k]) == TYPE_DICTIONARY:
            apply_modifier(m[k], d[k])
        else:
            d[k] = m[k]

func calculate_forces(input, modifier={}):
    var angle = global_transform.basis.get_euler()
    var attitude = max(abs(angle.x), abs(angle.z))
    var hover_factor = 1 - (attitude / 2)
    
    # if modifiers.keys() != active_modifiers:
    #     active_modifiers.clear()
    #     restore_data()
    #     for mod in modifiers:
    #         active_modifiers.append(mod)
    #         data = modifiers[mod].apply(data)
            
    var vert = data.vert
    var speed = data.speed
    var pitch = data.pitch
    var yaw = data.yaw
    var roll = data.roll

    # up = hover_thrust * hover_factor
    if !input['vertical_thrust_up'] and !input['vertical_thrust_down']:
        vert.target *= vert.damp
    if input['vertical_thrust_up']:
        vert.target += vert.up.accel
    if input['vertical_thrust_down']:
        vert.target += vert.down.accel
    vert.target = clamp(vert.target, vert.down.max, vert.up.max)
    vert.current = lerp(vert.current, vert.target, vert.response)

    if input['throttle_up']:
        speed.target += speed.accel
    if input['throttle_down']:
        speed.target -= speed.brake
    speed.target = clamp(speed.target, 0, speed.max)
    speed.current = lerp(speed.current, speed.target, speed.response)

    data.velocity.x = 0
    data.velocity.y = vert.current
    data.velocity.z = speed.current

    pitch.input = clamp(input['pitch'], -1, 1)
    if input['pitch_up']:
        pitch.input += -1
    if input['pitch_down']:
        pitch.input += 1
    pitch.input = clamp(pitch.input, -1, 1)

    pitch.target += pitch.input * pitch.force
    pitch.target = clamp(pitch.target, -pitch.max, pitch.max) * pitch.damp
    pitch.current = lerp(pitch.current, pitch.target, pitch.response)

    yaw.input = clamp(input['yaw'], -1, 1)
    if input['yaw_left']:
        yaw.input += 1
    if input['yaw_right']:
        yaw.input += -1
    yaw.input = clamp(yaw.input, -1, 1)

    yaw.target += yaw.input * yaw.force
    yaw.target = clamp(yaw.target, -yaw.max, yaw.max)
    yaw.target *= yaw.damp
    yaw.current = lerp(yaw.current, yaw.target, yaw.response)

    roll.input = clamp(-input['roll'], -1, 1)
    if input['roll_left']:
        roll.input += 1
    if input['roll_right']:
        roll.input += -1
    roll.input = clamp(roll.input, -1, 1)

    roll.target += roll.input * roll.force
    roll.target = clamp(roll.target, -roll.max, roll.max)
    roll.target *= roll.damp
    roll.current = lerp(roll.current, roll.target, roll.response)

    # panel.

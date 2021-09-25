extends Spatial


var data = {
    speed = {
        accel = 0,
        max = 0,
    },
    vert = {
        up = {
            force = 0,
            max = 0,
        },
    },
}


func _ready():
    pass

func apply(engine_data):
    engine_data.speed.accel += data.speed.accel
    engine_data.speed.max += data.speed.max
    engine_data.vert.up.force += data.vert.up.force
    engine_data.vert.up.max += data.vert.up.max
    return engine_data

func remove(engine_data):
    engine_data.speed.accel -= data.speed.accel
    engine_data.speed.max -= data.speed.max
    engine_data.vert.up.force -= data.vert.up.force
    engine_data.vert.up.max -= data.vert.up.max
    return engine_data
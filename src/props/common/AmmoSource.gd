class_name AmmoSource extends Area


var targets = []


func _ready():
    connect('body_entered', self, 'on_body_entered')
    connect('body_exited', self, 'on_body_exited')


func on_body_entered(body: Node):
    targets.append(body)

func on_body_exited(body: Node):
    targets.erase(body)

var time = 0.0
func _physics_process(delta):
    time += delta
    if time >= 5:
        time = 0
        print(targets)
    

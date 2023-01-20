extends Control

# ******************************************************************************

onready var camera = $ViewportContainer/Viewport/Camera

var default_size = 3500
var min_size = 1000
var max_size = 5000

var size_step = 100

var big = false

# ******************************************************************************

func _ready() -> void:
	camera.size = default_size

func zoom_in():
	var new_size = camera.size - size_step
	if new_size < min_size:
		new_size = min_size
	camera.size = new_size

func zoom_out():
	var new_size = camera.size + size_step
	if new_size > max_size:
		new_size = max_size
	camera.size = new_size

func toggle_size():
	if big:
		margin_top = -400
		margin_right = 400
		big = false
	else:
		margin_top = -600
		margin_right = 600
		big = true

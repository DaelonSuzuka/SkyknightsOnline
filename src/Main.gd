extends Node

# ******************************************************************************

func _ready():
	if Args.server:
		# HUD.Chat.show()
		Network.create_server()
		OS.set_window_title('Skyknights Online - Server')
		MainMenu.hide()
		return
	elif Args.connect:
		Network.join_server()
		MainMenu.Spawn.connect('spawn_pressed', Game, 'spawn_pressed')
		return

	# start game normally
	MainMenu.hide()
	Game.load_scene('test_world')
	
	yield(get_tree().create_timer(0.1), "timeout")
	var ship_data = {
		'name': 'marauder',
		'nosegun': 'colt',
	}
	ShipManager.spawn_ship(0, ship_data)
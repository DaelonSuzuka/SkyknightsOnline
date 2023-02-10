extends Node

# ******************************************************************************

func _ready():
	# if Args.server:
	# 	# HUD.Chat.show()
	# 	Network.create_server()
	# 	get_window().set_title('Skyknights Online - Server')
	# 	MainMenu.hide()
	# 	return
	# elif Args.connect:
	# 	Network.join_server()
	# 	MainMenu.Spawn.connect('spawn_pressed',Callable(Game,'spawn_pressed'))
	# 	return

	# start game normally
	MainMenu.hide()
	Game.load_scene('city')
	
	await get_tree().create_timer(0.1).timeout
	var ship_data = {
		'name': 'marauder',
		'nosegun': 'colt',
	}
	ShipManager.spawn_ship(0, ship_data)
	Player.toggle_mouse_capture(true)

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
	MainMenu.Connect.connect('pressed', Network, 'join_server')
	MainMenu.Local.connect('pressed', Game, 'on_local_pressed')
	MainMenu.Spawn.hide()
	Game.load_scene('hangar')
	MainMenu.Spawn.connect('spawn_pressed', Game, 'spawn_pressed')

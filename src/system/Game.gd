extends Node

# ******************************************************************************
var prefix = '[color=gray][GAME][/color] '
func Log(string: String):
	Console.print(prefix + string)
# ******************************************************************************

onready var scenes = {
	'player': preload('res://src/player/Player.tscn'),
	'peer': preload('res://src/player/Peer.tscn'),
	'bullet': preload('res://src/ships/common/weapons/Bullet.tscn'),
}

onready var ships = {
	'marauder': preload('res://src/ships/marauder/Marauder.tscn'),
}

onready var Bullets = get_node('/root/Main/Bullets')
onready var World = get_node('/root/Main/World')
onready var Ships = get_node('/root/Main/Ships')
onready var Players = get_node('/root/Main/Players')

# var version = load('res://system/Version.gd').new().VERSION

# just used for the pause menu to communicate to the main menu
var returning_to_menu := false
var continuing := false
var main_ready := true

signal scene_changed

var world_container: Node = null
var world: Node = null

func _ready():
	randomize()

	if fix_direct_launch():
		world_container = get_node('/root/Main/World')

# ******************************************************************************
"""
This section fixes the scene tree when a scene is launched directly from the editor.

Main game systems are built with the assumption that the 'current scene' is
Main.tscn. Levels are loaded in as children of 'Main/World'. Launching a scene
directly from the editor causes that scene to be the 'current scene'.

Fixed this requires saving a reference to the directly launched scene, removing
it from the root viewport so it doesn't get deleted, and then calling 
'get_tree().change_scene()'.

Changing the scene takes longer than one game frame, for <reasons>, so this
process has involves multiple uses of 'call_deferred'.
"""

var direct_launch := false

func fix_direct_launch() -> bool:
	var scene = get_tree().get_current_scene()
	if scene.name != 'Main':
		direct_launch = true
		main_ready = false
		call_deferred('fix_main1')
		return false
	return true

var saved_current_scene: Node = null

func fix_main1():
	var scene = get_tree().get_current_scene()
	scene.get_parent().remove_child(scene)
	saved_current_scene = scene
	get_tree().change_scene("res://Main.tscn")
	call_deferred('fix_main2')

func fix_main2():
	world_container = get_node('/root/Main/World')
	if saved_current_scene is Control:
		get_node('/root/Main/CanvasLayer').add_child(saved_current_scene)
	else:
		world_container.add_child(saved_current_scene)
	world = saved_current_scene
	emit_signal('scene_changed')
	main_ready = true

# ******************************************************************************
# Scene/World management

var requested_spawn = ''

remote func load_scene(scene_path: String, spawn:='', _continuing=false):
	Log('loading scene: ' + scene_path)
	requested_spawn = spawn
	continuing = _continuing

	if scene_path in Scenes.registry:
		scene_path = Scenes.registry[scene_path]

	var new_scene = load(scene_path) as PackedScene
	if new_scene:
		if world:
			world_container.remove_child(world)
			world.queue_free()
		world = null
		world = new_scene.instance()
		world_container.add_child(world)
	else:
		Log('scene not found, aborting scene load')
		return

	emit_signal('scene_changed')

# ******************************************************************************

func create_bullet():
	var bullet = scenes['bullet'].instance()
	Bullets.add_child(bullet)
	return bullet

func on_local_pressed():
	Game.load_scene('test_world')
	create_player(0)
	MainMenu.Spawn.show()

remotesync func create_player(id):
	var player

	if id == Network.net_id:
		player = scenes['player'].instance()
		player.set_network_master(Network.net_id)
	else:
		player = scenes['peer'].instance()

	player.name = str(id)
	Players.add_child(player)

remotesync func remove_player(id):
	if Ships.get_node(str(id)):
		Ships.get_node(str(id)).queue_free()

	Players.get_node(str(id)).queue_free()

# ******************************************************************************

func spawn_pressed(data):
	var id = Network.net_id

	if Network.connected:
		rpc('spawn_ship', id, data)
	else:
		if Ships.has_node(str(id)):
			var player = Players.get_node(str(id))
			if player:
				player.leave_ship()
			Ships.get_node(str(id)).kill()
		spawn_ship(id, data)

var next_spawn = 1

remotesync func spawn_ship(id, data):
	if Ships.has_node(str(id)):
		return

	var spawn_origin = World.get_child(0).get_node('Spawnpoints')
	var spawn = spawn_origin.get_node(str(next_spawn))
	next_spawn = ((next_spawn + 1) % 4) + 1

	if data['name'] in ships:
		var ship = ships[data['name']].instance()
		ship.name = str(id)
		ship.data = data
		Ships.add_child(ship)
		ship.equip('weapons', 'nosegun', data['nosegun'])
		ship.global_transform = spawn.global_transform
		ship.look_at(spawn_origin.global_transform.origin, Vector3.UP)
		Players.get_node(str(id)).enter_ship(ship)

	var display_name = ''
	if id == Network.net_id:
		display_name += 'my '
	display_name += data['name']

func _physics_process(delta):
	if Network.connected:
		if is_network_master():
			for ship in get_tree().get_nodes_in_group('ships'):
				if ship.dead:
					var player = Players.get_node(ship.name)
					if player:
						player.leave_ship()
					ship.rpc('kill')

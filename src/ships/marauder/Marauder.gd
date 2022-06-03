extends 'res://src/ships/common/BaseShip.gd'

export(String, 'none', 'colt', 'vortek') var nosegun = 'none'

var wing_angle = 0
var wing_turn_speed = 0.05

func _ready():
	ship_dir = 'res://src/ships/marauder/'

	slots = {
		'weapons':
		{
			'nosegun':
			{
				'none': null,
				'colt': 'weapons/colt/Colt.tscn',
				'vortek': 'weapons/vortek/Vortek.tscn',
			},
			'pylons':
			{
				'none': null,
				'tanks': 'weapons/tanks/Tanks.tscn',
				'rocket_pods': 'weapons/rocket_pods/RocketPods.tscn',
			},
		}
	}

	inventory = {
		'weapons':
		{
			'nosegun': null,
			'pylons': null,
		}
	}

	$Health.maximum = 3000

	$Afterburner.data.vert.up.accel = 4.0
	$Afterburner.data.vert.up.max = 35
	$Afterburner.data.speed.accel = 4.0
	$Afterburner.data.speed.max = 100

	$Engine.data.vert.hover.force = 1
	$Engine.data.vert.hover.max = 5
	$Engine.data.vert.up.force = 4.0
	$Engine.data.vert.up.max = 35.0
	$Engine.data.vert.down.force = -3
	$Engine.data.vert.down.max = -30

	$Engine.data.speed.accel = 0.5
	$Engine.data.speed.brake = 1.0
	$Engine.data.speed.max = 250 / 3.6
	$Engine.data.speed.response = .05

	$Engine.data.pitch.force = .2
	$Engine.data.pitch.max = 2.0
	$Engine.data.pitch.response = .2
	$Engine.data.pitch.damp = .95
	$Engine.data.roll.force = .2
	$Engine.data.roll.max = 2.0
	$Engine.data.roll.response = .2
	$Engine.data.roll.damp = .95
	$Engine.data.yaw.force = .1
	$Engine.data.yaw.max = 0.5
	$Engine.data.yaw.response = .1
	$Engine.data.yaw.damp = .9

	$Engine.backup_data()

	$Engine.EditPanel.create_labels()

	# var panel1_material = SpatialMaterial.new()
	# panel1_material.flags_unshaded = true
	# panel1_material.flags_transparent = true
	# $Model/Panel1.set_surface_material(0, panel1_material)

	# var panel1_texture = ViewportTexture.new()
	# panel1_texture.viewport_path = 'Panels/Panel1/Viewport'
	# $Model/Panel1.get_surface_material(0).albedo_texture = panel1_texture

	$Model/Panel1.get_surface_material(0).albedo_texture = $Panels/Panel1/Viewport.get_texture()
	$Panels/Panel1/Viewport/Sprite.texture = $Panels/Panel1/Viewport/Sprite/InnerViewport.get_texture()

	if nosegun != 'none':
		equip('weapons', 'nosegun', nosegun)

func switch_weapon(number):
	print(number)

func give_ammo():
	if current_weapon:
		current_weapon.give_ammo()

func scale(number, inMin, inMax, outMin, outMax):
	return (number - inMin) * (outMax - outMin) / (inMax - inMin) + outMin

func _physics_process(delta):
	var _max = $Engine.data.speed.max / 3
	var _in = clamp($Engine.data.speed.current, 0, _max)
	var target_wing_angle = scale(_in, 0, _max, -90, 0)

	wing_angle = lerp(wing_angle, target_wing_angle, wing_turn_speed)

	$Model/Wings.rotation_degrees.x = wing_angle
	$Model/Engines.rotation_degrees.x = wing_angle

	if input_state['afterburner']:
		$Engine.add_modifier('afterburner', $Afterburner)
	else:
		$Engine.remove_modifier('afterburner')

	if current_weapon:
		current_weapon.firing = input_state['fire_primary']
		if input_state['reload']:
			current_weapon.reload()

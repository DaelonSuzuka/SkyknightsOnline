tool
extends EditorScenePostImport

var mat_path = 'res://src/ships/marauder/materials/'
var res_path = mat_path + '%s.tres'
var tex_path = mat_path + '%s.png'

func post_import(scene):
	scene.name = 'Model'

	var parts = ['Chassis', 'Wings', 'Engines', 'Radar']
	var material
	var node

	for part in parts:
		node = scene.get_node(part)

		if Directory.new().file_exists(res_path % part):
			material = load(res_path % part)
		else:
			material = SpatialMaterial.new()
			material.albedo_texture = load(tex_path % part)
			ResourceSaver.save(res_path % part, material)

		node.set_surface_material(0, material)

	var panel
	for i in range(4):
		panel = 'Panel' + str(i + 1)
		node = scene.get_node(panel)

		if Directory.new().file_exists(res_path % panel):
			material = load(res_path % panel)
		else:
			material = SpatialMaterial.new()
			material.albedo_texture = load(tex_path % panel)
			material.flags_unshaded = true
			material.flags_transparent = true
			ResourceSaver.save(res_path % panel, material)

		node.set_surface_material(0, material)

	scene.transform.origin.y += -2.5

	return scene

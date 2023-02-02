@tool
extends EditorScenePostImport

var mat_path = 'res://src/props/Biolab/materials/'
var res_path = mat_path + '%s.tres'
var tex_path = mat_path + '%s.png'

func _post_import(scene):
	scene.name = 'Model'

	var parts = ['Deck', 'Dome', 'LandingPads']
	var material
	var node

	for part in parts:
		node = scene.get_node(part)

		if FileAccess.file_exists(res_path % part):
			material = load(res_path % part)
		else:
			material = StandardMaterial3D.new()
			material.albedo_texture = load(tex_path % part)
			ResourceSaver.save(res_path % part, material)

		node.set_surface_override_material(0, material)

		node.create_trimesh_collision()

	return scene

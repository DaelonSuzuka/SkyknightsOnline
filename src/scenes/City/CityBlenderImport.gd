@tool
extends EditorScenePostImport

var mat_path = 'res://src/scenes/City/'
var res_path = mat_path + '%s.tres'
var tex_path = mat_path + '%s.png'

func _post_import(scene):
	scene.name = 'Terrain'

	var material
	var node

	var ap = scene.get_node('AnimationPlayer')
	scene.remove_child(ap)
	ap.queue_free()

	# node = scene.get_node('Mesh')
	for child in scene.get_children():
		child.name = child.name.capitalize()

		if FileAccess.file_exists(res_path % (child.name + 'TerrainMaterial')):
			material = load(res_path % (child.name + 'TerrainMaterial'))
		else:
			material = StandardMaterial3D.new()
			print(material)
			# material.albedo_color = Color.GRAY
			ResourceSaver.save(res_path % (child.name + 'TerrainMaterial'), material)

		child.set_surface_override_material(0, material)

		child.create_trimesh_collision()
		child.get_node('Mesh_col').hide()

	return scene

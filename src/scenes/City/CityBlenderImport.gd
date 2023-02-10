@tool
extends EditorScenePostImport

var mat_path = 'res://src/scenes/City/'
var res_path = mat_path + '%s.tres'
var tex_path = mat_path + '%s.png'

func _post_import(scene):
	scene.name = 'Terrain'
	scene.scale *= 10
	scene.position = Vector3(-10000, 0, 10000)

	for child in scene.get_children():
		child.name = child.name.capitalize()

	var node

	node = scene.get_node('Buildings')
	node.create_trimesh_collision()
	node.set_surface_override_material(0, load('res://src/scenes/City/CityBuildingShader.tres'))

	node = scene.get_node('Domain')
	node.create_trimesh_collision()
	node.set_surface_override_material(0, load('res://src/scenes/City/CityBuildingShader.tres'))

	node = scene.get_node('Blocks')
	node.create_trimesh_collision()
	node.set_surface_override_material(0, load('res://src/scenes/City/CityBuildingShader.tres'))

	node = scene.get_node('River')
	node.hide()

	return scene

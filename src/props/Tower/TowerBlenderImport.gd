@tool
extends EditorScenePostImport

func _post_import(scene):
	scene.name = 'Model'

	for node in scene.get_children():
		var material = StandardMaterial3D.new()
		material.albedo_texture = load('res://src/props/biolab/Deck.png')
		node.set_surface_override_material(0, material)

	return scene

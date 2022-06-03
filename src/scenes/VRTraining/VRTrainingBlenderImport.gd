tool
extends EditorScenePostImport

var mat_path = 'res://src/scenes/VRTraining/'
var res_path = mat_path + '%s.tres'
var tex_path = mat_path + '%s.png'

func post_import(scene):
	scene.name = 'Terrain'

	var material
	var node

	node = scene.get_node('Mesh')

	if Directory.new().file_exists(res_path % 'VRTrainingTerrainMaterial'):
		material = load(res_path % 'VRTrainingTerrainMaterial')
	else:
		material = SpatialMaterial.new()
		material.albedo_texture = load(tex_path % 'VRTrainingTerrainTexture')
		ResourceSaver.save(res_path % 'VRTrainingTerrainMaterial', material)

	node.set_surface_material(0, material)

	node.create_trimesh_collision()
	node.get_node('Mesh_col').hide()

	return scene

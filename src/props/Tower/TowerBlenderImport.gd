tool
extends EditorScenePostImport

func post_import(scene):
    scene.name = 'Model'

    for node in scene.get_children():
        var material = SpatialMaterial.new()
        material.albedo_texture = load('res://src/props/biolab/Deck.png')
        node.set_surface_material(0, material)

    return scene
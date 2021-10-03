tool
extends EditorScenePostImport

func post_import(scene):
    scene.name = 'Model'

    var deck = SpatialMaterial.new()
    deck.albedo_texture = load('res://src/props/biolab/Deck.png')
    scene.get_node('Deck').set_surface_material(0, deck)

    var dome = SpatialMaterial.new()
    dome.albedo_texture = load('res://src/props/biolab/Dome.png')
    scene.get_node('Dome').set_surface_material(0, dome)

    var pads = SpatialMaterial.new()
    pads.albedo_texture = load('res://src/props/biolab/LandingPads.png')
    scene.get_node('LandingPads').set_surface_material(0, pads)

    return scene
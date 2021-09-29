tool
extends EditorScenePostImport

func post_import(scene):
    scene.name = 'Model'

    var chassis = load('res://src/ships/marauder/materials/Chassis.tres')
    var wings = load('res://src/ships/marauder/materials/Wings.tres')
    var engines = load('res://src/ships/marauder/materials/Engines.tres')
    var radar = load('res://src/ships/marauder/materials/Radar.tres')

    scene.get_node('Chassis').set_surface_material(0, chassis)
    scene.get_node('Wings').set_surface_material(0, wings)
    scene.get_node('Engines').set_surface_material(0, engines)
    scene.get_node('Radar').set_surface_material(0, radar)

    var panel1 = SpatialMaterial.new()
    panel1.flags_unshaded = true
    panel1.flags_transparent = true
    scene.get_node('Panel1').set_surface_material(0, panel1)

    # var panel2 = SpatialMaterial.new()
    # var panel3 = SpatialMaterial.new()
    # var panel4 = SpatialMaterial.new()
    # scene.get_node('Panel2').set_surface_material(0, panel2)
    # scene.get_node('Panel3').set_surface_material(0, panel3)
    # scene.get_node('Panel4').set_surface_material(0, panel4)

    # scene.get_node('Panel1').material.
    scene.transform.origin.y += -2.5

    return scene
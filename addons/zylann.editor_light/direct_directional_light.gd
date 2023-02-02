@tool

var _instance_rid = null
var _light_rid = null


func _init():
	_instance_rid = RenderingServer.instance_create()
	_light_rid = RenderingServer.directional_light_create()
	RenderingServer.instance_set_base(_instance_rid, _light_rid)


func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		
		if _instance_rid != null:
			RenderingServer.free_rid(_instance_rid)
			_instance_rid = null
			
		if _light_rid != null:
			RenderingServer.free_rid(_light_rid)
			_light_rid = null


func set_world(world):
	RenderingServer.instance_set_scenario(_instance_rid, world.scenario if world != null else RID())


func set_transform(trans):
	RenderingServer.instance_set_transform(_instance_rid, trans)


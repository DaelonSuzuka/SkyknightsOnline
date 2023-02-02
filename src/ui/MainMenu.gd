extends CanvasLayer

# ******************************************************************************

@onready var ID = $Panel/Bar/System/NetStatus/ID
@onready var Connect = $Panel/Bar/System/Connect
@onready var Local = $Panel/Bar/System/Local
@onready var Status = $Panel/Bar/System/NetStatus/Status
@onready var Ping = $Panel/Bar/System/NetStatus/Ping
@onready var Spawn = $Panel/Bar/Spawn
@onready var Username = $Panel/Bar/System/NetStatus/Username

# ******************************************************************************

func _ready():
	$Panel/Bar/System/Settings.connect('pressed',Callable(Settings,'toggle_visibility'))
	$Panel/Bar/System/Quit.connect('pressed',Callable(self,'quit_pressed'))

func quit_pressed():
	get_tree().quit()

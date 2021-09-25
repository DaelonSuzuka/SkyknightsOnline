extends CanvasLayer

onready var Radial = $Radial
onready var Debug = $Debug
onready var WeaponInfo = $WeaponInfo
onready var Crosshair = $Crosshair
onready var ReloadIndicator = $ReloadIndicator
onready var DebugOverlay = $DebugOverlay
# onready var Chat = $ChatBox

func _ready():
    WeaponInfo.hide()
    Crosshair.hide()
    ReloadIndicator.hide()
    # Chat.hide()
    # Debug.hide()

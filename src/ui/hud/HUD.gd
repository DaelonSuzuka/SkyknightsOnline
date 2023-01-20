extends CanvasLayer

# ******************************************************************************

onready var Radial = $Radial
onready var Debug = $Debug
onready var WeaponInfo = $WeaponInfo
onready var Crosshair = $Crosshair
onready var ReloadIndicator = $ReloadIndicator
onready var HorizonIndicator = $HorizonIndicator
onready var HeadingIndicator = $HorizonIndicator/HeadingIndicator
onready var PitchLadderLeft = $HorizonIndicator/PitchLadderLeft
onready var PitchLadderRight = $HorizonIndicator/PitchLadderRight
onready var Minimap = $Minimap
onready var Map = $Map
# onready var Chat = $ChatBox

# ******************************************************************************

func _ready():
	hide_hud()
	Map.hide()

func hide_hud():
	WeaponInfo.hide()
	Crosshair.hide()
	ReloadIndicator.hide()
	HorizonIndicator.hide()
	HeadingIndicator.hide()
	PitchLadderLeft.hide()
	PitchLadderRight.hide()
	Minimap.hide()

func show_hud():
	WeaponInfo.show()
	Crosshair.show()
	ReloadIndicator.show()
	HorizonIndicator.show()
	HeadingIndicator.show()
	PitchLadderLeft.show()
	PitchLadderRight.show()
	Minimap.show()

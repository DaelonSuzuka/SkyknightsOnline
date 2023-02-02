extends VBoxContainer

var weapon_name : set = set_weapon_name
var magazine : set = set_magazine
var ammo : set = set_ammo

func _ready():
	pass

func set_weapon_name(text):
	$Name.text = text

func set_magazine(text):
	$Ammo/Magazine.text = text

func set_ammo(text):
	$Ammo/Reserve.text = text

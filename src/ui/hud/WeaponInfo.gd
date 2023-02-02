extends VBoxContainer

# ******************************************************************************

var weapon_name:
	set(text):
		$Name.text = text

var magazine:
	set(text):
		$Ammo/Magazine.text = text

var ammo:
	set(text):
		$Ammo/Reserve.text = text

extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_BackButton_pressed():
	self.visible = false
	Global.save_data()

func _on_CodeButton_pressed():
	match $Panel/Code.text.to_upper():
		"703":
			if not Global.music_data.has("Rain Down"):
				$Panel/Code.text = "Rain Down Unlocked"
				Global.music_data.append("Rain Down")
			else:
				$Panel/Code.text = "Rain Down Already Unlocked"
		"RETROBELL":
			$Panel/Code.text = "Retro Skin Unlocked"
		"RAINBOW":
			if not Global.skin_data.has("Rainbow"):
				$Panel/Code.text = "Rainbow Skin Unlocked"
				Global.skin_data.append("Rainbow")
			else:
				$Panel/Code.text = "Rainbow Skin Already Unlocked"
		"MERCH":
			if not Global.skin_data.has("Merch"):
				$Panel/Code.text = "Rockway Merch Unlocked"
				Global.skin_data.append("Merch")
			else:
				$Panel/Code.text = "Rockway Merch Already Unlocked"
		"COPPER":
			if not Global.sound_data.has("Penny"):
				$Panel/Code.text = "Mr. Penny SFX Unlocked"
				Global.sound_data.append("Penny")
			else:
				$Panel/Code.text = "Penny Already Unlocked"
		"SCIENCE":
			if not Global.sound_data.has("Rempel"):
				$Panel/Code.text = "Mr. Rempel SFX Unlocked"
				Global.sound_data.append("Rempel")
			else:
				$Panel/Code.text = "Rempel Already Unlocked"
		"SECRET123":
			if not Global.sound_data.has("Scott"):
				$Panel/Code.text = "Ms. Scott SFX Unlocked"
				Global.sound_data.append("Scott")
			else:
				$Panel/Code.text = "Scott Already Unlocked"
		"FUNNY FUMO FUNCTION":
			if not Global.skin_data.has("Fumo"):
				$Panel/Code.text = ":3"
				Global.skin_data.append("Fumo")
			else:
				$Panel/Code.text = ":("
		"WIDE":
			if not Global.skin_data.has("Wide"):
				$Panel/Code.text = "W I D E"
				Global.skin_data.append("Wide")
			else:
				$Panel/Code.text = "You are already W I D E"
		_:
			$Panel/Code.text = "Incorrect"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_ThirdPartyButton_pressed():
	$ThirdParty.visible = true
	$Panel/BackButton.visible = false
func _on_ThridBackButton_pressed():
	$ThirdParty.visible = false
	$Panel/BackButton.visible = true

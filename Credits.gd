extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_BackButton_pressed():
	self.visible = false
	Global.save_data()

func _on_CodeButton_pressed():
	match $Panel/CodeEntry.text.to_upper():
		"703":
			if not Global.music_data.has("Rain Down"):
				$Panel/CodeEntry.text = "Rain Down Unlocked"
				Global.music_data.append("Rain Down")
			else:
				$Panel/CodeEntry.text = "Rain Down Already Unlocked"
		"RETROBELL":
			$Panel/CodeEntry.text = "Retro Skin Unlocked"
		"RAINBOW":
			if not Global.skin_data.has("Rainbow"):
				$Panel/CodeEntry.text = "Rainbow Skin Unlocked"
				Global.skin_data.append("Rainbow")
			else:
				$Panel/CodeEntry.text = "Rainbow Skin Already Unlocked"
		_:
			$Panel/CodeEntry.text = "Incorrect"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_ThirdPartyButton_pressed():
	$ThirdParty.visible = true
	$Panel/BackButton.visible = false
func _on_ThridBackButton_pressed():
	$ThirdParty.visible = false
	$Panel/BackButton.visible = true

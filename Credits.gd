extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_BackButton_pressed():
	self.visible = false
	Global.save_data()

func _ready():
	if OS.get_name() == "HTML5":
		$Panel/CodeButton.visible = false
		$Panel/Code.margin_right = 274
		var _error = $Panel/Code.connect("focus_exited", self, "_on_CodeButton_pressed")

func _on_CodeButton_pressed():
	$Panel/Code.modulate = Color(95/255, 1, 1, 1)
	match $Panel/Code.text.to_upper():
		# "703":
		# 	if not Global.music_data.has("Rain Down"):
		# 		$Panel/Code.text = "Rain Down Unlocked"
		# 		Global.music_data.append("Rain Down")
		# 	else:
		# 		$Panel/Code.text = "Rain Down Already Unlocked"
		# "RETROBELL":
		# 	$Panel/Code.text = "Retro Skin Unlocked"
		# "RAINBOW":
		# 	if not Global.skin_data.has("Rainbow"):
		# 		$Panel/Code.text = "Rainbow Skin Unlocked"
		# 		Global.skin_data.append("Rainbow")
		# 	else:
		# 		$Panel/Code.text = "Rainbow Skin Already Unlocked"
		# "THINK":
		# 	if not Global.skin_data.has("Think"):
		# 		$Panel/Code.text = "Think Skin Unlocked"
		# 		Global.skin_data.append("Think")
		# 	else:
		# 		$Panel/Code.text = "Think Skin Already Unlocked"
		# "RAIN":
		# 	if not Global.skin_data.has("Rain"):
		# 		$Panel/Code.text = "Rain Down Skin Unlocked"
		# 		Global.skin_data.append("Rain")
		# 	else:
		# 		$Panel/Code.text = "Rain Down Skin Already Unlocked"
		# "MERCH":
		# 	if not Global.skin_data.has("Merch"):
		# 		$Panel/Code.text = "Rockway Merch Unlocked"
		# 		Global.skin_data.append("Merch")
		# 	else:
		# 		$Panel/Code.text = "Rockway Merch Already Unlocked"
		# "39":
		# 	if not Global.skin_data.has("Miku"):
		# 		$Panel/Code.text = "Miku Skin Unlocked"
		# 		Global.skin_data.append("Miku")
		# 	else:
		# 		$Panel/Code.text = "Miku Skin Already Unlocked"
		# "WEALTH":
		# 	if not Global.skin_data.has("Gold"):
		# 		$Panel/Code.text = "Gold Skin Unlocked"
		# 		Global.skin_data.append("Gold")
		# 	else:
		# 		$Panel/Code.text = "Miku Skin Already Unlocked"
		# "COPPER":
		# 	if not Global.sound_data.has("Penny"):
		# 		$Panel/Code.text = "Mr. Penny SFX Unlocked"
		# 		Global.sound_data.append("Penny")
		# 	else:
		# 		$Panel/Code.text = "Penny Already Unlocked"
		# "SCIENCE":
		# 	if not Global.sound_data.has("Rempel"):
		# 		$Panel/Code.text = "Mr. Rempel SFX Unlocked"
		# 		Global.sound_data.append("Rempel")
		# 	else:
		# 		$Panel/Code.text = "Rempel Already Unlocked"
		# "SECRET123":
		# 	if not Global.sound_data.has("Scott"):
		# 		$Panel/Code.text = "Ms. Scott SFX Unlocked"
		# 		Global.sound_data.append("Scott")
		# 	else:
		# 		$Panel/Code.text = "Scott Already Unlocked"
		# "FUNNY FUMO FUNCTION":
		# 	if not Global.skin_data.has("Fumo"):
		# 		$Panel/Code.text = ":3"
		# 		Global.skin_data.append("Fumo")
		# 	else:
		# 		$Panel/Code.text = ":("
		# "WIDE":
		# 	if not Global.skin_data.has("Wide"):
		# 		$Panel/Code.text = "W I D E"
		# 		Global.skin_data.append("Wide")
		# 	else:
		# 		$Panel/Code.text = "You are already W I D E"
		"SAVE RESET":
			Global.reset_data()
			OS.alert("Save Data has been reset")
		"SETTINGS RESET":
			Global.currentMusicIndex = 0
			Global.currentSoundIndex = 0
			Global.currentSkinIndex = 0
			Global.save_data()
		_:
			$Panel/Code.text = "Incorrect"
			$Panel/Code.modulate = Color(1, 199/255, 1, 1)


func _process(delta):
	if $Panel/Code.modulate.r != 1:
		$Panel/Code.modulate.r += 0.01 * delta / 0.016
		if $Panel/Code.modulate.r > 1:
			$Panel/Code.modulate.r = 1
	if $Panel/Code.modulate.g != 1:
		$Panel/Code.modulate.g += 0.01 * delta / 0.016
		if $Panel/Code.modulate.g > 1:
			$Panel/Code.modulate.g = 1



func _on_ThirdPartyButton_pressed():
	$ThirdParty.visible = true
	$Panel/BackButton.visible = false
func _on_ThridBackButton_pressed():
	$ThirdParty.visible = false
	$Panel/BackButton.visible = true

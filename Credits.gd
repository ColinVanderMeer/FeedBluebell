extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var resetEnabled = false

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
		"703":
			if not Global.music_data.has("Rain Down"):
				$Panel/Code.text = "Rain Down Unlocked"
				Global.music_data.append("Rain Down")
			else:
				$Panel/Code.text = "Rain Down Already Unlocked"
		"THINK":
			if not Global.skin_data.has("Think"):
				$Panel/Code.text = "Think Skin Unlocked"
				Global.skin_data.append("Think")
			else:
				$Panel/Code.text = "Think Skin Already Unlocked"
		"39":
			if not Global.skin_data.has("Miku"):
				$Panel/Code.text = "Miku Skin Unlocked"
				Global.skin_data.append("Miku")
			else:
				$Panel/Code.text = "Miku Skin Already Unlocked"
		"COPPER":
			if not Global.sound_data.has("Penny"):
				$Panel/Code.text = "Mr. Penny Sounds Unlocked"
				Global.sound_data.append("Penny")
			else:
				$Panel/Code.text = "Penny Already Unlocked"
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
		"BALLET":
			if not Global.skin_data.has("Ballet"):
				$Panel/Code.text = "Bellerina Skin Unlocked"
				Global.skin_data.append("Ballet")
			else:
				$Panel/Code.text = "Bellerina Skin Already Unlocked"
		"COW":
			if not Global.skin_data.has("Cowbell"):
				$Panel/Code.text = "Cowbell skin Unlocked"
				Global.skin_data.append("Cowbell")
			else:
				$Panel/Code.text = "Cowbell Skin Already Unlocked"
		"MUSIC":
			if not Global.skin_data.has("Hamjam"):
				$Panel/Code.text = "DJ Ham Jam Unlocked"
				Global.skin_data.append("Hamjam")
			else:
				$Panel/Code.text = "DJ Ham Jam Already Unlocked"
		"RESET":
			if resetEnabled:
				Global.reset_data()
				OS.alert("Save Data has been reset")
			else:
				$Panel/Code.text = "Incorrect"
				$Panel/Code.modulate = Color(1, 199/255, 1, 1)
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
	resetEnabled = true
	
func _on_ThridBackButton_pressed():
	$ThirdParty.visible = false
	$Panel/BackButton.visible = true

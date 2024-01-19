extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _on_BackButton_pressed():
	self.visible = false
	Global.musicVolume = $Panel/MusicSlider.value
	Global.soundVolume = $Panel/SfxSlider.value
	Global.save_data()


onready var musicBus := AudioServer.get_bus_index("Music")
onready var sfxBus := AudioServer.get_bus_index("SFX")

# godot array with two values "mySoul" and "rainDown"


func _ready() -> void:
	AudioServer.set_bus_volume_db(musicBus, linear2db(Global.musicVolume))
	AudioServer.set_bus_volume_db(sfxBus, linear2db(Global.soundVolume))
	$Panel/MusicSlider.value = db2linear(AudioServer.get_bus_volume_db(musicBus))
	$Panel/SfxSlider.value = db2linear(AudioServer.get_bus_volume_db(sfxBus))
	updateMusic()
	updateSound()
	updateSkin()


func _on_MusicSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musicBus, linear2db(value))

func _on_SfxSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfxBus, linear2db(value))

func _on_MusicRight_pressed() -> void:
	Global.currentMusicIndex += 1
	if Global.currentMusicIndex >= Global.music_data.size():
		Global.currentMusicIndex = 0
	updateMusic()

func _on_MusicLeft_pressed() -> void:
	Global.currentMusicIndex -= 1
	if Global.currentMusicIndex < 0:
		Global.currentMusicIndex = Global.music_data.size() - 1
	updateMusic()

func _on_SoundRight_pressed() -> void:
	Global.currentSoundIndex += 1
	if Global.currentSoundIndex >= Global.sound_data.size():
		Global.currentSoundIndex = 0
	updateSound()

func _on_SoundLeft_pressed() -> void:
	Global.currentSoundIndex -= 1
	if Global.currentSoundIndex < 0:
		Global.currentSoundIndex = Global.sound_data.size() - 1
	updateSound()

func _on_SkinRight_pressed() -> void:
	Global.currentSkinIndex += 1
	if Global.currentSkinIndex >= Global.skin_data.size():
		Global.currentSkinIndex = 0
	updateSkin()

func _on_SkinLeft_pressed() -> void:
	Global.currentSkinIndex -= 1
	if Global.currentSkinIndex < 0:
		Global.currentSkinIndex = Global.skin_data.size() - 1
	updateSkin()

func updateMusic() -> void:
	$Panel/Music/Label.text = Global.music_data[Global.currentMusicIndex]
	Global.music = Global.music_data[Global.currentMusicIndex]

func updateSound() -> void:
	$Panel/SoundPack/Label.text = Global.sound_data[Global.currentSoundIndex]
	Global.soundpack = Global.sound_data[Global.currentSoundIndex]

func updateSkin() -> void:
	$Panel/Skin/TextureRect.texture = load("res://assets/characters/neutral_bbspr.png")
	$Panel/Skin/TextureRect.material = null
	$Panel/Skin/TextureRect.rect_scale = Vector2(1,1)
	$Panel/Skin/TextureRect.rect_position.x = 171.824
	match Global.skin_data[Global.currentSkinIndex]:
		"Rainbow":
			$Panel/Skin/TextureRect.material = load("res://assets/shaders/gayyy.tres")
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] Rainbow Pig"
		"Merch":
			$Panel/Skin/TextureRect.texture = load("res://assets/characters/merch/bluebell_game_swag_neutral.png")
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] Swagbell"
		"Fumo":
			$Panel/Skin/TextureRect.texture = load("res://assets/characters/funnyFumo/FunnyFumo.png")
			$Panel/RichSkinLabel.bbcode_text = "[b]Fumo:[/b] Funny"
		"Wide":
			$Panel/Skin/TextureRect.rect_scale = Vector2(2,1)
			$Panel/Skin/TextureRect.rect_position.x = 67.824
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] W   I   D   E"
		"Rain":
			$Panel/Skin/TextureRect.texture = load("res://assets/characters/rainDown/bluebell_game_rain_down.png")
			$Panel/Skin/TextureRect.rect_scale = Vector2(1.125,1)
			$Panel/Skin/TextureRect.rect_position.x = 155.824
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] Hymn Hog"
		"Think":
			$Panel/Skin/TextureRect.texture = load("res://assets/characters/think/bluebell_game_THINK_neutral.png")
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] Think"
		"Miku":
			$Panel/Skin/TextureRect.texture = load("res://assets/characters/miku/neutral_bbspr.png")
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] Hogsune Miku"
		"Gold":
			$Panel/Skin/TextureRect.texture = load("res://assets/characters/gold/neutral_bbspr.png")
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] Golden Bell"
		"Ballet":
			$Panel/Skin/TextureRect.texture = load("res://assets/characters/ballet/neutral_bbspr.png")
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] Bellerina"
		"Cowbell":
			$Panel/Skin/TextureRect.texture = load("res://assets/characters/cowbell/neutral_bbspr.png")
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] Cowbell"
		"Hamjam":
			$Panel/Skin/TextureRect.texture = load("res://assets/characters/hamjam/neutral_bbspr.png")
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] DJ Ham Jam"
		_:
			$Panel/RichSkinLabel.bbcode_text = "[b]Skin:[/b] Default"
	Global.skin = Global.skin_data[Global.currentSkinIndex]


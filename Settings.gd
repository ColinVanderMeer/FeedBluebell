extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _on_BackButton_pressed():
	self.visible = false


onready var musicBus := AudioServer.get_bus_index("Music")
onready var sfxBus := AudioServer.get_bus_index("SFX")

# godot array with two values "mySoul" and "rainDown"
var currentMusicIndex = 0

var currentSoundIndex = 0

var currentSkinIndex = 0


func _ready() -> void:
	$Panel/MusicSlider.value = db2linear(AudioServer.get_bus_volume_db(musicBus))
	$Panel/SfxSlider.value = db2linear(AudioServer.get_bus_volume_db(sfxBus))
	defaultText()


func _on_MusicSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musicBus, linear2db(value))

func _on_SfxSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfxBus, linear2db(value))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func defaultText() -> void:
	$Panel/Music/Label.text = Global.music
	$Panel/SoundPack/Label.text = Global.soundpack
	$Panel/Skin/Label.text = Global.skin

func _on_MusicRight_pressed() -> void:
	currentMusicIndex += 1
	if currentMusicIndex >= Global.music_data.size():
		currentMusicIndex = 0
	updateMusic()

func _on_MusicLeft_pressed() -> void:
	currentMusicIndex -= 1
	if currentMusicIndex < 0:
		currentMusicIndex = Global.music_data.size() - 1
	updateMusic()

func _on_SoundRight_pressed() -> void:
	currentSoundIndex += 1
	if currentSoundIndex >= Global.sound_data.size():
		currentSoundIndex = 0
	updateSound()

func _on_SoundLeft_pressed() -> void:
	currentSoundIndex -= 1
	if currentSoundIndex < 0:
		currentSoundIndex = Global.sound_data.size() - 1
	updateSound()

func _on_SkinRight_pressed() -> void:
	currentSkinIndex += 1
	if currentSkinIndex >= Global.skin_data.size():
		currentSkinIndex = 0
	updateSkin()

func _on_SkinLeft_pressed() -> void:
	currentSkinIndex -= 1
	if currentSkinIndex < 0:
		currentSkinIndex = Global.skin_data.size() - 1
	updateSkin()

func updateMusic() -> void:
	$Panel/Music/Label.text = Global.music_data[currentMusicIndex]
	Global.music = Global.music_data[currentMusicIndex]

func updateSound() -> void:
	$Panel/SoundPack/Label.text = Global.sound_data[currentSoundIndex]
	Global.soundpack = Global.sound_data[currentSoundIndex]

func updateSkin() -> void:
	$Panel/Skin/Label.text = Global.skin_data[currentSkinIndex]
	Global.skin = Global.skin_data[currentSkinIndex]


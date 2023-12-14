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
var musicList = ["mySoul", "rainDown"]

var currentSoundIndex = 0
var soundList = ["sound1", "sound2"]

var currentCostumeIndex = 0
var costumeList = ["costume1", "costume2"]


func _ready() -> void:
	$Panel/MusicSlider.value = db2linear(AudioServer.get_bus_volume_db(musicBus))
	$Panel/SfxSlider.value = db2linear(AudioServer.get_bus_volume_db(sfxBus))


func _on_MusicSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musicBus, linear2db(value))

func _on_SfxSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfxBus, linear2db(value))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MusicRight_pressed() -> void:
	currentMusicIndex += 1
	if currentMusicIndex >= musicList.size():
		currentMusicIndex = 0
	updateMusic()

func _on_MusicLeft_pressed() -> void:
	currentMusicIndex -= 1
	if currentMusicIndex < 0:
		currentMusicIndex = musicList.size() - 1
	updateMusic()

func _on_SoundRight_pressed() -> void:
	currentSoundIndex += 1
	if currentSoundIndex >= soundList.size():
		currentSoundIndex = 0
	updateSound()

func _on_SoundLeft_pressed() -> void:
	currentSoundIndex -= 1
	if currentSoundIndex < 0:
		currentSoundIndex = soundList.size() - 1
	updateSound()

func _on_CostumeRight_pressed() -> void:
	currentCostumeIndex += 1
	if currentCostumeIndex >= costumeList.size():
		currentCostumeIndex = 0
	updateCostume()

func _on_CostumeLeft_pressed() -> void:
	currentCostumeIndex -= 1
	if currentCostumeIndex < 0:
		currentCostumeIndex = costumeList.size() - 1
	updateCostume()

func updateMusic() -> void:
	if currentMusicIndex == 0:
		$Panel/Music/Label.text = "My Soul Cries Out"
	if currentMusicIndex == 1:
		$Panel/Music/Label.text = "Rain Down"
	SoundManager.music = musicList[currentMusicIndex]

func updateSound() -> void:
	if currentSoundIndex == 0:
		$Panel/SoundPack/Label.text = "Sound 1"
	if currentSoundIndex == 1:
		$Panel/SoundPack/Label.text = "Sound 2"
	SoundManager.sound = soundList[currentSoundIndex]

func updateCostume() -> void:
	if currentCostumeIndex == 0:
		$Panel/Costume/Label.text = "Costume 1"
	if currentCostumeIndex == 1:
		$Panel/Costume/Label.text = "Costume 2"
	SoundManager.costume = costumeList[currentCostumeIndex]


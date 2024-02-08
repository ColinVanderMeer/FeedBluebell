extends Node

const SAVE_FILE ="user://save_file.save"

# Set default save data
var music_data = ["My Soul Cries Out", "Rain Down"]
var sound_data = ["Default", "Rempel", "Scott", "Penny"]
var skin_data = ["Default", "Gold", "Rainbow", "Rain", "Merch", "Think", "Miku", "Wide", "Ballet", "Cowbell", "Hamjam"]
var currentMusicIndex = 0
var currentSoundIndex = 0
var currentSkinIndex = 0
var musicVolume = 1
var soundVolume = 1
var bestScore = 0

var unlock_data = [0, 0, 0, 1, 1, 0]

var score = 0
var pause = false
var sinceFarmer = 8

# Set default settings
var music = "My Soul Cries Out"
var soundpack = "Default"
var skin = "Default"

var good_food = []
var bad_food = []
var game_over = []

func _ready():
	load_data()

func save_data():
	unlock_data = [currentMusicIndex, currentSoundIndex, currentSkinIndex, musicVolume, soundVolume, bestScore]
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(unlock_data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		save_data()
	file.open(SAVE_FILE, File.READ)
	unlock_data = file.get_var()
	# If the save file is not the correct length, reset it to prevent out of bounds errors
	if len(unlock_data) != 6:
		unlock_data = [0, 0, 0, 1, 1, 0]
		save_data()
	file.close()
	
	currentMusicIndex = unlock_data[0]
	currentSoundIndex = unlock_data[1]
	currentSkinIndex = unlock_data[2]
	musicVolume = unlock_data[3]
	soundVolume = unlock_data[4]
	bestScore = unlock_data[5]

	# Prevent crash if funny fumo function was activated
	if currentSkinIndex == 11:
		currentSkinIndex = 0

# Reset the save file to default
func reset_data():
	unlock_data = [0, 0, 0, 1, 1, 0]
	
	currentMusicIndex = unlock_data[0]
	currentSoundIndex = unlock_data[1]
	currentSkinIndex = unlock_data[2]
	musicVolume = unlock_data[3]
	soundVolume = unlock_data[4]
	bestScore = unlock_data[5]

	save_data()

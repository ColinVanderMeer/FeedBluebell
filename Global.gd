extends Node

const SAVE_FILE ="user://save_file.save"
var music_data = ["My Soul Cries Out"]
var sound_data = ["Default"]
var skin_data = ["Default"]
var currentMusicIndex = 0
var currentSoundIndex = 0
var currentSkinIndex = 0
var musicVolume = 1
var soundVolume = 1
var bestScore = 0
var playerID = -1
var bannerHammer = 0
var banDate = 0

var unlock_data = [music_data, sound_data, skin_data, 0, 0, 0, 1, 1, 0, -1, 0, 0]

var current_datetime = OS.get_date()

# Set the default soundpack
var music = "My Soul Cries Out"
var soundpack = "Default"
var skin = "Default"

# TODO: Make these an array/hashmap of some kind?
var good_food = []
var bad_food = []
var game_over = []

func _ready():
	load_data()
	
	if current_datetime.day != banDate and banDate != 0:
		banDate = 0
		bannerHammer = 1

	
func banDay():
	banDate = current_datetime.day


var score = 0
var pause = false # this shouldn't be here, too bad

func save_data():
	unlock_data = [music_data, sound_data, skin_data, currentMusicIndex, currentSoundIndex, currentSkinIndex, musicVolume, soundVolume, bestScore, playerID, bannerHammer, banDate]
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
	if len(unlock_data) < 12:
		unlock_data = [music_data, sound_data, skin_data, 0, 0, 0, 1, 1, 0, -1, 0, 0]
		save_data()
	file.close()
	
	music_data = unlock_data[0]
	sound_data = unlock_data[1]
	skin_data = unlock_data[2]
	currentMusicIndex = unlock_data[3]
	currentSoundIndex = unlock_data[4]
	currentSkinIndex = unlock_data[5]
	musicVolume = unlock_data[6]
	soundVolume = unlock_data[7]
	bestScore = unlock_data[8]
	playerID = unlock_data[9]
	bannerHammer = unlock_data[10]
	banDate = unlock_data[11]
	
func reset_data():
	music_data = ["My Soul Cries Out"]
	sound_data = ["Default"]
	skin_data = ["Default"]
	unlock_data = [music_data, sound_data, skin_data, 0, 0, 0, 1, 1, 0, -1, 0, 0]
	
	music_data = unlock_data[0]
	sound_data = unlock_data[1]
	skin_data = unlock_data[2]
	currentMusicIndex = unlock_data[3]
	currentSoundIndex = unlock_data[4]
	currentSkinIndex = unlock_data[5]
	musicVolume = unlock_data[6]
	soundVolume = unlock_data[7]
	bestScore = unlock_data[8]
	playerID = unlock_data[9]
	bannerHammer = unlock_data[10]
	banDate = unlock_data[11]

	save_data()

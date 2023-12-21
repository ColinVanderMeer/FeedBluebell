extends Node

# Modify these to add additional soundpack settings
enum SOUND_PACK {DEFAULT, JADEN}

# Set the default soundpack
var soundpack = SOUND_PACK.DEFAULT
var music = "My Soul Cries Out"
var sound = "0"
var skin = "0"

# TODO: Make these an array/hashmap of some kind?
var good_food
var bad_food
var game_over

func _ready():
	# Dynamically set the file of each SFX depending on soundpack folder
	var path = "res://assets/sfx/"
	match soundpack:
		SOUND_PACK.DEFAULT:
			path += "default/"
		SOUND_PACK.JADEN:
			path += "jaden/"
	
	# TODO: Find better way to do this, rather than going through each manually
	good_food = load(path+"good_food.wav")
	bad_food = load(path+"bad_food.wav")
	game_over = load(path+"game_over.wav")

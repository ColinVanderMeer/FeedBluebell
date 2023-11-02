extends Node

enum SOUND_PACK {DEFAULT}

var soundpack = SOUND_PACK.DEFAULT

var good_food
var bad_food
var game_over

func _ready():
	var path = "res://assets/sfx/"
	match soundpack:
		SOUND_PACK.DEFAULT:
			path += "default/"
	
	good_food = load(path+"good_food.wav")
	bad_food = load(path+"bad_food.wav")
	game_over = load(path+"game_over.wav")

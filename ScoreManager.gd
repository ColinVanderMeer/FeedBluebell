extends Node

const SAVE_FILE ="user://save_file.save"
var music_data = ["My Soul Cries Out"]
var sound_data = ["Default"]
var skin_data = ["Default"]
var unlock_data = [music_data, sound_data, skin_data]

func _ready():
    load_data()

var score = 0
var pause = false # this shouldn't be here, too bad

func save_data():
    var file = File.new()
    file.open(SAVE_FILE, File.WRITE)
    file.store_var(unlock_data)
    file.close()

func load_data():
    var file = File.new()
    if not file.file_exists(SAVE_FILE):
        music_data = ["My Soul Cries Out"]
        sound_data = ["Default"]
        skin_data = ["Default"]
        save_data()
    file.open(SAVE_FILE, File.READ)
    unlock_data = file.get_var()
    file.close()
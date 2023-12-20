extends Node

const SAVE_FILE ="user://save_file.save"
var unlock_data = []

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
        unlock_data = []
        save_data()
    file.open(SAVE_FILE, File.READ)
    unlock_data = file.get_var()
    file.close()
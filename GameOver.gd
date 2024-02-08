extends Control

export(String, FILE, "*.tscn") onready var game
export(String, FILE, "*.tscn") onready var title_screen

var LeaderboardName = "Godot"
var banHammer = 0

func _ready():
	
	if Global.score > Global.bestScore:
		Global.bestScore = Global.score
		$Control/BestScore.material = load("res://assets/shaders/gayyy.tres")
		Global.save_data()

	# Set final time based on score, format as human-readable
	$Control/FinalScore.text = "Time: " + str(int(Global.score / 60)) + ":" + str(int(Global.score) % 60).pad_zeros(2)
	$Control/BestScore.text = "Personal Best: " + str(int(Global.bestScore / 60)) + ":" + str(int(Global.bestScore) % 60).pad_zeros(2)
	$AudioStreamPlayer.stream = Global.game_over[randi() % Global.game_over.size()]
	$AudioStreamPlayer.play()

func _on_TryAgain_pressed():
	if ResourceLoader.exists(game):
		var _error = get_tree().change_scene(game)
		
func _on_TitleScreen_pressed():
	if ResourceLoader.exists(title_screen):
		var _error = get_tree().change_scene(title_screen)

func _on_ButtonEnabler_timeout():
	# This is so that people don't accidentally hit try again after the game ends
	$Control/TryAgain.disabled = false
	$Control/TitleScren.disabled = false

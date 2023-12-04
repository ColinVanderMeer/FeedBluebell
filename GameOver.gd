extends Control

export(String, FILE, "*.tscn") var game
export(String, FILE, "*.tscn") var title_screen

func _ready():
	# Set final time based on score, format as human-readable
	$Panel/FinalScore.text = "Time: " + str(int(ScoreManager.score / 60)) + " minutes\n" + str(int(ScoreManager.score) % 60) + " seconds"
	$AudioStreamPlayer.stream = SoundManager.game_over
	$AudioStreamPlayer.play()

func _on_TryAgain_pressed():
	if ResourceLoader.exists(game):
		var _error = get_tree().change_scene(game)
		
func _on_TitleScreen_pressed():
	if ResourceLoader.exists(title_screen):
		var _error = get_tree().change_scene(title_screen)

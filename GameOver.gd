extends Control

export(String, FILE, "*.tscn") var game
export(String, FILE, "*.tscn") var title_screen

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/FinalScore.text = "Time: " + str(int(ScoreManager.score / 60)) + " minutes\n" + str(int(ScoreManager.score) % 60) + " seconds"
	BackgroundMusic.stop()
	$AudioStreamPlayer.stream = SoundManager.game_over
	$AudioStreamPlayer.play()


func _on_TryAgain_pressed():
#	get_tree().change_scene_to(game)
	BackgroundMusic.play()
	if ResourceLoader.exists(game):
		var _error = get_tree().change_scene(game)
		
func _on_TitleScreen_pressed():
#	get_tree().change_scene_to(game)
	BackgroundMusic.play()
	if ResourceLoader.exists(title_screen):
		var _error = get_tree().change_scene(title_screen)

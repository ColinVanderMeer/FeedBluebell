extends Control

export(PackedScene) var game_over
export(String, FILE, "*.tscn") var title_screen
export var step = 20
var game_time = 0

func _ready():
	$ProgressBar.value = 100  # Start with full progress
	$ProgressBar.max_value = 100
	# $Timer.wait_time = 0.07

func _on_Timer_timeout():
	$ProgressBar.value -= 0.25   # Update the progress bar
	if $ProgressBar.value <= 0:
		get_tree().change_scene_to(game_over)
		# You can add your logic for what happens when the countdown reaches 0 here

	
func _on_Pig_update_consumed(type):
	if type:
		$ProgressBar.value += step
	else:
		$ProgressBar.value -= step


func _on_Trash_update_consumed(type):
	if type:
		$ProgressBar.value -= step
	else:
		$ProgressBar.value += step

func _process(delta):
	if !ScoreManager.pause:
		$Panel/Label.text = "Time: " + str(stepify(game_time, 0.01))
		ScoreManager.score = game_time
		game_time += delta


func _on_Button_pressed():
	ScoreManager.pause = not ScoreManager.pause
	$Timer.paused = ScoreManager.pause
	$PauseScreen.visible = ScoreManager.pause
	if ScoreManager.pause:
		BackgroundMusic.volume_db = -5.0
	else:
		BackgroundMusic.volume_db = 0.0

func _on_MenuButton_pressed():
	if ResourceLoader.exists(title_screen):
		ScoreManager.pause = not ScoreManager.pause
		$Timer.paused = ScoreManager.pause
		var _error = get_tree().change_scene(title_screen)

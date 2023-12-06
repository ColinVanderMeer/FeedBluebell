extends Control

export(PackedScene) var game_over
export(String, FILE, "*.tscn") var title_screen
export var STEP = 20
export var TIMER_STEP = 14
var game_time = 0
var coyote = 0

func _ready():
	$ProgressBar.value = 100
	$ProgressBar.max_value = 100

	
func _on_Pig_update_consumed(type):
	if type:
		$ProgressBar.value += STEP
	else:
		$ProgressBar.value -= STEP

# TODO: deprecated
func _on_Trash_update_consumed(type):
	if type:
		$ProgressBar.value -= STEP
	else:
		$ProgressBar.value += STEP

func _process(delta):
	if !ScoreManager.pause:
		# Update time based on current time passed
		$Panel/Label.text = "Time: " + str(stepify(game_time, 0.01))
		ScoreManager.score = game_time
		game_time += delta

		$ProgressBar.value -= TIMER_STEP * delta
		if $ProgressBar.value <= 0:
			# Gameover when progress bar is empty
			coyote += delta
			if coyote > 0.5:
				var _error = get_tree().change_scene_to(game_over)
		else:
			coyote = 0

func _on_Button_pressed():
	# Pause Button
	# set global pause variable, which other scripts use
	ScoreManager.pause = not ScoreManager.pause
	$PauseScreen.visible = ScoreManager.pause
	if ScoreManager.pause:
		# Lower bg music on pause screen
		# TODO: do this for other menus
		$AudioStreamPlayer.volume_db = -8.0
	else:
		# TODO: normalize SFX so we can set this to 0dB
		$AudioStreamPlayer.volume_db = -3.0

func _on_MenuButton_pressed():
	# Exit to menu
	if ResourceLoader.exists(title_screen):
		ScoreManager.pause = not ScoreManager.pause
		var _error = get_tree().change_scene(title_screen)

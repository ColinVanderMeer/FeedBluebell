extends Control

export(PackedScene) var game_over
export(String, FILE, "*.tscn") var title_screen
export var STEP = 20
export var TIMER_STEP = 17
var game_time = 0
var coyote = 0

func _ready():
	$ProgressBar.value = 0
	$AudioStreamPlayer.stream = load("res://assets/music/" + Global.music + ".ogg")

	
func _on_Pig_update_consumed(type):
	if type:
		$ProgressBar.value -= STEP
	else:
		$ProgressBar.value += STEP

# TODO: deprecated
func _on_Trash_update_consumed(type):
	if type:
		$ProgressBar.value += STEP
	else:
		$ProgressBar.value -= STEP

func _process(delta):
	if !Global.pause:
		# Update time based on current time passed
		$Label.text = "Time: " + str(stepify(game_time, 0.01))
		Global.score = game_time
		game_time += delta

		if game_time > 120:
			$ProgressBar.value += TIMER_STEP * delta * game_time / 120
		else:
			$ProgressBar.value += TIMER_STEP * delta
		
		if $ProgressBar.value >= 100:
			# Gameover when progress bar is empty
			coyote += delta
			$CanvasLayer/GrayRect.material.set_shader_param("fade_amount", coyote)
			if coyote > 1:
				var _error = get_tree().change_scene_to(game_over)
		else:
			coyote = 0
			$CanvasLayer/GrayRect.material.set_shader_param("fade_amount", 0)
			
		if game_time < 2:
			$ProgressBar.value = 0

func _on_Button_pressed():
	# Pause Button
	# set global pause variable, which other scripts use
	Global.pause = not Global.pause
	$PauseScreen.visible = Global.pause
	if Global.pause:
		# Lower bg music on pause screen
		# TODO: do this for other menus
		$AudioStreamPlayer.volume_db = -8.0
		$CanvasLayer/Button.icon = load("res://assets/gui/buttonResume.png")
	else:
		# TODO: normalize SFX so we can set this to 0dB
		$AudioStreamPlayer.volume_db = -3.0
		$CanvasLayer/Button.icon = load("res://assets/gui/buttonPause.png")

func _on_MenuButton_pressed():
	# Exit to menu
	if ResourceLoader.exists(title_screen):
		Global.pause = not Global.pause
		var _error = get_tree().change_scene(title_screen)

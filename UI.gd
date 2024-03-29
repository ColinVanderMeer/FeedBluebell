extends Control

export(PackedScene) var game_over
export(String, FILE, "*.tscn") var title_screen
export var STEP = 20
export var TIMER_STEP = 17
var game_time = 0
var coyote = 0
var coyote_death = false

func _ready():
	$ProgressBar.value = 0
	coyote_death = false
	$AudioStreamPlayer.stream = load("res://assets/music/" + Global.music + ".ogg")

	
func _on_food_consumed(type):
	if type:
		# Good food consumed
		$ProgressBar.value -= STEP
		$DamageRect.modulate.a = 1
		$DamageRect.rect_scale.x = 1
		$DamageRect.rect_position.y = get_viewport().get_visible_rect().size.y/2 + 153
		$DamageRect.modulate = Color("#84f174")
	else:
		# Bad food consumed
		$ProgressBar.value += STEP
		if $ProgressBar.value == 100 and coyote > 0.2:
			coyote_death = true
		$DamageRect.modulate.a = 1
		$DamageRect.rect_scale.x = 1
		$DamageRect.rect_position.y = get_viewport().get_visible_rect().size.y/2 + 153
		$DamageRect.modulate = Color("#f17486")

func _on_Game_farmer_consumed():
	# Farmer reached the end (good)
	$ProgressBar.value -= STEP
	$DamageRect.modulate.a = 1
	$DamageRect.rect_scale.x = 1
	$DamageRect.rect_position.y = get_viewport().get_visible_rect().size.y/2 + 153
	$DamageRect.modulate = Color("#84f174")

	$SFXplayer.stream = Global.good_food[randi() % Global.good_food.size()]
	$SFXplayer.play()

func _on_Game_farmer_spawn():
	# On farmer spawn add half health
	$ProgressBar.value -= STEP/2

func _process(delta):
	if !Global.pause:
		# Update time based on current time passed
		$Label.text = "Time: " + str(stepify(game_time, 0.01))
		Global.score = game_time
		game_time += delta

		if game_time > 120:
			$ProgressBar.value += TIMER_STEP * delta * game_time / 120
		elif game_time > 240:
			$ProgressBar.value += TIMER_STEP * delta * 240 / 120
		else:
			$ProgressBar.value += TIMER_STEP * delta
		
		if $ProgressBar.value >= 100:
			# Add 3/4 second of grace period (coyote time)
			coyote += delta
			$CanvasLayer/GrayRect.material.set_shader_param("fade_amount", coyote / 0.75)
			if coyote > 0.75 or coyote_death:
				# Game over
				var _error = get_tree().change_scene_to(game_over)
		else:
			# Reset coyote time
			coyote = 0
			$CanvasLayer/GrayRect.material.set_shader_param("fade_amount", 0)
			
		if game_time < 2:
			# Don't change health for the first 2 seconds
			$ProgressBar.value = 0

		$DamageRect.modulate.a -= 0.03 / 0.016667 * delta
		$DamageRect.rect_scale.x -= 0.01 / 0.016667 * delta
		$DamageRect.rect_position.y -= 1.5 / 0.016667 * delta

func _on_Button_pressed():
	# Pause Button
	# set global pause variable, which other scripts use
	Global.pause = not Global.pause
	$PauseScreen.visible = Global.pause
	if Global.pause:
		# Lower bg music on pause screen
		$AudioStreamPlayer.volume_db = -8.0
		$CanvasLayer/Button.icon = load("res://assets/gui/buttonResume.png")
	else:
		$AudioStreamPlayer.volume_db = -3.0
		$CanvasLayer/Button.icon = load("res://assets/gui/buttonPause.png")

func _on_MenuButton_pressed():
	# Exit to menu
	if ResourceLoader.exists(title_screen):
		Global.pause = not Global.pause
		var _error = get_tree().change_scene(title_screen)

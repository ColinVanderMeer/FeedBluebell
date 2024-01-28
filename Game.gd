extends Node2D

export(PackedScene) var FOOD
export(int) var BGSIZE

var ping = false
var scaling = Vector2(0.025,0.025)
var max_scale = Vector2(0.625,0.625)

signal farmer_consumed()
signal farmer_spawn()

func _ready():
	$UI/AudioStreamPlayer.play(0)
	Global.sinceFarmer = 0

	Global.good_food = []
	Global.bad_food = []
	Global.game_over = []

	match Global.soundpack:
		"Default":
			Global.good_food.append(load("res://assets/sfx/default/good_food.wav"))
			Global.bad_food.append(load("res://assets/sfx/default/bad_food.wav"))
			Global.game_over.append(load("res://assets/sfx/default/game_over.wav"))
		"Penny":
			Global.good_food.append(load("res://assets/sfx/penny/good_food_1.wav"))
			Global.good_food.append(load("res://assets/sfx/penny/good_food_2.wav"))
			Global.good_food.append(load("res://assets/sfx/penny/good_food_3.wav"))
			Global.bad_food.append(load("res://assets/sfx/penny/bad_food_1.wav"))
			Global.bad_food.append(load("res://assets/sfx/penny/bad_food_2.wav"))
			Global.bad_food.append(load("res://assets/sfx/penny/bad_food_3.wav"))
			Global.bad_food.append(load("res://assets/sfx/penny/bad_food_4.wav"))
			Global.game_over.append(load("res://assets/sfx/penny/game_over_1.wav"))
			Global.game_over.append(load("res://assets/sfx/penny/game_over_2.wav"))
			Global.game_over.append(load("res://assets/sfx/penny/game_over_3.wav"))
		"Rempel":
			Global.good_food.append(load("res://assets/sfx/rempel/good_food_1.wav"))
			Global.good_food.append(load("res://assets/sfx/rempel/good_food_2.wav"))
			Global.good_food.append(load("res://assets/sfx/rempel/good_food_3.wav"))
			Global.bad_food.append(load("res://assets/sfx/rempel/bad_food_1.wav"))
			Global.game_over.append(load("res://assets/sfx/rempel/game_over_1.wav"))
		"Scott":
			Global.good_food.append(load("res://assets/sfx/scott/good_food_1.wav"))
			Global.good_food.append(load("res://assets/sfx/scott/good_food_2.wav"))
			Global.good_food.append(load("res://assets/sfx/scott/good_food_3.wav"))
			Global.bad_food.append(load("res://assets/sfx/scott/bad_food_1.wav"))
			Global.bad_food.append(load("res://assets/sfx/scott/bad_food_2.wav"))
			Global.bad_food.append(load("res://assets/sfx/scott/bad_food_3.wav"))
			Global.bad_food.append(load("res://assets/sfx/scott/bad_food_4.wav"))
			Global.game_over.append(load("res://assets/sfx/scott/game_over_1.wav"))
			Global.game_over.append(load("res://assets/sfx/scott/game_over_2.wav"))
			

			

func _on_SpawnTimer_timeout():
	# Spawn new food item on set spawn position, dynamically update fall speed based on score
	var new_food = FOOD.instance()
	new_food.position = $SpawnPosition.global_position
	new_food.pig_target = $Pig.global_position
	new_food.trash_target = $Trash.global_position
	new_food.FALL_SPEED = 5 + Global.score / 15
	if Global.score > 300:
		new_food.FALL_SPEED = 25
	add_child(new_food)
	if new_food.farmer:
		emit_signal("farmer_spawn")

func _process(_delta):
	if Global.pause:
		$SpawnTimer.paused = true
	else:
		$SpawnTimer.paused = false
		if Global.score > 300:
			$SpawnTimer.wait_time = 0.3
		else:
			$SpawnTimer.wait_time = 1 - log(Global.score) / (16 - Global.score / 40)
	$Background.position.y = get_viewport().get_visible_rect().size.y - BGSIZE

func _on_Despawn_body_entered(body):
	if body.farmer:
		print("farmer consumed")
		emit_signal("farmer_consumed")
	body.queue_free()
	
	

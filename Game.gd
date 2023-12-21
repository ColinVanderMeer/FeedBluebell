extends Node2D

export(PackedScene) var FOOD
export(int) var BGSIZE

func _ready():
	$UI/AudioStreamPlayer.play(0)

func _on_SpawnTimer_timeout():
	# Spawn new food item on set spawn position, dynamically update fall speed based on score
	var new_food = FOOD.instance()
	new_food.position = $SpawnPosition.global_position
	new_food.pig_target = $Pig.global_position
	new_food.trash_target = $Trash.global_position
	new_food.FALL_SPEED = 5 + Global.score / 17 # TODO: make this better
	add_child(new_food)

func _process(_delta):
	if Global.pause:
		$SpawnTimer.paused = true
	else:
		$SpawnTimer.paused = false
		$SpawnTimer.wait_time = 1 - log(Global.score) / 20
	$Background2.position.y = get_viewport().get_visible_rect().size.y - BGSIZE

func _on_Despawn_body_entered(body):
	body.queue_free()

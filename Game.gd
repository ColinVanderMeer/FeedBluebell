extends Node2D

export(PackedScene) var FOOD

func _on_SpawnTimer_timeout():
	# Spawn new food item on set spawn position, dynamically update fall speed based on score
	var new_food = FOOD.instance()
	new_food.position = $SpawnPosition.global_position
	new_food.pig_target = $Pig.global_position
	new_food.trash_target = $Trash.global_position
	new_food.FALL_SPEED = 5 + ScoreManager.score / 20 # TODO: make this better
	add_child(new_food)

func _process(_delta):
	if ScoreManager.pause:
		$SpawnTimer.paused = true
	else:
		$SpawnTimer.paused = false
		$SpawnTimer.wait_time = 1 - log(ScoreManager.score) / 30
	$Background.position.y = get_viewport().get_visible_rect().size.y - 900

func _on_Despawn_body_entered(body):
	body.queue_free()

extends Node2D

export(PackedScene) var FOOD

func _on_SpawnTimer_timeout():
	var new_food = FOOD.instance()
	new_food.position = $SpawnPosition.global_position
	new_food.pig_target = $Pig.global_position
	new_food.trash_target = $Trash.global_position
	add_child(new_food)

extends Node2D

export(PackedScene) var FOOD

func _on_SpawnTimer_timeout():
	var new_food = FOOD.instance()
	new_food.position = $SpawnPosition.global_position
	new_food.target = $Pig.global_position
	add_child(new_food)

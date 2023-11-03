extends Control

export(PackedScene) var game

func _on_StartButton_pressed():
	var _error = get_tree().change_scene_to(game)

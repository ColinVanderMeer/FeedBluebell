extends Control

export(PackedScene) var game
export(PackedScene) var tutorial

	
func _on_StartButton_pressed():
	get_tree().change_scene_to(game)
	
func _on_TutorialButton_pressed():
	get_tree().change_scene_to(tutorial)

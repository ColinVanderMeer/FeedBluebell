extends Control

export(PackedScene) var game
export(PackedScene) var tutorial

	
func _on_StartButton_pressed():
	var _error = get_tree().change_scene_to(game)
	
func _on_TutorialButton_pressed():
	var _error = get_tree().change_scene_to(tutorial)

func _on_SettingsButton_pressed():
	$Settings.visible = true

extends Control

export(PackedScene) var game
export(PackedScene) var tutorial
	
func _on_StartButton_pressed():
	var _error = get_tree().change_scene_to(game)
	
func _on_TutorialButton_pressed():
	var _error = get_tree().change_scene_to(tutorial)

func _on_SettingsButton_pressed():
	$Settings/Background.scale = get_viewport_rect().size
	$Settings/Background.position = get_viewport_rect().size / 2
	$Settings.visible = true

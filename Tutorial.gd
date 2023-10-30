extends Button

export(PackedScene) var game

func _on_Button_pressed():
	get_tree().change_scene_to(game)

extends Control

export(PackedScene) onready var game
export(PackedScene) onready var tutorial

func _on_StartButton_pressed():
	var _error = get_tree().change_scene_to(game)

func _on_TutorialButton_pressed():
	$Tutorial.visible = true

func _on_SettingsButton_pressed():
	$Settings.visible = true

func _on_CreditsButton_pressed():
	$Credits.visible = true

func _on_LeaderboardButton_pressed():
	$Leaderboard.visible = true

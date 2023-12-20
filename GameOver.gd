extends Control

export(String, FILE, "*.tscn") onready var game
export(String, FILE, "*.tscn") onready var title_screen

var LeaderboardName = "Godot"

func _ready():
	# Set final time based on score, format as human-readable
	$Panel/FinalScore.text = "Time: " + str(int(ScoreManager.score / 60)) + " minutes\n" + str(int(ScoreManager.score) % 60) + " seconds"
	$AudioStreamPlayer.stream = SoundManager.game_over
	$AudioStreamPlayer.play()

	

func _on_TryAgain_pressed():
	if ResourceLoader.exists(game):
		var _error = get_tree().change_scene(game)
		
func _on_TitleScreen_pressed():
	if ResourceLoader.exists(title_screen):
		var _error = get_tree().change_scene(title_screen)


func _make_post(url, data, ssl):
	var query = JSON.print(data)
	print(query)
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(url, headers, ssl, HTTPClient.METHOD_POST, query)


func _on_LeaderboardButton_pressed():
	LeaderboardName = $Panel/LeaderboardEntry.text
	_make_post("http://127.0.0.1:8080/api/new", {"score":ScoreManager.score, "name":LeaderboardName, "key":"test"}, false)

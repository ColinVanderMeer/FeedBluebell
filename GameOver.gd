extends Control

export(String, FILE, "*.tscn") onready var game
export(String, FILE, "*.tscn") onready var title_screen

var LeaderboardName = "Godot"

func _ready():
	
	# Set final time based on score, format as human-readable
	$Panel/FinalScore.text = "Time: " + str(int(Global.score / 60)) + " minutes\n" + str(int(Global.score) % 60) + " seconds"
	$AudioStreamPlayer.stream = Global.game_over
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
	if not len($Panel/Name.text) > 18:
		LeaderboardName = $Panel/Name.text
		_make_post("https://bluebell.starlightt.xyz/api/new/", {"name":LeaderboardName, "score":int(Global.score), "key":"test"}, true)
		$Panel/LeaderboardButton.visible = false
	else:
		OS.alert("Name must be less than 19 characters")

extends Control

export(String, FILE, "*.tscn") onready var game
export(String, FILE, "*.tscn") onready var title_screen

var LeaderboardName = "Godot"

func _ready():
	
	if Global.score > Global.bestScore:
		Global.bestScore = Global.score
		Global.save_data()

	# Set final time based on score, format as human-readable
	$Control/FinalScore.text = "Time: " + str(int(Global.score / 60)) + ":" + str(int(Global.score) % 60).pad_zeros(2)
	$Control/BestScore.text = "Personal Best: " + str(int(Global.bestScore / 60)) + ":" + str(int(Global.bestScore) % 60).pad_zeros(2)
	$AudioStreamPlayer.stream = Global.game_over[randi() % Global.game_over.size()]
	$AudioStreamPlayer.play()


	
	if OS.get_name() == "HTML5":
		$Control/LeaderboardButton.visible = false
		var _error = $Control/LeaderboardEntry.connect("focus_exited", self, "_on_LeaderboardButton_pressed")

	

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
	if not len($Control/LeaderboardEntry.text) > 18:
		LeaderboardName = $Control/LeaderboardEntry.text
		var keyHash = str(int(Global.score)) + LeaderboardName
		keyHash = keyHash.sha256_text()
		_make_post("https://bluebell.vandermeer.tech/api/new/", {"name":LeaderboardName, "score":int(Global.score), "key":keyHash}, true)
		$Control/LeaderboardButton.visible = false
		$Control/LeaderboardEntry.modulate = Color(110 / 255, 255 / 255, 0)
		if Global.score == Global.bestScore:
			Global.bestName = LeaderboardName
			Global.save_data()
	else:
		OS.alert("Name must be less than 19 characters")



func _on_ButtonEnabler_timeout():
	# This is so that people don't accidentally try again after the game ends
	$Control/TryAgain.disabled = false
	$Control/TitleScren.disabled = false

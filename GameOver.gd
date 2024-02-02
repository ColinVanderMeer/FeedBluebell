extends Control

export(String, FILE, "*.tscn") onready var game
export(String, FILE, "*.tscn") onready var title_screen

var LeaderboardName = "Godot"
var banHammer = 0

func _ready():
	
	if Global.score > Global.bestScore:
		Global.bestScore = Global.score
		$Control/BestScore.material = load("res://assets/shaders/gayyy.tres")
		Global.save_data()

	# Set final time based on score, format as human-readable
	$Control/FinalScore.text = "Time: " + str(int(Global.score / 60)) + ":" + str(int(Global.score) % 60).pad_zeros(2)
	$Control/BestScore.text = "Personal Best: " + str(int(Global.bestScore / 60)) + ":" + str(int(Global.bestScore) % 60).pad_zeros(2)
	$AudioStreamPlayer.stream = Global.game_over[randi() % Global.game_over.size()]
	$AudioStreamPlayer.play()

	if Global.banDate != 0:
		$Control/LeaderboardEntry.visible = false
		$Control/LeaderboardButton.visible = false
	
	# If the game is running on HTML5, hide the entry button as name will auto submit instead
	if OS.get_name() == "HTML5":
		$Control/LeaderboardButton.visible = false
		var _error = $Control/LeaderboardEntry.connect("focus_exited", self, "_on_LeaderboardButton_pressed")

	# If the player has a score of 4 minutes or more, unlock the gold skin
	if Global.score > 240:
		if not Global.skin_data.has("Gold"):
			Global.skin_data.append("Gold")
			Global.save_data()
			$GoldBG.visible = true
			$GoldPanel.visible = true
	else:
		pass


func _make_post(url, data, ssl):
	var query = JSON.print(data)
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(url, headers, ssl, HTTPClient.METHOD_POST, query)

func _on_LeaderboardButton_pressed():
	# If user doesn't enter a name, don't submit
	if $Control/LeaderboardEntry.text == "" or $Control/LeaderboardEntry.text == "Null":
		OS.alert("Please enter a name")
		return
	if not len($Control/LeaderboardEntry.text) > 18:
		LeaderboardName = $Control/LeaderboardEntry.text
		# Hash the score and name to prevent cheating
		var keyHash = str(int(Global.score)) + LeaderboardName
		keyHash = keyHash.sha256_text()
		_make_post("https://bluebell.vandermeer.tech/api/new/", {"name":LeaderboardName, "score":int(Global.score), "key":keyHash, "id":Global.playerID}, true)
		$Control/LeaderboardButton.visible = false
		$Control/LeaderboardEntry.modulate = Color(110 / 255, 255 / 255, 0)
	else:
		# If the name is too long, don't submit
		OS.alert("Name must be less than 19 characters")

func _on_HTTPRequest_request_completed(_result:int, response_code:int, _headers:PoolStringArray, body:PoolByteArray):
	if response_code == 200:
		var body_string = body.get_string_from_utf8()
		var json_data = JSON.parse(body_string)

		# Set id so user can submit to that id next time
		Global.playerID = json_data.result["id"]

		if Global.score == Global.bestScore:
			# If the score is a new best, show the users new position on the leaderboard
			$Control/NewBestLeaderboard.visible = true
			$Control/NewBestLeaderboard.text = "New Best: #" + str(json_data.result["position"])
		Global.save_data()
	if response_code == 400:
		var body_string = body.get_string_from_utf8()
		var json_data = JSON.parse(body_string)
		
		if json_data.result["name"].has("Potentially nickname offensive held for review"):
			# If the name is blocked warn user
			OS.alert("Something in your nickname seemed not rockway appropriate. Subsequent failed attempts may result in leaderboard ban.")
			banHammer += 1
			Global.save_data()
		else:
			# Something went very wrong or hash was blocked
			OS.alert("Something went wrong, please try again.")
			
		$Control/LeaderboardEntry.modulate = Color(1, 1, 1)
		
		# If the user has 3 failed attempts remove the entry box
		if banHammer >= 3:
			$Control/LeaderboardEntry.visible = false
			Global.bannerHammer += 1
			# If the user has 2 failed attempts ban them from the leaderboard for 24 hours
			if Global.bannerHammer >= 2:
				Global.banDay()
		elif OS.get_name() != "HTML5":
			$Control/LeaderboardButton.visible = true
		

func _on_BackButton_pressed():
	$GoldBG.visible = false
	$GoldPanel.visible = false

func _on_TryAgain_pressed():
	if ResourceLoader.exists(game):
		var _error = get_tree().change_scene(game)
		
func _on_TitleScreen_pressed():
	if ResourceLoader.exists(title_screen):
		var _error = get_tree().change_scene(title_screen)

func _on_ButtonEnabler_timeout():
	# This is so that people don't accidentally hit try again after the game ends
	$Control/TryAgain.disabled = false
	$Control/TitleScren.disabled = false
	$GoldPanel/BackButton.disabled = false

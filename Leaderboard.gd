extends Control

var http_request
var i

func _on_BackButton_pressed():
	self.visible = false

func _ready():
	# Set up the request parameters
	var url = "https://bluebell.vandermeer.tech/api/scores/"
	var headers = []
	
	# Send the request
	$HTTPRequest.request(url, headers)

	if Global.playerID == -1:
		$Panel/AroundMe.disabled = true


func _on_HTTPRequest_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		# Parse the JSON response
		var body_string = body.get_string_from_utf8()
		var json_data = JSON.parse(body_string)

		$Panel/NameLabel.text = ""
		$Panel/ScoreLabel.text = ""

		# If the JSON data has a "playerRanking" key, then we know that the request was for around me and not all time
		if json_data.result.has("playerRanking"):
			# Access the value of "playerRanking"
			var player_ranking = json_data.result["playerRanking"]
			i = 1
			for item in json_data.result["scores"]:
				# Get name and score from the JSON data
				var name = item.get("name")
				var score = int(item.get("topScore"))
				var position = int(item.get("position"))

				# Calculate the time in minutes and seconds
				var minutes = int(score / 60)
				var seconds = int(score % 60)

				# If the position is the same as the player's position, then display their name in blue
				if position == player_ranking:
					$Panel/NameLabel.append_bbcode("[color=#69a5d4]" + str(position) + ". " + name + "[/color]\n")
					$Panel/ScoreLabel.text += "%dm %ds" % [minutes, seconds] + "\n"
					continue
				# Display the information in the label
				$Panel/NameLabel.append_bbcode(str(position) + ". " + name + "\n")
				$Panel/ScoreLabel.text += "%dm %ds" % [minutes, seconds] + "\n"
		else: # All time leaderboard
			i = 1
			# Iterate through each item in the JSON array
			for item in json_data.result:
				# Get name and score from the JSON data
				var name = item.get("name")
				var score = int(item.get("topScore"))

				# Calculate the time in minutes and seconds
				var minutes = int(score / 60)
				var seconds = int(score % 60)

				# Display the information in the label
				$Panel/NameLabel.text += str(i) + ". " + name + "\n"
				$Panel/ScoreLabel.text += "%dm %ds" % [minutes, seconds] + "\n"
				i += 1
	else:
		print("HTTP request failed with response code:", response_code)
		print("Error body:", body)


func _on_AllTime_pressed():
	$Panel/AllTime.disabled = true
	$Panel/AroundMe.disabled = false
	$Panel/NameLabel.text = "Loading..."
	$Panel/ScoreLabel.text = ""

	var url = "https://bluebell.vandermeer.tech/api/scores"
	var headers = []
	
	# Send the request
	$HTTPRequest.request(url, headers)

func _on_AroundMe_pressed():
	$Panel/AllTime.disabled = false
	$Panel/AroundMe.disabled = true
	$Panel/NameLabel.text = "Loading..."
	$Panel/ScoreLabel.text = ""

	var url = "https://bluebell.vandermeer.tech/api/scores?id=" + str(Global.playerID)
	var headers = []
	
	# Send the request
	$HTTPRequest.request(url, headers)

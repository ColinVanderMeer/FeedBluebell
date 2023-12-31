extends Control

var http_request

func _on_BackButton_pressed():
	self.visible = false

func _ready():
	
	# Set up the request parameters
	var url = "https://bluebell.vandermeer.tech/api/scores"
	var headers = []
	
	# Send the request
	$HTTPRequest.request(url, headers)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == 200:
		# Parse the JSON response
		var body_string = body.get_string_from_utf8()

		var json_data = JSON.parse(body_string)

		$Panel/NameLabel.text = ""
		$Panel/ScoreLabel.text = ""

		# Iterate through each item in the JSON array
		for item in json_data.result:
			# Get name and score from the JSON data
			var name = item.get("name")
			var score = int(item.get("score"))

			# Calculate the time in minutes and seconds
			var minutes = int(score / 60)
			var seconds = int(score % 60)

			# Display the information in the label
			var display_text = "%s -- %dm %ds" % [name, minutes, seconds]
			$Panel/NameLabel.text += name + "\n"
			$Panel/ScoreLabel.text += "%dm %ds" % [minutes, seconds] + "\n"
	else:
		print("HTTP request failed with response code:", response_code)
		print("Error body:", body)

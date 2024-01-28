extends LineEdit

func _ready():
	# Check if platform is HTML5 so I don't get errors in the editor
	if OS.get_name() == "HTML5":
		var _error = connect("focus_entered", self, "js_text_entry")

func js_text_entry():
	text = JavaScript.eval(
			"prompt('%s', '%s');" % ["Please Enter your name for the leaderboard:", text], 
			true
			)
	
	release_focus()

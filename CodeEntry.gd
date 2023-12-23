extends LineEdit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "HTML5":
		var _error = connect("focus_entered", self, "js_text_entry")

func js_text_entry():
	text = JavaScript.eval(
			"prompt('%s', '%s');" % ["Please Enter " + self.name + ":", text], 
			true
			)
	
	release_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

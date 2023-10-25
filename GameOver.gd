extends Control

export(String, FILE, "*.tscn") var game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/FinalScore.text = "Time: " + str(ScoreManager.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
#	get_tree().change_scene_to(game)
	if ResourceLoader.exists(game):
		var _error = get_tree().change_scene(game)

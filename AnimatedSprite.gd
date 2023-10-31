extends AnimatedSprite

var type = true

# NEED BAD FOOD AFTER CAROT AND ABOVE
var foods = ["apple", "bottle", "broccoli", "meat", "carrot", "cheese", "granola", "grapes", "pasta", "sandwich"]

func _ready():
	randomize()
	play_random_animation()

func play_random_animation():
	var animation_id = randi() % (2 + int(ScoreManager.score / 10))
	var animation_name = foods[animation_id]
	if animation_name == "bottle":
		type = false
	if animation_name == "meat":
		type = false
	play(animation_name)

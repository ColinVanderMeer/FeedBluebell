extends AnimatedSprite

var type = true

# NEED BAD FOOD AFTER CAROT AND ABOVE
var foods = ["apple", "bottle", "broccoli", "meat", "carrot", "wrapper", "cheese", "spoon", "grapes", "granola", "pasta", "sandwich"]

func _ready():
	randomize()
	play_random_animation()

func play_random_animation():
	var animation_id = randi() % (2 + int(ScoreManager.score / 5))
	var animation_name = foods[animation_id]
	if animation_name == "bottle"\
	or animation_name == "meat"\
	or animation_name == "wrapper"\
	or animation_name == "spoon":
		type = false
	play(animation_name)

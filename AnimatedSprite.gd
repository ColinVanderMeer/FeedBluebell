extends AnimatedSprite

var type = true
var animation_id = 0

# NEED BAD FOOD AFTER CAROT AND ABOVE
var foods = ["apple", "bottle", "broccoli", "meat", "carrot", "wrapper", "cheese", "spoon", "grapes", "milk", "granola", "fish", "pasta", "cupcake", "sandwich"]

func _ready():
	randomize()
	play_random_animation()

func play_random_animation():
	if int(ScoreManager.score / 5) > 10:
		animation_id = randi() % 12
	else:	
		animation_id = randi() % (2 + int(ScoreManager.score / 5))
	var animation_name = foods[animation_id]
	if animation_name == "bottle"\
	or animation_name == "meat"\
	or animation_name == "wrapper"\
	or animation_name == "spoon"\
	or animation_name == "milk"\
	or animation_name == "fish"\
	or animation_name == "cupcake":
		type = false
	play(animation_name)

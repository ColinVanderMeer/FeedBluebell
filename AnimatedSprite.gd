extends AnimatedSprite

var type = true

func _ready():
	randomize()
	play_random_animation()

func play_random_animation():
	var animations = frames.get_animation_names()
	var animation_id = randi() % animations.size()
	if ScoreManager.score < 30 and animation_id > 1:
		animation_id = animation_id / 2
	var animation_name = animations[animation_id]
	if animation_name == "bottle":
		type = false
	if animation_name == "meat":
		type = false
	play(animation_name)

extends AnimatedSprite

var type = true

func _ready():
	randomize()
	play_random_animation()

func play_random_animation():
	var animations = frames.get_animation_names()
	var animation_id = randi() % animations.size()
	var animation_name = animations[animation_id]
	if animation_name == "bottle":
		type = false
	if animation_name == "meat":
		type = false
	play(animation_name)

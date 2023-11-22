extends Position2D

func _process(delta):
	# Ensures that the spawn position is always in the middle of the screen
	self.position.y = get_viewport().get_visible_rect().size.y/2

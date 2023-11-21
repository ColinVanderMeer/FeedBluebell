extends Position2D


func _process(delta):
	self.position.y = get_viewport().get_visible_rect().size.y/2

extends StaticBody2D

# How many food items have been consumed, deprecated
var consumed = 0
signal update_consumed(type)

var ping = false
var scaling = Vector2(0.025,0.025)
var max_scale = Vector2(0.5,0.5)

func _process(delta):
	# Ensure always on the bottom of screen
	self.position.y = get_viewport().get_visible_rect().size.y - 150
	if ping and ($Ping.scale < max_scale):
		$Ping.scale += scaling
		$Ping.modulate.a -= 0.05
	elif $Ping.scale >= max_scale:
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		ping = false


func _on_Area2D_body_entered(body):
	if body.type:
		$FoodSFX.stream = SoundManager.good_food
		$FoodSFX.volume_db = -5.0 # TODO: why?
		$AnimatedSprite.play("happy") # TODO: use better animation system
		$Timer.start()
		
		$Ping.modulate = Color("#84f174")
		ping = true
	else:
		$FoodSFX.stream = SoundManager.bad_food
		$FoodSFX.volume_db = 5.0
		$AnimatedSprite.play("sad")
		$Timer.start()
		
		$Ping.modulate = Color("#f17486")
		ping = true

	$FoodSFX.play()
	emit_signal("update_consumed", body.type)
	body.queue_free()

func _on_Timer_timeout():
	$AnimatedSprite.play("neutral")

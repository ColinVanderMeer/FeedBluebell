extends StaticBody2D

var consumed = 0
signal update_consumed(c)

var ping = false
var scaling = Vector2(0.025,0.025)
var max_scale = Vector2(0.625,0.625)

func _on_Area2D_body_entered(body):
	if !body.type:
		$FoodSFX.stream = Global.good_food
		# TODO: remove these, and make sure audio is normalized
		$FoodSFX.volume_db = -5.0
		
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		
		$Ping.modulate = Color("#84f174")
		ping = true
	else:
		$FoodSFX.stream = Global.bad_food
		$FoodSFX.volume_db = 5.0
		
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		
		$Ping.modulate = Color("#f17486")
		ping = true
	
	$FoodSFX.play()
	emit_signal("update_consumed", body.type)
	body.queue_free()

func _process(delta):
	if ping and ($Ping.scale < max_scale):
		$Ping.scale += scaling / 0.016667 * delta # delta time hack to make sure scaling is consistent across framerate
		$Ping.modulate.a -= 0.04 / 0.016667 * delta
	elif $Ping.scale >= max_scale:
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		ping = false

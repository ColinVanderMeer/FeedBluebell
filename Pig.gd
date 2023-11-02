extends StaticBody2D

var consumed = 0
signal update_consumed(type)

func _on_Area2D_body_entered(body):
	if body.type:
		$FoodSFX.stream = SoundManager.good_food
		$FoodSFX.volume_db = -5.0
	else:
		$FoodSFX.stream = SoundManager.bad_food
		$FoodSFX.volume_db = 5.0
	$FoodSFX.play()
	emit_signal("update_consumed", body.type)
	body.queue_free()

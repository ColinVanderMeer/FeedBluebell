extends StaticBody2D

var consumed = 0
signal update_consumed(c)

export(AudioStream) var good_food
export(AudioStream) var bad_food

func _on_Area2D_body_entered(body):
	if !body.type:
		$FoodSFX.stream = good_food
		$FoodSFX.volume_db = -5.0
	else:
		$FoodSFX.stream = bad_food
		$FoodSFX.volume_db = 5.0
	$FoodSFX.play()
	emit_signal("update_consumed", body.type)
	body.queue_free()


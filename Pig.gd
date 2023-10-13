extends StaticBody2D

var consumed = 0
signal update_consumed(c)

func _on_Area2D_body_entered(body):
	body.queue_free()
	consumed += 1
	emit_signal("update_consumed", consumed)

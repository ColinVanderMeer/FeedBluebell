extends StaticBody2D

var consumed = 0
signal update_consumed(c)

func _on_Area2D_body_entered(body):
	emit_signal("update_consumed", body.type)
	body.queue_free()

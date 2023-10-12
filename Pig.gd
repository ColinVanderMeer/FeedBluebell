extends StaticBody2D

var consumed = 0

func _on_Area2D_body_entered(body):
	if body.get_name() == "Food":
		body.queue_free()
		consumed += 1
		print(consumed)

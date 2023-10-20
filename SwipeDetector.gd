extends Node

signal swiped(direction)
signal swipe_canceled(start_position)

export (float, 1.0, 1.5) var MAX_DIAGONAL_SLOPE = 1.3

onready var timer = $Timer
var swipe_start_position = Vector2()

func _on_Food_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			_start_detection(event.position)
func _input(event):
	if event is InputEventMouseButton:
		if not timer.is_stopped():
			_end_detection(event.position)
		
func _start_detection(position):
	swipe_start_position = position
	timer.start()
	
func _end_detection(position):
	timer.stop()
	var direction = position - swipe_start_position
	
	if abs(direction.x) > 30:
		emit_signal('swiped', Vector2(sign(direction.x), 0.0))


func _on_Timer_timeout():
	emit_signal('swipe_canceled', swipe_start_position)

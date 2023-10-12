extends KinematicBody2D

export (int) var speed = 300

var velocity = Vector2()
var detect = true

func _on_SwipeDetector_swiped(direction):
	if detect:
		velocity = -direction * speed
		detect = false

func _physics_process(delta):
	move_and_slide(velocity)

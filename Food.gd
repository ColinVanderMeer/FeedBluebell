extends KinematicBody2D

export var FALL_SPEED = 5

var detect = true
var direction = Vector2.ZERO
var _velocity = Vector2.ZERO
var t = 0.0
onready var start = self.position
var target = Vector2.ZERO

func _on_SwipeDetector_swiped(dir):
	if detect:
		#dir.y = self.global_position.y - 500
		direction = -dir
		detect = false

func generate_curve(t: float):
	#var middle = start.linear_interpolate(target, 0.5)
	var middle = Vector2.ZERO
	middle.x = target.x+100
	middle.y = target.y - (target.y - start.y)
	return _quadratic_bezier(start, middle, target, t)

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = lerp(p0, p1, t)
	var q1 = lerp(p1, p2, t)
	var r = lerp(q0, q1, t)
	return r

func _physics_process(delta):
	if !detect:
		t += delta
		position = generate_curve(t)
	else:
		position.y += FALL_SPEED
		start = self.position

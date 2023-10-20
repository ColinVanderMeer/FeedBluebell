extends KinematicBody2D

export var FALL_SPEED = 5
export var SPEED = 1.5

var detect = true
var direction = Vector2.ZERO
var _velocity = Vector2.ZERO
var t = 0.0
onready var start = self.position
var target = Vector2.ZERO
var pig_target = Vector2.ZERO
var trash_target = Vector2.ZERO

onready var timer = $Timer
var swipe_start_position = Vector2()

func _on_Food_input_event(_viewport, event, _shape_idx):
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
	direction = position - swipe_start_position
	
	if abs(direction.x) > 30:
		if direction.x > 0:
			target = trash_target
		else:
			target = pig_target
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
		t += delta*2
		t = clamp(t, 0, SPEED)
		position = generate_curve(t)
	else:
		position.y += FALL_SPEED
		start = self.position

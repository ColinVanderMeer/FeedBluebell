extends StaticBody2D

signal update_consumed(type)

var ping = false
var scaling = Vector2(0.05,0.05)
var max_scale = Vector2(1.25,1.25)

func _ready():
	# Load skin on ready
	match Global.skin:
		"Rainbow":
			$AnimatedSprite.material = load("res://assets/shaders/gayyy.tres")
		"Merch":
			$AnimatedSprite.frames = load("res://assets/characters/merch/merchFrame.tres")
		"Fumo":
			$AnimatedSprite.frames = load("res://assets/characters/funnyFumo/fumo.tres")
			$AnimatedSprite.scale = Vector2(2,2)
		"Wide":
			$AnimatedSprite.scale = Vector2(0.816,0.408)
		"Rain":
			$AnimatedSprite.frames = load("res://assets/characters/rainDown/rainFrame.tres")
		"Think":
			$AnimatedSprite.frames = load("res://assets/characters/think/thinkFrame.tres")
		"Miku":
			$AnimatedSprite.frames = load("res://assets/characters/miku/mikuFrame.tres")
		"Gold":
			$AnimatedSprite.frames = load("res://assets/characters/gold/goldFrame.tres")
		"Ballet":
			$AnimatedSprite.frames = load("res://assets/characters/ballet/balletFrame.tres")
		"Cowbell":
			$AnimatedSprite.frames = load("res://assets/characters/cowbell/cowbellFrame.tres")
		"Hamjam":
			$AnimatedSprite.frames = load("res://assets/characters/hamjam/hamjamFrame.tres")
		_:
			# Default skin is already loaded so do nothing
			pass


func _on_Area2D_body_entered(body):
	if body.type and !body.farmer:
		# Play random sound from good food array
		$FoodSFX.stream = Global.good_food[randi() % Global.good_food.size()]
		$AnimatedSprite.play("happy")
		$Timer.start()
		
		# Set ping to full opacity and scale to 0.05
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		
		# Set ping color to green
		$Ping.modulate = Color("#84f174")
		ping = true

		emit_signal("update_consumed", true)
	elif body.farmer:
		# Play random sound from bad food array
		$FoodSFX.stream = Global.bad_food[randi() % Global.bad_food.size()]
		$AnimatedSprite.play("sad")
		$Timer.start()
		
		# Set ping to full opacity and scale to 0.05
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		
		# Set ping color to red
		$Ping.modulate = Color("#f17486")
		ping = true

	else:
		# Play random sound from bad food array
		$FoodSFX.stream = Global.bad_food[randi() % Global.bad_food.size()]
		$AnimatedSprite.play("sad")
		$Timer.start()
		
		# Set ping to full opacity and scale to 0.05
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		
		# Set ping color to red
		$Ping.modulate = Color("#f17486")
		ping = true

		emit_signal("update_consumed", false)

	# Play sound effect and remove food
	$FoodSFX.play()
	body.queue_free()


func _process(delta):
	# Ensure always on the bottom of screen
	self.position.y = get_viewport().get_visible_rect().size.y - 150
	if ping and ($Ping.scale < max_scale):
		$Ping.scale += scaling / 0.016667 * delta # delta time hack to make sure scaling is consistent across framerate
		$Ping.modulate.a -= 0.04 / 0.016667 * delta
	elif $Ping.scale >= max_scale:
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		ping = false

func _on_Timer_timeout():
	# Reset animation to neutral
	$AnimatedSprite.play("neutral")

extends StaticBody2D

# How many food items have been consumed, deprecated
var consumed = 0
signal update_consumed(type)

var ping = false
var scaling = Vector2(0.05,0.05)
var max_scale = Vector2(1.25,1.25)


func _ready():
	match Global.skin:
		"Rainbow":
			$AnimatedSprite.material = load("res://assets/shaders/gayyy.tres")
		"Merch":
		# change happy and sad sprites to merch
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
			pass

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


func _on_Area2D_body_entered(body):
	if body.type and !body.farmer:
		$FoodSFX.stream = Global.good_food[randi() % Global.good_food.size()]
		$AnimatedSprite.play("happy") # TODO: use better animation system
		$Timer.start()
		
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		
		$Ping.modulate = Color("#84f174")
		ping = true

		emit_signal("update_consumed", true)
	elif body.farmer:
		$FoodSFX.stream = Global.bad_food[randi() % Global.bad_food.size()]
		$AnimatedSprite.play("sad")
		$Timer.start()
		
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		
		$Ping.modulate = Color("#f17486")
		ping = true

	else:
		$FoodSFX.stream = Global.bad_food[randi() % Global.bad_food.size()]
		$AnimatedSprite.play("sad")
		$Timer.start()
		
		$Ping.scale = scaling
		$Ping.modulate.a = 1
		
		$Ping.modulate = Color("#f17486")
		ping = true

		emit_signal("update_consumed", false)

	$FoodSFX.play()
	body.queue_free()

func _on_Timer_timeout():
	$AnimatedSprite.play("neutral")

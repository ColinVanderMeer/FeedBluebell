extends AnimatedSprite

var type = true
var farmer = false
var animation_id = 0
var sinceFarmer = 0

# NEED BAD FOOD AFTER CAROT AND ABOVE
# TODO: what the hell is this
var foods = ["apple", "bottle", "cookie", "milk", "rockMeat", "carrot", "wrapper", "cheese", "sandwichBag", "grapes", "meat", "granola", "fish", "pasta", "cupcake", "sandwich", "spoon", "cookieBag", "broccoli", "tim", "cupcakeUnwrapped", "rockFish", "boehm", "ds"]

func _ready():
	randomize()
	play_random_animation()

func play_random_animation():
	if int(Global.score / 5) > 22:
		animation_id = randi() % 24
	else:	
		animation_id = randi() % (2 + int(Global.score / 5))
	var animation_name = foods[animation_id]
	# TODO: bruh
	if animation_name == "bottle"\
	or animation_name == "meat"\
	or animation_name == "wrapper"\
	or animation_name == "spoon"\
	or animation_name == "milk"\
	or animation_name == "fish"\
	or animation_name == "sandwichBag"\
	or animation_name == "cookieBag"\
	or animation_name == "tim"\
	or animation_name == "cupcake":
		type = false
	if animation_name == "boehm"\
	or animation_name == "ds":
		if randi() %  6 != 0 and sinceFarmer < 8:
			animation_name = "apple"
		else:
			farmer = true
	sinceFarmer += 1
	play(animation_name)

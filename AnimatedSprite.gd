extends AnimatedSprite

var type = true
var farmer = false
var animation_id = 0

# Array of all the foods and the order they appear
var foods = ["apple", "bottle", "cookie", "milk", "rockMeat", "carrot", "ds", "cheese", "wrapper", "grapes", "meat", "granola", "fish", "pasta", "cupcake", "sandwich", "spoon", "cookieBag", "broccoli", "tim", "cupcakeUnwrapped", "rockFish", "sandwichBag", "boehm"]

func _ready():
	randomize()
	play_random_animation()

func play_random_animation():
	# If the score is too high limit to only 24 foods so we don't index out of bounds
	if int(Global.score / 5) > 22:
		animation_id = randi() % 24
	else:	
		animation_id = randi() % (2 + int(Global.score / 5))
	var animation_name = foods[animation_id]

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
		# Make farmers rare by only having them appear 1/3 of the time
		if randi() % 3 != 0 or Global.sinceFarmer < 6:
			animation_name = "apple"
		else:
			farmer = true
			Global.sinceFarmer = 0
			
	Global.sinceFarmer += 1
	play(animation_name)

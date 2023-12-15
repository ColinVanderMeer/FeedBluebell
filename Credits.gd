extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_BackButton_pressed():
	self.visible = false

func _on_CodeButton_pressed():
	print($Panel/CodeEntry.text)
	if $Panel/CodeEntry.text == "1234":
		print("un")
		$Panel/CodeEntry.text = "Correct"
	else:
		$Panel/CodeEntry.text = "Incorrect"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_ThirdPartyButton_pressed():
	$ThirdParty.visible = true
	$Panel/BackButton.visible = false
func _on_ThridBackButton_pressed():
	$ThirdParty.visible = false
	$Panel/BackButton.visible = true

extends Control

var 	fumoEnable = 0

func _on_BackButton_pressed():
	self.visible = false
	Global.save_data()

func _on_ThirdPartyButton_pressed():
	$ThirdParty.visible = true
	$Panel/BackButton.visible = false
	fumoEnable += 1
	if fumoEnable == 6:
		Global.skin_data.append("Fumo")
		Global.skin = "Fumo"
		Global.currentSkinIndex = 11
		OS.alert("Funny Fumo Function has been activated")
	
func _on_ThridBackButton_pressed():
	$ThirdParty.visible = false
	$Panel/BackButton.visible = true

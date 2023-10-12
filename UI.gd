extends Control


func _on_Pig_update_consumed(c):
	$Panel/Label.text = "Consumed: " + str(c)

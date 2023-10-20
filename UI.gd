extends Control

export(PackedScene) var menu

func _ready():
	$ProgressBar.value = 7  # Start with full progress
	$ProgressBar.max_value = 7

func _on_Timer_timeout():
	$ProgressBar.value -= 1   # Update the progress bar
	if $ProgressBar.value <= 0:
		get_tree().change_scene_to(menu)
		# You can add your logic for what happens when the countdown reaches 0 here

	
func _on_Pig_update_consumed(garbage):
	if garbage == true:
		$ProgressBar.value -= 1.5
	else:
		$ProgressBar.value += 1.5
#	$Panel/Label.text = "Consumed: " + str(c)

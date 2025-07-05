extends CanvasLayer



func _on_start_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	$ButtonSFX.play()
	$"../MenuMusic".stop()
	$"../GameMusic".play()
	$"../TrainSFX".play()
	#await get_tree().create_timer(2).timeout
	#get_parent().start_dialogue()


func _on_credits_button_pressed() -> void:
	$Darken.visible = true
	$Credits.visible = true
	$ButtonSFX.play()
	
func _on_credits_pressed() -> void:
	$Darken.visible = false
	$Credits.visible = false
	$ButtonSFX.play()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	$ButtonSFX.play()

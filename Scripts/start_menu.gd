extends CanvasLayer



func _on_start_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	$ButtonSFX.play()
	$"../MenuMusic".stop()
	$"../GameMusic".play()
	$"../TrainSFX".play()
	if get_parent().get_node('Levels').has_node('Tutorial'):
		get_parent().get_node('Levels/Tutorial').on_started()


func _on_credits_button_pressed() -> void:
	$ButtonSFX.play()
	var credits = load("res://Scenes/journal.tscn").instantiate()
	add_child(credits)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	$ButtonSFX.play()

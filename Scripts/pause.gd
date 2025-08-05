extends CanvasLayer



func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	$ButtonSFX.play()


func _on_options_button_pressed() -> void:
	$ButtonSFX.play()
	var settings_scene = load("res://Scenes/settings_menu.tscn")
	var settings_instance = settings_scene.instantiate()
	add_child(settings_instance)
	
	# Connect to the close signal
	settings_instance.settings_closed.connect(_on_settings_closed)


func _on_settings_closed():
	# Settings menu closed, nothing special needed for now
	pass


func _on_quit_button_pressed() -> void:
	visible = false
	get_parent().get_node('StartMenu').visible = true
	$ButtonSFX.play()

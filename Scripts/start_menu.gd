extends CanvasLayer


func _ready() -> void:
	# Set the version label from project settings
	var version = ProjectSettings.get_setting("application/config/version", "1.0.0")
	$VersionLabel.text = "v" + version


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


func _on_settings_button_pressed() -> void:
	$ButtonSFX.play()
	var settings_scene = load("res://Scenes/settings_menu.tscn")
	var settings_instance = settings_scene.instantiate()
	add_child(settings_instance)
	
	# Connect to the close signal to handle cleanup
	settings_instance.settings_closed.connect(_on_settings_closed)


func _on_settings_closed():
	# Settings menu closed, nothing special needed for now
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	$ButtonSFX.play()

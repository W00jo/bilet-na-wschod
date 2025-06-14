extends CanvasLayer



func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	$ButtonSFX.play()


func _on_quit_button_pressed() -> void:
	visible = false
	get_parent().get_node('StartMenu').visible = true
	$ButtonSFX.play()

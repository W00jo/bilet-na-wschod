extends Node2D

var selected = false

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
	else:
		#global_position = lerp(global_position, get_parent().get_node('').global_position, 10*delta)
		global_position = lerp(global_position, global_position, 10*delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			scale = Vector2(2, 2)
			selected = false
			z_index = 0

func _on_control_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(4, 4)
		selected = true
		z_index = 1
	if Input.is_action_just_pressed("LMB"):
		$ButtonSFX.play()

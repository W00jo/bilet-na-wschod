extends Node2D

var selected = false
var is_on_screen:bool

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
	else:
		if global_position <= Vector2(500,40) or global_position >= Vector2(910,400) or is_on_screen == false:
			global_position = lerp(global_position, Vector2(1267.273, 377.273), 10*delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			scale = Vector2(2.25, 2.25)
			selected = false

func _on_control_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(2.75, 2.75)
		selected = true

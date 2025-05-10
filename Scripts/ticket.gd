extends Control

var selected = false
var is_on_screen:bool

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
	else:
		if global_position <= Vector2(500,40) or global_position >= Vector2(910,400) or is_on_screen == false:
			global_position = lerp(global_position, Vector2(1300,750), 10*delta)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("LMB"):
		scale = Vector2(1, 1)
		selected = false
		z_index = 0


func _on_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(1.5, 1.5)
		selected = true
		z_index = 1


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	is_on_screen = false

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_on_screen = true

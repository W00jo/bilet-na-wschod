extends Node2D

@onready var ticket_control = get_parent().get_parent().get_node('TicketControl')

var normal_scale = Vector2(2, 2)
var selected_scale = Vector2(4, 4)

var selected = false

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
	else:
		global_position = lerp(global_position, get_parent().get_node('HolepunchMarker').global_position, 10*delta)
		look_for_ticket_areas()


func look_for_ticket_areas():
	var collider = $RayCast2D.get_collider()
	if selected == false and collider != null and collider.is_in_group("TicketArea"):
		ticket_control.validate_ticket()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			scale = normal_scale
			selected = false
			z_index = 0

func _on_control_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = selected_scale
		selected = true
		z_index = 1
	if Input.is_action_just_pressed("LMB"):
		$ButtonSFX.play()

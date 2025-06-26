extends Node2D

@onready var ticket_control = get_parent().get_parent().get_parent().get_node('TicketControl')

var normal_scale = Vector2(0.85, 0.85)
var hover_scale = Vector2(0.95, 0.95)
var selected_scale = Vector2(1.5, 1.5)

var selected = false

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 20*delta)
		check_forbidden()
	else:
		global_position = lerp(global_position, get_parent().get_node('HolepunchMarker').global_position, 15*delta)
		look_for_ticket_areas()


func look_for_ticket_areas():
	var collider = $RayCast2D.get_collider()
	if selected == false and collider != null and collider.is_in_group("TicketArea"):
		if PassengerDataBus.currently_checked_passenger.is_fined == false:
			ticket_control.validate_ticket()
		if collider.get_parent().get_node('ForbiddenLabel').visible:
			collider.get_parent().get_node('ForbiddenLabel').visible = false

func check_forbidden():
	var collider = $RayCast2D.get_collider()
	if collider != null and collider.is_in_group("TicketArea") and PassengerDataBus.currently_checked_passenger.is_fined:
		collider.get_parent().get_node('ForbiddenLabel').visible = true
	else:
		get_parent().get_parent().get_parent().get_node('TicketControl/Ticket/ForbiddenLabel').visible = false

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


func _on_control_mouse_entered() -> void:
	scale = hover_scale

func _on_control_mouse_exited() -> void:
	scale = normal_scale

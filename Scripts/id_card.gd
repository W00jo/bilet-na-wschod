extends Node2D

var selected = false

var current_passenger = PassengerDataBus.currently_checked_passenger
var name_lastname

func assign_data():
	name_lastname = current_passenger.full_name
	$LastName.text = current_passenger.last_name
	$FirstName.text = current_passenger.first_name
	$Height.text = current_passenger.height
	match current_passenger.eye_color:
		"green":
			$Eyes.text = "zielone"
		"blue":
			$Eyes.text = "niebieskie"
		"brown":
			$Eyes.text = "brązowe"
	$SpecialMarks.text = "nie ma"
	$Pesel.text = current_passenger.pesel
	$Signature.text = name_lastname
	
	

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
	else:
		#if global_position <= Vector2(500,40) or global_position >= Vector2(910,400):
		global_position = lerp(global_position, get_parent().get_node('DocumentMarker').global_position, 10*delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			scale = Vector2(2, 2)
			selected = false
			z_index = 0

func _on_control_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(2.5, 2.5)
		selected = true
		z_index = 1
	

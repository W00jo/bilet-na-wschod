extends Node2D

var selected = false
var zoom_enabled = false
var magnified = false

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
	$BirthDate.text = current_passenger.birth_date

func _physics_process(delta: float) -> void:
	if get_parent() is not SubViewport:
		if selected:
			global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
			disable_zoom()
		else:
			#if global_position <= Vector2(500,40) or global_position >= Vector2(910,400):
			global_position = lerp(global_position, get_parent().get_node('DocumentMarker').global_position, 10*delta)

func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			#scale = Vector2(2, 2)
			#selected = false
			#z_index = 0
			##$ButtonSFX.play()
	if Input.is_action_just_pressed("Magnify") and zoom_enabled and magnified == false:
		magnify()
	elif Input.is_action_just_pressed("Magnify"):# and magnified == true:
		if get_parent().get_node('MagnifiedDocument').visible:
			get_parent().get_node('MagnifiedDocument').visible = false
			magnified = false

func _on_control_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(2.2, 2.2)
		selected = true
		z_index = 1
	if Input.is_action_just_released("LMB"):
		scale = Vector2(2, 2)
		selected = false
		enable_zoom()
		$ButtonSFX.play()
		z_index = 0
		
	if Input.is_action_just_pressed("LMB"):
		$ButtonSFX.play()


func _on_control_mouse_entered() -> void:
	enable_zoom()

func _on_control_mouse_exited() -> void:
	disable_zoom()
	
func enable_zoom():
	$MagnifyInstruction.visible = true
	zoom_enabled = true
	
func disable_zoom():
	$MagnifyInstruction.visible = false
	zoom_enabled = false

func magnify():
	var mag_layer= get_parent().get_node('MagnifiedDocument')
	mag_layer.visible = true
	magnified = true

extends Node2D

var selected = false
var zoom_enabled = false
var magnified = false
var investigation_enabled = false
var was_investigated = false

var current_passenger = PassengerDataBus.currently_checked_passenger
var name_lastname

var is_valid = true
var invalid_doc_years_below_reduced
var new_birth_year

var tic_visibility_area

func assign_data(is_doc_valid, years_below_reduced):
	invalid_doc_years_below_reduced = years_below_reduced
	if is_doc_valid == "invalid":
		is_valid = false 
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
	if is_valid:
		$BirthDate.text = current_passenger.birth_date
	else:
		var og_birth_date = current_passenger.birth_date
		var short_date = og_birth_date.erase(og_birth_date.length()-4, 4)
		if short_date.ends_with("sty ") or short_date.ends_with("lut ") or short_date.ends_with("mar "):
			new_birth_year = 35 + invalid_doc_years_below_reduced +1
		else:
			new_birth_year = 34 + invalid_doc_years_below_reduced + 1
		var new_date = short_date + str(new_birth_year) + "r."
		$BirthDate.text = new_date
		

func _physics_process(delta: float) -> void:
	if get_parent() is not SubViewport:
		if selected:
			global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
			disable_zoom()
			disable_investigation()
		else:
			global_position = lerp(global_position, find_closest().global_position, 25*delta)
		
		if tic_visibility_area != null:
			tic_visibility_area.get_parent().disable_zoom()

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
	
	if Input.is_action_just_pressed("Investigate") and investigation_enabled and was_investigated == false:
		was_investigated = true
		$InvestigateInstruction.texture = load("res://Assets/Sprites/UIElements/investigate_instruction_disabled.png")
		get_parent().dialogue.on_investigate("id_card", is_valid)
		

func _on_control_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(2, 2)
		selected = true
		z_index = 1
	if Input.is_action_just_released("LMB"):
		scale = Vector2(1.5, 1.5)
		selected = false
		enable_zoom()
		enable_investigation()
		$ButtonSFX.play()
		z_index = 0
		
	if Input.is_action_just_pressed("LMB"):
		$ButtonSFX.play()


func _on_control_mouse_entered() -> void:
	enable_zoom()
	enable_investigation()

func _on_control_mouse_exited() -> void:
	disable_zoom()
	disable_investigation()
	
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
	selected = false

func enable_investigation():
	$InvestigateInstruction.visible = true
	investigation_enabled = true

func disable_investigation():
	$InvestigateInstruction.visible = false
	investigation_enabled = false

func find_closest():
	var markers = get_parent().get_node('Markers').get_children()
	var closest_marker
	var lowest_distance = INF
	for marker in markers:
		var distance = marker.global_position.distance_to(global_position)
		if distance < lowest_distance:
			closest_marker = marker
			lowest_distance = distance
	if markers.size() > 0:
		return closest_marker


func _on_visibility_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("VisibilityArea"):
		tic_visibility_area = area

func _on_visibility_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("VisibilityArea"):
		tic_visibility_area = null

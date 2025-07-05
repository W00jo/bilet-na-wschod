extends Node2D

var selected = false
var zoom_enabled = false
var magnified = false
var investigation_enabled = false
var was_investigated = false

var current_passenger = PassengerDataBus.currently_checked_passenger
var name_lastname
var years_of_study

var is_valid
var missing_stamps

var tic_visibility_area

func assign_data(is_document_valid, missing_st):
	missing_stamps = missing_st
	match is_document_valid:
		"valid":
			is_valid = true
		"invalid":
			is_valid = false
	name_lastname = current_passenger.full_name
	$AlbumNumber.text = str(current_passenger.album_number)
	$Signature.text = name_lastname
	$Name.text = name_lastname
	assign_stamps()

func assign_stamps():
	years_of_study = current_passenger.years_of_study
	for stamp in $Stamps.get_children(): ## hide all stamps
		stamp.visible = false
	var stamp_num = (years_of_study-1)*2 + 2
	for stamp in $Stamps.get_children():
		if stamp.get_index() <= stamp_num-1:
			stamp.visible = true
		else:
			break
	assign_years(stamp_num)

func assign_years(stamp_num:int):
	for yr in $Years.get_children():
		yr.visible = false
	var years = []
	var cur_year = 95
	var double_year_num = (stamp_num-1)/2
	var first_year = cur_year - double_year_num
	for i in double_year_num:
		for j in 2:
			years.append(first_year+i)
	for k in 2:
		years.append(cur_year)
	for i in years.size():
		$Years.get_child(i).text = str(years[i])
		$Years.get_child(i).visible = true
		
	$Date.text = "Lbn 01,10," + str(first_year-1) + "r,"
	
	check_if_invalid()

func check_if_invalid():
	if is_valid == false:
		make_invalid()


func make_invalid():
	var visible_stamps = []
	var visible_years = []
	for stamp in $Stamps.get_children():
		if stamp.visible:
			visible_stamps.append(stamp)
	for year in $Years.get_children():
		if year.visible:
			visible_years.append(year)
	for i in missing_stamps:
		visible_stamps[visible_stamps.size()-(i+1)].visible = false
		visible_years[visible_years.size()-(i+1)].visible = false

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
			#enable_zoom()
			#$ButtonSFX.play()
			#z_index = 0
	if Input.is_action_just_pressed("Magnify") and zoom_enabled and magnified == false:
		magnify()
	elif Input.is_action_just_pressed("Magnify"):# and magnified == true:
		if get_parent().get_node('MagnifiedDocument').visible:
			get_parent().get_node('MagnifiedDocument').visible = false
			magnified = false
	
	if Input.is_action_just_pressed("Investigate") and investigation_enabled and was_investigated == false:
		was_investigated = true
		$InvestigateInstruction.texture = load("res://Assets/Sprites/UIElements/investigate_instruction_disabled.png")
		get_parent().dialogue.on_investigate("student_id", is_valid)
		

func _on_control_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(2, 2)
		selected = true
		z_index = 1
	if Input.is_action_just_released("LMB"):
		scale = Vector2(1.5, 1.5)
		selected = false
		#on_disselected()
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

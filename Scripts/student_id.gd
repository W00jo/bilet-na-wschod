extends Node2D

var selected = false
var zoom_enabled = false
var magnified = false

var current_passenger = PassengerDataBus.currently_checked_passenger
var name_lastname
var years_of_study

func assign_data():
	name_lastname = current_passenger.full_name
	$AlbumNumber.text = str(current_passenger.album_number)
	$Signature.text = name_lastname
	$Name.text = name_lastname
	assign_stamps()

func assign_stamps():
	years_of_study = current_passenger.years_of_study
	for stamp in $Stamps.get_children(): ## hide all stamps
		stamp.visible = false
	var stamp_num = (years_of_study-1)*2 + 1
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
	var cur_year = 99
	var double_year_num = (stamp_num-1)/2
	var first_year = cur_year - double_year_num
	for i in double_year_num:
		for j in 2:
			years.append(first_year+i)
	years.append(cur_year)
	for i in years.size():
		$Years.get_child(i).text = str(years[i])
		$Years.get_child(i).visible = true
		
	$Date.text = "Lbn 01,10," + str(first_year-1) + "r,"
	


func _physics_process(delta: float) -> void:
	if get_parent() is not SubViewport:
		if selected:
			global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
			disable_zoom()
		else:
			global_position = lerp(global_position, find_closest().global_position, 25*delta)

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

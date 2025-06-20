extends Node2D

var selected = false
var zoom_enabled = false

var current_passenger = PassengerDataBus.currently_checked_passenger
var name_lastname

func assign_data():
	name_lastname = current_passenger.full_name
	$AlbumNumber.text = str(current_passenger.album_number)
	$Signature.text = name_lastname
	$Name.text = name_lastname
	

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		#zoom_enabled = true
		#$MagnifyInstruction.visible = true
	else:
		if get_parent().name != "SubViewport":
			global_position = lerp(global_position, get_parent().get_node('DocumentMarker').global_position, 10*delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			scale = Vector2(2, 2)
			selected = false
			#$ButtonSFX.play()
			#zoom_enabled = false
			#$MagnifyInstruction.visible = false
			z_index = 0
	#if Input.is_action_just_pressed("Magnify") and zoom_enabled:
		#magnify()

func _on_control_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(4, 4)
		selected = true
		z_index = 1
	if Input.is_action_just_pressed("LMB"):
		$ButtonSFX.play()

#func magnify():
	#var mag_layer = get_parent().get_node('MagnifiedView')
	#var mag_viewport = get_parent().get_node('MagnifiedView/SubViewportContainer/SubViewport')
	#mag_layer.visible = true
	#var self_instance = load("res://Scenes/student_id.tscn").instantiate()
	#mag_viewport.add_child(self_instance)
	#self_instance.global_position = mag_viewport.get_node('MagnDocMarker').global_position
	#self_instance.scale = Vector2(5,5)
	#
	

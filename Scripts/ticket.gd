extends Control

@onready var buy_date_label = $TextureAndLabels/SubViewport/BuyDate
@onready var ticket_type_label = $TextureAndLabels/SubViewport/TicketType

var selected = false
var zoom_enabled = false
var magnified = false

var buy_date = "      07.04.1995"
var ticket_type

var doc_visibility_area

func _ready() -> void:
	$TextureAndLabels.material.set_shader_parameter("mask_size", Vector2(0, 0))
	$TextureAndLabels/SubViewport/HoleOutline.visible = false

func _physics_process(delta: float) -> void:
	if get_parent() is not SubViewport:
		if selected:
			global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
			disable_zoom()
		else:
			global_position = lerp(global_position, find_closest().global_position, 20*delta)
		
		if doc_visibility_area != null:
				doc_visibility_area.get_parent().disable_zoom()

func _input(event: InputEvent) -> void:
	#if Input.is_action_just_released("LMB"):
		#scale = Vector2(1, 1)
		#selected = false
		#z_index = 0
		##$ButtonSFX.play()
	if Input.is_action_just_pressed("Magnify") and zoom_enabled and magnified == false:
		magnify()
	elif Input.is_action_just_pressed("Magnify"):# and magnified == true:
		if get_parent().get_node('MagnifiedTicket').visible:
			get_parent().get_node('MagnifiedTicket').visible = false
			magnified = false

func assign_data():
	buy_date_label.text = buy_date
	ticket_type_label.text = ticket_type
	
func _on_control_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(0.9, 0.9)
		selected = true
		z_index = 1
	else:
		scale = Vector2(0.75, 0.75)
		selected = false
		z_index = 0
	if Input.is_action_just_released("LMB"):
		scale = Vector2(0.75, 0.75)
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
	var mag_layer= get_parent().get_node('MagnifiedTicket')
	mag_layer.visible = true
	if get_parent().is_ticket_checked:
		pass
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


func _on_visibility_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("VisibilityArea"):
		doc_visibility_area = area

func _on_visibility_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("VisibilityArea"):
		doc_visibility_area = null
		

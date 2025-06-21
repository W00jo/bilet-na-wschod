extends Control

@onready var buy_date_label = $TextureAndLabels/SubViewport/BuyDate
@onready var ticket_type_label = $TextureAndLabels/SubViewport/TicketType

var selected = false

var buy_date = "      07.04.1999"
var ticket_type

func _ready() -> void:
	$TextureAndLabels.material.set_shader_parameter("mask_size", Vector2(0, 0))

func _physics_process(delta: float) -> void:
	if get_parent() is not SubViewport:
		if selected:
			global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		else:
			#if global_position <= Vector2(500,40) or global_position >= Vector2(910,400):
			global_position = lerp(global_position, get_parent().get_node('TicketMarker').global_position, 10*delta)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("LMB"):
		scale = Vector2(1, 1)
		selected = false
		z_index = 0
		#$ButtonSFX.play()

func _on_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		scale = Vector2(2, 2)
		selected = true
		z_index = 1
	if Input.is_action_just_pressed("LMB"):
		$ButtonSFX.play()

func assign_data():
	buy_date_label.text = buy_date
	ticket_type_label.text = ticket_type

extends Area2D

@onready var sprites:SubViewport = $TexContainer/Sprites
@onready var textures = $Textures
@onready var doc_manager = $DocumentManager

var is_skasowaned = false
var has_ticket = true
var is_fined = false

var gender = "f"
var full_name = "Katarzyna Kowalska"
var ticket_type = "BILET ULGOWY"
var document = load("res://Scenes/student_id.tscn")
var is_document_valid = true
var album_number = 15327
var years_of_study = 2


var interaction_enabled:bool = false


func interactive_look_remover():
	$TexContainer.material.set_shader_parameter("type", 0)
	$TexContainer.material.set_shader_parameter("saturation", 0.3)


## INTERACTIONS ##

func update_interaction_position(pos:Vector2):
	$InteractionArea.global_position = pos


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		interaction_enabled = true
		
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		interaction_enabled = false

func display_interaction_label():
	if interaction_enabled and is_skasowaned == false:
		$InteractLabel.visible = true
		
func hide_interaction_label():
	$InteractLabel.visible = false
	
func _input(event: InputEvent) -> void:
	if interaction_enabled and $InteractLabel.visible and Input.is_action_just_pressed("Interact") and is_skasowaned == false:
		interaction_enabled = false
		var game = PassengerDataBus.get_game()
		if game:
			var laska_control = game.get_node_or_null('ToolkitLayer/LaskaControl')
			if laska_control:
				laska_control.start_laska_control(self)
			else:
				print("Warning: LaskaControl node not found")
		else:
			print("Warning: Cannot start laska control - game node not available")
		

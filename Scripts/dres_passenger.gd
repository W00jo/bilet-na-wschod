extends Area2D
class_name SpecialPassenger

var full_name = "Sebastian Radomski"

var interaction_enabled = false
var is_fined = false


func display_interaction_label():
	if interaction_enabled and is_fined == false:
		$InteractLabel.visible = true
		
func hide_interaction_label():
	$InteractLabel.visible = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('Player'):
		interaction_enabled = true

func interactive_look_remover():
	$TexContainer.material.set_shader_parameter("type", 0)
	$TexContainer.material.set_shader_parameter("saturation", 0.3)

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group('Player'):
		interaction_enabled = false

func _input(event: InputEvent) -> void:
	if interaction_enabled and $InteractLabel.visible and Input.is_action_just_pressed("Interact") and is_fined == false:
		interaction_enabled = false
		PassengerDataBus.game.get_node('ToolkitLayer/DresControl').start_dres_control(self)

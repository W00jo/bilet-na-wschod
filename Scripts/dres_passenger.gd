extends Area2D

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
		var game = PassengerDataBus.get_game()
		if game:
			var dres_control = game.get_node_or_null('ToolkitLayer/DresControl')
			if dres_control:
				dres_control.start_dres_control(self)
			else:
				print("Warning: DresControl node not found")
		else:
			print("Warning: Cannot start dres control - game node not available")


func _on_music_area_area_entered(area: Area2D) -> void:
	if area.is_in_group('Player'):
		var game = PassengerDataBus.get_game()
		if game:
			var game_music = game.get_node_or_null('GameMusic')
			if game_music:
				game_music.volume_db = -15
			else:
				print("Warning: GameMusic node not found")
		else:
			print("Warning: Cannot adjust music volume - game node not available")

func _on_music_area_area_exited(area: Area2D) -> void:
	if area.is_in_group('Player'):
		var game = PassengerDataBus.get_game()
		if game:
			var game_music = game.get_node_or_null('GameMusic')
			if game_music:
				game_music.volume_db = 0
			else:
				print("Warning: GameMusic node not found")
		else:
			print("Warning: Cannot adjust music volume - game node not available")

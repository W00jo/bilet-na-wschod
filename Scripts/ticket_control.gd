extends Control

@onready var ticket = $Ticket

func start_control():
	pass

#func _on_option_1_pressed() -> void:
	## Popros o bilet
	#$Box/DialogueBox/ScrollContainer/VBoxContainer/MarginContainer.visible = true
	#await get_tree().create_timer(1).timeout
	#$Box/DialogueBox/ScrollContainer/VBoxContainer/MarginContainer2.visible = true
	#$Box/HBox/DocumentBox/Container/Ticket.visible = true
	#$Toolkit.control_started()
	#$AnimationPlayer.play("updown")
	#
func ticket_checked():
	ticket.get_node("TextureAndLabels").material.set_shader_parameter("mask_size", Vector2(0.2, 0.25))

func _on_button_close_pressed() -> void:
	PassengerDataBus.game.end_ticket_control()
	remove_child(get_node('StudentID'))
	ticket.visible = false


func _on_option_1_pressed() -> void:
	ticket.visible = true
	PassengerDataBus.game.get_node('ToolkitLayer/Toolkit').control_started()
	get_parent().get_node('Toolkit/NinePatchRect/HBoxContainer/HolePunch').disabled = false
	print(get_parent().get_node('Toolkit/NinePatchRect/HBoxContainer/HolePunch').disabled)
	

func _on_option_2_pressed() -> void:
	var document = PassengerDataBus.currently_checked_passenger.document.instantiate()
	add_child(document)
	document.global_position = $DocumentMarker.global_position
	document.set_scale(Vector2(2, 2))
	var avatar_sprites = $Box/HBox/Left/NinePatchRect/PassengerAvatar.get_children()
	print(avatar_sprites)
	for sprite in avatar_sprites:
		if sprite is not ResourcePreloader:
			var duplicate = sprite.duplicate()
			document.get_node('PhotoCont/Photo').add_child(duplicate)
	

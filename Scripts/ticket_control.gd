extends Control


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
	$Box/HBox/DocumentBox/Ticket/Hole.visible = true
	#$Box/DialogueBox/ScrollContainer/VBoxContainer/MarginContainer4.visible = true
	$AnimationPlayer.stop()
	$TextureRect.visible = false

func _on_button_close_pressed() -> void:
	PassengerDataBus.game.end_ticket_control()
	remove_child(get_node('StudentID'))


func _on_option_1_pressed() -> void:
	$Box/HBox/DocumentBox/Ticket.visible = true
	PassengerDataBus.game.get_node('ToolkitLayer/Toolkit').control_started()
	$AnimationPlayer.play("updown")
	

func _on_option_2_pressed() -> void:
	var document = PassengerDataBus.currently_checked_passenger.document.instantiate()
	add_child(document)
	document.global_position = $DocumentMarker.global_position
	document.set_scale(Vector2(2.25, 2.25))
	var avatar_sprites = $Box/HBox/Left/NinePatchRect/PassengerAvatar.get_children()
	print(avatar_sprites)
	for sprite in avatar_sprites:
		if sprite is not ResourcePreloader:
			var duplicate = sprite.duplicate()
			document.get_node('Photo').add_child(duplicate)
	

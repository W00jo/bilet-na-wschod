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
#func ticket_checked():
	#$Box/HBox/DocumentBox/Container/Ticket/TextureRect2.visible = true
	#$Box/DialogueBox/ScrollContainer/VBoxContainer/MarginContainer4.visible = true
	#$AnimationPlayer.stop()
	#$TextureRect.visible = false
	#

func _on_button_close_pressed() -> void:
	PassengerDataBus.game.end_ticket_control()

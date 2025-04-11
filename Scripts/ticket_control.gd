extends Control

@onready var ticket_layer = get_tree().root.get_node('Game/TicketControlLayer')


func _on_button_pressed() -> void:
	print("pressed")
	ticket_layer.visible = false
	


func _on_option_1_pressed() -> void:
	# Popros o bilet
	$Box/DialogueBox/ScrollContainer/VBoxContainer/MarginContainer.visible = true
	await get_tree().create_timer(1).timeout
	$Box/DialogueBox/ScrollContainer/VBoxContainer/MarginContainer2.visible = true
	$Box/HBox/DocumentBox/Container/Ticket.visible = true
	$Toolkit.control_started()
	$AnimationPlayer.play("updown")
	
func ticket_checked():
	$Box/HBox/DocumentBox/Container/Ticket/TextureRect2.visible = true
	$Box/DialogueBox/ScrollContainer/VBoxContainer/MarginContainer4.visible = true
	$AnimationPlayer.stop()
	$TextureRect.visible = false
	

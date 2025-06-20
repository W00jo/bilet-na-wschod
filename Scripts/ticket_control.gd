extends Control

var ticket
var document
var is_ticket_checked

func start_control():
	is_ticket_checked = false
	create_ticket()
	create_document()

func create_ticket():
	var ticket_instance = load("res://Scenes/ticket.tscn").instantiate()
	add_child(ticket_instance)
	ticket = ticket_instance
	ticket.visible = false
	ticket.global_position = $TicketMarker.global_position
	set_ticket_data()

func set_ticket_data():
	ticket.ticket_type = PassengerDataBus.currently_checked_passenger.ticket_type
	ticket.assign_data()

func create_document():
	document = PassengerDataBus.currently_checked_passenger.document.instantiate()
	add_child(document)
	document.visible = false
	document.global_position = $DocumentMarker.global_position
	document.set_scale(Vector2(2, 2))
	var avatar_sprites = $Box/HBox/Left/NinePatchRect/PassengerAvatar.get_children()
	for sprite in avatar_sprites:
		if sprite is not ResourcePreloader:
			var duplicate = sprite.duplicate()
			document.get_node('PhotoCont/Photo').add_child(duplicate)
	set_document_data()

func set_document_data():
	document.name_lastname = PassengerDataBus.currently_checked_passenger.full_name
	document.assign_data()

func validate_ticket():
	if is_ticket_checked == false:
		ticket.get_node("TextureAndLabels").material.set_shader_parameter("mask_size", Vector2(0.2, 0.25))
		ticket.get_node("ValidationArea").queue_free()
		is_ticket_checked = true
		$TicketValidationSFX.play()
		PassengerDataBus.currently_checked_passenger.is_skasowaned = true
		PassengerDataBus.currently_checked_passenger.hide_interaction_label()

func _on_ask_ticket_pressed() -> void:
	if is_ticket_checked == false:
		ticket.visible = true
		#PassengerDataBus.game.get_node('ToolkitLayer/Toolkit').control_started()
		#get_parent().get_node('Toolkit/NinePatchRect/HBoxContainer/HolePunch').disabled = false
		$ButtonSFX.play()


func _on_ask_document_pressed() -> void:
	document.visible = true
	$ButtonSFX.play()

func _on_button_close_pressed() -> void:
	PassengerDataBus.game.end_ticket_control()
	remove_child(document)
	ticket.queue_free()
	$ButtonSFX.play()
	
	

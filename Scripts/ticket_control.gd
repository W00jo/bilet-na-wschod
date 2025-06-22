extends Control

@onready var mag_ticket_sub = $MagnifiedTicket/SVCont/SV
@onready var mag_doc_sub = $MagnifiedDocument/SVCont/SV
@onready var button_sfx = $ButtonSFX
@onready var ticket_validation_sfx = $TicketValidationSFX

var ticket
var mag_ticket
var document
var mag_document
var is_ticket_checked

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") and visible and $MagnifiedDocument.visible == false and $MagnifiedTicket.visible == false:
		close()


func start_control():
	is_ticket_checked = false
	create_ticket()
	create_document()

func create_ticket():
	var ticket_instance = load("res://Scenes/ticket.tscn").instantiate()
	add_child(ticket_instance)
	create_magnified_ticket()
	ticket = ticket_instance
	ticket.visible = false
	ticket.global_position = $TicketMarker.global_position
	set_ticket_data(ticket)

func create_magnified_ticket():
	var mag_ticket_instance = load("res://Scenes/ticket.tscn").instantiate()
	mag_ticket_sub.add_child(mag_ticket_instance)
	mag_ticket = mag_ticket_instance
	mag_ticket.set_scale(Vector2(2, 2))
	mag_ticket.global_position = Vector2(690,400)
	set_ticket_data(mag_ticket)

func set_ticket_data(t):
	t.ticket_type = PassengerDataBus.currently_checked_passenger.ticket_type
	t.assign_data()

func create_document():
	document = PassengerDataBus.currently_checked_passenger.document.instantiate()
	add_child(document)
	create_magnified_document()
	document.visible = false
	document.global_position = $DocumentMarker.global_position
	document.set_scale(Vector2(2, 2))
	create_document_avatar(document)
	set_document_data(document)

func create_magnified_document():
	mag_document = PassengerDataBus.currently_checked_passenger.document.instantiate()
	mag_remove_previous_docs()
	mag_doc_sub.add_child(mag_document)
	mag_document.set_scale(Vector2(6, 6))
	mag_document.global_position = Vector2(700,375)
	create_document_avatar(mag_document)
	set_document_data(mag_document)

func mag_remove_previous_docs():
	if mag_doc_sub.get_child_count() > 0:
		for child in mag_doc_sub.get_children():
			mag_doc_sub.remove_child(child)

func set_document_data(doc):
	doc.name_lastname = PassengerDataBus.currently_checked_passenger.full_name
	doc.assign_data()

func create_document_avatar(doc):
	var avatar_sprites = $Box/HBox/Left/NinePatchRect/PassengerAvatar.get_children()
	for sprite in avatar_sprites:
		if sprite is not ResourcePreloader:
			var duplicate = sprite.duplicate()
			doc.get_node('PhotoCont/Photo').add_child(duplicate)

func validate_ticket():
	if is_ticket_checked == false:
		ticket.get_node("TextureAndLabels").material.set_shader_parameter("mask_size", Vector2(0.25, 0.25))
		ticket.get_node("TextureAndLabels/SubViewport/HoleOutline").visible = true
		mag_ticket.get_node("TextureAndLabels/SubViewport/HoleOutline").visible = true
		ticket.get_node("ValidationArea").queue_free()
		is_ticket_checked = true
		ticket_validation_sfx.play()
		PassengerDataBus.currently_checked_passenger.is_skasowaned = true
		PassengerDataBus.currently_checked_passenger.interactive_look_remover()
		PassengerDataBus.currently_checked_passenger.hide_interaction_label()

func _on_ask_ticket_pressed() -> void:
	if is_ticket_checked == false:
		ticket.visible = true
		#PassengerDataBus.game.get_node('ToolkitLayer/Toolkit').control_started()
		#get_parent().get_node('Toolkit/NinePatchRect/HBoxContainer/HolePunch').disabled = false
		button_sfx.play()


func _on_ask_document_pressed() -> void:
	document.visible = true
	button_sfx.play()

func _on_button_close_pressed() -> void:
	close()

func close():
	if PassengerDataBus.currently_checked_passenger.is_skasowaned == false:
		PassengerDataBus.currently_checked_passenger.interaction_enabled = true
	PassengerDataBus.game.end_ticket_control()
	remove_child(document)
	ticket.queue_free()
	button_sfx.play()

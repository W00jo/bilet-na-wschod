extends Control

@onready var button_sfx = $ButtonSFX
@onready var dialogue = $Box/HBox/Middle/DialogueBox/Dialogue

var passenger


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") and visible:
		close()


func start_dres_control(dres):
	get_tree().get_first_node_in_group("Player").can_move = false
	get_tree().get_first_node_in_group("Player").get_node('WalkSFX').stop()
	PassengerDataBus.current_special = dres
	visible = true
	passenger = dres
	$Box/HBox/Middle/DialogueBox/Dialogue.greet()


func _on_ask_ticket_pressed() -> void:
	pass
		

func _on_ask_document_pressed() -> void:
	pass


func _on_button_close_pressed() -> void:
	close()

func close():
	if passenger.is_fined == false:
		passenger.interaction_enabled = true
		PassengerDataBus.current_special = null
		$Box/HBox/Middle/DialogueBox/Dialogue.text = ""
	get_tree().get_first_node_in_group("Player").can_move = true
	$Box/HBox/Middle/OptionBox/VBoxContainer/AskTicket.disabled = false
	$Box/HBox/Middle/OptionBox/VBoxContainer/AskDocument.disabled = false
	visible = false
	button_sfx.play()

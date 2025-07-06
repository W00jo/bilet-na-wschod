extends Control

@onready var button_sfx = $ButtonSFX
@onready var dialogue = $Box/HBox/Middle/DialogueBox/Dialogue

@onready var tut_dialogue = get_parent().get_parent().get_node('DialogueLayer/TutorialDialogue')

var passenger


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") and visible:
		if passenger.is_fined:
			close()


func start_dres_control(dres):
	get_tree().get_first_node_in_group("Player").can_move = false
	get_tree().get_first_node_in_group("Player").get_node('WalkSFX').stop()
	PassengerDataBus.current_special = dres
	visible = true
	passenger = dres
	$Box/HBox/Middle/DialogueBox/Dialogue.greet()


func _on_ask_ticket_pressed() -> void:
	await get_tree().create_timer(4).timeout
	tut_dialogue.start_tutorial_dialogue()
	$"../Toolkit".get_node('ToolBag/FinesTool').visible = true
	

func _on_ask_document_pressed() -> void:
	pass


func _on_button_close_pressed() -> void:
	if passenger.is_fined:
		close()

func close():
	if passenger.is_fined == false:
		passenger.interaction_enabled = true
		PassengerDataBus.current_special = null
		$Box/HBox/Middle/DialogueBox/Dialogue.text = ""
	get_tree().get_first_node_in_group("Player").can_move = true
	button_sfx.play()
	visible = false
	await get_tree().create_timer(1).timeout
	tut_dialogue.start_tutorial_dialogue()
	#get_parent().get_parent().get_node('Levels/Tutorial/WagonTutorial/TutGuy')
	queue_free()
	

extends Node2D

@onready var tutorial_dialogue = preload("res://Scenes/tutorial_dialogue.tscn").instantiate()
@onready var ticket_layer = $TicketControlLayer

#### UNCOMMENT FOR THE DIALOGUE TUTORIAL
#func _ready() -> void:
	#$ToolkitLayer/Toolkit.start_dialogue()
	#$TutorialLayer.add_child(tutorial_dialogue)

func start_ticket_control():
	ticket_layer.visible = true
	$TicketControlLayer/TicketControl.start_control()
	get_tree().get_first_node_in_group("Player").can_move = false

func end_ticket_control():
	get_tree().get_first_node_in_group("Player").can_move = true
	ticket_layer.visible = false
	

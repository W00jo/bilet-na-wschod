extends Node2D

@onready var tutorial_dialogue = preload("res://Scenes/tutorial_dialogue.tscn").instantiate()
@onready var ticket_layer = $TicketControlLayer

#### UNCOMMENT FOR THE DIALOGUE TUTORIAL
#func _ready() -> void:
	#$ToolkitLayer/Toolkit.start_dialogue()
	#$TutorialLayer.add_child(tutorial_dialogue)

func start_ticket_control():
	ticket_layer.visible = true

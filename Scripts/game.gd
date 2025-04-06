extends Node2D

@onready var ticket_layer = $TicketControlLayer

func _ready() -> void:
	$ToolkitLayer/Toolkit.start_dialogue()

func start_ticket_control():
	ticket_layer.visible = true

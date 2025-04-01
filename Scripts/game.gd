extends Node2D

@onready var ticket_layer = $TicketControlLayer

func start_ticket_control():
	ticket_layer.visible = true

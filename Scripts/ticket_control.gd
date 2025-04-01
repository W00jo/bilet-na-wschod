extends Control

@onready var ticket_layer = get_tree().root.get_node('Game/TicketControlLayer')

func _on_button_pressed() -> void:
	ticket_layer.visible = false

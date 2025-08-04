extends Control

@onready var toolbag = $ToolBag

var is_open = false

var position_hidden = Vector2(200,1050)
var position_shown = Vector2(200,940)

# Statistics system
var tickets_punched = 0



func _ready() -> void:
	toolbag.position = position_hidden


func _on_bag_interaction_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		if is_open:
			hide_bag()
		elif is_open == false:
			show_bag()
		$OpenCloseSFX.play()

func show_bag():
	get_tree().create_tween().tween_property(toolbag, "position", position_shown, 0.25)
	toolbag.open()
	is_open = true

func hide_bag():
	get_tree().create_tween().tween_property(toolbag, "position", position_hidden, 0.25)
	toolbag.close()
	is_open =  false

# Statistics functions
func record_ticket_punched():
	tickets_punched += 1
	print("DEBUG: Bilet skasowany! Łącznie: ", tickets_punched)

func get_tickets_punched():
	return tickets_punched

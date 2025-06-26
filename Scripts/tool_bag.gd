extends Node2D

@onready var anim = $AnimationPlayer
@onready var toolkit = get_parent()

var fine_normal_scale
var fine_hover_scale

var journal_normal_scale = Vector2(1, 1)
var journal_hover_scale = Vector2(1.1, 1.1)

func _ready() -> void:
	fine_normal_scale = $FinesTool.scale
	fine_hover_scale = fine_normal_scale + Vector2(0.1, 0.1)
	journal_normal_scale = $JournalTool.scale
	journal_hover_scale = journal_normal_scale + Vector2(0.1, 0.1)
	

func open():
	anim.play("open_bag")

func close():
	anim.play_backwards("open_bag")


func _on_fines_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB") and PassengerDataBus.currently_checked_passenger != null:
		var passenger = PassengerDataBus.currently_checked_passenger
		if passenger.is_skasowaned == false and passenger.is_fined == false:
			var fine = load("res://Scenes/fine.tscn").instantiate()
			toolkit.add_child(fine)

func _on_fines_mouse_entered() -> void:
	$FinesTool.scale = fine_hover_scale

func _on_fines_mouse_exited() -> void:
	$FinesTool.scale = fine_normal_scale


func _on_journal_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.

func _on_journal_mouse_entered() -> void:
	$JournalTool.scale = journal_hover_scale

func _on_journal_mouse_exited() -> void:
	$JournalTool.scale = journal_normal_scale

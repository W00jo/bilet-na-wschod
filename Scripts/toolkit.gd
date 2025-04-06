extends Control

@onready var anim = $AnimationPlayer

func start_dialogue():
	anim.speed_scale = 4
	anim.play_backwards("Un-dialogue")
	await anim.animation_finished
	anim.speed_scale = 1


func undialogue():
	anim.play("Un-dialogue")

func control_started():
	print("control")
	$NinePatchRect/HBoxContainer/HolePunch.texture_normal = load("res://Assets/Sprites/hole_punch_tool_hint.png")
	$NinePatchRect/HBoxContainer/HolePunch.disabled = false


func _on_hole_punch_pressed() -> void:
	$NinePatchRect/HBoxContainer/HolePunch.texture_normal = load("res://Assets/Sprites/hole_punch_tool.png")
	get_parent().ticket_checked()

extends Control

@onready var anim = $AnimationPlayer

func _ready() -> void:
	$NinePatchRect/HBoxContainer/HolePunch.disabled = true

func start_dialogue():
	anim.speed_scale = 4
	anim.play("dialogue")
	await anim.animation_finished
	anim.speed_scale = 1


func control_started():
	$NinePatchRect/HBoxContainer/HolePunch.texture_normal = load("res://Assets/Sprites/hole_punch_tool_hint.png")
	$NinePatchRect/HBoxContainer/HolePunch.disabled = false


func _on_hole_punch_pressed() -> void:
	$NinePatchRect/HBoxContainer/HolePunch.visible = false
	$NinePatchRect/HBoxContainer/Empty.visible = true
	$HolepunchDragndrop.visible = true
	$HolepunchDragndrop.global_position = get_global_mouse_position()
	$HolepunchDragndrop.selected = true

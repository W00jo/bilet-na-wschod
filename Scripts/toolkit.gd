extends Control

@onready var anim = $AnimationPlayer

#func _ready() -> void:
	#$NinePatchRect/HBoxContainer/HolePunch.disabled = true

func start_dialogue():
	anim.speed_scale = 4
	anim.play("dialogue")
	await anim.animation_finished
	anim.speed_scale = 1


#func control_started():
	#$NinePatchRect/HBoxContainer/HolePunch.texture_normal = load("res://Assets/Sprites/hole_punch_tool_hint.png")
	#$NinePatchRect/HBoxContainer/HolePunch.disabled = false

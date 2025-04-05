extends Control

@onready var anim = $AnimationPlayer


func undialogue():
	anim.play("Un-dialogue")

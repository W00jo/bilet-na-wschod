extends Node2D

@onready var anim = $AnimationPlayer

func open():
	anim.play("open_bag")

func close():
	anim.play_backwards("open_bag")

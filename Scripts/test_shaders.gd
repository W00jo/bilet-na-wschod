extends Control

func _ready() -> void:
	pass


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("wipe")
	

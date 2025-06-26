extends Control

func _ready() -> void:
	for i in 5:
		print(i)



func _on_timer_timeout() -> void:
	$AnimationPlayer.play("wipe")
	

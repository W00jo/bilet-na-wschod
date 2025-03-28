extends Path2D

@export var lerp_speed:float = 2.0

@onready var player = get_parent().get_node('YSort/Player')
@onready var follower = $PathFollow2D


func _process(delta: float) -> void:
	var offset = curve.get_closest_offset(player.global_position - global_position)
	follower.h_offset = lerp(follower.h_offset, offset, lerp_speed*delta)

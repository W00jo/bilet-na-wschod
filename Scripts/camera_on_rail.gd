extends Path2D

@export var lerp_speed:float = 2.0

@onready var follower = $PathFollow2D
@onready var wagon = get_parent()

var player

func _ready() -> void:
	wagon.connect("player_entered", on_player_entered)
	

func _process(delta: float) -> void:
	if player != null:
		var offset = curve.get_closest_offset(player.global_position - global_position)
		follower.h_offset = lerp(follower.h_offset, offset, lerp_speed*delta)

func on_player_entered(node):
	player = node

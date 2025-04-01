extends CharacterBody2D

@onready var anim_tree = $AnimationTree

const SPEED = 600.0

var passengers:Array

func _physics_process(delta: float) -> void:
	var directon = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	velocity = directon * SPEED
	
	if directon == Vector2.ZERO:
		pass # when not moving, look in the same direction as when last moved
	else:
		anim_tree.set("parameters/Idle/blend_position", directon) # look in the direction you're moving in
	
	move_and_slide()
	
func _on_timer_timeout() -> void:
	find_closest()
	
func find_closest():
	passengers = get_parent().get_node("Passengers").get_children()
	var closest_passenger
	var lowest_distance = INF
	for passenger in passengers:
		var distance = passenger.position.distance_to(position)
		if distance < lowest_distance:
			closest_passenger = passenger
			lowest_distance = distance
	make_interactible(closest_passenger)

func make_interactible(passenger):
	for p in passengers:
		p.hide_interaction_label()
	passenger.display_interaction_label()

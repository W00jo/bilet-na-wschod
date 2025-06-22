extends CharacterBody2D

@onready var anim_tree = $AnimationTree

const SPEED = 300.0

var passengers:Array

var can_move = true

func _physics_process(delta: float) -> void:
	if can_move == true:
		var directon = Input.get_vector("Left", "Right", "Up", "Down").normalized()
		velocity = directon * SPEED
		
		## Walking and Idle animations
		if directon == Vector2.ZERO:
			anim_tree.set("parameters/conditions/idle", true)
			anim_tree.set("parameters/conditions/is_walking", false)
		else:
			anim_tree.set("parameters/conditions/idle", false)
			anim_tree.set("parameters/conditions/is_walking", true)
			anim_tree.set("parameters/Walking/blend_position", directon)
			anim_tree.set("parameters/Idle/blend_position", directon)
	else:
		velocity = Vector2(0,0)
		
	move_and_slide()
	
func _on_timer_timeout() -> void:
	find_closest()
	
func find_closest():
	passengers = $InteractionArea.get_overlapping_areas()
	var closest_passenger
	var lowest_distance = INF
	for passenger in passengers:
		var distance = passenger.position.distance_to(position)
		if distance < lowest_distance:
			closest_passenger = passenger
			lowest_distance = distance
	if passengers.size() > 0:
		make_interactible(closest_passenger)

func make_interactible(passenger):
	for p in passengers:
		p.hide_interaction_label()
	passenger.display_interaction_label()


func _on_interaction_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Passenger"):
		area.hide_interaction_label()

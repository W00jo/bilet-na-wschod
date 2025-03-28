extends CharacterBody2D

@onready var anim_tree = $AnimationTree

const SPEED = 300.0


func _physics_process(delta: float) -> void:
	var directon = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	velocity = directon * SPEED
	
	if directon == Vector2.ZERO:
		pass # when not moving, look in the same direction as when last moved
	else:
		anim_tree.set("parameters/Idle/blend_position",directon) # look in the direction you're moving in
	
	move_and_slide()

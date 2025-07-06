extends Node2D

@onready var chairs = $YSort/Chairs

var min_passengers:int = 4
var max_passengers:int = 8

signal player_entered

func _ready() -> void:
	spawn_passengers()
	
#func instance_passenger():
	#var passenger_scene = load("res://Scenes/passenger.tscn").instantiate()
	#spawn_passengers(passenger_scene)

func spawn_passengers():
	var cells:Array = chairs.get_used_cells() # an array of all chair coords
	cells.shuffle()
	var num_of_passengers:int = randi_range(min_passengers, max_passengers)
	var instance_count:int = 0 # used for breaking the loop
	for cell in cells:
		# converting tilemap coords to scene coords
		var tile_pos = chairs.map_to_local(cell)
		# spawning passengers
		var passenger:Passenger = load("res://Scenes/passenger.tscn").instantiate()
		$YSort/Passengers.add_child(passenger)
		passenger.position = tile_pos * chairs.scale
		passenger.update_interaction_position(calculate_area_position(cell, tile_pos*chairs.scale))
		# checking if all passengers are instanced
		instance_count +=1
		if instance_count == num_of_passengers:
			break
	
	assign_problematic_levels(num_of_passengers)

func assign_problematic_levels(num_of_pas):
	var passenger_arr = $YSort/Passengers.get_children()
	passenger_arr.shuffle()
	var i = 0
	var problem_num = randi_range(0, roundi(num_of_pas*0.5))
	#var problem_num = passenger_arr.size()    ####  FOR_TEST
	for pas in passenger_arr:
		if i < problem_num:
			pas.is_problematic = true
			pas.get_node('DocumentManager').make_problematic()
			i +=1
		else:
			break
		

func calculate_area_position(cell_pos, global_pos):
	var passenger_position:Vector2
	match cell_pos.y:
		37:
			passenger_position.y = 590
			passenger_position.x = global_pos.x + 25
		41:
			passenger_position.y = 590
			passenger_position.x = global_pos.x - 25
		58:
			passenger_position.y = 730
			passenger_position.x = global_pos.x + 25
		62:
			passenger_position.y = 730
			passenger_position.x = global_pos.x - 25
	return passenger_position
			

func _on_left_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().change_wagons(body, "left")

func _on_right_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().change_wagons(body, "right")


func _on_y_sort_child_entered_tree(node: Node) -> void:
	if node.is_in_group("Player"):
		player_entered.emit(node)

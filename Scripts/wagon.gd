extends Node2D

func _ready() -> void:
	spawn_passengers()

func spawn_passengers():
	var cells_ac = $YSort/ChairsAC.get_used_cells()
	var cells_bd = $YSort/ChairsBD.get_used_cells()
	var cells = cells_ac + cells_bd ## an array of all chair coords
	cells.shuffle()
	
	var num_of_passengers = randi_range(11,12)
	var spawn_count:int = 0 ## used for breaking the loop
	
	for cell in cells:
		var tile_pos = $YSort/ChairsAC.map_to_local(cell)
		var passenger_scene = load("res://Scenes/passenger.tscn")
		var passenger = passenger_scene.instantiate()
		$YSort/Passengers.add_child(passenger)
		passenger.position = (tile_pos-Vector2(-4,5))*2
		spawn_count +=1
		if spawn_count == num_of_passengers:
			break

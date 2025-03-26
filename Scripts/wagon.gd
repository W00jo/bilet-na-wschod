extends Node2D

@onready var chairs = $YSort/Chairs


func _ready() -> void:
	spawn_passengers()

func spawn_passengers():
	var cells:Array = chairs.get_used_cells() # an array of all chair coords
	cells.shuffle()
	
	var min_passengers:int = 4
	var max_passengers:int = 12
	var num_of_passengers:int = randi_range(min_passengers, max_passengers)
	var instance_count:int = 0 # used for breaking the loop
	
	for cell in cells:
		# converting tilemap coords to scene coords
		var tile_pos = chairs.map_to_local(cell)
		# Instancing passengers
		var passenger_scene = load("res://Scenes/passenger.tscn")
		var passenger = passenger_scene.instantiate()
		$YSort/Passengers.add_child(passenger)
		passenger.position = tile_pos * chairs.scale
		# checking if all passengers are instanced
		instance_count +=1
		if instance_count == num_of_passengers:
			break

extends Node

var game: Node = null
var passenger_avatar: Control = null  ## assigned in ready by passenger_avatar scene

var checked_passengers = []
var currently_checked_passenger
var current_passenger_document

var current_special

func _ready():
	# Safe game node access with error handling
	if get_tree() and get_tree().root:
		game = get_tree().root.get_node_or_null('Game')
		if not game:
			push_error("PassengerDataBus: Game node not found!")
	else:
		push_error("PassengerDataBus: Scene tree not available!")

# Safe game access function
func get_game() -> Node:
	if not game:
		# Try to reconnect if game was null
		if get_tree() and get_tree().root:
			game = get_tree().root.get_node_or_null('Game')
	return game

func transfer_passenger_data(file_name_array, color_array, eye_color):
	passenger_avatar.get_texture(file_name_array)
	passenger_avatar.get_color_scheme(color_array, eye_color)

#func set_document(age, ticket_type, document):
	#document = current_passenger_document
	#print(current_passenger_document)
	#
#
#func document_photo(body, hair, eyes, shirt):
	#pass

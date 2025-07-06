extends Node

@onready var game = get_tree().root.get_node('Game')
var passenger_avatar:Control  ## assigned in ready by passenger_avatar scene

var checked_passengers = []
var currently_checked_passenger
var current_passenger_document

var current_special

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

extends Node

@onready var game = get_tree().root.get_node('Game')
var passenger_avatar:Control

var checked_passengers = []
var currently_checked_passenger

func transfer_passenger_data(gender, file_name_array, color_array, eye_color):
	passenger_avatar.get_path_data(gender, file_name_array)
	passenger_avatar.get_color_scheme(color_array, eye_color)

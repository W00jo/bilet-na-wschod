extends Node

@onready var json_preloader = $"../JSONs"

var names = {}

var male_names = []
var male_surnames = []
var female_names = []
var female_surnames = []


func _ready() -> void:
	names = json_preloader.get_resource("passenger_names").get_data()
	male_names = names["imiona_meskie"]
	female_names = names["imiona_damskie"]
	male_surnames = names["nazwiska_meskie"]
	female_surnames = names["nazwiska_damskie"]

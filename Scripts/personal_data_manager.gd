extends Node

@onready var json_preloader = $"../JSONs"
@onready var passenger = get_parent()

var names = {}
var adresses_dict = {}

var male_names = []
var male_surnames = []
var female_names = []
var female_surnames = []

var adresses = []

var current_year = 99
var pesel

func _ready() -> void:
	read_names()
	read_adresses()
	passenger.pesel = generate_pesel()

func read_names():
	names = json_preloader.get_resource("passenger_names").get_data()
	male_names = names["imiona_meskie"]
	female_names = names["imiona_damskie"]
	male_surnames = names["nazwiska_meskie"]
	female_surnames = names["nazwiska_damskie"]

func read_adresses():
	adresses_dict = json_preloader.get_resource("passenger_adresses").get_data()
	adresses = adresses_dict["adresses"]

func generate_pesel():
	var birth_year = str(current_year - passenger.age)
	if birth_year.length() == 1:
		birth_year = "0" + birth_year
	var month = str(randi_range(1, 12))
	if month.length() == 1:
		month = "0" + month
	var day = str(randi_range(1, 28))
	if day.length() == 1:
		day = "0" + day
	var three_randoms = str(randi_range(111,999))
	var gender_num
	match passenger.gender:
		"m":
			gender_num = str([1,3,5,7,9].pick_random())
		"f":
			gender_num = str([0,2,4,6,8].pick_random())
	var last_num = str(randi_range(1,9))
	pesel = birth_year + month + day + three_randoms + gender_num + last_num
	return pesel

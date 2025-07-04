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
var months = ["sty", "lut", "mar", "kwie", "maja", "czer", "lip", "sier", "wrze", "paź", "lis", "gru"]

var current_year = 1995
var pesel
var birth_date

var b_year
var b_month
var b_month_num
var b_day

func _ready() -> void:
	read_names()
	read_adresses()
	passenger.birth_date = generate_birth_date()
	passenger.years_of_study = generate_years_of_study()
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

func generate_birth_date():
	b_year = current_year - passenger.age
	b_month = months.pick_random()
	b_month_num = months.find(b_month) + 1
	b_day = randi_range(1,28)
	birth_date = str(b_day) + " " + b_month + " " + str(b_year) + "r."
	return birth_date

func generate_years_of_study():
	var years_of_study
	if passenger.age >=19 and passenger.age <=22:
		years_of_study = randi_range(1,4)
	elif passenger.age >=23 and passenger.age <=26:
		years_of_study = randi_range(1,5)
	return years_of_study

func generate_pesel():
	var birth_year = str(b_year - 1900)
	if birth_year.length() == 1:
		birth_year = "0 " + birth_year
	else:
		var unit = birth_year[1]
		birth_year = birth_year.left(-1) + " " + unit
		
	var month = str(b_month_num)
	if month.length() == 1:
		month = "0 " + month
	else:
		var unit = month[1]
		month = month.left(-1) + " " + unit
		
	var day = str(b_day)
	if day.length() == 1:
		day = "0 " + day
	else:
		var unit = day[1]
		day = day.left(-1) + " " + unit
		
	var three_randoms = str(randi_range(1,9)) + " " + str(randi_range(1,9)) + " " + str(randi_range(1,9))
	var gender_num
	match passenger.gender:
		"m":
			gender_num = str([1,3,5,7,9].pick_random())
		"f":
			gender_num = str([0,2,4,6,8].pick_random())
	var last_num = str(randi_range(1,9))
	pesel = birth_year + " " + month + " " + day + " " + three_randoms + " " + gender_num + " " + last_num
	return pesel

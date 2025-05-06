extends Node

var ticket
var document

func assign_ticket(age, age_range):

	match age_range:
		"youth":
			ticket = "ULGOWY"
		"young_adult":
			ticket = "NORMALNY"
		"middle_age":
			ticket = "NORMALNY"
		"senior":
			ticket = "SENIORA"
		"elderly":
			ticket = "SENIORA"
	
	if age >=19 and age <= 26:
		ticket = ["NORMALNY", "STUDENCKI"].pick_random()
	
	assign_document(age)

func assign_document(age):
	match ticket:
		"ULGOWY":
			#document = null ## preload(sciezka do legitki szkolnej).instantiate()
			document = load("res://Scenes/student_id.tscn")

		"STUDENCKI":
			document = load("res://Scenes/student_id.tscn")

		"NORMALNY":
			#document = null
			document = load("res://Scenes/student_id.tscn")
			
		"SENIORA":
			#document = null ## preload(sciezka do dowodu osobistego).instantiate()
			document = load("res://Scenes/student_id.tscn")

	
	get_parent().ticket_type = ticket
	get_parent().document = document

extends Node

var ticket
var ticket_text
var document

func assign_ticket(age, age_range):

	match age_range:
		"youth":
			ticket = "Ulgowy"
		"young_adult":
			ticket = "Normalny"
		"middle_age":
			ticket = "Normalny"
		"senior":
			ticket = "Seniora"
		"elderly":
			ticket = "Seniora"
	
	if age >=19 and age <= 26:
		ticket = ["Normalny", "Studencki", "Studencki"].pick_random()
	
	assign_document(age)

func assign_document(age):
	match ticket:
		"Ulgowy":
			#document = preload(sciezka do legitki szkolnej).instantiate()
			document = load("res://Scenes/student_id.tscn")
			ticket_text = "BILET ULGOWY"

		"Studencki":
			document = load("res://Scenes/student_id.tscn")
			ticket_text = "BILET ULGOWY"

		"Normalny":
			#document = preload(sciezka do dowodu osobistego).instantiate()
			document = load("res://Scenes/id_card.tscn")
			ticket_text = "BILET NORMALNY"
			
		"Seniora":
			#document = preload(sciezka do dowodu osobistego).instantiate()
			document = load("res://Scenes/id_card.tscn")
			ticket_text = "BILET ULGOWY"

	
	get_parent().ticket_type = ticket_text
	get_parent().document = document

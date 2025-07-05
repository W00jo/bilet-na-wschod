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
		#ticket = "Studencki"
	assign_document(age)

func assign_document(age):
	match ticket:
		"Ulgowy":
			#document = preload(sciezka do legitki szkolnej).instantiate()
			document = load("res://Scenes/id_card.tscn")
			#ticket_text = "BILET ULGOWY"
			ticket_text = "BILET NORMALNY"

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
	


func make_problematic():
	print("is_problematic")
	if ticket_text == "BILET ULGOWY" and get_parent().age_range != "elderly":
		var problem = ["no_ticket", "no_document", "no_document", "invalid_document", "invalid_document"].pick_random()
		#var problem = "invalid_document" ### FOR_TEST
		match problem:
			"no_ticket":
				get_parent().has_ticket = false
			"no_document":
				get_parent().has_document = false
			"invalid_document":
				get_parent().is_document_valid = false
	else:
		get_parent().has_ticket = false
	print("ticket: ", get_parent().has_ticket, "  document: ", get_parent().has_document)

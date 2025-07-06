extends RichTextLabel

@onready var ticket_button = $"../../OptionBox/VBoxContainer/AskTicket"
@onready var document_button = $"../../OptionBox/VBoxContainer/AskDocument"

var personality: String

var typing_speed := 0.02 # seconds per character
var is_typing := false
var displayed_bbcode := ""

var player_greeting = "Dzień dobry."

var dialogue = {
	
	"overly_polite": {
		"greetings": [
			"Dzień dobry!", 
			"Czołem Panie konduktorze!", 
			"Witam serdecznie Pana konduktora!",
			"Miło Pana widzieć! Dzień dobry!",
			"Dzień dobry! Jak się Pan dziś miewa?"
		],
		"ticket_yes": [
			"Proszę oto bilet, proszę Pana.",
			"Oczywiście! Oto mój bilet, proszę bardzo sprawdzić.",
			"Naturalnie! Proszę, tu jest mój bilet.",
			"Ale pewnie! Proszę oto bilet, wszystko w porządku."
		],
		"ticket_no": [
			"O nie... chyba mi wypadł...",
			"Jezusie! Gdzie ja go podziałem?",
			"O rany! Może w torebce... nie, nie ma...",
			"Boże drogi! Chyba zostawiłem w domu..."
		],
		"id_yes": [
			"Proszę bardzo. Wszystko się zgadza, mam nadzieję?",
			"Oczywiście! Tu jest mój dokument, proszę sprawdzić.",
			"Naturalnie! Proszę, wszystko aktualne.",
			"Ale pewnie! Proszę bardzo, tu mój dowód."
		],
		"id_no": [
			"Chyba został w innych spodniach...",
			"O nie! Zapomniałem go w domu...",
			"Jezusie! Może w drugiej torebce został...",
			"Boże! Chyba leży na stoliku w domu..."
		],
		"player_ask_ticket": [
			"Bilecik poproszę.",
			"Czy mogę prosić o bilet?",
			"Proszę o okazanie biletu."
		],
		"player_ask_id": [
			"Proszę się wylegitymować",
			"Mógłby Pan pokazać dokument?",
			"Proszę o okazanie dowodu osobistego."
		],
		"player_investigate": [
			"Hmm... Coś mi się tu nie zgadza...",
			"Moment... To wygląda podejrzanie...",
			"Proszę chwileczkę... Coś tu nie gra..."
		],
		"student_invalid": [
			"Ajj... Kto by pamiętał o tych pieczątkach!",
			"O rany! Zapomniałem przedłużyć!",
			"Jezusie! Faktycznie nie podbita...",
			"Boże! A to ja zupełnie zapomniałem!"
		],
		"senior_invalid": [
			"No proszę Pana, 60-tka! za pasem!",
			"Ale proszę Pana, już prawie senior!",
			"Och, może Pan przymknie oko? Tak niewiele brakuje!",
			"Proszę Pana, za kilka miesięcy będę miał 60!"
		],
		"student_defense": [
			"Wszystko podbite tak jak trzeba!",
			"Ależ jest pieczątka! Proszę dokładniej spojrzeć!",
			"Wszystko w porządku! Proszę jeszcze raz sprawdzić!",
			"Ale przecież to jest ważne! Proszę przyjrzeć się!"
		],
		"senior_defense": [
			"A niech Pan policzy dokładniej!",
			"Proszę Pana! Mam już swoje lata!",
			"Ależ to jasne jak słońce! Jestem seniorem!",
			"Proszę dokładnie sprawdzić moją datę urodzenia!"
		],
		"adult_defense": [
			"Skąd takie podejrzenia?",
			"Wszystko jest w jak najlepszym porządku!",
			"Nie rozumiem o co chodzi, wszystko się zgadza!",
			"Proszę Pana, przecież to oryginał!"
		]
	},
	
	"polite": {
		"greetings": [
			"Dzień dobry!",
			"Witam!",
			"Dzień dobry Panu!",
			"Miłego dnia!"
		],
		"ticket_yes": [
			"Proszę bardzo.",
			"Oczywiście, tu jest.",
			"Naturalnie, proszę.",
			"Tu jest mój bilet."
		],
		"ticket_no": [
			"O nie... chyba mi wypadł...",
			"Hmm... Nie mogę go znaleźć...",
			"Chyba go zgubiłem...",
			"Może został w domu..."
		],
		"id_yes": [
			"Oczywiście.",
			"Proszę bardzo.",
			"Tu jest mój dokument.",
			"Naturalnie, proszę."
		],
		"id_no": [
			"Chyba został w innych spodniach...",
			"Nie mam go przy sobie...",
			"Zapomniałem go w domu...",
			"Może w drugiej torebce..."
		],
		"player_ask_ticket": [
			"Bilet poproszę.",
			"Czy mogę prosić o bilet?",
			"Proszę o bilet."
		],
		"player_ask_id": [
			"Proszę pokazać dokument.",
			"Mógłby Pan pokazać dowód?",
			"Proszę o dokument."
		],
		"player_investigate": [
			"Coś się tu nie zgadza...",
			"Moment... To wygląda dziwnie...",
			"Hmm... Sprawdzę to dokładniej..."
		],
		"student_invalid": [
			"Oj... Faktycznie nie podbita...",
			"Rzeczywiście, zapomniałem przedłużyć...",
			"Ups... Nie zauważyłem...",
			"Faktycznie, już nieważna..."
		],
		"senior_invalid": [
			"Czy mógłby Pan przymknąć oko? Tylko troszeczkę mi brakuje...",
			"Może Pan będzie łaskawy? Tak mało brakuje...",
			"Proszę, za chwilę będę miał 60...",
			"Może tym razem się uda?"
		],
		"student_defense": [
			"Podbita jest!",
			"Wszystko w porządku!",
			"Proszę jeszcze raz sprawdzić!",
			"To jest ważne!"
		],
		"senior_defense": [
			"Zapewniam, że wszystko się zgadza!",
			"Proszę dokładnie sprawdzić!",
			"Mam już swoje lata!",
			"Jestem seniorem!"
		],
		"adult_defense": [
			"Czemu coś miałoby się nie zgadzać?",
			"Wszystko jest w porządku!",
			"To oryginał!",
			"Nie rozumiem problemu..."
		]
	},
	"rude": {
		"greetings": [
			"Czego?",
			"Co tam?",
			"No?",
			"Tak?",
			"Czego chcesz?"
		],
		"ticket_yes": [
			"Bierz.",
			"No masz.",
			"Dawaj sprawdzaj.",
			"Tu jest, sprawdzaj szybko."
		],
		"ticket_no": [
			"Nie mam, no i co?",
			"A co, nie widać?",
			"Nie ma i koniec.",
			"Zgubił się, masz problem?"
		],
		"id_yes": [
			"No masz.",
			"Bierz i sprawdzaj.",
			"Tu jest, nie gryź.",
			"Dawaj, szybko."
		],
		"id_no": [
			"A po co?",
			"Nie mam i co?",
			"Po co ci?",
			"Nie noszę przy sobie."
		],
		"player_ask_ticket": [
			"Bilet.",
			"Bilet dawaj.",
			"Pokaż bilet.",
			"Gdzie bilet?"
		],
		"player_ask_id": [
			"Dokument.",
			"Pokaż dowód.",
			"Legitimacja.",
			"Gdzie dokument?"
		],
		"player_investigate": [
			"Co to ma być?",
			"Co kombinujesz?",
			"Czego szukasz?",
			"Co ci nie pasuje?"
		],
		"student_invalid": [
			"Czego się czepiasz? Kasuj.",
			"I co z tego?",
			"Nie twój problem.",
			"A co cię to obchodzi?"
		],
		"senior_invalid": [
			"Co, starszemu człowiekowi nie odpuścisz?",
			"Nie szanujeszь starszych?",
			"Czego się czepiasz starego człowieka?",
			"Nie masz serca?"
		],
		"student_defense": [
			"No przecież jest podbita!",
			"Ślepak jesteś?",
			"Zobacz lepiej!",
			"Podbita jest, nie widzisz?"
		],
		"senior_defense": [
			"Co, liczyć nie umiesz?",
			"Idź się naucz liczyć!",
			"Sprawdź jeszcze raz!",
			"Nie umiesz czytać?"
		],
		"adult_defense": [
			"Po co mi w ogóle sprawdzasz!",
			"Czego się czepiasz?",
			"Wszystko w porządku!",
			"Nie ma o czym gadać!"
		]
	},
	"fraidy": {
		"greetings": [
			"Dzie- dzień dobry...",
			"Witam... proszę Pana...",
			"Dzień dobry Panu...",
			"Ee... dzień dobry...",
			"Witam... przepraszam..."
		],
		"ticket_yes": [
			"Jest! Momencik, tylko znajdę...",
			"Tak! Zaraz... tu gdzieś jest...",
			"O tak! Proszę, tu jest...",
			"Mam! Proszę bardzo..."
		],
		"ticket_no": [
			"N- nie mam... Przepraszam!",
			"Boję się, że nie mam...",
			"Chyba... chyba go nie ma...",
			"Przykro mi... nie mam..."
		],
		"id_yes": [
			"Oczywiście!",
			"Tak... tu jest...",
			"Proszę bardzo...",
			"Mam... proszę..."
		],
		"id_no": [
			"Ja... w domu jest...",
			"Nie mam... przepraszam...",
			"Zapomniałem... przykro mi...",
			"W domu został... sorki..."
		],
		"player_ask_ticket": [
			"Bilet proszę.",
			"Mógłby Pan pokazać bilet?",
			"Proszę o bilet."
		],
		"player_ask_id": [
			"Dokument?",
			"Mógłby Pan pokazać dowód?",
			"Proszę o dokument."
		],
		"player_investigate": [
			"No no, coś mi tu nie gra...",
			"Hmm... To wygląda dziwnie...",
			"Coś tu nie tak..."
		],
		"student_invalid": [
			"...",
			"Och... rzeczywiście...",
			"Ups... nie zauważyłem...",
			"Ojej... faktycznie..."
		],
		"senior_invalid": [
			"Yyy...",
			"Hmm... może Pan... może?",
			"Proszę... może tym razem?",
			"Ehh... proszę bardzo..."
		],
		"student_defense": [
			"M- myślę, że wszystko się zgadza!",
			"Ale... ale przecież jest podbita!",
			"Wydaje mi się, że w porządku...",
			"Chyba... chyba wszystko dobrze..."
		],
		"senior_defense": [
			"Jest Pan pewien...?",
			"Może Pan sprawdzi jeszcze raz?",
			"Czy... czy na pewno?",
			"Proszę... może się Pan pomylił?"
		],
		"adult_defense": [
			"N- nie rozumiem...? Co może być nie tak?",
			"Ale... ale przecież wszystko w porządku...",
			"Nie wiem... co może być źle?",
			"Wydaje mi się, że wszystko dobrze..."
		]
	}
}


#func greet():
	#personality = PassengerDataBus.currently_checked_passenger.personality
	#var greeting = dialogue[personality]["greetings"].pick_random()
	#text = "[right][color=STEEL_BLUE]%s[/color][/right]\n[left]%s[/left]" % [player_greeting, greeting]

func greet():
	displayed_bbcode = ""
	personality = PassengerDataBus.currently_checked_passenger.personality
	var npc_text = dialogue[personality]["greetings"].pick_random()
	var new_lines = [
		{"align": "right", "text": player_greeting},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)


func _on_ask_ticket_pressed() -> void:
	if is_typing:
		return
	ticket_button.disabled = true
	var ticket_yes_or_no
	match PassengerDataBus.currently_checked_passenger.has_ticket:
		true:
			ticket_yes_or_no = "ticket_yes"
		false:
			ticket_yes_or_no = "ticket_no"
	var npc_text = dialogue[personality][ticket_yes_or_no].pick_random()
	var player_text = dialogue[personality]["player_ask_ticket"].pick_random()
	var new_lines = [
		{"align": "right", "text": player_text},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)
	


func _on_ask_document_pressed() -> void:
	if is_typing:
		return
	document_button.disabled = true
	var id_yes_or_no
	match PassengerDataBus.currently_checked_passenger.has_document:
		true:
			id_yes_or_no = "id_yes"
		false:
			id_yes_or_no = "id_no"
	var npc_text = dialogue[personality][id_yes_or_no].pick_random()
	var player_text = dialogue[personality]["player_ask_id"].pick_random()
	var new_lines = [
		{"align": "right", "text": player_text},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)
	

func on_investigate(doc_type, is_valid):
	if is_typing:
		return
	var player_text = dialogue[personality]["player_investigate"].pick_random()
	var npc_text
	match doc_type:
		"student_id":
			if is_valid:
				npc_text = dialogue[personality]["student_defense"].pick_random()
			else:
				npc_text = dialogue[personality]["student_invalid"].pick_random()
		"id_card":
			if PassengerDataBus.currently_checked_passenger.age_range == "senior" or PassengerDataBus.currently_checked_passenger.age_range == "elderly":
				if is_valid:
					npc_text = dialogue[personality]["senior_defense"].pick_random()
				else:
					npc_text = dialogue[personality]["senior_invalid"].pick_random()
			else:
				npc_text = dialogue[personality]["adult_defense"].pick_random()
	
	var new_lines = [
		{"align": "right", "text": player_text},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)
	
	
func show_text_typewriter(bbcode_blocks: Array, prefix: String = "") -> void:
	is_typing = true
	text = prefix
	var result := prefix
	for block in bbcode_blocks:
		result += block["prefix"]
		for i in block["text"].length():
			text = result + block["text"].left(i + 1) + block["suffix"]
			await get_tree().create_timer(typing_speed).timeout
		result += block["text"] + block["suffix"]
	text = result # Ensure full text at the end
	is_typing = false
	
# Helper to build BBCode blocks for typewriter effect
func build_bbcode_blocks(dialogue_lines: Array) -> Array:
	var blocks := []
	for line in dialogue_lines:
		var prefix = "[%s]" % line.align
		var suffix = "[/%s]\n" % line.align
		
		# Add steel blue color for player (right-aligned) text
		if line.align == "right":
			prefix = "[%s][color=steelblue]" % line.align
			suffix = "[/color][/%s]\n" % line.align
		
		blocks.append({"prefix": prefix, "text": line.text, "suffix": suffix})
	return blocks

func build_bbcode_from_blocks(blocks: Array) -> String:
	var bbcode := ""
	for block in blocks:
		bbcode += block["prefix"] + block["text"] + block["suffix"]
	return bbcode
	
	
	
	
	
	
	
	
	
	
	
	

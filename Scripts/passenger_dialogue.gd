extends RichTextLabel

@onready var ticket_button = $"../../OptionBox/VBoxContainer/AskTicket"
@onready var document_button = $"../../OptionBox/VBoxContainer/AskDocument"

var personality: String

var player_greeting = "Dzień dobry."

var dialogue = {
	
	"overly_polite": {
<<<<<<< Updated upstream
		"greetings": ["Dzień dobry!", "Czołem Panie konduktorze!"],
		"ticket_yes": ["Proszę oto bilet, proszę Pana."],
		"ticket_no": ["O nie... chyba mi wypadł..."],
		"id_yes": ["Proszę bardzo. Wszystko się zgadza, mam nadzieję?"],
		"id_no": ["Chyba został w innych spodniach..."],
		"player_ask_ticket": ["Bilecik poproszę."],
		"player_ask_id": ["Proszę się wylegitymować"]
	},
	
	"polite": {
		"greetings": ["Dzień dobry!"],
		"ticket_yes": ["Proszę bardzo."],
		"ticket_no": ["O nie... chyba mi wypadł..."],
		"id_yes": ["Oczywiście."],
		"id_no": ["Chyba został w innych spodniach..."],
		"player_ask_ticket": ["Bilet poproszę."],
		"player_ask_id": ["Proszę pokazać dokument."]
	},
	"rude": {
		"greetings": ["Czego?"],
		"ticket_yes": ["Bierz."],
		"ticket_no": ["Nie mam, no i co?"],
		"id_yes": ["No masz."],
		"id_no": ["A po co?"],
		"player_ask_ticket": ["Bilet."],
		"player_ask_id": ["Dokument."]
	},
	"fraidy": {
		"greetings": ["Dzie- dzień dobry..."],
		"ticket_yes": ["Jest! Momencik, tylko znajdę..."],
		"ticket_no": ["N- nie mam... Przepraszam!"],
		"id_yes": ["Oczywiście!"],
		"id_no": ["Ja... w domu jest..."],
		"player_ask_ticket": ["Bilet proszę."],
		"player_ask_id": ["Dokument?"]
=======
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
			"Boziuniu! Chyba zostawiłem w domu..."
		],
		"id_yes": [
			"Proszę bardzo. Wszystko się zgadza, mam nadzieję?",
			"Oczywiście! Tu jest mój dokument, proszę sprawdzić.",
			"Naturalnie! Proszę, wszystko aktualne.",
			"Ależ pewnie! Proszę bardzo, tu mój dowód."
		],
		"id_no": [
			"Chyba został przy kasie...",
			"O nie! Zapomniałem go w domu...",
			"Jezusie! Może w drugiej torebce został...",
			"Ło Jezusku! Chyba mi wypadł..."
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
>>>>>>> Stashed changes
	}
}


func greet():
	personality = PassengerDataBus.currently_checked_passenger.personality
	var greeting = dialogue[personality]["greetings"].pick_random()
	text = "[right][color=STEEL_BLUE]%s[/color][/right]\n[left]%s[/left]" % [player_greeting, greeting]


func _on_ask_ticket_pressed() -> void:
	var ticket_yes_or_no
	match PassengerDataBus.currently_checked_passenger.has_ticket:
		true:
			ticket_yes_or_no = "ticket_yes"
		false:
			ticket_yes_or_no = "ticket_no"
	var npc_text = dialogue[personality][ticket_yes_or_no].pick_random()
	var player_text = dialogue[personality]["player_ask_ticket"].pick_random()
	text += "\n[right][color=STEEL_BLUE]%s[/color][/right]\n[left]%s[/left]" % [player_text, npc_text]
	ticket_button.disabled = true


func _on_ask_document_pressed() -> void:
	var id_yes_or_no
	match PassengerDataBus.currently_checked_passenger.has_document:
		true:
			id_yes_or_no = "id_yes"
		false:
			id_yes_or_no = "id_no"
	var npc_text = dialogue[personality][id_yes_or_no].pick_random()
	var player_text = dialogue[personality]["player_ask_id"].pick_random()
	text += "\n[right][color=STEEL_BLUE]%s[/color][/right]\n[left]%s[/left]" % [player_text, npc_text]
	document_button.disabled = true

extends RichTextLabel

@onready var ticket_button = $"../../OptionBox/VBoxContainer/AskTicket"
@onready var document_button = $"../../OptionBox/VBoxContainer/AskDocument"

var personality: String

var player_greeting = "Dzień dobry."

var dialogue = {
	
	"overly_polite": {
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

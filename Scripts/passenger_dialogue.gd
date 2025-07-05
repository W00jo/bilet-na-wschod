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
		"greetings": ["Dzień dobry!", "Czołem Panie konduktorze!"],
		"ticket_yes": ["Proszę oto bilet, proszę Pana."],
		"ticket_no": ["O nie... chyba mi wypadł..."],
		"id_yes": ["Proszę bardzo. Wszystko się zgadza, mam nadzieję?"],
		"id_no": ["Chyba został w innych spodniach..."],
		"player_ask_ticket": ["Bilecik poproszę."],
		"player_ask_id": ["Proszę się wylegitymować"],
		"player_investigate": ["Hmm... Coś mi się tu nie zgadza..."],
		"student_invalid": ["Ajj... Kto by pamiętał o tych pieczątkach!"],
		"senior_invalid": ["No proszę Pana, 60-tka! za pasem!"],
		"student_defense": ["Wszystko podbite tak jak trzeba!"],
		"senior_defense": ["A niech Pan policzy dokładniej!"],
		"adult_defense": ["Skąd takie podejrzenia?"]
	},
	
	"polite": {
		"greetings": ["Dzień dobry!"],
		"ticket_yes": ["Proszę bardzo."],
		"ticket_no": ["O nie... chyba mi wypadł..."],
		"id_yes": ["Oczywiście."],
		"id_no": ["Chyba został w innych spodniach..."],
		"player_ask_ticket": ["Bilet poproszę."],
		"player_ask_id": ["Proszę pokazać dokument."],
		"player_investigate": ["Coś się tu nie zgadza..."],
		"student_invalid": ["Oj... Faktycznie nie podbita..."],
		"senior_invalid": ["Czy mógłby Pan przymknąć oko? Tylko troszeczkę mi brakuje..."],
		"student_defense": ["Podbita jest!"],
		"senior_defense": ["Zapewniam, że wszystko się zgadza!"],
		"adult_defense": ["Czemu coś miałoby się nie zgadzać?"]
	},
	"rude": {
		"greetings": ["Czego?"],
		"ticket_yes": ["Bierz."],
		"ticket_no": ["Nie mam, no i co?"],
		"id_yes": ["No masz."],
		"id_no": ["A po co?"],
		"player_ask_ticket": ["Bilet."],
		"player_ask_id": ["Dokument."],
		"player_investigate": ["Co to ma być?"],
		"student_invalid": ["Czego się czepiasz? Kasuj."],
		"senior_invalid": ["Co, starszemu człowiekowi nie odpuścisz?"],
		"student_defense": ["No przecież jest podbita!"],
		"senior_defense": ["Co, liczyć nie umiesz?"],
		"adult_defense": ["Po co mi w ogóle sprawdzasz!"]
	},
	"fraidy": {
		"greetings": ["Dzie- dzień dobry..."],
		"ticket_yes": ["Jest! Momencik, tylko znajdę..."],
		"ticket_no": ["N- nie mam... Przepraszam!"],
		"id_yes": ["Oczywiście!"],
		"id_no": ["Ja... w domu jest..."],
		"player_ask_ticket": ["Bilet proszę."],
		"player_ask_id": ["Dokument?"],
		"player_investigate": ["No no, coś mi tu nie gra..."],
		"student_invalid": ["..."],
		"senior_invalid": ["Yyy..."],
		"student_defense": ["M- myślę, że wszystko się zgadza!"],
		"senior_defense": ["Jest Pan pewien...?"],
		"adult_defense": ["N- nie rozumiem...? Co może być nie tak?"]
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
	
	
	
	
	
	
	
	
	
	
	
	

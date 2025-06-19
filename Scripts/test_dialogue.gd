extends Control

var dialogue = {
	"polite": {
		"greetings": ["Dzień dobry!", "Czołem Panie konduktorze!"],
		"ticket_yes": ["Proszę oto bilet, proszę Pana."],
		"ticket_no": ["O nie... chyba mi wypadł..."],
		"id_yes": ["Proszę bardzo. [P] Wszystko się zgadza, mam nadzieję?"],
		"id_no": ["Chyba został w innych spodniach..."]
	},
	"rude": {
		"greetings": ["Czego?"],
		"ticket_yes": ["Bierz."],
		"ticket_no": ["Nie mam, no i co?"],
		"id_yes": ["No masz."],
		"id_no": ["A po co?"]
	},
	"fraidy": {
		"greetings": ["Dzie- dzień dobry..."],
		"ticket_yes": ["Jest! Momencik, tylko znajdę..."],
		"ticket_no": ["N- nie mam... Przepraszam!"],
		"id_yes": ["Oczywiście!"],
		"id_no": ["Ja... w domu jest..."]
	}
}

var dialogue_box: RichTextLabel
var personality: String

func _ready():
	dialogue_box = $Panel/RichTextLabel
	# Przy starcie sceny powinno wybierać losowo osbowość :3
	var personalities = ["polite", "rude", "fraidy"]
	personality = personalities.pick_random()
	# "greetings" używa tylko na starcie
	var greeting = dialogue[personality]["greetings"].pick_random()
	dialogue_box.text = "[left]" + greeting + "[/left]"

func _on_bilet_pressed():
	var yes_or_no = ["ticket_yes", "ticket_no"].pick_random()
	var npc_text = dialogue[personality][yes_or_no].pick_random()
	var player_text = "Proszę bilet"
	dialogue_box.text = "[left]%s[/left]\n[right]%s[/right]" % [npc_text, player_text]
	print("Bilet pressed, personality:", personality, "key:", yes_or_no, "npc:", npc_text)

func _on_id_pressed():
	var yes_or_no = ["id_yes", "id_no"].pick_random()
	var npc_text = dialogue[personality][yes_or_no].pick_random()
	var player_text = "Proszę bilet"
	dialogue_box.text = "[left]%s[/left]\n[right]%s[/right]" % [npc_text, player_text]
	print("Bilet pressed, personality:", personality, "key:", yes_or_no, "npc:", npc_text)

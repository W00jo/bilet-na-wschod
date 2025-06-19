extends Control

var typing_speed := 0.02 # seconds per character
var is_typing := false
var displayed_bbcode := ""

var dialogue = {
	"polite": {
		"greetings": ["Dzień dobry!", "Czołem Panie konduktorze!"],
		"ticket_yes": ["Proszę oto bilet, proszę Pana."],
		"ticket_no": ["O nie... chyba mi wypadł..."],
		"id_yes": ["Proszę bardzo. Wszystko się zgadza, prawda?"],
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
var bilet_button: Button
var id_button: Button

# Helper to type out only the dialogue, not the tags
func show_text_typewriter(bbcode_blocks: Array, prefix: String = "") -> void:
	is_typing = true
	dialogue_box.text = prefix
	var result := prefix
	for block in bbcode_blocks:
		result += block["prefix"]
		for i in block["text"].length():
			dialogue_box.text = result + block["text"].left(i + 1) + block["suffix"]
			await get_tree().create_timer(typing_speed).timeout
		result += block["text"] + block["suffix"]
	dialogue_box.text = result # Ensure full text at the end
	is_typing = false
	
# Helper to build BBCode blocks for typewriter effect
func build_bbcode_blocks(dialogue_lines: Array) -> Array:
	var blocks := []
	for line in dialogue_lines:
		var prefix = "[%s]" % line.align
		var suffix = "[/%s]\n" % line.align
		blocks.append({"prefix": prefix, "text": line.text, "suffix": suffix})
	return blocks

func build_bbcode_from_blocks(blocks: Array) -> String:
	var bbcode := ""
	for block in blocks:
		bbcode += block["prefix"] + block["text"] + block["suffix"]
	return bbcode

func _ready():
	dialogue_box = $Panel/RichTextLabel
	bilet_button = $VBoxContainer/Bilet
	id_button = $VBoxContainer/Id
	var personalities = ["polite", "rude", "fraidy"]
	personality = personalities.pick_random()
	var greeting = dialogue[personality]["greetings"].pick_random()
	var blocks = build_bbcode_blocks([{"align": "left", "text": greeting}])
	displayed_bbcode = build_bbcode_from_blocks(blocks)
	dialogue_box.text = displayed_bbcode

func _on_bilet_pressed():
	if is_typing:
		return
	var yes_or_no = ["ticket_yes", "ticket_no"].pick_random()
	var npc_text = dialogue[personality][yes_or_no].pick_random()
	var player_text = "Proszę bilet"
	var new_lines = [
		{"align": "right", "text": player_text},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)
	bilet_button.disabled = true
	print("Bilet pressed, personality: ", personality, "key: ", yes_or_no, "npc: ", npc_text)

func _on_id_pressed():
	if is_typing:
		return
	var yes_or_no = ["id_yes", "id_no"].pick_random()
	var npc_text = dialogue[personality][yes_or_no].pick_random()
	var player_text = "Proszę się wylegitymować"
	var new_lines = [
		{"align": "right", "text": player_text},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)
	id_button.disabled = true
	print("ID pressed, personality: ", personality, "key: ", yes_or_no, "npc: ", npc_text)

# Helper to parse existing BBCode lines into [{align, text}]
func parse_bbcode_lines(bbcode: String) -> Array:
	var lines := []
	var regex = RegEx.new()
	regex.compile("\\[(left|right)\\](.*?)\\[/\\1\\]")
	for result in regex.search_all(bbcode):
		var align = result.get_string(1)
		var text = result.get_string(2)
		lines.append({"align": align, "text": text})
	return lines

extends Control

@onready var dialogue_box:RichTextLabel = $Test/DialogueBox
@onready var anim = $AnimationPlayer



var dialogue = {
	"seq_1":  [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["Dobra młody, będziesz mieć kurs przyspieszony, jestem umówiony na wódke z chłopakami w Piaskach.",
		"Zrobimy szybką powtórke ze szkoleń"]
	],
	
	"seq_2":  [
		load("res://Assets/Sprites/TutorialAvatars/conductor_tutorial.png"),
		
		"Janusz Efinowicz",
		
		["N...No dobrze."]
	],
	
	"seq_3":  [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["Pamiętaj, młody… jak zobaczysz pasażera bez biletu, to nie krzycz. On się już wystarczająco zestresował, że zamiast do Krasnego jedzie do Kołobrzegu."]
	],
	
	"seq_4":  [
		load("res://Assets/Sprites/TutorialAvatars/conductor_tutorial.png"),
		
		"Janusz Efinowicz",
		
		["Taa… znam to."]
	],
	
	"seq_5":  [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["Dobra młody, słuchaj bo dwa razy powtarzał nie będę.",
		"Najpierw prosisz o bilet."]
	],
	"seq_6": [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["Ta pani jakaś młoda jest, zapytaj o legitymację."]
	],
	
	"seq_7": [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["Teraz szukaj w torbie dziurkacza i kasuj bilet."]
	],
	
	"seq_8": [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["Ładnie młody, pasażerka w futrze puściła ci oczko, a ty tylko bilet skasowałeś."]
	],
	
	"seq_9": [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["Teraz idź i skasuj tego ortaliona z jamnikiem, bilet w sensie."]
	],
	
	"seq_10": [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["No młody, uważaj na stres! ,
		W tej robocie nie ma lekko, jak serducho ci wysiądzie w połowie trasy to nic z tego nie będzie!"]
	],
	
	"seq_11":  [
		load("res://Assets/Sprites/TutorialAvatars/dres_tutorial.png"),
		
		"Dres",
		
		["Te konduktor!"]
	],
	
	"seq12":  [
		load("res://Assets/Sprites/TutorialAvatars/conductor_tutorial.png"),
		
		"Janusz Efinowicz",
		
		["Huh?"]
	],
	
	"seq_13":  [
		load("res://Assets/Sprites/TutorialAvatars/dres_tutorial.png"),
		
		"Dres",
		
		["Masz rodzine?",
		"To zadzwoń i sie pożegnaj!"]
	],
	
	"seq_14":  [
		load("res://Assets/Sprites/TutorialAvatars/friend_tutorial.png"),
		
		"Kolega",
		
		["Janusz, ej Janusz!",
		"Nie śpij, trzeba kasować pasażerów!"]
	],
	
	"seq15":  [
		load("res://Assets/Sprites/TutorialAvatars/conductor_tutorial.png"),
		
		"Janusz Efinowicz",
		
		["Nie śpię, nie śpię, już lecę..."]
	],
}

var sequence_num = 0
var page = 0
var current_sequence

var avatar_texture_id = 0
var name_id = 1
var text_array_id = 2

var dialogue_started = false

func start_tutorial_dialogue():
	get_parent().get_parent().disable_player_movement()
	$Test/ArrowIndicator.visible = false
	visible = true
	current_sequence = "seq_" + str(sequence_num+1)
	
	dialogue_box.set_text(dialogue[current_sequence][text_array_id][page])
	dialogue_box.set_visible_characters(0)
	$Test/Avatar.texture = dialogue[current_sequence][avatar_texture_id]
	$Test/NameLabel.text = dialogue[current_sequence][name_id]	

func _on_timer_timeout() -> void:
	dialogue_box.set_visible_characters(dialogue_box.get_visible_characters()+1)
	if dialogue_box.get_visible_characters() >= dialogue_box.get_total_character_count():
		$Test/ArrowIndicator.visible = true
		anim.play("arrow")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB") and dialogue_started:
		if page < dialogue[current_sequence][text_array_id].size()-1:
			page += 1
			start_tutorial_dialogue()
		else:
			
			if sequence_num < dialogue.size()-1:
				sequence_num += 1
				page = 0
				start_tutorial_dialogue()
			else:
				get_tree().quit()
			
			match sequence_num:
				4:
					stop_dialogue()
				5:
					stop_dialogue()
				6:
					stop_dialogue()
				7:
					stop_dialogue()
				8:
					stop_dialogue()
				9:
					stop_dialogue()
				13:
					stop_dialogue()
				15:
					stop_dialogue()

func stop_dialogue():
	visible = false
	dialogue_started = false
	page = 0
	get_parent().get_parent().enable_player_movement()


#func _on_button_1_pressed() -> void:
	#dialogue_started = true
	#start_tutorial_dialogue()


#func setup_dialogue_label():
	#$ArrowIndicator.visible = false
	#dialogue_label.set_text(greeting_dialogue[page])
	#dialogue_label.set_visible_characters(0)
#
#func _on_timer_timeout() -> void:
	#dialogue_label.set_visible_characters(dialogue_label.get_visible_characters()+1)
	#if dialogue_label.get_visible_characters() > dialogue_label.get_total_character_count():
		#$ArrowIndicator.visible = true
		#anim.play("arrow_next")
#
#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("Dialogue") and visible == true:
		#if dialogue_label.get_visible_characters() > dialogue_label.get_total_character_count():
			#if page < greeting_dialogue.size()-1:
				#page += 1
				#setup_dialogue_label()
			#else:
				#if get_parent().visible:
					#end_dialogue_sequence()
		#else:
			#dialogue_label.set_visible_characters(dialogue_label.get_total_character_count())
#
#func end_dialogue_sequence():
	#tween = create_tween()
	#tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.1)
	#await tween.finished
	#get_tree().paused = false

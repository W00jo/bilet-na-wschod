extends Control
@onready var avatar_sprite: TextureRect = $Test/Avatar
@onready var speaker_label: Label = $Test/NameLabel
@onready var dialogue_box:RichTextLabel = $Test/DialogueBox
@onready var anim = $AnimationPlayer
@onready var arrow_indicator:TextureRect = $Test/ArrowIndicator

const tutorial_guy = preload("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png")
const starszy_konduktor = "Starszy Konduktor"
const conductor_tutorial = preload("res://Assets/Sprites/TutorialAvatars/conductor_tutorial.png")
const janusz_efinowicz = "Janusz Efinowicz"
const dres_tutorial = preload("res://Assets/Sprites/TutorialAvatars/dres_tutorial.png")
const dres = "Sebastian Radomski"
const friend_tutorial = preload("res://Assets/Sprites/TutorialAvatars/friend_tutorial.png")
const friend = "Kolega"

var dialogue_sequence : Array = []
var current_index     : int   = 0
var current_page      : int   = 0
var dialogue_running  : bool  = false

func start_tutorial_dialogue() -> void:
	build_dialogue_sequence()
	current_index = 0
	current_page  = 0
	visible = true
	show_current()
	dialogue_running = true
	#get_tree().get_root().get_node("res://Scripts/player.gd").can_move = false

class DialogueSequence:
	var avatar
	var speaker_name
	var pages
	var on_complete
	
	func _init(a, name, text_pages:Array, cb = null):
		avatar = a
		speaker_name = name
		pages = text_pages
		on_complete = cb

func _ready() -> void:
	build_dialogue_sequence()
	show_current()
	print("Panel loaded from path:", get_path())
#sekwencja lini dialogów
func build_dialogue_sequence() -> void:
	dialogue_sequence = [
		DialogueSequence.new(tutorial_guy, starszy_konduktor,
			[
				"Dobra młody, będziesz mieć kurs przyspieszony, jestem umówiony na wódkę z chłopakami w Piaskach.",
				"Zrobimy szybką powtórkę ze szkoleń."
			],
			Callable(self, "_on_step_0_finished")
		),
		DialogueSequence.new(conductor_tutorial, janusz_efinowicz,
			["N...No dobrze."]
			
		),
		DialogueSequence.new(tutorial_guy, starszy_konduktor,
			[
				"Pamiętaj, młody… jak zobaczysz pasażera bez biletu, to nie krzycz. On się już wystarczająco zestresował, że zamiast do Krasnego jedzie do Kołobrzegu."
			],
			Callable(self, "_on_step_1_finished")
		),
		DialogueSequence.new(conductor_tutorial, janusz_efinowicz,
			["Taa… znam to."],
			Callable(self, "_on_step_2_finished")
		),
		]
#bieżaca strona dialogu
func show_current() -> void:
	var seq = dialogue_sequence[current_index]
	avatar_sprite.texture = seq.avatar
	speaker_label.text = seq.speaker_name
	#dialogue_box.clear()
	dialogue_box.bbcode_text = seq.pages[current_page]
	dialogue_box.visible_characters = -1
	arrow_indicator.visible = true
	anim.play("typewriter")
	dialogue_running = true
	
	#kliknij aby przejsc dalej
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and dialogue_running:
		advance_dialogue()
	
	#przechodzenie pomiędzy stronami i sekwencjami		
func advance_dialogue() -> void:
	var seq = dialogue_sequence[current_index]
	#Jeśli są strony w dialogu
	if current_page < seq.pages.size() - 1:
		current_page += 1
		show_current()
		return
	if seq.on_complete.is_valid():
		seq.on_complete.call()
		#kolejna sekwencja lub koniec dialogu
	current_index += 1
	current_page = 0
	if current_index >= dialogue_sequence.size():
		finish_dialogue()
	else: show_current()
		
#Kuniec dialogu haj
func finish_dialogue() -> void:
	dialogue_running = false
	hide()
	get_parent().get_parent().enable_player_movement()

#Callbacki dla wybranych kroków
#func _on_step_3_finished() -> void: #do testów daje 3
###func _on_step_15_finished() -> void:
	## Po ostatnim kroku odblokowujemy gracza i usuwamy panel
	#get_tree().get_first_node_in_group("Player").can_move = true
	#get_parent().queue_free()
	
		
		
		#DialougeSequence.new(conductor_tutorial, janusz_efinowicz,
			#["Taa… znam to."
		#]),
		#DialougeSequence.new(tutorial_guy, starszy_konduktor,
			#["Dobra, słuchaj bo dwa razy powtarzał nie będę.",
			#"Najpierw prosisz o bilet."
		#]),
		#DialougeSequence.new(tutorial_guy, starszy_konduktor,
			#["Ta pani jakaś młoda jest, zapytaj o legitymację."
		#]),
			#DialougeSequence.new(tutorial_guy, starszy_konduktor,
			#["Teraz szukaj w torbie dziurkacza i kasuj bilet."
		#]),
			#DialougeSequence.new(tutorial_guy, starszy_konduktor,
			#["Ładnie młody, pasażerka w futrze puściła ci oczko, a ty tylko bilet skasowałeś."
		#]),
			#DialougeSequence.new(tutorial_guy, starszy_konduktor,
			#["Teraz idź i skasuj tego ortaliona z jamnikiem, bilet w sensie."
		#]),
			#DialougeSequence.new(tutorial_guy, starszy_konduktor,
			#["Pamiętasz gdzie masz bloczek wezwań?",
			#"Zawsze trzymaj obok podręcznika, to ci się w stresie nie pogubi."
		#]),
			#DialougeSequence.new(dres_tutorial, dres,
			#["Te konduktor!"
		#]),
			#DialougeSequence.new(conductor_tutorial, janusz_efinowicz,
			#["Huh?"
		#]),
		#DialougeSequence.new(dres_tutorial, dres,
			#["Masz rodzine?",
			#"To zadzwoń i sie pożegnaj!"
		#]),
		#DialougeSequence.new(friend_tutorial, friend,
			#["Janusz, ej Janusz!",
			#"Nie śpij, trzeba kasować pasażerów!"
		#]),
		#DialougeSequence.new(conductor_tutorial, janusz_efinowicz,
			#["Nie śpię, nie śpię, już lecę..."
		#]),
	#]

#func start_tutorial_dialogue():
	#dialogue_started = true
	#get_parent().get_parent().disable_player_movement()
	#arrow_indicator.visible = false
	#visible = true
	#
	#dialogue_box.set_text(dialogue[current_sequence][text_array_id][page])
	#dialogue_box.set_visible_characters(0)
#
	##"seq_10": [
		##load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		##
		##"Starszy konduktor",
		##
		##["No młody, uważaj na stres! ,
		##W tej robocie nie ma lekko, jak serducho ci wysiądzie w połowie trasy to nic z tego nie będzie!"]
	##],
#
#
##var sequence_num = 0
##var page = 0
##var current_sequence
##
##var avatar_texture_id = 0
##var name_id = 1
##var text_array_id = 2
##
##var dialogue_started = false
#
#
	#
#
	#
#
#
#
#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("LMB") and dialogue_started:
		#if page < dialogue[current_sequence][text_array_id].size()-1:
			#page += 1
			#start_tutorial_dialogue()
		#else:
			#
			#if sequence_num < dialogue.size()-1:
				#sequence_num += 1
				#page = 0
				#start_tutorial_dialogue()
			#else:
				#return
			#
			#match sequence_num:
				#4:
					#stop_dialogue()
					#get_parent().get_parent().get_node('Levels/Tutorial').tutorial_guy.queue_free()
				#5:
					#stop_dialogue()
				#6:
					#stop_dialogue()
				#7:
					#stop_dialogue()
				#9:
					#stop_dialogue()
					#get_parent().get_parent().get_node('ToolkitLayer/LaskaControl').close()
					#get_parent().get_parent().get_node('Levels/Tutorial/WagonTutorial/TutGuy').position = get_parent().get_parent().get_node('Levels/Tutorial/WagonTutorial/TutorialGuyMarker').position
				#10:
					#stop_dialogue()
					##get_parent().get_parent().get_node('ToolkitLayer/DresControl').close()
					##get_parent().get_parent().get_node('Levels/Tutorial/WagonTutorial/TutGuy').queue_free()
				#13:
					#stop_dialogue()
					#$"../DeathScreen".visible = true
					#$Bam.play()
					#await get_tree().create_timer(0.75).timeout
					#$Bam.play()
					#$"../../Levels/Tutorial".queue_free()
					#var wagon_cont = load("res://Scenes/wagon_controller.tscn").instantiate()
					#$"../../Levels".add_child(wagon_cont)
					#await get_tree().create_timer(3).timeout
					#start_tutorial_dialogue()
					#
				#15:
					#stop_dialogue()
					#get_tree().get_first_node_in_group("Player").can_move = true
					#get_parent().queue_free()
#
#func stop_dialogue():
	#print("stoped")
	#visible = false
	#dialogue_started = false
	#page = 0
	#if get_parent().get_parent().get_node('ToolkitLayer/LaskaControl') != null and get_parent().get_parent().get_node('ToolkitLayer/DresControl') != null:
		#if get_parent().get_parent().get_node('ToolkitLayer/LaskaControl').visible == false and get_parent().get_parent().get_node('ToolkitLayer/DresControl').visible == false:
			#get_parent().get_parent().enable_player_movement()


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

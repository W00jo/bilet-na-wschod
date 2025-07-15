extends Control

# Improved Tutorial Dialogue System
# This version addresses performance, maintainability, and code organization issues

class_name TutorialDialogue

# Preloaded resources for better performance
const TUTORIAL_GUY_AVATAR = preload("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png")
const CONDUCTOR_AVATAR = preload("res://Assets/Sprites/TutorialAvatars/conductor_tutorial.png")
const DRES_AVATAR = preload("res://Assets/Sprites/TutorialAvatars/dres_tutorial.png")
const FRIEND_AVATAR = preload("res://Assets/Sprites/TutorialAvatars/friend_tutorial.png")

# Character names as constants
const SENIOR_CONDUCTOR = "Starszy konduktor"
const JANUSZ = "Janusz Efinowicz"
const DRES = "Dres"
const FRIEND = "Kolega"

# UI node references
@onready var dialogue_box: RichTextLabel = $Test/DialogueBox
@onready var avatar: TextureRect = $Test/Avatar
@onready var name_label: Label = $Test/NameLabel
@onready var arrow_indicator: Control = $Test/ArrowIndicator
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var bam_sound: AudioStreamPlayer = $Bam

# Game state references (cached for performance)
var game_controller: Node
var player: Node
var tutorial_level: Node
var toolkit_layer: Node

# Dialogue state
var current_sequence_index: int = 0
var current_page: int = 0
var dialogue_started: bool = false
var is_typing: bool = false

# Dialogue data structure
var dialogue_sequences: Array[DialogueSequence] = []

# Dialogue sequence data class
class DialogueSequence:
	var avatar: Texture2D
	var speaker_name: String
	var text_lines: Array[String]
	var action_callback: Callable
	
	func _init(p_avatar: Texture2D, p_speaker: String, p_lines: Array[String], p_callback: Callable = Callable()):
		avatar = p_avatar
		speaker_name = p_speaker
		text_lines = p_lines
		action_callback = p_callback

func _ready():
	_cache_node_references()
	_setup_dialogue_sequences()
	_connect_signals()

func _cache_node_references():
	"""Cache frequently accessed node references for better performance"""
	game_controller = get_parent().get_parent()
	player = get_tree().get_first_node_in_group("Player")
	
	# Safely get child nodes only if game_controller exists
	if game_controller:
		tutorial_level = game_controller.get_node_or_null('Levels/Tutorial')
		toolkit_layer = game_controller.get_node_or_null('ToolkitLayer')
	else:
		print("Warning: game_controller is null in tutorial_dialogue_improved.gd")
		tutorial_level = null
		toolkit_layer = null

func _connect_signals():
	"""Connect all necessary signals"""
	if timer and not timer.timeout.is_connected(_on_timer_timeout):
		timer.timeout.connect(_on_timer_timeout)

func _setup_dialogue_sequences():
	"""Initialize all dialogue sequences with their associated actions"""
	dialogue_sequences = [
		DialogueSequence.new(TUTORIAL_GUY_AVATAR, SENIOR_CONDUCTOR, [
			"Dobra młody, będziesz mieć kurs przyspieszony, jestem umówiony na wódke z chłopakami w Piaskach.",
			"Zrobimy szybką powtórke ze szkoleń"
		]),
		
		DialogueSequence.new(CONDUCTOR_AVATAR, JANUSZ, [
			"N...No dobrze."
		]),
		
		DialogueSequence.new(TUTORIAL_GUY_AVATAR, SENIOR_CONDUCTOR, [
			"Pamiętaj, młody… jak zobaczysz pasażera bez biletu, to nie krzycz. On się już wystarczająco zestresował, że zamiast do Krasnego jedzie do Kołobrzegu."
		]),
		
		DialogueSequence.new(CONDUCTOR_AVATAR, JANUSZ, [
			"Taa… znam to."
		]),
		
		DialogueSequence.new(TUTORIAL_GUY_AVATAR, SENIOR_CONDUCTOR, [
			"Dobra, słuchaj bo dwa razy powtarzał nie będę.",
			"Najpierw prosisz o bilet."
		], _on_sequence_4_complete),
		
		DialogueSequence.new(TUTORIAL_GUY_AVATAR, SENIOR_CONDUCTOR, [
			"Ta pani jakaś młoda jest, zapytaj o legitymację."
		], _on_sequence_5_complete),
		
		DialogueSequence.new(TUTORIAL_GUY_AVATAR, SENIOR_CONDUCTOR, [
			"Teraz szukaj w torbie dziurkacza i kasuj bilet."
		], _on_sequence_6_complete),
		
		DialogueSequence.new(TUTORIAL_GUY_AVATAR, SENIOR_CONDUCTOR, [
			"Ładnie młody, pasażerka w futrze puściła ci oczko, a ty tylko bilet skasowałeś."
		], _on_sequence_7_complete),
		
		DialogueSequence.new(TUTORIAL_GUY_AVATAR, SENIOR_CONDUCTOR, [
			"Teraz idź i skasuj tego ortaliona z jamnikiem, bilet w sensie."
		]),
		
		DialogueSequence.new(TUTORIAL_GUY_AVATAR, SENIOR_CONDUCTOR, [
			"Pamiętasz gdzie masz bloczek wezwań?",
			"Zawsze trzymaj obok podręcznika, to ci się w stresie nie pogubi."
		], _on_sequence_9_complete),
		
		DialogueSequence.new(DRES_AVATAR, DRES, [
			"Te konduktor!"
		]),
		
		DialogueSequence.new(CONDUCTOR_AVATAR, JANUSZ, [
			"Huh?"
		]),
		
		DialogueSequence.new(DRES_AVATAR, DRES, [
			"Masz rodzine?",
			"To zadzwoń i sie pożegnaj!"
		]),
		
		DialogueSequence.new(FRIEND_AVATAR, FRIEND, [
			"Janusz, ej Janusz!",
			"Nie śpij, trzeba kasować pasażerów!"
		], _on_sequence_13_complete),
		
		DialogueSequence.new(CONDUCTOR_AVATAR, JANUSZ, [
			"Nie śpię, nie śpię, już lecę..."
		]),
		
		DialogueSequence.new(CONDUCTOR_AVATAR, JANUSZ, [
			"Nie śpię, nie śpię, już lecę..."
		], _on_sequence_15_complete)
	]

func start_tutorial_dialogue():
	"""Start the tutorial dialogue system"""
	dialogue_started = true
	_disable_player_movement()
	arrow_indicator.visible = false
	visible = true
	_display_current_sequence()

func _display_current_sequence():
	"""Display the current dialogue sequence"""
	if current_sequence_index >= dialogue_sequences.size():
		_end_dialogue()
		return
	
	var sequence = dialogue_sequences[current_sequence_index]
	
	# Update UI elements
	avatar.texture = sequence.avatar
	name_label.text = sequence.speaker_name
	dialogue_box.text = sequence.text_lines[current_page]
	dialogue_box.visible_characters = 0
	
	# Start typing animation
	is_typing = true
	timer.start()

func _on_timer_timeout():
	"""Handle typing animation"""
	if not is_typing:
		return
		
	dialogue_box.visible_characters += 1
	
	if dialogue_box.visible_characters >= dialogue_box.get_total_character_count():
		is_typing = false
		arrow_indicator.visible = true
		anim.play("arrow")

func _input(_event: InputEvent):
	"""Handle input for dialogue progression"""
	if not dialogue_started or not Input.is_action_just_pressed("LMB"):
		return
	
	if is_typing:
		# Skip typing animation
		_complete_current_text()
	else:
		# Advance dialogue
		_advance_dialogue()

func _complete_current_text():
	"""Complete the current text display immediately"""
	is_typing = false
	dialogue_box.visible_characters = dialogue_box.get_total_character_count()
	arrow_indicator.visible = true
	anim.play("arrow")

func _advance_dialogue():
	"""Advance to the next dialogue line or sequence"""
	var current_sequence = dialogue_sequences[current_sequence_index]
	
	if current_page < current_sequence.text_lines.size() - 1:
		# More pages in current sequence
		current_page += 1
		_display_current_sequence()
	else:
		# Move to next sequence
		current_page = 0
		current_sequence_index += 1
		
		# Execute sequence completion callback
		if current_sequence.action_callback.is_valid():
			current_sequence.action_callback.call()
		
		_display_current_sequence()

func _end_dialogue():
	"""End the dialogue system"""
	visible = false
	dialogue_started = false
	current_page = 0
	current_sequence_index = 0
	_enable_player_movement()

func stop_dialogue():
	"""Stop dialogue and re-enable player movement if appropriate"""
	visible = false
	dialogue_started = false
	current_page = 0
	
	# Only enable player movement if no UI elements are open
	var laska_control = _get_node_safe(toolkit_layer, 'LaskaControl')
	var dres_control = _get_node_safe(toolkit_layer, 'DresControl')
	
	if laska_control and dres_control:
		if not laska_control.visible and not dres_control.visible:
			_enable_player_movement()

# Sequence completion callbacks
func _on_sequence_4_complete():
	stop_dialogue()
	var tutorial_guy = _get_node_safe(tutorial_level, 'tutorial_guy')
	if tutorial_guy:
		tutorial_guy.queue_free()

func _on_sequence_5_complete():
	stop_dialogue()

func _on_sequence_6_complete():
	stop_dialogue()

func _on_sequence_7_complete():
	stop_dialogue()

func _on_sequence_9_complete():
	stop_dialogue()
	var laska_control = _get_node_safe(toolkit_layer, 'LaskaControl')
	if laska_control:
		laska_control.close()
	
	var tut_guy = _get_node_safe(tutorial_level, 'WagonTutorial/TutGuy')
	var marker = _get_node_safe(tutorial_level, 'WagonTutorial/TutorialGuyMarker')
	if tut_guy and marker:
		tut_guy.position = marker.position

func _on_sequence_13_complete():
	stop_dialogue()
	await _play_death_sequence()
	start_tutorial_dialogue()

func _on_sequence_15_complete():
	stop_dialogue()
	if player:
		player.can_move = true
	get_parent().queue_free()

func _play_death_sequence():
	"""Play the death sequence with proper timing"""
	var death_screen = get_node_or_null("../DeathScreen")
	if death_screen:
		death_screen.visible = true
	
	if bam_sound:
		bam_sound.play()
		await get_tree().create_timer(0.75).timeout
		bam_sound.play()
	
	if tutorial_level:
		tutorial_level.queue_free()
	
	# Load new wagon controller
	var wagon_scene = load("res://Scenes/wagon_controller.tscn")
	if wagon_scene and game_controller:
		var wagon_cont = wagon_scene.instantiate()
		var levels_node = game_controller.get_node_or_null('Levels')
		if levels_node:
			levels_node.add_child(wagon_cont)
	
	await get_tree().create_timer(3).timeout

# Utility functions
func _get_node_safe(parent: Node, path: String) -> Node:
	"""Safely get a node without throwing errors"""
	if not parent:
		return null
	return parent.get_node_or_null(path)

func _disable_player_movement():
	"""Disable player movement safely"""
	if game_controller and game_controller.has_method("disable_player_movement"):
		game_controller.disable_player_movement()
	elif player and player.has_method("set") and "can_move" in player:
		player.can_move = false

func _enable_player_movement():
	"""Enable player movement safely"""
	if game_controller and game_controller.has_method("enable_player_movement"):
		game_controller.enable_player_movement()
	elif player and player.has_method("set") and "can_move" in player:
		player.can_move = true

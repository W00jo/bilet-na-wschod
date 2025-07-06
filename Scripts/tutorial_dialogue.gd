extends Control

@onready var dialogue_box:RichTextLabel = $Test/DialogueBox
@onready var anim = $AnimationPlayer



var dialogue = {
	"seq_1":  [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["Pierwszy dialog starszego konduktorka!",
		"Testowa sekwencja lalala",
		"Fifarafa robimy sobie szkolenie",
		"Jedzieeemy panowie!"]
	],
	
	"seq_2":  [
		load("res://Assets/Sprites/TutorialAvatars/conductor_tutorial.png"),
		
		"Nowy",
		
		["Teraz mówi nasz konduktor",
		"Ale fajne szkolenie fiu fiuu"]
	],
	
	"seq_3":  [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["Znowu na linii pan Sienkiewicz, halo halo",
		"Ciąg dalszy szkolenia, kasować ich!",
		"Zaczynamy od kobiet i dzieci"]
	],
	
	"seq_4":  [
		load("res://Assets/Sprites/TutorialAvatars/conductor_tutorial.png"),
		
		"Nowy",
		
		["Nasz konduktor here!",
		"Co ja mam z tymi wąsaczami ehh..."]
	],
	
	"seq_5":  [
		load("res://Assets/Sprites/TutorialAvatars/dres_tutorial.png"),
		
		"Dres",
		
		["YO z tej strony Rychu Peja",
		"Wiesz co się liczy?",
		"Szacunek konduktorów ulicy!"]
	],
	
	"seq_6":  [
		load("res://Assets/Sprites/TutorialAvatars/TutorialGuy/tutorial_guy_default.png"),
		
		"Starszy konduktor",
		
		["(starszy) O w morde! Ten to jakis nafurany!",
		"Dzwonie po policje"]
	],
	
	"seq_7":  [
		load("res://Assets/Sprites/TutorialAvatars/conductor_tutorial.png"),
		
		"Nowy",
		
		["O kurcze, pierwszy dzień w pracy a już takie rzeczy!",
		"Mam nadzieję że mnie nie pobije"]
	],
	
	"seq_8":  [
		load("res://Assets/Sprites/TutorialAvatars/friend_tutorial.png"),
		
		"Współkonduktor",
		
		[" (koleżka) Siema siema o tej porze-",
		"-każdy wypić może"]
	],
}

var sequence_num = 0
var page = 0
var current_sequence

var avatar_texture_id = 0
var name_id = 1
var text_array_id = 2

var batch_breakpoints = [2,4,7,8]
var dialogue_started = false

func start_tutorial_dialogue():
	$Test/ArrowIndicator.visible = false
	$Test.visible = true
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
				2:
					stop_dialogue()
				4:
					stop_dialogue()
				7:
					stop_dialogue()
				8:
					stop_dialogue()

func stop_dialogue():
	$Test.visible = false
	dialogue_started = false
	page = 0


func _on_button_1_pressed() -> void:
	dialogue_started = true
	start_tutorial_dialogue()


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

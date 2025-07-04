extends Control

@onready var dialogue_label:RichTextLabel = $DialogueText
@onready var anim = $AnimationPlayer

var tween: Tween

var greeting_dialogue = ["Czołem, konduktorze! Nowy na trasie, co?", 
						"Nie martw się, wszyscy kiedyś zaczynaliśmy.", 
						"Tu nie tylko bilety się sprawdza- tu się pilnuje porządku, dba o pasażerów...", 
						"...i czasem załatwia sprawy \"między wierszami\", rozumiesz?",
						"No, słuchaj się i będą z ciebie ludzie.",
						"Tylko nie kombinuj, bo tu się wszystko roznosi szybciej niż gazeta z kiosku!"]
var page = 0


#func start_tutorial_dialogue():
	#visible = true
	#$ArrowIndicator.visible = false
	#tween = create_tween()
	#tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	#setup_dialogue_label()
#
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

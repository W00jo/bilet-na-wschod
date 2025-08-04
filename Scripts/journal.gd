extends Control

@onready var page_sound = $AudioStreamPlayer

func _ready() -> void:
	if get_parent() == get_tree().root.get_node('Game/ToolkitLayer/Toolkit'):
		$CreditsPages.visible = false
		hide_all_journal_pages()
		$JournalPages/Cover.visible = true
	elif get_parent() == get_tree().root.get_node('Game/StartMenu'):
		$JournalPages.visible = false
		hide_all_credits_pages()
		$CreditsPages/Cover.visible = true


func hide_all_journal_pages():
	for page in $JournalPages.get_children():
		page.visible = false

func hide_all_credits_pages():
	for page in $CreditsPages.get_children():
		page.visible = false

##############################################

func _on_button_cover_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_1_2.visible = true
	page_sound.play()

func _on_button_page_1_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Cover.visible = true
	page_sound.play()

func _on_button_page_2_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_3_4.visible = true
	page_sound.play()

func _on_button_page_3_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_1_2.visible = true
	page_sound.play()

func _on_button_page_4_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_5_6.visible = true
	update_statistics()
	page_sound.play()

func _on_button_page_5_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_3_4.visible = true
	page_sound.play()

func _on_button_page_6_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_7_8.visible = true
	update_statistics()
	page_sound.play()

func _on_button_page_7_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_5_6.visible = true
	page_sound.play()

func _on_button_page_8_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Cover.visible = true
	page_sound.play()

func _on_stats_tab_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_7_8.visible = true
	update_statistics()
	page_sound.play()

func update_statistics():
	var toolkit = PassengerDataBus.game.get_node_or_null("ToolkitLayer/Toolkit")
	if toolkit:
		var tickets_count = toolkit.get_tickets_punched()
		$JournalPages/Pages_7_8/TicketsCount.text = "[center][b]" + str(tickets_count) + "[/b][/center]"
	else:
		$JournalPages/Pages_7_8/TicketsCount.text = "[center][b]0[/b][/center]"

###############################################

func _on_credits_cover_pressed() -> void:
	hide_all_credits_pages()
	$CreditsPages/Pages_1_2.visible = true
	page_sound.play()

func _on_credits_page_1_pressed() -> void:
	hide_all_credits_pages()
	$CreditsPages/Cover.visible = true
	page_sound.play()

func _on_credits_page_2_pressed() -> void:
	hide_all_credits_pages()
	$CreditsPages/Pages_3_4.visible = true
	page_sound.play()

func _on_credits_page_3_pressed() -> void:
	hide_all_credits_pages()
	$CreditsPages/Pages_1_2.visible = true
	page_sound.play()

###############################################

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Magnify"):
		queue_free()

func _on_credits_page_4_pressed() -> void:
	pass # Replace with function body.

extends Control

@onready var all_pages = $Pages
@onready var cover = $Pages/Cover
@onready var pages_1_2 = $Pages/Pages_1_2
@onready var pages_3_4 = $Pages/Pages_3_4


func _ready() -> void:
	hide_all_pages()
	$Pages/Cover.visible = true

func hide_all_pages():
	for page in $Pages.get_children():
		page.visible = false

func _on_button_cover_pressed() -> void:
	hide_all_pages()
	$Pages/Pages_1_2.visible = true

func _on_button_page_1_pressed() -> void:
	hide_all_pages()
	$Pages/Cover. visible = true

func _on_button_page_2_pressed() -> void:
	hide_all_pages()
	$Pages/Pages_3_4.visible = true

func _on_button_page_3_pressed() -> void:
	hide_all_pages()
	$Pages/Pages_1_2.visible = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Magnify"):
		queue_free()

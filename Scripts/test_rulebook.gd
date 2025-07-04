extends Sprite2D
class_name InteractiveBook2D

var pages = [
	["Cover"],
	["Strona tytułowa", "Dedykacja"],
	["Strona x lewa", "Strona y prawa"],
	["Strona z lewa", "Strona ? prawa"]
]

var current_page := 0
@onready var left_label = $LeftPageLabel
@onready var right_label = $RightPageLabel

func _ready():
	_update_page()

func _on_next_page_button_pressed() -> void:
	if current_page < pages.size() - 1:
		current_page += 1
		_update_page()

func _on_previous_page_button_pressed() -> void:
	if current_page > 0:
		current_page -= 1
		_update_page()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _update_page():
	if current_page == 0:
		texture = preload("res://Assets/Sprites/rulebook_closed.png")
		left_label.text = pages[0][0]
		left_label.show()
		right_label.hide()
	elif current_page == 1:
		texture = preload("res://Assets/Sprites/rulebook_open.png")
		left_label.text = pages[1][0]
		right_label.text = pages[1][1]
		left_label.show()
		right_label.show()
	else:
		texture = preload("res://Assets/Sprites/rulebook_blank.png")
		left_label.text = pages[current_page][0]
		right_label.text = pages[current_page][1]
		left_label.show()
		right_label.show()

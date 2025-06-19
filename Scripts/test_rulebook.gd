extends Sprite2D
class_name InteractiveBook2D

func _on_next_page_button_pressed() -> void:
	print("next page")


func _on_previous_page_button_pressed() -> void:
	print("previous page")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

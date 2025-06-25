extends Node2D

signal player_entered

func _on_y_sort_child_entered_tree(node: Node) -> void:
	if node.is_in_group("Player"):
		player_entered.emit(node)



func _on_right_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().change_wagons(body, "right")

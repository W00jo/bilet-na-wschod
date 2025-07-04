@tool
extends EditorPlugin

var add_button = Button.new()
var remove_button = Button.new()

func _enter_tree():
	add_button.text = "Add Areas"
	add_button.connect("pressed", self._on_add_button_pressed)
	add_control_to_container(CONTAINER_TOOLBAR, add_button)
	remove_button.text = "Remove children"
	remove_button.connect("pressed", self._on_remove_button_pressed)
	add_control_to_container(CONTAINER_TOOLBAR, remove_button)

func _exit_tree():
	remove_control_from_container(CONTAINER_TOOLBAR, add_button)
	add_button.queue_free()
	remove_control_from_container(CONTAINER_TOOLBAR, remove_button)
	remove_button.queue_free()

func _on_add_button_pressed():
	var selection = get_editor_interface().get_selection().get_selected_nodes()
	for node in selection:
		var new_area = Area2D.new()
		node.add_child(new_area)
		new_area.owner = get_editor_interface().get_edited_scene_root()
		var new_collision = CollisionShape2D.new()
		new_area.add_child(new_collision)
		new_collision.shape = RectangleShape2D.new()
		#new_collision.scale = Vector2(3, 3)
		new_collision.owner = get_editor_interface().get_edited_scene_root()
		print("Added Area2D to ", node.name)
		print(node.get_children())

func _on_remove_button_pressed():
	var selection = get_editor_interface().get_selection().get_selected_nodes()
	for node in selection:
		if node is Marker2D:
			for child in node.get_children():
				child.queue_free()

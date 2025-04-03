extends Node2D

@onready var anim = $"../AnimationPlayer"

var min_wagons = 2
var max_wagons = 5
var wagon_scenes = ["res://Scenes/wagon_1.tscn"]
var player_scene = load("res://Scenes/player.tscn")

var wagon_count = randi_range(min_wagons, max_wagons)
var all_wagons = []


func _ready() -> void:
	spawn_wagons()
	print(wagon_count)

func spawn_wagons():
	for i in wagon_count:
		var wagon = load(wagon_scenes.pick_random()).instantiate()
		add_child(wagon)
		wagon.visible = false
		wagon.set("process_mode", 4)
		all_wagons.append(wagon)
	put_player_in_first_wagon()

func put_player_in_first_wagon():
	var first_wagon = all_wagons[0]
	first_wagon.visible = true
	first_wagon.set("process_mode", 0)
	var player_instance = player_scene.instantiate()
	first_wagon.get_node('YSort').add_child(player_instance)
	player_instance.position = first_wagon.get_node('LeftEntranceMarker').position

func change_wagons(player, side):
	var current_wagon = player.get_parent().get_parent()
	var j = all_wagons.find(current_wagon)
	var entrance_marker
	var camera_marker
	if side == "left":
		if current_wagon != all_wagons[0]:
			var previous_wagon = all_wagons[j-1]
			entrance_marker = "RightEntranceMarker"
			camera_marker = "RightCameraMarker"
			anim.play("leave_wagon")
			await anim.animation_finished
			player.queue_free()
			move_player_to_wagon(entrance_marker, camera_marker, current_wagon, previous_wagon)
	elif side == "right":
		if current_wagon != all_wagons[wagon_count-1]:
			var next_wagon = all_wagons[j+1]
			entrance_marker = "LeftEntranceMarker"
			camera_marker = "LeftCameraMarker"
			anim.play("leave_wagon")
			await anim.animation_finished
			player.queue_free()
			move_player_to_wagon(entrance_marker, camera_marker, current_wagon, next_wagon)


func move_player_to_wagon(entrance_marker, camera_marker, old_wagon, new_wagon):
	old_wagon.visible = false
	old_wagon.get_node('CameraOnRail/PathFollow2D/Camera2D').enabled = false
	old_wagon.set("process_mode", 4)
	
	var player_instance = player_scene.instantiate()
	new_wagon.get_node('YSort').add_child(player_instance)
	player_instance.position = new_wagon.get_node(entrance_marker).position
	
	new_wagon.visible = true
	new_wagon.set("process_mode", 1)
	
	var all_cameras = get_tree().get_nodes_in_group("Camera")
	for camera in all_cameras:
		camera.enabled = false
	
	var cam_pathfollow = new_wagon.get_node('CameraOnRail/PathFollow2D')
	cam_pathfollow.position.x = new_wagon.get_node(camera_marker).position.x
	cam_pathfollow.get_node('Camera2D').enabled = true
	
	anim.play("enter_wagon")
	

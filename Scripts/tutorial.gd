extends Node2D

@onready var anim = $"../../AnimationPlayer"
@onready var intro_anim = $"../../DialogueLayer/AnimationPlayer"
const DialogueScene = preload("res://Scenes/tutorial_dialogue.tscn")

var min_wagons = 3
var max_wagons = 3
#var wagon_scenes = ["res://Scenes/wagon_tutorial.tscn"]
var wagon_scenes = ["res://Scenes/wagon_tutorial.tscn"]
var player_scene = load("res://Scenes/player.tscn")

var wagon_count = randi_range(min_wagons, max_wagons)
var all_wagons = []

var tutorial_guy

func _ready() -> void:
	spawn_wagons()

func on_started():
	start_indroduction_animations()

func start_indroduction_animations():
	get_tree().paused = false
	intro_anim.play("5_lat_temu")
	await intro_anim.animation_finished
	intro_anim.play("pierwszy")
	await intro_anim.animation_finished
	$"../../DialogueLayer/DarkScreen".queue_free()
	start_dialogue()

func start_dialogue():
	var panel = DialogueScene.instantiate()
	add_child(panel)
	panel.start_tutorial_dialogue()
#func start_dialogue():
	#$"../../DialogueLayer/TutorialDialogue".dialogue_started = true
	#$"../../DialogueLayer/TutorialDialogue".start_tutorial_dialogue()

func spawn_wagons():
	# first wagon
	var first_wagon = load("res://Scenes/wagon_first.tscn").instantiate()
	all_wagons.append(first_wagon)
	add_child(first_wagon)
	
	# middle wagons
	for i in wagon_count-2: # 2 for the two mandatory wagons(first and last w.), this loop is only for middle wagons
		var wagon = load(wagon_scenes.pick_random()).instantiate()
		add_child(wagon)
		wagon.visible = false
		wagon.set("process_mode", 4)
		all_wagons.append(wagon)
	
	# last wagon
	var last_wagon = load("res://Scenes/wagon_last.tscn").instantiate()
	all_wagons.append(last_wagon)
	add_child(last_wagon)
	last_wagon.visible = false
	last_wagon.set("process_mode", 4)
	
	put_player_in_first_wagon()

func put_player_in_first_wagon():
	print(all_wagons)
	var first_wagon = all_wagons[0]
	first_wagon.visible = true
	first_wagon.set("process_mode", 0)
	var player_instance = player_scene.instantiate()
	first_wagon.get_node('YSort').add_child(player_instance)
	player_instance.position = first_wagon.get_node('LeftEntranceMarker').position
	var tut_guy = Sprite2D.new()
	tut_guy.texture = load("res://Assets/Sprites/tutorial_conductor.png")
	first_wagon.get_node('YSort').add_child(tut_guy)
	tut_guy.position = player_instance.position + Vector2(200, -20)
	tut_guy.scale = Vector2(3.75, 3.75)
	tutorial_guy = tut_guy

func change_wagons(player, side):
	var current_wagon = player.get_parent().get_parent()
	var j = all_wagons.find(current_wagon)
	print(j)
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
	#if new_wagon != all_wagons[0]:
	cam_pathfollow.get_node('Camera2D').enabled = true
	
	anim.play("enter_wagon")
	

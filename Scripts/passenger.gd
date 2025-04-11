extends Node2D
class_name Passenger

@onready var sprites:Node2D = $Sprites

var is_skasowaned = false

var gender = ["m","f"].pick_random()

var body_tex:Texture
var hair_tex:Texture
var shirt_tex:Texture
var pants_tex:Texture
var shoes_tex:Texture

var component_file_name:String

var avatar_textures = []
var avatar_colors = []

var body_colors = [Color.BISQUE, Color.BURLYWOOD, Color.PERU, Color.NAVAJO_WHITE, Color.TAN]
var hair_colors = [Color.GOLDENROD, Color.BROWN, Color.CHOCOLATE, Color.SIENNA, Color.SANDY_BROWN, Color.CORAL]
var shirt_colors = [Color.DARK_ORANGE, Color.MEDIUM_AQUAMARINE, Color.DARK_OLIVE_GREEN, Color.CRIMSON, Color.DIM_GRAY]
var pants_colors = [Color.WEB_PURPLE, Color.WEB_GRAY, Color.WEB_GREEN, Color.STEEL_BLUE]
var shoes_colors = [Color.NAVY_BLUE, Color.SADDLE_BROWN, Color.WEB_MAROON, Color.DIM_GRAY]

var eye_color = ["green", "blue"].pick_random()

var interaction_enabled:bool = false



func _ready() -> void:
	texture_assigner()

func texture_assigner():
	#var component_dir:String = "res://Assets/Sprites/PassengerComponents/"
	#var gender_dir:String
	#match gender:
		#"f": 
			#gender_dir = "Female/"
		#"m": 
			#gender_dir = "Male/"
	body_tex = $Textures.get_resource(get_random_body_part(gender,"body")) ##onready
	hair_tex = $Textures.get_resource(get_random_body_part(gender,"hair"))
	shirt_tex = $Textures.get_resource(get_random_body_part(gender,"shirt"))
	pants_tex = $Textures.get_resource(get_random_body_part(gender,"pants"))
	shoes_tex = $Textures.get_resource(get_random_body_part(gender,"shoes"))
	
	passenger_dress_up()

func passenger_dress_up():
	var body = Sprite2D.new()
	texture_setter(body, body_tex)
	color_setter(body, body_colors)
	sprites.add_child(body)
	avatar_colors.append(body.modulate)
	
	var hair = Sprite2D.new()
	texture_setter(hair, hair_tex)
	color_setter(hair, hair_colors)
	sprites.add_child(hair)
	avatar_colors.append(hair.modulate)
	
	var shirt = Sprite2D.new()
	texture_setter(shirt, shirt_tex)
	color_setter(shirt, shirt_colors)
	sprites.add_child(shirt)
	avatar_colors.append(shirt.modulate)
	
	var pants = Sprite2D.new()
	texture_setter(pants, pants_tex)
	color_setter(pants, pants_colors)
	sprites.add_child(pants)
	
	var shoes = Sprite2D.new()
	texture_setter(shoes, shoes_tex)
	color_setter(shoes, shoes_colors)
	sprites.add_child(shoes)
	

#func texture_getter(component_dir_path, component_name):
	##var dir = Array(DirAccess.get_files_at(component_dir_path))
	#var dir = $Textures.get_resource_list()
	#for file in dir:
		#if file.get_extension() == "import":
			#dir.erase(file)
	#component_file_name = str(dir.pick_random())
	#avatar_path_data_collector(gender, component_name, component_file_name)
	#var texture = component_dir_path + component_file_name
	#print(dir)
	#return texture

func get_random_body_part(gender, body_part:String):
	var body_part_textures = $Textures.get_resource_list()
	var body_part_textures_to_rand = []
	for bp_tex in body_part_textures:
		if bp_tex.begins_with(gender + "_" + body_part):
			body_part_textures_to_rand.append(bp_tex)
	var texture = body_part_textures_to_rand.pick_random()
	avatar_texture_collector(gender,body_part,texture)
	return texture


func texture_setter(component, comp_tex):
	component.set_texture(comp_tex)

func color_setter(component, comp_color_arr):
	var rand_color = comp_color_arr.pick_random()
	component.set_modulate(rand_color)

func avatar_texture_collector(gender, body_part, file_name):
	if body_part == "body" or body_part == "hair" or body_part == "shirt":
		avatar_textures.append(file_name)
		

## INTERACTIONS ##

func update_interaction_position(pos:Vector2):
	$InteractionArea.global_position = pos


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		interaction_enabled = true
		
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		interaction_enabled = false

func display_interaction_label():
	if interaction_enabled:
		$InteractLabel.visible = true
		
func hide_interaction_label():
	$InteractLabel.visible = false
	
func _input(event: InputEvent) -> void:
	if interaction_enabled and $InteractLabel.visible and Input.is_action_just_pressed("Interact"):
		PassengerDataBus.transfer_passenger_data(avatar_textures, avatar_colors, eye_color)
		PassengerDataBus.game.start_ticket_control()
		PassengerDataBus.currently_checked_passenger = self

extends Node2D
class_name Passenger

@onready var sprites:Node2D = $Sprites
@onready var textures = $Textures
@onready var doc_manager = $DocumentManager

var is_skasowaned = false

var gender = ["m","f"].pick_random()
var age = randi_range(12, 95)
var age_range:String
#  15-24  25-39  40-64  65-79  80-95
#  młodziez  młodsi-dorośli  starsi-dorośli  seniorzy  starcy
var ticket_type:String
var document:PackedScene
var first_name
var last_name
var full_name
var album_number = randi_range(21370, 99769)
var adress
var height = ["niski", "średni", "wysoki"].pick_random()
var pesel

var body_tex:Texture
var hair_tex:Texture
var shirt_tex:Texture
var pants_tex:Texture
var shoes_tex:Texture


var avatar_textures = []
var avatar_colors = []

var body_colors = [Color.BISQUE, Color.BURLYWOOD, Color.NAVAJO_WHITE, Color.TAN]
var hair_colors = [Color.GOLDENROD, Color.BROWN, Color.CHOCOLATE, Color.SIENNA, Color.SANDY_BROWN, Color.CORAL]
var shirt_colors = [Color.DARK_ORANGE, Color.MEDIUM_AQUAMARINE, Color.DARK_OLIVE_GREEN, Color.CRIMSON, Color.DIM_GRAY]
var pants_colors = [Color.WEB_PURPLE, Color.WEB_GRAY, Color.WEB_GREEN, Color.STEEL_BLUE]
var shoes_colors = [Color.NAVY_BLUE, Color.SADDLE_BROWN, Color.WEB_MAROON, Color.DIM_GRAY]

var eye_color = ["green", "blue", "brown"].pick_random()


var interaction_enabled:bool = false


func _ready() -> void:
	age_range_assigner()
	personal_data_assigner()

func age_range_assigner():
	if age>=12 and age<=24:
		age_range = "youth"
	if age>=25 and age<=39:
		age_range = "young_adult"
	if age>=40 and age<=64:
		age_range = "middle_age"
	if age>=65 and age<=79:
		age_range = "senior"
	if age>=80 and age<=95:
		age_range = "elderly"
		
	texture_assigner()
	doc_manager.assign_ticket(age, age_range)

func personal_data_assigner():
	match gender:
		"m":
			first_name = $PersonalDataManager.male_names.pick_random()
			last_name = $PersonalDataManager.male_surnames.pick_random()
		"f":
			first_name = $PersonalDataManager.female_names.pick_random()
			last_name = $PersonalDataManager.female_surnames.pick_random()
	full_name = first_name + " " + last_name
	adress = $PersonalDataManager.adresses.pick_random()
	
	

func texture_assigner():
	body_tex = textures.get_resource(get_random_body_part(gender,"body"))
	hair_tex = textures.get_resource(get_random_body_part(gender,"hair"))
	shirt_tex = textures.get_resource(get_random_body_part(gender,"shirt"))
	pants_tex = textures.get_resource(get_random_body_part(gender,"pants"))
	shoes_tex = textures.get_resource(get_random_body_part(gender,"shoes"))
	
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
	

func get_random_body_part(gender, body_part:String):
	var body_part_textures = textures.get_resource_list()
	var body_part_textures_to_rand = []
	for bp_tex in body_part_textures:
		if bp_tex.begins_with(gender + "_" + age_range + "_" + body_part):
			body_part_textures_to_rand.append(bp_tex)
	var texture = body_part_textures_to_rand.pick_random()
	avatar_texture_collector(gender,body_part,texture)
	return texture


func texture_setter(component, comp_tex):
	component.set_texture(comp_tex)

func color_setter(component, comp_color_arr):
	if comp_color_arr == hair_colors and (age_range == "senior" or age_range == "elderly"):
		component.set_modulate(Color.GRAY)
	else:
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
	if interaction_enabled and is_skasowaned == false:
		$InteractLabel.visible = true
		
func hide_interaction_label():
	$InteractLabel.visible = false
	
func _input(event: InputEvent) -> void:
	if interaction_enabled and $InteractLabel.visible and Input.is_action_just_pressed("Interact") and is_skasowaned == false:
		PassengerDataBus.currently_checked_passenger = self
		PassengerDataBus.transfer_passenger_data(avatar_textures, avatar_colors, eye_color)
		PassengerDataBus.game.start_ticket_control()
		

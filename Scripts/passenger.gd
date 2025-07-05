extends Node2D
class_name Passenger

@onready var sprites:SubViewport = $TexContainer/Sprites
@onready var textures = $Textures
@onready var doc_manager = $DocumentManager

var is_skasowaned = false
var is_fined = false

var gender = ["m","f"].pick_random()
var age = randi_range(12, 95)
#var age = randi_range(19, 20)
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
var birth_date
var years_of_study
var pesel

var personality
var is_problematic = false
var has_ticket = true
var has_document = true
var is_document_valid = true

var body_tex:Texture
var hair_tex:Texture
var shirt_tex:Texture
var pants_tex:Texture
var shoes_tex:Texture
var eyes_tex:Texture

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
		personality = ["polite", "overly_polite"].pick_random()
	if age>=25 and age<=39:
		age_range = "young_adult"
		personality = ["polite", "overly_polite", "fraidy"].pick_random()
	if age>=40 and age<=54:
		age_range = "middle_age"
		personality = ["polite", "fraidy", "rude"].pick_random()
	if age>=55 and age<=74:
		age_range = "senior"
		personality = ["rude", "fraidy"].pick_random()
	if age>=75 and age<=95:
		age_range = "elderly"
		personality = ["overly_polite", "polite"].pick_random()
		
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
	eyes_tex = textures.get_resource(get_random_body_part(gender,"eyes"))
	
	passenger_dress_up()


func passenger_dress_up():
	var body = TextureRect.new()
	texture_setter(body, body_tex)
	color_setter(body, body_colors)
	sprites.add_child(body)
	avatar_colors.append(body.modulate)
	
	var hair = TextureRect.new()
	texture_setter(hair, hair_tex)
	color_setter(hair, hair_colors)
	sprites.add_child(hair)
	avatar_colors.append(hair.modulate)
	
	var shirt = TextureRect.new()
	texture_setter(shirt, shirt_tex)
	color_setter(shirt, shirt_colors)
	sprites.add_child(shirt)
	avatar_colors.append(shirt.modulate)
	
	var shoes = TextureRect.new()
	texture_setter(shoes, shoes_tex)
	color_setter(shoes, shoes_colors)
	sprites.add_child(shoes)
	
	var pants = TextureRect.new()
	texture_setter(pants, pants_tex)
	color_setter(pants, pants_colors)
	sprites.add_child(pants)
	
	outline_creator()

func outline_creator():
	$TexContainer.set("material", ShaderMaterial.new())
	$TexContainer.material.set("shader", load("res://Shaders/hsv_outline.gdshader"))
	$TexContainer.material.set_shader_parameter("type", 1)
	$TexContainer.material.set_shader_parameter("thickness", 1)
	$TexContainer.material.set_shader_parameter("saturation", 1)
	
	

func get_random_body_part(gender, body_part:String):
	var body_part_textures = textures.get_resource_list()
	if body_part != "eyes":
		var body_part_textures_to_rand = []
		for bp_tex in body_part_textures:
			if bp_tex.begins_with(gender + "_" + age_range + "_" + body_part):
				body_part_textures_to_rand.append(bp_tex)
		var texture = body_part_textures_to_rand.pick_random()
		avatar_texture_collector(gender,body_part,texture)
		return texture
	else:
		for bp_tex in body_part_textures:
			if bp_tex.ends_with(age_range + "_" + body_part + "_" + eye_color):
				var texture = bp_tex
				avatar_texture_collector(gender, body_part, texture)
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
	if body_part == "body" or body_part == "hair" or body_part == "shirt" or body_part == "eyes":
		avatar_textures.append(file_name)

func interactive_look_remover():
	$TexContainer.material.set_shader_parameter("type", 0)
	$TexContainer.material.set_shader_parameter("saturation", 0.3)


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
	if interaction_enabled and is_skasowaned == false and is_fined == false:
		$InteractLabel.visible = true
		
func hide_interaction_label():
	$InteractLabel.visible = false
	
func _input(event: InputEvent) -> void:
	if interaction_enabled and $InteractLabel.visible and Input.is_action_just_pressed("Interact") and is_skasowaned == false and is_fined == false:
		PassengerDataBus.currently_checked_passenger = self
		interaction_enabled = false
		PassengerDataBus.transfer_passenger_data(avatar_textures, avatar_colors, eye_color)
		PassengerDataBus.game.start_ticket_control()
		

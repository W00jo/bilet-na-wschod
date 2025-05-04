extends Control

var texture_preloader

var body_tex
var hair_tex
var shirt_tex
var eye_tex

var skin_color:Color
var hair_color:Color
var shirt_color:Color
var eye_color:String

func _ready() -> void:
	PassengerDataBus.passenger_avatar = self

func get_texture(texture_array):
	for child in get_children():
		remove_child(child)
	texture_preloader = load("res://Scenes/avatar_textures_preloader.tscn").instantiate()
	add_child(texture_preloader)
	body_tex = texture_preloader.get_resource(texture_array[0])
	hair_tex = texture_preloader.get_resource(texture_array[1])
	shirt_tex = texture_preloader.get_resource(texture_array[2])

func get_color_scheme(colors, eyes):
	skin_color = colors[0]
	hair_color = colors[1]
	shirt_color = colors[2]
	eye_color = eyes
	draw_avatar()


func draw_avatar():
	var body = TextureRect.new()
	body.set_texture(body_tex)
	body.set_modulate(skin_color)
	add_child(body)
	body.set_scale(Vector2(0.7,0.7))

	var eyes = TextureRect.new()
	eyes.set_texture(eyes_getter())
	add_child(eyes)
	eyes.set_scale(Vector2(0.7,0.7))
	
	var hair = TextureRect.new()
	hair.set_texture(hair_tex)
	hair.set_modulate(hair_color)
	add_child(hair)
	hair.set_scale(Vector2(0.7,0.7))

	var shirt = TextureRect.new()
	shirt.set_texture(shirt_tex)
	shirt.set_modulate(shirt_color)
	add_child(shirt)
	shirt.set_scale(Vector2(0.7,0.7))
	
func eyes_getter():
	eye_tex
	match eye_color:
		"green":
			eye_tex= texture_preloader.get_resource("eyes_green")
		"blue":
			eye_tex= texture_preloader.get_resource("eyes_blue")
	return eye_tex

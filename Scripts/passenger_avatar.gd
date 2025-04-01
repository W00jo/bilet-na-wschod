extends Control

var skin_color:Color
var hair_color:Color
var shirt_color:Color

var files = []

var avatar_component_dir_path = "res://Assets/Sprites/PassengerComponents/UIAvatars/"

var eye_color:String

func _ready() -> void:
	PassengerDataBus.passenger_avatar = self

func get_path_data(gender, file_name_array):
	files.clear()
	var gender_dir_path:String
	var gender_dir:String
	match gender:
		"f":
			gender_dir = "Female/"
		"m":
			gender_dir = "Male/"
	
	gender_dir_path = avatar_component_dir_path + gender_dir
	for file_name in file_name_array:
		var file_path = gender_dir_path + file_name
		files.append(file_path)


func get_color_scheme(colors, eye):
	skin_color = colors[0]
	hair_color = colors[1]
	shirt_color = colors[2]
	eye_color = eye
	draw_avatar()


func draw_avatar():
	for c in get_children():
		c.queue_free()
	var body = TextureRect.new()
	body.set_texture(load(files[0]))
	body.set_modulate(skin_color)
	add_child(body)
	body.set_scale(Vector2(0.7,0.7))
	
	var eyes = TextureRect.new()
	eyes.set_texture(load(eyes_getter()))
	add_child(eyes)
	eyes.set_scale(Vector2(0.7,0.7))
	
	var hair = TextureRect.new()
	hair.set_texture(load(files[1]))
	hair.set_modulate(hair_color)
	add_child(hair)
	hair.set_scale(Vector2(0.7,0.7))

	var shirt = TextureRect.new()
	shirt.set_texture(load(files[2]))
	shirt.set_modulate(shirt_color)
	add_child(shirt)
	shirt.set_scale(Vector2(0.7,0.7))
	
func eyes_getter():
	var eyes_path = avatar_component_dir_path + "Eyes/"
	var eyes_file_name:String
	match eye_color:
		"green":
			eyes_file_name = "eyes_green.png"
		"blue":
			eyes_file_name = "eyes_blue.png"
			
	var texture = eyes_path + eyes_file_name
	return texture

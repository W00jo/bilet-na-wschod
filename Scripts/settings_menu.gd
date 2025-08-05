extends Control

signal settings_closed

@onready var music_slider: HSlider = $Panel/VBoxContainer/MusicContainer/MusicSlider
@onready var sfx_slider: HSlider = $Panel/VBoxContainer/SFXContainer/SFXSlider
@onready var music_label: Label = $Panel/VBoxContainer/MusicContainer/MusicLabel
@onready var sfx_label: Label = $Panel/VBoxContainer/SFXContainer/SFXLabel
@onready var back_button: Button = $Panel/VBoxContainer/BackButton

func _ready():
	setup_sliders()
	load_settings()
	connect_signals()
	update_volume_labels()

func _input(event):
	# ESC key to close settings
	if event.is_action_pressed("ui_cancel"):
		close_settings()

func setup_sliders():
	music_slider.min_value = 0
	music_slider.max_value = 100
	music_slider.step = 1
	sfx_slider.min_value = 0
	sfx_slider.max_value = 100
	sfx_slider.step = 1

func connect_signals():
	music_slider.value_changed.connect(_on_music_slider_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)
	back_button.pressed.connect(_on_back_button_pressed)

func _on_music_slider_changed(value: float):
	var volume_db = linear_to_db(value / 100.0)
	# Check if Music bus exists, if not use Master
	var bus_index = AudioServer.get_bus_index("Music")
	if bus_index == -1:
		bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, volume_db)
	update_volume_labels()
	save_settings()

func _on_sfx_slider_changed(value: float):
	var volume_db = linear_to_db(value / 100.0)
	# Check if SFX bus exists, if not use Master
	var bus_index = AudioServer.get_bus_index("SFX")
	if bus_index == -1:
		bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, volume_db)
	update_volume_labels()
	save_settings()

func update_volume_labels():
	music_label.text = "Muzyka: %d%%" % music_slider.value
	sfx_label.text = "Efekty dźwiękowe: %d%%" % sfx_slider.value

func save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "music_volume", music_slider.value)
	config.set_value("audio", "sfx_volume", sfx_slider.value)
	config.save("user://settings.cfg")

func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err == OK:
		music_slider.value = config.get_value("audio", "music_volume", 70)
		sfx_slider.value = config.get_value("audio", "sfx_volume", 70)
	else:
		# Default values
		music_slider.value = 70
		sfx_slider.value = 70

func _on_back_button_pressed():
	close_settings()

func close_settings():
	settings_closed.emit()
	queue_free()  # Remove the scene when closed

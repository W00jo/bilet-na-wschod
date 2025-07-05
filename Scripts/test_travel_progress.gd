extends Control

@onready var progress_bar = $TravelAnimation
@onready var info_label = $InfoLabel
@onready var start_button = $VBoxContainer/StartButton
@onready var reset_button = $VBoxContainer/ResetButton

var destinations = ["Sandomierz"]
var current_destination_index = 0

func _ready():
	print("=== SCENA TESTOWA POSTĘPU PODRÓŻY ===")
	
	_update_info_label()

func _process(_delta):
	_update_info_label()

func _on_start_pressed():
	print("Naciśnięto przycisk startu!")
	var destination = destinations[current_destination_index]
	current_destination_index = (current_destination_index + 1) % destinations.size()
	
	progress_bar.start_travel(destination)
	start_button.disabled = true
	
	# Ponowne włączenie przycisku po zakończeniu podróży
	await get_tree().create_timer(0.1).timeout
	while progress_bar.is_traveling:
		await get_tree().create_timer(0.1).timeout
	start_button.disabled = false
	print("Przycisk startu ponownie włączony")

func _on_reset_pressed():
	print("Naciśnięto przycisk resetu!")
	progress_bar.reset_progress()
	start_button.disabled = false

func _update_info_label():
	var progress_percent = progress_bar.get_progress_percent()
	var status = "Podróżuje" if progress_bar.is_traveling else "Zatrzymany"
	var time_remaining = progress_bar.travel_time - progress_bar.elapsed_time
	
	info_label.text = "Status: %s\nPostęp: %.1f%%\nCzas podróży: %.1fs\nPozostało: %.1fs\nCel: %s" % [
		status, progress_percent, progress_bar.travel_time, 
		max(0.0, time_remaining), progress_bar.destination
	]

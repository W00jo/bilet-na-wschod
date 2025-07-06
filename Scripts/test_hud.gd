@tool
extends Control

@onready var progress_bar = $TravelAnimation
@onready var info_label = $InfoLabel
@onready var start_button = $VBoxContainer/StartButton
@onready var reset_button = $VBoxContainer/ResetButton
@onready var time_label = $ClockContainer/TimeLabel
@onready var date_label = $CalendarContainer/DateLabel

# Stress bar components
@onready var stress_bar = $StressBar
@onready var stress_info_label = $StressInfoLabel
@onready var small_stress_button = $VBoxContainer/SmallStressButton
@onready var medium_stress_button = $VBoxContainer/MediumStressButton
@onready var large_stress_button = $VBoxContainer/LargeStressButton
@onready var reset_stress_button = $VBoxContainer/ResetStressButton

var destinations = ["Sandomierz"]
var current_destination_index = 0

# Zmienne systemu zegara
@export var start_time_hour: int = 9
@export var start_time_minute: int = 0
@export var end_time_hour: int = 17
@export var end_time_minute: int = 0
@export var time_scale: float = 60.0  # Jak szybko porusza się zegar (60.0 = 1 minuta na sekundę)
@export var update_travel_bar: bool = true  # Czy synchronizować pasek podróży z zegarem

@export_group("Pozycjonowanie UI")
# Pozycje paska stresu (lewy górny róg)
@export var stress_bar_position: Vector2 = Vector2(40, 20)
@export var stress_zero_icon_position: Vector2 = Vector2(10, 15)
@export var stress_icon_position: Vector2 = Vector2(164, 15)
@export var stress_info_position: Vector2 = Vector2(10, 45)

# Pozycje zegara i kalendarza (prawy górny róg)
@export var clock_margin_right: float = 20.0
@export var clock_margin_top: float = 10.0
@export var calendar_margin_top: float = 35.0

# Pozycja paska podróży (środek górnej części)
@export var travel_bar_offset_top: float = 80.0
@export var travel_bar_width: float = 474.0

# Pozycje przycisków sterowania
@export var controls_position: Vector2 = Vector2(290, 250)
@export var info_label_position: Vector2 = Vector2(200, 140)

@export_group("Rozmiary UI")
@export var stress_bar_size: Vector2 = Vector2(114, 6)
@export var icon_size: Vector2 = Vector2(20, 20)
@export var clock_container_width: float = 130.0
@export var info_label_size: Vector2 = Vector2(400, 40)

@export_group("Funkcje Edytora")
@export var apply_positions_in_editor: bool = false : set = _apply_positions_setter

func _apply_positions_setter(value: bool):
	if value and Engine.is_editor_hint():
		_apply_ui_positions()
		apply_positions_in_editor = false

var current_time_minutes: float = 0.0
var total_journey_minutes: float = 0.0
var is_clock_running: bool = false

# Zmienne systemu stresu
var max_stress := 100.0
var current_stress := 0.0

# Tekstury do animacji migania
var texture_normal: Texture2D  # stressbar.png (normalny kolor)
var texture_flash: Texture2D   # stressbar_over.png (migający kolor)

# System "migania"
var is_flashing := false
var flash_timer := 0.0
var flash_duration := 0.5  # Jak długo ma migać po dodaniu stresu
var flash_interval := 0.1  # Częstotliwość migania

func _ready():
	print("=== SCENA TESTOWA HUD ===")
	
	if Engine.is_editor_hint():
		# W edytorze, tylko zastosuj pozycje UI
		_apply_ui_positions()
		return
	
	print("Zegar konfigurowany od %02d:%02d do %02d:%02d" % [start_time_hour, start_time_minute, end_time_hour, end_time_minute])
	print("Prędkość zegara: %.1f minut/sekunda" % time_scale)
	
	_apply_ui_positions()
	_initialize_clock()
	_initialize_date()
	_initialize_stress_bar()
	_update_info_label()

func _apply_ui_positions():
	if not is_inside_tree():
		return
		
	print("Aplikowanie pozycji UI z Inspektora...")
	
	# Ustaw pozycje i rozmiary paska stresu
	var stress_bar_node = get_node_or_null("StressBar")
	if stress_bar_node:
		stress_bar_node.position = stress_bar_position
		stress_bar_node.size = stress_bar_size
	
	var stress_zero_icon_node = get_node_or_null("StressZeroIcon")
	if stress_zero_icon_node:
		stress_zero_icon_node.position = stress_zero_icon_position
		stress_zero_icon_node.size = icon_size
	
	var stress_icon_node = get_node_or_null("StressIcon")
	if stress_icon_node:
		stress_icon_node.position = stress_icon_position
		stress_icon_node.size = icon_size
	
	var stress_info_label_node = get_node_or_null("StressInfoLabel")
	if stress_info_label_node:
		stress_info_label_node.position = stress_info_position
		stress_info_label_node.size = info_label_size
	
	# Ustaw pozycje zegara i kalendarza (prawy górny róg)
	var clock_container_node = get_node_or_null("ClockContainer")
	if clock_container_node:
		clock_container_node.offset_left = -clock_container_width - clock_margin_right
		clock_container_node.offset_right = -clock_margin_right
		clock_container_node.offset_top = clock_margin_top
		clock_container_node.offset_bottom = clock_margin_top + 20.0
	
	var calendar_container_node = get_node_or_null("CalendarContainer")
	if calendar_container_node:
		calendar_container_node.offset_left = -clock_container_width - clock_margin_right
		calendar_container_node.offset_right = -clock_margin_right
		calendar_container_node.offset_top = calendar_margin_top
		calendar_container_node.offset_bottom = calendar_margin_top + 20.0
	
	# Ustaw pozycję paska podróży
	var progress_bar_node = get_node_or_null("TravelAnimation")
	if progress_bar_node:
		var half_width = travel_bar_width / 2.0
		progress_bar_node.offset_left = -half_width
		progress_bar_node.offset_right = half_width
		progress_bar_node.offset_top = travel_bar_offset_top
		progress_bar_node.offset_bottom = travel_bar_offset_top + 40.0
	
	# Ustaw pozycje przycisków sterowania
	var vbox_container_node = get_node_or_null("VBoxContainer")
	if vbox_container_node:
		vbox_container_node.position = controls_position
	
	# Ustaw pozycję etykiety informacyjnej
	var info_label_node = get_node_or_null("InfoLabel")
	if info_label_node:
		info_label_node.position = info_label_position
		info_label_node.size = info_label_size
	
	print("Pozycje UI zastosowane pomyślnie")

func _initialize_clock():
	# Konwertuj godziny początkowe i końcowe na minuty
	current_time_minutes = start_time_hour * 60 + start_time_minute
	var end_time_minutes = end_time_hour * 60 + end_time_minute
	total_journey_minutes = end_time_minutes - current_time_minutes
	
	# Zaktualizuj początkowy wyświetlacz
	_update_time_display()
	
	print("Zegar zainicjowany: %02d:%02d do %02d:%02d (%.1f minut)" % [
		start_time_hour, start_time_minute, end_time_hour, end_time_minute, total_journey_minutes
	])

func _initialize_date():
	if Engine.is_editor_hint():
		return
		
	# Ustaw dzisiejszą datę (6 lipca 2025)
	var current_date = Time.get_date_dict_from_system()
	var date_label_node = get_node_or_null("CalendarContainer/DateLabel")
	if date_label_node:
		date_label_node.text = "%02d.%02d.%d" % [current_date.day, current_date.month, current_date.year]
		print("Data ustawiona na: ", date_label_node.text)

func _initialize_stress_bar():
	print("Inicjalizacja paska stresu...")
	
	_load_stress_textures()
	_setup_stress_bar()
	
	# Początek bez stresu (pusty pasek)
	current_stress = 0.0
	_update_stress_visual()

func _load_stress_textures():
	# Załaduj tekstury dla paska stresu
	texture_normal = preload("res://Assets/Sprites/UIElements/stressbar.png")
	texture_flash = preload("res://Assets/Sprites/UIElements/stressbar_over.png")

func _setup_stress_bar():
	# Czekaj na załadowanie tekstur
	await get_tree().process_frame
	
	if stress_bar:
		# Ustawia pasek stresu
		stress_bar.min_value = 0.0
		stress_bar.max_value = 100.0
		stress_bar.value = 0.0  # Początek z pustym paskiem
		stress_bar.texture_progress = texture_normal
		
		print("Pasek stresu skonfigurowany - zakres: 0-100, wartość: ", stress_bar.value)

func _process(delta):
	if Engine.is_editor_hint():
		return
		
	_update_info_label()
	
	if is_clock_running:
		# Posuń zegar do przodu (time_scale = minut na sekundę)
		current_time_minutes += (delta * time_scale)
		
		# Zaktualizuj wyświetlacz czasu
		_update_time_display()
		
		# Oblicz postęp na podstawie czasu
		var time_progress = (current_time_minutes - (start_time_hour * 60 + start_time_minute)) / total_journey_minutes
		time_progress = clamp(time_progress, 0.0, 1.0)
		
		# Synchronizuj pasek postępu podróży z zegarem, jeśli włączono
		if update_travel_bar:
			progress_bar.set_progress_by_time(time_progress)
		
		# Sprawdź, czy osiągnęliśmy godzinę końcową
		if current_time_minutes >= end_time_hour * 60 + end_time_minute:
			is_clock_running = false
			start_button.disabled = false
			print("Podróż zakończona o godzinie końcowej!")
	
	# Animacja "migania" przy "dostawaniu" stresu
	if is_flashing:
		flash_timer += delta
		
		# Interwał animacji
		var flash_cycle = fmod(flash_timer, flash_interval * 2.0)
		if flash_cycle < flash_interval:
			stress_bar.texture_progress = texture_flash  # Migający kolor
		else:
			stress_bar.texture_progress = texture_normal  # Normalny kolor
		
		# Zatrzymaj miganie po flash_duration
		if flash_timer >= flash_duration:
			_stop_flashing()
	
	# Aktualizuj etykietę informacyjną stresu
	_update_stress_info_label()

func _update_time_display():
	var total_minutes = int(current_time_minutes)
	var hours = int(total_minutes / 60)  # Explicit integer division
	var minutes = total_minutes % 60
	if time_label:
		time_label.text = "%02d:%02d" % [hours, minutes]

func _update_info_label():
	var progress_percent = progress_bar.get_progress_percent()
	var status = "Podróżuje" if progress_bar.is_traveling else "Zatrzymany"
	var time_remaining = progress_bar.travel_time - progress_bar.elapsed_time
	var clock_status = "Działa" if is_clock_running else "Zatrzymany"
	
	info_label.text = "Status: %s\nPostęp: %.1f%%\nCzas podróży: %.1fs\nPozostało: %.1fs\nCel: %s\nZegar: %s" % [
		status, progress_percent, progress_bar.travel_time, 
		max(0.0, time_remaining), progress_bar.destination, clock_status
	]

func _on_start_pressed():
	print("Naciśnięto przycisk startu!")
	var destination = destinations[current_destination_index]
	current_destination_index = (current_destination_index + 1) % destinations.size()
	
	# Uruchom zarówno animację podróży, jak i zegar
	progress_bar.start_travel(destination)
	is_clock_running = true
	start_button.disabled = true
	
	print("Zegar uruchomiony, podróż się rozpoczyna!")

func _on_reset_pressed():
	print("Naciśnięto przycisk resetu!")
	progress_bar.reset_progress()
	
	# Zresetuj zegar
	current_time_minutes = start_time_hour * 60 + start_time_minute
	_update_time_display()
	is_clock_running = false
	start_button.disabled = false
	
	print("Zegar zresetowany do czasu początkowego")

# === FUNKCJE SYSTEMU STRESU ===

func _start_flashing():
	# Rozpoczyna miganie
	is_flashing = true
	flash_timer = 0.0
	print("Rozpoczęto miganie paska stresu")

func _stop_flashing():
	# Stopuje miganie
	is_flashing = false
	flash_timer = 0.0
	stress_bar.texture_progress = texture_normal
	print("Zatrzymano miganie paska stresu")

func add_stress(amount: float, reason: String = "Nieznany"):
	print("=== ZDARZENIE STRESOWE ===")
	print("Przyczyna: ", reason)
	print("Ilość stresu: ", amount)
	print("Aktualny stres przed: ", current_stress)
	
	current_stress += amount
	current_stress = min(max_stress, current_stress)
	
	print("Aktualny stres po: ", current_stress)
	print("Procent stresu: ", get_stress_percentage(), "%")
	
	# Rozpocznij miganie przy dodaniu stresu
	_start_flashing()
	
	_update_stress_visual()

func _update_stress_visual():
	# Nowy system: im więcej stresu, tym więcej wypełniony pasek
	var stress_percent = current_stress / max_stress
	
	print("Aktualizacja wizualna - Stres: %.1f%%" % [stress_percent * 100])
	
	# Ustaw wartość paska na procent stresu (0% = pusty, 100% = pełny)
	if stress_bar:
		stress_bar.value = stress_percent * 100.0

func get_stress_percentage() -> float:
	return (current_stress / max_stress) * 100.0

func is_stressed() -> bool:
	return current_stress > 0.0

func reset_stress():
	print("=== RESET STRESU ===")
	current_stress = 0.0
	_stop_flashing()  # Zatrzymaj miganie przy resecie
	_update_stress_visual()

# Obsługa przycisków stresu
func _on_small_stress_pressed():
	add_stress(15.0, "Mały stres")

func _on_medium_stress_pressed():
	add_stress(25.0, "Średni stres")

func _on_large_stress_pressed():
	add_stress(35.0, "Duży stres")

func _on_reset_stress_pressed():
	reset_stress()

# Aktualizuj wyświetlanie informacji o stresie
func _update_stress_info_label():
	var status = "Psycha nie siada"
	if current_stress > 0.0:
		status = "Psycha siada"
	
	stress_info_label.text = "Stres: %.1f%% | Status: %s" % [
		get_stress_percentage(), status
	]

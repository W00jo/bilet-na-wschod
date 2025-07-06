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

# Cel jazdy
var destinations = ["Sandomierz"]
var current_destination_index = 0

# Zmienne systemu zegara
@export var start_time_hour: int = 9
@export var start_time_minute: int = 0
@export var end_time_hour: int = 17
@export var end_time_minute: int = 0
@export var time_step_interval: float = 1.0  # Ile sekund realnych na jeden krok czasu (1s = jeden krok co sekundę)
@export var update_travel_bar: bool = true  # Czy synchronizować pasek podróży z zegarem

var current_time_minutes: float = 0.0
var total_journey_minutes: float = 0.0
var is_clock_running: bool = false

# Zegar tyka co 5 minut
var time_step_minutes: int = 5  # Krok czasu w minutach (5 = co 5 minut)
var step_timer: float = 0.0  # Timer dla kroków czasu

# Arbitralne zmienne systemu stresu
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
		return
	
	print("Zegar konfigurowany od %02d:%02d do %02d:%02d" % [start_time_hour, start_time_minute, end_time_hour, end_time_minute])
	print("Zegar będzie skakać co %d minut, co %.1f sekund realnych" % [time_step_minutes, time_step_interval])
	
	_initialize_clock()
	_initialize_date()
	_initialize_stress_bar()
	_update_info_label()

func _initialize_clock():
	# Konwertuj godziny początkowe i końcowe na minuty
	current_time_minutes = start_time_hour * 60 + start_time_minute
	var end_time_minutes = end_time_hour * 60 + end_time_minute
	total_journey_minutes = end_time_minutes - current_time_minutes
	
	step_timer = 0.0
	
	_update_time_display()
	
	print("Zegar będzie skakać co %d minut, co %.1f sekund realnych" % [time_step_minutes, time_step_interval])

func _initialize_date():
	if Engine.is_editor_hint():
		return
		
	# Ustawia dzisiejszą datę (6 lipca 2025) dla testu
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
	# Bez tego jakoś nie chce działać!
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

func _process(delta):
	if Engine.is_editor_hint():
		return
		
	_update_info_label()
	
	if is_clock_running:
		# Nowy system: skokowy zegar co 5 minut
		step_timer += delta
		
		# Sprawdź, czy minął czas na kolejny krok
		if step_timer >= time_step_interval:
			step_timer = 0.0  # Zresetuj timer
			
			# Dodaj krok czasu (5 minut)
			current_time_minutes += time_step_minutes
			
			# Zaktualizuj wyświetlacz czasu
			_update_time_display()
			
			# Oblicz postęp na podstawie czasu
			var time_progress = (current_time_minutes - (start_time_hour * 60 + start_time_minute)) / total_journey_minutes
			time_progress = clamp(time_progress, 0.0, 1.0)
			
			if update_travel_bar:
				progress_bar.set_progress_by_time(time_progress)
			
			print("Zegar: %02d:%02d (postęp: %.1f%%)" % [
				int(current_time_minutes) / 60.0, 
				int(current_time_minutes) % 60, 
				time_progress * 100.0
			])
		
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
	var hours = total_minutes / 60.0  # Float division to avoid integer division warning
	var minutes = total_minutes % 60
	if time_label:
		time_label.text = "%02d:%02d" % [int(hours), minutes]

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
	var destination = destinations[current_destination_index]
	current_destination_index = (current_destination_index + 1) % destinations.size()
	
	# Uruchom zarówno animację podróży, jak i zegar
	progress_bar.start_travel(destination)
	is_clock_running = true
	start_button.disabled = true
	
	print ("No to w drogę!")

func _on_reset_pressed():
	progress_bar.reset_progress()
	
	# Zresetuj zegar
	current_time_minutes = start_time_hour * 60 + start_time_minute
	step_timer = 0.0  # Zresetuj timer kroków
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
	var stress_percent = current_stress / max_stress
	
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

extends Control

@onready var track_rect: TextureRect = $Trasa
@onready var train_rect: TextureRect = $Train

var travel_time := 8.0  # Całkowity czas podróży w sekundach
var is_traveling := false
var destination := "Następna stacja"
var start_position: float = 5.0
var end_position: float = 0.0
var travel_start_time: float = 0.0
var elapsed_time: float = 0.0
var time_controlled := false  # Czy pociąg jest kontrolowany przez zewnętrzny system czasu

# Ustawienia pozycji pociągu na torze
var vertical_offset: float = -20.0  # Przesunięcie w pionie (dodatnie = w dół, ujemne = w górę)
var horizontal_margin: float = 0.0  # Margines od brzegów toru (zmniejsza zakres ruchu)
var scale_factor: float = 0.5  # Skala pociągu (0.5 = połowa oryginalnego rozmiaru dla lepszego dopasowania)

func _ready():
	# Tylko konfiguracja pozycji
	_setup_positions()

func _setup_positions():
	# Czekaj na załadowanie tekstur
	await get_tree().process_frame
	
	if track_rect.texture and train_rect.texture:
		# Ustaw rozmiar TrackRect na rozmiar tekstury toru
		track_rect.size = track_rect.texture.get_size()
		track_rect.position = Vector2(0, 0)
		
		# Ustaw rozmiar głównej kontrolki na rozmiar toru
		custom_minimum_size = track_rect.texture.get_size()
		size = track_rect.texture.get_size()
		
		# Zastosuj skalę do pociągu
		train_rect.scale = Vector2(scale_factor, scale_factor)
		
		# Oblicz zakres ruchu z uwzględnieniem marginesów
		start_position = horizontal_margin
		end_position = track_rect.texture.get_width() - train_rect.texture.get_width() * scale_factor - horizontal_margin
		
		# Umieść pociąg na początku
		train_rect.position.x = start_position
		train_rect.position.y = vertical_offset
		
		print("Start: ", start_position, " Koniec: ", end_position)

func _process(delta):
	# Posuń automatycznie tylko wtedy, gdy nie jest kontrolowany przez zewnętrzny system czasu
	if is_traveling and train_rect and not time_controlled:
		elapsed_time += delta
		
		# Oblicza postęp jako procent czasu podróży
		var time_progress = elapsed_time / travel_time
		time_progress = clamp(time_progress, 0.0, 1.0)
		
		# Użyj funkcji ease_out dla spowolnienia przy zbliżaniu się do stacji
		var eased_progress = ease_out(time_progress)
		
		# Oblicza nową pozycję na podstawie wygładzonego postępu
		var old_x = train_rect.position.x
		train_rect.position.x = start_position + (end_position - start_position) * eased_progress
		
		# Wyświetla aktualizacje postępu co 10% tylko dla informacji w terminalu
		var progress_percent = eased_progress * 100.0
		var old_progress_percent = (old_x - start_position) / (end_position - start_position) * 100.0
		if int(old_progress_percent / 10) != int(progress_percent / 10):
			print("Postęp podróży: ", int(progress_percent), "%")
		
		if time_progress >= 1.0:
			arrive_at_station()

# Funkcja wygładzania dla spowolnienia
func ease_out(t: float) -> float:
	return 1.0 - pow(1.0 - t, 3.0)

func start_travel(dest: String = "Następna stacja"):
	print("=== ROZPOCZĘCIE PODRÓŻY ===")
	print("Stacja docelowa:", dest)
	print("Czas podróży:", travel_time, "sekund")
	
	destination = dest
	is_traveling = true
	elapsed_time = 0.0
	time_controlled = true  # Włącz kontrolę czasu przez zewnętrzny system
	travel_start_time = Time.get_time_dict_from_system()["hour"] * 3600 + Time.get_time_dict_from_system()["minute"] * 60 + Time.get_time_dict_from_system()["second"]
	
	# Zresetuj pozycję pociągu
	if train_rect:
		train_rect.position.x = start_position
		train_rect.position.y = vertical_offset
	
func arrive_at_station():
	print("=== PRZYJAZD NA STACJĘ ===")
	print("Dotarliśmy do: ", destination)
	print("Pozycja końcowa: ", train_rect.position.x if train_rect else 0.0)
	print("Całkowity czas podróży: ", elapsed_time, " sekund")
	
	is_traveling = false
	
	# Opcjonalnie: Reset po opóźnieniu
	print("Reset za 2 sekundy...")
	await get_tree().create_timer(2.0).timeout
	reset_progress()

func reset_progress():
	print("=== RESET POSTĘPU ===")
	if train_rect:
		train_rect.position.x = start_position
		train_rect.position.y = vertical_offset
	is_traveling = false
	elapsed_time = 0.0
	time_controlled = false  # Wyłącz kontrolę czasu
	destination = "Gotowy do dalszej trasy!"
	print("Postęp zresetowany. Pozycja pociągu: ", train_rect.position.x if train_rect else 0.0)

func get_progress_percent() -> float:
	if not train_rect or end_position <= start_position:
		return 0.0
	return (train_rect.position.x - start_position) / (end_position - start_position) * 100.0

func set_progress_by_time(progress: float):
	"""Ustaw pozycję pociągu na podstawie postępu czasu (0.0 do 1.0)"""
	if not train_rect:
		return
	
	progress = clamp(progress, 0.0, 1.0)
	
	# Użyj funkcji ease_out dla płynnego spowolnienia
	var eased_progress = ease_out(progress)
	
	# Oblicz nową pozycję na podstawie wygładzonego postępu
	train_rect.position.x = start_position + (end_position - start_position) * eased_progress
	
	# Zaktualizuj czas, który upłynął, aby dopasować postęp
	elapsed_time = progress * travel_time
	
	# Sprawdź, czy podróż jest zakończona
	if progress >= 1.0:
		arrive_at_station()

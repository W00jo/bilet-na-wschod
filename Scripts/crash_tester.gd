extends Node
## System testowania crashy i symulacji błędów
## Używaj tych funkcji do testowania systemu logowania i obsługi crashy
## Ten skrypt dodaj do sceny ręcznie, nie jako autoload

class_name CrashTester

# Referencja do loggera - ustawi się gdy scena będzie gotowa
var logger = null

func _ready():
	# Poczekaj na następną klatkę żeby autoloady się zainicjalizowały
	await get_tree().process_frame
	logger = Logger if Logger else null
	
	if logger:
		logger.info("CrashTester gotowy i Logger dostępny", "CRASH_TESTER")
	else:
		print("Uwaga: CrashTester gotowy ale Logger niedostępny")

# Testuj różne typy logowania
func test_basic_logging():
	## Testuj wszystkie poziomy logów
	if not logger:
		print("Logger jeszcze niedostępny")
		return
		
	logger.debug("To jest wiadomość debug - widoczna tylko w buildach debug")
	logger.info("Stan gry: Wszystko działa normalnie")
	logger.warning("Wykryto drobny problem: Ostrzeżenie o małej pamięci")
	logger.error("Wystąpił problem: Nie udało się załadować tekstury")
	logger.critical("Krytyczny błąd: Nie można zapisać danych gry")

# Testuj specjalne funkcje logowania
func test_game_logging():
	## Testuj funkcje logowania specyficzne dla gry
	if not logger:
		print("Logger jeszcze niedostępny")
		return
		
	logger.log_passenger_interaction("Jan Kowalski", "kontrola_biletu", "ważny")
	logger.log_ticket_control("Anna Nowak", true, false)
	logger.log_stress_change(45.0, 60.0, "nieuprzejmy pasażer")
	logger.log_scene_transition("menu_glowne", "scena_gry")

# Symuluj różne scenariusze crashy
func test_crash_scenarios():
	## Testuj wykrywanie i logowanie crashy
	
	# Test 1: Crash null reference
	simulate_null_reference_crash()
	
	# Test 2: Wyjście poza tablicę
	simulate_array_crash()
	
	# Test 3: Dzielenie przez zero
	simulate_division_crash()

func simulate_null_reference_crash():
	## Symuluj błąd null reference
	if not logger:
		print("Logger jeszcze niedostępny")
		return
		
	logger.log_crash_data("Symulowany wyjątek null reference w teście", {
		"typ_testu": "null_reference",
		"funkcja": "simulate_null_reference_crash"
	})

func simulate_array_crash():
	## Symuluj błąd wyjścia poza granice tablicy
	if not logger:
		print("Logger jeszcze niedostępny")
		return
		
	logger.log_crash_data("Symulowane wyjście poza granice tablicy w teście", {
		"typ_testu": "array_bounds",
		"rozmiar_tablicy": 3,
		"proponowany_indeks": 10
	})

func simulate_division_crash():
	## Symuluj dzielenie przez zero
	if not logger:
		print("Logger jeszcze niedostępny")
		return
		
	logger.log_crash_data("Symulowane dzielenie przez zero w teście", {
		"typ_testu": "division_by_zero",
		"licznik": 10,
		"mianownik": 0
	})

# Testowanie wydajności
func test_performance_logging():
	## Testuj monitorowanie wydajności
	if not logger:
		print("Logger jeszcze niedostępny")
		return
		
	var start_time = Time.get_unix_time_from_system()
	
	# Symuluj wolną operację
	await get_tree().create_timer(0.1).timeout
	
	var end_time = Time.get_unix_time_from_system()
	var czas_wykonania = end_time - start_time
	
	logger.log_performance_warning("test_wolnej_funkcji", czas_wykonania)

# Testowanie systemu plików
func test_file_operations():
	## Testuj scenariusze crashy związane z plikami
	# Testuj nieprawidłową ścieżkę pliku
	var file = FileAccess.open("invalid://path/file.txt", FileAccess.READ)
	if file == null and logger:
		logger.log_error("Nie udało się otworzyć pliku: nieprawidłowa ścieżka", "SYSTEM_PLIKOW")

# Testowanie pamięci
func test_memory_issues():
	## Testuj problemy związane z pamięcią
	if not logger:
		print("Logger jeszcze niedostępny")
		return
		
	logger.info("Testowanie alokacji pamięci", "TEST_PAMIECI")
	
	# Symuluj operację intensywną dla pamięci
	var duza_tablica = []
	for i in range(100000):
		duza_tablica.append("Test string pamięci %d" % i)
	
	logger.info("Utworzono dużą tablicę z %d elementami" % duza_tablica.size(), "TEST_PAMIECI")
	
	# Posprzątaj
	duza_tablica.clear()
	logger.info("Test pamięci zakończony", "TEST_PAMIECI")

# Integracja z istniejącymi systemami gry
func add_crash_testing_to_game():
	## Przykład jak dodać testowanie crashy do systemów gry
	
	# Dodaj skróty klawiszowe do testowania crashy (tylko w buildach debug)
	if OS.is_debug_build() and logger:
		logger.info("Testowanie crashy włączone - Naciśnij F9 dla podstawowego testu logowania", "CRASH_TESTER")
		
func _input(event):
	## Obsłuż input do testowania crashy (tylko w buildach debug)
	if not OS.is_debug_build() or not logger:
		return
		
	if Input.is_action_just_pressed("ui_accept") and Input.is_key_pressed(KEY_F9):
		logger.info("Uruchamianie pakietu testów crashy", "CRASH_TESTER")
		test_basic_logging()
		test_game_logging()
		test_performance_logging()
		
	elif Input.is_action_just_pressed("ui_accept") and Input.is_key_pressed(KEY_F10):
		logger.warning("Uruchamianie testów symulacji crashy", "CRASH_TESTER")
		test_crash_scenarios()

# Funkcja narzędziowa do sprawdzania pliku logów
func check_log_file():
	## Sprawdź czy logowanie działa poprzez odczyt pliku logów
	if not logger:
		print("Logger jeszcze niedostępny")
		return
		
	var log_content = FileAccess.get_file_as_string("user://game_log.txt")
	if log_content != "":
		logger.info("Plik logów zawiera %d znaków" % log_content.length(), "SPRAWDZENIE_LOGOW")
		print("Ostatnie wpisy w logach:")
		var lines = log_content.split("\n")
		var ostatnie_linie = lines.slice(-5)  # Ostatnie 5 linii
		for line in ostatnie_linie:
			if line.strip_edges() != "":
				print("  " + line)
	else:
		logger.error("Plik logów jest pusty lub nieczytelny", "SPRAWDZENIE_LOGOW")

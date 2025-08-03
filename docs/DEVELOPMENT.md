# Przewodnik Dewelopera - Bilet na Wschód

## Architektura projektu

### Główne systemy

**Game Manager (`Scripts/game.gd`)**
- Centralne zarządzanie stanem gry
- Kontrola przejść między scenami i przepływu gry
- Globalne ustawienia i konfiguracja gry

**System Pasażerów**
- `PassengerDataBus.gd` - Globalna magistrala danych pasażerów, transfer informacji między scenami
- `passenger.gd` - Klasa bazowa Passenger z generowaniem wyglądu i danych osobowych
- `personal_data_manager.gd` - Generator danych osobowych (imiona, nazwiska, adresy, PESEL)
- `passenger_dialogue.gd` - System dialogów z pasażerami
- `passenger_avatar.gd` - Wyświetlanie awatarów pasażerów w UI kontroli

**Specjalni Pasażerowie**
- `laska_passenger.gd` i `laska_control.gd` - Pani z laską (tutorial)
- `dres_passenger.gd` i `dres_control.gd` - Pan w dresie (tutorial)

**System Dokumentów i Kontroli**
- `document_manager.gd` - Przypisywanie typów biletów i dokumentów
- `ticket_control.gd` - Główna logika kontroli biletów i dokumentów
- `ticket.gd` - Klasa biletu
- `id_card.gd` - Dowód osobisty
- `student_id.gd` - Legitka studencka  
- `fine.gd` - System wystawiania mandatów

**Systemy Rozgrywki**
- `wagon.gd` - Logika pojedynczego wagonu, spawn pasażerów
- `wagon_controller.gd` - Kontroler wszystkich wagonów, przejścia między nimi
- `player.gd` - Kontroler gracza i interakcje
- `tutorial.gd` - System tutorialu

**Systemy UI i Narzędzi**
- `toolkit.gd` i `tool_bag.gd` - System narzędzi konduktora
- `journal.gd` - Podręcznik konduktora
- `pause.gd` - Menu pauzy
- `test_hud.gd` - System stresu (w fazie rozwoju)

## Konwencje kodowania

### Konwencje GDScript

```gdscript
# Używaj snake_case dla zmiennych i funkcji
var passenger_count = 0
var is_ticket_valid = false

# Używaj PascalCase dla klas i enumów
class_name PassengerManager
enum TicketType { NORMAL, REDUCED, STUDENT }

# Używaj SCREAMING_SNAKE_CASE dla stałych
const MAX_STRESS_LEVEL = 100.0
const DEFAULT_FINE_AMOUNT = 280

# Jasna dokumentacja funkcji
## Waliduje bilet i zwraca true jeśli jest ważny
## @param ticket: Zasób biletu do walidacji
## @param passenger_data: Powiązane informacje o pasażerze
## @return: Boolean wskazujący ważność biletu
func validate_ticket(ticket: Resource, passenger_data: Dictionary) -> bool:
    # Implementacja tutaj
    return true
```
**Konwencja Nazewnictwa Skryptów**
- Kontrolery scen: `scene_name.gd`
- Menedżery systemów: `system_name_manager.gd`
- Klasy danych: `data_type.gd`
- Kontrolery UI: `ui_element_control.gd`

## Zarządzanie danymi

### Struktura Danych Pasażera

```gdscript
# Scripts/passenger.gd - Klasa bazowa pasażera
extends Node2D
class_name Passenger

var is_skasowaned = false
var is_fined = false
var is_problematic = false  # czy ma problematyczne dokumenty

var gender = ["m","f"].pick_random()
var age = randi_range(12, 95)
var age_range: String  # youth, young_adult, middle_age, senior, elderly
var ticket_type: String  # Normalny, Ulgowy, Studencki, Seniora
var document: PackedScene  # scena dokumentu

# Dane osobowe
var first_name: String
var last_name: String
var full_name: String
var album_number = randi_range(21370, 99769)
var adress: String
var height = ["niski", "średni", "wysoki"].pick_random()
var birth_date: String
var years_of_study: int
var pesel: String
var eye_color = ["green", "blue", "brown"].pick_random()

# Osobowość i zachowanie
var personality: String  # polite, overly_polite, rude, fraidy
var interaction_enabled: bool = false

# PassengerDataBus.gd - System transferu danych
extends Node

var checked_passengers = []
var currently_checked_passenger  # aktualnie kontrolowany pasażer
var current_passenger_document
var current_special  # specjalni pasażerowie (laska, dres)

func transfer_passenger_data(file_name_array, color_array, eye_color):
    # Przenosi dane wizualne do systemu kontroli
```

### Generator Danych Osobowych

```gdscript
# Scripts/personal_data_manager.gd
extends Node

var current_year = 1995  # Rok ustawiony w grze

func generate_birth_date():
    b_year = current_year - passenger.age
    b_month = months.pick_random()
    b_month_num = months.find(b_month) + 1
    b_day = randi_range(1,28)
    birth_date = str(b_day) + " " + b_month + " " + str(b_year) + "r."
    return birth_date

func generate_pesel():
    # Generuje realistyczny PESEL na podstawie daty urodzenia i płci
    var birth_year = str(b_year - 1900)
    # ... logika generowania PESEL
    
func read_names():
    # Ładuje imiona i nazwiska z plików JSON
    names = json_preloader.get_resource("passenger_names").get_data()
    male_names = names["imiona_meskie"]
    female_names = names["imiona_damskie"]
    male_surnames = names["nazwiska_meskie"]
    female_surnames = names["nazwiska_damskie"]
```

### System Typów Biletów

```gdscript
# Scripts/document_manager.gd
extends Node

func assign_ticket(age, age_range):
    match age_range:
        "youth":
            ticket = "Ulgowy"
        "young_adult":
            ticket = "Normalny"
        "middle_age": 
            ticket = "Normalny"
        "senior":
            ticket = "Seniora"
        "elderly":
            ticket = "Seniora"
    
    # Specjalne przypadki dla studentów
    if age >=19 and age <= 26:
        ticket = ["Normalny", "Studencki", "Studencki"].pick_random()
        
func assign_document(age):
    match ticket:
        "Ulgowy":
            # Legitka szkolna (nie zaimplementowana)
        "Studencki":
            document = preload("res://Scenes/student_id.tscn")
        _:
            document = preload("res://Scenes/id_card.tscn")
```

## System kontroli biletów

### Mechanizm Kontroli

```gdscript
# Scripts/ticket_control.gd
extends Control

var passenger  # aktualnie kontrolowany pasażer
var ticket     # instancja biletu
var document   # instancja dokumentu
var is_ticket_checked = false

func start_control():
    passenger = PassengerDataBus.currently_checked_passenger
    create_ticket()
    create_document()
    
func validate_ticket():
    if is_ticket_checked == false and passenger.is_fined == false:
        # Logika dziurkowania biletu
        ticket.get_node("TextureAndLabels").material.set_shader_parameter("mask_size", Vector2(0.25, 0.25))
        ticket.get_node("ValidationArea").queue_free()
        is_ticket_checked = true
        passenger.is_skasowaned = true
        
func create_magnified_document():
    # Tworzy powiększoną wersję dokumentu do inspekcji
    mag_document = passenger.document.instantiate()
    mag_document.set_scale(Vector2(6, 6))
```

### System Mandatów

```gdscript
# Scripts/fine.gd
extends Control

const FINE_AMOUNTS = {
    "no_ticket": 280,
    "invalid_document": 150,
    "expired_ticket": 280
}

func issue_fine(reason: String):
    var amount = FINE_AMOUNTS.get(reason, 280)
    # Logika wystawiania mandatu
```

### Stałe Gry

```gdscript
# Wbudowane w logikę gry - obecnie rozproszone w różnych plikach

# Balans Gry (Scripts/test_hud.gd)
var max_stress := 100.0
var current_stress := 0.0

# Kwoty Mandatów (Scripts/fine.gd)
const FINE_NO_TICKET = 280
const FINE_INVALID_DOCUMENT = 150

# Rok Gry (Scripts/personal_data_manager.gd)
var current_year = 1995

# Typy Biletów (Scripts/document_manager.gd)
enum TicketTypes {
    NORMALNY,
    ULGOWY, 
    STUDENCKI,
    SENIORA
}

# Osobowości Pasażerów (Scripts/passenger.gd)
enum PersonalityTypes {
    POLITE,
    OVERLY_POLITE,
    RUDE,
    FRAIDY
}

# Przedziały Wiekowe (Scripts/passenger.gd)
enum AgeRanges {
    YOUTH,      # 12-24
    YOUNG_ADULT, # 25-39
    MIDDLE_AGE,  # 40-54
    SENIOR,      # 55-74
    ELDERLY      # 75-95
}
```

## Optymalizacja wydajności

### Spawn Systemu Pasażerów

```gdscript
# Scripts/wagon.gd - Efektywny spawn pasażerów w wagonie
extends Node2D

func spawn_passengers():
    var cells: Array = chairs.get_used_cells()  # pozycje krzeseł
    cells.shuffle()
    var num_of_passengers = randi_range(min_passengers, max_passengers)
    
    for cell in cells:
        if instance_count >= num_of_passengers:
            break
            
        var passenger: Passenger = load("res://Scenes/passenger.tscn").instantiate()
        $YSort/Passengers.add_child(passenger)
        passenger.position = chairs.map_to_local(cell) * chairs.scale
        passenger.update_interaction_position(calculate_area_position(cell, passenger.position))
        instance_count += 1
    
    assign_problematic_levels(num_of_passengers)

func assign_problematic_levels(num_of_pas):
    # Przypisuje problematyczne dokumenty losowym pasażerom
    var passenger_arr = $YSort/Passengers.get_children()
    passenger_arr.shuffle()
    var problem_num = randi_range(0, roundi(num_of_pas * 0.5))
    
    for i in range(problem_num):
        passenger_arr[i].is_problematic = true
        passenger_arr[i].get_node('DocumentManager').make_problematic()
```

### System Wagonów

```gdscript
# Scripts/wagon_controller.gd - Zarządzanie wieloma wagonami
extends Node2D

var wagon_count = randi_range(min_wagons, max_wagons)
var all_wagons = []
var all_passengers = []

func spawn_wagons():
    # Pierwszy wagon
    var first_wagon = load("res://Scenes/wagon_first.tscn").instantiate()
    all_wagons.append(first_wagon)
    add_child(first_wagon)
    
    # Wagony środkowe
    for i in wagon_count-2:
        var wagon = load(wagon_scenes.pick_random()).instantiate()
        all_wagons.append(wagon)
        add_child(wagon)
        wagon.visible = false
        wagon.set("process_mode", 4)  # Process mode disabled
    
    # Ostatni wagon
    var last_wagon = load("res://Scenes/wagon_last.tscn").instantiate()
    all_wagons.append(last_wagon)
    add_child(last_wagon)

func change_wagons(player, side):
    # Efektywne przejście między wagonami
    var current_wagon = player.get_parent().get_parent()
    var j = all_wagons.find(current_wagon)
    
    # Wyłącz aktualny wagon
    current_wagon.visible = false
    current_wagon.get_node('CameraOnRail/PathFollow2D/Camera2D').enabled = false
    current_wagon.set("process_mode", 4)
    
    # Włącz nowy wagon
    new_wagon.visible = true
    new_wagon.set("process_mode", 0)
```

## Obsługa błędów

### Solidne Zarządzanie Błędami

```gdscript
# Scripts/error_handler.gd
extends Node

signal error_occurred(error_message: String, severity: ErrorSeverity)

enum ErrorSeverity {
    INFO,
    WARNING,
    ERROR,
    CRITICAL
}

func log_error(message: String, severity: ErrorSeverity = ErrorSeverity.ERROR):
    var timestamp = Time.get_datetime_string_from_system()
    var log_entry = "[%s] %s: %s" % [timestamp, ErrorSeverity.keys()[severity], message]
    
    print(log_entry)
    
    # Zapisz do pliku logu
    var log_file = FileAccess.open("user://error_log.txt", FileAccess.WRITE)
    if log_file:
        log_file.seek_end()
        log_file.store_line(log_entry)
        log_file.close()
    
    error_occurred.emit(message, severity)
    
    # Obsłuż krytyczne błędy
    if severity == ErrorSeverity.CRITICAL:
        handle_critical_error(message)

func handle_critical_error(message: String):
    # Zapisz awaryjny stan gry
    if has_method("emergency_save"):
        call("emergency_save")
    
    # Pokaż dialog błędu użytkownikowi
    var dialog = AcceptDialog.new()
    dialog.dialog_text = "Wystąpił krytyczny błąd: %s\nGra zostanie zamknięta." % message
    get_tree().current_scene.add_child(dialog)
    dialog.popup_centered()
    dialog.confirmed.connect(func(): get_tree().quit())
```

## Framework testowania

### Sceny Testowe w Projekcie

```gdscript
# Scripts/test_dialogue.gd - Test systemu dialogów
# Scripts/test_hud.gd - Test interfejsu i systemu stresu
# Scripts/test_rulebook.gd - Test podręcznika konduktora
# Scripts/test_shaders.gd - Test efektów wizualnych
# Scripts/test_stress_bar.gd - Test paska stresu

# Przykład testu systemu stresu:
# Scripts/test_hud.gd
extends Control

var max_stress := 100.0
var current_stress := 0.0

func _on_small_stress_button_pressed():
    add_stress(10.0)

func _on_medium_stress_button_pressed():
    add_stress(25.0)
    
func _on_large_stress_button_pressed():
    add_stress(50.0)

func add_stress(amount: float):
    current_stress = min(current_stress + amount, max_stress)
    update_stress_bar()
    
func update_stress_bar():
    stress_bar.value = current_stress
    if current_stress >= max_stress * 0.8:
        trigger_stress_flash()
```

### Testowanie Manuelne

**Testowanie Pasażerów:**
- Uruchom `test_dialogue.tscn` dla testów dialogów
- Sprawdź różne typy osobowości pasażerów
- Testuj generowanie danych osobowych

**Testowanie UI:**
- `test_hud.tscn` - system stresu i interfejs
- `test_rulebook.tscn` - podręcznik konduktora
- `test_stress_bar.tscn` - responsywność paska stresu

**Testowanie Systemów:**
- Uruchom główną grę dla pełnych testów integracyjnych
- Sprawdź przejścia między wagonami
- Testuj system kontroli biletów z różnymi dokumentami

## Narzędzia debugowania

### Godot Debug Features

```gdscript
# Użyj wbudowanych narzędzi Godot do debugowania:

# 1. Remote Inspector - podgląd node'ów i właściwości w czasie rzeczywistym
# 2. Profiler - analiza wydajności
# 3. Network Profiler - monitoring sieciowy (jeśli potrzebny)
# 4. Debugger - breakpointy i step-by-step debugging

# Scripts/game.gd - Funkcje pomocnicze do debugowania
extends Node2D

func _input(event):
    if OS.is_debug_build():
        if Input.is_action_just_pressed("debug_spawn_passenger"):
            debug_spawn_passenger()
        elif Input.is_action_just_pressed("debug_toggle_stress"):
            debug_toggle_stress_visibility()

func debug_spawn_passenger():
    # Tworzy testowego pasażera w aktualnym wagonie
    var current_wagon = get_tree().get_first_node_in_group("CurrentWagon")
    if current_wagon:
        var passenger = load("res://Scenes/passenger.tscn").instantiate()
        current_wagon.get_node("YSort/Passengers").add_child(passenger)
        print("Debug: Spawned test passenger")

func debug_toggle_stress_visibility():
    # Pokazuje/ukrywa debug informacje o stresie
    var hud = get_node_or_null("HUD")
    if hud:
        hud.toggle_debug_stress_info()
```

### Print Debugging

```gdscript
# Używaj print() do szybkiego debugowania:

# Scripts/passenger.gd
func _ready():
    if OS.is_debug_build():
        print("Passenger created: ", full_name, " Age: ", age, " Ticket: ", ticket_type)

# Scripts/wagon_controller.gd
func change_wagons(player, side):
    var current_wagon = player.get_parent().get_parent()
    var j = all_wagons.find(current_wagon)
    print("Changing from wagon ", j, " to side: ", side)  # Debug info
```

### Sceny Debug

- `test_dialogue.tscn` - Testowanie systemu dialogów
- `test_hud.tscn` - Testowanie interfejsu użytkownika
- `test_shaders.tscn` - Testowanie efektów wizualnych
- `test_stress_bar.tscn` - Testowanie systemu stresu

## System lokalizacji

### CSV-Based Translation System

```gdscript
# System lokalizacji bazuje na pliku localization.csv
# Struktura: ID,Context,Polish,English,Notes

# Przykłady z localization.csv:
journal_cover_company,Journal Cover,"Przedsiębiorstwo Krajowa Państwowa Komunikacja Pociągowa","National State Railway Communication Company"
journal_page1_title,Journal Page 1,"PODRĘCZNIK KONDUKTORA W TWOJEJ TORBIE","CONDUCTOR'S HANDBOOK IN YOUR BAG"
dialogue_greet_polite,Dialogue,"Dzień dobry, panie konduktorze","Good day, Mr. Conductor"

# Aktualnie system lokalizacji jest zaimplementowany w Godot Project Settings
# jako TranslationServer z plikami .translation wygenerowanymi z CSV

# Scripts/localization_manager.gd (do zaimplementowania)
extends Node

var current_language = "pl"

func get_localized_text(key: String) -> String:
    return tr(key)  # Używa wbudowanego systemu translacji Godot

func set_language(lang: String):
    current_language = lang
    TranslationServer.set_locale(lang)
    get_tree().call_group("localizable", "update_text")
```

### Struktura Plików Lokalizacji

```
localization.csv                    # Główny plik CSV z wszystkimi tekstami
localization.Context.translation    # Kontekst (komentarze)
localization.English.translation    # Tłumaczenia angielskie
localization.Polish.translation     # Teksty polskie
localization.Notes.translation      # Notatki dla tłumaczy
```

## Proces wkładu w projekt

### Standardy Dokumentacji

- **Komentarze kodu** dla złożonej logiki
- **Dokumentacja funkcji** z parametrami i zwracanymi wartościami
- **Aktualizacje README** dla nowych funkcji
- **Wpisy w changelog** dla wszystkich zmian

## 📁 Struktura Plików Projektu

```
BiletNaWschod/
├── Assets/                 # Zasoby gry
│   ├── Fonts/             # Czcionki (.ttf, .otf)
│   ├── Music/             # Muzyka w formacie .ogg
│   ├── SFX/               # Efekty dźwiękowe 
│   └── Sprites/           # Grafiki i tekstury
├── Scenes/                # Sceny Godot (.tscn)
│   ├── UI sceny           # ticket_control.tscn, fine.tscn, journal.tscn
│   ├── Gameplay sceny     # game.tscn, wagon_*.tscn, passenger.tscn
│   ├── Documents          # id_card.tscn, student_id.tscn, ticket.tscn
│   └── Menu sceny         # start_menu.tscn, pause_menu.tscn
├── Scripts/               # Skrypty GDScript (.gd)
│   ├── examples/          # Przykładowe skrypty do nauki
│   ├── Jsons/             # Dane JSON (imiona, nazwiska, adresy)
│   ├── Core Systems:      # game.gd, PassengerDataBus.gd
│   ├── Passenger System:  # passenger.gd, personal_data_manager.gd
│   ├── Control System:    # ticket_control.gd, document_manager.gd
│   ├── UI System:         # toolkit.gd, journal.gd, fine.gd
│   └── Tutorial System:   # tutorial.gd, laska_*.gd, dres_*.gd
├── Resources/             # Zasoby Godot (.tres)
│   ├── camera_rail_curve.tres
│   ├── chairs_tileset.tres
│   └── wagon_tileset.tres
├── Shaders/               # Niestandardowe shadery (.gdshader)
├── docs/                  # Dokumentacja projektu
│   ├── CONTROLS.md        # Sterowanie
│   ├── DEVELOPMENT.md     # Dokumentacja deweloperska
│   ├── GAMEPLAY.md        # Mechaniki rozgrywki
│   └── SETUP.md           # Instrukcje konfiguracji
├── addons/                # Addony/wtyczki Godot
│   └── MyPlugin/
├── localization.csv       # Główny plik lokalizacji
├── localization.*.translation  # Pliki tłumaczeń
└── project.godot          # Główny plik projektu Godot
```

## Narzędzia

### Zewnętrzne Narzędzia
- **Aseprite** - Tworzenie sprite'ów z normal mapami
- **Git** - Kontrola wersji
- **Visual Studio Code** - Edytor kodu z wtyczkami GDScript
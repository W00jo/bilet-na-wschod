# Przewodnik Dewelopera - Bilet na Wschód

## 🏗️ Architektura Projektu

### Główne Systemy

**Game Manager (`Scripts/game.gd`)**
- Centralne zarządzanie stanem gry
- Kontrola przejść między scenami i przepływu gry
- Globalne ustawienia i konfiguracja gry

**System Pasażerów**
- `PassengerDataBus.gd` - Globalne zarządzanie danymi pasażerów
- `passenger.gd` - Zachowania indywidualnych pasażerów
- `passenger_dialogue.gd` - System konwersacji

**System Dokumentów**
- `document_manager.gd` - Obsługa i weryfikacja dokumentów
- `ticket_control.gd` - Logika walidacji biletów
- `fine.gd` - System wystawiania mandatów

**Systemy UI**
- HUD zarządzania stresem
- System podręcznika i referencji
- Interfejs dialogów

## 📝 Konwencje Kodowania

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

### Organizacja Plików

**Struktura Sceny**
```
Node2D (Główna Scena)
├── Player (Kontroler gracza)
├── UI (Warstwa interfejsu użytkownika)
│   ├── HUD (Heads-up display)
│   ├── Journal (Podręcznik referencyjny)
│   └── DialogueBox (UI konwersacji)
├── Passengers (Kontener pasażerów)
└── Environment (Tło i dekoracje)
```

**Konwencja Nazewnictwa Skryptów**
- Kontrolery scen: `scene_name.gd`
- Menedżery systemów: `system_name_manager.gd`
- Klasy danych: `data_type.gd`
- Kontrolery UI: `ui_element_control.gd`

## 📊 Zarządzanie Danymi

### Struktura Danych Pasażera

```gdscript
# PassengerDataBus.gd - Globalne zarządzanie pasażerami
extends Node

var passengers_data = []
var checked_passengers = []

# Struktura danych pasażera
var passenger_template = {
    "id": 0,
    "name": "",
    "surname": "",
    "address": "",
    "personality": PersonalityType.POLITE,
    "has_ticket": true,
    "ticket_type": TicketType.NORMAL,
    "has_valid_id": true,
    "stress_impact": 1.0
}
```

### Architektura Systemu Zapisów

```gdscript
# Scripts/save_manager.gd
extends Node

const SAVE_FILE = "user://game_save.dat"

func save_game():
    var save_data = {
        "version": "1.0",
        "timestamp": Time.get_unix_time_from_system(),
        "player_data": get_player_state(),
        "game_progress": get_game_progress(),
        "settings": get_game_settings()
    }
    
    var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
    file.store_string(JSON.stringify(save_data))
    file.close()

func load_game() -> bool:
    if not FileAccess.file_exists(SAVE_FILE):
        return false
    
    var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
    var json_string = file.get_as_text()
    file.close()
    
    var json = JSON.new()
    var parse_result = json.parse(json_string)
    
    if parse_result != OK:
        return false
    
    apply_save_data(json.data)
    return true
```

## ⚙️ System Konfiguracji

### Menedżer Ustawień

```gdscript
# Scripts/settings_manager.gd
extends Node

signal settings_changed(setting_name: String, new_value)

var default_settings = {
    "language": "pl",
    "master_volume": 1.0,
    "music_volume": 0.8,
    "sfx_volume": 1.0,
    "screen_resolution": "1920x1080",
    "fullscreen": false,
    "vsync": true,
    "show_tutorial": true,
    "accessibility_high_contrast": false,
    "accessibility_text_size": 1.0
}

var current_settings = {}

func _ready():
    load_settings()
    apply_settings()

func set_setting(key: String, value):
    if key in current_settings:
        current_settings[key] = value
        settings_changed.emit(key, value)
        save_settings()
        apply_setting(key, value)

func apply_setting(key: String, value):
    match key:
        "language":
            TranslationServer.set_locale(value)
        "master_volume":
            AudioServer.set_bus_volume_db(0, linear_to_db(value))
        "fullscreen":
            if value:
                DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
            else:
                DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
```

### Stałe Gry

```gdscript
# Scripts/game_constants.gd
extends Node

# Balans Gry
const MAX_STRESS = 100.0
const STRESS_DECAY_RATE = 0.5
const STRESS_INCREASE_BASE = 10.0

# Kwoty Mandatów (PLN)
const FINE_NO_TICKET = 280
const FINE_INVALID_TICKET = 280
const FINE_INVALID_DOCUMENT = 150

# Stałe Czasowe
const GAME_TIME_SCALE = 60.0  # 1 minuta = 1 sekunda
const SHIFT_DURATION_MINUTES = 480  # 8 godzin

# Typy Biletów
enum TicketType {
    NORMAL,
    REDUCED,
    STUDENT,
    SENIOR
}

# Osobowości Pasażerów
enum PersonalityType {
    POLITE,
    OVERLY_POLITE,
    RUDE,
    FRAIDY
}

# Funkcje Użytkowe
static func get_personality_stress_multiplier(personality: PersonalityType) -> float:
    var multipliers = {
        PersonalityType.POLITE: 1.0,
        PersonalityType.OVERLY_POLITE: 1.2,
        PersonalityType.RUDE: 2.0,
        PersonalityType.FRAIDY: 1.5
    }
    return multipliers.get(personality, 1.0)
```

## 🔧 Optymalizacja Wydajności

### Object Pooling dla Pasażerów

```gdscript
# Scripts/passenger_pool.gd
extends Node

var passenger_scene = preload("res://Scenes/passenger.tscn")
var pool_size = 20
var available_passengers = []
var active_passengers = []

func _ready():
    initialize_pool()

func initialize_pool():
    for i in pool_size:
        var passenger = passenger_scene.instantiate()
        passenger.set_process(false)
        passenger.visible = false
        available_passengers.append(passenger)

func get_passenger() -> Node:
    var passenger
    if available_passengers.size() > 0:
        passenger = available_passengers.pop_back()
    else:
        passenger = passenger_scene.instantiate()
    
    active_passengers.append(passenger)
    passenger.set_process(true)
    passenger.visible = true
    return passenger

func return_passenger(passenger: Node):
    if passenger in active_passengers:
        active_passengers.erase(passenger)
        passenger.set_process(false)
        passenger.visible = false
        passenger.reset()  # Niestandardowa metoda resetowania stanu
        available_passengers.append(passenger)
```

## 🐛 Obsługa Błędów

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

## 🧪 Framework Testowania

### Struktura Testów Jednostkowych

```gdscript
# Tests/unit/test_passenger_generation.gd
extends RefCounted

var passenger_generator

func before_each():
    passenger_generator = preload("res://Scripts/passenger_generator.gd").new()

func test_generate_passenger_with_valid_data():
    var passenger_data = passenger_generator.generate_passenger()
    
    assert(passenger_data.has("name"), "Pasażer powinien mieć imię")
    assert(passenger_data.has("ticket_type"), "Pasażer powinien mieć typ biletu")
    assert(passenger_data["name"] != "", "Imię pasażera nie powinno być puste")

func test_stress_calculation():
    var base_stress = 10.0
    var personality_modifier = 1.5
    var expected_stress = base_stress * personality_modifier
    
    var calculated_stress = passenger_generator.calculate_stress_impact(
        GameConstants.PersonalityType.RUDE
    )
    
    assert(calculated_stress == expected_stress, "Nieprawidłowe obliczenie stresu")
```

## 🛠️ Narzędzia Debugowania

### Konsola Debug

```gdscript
# Scripts/debug_console.gd
extends CanvasLayer

var console_visible = false
var command_history = []

func _ready():
    visible = false

func _input(event):
    if event.is_action_pressed("toggle_debug_console"):
        toggle_console()

func execute_command(command: String):
    command_history.append(command)
    
    var parts = command.split(" ")
    var cmd = parts[0].to_lower()
    
    match cmd:
        "stress":
            if parts.size() > 1:
                var value = parts[1].to_float()
                get_node("/root/Game").set_stress(value)
                print("Stres ustawiony na: ", value)
        "spawn_passenger":
            get_node("/root/Game").spawn_debug_passenger()
            print("Debugowy pasażer utworzony")
        "reload_scene":
            get_tree().reload_current_scene()
        _:
            print("Nieznana komenda: ", cmd)
```

## 🌐 System Lokalizacji

### CSV-Based Translation System

```gdscript
# Scripts/localization_manager.gd
extends Node

var translations = {}
var current_language = "pl"

func _ready():
    load_translations()
    TranslationServer.set_locale(current_language)

func load_translations():
    var file = FileAccess.open("res://localization.csv", FileAccess.READ)
    if not file:
        push_error("Nie można załadować pliku lokalizacji")
        return
    
    # Pomiń nagłówek
    file.get_csv_line()
    
    while not file.eof_reached():
        var line = file.get_csv_line()
        if line.size() >= 4:
            var id = line[0]
            var context = line[1]
            var polish = line[2]
            var english = line[3]
            
            translations[id] = {
                "context": context,
                "pl": polish,
                "en": english
            }
    
    file.close()

func get_text(id: String, language: String = current_language) -> String:
    if id in translations:
        return translations[id].get(language, translations[id].get("pl", id))
    return id

func set_language(language: String):
    current_language = language
    TranslationServer.set_locale(language)
    # Wyślij sygnał do aktualizacji wszystkich tekstów UI
    get_tree().call_group("localizable", "update_text")
```

## 🚀 Proces Wkładu w Projekt

### Workflow Git

```bash
# Rozwój funkcjonalności
git checkout -b feature/new-passenger-type
git commit -m "Dodaj typ pasażera seniorów ze specjalną obsługą"
git push origin feature/new-passenger-type

# Naprawy błędów
git checkout -b bugfix/stress-calculation-error
git commit -m "Napraw błąd przepełnienia w obliczaniu stresu"
git push origin bugfix/stress-calculation-error
```

### Proces Code Review

1. **Utwórz branch funkcjonalności** z main
2. **Implementuj zmiany** zgodnie z wytycznymi stylu
3. **Napisz testy** dla nowej funkcjonalności
4. **Zaktualizuj dokumentację** według potrzeb
5. **Prześlij pull request** z jasnym opisem
6. **Rozpatrz feedback** z przeglądu szybko

### Standardy Dokumentacji

- **Komentarze kodu** dla złożonej logiki
- **Dokumentacja funkcji** z parametrami i zwracanymi wartościami
- **Aktualizacje README** dla nowych funkcji
- **Wpisy w changelog** dla wszystkich zmian

## 📁 Struktura Plików Projektu

```
BiletNaWschod/
├── Assets/                 # Zasoby gry
│   ├── Fonts/             # Czcionki
│   ├── Music/             # Muzyka
│   ├── SFX/               # Efekty dźwiękowe
│   └── Sprites/           # Grafiki
├── Scenes/                # Sceny Godot
│   ├── ui/                # Sceny UI
│   ├── gameplay/          # Sceny rozgrywki
│   └── menus/             # Sceny menu
├── Scripts/               # Skrypty GDScript
│   ├── managers/          # Menedżery systemów
│   ├── ui/                # Kontrolery UI
│   ├── gameplay/          # Logika rozgrywki
│   └── data/              # Klasy danych
├── Resources/             # Zasoby Godot (.tres)
├── Shaders/               # Niestandardowe shadery
├── Tests/                 # Testy automatyczne
│   ├── unit/              # Testy jednostkowe
│   └── integration/       # Testy integracyjne
├── docs/                  # Dokumentacja
└── addons/                # Wtyczki Godot
```

## 🔧 Narzędzia Rozwoju

### Zalecane Wtyczki Godot
- **Godot Tools** - Podstawowe narzędzia developera
- **Todo Manager** - Zarządzanie zadaniami w kodzie
- **Gut** - Framework testowania dla Godot

### Zewnętrzne Narzędzia
- **Aseprite** - Tworzenie sprite'ów z normal mapami
- **Git** - Kontrola wersji
- **Visual Studio Code** - Edytor kodu z wtyczkami GDScript

Ten przewodnik rozwoju zapewnia podstawę do utrzymywania i rozszerzania kodu "Bilet na Wschód" przy jednoczesnym zapewnieniu jakości kodu i spójności projektu.

---

**Miłego kodowania! 💻🚂**
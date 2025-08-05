# Implementacja i logika systemów - Bilet na Wschód

*Szczegółowy opis implementacji mechanik gry i logiki systemów*

---

## System generowania pasażerów

### Klasa Passenger (`Scripts/passenger.gd`)
```gdscript
extends Node2D
class_name Passenger

# Stan pasażera
var is_skasowaned = false
var is_fined = false  
var is_problematic = false

# Dane demograficzne
var gender = ["m","f"].pick_random()
var age = randi_range(12, 95)
var age_range: String  # youth, young_adult, middle_age, senior, elderly

# Typy dokumentów  
var ticket_type: String  # Normalny, Ulgowy, Studencki, Seniora
var document: PackedScene

# Dane osobowe
var first_name: String
var last_name: String
var pesel: String
var birth_date: String
var album_number = randi_range(21370, 99769)

# Osobowość
var personality: String  # polite, overly_polite, rude, fraidy
```

### Generator danych osobowych (`Scripts/personal_data_manager.gd`)
- **Funkcja:** Generuje realistyczne dane osobowe
- **Źródła danych:** Pliki JSON z polskimi imionami i nazwiskami
- **PESEL:** Algorytm generujący poprawne numery PESEL
- **Rok bazowy:** 1995 (setting gry)

### Spawn pasażerów (`Scripts/wagon.gd`)
```gdscript
func spawn_passengers():
    var cells: Array = chairs.get_used_cells()
    assign_problematic_levels(num_of_passengers)
    
func assign_problematic_levels(num_of_pas):
    # Algorytm przypisywania problematycznych dokumentów
```

## System dokumentów

### Document Manager (`Scripts/document_manager.gd`)
- **Przypisywanie typów biletów** na podstawie wieku i age_range
- **Logika ulgowa:** Automatyczne przypisanie dokumentów do biletów ulgowych
- **Problematyczne przypadki:** Generowanie błędów w dokumentach

### Typy dokumentów
- **`ticket.gd`** - Klasa bazowa biletu
- **`id_card.gd`** - Dowód osobisty z datami ważności
- **`student_id.gd`** - Legitymacja studencka z numerem albumu

### Walidacja dokumentów
```gdscript
func validate_ticket():
    if is_ticket_checked == false and passenger.is_fined == false:
        # Logika sprawdzania ważności
```

## System kontroli biletów

### Ticket control (`Scripts/ticket_control.gd`)
```gdscript
extends Control

var passenger  # obecnie kontrolowany
var ticket     # instancja biletu  
var document   # instancja dokumentu
var is_ticket_checked = false

func start_control():
    passenger = PassengerDataBus.currently_checked_passenger
    create_document()
```

### Powiększanie pokumentów
```gdscript
func create_magnified_document():
    mag_document.set_scale(Vector2(6, 6))
    # Zoom dla szczegółowego sprawdzenia
```

### Przepływ Kontroli
1. **Interakcja z pasażerem** [E]
2. **Pobranie dokumentów** [LMB]
3. **Powiększenie dokumentów** [Q]
3. **Sprawdzenie szczegółów** [F]
4. **Decyzja:** Akceptacja lub mandat

## System mandatów

### Fine system (`Scripts/fine.gd`)
```gdscript
const FINE_AMOUNTS = {
    "no_ticket": 280,
    "expired_ticket": 280,
    "invalid_document": 150
}

func issue_fine(reason: String):
    var amount = FINE_AMOUNTS.get(reason, 280)
```

### Typy naruszeń
- **Brak biletu** - 280 PLN
- **Nieważny bilet** - 280 PLN  
- **Brak/nieważny dokument** - 150 PLN

## System stresu

### *(Testowa)* Mechanika stresu (`Scripts/test_hud.gd`)
```gdscript
var max_stress := 100.0
var current_stress := 0.0

func add_stress(amount: float):
    current_stress = min(current_stress + amount, max_stress)
    update_stress_bar()
```

### Źródła Stresu
- **Nieuprzejmi pasażerowie** - +25 punktów
- **Trudne sytuacje** - +10-50 punktów
- **Błędy w procedurach** - +15 punktów

### Efekty Wizualne
- **Zniekształcenia ekranu** przy wysokim stresie
- **Zmiany kolorystki** interfejsu
- **Wpływ na wydajność** gracza

## System UI

### Kompendium konduktora (`Scripts/journal.gd`)
```gdscript
# Struktura 10-stronicowa:
# Cover → Pages_1_2 → Pages_3_4 → Pages_5_6 → Pages_7_8 → Pages_9_10

func hide_all_journal_pages():
    for page in $JournalPages.get_children():
        page.visible = false
```

### Funkcjonalności Kompendium
- **Strony 1-2:** Spis treści i wprowadzenie
- **Strony 3-4:** Procedury kontroli biletów
- **Strony 5-6:** Porady dla konduktorów  
- **Strony 7-8:** **Statystyki na żywo** (integracja z gameplay)
- **Strony 9-10:** Glosariusz kolejowy

### Torba Narzędzi (`Scripts/toolkit.gd`, `Scripts/tool_bag.gd`)
- **Dziurkacz** - kasowanie biletów
- **Formularze mandatów** - wystawianie kar
- **Pieczątka** - oficjalne potwierdzenia
- **Kompendium** - dostęp do przepisów

### Statystyki na Żywo (`Scripts/statistics_manager.gd`)
- **Automatyczne aktualizacje** w kompendium
- **Metryki wydajności** konduktora
- **Integracja z gameplay** - dane z rzeczywistej rozgrywki

## System wagonów

### Wagon Controller (`Scripts/wagon_controller.gd`)
```gdscript
var wagon_count = randi_range(min_wagons, max_wagons)
var all_wagons = []
var all_passengers = []

func spawn_wagons():
    # Pierwszy wagon
    add_child(last_wagon)
```

### Przejścia między wagonami
```gdscript
func change_wagons(player, side):
    new_wagon.set("process_mode", 0)
    # Efektywne przełączanie między wagonami
```

## Specjalni pasażerowie *(póki co tylko w tutorialu)*

### Pani w tutorialu
- **Pliki:** `laska_passenger.gd`, `laska_control.gd`
- **Cel:** Nauka podstaw kontroli biletów
- **Zachowanie:** Grzeczna, współpracująca

### Pan dres
- **Pliki:** `dres_passenger.gd`, `dres_control.gd`
- **Cel:** Nauka radzenia sobie z trudnymi pasażerami
- **Zachowanie:** Problemowy, wymagający stanowczości

## Stałe i Konfiguracja Gry

*Constanty dopiero trzeba utworzyć*

---

*Dokument opisuje szczegółową implementację każdego systemu gry wraz z przykładami kodu.*

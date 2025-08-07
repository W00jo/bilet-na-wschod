# Architektura gry

## Przegląd architektury

### Paradygmaty

- **Godot Engine 4.x** - gra używa systemu węzłów (node-tree), gdzie każdy element gry to węzeł
- **Globalne Managery** - obiekty dostępne z każdego miejsca w grze (np. PassengerDataBus przekazuje dane o pasażerach)
- **Niezależne Sceny** - każdy ekran gry to osobny plik (wagon.tscn, ticket_control.tscn)
- **Dane z Plików** - imiona, nazwiska, adresy ładowane z plików JSON, nie wpisane na sztywno w kod

### Jak zorganizowany jest kod

1. **Warstwa Wyglądu** - wszystko co widzi gracz: menu, wagony, bilety, interfejs
2. **Warstwa Mechanik** - logika gry: sprawdzanie biletów, generowanie pasażerów, mandaty
3. **Warstwa Przechowywania** - zapisywanie i ładowanie danych: stan gry, statystyki, ustawienia
4. **Warstwa Zasobów** - pliki graficzne, dźwięki, czcionki, muzykę

**Przykład:** Gdy gracz klika na pasażera:

- **Wygląd:** pokazuje okno kontroli biletu
- **Mechanika:** sprawdza czy bilet jest ważny
- **Dane:** zapisuje statystykę kontroli
- **Zasoby:** odtwarza dźwięk kliknięcia

## Centralne komponenty

### Game Manager (`Scripts/game.gd`)

- **Odpowiedzialność:** Centralne zarządzanie stanem gry
- **Funkcje:** Przejścia między scenami, globalne ustawienia
- **Pattern:** Singleton, State Machine

### PassengerDataBus (`Scripts/PassengerDataBus.gd`)  

- **Odpowiedzialność:** Transfer danych między scenami
- **Funkcje:** Globalna magistrala komunikacji
- **Pattern:** Singleton, Observer

### Scene Controllers

- **Konwencja:** `scene_name.gd` dla każdej głównej sceny
- **Odpowiedzialność:** Zarządzanie logiką konkretnej sceny
- **Komunikacja:** Przez DataBus i sygnały

## Jak działa gra (przepływ danych)

### Tworzenie pasażera (krok po kroku)

```text
1. PersonalDataManager → tworzy dane: imię "Jan Kowalski", wiek 45
2. Passenger → powstaje pasażer z biletem studenckim 
3. PassengerDataBus → przekazuje dane do kontroli biletu
4. TicketControl → sprawdza: 45-latek z biletem studenckim = BŁĄD!
5. ValidationResult → wynik: mandat 280 PLN
```

### Kontrola biletu (co się dzieje gdy klikniesz na pasażera)

```text
1. Gracz klika [E] → PlayerInteraction
2. Otwiera się okno kontroli → TicketControl  
3. Sprawdza bilet i dokumenty → DocumentValidation
4. Jeśli błąd, wystawia mandat → FineSystem
5. Zapisuje wynik → Statistics
```

### Przechodzenie między wagonami

```text
1. Gracz idzie do drzwi → GameManager
2. Ładuje nowy wagon → SceneTransition  
3. Przenosi dane o pasażerach → DataBus.transfer()
4. Nowy wagon się uruchamia → NewScene.initialize()
```

## Rozwiązania programistyczne (wzorce)

### Obiekty Globalne (Singleton)

**Co to:** Obiekty dostępne z każdego miejsca w grze

- `PassengerDataBus` - przechowuje dane o aktualnie kontrolowanym pasażerze
- `GameManager` - steruje całą grą (przejścia między scenami, pauza)
- `StatisticsManager` - liczy ile mandatów wystawiłeś, ilu pasażerów skontrolowałeś

### Fabryki Obiektów (Factory)

**Co to:** Funkcje które tworzą skomplikowane obiekty

- `PersonalDataManager` - tworzy losowego pasażera z imieniem, PESEL-em, wiekiem
- `DocumentManager` - tworzy odpowiedni bilet do pasażera (student → legitymacja + bilet ulgowy)

### Obserwatorzy (Observer)  

**Co to:** Powiadamianie o zdarzeniach

- Godot Signals - gdy pasażer wejdzie do wagonu, wszystkie systemy się dowiadują
- UI updates - gdy zmieni się stres, pasek stresu automatycznie się aktualizuje

### Różne Zachowania Pasażerów (Strategy) *(do implementacji)*

**Co to:** Różne sposoby reagowania pasażerów w zależności od sytuacji

- `PolitePassenger` - grzeczny, współpracuje, nie podnosi stresu
- `RudePassenger` - agresywny, kłótliwy, zwiększa stres konduktora
- `NervousPassenger` - zdenerwowany, może mieć problemy z dokumentami
- `StudentPassenger` - młody, czasem próbuje oszukać z biletem ulgowym

(Szkielet do wypełnienia, gdy system stresu będzie w pełni działać, te wzorce zostaną rozwinięte).

## Struktura Projektu

### Organizacja Folderów

```text
Assets/           # Zasoby zewnętrzne
├── Fonts/        # Czcionki TTF/OTF
├── Music/        # Pliki audio muzyki
├── SFX/          # Efekty dźwiękowe  
└── Sprites/      # Grafiki PNG z normal mapami

Scenes/           # Pliki .tscn
├── game.tscn     # Główna scena gry
├── test_*.tscn   # Sceny testowe
└── ui/           # Sceny interfejsu

Scripts/          # Logika GDScript
├── game.gd       # Game Manager
├── passenger.gd  # Klasa bazowa
├── managers/     # Singleton managery
└── ui/           # Kontrolery UI

Resources/        # Zasoby Godot .tres
└── Shaders/      # Custom shadery
```

### Konwencje nazewnictwa *(do zredagowania potem)*

- **Klasy:** `PascalCase` (PassengerManager)
- **Zmienne/Funkcje:** `snake_case` (is_ticket_valid)  
- **Stałe:** `SCREAMING_SNAKE_CASE` (MAX_STRESS_LEVEL)
- **Pliki scen:** `snake_case.tscn` (ticket_control.tscn)
- **Kontrolery:** `scene_name.gd` lub `component_control.gd`

## Zależności Między Systemami

### Core Dependencies

```text
GameManager
├── PassengerDataBus (komunikacja)
├── StatisticsManager (metryki)  
└── SceneControllers (zarządzanie)
```

### Gameplay Dependencies  

```text
TicketControl
├── DocumentManager (bilety/dokumenty)
├── PassengerDialogue (interakcje)
├── FineSystem (mandaty)
└── StressManager (wpływ na gracza)
```

### UI Dependencies

```text
GameUI
├── Toolkit/ToolBag (narzędzia konduktora)
├── Journal (kompendium)
├── PauseMenu (sterowanie)
└── HUD (pasek stresu, statystyki)
```

## Skalowanie i wydajność

### Optymalizacje

- **Object Pooling** - reużycie pasażerów w wagonach
- **Lazy Loading** - ładowanie dokumentów na żądanie
- **Scene Partitioning** - tylko aktywny wagon renderowany

### Zarządzanie pamięcią

- Automatyczne usuwanie pasażerów po opuszczeniu wagonu
- Cache'owanie często używanych zasobów
- Preload krytycznych komponentów

---

*Dokument definiuje wysokopoziomową strukturę i wzorce projektowe w grze.*

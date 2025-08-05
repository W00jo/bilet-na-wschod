# Bilet na Wschód

**Gra symulacyjna konduktora pociągu / Train Conductor Simulation Game**

Przenosi gracza w charakterystyczny klimat wschodniej Polski lat 90. - daj mandaty, sprawdzaj bilety i użeraj się z niesfornymi pasażerami na gapę! Trudne decyzje moralne czekają w tej immersyjnej grze 2D z pixel art grafiką.

*Experience the authentic atmosphere of 1990s eastern Poland - issue fines, check tickets, and deal with unruly fare dodgers! Tough moral decisions await in this immersive 2D game with pixel art graphics.*

![Game Screenshot](docs/images/screenshot.png) <!-- Dodamy potem! -->

## Opis Gry / Game Description

**Polski:**
"Bilet na Wschód" to gra symulacyjna w 2D, inspirowana klasykami jak "Papers, Please". Wciel się w rolę konduktora wschodniej kolei polskiej tuż po transformacjach ustrojowych z 1989. Sprawdzaj bilety, weryfikuj dokumenty, wystawiaj mandaty i radź sobie z niesfornymi pasażerami - ale uważaj na swój stres! Kolej ma swoje zasady i trzeba się ich trzymać.

**English:**
"Bilet na Wschód" is a 2D simulation game inspired by classics like "Papers, Please". Take on the role of a train conductor on Poland's eastern railway just after the 1989 political transformation. Check tickets, verify documents, issue fines, and deal with unruly passengers - but watch your stress levels! The railway has its rules and you must follow them.

## Funkcjonalności / Features

- **System kontroli biletów** / Ticket control system
- **Weryfikacja dokumentów** / Document verification  
- **System mandatów** / Fine system
- **Zarządzanie stresem** / Stress management
- **Różne typy pasażerów** / Various passenger types
- **Pełna lokalizacja PL/EN** / Full localization PL/EN
- **System tutoriali** / Tutorial system
- **Grafika 2D z normal mapami** / 2D graphics with normal maps

### Inspiracje / Inspirations
- **Papers, Please** (Lucas Pope, 2013) - główna inspiracja mechanik
- **Death and Taxes** (Placeholder Gameworks, 2020) - moralny aspekt decyzji
- **Klimat wschodu Polski** lat 90. - autentyczna atmosfera

*Main inspiration from Papers, Please for mechanics and authentic 1990s eastern Poland atmosphere*

## Rozgrywka / Gameplay

### Typy Biletów / Ticket Types
- **Normalny** - dla dorosłych / for adults
- **Ulgowy** - dla młodzieży i seniorów / for youth and seniors  
- **Studencki** - wymaga legitymacji / requires student ID

### Typy Dokumentów / Document Types
- **Dowód osobisty** / ID card
- **Legitymacja studencka** / Student ID
- **Legitymacja szkolna** / School ID

### Typy Pasażerów / Passenger Types
- **Grzeczni** - współpracują chętnie / Polite - cooperate willingly
- **Przesadnie grzeczni** - powolni ale uprzejmi / Overly polite - slow but courteous
- **Nieuprzejmi** - trudni w obsłudze / Rude - difficult to handle
- **Przestraszeni** - nerwowi i zestresowani / Anxious - nervous and stressed

## Sterowanie / Controls

- **[E]** - Rozmowa z pasażerem (musisz być blisko) / Talk to passenger (must be close)
- **[LMB]** - Pobierz dokument / Take document
- **[Q]** lub **[F]** - Powiększ dokument / Magnify document
- **[ESC]** - Menu pauzy / Pause menu

## Wymagania Techniczne / Technical Requirements

### MINIMALNE / MINIMUM
- **System:** Windows 10 64-bit (build 1903+)
- **Procesor:** Intel Core i3-6100 / AMD FX-6300
- **Pamięć:** 4 GB RAM
- **Grafika:** DirectX 11, 1GB VRAM (Intel HD Graphics 520 / AMD Radeon R5)
- **DirectX:** Wersja 11
- **Miejsce:** 512 MB wolnego miejsca
- **Dodatkowe:** Mysz i klawiatura wymagane

### ZALECANE / RECOMMENDED  
- **System:** Windows 10/11 64-bit (najnowsze aktualizacje)
- **Procesor:** Intel Core i5-8400 / AMD Ryzen 5 2600
- **Pamięć:** 8 GB RAM
- **Grafika:** DirectX 11, 2GB VRAM (GTX 1050 / RX 560)
- **DirectX:** Wersja 12
- **Miejsce:** 1 GB wolnego miejsca
- **Rozdzielczość:** 1920x1080 (Full HD)

### PLATFORMY / PLATFORMS
- **Windows** - Główna platforma ⭐
- **Steam** - Planowane wydanie

## Instalacja / Installation

### Dla Graczy / For Players
1. **Pobierz grę**:
   - [itch.io](https://wuj0.itch.io/bilet-na-wschd) - Najnowsza wersja
   - [GitHub Releases](../../releases) - Wersje deweloperskie
2. **Rozpakuj** archiwum do wybranego folderu
3. **Uruchom** `BiletNaWschod.exe`
4. **Jeśli Windows wyświetli ostrzeżenie**: Kliknij "Więcej informacji" → "Uruchom mimo to"

### Dla Deweloperów / For Developers
1. **Zainstaluj wymagane narzędzia**:
   - [Godot Engine 4.4+](https://godotengine.org/)
   - [Git for Windows](https://git-scm.com/)
   - [VS Code](https://code.visualstudio.com/) z rozszerzeniem godot-tools
2. **Sklonuj repozytorium**:
   ```bash
   git clone https://github.com/W00jo/BiletNaWschod.git
   cd BiletNaWschod
   ```
3. **Otwórz w Godot**: Import → Wybierz `project.godot`
4. **Uruchom**: Scenę główną `Scenes/game.tscn` (F6)

## Struktura Projektu / Project Structure

```
BiletNaWschod/
├── Assets/           # Zasoby gry (sprites, audio, fonts)
├── Scenes/           # Sceny Godot (.tscn)
├── Scripts/          # Skrypty GDScript (.gd)
├── Shaders/          # Shadery niestandardowe
├── Resources/        # Zasoby Godot (.tres)
├── docs/             # Dokumentacja
└── addons/           # Wtyczki Godot
```

### Technologie / Technologies
- **Godot Engine 4.x** - Silnik gry / Game engine
- **GDScript** - Główny język programowania / Main programming language  
- **LibreSprite/Aseprite** - Pixel art i sprite'y / Pixel art and sprites
- **Blender** - Modele 3D z filtrem pixel art / 3D models with pixel art filter
- **Figma** - UI/UX design i mockupy / UI/UX design and mockups

## Dokumentacja / Documentation

### Dla Graczy / For Players
- **[Szybki Start](docs/QUICKSTART.md)** - Jak zacząć grać / How to start playing
- **[Sterowanie](docs/CONTROLS.md)** - Pełna lista kontrolek / Complete controls list
- **[Instalacja](docs/SETUP.md)** - Szczegółowa instalacja / Detailed installation

### Dla Deweloperów / For Developers
- **[Game Design Document](docs/GDD.md)** - Wizja i mechaniki gry / Game vision and mechanics
- **[Dokumentacja deweloperska](docs/dev/INDEX.md)** - Centrum dokumentacji technicznej / Technical documentation hub
- **[Architektura](docs/dev/ARCHITEKTURA.md)** - Struktura systemu / System architecture
- **[Standardy kodowania](docs/dev/CODING-STANDARDS.md)** - Konwencje i best practices / Conventions and best practices

## Zespół / Team

Projekt powstał podczas **Cyberiady** - Mistrzostw w Projektowaniu Gier Komputerowych na UMCS.

**KONDUKTORZY UMCS** *(obecnie: Platform Ten!)*

### Podziękowania
- **Michał Sieńko** i **Wojciech Miedziocha** - opiekunowie zespołów
- **Julia** - najzdolniejsza z Godociar 
- Społeczność **Cyberiady** za wsparcie i inspirację

*"Bez nich by się nam nie udało :)"*

## Zgłaszanie Błędów / Bug Reports

Jeśli znajdziesz błąd, proszę [zgłoś go tutaj](../../issues).

*If you find a bug, please [report it here](../../issues).*

## Wkład / Contributing

Zapraszamy do współpracy! Zobacz [przewodnik współpracy](docs/dev/CONTRIBUTING.md) po szczegóły.

*Contributions are welcome! See [contribution guide](docs/dev/CONTRIBUTING.md) for details.*

---

**Miłej gry! / Happy gaming!**
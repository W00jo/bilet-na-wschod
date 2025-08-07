# Jak korzystać z dokumentacji?

## Dla graczy

### *Chcę tylko grać!*

1. **[Pobierz grę](https://wuj0.itch.io/bilet-na-wschd)** z itch.io
2. **Rozpakuj** i uruchom `BiletNaWschod.exe`
3. **Rozpocznij Tutorial** - poznaj podstawy
4. **[Sprawdź sterowanie](CONTROLS.md)** jeśli masz problemy

### Pierwsze kroki w grze

1. **Zacznij od tutoriala**
2. **Przeczytaj kompendium** (w grze)
3. **Zachowaj spokój** - dokładność ważniejsza od szybkości

### Najważniejsze zasady

- **[E]** - rozmowa z pasażerem (musisz być blisko)
- **[LMB]** - zapytaj o dokument i bilet  
- **[Q]** - powiększ przedmiot do sprawdzenia
- **[F]** - sprawdź czy dokument jest ważny
- **[ESC]** - menu pauzy

## Dla deweloperów

### Szybka konfiguracja

1. **Zainstaluj** [Godot Engine 4.x](https://godotengine.org/)
2. **Sklonuj repo**:

   ```bash
   git clone https://github.com/W00jo/BiletNaWschod.git
   cd BiletNaWschod
   ```

3. **Otwórz w Godot** - wybierz `project.godot`

### Pierwsza eksploracja kodu

1. **Przeczytaj** [GDD.md](GDD.md) - zrozum wizję gry
2. **Sprawdź** [architekturę systemu](dev/ARCHITEKTURA.md)
3. **Zobacz** [konwencje kodowania](dev/CODING-STANDARDS.md)
4. **Przetestuj** sceny w folderze `Scenes/test_*.tscn`

### Kluczowe pliki do zrozumienia

- `Scripts/game.gd` - główny manager gry
- `Scripts/passenger.gd` - system pasażerów
- `Scripts/ticket_control.gd` - logika kontroli biletów
- `Scripts/document_manager.gd` - zarządzanie dokumentami

## Nawigacja po dokumentacji

### Dokumentacja dla wszystkich

- **[README.md](../README.md)** - Przegląd projektu
- **[SETUP.md](SETUP.md)** - Szczegółowa instalacja
- **[GDD.md](GDD.md)** - Game Design Document

### Dokumentacja dla graczy

- **[CONTROLS.md](CONTROLS.md)** - Pełne sterowanie
- **[GDD.md](GDD.md)** - Mechaniki gry (w Game Design Document)

### Dokumentacja dla deweloperów

- **[dev/ARCHITEKTURA.md](dev/ARCHITEKTURA.md)** - Architektura systemu
- **[dev/CODING-STANDARDS.md](dev/CODING-STANDARDS.md)** - Standardy kodowania
- **[dev/LOGIKA.md](dev/LOGIKA.md)** - Logika systemów gry
- **[dev/BUILD.md](dev/BUILD.md)** - Buildowanie i wdrażanie
- **[dev/CONTRIBUTING.md](dev/CONTRIBUTING.md)** - Przewodnik współpracy

## Potrzebujesz pomocy?

### Problemy z grą

1. **Sprawdź** [najczęstsze problemy](SETUP.md#rozwiązywanie-problemów)
2. **Przeczytaj** [kompendium w grze](CONTROLS.md#nawigacja-po-kompendium)
3. **Zgłoś błąd** w [Issues](https://github.com/W00jo/BiletNaWschod/issues)

### Problemy z kodem

1. **Sprawdź** [logikę systemów](dev/LOGIKA.md#przykłady-implementacji)
2. **Uruchom** sceny testowe (`test_*.tscn`)
3. **Skontaktuj się** z zespołem deweloperskim

---

**Miłej gry! / Miłego kodowania!**

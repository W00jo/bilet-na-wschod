# Instalacja - Bilet na Wschód

## Wymagania systemowe

### MINIMALNE

- **System Operacyjny**: Windows 10 64-bit (build 1903 lub nowszy)
- **Procesor**: Intel Core i3-6100 / AMD FX-6300
- **Pamięć**: 4 GB RAM
- **Grafika**: DirectX 11 compatible, 1GB VRAM (Intel HD Graphics 520 / AMD Radeon R5)
- **DirectX**: Wersja 11
- **Miejsce na dysku**: 512 MB wolnego miejsca
- **Dodatkowe**: Mysz i klawiatura wymagane

### ZALECANE

(do wypełnienia)

### PLANOWANE PLATFORMY

- **Windows** - Główna platforma (gotowe)

## Instalacja dla graczy

### Pobieranie gry

1. **Oficjalna strona**: [itch.io/bilet-na-wschod](https://wuj0.itch.io/bilet-na-wschd)
2. **GitHub Releases**: [Najnowsza wersja](https://github.com/W00jo/BiletNaWschod/releases)
3. **Steam**: *(planowane w przyszłości)*

### Instalacja na Windows

1. **Pobierz plik .zip** z wybranej platformy
2. **Rozpakuj** do wybranego folderu (np. `C:\Games\BiletNaWschod\`)
3. **Uruchom** `BiletNaWschod.exe`
4. **Przy pierwszym uruchomieniu**:
   - Windows może wyświetlić ostrzeżenie SmartScreen
   - Kliknij "Więcej informacji" → "Uruchom mimo to"
   - Lub dodaj folder gry do wyjątków antywirusa

### Rozwiązywanie problemów instalacji

- **"Aplikacja nie może się uruchomić"**: Zainstaluj [Microsoft Visual C++ Redistributable](https://docs.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist)
- **Błąd DirectX**: Zaktualizuj sterowniki karty graficznej
- **Antywirus blokuje**: Dodaj `BiletNaWschod.exe` do listy wyjątków

## Instalacja dla deweloperów

### Wymagane narzędzia deweloperskie

1. **Godot Engine 4.4+** - [Pobierz z godotengine.org](https://godotengine.org/)
   - Wybierz wersję Standard (bez C# support, używamy głównie GDScript)
   - Lub wersję .NET jeśli planujesz pisać w C#
2. **Git for Windows** - [git-scm.com](https://git-scm.com/)
3. **VS Code** (zalecane) - z extensions:
   - godot-tools (syntax highlighting dla GDScript)
   - GitLens (lepsze Git integration)
4. **Jira** - [atlassian.com/software/jira](https://www.atlassian.com/software/jira)
   - Zarządzanie zadaniami i trackowanie postępów
   - Dostęp do workspace zespołu KONDUKTORZY UMCS
5. **Aseprite** lub **Libresprite** - do edycji pixel art i sprite'ów
6. **Figma** (opcjonalnie) - [figma.com](https://www.figma.com/)
   - Game design, UI mockupy, wireframing
   - Planowanie interfejsów i layoutów

### Konfiguracja środowiska

1. **Sklonuj repozytorium**:

   ```bash
   git clone https://github.com/W00jo/BiletNaWschod.git
   cd BiletNaWschod
   ```

2. **Otwórz w Godot**:
   - Uruchom Godot Engine
   - Kliknij "Import"
   - Wskaż folder projektu i wybierz `project.godot`
   - Kliknij "Import & Edit"

3. **Sprawdź czy wszystko działa**:
   - Uruchom scenę główną `Scenes/game.tscn` (F6)
   - Przetestuj podstawowe mechaniki
   - Sprawdź czy nie ma błędów w konsoli Godot

### Ustawienia projektu Godot

- **Renderer**: Vulkan (Mobile dla starszych kart graficznych)
- **Target FPS**: 60 (vsync enabled)
- **Import settings**: Keep default texture import settings
- **Export settings**: Skonfigurowane presets dla Windows Desktop

### Architektura projektu

```text
BiletNaWschod/
├── Assets/                 # Zewnętrzne zasoby (importowane do Godot)
│   ├── Fonts/             # Czcionki TTF/OTF
│   ├── Music/             # Muzyka w tle (.ogg, .mp3)
│   ├── SFX/               # Efekty dźwiękowe (.wav, .ogg)
│   └── Sprites/           # Grafiki PNG + normal mapy
├── Scenes/                # Sceny Godot (.tscn files)
│   ├── game.tscn          # Główna scena gry
│   ├── test_*.tscn        # Sceny testowe systemów
│   └── ui/                # Sceny interfejsu użytkownika
├── Scripts/               # Logika gry (GDScript .gd files)
│   ├── Jsons/             # Dane JSON (imiona, adresy, konfiguracja)
│   ├── examples/          # Przykładowe implementacje
│   └── [główne skrypty]   # passenger.gd, game.gd, ticket_control.gd
├── docs/                  # Dokumentacja projektu
│   ├── dev/               # Dokumentacja deweloperska
│   └── [dokumenty użyt.]  # CONTROLS.md, SETUP.md
└── addons/                # Wtyczki Godot
    └── MyPlugin/          # Niestandardowe dodatki
```

## Pipeline zasobów

### Grafika i sprite'y

1. **Tworzenie**: Aseprite/LibreSprite (pixel art 16x16, 32x32, 64x64)
2. **Export**: PNG bez kompresji do `Assets/Sprites/`
3. **Normal mapy**: Generowane automatycznie lub ręcznie w `Assets/Sprites/Normals/`
4. **Import do Godot**: Automatyczne rozpoznawanie jako Texture2D
5. **Ustawienia importu**: Filter OFF dla pixel perfect, Mipmaps OFF

### UI/UX Design

1. **Planowanie**: Figma - wireframing, mockupy, prototyping
2. **Komponenty**: Projektowanie elementów UI przed implementacją
3. **Layout**: Planowanie rozmieszczenia elementów interfejsu
4. **Iteracja**: Testowanie różnych wersji przed kodowaniem

### Audio

1. **Muzyka**: Format OGG Vorbis (lepsze niż MP3 w Godot)
2. **SFX**: WAV lub OGG, krótkie pliki (< 5 sekund)
3. **Kompresja**: Quality 0.7-0.9 dla muzyki, bez kompresji dla SFX
4. **Głośność**: Normalizacja do -6dB peak, -23 LUFS dla muzyki

### Czcionki i UI

1. **Czcionki**: TTF preferred over OTF (lepsza kompatybilność)
2. **Rozmiary**: 12px, 16px, 20px, 24px (pixel perfect sizes)
3. **UI scaling**: Base resolution 1920x1080, stretch mode 2d

## Rozwiązywanie problemów

### Problemy z grą (gracze)

**Gra się nie uruchamia:**

- Sprawdź czy masz Windows 10 64-bit lub nowszy
- Zainstaluj [Visual C++ Redistributable 2015-2022](https://aka.ms/vs/17/release/vc_redist.x64.exe)
- Zaktualizuj sterowniki karty graficznej (NVIDIA GeForce Experience / AMD Adrenalin)
- Uruchom jako administrator

**Problemy z wydajnością:**

- Zamknij niepotrzebne aplikacje (Chrome, Discord)
- Sprawdź czy gra używa właściwej karty graficznej (nie integrated)
- Zmniejsz rozdzielczość Windows do 1920x1080
- Sprawdź czy Windows jest w trybie "Gra" (Game Mode)

**Brak dźwięku:**

- Sprawdź czy gra nie jest wyciszona w Windows Volume Mixer
- Ustaw domyślne urządzenie audio w Windows
- Sprawdź czy audio nie jest przekierowane na inne urządzenie (słuchawki Bluetooth)

### Problemy deweloperskie

**Godot nie otwiera projektu:**

- Sprawdź czy używasz Godot 4.4 lub nowszego
- Usuń folder `.godot/` i zrestartuj Godot
- Sprawdź czy `project.godot` nie jest uszkodzony

**Błędy kompilacji GDScript:**

- Sprawdź składnię w Console/Debugger
- Upewnij się że wszystkie wymagane sceny istnieją
- Sprawdź ścieżki do plików (case sensitive paths)

**Problemy z Git'em:**

- Dodaj `.godot/` do `.gitignore`
- Nie commituj `*.tmp` files
- Używaj LFS dla dużych plików (audio, grafiki > 100MB)

**Błędy import zasobów:**

- Reimportuj zasoby: prawoklik → Reimport
- Sprawdź czy pliki nie są zablokowane przez inną aplikację
- Upewnij się że rozszerzenia plików są poprawne (.png, .ogg, .ttf)

## Uzyskiwanie pomocy

### Dla graczy

1. **Przeczytaj dokumentację**:
   - [Szybki Start](QUICKSTART.md) - podstawowe informacje
   - [Sterowanie](CONTROLS.md) - pełna lista kontrolek
   - [Game Design Document](GDD.md) - mechaniki gry
2. **Sprawdź FAQ** w tym dokumencie (sekcja "Rozwiązywanie problemów")
3. **Zgłoś błąd**: [GitHub Issues](https://github.com/W00jo/BiletNaWschod/issues)

### Dla deweloperów

1. **Dokumentacja techniczna**:
   - [Index deweloperski](dev/INDEX.md) - centrum dokumentacji
   - [Architektura](dev/ARCHITEKTURA.md) - struktura systemu
   - [Logika systemów](dev/LOGIKA.md) - implementacja mechanik
   - [Standardy kodowania](dev/CODING-STANDARDS.md) - konwencje
2. **Współpraca**: [Contributing Guide](dev/CONTRIBUTING.md)
3. **Build i deployment**: [Build Instructions](dev/BUILD.md)

### Kontakt z zespołem

- **GitHub Issues**: Najlepszy (i póki co jedyny) sposób na zgłaszanie błędów i propozycji

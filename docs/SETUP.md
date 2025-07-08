# Instalacja - Bilet na Wschód

## 🖥️ Wymagania Systemowe

### Minimalne Wymagania
- **System Operacyjny**: Windows 10, macOS 10.14, lub Ubuntu 18.04+
- **Procesor**: Intel Core i3 lub AMD odpowiednik
- **Pamięć**: 4 GB RAM
- **Grafika**: Kompatybilna z DirectX 11
- **Miejsce na dysku**: 500 MB wolnego miejsca
- **Sieć**: Połączenie internetowe do pobrania gry

### Zalecane Wymagania
- **System Operacyjny**: Windows 11, macOS 12+, lub Ubuntu 22.04+
- **Procesor**: Intel Core i5 lub AMD Ryzen 5
- **Pamięć**: 8 GB RAM
- **Grafika**: Dedykowana karta graficzna
- **Miejsce na dysku**: 1 GB wolnego miejsca
- **Rozdzielczość**: 1920x1080 lub wyższa

## 🎮 Instalacja dla Graczy

### Windows
1. **Pobierz grę**:
   - Przejdź do [strony Releases](../../releases)
   - Pobierz najnowszą wersję `BiletNaWschod_Windows.zip`

2. **Instalacja**:
   - Rozpakuj archiwum do wybranego folderu
   - Uruchom `BiletNaWschod.exe`
   - Przy pierwszym uruchomieniu może pojawić się ostrzeżenie Windows Defender

3. **Rozwiązywanie problemów**:
   - Jeśli gra się nie uruchamia, sprawdź czy masz zainstalowane Visual C++ Redistributable
   - Upewnij się, że DirectX jest aktualny

### macOS
1. **Pobierz grę**:
   - Pobierz `BiletNaWschod_macOS.dmg`
   - Otwórz plik DMG

2. **Instalacja**:
   - Przeciągnij aplikację do folderu Applications
   - Przy pierwszym uruchomieniu przytrzymaj Ctrl i kliknij aplikację
   - Wybierz "Otwórz" w menu kontekstowym

### Linux
1. **Pobierz grę**:
   - Pobierz `BiletNaWschod_Linux.tar.gz`
   - Rozpakuj: `tar -xzf BiletNaWschod_Linux.tar.gz`

2. **Instalacja**:
   - Nadaj uprawnienia wykonywania: `chmod +x BiletNaWschod`
   - Uruchom: `./BiletNaWschod`

## 🛠️ Instalacja dla Deweloperów

### Wymagania
1. **Godot Engine 4.x** - Pobierz z [godotengine.org](https://godotengine.org/)
2. **Git** - Do kontroli wersji
3. **Aseprite** (opcjonalnie) - Do edycji sprite'ów z normal mapami

### Kroki Instalacji
1. **Klonowanie repozytorium**:
   ```bash
   git clone https://github.com/username/BiletNaWschod.git
   cd BiletNaWschod
   ```

2. **Otwórz w Godot**:
   - Uruchom Godot Engine
   - Kliknij "Import"
   - Przejdź do folderu projektu
   - Wybierz `project.godot`
   - Kliknij "Import & Edit"

3. **Wstępna konfiguracja**:
   - Projekt automatycznie zaimportuje wszystkie zasoby
   - Sprawdź czy wszystkie sceny ładują się poprawnie
   - Zweryfikuj działanie systemu lokalizacji

### Struktura Projektu
```
BiletNaWschod/
├── Assets/           # Zasoby gry
│   ├── Fonts/        # Czcionki
│   ├── Music/        # Muzyka
│   ├── SFX/          # Efekty dźwiękowe
│   └── Sprites/      # Grafiki
├── Scenes/           # Sceny Godot (.tscn)
├── Scripts/          # Skrypty GDScript (.gd)
│   ├── Jsons/        # Dane JSON (imiona, adresy)
│   └── examples/     # Przykłady kodu
├── Shaders/          # Shadery niestandardowe
├── Resources/        # Zasoby Godot (.tres)
├── docs/             # Dokumentacja
└── addons/           # Wtyczki Godot
```

## 🎨 Pipeline Zasobów

### Grafiki
- **Sprite'y**: Tworzone w Aseprite z normal mapami
- **Eksport**: Jako PNG do `Assets/Sprites/`
- **Normal mapy**: Umieszczane w `Assets/Sprites/Normals/`
- **Format**: PNG, zalecana rozdzielczość wielokrotność 16px

### Audio
- **Muzyka**: Pliki OGG w `Assets/Music/`
- **Efekty**: Pliki OGG/WAV w `Assets/SFX/`
- **Kompresja**: OGG dla lepszej kompresji

### Czcionki
- **Lokalizacja**: `Assets/Fonts/`
- **Licencje**: Sprawdź licencje wszystkich użytych czcionek
- **Format**: TTF lub OTF

## 🌍 Konfiguracja Lokalizacji

Gra używa systemu lokalizacji opartego na CSV:

1. **Główny plik**: `localization.csv` zawiera wszystkie tłumaczalne teksty
2. **Obsługiwane języki**: Polski (domyślny), Angielski
3. **Dodawanie nowych tekstów**: Dodaj wpisy do CSV z ID, kontekstem i tłumaczeniami

## 🔧 Instrukcje Buildowania

### Build Debugowy
1. Otwórz projekt w Godot
2. Przejdź do Project → Export
3. Wybierz platformę docelową
4. Kliknij "Export Project"

### Build Release
1. Upewnij się, że cały kod debugowy został usunięty
2. Zoptymalizuj tekstury i pliki audio
3. Ustaw preset eksportu na "Release"
4. Eksportuj z odpowiednimi ustawieniami optymalizacji

## ❗ Rozwiązywanie Problemów

### Najczęstsze Problemy

**Brakujące Tekstury**
- Sprawdź czy wszystkie pliki tekstur są poprawnie zaimportowane
- Zweryfikuj ścieżki plików w dock FileSystem

**Brak Dźwięku**
- Upewnij się, że pliki audio są w formacie OGG lub WAV
- Sprawdź czy węzły AudioStreamPlayer są poprawnie skonfigurowane

**Lokalizacja Nie Działa**
- Zweryfikuj czy `localization.csv` ma poprawny format
- Sprawdź czy TranslationServer jest prawidłowo ustawiony

**Problemy z Wydajnością**
- Włącz profiling w menu debug Godot
- Sprawdź czy nie ma wycieków pamięci w spawnovaniu pasażerów
- Zoptymalizuj rozmiary tekstur jeśli potrzeba

### Problemy Specyficzne dla Platform

**Windows**
- Błąd "VCRUNTIME140.dll not found": Zainstaluj Visual C++ Redistributable
- Antywirus blokuje: Dodaj do wyjątków

**macOS**
- "App can't be opened": Użyj Ctrl+klik → Open
- Problemy z uprawnieniami: Sprawdź System Preferences → Security & Privacy

**Linux**
- Brak uprawnień: `chmod +x BiletNaWschod`
- Problemy z audio: Sprawdź czy PulseAudio/ALSA są skonfigurowane

## 📞 Uzyskiwanie Pomocy

1. Sprawdź [Dokumentację](GAMEPLAY.md) mechanik gry
2. Przejrzyj [Sterowanie](CONTROLS.md) w przypadku problemów z inputem
3. Zobacz [Przewodnik Dewelopera](DEVELOPMENT.md) dla problemów technicznych
4. Skontaktuj się z zespołem deweloperskim poprzez GitHub Issues

## 🔄 Aktualizacje

- **Automatyczne sprawdzanie**: Gra sprawdza dostępność aktualizacji przy starcie
- **Ręczne aktualizacje**: Pobierz najnowszą wersję z GitHub Releases
- **Zachowanie zapisów**: Stare zapisy gry są kompatybilne z nowymi wersjami

---

**Powodzenia w instalacji! 🚂**
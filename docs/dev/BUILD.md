# Build & Deploy

*Instrukcje budowania, kompilacji i wdrażania gry na różne platformy, podwalona z GitHuba.*

---

## Przygotowanie do Build'u

### Wymagania systemowe

- **Godot Engine 4.4** lub nowszy
- **Min. 4GB RAM** podczas kompilacji
- **Min. 2GB miejsca** na dysku dla target platform
- **Internetowe połączenie** dla export templates

### Export Templates

```bash
# Pobieranie w Godot Editor:
Project → Export → Manage Export Templates → Download and Install
```

## Konfiguracja Export Presets

### Windows (PC)

```gdscript
# Ustawienia w Project → Export
Platform: Windows Desktop
Binary Format: 64 bits
Embed PCK: true
Executable Name: "BiletNaWschod.exe"
```

## Proces Buildowania

### Development Build

```bash
# W Godot Editor:
1. Project → Export
2. Wybierz preset "Windows Desktop (Debug)"
3. Export Project → wybierz folder
4. Zaznacz "Export With Debug" dla testowania
```

### Production Release

```bash
# Kroki dla oficjalnego release:
1. Aktualizuj VERSION w project.godot
2. Sprawdź wszystkie sceny pod kątem błędów
3. Uruchom pełny test gameplay
4. Project → Export → "Windows Desktop (Release)"
5. Usuń zaznaczenie "Export With Debug"
6. Export Project do folderu release/
```

### Build Scripts *(do implementacji)*

```bash
# Planowane automatyczne skrypty:
./scripts/build-windows.sh    # Windows build
./scripts/package-release.sh  # Kompletny package
```

## Optymalizacja

### Redukcja rozmiaru

- **Kompresja audio** - OGG Vorbis quality 0.8
- **Kompresja tekstur** - Lossy dla sprites, Lossless dla UI
- **Usuwanie debug info** - Export bez debug symbols
- **Exclude unused assets** - Tylko potrzebne pliki

### Performance settings

```gdscript
# Zalecane ustawienia exportu:
Binary Format: 64-bit (lepszej wydajności)
Threads: true (multicore support)
Debug Features: false (w release)
Optimization: Speed (nie Size)
```

## Platformy

### Systemy operacyjne

- **Windows 10/11** (64-bit) - Główna platforma

### Gdzie wydamy

- **Steam** - Po dopracowaniu
- **GOG** - To my Polacy

## Testing Builds

### Pre-release Checklist

- [ ] Wszystkie sceny ładują się poprawnie
- [ ] Brak error logów w konsoli
- [ ] Tutorial działa od początku do końca
- [ ] System mandatów funkcjonuje
- [ ] Statystyki się zapisują
- [ ] Audio gra na wszystkich poziomach
- [ ] UI skaluje się na różnych rozdzielczościach
- [ ] Gra uruchamia się bez Godot Editora

### Testy wydajności / Performance testing

```bash
- FPS stabilny na min. 30 fps
- RAM usage < 1GB
- Loading time < 5 sekund
- No memory leaks po 30 min grania
```

## CI/CD Pipeline *(przyszłościowe)*

### GitHub Actions

```yaml
# Planowana automatyzacja:
name: Build Game
on: [push, pull_request]
jobs:
  build-windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Godot
        uses: lihop/setup-godot@v2
      - name: Export Game
        run: godot --export "Windows Desktop" build/
```

### Release Automation

- **Automatyczne buildowanie** na każdy tag
- **Wrzucanie na itch.io** przez CI
- **Steam upload** przez Steamworks SDK
- **Version bumping** w project.godot

## Dystrybucja

### itch.io *(główna platforma)*

```bash
# Upload przez butler CLI:
butler push build/ w00jo/bilet-na-wschod:windows
```

### Steam *(planowane)*

- **Steam Direct** - $100 fee
- **Steamworks SDK** integration
- **Achievements** system
- **Steam Workshop** dla modów

### Własna strona

- **Direct download** z GitHub Releases
- **Update checker** w grze
- **Crash reporting** system

## Debug i Diagnostyka

### Debug Build Features

```gdscript
# Dostępne w debug builds:
- Console commands
- Performance overlay (FPS, RAM)
- Scene reload hotkey
- Skip intro/tutorial
- God mode dla testów
```

### Crash Reporting

```gdscript
# Planowany system:
class CrashReporter:
    func report_crash(error: String, stacktrace: String):
        # Send to logging service
        # Include system info
        # Save local crash dump
```

### Profiling Tools

- **Godot Profiler** - CPU/GPU/Memory usage
- **Custom metrics** - Gameplay statistics
- **Performance graphs** - Frame time analysis

## Rozwiązywanie Problemów

### Najczęstsze błędy budowania

- **Missing export templates** → Pobierz z Project Settings
- **Scene errors** → Sprawdź wszystkie .tscn files
- **Asset missing** → Sprawdź paths w FileSystem
- **Script errors** → Fix wszystkie GDScript errors

### Platform-specific Issues

- **Windows**: Antivirus blocking .exe
- **Potential future platforms**: Currently not supported

*Uwaga: Projekt skupia się wyłącznie na platformie Windows Desktop.*

---

*Dokument będzie aktualizowany wraz z rozwojem procesu buildowania.*

# RAZEM ZNACZY WIĘCEJ!

## Przygotowanie środowiska

### Wymagane narzędzia
- **Godot Engine 4.x** - [pobierz tutaj](https://godotengine.org/) *(obsługuje C# i GDScript)*
- **Git** - kontrola wersji
- **Jira** - zarządzanie zadaniami
- **Aseprite** lub **LibreSprite** - edycja sprite'ów i grafik
- **Figma** (opcjonalnie) - [figma.com](https://www.figma.com/) - UI/UX design, mockupy, wireframing

### Konfiguracja
1. Sklonuj repozytorium:
   ```bash
   git clone https://github.com/W00jo/BiletNaWschod.git
   cd BiletNaWschod
   ```
2. Otwórz projekt w Godot
3. Uruchom scenę `Scenes/game.tscn` żeby sprawdzić czy wszystko działa

## Praca z Git'em

### Branche
- **main** - rozwojowa
- **working-version** - stabilna wersja produkcyjna
- **feature/nazwa-funkcji** - nowe funkcjonalności
- **bugfix/opis-bledu** - poprawki błędów
- **qol/nazwa-zmiany** - usprawnienia istniejących rzeczy

### Workflow
1. **Stwórz branch** z dev:
   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/nazwa-funkcji
   ```

2. **Wprowadź zmiany**, fetchuj i commituj regularnie

3. **Push** i stwórz Pull Request do `main`

### Commit Messages
Format: Tytuł, w wiadomości szczegółowy opis z listą zmian

**Przykład:**
```
Merge journal-update branch with complete journal system overhaul
- Replaced old rulebook PNG assets with new journal assets (journal_first.png, journal_blank.png, journal_last.png)  
- Added improved navigation with arrow buttons and fixed navigation logic
- Standardized RichTextLabel components for consistency
```

## Pull Requests

### Przed utworzeniem PR
- Przetestuj nową funkcjonalność
- Zaktualizuj dokumentację jeśli potrzeba

## Jira

### Typy zadań
- **Story** - nowa funkcjonalność
- **Bug** - błąd do naprawy
- **Task** - zadanie techniczne
- **Epic** - duży obszar funkcjonalności

### Workflow zadań
1. **Backlog** → **In Progress** → **Code Review** → **Testing** → **Done**
2. Zawsze przypisz zadanie do siebie przed rozpoczęciem pracy
3. Estymuj czasowo ile zadanie Ci zajmie!
4. Po skończeniu zadania dodaj informację ile faktycznie Ci zajęło!
5. Jeśli zadanie zostanie porzucone dodaj je do **Scrapped**

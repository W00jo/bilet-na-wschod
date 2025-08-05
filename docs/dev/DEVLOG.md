# DevLog Konduktorski

*Dziennik rozwoju technicznego, notatki ze sprintów i wewnętrzne patch notes'y ♥*

---

## Format Wpisów

```
## [Data] - Tytuł Aktualizacji

**Jira ID:** [BNW-XXX](https://konduktorzy.atlassian.net/browse/BNW-XXX) (opcjonalne)

### Zmiany Techniczne
- Lista zmian w kodzie
- Nowe funkcjonalności 
- Poprawki błędów

### Sprint Notes
- Postęp w bieżącym sprincie
- Blockers i problemy
- Decyzje techniczne

### Następne Kroki
- Planowane prace
- Priorytety
```

---

## [05.08.2025] - Refaktoryzacja dokumentacji

**Jira ID:** [BNW-138](https://konduktorzy.atlassian.net/browse/BNW-138)

### Zmiany techniczne
- Utworzono pełną strukturę dokumentacji deweloperskiej w `docs/dev/`

### Sprint Notes
- Przejście z placeholder dokumentacji na w pełni funkcjonalną strukturę
- Synchronizacja wszystkich cross-referencji między dokumentami

### Decyzje Techniczne
- Zastosowano Clean Architecture patterns jako aspiracyjny cel dla refaktoringu kodu

### Następne Kroki
- Wypełnienie GDD.md
- Rozpoczęcie implementacji Clean Code standards w istniejącym kodzie

---

## [04.08.2025] - Implementacja systemu UI zegara

**Jira ID:** [BNW-118](https://konduktorzy.atlassian.net/browse/BNW-118)

### Zmiany techniczne
- Refaktoryzacja `game_ui.gd` - wdrożenie systemu skok-czasowego (step-based time)
- Implementacja ikony czasu `time_icon.png` w głównym interfejsie gry
- Przeniesienie logiki zegara z `test_hud.gd` do produkcyjnego `game_ui.gd`
- Dodanie sygnałów `clock_started` i `clock_finished` dla komunikacji między komponentami
- Optymalizacja: zegar skacze co 5 minut gry = 8 sekund realnych

### Sprint Notes
- Testowanie i debugging systemu czasu na podstawie sceny testowej `test_hud.tscn`
- Successful port logiki z prototypu do main game UI
- Dodano progress tracking i utility functions dla time management
- Integration z istniejącym systemem UI bez breaking changes

### Decyzje Techniczne
- Wybór step-based time system zamiast smooth progression dla lepszej kontroli nad grą (step-based, że rusza się o 5 minut tick)
- Real-time to game-time ratio: 10 minut realnych = 6.25 godzin gry (75 kroków po 5 min)

### Następne Kroki
- Integracja systemu zegara z mechanikami gameplay'u (przede wszystkim progress bar'em)
- Testowanie wydajności w dłuższych sesjach gry

---

## [03.08.2025] - Rozwój systemu dziennika konduktora

**Jira ID:** [BNW-112](https://konduktorzy.atlassian.net/browse/BNW-112)

### Zmiany techniczne
- Refaktoryzacja `journal.gd` - upgrade logiki zarządzania dziennikiem
- Aktualizacja `journal.tscn` - nowy layout i komponenty UI
- Implementacja nowych tekstur dziennika:
  - `journal_first.png` - pierwsza strona dziennika
  - `journal_blank.png` - puste strony dziennika  
  - `journal_last.png` - ostatnia strona dziennika
- Dodanie nowej logiki nawigacji po dzienniku
- Implementacja przycisków strzałkowych dla nawigacji między stronami
- Dodanie przycisku szybkiego dostępu do sekcji statystyk

### Sprint Notes
- Przeprojektowanie UX dziennika - bardziej intuicyjna nawigacja
- Testowanie nowych kontrolek nawigacyjnych
- Optymalizacja flow użytkownika między sekcjami dziennika

### Decyzje Techniczne
- Zwiększenie liczby przycisków nawigacyjnych
- Implementacja quick access do kluczowych sekcji (statystyki)

### Następne Kroki
- Dodanie grafik referencyjnych, gdy mowa o jakiejś mechanice diegetycznie(?)
- Wypełnienie dzienniku treścią
- Dodanie nowych sekcji
- Aktualizowanie strony ze statystykami, wraz z dodawaniem innych mechanik

---

*[Kolejne wpisy będą dodawane chronologicznie]*

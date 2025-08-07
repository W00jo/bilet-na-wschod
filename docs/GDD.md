# Game Design Document - Bilet na Wschód

## Symulator Konduktora na Wschodzie Polski

---

**Wersja dokumentu:** 2.0  
**Data utworzenia:** 2024  
**Data aktualizacji:** 2025  
**Autorzy:** Zespół Platform Ten! (dawniej: Konduktorzy)

**Specjalne podziękowania:**

- Michał Sieńko i Wojciech Miedziocha - opiekunowie zespołów
- Julia - najzdolniejsza z Godociar  
- Społeczność Cyberiady za wsparcie i inspirację

*Bez Was by się nam nie udało!*

**Dokument przygotował:** Jakub "Wujo" Wójcik (@W00jo)

---

## Spis treści

### [1. Wprowadzenie do projektu](#1-wprowadzenie-do-projektu)

- [1.1. Szybkie wprowadzenie](#11-szybkie-wprowadzenie)
- [1.2. Hook](#12-hook)
- [1.3. Splash Art](#13-splash-art)
- [1.4. Podsumowanie mechanik](#14-podsumowanie-mechanik)
- [1.5. Inspiracje growe](#15-inspiracje-growe)
- [1.6. Inspiracje inne](#16-inspiracje-inne)
- [1.7. Platformy](#17-platformy)
- [1.8. Silnik i narzędzia](#18-silnik-i-narzędzia)
- [1.9. Tagi](#19-tagi)
- [1.10. Odbiorcy](#110-odbiorcy)
- [1.11. Analiza marketingowa](#111-analiza-marketingowa)

### [2. Rozgrywka](#2-rozgrywka)

- [2.1. Systemy, mechaniki – ich połączenia i źródła](#21-systemy-mechaniki--ich-połączenia-i-źródła)
- [2.2. Player Experience](#22-player-experience)
- [2.3. Pętla wydarzeń w grze](#23-pętla-wydarzeń-w-grze)
- [2.4. Progresja w grze](#24-progresja-w-grze)

### [3. Mechaniki / Systemy](#3-mechaniki--systemy)

- [3.1. Mechaniki główne](#31-mechaniki-główne)
- [3.2. Mechaniki drugorzędne](#32-mechaniki-drugorzędne)
- [3.3. Mechaniki pozostałe](#33-mechaniki-pozostałe)
- [3.4. System poruszania się i nawigacji](#34-system-poruszania-się-i-nawigacji)
- [3.5. Torba z narzędziami konduktora](#35-torba-z-narzędziami-konduktora)

### [4. Narracja](#4-narracja)

### [5. Sztuka](#5-sztuka)

### [6. UI / UX](#6-ui--ux)

### [7. Pozostałe](#7-pozostałe)

---

## 1. Wprowadzenie do projektu

### 1.1. Szybkie wprowadzenie

*Bilet na wschód* to gra symulacyjna w 2D. Grafika będzie stworzona w Pixel Art'cie, z domieszką modeli 3D w Blenderze, na które zostanie nałożony filtr symulujący ową grafikę. Systemy w rozgrywce pomogą graczowi na immersję, poprzez dokonywanie trudnych moralnie decyzji przy wypełnianiu swoich obowiązków konduktora.

Gracz wciela się w rolę konduktora wschodniej kolei Polskiej, tuż po transformacjach ustrojowych z 1989, gdzie musi radzić sobie z niesfornymi pasażerami, jak i nie narażać swojego chorego serca na niepotrzebny stres. Przy czym nie zapomnieć, że kolej ma swoje zasady i trzeba się ich trzymać!

### 1.2. Hook

*Bilet na wschód* przenosi gracza w charakterystyczny klimat wschodniej Polski, dając możliwość wcielenia się w konduktora polskich kolei… Kto nie chciałby dawać mandatów, sprawdzać biletów i użerać się z niesfornymi pasażerami na gapę?

### 1.3. Splash Art

*[Link do pliku, jak będzie i o ile będzie](Link.png)*

### 1.4. Podsumowanie mechanik

1. **Sprawdzanie dokumentacji pod presją czasu**
2. **Zarządzanie stresem** - Dbanie o zdrowie konduktora przy podejmowaniu trudnych decyzji moralnych
3. **System interakcji społecznych** - Dialogi z pasażerami, mediacja w konfliktach, dylematy etyczne

### 1.5. Inspiracje growe

- *Papers, Please* (Pope, 2013)
- *Death and Taxes* (x, 2020)

### 1.6. Inspiracje inne

- Polskie linie kolejowe i ich kryzys po transformacjach ustrojowych w 1989
- Nasze doświadczenia z podróży pociągami na wschodzie Polski
- Wryomantyzowana wizja PRLu, stworzona dzięki prominentnej pozycji social mediów

### 1.7. Platformy

#### Platforma docelowa

- **PC Windows** - Główna platforma docelowa z naciskiem na komputery osobiste
- **Minimalne wymagania systemowe:**
  - System: Windows 7 lub nowszy
  - Procesor: Dual-core 2.0 GHz
  - RAM: 1 GB
  - Grafika: Zintegrowana karta graficzna
  - Miejsce na dysku: 200 MB

#### Dystrybucja

- **Steam** - Planowana dystrybucja głównie przez Steam jako główny kanał dla gier indie
- **Itch.io** - Rozważana jako alternatywna platforma dla społeczności indie
- **Direct sales** - Możliwość bezpośredniej "sprzedaży" przez stronę zespołu

#### Przyszłe platformy *[TODO: rozważenie]*

- **Linux** - Godot zapewnia natywne wsparcie, relatywnie łatwy port
- **MacOS** - Również możliwy dzięki Godot, ale wymaga testowania na sprzęcie Apple *[Fortunnie daniel ma]*

### 1.8. Silnik i narzędzia

Wybór technologii dla *Biletu na wschód* skupia się na open-source'owych rozwiązaniach, które zapewniają maksymalną elastyczność przy minimalnych kosztach. Strategia ta jest szczególnie ważna dla małego zespołu indie, pozwalając na eksperymentowanie i iterację bez ograniczeń licencyjnych.

| **Komentarz deweloperski** |
| :------ |
| *Wybór **Godot** zamiast **Unity** czy **Unreal** był oczywisty. Nie byliśmy (nadal nie jesteśmy) doświadczonymi game dev'ami, tylko ja (Wujo) miałem (jakąś) styczność z silnikami na U. Niemniej żaden z nich nie jest open-source, a silnik od Epica to aktualnie pokazówka hyperrealistycznej garfiki, która pali komputery i jest nie pasowałby zupełnie do gry 2D. Dodatkowo Julia pracowała już z Godotem i akurat zaczęła się go sama uczyć, a jakby tego było mało zaczęliśmy mieć o nim (Godocie) teorię wykładaną na uniwersytecie.* |

#### Silnik gry

- **Godot 4.x** - Główny silnik do tworzenia gry, open-source, doskonały dla gier 2D
  - Natywne wsparcie dla pixel art
  - Wbudowany system animacji
  - Możliwość exportu na wiele platform

#### Grafika

- **Aseprite** - Podstawowe narzędzie do tworzenia pixel art i animacji
  - **Libresprite** - Darmowa alternatywa do Aseprite
- **Blender** - Tworzenie modeli 3D z filtrem pixel art

#### Design i prototypowanie

- **Figma** - UI/UX design, mockupy interfejsu (opcjonalnie)
- **Pen & paper** - Niezawodne notesy!

#### Zarządzanie projektem

- **Jira** - Tracking zadań i postępów rozwoju
- **Git/GitHub** - Kontrola wersji kodu i zasobów
- **Discord** - Komunikacja zespołu *[obecne rozwiązanie]*
  - **Chat na messengerze** - Uzupełnienie komunikacji na DC, takim luźnym spamem i oznaczaniem się na już

#### Audio *[TODO: zapytać w czym robi Kacper i Zuza]*

### 1.9. Tagi

W erze post-modernistycznej gatunki gier już w roku 2015 miały coraz mniej sensu. Z uwagi na to jak zaszkodziły premierze Cyberpunk 2077 (CD Projekt Red, 2020), gdzie twórcy zmieniali gatunek pokryjomu po premierze, gdzie ta infromacja była dostępna. Lepiej unikać tak odważnego wpychania się w szufladki, stąd lepiej korzystać i opierać się na **tagach**.

#### Tagi główne (Steam/platformy dystrybucji)

- **Simulation** - Symulatory pracy to aktualnie gorący gatunek
- **Puzzle**
- **Point & Click**
- **Indie** - Niezależna produkcja małego zespołu

#### Tagi tematyczne

- **Pixel Art**
- **Singleplayer** - Gra dla jednego gracza
- **Atmospheric** - Klimatyczna gra z naciskiem na atmosferę
- **F2P** - to nasz główny model biznesowy

#### Tagi niszowe *[TODO: przeanalizować, task an Jirze [BNW-134](https://konduktorzy.atlassian.net/browse/BNW-134)]*

- **Trains** - Dla miłośników kolei
- **Retro**
- **Eastern Europe** - Specyficzny kontekst kulturowy
- **Moral Choices** - Dylematy etyczne w rozgrywce

#### Uwagi marketingowe

- Skupić się na unikalnych aspektach (kolej, Polska, lata 90.)
- Rozważyć tagi związane z *Papers, Please* (Pope, 2013) (i tym podobnych) dla targetowania fanów

### 1.10. Odbiorcy

#### Profil odbiorców

- **Wiek:** 16-40 lat (głównie millennialsi i starsi gen Z)
- **Płeć:** Bez ograniczeń, spodziewamy się zrównoważonego odbioru
- **Lokalizacja:** Globalnie z naciskiem na Polskę
- **Wartości:** Autentyczność, wsparcie dla indie deweloperów, ciekawość historyczna
- **Motywacje:** Nostalgia, unikalny gameplay, wsparcie polskich twórców
- **Bariery:** Gra za darmo więc brak barier finansowych

#### Grupy docelowe

**Prymarna:**

- Gracze indie szukający unikalnych doświadczeń
- Fani *Papers, Please* (Pope, 2013) i podobnych gier dokumentowych
- Entuzjaści symulatorów życia/pracy
- Miłośnicy pixel artu i gier retro

**Sekundarna:**

- Polska społeczność gamingowa (nostalgia za latami 90.)
- Miłośnicy pociągów i transportu publicznego
- Gracze szukający gier z dylemami moralnymi
- Społeczność Steam zainteresowana indie titles

#### Rating i zawartość

- **Wiek docelowy:** 16+ (Teen)
- **Powody:** Przerysowana przemoc, alkohol, dylematy moralne
- **Ograniczenia:** Lokalne smaczki, niezrozumiałe dla zagarnicznych odbiorców, ale to może ich także zachęcić, przez swoją "egzotykę"

### 1.11. Analiza marketingowa

| **Komentarz deweloperski** |
| :------ |
| *Analiza rynku była dla nas prawdziwą nauką - początkowo myśleliśmy, że jesteśmy pionierami gier o konduktorach, ale szybko okazało się, że podobne tytuły pojawiają się akurat teraz! To było stresujące, trudno jest uniknąć i jezscze trudniej wyrbonić się z zarzutów o plagiat (w przeciwieństwie do Beholder: Conductor my nie mamy swojej big titty mommy milkers!). Proces ustalania modelu biznesowego naotmiast (dla mnie) wydawał się oczywisty - przekonał mnie sukces "Supermarket Together" (a raczej moje zagrywanie się w niego godzinami i excel) oraz sam fakt, że jako nieznani deweloperzy trudno nam byłoby przekonać graczy do płacenia z góry.* |

#### Aktualność tematu i konkurencja

Pociągowe symulatory oraz gry w stylu *Papers, Please* (Pope, 2013) przeżywają obecnie swoisty renesans. Ostatnie miesiące przyniosły premiery takich tytułów jak:

- *Beholder: Conductor* (Alawar Entertainment, 2025), do którego jesteśmy często porównywani,
- oraz *Locomoto* (Anthropic Games, 2025) - gry o antropomorficznym maszyniście.

Paradoksalnie, te porównania świadczą pozytywnie o naszym researchu rynkowym i trafności wybranego kierunku. Trend wskazuje na rosnące zainteresowanie grami symulacyjnymi, co stawia *Bilet na Wschód* w doskonałym momencie czasowym.

#### Model biznesowy i jego uzasadnienie

Decyzja o darmowej dystrybucji gry bazowej wynika z kilku kluczowych czynników.

1. Po pierwsze, jako nieznanym jeszcze studio trudno byłoby nam konkurować cenowo na polskim rynku, gdzie gracze są notorycznie niechętni do wydawania nawet niewielkich kwot na nowe tytuły.
2. Po drugie, inspirujemy się sukcesem *Supermarket Together* (Northwind Interactive, 2022), gdzie darmowa gra bazowa bez mikrotransakcji zyskała ogromną popularność, a monetyzacja opiera się na płatnych DLC ze skórkami (~15 zł).

Mimo kosztów wejścia na Steam (~$100), strategia free-to-play pozwoli nam zbudować bazę graczy i zaufanie, a następnie monetyzować przez wysokiej jakości dodatki: soundtrack, art book i humorystyczną książkę kucharską opartą na motywach wschodnich smaków Polski.

#### Mocne strony i pozycjonowanie

Nasze główne atuty to:

- unikatowa tematyka polskiej kolei lat 90.,
- autentyczne doświadczenie kulturowe
- oraz nostalgiczny klimat atrakcyjny nawet dla graczy, którzy transformacji ustrojowej osobiście nie pamiętają.

Pixel art pozostaje popularnym stylem w społeczności indie, a mechanika stresu konduktora stanowi innowacyjne podejście do gatunku. Pozycjonujemy się jako duchowy następca *Papers, Please* (Pope, 2013), oferujący podobny dyskomfort moralny, ale w unikalnie polskim kontekście historyczno-kulturowym. (Nie)stety mimo upływu lat, *Papers, Please* nadal nie doczekało się nadejścia swojego następcy z przytupem.

---

## 2. Rozgrywka

### 2.1. O genezie systemów i mechanik

Architektura rozgrywki *Biletu na wschód* opiera się na trzech głównych filarach, które wzajemnie się wspierają i tworzą spójne doświadczenie gracza. Każdy system został zaprojektowany tak, aby wzmacniać immersję, jak i dawać frajdę z gamifikacji doświadczenia konduktora.

#### Główne filary rozgrywki

- **Zarządzanie czasem** - Kontrola biletów i dokumentów pod presją czasu między przystankami
- **Zarządzanie stresem** - Mechanika stresu wpływająca na wydajność i decyzje gracza  
- **System interakcji społecznych** - Dialogi, zarządzanie konfliktami, dylematy moralne

#### Systemy wspierające

- **System ekonomiczny** - Budżet, mandaty, premie, konsekwencje finansowe *[TODO: implementacja]*
- **System progresji** - Rozwój umiejętności konduktora przez doświadczenie z trade-offami między stylami pracy (np. mili konduktorzy otrzymują odznaki i mniejszą konfliktowość pasażerów, ale niższe wynagrodzenie)
- **Elementy narracyjne** - Mini-historie, charakterystyczni pasażerowie, kontekst historyczny

#### Mechaniki UX/UI

- **Satysfakcjonujące interakcje** - Przyjemne kliknięcia, dźwięki ASMR, intuicyjny interfejs
- **Wizualne feedbacki** - Jasne komunikaty o sukcesach/błędach, animacje
- **Immersyjny, diegetyczny interfejs** - Elementy UI wbudowane w świat gry
- **Dostępność** - Czytelne fonty, kontrasty, opcje dla różnych potrzeb *[TODO: implementacja]*

Te systemy działają synergicznie - stres konduktora wpływa na precyzję kontroli dokumentów, presja czasu zwiększa napięcie, a interakcje społeczne mogą zarówno łagodzić, jak i potęgować konflikt między obowiązkiem a empatią.

### 2.2. Player Experience

*Bilet na wschód* ma dostarczyć graczowi wielowarstwowe doświadczenie łączące prostotę mechanik z głębią emocjonalną. Gra świadomie balansuje między rozrywką a refleksją, tworząc przestrzeń dla osobistych interpretacji i moralnych dylematów.

- **Przede wszystkim frajda** - Gra ma być przyjemna i satysfakcjonująca pomimo prostego konceptu sprawdzania biletów
- **Dyskomfort moralny** - Trudne decyzje etyczne przy wypełnianiu obowiązków konduktora
- **Satysfakcja z kompetencji** - Poczucie rozwoju umiejętności i opanowania mechanik
- **Nostalgiczna atmosfera** - Klimat wschodniej Polski lat 90. wywołujący pozytywne emocje
- **Tension i relief** - Napięcie podczas kontroli przeplatane z momentami oddechu między stacjami
- **Poczucie sprawczości** - Gracz ma realny wpływ na losy pasażerów i własną karierę

Kluczowym elementem jest autentyczność doświadczenia - gracze nie wcielają się w superbohatera, ale w zwykłego człowieka wykonującego trudną pracę w niełatwych czasach.

### 2.3. Pętla wydarzeń w grze

Struktura rozgrywki *Biletu na wschód* opiera się na cyklicznych obowiązkach konduktora, przemieszanych z różnorodnymi wyzwaniami. Każdy element pętli został zaprojektowany tak, aby dostarczać różnorodnych wyzwań, jednocześnie zachowując autentyczność doświadczenia pracy w polskiej kolei.

#### Główna pętla rozgrywki

Wypełnianie obowiązku konduktora – sprawdzanie biletów i dokumentacji pasażerów, sprzedawanie biletów *[TODO: mechanika do implementacji w przyszłych wersjach]*, gwizdanie na peronie, mediacja w konfliktach oraz zarządzanie własnymi emocjami w stresujących sytuacjach.

#### Szczegółowy cykl rozgrywki

*[Dev: Wszystkie wartości czasowe [PLACEHOLDER] będą wyrażone w jednostkach czasu odpowiednich dla danego elementu]*

**A. Przystanek** [BOARDING_TIME] → **B. Kontrola** [CHECK_TIME] → **C. Dylematy** [DECISION_TIME] → **D. Przejazd** [TRAVEL_TIME] → **↺ POWTARZAJ**

- **Ad. A. Przystanek** - Nowi pasażerowie wsiadają (+x osób do kontroli) *[TODO: zbalansować liczby pasażerów vs. czas]*
- **Ad. B. Kontrola** - Sprawdzanie biletów i dokumentów (Dochód/Straty/Mandaty)
- **Ad. C. Dylematy** - Decyzje moralne: przepuścić/ukarać (+Stres)
- **Ad. D. Przejazd** - Podróż do następnej stacji (Stres gracza, czy się wyrobi ze sprawdzeniem wszystkich) *[Dev: moment oddechu + building tension]*

→ Cykl trwa do końca trasy (x przystanków na zmianę) *[TODO: określić optymalną liczbę przystanków]*

#### Mikropętla [PASSENGER_TIME]

**Pasażer** → **Sprawdzenie** → **Decyzja** → **Konsekwencje** → **↺**

*[Dev: To jest podstawowa jednostka rozgrywki - musi być satysfakcjonująca i dobrze wybalansowana]*

#### Makropętla [WORKDAY_TIME] - jeden dzień pracy

**Start** → **Serie przystanków** → **Koniec zmiany** → **Podsumowanie** → **↺**

*[TODO: Makropętla to pełny dzień pracy konduktora, gra będzie składać się z kilku takich dni. Ustalić: czy gracz wybiera trasę, czy dostaje przydzieloną?]*

### 2.4. Progresja w grze

#### Struktura rozgrywki

**Cel krótkoterminowy:** Ukończyć zmianę bez przekroczenia krytycznego poziomu stresu (>80%)

**Cel średnioterminowy:** Zdobyć doświadczenie pozwalające na awans lub lepsze trasy

**Cel długoterminowy:** Zostać najlepszym konduktorem wschodnich linii kolejowych z opcją przejścia na emeryturę z godnością

#### Metryki sukcesu

- **Efektywność kontroli** - % sprawdzonych pasażerów
- **Poziom stresu** - Utrzymanie poniżej czerwonej strefy
- **Satysfakcja pasażerów** - Feedback od podróżnych
- **Ocena przełożonych** - Miesięczne raporty wydajności

---

## 3. Mechaniki / Systemy

Sekcja ta szczegółowo opisuje implementację głównych systemów gry, ich wzajemne relacje oraz wpływ na rozgrywkę. Każda mechanika została zaprojektowana z myślą o gamifikacji autentyczności doświadczenia i pracy konduktora.

### 3.1. Mechaniki główne

Mechaniki w zasadzie zawsze sprowadzają się do zarządzania. Gracz musi zarządzać czasem - jak najefektywniej sprawdzić wszystkich pasażerów w określonym okienku czasowym (przejazd pociągu od stacji A do B, od B do C itd.), a także zarządzać własnym stresem (czy warto pchać się w interakcję z jakimś niemilcem, ale ryzykować stresem i chorym sercem, czy olać go, ale liczyć się z reprymendą pracodawcy). Mechaniki są proste w swoich fundamentach i egzekucji.

| **Komentarz deweloperski** |
| :------ |
| *Podczas projektowania głównych mechanik musieliśmy zbalansować autentyczność pracy konduktora z frajdą z rozgrywki. Myślę, że wchodzenie w interakcję z grą i zabawa rozgrywką to najsilniejsze cechy gier wideo i są dla mnie zawsze najważniejsze.* |

#### Wypełnianie obowiązków konduktora pod presją czasu (Core mechanic #1)

*[Dev: Połączenie presji czasu + kontroli biletów + gwizdania = kompleksowe doświadczenie pracy konduktora]*

**Obowiązki konduktora:**

- **Sprawdzanie ważności** - Weryfikacja daty, pieczątki, integralności dokumentu *[TODO: zdefiniować typy błędów w biletach]*
- **Rozpoznawanie typów** - Normalne, ulgowe (dla seniorów i studentów złączone w jeden typ)
- **Weryfikacja uprawnień** - Sprawdzanie dokumentów uprawniających do zniżek
- **Mechanika gwizdania na peronie:**
  - **Sygnał odjazdu** - Zakończenie fazy kontroli poprzez charakterystyczny gwizd
  - **Ceremoniał zawodowy** - Gesture wyciągnięcia gwizdka jako element immersji
  - **Feedback dla gracza** - Może iść na przerwę/zakończyć sesję grania

*[Dev: Gwizdanie to nie tylko mechanika, ale "ceremonialność" kluczowa dla autentyczności doświadczenia konduktora.]*

**Ograniczony czas** - [STATION_TIME] na kontrolę przed następną

- **Strategiczne planowanie** - Balansowanie między dokładnością a szybkością

#### Zarządzanie stresem (Core mechanic #2)

*[Dev: Obrazowany za pomocą pasku w lewym górnym rogu ekranu.]*

- **Pasek stresu** - Wizualny wskaźnik stanu emocjonalnego ([MIN_STRESS]-[MAX_STRESS]%)
- **Czynniki zwiększające** - Agresywni pasażerowie, konflikty moralne *[TODO: zbalansować wartości stresu]*
- **Wpływ na rozgrywkę** - Sięgnięcie zenitu pasku stres = zawał serca *[TODO: zaimplementować do gry]*
- **Mechanizmy odprężenia** - Przerwy między przystankami, pozytywne interakcje *[TODO: dodać mechaniki relaksu]*
- **Decyzje moralne** - Przepuścić, ukarać mandatem, czy wyrzucić z pociągu

#### System interakcji społecznych (Core mechanic #3)

*[Dev: Dialogi + dylematy moralne - serce rozgrywki narracyjnej]*

- **Archetypy pasażerów** - Różne charaktery z unikalnymi wzorcami zachowań
- **System dialogowy?** - z ikonicznymi NPC można wchodzić w swoistą interakcję. Robimy to za pomocą rozgrywki, zamiast osobnego systemu dialogowego:
  - **Pominięcie** - Wpadka gracza, celowa lub nie, gdzie nie wchodzimy w interakcję z pasażeram w trakcie podóży do następnej stacji
  - **Miękkie serce** - Przepuszczenie bez konsekwencji gapowicza
  - **Sztywne egzekwowanie** - Pełne przestrzeganie przepisów

- **Konsekwencje długoterminowe** - Wpływ decyzji na przyszłe interakcje i rozwój konduktora
  - **Ocena przełożonych** - determinuje czy nas nie zwolnią
  - **Stan psychiczny** - patrz #### Zarządzanie stresem (Core mechanic #2)
  - **Memoria pasażerów** - Powtarzający się pasażerowie pamiętają poprzednie interakcje *[TODO: system pamięci NPC]*

### 3.2. Mechaniki drugorzędne

#### System ekonomiczny

System ekonomiczny stanowi mechanizm motywujący gracza do ścisłego przestrzegania regulaminów narzuconych przez kolejowego mocodawcę, jednocześnie kreując napięcie między dodatkowymi benefitami w rozgrywce a własnym poczuciem moralności.

**Struktura mandatów:**

- **Brak/nieważny bilet**: 280 zł
- **Naruszenia dokumentacyjne**: 150 zł

**Źródła przychodów:**

- **Premie za efektywność**: [EFFICIENCY_BONUS] zł za terminowe zakończenie kontroli
- **Komisje od mandatów**: [COMMISSION_RATE]% z wystawionych kar finansowych
- **Łapówki**: [ŁAPÓWKA] zł od pasżera, bez biletu/dokumentów

**Kary ekonomiczne i konsekwencje:**

- **Pominięte kontrole**: [MISSED_CHECK_PENALTY] zł za każdego niesprawdzonego pasażera
- **Błędy proceduralne**: [PROCEDURE_ERROR_COST] zł za nieprawidłowo wystawione mandaty

| **Komentarz deweloperski** |
| :------ |
| *Pierwotna koncepcja systemu ekonomicznego bezpośrednio nawiązywała do mechaniki budżetu osobistego z "Papers, Please" (Pope, 2013), gdzie konieczność utrzymania rodziny stanowiła główny motor napędowy decyzji gracza. Jednak w trakcie rozwoju zdecydowaliśmy się na bardziej subtelne podejście, charakterystyczne dla polskich realiów społecznych. Implementujemy system "nieformalnego wsparcia rodziny" - na przykład pasażer okazuje się być problemem z życia córki protagonisty (ojciec szkolnego łobuza, surowy dyrektor, tyrański nauczyciel), z którym można dyskretnie "załatwić sprawę" poprzez łapówkę czy przysługę. To lepiej oddaje Polską popkulturę.* |

#### System odznaczenia/traitów

Rozwój charakteru konduktora poprzez systematyczne wdrażanie określonego stylu pracy, który przekłada się na zdobywanie osiągnięć, budowanie replay value oraz uzyskiwanie wymiernych korzyści w rozgrywce.

**Przykładowe ścieżki rozwoju charakteru Janusza:**

- **"Dobry wujek"** - Przyznawany po określonej liczbie pobłażliwego potraktowania gapowiczów
  - *Korzyść dla gracza*: Zmniejszona agresywność pasażerów w przyszłych interakcjach
  - *Mechanika od strony kodu*: Pasażerowie chętniej współpracują podczas kontroli

- **"Żelazny konduktor"** - Uzyskiwany przez konsekwentne, książkowe egzekwowanie przepisów
  - *Korzyść dla gracza*: Zwiększony respekt u przełożonych i dodatkowe benefity służbowe
  - *Mechanika od strony kodu*: [PLACEHOLDER - wyższe progi tolerancji dla błędów w ocenach okresowych, bonus do wykrywania naruszeń, możliwość wystawiania wyższych mandatów bez konsekwencji?]

- **[PLACEHOLDER: Dodatkowy trait]** - Miejsce na trzecią ścieżkę rozwoju charakteru
  - *Korzyść dla gracza*: [PLACEHOLDER - do ustalenia w zależności od koncepcji]
  - *Mechanika od strony kodu*: [PLACEHOLDER - szczegóły implementacji do przemyślenia]

**Wizualne oznaczenia progresji:**

Wszystkie zdobyte odznaczenia i cechy charakteru manifestują się poprzez medale i odznaki na mundurze konduktora, stanowiąc natychmiastowy feedback dla gracza oraz satysfakcjonującą gratyfikację za konsekwentny styl gry.

**Wpływ na rozgrywkę:**

System traitów bezpośrednio integruje się z [mechanikami głównymi](#31-mechaniki-główne), wpływając na interakcje społeczne, zarządzanie stresem oraz długoterminową reputację zawodową.

| **Komentarz deweloperski** |
| :------ |
| *Co ciekawe takie odznaczenia faktycznie istnieją w kolei Polskiej! [Odznaka Zasłużonego dla Kolejnictwa](https://pl.wikipedia.org/wiki/Odznaka_honorowa_„Zasłużony_dla_Kolejnictwa”)* |

### 3.3. Mechaniki pozostałe

#### Elementy fabularne w rozgrywce

**Charakterystyczni pasażerowie i wydarzenia narracyjne:**

- **Powtarzające się postacie** - Pasażerowie z rozwiniętymi historiami osobistymi, którzy regularnie podróżują tą samą trasą
- **Wydarzenia losowe** - Scenariusze wybierane z puli przygotowanych wątków, specyficznych dla danej trasy i generowanych przy rozpoczęciu rozgrywki
- **Dylematy moralne** - Sytuacje testujące sumienie gracza np. biedny senior bez biletu jedzie do szpitala. **Opcje gracza:**
  - Wystawić mandat (zgodnie z przepisami)
  - Przepuścić z ostrzeżeniem (ryzyko reprymendy)
  - Pomóc kupić bilet ze własnych pieniędzy (koszt osobisty)
- **Kontekst historyczny** - Elementy związane z Polską, w tamtym czasie np.:
  - Spotkanie Partii Przyjaciół Piwa.

#### Systemy dodatkowe

**Gamifikacja i monitorowanie postępów:**

- **System osiągnięć** - Kluczowy element dla graczy (zdobywców) nastawionych na *completionist gameplay*, szczególnie istotny na platformie **Steam** gdzie system osiągnięć jest szeroko wykorzystywany (w przeciwieństwie do **GOG**'a)
- **Raportowanie końca zmiany**
- **Statystyki długoterminowe** - Diegetyczny podręczniko-dziennik dostępny w torbie narzędzi gracza, umożliwiający przeglądanie osobistych osiągnięć i statystyk "kariery"

**Dodatkowe mechaniki wspierające:**

- **Swoiste archiwum przypadków**: Możliwość odczytania przemyśleń Janusza/przebiegu specjalnego/losowego wydarzenia, czy jakiejś kluczowej interakcji, w tym samym diegetycznym dzienniku

### 3.4. System poruszania się i nawigacji

Przemieszczanie się konduktora po pociągu stanowi podstawę wszystkich interakcji z pasażerami i środowiskiem gry. System został zaprojektowany tak, aby oddawać autentyczność pracy w wagonie kolejowym, jednocześnie pozostając intuicyjnym dla gracza.

**Podstawy poruszania się:**

- **Nawigacja po wagonie** - Konduktor porusza się między siedzeniami pasażerów w ustalonej kolejności
- **Ograniczenia przestrzenne** - Wąski korytarz wagonu wymusza strategiczne planowanie trasy
- **Interakcja z pasażerami** - Zatrzymanie się przy każdym miejscu siedzącym dla kontroli biletów
- **Przejścia między wagonami** - Możliwość przemieszczania się do sąsiednich części składu *[TODO: zaimplementować w przyszłych wersjach]*

**Czas**
Presja wynika z ograniczonego czasu, bo pociąg (najopewniej, bo przecież się nie spoźni) do trze na następny peron na określoną godzinę, więc gracz potencjalnie może nie zdażyć skasować wszystkim pasażerom bilet.

**Wpływ na gameplayloop:**

System poruszania się bezpośrednio integruje się z wszystkimi [mechanikami głównymi](#31-mechaniki-główne), determinując tempo i rytm rozgrywki. Każdy ruch konduktora musi być przemyślany, ponieważ wpływa na efektywność kontroli i poziom stresu.

| **Komentarz deweloperski** |
| :------ |
| *Początkowo planowaliśmy pełną swobodę poruszania się po wagonie, ale szybko okazało się, że to rozpraszało od głównej mechaniki gry. Obecny system z ustaloną trasą lepiej oddaje rzeczywistość pracy konduktora i zmusza gracza do strategicznego myślenia o kolejności kontroli.* |

### 3.5. Torba z narzędziami konduktora

Diegetyczny interfejs narzędzi służbowych stanowi centralny element interakcji gracza z systemami gry. Torba konduktora zawiera wszystkie niezbędne przybory do wykonywania obowiązków służbowych, zapewniając immersyjne doświadczenie, zgodne z designowaniem UI/UX.

- **Interakcja myszą** - Kliknięcie na torbę uruchamia animację otwierania/zamykania
- **Animowane przejścia** - Płynne wysuwanie torby z dolnej części ekranu (trwa [0.25s])
- **Feedback audio** - Charakterystyczny dźwięk otwierania torby dla lepszej immersji
- **Pozycjonowanie** - Torba ukryta poza ekranem, wysuwana na pozycję roboczą

#### Zawartość torby

- **Dziurkacz** - Weryfikacja autentyczności biletów przez ich kasowanie
  Oparty o *drag & drop*, czyli przeciągnięcie na bilet pasażera. Bezpośredni wpływ na [Core mechanic #1](#31-mechaniki-główne
- **Narzędzie do mandatów** - Wystawianie kar finansowych dla gapowiczów/sabotażystów
- **Podręcznik konduktora [J]**
  - *Interfejs*: Dedykowany ekran z instrukcjami, notatkami Janusza i danymi kariery
  - **Mapka podróży**
  - **System statystyk i monitorowania progresji** - Sekcja ze statystykami zawierająca:
    - **Licznik skasowanych biletów** - Aktualizowany w czasie rzeczywistym!
    - **Licznik pominiętych kontroli**
    - **Najbardziej stresujące wydarzenie**
    - **Licznik dni pracy** - Całkowity staż w zawodzie
  - **Sekcja osiągnięć** - Lista zdobytych odznaczeń i traitów charakteru
  - **Sekcja dziennika** - Przemyślenia i refleksje Janusza o minionych wydarzeniach w grze
- **Gwizdek** - [PLACEHOLDER: Funkcjonalność do doprecyzowania]

| **Komentarz deweloperski** |
| :------ |
| *To jest mój osobisty konik, perła w oczku i ulubione z dzieci. Mam nadzieję, że i po tym gdd to widać, że pasjonuje mnie szczerze tworzenie rzetelnej dokumentacji :).* |

---

## 4. Narracja

### 4.1. Elementy narracyjne

#### Filozofia narracji w grze

**Emergentna narracja** - Historia nie jest opowiedziana explicite, ale wyłania się z codziennych decyzji gracza. Każda interakcja z pasażerem, każdy dylemat moralny, każde użycie gwizdka tworzy unikalną opowieść o konduktorze Januszu i jego podejściu do pracy w wyzywających dla niego (Janusza) czasach.

**Show, don't tell** - Zamiast długich ekspozycji, kontekst historyczny i społeczny ujawnia się przez:

- **Archetypy pasażerów** reprezentujących różne warstwy społeczne lat 90.
- **Narrację środowiskową** - wygląd pociągu i peronu, gazety, plakaty, rozmowy pasażerów
- **Notatki Janusza** zapisane w [dzienniku konduktora](#35-torba-z-narzędziami-konduktora)

Gra nie stara się być poważniejsza i większa niż życie. W zasadzie to parodiuje, czy punktuje w szczery, pocieszny sposób bolączki i udręki, jakie mogły spotkać wtedy ludzi i jakie spotykają ich nadal dziś.

#### Narzędzia narracyjne

- **[System stresu](#31-mechaniki-główne)** = wewnętrzny konflikt protagonisty między empantią a własnym dobrostanem
- **Dylematy z NPCtami** = test charakteru gracza i budowanie tożsamości Janusza

**Narracja środowiskowa** - Wagon kolejowy jako "żywy" świat opowiadający historię:

- **Architektura z epoki** - charakterystyczne siedzenia, okna, wąski korytarz wagonu SU45
- **Detale czasowe** - gazety z nagłówkami o transformacji, plakaty wyborcze, rozmowy pasażerów

**Interaktywne storytelling** - Gracz nie tylko obserwuje, ale aktywnie tworzy narrację poprzez:

- **Styl pracy** - czy Janusz stanie się łagodnym "dobrym wujkiem" czy surowym "żelaznym konduktorem"
- **Wybory moralne** jakie podejmuje przez rozgrywkę, wpływające na [rozwój charakteru](#32-mechaniki-drugorzędne) i przyszłe interakcje

#### Typy narracji w grze

**Fabuła emergentna** - Główna historia wyłania się z gameplayu:

- Brak liniowego głównego wątku
- História tworzy się przez style gry gracza i jego moralne wybory  
- Każda rozgrywka może opowiedzieć inną historię o tym samym konduktorze. Jakby nie było **Janusz Efinowicz** jest tylko trybikiem w systemie

**Ikoniczni pasażerowie**, których napotkamy podczas rozgrywki, reprezentują różne stereotypy polskiego społeczeństwa lat 90. Może pozostające nawet do dziś aktualne. Niemniej pozwalają się wczuć w klimat czasów, których się nawet nie przeżyło.

**Świat gry jako narracja** - Wschodnia Polska jako pełnoprawny "bohater":

- **Kontekst historyczny** - rok 1990, transformacja ustrojowa, kryzys kolejnictwa (łapówki i korupcja, słaba dokumentacja)
- **Klimat regionalny** - specyfika wschodniej Polski, mentalność, trudności ekonomiczne
- **Autentyczność kulturowa** - dialekty, zwyczaje, realia społeczne z epoki

#### Integracja z mechanikami

Każdy element narracyjny bezpośrednio wspiera [mechaniki główne](#31-mechaniki-główne):

| **Element narracyjny** | **Mechanika docelowa** | **Sposób integracji** | **Wpływ na rozgrywkę** |
|------------------------|------------------------|----------------------|------------------------|
| **Dylematy moralne** | [System zarządzania stresem](#31-mechaniki-główne) | Trudne decyzje zwiększają poziom stresu | Gracz musi balansować między empatią a zdrowiem |
| **Presja społeczna** | [Kontrola biletów pod presją czasu](#31-mechaniki-główne) | Agresywni pasażerowie skracają czas reakcji | Stres wpływa na precyzję sprawdzania dokumentów |
| **Rozwój charakteru** | [System traitów/odznaczeń](#32-mechaniki-drugorzędne) | Konsekwentne wybory kształtują osobowość Janusza | Różne style gry odblokowują unikalne benefity |
| **Relacje międzyludzkie** | [System interakcji społecznych](#31-mechaniki-główne) | Pamięć NPC o poprzednich spotkaniach | Budowanie reputacji wpływa na przyszłe interakcje |
| **Narracja środowiskowa** | [Immersyjny interfejs](#35-torba-z-narzędziami-konduktora) | Detale wagonu wspierają autentyczność | Zwiększona immersja i klimat gry |
| **Emergentna fabuła** | [Wszystkie mechaniki](#31-mechaniki-główne) | Historia wyłania się z decyzji gracza | Każda rozgrywka tworzy unikalną narrację |

| **Komentarz deweloperski** |
| :------ |
| *Każda **[mechanika](#3-mechaniki--systemy)** ma na celu zarówno sprawiać frajdę z grania, ale też budować narrację. To już truizm, że najsilniejszą cechą narracji gier, jest ich **interaktywność**. Postawiliśmy na prowadzenie dialogu, wchodzenie w współoddziaływanie z npc, przez rozgrywkę. Jakby tego było mało, to o wiele łatwiej jest nam tworzyć, jako początkującym game devom.* |

### 4.2. Znaczące punkty w fabule

Progresja narracyjna w *Bilecie na wschód* nie opiera się na standardowym dziś story points, ale na emergentnych momentach, które definiują styl pracy i moralny profil protagonisty.

#### Kluczowe momenty narracyjne

- **Pierwszy dzień pracy** - Tutorial wprowadzający gracza w podstawowe mechaniki i klimat gry:
  1. Zapoznanie z obowiązkami konduktora
  2. Pierwsza interakcja z problematycznym pasażerem
  3. Ustalenie tonu dla dalszej rozgrywki
- **Wydarzenia przełomowe** *(wybierane losowo z puli w trakcie rozgrywki)*
- **Coprzejazdowe karty oceny** - Momenty refleksji i feedbacku od przełożonych. Przydatne w narracji, opartej o takie decyzje *[Dev: Polecam zobaczyć sobie Day Repeat Day, gdzie taki system pracy w korpo i w zasadzie prowadzenia narracji jest bliźniaczo podobny do naszego. Dodatkowo jest to bardzo dobre Match-3!]*

#### Progresja narracyjna i zakończenia gry

System wielokoncówkowy oparty na **stylu pracy gracza** i **decyzjach moralnych** podejmowanych przez całą karierę. Każde zakończenie odzwierciedla konsekwencje wyborów dokonanych w trakcie służby, tworząc spersonalizowaną historię o konkretnym podejściu do pracy konduktora.

**Ścieżki zakończenia:**

*[Dev: wszystkie zakończenia to i tak głównie [PLACEHOLDERY]. Będzie trzeba je przerobić i doszprycować zapewne.]*

- **"Żelazny służbista"** - Konsekwentne przestrzeganie przepisów
- **"Dobry wujek"** - Humanitarne podejście do pasażerów
- **"Wypalenie zawodowe"** - Przekroczenie limitu stresu
- **"Korupcyjna ścieżka"** - Przyjmowanie łapówek i układy nieformalne
- **"Rodzinny dramat"** - Zaniedbanie życia prywatnego
- **"Złoty środek"** - Zbalansowane podejście

*[TODO: integracja z systemem traitów]* - Bezpośrednie połączenie z [systemem traitów](#32-mechaniki-drugorzędne) i wpływ na rozwój charakteru.

### 4.3. Scenariusze i wydarzenia

Konkretne sytuacje narracyjne w *Bilecie na wschód* tworzą bibliotekę scenariuszy, które mogą wystąpić podczas rozgrywki. Każdy scenariusz został zaprojektowany tak, aby testować różne aspekty moralności gracza i wpływać na rozwój charakteru Janusza.

#### Kategorie scenariuszy

**Scenariusz tutorialu**:
Wprowadzenie do mechanik i klimatu i jednocześnie wyjaśnia dlaczego Janusz byłby doświadczony. Jest to jego retrospekcja/sen wydarzeń sprzed 5-ciu lat. Jednocześnie:

- wprowadza go do podstawowych obowiązków konduktora
- uczy radzić sobie z agresorami

**Scenariusze losowe** *(wybierane z puli w trakcie rozgrywki)* *[TODO: rozbudować bazę scenariuszy]*:

- **"Senior bez biletu"** - Starszy człowiek jedzie odwiedzić chorego wnuka, nie ma pieniędzy na bilet
  - *Opcje gracza*: [PLACEHOLDER]
  - *Wpływ na narrację*: [PLACEHOLDER]

- **"Łapówka od dyrektora"** - Wpływowa osoba próbuje przekupić konduktora
  - *Opcje gracza*: [PLACEHOLDER]
  - *Wpływ na narrację*: [PLACEHOLDER]

- **"Zmiana czasu"** - Pociąg się zatrzymuje na godzinę w środku nocy na trasie
  - *Wpływ na narrację*: [PLACEHOLDER]

**Scenariusze okresowe** - Wydarzenia cykliczne:

- **"Cotygodniowa ocena"** - Regularny kontakt z przełożonymi (możliwość awansu lub nagany w zależności od stylu pracy i decyzji gracza)

*[TODO: proceduralne mieszanie]* - System wyboru scenariuszy z bazowej puli w zależności od stylu gry gracza i postępu narracyjnego.

#### Dynamiczne wydarzenia

**System pamięci NPC** - Powtarzające się interakcje z charakterystycznymi pasażerami *[TODO: zaimplementować system pamięci NPC]*:

- Pasażerowie pamiętają poprzednie spotkania z Januszem
- Reakcje uzależnione od wcześniejszych decyzji gracza

**Wydarzenia związane z kontekstem historycznym**:

- **"Transformacja w tle"** - Rozmowy pasażerów o zmianach politycznych
- **"Strajki"** - Solidarność zawodowa vs. obowiązki służbowe
- **"Przyjaciele piwa"** - Partia Przyjaciół Piwa chleje w pociągu

(Opcjonalnie) *[TODO: przygotować makiety w Figmie]* - Wizualizacja kluczowych momentów scenariuszy dla zespołu artystycznego i lepszej komunikacji koncepcji. gracza.

| **Komentarz deweloperski** |
| :------ |
| *Myślę, że takie scenariusze są najbardziej atrakcyjne dla graczy, jest to mój ulubiony styl tworzenia angażujących mikronarracji oraz zadań dla odbiorcy. Samo projektowanie ich to także kupa radości, dająca masę wolności kreatywnej.* |

### 4.4. Charakterystyka postaci

#### Główne postacie

##### Janusz Efinowicz - Protagonista

| Cecha | Wartość |
|-------|---------|
| Imię | Janusz Efinowicz |
| Wiek | 45 lat |
| Zawód | Konduktor PKP |
| Status rodzinny | Żonaty, ojciec nastolatki |
| Stan zdrowia | Problemy z sercem (stres w pracy) |
| Motywacja | Utrzymanie rodziny |
| Osobowość | *[PLACEHOLDER: do rozwinięcia - balans między obowiązkiem a empatią]* |

##### x Efinowicz - Żona Janusza

| Cecha | Wartość |
|-------|---------|
| Imię | Grażyna Efinowicz |
| Wiek | 42 lata |
| Zawód | *[PLACEHOLDER: do ustalenia - prawdopodobnie praca w lokalnej administracji]* |
| Status | Żona Janusza, matka Moniki |
| Motywacja | *[PLACEHOLDER: stabilność rodziny, przyszłość córki]* |
| Relacja z mężem | *[PLACEHOLDER: wsparcie vs. napięcia związane z pracą Janusza]* |

##### y Efinowicz - Córka (Punkówka)

| Cecha | Wartość |
|-------|---------|
| Imię | Monika "Monia" Efinowicz |
| Wiek | 16 lat |
| Zawód | Uczennica liceum |
| Styl | Punkowy bunt przeciwko PRL-owskim normom |
| Status rodzinny | Córka Janusza i Grażyny |
| Motywacja | *[PLACEHOLDER: bunt młodzieńczy, poszukiwanie tożsamości w zmieniającym się świecie]* |
| Relacja z ojcem | *[PLACEHOLDER: napięcia pokoleniowe, ale głęboka więź]* |

#### Archetypy pasażerów

##### Arek "Romantyk"

| Cecha | Wartość |
|-------|---------|
| Imię | Arek „Romantyk" |
| Wiek | 17 lat |
| Zawód | Uczeń budowlanki |
| Miejsce życia | Wieś niedaleko Sandomierza |
| Status rodzinny | Mieszka z matką i braćmi |
| Motywacja | Miłość i poszukiwanie emocji |

*[PLACEHOLDER na dodatkowe archetypy pasażerów]*

### 4.5. Relacje

[DIAGRAM_RELATIONSHIPS_PLACEHOLDER](diagarm.png)

#### Dynamika relacji w rozgrywce

**Rodzina Janusza:**

- **Grażyna** ↔ **Janusz**: Wsparcie emocjonalne ⟷ Napięcia z powodu pracy
- **Monia** ↔ **Janusz**: Bunt młodzieńczy ⟷ Ojcowska troska
- **Monia** ↔ **Grażyna**: *[PLACEHOLDER: dynamika matka-córka w czasach transformacji]*

**Relacje zawodowe:**

- **Janusz** → **PKP**: Lojalność pracownika ⟷ Wymagania systemu
- **Pasażerowie** → **Janusz**: Różnorodne postawy ⟷ Jednolita rola konduktora

**Wpływ na mechaniki gry:**

- Decyzje wobec pasażerów → Stres → Relacje rodzinne
- Styl pracy → Oceny przełożonych → Stabilność finansowa rodziny

### 4.6. System komunikacji z pasażerami

W *Bilecie na wschód* komunikacja z pasażerami odbywa się naturalnie, poprzez reakcje na działania konduktora, a nie przez tradycyjny system dialogowy z wyborem opcji.

#### Filozofia komunikacji

Gra **nie wykorzystuje** klasycznego systemu dialogowego wyboru odpowiedzi znanego z gier RPG. Zamiast tego komunikacja odbywa się poprzez:

- **Naturalne interakcje** - Rozmowy wynikają z kontekstu sytuacji (kontrola biletów, sprawdzanie dokumentów)
- **Feedback środowiska** - To jak zmienia się charakter i mundur bohatera, odwzierciedla stosunek świata do niego samego

#### Ożywienie pasażerów

**Chmurki dialogowe** - Główny sposób komunikacji pasażerów:

- *Lokalizacja:* Nad głowami pasażerów w wagonie
- *Treść:* Krótkie, naturalne komentarze, czy myśli (np. "ale jestem głodnx", czy frustracja)
- *Timing:* Pojawiają się w odpowiedzi na działania  i losowo w trakcie podróży
- **Kontekstowe rozmowy pasażerów między sobą:**
  - **Polityka:** "Słyszałeś o nowym premierze?" / "Ciekawe, co będzie z koleją"
  - **Transformacja:** "Wszystko się zmienia..." / "Kiedyś było inaczej"
  - **Lokalne wydarzenia:** "W Biłgoraju utknął jakiś szczyl" / "Drożyzna straszna"

#### Przykłady interakcji

**Standardowa kontrola biletów:**

```text
Konduktor podchodzi → Pasażer: "Bilet? Proszę bardzo"
Konduktor sprawdza → Pasażer: "Wszystko w porządku?"
Konduktor kasuje → Pasażer: "Dziękuję"
```

*[Dev: Reakcje na różne style pracy?]*

---

## 5. Sztuka

### 5.1. Kierunek w sztuce, koncepty

Gra stawia na stylizowany pixel art, inspirowany Polską rzeczywistością lat 90., ale z lekką nutą groteski i przerysowania. Nie dążymy do hiperrealizmy - świat jest uproszczony, z wyraźnymi konturami i czytelnymi postaciami.

#### Koncepty

[Konduktor na stacji, Filip Łątka, 2024.](Assets/Sprites/start_screen_temporary.png)

*[TODO: do przygotowania więcej concept artów].*

### 5.2. 2D, 2.5D, 3D

Gra korzysta wyłącznie z grafiki 2D. Jedyna rzecz 2.5D, czy 3D nawet to wyżej wspomniany start screen Filipa. Stworzony został w Blenderze, z nałożonym efektem pixelizacji.

### 5.3. Decyzje stylistyczne (Pixel Art np.)

- **Styl graficzny:** Uproszczony, stylizowany **pixel art** – brak dążenia do realizmu, nacisk na czytelność i ekspresję postaci.
- **Rozdzielczość:** Assety graficzne staramy się tworzyć i exportować na płótnie do nich przystosowanym, bez zbędnego pustego miejsca. Rozmiar samego exportu to [100%]
- **Animacje:** Ręcznie animowane, z ograniczoną liczbą klatek
- **Ograniczona paleta kolorów:** [*Waldgeist Palette*, od Acid Burritos](../Assets/waldgeist.gpl)
- **Postacie:** Wyraźne kontury, przerysowane cechy (np. wąsy, okulary, charakterystyczne fryzury), łatwo rozpoznawalne archetypy społeczne
- **Środowisko:** Minimalistyczne tła, ale z detalami budującymi klimat epoki (plakaty, graffiti, stare reklamy, ślady zużycia)
- **Efekty specjalne:** Proste efekty świetlne (np. światło lampy, refleksy na szybach)
- **UI:** Interfejs diegetyczny, stylizowany na elementy z epoki (np. stare bilety, notesy, tablice informacyjne)

| **Komentarz deweloperski** |
| :------ |
| *Pixel art pozwala nam na frywolne tworzenie assetów, bez większego martwienia się o spójność stylu graficznego. Poza tym jest przystępny i przyjemny w tworzeniu!* |

### 5.4. Arty postaci, przedmioty oraz design poziomów

*[DO UZUPEŁNIENIA]*

### 5.5. Kształty, kolory, nastrój, tekstury

*[DO UZUPEŁNIENIA]*

### 5.6. Motywy wizualne

*[DO UZUPEŁNIENIA]*

### 5.7. Ton oraz ekspresja

*[DO UZUPEŁNIENIA]*

### 5.8. Muzyka

#### 5.8.1. SD

*[DO UZUPEŁNIENIA]*

#### 5.8.2. SFX

*[DO UZUPEŁNIENIA]*

#### 5.8.3. Dubbing

*[DO UZUPEŁNIENIA]*

#### 5.8.4. Inspiracje

*[DO UZUPEŁNIENIA]*

#### 5.8.5. Uniwersalne wskazówki co do muzyki

*[DO UZUPEŁNIENIA]*

---

## 6. UI / UX

### 6.1. Player Experience

*[DO UZUPEŁNIENIA]*

### 6.2. UX/UI

*[DO UZUPEŁNIENIA]*

### 6.3. Przyciski i kontrolki

*[DO UZUPEŁNIENIA]*

### 6.4. Menu

*[DO UZUPEŁNIENIA]*

### 6.5. HUD

*[DO UZUPEŁNIENIA]*

### 6.6. Dostępność

*[DO UZUPEŁNIENIA]*

### 6.7. Elementy uczące

*[DO UZUPEŁNIENIA]*

### 6.8. Easter eggi

*[DO UZUPEŁNIENIA]*

---

## 7. Pozostałe

### 7.1. Trendy w kulturze

*[DO UZUPEŁNIENIA]*

### 7.2. Trendy w technologiach

*[DO UZUPEŁNIENIA]*

### 7.3. Social media

*[DO UZUPEŁNIENIA]*

### 7.4. Exporty

*[DO UZUPEŁNIENIA]*

### 7.5. Multiplayer

*[DO UZUPEŁNIENIA]*

### 7.6. Mobile

*[DO UZUPEŁNIENIA]*

### 7.7. VR

*[DO UZUPEŁNIENIA]*

### 7.8. Streaming

*[DO UZUPEŁNIENIA]*

---

### Koniec dokumentu

*Game Design Document - Bilet na Wschód*  
*Wersja 2.0 - 2025*  
*Zespół: Platform Ten! (dawniej: Konduktorzy)*

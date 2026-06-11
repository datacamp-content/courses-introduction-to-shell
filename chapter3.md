---
title: Łączenie narzędzi
description: >-
  Prawdziwa siła powłoki Unix tkwi nie w pojedynczych poleceniach, lecz w tym,
  jak łatwo można je ze sobą łączyć, tworząc nowe możliwości. Ten rozdział
  pokaże ci, jak wykorzystać tę moc do wybierania potrzebnych danych, oraz
  przedstawi polecenia do sortowania wartości i usuwania duplikatów.
lessons:
  - nb_of_exercises: 12
    title: Jak zapisać wynik polecenia do pliku?
---

## Jak zapisać wynik polecenia do pliku?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Wszystkie dotychczas poznane narzędzia pozwalają podawać nazwy plików wejściowych.
Większość z nich nie oferuje opcji określenia pliku wyjściowego – po prostu nie jest im to potrzebne.
Zamiast tego możesz użyć **przekierowania**, aby zapisać wynik dowolnego polecenia dokładnie tam, gdzie chcesz.
Jeśli uruchomisz to polecenie:

```{shell}
head -n 5 seasonal/summer.csv
```

na ekranie pojawi się pierwszych 5 linii danych z pliku summer.
Jeśli natomiast uruchomisz to polecenie:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

na ekranie nic się nie pojawi.
Zamiast tego wynik działania `head` zostanie zapisany do nowego pliku o nazwie `top.csv`.
Zawartość tego pliku możesz podejrzeć za pomocą `cat`:

```{shell}
cat top.csv
```

Znak większości `>` informuje powłokę, że wynik polecenia `head` ma zostać przekierowany do pliku.
Nie jest on częścią polecenia `head` –
działa z każdym poleceniem powłoki, które generuje jakiś wynik.

`@instructions`
Połącz `tail` z przekierowaniem, aby zapisać ostatnie 5 linii pliku `seasonal/winter.csv` do pliku o nazwie `last.csv`.

`@hint`
Użyj `tail -n 5`, aby pobrać ostatnie 5 linii.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "Linia `%s` powinna znajdować się w pliku `last.csv`, ale jej tam nie ma. Przekieruj wynik polecenia `tail -n 5 seasonal/winter.csv` do pliku `last.csv` za pomocą `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` zawiera zbyt wiele linii. Czy użyto flagi `-n 5` z poleceniem `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Świetnie! Poćwiczmy jeszcze trochę!")
```

---

## Jak użyć wyniku polecenia jako danych wejściowych?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Załóżmy, że chcesz pobrać linie ze środka pliku.
Dokładniej – chcesz pobrać linie od 3. do 5. z jednego z naszych plików z danymi.
Możesz zacząć od użycia `head`, aby pobrać pierwsze 5 linii
i przekierować je do pliku,
a następnie użyć `tail`, aby wybrać ostatnie 3:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Szybka weryfikacja potwierdza, że są to linie 3–5 oryginalnego pliku,
ponieważ stanowią ostatnie 3 linie spośród pierwszych 5.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 35bbb5520e
xp: 50
```

`@instructions`
Wybierz dwie ostatnie linie z pliku `seasonal/winter.csv`
i zapisz je w pliku o nazwie `bottom.csv`.

`@hint`
Użyj `tail`, aby wybrać linie, i `>`, aby przekierować wynik działania `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="Linia `%s` powinna znajdować się w pliku `bottom.csv`, ale jej tam nie ma. Przekieruj wynik polecenia `tail -n 2 seasonal/winter.csv` do pliku `bottom.csv` za pomocą `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` zawiera zbyt wiele linii. Czy użyto flagi `-n 2` z poleceniem `tail`?'),
        has_code('2017-08-11,wisdom', incorrect_msg=patt%"2017-08-11,wisdom"),
        has_code('2017-08-13,canine', incorrect_msg=patt%"2017-08-13,canine")
    )
)
```

***

```yaml
type: ConsoleExercise
key: c94d3936a7
xp: 50
```

`@instructions`
Wybierz pierwszą linię z pliku `bottom.csv`,
aby uzyskać przedostatnią linię oryginalnego pliku.

`@hint`
Użyj `head`, aby wybrać interesującą cię linię.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Coś jest nie tak z plikiem `bottom.csv`. Proszę upewnić się, że nie został on zmieniony!"),
    has_expr_output(strict=True, incorrect_msg="Czy użyto polecenia `head` poprawnie na pliku `bottom.csv`? Proszę upewnić się, że flaga `-n` jest użyta poprawnie.")
)

Ex().success_msg("Brawo. Proszę przejść do następnego ćwiczenia, aby dowiedzieć się o lepszych sposobach łączenia poleceń.")
```

---

## Jak lepiej łączyć polecenia?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Łączenie poleceń za pomocą przekierowania ma dwie wady:

1. Pozostawia wiele plików pośrednich (takich jak `top.csv`).
2. Polecenia prowadzące do końcowego wyniku są rozproszone po wielu wierszach historii.

Shell oferuje inne narzędzie, które rozwiązuje oba te problemy naraz – **potok** (ang. *pipe*).
Zacznij ponownie od uruchomienia `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

Zamiast zapisywać wynik `head` do pliku,
dodaj pionową kreskę i polecenie `tail` *bez* podawania nazwy pliku:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Symbol potoku nakazuje powłoce użyć wyniku polecenia po lewej stronie jako danych wejściowych dla polecenia po prawej.

`@instructions`
Za pomocą `cut` wybierz wszystkie nazwy zębów z kolumny 2 pliku `seasonal/summer.csv` (z separatorem przecinkowym), a następnie przekaż wynik potokiem do `grep` z odwróconym dopasowaniem, aby wykluczyć wiersz nagłówka zawierający słowo "Tooth". *Polecenia `cut` i `grep` zostały szczegółowo omówione w rozdziale 2, odpowiednio w ćwiczeniach 8 i 11.*

`@hint`
- Pierwsza część polecenia ma postać `cut -d separator_pól -f numer_kolumny nazwa_pliku`.
- Druga część polecenia ma postać `grep -v szukana_wartość`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg = 'Czy przekazałeś wynik polecenia `cut -d , -f 2 seasonal/summer.csv` do `grep -v Tooth` za pomocą `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Czy wykluczyłeś nagłówek `"Tooth"` za pomocą `grep`?')
)
Ex().success_msg("Doskonałe użycie potoku! To może być pierwszy raz, gdy użył Pan `|`, ale z pewnością nie ostatni!")
```

---

## Jak łączyć wiele poleceń?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Możesz łączyć ze sobą dowolną liczbę poleceń.
Na przykład
poniższe polecenie:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

wykonuje kolejno trzy operacje:

1. wybiera pierwszą kolumnę z danych wiosennych;
2. usuwa wiersz nagłówka zawierający słowo "Date";
3. wybiera pierwszych 10 wierszy z właściwymi danymi.

`@instructions`
W poprzednim ćwiczeniu użyto poniższego polecenia, aby wybrać wszystkie nazwy zębów z kolumny 2 pliku `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Rozszerz ten potok o polecenie `head`, tak aby wybrać tylko pierwszą nazwę zęba.

`@hint`
Skopiuj i wklej kod z instrukcji, dodaj potok, a następnie wywołaj `head` z flagą `-n`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth | head -n 1
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    # for some reason has_expr_output with strict=True does not work here...
    has_output('^\s*canine\s*$', incorrect_msg = "Czy użył/a Pan/Pani `|` do rozszerzenia potoku o polecenie `head`? Proszę upewnić się, że flaga `-n` jest ustawiona poprawnie."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Czy użył/a Pan/Pani `|` do rozszerzenia potoku o polecenie `head`?")
)
Ex().success_msg("Wspaniałe łączenie! Łącząc kilka poleceń razem, można tworzyć zaawansowane potoki do przetwarzania danych.")
```

---

## Jak zliczać rekordy w pliku?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Polecenie `wc` (skrót od „word count") wyświetla liczbę **z**naków, **s**łów i **w**ierszy w pliku.
Możesz sprawić, żeby wypisywało tylko jedną z tych wartości – używając odpowiednio flag `-c`, `-w` lub `-l`.

`@instructions`
Policz, ile rekordów w pliku `seasonal/spring.csv` ma daty z lipca 2017 roku (`2017-07`).
- Użyj polecenia `grep` z częścią daty, żeby wybrać odpowiednie wiersze, a następnie przekaż wynik potokiem do `wc` z odpowiednią flagą, aby zliczyć wiersze.

`@hint`
- Użyj `head seasonal/spring.csv`, żeby przypomnieć sobie format daty.
- Pierwsza część polecenia ma postać `grep thing_to_match filename`.
- Po potoku, `|`, wywołaj `wc` z flagą `-l`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
grep 2017-07 seasonal/spring.csv | wc -l
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("grep", incorrect_msg = "Czy wywołano `grep`?"),
      has_code("2017-07", incorrect_msg = "Czy wyszukano `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Czy przeszukano plik `seasonal/spring.csv`?"),
      has_code("|", incorrect_msg = "Czy przekierowano dane do `wc` za pomocą `|`?"),      
      has_code("wc", incorrect_msg = "Czy wywołano `wc`?"),
      has_code("-l", incorrect_msg = "Czy policzono wiersze za pomocą `-l`?")
    )
  )
)
Ex().success_msg("Staranne liczenie! Określenie ilości posiadanych danych to świetny pierwszy krok w każdej analizie danych.")
```

---

## Jak wskazać wiele plików jednocześnie?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

Większość poleceń powłoki działa na wielu plikach, jeśli podasz kilka nazw plików.
Na przykład
pierwszą kolumnę ze wszystkich sezonowych plików danych możesz pobrać za jednym razem:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Wpisywanie nazw wielu plików w kółko to jednak zły pomysł:
traci się na tym czas,
a prędzej czy później któryś plik zostanie pominięty albo powtórzony.
Aby ułatwić sobie pracę,
powłoka pozwala używać **symboli wieloznacznych** do wskazywania listy plików za pomocą jednego wyrażenia.
Najczęściej stosowanym symbolem wieloznacznym jest `*`,
który oznacza „dopasuj zero lub więcej znaków".
Dzięki niemu powyższe polecenie `cut` można skrócić do:

```{shell}
cut -d , -f 1 seasonal/*
```

lub:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Napisz pojedyncze polecenie używając `head`, które pobierze pierwsze trzy linie z plików `seasonal/spring.csv` i `seasonal/summer.csv` – łącznie sześć wierszy danych – *bez* uwzględniania plików z danymi jesiennymi i zimowymi.
Zamiast wpisywać pełne nazwy plików, użyj symbolu wieloznacznego.

`@hint`
- Polecenie ma postać `head -n liczba_linii wzorzec_nazwy_pliku`.
- Pliki w katalogu `a`, których nazwy zaczynają się od `b`, możesz dopasować na przykład wzorcem `a/b*`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
head -n 3 seasonal/s* # ...or seasonal/s*.csv, or even s*/s*.csv
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg = "Można użyć `seasonal/s*`, aby wybrać `seasonal/spring.csv` i `seasonal/summer.csv`. Proszę upewnić się, że uwzględnione są tylko pierwsze trzy linie każdego pliku za pomocą flagi `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Proszę nie uwzględniać danych wyjściowych dla `seasonal/autumn.csv`. Można użyć `seasonal/s*`, aby wybrać `seasonal/spring.csv` i `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Proszę nie uwzględniać danych wyjściowych dla `seasonal/winter.csv`. Można użyć `seasonal/s*`, aby wybrać `seasonal/spring.csv` i `seasonal/summer.csv`")
)
Ex().success_msg("Świetna praca z symbolami wieloznacznymi! Staje się to jeszcze ważniejsze, gdy katalog zawiera setki lub tysiące plików.")
```

---

## Jakich innych symboli wieloznacznych można używać?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Powłoka udostępnia również inne symbole wieloznaczne, choć są one rzadziej stosowane:

- `?` dopasowuje pojedynczy znak, więc `201?.txt` pasuje do `2017.txt` lub `2018.txt`, ale nie do `2017-01.txt`.
- `[...]` dopasowuje dowolny jeden znak spośród podanych w nawiasach kwadratowych, więc `201[78].txt` pasuje do `2017.txt` lub `2018.txt`, ale nie do `2016.txt`.
- `{...}` dopasowuje dowolny z wzorców oddzielonych przecinkami w nawiasach klamrowych, więc `{*.txt, *.csv}` pasuje do każdego pliku, którego nazwa kończy się na `.txt` lub `.csv`, ale nie do plików z rozszerzeniem `.pdf`.

<hr/>

Które wyrażenie pasuje do `singh.pdf` i `johel.txt`, ale *nie* do `sandhu.pdf` ani `sandhu.txt`?

`@hint`
Sprawdź każde wyrażenie dla każdej nazwy pliku po kolei.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Nie: `.pdf` i `.txt` to nie są nazwy plików.
- Nie: to wyrażenie dopasuje `sandhu.pdf`.
- Nie: wyrażenie w nawiasach kwadratowych dopasowuje tylko jeden znak, a nie całe słowa.
- Prawidłowo!

---

## Jak sortować wiersze tekstu?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Jak sama nazwa wskazuje,
`sort` porządkuje dane.
Domyślnie sortuje je w rosnącej kolejności alfabetycznej,
ale flagi `-n` i `-r` pozwalają sortować numerycznie i odwracać kolejność wyników,
flaga `-b` ignoruje wiodące spacje,
a `-f` powoduje **f**oldowanie wielkości liter (czyli wyszukiwanie bez rozróżniania wielkości liter).
Potoki często używają `grep` do odfiltrowania niechcianych rekordów,
a następnie `sort` do uporządkowania pozostałych.

`@instructions`
Pamiętasz kombinację `cut` i `grep`, która pozwala wybrać wszystkie nazwy zębów z kolumny 2 pliku `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Wychodząc od tego polecenia, posortuj nazwy zębów z pliku `seasonal/winter.csv` (nie `summer.csv`) w malejącej kolejności alfabetycznej. W tym celu rozszerz potok o krok `sort`.

`@hint`
Skopiuj i wklej polecenie z instrukcji, zmień nazwę pliku, dodaj potok, a następnie wywołaj `sort` z flagą `-r`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth | sort -r
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("cut", incorrect_msg = "Czy wywołano `cut`?"),
      has_code("-d", incorrect_msg = "Czy określono separator pól za pomocą `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Czy pobrano dane z pliku `seasonal/winter.csv`?"),
      has_code("|", incorrect_msg = "Czy przekierowano dane z `cut` do `grep` i `sort` za pomocą `|`?"),      
      has_code("grep", incorrect_msg = "Czy wywołano `grep`?"),
      has_code("-v", incorrect_msg = "Czy odwrócono dopasowanie za pomocą `-v`?"),
      has_code("Tooth", incorrect_msg = "Czy wyszukano `Tooth`?"),
      has_code("sort", incorrect_msg = "Czy wywołano `sort`?"),
      has_code("-r", incorrect_msg = "Czy odwrócono kolejność sortowania za pomocą `-r`?")
    )
  )
)
Ex().success_msg("Posortowano! Polecenie `sort` ma wiele zastosowań. Na przykład przekierowanie `sort -n` do `head` pokazuje największe wartości.")
```

---

## Jak usunąć zduplikowane wiersze?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Kolejnym poleceniem często używanym razem z `sort` jest `uniq`,
którego zadaniem jest usuwanie zduplikowanych wierszy.
Dokładniej rzecz ujmując,
usuwa ono *sąsiadujące* zduplikowane wiersze.
Jeśli plik zawiera:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

to `uniq` zwróci:

```
2017-07-03
2017-08-03
```

ale jeśli zawiera:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

to `uniq` wypisze wszystkie cztery wiersze.
Dzieje się tak, ponieważ `uniq` zostało zaprojektowane do pracy z bardzo dużymi plikami.
Aby usunąć niesąsiadujące duplikaty,
polecenie musiałoby przechowywać cały plik w pamięci
(albo przynajmniej wszystkie napotkane dotąd unikalne wiersze).
Usuwając tylko sąsiadujące duplikaty,
wystarczy mu trzymać w pamięci jedynie ostatnio napotkany unikalny wiersz.

`@instructions`
Zbuduj potok, który:

- pobierze drugą kolumnę z pliku `seasonal/winter.csv`,
- usunie słowo „Tooth" z wyników, tak aby wyświetlały się tylko nazwy zębów,
- posortuje wyniki, aby wszystkie wystąpienia danej nazwy zęba znalazły się obok siebie,
- wyświetli każdą nazwę zęba dokładnie raz wraz z liczbą jej wystąpień.

Początek potoku jest taki sam jak w poprzednim ćwiczeniu:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Rozbuduj go o polecenie `sort`, a następnie użyj `uniq -c`, aby wyświetlić unikalne wiersze wraz z liczbą ich wystąpień – zamiast korzystać osobno z `uniq` i `wc`.

`@hint`
Skopiuj i wklej polecenie z instrukcji, przekieruj potok do `sort` bez flag, a następnie ponownie do `uniq` z flagą `-c`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth | sort | uniq -c
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_correct(
        has_expr_output(),
        multi(
            has_code('cut\s+-d\s+,\s+-f\s+2\s+seasonal/winter.csv\s+\|\s+grep\s+-v\s+Tooth',
                     incorrect_msg="Należy zacząć od tego polecenia: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Teraz proszę je rozszerzyć!"),
            has_code('\|\s+sort', incorrect_msg="Czy polecenie zostało rozszerzone o `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="Czy polecenie zostało rozszerzone o `| uniq`?"),
            has_code('-c', incorrect_msg="Czy uwzględniono liczniki za pomocą `-c`?")
        )
    )
)
Ex().success_msg("Świetnie! Po całej tej pracy z potokiem, przydałoby się móc zapisać wynik, prawda?")
```

---

## Jak zapisać wynik działania potoku?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Powłoka pozwala przekierować wyniki sekwencji poleceń połączonych potokiem:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Znak `>` musi jednak pojawić się na końcu potoku.
Jeśli spróbujesz użyć go w środku, tak jak tutaj:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

to cały wynik polecenia `cut` zostanie zapisany do pliku `teeth-only.txt`,
przez co dla `grep` nie pozostaje już żadnych danych
i będzie on czekał w nieskończoność na dane wejściowe.

<hr>

Co się stanie, jeśli umieścisz przekierowanie na początku potoku, tak jak poniżej:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [Wynik polecenia zostaje przekierowany do pliku jak zwykle.]
- Powłoka zgłasza błąd.
- Powłoka czeka w nieskończoność na dane wejściowe.

`@hint`
Wypróbuj to w powłoce.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Poprawnie!', 'Nie; powłoka może to faktycznie wykonać.', 'Nie; powłoka może to faktycznie wykonać.'])
```

---

## Jak zatrzymać działający program?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Wszystkie polecenia i skrypty, które do tej pory uruchamiałeś, wykonywały się szybko,
ale niektóre zadania mogą trwać minuty, godziny, a nawet dni.
Zdarza się też, że przez pomyłkę umieścisz przekierowanie w środku potoku,
co spowoduje zawieszenie programu.
Jeśli chcesz przerwać działanie programu,
wpisz `Ctrl` + `C`, aby go zakończyć.
W dokumentacji uniksowej jest to często zapisywane jako `^C`;
zwróć uwagę, że litera 'c' może być mała.

`@instructions`
Uruchom polecenie:

```{shell}
head
```

bez żadnych argumentów (tak żeby czekało na dane, które nigdy nie nadejdą),
a następnie zatrzymaj je, wpisując `Ctrl` + `C`.

`@hint`
Wpisz head, naciśnij Enter i zakończ działający program kombinacją `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Czy użył(a) Pan(i) `head`?")
```

---

## Podsumowanie

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Na zakończenie zbudujesz potok, który sprawdzi, ile rekordów zawiera najkrótszy z sezonowych plików danych.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: b1f9c8ff84
xp: 35
```

`@instructions`
Użyj polecenia `wc` z odpowiednimi parametrami, aby wyświetlić liczbę wierszy we wszystkich sezonowych plikach danych.
(Zamiast wpisywać nazwy plików ręcznie, użyj wieloznacznika.)

`@hint`
Użyj flagi `-l`, aby wyświetlić tylko liczbę wierszy, i znaku `*`, aby dopasować nazwy plików.

`@solution`
```{shell}
wc -l seasonal/*.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("wc", incorrect_msg = "Czy wywołano `wc`?"),
      has_code("-l", incorrect_msg = "Czy policzono liczbę wierszy za pomocą `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Czy pobrano dane ze wszystkich plików `seasonal/*`?")
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: 7f94acc679
xp: 35
```

`@instructions`
Dodaj kolejne polecenie do poprzedniego za pomocą potoku, aby usunąć wiersz zawierający słowo „total".

`@hint`


`@solution`
```{shell}
wc -l seasonal/*.csv | grep -v total

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("wc", incorrect_msg = "Czy wywołano `wc`?"),
      has_code("-l", incorrect_msg = "Czy policzono liczbę linii za pomocą `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Czy pobrano dane ze wszystkich plików `seasonal/*`?"),
      has_code("|", incorrect_msg = "Czy przekierowano dane z `wc` do `grep` za pomocą `|`?"),      
      has_code("grep", incorrect_msg = "Czy wywołano `grep`?"),
      has_code("-v", incorrect_msg = "Czy odwrócono dopasowanie za pomocą `-v`?"),
      has_code("total", incorrect_msg = "Czy wyszukano wyrażenia `total`?")
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: c5f55bff6b
xp: 30
```

`@instructions`
Dodaj do potoku dwa kolejne etapy, używając `sort -n` i `head -n 1`, aby znaleźć plik z najmniejszą liczbą wierszy.

`@hint`
- Użyj flagi `-n` polecenia `sort`, aby sortować numerycznie.
- Użyj flagi `-n` polecenia `head`, aby ograniczyć wynik do 1 wiersza.

`@solution`
```{shell}
wc -l seasonal/*.csv | grep -v total | sort -n | head -n 1

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("wc", incorrect_msg = "Czy wywołano `wc`?"),
      has_code("-l", incorrect_msg = "Czy policzono liczbę wierszy za pomocą `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Czy pobrano dane ze wszystkich plików `seasonal/*`?"),
      has_code("|", incorrect_msg = "Czy użyto potoku z `wc` do `grep`, do `sort`, do `head` za pomocą `|`?"),      
      has_code("grep", incorrect_msg = "Czy wywołano `grep`?"),
      has_code("-v", incorrect_msg = "Czy odwrócono dopasowanie za pomocą `-v`?"),
      has_code("total", incorrect_msg = "Czy wyszukano `total`?"),
      has_code("sort", incorrect_msg = "Czy wywołano `sort`?"),
      has_code("-n", incorrect_msg = "Czy określono liczbę wierszy do zachowania za pomocą `-n`?"),
      has_code("1", incorrect_msg = "Czy określono 1 wiersz do zachowania za pomocą `-n 1`?")
    )
  )
)
Ex().success_msg("Świetnie! Okazuje się, że `autumn.csv` to plik z najmniejszą liczbą wierszy. Przejdź do rozdziału 4, aby dowiedzieć się więcej o przetwarzaniu wsadowym!")
```

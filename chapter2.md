---
title: Praca z danymi
description: >-
  Polecenia poznane w poprzednim rozdziale pozwalały przemieszczać elementy w
  systemie plików. Ten rozdział pokaże ci, jak pracować z danymi zawartymi w
  plikach. Narzędzia, których będziesz używać, są stosunkowo proste, ale
  stanowią solidne fundamenty.
lessons:
  - nb_of_exercises: 12
    title: Jak wyświetlić zawartość pliku?
---

## Jak wyświetlić zawartość pliku?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Zanim zmienisz nazwę pliku lub go usuniesz,
warto najpierw sprawdzić jego zawartość.
Najprostszym sposobem jest polecenie `cat`,
które wyświetla zawartość plików bezpośrednio na ekranie.
(Nazwa pochodzi od słowa „concatenate", czyli „łączyć",
ponieważ polecenie wypisuje kolejno wszystkie podane pliki, jeden po drugim.)

```{shell}
cat agarwal.txt
```
```
name: Agarwal, Jasmine
position: RCT2
start: 2017-04-01
benefits: full
```

`@instructions`
Wyświetl zawartość pliku `course.txt` na ekranie.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
cat course.txt
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Twoje polecenie nie wygenerowało właściwego wyniku. Czy użyto `cat` wraz z nazwą pliku `course.txt`?")
)
Ex().success_msg("Świetnie! Przyjrzyjmy się innym sposobom wyświetlania zawartości pliku.")
```

---

## Jak wyświetlać zawartość pliku stopniowo?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Możesz użyć `cat`, żeby wyświetlić duży plik, a następnie przewijać wyniki,
ale zwykle wygodniej jest **stronicować** wyniki.
Pierwotne polecenie do tego celu nazywało się `more`,
ale zastąpiło je potężniejsze polecenie `less`.
(Taki właśnie humor panuje w świecie Uniksa.)
Kiedy otworzysz plik przez `less`,
wyświetlana jest jedna strona na raz;
możesz nacisnąć spację, żeby przejść do następnej strony, lub wpisać `q`, żeby wyjść.

Jeśli podasz poleceniu `less` nazwy kilku plików,
możesz wpisać `:n` (dwukropek i małą literę 'n'), żeby przejść do następnego pliku,
`:p`, żeby wrócić do poprzedniego,
lub `:q`, żeby wyjść.

Uwaga: jeśli wyświetlisz rozwiązania ćwiczeń używających `less`,
zobaczysz na końcu dodatkowe polecenie, które wyłącza stronicowanie,
dzięki czemu możemy sprawnie testować twoje rozwiązania.

`@instructions`
Użyj polecenia `less seasonal/spring.csv seasonal/summer.csv`, żeby wyświetlić te dwa pliki w podanej kolejności.
Naciśnij spację, żeby przejść do następnej strony, `:n`, żeby przejść do drugiego pliku, i `:q`, żeby wyjść.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
# You can leave out the '| cat' part here:
less seasonal/spring.csv seasonal/summer.csv | cat
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_or(
        has_code(r'\s*less\s+seasonal/spring\.csv\s+seasonal/summer\.csv\s*',
                 incorrect_msg='Użyj `less` i nazw plików. Pamiętaj, że `:n` przenosi do następnego pliku.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Jak wyświetlić początek pliku?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Gdy analityk danych otrzymuje nowy zbiór danych do analizy, zazwyczaj zaczyna od sprawdzenia, jakie pola zawiera i jakie wartości się w nich znajdują. Jeśli zbiór danych został wyeksportowany z bazy danych lub arkusza kalkulacyjnego, często jest zapisany w formacie **wartości rozdzielanych przecinkami** (CSV). Szybkim sposobem na zorientowanie się w jego zawartości jest podejrzenie pierwszych kilku wierszy.

Można to zrobić w powłoce za pomocą polecenia `head`.
Jak sugeruje nazwa,
wyświetla ono pierwsze kilka wierszy pliku
(gdzie „kilka" oznacza 10),
a więc polecenie:

```{shell}
head seasonal/summer.csv
```

wyświetla:

```
Date,Tooth
2017-01-11,canine
2017-01-18,wisdom
2017-01-21,bicuspid
2017-02-02,molar
2017-02-27,wisdom
2017-02-27,wisdom
2017-03-07,bicuspid
2017-03-15,wisdom
2017-03-20,canine
```

<hr>

Co zrobi `head`, jeśli plik zawiera mniej niż 10 wierszy?
(Sprawdź to, używając tego polecenia na pliku `people/agarwal.txt`.)

`@possible_answers`
- Wyświetla komunikat o błędzie, bo plik jest za krótki.
- Wyświetla tyle wierszy, ile jest w pliku.
- Uzupełnia wynik pustymi wierszami, aby łącznie było ich 10.

`@hint`
Co byłoby w takiej sytuacji najbardziej przydatne?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Nieprawidłowo: to nie jest najbardziej użyteczna rzecz, którą mógłby zrobić.",
                    "Poprawnie!",
                    "Nieprawidłowo: byłoby to niemożliwe do odróżnienia od pliku, który kończył się wieloma pustymi wierszami."])
```

---

## Jak pisać mniej?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Jednym z przydatnych narzędzi powłoki jest **uzupełnianie tabulatorem**.
Jeśli zaczniesz wpisywać nazwę pliku i naciśniesz klawisz Tab,
powłoka spróbuje automatycznie uzupełnić ścieżkę.
Na przykład,
jeśli wpiszesz `sea` i naciśniesz Tab,
powłoka uzupełni nazwę katalogu do `seasonal/` (wraz z ukośnikiem na końcu).
Jeśli następnie wpiszesz `a` i naciśniesz Tab,
ścieżka zostanie uzupełniona do `seasonal/autumn.csv`.

Jeśli ścieżka jest niejednoznaczna,
np. `seasonal/s`,
ponowne naciśnięcie Tab wyświetli listę możliwości.
Wpisz jeszcze jeden lub dwa znaki, aby doprecyzować ścieżkę,
a następnie naciśnij Tab –
powłoka uzupełni resztę nazwy.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 4e30296c27
xp: 50
```

`@instructions`
Uruchom `head seasonal/autumn.csv` bez wpisywania pełnej nazwy pliku.

`@hint`
Wpisz tyle znaków ścieżki, ile potrzebujesz, naciśnij Tab i powtarzaj tę czynność.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Weryfikator nie znalazł właściwego wyniku w Pana/Pani poleceniu. Czy na pewno wywołał(a) Pan/Pani `head` na `seasonal/autumn.csv`?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Uruchom `head seasonal/spring.csv` bez wpisywania pełnej nazwy pliku.

`@hint`
Wpisz tyle znaków ścieżki, ile potrzebujesz, naciśnij Tab i powtarzaj tę czynność.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Weryfikator nie znalazł właściwego wyniku w Pana/Pani poleceniu. Czy na pewno wywołał(a) Pan/Pani `head` na `seasonal/spring.csv`?")
)
Ex().success_msg("Dobra robota! Gdy przyzwyczai się Pan/Pani do używania uzupełniania tabulatorem, zaoszczędzi to wiele czasu!")
```

---

## Jak sterować zachowaniem poleceń?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Nie zawsze będziesz chcieć wyświetlać pierwsze 10 wierszy pliku.
Shell pozwala zmieniać zachowanie `head`
przez podanie **flagi wiersza poleceń** (w skrócie: „flagi").
Jeśli uruchomisz polecenie:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` wyświetli tylko trzy pierwsze wiersze pliku.
Jeśli uruchomisz `head -n 100`,
wyświetli pierwszych 100 wierszy (o ile tyle istnieje)
– i tak dalej.

Nazwa flagi zazwyczaj wskazuje jej przeznaczenie
(na przykład `-n` sygnalizuje „**n**umber of lines", czyli liczbę wierszy).
Flagi poleceń nie muszą składać się z `-` i pojedynczej litery,
ale taka konwencja jest powszechnie stosowana.

Uwaga: dobrą praktyką jest umieszczanie wszystkich flag *przed* nazwami plików.
W tym kursie akceptujemy tylko odpowiedzi zgodne z tą zasadą.

`@instructions`
Wyświetl 5 pierwszych wierszy pliku `winter.csv` z katalogu `seasonal`.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
head -n 5 seasonal/winter.csv
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_correct(
        has_expr_output(incorrect_msg="Czy na pewno wywołujesz `head` na pliku `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Czy na pewno użyto flagi `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Czy na pewno użyto flagi `-n 5`?")
)
Ex().success_msg("Świetnie! Dzięki tej technice można uniknąć przeciążenia powłoki, gdy chce się przejrzeć większe pliki tekstowe.")
```

---

## Jak wyświetlić zawartość całego drzewa katalogów?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Aby zobaczyć wszystko, co znajduje się w danym katalogu – niezależnie od głębokości zagnieżdżenia – możesz przekazać poleceniu `ls` flagę `-R` (od angielskiego *recursive*, czyli „rekurencyjnie").
Jeśli uruchomisz `ls -R` w swoim katalogu domowym, zobaczysz wynik podobny do poniższego:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Wynik pokazuje najpierw wszystkie pliki i katalogi na bieżącym poziomie, a następnie zawartość każdego podkatalogu – i tak dalej, wgłąb całej struktury.

`@instructions`
Aby łatwiej odróżnić pliki od katalogów, `ls` oferuje dodatkową flagę `-F`: wyświetla `/` po nazwie każdego katalogu oraz `*` po nazwie każdego programu, który można uruchomić.
Uruchom `ls` z dwiema flagami – `-R` i `-F` – oraz ze ścieżką bezwzględną do swojego katalogu domowego, aby zobaczyć całą jego zawartość.
(Kolejność flag nie ma znaczenia, ale nazwa katalogu musi pojawić się na końcu.)

`@hint`
Katalog domowy możesz wskazać, używając `~`, `.` lub jego ścieżki bezwzględnej.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
ls -R -F /home/repl
```

`@sct`
```{python}
Ex().check_or(
  has_expr_output(incorrect_msg='Użyj `ls -R -F` lub `ls -F -R` i ścieżki `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Użyj `ls -R -F` lub `ls -F -R` i ścieżki `/home/repl`.')
)
Ex().success_msg("To całkiem niezłe podsumowanie, prawda?")
```

---

## Jak uzyskać pomoc dotyczącą polecenia?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Aby dowiedzieć się, co robią poszczególne polecenia,
dawniej używano polecenia `man`
(skrót od angielskiego „manual", czyli „podręcznik").
Na przykład
polecenie `man head` wyświetla następujące informacje:

```
HEAD(1)               BSD General Commands Manual              HEAD(1)

NAME
     head -- display first lines of a file

SYNOPSIS
     head [-n count | -c bytes] [file ...]

DESCRIPTION
     This filter displays the first count lines or bytes of each of
     the specified files, or of the standard input if no files are
     specified.  If count is omitted it defaults to 10.

     If more than a single file is specified, each file is preceded by
     a header consisting of the string ``==> XXX <=='' where ``XXX''
     is the name of the file.

SEE ALSO
     tail(1)
```

`man` automatycznie uruchamia `less`,
więc być może trzeba będzie nacisnąć spację, aby przewinąć zawartość,
i `:q`, aby zakończyć.

Jednowierszowy opis w sekcji `NAME` zwięźle wyjaśnia, do czego służy dane polecenie,
a zestawienie w sekcji `SYNOPSIS` zawiera listę wszystkich obsługiwanych flag.
Elementy opcjonalne są ujęte w nawiasy kwadratowe `[...]`,
alternatywy są oddzielone znakiem `|`,
a elementy, które można powtarzać, są oznaczone przez `...`.
Strona podręcznika dla `head` informuje zatem, że można podać *albo* liczbę wierszy za pomocą `-n`,
*albo* liczbę bajtów za pomocą `-c`,
oraz że można przekazać dowolną liczbę nazw plików.

Problem z podręcznikiem Uniksa polega na tym, że trzeba wiedzieć, czego się szuka.
Jeśli nie wiesz, od czego zacząć,
możesz przeszukać [Stack Overflow](https://stackoverflow.com/),
zadać pytanie na kanałach Slack DataCamp
lub zajrzeć do sekcji `SEE ALSO` poleceń, które już znasz.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 52d629048a
xp: 50
```

`@instructions`
Zapoznaj się ze stroną podręcznika polecenia `tail`, aby dowiedzieć się,
co robi znak `+` umieszczony przed liczbą używaną z flagą `-n`.
(Pamiętaj, aby nacisnąć spację w celu przewinięcia strony i/lub wpisać `q`, aby wyjść.)

`@hint`
Pamiętaj: `man` to skrót od angielskiego słowa „manual" (podręcznik).

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Użyj `man` i nazwy polecenia.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Użyj polecenia `tail` z flagą `-n +7`, aby wyświetlić wszystkie wiersze pliku `seasonal/spring.csv` *z wyjątkiem* pierwszych sześciu.

`@hint`
Użyj znaku plus '+' przed liczbą określającą, od którego wiersza mają być wyświetlane dane.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Czy wywołuje Pan/Pani `tail` na `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Czy jest Pan/Pani pewny/pewna, że użył(a) Pan/Pani flagi `-n +7`?")
)
```

---

## Jak wybrać kolumny z pliku?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` i `tail` pozwalają wybierać wiersze z pliku tekstowego.
Jeśli chcesz wybrać kolumny,
możesz użyć polecenia `cut`.
Ma ono kilka opcji (użyj `man cut`, żeby je poznać),
ale najczęściej stosuje się je w podobny sposób:

```{shell}
cut -f 2-5,8 -d , values.csv
```

co oznacza:
„wybierz kolumny od 2 do 5 oraz kolumnę 8,
używając przecinka jako separatora".
`cut` używa flagi `-f` (od ang. *fields*, czyli „pola") do wskazania kolumn
oraz `-d` (od ang. *delimiter*, czyli „separator") do określenia znaku oddzielającego kolumny.
Warto podać separator, ponieważ w różnych plikach kolumny mogą być oddzielane spacjami, tabulatorami lub dwukropkami.

<hr>

Jakie polecenie wybierze pierwszą kolumnę (zawierającą daty) z pliku `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Każde z powyższych.
- Żadne z powyższych, ponieważ `-f` musi pojawić się przed `-d`.

`@hint`
Kolejność flag nie ma znaczenia.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Tak, ale to nie wszystko', 'Tak, ale to nie wszystko', 'Poprawnie! Dodanie spacji po fladze jest dobrym stylem, ale nie jest obowiązkowe.', 'Nie, kolejność flag nie ma znaczenia'])
```

---

## Czego nie potrafi cut?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` to polecenie o ograniczonych możliwościach.
Nie radzi sobie w szczególności z ciągami znaków ujętymi w cudzysłów.
Jeśli na przykład twój plik wygląda tak:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

to polecenie:

```{shell}
cut -f 2 -d , everyone.csv
```

zwróci:

```
Age
Ranjit"
Rupinder"
```

zamiast wieku każdej osoby – ponieważ `cut` potraktuje przecinek między nazwiskiem a imieniem jako separator kolumn.

<hr>

Jaki będzie wynik działania `cut -d : -f 2-4` na wierszu:

```
first:second:third:
```

(Zwróć uwagę na dwukropek na końcu.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Żadna z powyższych, bo nie ma czterech pól.

`@hint`
Zwróć uwagę na dwukropek na końcu.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Nie, jest więcej.', 'Nie, jest więcej.', 'Poprawnie! Końcowy dwukropek tworzy puste czwarte pole.', 'Nie, `cut` robi co może.'])
```

---

## Jak powtarzać polecenia?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Jedną z największych zalet korzystania z powłoki jest to,
że bardzo łatwo możesz powtarzać wcześniej wykonane operacje.
Po uruchomieniu kilku poleceń naciśnij klawisz strzałki w górę,
aby przewijać historię poleceń.
Możesz też użyć strzałek w lewo i w prawo oraz klawisza Delete,
aby edytować wybrane polecenie. Naciśnięcie Enter uruchomi je ponownie.

Jeszcze wygodniejsze jest polecenie `history`, które wyświetla listę ostatnio wykonanych poleceń.
Każde z nich ma przypisany numer porządkowy, co ułatwia ponowne uruchomienie konkretnego polecenia:
wpisz na przykład `!55`, aby powtórzyć polecenie numer 55 z historii (jeśli masz tyle wpisów).
Możesz też ponownie uruchomić polecenie, wpisując wykrzyknik, a po nim jego nazwę,
np. `!head` lub `!cut` – w ten sposób powtórzysz ostatnie użycie danego polecenia.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 188a2fab38
xp: 20
```

`@instructions`
Uruchom `head summer.csv` w swoim katalogu domowym (polecenie powinno zakończyć się błędem).

`@hint`
Uzupełnianie tabulatorem nie zadziała, jeśli nie ma pasującej nazwy pliku.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Użyj `head` i nazwy pliku `summer.csv`. Nie przejmuj się, jeśli to nie zadziała. Tak powinno być.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Przejdź do katalogu `seasonal`.

`@hint`
Pamiętaj, że `cd` to skrót od „change directory" (zmień katalog).

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Jeśli Państwa bieżący katalog roboczy (można to sprawdzić za pomocą `pwd`) to `/home/repl`, można przejść do folderu `seasonal` za pomocą polecenia `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Uruchom ponownie polecenie `head`, używając `!head`.

`@hint`
Nie wstawiaj żadnych spacji między `!` a tym, co po nim następuje.

`@solution`
```{shell}
!head

```

`@sct`
```{python}
# !head is expanded into head summer.csv by the terminal, so manually specify expression
# This won't work for the validator though, so we have to use check_or to satisfy it.
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_or(
        has_expr_output(expr = 'head summer.csv',
                        incorrect_msg='Użyj `!head`, aby powtórzyć polecenie `head`.'),
        has_code('!head')
    )
)
```

***

```yaml
type: ConsoleExercise
key: a28555575a
xp: 20
```

`@instructions`
Użyj `history`, aby przejrzeć historię swoich poleceń.

`@hint`
Zwróć uwagę, że `history` wyświetla ostatnie polecenia na końcu listy, dzięki czemu są widoczne na ekranie po zakończeniu działania.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Użyj `history` bez flag, aby uzyskać listę poprzednich poleceń.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Uruchom `head` ponownie, używając `!` i numeru polecenia z historii.

`@hint`
Nie wstawiaj *żadnych* spacji między `!` a tym, co po nim następuje.

`@solution`
```{shell}
!3

```

`@sct`
```{python}
# !3 is expanded into head summer.csv by the terminal, so manually specify expression
# This won't work for the validator though, so we have to use check_or to satisfy it.
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_or(
        has_expr_output(expr = 'head summer.csv',
                        incorrect_msg='Czy użył(a) Pan(i) `!<a_number>`, aby ponownie uruchomić ostatnie polecenie `head` z historii?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Brawo! Przechodzimy do następnego!")
```

---

## Jak wybrać wiersze zawierające określone wartości?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` i `tail` wybierają wiersze,
`cut` wybiera kolumny,
a `grep` wybiera wiersze na podstawie ich zawartości.
W najprostszej postaci
`grep` przyjmuje fragment tekstu, po którym podajesz jedną lub więcej nazw plików,
i wyświetla wszystkie wiersze z tych plików, które zawierają podany tekst.
Na przykład
`grep bicuspid seasonal/winter.csv`
wyświetla wiersze z pliku `winter.csv` zawierające słowo "bicuspid".

`grep` potrafi też wyszukiwać wzorce –
omówimy to w kolejnym kursie.
Na razie ważniejsze są najczęściej używane flagi `grep`:

- `-c`: wyświetla liczbę pasujących wierszy zamiast ich treści
- `-h`: *nie* wyświetla nazw plików podczas przeszukiwania wielu plików
- `-i`: ignoruje wielkość liter (np. traktuje "Regression" i "regression" jako zgodne)
- `-l`: wyświetla nazwy plików zawierających dopasowania, a nie same dopasowania
- `-n`: wyświetla numery wierszy dla pasujących wyników
- `-v`: odwraca dopasowanie, tzn. pokazuje tylko wiersze, które *nie* pasują

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 0d7ef2baa0
xp: 35
```

`@instructions`
Wyświetl zawartość wszystkich wierszy zawierających słowo `molar` w pliku `seasonal/autumn.csv`,
uruchamiając pojedyncze polecenie ze swojego katalogu domowego. Nie używaj żadnych flag.

`@hint`
Użyj `grep`, podając szukane słowo oraz nazwę pliku (lub plików), w których chcesz przeszukiwać.

`@solution`
```{shell}
grep molar seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("grep", incorrect_msg = "Czy wywołano `grep`?"),
      has_code("molar", incorrect_msg = "Czy wyszukano `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Czy przeszukano plik `seasonal/autumn.csv`?")
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: a0eee34d1e
xp: 35
```

`@instructions`
Odwróć dopasowanie, aby znaleźć wszystkie wiersze, które *nie* zawierają słowa `molar` w pliku `seasonal/spring.csv`, i wyświetl ich numery.
Pamiętaj, że dobrą praktyką jest umieszczanie wszystkich flag *przed* innymi wartościami, takimi jak nazwy plików czy szukany wyraz "molar".

`@hint`


`@solution`
```{shell}
grep -v -n molar seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("grep", incorrect_msg = "Czy wywołano `grep`?"),
      has_code("-v", incorrect_msg = "Czy odwrócono dopasowanie za pomocą `-v`?"),
      has_code("-n", incorrect_msg = "Czy wyświetlono numery wierszy za pomocą `-n`?"),
      has_code("molar", incorrect_msg = "Czy wyszukano frazy `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Czy przeszukano plik `seasonal/spring.csv`?")
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: f5641234fe
xp: 30
```

`@instructions`
Policz, ile wierszy zawiera słowo `incisor` łącznie w plikach `autumn.csv` i `winter.csv`.
(Pamiętaj, żeby uruchomić pojedyncze polecenie ze swojego katalogu domowego.)

`@hint`
Pamiętaj, żeby użyć flagi `-c` z `grep`, aby zliczyć wiersze.

`@solution`
```{shell}
grep -c incisor seasonal/autumn.csv seasonal/winter.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("grep", incorrect_msg = "Czy wywołano `grep`?"),
      has_code("-c", incorrect_msg = "Czy uzyskano liczniki za pomocą `-c`?"),
      has_code("incisor", incorrect_msg = "Czy wyszukano `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Czy przeszukano plik `seasonal/autumn.csv`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Czy przeszukano plik `seasonal/winter.csv`?")
    )
  )
)
```

---

## Dlaczego traktowanie danych jak zwykłego tekstu nie zawsze jest bezpieczne?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

Sekcja `SEE ALSO` strony podręcznika dla polecenia `cut` odsyła do polecenia `paste`,
którego można użyć do łączenia plików z danymi zamiast ich rozcinania.

<hr>

Przeczytaj stronę podręcznika dla `paste`,
a następnie uruchom `paste`, aby połączyć pliki z danymi jesiennymi i zimowymi w jedną tabelę,
używając przecinka jako separatora.
Co jest nie tak z wynikiem z punktu widzenia analizy danych?

`@possible_answers`
- Nagłówki kolumn są powtórzone.
- Kilka ostatnich wierszy ma nieprawidłową liczbę kolumn.
- Część danych z `winter.csv` jest brakująca.

`@hint`
Jeśli użyjesz `cut` na wynikach `paste`, stosując przecinek jako separator,
czy otrzymasz poprawną odpowiedź?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Prawda, ale niekoniecznie jest to błąd.'
correct2 = 'Poprawnie: łączenie wierszy z kolumnami tworzy tylko jedną pustą kolumnę na początku, a nie dwie.'
err3 = 'Nie, wszystkie dane zimowe są tam obecne.'
Ex().has_chosen(2, [err1, correct2, err3])
```

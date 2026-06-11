---
title: Tworzenie nowych narzędzi
description: >-
  Historia poleceń pozwala powtarzać działania za pomocą kilku naciśnięć
  klawiszy, a potoki umożliwiają łączenie istniejących poleceń w nowe. W tym
  rozdziale pójdziesz o krok dalej i nauczysz się tworzyć własne polecenia.
lessons:
  - nb_of_exercises: 9
    title: Jak edytować plik?
---

## Jak edytować plik?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix oferuje zaskakująco wiele edytorów tekstu.
W tym kursie będziemy używać prostego edytora o nazwie Nano.
Jeśli wpiszesz `nano nazwa_pliku`,
edytor otworzy `nazwa_pliku` do edycji
(lub utworzy go, jeśli jeszcze nie istnieje).
Po pliku możesz się poruszać za pomocą klawiszy strzałek,
usuwać znaki klawiszem Backspace
oraz wykonywać inne operacje przy użyciu skrótów klawiaturowych:

- `Ctrl` + `K`: usuń wiersz.
- `Ctrl` + `U`: cofnij usunięcie wiersza.
- `Ctrl` + `O`: zapisz plik (litera „O" pochodzi od angielskiego słowa „output", czyli „dane wyjściowe"). _Następnie naciśnij Enter, aby potwierdzić nazwę pliku!_
- `Ctrl` + `X`: wyjdź z edytora.

`@instructions`
Uruchom `nano names.txt`, aby otworzyć nowy plik w swoim katalogu domowym,
i wprowadź następujące cztery wiersze:

```
Lovelace
Hopper
Johnson
Wilson
```

Aby zapisać wprowadzone zmiany,
wpisz `Ctrl` + `O`, żeby zapisać plik,
następnie naciśnij Enter, aby potwierdzić nazwę pliku,
a na końcu `Ctrl` + `X`, aby wyjść z edytora.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/names.txt /home/repl
```

`@sct`
```{python}
patt = "Czy uwzględniono wiersz `%s` w pliku `names.txt`? Proszę użyć polecenia `nano names.txt`, aby zaktualizować plik. Proszę użyć `Ctrl` + `O`, aby zapisać, oraz `Ctrl` + `X`, aby wyjść."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Świetnie! Czas na następne zadanie!")
```

---

## Jak zapisać to, co właśnie zrobiłeś?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Podczas złożonej analizy często warto zachować zapis użytych poleceń.
Można to zrobić za pomocą narzędzi, które już znasz:

1. Uruchom `history`.
2. Przekieruj wynik do `tail -n 10` (lub tyle ostatnich kroków, ile chcesz zapisać).
3. Przekieruj to do pliku o nazwie np. `figure-5.history`.

To lepsze rozwiązanie niż ręczne notowanie,
bo masz pewność, że żaden krok nie zostanie pominięty.
Dobrze ilustruje też podstawową ideę powłoki:
proste narzędzia, które produkują i przetwarzają linie tekstu,
można łączyć na wiele sposobów,
aby rozwiązywać różnorodne problemy.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 144ca955ca
xp: 35
```

`@instructions`
Skopiuj pliki `seasonal/spring.csv` i `seasonal/summer.csv` do swojego katalogu domowego.

`@hint`
Użyj `cp`, aby skopiować pliki, oraz `~` jako skrótu do ścieżki swojego katalogu domowego.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Czy użył(a) Pan(i) `cp seasonal/s* ~` aby skopiować wymagane pliki do katalogu domowego?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Znakomite prowadzenie dokumentacji! Jeśli popełnił(a) Pan(i) błędy w poleceniach, zawsze można użyć `nano` aby wyczyścić plik historii zapisów.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Użyj `grep` z flagą `-h` (aby nie wyświetlał nazw plików)
oraz `-v Tooth` (aby wybrać wiersze, które *nie* pasują do wiersza nagłówka),
aby wybrać rekordy danych z plików `spring.csv` i `summer.csv` w tej kolejności,
i przekieruj wynik do pliku `temp.csv`.

`@hint`
Umieść flagi przed nazwami plików.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Upewnij się, że przekierowujesz dane wyjściowe polecenia `grep` do `temp.csv` za pomocą `>`!"
msg2 = "Czy użył(a) Pan(i) `grep -h -v ___ ___ ___` (uzupełnij luki), aby wypełnić `temp.csv`?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/temp.csv', missing_msg=msg1).multi(
        has_code(r'2017-08-04,canine', incorrect_msg=msg2),
        has_code(r'2017-03-14,incisor', incorrect_msg=msg2),
        has_code(r'2017-03-12,wisdom', incorrect_msg=msg2)
    )
)
```

***

```yaml
type: ConsoleExercise
key: c40348c1e5
xp: 30
```

`@instructions`
Przekieruj wynik `history` do `tail -n 3`
i zapisz go do pliku `steps.txt`,
aby zachować trzy ostatnie polecenia.
(Trzeba zapisać trzy zamiast dwóch,
ponieważ samo polecenie `history` również pojawi się na liście.)

`@hint`
Pamiętaj, że przekierowanie za pomocą `>` umieszcza się na końcu sekwencji poleceń połączonych potokiem.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Upewnij się, że przekierowujesz dane wyjściowe polecenia do `steps.txt`."
msg2="Czy użyto `history | tail ___ ___` (uzupełnij luki), aby wypełnić `steps.txt`?"
Ex().multi(
    has_cwd('/home/repl'),
    # When run by the validator, solution3 doesn't pass, so including a has_code for that
    check_or(
        check_file('/home/repl/steps.txt', missing_msg=msg1).multi(
            has_code(r'\s+1\s+', incorrect_msg=msg2),
            has_code(r'\s+3\s+history', incorrect_msg=msg2)
        ),
        has_code(r'history\s+|\s+tail\s+-n\s+4\s+>\s+steps\.txt')
    )
)
Ex().success_msg("Świetnie! Czas na większe wyzwania!")
```

---

## Jak zapisywać polecenia do późniejszego uruchamiania?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Do tej pory korzystałeś z powłoki interaktywnie.
Ponieważ jednak wpisywane polecenia to zwykły tekst,
można je zapisywać w plikach i uruchamiać wielokrotnie.
Aby poznać tę przydatną możliwość,
umieść poniższe polecenie w pliku o nazwie `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

To polecenie pobiera pierwszy wiersz z każdego pliku CSV w katalogu `seasonal`.
Gdy plik jest już gotowy,
uruchom go, wpisując:

```{shell}
bash headers.sh
```

W ten sposób nakazujesz powłoce (czyli programowi `bash`)
wykonanie poleceń zawartych w pliku `headers.sh`.
Efekt jest taki sam, jak przy bezpośrednim uruchamianiu tych poleceń.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 316ad2fec6
xp: 50
```

`@instructions`
Użyj `nano dates.sh`, aby utworzyć plik o nazwie `dates.sh`
zawierający następujące polecenie:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

wyodrębniające pierwszą kolumnę ze wszystkich plików CSV w katalogu `seasonal`.

`@hint`
Wpisz podane polecenia do pliku bez dodatkowych pustych wierszy ani spacji.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Czy uwzględniono wiersz `cut -d , -f 1 seasonal/*.csv` w pliku `dates.sh`? Proszę użyć `nano dates.sh` ponownie, aby zaktualizować plik. Proszę użyć `Ctrl` + `O`, aby zapisać, i `Ctrl` + `X`, aby wyjść."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/dates.sh').\
        has_code('cut -d *, *-f +1 +seasonal\/\*\.csv', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: 30a8fa953e
xp: 50
```

`@instructions`
Użyj `bash`, aby uruchomić plik `dates.sh`.

`@hint`
Użyj `bash nazwa_pliku`, aby uruchomić plik.

`@solution`
```{shell}
bash dates.sh

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("bash", incorrect_msg = 'Czy wywołano `bash`?'),
      has_code("dates.sh", incorrect_msg = 'Czy podano plik `dates.sh`?')
    )
  )
)
```

---

## Jak ponownie używać potoków?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Plik zawierający polecenia powłoki nazywa się ***skryptem powłoki**,
albo w skrócie po prostu "skryptem". Nazwy skryptów nie muszą kończyć się na `.sh`,
ale w tej lekcji będziemy stosować tę konwencję,
żeby łatwiej odróżnić pliki skryptów od pozostałych.

Skrypty mogą też zawierać potoki.
Na przykład,
jeśli plik `all-dates.sh` zawiera taki wiersz:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

to polecenie:

```{shell}
bash all-dates.sh > dates.out
```

wyodrębni unikalne daty z sezonowych plików danych
i zapisze je do pliku `dates.out`.

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/teeth-start.sh', 'teeth.sh')
```

***

```yaml
type: ConsoleExercise
key: 6fae90f320
xp: 35
```

`@instructions`
W twoim katalogu domowym został przygotowany plik `teeth.sh`, który zawiera jednak pewne luki.
Użyj Nano, aby edytować ten plik i zastąp oba symbole zastępcze `____`
wartościami `seasonal/*.csv` oraz `-c`, tak aby skrypt wypisywał liczbę wystąpień
każdej nazwy zęba w plikach CSV znajdujących się w katalogu `seasonal`.

`@hint`
Użyj polecenia `nano teeth.sh`, aby edytować plik.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Czy poprawnie wypełniono puste miejsca, tak aby polecenie w pliku `teeth.sh` brzmiało `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Proszę użyć polecenia `nano teeth.sh`, aby wprowadzić wymagane zmiany."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/teeth.sh').\
        has_code(r'cut\s+-d\s+,\s+-f\s+2\s+seasonal/\*\.csv\s+\|\s+grep\s+-v\s+Tooth\s+\|\s+sort\s+\|\s+uniq\s+-c', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: dcfccb51e2
xp: 35
```

`@instructions`
Użyj polecenia `bash`, aby uruchomić skrypt `teeth.sh`, i operatora `>`, aby przekierować jego dane wyjściowe do pliku `teeth.out`.

`@hint`
Pamiętaj, że `> teeth.out` musi znaleźć się *po* poleceniu generującym dane wyjściowe.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Czy poprawnie przekierowano wynik działania `bash teeth.sh` do `teeth.out` za pomocą `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Czy wywołano `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Czy uruchomiono plik `teeth.sh`?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Czy przekierowano dane do pliku `teeth.out`?')
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: c8c9a11e3c
xp: 30
```

`@instructions`
Uruchom `cat teeth.out`, aby sprawdzić wyniki.

`@hint`
Pamiętaj, że możesz wpisać kilka pierwszych znaków nazwy pliku, a następnie nacisnąć klawisz Tab, aby automatycznie uzupełnić resztę.

`@solution`
```{shell}
cat teeth.out

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("cat", incorrect_msg = 'Czy wywołano `cat`?'),
      has_code("teeth.out", incorrect_msg = 'Czy podano plik `teeth.out`?')
    )
  )
)
Ex().success_msg("Świetnie! Na początku może to wydawać się sztuczne, ale zaletą jest to, że krok po kroku automatyzuje się części swojego przepływu pracy. Jest to bardzo przydatne w pracy analityka danych!")
```

---

## Jak przekazywać nazwy plików do skryptów?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Skrypt przetwarzający konkretne pliki jest przydatny jako zapis wykonanych działań, ale jeszcze bardziej użyteczny jest taki, który pozwala przetwarzać dowolne pliki.
Aby to umożliwić,
może użyć specjalnego wyrażenia `$@` (znak dolara bezpośrednio poprzedzający znak at),
które oznacza „wszystkie parametry wiersza poleceń przekazane do skryptu".

Na przykład, jeśli plik `unique-lines.sh` zawiera `sort $@ | uniq`, to po uruchomieniu:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

powłoka zastępuje `$@` wartością `seasonal/summer.csv` i przetwarza jeden plik. Jeśli uruchomisz:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

skrypt przetworzy dwa pliki danych – i tak dalej.

_Przypomnienie: aby zapisać plik w Nano, naciśnij `Ctrl` + `O`, żeby zapisać plik, następnie Enter, aby potwierdzić nazwę pliku, a potem `Ctrl` + `X`, aby wyjść z edytora._

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/count-records-start.sh', 'count-records.sh')
```

***

```yaml
type: ConsoleExercise
key: 7a893623af
xp: 50
```

`@instructions`
Otwórz skrypt `count-records.sh` w Nano i uzupełnij dwa miejsca `____`
wartościami `$@` oraz `-l` (_litera_), tak aby skrypt zliczał liczbę wierszy w jednym lub kilku plikach,
pomijając pierwszy wiersz każdego z nich.

`@hint`
* Użyj polecenia `nano count-records.sh`, aby edytować plik.
* Upewnij się, że podajesz _literę_ `-l`, a nie cyfrę jeden.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Czy poprawnie uzupełniono luki, tak aby polecenie w pliku `count-records.sh` brzmiało `tail -q -n +2 $@ | wc -l`? Proszę użyć `nano count-records.sh` ponownie, aby wprowadzić wymagane zmiany."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/count-records.sh').\
        has_code('tail\s+-q\s+-n\s+\+2\s+\$\@\s+\|\s+wc\s+-l', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: d0da324516
xp: 50
```

`@instructions`
Uruchom `count-records.sh` na plikach `seasonal/*.csv`
i przekieruj wynik do pliku `num-records.out` za pomocą `>`.

`@hint`
Użyj `>`, aby przekierować wynik.

`@solution`
```{shell}
bash count-records.sh seasonal/*.csv > num-records.out

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/num-records.out').has_code(r'92'),
    multi(
      has_code("bash", incorrect_msg = 'Czy wywołano `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Czy uruchomiono plik `count-records.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Czy określono pliki do przetworzenia za pomocą `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Czy przekierowano dane do pliku `num-records.out`?')
    )
  )
)
Ex().success_msg("Doskonała robota! Pańskie umiejętności w powłoce systemowej stale rosną!")
```

---

## Jak przetworzyć pojedynczy argument?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Oprócz `$@`,
powłoka pozwala używać `$1`, `$2` itd. do odwoływania się do konkretnych parametrów wiersza poleceń.
Dzięki temu możesz tworzyć polecenia, które działają prościej i bardziej intuicyjnie niż domyślne narzędzia powłoki.
Na przykład
możesz utworzyć skrypt o nazwie `column.sh`, który wybiera pojedynczą kolumnę z pliku CSV,
gdy użytkownik podaje nazwę pliku jako pierwszy parametr, a kolumnę jako drugi:

```{shell}
cut -d , -f $2 $1
```

a następnie uruchomić go poleceniem:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Zwróć uwagę, że skrypt używa obu parametrów w odwrotnej kolejności.

<hr>

Skrypt `get-field.sh` ma pobierać nazwę pliku,
numer wiersza do wybrania,
numer kolumny do wybrania
i wyświetlać tylko to pole z pliku CSV.
Na przykład:

```
bash get-field.sh seasonal/summer.csv 4 2
```

powinno wybrać drugie pole z wiersza 4 pliku `seasonal/summer.csv`.
Które z poniższych poleceń należy umieścić w `get-field.sh`, aby to osiągnąć?

`@hint`
Pamiętaj, że parametry wiersza poleceń są numerowane od lewej do prawej.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Nie: ta opcja spróbuje użyć nazwy pliku jako liczby wierszy do wybrania przez `head`.
- Poprawnie!
- Nie: ta opcja zamieni numer kolumny z numerem wiersza i odwrotnie.
- Nie: ta opcja zamieni numer pola z nazwą pliku i odwrotnie.

---

## Jak jeden skrypt powłoki może robić wiele rzeczy?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Dotychczasowe skrypty powłoki zawierały jedno polecenie lub potok, ale skrypt może składać się z wielu linii poleceń. Możesz na przykład utworzyć skrypt, który poda liczbę rekordów w najkrótszym i najdłuższym pliku danych – czyli zakres długości twoich zbiorów danych.

Zwróć uwagę, że w Nano „kopiowanie i wklejanie" polega na przejściu do linii, którą chcesz skopiować, naciśnięciu `CTRL` + `K`, aby wyciąć linię, a następnie dwukrotnym naciśnięciu `CTRL` + `U`, aby wkleić dwie jej kopie.

_Przypomnienie: aby zapisać plik w Nano, wpisz `Ctrl` + `O`, zatwierdź nazwę pliku klawiszem Enter, a następnie naciśnij `Ctrl` + `X`, aby wyjść z edytora._

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/range-start-1.sh', 'range.sh')
```

***

```yaml
type: ConsoleExercise
key: a1e55487fb
xp: 25
```

`@instructions`
Otwórz skrypt `range.sh` w Nano
i zastąp dwa symbole zastępcze `____`
wartościami `$@` i `-v`,
tak aby skrypt wyświetlał nazwy plików i liczbę linii we wszystkich plikach podanych w wierszu poleceń
*bez* wyświetlania łącznej liczby linii.
(Nie musisz odejmować linii nagłówkowych z plików.)

`@hint`
Użyj `wc -l $@`, aby policzyć linie we wszystkich plikach podanych w wierszu poleceń.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Czy poprawnie wypełniono luki, tak aby polecenie w pliku `range.sh` brzmiało `wc -l $@ | grep -v total`? Proszę użyć `nano range.sh` ponownie, aby wprowadzić wymagane zmiany."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').\
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: e8ece27fe7
xp: 25
```

`@instructions`
Otwórz ponownie Nano i dodaj `sort -n` oraz `head -n 1` – w tej kolejności –
do potoku w skrypcie `range.sh`,
aby wyświetlić nazwę i liczbę linii najkrótszego podanego pliku.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Czy dodano `sort -n` i `head -n 1` z potokami do pliku `range.sh`? Proszę użyć ponownie `nano range.sh`, aby wprowadzić wymagane zmiany."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').\
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total\s+\|\s+sort\s+-n\s+|\s+head\s+-n\s+1', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: a3b36a746e
xp: 25
```

`@instructions`
Używając ponownie Nano, dodaj do skryptu `range.sh` drugą linię, która wyświetli nazwę i liczbę rekordów
*najdłuższego* pliku w katalogu *wraz z* najkrótszym.
Ta linia powinna być kopią już napisanej,
ale z `sort -n -r` zamiast `sort -n`.

`@hint`
Skopiuj pierwszą linię i zmień kolejność sortowania.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Zachowaj pierwszą linię w pliku `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Czy zduplikowali Państwo pierwszą linię w `range.sh` i wprowadzili małą zmianę? `sort -n -r` zamiast `sort -n`!"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').multi(
        has_code("wc -l $@ | grep -v total | sort -n | head -n 1", fixed=True, incorrect_msg = msg1),
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total\s+\|\s+sort\s+-n\s+-r\s+|\s+head\s+-n\s+1', incorrect_msg=msg2)
    )
)
```

***

```yaml
type: ConsoleExercise
key: cba93a77c3
xp: 25
```

`@instructions`
Uruchom skrypt na plikach w katalogu `seasonal`,
używając `seasonal/*.csv`, aby dopasować wszystkie pliki,
i przekieruj wynik za pomocą `>`
do pliku o nazwie `range.out` w swoim katalogu domowym.

`@hint`
Użyj `bash range.sh`, aby uruchomić skrypt, `seasonal/*.csv`, aby wskazać pliki, oraz `> range.out`, aby przekierować wynik.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Czy poprawnie przekierowano wynik polecenia `bash range.sh seasonal/*.csv` do `range.out` za pomocą `>`?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Czy wywołano `bash`?'),
has_code("bash\s+range.sh", incorrect_msg = 'Czy uruchomiono plik `range.sh`?'),
has_code("seasonal/\*", incorrect_msg = 'Czy określono pliki do przetworzenia za pomocą `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = 'Czy przekierowano dane do pliku `range.out`?')
)
)

Ex().success_msg("To idzie dobrze. Przejdź do następnego ćwiczenia, aby dowiedzieć się więcej o pisaniu pętli!")
```

---

## Jak pisać pętle w skrypcie powłoki?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Skrypty powłoki mogą również zawierać pętle. Możesz je zapisywać z użyciem średników lub rozbijać na wiele linii bez średników, co poprawia czytelność:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Wcięcia wewnątrz pętli nie są wymagane, ale znacznie ułatwiają czytanie kodu.)

Pierwsza linia tego skryptu to **komentarz** informujący czytelnika, co skrypt robi. Komentarze zaczynają się od znaku `#` i obejmują całą resztę linii. Dodawanie krótkich objaśnień – takich jak to powyżej – do każdego pisanego skryptu to dobra praktyka, którą docenisz w przyszłości.

_Przypomnienie: aby zapisać plik w edytorze Nano, wciśnij `Ctrl` + `O`, następnie Enter, aby potwierdzić nazwę pliku, a potem `Ctrl` + `X`, aby wyjść z edytora._

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/date-range-start.sh', '/home/repl/date-range.sh')
```

***

```yaml
type: ConsoleExercise
key: 8ca2adb6c4
xp: 35
```

`@instructions`
Uzupełnij miejsca zastępcze w skrypcie `date-range.sh`
wartościami `$filename` (dwa razy), `head` i `tail`,
tak aby skrypt wypisywał pierwszą i ostatnią datę z jednego lub wielu plików.

`@hint`
Pamiętaj, aby użyć `$filename` do pobrania bieżącej wartości zmiennej pętli.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="W `date-range.sh`, czy zmieniłeś/zmieniłaś %s linię w pętli na `%s`? Użyj `nano date-range.sh`, aby wprowadzić zmiany."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('pierwszą', cmdpatt%'head')
msg2=msgpatt%('drugą', cmdpatt%'tail')
patt='cut\s+-d\s+,\s+-f\s+1\s+\$filename\s+\|\s+grep\s+-v\s+Date\s+\|\s+sort\s+\|\s+%s\s+-n\s+1'
patt1 = patt%'head'
patt2 = patt%'tail'
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/date-range.sh').multi(
        has_code(patt1, incorrect_msg=msg1),
        has_code(patt2, incorrect_msg=msg2)
    )
)
```

***

```yaml
type: ConsoleExercise
key: ec1271356d
xp: 35
```

`@instructions`
Uruchom skrypt `date-range.sh` na wszystkich czterech plikach z danymi sezonowymi,
używając wyrażenia `seasonal/*.csv` do dopasowania ich nazw.

`@hint`
Wyrażenie z wieloznacznikiem powinno zaczynać się od nazwy katalogu.

`@solution`
```{shell}
bash date-range.sh seasonal/*.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("bash", incorrect_msg = 'Czy wywołano `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Czy uruchomiono plik `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Czy określono pliki do przetworzenia za pomocą `seasonal/*`?')
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: 0323c7d68d
xp: 30
```

`@instructions`
Uruchom skrypt `date-range.sh` na wszystkich czterech plikach z danymi sezonowymi, używając wyrażenia `seasonal/*.csv` do dopasowania ich nazw,
a następnie przekieruj jego wynik potokiem do polecenia `sort`, aby sprawdzić, że twoje skrypty działają tak samo jak wbudowane polecenia Uniksa.

`@hint`
Użyj tego samego wyrażenia z wieloznacznikiem, co wcześniej.

`@solution`
```{shell}
bash date-range.sh seasonal/*.csv | sort

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("bash", incorrect_msg = 'Czy wywołano `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Czy uruchomiono plik `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Czy określono pliki do przetworzenia za pomocą `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Czy przekierowano dane wyjściowe skryptu do `sort` za pomocą potoku?'),
      has_code("sort", incorrect_msg = 'Czy wywołano `sort`?')
    )
  )
)
Ex().success_msg("Doskonale! Proszę zwrócić uwagę, jak wszystkie poznane elementy można ze sobą łączyć.")
```

---

## Co się dzieje, gdy nie podaję nazw plików?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Częsty błąd w skryptach powłoki (i poleceniach interaktywnych) to podanie nazw plików w złym miejscu.
Jeśli wpiszesz:

```{shell}
tail -n 3
```

to ponieważ `tail` nie otrzymał żadnych nazw plików,
będzie czekać na dane wprowadzone z klawiatury.
Oznacza to, że jeśli wpiszesz:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

to `tail` wypisze ostatnie trzy linie pliku `somefile.txt`,
ale `head` będzie czekać w nieskończoność na dane z klawiatury,
ponieważ nie podano mu nazwy pliku i nic nie poprzedza go w potoku.

<hr>

Przypuśćmy, że przez pomyłkę wpiszesz:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Co powinieneś zrobić w takiej sytuacji?

`@possible_answers`
- Poczekać 10 sekund, aż `head` przekroczy limit czasu.
- Wpisać `somefile.txt` i nacisnąć Enter, aby przekazać dane do `head`.
- Użyć `Ctrl` + `C`, aby zatrzymać działający program `head`.

`@hint`
Co robi `head`, jeśli nie podano mu nazwy pliku i nic nie poprzedza go w potoku?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Nie, polecenia nie będą przekraczać limitu czasu.'
a2 = 'Nie, to przekaże poleceniu `head` tekst `somefile.txt` do przetworzenia, ale następnie program będzie oczekiwał na dalsze dane wejściowe.'
a3 = 'Tak! Należy użyć `Ctrl` + `C`, aby zatrzymać działający program. To kończy ten kurs wprowadzający! Jeśli chcą Państwo dowiedzieć się więcej o narzędziach wiersza poleceń, gorąco polecamy nasz bezpłatny kurs wprowadzający do Git!'
Ex().has_chosen(3, [a1, a2, a3])
```

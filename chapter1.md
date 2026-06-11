---
title: Praca z plikami i katalogami
description: >-
  Ten rozdział to krótkie wprowadzenie do powłoki Unix. Dowiesz się, dlaczego
  jest nadal używana po prawie 50 latach, czym różni się od graficznych
  narzędzi, które mogą być ci lepiej znane, jak poruszać się po powłoce oraz jak
  tworzyć, modyfikować i usuwać pliki i foldery.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Czym różni się powłoka od interfejsu graficznego?
---

## Czym różni się powłoka od interfejsu graficznego?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

System operacyjny, taki jak Windows, Linux czy macOS, to szczególny rodzaj programu.
Kontroluuje procesor, dysk twardy i połączenie sieciowe komputera,
ale jego najważniejszym zadaniem jest uruchamianie innych programów.

Ponieważ człowiek nie jest bytem cyfrowym,
potrzebuje interfejsu, aby komunikować się z systemem operacyjnym.
Najpopularniejszym rozwiązaniem jest dziś graficzny eksplorator plików,
który zamienia kliknięcia i dwukrotne kliknięcia w polecenia otwierania plików i uruchamiania programów.
Zanim komputery zyskały wyświetlacze graficzne,
użytkownicy wpisywali instrukcje do programu zwanego **powłoką wiersza poleceń** (ang. *command-line shell*).
Po każdym wprowadzeniu polecenia
powłoka uruchamia odpowiednie programy,
wyświetla ich wyniki w czytelnej formie
i pokazuje *znak zachęty*, sygnalizując gotowość do przyjęcia kolejnego polecenia.
(Nazwa pochodzi od koncepcji, że powłoka stanowi „zewnętrzną warstwę" komputera.)

Wpisywanie poleceń zamiast klikania i przeciągania może z początku wydawać się nieporęczne,
ale jak się przekonasz,
gdy zaczniesz precyzyjnie określać, co komputer ma zrobić,
będziesz łączyć istniejące polecenia, tworząc nowe,
i automatyzować powtarzające się operacje
za pomocą zaledwie kilku klawiszy.

<hr>
Jaka jest zależność między graficznym eksploratorem plików, z którego korzysta większość ludzi, a powłoką wiersza poleceń?

`@hint`
Pamiętaj, że użytkownik może wchodzić w interakcję z systemem operacyjnym wyłącznie za pośrednictwem programu.

`@possible_answers`
- Eksplorator plików służy do przeglądania i edytowania plików, a powłoka – do uruchamiania programów.
- Eksplorator plików jest zbudowany na bazie powłoki.
- Powłoka jest częścią systemu operacyjnego, podczas gdy eksplorator plików jest od niego oddzielny.
- [Obie opcje to interfejsy służące do wydawania poleceń systemowi operacyjnemu.]

`@feedback`
- Obie opcje pozwalają przeglądać i edytować pliki oraz uruchamiać programy.
- Graficzny eksplorator plików i powłoka wywołują te same funkcje systemu operacyjnego.
- Powłoka i eksplorator plików to programy, które tłumaczą polecenia użytkownika (wpisywane lub klikane) na wywołania systemu operacyjnego.
- Dobrze! Obie opcje przyjmują polecenia użytkownika (wpisywane lub klikane) i przekazują je do systemu operacyjnego.

---

## Gdzie jestem?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**System plików** zarządza plikami i katalogami (folderami).
Każdy z nich jest identyfikowany przez **ścieżkę bezwzględną**,
która pokazuje, jak do niego dotrzeć z **katalogu głównego** systemu plików:
`/home/repl` to katalog `repl` znajdujący się w katalogu `home`,
`/home/repl/course.txt` to plik `course.txt` w tym katalogu,
natomast `/` samo w sobie oznacza katalog główny.

Aby sprawdzić, gdzie się aktualnie znajdujesz w systemie plików,
uruchom polecenie `pwd`
(skrót od „**p**rint **w**orking **d**irectory", czyli „wydrukuj bieżący katalog roboczy").
Polecenie to wyświetla ścieżkę bezwzględną do twojego **bieżącego katalogu roboczego** –
domyślnego miejsca, w którym powłoka wykonuje polecenia i szuka plików.

<hr>
Uruchom `pwd`.
Gdzie się teraz znajdujesz?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
W systemach Unix katalogi domowe użytkowników znajdują się zazwyczaj w `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "To nie jest właściwa ścieżka."
correct = "Poprawnie - jesteś w `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Jak rozpoznać pliki i katalogi?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` pokazuje, gdzie się znajdujesz.
Aby sprawdzić, co tam jest,
wpisz `ls` (skrót od angielskiego „**l**i**s**ting", czyli „lista") i naciśnij Enter.
Użyte samodzielnie,
`ls` wyświetla zawartość bieżącego katalogu
(tego, który wskazuje `pwd`).
Jeśli podasz nazwy plików,
`ls` je wyświetli,
a jeśli podasz nazwy katalogów,
pokaże ich zawartość.
Na przykład
`ls /home/repl` pokazuje zawartość twojego katalogu startowego
(zwanego zwykle **katalogiem domowym**).

<hr>
Użyj `ls` z odpowiednim argumentem, aby wyświetlić pliki w katalogu `/home/repl/seasonal`
(zawiera on informacje o zabiegach stomatologicznych z podziałem na pory roku).
Którego z tych plików *nie ma* w tym katalogu?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Jeśli podasz `ls` ścieżkę, polecenie wyświetli jej zawartość.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Ten plik znajduje się w katalogu `seasonal`."
correct = "Poprawnie - ten plik *nie* znajduje się w katalogu `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Jak jeszcze można identyfikować pliki i katalogi?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Ścieżka bezwzględna działa jak współrzędne geograficzne: ma tę samą wartość niezależnie od tego, gdzie się znajdujesz. **Ścieżka względna** natomiast określa lokalizację względem twojego aktualnego położenia – to jak powiedzenie „20 kilometrów na północ".

Przykłady:
- Jeśli jesteś w katalogu `/home/repl`, **względna** ścieżka `seasonal` wskazuje ten sam katalog co **bezwzględna** ścieżka `/home/repl/seasonal`.
- Jeśli jesteś w katalogu `/home/repl/seasonal`, **względna** ścieżka `winter.csv` wskazuje ten sam plik co **bezwzględna** ścieżka `/home/repl/seasonal/winter.csv`.

Shell rozpoznaje, czy ścieżka jest bezwzględna, czy względna, na podstawie jej pierwszego znaku: jeśli zaczyna się od `/`, jest bezwzględna. Jeśli *nie* zaczyna się od `/`, jest względna.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 9db1ed7afd
xp: 35
```

`@instructions`
Jesteś w katalogu `/home/repl`. Użyj polecenia `ls` ze **ścieżką względną**, aby wyświetlić plik o bezwzględnej ścieżce `/home/repl/course.txt` (i tylko ten plik).

`@hint`
Ścieżkę względną do pliku lub katalogu znajdującego się poniżej twojej bieżącej lokalizacji
można często uzyskać, odejmując bezwzględną ścieżkę bieżącej lokalizacji
od bezwzględnej ścieżki docelowego zasobu.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Nie wywołano polecenia `ls` w celu wygenerowania listy plików."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Polecenie nie wygenerowało poprawnej listy plików. Proszę użyć polecenia `ls` wraz ze ścieżką względną do `/home/repl/course.txt`.")
    )
)
```

***

```yaml
type: ConsoleExercise
key: 4165425bf6
xp: 35
```

`@instructions`
Jesteś w katalogu `/home/repl`.
Użyj polecenia `ls` ze **ścieżką względną**,
aby wyświetlić plik `/home/repl/seasonal/summer.csv` (i tylko ten plik).

`@hint`
Ścieżki względne *nie* zaczynają się od znaku '/'.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Nie wywołano polecenia `ls` w celu wygenerowania listy plików."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Polecenie nie wygenerowało poprawnej listy plików. Należy użyć polecenia `ls` wraz ze ścieżką względną do `/home/repl/seasonal/summer.csv`.")
    )
)
```

***

```yaml
type: ConsoleExercise
key: b5e66d3741
xp: 30
```

`@instructions`
Jesteś w katalogu `/home/repl`.
Użyj polecenia `ls` ze **ścieżką względną**,
aby wyświetlić zawartość katalogu `/home/repl/people`.

`@hint`
Ścieżki względne nie zaczynają się od znaku '/'.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Nie wywołano polecenia `ls` w celu wygenerowania listy plików."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Polecenie nie wygenerowało poprawnej listy plików. Proszę użyć polecenia `ls` wraz z relatywną ścieżką do `/home/repl/people`.")
    )
)
Ex().success_msg("Brawo. Teraz, gdy wiadomo już, jak wyświetlać pliki i katalogi, zobaczmy, jak można poruszać się po systemie plików!")
```

---

## Jak przejść do innego katalogu?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Podobnie jak w przeglądarce plików możesz otwierać foldery dwukrotnym kliknięciem,
w powłoce możesz poruszać się po systemie plików za pomocą polecenia `cd`
(od angielskiego „change directory", czyli „zmień katalog").

Jeśli wpiszesz `cd seasonal`, a następnie `pwd`,
powłoka pokaże ci, że znajdujesz się teraz w `/home/repl/seasonal`.
Jeśli potem uruchomisz samo polecenie `ls`,
wyświetli ono zawartość katalogu `/home/repl/seasonal`,
bо właśnie tam jesteś.
Aby wrócić do katalogu domowego `/home/repl`,
użyj polecenia `cd /home/repl`.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 3d0bfdd77d
xp: 35
```

`@instructions`
Jesteś w katalogu `/home/repl`/.
Przejdź do katalogu `/home/repl/seasonal`, używając ścieżki względnej.

`@hint`
Pamiętaj, że `cd` oznacza „change directory" i że ścieżki względne nie zaczynają się od znaku „/'.

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
key: e69c8eac15
xp: 35
```

`@instructions`
Użyj polecenia `pwd`, żeby sprawdzić, czy jesteś we właściwym miejscu.

`@hint`
Pamiętaj, żeby po wpisaniu polecenia nacisnąć „Enter".

`@solution`
```{shell}
pwd

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_correct(
      has_expr_output(),
      has_code('pwd')
    )
)
```

***

```yaml
type: ConsoleExercise
key: f6b265bd7f
xp: 30
```

`@instructions`
Użyj polecenia `ls` bez żadnych ścieżek, żeby zobaczyć zawartość tego katalogu.

`@hint`
Pamiętaj, żeby po wpisaniu polecenia nacisnąć „Enter".

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_correct(
      has_expr_output(),
      has_code('ls', incorrect_msg="Twoje polecenie nie wygenerowało poprawnego wyniku. Czy użył(a) Pan(i) polecenia `ls` bez ścieżek, aby wyświetlić zawartość bieżącego katalogu?")
    )
)

Ex().success_msg("Świetnie! To było ćwiczenie dotyczące przechodzenia do podkatalogów. A co z przechodzeniem w górę? Przekonajmy się!")
```

---

## Jak przejść do katalogu nadrzędnego?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

**Katalog nadrzędny** to katalog znajdujący się poziom wyżej w hierarchii.
Na przykład `/home` jest katalogiem nadrzędnym dla `/home/repl`,
a `/home/repl` jest katalogiem nadrzędnym dla `/home/repl/seasonal`.
Zawsze możesz podać ścieżkę bezwzględną do katalogu nadrzędnego jako argument poleceń takich jak `cd` czy `ls`.
Częściej jednak skorzystasz ze specjalnej ścieżki `..`
(dwie kropki bez spacji), która oznacza „katalog powyżej tego, w którym się teraz znajduję".
Jeśli jesteś w `/home/repl/seasonal`,
wówczas `cd ..` przenosi cię do `/home/repl`.
Kolejne `cd ..`
przenosI cię do `/home`.
Jeszcze jedno `cd ..` przenosi cię do *katalogu głównego* `/`,
czyli samego szczytu systemu plików.
(Pamiętaj, aby wstawić spację między `cd` a `..` – to polecenie i ścieżka, a nie jedno czteroliterowe polecenie.)

Pojedyncza kropka `.` zawsze oznacza „bieżący katalog",
dlatego samo `ls` i `ls .` działają tak samo,
a `cd .` nie robi nic
(bo przenosi cię do katalogu, w którym już jesteś).

Ostatnia specjalna ścieżka to `~` (tylda),
która oznacza „twój katalog domowy",
na przykład `/home/repl`.
Gdziekolwiek jesteś,
`ls ~` zawsze wyświetli zawartość twojego katalogu domowego,
a `cd ~` zawsze przeniesie cię do domu.

<hr>
Jeśli jesteś w `/home/repl/seasonal`,
gdzie zaprowadzi cię `cd ~/../.`?

`@hint`
Śledź ścieżkę katalog po katalogu.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (katalog główny)

`@feedback`
- Nie, choć samo `~` lub samo `..` zaprowadziłoby cię tam.
- Dokładnie! Ścieżka oznacza: „katalog domowy", „poziom wyżej", „tutaj".
- Nie, choć samo `.` zrobiłoby właśnie to.
- Nie, ostatni element ścieżki to `.` (czyli „tutaj"), a nie `..` (czyli „poziom wyżej").

---

## Jak kopiować pliki?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Często będziesz chciał kopiować pliki,
przenosić je do innych katalogów, aby je uporządkować,
albo zmieniać im nazwy.
Służy do tego polecenie `cp`, skrót od angielskiego „copy" (kopiuj).
Jeśli `original.txt` jest istniejącym plikiem,
to:

```{shell}
cp original.txt duplicate.txt
```

tworzy kopię pliku `original.txt` o nazwie `duplicate.txt`.
Jeśli plik `duplicate.txt` już istniał,
zostanie nadpisany.
Jeśli ostatni parametr polecenia `cp` jest istniejącym katalogiem,
to polecenie w stylu:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

kopiuje *wszystkie* podane pliki do tego katalogu.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 6ab3fb1e25
xp: 50
```

`@instructions`
Skopiuj plik `seasonal/summer.csv` do katalogu `backup` (znajdującego się również w `/home/repl`),
nazywając nowy plik `summer.bck`.

`@hint`
Połącz nazwę katalogu docelowego z nazwą kopiowanego pliku,
aby utworzyć ścieżkę względną dla nowego pliku.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` nie wydaje się istnieć w katalogu `backup`. Podaj dwie ścieżki do `cp`: istniejący plik (`seasonal/summer.csv`) i plik docelowy (`backup/summer.bck`)."),
    has_cwd('/home/repl')
)
```

***

```yaml
type: ConsoleExercise
key: d9e1214bb0
xp: 50
```

`@instructions`
Skopiuj pliki `spring.csv` i `summer.csv` z katalogu `seasonal` do katalogu `backup`,
*nie* zmieniając bieżącego katalogu roboczego (`/home/repl`).

`@hint`
Użyj polecenia `cp`, podając nazwy plików, które chcesz skopiować,
a *następnie* nazwę katalogu docelowego.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` nie został skopiowany do katalogu `backup`. Podaj dwie nazwy plików i nazwę katalogu do `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Proszę skopiować pliki będąc w katalogu `{{dir}}`! Proszę użyć `cd {{dir}}`, aby tam wrócić."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Dobra robota. Oprócz kopiowania, powinniśmy również umieć przenosić pliki z jednego katalogu do drugiego. Proszę zapoznać się z tym w następnym ćwiczeniu!")
```

---

## Jak przenieść plik?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Polecenie `cp` kopiuje plik,
natomiast `mv` przenosi go z jednego katalogu do innego –
podobnie jak przeciąganie pliku w graficznym menedżerze plików.
Parametry podaje się tak samo jak w przypadku `cp`,
a zatem polecenie:

```{shell}
mv autumn.csv winter.csv ..
```

przenosi pliki `autumn.csv` i `winter.csv` z bieżącego katalogu roboczego
o jeden poziom wyżej, do katalogu nadrzędnego
(ponieważ `..` zawsze oznacza katalog położony powyżej twojej bieżącej lokalizacji).

`@instructions`
Znajdujesz się w katalogu `/home/repl`, który zawiera podkatalogi `seasonal` i `backup`.
Używając jednego polecenia, przenieś pliki `spring.csv` i `summer.csv` z katalogu `seasonal` do katalogu `backup`.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
mv seasonal/spring.csv seasonal/summer.csv backup
```

`@sct`
```{python}
backup_patt="Plik `%s` nie znajduje się w katalogu `backup`. Czy użył(a) Pan(i) poprawnie polecenia `mv`? Proszę użyć dwóch nazw plików i katalogu jako parametrów polecenia `mv`."
seasonal_patt="Plik `%s` nadal znajduje się w katalogu `seasonal`. Proszę upewnić się, że pliki są przenoszone za pomocą polecenia `mv`, a nie kopiowane za pomocą polecenia `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Świetnie, kontynuujmy tę przygodę z powłoką!")
```

---

## Jak zmieniać nazwy plików?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` może być też używane do zmiany nazw plików. Po uruchomieniu:

```{shell}
mv course.txt old-course.txt
```

plik `course.txt` w bieżącym katalogu roboczym zostaje „przeniesiony" do pliku `old-course.txt`.
To działa inaczej niż w przeglądarkach plików,
ale bywa bardzo wygodne.

Uwaga:
podobnie jak `cp`,
polecenie `mv` nadpisuje istniejące pliki.
Jeśli na przykład masz już plik o nazwie `old-course.txt`,
powyższe polecenie zastąpi go zawartością pliku `course.txt`.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 710187c8c7
xp: 35
```

`@instructions`
Przejdź do katalogu `seasonal`.

`@hint`
Pamiętaj, że `cd` oznacza „change directory" (zmień katalog) i że ścieżki względne nie zaczynają się od '/'.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
Zmień nazwę pliku `winter.csv` na `winter.csv.bck`.

`@hint`
Użyj `mv`, podając najpierw bieżącą nazwę pliku, a potem tę, którą chcesz mu nadać.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Użyj `mv` z dwoma argumentami: plikiem, który chcesz zmienić nazwę (`winter.csv`) i nową nazwą pliku (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Oczekiwaliśmy znalezienia `winter.csv.bck` w katalogu." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Nie oczekiwaliśmy już `winter.csv` w katalogu." + hint)
    )
)
```

***

```yaml
type: ConsoleExercise
key: 1deee4c768
xp: 30
```

`@instructions`
Uruchom `ls`, aby sprawdzić, czy wszystko przebiegło poprawnie.

`@hint`
Pamiętaj, aby nacisnąć Enter, żeby uruchomić polecenie.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Czy użył/użyła Pan/Pani polecenia `ls`, aby wyświetlić zawartość bieżącego katalogu roboczego?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Polecenie nie wygenerowało poprawnej listy plików. Proszę użyć polecenia `ls` bez argumentów, aby wyświetlić zawartość bieżącego katalogu roboczego.")
    )
)
Ex().success_msg("Kopiowanie, przenoszenie, zmiana nazwy — opanował/opanowała Pan/Pani to wszystko! Następny temat: usuwanie plików.")
```

---

## Jak usuwać pliki?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Pliki można kopiować i przenosić;
do ich usuwania służy polecenie `rm`,
od angielskiego „remove" (usuń).
Podobnie jak `cp` i `mv`,
`rm` przyjmuje nazwy wielu plików naraz, na przykład:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

usuwa zarówno `thesis.txt`, jak i `backup/thesis-2017-08.txt`.

`rm` robi dokładnie to, co sugeruje jego nazwa,
i robi to natychmiast:
w przeciwieństwie do graficznych menedżerów plików
powłoka nie ma kosza,
więc po wpisaniu tego polecenia
twój plik znika bezpowrotnie.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: d7580f7bd4
xp: 25
```

`@instructions`
Jesteś w `/home/repl`.
Przejdź do katalogu `seasonal`.

`@hint`
Pamiętaj, że `cd` oznacza „change directory" (zmień katalog) i że ścieżka względna nie zaczyna się od znaku '/'.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().has_cwd('/home/repl/seasonal')
```

***

```yaml
type: ConsoleExercise
key: 1c21cc7039
xp: 25
```

`@instructions`
Usuń plik `autumn.csv`.

`@hint`
Pamiętaj, że `rm` oznacza „remove" (usuń).

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Nie spodziewaliśmy się, że `autumn.csv` nadal będzie w katalogu `seasonal`. Proszę użyć polecenia `rm` ze ścieżką do pliku, który ma zostać usunięty."),
    has_code('rm', incorrect_msg = 'Proszę użyć polecenia `rm`, aby usunąć plik, zamiast go przenosić.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Wróć do swojego katalogu domowego.

`@hint`
Jeśli użyjesz `cd` bez żadnej ścieżki, powróci do katalogu domowego.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Użyj `cd ..` lub `cd ~`, aby powrócić do katalogu domowego.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Usuń plik `seasonal/summer.csv` bez ponownego zmieniania katalogu.

`@hint`
Pamiętaj, że `rm` oznacza „remove" (usuń).

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Nie spodziewaliśmy się, że `summer.csv` nadal będzie w katalogu `seasonal`. Użyj `rm` ze ścieżką do pliku, który chcesz usunąć."),
    has_code('rm', incorrect_msg = 'Użyj `rm`, aby usunąć plik, zamiast go przenosić.')
)
Ex().success_msg("Imponujące! Przechodzimy do następnego!")
```

---

## Jak tworzyć i usuwać katalogi?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` traktuje katalogi tak samo jak pliki:
jeśli jesteś w katalogu domowym i uruchomisz `mv seasonal by-season`,
na przykład,
`mv` zmieni nazwę katalogu `seasonal` na `by-season`.
Jednak
`rm` działa inaczej.

Jeśli spróbujesz usunąć katalog poleceniem `rm`,
shell wyświetli komunikat o błędzie informujący, że nie jest to możliwe –
głównie po to, żeby uchronić cię przed przypadkowym usunięciem całego katalogu pełnego plików.
Zamiast tego możesz użyć osobnego polecenia `rmdir`.
Dla bezpieczeństwa działa ono tylko wtedy, gdy katalog jest pusty,
dlatego przed usunięciem katalogu musisz najpierw usunąć znajdujące się w nim pliki.
(Doświadczeni użytkownicy mogą użyć opcji `-r` polecenia `rm`, aby uzyskać ten sam efekt;
omówimy opcje poleceń w następnym rozdziale.)

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 5a81bb8589
xp: 25
```

`@instructions`
Bez zmieniania katalogu bieżącego
usuń plik `agarwal.txt` znajdujący się w katalogu `people`.

`@hint`
Pamiętaj, że `rm` oznacza "remove" (usuń) i że ścieżka względna nie zaczyna się od '/'.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` nie powinien już znajdować się w `/home/repl/people`. Czy użył/a Pan/i poprawnie polecenia `rm`?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'W katalogu `people` nadal znajdują się pliki. Jeśli po prostu przeniósł/przeniosła Pan/i plik `agarwal.txt` lub utworzył/a nowe pliki, należy je wszystkie usunąć.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Skoro katalog `people` jest już pusty,
usuń go za pomocą jednego polecenia.

`@hint`
Pamiętaj, że `rm` działa tylko na plikach.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "Katalog 'people' nie powinien już znajdować się w Państwa katalogu domowym. Użyj polecenia `rmdir`, aby go usunąć!")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Ponieważ katalog to nie plik,
do jego tworzenia służy polecenie `mkdir nazwa_katalogu`.
Użyj go, aby utworzyć nowy (pusty) katalog o nazwie `yearly` w katalogu domowym.

`@hint`
Uruchom `mkdir` z nazwą katalogu, który chcesz utworzyć.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="W Twoim katalogu domowym nie ma katalogu `yearly`. Użyj polecenia `mkdir yearly`, aby go utworzyć!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Skoro katalog `yearly` już istnieje,
utwórz wewnątrz niego kolejny katalog o nazwie `2017`,
*nie* opuszczając katalogu domowego.

`@hint`
Użyj ścieżki względnej do podkatalogu, który chcesz utworzyć.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Nie można znaleźć katalogu '2017' w '/home/repl/yearly'. Można utworzyć ten katalog, używając ścieżki względnej `yearly/2017`.")
)
Ex().success_msg("Świetnie! Zakończmy ten rozdział ćwiczeniem, które powtarza niektóre z jego koncepcji!")
```

---

## Podsumowanie

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Podczas analizy danych często tworzy się pliki pośrednie.
Zamiast przechowywać je w katalogu domowym,
można umieszczać je w `/tmp` –
to miejsce, gdzie użytkownicy i programy trzymają pliki potrzebne tylko przez chwilę.
(Zwróć uwagę, że `/tmp` znajduje się bezpośrednio poniżej katalogu głównego `/`,
*nie* poniżej katalogu domowego.)
To ćwiczenie podsumowujące pokaże ci, jak to zrobić.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 59781bc43b
xp: 25
```

`@instructions`
Użyj `cd`, aby przejść do `/tmp`.

`@hint`
Pamiętaj, że `cd` oznacza "zmień katalog" (change directory) i że ścieżka bezwzględna zaczyna się od '/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Znajdują się Państwo w niewłaściwym katalogu. Użyj `cd`, aby zmienić katalog na `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Wyświetl zawartość `/tmp` *bez* podawania nazwy katalogu.

`@hint`
Jeśli nie podasz `ls` żadnego argumentu, polecenie wyświetli zawartość bieżącego katalogu.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Nie wywołano polecenia `ls` w celu wygenerowania listy plików."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Polecenie nie wygenerowało poprawnej listy plików. Proszę użyć polecenia `ls` bez dodatkowych argumentów.")
    )
)
```

***

```yaml
type: ConsoleExercise
key: edaf1bcf96
xp: 25
```

`@instructions`
Utwórz nowy katalog wewnątrz `/tmp` o nazwie `scratch`.

`@hint`
Użyj `mkdir`, aby tworzyć katalogi.

`@solution`
```{shell}
mkdir scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_correct(
      has_dir('/tmp/scratch'),
      has_code('mkdir +scratch', incorrect_msg="Nie można znaleźć katalogu 'scratch' w '/tmp'. Upewnij się, że polecenie `mkdir` jest używane poprawnie.")
    )
)
```

***

```yaml
type: ConsoleExercise
key: a904a3a719
xp: 25
```

`@instructions`
Przenieś plik `/home/repl/people/agarwal.txt` do `/tmp/scratch`.
Sugerujemy użycie skrótu `~` dla katalogu domowego oraz ścieżki względnej dla drugiego argumentu zamiast ścieżki bezwzględnej.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Nie można znaleźć 'agarwal.txt' w '/tmp/scratch'. Proszę użyć polecenia `mv` z `~/people/agarwal.txt` jako pierwszym parametrem i `scratch` jako drugim.")
)
Ex().success_msg("To kończy Rozdział 1 kursu Wprowadzenie do powłoki! Zapraszamy do następnego rozdziału, aby dowiedzieć się więcej o manipulowaniu danymi!")
```

---
title: Przetwarzanie wsadowe
description: >-
  Większość poleceń powłoki przetwarza wiele plików jednocześnie. Ten rozdział
  pokazuje, jak sprawić, by twoje własne potoki działały w ten sam sposób. Przy
  okazji zobaczysz, jak powłoka używa zmiennych do przechowywania informacji.
lessons:
  - nb_of_exercises: 10
    title: Jak powłoka przechowuje informacje?
---

## Jak powłoka przechowuje informacje?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Podobnie jak inne programy, powłoka przechowuje informacje w zmiennych.
Niektóre z nich,
nazywane **zmiennymi środowiskowymi**,
są dostępne przez cały czas.
Nazwy zmiennych środowiskowych są zgodnie z konwencją pisane wielkimi literami.
Kilka najczęściej używanych zmiennych przedstawia poniższa tabela.

| Zmienna | Przeznaczenie                        | Wartość               |
|---------|--------------------------------------|-----------------------|
| `HOME`  | Katalog domowy użytkownika           | `/home/repl`          |
| `PWD `  | Bieżący katalog roboczy              | Tak jak polecenie `pwd` |
| `SHELL` | Używana powłoka                      | `/bin/bash`           |
| `USER`  | Identyfikator użytkownika            | `repl`                |

Aby wyświetlić pełną listę (która jest dość długa),
wpisz w powłoce polecenie `set`.

<hr>

Użyj poleceń `set` i `grep` z potokiem, aby wyświetlić wartość zmiennej `HISTFILESIZE`,
która określa, ile poprzednich poleceń jest przechowywanych w historii.
Jaka jest jej wartość?

`@possible_answers`
- 10
- 500
- [2000]
- Zmienna nie istnieje.

`@hint`
Użyj polecenia `set | grep HISTFILESIZE`, aby znaleźć potrzebną linię.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nie: powłoka zapisuje więcej historii niż to."
err2 = "Nie: powłoka zapisuje więcej historii niż to."
correct3 = "Poprawnie: powłoka domyślnie zapisuje 2000 starych poleceń w tym systemie."
err4 = "Nie: zmienna `HISTFILESIZE` jest tam."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Jak wyświetlić wartość zmiennej?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Prostym sposobem na sprawdzenie wartości zmiennej jest użycie polecenia `echo`, które wyświetla podane argumenty. Wpisanie

```{shell}
echo hello DataCamp!
```

wyświetli

```
hello DataCamp!
```

Jeśli spróbujesz użyć `echo` do wyświetlenia wartości zmiennej w taki sposób:

```{shell}
echo USER
```

polecenie wyświetli nazwę zmiennej, czyli `USER`.

Aby uzyskać wartość zmiennej, musisz poprzedzić jej nazwę znakiem dolara `$`. Wpisanie

```{shell}
echo $USER
```

wyświetli

```
repl
```

Ta zasada obowiązuje wszędzie:
aby odwołać się do wartości zmiennej o nazwie `X`,
musisz napisać `$X`.
(Dzięki temu powłoka wie, czy chodzi ci o „plik o nazwie X",
czy o „wartość zmiennej o nazwie X".)

`@instructions`
Zmienna `OSTYPE` przechowuje nazwę używanego systemu operacyjnego.
Wyświetl jej wartość za pomocą `echo`.

`@hint`
Wywołaj `echo` ze zmienną `OSTYPE` poprzedzoną znakiem `$`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
echo $OSTYPE
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_correct(
        has_expr_output(strict = True),
        multi(
            has_code('echo', incorrect_msg="Czy wywołano `echo`?"),
            has_code('OSTYPE', incorrect_msg="Czy wydrukowano zmienną środowiskową `OSTYPE`?"),
            has_code(r'\$OSTYPE', incorrect_msg="Proszę upewnić się, że przed `OSTYPE` znajduje się znak `$`.")
        )
    )
)
Ex().success_msg("Doskonałe wyświetlenie zmiennych środowiskowych! To dobry początek. Kontynuujmy!")
```

---

## W jaki jeszcze sposób powłoka przechowuje informacje?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Drugi rodzaj zmiennej to **zmienna powłoki**, która działa podobnie do zmiennej lokalnej w języku programowania.

Aby utworzyć zmienną powłoki, wystarczy przypisać wartość do nazwy:

```{shell}
training=seasonal/summer.csv
```

*bez* żadnych spacji przed znakiem `=` ani po nim.
Po wykonaniu tej operacji możesz sprawdzić wartość zmiennej za pomocą:

```{shell}
echo $training
```
```
seasonal/summer.csv
```

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 78f7fd446f
xp: 50
```

`@instructions`
Zdefiniuj zmienną o nazwie `testing` z wartością `seasonal/winter.csv`.

`@hint`
Między nazwą zmiennej a jej wartością *nie* powinno być spacji.

`@solution`
```{shell}
testing=seasonal/winter.csv

```

`@sct`
```{python}
# For some reason, testing the shell variable directly always passes, so we can't do the following.
# Ex().multi(
#     has_cwd('/home/repl'),
#     has_expr_output(
#         expr='echo $testing',
#         output='seasonal/winter.csv',
#         incorrect_msg="Have you used `testing=seasonal/winter.csv` to define the `testing` variable?"
#     )
# )
Ex().multi(
    has_cwd('/home/repl'),
    multi(
        has_code('testing', incorrect_msg='Czy zdefiniowano zmienną powłoki o nazwie `testing`?'),
        has_code('testing=', incorrect_msg='Czy napisano `=` bezpośrednio po testing, bez spacji?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Czy ustawiono wartość `testing` na `seasonal/winter.csv`?')
    )
)
```

***

```yaml
type: ConsoleExercise
key: d5e7224f55
xp: 50
```

`@instructions`
Użyj polecenia `head -n 1 SOMETHING`, aby pobrać pierwszy wiersz z pliku `seasonal/winter.csv`,
posługując się wartością zmiennej `testing` zamiast bezpośredniej nazwy pliku.

`@hint`
Pamiętaj, aby użyć `$testing`, a nie samego `testing`
(znak `$` jest potrzebny, by odczytać wartość zmiennej).

`@solution`
```{shell}
# We need to re-set the variable for testing purposes for this exercise
# you should only run "head -n 1 $testing"
testing=seasonal/winter.csv
head -n 1 $testing

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\$testing', incorrect_msg="Czy odwołano się do zmiennej powłoki za pomocą `$testing`?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Czy wywołano `head`?"),
            has_code('-n', incorrect_msg="Czy ograniczono liczbę wierszy za pomocą `-n`?"),
            has_code(r'-n\s+1', incorrect_msg="Czy wybrano zachowanie 1 wiersza za pomocą `-n 1`?")     
        )
    )
)
Ex().success_msg("Doskonale! Zobaczmy, jak można łatwo powtarzać polecenia.")
```

---

## Jak powtórzyć polecenie wiele razy?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Zmienne powłoki są również używane w **pętlach**,
które powtarzają polecenia wiele razy.
Jeśli uruchomimy to polecenie:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

na wyjściu otrzymamy:

```
gif
jpg
png
```

Zwróć uwagę na kilka rzeczy dotyczących tej pętli:

1. Struktura wygląda tak: `for` ...zmienna... `in` ...lista... `; do` ...treść... `; done`
2. Lista elementów, które pętla ma przetworzyć (w naszym przypadku słowa `gif`, `jpg` i `png`).
3. Zmienna śledząca, który element jest aktualnie przetwarzany (w naszym przypadku `filetype`).
4. Treść pętli wykonująca właściwe działanie (w naszym przypadku `echo $filetype`).

Zauważ, że w treści pętli używamy `$filetype`, aby odczytać wartość zmiennej – a nie samego `filetype`,
podobnie jak w przypadku każdej innej zmiennej powłoki.
Zwróć też uwagę na położenie średników:
pierwszy pojawia się między listą a słowem kluczowym `do`,
a drugi – między treścią a słowem kluczowym `done`.

`@instructions`
Zmodyfikuj pętlę tak, żeby wypisała:

```
docx
odt
pdf
```

Jako nazwy zmiennej pętli użyj `filetype`.

`@hint`
Skorzystaj ze struktury kodu z tekstu wprowadzającego, zastępując rozszerzenia plików graficznych rozszerzeniami plików dokumentów.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
for filetype in docx odt pdf; do echo $filetype; done
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('for', incorrect_msg='Czy użył/a Pan/Pani `for`?'),
      has_code('filetype', incorrect_msg='Czy użył/a Pan/Pani `filetype` jako zmiennej pętli?'),
      has_code('in', incorrect_msg='Czy użył/a Pan/Pani `in` przed listą typów plików?'),
      has_code('docx odt pdf', incorrect_msg='Czy iterował/a Pan/Pani po `docx`, `odt` i `pdf` w tej kolejności?'),
      has_code(r'pdf\s*;', incorrect_msg='Czy umieścił/a Pan/Pani średnik po ostatnim elemencie pętli?'),
      has_code(r';\s*do', incorrect_msg='Czy użył/a Pan/Pani `do` po pierwszym średniku?'),
      has_code('echo', incorrect_msg='Czy użył/a Pan/Pani `echo`?'),
      has_code(r'\$filetype', incorrect_msg='Czy wyświetlił/a Pan/Pani `$filetype` za pomocą echo?'),
      has_code(r'filetype\s*;', incorrect_msg='Czy umieścił/a Pan/Pani średnik po ciele pętli?'),
      has_code('; done', incorrect_msg='Czy zakończył/a Pan/Pani pętlę słowem `done`?')
    )
  )
)
Ex().success_msg("Doskonałe użycie pętli! Pętle są świetne, gdy chce się wykonać tę samą czynność setki lub tysiące razy.")
```

---

## Jak powtórzyć polecenie dla każdego pliku?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Podczas pisania pętli zawsze możesz ręcznie wpisać nazwy plików, które chcesz przetworzyć – zwykle jednak wygodniej jest użyć symboli wieloznacznych.
Spróbuj uruchomić tę pętlę w konsoli:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Wynik:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

Powodem jest to, że powłoka rozwija wyrażenie `seasonal/*.csv` do listy czterech nazw plików jeszcze przed uruchomieniem pętli.

`@instructions`
Zmień wyrażenie wieloznaczne na `people/*`,
tak aby pętla wypisywała nazwy plików z katalogu `people`
niezależnie od tego, czy mają jakieś rozszerzenie, czy nie.
Jako nazwy zmiennej pętli użyj `filename`.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
for filename in people/*; do echo $filename; done
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('for', incorrect_msg='Czy użył(a) Pan(i) `for`?'),
      has_code('filename', incorrect_msg='Czy użył(a) Pan(i) `filename` jako zmiennej pętli?'),
      has_code('in', incorrect_msg='Czy użył(a) Pan(i) `in` przed listą typów plików?'),
      has_code('people/\*', incorrect_msg='Czy określił(a) Pan(i) listę plików za pomocą `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='Czy umieścił(a) Pan(i) średnik po liście plików?'),
      has_code(r';\s*do', incorrect_msg='Czy użył(a) Pan(i) `do` po pierwszym średniku?'),
      has_code('echo', incorrect_msg='Czy wywołał(a) Pan(i) `echo`?'),
      has_code(r'\$filename', incorrect_msg='Czy wyświetlił(a) Pan(i) `$filename` za pomocą echo?'),
      has_code(r'filename\s*;', incorrect_msg='Czy umieścił(a) Pan(i) średnik po treści pętli?'),
      has_code('; done', incorrect_msg='Czy zakończył(a) Pan(i) instrukcję słowem `done`?')
    )
  )
)
Ex().success_msg("Świetna pętla! Symbole wieloznaczne i pętle tworzą potężne połączenie.")
```

---

## Jak zapisać nazwy zestawu plików?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Często stosuje się zmienne z wyrażeniami wieloznacznymi, aby zapisać listę nazw plików.
Na przykład,
jeśli zdefiniujesz zmienną `datasets` w ten sposób:

```{shell}
datasets=seasonal/*.csv
```

może później wyświetlić nazwy tych plików za pomocą:

```{shell}
for filename in $datasets; do echo $filename; done
```

To oszczędza pisania i zmniejsza ryzyko pomyłek.

<hr>

Jeśli uruchomisz te dwa polecenia w swoim katalogu domowym,
ile linii wyników zostanie wyświetlonych?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Żadnej: ponieważ `files` jest zdefiniowane w osobnej linii, w drugiej linii nie ma żadnej wartości.
- Jedna: słowo „files".
- Cztery: nazwy wszystkich czterech sezonowych plików z danymi.

`@hint`
Pamiętaj, że samo `X` to po prostu „X", natomiast `$X` to wartość zmiennej `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nie: nie musisz definiować zmiennej w tej samej linii, w której jej używasz."
err2 = "Nie: ten przykład definiuje i używa zmiennej `files` w tej samej powłoce."
correct3 = "Poprawnie. Polecenie jest równoważne z `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Nazwa zmiennej a jej wartość

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Częstym błędem jest zapomnienie o wstawieniu `$` przed nazwą zmiennej.
W takim przypadku powłoka traktuje wpisany tekst jako nazwę dosłowną,
a nie jako wartość zmiennej.

Inny typowy błąd – szczególnie wśród bardziej doświadczonych użytkowników – to literówka w nazwie zmiennej.
Na przykład,
jeśli zdefiniujesz zmienną `datasets` w ten sposób:

```{shell}
datasets=seasonal/*.csv
```

a następnie wpiszesz:

```{shell}
echo $datsets
```

powłoka nie wypisze nic,
ponieważ `datsets` (bez drugiego „a") nie jest zdefiniowane.

<hr>

Jakby uruchomić te dwa polecenia w katalogu domowym,
co zostałoby wypisane na ekranie?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Uważnie przeczytaj pierwszą część pętli przed udzieleniem odpowiedzi.)

`@hint`
Pamiętaj, że samo `X` oznacza po prostu „X", natomiast `$X` to wartość zmiennej `X`.

`@possible_answers`
- [Jedna linia: słowo „files".]
- Cztery linie: nazwy wszystkich czterech plików z danymi sezonowymi.
- Cztery puste linie: zmienna `f` nie ma przypisanej wartości.

`@feedback`
- Poprawnie: pętla używa `files` zamiast `$files`, więc lista składa się ze słowa „files".
- Nie: pętla używa `files` zamiast `$files`, więc lista zawiera słowo „files", a nie rozwinięcie zmiennej `files`.
- Nie: zmienna `f` jest definiowana automatycznie przez pętlę `for`.

---

## Jak uruchomić wiele poleceń w jednej pętli?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Wyświetlanie nazw plików przydaje się podczas debugowania,
ale prawdziwy cel pętli to wykonywanie operacji na wielu plikach jednocześnie.
Poniższa pętla wyświetla drugi wiersz każdego pliku z danymi:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Ma taką samą strukturę jak inne pętle, które już widziałeś:
jedyna różnica polega na tym, że jej ciało to potok złożony z dwóch poleceń zamiast jednego.

`@instructions`
Napisz pętlę, która wyświetla ostatni wpis z lipca 2017 roku (`2017-07`) z każdego sezonowego pliku. Powinna dawać wynik podobny do:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

ale dla **_każdego_** sezonowego pliku osobno. Użyj `file` jako nazwy zmiennej pętli i pamiętaj, aby iterować po liście plików `seasonal/*.csv` (_zamiast 'seasonal/winter.csv' jak w przykładzie_).

`@hint`
Ciałem pętli jest polecenie grep pokazane w instrukcjach, z tą różnicą, że `seasonal/winter.csv` zastępujesz przez `$file`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
for file in seasonal/*.csv; do grep 2017-07 $file | tail -n 1; done
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  # Enforce use of for loop, so students can't just use grep -h 2017-07 seasonal/*.csv
  has_code('for', incorrect_msg='Czy użył(a) Pan(i) `for`?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Czy użył(a) Pan(i) `file` jako zmiennej pętli?'),
      has_code('in', incorrect_msg='Czy użył(a) Pan(i) `in` przed listą plików?'),
      has_code('seasonal/\*', incorrect_msg='Czy określił(a) Pan(i) listę plików za pomocą `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Czy umieścił(a) Pan(i) średnik po liście plików?'),
      has_code(r';\s*do', incorrect_msg='Czy użył(a) Pan(i) `do` po pierwszym średniku?'),
      has_code('grep', incorrect_msg='Czy wywołał(a) Pan(i) `grep`?'),
      has_code('2017-07', incorrect_msg='Czy wyszukał(a) Pan(i) wyrażenia `2017-07`?'),
      has_code(r'\$file', incorrect_msg='Czy użył(a) Pan(i) `$file` jako nazwy zmiennej pętli?'),
      has_code(r'file\s*|', incorrect_msg='Czy użył(a) Pan(i) potoku, aby połączyć drugie polecenie?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Czy użył(a) Pan(i) `tail -n 1`, aby wyświetlić ostatni wpis każdego wyszukiwania w drugim poleceniu?'),
      has_code('; done', incorrect_msg='Czy zakończył(a) Pan(i) polecenie słowem `done`?')
    )
  )
)

Ex().success_msg("Świetna robota! Symbole wieloznaczne i pętle to potężne połączenie.")
```

---

## Dlaczego nie używać spacji w nazwach plików?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Nadawanie plikom wieloczłonowych nazw, takich jak `July 2017.csv`,
jest wygodne i naturalne podczas korzystania z graficznego menedżera plików.
Jednak w pracy z powłoką takie nazwy mogą powodować problemy.
Na przykład,
jeśli chcesz zmienić nazwę pliku `July 2017.csv` na `2017 July data.csv`,
nie możesz wpisać:

```{shell}
mv July 2017.csv 2017 July data.csv
```

Powyższe polecenie powłoka zinterpretuje jako próbę przeniesienia
czterech plików o nazwach `July`, `2017.csv`, `2017` i ponownie `July`
do katalogu o nazwie `data.csv`.
Zamiast tego musisz ująć nazwy plików w cudzysłów,
aby powłoka traktowała każdą z nich jako jeden parametr:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Załóżmy, że masz dwa pliki: `current.csv` oraz `last year.csv`
(z spacją w nazwie)
i wpisujesz:

```{shell}
rm current.csv last year.csv
```

Co się stanie:

`@hint`
Zastanów się, co by się stało, gdyby ktoś pokazał ci to polecenie, a ty nie wiedziałbyś, jakie pliki istnieją.

`@possible_answers`
- Powłoka wyświetli komunikat o błędzie, ponieważ pliki `last` i `year.csv` nie istnieją.
- Powłoka usunie plik `current.csv`.
- [Obydwie powyższe rzeczy naraz.]
- Nic się nie stanie.

`@feedback`
- Tak, ale to nie wszystko.
- Tak, ale to nie wszystko.
- Zgadza się. Nazwy plików możesz ująć w pojedynczy cudzysłów, `'`, lub podwójny cudzysłów, `"`.
- Niestety nie.

---

## Jak wykonać wiele operacji w jednej pętli?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Wszystkie pętle, które do tej pory widziałeś, miały w ciele tylko jedno polecenie lub jeden potok,
ale pętla może zawierać dowolną liczbę poleceń.
Aby wskazać powłoce, gdzie kończy się jedno polecenie, a zaczyna kolejne,
należy oddzielić je średnikami:

```{shell}
for f in seasonal/*.csv; do echo $f; head -n 2 $f | tail -n 1; done
```

```
seasonal/autumn.csv
2017-01-05,canine
seasonal/spring.csv
2017-01-25,wisdom
seasonal/summer.csv
2017-01-11,canine
seasonal/winter.csv
2017-01-03,bicuspid
```

<hr>

Załóżmy, że zapominasz o średniku między poleceniami `echo` i `head` w powyższej pętli,
w wyniku czego polecenie przekazane do powłoki wygląda tak:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Co zrobi powłoka?

`@possible_answers`
- Wyświetli komunikat o błędzie.
- Wyświetli jeden wiersz dla każdego z czterech plików.
- Wyświetli jeden wiersz dla pliku `autumn.csv` (pierwszego pliku).
- Wyświetli ostatni wiersz każdego pliku.

`@hint`
Możesz przekierować wynik polecenia `echo` do `tail` za pomocą potoku.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nie: pętla zostanie uruchomiona, po prostu nie wykona niczego sensownego."
correct2 = "Tak: `echo` generuje jedną linię zawierającą nazwę pliku dwukrotnie, którą następnie `tail` kopiuje."
err3 = "Nie: pętla wykonuje się raz dla każdej z czterech nazw plików."
err4 = "Nie: dane wejściowe `tail` to dane wyjściowe `echo` dla każdej nazwy pliku."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

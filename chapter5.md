---
title: Crearea de noi instrumente
description: >-
  Istoricul îți permite să repeți acțiuni cu doar câteva apăsări de taste, iar
  pipe-urile îți permit să combini comenzi existente pentru a crea altele noi.
  În acest capitol, vei vedea cum să mergi cu un pas mai departe și să îți
  creezi propriile comenzi.
lessons:
  - nb_of_exercises: 9
    title: Cum pot edita un fișier?
---

## Cum pot edita un fișier?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix dispune de o varietate surprinzătoare de editoare de text.
În cadrul acestui curs,
vom folosi unul simplu, numit Nano.
Dacă tastezi `nano filename`,
se va deschide `filename` pentru editare
(sau va fi creat dacă nu există deja).
Poți naviga prin fișier cu tastele săgeată,
șterge caractere cu tasta Backspace
și efectua alte operațiuni cu combinații de taste Ctrl:

- `Ctrl` + `K`: șterge o linie.
- `Ctrl` + `U`: recuperează o linie ștearsă.
- `Ctrl` + `O`: salvează fișierul ('O' vine de la 'output'). _Va trebui să apeși și Enter pentru a confirma numele fișierului!_
- `Ctrl` + `X`: iese din editor.

`@instructions`
Rulează `nano names.txt` pentru a edita un fișier nou în directorul tău home
și introdu următoarele patru rânduri:

```
Lovelace
Hopper
Johnson
Wilson
```

Pentru a salva ce ai scris,
tastează `Ctrl` + `O` pentru a scrie fișierul,
apoi Enter pentru a confirma numele fișierului,
iar la final `Ctrl` + `X` pentru a ieși din editor.

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
patt = "Ați inclus linia `%s` în fișierul `names.txt`? Folosiți `nano names.txt` din nou pentru a actualiza fișierul. Folosiți `Ctrl` + `O` pentru a salva și `Ctrl` + `X` pentru a ieși."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Bine făcut! Trecem la următorul!")
```

---

## Cum pot înregistra ce am făcut?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Când realizezi o analiză complexă,
vei dori adesea să păstrezi o evidență a comenzilor folosite.
Poți face asta cu instrumentele pe care le-ai văzut deja:

1. Rulează `history`.
2. Direcționează rezultatul prin pipe către `tail -n 10` (sau câți pași recenți vrei să salvezi).
3. Redirecționează rezultatul într-un fișier cu un nume precum `figure-5.history`.

Această metodă este mai bună decât notarea manuală într-un caiet de laborator,
deoarece garantează că nu vei omite niciun pas.
Ilustrează și ideea centrală a shell-ului:
instrumente simple care produc și consumă linii de text
pot fi combinate în fel și chip
pentru a rezolva o gamă largă de probleme.

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
Copiază fișierele `seasonal/spring.csv` și `seasonal/summer.csv` în directorul tău home.

`@hint`
Folosește `cp` pentru a copia și `~` ca scurtătură pentru calea către directorul tău home.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Ați folosit `cp seasonal/s* ~` pentru a copia fișierele necesare în directorul dvs. principal?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Evidențe remarcabile! Dacă ați tastat greșit anumite comenzi, puteți folosi oricând `nano` pentru a curăța ulterior fișierul cu istoricul salvărilor.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Folosește `grep` cu flag-ul `-h` (pentru a opri afișarea numelor de fișiere)
și `-v Tooth` (pentru a selecta liniile care *nu* corespund liniei de antet)
ca să selectezi înregistrările de date din `spring.csv` și `summer.csv`, în această ordine,
și redirecționează rezultatul în `temp.csv`.

`@hint`
Pune flag-urile înaintea numelor de fișiere.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Asigurați-vă că redirecționați ieșirea comenzii `grep` către `temp.csv` cu `>`!"
msg2 = "Ați folosit `grep -h -v ___ ___ ___` (completați spațiile libere) pentru a popula `temp.csv`?"
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
Direcționează `history` prin pipe către `tail -n 3`
și redirecționează rezultatul în `steps.txt`
pentru a salva ultimele trei comenzi într-un fișier.
(Trebuie să salvezi trei în loc de doar două
deoarece comanda `history` în sine va apărea în listă.)

`@hint`
Reține că redirecționarea cu `>` vine la sfârșitul secvenței de comenzi conectate prin pipe.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Asigurați-vă că redirecționați ieșirea comenzii dvs. către `steps.txt`."
msg2="Ați folosit `history | tail ___ ___` (completați spațiile libere) pentru a popula `steps.txt`?"
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
Ex().success_msg("Bine făcut! Să ridicăm ștacheta!")
```

---

## Cum pot salva comenzi pentru a le rula mai târziu?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Până acum ai folosit shell-ul în mod interactiv.
Însă, deoarece comenzile pe care le tastezi sunt simplu text,
le poți salva în fișiere pe care shell-ul să le ruleze ori de câte ori este nevoie.
Pentru a explora această capabilitate utilă,
pune următoarea comandă într-un fișier numit `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Această comandă selectează primul rând din fiecare fișier CSV din directorul `seasonal`.
Odată ce ai creat acest fișier,
îl poți rula tastând:

```{shell}
bash headers.sh
```

Astfel îi spui shell-ului (care este un program numit `bash`)
să ruleze comenzile din fișierul `headers.sh`,
producând același rezultat ca și cum ai rula comenzile direct.

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
Folosește `nano dates.sh` pentru a crea un fișier numit `dates.sh`
care să conțină această comandă:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

pentru a extrage prima coloană din toate fișierele CSV din directorul `seasonal`.

`@hint`
Introdu comenzile indicate în fișier fără linii goale sau spații suplimentare.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Ați inclus linia `cut -d , -f 1 seasonal/*.csv` în fișierul `dates.sh`? Folosiți `nano dates.sh` din nou pentru a actualiza fișierul. Folosiți `Ctrl` + `O` pentru a salva și `Ctrl` + `X` pentru a ieși."
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
Folosește `bash` pentru a rula fișierul `dates.sh`.

`@hint`
Folosește `bash nume_fișier` pentru a rula fișierul.

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
      has_code("bash", incorrect_msg = 'Ați apelat `bash`?'),
      has_code("dates.sh", incorrect_msg = 'Ați specificat fișierul `dates.sh`?')
    )
  )
)
```

---

## Cum pot reutiliza pipe-uri?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Un fișier care conține comenzi shell se numește ***script shell***,
sau uneori, mai simplu, un „script". Numele scripturilor nu trebuie să se termine cu `.sh`,
dar această lecție va folosi această convenție
pentru a te ajuta să identifici mai ușor care fișiere sunt scripturi.

Scripturile pot conține și pipe-uri.
De exemplu,
dacă `all-dates.sh` conține această linie:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

atunci:

```{shell}
bash all-dates.sh > dates.out
```

va extrage datele unice din fișierele de date sezoniere
și le va salva în `dates.out`.

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
În directorul tău home a fost pregătit un fișier `teeth.sh`, dar acesta conține câteva spații libere.
Folosește Nano pentru a edita fișierul și înlocuiește cele două marcaje `____`
cu `seasonal/*.csv` și `-c`, astfel încât scriptul să afișeze numărul de apariții
ale fiecărui nume de dinte în fișierele CSV din directorul `seasonal`.

`@hint`
Folosește `nano teeth.sh` pentru a edita fișierul.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Ați înlocuit corect spațiile libere astfel încât comanda din `teeth.sh` să citească `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Utilizați `nano teeth.sh` din nou pentru a efectua modificările necesare."
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
Folosește `bash` pentru a rula `teeth.sh` și `>` pentru a redirecționa rezultatul în `teeth.out`.

`@hint`
Reține că `> teeth.out` trebuie să apară *după* comanda care produce rezultatul.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Ați redirecționat corect rezultatul comenzii `bash teeth.sh` către `teeth.out` folosind `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Ați apelat `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Ați rulat fișierul `teeth.sh`?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Ați redirecționat către fișierul `teeth.out`?')
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
Rulează `cat teeth.out` pentru a inspecta rezultatele.

`@hint`
Reține că poți tasta primele câteva caractere ale unui nume de fișier și apoi să apeși tasta Tab pentru a-l completa automat.

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
      has_code("cat", incorrect_msg = 'Ați apelat `cat`?'),
      has_code("teeth.out", incorrect_msg = 'Ați specificat fișierul `teeth.out`?')
    )
  )
)
Ex().success_msg("Excelent! Toate acestea pot părea artificiale la început, dar lucrul plăcut este că automatizați părți ale fluxului de lucru pas cu pas. Ceva foarte util ca om de știință al datelor!")
```

---

## Cum pot transmite nume de fișiere către scripturi?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Un script care procesează anumite fișiere specifice este util ca înregistrare a ceea ce ai făcut, dar unul care îți permite să procesezi orice fișiere dorești este și mai valoros.
Pentru a face acest lucru,
poți folosi expresia specială `$@` (semnul dolar urmat imediat de simbolul @)
cu sensul de „toți parametrii transmiși scriptului din linia de comandă".

De exemplu, dacă `unique-lines.sh` conține `sort $@ | uniq`, atunci când rulezi:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

shell-ul înlocuiește `$@` cu `seasonal/summer.csv` și procesează un singur fișier. Dacă rulezi:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

vor fi procesate două fișiere de date, și tot așa.

_Ca reminder: pentru a salva ce ai scris în Nano, apasă `Ctrl` + `O` pentru a scrie fișierul, apoi Enter pentru a confirma numele fișierului, apoi `Ctrl` + `X` pentru a ieși din editor._

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
Editează scriptul `count-records.sh` cu Nano și completează cei doi substituenți `____`
cu `$@` și respectiv `-l` (_litera_), astfel încât scriptul să numere liniile din unul sau mai multe fișiere,
excluzând prima linie din fiecare.

`@hint`
* Folosește `nano count-records.sh` pentru a edita fișierul.
* Asigură-te că specifici _litera_ `-l`, nu cifra unu.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Ați înlocuit corect spațiile libere astfel încât comanda din `count-records.sh` să citească `tail -q -n +2 $@ | wc -l`? Utilizați din nou `nano count-records.sh` pentru a efectua modificările necesare."
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
Rulează `count-records.sh` pe `seasonal/*.csv`
și redirecționează rezultatul către `num-records.out` folosind `>`.

`@hint`
Folosește `>` pentru a redirecționa rezultatul.

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
      has_code("bash", incorrect_msg = 'Ați apelat `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Ați rulat fișierul `count-records.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Ați specificat fișierele de procesat cu `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Ați redirecționat către fișierul `num-records.out`?')
    )
  )
)
Ex().success_msg("Treabă bine făcută! Puterea dumneavoastră în shell este în continuă expansiune!")
```

---

## Cum pot procesa un singur argument?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Pe lângă `$@`,
shell-ul îți permite să folosești `$1`, `$2` și așa mai departe pentru a face referire la parametri specifici din linia de comandă.
Poți folosi acest lucru pentru a scrie comenzi care par mai simple sau mai naturale decât cele ale shell-ului.
De exemplu,
poți crea un script numit `column.sh` care selectează o singură coloană dintr-un fișier CSV
atunci când utilizatorul furnizează numele fișierului ca prim parametru și coloana ca al doilea:

```{shell}
cut -d , -f $2 $1
```

și apoi îl rulezi astfel:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Observă că scriptul folosește cei doi parametri în ordine inversă.

<hr>

Scriptul `get-field.sh` ar trebui să primească un nume de fișier,
numărul rândului de selectat,
numărul coloanei de selectat
și să afișeze doar acel câmp dintr-un fișier CSV.
De exemplu:

```
bash get-field.sh seasonal/summer.csv 4 2
```

ar trebui să selecteze al doilea câmp din linia 4 a fișierului `seasonal/summer.csv`.
Care dintre următoarele comenzi ar trebui pusă în `get-field.sh` pentru a realiza asta?

`@hint`
Reține că parametrii din linia de comandă sunt numerotați de la stânga la dreapta.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Nu: aceasta va încerca să folosească numele fișierului ca număr de linii de selectat cu `head`.
- Corect!
- Nu: aceasta va încerca să folosească numărul coloanei ca număr de linie și invers.
- Nu: aceasta va folosi numărul câmpului ca nume de fișier și invers.

---

## Cum poate un script shell să facă mai multe lucruri?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Scripturile shell pe care le-am scris până acum au conținut o singură comandă sau un singur pipe, dar un script poate include mai multe linii de comenzi. De exemplu, poți crea unul care îți arată câte înregistrări are cel mai scurt și cel mai lung fișier de date, adică intervalul lungimilor seturilor tale de date.

Notă: în Nano, „copierea și lipirea" se realizează navigând la linia pe care vrei să o copiezi, apăsând `CTRL` + `K` pentru a o decupa, apoi `CTRL` + `U` de două ori pentru a lipi două copii ale acesteia.

_Ca reminder: pentru a salva ce ai scris în Nano, apasă `Ctrl` + `O` pentru a scrie fișierul, apoi Enter pentru a confirma numele fișierului, iar apoi `Ctrl` + `X` pentru a ieși din editor._

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
Folosește Nano pentru a edita scriptul `range.sh`
și înlocuiește cele două marcaje `____`
cu `$@` și `-v`,
astfel încât să afișeze numele și numărul de linii ale tuturor fișierelor transmise în linia de comandă,
*fără* a afișa numărul total de linii din toate fișierele.
(Nu încerca să scazi liniile de antet ale coloanelor din fișiere.)

`@hint`
Folosește `wc -l $@` pentru a număra liniile din toate fișierele transmise în linia de comandă.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Ați înlocuit corect spațiile libere astfel încât comanda din `range.sh` să fie `wc -l $@ | grep -v total`? Utilizați `nano range.sh` din nou pentru a efectua modificările necesare."
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
Folosește Nano din nou pentru a adăuga `sort -n` și `head -n 1`, în această ordine,
la pipeline-ul din `range.sh`,
pentru a afișa numele și numărul de linii ale celui mai scurt fișier transmis.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Ați adăugat `sort -n` și `head -n 1` cu pipe-uri în fișierul `range.sh`? Utilizați `nano range.sh` din nou pentru a efectua modificările necesare."
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
Tot folosind Nano, adaugă o a doua linie în `range.sh` pentru a afișa numele și numărul de înregistrări ale
fișierului *cel mai lung* din director, *pe lângă* cel mai scurt.
Această linie trebuie să fie o copie a celei deja scrise,
dar cu `sort -n -r` în loc de `sort -n`.

`@hint`
Copiază prima linie și modifică ordinea de sortare.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Păstrați prima linie în fișierul `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Ați duplicat prima linie din `range.sh` și ați făcut o mică modificare? `sort -n -r` în loc de `sort -n`!"
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
Rulează scriptul pe fișierele din directorul `seasonal`,
folosind `seasonal/*.csv` pentru a selecta toate fișierele,
și redirecționează rezultatul cu `>`
către un fișier numit `range.out` din directorul tău home.

`@hint`
Folosește `bash range.sh` pentru a rula scriptul, `seasonal/*.csv` pentru a specifica fișierele și `> range.out` pentru a redirecționa rezultatul.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Ați redirecționat corect rezultatul `bash range.sh seasonal/*.csv` către `range.out` cu `>`?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Ați apelat `bash`?'),
has_code("bash\s+range.sh", incorrect_msg = 'Ați rulat fișierul `range.sh`?'),
has_code("seasonal/\*", incorrect_msg = 'Ați specificat fișierele de procesat cu `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = 'Ați redirecționat către fișierul `range.out`?')
)
)

Ex().success_msg("Merge bine. Treceți la exercițiul următor pentru a învăța despre scrierea buclelor!")
```

---

## Cum pot scrie bucle într-un script shell?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Scripturile shell pot conține și bucle. Le poți scrie folosind punct și virgulă sau le poți împărți pe mai multe rânduri, fără punct și virgulă, pentru a fi mai ușor de citit:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Nu este obligatoriu să indentezi comenzile din interiorul buclei, dar acest lucru face codul mai clar.)

Prima linie a acestui script este un **comentariu** care explică cititorului ce face scriptul. Comentariile încep cu caracterul `#` și se extind până la sfârșitul rândului. Versiunea ta din viitor îți va mulțumi că ai adăugat explicații scurte, ca cea de mai sus, în fiecare script pe care îl scrii.

_Ca reminder, pentru a salva ce ai scris în Nano, tastează `Ctrl` + `O` pentru a scrie fișierul, apoi Enter pentru a confirma numele fișierului, apoi `Ctrl` + `X` pentru a ieși din editor._

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
Completează locurile marcate cu placeholder în scriptul `date-range.sh`
cu `$filename` (de două ori), `head` și `tail`,
astfel încât să afișeze prima și ultima dată din unul sau mai multe fișiere.

`@hint`
Nu uita să folosești `$filename` pentru a obține valoarea curentă a variabilei din buclă.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="În `date-range.sh`, ați modificat linia %s din buclă pentru a fi `%s`? Utilizați `nano date-range.sh` pentru a efectua modificări."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('prima', cmdpatt%'head')
msg2=msgpatt%('a doua', cmdpatt%'tail')
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
Rulează `date-range.sh` pe toate cele patru fișiere de date sezoniere
folosind `seasonal/*.csv` pentru a le potrivi după nume.

`@hint`
Expresia cu wildcard trebuie să înceapă cu numele directorului.

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
      has_code("bash", incorrect_msg = 'Ați apelat `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Ați rulat fișierul `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Ați specificat fișierele de procesat cu `seasonal/*`?')
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
Rulează `date-range.sh` pe toate cele patru fișiere de date sezoniere folosind `seasonal/*.csv` pentru a le potrivi după nume,
și redirecționează rezultatul prin pipe către `sort` pentru a vedea că scripturile tale pot fi folosite la fel ca comenzile built-in din Unix.

`@hint`
Folosește aceeași expresie cu wildcard pe care ai folosit-o anterior.

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
      has_code("bash", incorrect_msg = 'Ați apelat `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Ați rulat fișierul `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Ați specificat fișierele de procesat cu `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Ați redirecționat ieșirea scriptului către `sort`?'),
      has_code("sort", incorrect_msg = 'Ați apelat `sort`?')
    )
  )
)
Ex().success_msg("Extraordinar! Observați cât de ușor se pot combina toate lucrurile pe care le-am învățat.")
```

---

## Ce se întâmplă când nu furnizezi nume de fișiere?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

O greșeală frecventă în scripturile shell (și în comenzile interactive) este să plasezi numele fișierelor în locul greșit.
Dacă tastezi:

```{shell}
tail -n 3
```

deoarece `tail` nu a primit niciun nume de fișier,
va aștepta să citească date de la tastatură.
Însemnă că, dacă tastezi:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

atunci `tail` afișează ultimele trei linii din `somefile.txt`,
dar `head` va aștepta la nesfârșit date de la tastatură,
deoarece nu a primit niciun nume de fișier și nu are nimic înaintea lui în pipeline.

<hr>

Să presupunem că tastezi din greșeală:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Ce ar trebui să faci în continuare?

`@possible_answers`
- Să aștepți 10 secunde pentru ca `head` să expire.
- Să tastezi `somefile.txt` și să apeși Enter pentru a furniza date către `head`.
- Să folosești `Ctrl` + `C` pentru a opri programul `head` care rulează.

`@hint`
Ce face `head` dacă nu primește niciun nume de fișier și nu are nimic în amonte?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Nu, comenzile nu vor expira.'
a2 = 'Nu, aceasta va oferi comanzii `head` textul `somefile.txt` pentru procesare, dar apoi va aștepta în continuare mai multe date de intrare.'
a3 = 'Da! Ar trebui să utilizați `Ctrl` + `C` pentru a opri un program în execuție. Aceasta încheie acest curs introductiv! Dacă doriți să aflați mai multe despre instrumentele liniei de comandă, vă recomandăm cu căldură să urmați cursul nostru gratuit de introducere în Git!'
Ex().has_chosen(3, [a1, a2, a3])
```

---
title: Procesarea în lot
description: >-
  Majoritatea comenzilor shell procesează mai multe fișiere simultan. Acest
  capitol îți arată cum să configurezi propriile tale pipeline-uri pentru a face
  același lucru. Pe parcurs, vei vedea cum folosește shell-ul variabile pentru a
  stoca informații.
lessons:
  - nb_of_exercises: 10
    title: Cum stochează shell-ul informațiile?
---

## Cum stochează shell-ul informațiile?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Ca orice alt program, shell-ul stochează informații în variabile.
Unele dintre acestea,
numite **variabile de mediu**,
sunt disponibile tot timpul.
Numele variabilelor de mediu sunt scrise, prin convenție, cu litere mari,
iar câteva dintre cele mai utilizate sunt prezentate mai jos.

| Variabilă | Scop                                        | Valoare               |
|-----------|---------------------------------------------|-----------------------|
| `HOME`    | Directorul principal al utilizatorului      | `/home/repl`          |
| `PWD `    | Directorul de lucru curent                  | Același cu comanda `pwd` |
| `SHELL`   | Programul shell utilizat                    | `/bin/bash`           |
| `USER`    | ID-ul utilizatorului                        | `repl`                |

Pentru a obține lista completă (care este destul de lungă),
pot introduce `set` în shell.

<hr>

Folosește `set` și `grep` cu un pipe pentru a afișa valoarea variabilei `HISTFILESIZE`,
care determină câte comenzi vechi sunt stocate în istoricul comenzilor tale.
Care este valoarea sa?

`@possible_answers`
- 10
- 500
- [2000]
- Variabila nu există.

`@hint`
Folosește `set | grep HISTFILESIZE` pentru a obține linia de care ai nevoie.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nu: shell-ul înregistrează mai mult istoric decât atât."
err2 = "Nu: shell-ul înregistrează mai mult istoric decât atât."
correct3 = "Corect: shell-ul salvează implicit 2000 de comenzi vechi pe acest sistem."
err4 = "Nu: variabila `HISTFILESIZE` există."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Cum pot afișa valoarea unei variabile?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

O metodă mai simplă de a afla valoarea unei variabile este să folosești comanda `echo`, care afișează argumentele primite. Dacă scrii

```{shell}
echo hello DataCamp!
```

se va afișa

```
hello DataCamp!
```

Dacă încerci să folosești `echo` pentru a afișa valoarea unei variabile, astfel:

```{shell}
echo USER
```

va fi afișat numele variabilei, adică `USER`.

Pentru a obține valoarea variabilei, trebuie să pui semnul dolar `$` înaintea ei. Dacă scrii

```{shell}
echo $USER
```

se va afișa

```
repl
```

Această regulă este valabilă peste tot:
pentru a obține valoarea unei variabile numite `X`,
trebuie să scrii `$X`.
(Astfel, shell-ul poate distinge între „un fișier numit X"
și „valoarea unei variabile numite X".)

`@instructions`
Variabila `OSTYPE` conține numele tipului de sistem de operare pe care îl folosești.
Afișează-i valoarea folosind `echo`.

`@hint`
Apelează `echo` cu variabila `OSTYPE` precedată de `$`.

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
            has_code('echo', incorrect_msg="Ați apelat `echo`?"),
            has_code('OSTYPE', incorrect_msg="Ați afișat variabila de mediu `OSTYPE`?"),
            has_code(r'\$OSTYPE', incorrect_msg="Asigurați-vă că prefixați `OSTYPE` cu `$`.")
        )
    )
)
Ex().success_msg("Excelentă afișare a variabilelor de mediu! Ați făcut un început bun. Să continuăm!")
```

---

## Cum mai stochează shell-ul informații?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Un alt tip de variabilă se numește **variabilă shell**,
care funcționează similar cu o variabilă locală dintr-un limbaj de programare.

Pentru a crea o variabilă shell,
trebuie doar să îi atribui o valoare unui nume:

```{shell}
training=seasonal/summer.csv
```

*fără* spații înainte sau după semnul `=`.
Odată ce ai făcut asta,
poți verifica valoarea variabilei cu:

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
Definește o variabilă numită `testing` cu valoarea `seasonal/winter.csv`.

`@hint`
Nu trebuie să existe spații între numele variabilei și valoarea sa.

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
        has_code('testing', incorrect_msg='Ați definit o variabilă shell numită `testing`?'),
        has_code('testing=', incorrect_msg='Ați scris `=` imediat după testing, fără spații?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Ați setat valoarea `testing` la `seasonal/winter.csv`?')
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
Folosește `head -n 1 SOMETHING` pentru a obține prima linie din `seasonal/winter.csv`,
utilizând valoarea variabilei `testing` în locul numelui fișierului.

`@hint`
Folosește `$testing` în loc de simplu `testing`
(semnul `$` este necesar pentru a obține valoarea variabilei).

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
    has_code(r'\$testing', incorrect_msg="Ați făcut referire la variabila shell folosind `$testing`?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Ați apelat `head`?"),
            has_code('-n', incorrect_msg="Ați limitat numărul de linii cu `-n`?"),
            has_code(r'-n\s+1', incorrect_msg="Ați ales să păstrați 1 linie cu `-n 1`?")     
        )
    )
)
Ex().success_msg("Excelent! Să vedem cum puteți repeta comenzile cu ușurință.")
```

---

## Cum pot repeta o comandă de mai multe ori?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Variabilele shell sunt folosite și în **bucle**,
care repetă comenzi de mai multe ori.
Dacă rulăm această comandă:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

obținem:

```
gif
jpg
png
```

Observă câteva lucruri despre această buclă:

1. Structura este `for` ...variabilă... `in` ...listă... `; do` ...corp... `; done`
2. Lista elementelor pe care bucla le va procesa (în cazul nostru, cuvintele `gif`, `jpg` și `png`).
3. Variabila care urmărește elementul procesat în acel moment de buclă (în cazul nostru, `filetype`).
4. Corpul buclei care realizează procesarea (în cazul nostru, `echo $filetype`).

Observă că în corp se folosește `$filetype` pentru a obține valoarea variabilei, nu doar `filetype`,
la fel ca pentru orice altă variabilă shell.
De asemenea, observă unde se plasează punct și virgulă:
primul apare între listă și cuvântul cheie `do`,
iar al doilea apare între corp și cuvântul cheie `done`.

`@instructions`
Modifică bucla astfel încât să afișeze:

```
docx
odt
pdf
```

Te rog folosește `filetype` ca nume al variabilei din buclă.

`@hint`
Folosește structura de cod din textul introductiv, înlocuind tipurile de fișiere imagine cu tipuri de fișiere document.

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
      has_code('for', incorrect_msg='Ați folosit `for`?'),
      has_code('filetype', incorrect_msg='Ați folosit `filetype` ca variabilă de buclă?'),
      has_code('in', incorrect_msg='Ați folosit `in` înainte de lista tipurilor de fișiere?'),
      has_code('docx odt pdf', incorrect_msg='Ați iterat peste `docx`, `odt` și `pdf` în această ordine?'),
      has_code(r'pdf\s*;', incorrect_msg='Ați pus un punct și virgulă după ultimul element al buclei?'),
      has_code(r';\s*do', incorrect_msg='Ați folosit `do` după primul punct și virgulă?'),
      has_code('echo', incorrect_msg='Ați apelat `echo`?'),
      has_code(r'\$filetype', incorrect_msg='Ați afișat `$filetype` cu echo?'),
      has_code(r'filetype\s*;', incorrect_msg='Ați pus un punct și virgulă după corpul buclei?'),
      has_code('; done', incorrect_msg='Ați încheiat cu `done`?')
    )
  )
)
Ex().success_msg("Excelent pentru utilizarea buclelor! Buclele sunt extraordinare dacă doriți să efectuați același lucru de sute sau mii de ori.")
```

---

## Cum pot repeta o comandă pentru fiecare fișier în parte?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Poți oricând să introduci manual numele fișierelor pe care vrei să le procesezi atunci când scrii bucla,
dar de obicei este mai bine să folosești wildcarduri.
Încearcă să rulezi această buclă în consolă:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Aceasta afișează:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

deoarece shell-ul extinde `seasonal/*.csv` într-o listă cu patru nume de fișiere
înainte de a rula bucla.

`@instructions`
Modifică expresia wildcard la `people/*`
astfel încât bucla să afișeze numele fișierelor din directorul `people`,
indiferent de sufixul pe care îl au sau nu.
Te rog folosește `filename` ca nume al variabilei din buclă.

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
      has_code('for', incorrect_msg='Ați folosit `for`?'),
      has_code('filename', incorrect_msg='Ați folosit `filename` ca variabilă de buclă?'),
      has_code('in', incorrect_msg='Ați folosit `in` înainte de lista tipurilor de fișiere?'),
      has_code('people/\*', incorrect_msg='Ați specificat o listă de fișiere cu `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='Ați pus un punct și virgulă după lista de fișiere?'),
      has_code(r';\s*do', incorrect_msg='Ați folosit `do` după primul punct și virgulă?'),
      has_code('echo', incorrect_msg='Ați apelat `echo`?'),
      has_code(r'\$filename', incorrect_msg='Ați afișat cu echo `$filename`?'),
      has_code(r'filename\s*;', incorrect_msg='Ați pus un punct și virgulă după corpul buclei?'),
      has_code('; done', incorrect_msg='Ați încheiat cu `done`?')
    )
  )
)
Ex().success_msg("Buclă după buclă! Caracterele wildcard și buclele formează o combinație puternică.")
```

---

## Cum pot înregistra numele unui set de fișiere?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

De multe ori, o variabilă este definită folosind o expresie wildcard pentru a reține o listă de nume de fișiere.
De exemplu,
dacă definești `datasets` astfel:

```{shell}
datasets=seasonal/*.csv
```

poți afișa numele fișierelor mai târziu cu:

```{shell}
for filename in $datasets; do echo $filename; done
```

Acest lucru reduce tastarea și minimizează riscul de erori.

<hr>

Dacă rulezi aceste două comenzi în directorul tău home,
câte linii de rezultate vor fi afișate?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Niciuna: deoarece `files` este definit pe o linie separată, nu are nicio valoare în a doua linie.
- Una: cuvântul „files".
- Patru: numele tuturor celor patru fișiere de date sezoniere.

`@hint`
Reține că `X` în sine înseamnă doar „X", în timp ce `$X` reprezintă valoarea variabilei `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nu: nu trebuie să definiți o variabilă pe aceeași linie în care o utilizați."
err2 = "Nu: acest exemplu definește și utilizează variabila `files` în același shell."
correct3 = "Corect. Comanda este echivalentă cu `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Numele unei variabile față de valoarea ei

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

O greșeală frecventă este uitarea semnului `$` înaintea numelui unei variabile.
Când se întâmplă asta,
shell-ul folosește exact numele pe care l-ai scris,
nu valoarea acelei variabile.

O altă greșeală, mai des întâlnită la utilizatorii experimentați, este scrierea greșită a numelui variabilei.
De exemplu,
dacă definești `datasets` astfel:

```{shell}
datasets=seasonal/*.csv
```

și apoi scrii:

```{shell}
echo $datsets
```

shell-ul nu afișează nimic,
deoarece `datsets` (fără al doilea „a") nu este definit.

<hr>

Dacă ai rula aceste două comenzi în directorul tău de pornire,
ce rezultat ar fi afișat?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Citește cu atenție prima parte a buclei înainte să răspunzi.)

`@hint`
Reține că `X` în sine înseamnă doar „X", în timp ce `$X` reprezintă valoarea variabilei `X`.

`@possible_answers`
- [O singură linie: cuvântul „files".]
- Patru linii: numele celor patru fișiere de date sezoniere.
- Patru linii goale: variabilei `f` nu i se atribuie nicio valoare.

`@feedback`
- Corect: bucla folosește `files` în loc de `$files`, astfel că lista conține cuvântul „files".
- Nu: bucla folosește `files` în loc de `$files`, deci lista conține cuvântul „files", nu expansiunea variabilei `files`.
- Nu: variabila `f` este definită automat de bucla `for`.

---

## Cum pot rula mai multe comenzi într-o singură buclă?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Afișarea numelor de fișiere este utilă pentru depanare,
dar scopul real al buclelor este să execute operații pe mai multe fișiere.
Bucla de mai jos afișează a doua linie din fiecare fișier de date:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Are aceeași structură ca și celelalte bucle pe care le-ai văzut deja:
singura diferență este că corpul ei este un pipeline format din două comenzi, nu una singură.

`@instructions`
Scrie o buclă care afișează ultima înregistrare din iulie 2017 (`2017-07`) din fiecare fișier sezonier. Ar trebui să producă un rezultat similar cu:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

dar pentru **_fiecare_** fișier sezonier în parte. Te rugăm să folosești `file` ca nume al variabilei de buclă și ține minte să parcurgi lista de fișiere `seasonal/*.csv` (_în loc de 'seasonal/winter.csv', ca în exemplu_).

`@hint`
Corpul buclei este comanda grep din instrucțiuni, cu `seasonal/winter.csv` înlocuit prin `$file`.

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
  has_code('for', incorrect_msg='Ați folosit `for`?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Ați folosit `file` ca variabilă de buclă?'),
      has_code('in', incorrect_msg='Ați folosit `in` înainte de lista de fișiere?'),
      has_code('seasonal/\*', incorrect_msg='Ați specificat o listă de fișiere cu `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Ați pus un punct și virgulă după lista de fișiere?'),
      has_code(r';\s*do', incorrect_msg='Ați folosit `do` după primul punct și virgulă?'),
      has_code('grep', incorrect_msg='Ați apelat `grep`?'),
      has_code('2017-07', incorrect_msg='Ați căutat după `2017-07`?'),
      has_code(r'\$file', incorrect_msg='Ați folosit `$file` ca nume al variabilei de buclă?'),
      has_code(r'file\s*|', incorrect_msg='Ați folosit un pipe pentru a conecta al doilea comandă?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Ați folosit `tail -n 1` pentru a afișa ultima intrare a fiecărei căutări în al doilea comandă?'),
      has_code('; done', incorrect_msg='Ați terminat cu `done`?')
    )
  )
)

Ex().success_msg("Buclă după buclă! Caracterele wildcard și buclele formează o combinație puternică.")
```

---

## De ce să nu folosesc spații în numele fișierelor?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

E ușor și logic să dai fișierelor nume formate din mai multe cuvinte, precum `July 2017.csv`,
atunci când folosești un explorator grafic de fișiere.
Însă acest lucru poate crea probleme atunci când lucrezi în shell.
De exemplu,
să presupunem că vrei să redenumești `July 2017.csv` în `2017 July data.csv`.
Nu poți scrie:

```{shell}
mv July 2017.csv 2017 July data.csv
```

deoarece shell-ul va interpreta că încerci să muți
patru fișiere numite `July`, `2017.csv`, `2017` și `July` (din nou)
într-un director numit `data.csv`.
În schimb,
trebuie să pui numele fișierelor între ghilimele,
astfel încât shell-ul să trateze fiecare nume ca un singur parametru:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Dacă ai două fișiere numite `current.csv` și `last year.csv`
(cu un spațiu în nume)
și tastezi:

```{shell}
rm current.csv last year.csv
```

ce se va întâmpla:

`@hint`
Ce crezi că s-ar întâmpla dacă cineva ți-ar arăta comanda fără să știi ce fișiere există?

`@possible_answers`
- Shell-ul va afișa un mesaj de eroare, deoarece `last` și `year.csv` nu există.
- Shell-ul va șterge `current.csv`.
- [Ambele variante de mai sus.]
- Nimic.

`@feedback`
- Da, dar nu e tot.
- Da, dar nu e tot.
- Corect. Poți folosi ghilimele simple, `'`, sau ghilimele duble, `"`, în jurul numelor de fișiere.
- Din păcate, nu.

---

## Cum pot face mai multe lucruri într-o singură buclă?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Buclele pe care le-ai văzut până acum aveau o singură comandă sau un singur pipeline în corpul lor,
dar o buclă poate conține oricâte comenzi.
Pentru a-i indica shell-ului unde se termină una și unde începe următoarea,
trebuie să le separi cu punct și virgulă:

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

Să presupunem că uiți punct și virgula dintre comenzile `echo` și `head` din bucla anterioară,
astfel încât îi ceri shell-ului să ruleze:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Ce va face shell-ul?

`@possible_answers`
- Va afișa un mesaj de eroare.
- Va afișa câte o linie pentru fiecare dintre cele patru fișiere.
- Va afișa o linie pentru `autumn.csv` (primul fișier).
- Va afișa ultima linie din fiecare fișier.

`@hint`
Poți redirecționa rezultatul comenzii `echo` către `tail` folosind un pipe.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nu: bucla va rula, doar că nu va face ceva util."
correct2 = "Da: `echo` produce o linie care include numele fișierului de două ori, pe care `tail` o copiază."
err3 = "Nu: bucla rulează câte o dată pentru fiecare dintre cele patru nume de fișiere."
err4 = "Nu: intrarea lui `tail` este ieșirea lui `echo` pentru fiecare nume de fișier."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

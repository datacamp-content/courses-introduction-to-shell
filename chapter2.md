---
title: Manipularea datelor
description: >-
  Comenzile din capitolul anterior ți-au permis să muți fișiere în sistemul de
  fișiere. Acest capitol îți va arăta cum să lucrezi cu datele din acele
  fișiere. Instrumentele pe care le vom folosi sunt destul de simple, dar
  constituie fundamente solide.
lessons:
  - nb_of_exercises: 12
    title: Cum pot vizualiza conținutul unui fișier?
---

## Cum pot vizualiza conținutul unui fișier?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Înainte să redenumești sau să ștergi fișiere,
poate vrei să le arunci o privire asupra conținutului.
Cel mai simplu mod de a face asta este cu `cat`,
care afișează conținutul fișierelor direct pe ecran.
(Numele provine de la "concatenate", adică "a lega lucrurile împreună",
deoarece va afișa toate fișierele ale căror nume le specifici, unul după altul.)

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
Afișează conținutul fișierului `course.txt` pe ecran.

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
    has_expr_output(incorrect_msg="Comanda dvs. nu a generat rezultatul corect. Ați folosit `cat` urmat de numele fișierului, `course.txt`?")
)
Ex().success_msg("Excelent! Să ne uităm la alte modalități de a vizualiza conținutul unui fișier.")
```

---

## Cum pot vizualiza conținutul unui fișier pagină cu pagină?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Poți folosi `cat` pentru a afișa fișiere mari și a derula prin rezultate,
dar de obicei este mai comod să **paginezi** rezultatul.
Comanda originală pentru asta se numea `more`,
dar a fost înlocuită de o comandă mai puternică: `less`.
(Acest tip de denumire reprezintă umorul specific lumii Unix.)
Când folosești `less` pe un fișier,
se afișează câte o pagină odată;
pot apăsa bara de spațiu pentru a avansa la pagina următoare sau poți tasta `q` pentru a ieși.

Dacă îi transmiți lui `less` mai multe fișiere,
poți tasta `:n` (două puncte și litera 'n' mică) pentru a trece la fișierul următor,
`:p` pentru a reveni la cel anterior,
sau `:q` pentru a ieși.

Notă: Dacă vizualizezi soluțiile exercițiilor care folosesc `less`,
vei observa o comandă suplimentară la final, care dezactivează paginarea
pentru a putea testa soluțiile eficient.

`@instructions`
Folosește `less seasonal/spring.csv seasonal/summer.csv` pentru a vizualiza aceste două fișiere în această ordine.
Apasă bara de spațiu pentru a avansa la pagina următoare, `:n` pentru a trece la al doilea fișier și `:q` pentru a ieși.

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
                 incorrect_msg='Folosiți `less` și numele fișierelor. Rețineți că `:n` vă mută la fișierul următor.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Cum pot vedea începutul unui fișier?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Primul lucru pe care îl fac majoritatea oamenilor de știință a datelor atunci când primesc un set de date nou de analizat este
să identifice ce câmpuri conține și ce valori au acele câmpuri.
Dacă setul de date a fost exportat dintr-o bază de date sau dintr-un spreadsheet,
acesta va fi adesea stocat ca **valori separate prin virgulă** (CSV).
O metodă rapidă de a afla ce conține este să te uiți la primele rânduri.

Putem face asta în shell folosind comanda `head`.
Așa cum îi sugerează numele,
afișează primele câteva linii dintr-un fișier
(unde „câteva" înseamnă 10),
așadar comanda:

```{shell}
head seasonal/summer.csv
```

afișează:

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

Ce face `head` dacă fișierul are mai puțin de 10 linii?
(Pentru a afla, folosește comanda pentru a vedea începutul fișierului `people/agarwal.txt`.)

`@possible_answers`
- Afișează un mesaj de eroare deoarece fișierul este prea scurt.
- Afișează câte linii există.
- Afișează suficiente linii goale pentru a ajunge la un total de 10.

`@hint`
Care ar fi lucrul cel mai util pe care l-ar putea face?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Incorect: aceasta nu este cel mai util lucru pe care l-ar putea face.",
                    "Corect!",
                    "Incorect: ar fi imposibil de distins de un fișier care s-a terminat cu mai multe rânduri goale."])
```

---

## Cum să scrii mai puțin?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Unul dintre instrumentele puternice ale shell-ului este **completarea automată cu tab**.
Dacă începi să scrii numele unui fișier și apeși tasta tab,
shell-ul va încerca să completeze calea automat.
De exemplu,
dacă scrii `sea` și apeși tab,
va completa numele directorului `seasonal/` (cu slash la final).
Dacă apoi scrii `a` și apeși tab,
va completa calea ca `seasonal/autumn.csv`.

Dacă există mai multe variante posibile,
cum ar fi `seasonal/s`,
apăsând tab a doua oară se va afișa o listă cu opțiunile disponibile.
Scrie încă unul sau două caractere pentru a preciza calea mai exact,
apoi apasă tab
și restul numelui va fi completat automat.

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
Rulează `head seasonal/autumn.csv` fără să tastezi numele complet al fișierului.

`@hint`
Scrie atât din cale cât ai nevoie, apasă tab și repetă procedeul.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Verificatorul nu a putut găsi rezultatul corect în comanda dumneavoastră. Sunteți sigur că ați apelat `head` pe `seasonal/autumn.csv`?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Rulează `head seasonal/spring.csv` fără să tastezi numele complet al fișierului.

`@hint`
Scrie atât din cale cât ai nevoie, apasă tab și repetă procedeul.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Verificatorul nu a putut găsi rezultatul corect în comanda dumneavoastră. Sunteți sigur că ați apelat `head` pe `seasonal/spring.csv`?")
)
Ex().success_msg("Bună treabă! Odată ce vă obișnuiți cu utilizarea completării automate cu Tab, vă va economisi mult timp!")
```

---

## Cum pot controla comportamentul comenzilor?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Nu vei dori întotdeauna să vezi primele 10 linii dintr-un fișier,
așa că shell-ul îți permite să modifici comportamentul comenzii `head`
prin intermediul unui **indicator de linie de comandă** (sau, pe scurt, „indicator").
Dacă rulezi comanda:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` va afișa doar primele trei linii ale fișierului.
Dacă rulezi `head -n 100`,
va afișa primele 100 de linii (presupunând că există atâtea),
și tot așa.

Numele unui indicator sugerează de obicei scopul său
(de exemplu, `-n` semnalează „**n**umărul de linii").
Indicatorii de comandă nu trebuie să fie neapărat un `-` urmat de o singură literă,
dar aceasta este o convenție foarte răspândită.

Notă: se consideră un stil bun să plasezi toți indicatorii *înaintea* numelor de fișiere,
de aceea, în cadrul acestui curs,
acceptăm doar răspunsurile care respectă această regulă.

`@instructions`
Afișează primele 5 linii din `winter.csv` aflat în directorul `seasonal`.

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
        has_expr_output(incorrect_msg="Sigur apelați `head` pe fișierul `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Sigur ați folosit indicatorul `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Sigur ați folosit indicatorul `-n 5`?")
)
Ex().success_msg("Excelent! Cu această tehnică, puteți evita supraîncărcarea terminalului dacă doriți să vizualizați fișiere text mai mari.")
```

---

## Cum pot lista tot ce se află într-un director?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Pentru a vedea tot ce se află într-un director,
indifierent cât de adânc sunt imbricate fișierele,
poți folosi opțiunea `-R` împreună cu `ls`
(de la „recursiv").
Dacă rulezi `ls -R` în directorul tău home,
vei vedea ceva similar cu:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Acest rezultat afișează toate fișierele și directoarele de la nivelul curent,
urmate de conținutul fiecărui subdirector,
și tot așa.

`@instructions`
Pentru a ști mai ușor ce reprezintă fiecare element,
`ls` are și opțiunea `-F`, care adaugă `/` după numele fiecărui director
și `*` după numele fiecărui program executabil.
Rulează `ls` cu cele două opțiuni, `-R` și `-F`, și calea absolută către directorul tău home
pentru a vedea tot ce conține.
(Ordinea opțiunilor nu contează, dar numele directorului trebuie să fie ultimul argument.)

`@hint`
Directorul tău home poate fi specificat folosind `~` sau `.` sau calea sa absolută.

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
  has_expr_output(incorrect_msg='Utilizați fie `ls -R -F`, fie `ls -F -R` și calea `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Utilizați fie `ls -R -F`, fie `ls -F -R` și calea `/home/repl`.')
)
Ex().success_msg("Aceasta este o prezentare destul de utilă, nu-i așa?")
```

---

## Cum pot obține ajutor pentru o comandă?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Pentru a afla ce fac comenzile,
oamenii obișnuiau să folosească comanda `man`
(prescurtare de la „manual").
De exemplu,
comanda `man head` afișează următoarele informații:

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

`man` invocă automat `less`,
așa că s-ar putea să fie nevoie să apeși bara de spațiu pentru a parcurge informațiile
și `:q` pentru a ieși.

Descrierea de o linie de sub `NAME` îți spune pe scurt ce face comanda,
iar rezumatul de sub `SYNOPSIS` listează toate opțiunile disponibile.
Orice element opțional apare între paranteze drepte `[...]`,
alternativele sunt separate prin `|`,
iar elementele care pot fi repetate sunt marcate cu `...`.
Astfel, pagina de manual a lui `head` îți indică că poți specifica *fie* numărul de linii cu `-n`,
*fie* numărul de octeți cu `-c`,
și că poți furniza oricâte nume de fișiere.

Problema cu manualul Unix este că trebuie să știi ce cauți.
Dacă nu știi,
poți căuta pe [Stack Overflow](https://stackoverflow.com/),
pune o întrebare pe canalele Slack ale DataCamp
sau consulta secțiunile `SEE ALSO` ale comenzilor pe care le cunoști deja.

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
Citește pagina de manual a comenzii `tail` pentru a afla
ce efect are plasarea unui semn `+` în fața numărului folosit cu opțiunea `-n`.
(Nu uita să apeși bara de spațiu pentru a derula în jos și/sau să tastezi `q` pentru a ieși.)

`@hint`
Reține: `man` este prescurtarea de la „manual".

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Utilizați `man` și numele comenzii.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Folosește `tail` cu opțiunea `-n +7` pentru a afișa toate liniile din `seasonal/spring.csv`, *cu excepția* primelor șase.

`@hint`
Folosește semnul plus '+' în fața numărului de linii pe care vrei să le afișezi.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Apelați `tail` pe `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Sigur ați folosit indicatorul `-n +7`?")
)
```

---

## Cum pot selecta coloane dintr-un fișier?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` și `tail` îți permit să selectezi rânduri dintr-un fișier text.
Dacă vrei să selectezi coloane,
poți folosi comanda `cut`.
Aceasta are mai multe opțiuni (explorează-le cu `man cut`),
dar cea mai comună arată cam așa:

```{shell}
cut -f 2-5,8 -d , values.csv
```

ceea ce înseamnă
„selectează coloanele 2 până la 5 și coloana 8,
folosind virgula ca separator".
`cut` folosește `-f` (de la „fields", adică „câmpuri") pentru a specifica coloanele
și `-d` (de la „delimiter", adică „separator") pentru a specifica caracterul de separare.
Trebuie să îl specifici, deoarece unele fișiere pot folosi spații, tab-uri sau două puncte pentru a separa coloanele.

<hr>

Ce comandă va selecta prima coloană (care conține date calendaristice) din fișierul `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Oricare dintre variantele de mai sus.
- Niciuna dintre variantele de mai sus, deoarece `-f` trebuie să apară înaintea lui `-d`.

`@hint`
Ordinea opțiunilor nu contează.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Yes, but that is not all', 'Yes, but that is not all', 'Correct! Adding a space after the flag is good style, but not compulsory.', 'No, flag order doesn\'t matter'])
```

---

## Ce nu poate face `cut`?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` este o comandă destul de limitată.
În special,
nu înțelege șirurile de caractere între ghilimele.
Dacă, de exemplu, fișierul tău arată astfel:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

atunci:

```{shell}
cut -f 2 -d , everyone.csv
```

va produce:

```
Age
Ranjit"
Rupinder"
```

în loc să afișeze vârsta fiecărei persoane,
deoarece va interpreta virgula dintre nume și prenume ca separator de coloană.

<hr>

Care este rezultatul comenzii `cut -d : -f 2-4` aplicată pe linia:

```
first:second:third:
```

(Remarcă caracterul două puncte de la final.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Niciuna dintre variantele de mai sus, deoarece nu există patru câmpuri.

`@hint`
Acordă atenție caracterului două puncte de la final.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Nu, există mai mult.', 'Nu, există mai mult.', 'Corect! Două puncte finale creează un al patrulea câmp gol.', 'Nu, `cut` face tot ce poate.'])
```

---

## Cum pot repeta comenzile?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Unul dintre cele mai mari avantaje ale utilizării shell-ului este că
îți permite să repeți acțiuni cu ușurință.
Dacă ai rulat câteva comenzi,
pot apăsa tasta săgeată sus pentru a le parcurge din nou.
Poți folosi și săgețile stânga-dreapta, precum și tasta Delete, pentru a le edita.
Apăsând Enter, vei rula comanda modificată.

Și mai util, `history` afișează o listă cu comenzile rulate recent.
Fiecare comandă este precedată de un număr de ordine, astfel încât poți relua ușor o anumită comandă:
scrie pur și simplu `!55` pentru a relua a 55-a comandă din istoric (dacă ai atât de multe).
Poți relua o comandă și scriind semnul exclamării urmat de numele comenzii,
de exemplu `!head` sau `!cut`,
care va relua cea mai recentă utilizare a acelei comenzi.

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
Rulează `head summer.csv` în directorul tău principal (ar trebui să eșueze).

`@hint`
Completarea automată cu Tab nu funcționează dacă nu există un nume de fișier corespunzător.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Folosiți `head` și un nume de fișier, `summer.csv`. Nu vă faceți griji dacă eșuează. Ar trebui să eșueze.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Schimbă directorul în `seasonal`.

`@hint`
Amintește-ți că `cd` înseamnă „schimbă directorul" (change directory).

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Dacă directorul dvs. de lucru curent (aflați cu `pwd`) este `/home/repl`, puteți naviga la folderul `seasonal` cu `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Rulează din nou comanda `head` folosind `!head`.

`@hint`
Nu introduce niciun spațiu între `!` și ce urmează după.

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
                        incorrect_msg='Folosiți `!head` pentru a repeta comanda `head`.'),
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
Folosește `history` pentru a vedea ce ai făcut până acum.

`@hint`
Observă că `history` afișează cele mai recente comenzi la final, astfel încât acestea rămân vizibile pe ecran după ce se termină execuția.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Utilizați `history` fără indicatori pentru a obține o listă a comenzilor anterioare.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Rulează din nou `head` folosind `!` urmat de numărul comenzii din istoric.

`@hint`
Nu introduce *niciun* spațiu între `!` și ce urmează după.

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
                        incorrect_msg='Ați folosit `!<a_number>` pentru a rula din nou ultimul `head` din istoric?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Bine făcut! La următorul!")
```

---

## Cum pot selecta liniile care conțin anumite valori?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` și `tail` selectează rânduri,
`cut` selectează coloane,
iar `grep` selectează liniile în funcție de conținutul lor.
În forma sa cea mai simplă,
`grep` primește un fragment de text urmat de unul sau mai multe nume de fișiere
și afișează toate liniile din acele fișiere care conțin textul respectiv.
De exemplu,
`grep bicuspid seasonal/winter.csv`
afișează liniile din `winter.csv` care conțin "bicuspid".

`grep` poate căuta și după tipare;
acest subiect îl vom explora în cursul următor.
Ceea ce contează mai mult acum sunt câteva dintre opțiunile comune ale lui `grep`:

- `-c`: afișează numărul de linii care se potrivesc, nu liniile în sine
- `-h`: *nu* afișează numele fișierelor atunci când se caută în mai multe fișiere
- `-i`: ignoră majusculele (de exemplu, tratează "Regression" și "regression" ca potriviri)
- `-l`: afișează numele fișierelor care conțin potriviri, nu potrivirile în sine
- `-n`: afișează numerele de linie pentru liniile care se potrivesc
- `-v`: inversează potrivirea, adică afișează doar liniile care *nu* se potrivesc

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
Afișează conținutul tuturor liniilor care conțin cuvântul `molar` din `seasonal/autumn.csv`
folosind un singur comandă, din directorul tău principal. Nu folosi nicio opțiune.

`@hint`
Folosește `grep` cu cuvântul căutat și numele fișierului (sau fișierelor) în care să caute.

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
      has_code("grep", incorrect_msg = "Ați apelat `grep`?"),
      has_code("molar", incorrect_msg = "Ați căutat `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Ați căutat în fișierul `seasonal/autumn.csv`?")
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
Inversează potrivirea pentru a găsi toate liniile care *nu* conțin cuvântul `molar` în `seasonal/spring.csv` și afișează numerele lor de linie.
Rețineți că este considerat bun stil să plasezi toate opțiunile *înainte* de alte valori, precum numele fișierelor sau termenul de căutare "molar".

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
      has_code("grep", incorrect_msg = "Ați apelat `grep`?"),
      has_code("-v", incorrect_msg = "Ați inversat potrivirea cu `-v`?"),
      has_code("-n", incorrect_msg = "Ați afișat numerele de linie cu `-n`?"),
      has_code("molar", incorrect_msg = "Ați căutat `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Ați căutat în fișierul `seasonal/spring.csv`?")
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
Numără câte linii conțin cuvântul `incisor` în `autumn.csv` și `winter.csv` la un loc.
(Din nou, rulează un singur comandă din directorul tău principal.)

`@hint`
Nu uita să folosești opțiunea `-c` împreună cu `grep` pentru a număra liniile.

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
      has_code("grep", incorrect_msg = "Ați apelat `grep`?"),
      has_code("-c", incorrect_msg = "Ați obținut numărătorile cu `-c`?"),
      has_code("incisor", incorrect_msg = "Ați căutat `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Ați căutat în fișierul `seasonal/autumn.csv`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Ați căutat în fișierul `seasonal/winter.csv`?")
    )
  )
)
```

---

## De ce nu este întotdeauna sigur să tratezi datele ca text?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

Secțiunea `SEE ALSO` din pagina de manual a comenzii `cut` menționează o comandă numită `paste`,
care poate fi folosită pentru a combina fișiere de date în loc să le fragmenteze.

<hr>

Citește pagina de manual pentru `paste`,
apoi rulează `paste` pentru a combina fișierele cu date de toamnă și de iarnă într-un singur tabel,
folosind virgula ca separator.
Ce problemă prezintă rezultatul din perspectiva analizei datelor?

`@possible_answers`
- Anteturile de coloană se repetă.
- Ultimele rânduri au un număr greșit de coloane.
- O parte din datele din `winter.csv` lipsesc.

`@hint`
Dacă aplici `cut` pe rezultatul comenzii `paste` folosind virgula ca separator,
ai obține răspunsul corect?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Adevărat, dar nu este neapărat o eroare.'
correct2 = 'Corect: unirea liniilor cu coloanele creează doar o coloană goală la început, nu două.'
err3 = 'Nu, toate datele de iarnă sunt acolo.'
Ex().has_chosen(2, [err1, correct2, err3])
```

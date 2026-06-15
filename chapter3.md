---
title: Combinarea instrumentelor
description: >-
  Puterea reală a shell-ului Unix nu constă în comenzile individuale, ci în
  ușurința cu care pot fi combinate pentru a realiza lucruri noi. Acest capitol
  îți va arăta cum să folosești această putere pentru a selecta datele dorite și
  îți va prezenta comenzi pentru sortarea valorilor și eliminarea duplicatelor.
lessons:
  - nb_of_exercises: 12
    title: Cum pot salva rezultatul unei comenzi într-un fișier?
---

## Cum pot salva rezultatul unei comenzi într-un fișier?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Toate instrumentele pe care le-ai văzut până acum îți permit să specifici fișiere de intrare.
Cele mai multe nu au o opțiune pentru a specifica un fișier de ieșire, pentru că nu au nevoie de una.
În schimb,
poți folosi **redirecționarea** pentru a salva rezultatul oricărei comenzi oriunde dorești.
Dacă rulezi această comandă:

```{shell}
head -n 5 seasonal/summer.csv
```

aceasta afișează primele 5 linii din datele de vară pe ecran.
Dacă rulezi în schimb această comandă:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

nimic nu apare pe ecran.
În schimb,
rezultatul lui `head` este salvat într-un fișier nou numit `top.csv`.
Poți vizualiza conținutul acelui fișier folosind `cat`:

```{shell}
cat top.csv
```

Semnul mai-mare-decât `>` îi spune shell-ului să redirecționeze rezultatul lui `head` către un fișier.
Nu face parte din comanda `head`;
în schimb,
funcționează cu orice comandă shell care produce rezultate.

`@instructions`
Combină `tail` cu redirecționarea pentru a salva ultimele 5 linii din `seasonal/winter.csv` într-un fișier numit `last.csv`.

`@hint`
Folosește `tail -n 5` pentru a obține ultimele 5 linii.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "Linia `%s` ar trebui să se afle în fișierul `last.csv`, dar nu se află. Redirecționați ieșirea comenzii `tail -n 5 seasonal/winter.csv` către `last.csv` folosind `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` conține prea multe linii. Ați folosit indicatorul `-n 5` cu `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Excelent! Să mai exersăm puțin!")
```

---

## Cum pot folosi rezultatul unei comenzi ca intrare?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Să presupunem că vrei să extragi linii din mijlocul unui fișier.
Mai exact,
să zicem că vrei să obții liniile 3-5 dintr-unul dintre fișierele noastre de date.
Poți începe prin a folosi `head` pentru a extrage primele 5 linii
și a le redirecționa într-un fișier,
apoi folosești `tail` pentru a selecta ultimele 3:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

O verificare rapidă confirmă că acestea sunt liniile 3-5 din fișierul original,
deoarece reprezintă ultimele 3 linii din primele 5.

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
Selectează ultimele două linii din `seasonal/winter.csv`
și salvează-le într-un fișier numit `bottom.csv`.

`@hint`
Folosește `tail` pentru a selecta liniile și `>` pentru a redirecționa rezultatul comenzii `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="Linia `%s` ar trebui să se afle în fișierul `bottom.csv`, dar nu se află. Redirecționați ieșirea comenzii `tail -n 2 seasonal/winter.csv` către `bottom.csv` folosind `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` conține prea multe linii. Ați folosit indicatorul `-n 2` cu `tail`?'),
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
Selectează prima linie din `bottom.csv`
pentru a obține penultima linie din fișierul original.

`@hint`
Folosește `head` pentru a selecta linia dorită.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Ceva nu este în regulă cu fișierul `bottom.csv`. Asigurați-vă că nu îl modificați!"),
    has_expr_output(strict=True, incorrect_msg="Ați folosit `head` corect pe `bottom.csv`? Asigurați-vă că utilizați corect indicatorul `-n`.")
)

Ex().success_msg("Felicitări. Continuați cu următorul exercițiu pentru a afla despre modalități mai bune de a combina comenzile.")
```

---

## Care este o modalitate mai bună de a combina comenzi?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Utilizarea redirecționării pentru a combina comenzi are două dezavantaje:

1. Lasă în urmă multe fișiere intermediare (precum `top.csv`).
2. Comenzile necesare pentru a obține rezultatul final sunt răspândite pe mai multe linii din istoric.

Shell-ul oferă un alt instrument care rezolvă ambele probleme dintr-o dată, numit **pipe**.
Începe din nou prin a rula `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

În loc să trimiți rezultatul lui `head` într-un fișier,
adaugă o bară verticală și comanda `tail` *fără* un nume de fișier:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Simbolul pipe îi indică shell-ului să folosească rezultatul comenzii din stânga drept intrare pentru comanda din dreapta.

`@instructions`
Folosește `cut` pentru a selecta toate numele de dinți din coloana 2 a fișierului delimitat prin virgulă `seasonal/summer.csv`, apoi direcționează rezultatul către `grep`, cu o potrivire inversă, pentru a exclude linia de antet care conține cuvântul "Tooth". *`cut` și `grep` au fost tratate în detaliu în Capitolul 2, exercițiile 8 și, respectiv, 11.*

`@hint`
- Prima parte a comenzii are forma `cut -d field_delimiter -f column_number filename`.
- A doua parte a comenzii are forma `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'Ați redirecționat rezultatul comenzii `cut -d , -f 2 seasonal/summer.csv` către `grep -v Tooth` folosind `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Ați exclus linia de antet `"Tooth"` folosind `grep`?')
)
Ex().success_msg("Redirecționare perfectă! Poate că aceasta este prima dată când ați folosit `|`, dar cu siguranță nu va fi ultima!")
```

---

## Cum pot combina mai multe comenzi?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Poți înlănțui oricâte comenzi dorești.
De exemplu,
această comandă:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

va:

1. selecta prima coloană din datele de primăvară;
2. elimina linia de antet care conține cuvântul "Date"; și
3. selecta primele 10 linii de date efective.

`@instructions`
În exercițiul anterior, ai folosit următoarea comandă pentru a selecta toate numele de dinți din coloana 2 a fișierului `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Extinde acest pipeline cu o comandă `head` pentru a selecta doar primul nume de dinte.

`@hint`
Copiază și lipește codul din instrucțiuni, adaugă un pipe, apoi apelează `head` cu indicatorul `-n`.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Ați folosit `|` pentru a extinde pipeline-ul cu o comandă `head`? Asigurați-vă că ați setat corect indicatorul `-n`."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Ați folosit `|` pentru a extinde pipeline-ul cu o comandă `head`?")
)
Ex().success_msg("Înlănțuire admirabilă! Prin înlănțuirea mai multor comenzi, puteți construi pipeline-uri puternice de manipulare a datelor.")
```

---

## Cum pot număra înregistrările dintr-un fișier?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Comanda `wc` (prescurtare de la „word count") afișează numărul de **c**aractere, **c**uvinte și **l**inii dintr-un fișier.
Poți face ca aceasta să afișeze doar una dintre aceste valori folosind `-c`, `-w` sau `-l`, respectiv.

`@instructions`
Numără câte înregistrări din `seasonal/spring.csv` au date din iulie 2017 (`2017-07`). 
- Pentru aceasta, folosește `grep` cu o dată parțială pentru a selecta liniile și trimite rezultatul prin pipe către `wc` cu un flag potrivit pentru a număra liniile.

`@hint`
- Folosește `head seasonal/spring.csv` pentru a-ți reaminti formatul datei.
- Prima parte a comenzii are forma `grep thing_to_match filename`.
- După pipe, `|`, apelează `wc` cu flag-ul `-l`.

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
      has_code("grep", incorrect_msg = "Ați apelat `grep`?"),
      has_code("2017-07", incorrect_msg = "Ați căutat `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Ați căutat în fișierul `seasonal/spring.csv`?"),
      has_code("|", incorrect_msg = "Ați redirecționat către `wc` folosind `|`?"),      
      has_code("wc", incorrect_msg = "Ați apelat `wc`?"),
      has_code("-l", incorrect_msg = "Ați numărat liniile cu `-l`?")
    )
  )
)
Ex().success_msg("Numărare atentă! Determinarea cantității de date pe care o aveți este un prim pas excelent în orice analiză de date.")
```

---

## Cum pot specifica mai multe fișiere deodată?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

Majoritatea comenzilor shell funcționează cu mai multe fișiere dacă le oferi mai multe nume de fișiere.
De exemplu,
pot extrage prima coloană din toate fișierele cu date sezoniere deodată, astfel:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Însă să tastezi numele atâtor fișiere din nou și din nou nu este o idee bună:
piezi timp,
iar mai devreme sau mai târziu vei omite un fișier sau vei repeta numele altuia.
Pentru a-ți ușura munca,
shell-ul îți permite să folosești **wildcarduri** pentru a specifica o listă de fișiere printr-o singură expresie.
Cel mai frecvent wildcard este `*`,
care înseamnă „potrivește zero sau mai multe caractere".
Using it,
putem scurta comanda `cut` de mai sus la:

```{shell}
cut -d , -f 1 seasonal/*
```

sau:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Scrie o singură comandă folosind `head` pentru a obține primele trei linii atât din `seasonal/spring.csv`, cât și din `seasonal/summer.csv` — în total șase linii de date —, dar *nu* și din fișierele cu date de toamnă sau iarnă.
Folosește un wildcard în loc să scrii numele fișierelor în întregime.

`@hint`
- Comanda are forma `head -n number_of_lines filename_pattern`.
- Pentru a potrivi fișierele din directorul `a` care încep cu `b`, poți folosi, de exemplu, `a/b*`.

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
    has_expr_output(incorrect_msg = "Puteți folosi `seasonal/s*` pentru a selecta `seasonal/spring.csv` și `seasonal/summer.csv`. Asigurați-vă că includeți doar primele trei linii din fiecare fișier cu indicatorul `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Nu includeți rezultatul pentru `seasonal/autumn.csv`. Puteți folosi `seasonal/s*` pentru a selecta `seasonal/spring.csv` și `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Nu includeți rezultatul pentru `seasonal/winter.csv`. Puteți folosi `seasonal/s*` pentru a selecta `seasonal/spring.csv` și `seasonal/summer.csv`")
)
Ex().success_msg("Wildcard-uri sălbatice la treabă! Acest lucru devine și mai important dacă directorul dumneavoastră conține sute sau mii de fișiere.")
```

---

## Ce alte metacaractere pot folosi?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Shell-ul dispune și de alte metacaractere,
deși sunt folosite mai rar:

- `?` se potrivește cu un singur caracter, deci `201?.txt` va fi asociat cu `2017.txt` sau `2018.txt`, dar nu cu `2017-01.txt`.
- `[...]` se potrivește cu oricare dintre caracterele din parantezele pătrate, deci `201[78].txt` se asociază cu `2017.txt` sau `2018.txt`, dar nu cu `2016.txt`.
- `{...}` se potrivește cu oricare dintre șabloanele separate prin virgulă din acolade, deci `{*.txt, *.csv}` se asociază cu orice fișier al cărui nume se termină cu `.txt` sau `.csv`, dar nu cu fișiere ale căror nume se termină cu `.pdf`.

<hr/>

Care expresie s-ar potrivi cu `singh.pdf` și `johel.txt`, dar *nu* și cu `sandhu.pdf` sau `sandhu.txt`?

`@hint`
Verifică fiecare expresie față de fiecare nume de fișier pe rând.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Nu: `.pdf` și `.txt` nu sunt nume de fișiere.
- Nu: aceasta se va potrivi cu `sandhu.pdf`.
- Nu: expresia din paranteze pătrate se potrivește cu un singur caracter, nu cu cuvinte întregi.
- Corect!

---

## Cum pot sorta liniile de text?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

După cum îi sugerează și numele,
`sort` ordonează datele.
Implicit, le sortează în ordine alfabetică crescătoare,
dar flag-urile `-n` și `-r` pot fi folosite pentru a sorta numeric și, respectiv, pentru a inversa ordinea rezultatelor.
În plus, `-b` ignoră spațiile de la începutul liniei,
iar `-f` **i**gnorează diferența dintre majuscule și minuscule (adică face sortarea case-insensitive).
În general, pipeline-urile folosesc `grep` pentru a elimina înregistrările nedorite,
urmat de `sort` pentru a ordona înregistrările rămase.

`@instructions`
Îți amintești combinația de `cut` și `grep` pentru a selecta toate numele dinților din coloana 2 a fișierului `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Pornind de la această comandă, sortează numele dinților din `seasonal/winter.csv` (nu din `summer.csv`) în ordine alfabetică descrescătoare. Pentru asta, extinde pipeline-ul cu un pas `sort`.

`@hint`
Copiază și lipește comanda din instrucțiuni, schimbă numele fișierului, adaugă un pipe, apoi apelează `sort` cu flag-ul `-r`.

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
      has_code("cut", incorrect_msg = "Ați apelat `cut`?"),
      has_code("-d", incorrect_msg = "Ați specificat un delimitator de câmp cu `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Ați obținut datele din fișierul `seasonal/winter.csv`?"),
      has_code("|", incorrect_msg = "Ați redirecționat din `cut` către `grep` și `sort` folosind `|`?"),      
      has_code("grep", incorrect_msg = "Ați apelat `grep`?"),
      has_code("-v", incorrect_msg = "Ați inversat potrivirea cu `-v`?"),
      has_code("Tooth", incorrect_msg = "Ați căutat `Tooth`?"),
      has_code("sort", incorrect_msg = "Ați apelat `sort`?"),
      has_code("-r", incorrect_msg = "Ați inversat ordinea de sortare cu `-r`?")
    )
  )
)
Ex().success_msg("Sortat! `sort` are multe utilizări. De exemplu, redirecționând `sort -n` către `head` vă arată cele mai mari valori.")
```

---

## Cum pot elimina liniile duplicate?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

O altă comandă folosită frecvent împreună cu `sort` este `uniq`,
al cărei rol este să elimine liniile duplicate.
Mai exact,
eliminează liniile duplicate *adiacente*.
Dacă un fișier conține:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

atunci `uniq` va produce:

```
2017-07-03
2017-08-03
```

dar dacă fișierul conține:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

atunci `uniq` va afișa toate cele patru linii.
Motivul este că `uniq` a fost conceput pentru a lucra cu fișiere foarte mari.
Pentru a elimina liniile care nu sunt adiacente,
ar fi nevoie să păstreze întregul fișier în memorie
(sau cel puțin
toate liniile unice întâlnite până în acel moment).
Eliminând doar duplicatele adiacente,
este suficient să păstreze în memorie doar cea mai recentă linie unică.

`@instructions`
Scrie un pipeline care să:

- extragă a doua coloană din `seasonal/winter.csv`,
- elimine cuvântul "Tooth" din rezultat, astfel încât să fie afișate doar numele dinților,
- sorteze rezultatul, astfel încât toate aparițiile unui anumit nume să fie adiacente; și
- afișeze fiecare nume o singură dată, împreună cu numărul de apariții.

Începutul pipeline-ului tău este același ca în exercițiul anterior:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Extinde-l cu o comandă `sort`, apoi folosește `uniq -c` pentru a afișa liniile unice împreună cu numărul de apariții, în loc să folosești `uniq` și `wc`.

`@hint`
Copiază și lipește comanda din instrucțiuni, direcționează rezultatul cu `|` către `sort` fără opțiuni, apoi din nou cu `|` către `uniq` cu opțiunea `-c`.

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
                     incorrect_msg="Ar trebui să începeți cu această comandă: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Acum extindeți-o!"),
            has_code('\|\s+sort', incorrect_msg="Ați extins comanda cu `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="Ați extins comanda cu `| uniq`?"),
            has_code('-c', incorrect_msg="Ați inclus numărul de apariții cu `-c`?")
        )
    )
)
Ex().success_msg("Excelent! După toată această muncă pe un pipe, ar fi util să putem stoca rezultatul, nu-i așa?")
```

---

## Cum pot salva rezultatul unui pipe?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Shell-ul ne permite să redirecționăm rezultatul unei secvențe de comenzi conectate prin pipe:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Totuși, `>` trebuie să apară la sfârșitul pipeline-ului:
dacă încercăm să îl folosim la mijloc, astfel:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

atunci tot rezultatul comenzii `cut` este scris în `teeth-only.txt`,
așa că nu mai rămâne nimic pentru `grep`
și acesta așteaptă la nesfârșit date de intrare.

<hr>

Ce se întâmplă dacă plasăm redirecționarea la începutul unui pipeline, astfel:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [Rezultatul comenzii este redirecționat în fișier ca de obicei.]
- Shell-ul raportează o eroare.
- Shell-ul așteaptă la nesfârșit date de intrare.

`@hint`
Încearcă direct în shell.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Corect!', 'Nu; shell-ul poate de fapt executa acest lucru.', 'Nu; shell-ul poate de fapt executa acest lucru.'])
```

---

## Cum pot opri un program în rulare?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Comenzile și scripturile pe care le-ai rulat până acum s-au executat rapid,
dar unele sarcini pot dura minute, ore sau chiar zile.
Poți ajunge, de asemenea, să plasezi din greșeală o redirecționare în mijlocul unui pipeline,
cauzând blocarea acestuia.
Dacă decizi că nu mai vrei ca un program să continue să ruleze,
poți tasta `Ctrl` + `C` pentru a-l opri.
Această combinație este adesea scrisă `^C` în documentația Unix;
reține că litera 'c' poate fi scrisă cu minusculă.

`@instructions`
Rulează comanda:

```{shell}
head
```

fără argumente (astfel încât să aștepte o intrare care nu va veni niciodată),
apoi oprește-o tastând `Ctrl` + `C`.

`@hint`
Tastează head, apasă Enter și ieși din program cu `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Ați folosit `head`?")
```

---

## Recapitulare finală

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Pentru a încheia,
vei construi un pipeline care să afle câte înregistrări conține cel mai scurt fișier de date sezoniere.

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
Folosește `wc` cu parametrii potriviți pentru a lista numărul de linii din toate fișierele de date sezoniere.
(Folosește un wildcard pentru numele fișierelor, în loc să le tastezi pe toate manual.)

`@hint`
Folosește `-l` pentru a afișa doar numărul de linii și `*` pentru a potrivi numele fișierelor.

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
      has_code("wc", incorrect_msg = "Ați apelat `wc`?"),
      has_code("-l", incorrect_msg = "Ați numărat numărul de linii cu `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Ați obținut date din toate fișierele `seasonal/*`?")
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
Adaugă o altă comandă la cea anterioară, folosind un pipe pentru a elimina linia care conține cuvântul „total".

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
      has_code("wc", incorrect_msg = "Ați apelat `wc`?"),
      has_code("-l", incorrect_msg = "Ați numărat numărul de linii cu `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Ați obținut date din toate fișierele `seasonal/*`?"),
      has_code("|", incorrect_msg = "Ați redirecționat ieșirea din `wc` către `grep` folosind `|`?"),      
      has_code("grep", incorrect_msg = "Ați apelat `grep`?"),
      has_code("-v", incorrect_msg = "Ați inversat potrivirea cu `-v`?"),
      has_code("total", incorrect_msg = "Ați căutat `total`?")
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
Adaugă încă două etape în pipeline, folosind `sort -n` și `head -n 1`, pentru a găsi fișierul cu cel mai mic număr de linii.

`@hint`
- Folosește opțiunea `-n` a comenzii `sort` pentru a sorta numeric.
- Folosește opțiunea `-n` a comenzii `head` pentru a păstra doar 1 linie.

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
      has_code("wc", incorrect_msg = "Ați apelat `wc`?"),
      has_code("-l", incorrect_msg = "Ați numărat numărul de linii cu `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Ați obținut date din toate fișierele `seasonal/*`?"),
      has_code("|", incorrect_msg = "Ați redirecționat din `wc` către `grep`, apoi către `sort` și către `head` folosind `|`?"),      
      has_code("grep", incorrect_msg = "Ați apelat `grep`?"),
      has_code("-v", incorrect_msg = "Ați inversat potrivirea cu `-v`?"),
      has_code("total", incorrect_msg = "Ați căutat `total`?"),
      has_code("sort", incorrect_msg = "Ați apelat `sort`?"),
      has_code("-n", incorrect_msg = "Ați specificat numărul de linii de păstrat cu `-n`?"),
      has_code("1", incorrect_msg = "Ați specificat 1 linie de păstrat cu `-n 1`?")
    )
  )
)
Ex().success_msg("Excelent! Se pare că `autumn.csv` este fișierul cu cel mai mic număr de linii. Treceți la capitolul 4 pentru a afla mai multe despre procesarea în lot!")
```

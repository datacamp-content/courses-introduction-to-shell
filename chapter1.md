---
title: Manipularea fișierelor și directoarelor
description: >-
  Acest capitol este o scurtă introducere în shell-ul Unix. Vei afla de ce este
  încă folosit după aproape 50 de ani, cum se compară cu instrumentele grafice
  cu care ești poate mai familiarizat, cum să te deplasezi în shell și cum să
  creezi, modifici și ștergi fișiere și foldere.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Cum se compară shell-ul cu o interfață grafică?
---

## Cum se compară shell-ul cu o interfață grafică?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Un sistem de operare precum Windows, Linux sau Mac OS este un tip special de program.
Controlează procesorul, hard disk-ul și conexiunea la rețea ale calculatorului,
dar cel mai important rol al său este să ruleze alte programe.

Deoarece oamenii nu sunt digitali,
au nevoie de o interfață pentru a interacționa cu sistemul de operare.
Cea mai comună interfață în zilele noastre este un explorator grafic de fișiere,
care transformă clicurile și dublu-clicurile în comenzi pentru a deschide fișiere și a rula programe.
Înainte ca calculatoarele să aibă ecrane grafice,
însă,
oamenii introduceau instrucțiuni într-un program numit **shell de linie de comandă**.
De fiecare dată când este introdusă o comandă,
shell-ul rulează alte programe,
afișează rezultatele acestora într-un format lizibil
și afișează apoi un *prompt* pentru a semnala că este gata să primească următoarea comandă.
(Numele său vine din ideea că reprezintă „învelișul exterior" al calculatorului.)

Să tastezi comenzi în loc să dai clicuri și să tragi elemente poate părea incomod la început,
dar, după cum vei vedea,
odată ce începi să îi spui calculatorului exact ce vrei să facă,
poți combina comenzi existente pentru a crea unele noi
și automatiza operațiuni repetitive
cu doar câteva apăsări de taste.

<hr>
Care este relația dintre exploratorul grafic de fișiere pe care îl folosesc cei mai mulți oameni și shell-ul de linie de comandă?

`@hint`
Reține că un utilizator poate interacționa cu sistemul de operare doar printr-un program.

`@possible_answers`
- Exploratorul de fișiere îți permite să vizualizezi și să editezi fișiere, în timp ce shell-ul îți permite să rulezi programe.
- Exploratorul de fișiere este construit pe baza shell-ului.
- Shell-ul face parte din sistemul de operare, în timp ce exploratorul de fișiere este separat.
- [Ambele sunt interfețe pentru transmiterea comenzilor către sistemul de operare.]

`@feedback`
- Ambele îți permit să vizualizezi și să editezi fișiere și să rulezi programe.
- Atât exploratorii grafici de fișiere, cât și shell-ul apelează aceleași funcții ale sistemului de operare.
- Shell-ul și exploratorul de fișiere sunt ambele programe care traduc comenzile utilizatorului (tastate sau date cu clicuri) în apeluri către sistemul de operare.
- Corect! Ambele preiau comenzile utilizatorului (fie că sunt tastate, fie că sunt date cu clicuri) și le transmit sistemului de operare.

---

## Unde mă aflu?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**Sistemul de fișiere** gestionează fișierele și directoarele (sau folderele).
Fiecare este identificat printr-o **cale absolută**
care arată cum se ajunge la el din **directorul rădăcină** al sistemului de fișiere:
`/home/repl` este directorul `repl` din directorul `home`,
`/home/repl/course.txt` este un fișier `course.txt` din acel director,
iar `/` de sine stătător reprezintă directorul rădăcină.

Pentru a afla unde te afli în sistemul de fișiere,
rulează comanda `pwd`
(prescurtare de la "**p**rint **w**orking **d**irectory", adică „afișează directorul de lucru curent").
Aceasta afișează calea absolută a **directorului tău de lucru curent** –
locul în care shell-ul execută comenzile și caută fișierele în mod implicit.

<hr>
Rulează `pwd`.
Unde te afli acum?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Sistemele Unix plasează de obicei directoarele home ale utilizatorilor în `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Aceasta nu este calea corectă."
correct = "Corect - vă aflați în `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Cum pot identifica fișiere și directoare?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` îți arată unde te afli.
Pentru a vedea ce conține directorul curent,
tastează `ls` (prescurtare de la "**l**i**s**ting") și apasă tasta Enter.
Utilizat singur,
`ls` afișează conținutul directorului curent
(cel afișat de `pwd`).
Dacă adaugi numele unor fișiere,
`ls` le va lista,
iar dacă adaugi numele unor directoare,
va afișa conținutul acestora.
De exemplu,
`ls /home/repl` îți arată ce se află în directorul tău de pornire
(numit de obicei **directorul home**).

<hr>
Folosește `ls` cu un argument potrivit pentru a lista fișierele din directorul `/home/repl/seasonal`
(care conține informații despre intervenții dentare pe date, organizate pe sezoane).
Care dintre aceste fișiere *nu* se află în acel director?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Dacă îi dai lui `ls` o cale, îți arată ce se află la acea cale.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Acel fișier se află în directorul `seasonal`."
correct = "Corect - acel fișier *nu* se află în directorul `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Cum altfel pot identifica fișiere și directoare?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

O cale absolută este ca latitudinea și longitudinea: are aceeași valoare indiferent de unde ești. O **cale relativă**, în schimb, specifică o locație pornind de unde te afli: e ca și cum ai spune „20 de kilometri spre nord".

Câteva exemple:
- Dacă ești în directorul `/home/repl`, calea **relativă** `seasonal` specifică același director ca și calea **absolută** `/home/repl/seasonal`. 
- Dacă ești în directorul `/home/repl/seasonal`, calea **relativă** `winter.csv` specifică același fișier ca și calea **absolută** `/home/repl/seasonal/winter.csv`.

Shell-ul determină dacă o cale este absolută sau relativă uitându-se la primul caracter: dacă începe cu `/`, este absolută. Dacă *nu* începe cu `/`, este relativă.

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
Ești în `/home/repl`. Folosește `ls` cu o cale **relativă** pentru a lista fișierul cu calea absolută `/home/repl/course.txt` (și numai acel fișier).

`@hint`
Poți construi adesea calea relativă către un fișier sau director aflat sub locația ta curentă
scăzând calea absolută a locației tale curente
din calea absolută a elementului dorit.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Nu ați apelat `ls` pentru a genera lista de fișiere."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Comanda dumneavoastră nu a generat lista corectă de fișiere. Utilizați `ls` urmat de o cale relativă către `/home/repl/course.txt`.")
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
Ești în `/home/repl`.
Folosește `ls` cu o cale **relativă**
pentru a lista fișierul `/home/repl/seasonal/summer.csv` (și numai acel fișier).

`@hint`
Căile relative *nu* încep cu '/'.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Nu ați apelat `ls` pentru a genera lista de fișiere."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Comanda dumneavoastră nu a generat lista corectă de fișiere. Utilizați `ls` urmat de o cale relativă către `/home/repl/seasonal/summer.csv`.")
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
Ești în `/home/repl`.
Folosește `ls` cu o cale **relativă**
pentru a lista conținutul directorului `/home/repl/people`.

`@hint`
Căile relative nu încep cu '/'.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Nu ați apelat `ls` pentru a genera lista de fișiere."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Comanda dumneavoastră nu a generat lista corectă de fișiere. Utilizați `ls` urmat de o cale relativă către `/home/repl/people`.")
    )
)
Ex().success_msg("Bine făcut. Acum că știți cum să listați fișiere și directoare, să vedem cum vă puteți deplasa în sistemul de fișiere!")
```

---

## Cum mă deplasez într-un alt director?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Așa cum poți naviga într-un explorator de fișiere făcând dublu clic pe foldere,
poți naviga în sistemul de fișiere folosind comanda `cd`
(care vine de la „change directory", adică „schimbă directorul").

Dacă tastezi `cd seasonal` și apoi `pwd`,
shell-ul îți va arăta că te afli acum în `/home/repl/seasonal`.
Dacă rulezi apoi `ls` fără argumente,
îți va afișa conținutul directorului `/home/repl/seasonal`,
deoarece acolo te afli în acel moment.
Dacă vrei să te întorci la directorul tău home `/home/repl`,
poți folosi comanda `cd /home/repl`.

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
Te afli în `/home/repl`/.
Schimbă directorul la `/home/repl/seasonal` folosind o cale relativă.

`@hint`
Reține că `cd` vine de la „change directory" și că căile relative nu încep cu „/'.

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
key: e69c8eac15
xp: 35
```

`@instructions`
Folosește `pwd` pentru a verifica că te afli în directorul corect.

`@hint`
Nu uita să apeși „Enter" sau „Return" după ce introduci comanda.

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
Folosește `ls` fără nicio cale pentru a vedea conținutul acelui director.

`@hint`
Nu uita să apeși „Enter" sau „Return" după ce introduci comanda.

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
      has_code('ls', incorrect_msg="Comanda dvs. nu a generat rezultatul corect. Ați folosit `ls` fără căi pentru a afișa conținutul directorului curent?")
    )
)

Ex().success_msg("Excelent! Acesta a fost despre navigarea în subdirectoare. Dar despre deplasarea în sus? Să aflăm!")
```

---

## Cum pot urca un nivel în directoare?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

**Părintele** unui director este directorul aflat deasupra lui.
De exemplu, `/home` este părintele lui `/home/repl`,
iar `/home/repl` este părintele lui `/home/repl/seasonal`.
Poți folosi întotdeauna calea absolută a directorului părinte în comenzi precum `cd` și `ls`.
Cel mai adesea, însă, vei profita de faptul că calea specială `..`
(două puncte fără spații) înseamnă „directorul de deasupra celui în care mă aflu".
Dacă ești în `/home/repl/seasonal`,
atunci `cd ..` te mută în `/home/repl`.
Dacă folosești `cd ..` încă o dată,
ajungi în `/home`.
Încă un `cd ..` te duce în *directorul rădăcină* `/`,
care reprezintă cel mai înalt nivel al sistemului de fișiere.
(Nu uita să pui un spațiu între `cd` și `..` – este o comandă și o cale, nu o singură comandă de patru caractere.)

Un singur punct, `.`, înseamnă întotdeauna „directorul curent",
așa că `ls` singur și `ls .` fac același lucru,
în timp ce `cd .` nu are niciun efect
(pentru că te mută în directorul în care te afli deja).

O ultimă cale specială este `~` (caracterul tildă),
care înseamnă „directorul tău home",
de exemplu `/home/repl`.
Indiferent unde te afli,
`ls ~` va lista întotdeauna conținutul directorului tău home,
iar `cd ~` te va duce întotdeauna acasă.

<hr>
Dacă ești în `/home/repl/seasonal`,
unde te duce `cd ~/../.`?

`@hint`
Urmărește calea câte un director pe rând.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (directorul rădăcină)

`@feedback`
- Nu, dar `~` sau `..` singur te-ar duce acolo.
- Corect! Calea înseamnă „directorul home", „un nivel mai sus", „aici".
- Nu, dar `.` singur ar face asta.
- Nu, ultima parte a căii este `.` (adică „aici"), nu `..` (adică „un nivel mai sus").

---

## Cum pot copia fișiere?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

De multe ori vei dori să copiezi fișiere,
să le muți în alte directoare pentru a le organiza
sau să le redenumești.
Una dintre comenzile pentru asta este `cp`, prescurtare de la „copy" (copiere).
Dacă `original.txt` este un fișier existent,
atunci:

```{shell}
cp original.txt duplicate.txt
```

creează o copie a fișierului `original.txt` cu numele `duplicate.txt`.
Dacă există deja un fișier numit `duplicate.txt`,
acesta va fi suprascris.
Dacă ultimul parametru al comenzii `cp` este un director existent,
atunci o comandă de tipul:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

copiază *toate* fișierele specificate în acel director.

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
Creează o copie a fișierului `seasonal/summer.csv` în directorul `backup` (aflat tot în `/home/repl`),
numind noul fișier `summer.bck`.

`@hint`
Combină numele directorului destinație cu numele fișierului copiat
pentru a crea o cale relativă pentru noul fișier.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` nu pare să existe în directorul `backup`. Furnizați două căi către `cp`: fișierul existent (`seasonal/summer.csv`) și fișierul destinație (`backup/summer.bck`)."),
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
Copiază fișierele `spring.csv` și `summer.csv` din directorul `seasonal` în directorul `backup`,
*fără* a-ți schimba directorul de lucru curent (`/home/repl`).

`@hint`
Folosește `cp` cu numele fișierelor pe care vrei să le copiezi,
urmate de numele directorului în care să fie copiate.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` nu pare să fi fost copiat în directorul `backup`. Furnizați două nume de fișiere și un nume de director către `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Asigurați-vă că copiați fișierele în timp ce vă aflați în `{{dir}}`! Utilizați `cd {{dir}}` pentru a naviga înapoi acolo."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Bună treabă. Pe lângă copiere, ar trebui să putem și muta fișiere dintr-un director în altul. Aflați mai multe în exercițiul următor!")
```

---

## Cum pot muta un fișier?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

În timp ce `cp` copiază un fișier,
`mv` îl mută dintr-un director în altul,
la fel ca atunci când tragi un fișier în interfața grafică.
Comanda funcționează cu aceiași parametri ca `cp`,
așadar comanda:

```{shell}
mv autumn.csv winter.csv ..
```

mută fișierele `autumn.csv` și `winter.csv` din directorul de lucru curent
cu un nivel mai sus, în directorul părinte
(deoarece `..` se referă întotdeauna la directorul de deasupra locației tale curente).

`@instructions`
Te afli în `/home/repl`, care conține subdirectoarele `seasonal` și `backup`.
Folosind o singură comandă, mută `spring.csv` și `summer.csv` din `seasonal` în `backup`.

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
backup_patt="Fișierul `%s` nu se află în directorul `backup`. Ați folosit `mv` corect? Utilizați două nume de fișiere și un director ca parametri pentru `mv`."
seasonal_patt="Fișierul `%s` se află încă în directorul `seasonal`. Asigurați-vă că mutați fișierele cu `mv` în loc să le copiați cu `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Bine făcut, să continuăm cu acest tren al comenzilor shell!")
```

---

## Cum pot redenumi fișiere?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` poate fi folosit și pentru a redenumi fișiere. Dacă rulezi:

```{shell}
mv course.txt old-course.txt
```

atunci fișierul `course.txt` din directorul de lucru curent este „mutat" în fișierul `old-course.txt`.
Acesta este un comportament diferit față de cel al managerelor de fișiere grafice,
dar este adesea foarte util.

O atenționare importantă:
la fel ca `cp`,
`mv` va suprascrie fișierele existente.
Dacă,
de exemplu,
există deja un fișier numit `old-course.txt`,
comanda de mai sus îl va înlocui cu conținutul din `course.txt`.

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
Navighează în directorul `seasonal`.

`@hint`
Reține că `cd` înseamnă „change directory" și că căile relative nu încep cu '/'.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
Redenumiește fișierul `winter.csv` în `winter.csv.bck`.

`@hint`
Folosește `mv` cu numele actual al fișierului urmat de numele dorit, în această ordine.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Utilizați `mv` cu două argumente: fișierul pe care doriți să îl redenumiți (`winter.csv`) și noul nume pentru fișier (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Ne așteptam să găsim `winter.csv.bck` în director." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Nu ne mai așteptam ca `winter.csv` să fie în director." + hint)
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
Rulează `ls` pentru a verifica că totul a funcționat corect.

`@hint`
Nu uita să apeși „Enter" sau „Return" pentru a rula comanda.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Ați folosit `ls` pentru a lista conținutul directorului de lucru curent?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Comanda dvs. nu a generat listarea corectă a fișierelor. Utilizați `ls` fără argumente pentru a lista conținutul directorului de lucru curent.")
    )
)
Ex().success_msg("Copiere, mutare, redenumire, le-ați înțeles pe toate! Urmează: ștergerea fișierelor.")
```

---

## Cum pot șterge fișiere?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Putem copia fișiere și le putem muta;
pentru a le șterge,
folosim `rm`,
care provine de la "remove" (eliminare).
Ca și în cazul `cp` și `mv`,
poți furniza lui `rm` oricâte nume de fișiere dorești, de exemplu:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

șterge atât `thesis.txt`, cât și `backup/thesis-2017-08.txt`.

`rm` face exact ce îi spune numele,
și o face imediat:
spre deosebire de browserele grafice de fișiere,
shell-ul nu are un coș de gunoi,
așadar când introduci comanda de mai sus,
lucrarea ta dispare definitiv.

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
Te afli în `/home/repl`.
Navighează în directorul `seasonal`.

`@hint`
Reține că `cd` înseamnă "change directory" și că o cale relativă nu începe cu '/'.

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
Șterge fișierul `autumn.csv`.

`@hint`
Reține că `rm` înseamnă "remove" (eliminare).

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Nu ne așteptam ca `autumn.csv` să mai fie în directorul `seasonal`. Utilizați `rm` cu calea către fișierul pe care doriți să îl eliminați."),
    has_code('rm', incorrect_msg = 'Utilizați `rm` pentru a elimina fișierul, în loc să îl mutați.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Întoarce-te în directorul home.

`@hint`
Dacă folosești `cd` fără niciun argument, te duce în directorul home.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Utilizați `cd ..` sau `cd ~` pentru a reveni la directorul principal.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Șterge `seasonal/summer.csv` fără a mai schimba directorul.

`@hint`
Reține că `rm` înseamnă "remove" (eliminare).

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Nu ne așteptam ca `summer.csv` să mai fie în directorul `seasonal`. Utilizați `rm` cu calea către fișierul pe care doriți să îl eliminați."),
    has_code('rm', incorrect_msg = 'Utilizați `rm` pentru a elimina fișierul, în loc să îl mutați.')
)
Ex().success_msg("Impresionant! Trecem la următorul!")
```

---

## Cum pot crea și șterge directoare?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` tratează directoarele la fel ca fișierele:
dacă te afli în directorul tău home și rulezi `mv seasonal by-season`,
de exemplu,
`mv` schimbă numele directorului `seasonal` în `by-season`.
Însă `rm` se comportă diferit.

Dacă încerci să ștergi un director cu `rm`,
shell-ul afișează un mesaj de eroare care îți spune că nu poate face asta –
in principal pentru a te împiedica să ștergi accidental un întreg director plin de fișiere.
În schimb, poți folosi o comandă separată numită `rmdir`.
Pentru siguranță suplimentară,
această comandă funcționează doar când directorul este gol,
așadar trebuie să ștergi fișierele dintr-un director *înainte* de a șterge directorul în sine.
(Utilizatorii experimentați pot folosi opțiunea `-r` pentru `rm` pentru a obține același efect;
opțiunile comenzilor vor fi discutate în capitolul următor.)

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
Fără a schimba directorul curent,
șterge fișierul `agarwal.txt` din directorul `people`.

`@hint`
Reține că `rm` înseamnă „remove" (șterge) și că o cale relativă nu începe cu '/'.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` nu ar mai trebui să fie în `/home/repl/people`. Ați folosit `rm` corect?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'Mai există fișiere în directorul `people`. Dacă ați mutat pur și simplu `agarwal.txt` sau ați creat fișiere noi, ștergeți-le pe toate.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Acum că directorul `people` este gol,
folosește o singură comandă pentru a-l șterge.

`@hint`
Reține că `rm` funcționează doar pentru fișiere.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "Directorul 'people' nu ar mai trebui să se afle în directorul dvs. de acasă. Utilizați `rmdir` pentru a-l elimina!")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Deoarece un director nu este un fișier,
trebuie să folosești comanda `mkdir directory_name`
pentru a crea un director nou (gol).
Folosește această comandă pentru a crea un director nou numit `yearly` în directorul tău home.

`@hint`
Rulează `mkdir` cu numele directorului pe care vrei să îl creezi.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Nu există niciun director `yearly` în directorul dvs. principal. Utilizați `mkdir yearly` pentru a crea unul!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Acum că `yearly` există,
creează un alt director numit `2017` în interiorul său
*fără* a părăsi directorul tău home.

`@hint`
Folosește o cale relativă pentru subdirectorul pe care vrei să îl creezi.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Nu se poate găsi un director '2017' în '/home/repl/yearly'. Puteți crea acest director folosind calea relativă `yearly/2017`.")
)
Ex().success_msg("Excelent! Să încheiem acest capitol cu un exercițiu care repetă câteva dintre conceptele sale!")
```

---

## Recapitulare

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Când analizezi date, vei crea adesea fișiere intermediare.
În loc să le stochezi în directorul tău home,
le poți plasa în `/tmp`,
unde oamenii și programele păstrează de obicei fișierele de care au nevoie doar pentru scurt timp.
(Reține că `/tmp` se află imediat sub directorul rădăcină `/`,
*nu* sub directorul tău home.)
Acest exercițiu de recapitulare îți va arăta cum să faci asta.

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
Folosește `cd` pentru a naviga în `/tmp`.

`@hint`
Ține minte că `cd` înseamnă „change directory" și că o cale absolută începe cu „/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Vă aflați în directorul greșit. Utilizați `cd` pentru a schimba directorul în `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Listează conținutul directorului `/tmp` *fără* a introduce un nume de director.

`@hint`
Dacă nu îi specifici lui `ls` ce să listeze, afișează conținutul directorului curent.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Nu ați apelat `ls` pentru a genera lista de fișiere."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Comanda dvs. nu a generat lista corectă de fișiere. Utilizați `ls` fără`.")
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
Creează un director nou în `/tmp` numit `scratch`.

`@hint`
Folosește `mkdir` pentru a crea directoare.

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
      has_code('mkdir +scratch', incorrect_msg="Nu se poate găsi un director 'scratch' în '/tmp'. Asigurați-vă că utilizați corect comanda `mkdir`.")
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
Mută `/home/repl/people/agarwal.txt` în `/tmp/scratch`.
Îți recomandăm să folosești comanda rapidă `~` pentru directorul tău home și o cale relativă pentru al doilea argument, în loc de calea absolută.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Nu se poate găsi 'agarwal.txt' în '/tmp/scratch'. Utilizați `mv` cu `~/people/agarwal.txt` ca primul parametru și `scratch` ca al doilea.")
)
Ex().success_msg("Aceasta încheie Capitolul 1 din Introducere în Shell! Treceți la următorul capitol pentru a afla mai multe despre manipularea datelor!")
```

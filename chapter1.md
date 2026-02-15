---
title: Bestanden en mappen beheren
description: >-
  Dit hoofdstuk is een korte introductie tot de Unix-shell. Je leert waarom die
  na bijna 50 jaar nog steeds wordt gebruikt, hoe die zich verhoudt tot de
  grafische tools die je misschien gewend bent, hoe je in de shell navigeert en
  hoe je bestanden en mappen maakt, wijzigt en verwijdert.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Hoe verhoudt de shell zich tot een desktopinterface?
---

## Hoe verhoudt de shell zich tot een desktopinterface?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Een besturingssysteem zoals Windows, Linux of Mac OS is een speciaal soort programma.
Het stuurt de processor, harde schijf en netwerkverbinding van de computer aan,
maar zijn belangrijkste taak is het uitvoeren van andere programma's.

Omdat mensen niet digitaal zijn,
hebben ze een interface nodig om met het besturingssysteem te werken.
De meest gebruikelijke tegenwoordig is een grafische bestandsverkenner,
die klikken en dubbelklikken vertaalt naar opdrachten om bestanden te openen en programma's te starten.
Voordat computers grafische schermen hadden,
typten mensen instructies in een programma dat een **command-line shell** werd genoemd.
Elke keer dat een opdracht wordt ingevoerd,
start de shell andere programma's,
druk hun uitvoer af in een voor mensen leesbare vorm,
en toont vervolgens een *prompt* als signaal dat hij klaar is voor de volgende opdracht.
(De naam komt van het idee dat het de "buitenschil" van de computer is.)

Opdrachten typen in plaats van klikken en slepen lijkt in het begin misschien onhandig,
maar zoals je zult zien,
zodra je expliciet aangeeft wat je de computer wilt laten doen,
kun je oude opdrachten combineren om nieuwe te maken
en repetitieve handelingen automatiseren
met slechts een paar toetsaanslagen.

<hr>
Wat is de relatie tussen de grafische bestandsverkenner die de meeste mensen gebruiken en de command-line shell?

`@hint`
Onthoud dat een gebruiker alleen via een programma met een besturingssysteem kan communiceren.

`@possible_answers`
- De bestandsverkenner laat je bestanden bekijken en bewerken, terwijl de shell je programma's laat uitvoeren.
- De bestandsverkenner is boven op de shell gebouwd.
- De shell is onderdeel van het besturingssysteem, terwijl de bestandsverkenner losstaat.
- [Het zijn allebei interfaces om opdrachten aan het besturingssysteem te geven.]

`@feedback`
- Beide laten je bestanden bekijken en bewerken en programma's uitvoeren.
- Grafische bestandsverkenners en de shell roepen allebei dezelfde onderliggende functies van het besturingssysteem aan.
- De shell en de bestandsverkenner zijn allebei programma's die gebruikersopdrachten (getypt of geklikt) vertalen naar aanroepen van het besturingssysteem.
- Goed zo! Beide nemen de opdrachten van de gebruiker (of ze nu getypt of geklikt zijn) en sturen die door naar het besturingssysteem.

---

## Waar ben ik?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

Het **bestandssysteem** beheert bestanden en mappen (of folders).
Elk element heeft een **absoluut pad**
dat laat zien hoe je er komt vanaf de **rootmap** van het bestandssysteem:
`/home/repl` is de map `repl` in de map `home`,
terwijl `/home/repl/course.txt` het bestand `course.txt` in die map is,
en `/` op zichzelf is de rootmap.

Om te zien waar je je in het bestandssysteem bevindt,
voer je het commando `pwd` uit
(kort voor "**p**rint **w**orking **d**irectory").
Dit toont het absolute pad van je **huidige werkmap**,
waar de shell standaard commando’s uitvoert en naar bestanden zoekt.

<hr>
Voer `pwd` uit.
Waar ben je nu?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix-systemen plaatsen doorgaans de thuismappen van alle gebruikers onder `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Dat is niet het juiste pad."
correct = "Correct - je bent in `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Hoe kan ik bestanden en mappen herkennen?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` vertelt je waar je bent.
Om te zien wat daar staat,
typ je `ls` (dat staat voor "**l**i**s**ting") en druk je op Enter.
Op zichzelf
lijst `ls` de inhoud van je huidige map op
(de map die `pwd` toont).
Als je de namen van enkele bestanden toevoegt,
laat `ls` die zien,
en als je de namen van mappen toevoegt,
laat het hun inhoud zien.
Bijvoorbeeld,
`ls /home/repl` toont wat er in je startmap staat
(meestal je **home directory** genoemd).

<hr>
Gebruik `ls` met een geschikt argument om de bestanden in de map `/home/repl/seasonal` weer te geven
(die informatie over tandheelkundige ingrepen per datum bevat, uitgesplitst per seizoen).
Welk van deze bestanden staat *niet* in die map?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Als je `ls` een pad meegeeft, laat het zien wat er in dat pad staat.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Dat bestand staat in de map `seasonal`."
correct = "Correct - dat bestand staat *niet* in de map `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Hoe kan ik bestanden en mappen nog meer identificeren?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Een absoluut pad is als breedte- en lengtegraad: het heeft overal dezelfde waarde, ongeacht waar je bent. Een **relatief pad** daarentegen geeft een locatie aan vanaf waar jij je nu bevindt: het is alsof je zegt: "20 kilometer naar het noorden".

Als voorbeelden:
- Als je in de map `/home/repl` bent, verwijst het **relatieve** pad `seasonal` naar dezelfde map als het **absolute** pad `/home/repl/seasonal`. 
- Als je in de map `/home/repl/seasonal` bent, verwijst het **relatieve** pad `winter.csv` naar hetzelfde bestand als het **absolute** pad `/home/repl/seasonal/winter.csv`.

De shell bepaalt of een pad absoluut of relatief is door naar het eerste teken te kijken: als het begint met `/`, is het absoluut. Als het *niet* met `/` begint, is het relatief.

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
Je bent in `/home/repl`. Gebruik `ls` met een **relatief pad** om het bestand met het absolute pad `/home/repl/course.txt` te tonen (en alleen dat bestand).

`@hint`
Je kunt het relatieve pad naar een bestand of map onder je huidige locatie vaak construeren door het absolute pad van je huidige locatie af te trekken van het absolute pad van wat je wilt bereiken.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Je hebt `ls` niet aangeroepen om de bestandslijst te genereren."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Je commando heeft niet de juiste bestandslijst gegenereerd. Gebruik `ls` gevolgd door een relatief pad naar `/home/repl/course.txt`.")
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
Je bent in `/home/repl`.
Gebruik `ls` met een **relatief** pad
om het bestand `/home/repl/seasonal/summer.csv` te tonen (en alleen dat bestand).

`@hint`
Relatieve paden beginnen *niet* met een voorloop-‘/’.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Je hebt `ls` niet aangeroepen om de bestandslijst te genereren."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Je commando genereerde niet de juiste bestandslijst. Gebruik `ls` gevolgd door een relatief pad naar `/home/repl/seasonal/summer.csv`.")
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
Je bent in `/home/repl`.
Gebruik `ls` met een **relatief** pad
om de inhoud van de map `/home/repl/people` te tonen.

`@hint`
Relatieve paden beginnen niet met een voorloop-‘/’.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Je hebt `ls` niet aangeroepen om de bestandslijst te genereren."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Je opdracht heeft niet de juiste bestandslijst gegenereerd. Gebruik `ls` gevolgd door een relatief pad naar `/home/repl/people`.")
    )
)
Ex().success_msg("Goed gedaan. Nu je weet hoe je bestanden en mappen kunt weergeven, laten we eens kijken hoe je door het bestandssysteem kunt navigeren!")
```

---

## Hoe ga ik naar een andere map?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Net zoals je in een bestandsbeheerder door mappen klikt om te navigeren,
kun je je in het bestandssysteem verplaatsen met het commando `cd`
(dat staat voor "change directory").

Als je `cd seasonal` typt en daarna `pwd`,
dan vertelt de shell je dat je nu in `/home/repl/seasonal` bent.
Voer je vervolgens `ls` los uit,
dan zie je de inhoud van `/home/repl/seasonal`,
omdat je daar bent.
Wil je terug naar je home-directory `/home/repl`,
dan kun je `cd /home/repl` gebruiken.

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
Je bent in `/home/repl`.
Ga met een relatief pad naar `/home/repl/seasonal`.

`@hint`
Onthoud dat `cd` staat voor "change directory" en dat relatieve paden niet beginnen met een voorloop '/'.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Als je huidige werkmap (vind het uit met `pwd`) `/home/repl` is, kun je naar de map `seasonal` gaan met `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: e69c8eac15
xp: 35
```

`@instructions`
Gebruik `pwd` om te controleren dat je daar bent.

`@hint`
Vergeet niet op "enter" of "return" te drukken nadat je het commando hebt ingevoerd.

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
Gebruik `ls` zonder paden om te zien wat er in die map staat.

`@hint`
Vergeet niet op "enter" of "return" te drukken na het commando.

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
      has_code('ls', incorrect_msg="Je opdracht genereerde niet de juiste output. Heb je `ls` zonder paden gebruikt om de inhoud van de huidige directory te tonen?")
    )
)

Ex().success_msg("Netjes! Dit ging over navigeren naar subdirectories. Maar hoe zit het met omhoog gaan? Laten we dat ontdekken!")
```

---

## Hoe ga ik een map omhoog?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

De **parent** van een map is de map die er boven ligt.
Zo is `/home` de parent van `/home/repl`,
en is `/home/repl` de parent van `/home/repl/seasonal`.
Je kunt altijd het absolute pad van je bovenliggende map gebruiken bij opdrachten als `cd` en `ls`.
Vaker
maak je echter gebruik van het feit dat het speciale pad `..`
(twee punten zonder spaties) betekent: "de map boven de map waarin ik nu zit".
Als je in `/home/repl/seasonal` zit,
brengt `cd ..` je omhoog naar `/home/repl`.
Als je nog eens `cd ..` gebruikt,
kom je in `/home` terecht.
Nog een `cd ..` zet je in de *root-directory* `/`,
het allerhoogste niveau van het bestandssysteem.
(Denk eraan om een spatie te zetten tussen `cd` en `..` - het is een opdracht en een pad, niet één enkel vierletterwoord.)

Eén enkele punt, `.`, betekent altijd "de huidige map",
dus `ls` op zichzelf en `ls .` doen hetzelfde,
terwijl `cd .` geen effect heeft
(omdat je dan naar de map gaat waar je al in zit).

Een laatste speciaal pad is `~` (het tilde-teken),
wat "je home-directory" betekent,
bijvoorbeeld `/home/repl`.
Waar je ook bent,
`ls ~` toont altijd de inhoud van je home-directory,
en `cd ~` brengt je altijd naar huis.

<hr>
Als je in `/home/repl/seasonal` zit,
waar brengt `cd ~/../.` je naartoe?

`@hint`
Volg het pad stap voor stap, één map tegelijk.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (de root-directory)

`@feedback`
- Nee, maar met alleen `~` of `..` kom je daar ook.
- Klopt! Het pad betekent 'home-directory', 'één niveau omhoog', 'hier'.
- Nee, maar `.` op zichzelf zou dat doen.
- Nee, het laatste deel van het pad is `.` (betekent "hier") en niet `..` (betekent "omhoog").

---

## Hoe kan ik bestanden kopiëren?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Je wilt vaak bestanden kopiëren,
ze naar andere mappen verplaatsen om te ordenen,
of ze hernoemen.
Eén opdracht hiervoor is `cp`, wat staat voor "copy".
Als `original.txt` een bestaand bestand is,
dan:

```{shell}
cp original.txt duplicate.txt
```

maakt een kopie van `original.txt` met de naam `duplicate.txt`.
Als er al een bestand `duplicate.txt` bestond,
wordt het overschreven.
Als de laatste parameter van `cp` een bestaande map is,
dan kopieert een opdracht zoals:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

*alle* bestanden naar die map.

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
Maak een kopie van `seasonal/summer.csv` in de map `backup` (die ook in `/home/repl` staat),
en noem het nieuwe bestand `summer.bck`.

`@hint`
Combineer de naam van de doelmap en de naam van het gekopieerde bestand
om een relatief pad voor het nieuwe bestand te maken.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` lijkt niet te bestaan in de `backup`-map. Geef twee paden aan `cp`: het bestaande bestand (`seasonal/summer.csv`) en het bestemmingsbestand (`backup/summer.bck`)."),
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
Kopieer `spring.csv` en `summer.csv` uit de map `seasonal` naar de map `backup`
*zonder* je huidige werkmap (`/home/repl`) te veranderen.

`@hint`
Gebruik `cp` met de namen van de bestanden die je wilt kopiëren
en *daarna* de naam van de map waarnaar je ze wilt kopiëren.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` lijkt niet te zijn gekopieerd naar de `backup` directory. Geef twee bestandsnamen en een directorynaam aan `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Zorg ervoor dat je de bestanden kopieert terwijl je in `{{dir}}` bent! Gebruik `cd {{dir}}` om daar terug te navigeren."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Goed gedaan. Naast kopiëren moeten we ook bestanden van de ene directory naar de andere kunnen verplaatsen. Leer erover in de volgende oefening!")
```

---

## Hoe verplaats ik een bestand?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

`cp` kopieert een bestand,
`mv` verplaatst het van de ene map naar de andere,
net alsof je het sleept in een grafische bestandsbrowser.
De parameters werken hetzelfde als bij `cp`,
dus de opdracht:

```{shell}
mv autumn.csv winter.csv ..
```

verplaatst de bestanden `autumn.csv` en `winter.csv` vanuit de huidige werkmap
één niveau omhoog naar de bovenliggende map
(omdat `..` altijd verwijst naar de map boven je huidige locatie).

`@instructions`
Je bent in `/home/repl`, met de submappen `seasonal` en `backup`.
Verplaats met één opdracht `spring.csv` en `summer.csv` van `seasonal` naar `backup`.

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
backup_patt="Het bestand `%s` staat niet in de map `backup`. Heb je `mv` correct gebruikt? Gebruik twee bestandsnamen en een map als parameters voor `mv`."
seasonal_patt="Het bestand `%s` staat nog steeds in de map `seasonal`. Zorg ervoor dat je de bestanden verplaatst met `mv` in plaats van ze te kopiëren met `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Goed gedaan, laten we deze shell-trein laten doorgaan!")
```

---

## Hoe kan ik bestanden hernoemen?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` kun je ook gebruiken om bestanden een andere naam te geven. Als je het volgende uitvoert:

```{shell}
mv course.txt old-course.txt
```

wordt het bestand `course.txt` in de huidige werkmap "verplaatst" naar het bestand `old-course.txt`.
Dat werkt anders dan in veel bestandsbrowsers,
maar is vaak handig.

Eén waarschuwing:
net als `cp`
overschrijft `mv` bestaande bestanden.
Als je
bijvoorbeeld
al een bestand hebt met de naam `old-course.txt`,
dan vervangt de bovenstaande opdracht het door de inhoud van `course.txt`.

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
Ga naar de map `seasonal`.

`@hint`
Onthoud dat `cd` staat voor "change directory" en dat relatieve paden niet beginnen met een voorloopteken '/'.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Als je huidige werkmap (vind het uit met `pwd`) `/home/repl` is, kun je naar de map `seasonal` gaan met `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: ed5fe1df23
xp: 35
```

`@instructions`
Hernoem het bestand `winter.csv` naar `winter.csv.bck`.

`@hint`
Gebruik `mv` met eerst de huidige bestandsnaam en daarna de naam die je wilt geven, in die volgorde.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Gebruik `mv` met twee argumenten: het bestand dat je wilt hernoemen (`winter.csv`) en de nieuwe naam voor het bestand (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="We verwachtten `winter.csv.bck` in de map te vinden." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="We verwachtten niet langer `winter.csv` in de map te vinden." + hint)
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
Voer `ls` uit om te controleren of alles is gelukt.

`@hint`
Vergeet niet op "enter" of "return" te drukken om de opdracht uit te voeren.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Heb je `ls` gebruikt om de inhoud van je huidige werkdirectory te tonen?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Je commando genereerde niet de juiste bestandslijst. Gebruik `ls` zonder argumenten om de inhoud van je huidige werkdirectory te tonen.")
    )
)
Ex().success_msg("Kopiëren, verplaatsen, hernoemen, je hebt het allemaal onder de knie! Volgende: bestanden verwijderen.")
```

---

## Hoe kan ik bestanden verwijderen?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

We kunnen bestanden kopiëren en verplaatsen;
om ze te verwijderen,
gebruiken we `rm`,
dat staat voor "remove" (verwijderen).
Net als bij `cp` en `mv`
kun je `rm` de namen van zoveel bestanden geven als je wilt, dus:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

verwijdert zowel `thesis.txt` als `backup/thesis-2017-08.txt`

`rm` doet precies wat de naam zegt,
en het gebeurt meteen:
in tegenstelling tot grafische bestandsbeheerders
heeft de shell geen prullenbak,
dus als je de bovenstaande opdracht typt,
is je scriptie definitief weg.

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
Je bent in `/home/repl`.
Ga naar de map `seasonal`.

`@hint`
Onthoud dat `cd` staat voor "change directory" en dat een relatief pad niet begint met een schuine streep '/'.

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
Verwijder `autumn.csv`.

`@hint`
Onthoud dat `rm` staat voor "remove".

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="We hadden niet verwacht dat `autumn.csv` nog in de `seasonal` map zou staan. Gebruik `rm` met het pad naar het bestand dat je wilt verwijderen."),
    has_code('rm', incorrect_msg = 'Gebruik `rm` om het bestand te verwijderen, in plaats van het te verplaatsen.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Ga terug naar je homedirectory.

`@hint`
Als je `cd` zonder pad gebruikt, ga je naar je homedirectory.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Gebruik `cd ..` of `cd ~` om terug te keren naar de home directory.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Verwijder `seasonal/summer.csv` zonder opnieuw van map te wisselen.

`@hint`
Onthoud dat `rm` staat voor "remove".

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="We hadden niet verwacht dat `summer.csv` nog steeds in de `seasonal` directory zou staan. Gebruik `rm` met het pad naar het bestand dat je wilt verwijderen."),
    has_code('rm', incorrect_msg = 'Gebruik `rm` om het bestand te verwijderen, in plaats van het te verplaatsen.')
)
Ex().success_msg("Indrukwekkend spul! Op naar de volgende!")
```

---

## Hoe maak en verwijder ik mappen?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` behandelt mappen hetzelfde als bestanden:
als je in je thuismap bent en `mv seasonal by-season` uitvoert,
bijvoorbeeld,
verandert `mv` de naam van de map `seasonal` in `by-season`.
`rm` werkt echter anders.

Als je probeert een map te `rm`'en,
print de shell een foutmelding dat dit niet kan,
vooral om te voorkomen dat je per ongeluk een hele map vol werk verwijdert.
In plaats daarvan
kun je een aparte opdracht gebruiken: `rmdir`.
Voor extra veiligheid
werkt die alleen als de map leeg is,
dus moet je de bestanden in een map verwijderen *voordat* je de map zelf verwijdert.
(Gevorderde gebruikers kunnen de optie `-r` bij `rm` gebruiken om hetzelfde effect te krijgen;
we bespreken opties voor opdrachten in het volgende hoofdstuk.)

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
Zonder van map te veranderen,
verwijder het bestand `agarwal.txt` in de map `people`.

`@hint`
Onthoud dat `rm` staat voor "remove" en dat een relatief pad niet begint met een voorloop-‘/’.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` zou niet langer in `/home/repl/people` moeten zijn. Heb je `rm` correct gebruikt?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'Er staan nog steeds bestanden in de `people` directory. Als je `agarwal.txt` gewoon hebt verplaatst, of nieuwe bestanden hebt aangemaakt, verwijder ze dan allemaal.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Nu de map `people` leeg is,
verwijder je die met één opdracht.

`@hint`
Onthoud dat `rm` alleen werkt op bestanden.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "De 'people'-directory zou niet langer in je home-directory moeten staan. Gebruik `rmdir` om het te verwijderen!")
)

```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Omdat een map geen bestand is,
moet je de opdracht `mkdir directory_name` gebruiken
om een nieuwe (lege) map te maken.
Gebruik deze opdracht om een nieuwe map `yearly` te maken onder je thuismap.

`@hint`
Voer `mkdir` uit met de naam van de map die je wilt maken.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Er is geen `yearly`-map in je home directory. Gebruik `mkdir yearly` om er een te maken!")
)

```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Nu `yearly` bestaat,
maak je daarin nog een map met de naam `2017`,
*zonder* je thuismap te verlaten.

`@hint`
Gebruik een relatief pad voor de submap die je wilt maken.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Kan geen '2017' map vinden in '/home/repl/yearly'. Je kunt deze map maken met het relatieve pad `yearly/2017`.")
)
Ex().success_msg("Cool! Laten we dit hoofdstuk afsluiten met een oefening die enkele van de concepten herhaalt!")
```

---

## Afronden

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Tijdens data-analyse maak je vaak tijdelijke bestanden.
In plaats van ze in je persoonlijke map op te slaan,
kun je ze in `/tmp` zetten,
waar mensen en programma's vaak bestanden bewaren die ze maar kort nodig hebben.
(Let op: `/tmp` staat direct onder de rootmap `/`,
*niet* onder je persoonlijke map.)
In deze afsluitoefening zie je hoe je dat doet.

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
Gebruik `cd` om naar `/tmp` te gaan.

`@hint`
Onthoud dat `cd` staat voor "change directory" en dat een absoluut pad begint met een '/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Je zit in de verkeerde map. Gebruik `cd` om naar de map `/tmp` te gaan.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Toon de inhoud van `/tmp` *zonder* een mapnaam te typen.

`@hint`
Als je `ls` niet vertelt wat het moet weergeven, laat het zien wat er in je huidige map staat.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Je hebt `ls` niet aangeroepen om de bestandslijst te genereren."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Je commando genereerde niet de juiste bestandslijst. Gebruik `ls` zonder iets anders.")
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
Maak binnen `/tmp` een nieuwe map met de naam `scratch`.

`@hint`
Gebruik `mkdir` om mappen te maken.

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
      has_code('mkdir +scratch', incorrect_msg="Kan geen 'scratch'-directory vinden onder '/tmp'. Zorg ervoor dat je `mkdir` correct gebruikt.")
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
Verplaats `/home/repl/people/agarwal.txt` naar `/tmp/scratch`.
We raden aan de snelkoppeling `~` voor je persoonlijke map te gebruiken en voor het tweede pad een relatief pad in plaats van het absolute pad.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Kan 'agarwal.txt' niet vinden in '/tmp/scratch'. Gebruik `mv` met `~/people/agarwal.txt` als de eerste parameter en `scratch` als de tweede.")
)
Ex().success_msg("Dit is het einde van Hoofdstuk 1 van Inleiding tot Shell! Ga snel naar het volgende hoofdstuk om meer te leren over het manipuleren van data!")
```

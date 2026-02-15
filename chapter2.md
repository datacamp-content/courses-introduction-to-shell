---
title: Gegevens bewerken
description: >-
  Met de opdrachten uit het vorige hoofdstuk kon je dingen verplaatsen in het
  bestandssysteem. In dit hoofdstuk leer je werken met de gegevens in die
  bestanden. De tools die we gebruiken zijn vrij eenvoudig, maar vormen wel
  stevige bouwstenen.
lessons:
  - nb_of_exercises: 12
    title: Hoe kan ik de inhoud van een bestand bekijken?
---

## Hoe kan ik de inhoud van een bestand bekijken?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Voordat je bestanden hernoemt of verwijdert,
wil je misschien eerst hun inhoud bekijken.
De eenvoudigste manier is met `cat`,
dat gewoon de inhoud van bestanden op het scherm afdrukt.
(De naam is een afkorting van "concatenate", wat "dingen aan elkaar koppelen" betekent,
omdat het alle bestanden waarvan je de naam meegeeft achter elkaar afdrukt.)

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
Druk de inhoud van `course.txt` op het scherm af.

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
    has_expr_output(incorrect_msg="Je opdracht genereerde niet de juiste output. Heb je `cat` gevolgd door de naam van het bestand, `course.txt`, gebruikt?")
)
Ex().success_msg("Mooi! Laten we naar andere manieren kijken om de inhoud van een bestand te bekijken.")
```

---

## Hoe kan ik de inhoud van een bestand stukje voor stukje bekijken?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Je kunt `cat` gebruiken om grote bestanden te printen en dan door de uitvoer te scrollen,
maar het is meestal handiger om de uitvoer te **pagineren**.
De oorspronkelijke opdracht hiervoor heette `more`,
maar die is vervangen door een krachtigere opdracht met de naam `less`.
(Dit soort naamgeving geldt als humor in de Unix-wereld.)
Als je `less` op een bestand gebruikt,
zie je telkens één pagina;
je kunt met de spatiebalk naar beneden bladeren of `q` typen om af te sluiten.

Als je `less` de namen van meerdere bestanden geeft,
kun je `:n` (dubbele punt en een kleine 'n') typen om naar het volgende bestand te gaan,
`:p` om terug te gaan naar het vorige,
of `:q` om te stoppen.

Let op: als je oplossingen bekijkt voor oefeningen die `less` gebruiken,
zie je aan het einde een extra opdracht die het pagineren *uit* zet,
zodat we je oplossingen efficiënt kunnen testen.

`@instructions`
Gebruik `less seasonal/spring.csv seasonal/summer.csv` om die twee bestanden in die volgorde te bekijken.
Druk op de spatiebalk om naar beneden te bladeren, `:n` om naar het tweede bestand te gaan en `:q` om af te sluiten.

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
                 incorrect_msg='Gebruik `less` en de bestandsnamen. Vergeet niet dat `:n` je naar het volgende bestand brengt.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Hoe kan ik het begin van een bestand bekijken?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Het eerste wat de meeste data scientists doen met een nieuwe gegevensset is
bekijken welke velden erin zitten en welke waarden die velden hebben.
Als de gegevensset uit een database of spreadsheet is geëxporteerd,
wordt die vaak opgeslagen als **comma-separated values** (CSV).
Een snelle manier om te zien wat erin staat, is de eerste paar rijen bekijken.

Dat kan in de shell met een opdracht genaamd `head`.
Zoals de naam al aangeeft,
die print de eerste paar regels van een bestand
(waarbij "een paar" 10 betekent),
dus de opdracht:

```{shell}
head seasonal/summer.csv
```

geeft weer:

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

Wat doet `head` als er geen 10 regels in het bestand staan?
(Om dat te ontdekken, gebruik het om naar de bovenkant van `people/agarwal.txt` te kijken.)

`@possible_answers`
- Een foutmelding geven omdat het bestand te kort is.
- Zoveel regels weergeven als er zijn.
- Genoeg lege regels tonen om het totaal op 10 te brengen.

`@hint`
Wat is het nuttigste dat het zou kunnen doen?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Onjuist: dat is niet het nuttigste dat het zou kunnen doen.",
                    "Correct!",
                    "Onjuist: dat zou onmogelijk te onderscheiden zijn van een bestand dat eindigt met een hoop lege regels."])
```

---

## Hoe kan ik minder typen?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Een van de krachtige hulpmiddelen van de shell is **tab-completion**.
Als je begint met het typen van de naam van een bestand en vervolgens op de tab-toets drukt,
zal de shell proberen het pad automatisch aan te vullen.
Als je bijvoorbeeld
`sea` typt en op tab drukt,
vult hij de mapnaam `seasonal/` aan (met een schuine streep erachter).
Als je daarna `a` typt en weer op tab drukt,
maakt hij het pad compleet als `seasonal/autumn.csv`.

Als het pad niet eenduidig is,
zoals bij `seasonal/s`,
laat een tweede keer op tab drukken een lijst met mogelijkheden zien.
Typ nog een of twee extra tekens om je pad specifieker te maken
en druk dan op tab
om de rest van de naam in te vullen.

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
Voer `head seasonal/autumn.csv` uit zonder de volledige bestandsnaam te typen.

`@hint`
Typ zoveel van het pad als nodig is, druk dan op tab, en herhaal.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="De checker kon de juiste uitvoer niet vinden in je opdracht. Weet je zeker dat je `head` hebt aangeroepen op `seasonal/autumn.csv`?")
)

```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Voer `head seasonal/spring.csv` uit zonder de volledige bestandsnaam te typen.

`@hint`
Typ zoveel van het pad als nodig is, druk dan op tab, en herhaal.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="De checker kon de juiste uitvoer niet vinden in je opdracht. Weet je zeker dat je `head` hebt aangeroepen op `seasonal/spring.csv`?")
)
Ex().success_msg("Goed gedaan! Zodra je gewend raakt aan het gebruik van tab-completion, zal het je veel tijd besparen!")
```

---

## Hoe kan ik bepalen wat opdrachten doen?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Je wilt niet altijd de eerste 10 regels van een bestand bekijken,
dus laat de shell je het gedrag van `head` aanpassen
door een **commandoregelvlag** (kortweg "vlag") mee te geven.
Als je het commando uitvoert:

```{shell}
head -n 3 seasonal/summer.csv
```

zal `head` alleen de eerste drie regels van het bestand tonen.
Als je `head -n 100` uitvoert,
laat het de eerste 100 regels zien (als die er zijn),
enzovoort.

De naam van een vlag geeft meestal aan wat die doet
(bijvoorbeeld, `-n` staat voor het "**a**antal regels").
Commandovlaggen hoeven niet per se een `-` gevolgd door één letter te zijn,
maar het is wel een veelgebruikte conventie.

Let op: het is goede stijl om alle vlaggen *vóór* bestandsnamen te zetten,
dus in deze cursus
accepteren we alleen antwoorden die dat doen.

`@instructions`
Toon de eerste 5 regels van `winter.csv` in de map `seasonal`.

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
        has_expr_output(incorrect_msg="Weet je zeker dat je `head` aanroept op het bestand `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Weet je zeker dat je de vlag `-n 5` hebt gebruikt?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Weet je zeker dat je de vlag `-n 5` hebt gebruikt?")
)
Ex().success_msg("Mooi! Met deze techniek kun je voorkomen dat je shell vastloopt als je grotere tekstbestanden wilt bekijken.")
```

---

## Hoe kan ik alles onder een map weergeven?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Om alles onder een map te zien,
ongeacht hoe diep het genest is,
kun je `ls` de vlag `-R` geven
(dat staat voor "recursive").
Als je `ls -R` gebruikt in je startmap,
zie je iets als dit:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Dit toont elk bestand en elke map op het huidige niveau,
dan alles in elke submap,
en zo verder.

`@instructions`
Om je te helpen zien wat wat is,
heeft `ls` nog een vlag, `-F`, die een `/` achter de naam van elke map zet
en een `*` achter de naam van elk uitvoerbaar programma.
Voer `ls` uit met de twee vlaggen, `-R` en `-F`, en het absolute pad naar je startmap
om alles te zien wat erin staat.
(De volgorde van de vlaggen maakt niet uit, maar de mapnaam moet als laatste komen.)

`@hint`
Je startmap kun je opgeven met `~` of `.` of met het absolute pad.

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
  has_expr_output(incorrect_msg='Gebruik ofwel `ls -R -F` of `ls -F -R` en het pad `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Gebruik ofwel `ls -R -F` of `ls -F -R` en het pad `/home/repl`.')
)
Ex().success_msg("Dat is een behoorlijk net overzicht, nietwaar?")
```

---

## Hoe krijg ik hulp voor een command?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Om uit te vinden wat commands doen,
gebruikten mensen vroeger het `man`-commando
(kort voor "manual").
Bijvoorbeeld,
het commando `man head` toont deze informatie:

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

`man` start automatisch `less`,
dus je moet mogelijk op de spatiebalk drukken om door de informatie te bladeren
en `:q` typen om af te sluiten.

De éénregelige beschrijving onder `NAME` vertelt je kort wat het commando doet,
en de samenvatting onder `SYNOPSIS` geeft alle flags weer die het begrijpt.
Alles wat optioneel is staat tussen vierkante haken `[...]`,
of/of-alternatieven zijn gescheiden door `|`,
en zaken die herhaalbaar zijn worden aangegeven met `...`,
dus de handleiding van `head` vertelt je dat je *ofwel* een regeltelling met `-n`
of een byte-aantal met `-c` kunt meegeven,
en dat je elk aantal bestandsnamen kunt opgeven.

Het probleem met de Unix-handleiding is dat je moet weten waar je naar zoekt.
Als dat niet zo is,
kun je zoeken op [Stack Overflow](https://stackoverflow.com/),
een vraag stellen op de Slack-kanalen van DataCamp,
of kijken naar de `SEE ALSO`-secties van de commands die je al kent.

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
Lees de handleiding van het `tail`-commando om te ontdekken
wat een `+`-teken vóór het getal dat je met de `-n`-flag gebruikt doet.
(Denk eraan: druk op de spatiebalk om naar beneden te bladeren en/of typ `q` om af te sluiten.)

`@hint`
Onthoud: `man` is kort voor "manual".

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Gebruik `man` en de naam van het commando.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Gebruik `tail` met de flag `-n +7` om alle regels *behalve* de eerste zes van `seasonal/spring.csv` weer te geven.

`@hint`
Zet een plusteken '+' vóór het aantal regels dat je wilt weergeven.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Roep je `tail` aan op `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Weet je zeker dat je de vlag `-n +7` hebt gebruikt?")
)
```

---

## Hoe kan ik kolommen uit een bestand selecteren?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` en `tail` laten je rijen uit een tekstbestand selecteren.
Als je kolommen wilt selecteren,
kun je het commando `cut` gebruiken.
Het heeft verschillende opties (gebruik `man cut` om ze te verkennen),
maar de meest voorkomende is iets als:

```{shell}
cut -f 2-5,8 -d , values.csv
```

wat betekent:
"selecteer kolommen 2 tot en met 5 en kolom 8,
met een komma als scheidingsteken".
`cut` gebruikt `-f` (van "fields") om kolommen aan te geven
en `-d` (van "delimiter") om het scheidingsteken aan te geven.
Je moet die laatste opgeven omdat sommige bestanden spaties, tabs of dubbele punten gebruiken om kolommen te scheiden.

<hr>

Welk commando selecteert de eerste kolom (met datums) uit het bestand `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Een van bovenstaande.
- Geen van bovenstaande, omdat `-f` vóór `-d` moet komen.

`@hint`
De volgorde van de flags maakt niet uit.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Ja, maar dat is niet alles', 'Ja, maar dat is niet alles', 'Correct! Een spatie toevoegen na de vlag is goede stijl, maar niet verplicht.', 'Nee, de volgorde van vlaggen maakt niet uit'])
```

---

## Wat kan cut niet?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` is een nogal simpele opdracht.
Specifiek,
het begrijpt geen tekst tussen aanhalingstekens.
Als je bestand bijvoorbeeld is:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

dan:

```{shell}
cut -f 2 -d , everyone.csv
```

levert dit op:

```
Age
Ranjit"
Rupinder"
```

in plaats van ieders leeftijd,
omdat het de komma tussen achternaam en voornaam als kolomscheidingsteken ziet.

<hr>

Wat is de output van `cut -d : -f 2-4` op de regel:

```
first:second:third:
```

(Let op de dubbelepunt aan het eind.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Geen van bovenstaande, want er zijn geen vier velden.

`@hint`
Let op de dubbelepunt aan het eind.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Nee, er is meer.', 'Nee, er is meer.', 'Correct! De afsluitende dubbele punt creëert een leeg vierde veld.', 'Nee, `cut` doet zijn best.'])
```

---

## Hoe kan ik opdrachten herhalen?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Een van de grootste voordelen van de shell is dat
je heel makkelijk dingen opnieuw kunt doen.
Als je een paar opdrachten hebt uitgevoerd,
kun je met de pijl-omhoog door je eerdere opdrachten bladeren.
Met de pijltjes links en rechts en de delete-toets kun je ze bewerken.
Door op Enter te drukken voer je de aangepaste opdracht uit.

Nog beter: `history` toont een lijst met opdrachten die je recent hebt uitgevoerd.
Elke regel heeft een volgnummer ervoor, zodat je een specifieke opdracht gemakkelijk opnieuw kunt uitvoeren:
typ gewoon `!55` om de 55e opdracht in je geschiedenis opnieuw uit te voeren (als je er zoveel hebt).
Je kunt ook een opdracht opnieuw uitvoeren door een uitroepteken te typen gevolgd door de naam van de opdracht,
zoals `!head` of `!cut`,
die de meest recente keer dat die opdracht is gebruikt opnieuw zal uitvoeren.

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
Voer `head summer.csv` uit in je thuismap (dit zou moeten mislukken).

`@hint`
Tab-completion werkt niet als er geen bestandsnaam overeenkomt.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Gebruik `head` en een bestandsnaam, `summer.csv`. Maak je geen zorgen als het mislukt. Dat hoort zo.")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Ga naar de map `seasonal`.

`@hint`
Vergeet niet dat `cd` staat voor "change directory".

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
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Voer de `head`-opdracht opnieuw uit met `!head`.

`@hint`
Typ geen spatie tussen `!` en wat erop volgt.

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
                        incorrect_msg='Gebruik `!head` om het `head`-commando te herhalen.'),
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
Gebruik `history` om te bekijken wat je hebt gedaan.

`@hint`
Let op: `history` toont de meest recente opdrachten als laatste, zodat ze op je scherm blijven staan wanneer het klaar is met uitvoeren.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Gebruik `history` zonder vlaggen om een lijst van eerdere commando\'s te krijgen.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Voer `head` opnieuw uit met `!` gevolgd door een opdrachtnummer.

`@hint`
Typ *geen* spatie tussen `!` en wat erop volgt.

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
                        incorrect_msg='Heb je `!<een_getal>` gebruikt om de laatste `head` uit de geschiedenis opnieuw uit te voeren?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Goed gedaan! Op naar de volgende!")
```

---

## Hoe kan ik regels selecteren die specifieke waarden bevatten?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` en `tail` selecteren rijen,
`cut` selecteert kolommen,
en `grep` selecteert regels op basis van hun inhoud.
In de simpelste vorm
neemt `grep` een stukje tekst gevolgd door een of meer bestandsnamen
en print alle regels in die bestanden die die tekst bevatten.
Bijvoorbeeld,
`grep bicuspid seasonal/winter.csv`
print regels uit `winter.csv` die "bicuspid" bevatten.

`grep` kan ook naar patronen zoeken;
die verkennen we in de volgende cursus.
Wat nu belangrijker is, zijn een paar veelgebruikte vlaggen van `grep`:

- `-c`: print het aantal overeenkomende regels in plaats van de regels zelf
- `-h`: print de bestandsnamen niet bij het doorzoeken van meerdere bestanden
- `-i`: negeer hoofd-/kleine letters (bijv. behandel "Regression" en "regression" als overeenkomend)
- `-l`: print de namen van bestanden die overeenkomsten bevatten, niet de overeenkomsten zelf
- `-n`: print regelnummers voor overeenkomende regels
- `-v`: keer de match om, d.w.z. laat alleen regels zien die juist niet overeenkomen

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
Print de inhoud van alle regels die het woord `molar` bevatten in `seasonal/autumn.csv`
door één enkele opdracht uit te voeren vanuit je home-directory. Gebruik geen vlaggen.

`@hint`
Gebruik `grep` met het woord waar je naar zoekt en de naam van het/de bestand(en) waarin je zoekt.

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
      has_code("grep", incorrect_msg = "Heb je `grep` aangeroepen?"),
      has_code("molar", incorrect_msg = "Heb je gezocht naar `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Heb je het bestand `seasonal/autumn.csv` doorzocht?")
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
Keer de match om om alle regels te vinden die het woord `molar` in `seasonal/spring.csv` juist niet bevatten, en toon hun regelnummers.
Onthoud: het is goede stijl om alle vlaggen vóór andere waarden te zetten, zoals bestandsnamen of de zoekterm "molar".

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
      has_code("grep", incorrect_msg = "Heb je `grep` aangeroepen?"),
      has_code("-v", incorrect_msg = "Heb je de match omgekeerd met `-v`?"),
      has_code("-n", incorrect_msg = "Heb je regelnummers weergegeven met `-n`?"),
      has_code("molar", incorrect_msg = "Heb je gezocht naar `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Heb je het bestand `seasonal/spring.csv` doorzocht?")
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
Tel hoeveel regels het woord `incisor` bevatten in `autumn.csv` en `winter.csv` samen.
(Voer opnieuw één enkele opdracht uit vanuit je home-directory.)

`@hint`
Vergeet niet `-c` met `grep` te gebruiken om regels te tellen.

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
      has_code("grep", incorrect_msg = "Heb je `grep` aangeroepen?"),
      has_code("-c", incorrect_msg = "Heb je tellingen gekregen met `-c`?"),
      has_code("incisor", incorrect_msg = "Heb je gezocht naar `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Heb je het bestand `seasonal/autumn.csv` doorzocht?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Heb je het bestand `seasonal/winter.csv` doorzocht?")
    )
  )
)

```

---

## Waarom is het niet altijd veilig om data als tekst te behandelen?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

In de sectie `SEE ALSO` van de handleiding voor `cut` wordt verwezen naar een opdracht `paste`
die je kunt gebruiken om databestanden te combineren in plaats van ze op te knippen.

<hr>

Lees de handleiding van `paste`,
en voer daarna `paste` uit om de herfst- en winterdatabestanden in één tabel te combineren
met een komma als scheidingsteken.
Wat is er mis met de output vanuit het perspectief van data-analyse?

`@possible_answers`
- De kolomkoppen worden herhaald.
- De laatste paar rijen hebben het verkeerde aantal kolommen.
- Een deel van de data uit `winter.csv` ontbreekt.

`@hint`
Als je de uitvoer van `paste` met `cut` zou bewerken met komma's als scheidingsteken,
zou dat dan het juiste antwoord opleveren?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Klopt, maar het is niet per se een fout.'
correct2 = 'Correct: het samenvoegen van de regels met kolommen creëert slechts één lege kolom aan het begin, niet twee.'
err3 = 'Nee, alle wintergegevens zijn aanwezig.'
Ex().has_chosen(2, [err1, correct2, err3])
```

---
title: Batchverwerking
description: >-
  De meeste shell-opdrachten verwerken in één keer veel bestanden. In dit
  hoofdstuk leer je hoe je je eigen pijplijnen dat ook laat doen. Onderweg zie
  je hoe de shell variabelen gebruikt om informatie op te slaan.
lessons:
  - nb_of_exercises: 10
    title: Hoe slaat de shell informatie op?
---

## Hoe slaat de shell informatie op?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Net als andere programma's slaat de shell informatie op in variabelen.
Sommige daarvan,
**omgevingsvariabelen** genoemd,
zijn altijd beschikbaar.
De namen van omgevingsvariabelen worden volgens conventie in hoofdletters geschreven,
en hieronder staan een paar van de meest gebruikte.

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | Home-directory van de gebruiker   | `/home/repl`          |
| `PWD `   | Huidige werkmap                   | Zelfde als `pwd`-commando |
| `SHELL`  | Welke shell gebruikt wordt        | `/bin/bash`           |
| `USER`   | Gebruikers-ID                     | `repl`                |

Voor een volledige (en vrij lange) lijst
kun je `set` in de shell typen.

<hr>

Gebruik `set` en `grep` met een pipe om de waarde van `HISTFILESIZE` weer te geven,
die bepaalt hoeveel oude commando's er in je commandogeschiedenis worden bewaard.
Wat is de waarde?

`@possible_answers`
- 10
- 500
- [2000]
- De variabele staat er niet.

`@hint`
Gebruik `set | grep HISTFILESIZE` om de regel te vinden die je nodig hebt.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nee: de shell registreert meer geschiedenis dan dat."
err2 = "Nee: de shell registreert meer geschiedenis dan dat."
correct3 = "Correct: de shell slaat standaard 2000 oude commando's op op dit systeem."
err4 = "Nee: de variabele `HISTFILESIZE` is er."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Hoe print ik de waarde van een variabele?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Een eenvoudigere manier om de waarde van een variabele te vinden, is met het commando `echo`, dat zijn argumenten print. Als je typt

```{shell}
echo hello DataCamp!
```

print het

```
hello DataCamp!
```

Als je dit probeert te gebruiken om de waarde van een variabele te printen, zoals hier:

```{shell}
echo USER
```

print het de naam van de variabele, `USER`.

Om de waarde van de variabele te krijgen, moet je er een dollarteken `$` voor zetten. Als je typt 

```{shell}
echo $USER
```

print het

```
repl
```

Dit geldt overal:
om de waarde van een variabele genaamd `X` te krijgen,
moet je `$X` schrijven.
(Dit is zodat de shell kan zien of je "een bestand met de naam X" bedoelt
of "de waarde van een variabele met de naam X".)

`@instructions`
De variabele `OSTYPE` bevat de naam van het type besturingssysteem dat je gebruikt.
Toon de waarde met `echo`.

`@hint`
Roep `echo` aan met de variabele `OSTYPE` voorafgegaan door `$`.

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
            has_code('echo', incorrect_msg="Heb je `echo` aangeroepen?"),
            has_code('OSTYPE', incorrect_msg="Heb je de omgevingsvariabele `OSTYPE` afgedrukt?"),
            has_code(r'\$OSTYPE', incorrect_msg="Zorg ervoor dat je `OSTYPE` voorafgaat met een `$`.")
        )
    )
)
Ex().success_msg("Uitstekend echoën van omgevingsvariabelen! Je bent goed begonnen. Laten we doorgaan!")
```

---

## Hoe slaat de shell nog meer informatie op?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Het andere type variabele heet een **shellvariabele**,
en lijkt op een lokale variabele in een programmeertaal.

Om een shellvariabele te maken,
geef je simpelweg een waarde aan een naam:

```{shell}
training=seasonal/summer.csv
```

*zonder* spaties vóór of na het `=`-teken.
Zodra je dit hebt gedaan,
kun je de waarde van de variabele controleren met:

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
Definieer een variabele `testing` met de waarde `seasonal/winter.csv`.

`@hint`
Er mogen *geen* spaties staan tussen de naam van de variabele en de waarde.

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
        has_code('testing', incorrect_msg='Heb je een shellvariabele genaamd `testing` gedefinieerd?'),
        has_code('testing=', incorrect_msg='Heb je `=` direct na testing geschreven, zonder spaties?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Heb je de waarde van `testing` ingesteld op `seasonal/winter.csv`?')
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
Gebruik `head -n 1 IETS` om de eerste regel uit `seasonal/winter.csv` te halen,
waarbij je de waarde van de variabele `testing` gebruikt in plaats van de bestandsnaam.

`@hint`
Vergeet niet `$testing` te gebruiken in plaats van alleen `testing`
(de `$` is nodig om de waarde van de variabele op te halen).

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
    has_code(r'\$testing', incorrect_msg="Heb je de shell-variabele met `$testing` gerefereerd?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Heb je `head` aangeroepen?"),
            has_code('-n', incorrect_msg="Heb je het aantal regels beperkt met `-n`?"),
            has_code(r'-n\s+1', incorrect_msg="Heb je ervoor gekozen om 1 regel te behouden met `-n 1`?")     
        )
    )
)
Ex().success_msg("Geweldig! Laten we eens kijken hoe je opdrachten gemakkelijk kunt herhalen.")
```

---

## Hoe kan ik een opdracht vaak herhalen?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Shell-variabelen worden ook gebruikt in **loops**,
die opdrachten vaak herhalen.
Als we deze opdracht uitvoeren:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

krijgen we:

```
gif
jpg
png
```

Let op het volgende aan de loop:

1. De structuur is `for` ...variabele... `in` ...lijst... `; do` ...body... `; done`
2. De lijst met dingen die de loop moet verwerken (in ons geval de woorden `gif`, `jpg` en `png`).
3. De variabele die bijhoudt welk item de loop op dat moment verwerkt (in ons geval `filetype`).
4. De body van de loop die het werk doet (in ons geval `echo $filetype`).

Merk op dat de body `$filetype` gebruikt om de waarde van de variabele op te halen in plaats van alleen `filetype`,
net zoals bij andere shell-variabelen.
Let ook op waar de puntkomma's staan:
de eerste staat tussen de lijst en het sleutelwoord `do`,
en de tweede staat tussen de body en het sleutelwoord `done`.

`@instructions`
Pas de loop aan zodat hij het volgende afdrukt:

```
docx
odt
pdf
```

Gebruik `filetype` als de naam van de loopvariabele.

`@hint`
Gebruik de codestructuur uit de inleidende tekst en vervang de afbeeldingsbestandstypen door documentbestandstypen.

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
      has_code('for', incorrect_msg='Heb je `for` aangeroepen?'),
      has_code('filetype', incorrect_msg='Heb je `filetype` als de lusvariabele gebruikt?'),
      has_code('in', incorrect_msg='Heb je `in` gebruikt voor de lijst van bestandstypen?'),
      has_code('docx odt pdf', incorrect_msg='Heb je over `docx`, `odt` en `pdf` in die volgorde gelust?'),
      has_code(r'pdf\s*;', incorrect_msg='Heb je een puntkomma na het laatste luselement gezet?'),
      has_code(r';\s*do', incorrect_msg='Heb je `do` na de eerste puntkomma gebruikt?'),
      has_code('echo', incorrect_msg='Heb je `echo` aangeroepen?'),
      has_code(r'\$filetype', incorrect_msg='Heb je `$filetype` ge-echo\'d?'),
      has_code(r'filetype\s*;', incorrect_msg='Heb je een puntkomma na de lusbody gezet?'),
      has_code('; done', incorrect_msg='Ben je geëindigd met `done`?')
    )
  )
)
Ex().success_msg("Eersteklas voor lussen! Lussen zijn briljant als je hetzelfde honderden of duizenden keren wilt doen.")
```

---

## Hoe kan ik een opdracht één keer per bestand herhalen?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Je kunt altijd handmatig de namen typen van de bestanden die je wilt verwerken wanneer je de lus schrijft,
maar meestal is het beter om wildcards te gebruiken.
Probeer deze lus in de console uit te voeren:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Dit geeft:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

omdat de shell `seasonal/*.csv` uitbreidt tot een lijst met vier bestandsnamen
voordat de lus wordt uitgevoerd.

`@instructions`
Pas de wildcardexpressie aan naar `people/*`
zodat de lus de namen van de bestanden in de map `people` afdrukt,
ongeacht welke extensie ze wel of niet hebben.
Gebruik `filename` als de naam van je lusvariabele.

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
      has_code('for', incorrect_msg='Heb je `for` aangeroepen?'),
      has_code('filename', incorrect_msg='Heb je `filename` als de lusvariabele gebruikt?'),
      has_code('in', incorrect_msg='Heb je `in` gebruikt voor de lijst van bestandstypen?'),
      has_code('people/\*', incorrect_msg='Heb je een lijst van bestanden gespecificeerd met `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='Heb je een puntkomma na de lijst van bestanden gezet?'),
      has_code(r';\s*do', incorrect_msg='Heb je `do` gebruikt na de eerste puntkomma?'),
      has_code('echo', incorrect_msg='Heb je `echo` aangeroepen?'),
      has_code(r'\$filename', incorrect_msg='Heb je `$filename` ge-echo\'d?'),
      has_code(r'filename\s*;', incorrect_msg='Heb je een puntkomma na de lusbody gezet?'),
      has_code('; done', incorrect_msg='Ben je geëindigd met `done`?')
    )
  )
)
Ex().success_msg("Loopy looping! Wildcards en lussen vormen een krachtige combinatie.")
```

---

## Hoe kan ik de namen van een set bestanden vastleggen?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Mensen stellen vaak een variabele in met een wildcardexpressie om een lijst met bestandsnamen op te slaan.
Bijvoorbeeld,
als je `datasets` zo definieert:

```{shell}
datasets=seasonal/*.csv
```

kun je de bestandsnamen later tonen met:

```{shell}
for filename in $datasets; do echo $filename; done
```

Dit scheelt typwerk en verkleint de kans op fouten.

<hr>

Als je deze twee opdrachten in je thuismap uitvoert,
hoeveel regels aan output geven ze dan?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Geen: omdat `files` op een aparte regel wordt gedefinieerd, heeft het geen waarde op de tweede regel.
- Eén: het woord "files".
- Vier: de namen van alle vier de seizoensgegevensbestanden.

`@hint`
Onthoud dat `X` op zichzelf gewoon "X" is, terwijl `$X` de waarde van de variabele `X` is.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nee: je hoeft geen variabele te definiëren op dezelfde regel waar je hem gebruikt."
err2 = "Nee: dit voorbeeld definieert en gebruikt de variabele `files` in dezelfde shell."
correct3 = "Correct. Het commando is gelijk aan `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## De naam van een variabele versus de waarde ervan

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Een veelgemaakte fout is vergeten `$` te gebruiken vóór de naam van een variabele.
Als je dat doet,
gebruikt de shell de naam die je hebt getypt
in plaats van de waarde van die variabele.

Een nog vaker voorkomende fout bij ervaren gebruikers is de variabelenaam verkeerd typen.
Als je bijvoorbeeld `datasets` zo definieert:

```{shell}
datasets=seasonal/*.csv
```

en daarna typt:

```{shell}
echo $datsets
```

druk de shell niets af,
omdat `datsets` (zonder de tweede "a") niet is gedefinieerd.

<hr>

Als je deze twee commando's in je thuismap zou uitvoeren,
welke output wordt er dan afgedrukt?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Lees het eerste deel van de loop goed voordat je antwoordt.)

`@hint`
Onthoud dat `X` op zichzelf gewoon "X" is, terwijl `$X` de waarde van de variabele `X` is.

`@possible_answers`
- [Eén regel: het woord "files".]
- Vier regels: de namen van alle vier de seizoensgegevensbestanden.
- Vier lege regels: de variabele `f` krijgt geen waarde toegekend.

`@feedback`
- Correct: de loop gebruikt `files` in plaats van `$files`, dus de lijst bestaat uit het woord "files".
- Nee: de loop gebruikt `files` in plaats van `$files`, dus de lijst bestaat uit het woord "files" in plaats van de expansie van `files`.
- Nee: de variabele `f` wordt automatisch gedefinieerd door de `for`-loop.

---

## Hoe kan ik veel opdrachten in één enkele loop uitvoeren?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Bestandsnamen afdrukken is handig om te debuggen,
maar het echte doel van loops is om iets met meerdere bestanden te doen.
Deze loop print de tweede regel van elk databestand:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Hij heeft dezelfde structuur als de andere loops die je al hebt gezien:
het enige verschil is dat de body een pipeline van twee opdrachten is in plaats van één enkele opdracht.

`@instructions`
Schrijf een loop die het laatste item van juli 2017 (`2017-07`) in elk seasonal-bestand print. De uitvoer moet lijken op:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

maar dan voor **_elk_** seasonal-bestand apart. Gebruik `file` als naam van de loopvariabele, en vergeet niet te loopen over de lijst met bestanden `seasonal/*.csv` (_in plaats van 'seasonal/winter.csv' zoals in het voorbeeld_).

`@hint`
De loop-body is de grep-opdracht uit de instructies, maar dan met `seasonal/winter.csv` vervangen door `$file`.

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
  has_code('for', incorrect_msg='Heb je `for` aangeroepen?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Heb je `file` als de lusvariabele gebruikt?'),
      has_code('in', incorrect_msg='Heb je `in` gebruikt voor de lijst met bestanden?'),
      has_code('seasonal/\*', incorrect_msg='Heb je een lijst met bestanden gespecificeerd met `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Heb je een puntkomma na de lijst met bestanden gezet?'),
      has_code(r';\s*do', incorrect_msg='Heb je `do` gebruikt na de eerste puntkomma?'),
      has_code('grep', incorrect_msg='Heb je `grep` aangeroepen?'),
      has_code('2017-07', incorrect_msg='Heb je gezocht naar `2017-07`?'),
      has_code(r'\$file', incorrect_msg='Heb je `$file` als de naam van de lusvariabele gebruikt?'),
      has_code(r'file\s*|', incorrect_msg='Heb je een pipe gebruikt om je tweede commando te verbinden?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Heb je `tail -n 1` gebruikt om de laatste invoer van elke zoekopdracht in je tweede commando af te drukken?'),
      has_code('; done', incorrect_msg='Ben je geëindigd met `done`?')
    )
  )
)

Ex().success_msg("Loopy looping! Wildcards en loops vormen een krachtige combinatie.")
```

---

## Waarom moet ik geen spaties in bestandsnamen gebruiken?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Het is logisch en handig om bestanden meerwoordige namen te geven zoals `July 2017.csv`
wanneer je een grafische bestandsverkenner gebruikt.
Maar dit zorgt voor problemen als je in de shell werkt.
Stel je bijvoorbeeld voor
dat je `July 2017.csv` wilt hernoemen naar `2017 July data.csv`.
Je kunt dan niet typen:

```{shell}
mv July 2017.csv 2017 July data.csv
```

want voor de shell lijkt het alsof je probeert
vier bestanden genaamd `July`, `2017.csv`, `2017` en (opnieuw) `July`
te verplaatsen naar een map genaamd `data.csv`.
In plaats daarvan
moet je de bestandsnamen tussen aanhalingstekens zetten,
zodat de shell elk ervan als één parameter behandelt:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Als je twee bestanden hebt met de namen `current.csv` en `last year.csv`
(met een spatie in de naam)
en je typt:

```{shell}
rm current.csv last year.csv
```

wat gebeurt er dan:

`@hint`
Wat zou je denken dat er gaat gebeuren als iemand je dit commando laat zien en je niet weet welke bestanden er bestaan?

`@possible_answers`
- De shell geeft een foutmelding omdat `last` en `year.csv` niet bestaan.
- De shell verwijdert `current.csv`.
- [Beide bovenstaande.]
- Niets.

`@feedback`
- Ja, maar dat is niet alles.
- Ja, maar dat is niet alles.
- Correct. Je kunt enkele aanhalingstekens, `'`, of dubbele aanhalingstekens, `"`, om de bestandsnamen zetten.
- Helaas niet.

---

## Hoe kan ik veel dingen doen in één enkele loop?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

De loops die je tot nu toe hebt gezien hebben allemaal één enkele opdracht of pipeline in hun body,
maar een loop kan elk aantal opdrachten bevatten.
Om de shell te vertellen waar de ene eindigt en de volgende begint,
moet je ze scheiden met puntkomma's:

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

Stel dat je de puntkomma tussen de opdrachten `echo` en `head` in de vorige loop vergeet,
waardoor je de shell vraagt om het volgende uit te voeren:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Wat zal de shell doen?

`@possible_answers`
- Een foutmelding afdrukken.
- Eén regel afdrukken voor elk van de vier bestanden.
- Eén regel afdrukken voor `autumn.csv` (het eerste bestand).
- De laatste regel van elk bestand afdrukken.

`@hint`
Je kunt de output van `echo` naar `tail` pipen.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nee: de lus zal draaien, maar hij zal niets zinnigs doen."
correct2 = "Ja: `echo` produceert één regel die de bestandsnaam twee keer bevat, die `tail` vervolgens kopieert."
err3 = "Nee: de lus draait één keer voor elk van de vier bestandsnamen."
err4 = "Nee: de invoer van `tail` is de uitvoer van `echo` voor elke bestandsnaam."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

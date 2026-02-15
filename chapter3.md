---
title: Tools combineren
description: >-
  De echte kracht van de Unix-shell zit niet in losse opdrachten, maar in hoe
  makkelijk je ze kunt combineren om nieuwe dingen te doen. In dit hoofdstuk
  leer je die kracht gebruiken om de gegevens te selecteren die je wilt, en maak
  je kennis met opdrachten om waarden te sorteren en duplicaten te verwijderen.
lessons:
  - nb_of_exercises: 12
    title: Hoe kan ik de uitvoer van een opdracht in een bestand opslaan?
---

## Hoe kan ik de uitvoer van een commando in een bestand opslaan?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Alle tools die je tot nu toe hebt gezien, laten je invoerbestanden opgeven.
De meeste hebben geen optie om een uitvoerbestand te benoemen, omdat dat niet nodig is.
In plaats daarvan kun je **omleiding** gebruiken om de uitvoer van elk commando op te slaan waar je maar wilt.
Als je dit commando uitvoert:

```{shell}
head -n 5 seasonal/summer.csv
```

print het de eerste 5 regels van de zomerdata op het scherm.
Als je in plaats daarvan dit commando draait:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

verschijnt er niets op het scherm.
In plaats daarvan wordt de uitvoer van `head` in een nieuw bestand gezet met de naam `top.csv`.
Je kunt de inhoud van dat bestand bekijken met `cat`:

```{shell}
cat top.csv
```

Het groter-dan-teken `>` vertelt de shell om de uitvoer van `head` naar een bestand om te leiden.
Het maakt geen deel uit van het `head`-commando;
het werkt juist met elk shell-commando dat uitvoer produceert.

`@instructions`
Combineer `tail` met omleiding om de laatste 5 regels van `seasonal/winter.csv` op te slaan in een bestand met de naam `last.csv`.

`@hint`
Gebruik `tail -n 5` om de laatste 5 regels op te halen.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "De regel `%s` zou in het bestand `last.csv` moeten staan, maar dat is niet zo. Leid de uitvoer van `tail -n 5 seasonal/winter.csv` om naar `last.csv` met `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` heeft te veel regels. Heb je de vlag `-n 5` met `tail` gebruikt?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Mooi! Laten we nog wat meer oefenen!")
```

---

## Hoe kan ik de uitvoer van een commando als invoer gebruiken?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Stel dat je regels uit het midden van een bestand wilt halen.
Specifieker: je wilt regels 3-5 uit een van onze databestanden.
Je kunt beginnen met `head` om de eerste 5 regels op te halen
en die om te leiden naar een bestand,
en daarna `tail` gebruiken om de laatste 3 te selecteren:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Een snelle controle bevestigt dat dit regels 3-5 van ons oorspronkelijke bestand zijn,
omdat het de laatste 3 regels van de eerste 5 zijn.

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
Selecteer de laatste twee regels van `seasonal/winter.csv`
en sla ze op in een bestand met de naam `bottom.csv`.

`@hint`
Gebruik `tail` om regels te selecteren en `>` om de uitvoer van `tail` om te leiden.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="De regel `%s` zou in het bestand `bottom.csv` moeten staan, maar dat is niet het geval. Leid de uitvoer van `tail -n 2 seasonal/winter.csv` om naar `bottom.csv` met `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` heeft te veel regels. Heb je de vlag `-n 2` met `tail` gebruikt?'),
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
Selecteer de eerste regel uit `bottom.csv`
ome de op een na laatste regel van het oorspronkelijke bestand te krijgen.

`@hint`
Gebruik `head` om de regel te selecteren die je wilt.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Er is iets mis met het `bottom.csv`-bestand. Zorg ervoor dat je het niet verandert!"),
    has_expr_output(strict=True, incorrect_msg="Heb je `head` correct gebruikt op `bottom.csv`? Zorg ervoor dat je de `-n` vlag correct gebruikt.")
)

Ex().success_msg("Goed gedaan. Ga naar de volgende oefening om meer te weten te komen over betere manieren om commando's te combineren.")                             

```

---

## Wat is een betere manier om commando's te combineren?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Commando's combineren met omleiding heeft twee nadelen:

1. Het laat veel tijdelijke bestanden rondslingeren (zoals `top.csv`).
2. De commando's om je eindresultaat te produceren staan verspreid over meerdere regels in je geschiedenis.

De shell biedt een ander hulpmiddel dat beide problemen in één keer oplost: een **pipe**.
Begin opnieuw met het uitvoeren van `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

In plaats van de output van `head` naar een bestand te sturen,
voeg je een verticale streep en het commando `tail` *zonder* bestandsnaam toe:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Het pipesymbool vertelt de shell dat de output van het commando links
gebruikt moet worden als input voor het commando rechts.

`@instructions`
Gebruik `cut` om alle tandnamen uit kolom 2 van het kommagescheiden bestand `seasonal/summer.csv` te selecteren, en pipe het resultaat vervolgens naar `grep` met een omgekeerde match om de kopregel met het woord "Tooth" uit te sluiten. *`cut` en `grep` zijn uitgebreid behandeld in hoofdstuk 2, respectievelijk in oefeningen 8 en 11.*

`@hint`
- Het eerste deel van het commando heeft de vorm `cut -d field_delimiter -f column_number filename`.
- Het tweede deel van het commando heeft de vorm `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'Heb je het resultaat van `cut -d , -f 2 seasonal/summer.csv` in `grep -v Tooth` gepiped met `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Heb je de regel met de kop `"Tooth"` uitgesloten met `grep`?')
)
Ex().success_msg("Perfect gepiped! Dit is misschien de eerste keer dat je `|` gebruikt, maar zeker niet de laatste!")
```

---

## Hoe kan ik veel commando's combineren?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Je kunt elk aantal commando's aan elkaar koppelen.
Bijvoorbeeld,
dit commando:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

zal het volgende doen:

1. de eerste kolom uit de voorjaarsgegevens selecteren;
2. de kopregel met het woord "Date" verwijderen; en
3. de eerste 10 regels met echte data selecteren.

`@instructions`
In de vorige oefening gebruikte je het volgende commando om alle tandnamen uit kolom 2 van `seasonal/summer.csv` te selecteren:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Breid deze pijplijn uit met een `head`-commando om alleen de allereerste tandnaam te selecteren.

`@hint`
Kopieer en plak de code uit de instructies, voeg een pipe toe en roep daarna `head` aan met de `-n`-vlag.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Heb je `|` gebruikt om de pipeline uit te breiden met een `head`-commando? Zorg ervoor dat je de `-n`-vlag correct instelt."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Heb je `|` gebruikt om de pipeline uit te breiden met een `head`-commando?")
)
Ex().success_msg("Vrolijk ketenen! Door meerdere commando's aan elkaar te koppelen, kun je krachtige datamanipulatiepipelines bouwen.")
```

---

## Hoe tel ik de records in een bestand?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Het commando `wc` (afkorting van "word count") print het aantal **c**haracters, **w**oorden en **l**ijnen in een bestand.
Je kunt het alleen één van deze laten printen met respectievelijk `-c`, `-w` of `-l`.

`@instructions`
Tel hoeveel records in `seasonal/spring.csv` datums in juli 2017 (`2017-07`) hebben.
- Gebruik hiervoor `grep` met een gedeeltelijke datum om de regels te selecteren en pipe dit resultaat naar `wc` met een geschikte vlag om de regels te tellen.

`@hint`
- Gebruik `head seasonal/spring.csv` om jezelf aan het datumformaat te herinneren.
- Het eerste deel van het commando heeft de vorm `grep thing_to_match filename`.
- Na de pipe, `|`, roep je `wc` aan met de `-l` vlag.

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
      has_code("grep", incorrect_msg = "Heb je `grep` aangeroepen?"),
      has_code("2017-07", incorrect_msg = "Heb je gezocht naar `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Heb je het bestand `seasonal/spring.csv` doorzocht?"),
      has_code("|", incorrect_msg = "Heb je naar `wc` gepiped met `|`?"),      
      has_code("wc", incorrect_msg = "Heb je `wc` aangeroepen?"),
      has_code("-l", incorrect_msg = "Heb je regels geteld met `-l`?")
    )
  )
)
Ex().success_msg("Voorzichtig geteld! Bepalen hoeveel data je hebt is een geweldige eerste stap in elke data-analyse.")
```

---

## Hoe kan ik in één keer veel bestanden opgeven?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

De meeste shell-opdrachten werken op meerdere bestanden als je meerdere bestandsnamen meegeeft.
Zo kun je bijvoorbeeld de eerste kolom uit alle seizoensbestanden in één keer halen met:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Maar steeds opnieuw veel bestandsnamen typen is geen goed idee:
het kost tijd,
en vroeg of laat laat je een bestand weg of noem je er per ongeluk twee keer één.
Om het je makkelijker te maken,
kun je in de shell **wildcards** gebruiken om met één expressie een lijst met bestanden op te geven.
De meest gebruikte wildcard is `*`,
die betekent: "match nul of meer tekens".
Daarmee kunnen we de `cut`-opdracht hierboven inkorten tot:

```{shell}
cut -d , -f 1 seasonal/*
```

of:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Schrijf één opdracht met `head` om de eerste drie regels op te halen uit zowel `seasonal/spring.csv` als `seasonal/summer.csv`, in totaal zes regels aan data, maar dus *niet* uit de bestanden voor autumn of winter.
Gebruik een wildcard in plaats van de bestandsnamen volledig uit te schrijven.

`@hint`
- De opdracht heeft de vorm `head -n aantal_regels bestandsnaamspatroon`.
- Je kunt bestanden in map `a` die beginnen met `b` matchen met bijvoorbeeld `a/b*`.

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
    has_expr_output(incorrect_msg = "Je kunt `seasonal/s*` gebruiken om `seasonal/spring.csv` en `seasonal/summer.csv` te selecteren. Zorg ervoor dat je alleen de eerste drie regels van elk bestand opneemt met de `-n` vlag!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Neem de output voor `seasonal/autumn.csv` niet op. Je kunt `seasonal/s*` gebruiken om `seasonal/spring.csv` en `seasonal/summer.csv` te selecteren"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Neem de output voor `seasonal/winter.csv` niet op. Je kunt `seasonal/s*` gebruiken om `seasonal/spring.csv` en `seasonal/summer.csv` te selecteren")
)
Ex().success_msg("Wilde wildcard-werk! Dit wordt nog belangrijker als je directory honderden of duizenden bestanden bevat.")
```

---

## Welke andere wildcards kan ik gebruiken?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

De shell heeft ook andere wildcards,
al zijn ze minder gebruikelijk:

- `?` matcht één teken, dus `201?.txt` matcht `2017.txt` of `2018.txt`, maar niet `2017-01.txt`.
- `[...]` matcht één van de tekens tussen de rechte haken, dus `201[78].txt` matcht `2017.txt` of `2018.txt`, maar niet `2016.txt`.
- `{...}` matcht elk van de door komma’s gescheiden patronen tussen de accolades, dus `{*.txt, *.csv}` matcht elk bestand waarvan de naam eindigt op `.txt` of `.csv`, maar niet bestanden waarvan de naam eindigt op `.pdf`.

<hr/>

Welke expressie matcht `singh.pdf` en `johel.txt` maar *niet* `sandhu.pdf` of `sandhu.txt`?

`@hint`
Vergelijk elke expressie om de beurt met elke bestandsnaam.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Nee: `.pdf` en `.txt` zijn geen bestandsnamen.
- Nee: dit matcht `sandhu.pdf`.
- Nee: de expressie tussen rechte haken matcht maar één teken, geen hele woorden.
- Goed zo!

---

## Hoe kan ik tekstregels sorteren?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Zoals de naam al aangeeft,
zet `sort` gegevens op volgorde.
Standaard gebeurt dit in oplopende alfabetische volgorde,
maar met de flags `-n` en `-r` kun je numeriek sorteren en de volgorde van de uitvoer omkeren,
terwijl `-b` aangeeft dat voorloopspaties genegeerd moeten worden
en `-f` dat hoofd-/kleine letters genegeerd worden (**f**old case, oftewel case-insensitive).
Pijplijnen gebruiken vaak `grep` om ongewenste records te verwijderen
en daarna `sort` om de overgebleven records te ordenen.

`@instructions`
Weet je nog de combinatie van `cut` en `grep` om alle tandnamen uit kolom 2 van `seasonal/summer.csv` te selecteren?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Begin vanaf dit recept en sorteer de namen van de tanden in `seasonal/winter.csv` (niet `summer.csv`) in aflopende alfabetische volgorde. Breid hiervoor de pijplijn uit met een `sort`-stap.

`@hint`
Kopieer en plak de opdracht uit de instructies, wijzig de bestandsnaam, voeg een pipe toe en roep vervolgens `sort` aan met de vlag `-r`.

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
      has_code("cut", incorrect_msg = "Heb je `cut` aangeroepen?"),
      has_code("-d", incorrect_msg = "Heb je een veldscheidingsteken gespecificeerd met `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Heb je gegevens uit het bestand `seasonal/winter.csv` gehaald?"),
      has_code("|", incorrect_msg = "Heb je van `cut` naar `grep` naar `sort` gepiped met `|`?"),      
      has_code("grep", incorrect_msg = "Heb je `grep` aangeroepen?"),
      has_code("-v", incorrect_msg = "Heb je de match omgekeerd met `-v`?"),
      has_code("Tooth", incorrect_msg = "Heb je gezocht naar `Tooth`?"),
      has_code("sort", incorrect_msg = "Heb je `sort` aangeroepen?"),
      has_code("-r", incorrect_msg = "Heb je de sorteervolgorde omgekeerd met `-r`?")
    )
  )
)
Ex().success_msg("Gesorteerd! `sort` heeft veel toepassingen. Bijvoorbeeld, door `sort -n` naar `head` te pipen, zie je de grootste waarden.")
```

---

## Hoe kan ik dubbele regels verwijderen?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Een andere opdracht die vaak samen met `sort` wordt gebruikt is `uniq`,
waarvan de taak is om dubbele regels te verwijderen.
Meer specifiek:
hij verwijdert *aangrenzende* dubbele regels.
Als een bestand bevat:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

dan produceert `uniq`:

```
2017-07-03
2017-08-03
```

maar als het bevat:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

dan print `uniq` alle vier de regels.
De reden is dat `uniq` is gebouwd om met zeer grote bestanden te werken.
Om niet-aangrenzende dubbele regels uit een bestand te verwijderen,
zou het het hele bestand in het geheugen moeten houden
(of in elk geval
alle unieke regels die tot dan toe zijn gezien).
Door alleen aangrenzende duplicaten te verwijderen,
hoeft het alleen de meest recente unieke regel in het geheugen te bewaren.

`@instructions`
Schrijf een pipeline die:

- de tweede kolom uit `seasonal/winter.csv` haalt,
- het woord "Tooth" uit de output verwijdert zodat alleen tandnamen overblijven,
- de output sorteert zodat alle voorkomens van een bepaalde tandnaam naast elkaar staan; en
- elke tandnaam één keer weergeeft met een telling van hoe vaak hij voorkomt.

Het begin van je pipeline is hetzelfde als in de vorige oefening:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Breid dit uit met een `sort`-commando, en gebruik `uniq -c` om unieke regels weer te geven met een telling van hoe vaak elke regel voorkomt, in plaats van `uniq` en `wc` te gebruiken.

`@hint`
Kopieer en plak het commando uit de instructies, pipe naar `sort` zonder flags, en pipe daarna opnieuw naar `uniq` met de flag `-c`.

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
                     incorrect_msg="Je zou moeten beginnen met dit commando: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Breid het nu uit!"),
            has_code('\|\s+sort', incorrect_msg="Heb je het commando uitgebreid met `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="Heb je het commando uitgebreid met `| uniq`?"),
            has_code('-c', incorrect_msg="Heb je tellingen opgenomen met `-c`?")
        )
    )
)
Ex().success_msg("Geweldig! Na al dit werk aan een pipe, zou het leuk zijn als we het resultaat konden opslaan, niet?")
```

---

## Hoe kan ik de uitvoer van een pipe opslaan?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

De shell laat je de uitvoer van een reeks gepipete commando's omleiden:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Maar `>` moet aan het einde van de pipeline staan:
als je het in het midden gebruikt, zoals hier:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

wordt alle uitvoer van `cut` naar `teeth-only.txt` geschreven,
waardoor er niets overblijft voor `grep`,
dus die blijft eindeloos wachten op invoer.

<hr>

Wat gebeurt er als we omleiding vooraan in een pipeline zetten, zoals in:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [De uitvoer van het commando wordt zoals gebruikelijk naar het bestand omgeleid.]
- De shell meldt dit als een fout.
- De shell blijft voor altijd wachten op invoer.

`@hint`
Probeer het uit in de shell.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Correct!', 'Nee, de shell kan dit eigenlijk uitvoeren.', 'Nee, de shell kan dit eigenlijk uitvoeren.'])
```

---

## Hoe stop ik een draaiend programma?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

De commando's en scripts die je tot nu toe hebt uitgevoerd, waren allemaal snel klaar,
maar sommige taken duren minuten, uren of zelfs dagen.
Je kunt ook per ongeluk een omleiding midden in een pijplijn zetten,
waardoor het vastloopt.
Als je besluit dat je een programma niet wilt laten doorlopen,
kun je `Ctrl` + `C` typen om het te beëindigen.
Dit wordt in Unix-documentatie vaak geschreven als `^C`;
let op: de 'c' mag een kleine letter zijn.

`@instructions`
Voer het commando uit:

```{shell}
head
```

zonder argumenten (zodat het blijft wachten op invoer die nooit komt)
en stop het daarna door `Ctrl` + `C` te typen.

`@hint`
Typ gewoon head, druk op Enter en beëindig het draaiende programma met `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Heb je `head` gebruikt?")
```

---

## Afronden

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Om af te ronden
bouw je een pijplijn om uit te zoeken hoeveel records er staan in het kortste van de seizoens-databestanden.

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
Gebruik `wc` met de juiste parameters om het aantal regels in alle seizoens-databestanden te tonen.
(Gebruik een wildcard voor de bestandsnamen in plaats van ze allemaal met de hand te typen.)

`@hint`
Gebruik `-l` om alleen de regels te tellen en `*` om bestandsnamen te matchen.

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
      has_code("wc", incorrect_msg = "Heb je `wc` aangeroepen?"),
      has_code("-l", incorrect_msg = "Heb je het aantal regels geteld met `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Heb je gegevens opgehaald uit alle `seasonal/*` bestanden?")
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
Voeg met een pipe een extra opdracht toe aan de vorige om de regel met het woord "total" te verwijderen.

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
      has_code("wc", incorrect_msg = "Heb je `wc` aangeroepen?"),
      has_code("-l", incorrect_msg = "Heb je het aantal regels geteld met `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Heb je gegevens opgehaald uit alle `seasonal/*` bestanden?"),
      has_code("|", incorrect_msg = "Heb je van `wc` naar `grep` gepiped met `|`?"),      
      has_code("grep", incorrect_msg = "Heb je `grep` aangeroepen?"),
      has_code("-v", incorrect_msg = "Heb je de match omgekeerd met `-v`?"),
      has_code("total", incorrect_msg = "Heb je gezocht naar `total`?")
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
Voeg nog twee stappen toe aan de pijplijn die `sort -n` en `head -n 1` gebruiken om het bestand met de minste regels te vinden.

`@hint`
- Gebruik de `-n`-vlag van `sort` om numeriek te sorteren.
- Gebruik de `-n`-vlag van `head` om te beperken tot 1 regel.

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
      has_code("wc", incorrect_msg = "Heb je `wc` aangeroepen?"),
      has_code("-l", incorrect_msg = "Heb je het aantal regels geteld met `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Heb je gegevens opgehaald uit alle `seasonal/*` bestanden?"),
      has_code("|", incorrect_msg = "Heb je van `wc` naar `grep` naar `sort` naar `head` gepiped met `|`?"),      
      has_code("grep", incorrect_msg = "Heb je `grep` aangeroepen?"),
      has_code("-v", incorrect_msg = "Heb je de match omgekeerd met `-v`?"),
      has_code("total", incorrect_msg = "Heb je gezocht naar `total`?"),
      has_code("sort", incorrect_msg = "Heb je `sort` aangeroepen?"),
      has_code("-n", incorrect_msg = "Heb je het aantal regels dat je wilt behouden gespecificeerd met `-n`?"),
      has_code("1", incorrect_msg = "Heb je 1 regel gespecificeerd om te behouden met `-n 1`?")
    )
  )
)
Ex().success_msg("Geweldig! Het blijkt dat `autumn.csv` het bestand is met de minste regels. Ga snel naar hoofdstuk 4 om meer te leren over batchverwerking!")
```

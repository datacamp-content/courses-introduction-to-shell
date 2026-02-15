---
title: Nieuwe tools maken
description: >-
  Met history kun je dingen met maar een paar toetsaanslagen herhalen, en met
  pipes kun je bestaande opdrachten combineren om nieuwe te maken. In dit
  hoofdstuk ga je nog een stap verder en maak je je eigen nieuwe opdrachten.
lessons:
  - nb_of_exercises: 9
    title: Hoe kan ik een bestand bewerken?
---

## Hoe kan ik een bestand bewerken?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix heeft een overweldigende hoeveelheid teksteditors.
Voor deze cursus gebruiken we een eenvoudige editor genaamd Nano.
Als je `nano filename` typt,
opent Nano `filename` om te bewerken
(of maakt het aan als het nog niet bestaat).
Je kunt bewegen met de pijltjestoetsen,
tekens verwijderen met backspace,
en andere bewerkingen doen met combinaties met de control-toets:

- `Ctrl` + `K`: een regel verwijderen.
- `Ctrl` + `U`: een verwijderde regel terughalen.
- `Ctrl` + `O`: het bestand opslaan ('O' staat voor 'output'). _Je moet ook op Enter drukken om de bestandsnaam te bevestigen!_
- `Ctrl` + `X`: de editor afsluiten.

`@instructions`
Voer `nano names.txt` uit om een nieuw bestand in je homedirectory te bewerken
en voer de volgende vier regels in:

```
Lovelace
Hopper
Johnson
Wilson
```

Om op te slaan wat je hebt geschreven,
typ je `Ctrl` + `O` om het bestand weg te schrijven,
dan Enter om de bestandsnaam te bevestigen,
dan `Ctrl` + `X` om de editor af te sluiten.

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
patt = "Heb je de regel `%s` in het bestand `names.txt` opgenomen? Gebruik `nano names.txt` opnieuw om je bestand bij te werken. Gebruik `Ctrl` + `O` om op te slaan en `Ctrl` + `X` om af te sluiten."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Goed gedaan! Op naar de volgende!")
```

---

## Hoe kan ik vastleggen wat ik net heb gedaan?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Als je een complexe analyse doet,
wil je vaak een overzicht bewaren van de opdrachten die je hebt gebruikt.
Dat kan met de tools die je al hebt gezien:

1. Voer `history` uit.
2. Pijp de uitvoer naar `tail -n 10` (of zoveel recente stappen als je wilt bewaren).
3. Leid dat om naar een bestand met een naam als `figure-5.history`.

Dit is beter dan dingen in een labjournaal opschrijven,
omdat je zo gegarandeerd geen stappen overslaat.
Het illustreert ook het kernidee van de shell:
simpele tools die regels tekst produceren en gebruiken
kun je op allerlei manieren combineren
om een breed scala aan problemen op te lossen.

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
Kopieer de bestanden `seasonal/spring.csv` en `seasonal/summer.csv` naar je thuismap.

`@hint`
Gebruik `cp` om te kopiëren en `~` als snelkoppeling voor het pad naar je thuismap.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Heb je `cp seasonal/s* ~` gebruikt om de benodigde bestanden naar je home directory te kopiëren?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Opmerkelijke administratie! Als je een fout hebt gemaakt in een van de opdrachten, kun je altijd `nano` gebruiken om het geschiedenisbestand van de opslagen achteraf op te schonen.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Gebruik `grep` met de vlag `-h` (zodat bestandsnamen niet worden afgedrukt)
en `-v Tooth` (om regels te selecteren die niet overeenkomen met de kopregel)
om de gegevensrecords uit `spring.csv` en `summer.csv` in die volgorde te selecteren
en leid de uitvoer om naar `temp.csv`.

`@hint`
Zet de vlaggen vóór de bestandsnamen.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Zorg ervoor dat je de uitvoer van het `grep`-commando omleidt naar `temp.csv` met `>`!"
msg2 = "Heb je `grep -h -v ___ ___ ___` gebruikt (vul de lege plekken in) om `temp.csv` te vullen?"
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
Pijp `history` naar `tail -n 3`
en leid de uitvoer om naar `steps.txt`
om de laatste drie opdrachten in een bestand op te slaan.
(Je moet er drie opslaan in plaats van twee,
omdat de opdracht `history` zelf ook in de lijst staat.)

`@hint`
Onthoud dat omleiding met `>` aan het einde van de reeks gepijpte opdrachten komt.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Zorg ervoor dat je de uitvoer van je commando omleidt naar `steps.txt`."
msg2="Heb je `history | tail ___ ___` gebruikt (vul de lege plekken in) om `steps.txt` te vullen?"
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
Ex().success_msg("Goed gedaan! Laten we een stapje verder gaan!")
```

---

## Hoe kan ik commando's opslaan om later opnieuw uit te voeren?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Je hebt de shell tot nu toe interactief gebruikt.
Maar omdat de commando's die je typt gewoon tekst zijn,
kun je ze opslaan in bestanden die de shell steeds opnieuw kan uitvoeren.
Om deze krachtige mogelijkheid te verkennen,
zet je het volgende commando in een bestand met de naam `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Dit commando haalt de eerste rij op uit elk van de CSV-bestanden in de map `seasonal`.
Zodra je dit bestand hebt gemaakt,
kun je het uitvoeren door te typen:

```{shell}
bash headers.sh
```

Dit vertelt de shell (wat gewoon een programma genaamd `bash` is)
om de commando's in het bestand `headers.sh` uit te voeren,
wat dezelfde output oplevert als wanneer je de commando's direct draait.

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
Gebruik `nano dates.sh` om een bestand `dates.sh` te maken
met dit commando:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

om de eerste kolom uit alle CSV-bestanden in `seasonal` te halen.

`@hint`
Zet de getoonde commando's in het bestand zonder extra lege regels of spaties.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Heb je de regel `cut -d , -f 1 seasonal/*.csv` in het bestand `dates.sh` opgenomen? Gebruik `nano dates.sh` opnieuw om je bestand bij te werken. Gebruik `Ctrl` + `O` om op te slaan en `Ctrl` + `X` om af te sluiten."
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
Gebruik `bash` om het bestand `dates.sh` uit te voeren.

`@hint`
Gebruik `bash bestandsnaam` om het bestand uit te voeren.

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
      has_code("bash", incorrect_msg = 'Heb je `bash` aangeroepen?'),
      has_code("dates.sh", incorrect_msg = 'Heb je het `dates.sh` bestand gespecificeerd?')
    )
  )
)
```

---

## Hoe kan ik pipes hergebruiken?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Een bestand vol shell-opdrachten heet een ***shellscript**,
of kortweg een "script". Scripts hoeven niet per se te eindigen op `.sh`,
maar in deze les gebruiken we die conventie
zodat je makkelijk kunt bijhouden welke bestanden scripts zijn.

Scripts kunnen ook pipes bevatten.
Als bijvoorbeeld `all-dates.sh` deze regel bevat:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

dan zal:

```{shell}
bash all-dates.sh > dates.out
```

de unieke datums uit de seizoensdata-bestanden halen
en opslaan in `dates.out`.

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
Een bestand `teeth.sh` in je home-directory is voor je klaargezet, maar bevat enkele lege plekken.
Gebruik Nano om het bestand te bewerken en vervang de twee `____` placeholders
door `seasonal/*.csv` en `-c` zodat dit script een telling afdrukt van het
aantal keren dat elke tandnaam voorkomt in de CSV-bestanden in de map `seasonal`.

`@hint`
Gebruik `nano teeth.sh` om het bestand te bewerken.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Heb je de lege plekken goed vervangen zodat het commando in `teeth.sh` `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c` leest? Gebruik `nano teeth.sh` opnieuw om de vereiste wijzigingen aan te brengen."
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
Gebruik `bash` om `teeth.sh` uit te voeren en `>` om de output om te leiden naar `teeth.out`.

`@hint`
Onthoud dat `> teeth.out` *na* de opdracht moet komen die output produceert.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Heb je het resultaat van `bash teeth.sh` correct omgeleid naar `teeth.out` met de `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Heb je `bash` aangeroepen?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Heb je het bestand `teeth.sh` uitgevoerd?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Heb je omgeleid naar het bestand `teeth.out`?')
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
Voer `cat teeth.out` uit om je resultaten te bekijken.

`@hint`
Je kunt de eerste paar letters van een bestandsnaam typen en dan op Tab drukken om automatisch aan te vullen.

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
      has_code("cat", incorrect_msg = 'Heb je `cat` aangeroepen?'),
      has_code("teeth.out", incorrect_msg = 'Heb je het bestand `teeth.out` gespecificeerd?')
    )
  )
)
Ex().success_msg("Mooi! Dit alles kan in het begin geforceerd aanvoelen, maar het mooie is dat je stap voor stap delen van je workflow automatiseert. Iets dat erg handig is als data scientist!")
```

---

## Hoe kan ik bestandsnamen aan scripts doorgeven?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Een script dat specifieke bestanden verwerkt is handig als verslag van wat je hebt gedaan, maar een script waarmee je elk gewenst bestand kunt verwerken is nog handiger.
Om dit te ondersteunen,
kun je de speciale expressie `$@` gebruiken (dollarteken direct gevolgd door apenstaartje)
om "alle commandoregelparameters die aan het script zijn doorgegeven" te betekenen.

Als `unique-lines.sh` bijvoorbeeld `sort $@ | uniq` bevat en je voert uit:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

vervangt de shell `$@` door `seasonal/summer.csv` en wordt één bestand verwerkt. Als je dit uitvoert:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

worden twee databestanden verwerkt, enzovoort.

_Ter herinnering: om op te slaan wat je in Nano hebt geschreven, typ je `Ctrl` + `O` om het bestand weg te schrijven, druk je op Enter om de bestandsnaam te bevestigen en vervolgens `Ctrl` + `X` om de editor af te sluiten._

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
Bewerk het script `count-records.sh` met Nano en vul de twee `____` placeholders
respectievelijk in met `$@` en `-l` (_de letter_) zodat het het aantal regels telt in één of meer bestanden,
waarbij de eerste regel van elk bestand wordt overgeslagen.

`@hint`
* Gebruik `nano count-records.sh` om de bestandsnaam te bewerken.
* Zorg dat je de _letter_ `-l` opgeeft, en niet het cijfer één.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Heb je de lege plekken goed vervangen zodat de opdracht in `count-records.sh` leest als `tail -q -n +2 $@ | wc -l`? Gebruik `nano count-records.sh` opnieuw om de vereiste wijzigingen aan te brengen."
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
Voer `count-records.sh` uit op `seasonal/*.csv`
en leid de uitvoer om naar `num-records.out` met `>`.

`@hint`
Gebruik `>` om de uitvoer te herleiden.

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
      has_code("bash", incorrect_msg = 'Heb je `bash` aangeroepen?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Heb je het bestand `count-records.sh` uitgevoerd?'),
      has_code("seasonal/\*", incorrect_msg = 'Heb je de bestanden gespecificeerd om te verwerken met `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Heb je doorgestuurd naar het bestand `num-records.out`?')
    )
  )
)
Ex().success_msg("Goed gedaan! Je shell-kracht breidt zich steeds verder uit!")
```

---

## Hoe verwerk ik één argument?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Naast `$@` kun je in de shell `$1`, `$2`, enzovoort gebruiken om naar specifieke opdrachtregelparameters te verwijzen.
Hiermee kun je commando's schrijven die eenvoudiger of natuurlijker aanvoelen dan die van de shell zelf.
Je kunt bijvoorbeeld een script `column.sh` maken dat één kolom uit een CSV-bestand selecteert wanneer de gebruiker de bestandsnaam als eerste parameter en de kolom als tweede meegeeft:

```{shell}
cut -d , -f $2 $1
```

en het vervolgens draaien met:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Let op dat het script de twee parameters in omgekeerde volgorde gebruikt.

<hr>

Het script `get-field.sh` moet een bestandsnaam aannemen,
het nummer van de te selecteren rij,
het nummer van de te selecteren kolom,
en precies dat veld uit een CSV-bestand afdrukken.
Bijvoorbeeld:

```
bash get-field.sh seasonal/summer.csv 4 2
```

moet het tweede veld uit regel 4 van `seasonal/summer.csv` selecteren.
Welke van de volgende commando's moet in `get-field.sh` worden gezet om dat te doen?

`@hint`
Vergeet niet dat opdrachtregelparameters van links naar rechts genummerd zijn.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Nee: daarmee probeer je de bestandsnaam te gebruiken als het aantal regels dat `head` moet selecteren.
- Correct!
- Nee: daarmee gebruik je het kolomnummer als regelnummer en andersom.
- Nee: daarmee gebruik je het veldnummer als bestandsnaam en andersom.

---

## Hoe kan één shellscript veel dingen doen?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Onze shellscripts hadden tot nu toe één opdracht of pipe, maar een script kan uit veel regels met opdrachten bestaan. Je kunt bijvoorbeeld een script maken dat je vertelt hoeveel records er staan in het kortste en het langste van je gegevensbestanden, dus het bereik van de lengtes van je datasets.

Let op: in Nano doe je "kopiëren en plakken" door naar de regel te gaan die je wilt kopiëren, `CTRL` + `K` te drukken om de regel te knippen, en daarna twee keer `CTRL` + `U` om er twee kopieën van te plakken.

_Ter herinnering: om op te slaan wat je in Nano hebt geschreven, typ je `Ctrl` + `O` om het bestand weg te schrijven, druk je op Enter om de bestandsnaam te bevestigen, en daarna `Ctrl` + `X` om de editor te sluiten._

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
Gebruik Nano om het script `range.sh` te bewerken
en vervang de twee placeholders `____`
door `$@` en `-v`
zodat het de namen en het aantal regels van alle op de opdrachtregel opgegeven bestanden laat zien
*zónder* het totale aantal regels in alle bestanden te tonen.
(Probeer de kolomkopregels in de bestanden niet af te trekken.)

`@hint`
Gebruik `wc -l $@` om regels te tellen in alle bestanden die op de opdrachtregel zijn opgegeven.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Heb je de lege plekken goed ingevuld zodat het commando in `range.sh` `wc -l $@ | grep -v total` leest? Gebruik `nano range.sh` opnieuw om de vereiste wijzigingen aan te brengen."
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
Gebruik opnieuw Nano om `sort -n` en `head -n 1` in die volgorde
aan de pijplijn in `range.sh` toe te voegen
zodat de naam en regelcount van het kortste bestand dat eraan is doorgegeven worden getoond.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Heb je `sort -n` en `head -n 1` met pipes toegevoegd aan het `range.sh` bestand? Gebruik `nano range.sh` opnieuw om de vereiste wijzigingen aan te brengen."
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
Gebruik weer Nano en voeg een tweede regel toe aan `range.sh` om de naam en het recordaantal van
het *langste* bestand in de map te printen *én* dat van het kortste.
Deze regel moet een kopie zijn van de regel die je al hebt geschreven,
maar met `sort -n -r` in plaats van `sort -n`.

`@hint`
Kopieer de eerste regel en pas de sorteervolgorde aan.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Houd de eerste regel in het `range.sh` bestand: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Heb je de eerste regel in `range.sh` gedupliceerd en een kleine wijziging gemaakt? `sort -n -r` in plaats van `sort -n`!"
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
Voer het script uit op de bestanden in de map `seasonal`
met `seasonal/*.csv` om alle bestanden te matchen
en leid de uitvoer om met `>`
naar een bestand `range.out` in je thuismap.

`@hint`
Gebruik `bash range.sh` om je script uit te voeren, `seasonal/*.csv` om bestanden op te geven, en `> range.out` om de uitvoer om te leiden.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Heb je het resultaat van `bash range.sh seasonal/*.csv` correct omgeleid naar `range.out` met de `>`?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Heb je `bash` aangeroepen?'),
has_code("bash\s+range.sh", incorrect_msg = 'Heb je het `range.sh` bestand uitgevoerd?'),
has_code("seasonal/\*", incorrect_msg = 'Heb je de bestanden om te verwerken gespecificeerd met `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = 'Heb je omgeleid naar het `range.out` bestand?')
)
)

Ex().success_msg("Dit gaat goed. Ga naar de volgende oefening om te leren over het schrijven van loops!")
```

---

## Hoe schrijf ik lussen in een shellscript?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shellscripts kunnen ook lussen bevatten. Je kunt ze met puntkomma's schrijven, of over meerdere regels zonder puntkomma's om ze leesbaarder te maken:

```{shell}
# Print de eerste en laatste gegevensregel van elk bestand.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Je hoeft de opdrachten binnen de lus niet in te springen, maar dat maakt het wel duidelijker.)

De eerste regel van dit script is een **commentaar** om lezers te vertellen wat het script doet. Commentaar begint met het teken `#` en loopt tot het einde van de regel. Je toekomstige zelf zal je dankbaar zijn als je aan elk script dat je schrijft korte uitleg toevoegt, zoals hier.

_Ter herinnering: om op te slaan wat je in Nano hebt geschreven, typ je `Ctrl` + `O` om het bestand weg te schrijven, druk je daarna op Enter om de bestandsnaam te bevestigen, en vervolgens `Ctrl` + `X` om de editor te sluiten._

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
Vul de placeholders in het script `date-range.sh` in
met `$filename` (twee keer), `head` en `tail`,
zodat het de eerste en laatste datum uit één of meer bestanden print.

`@hint`
Vergeet niet `$filename` te gebruiken om de huidige waarde van de lusvariabele op te halen.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="Heb je in `date-range.sh` de %s regel in de lus veranderd naar `%s`? Gebruik `nano date-range.sh` om wijzigingen aan te brengen."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('eerste', cmdpatt%'head')
msg2=msgpatt%('tweede', cmdpatt%'tail')
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
Voer `date-range.sh` uit op alle vier seizoensgegevensbestanden
met `seasonal/*.csv` om op hun namen te matchen.

`@hint`
De jokertekenexpressie moet beginnen met de mapnaam.

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
      has_code("bash", incorrect_msg = 'Heb je `bash` aangeroepen?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Heb je het bestand `date-range.sh` uitgevoerd?'),
      has_code("seasonal/\*", incorrect_msg = 'Heb je de bestanden om te verwerken gespecificeerd met `seasonal/*`?')
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
Voer `date-range.sh` uit op alle vier de seizoensgegevensbestanden met `seasonal/*.csv` om op hun namen te matchen,
en stuur de uitvoer via een pipe naar `sort` om te zien dat je scripts net als de ingebouwde Unix-opdrachten gebruikt kunnen worden.

`@hint`
Gebruik dezelfde jokertekenexpressie als eerder.

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
      has_code("bash", incorrect_msg = 'Heb je `bash` aangeroepen?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Heb je het bestand `date-range.sh` uitgevoerd?'),
      has_code("seasonal/\*", incorrect_msg = 'Heb je de bestanden gespecificeerd om te verwerken met `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Heb je de uitvoer van het script naar `sort` gepiped?'),
      has_code("sort", incorrect_msg = 'Heb je `sort` aangeroepen?')
    )
  )
)
Ex().success_msg("Magie! Merk op hoe samenstelbaar alle dingen zijn die we hebben geleerd.")
```

---

## Wat gebeurt er als ik geen bestandsnamen opgeef?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Een veelgemaakte fout in shellscripts (en interactieve commando's) is bestandsnamen op de verkeerde plek zetten.
Als je typt:

```{shell}
tail -n 3
```

Aangezien `tail` geen bestandsnamen heeft gekregen,
wacht het om invoer van je toetsenbord te lezen.
Dit betekent dat als je typt:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

`tail` gewoon de laatste drie regels van `somefile.txt` afdrukt,
maar `head` eindeloos wacht op invoer van het toetsenbord,
omdat het geen bestandsnaam kreeg en er niets vóór staat in de pijplijn.

<hr>

Stel dat je per ongeluk typt:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Wat moet je dan doen?

`@possible_answers`
- Wacht 10 seconden totdat `head` een timeout krijgt.
- Typ `somefile.txt` en druk op Enter om `head` invoer te geven.
- Gebruik `Ctrl` + `C` om het draaiende `head`-programma te stoppen.

`@hint`
Wat doet `head` als het geen bestandsnaam heeft en er niets vóór in de pijplijn staat?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Nee, opdrachten zullen niet verlopen.'
a2 = 'Nee, dat zal `head` de tekst `somefile.txt` geven om te verwerken, maar dan blijft het wachten op nog meer invoer.'
a3 = "Ja! Je moet `Ctrl` + `C` gebruiken om een draaiend programma te stoppen. Dit is het einde van deze introductiecursus! Als je geïnteresseerd bent om meer commandoregeltools te leren, raden we je ten zeerste aan om onze gratis intro tot Git-cursus te volgen!"
Ex().has_chosen(3, [a1, a2, a3])
```

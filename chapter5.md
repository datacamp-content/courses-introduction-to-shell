---
title: Skapa nya verktyg
description: >-
  Historiken låter dig upprepa kommandon med bara några knapptryckningar, och
  pipes låter dig kombinera befintliga kommandon för att skapa nya. I det här
  kapitlet ser du hur du går ett steg längre och skapar helt egna kommandon.
lessons:
  - nb_of_exercises: 9
    title: Hur redigerar jag en fil?
---

## Hur redigerar man en fil?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix har ett förvirrande stort utbud av textredigerare.
I den här kursen använder vi en enkel redigerare som heter Nano.
Om du skriver `nano filnamn` öppnas `filnamn` för redigering
(eller skapas om filen inte redan finns).
Du kan navigera med piltangenterna,
trycka på backsteg för att ta bort tecken,
och använda kortkommandon med Ctrl-tangenten för andra funktioner:

- `Ctrl` + `K`: ta bort en rad.
- `Ctrl` + `U`: ångra borttagning av en rad.
- `Ctrl` + `O`: spara filen ('O' står för 'output'). _Du måste också trycka på Enter för att bekräfta filnamnet!_
- `Ctrl` + `X`: avsluta redigeraren.

`@instructions`
Kör `nano names.txt` för att redigera en ny fil i din hemkatalog
och ange följande fyra rader:

```
Lovelace
Hopper
Johnson
Wilson
```

För att spara det du har skrivit
trycker du `Ctrl` + `O` för att skriva filen,
sedan Enter för att bekräfta filnamnet,
och slutligen `Ctrl` + `X` för att avsluta redigeraren.

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
patt = "Har du inkluderat raden `%s` i filen `names.txt`? Använd `nano names.txt` igen för att uppdatera filen. Använd `Ctrl` + `O` för att spara och `Ctrl` + `X` för att avsluta."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Bra gjort! Vidare till nästa!")
```

---

## Hur sparar jag vad jag nyss gjorde?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

När du genomför en komplex analys vill du ofta ha ett register över de kommandon du använt.
Det kan du åstadkomma med verktyg du redan känner till:

1. Kör `history`.
2. Skicka utdata via pipe till `tail -n 10` (eller hur många senaste steg du vill spara).
3. Omdirigera resultatet till en fil med ett namn som `figure-5.history`.

Det här är bättre än att anteckna för hand i en loggbok,
eftersom det garanterat inte missar något steg.
Det illustrerar också skalets grundläggande idé:
enkla verktyg som producerar och konsumerar textrader
kan kombineras på en mängd olika sätt
för att lösa ett brett spektrum av problem.

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
Kopiera filerna `seasonal/spring.csv` och `seasonal/summer.csv` till din hemkatalog.

`@hint`
Använd `cp` för att kopiera och `~` som genväg till sökvägen för din hemkatalog.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Har du använt `cp seasonal/s* ~` för att kopiera de nödvändiga filerna till din hemkatalog?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Remarkabel journalföring! Om du har skrivit fel i några kommandon kan du alltid använda `nano` för att rensa upp historikfilen efteråt.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Använd `grep` med flaggan `-h` (för att förhindra att filnamn skrivs ut)
och `-v Tooth` (för att välja rader som *inte* matchar rubrikraden)
för att välja dataposter från `spring.csv` och `summer.csv` i den ordningen
och omdirigera utdata till `temp.csv`.

`@hint`
Placera flaggorna före filnamnen.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Se till att du omdirigerar utdata från kommandot `grep` till `temp.csv` med `>`!"
msg2 = "Har du använt `grep -h -v ___ ___ ___` (fyll i luckorna) för att fylla `temp.csv`?"
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
Skicka `history` via pipe till `tail -n 3`
och omdirigera utdata till `steps.txt`
för att spara de tre senaste kommandona i en fil.
(Du behöver spara tre i stället för bara två
eftersom kommandot `history` i sig självt kommer att finnas med i listan.)

`@hint`
Kom ihåg att omdirigering med `>` placeras i slutet av den pipade kommandosekvensen.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Se till att omdirigera utdata från ditt kommando till `steps.txt`."
msg2="Har du använt `history | tail ___ ___` (fyll i luckorna) för att fylla `steps.txt`?"
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
Ex().success_msg("Bra gjort! Nu tar vi det ett steg längre!")
```

---

## Hur sparar jag kommandon för att köra dem igen senare?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Hittills har du använt skalet interaktivt.
Men eftersom kommandona du skriver bara är text,
kan du spara dem i filer som skalet sedan kan köra om och om igen.
För att utforska den här kraftfulla möjligheten,
lägg följande kommando i en fil som heter `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Det här kommandot hämtar den första raden från var och en av CSV-filerna i katalogen `seasonal`.
När du har skapat filen
kan du köra den genom att skriva:

```{shell}
bash headers.sh
```

Detta instruerar skalet (som är ett program som kallas `bash`)
att köra kommandona i filen `headers.sh`,
vilket ger samma utdata som om du hade kört kommandona direkt.

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
Använd `nano dates.sh` för att skapa en fil som heter `dates.sh`
med följande kommando:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

Det här extraherar den första kolumnen från alla CSV-filer i `seasonal`.

`@hint`
Skriv in kommandona i filen utan extra tomma rader eller mellanslag.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Har du inkluderat raden `cut -d , -f 1 seasonal/*.csv` i filen `dates.sh`? Använd `nano dates.sh` igen för att uppdatera din fil. Använd `Ctrl` + `O` för att spara och `Ctrl` + `X` för att avsluta."
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
Använd `bash` för att köra filen `dates.sh`.

`@hint`
Använd `bash filnamn` för att köra filen.

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
      has_code("bash", incorrect_msg = 'Anropade du `bash`?'),
      has_code("dates.sh", incorrect_msg = 'Angav du filen `dates.sh`?')
    )
  )
)
```

---

## Hur kan jag återanvända pipes?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

En fil med shell-kommandon kallas ett ***skalskript**,
eller ibland bara "skript" för kort. Skript behöver inte ha namn som slutar på `.sh`,
men den här lektionen använder den konventionen
för att hjälpa dig hålla koll på vilka filer som är skript.

Skript kan också innehålla pipes.
Till exempel,
om `all-dates.sh` innehåller den här raden:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

kommer:

```{shell}
bash all-dates.sh > dates.out
```

att extrahera de unika datumen från de säsongsbetingade datafilerna
och spara dem i `dates.out`.

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
En fil `teeth.sh` i din hemkatalog har förberetts åt dig, men innehåller några tomma platser.
Använd Nano för att redigera filen och ersätt de två `____`-platshållarna
med `seasonal/*.csv` och `-c` så att skriptet skriver ut en räkning av hur många
gånger varje tandnamn förekommer i CSV-filerna i katalogen `seasonal`.

`@hint`
Använd `nano teeth.sh` för att redigera filen.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Har du ersatt luckorna korrekt så att kommandot i `teeth.sh` lyder `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Använd `nano teeth.sh` igen för att göra de nödvändiga ändringarna."
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
Använd `bash` för att köra `teeth.sh` och `>` för att omdirigera utdata till `teeth.out`.

`@hint`
Kom ihåg att `> teeth.out` måste komma *efter* det kommando som producerar utdata.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Har du korrekt omdirigerat resultatet av `bash teeth.sh` till `teeth.out` med `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Anropade du `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Körde du filen `teeth.sh`?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Omdirigerade du till filen `teeth.out`?')
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
Kör `cat teeth.out` för att granska dina resultat.

`@hint`
Kom ihåg att du kan skriva de första tecknen i ett filnamn och sedan trycka på tabbtangenten för att autokomplettera.

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
      has_code("cat", incorrect_msg = 'Anropade du `cat`?'),
      has_code("teeth.out", incorrect_msg = 'Angav du filen `teeth.out`?')
    )
  )
)
Ex().success_msg("Bra! Allt detta kan kännas konstruerat till en början, men det fina är att du automatiserar delar av ditt arbetsflöde steg för steg. Något som är mycket praktiskt som datavetenskap!")
```

---

## Hur skickar jag filnamn till skript?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Ett skript som bearbetar specifika filer är praktiskt som dokumentation av vad du gjort, men ett skript som kan bearbeta vilka filer som helst är ännu mer användbart.
För att stödja detta
kan du använda det speciella uttrycket `$@` (dollartecken direkt följt av ett snabel-a)
som betyder "alla kommandoradsparametrar som skickats till skriptet".

Om till exempel `unique-lines.sh` innehåller `sort $@ | uniq`, och du kör:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

ersätter skalet `$@` med `seasonal/summer.csv` och bearbetar en fil. Om du kör detta:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

bearbetas två datafiler, och så vidare.

_Som en påminnelse: för att spara det du skrivit i Nano, tryck `Ctrl` + `O` för att skriva filen, sedan Enter för att bekräfta filnamnet och sedan `Ctrl` + `X` för att avsluta redigeraren._

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
Redigera skriptet `count-records.sh` med Nano och fyll i de två `____`-platshållarna
med `$@` respektive `-l` (_bokstaven_), så att skriptet räknar antalet rader i en eller flera filer
och utesluter den första raden i varje fil.

`@hint`
* Använd `nano count-records.sh` för att redigera filen.
* Se till att du anger _bokstaven_ `-l` och inte siffran ett.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Har du ersatt luckorna korrekt så att kommandot i `count-records.sh` lyder `tail -q -n +2 $@ | wc -l`? Använd `nano count-records.sh` igen för att göra de nödvändiga ändringarna."
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
Kör `count-records.sh` på `seasonal/*.csv`
och omdirigera utdata till `num-records.out` med `>`.

`@hint`
Använd `>` för att omdirigera utdata.

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
      has_code("bash", incorrect_msg = 'Anropade du `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Körde du filen `count-records.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Angav du filerna som ska bearbetas med `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Omdirigerade du till filen `num-records.out`?')
    )
  )
)
Ex().success_msg("Väl utfört! Din förmåga med skalet växer ständigt!")
```

---

## Hur bearbetar jag ett enskilt argument?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Förutom `$@`
kan du i skalet använda `$1`, `$2` och så vidare för att referera till specifika parametrar på kommandoraden.
Det gör det möjligt att skriva kommandon som känns enklare eller mer naturliga än skalets egna.
Du kan till exempel skapa ett skript som heter `column.sh` och som väljer ut en enskild kolumn från en CSV-fil
när användaren anger filnamnet som första parameter och kolumnen som andra:

```{shell}
cut -d , -f $2 $1
```

och sedan köra det med:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Observera att skriptet använder de två parametrarna i omvänd ordning.

<hr>

Skriptet `get-field.sh` ska ta ett filnamn,
numret på den rad som ska väljas,
numret på den kolumn som ska väljas,
och skriva ut just det fältet från en CSV-fil.
Till exempel ska:

```
bash get-field.sh seasonal/summer.csv 4 2
```

välja det andra fältet från rad 4 i `seasonal/summer.csv`.
Vilket av följande kommandon ska placeras i `get-field.sh` för att åstadkomma det?

`@hint`
Kom ihåg att parametrar på kommandoraden numreras från vänster till höger.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Nej: det försöker använda filnamnet som antal rader att välja med `head`.
- Rätt!
- Nej: det försöker använda kolumnnumret som radnummer och vice versa.
- Nej: det använder fältnumret som filnamn och vice versa.

---

## Hur kan ett skalskript göra många saker?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Våra skalskript har hittills bestått av ett enda kommando eller en pipe, men ett skript kan innehålla många rader med kommandon. Du kan till exempel skapa ett skript som visar hur många poster som finns i den kortaste och den längsta av dina datafiler – det vill säga längdspannet i dina datamängder.

Observera att "kopiera och klistra in" i Nano går till så här: navigera till raden du vill kopiera, tryck `CTRL` + `K` för att klippa ut raden och sedan `CTRL` + `U` två gånger för att klistra in två kopior av den.

_Som en påminnelse: för att spara det du har skrivit i Nano skriver du `Ctrl` + `O` för att skriva filen, trycker Enter för att bekräfta filnamnet och sedan `Ctrl` + `X` för att avsluta editorn._

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
Använd Nano för att redigera skriptet `range.sh`
och ersätt de två platshållarna `____`
med `$@` och `-v`
så att skriptet listar namn och radantal för alla filer som anges på kommandoraden
*utan* att visa det totala antalet rader för alla filer.
(Försök inte subtrahera kolumnrubriker från filerna.)

`@hint`
Använd `wc -l $@` för att räkna rader i alla filer som anges på kommandoraden.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Har du ersatt luckorna korrekt så att kommandot i `range.sh` lyder `wc -l $@ | grep -v total`? Använd `nano range.sh` igen för att göra de nödvändiga ändringarna."
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
Använd Nano igen för att lägga till `sort -n` och `head -n 1` i den ordningen
till pipe-kedjan i `range.sh`
så att skriptet visar namn och radantal för den kortaste filen som skickas in.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Har du lagt till `sort -n` och `head -n 1` med pipes i filen `range.sh`? Använd `nano range.sh` igen för att göra de nödvändiga ändringarna."
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
Använd Nano för att lägga till en andra rad i `range.sh` som skriver ut namn och postantal för
den *längsta* filen i katalogen *samt* den kortaste.
Den här raden ska vara en kopia av den du redan har skrivit,
men med `sort -n -r` i stället för `sort -n`.

`@hint`
Kopiera den första raden och ändra sorteringsordningen.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Behåll den första raden i filen `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Har du duplicerat den första raden i `range.sh` och gjort en liten ändring? `sort -n -r` istället för `sort -n`!"
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
Kör skriptet på filerna i katalogen `seasonal`
och använd `seasonal/*.csv` för att matcha alla filer.
Omdirigera utdata med `>`
till en fil som heter `range.out` i din hemkatalog.

`@hint`
Använd `bash range.sh` för att köra skriptet, `seasonal/*.csv` för att ange filerna och `> range.out` för att omdirigera utdata.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Har du korrekt omdirigerat resultatet av `bash range.sh seasonal/*.csv` till `range.out` med `>`?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Anropade du `bash`?'),
has_code("bash\s+range.sh", incorrect_msg = 'Körde du filen `range.sh`?'),
has_code("seasonal/\*", incorrect_msg = 'Angav du filerna som ska bearbetas med `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = 'Omdirigerade du till filen `range.out`?')
)
)

Ex().success_msg("Det går bra. Gå vidare till nästa övning för att lära dig om att skriva loopar!")
```

---

## Hur skriver man loopar i ett skalskript?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Skalskript kan också innehålla loopar. Du kan skriva dem med semikolon, eller dela upp dem över flera rader utan semikolon för att göra dem mer lättlästa:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Du behöver inte indentera kommandona inuti loopen, men det gör koden tydligare.)

Den första raden i det här skriptet är en **kommentar** som berättar för läsaren vad skriptet gör. Kommentarer börjar med tecknet `#` och löper till slutet av raden. Ditt framtida jag kommer att tacka dig för att du lägger till korta förklaringar som den här i varje skript du skriver.

_Som en påminnelse: för att spara det du har skrivit i Nano, tryck `Ctrl` + `O` för att skriva filen, sedan Enter för att bekräfta filnamnet och därefter `Ctrl` + `X` för att avsluta editorn._

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
Fyll i platshållarna i skriptet `date-range.sh`
med `$filename` (två gånger), `head` och `tail`
så att det skriver ut det första och sista datumet från en eller flera filer.

`@hint`
Kom ihåg att använda `$filename` för att hämta det aktuella värdet på loopvariabeln.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="I `date-range.sh`, har du ändrat %s raden i loopen till `%s`? Använd `nano date-range.sh` för att göra ändringar."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('första', cmdpatt%'head')
msg2=msgpatt%('andra', cmdpatt%'tail')
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
Kör `date-range.sh` på alla fyra säsongsdatafiler
och använd `seasonal/*.csv` för att matcha deras namn.

`@hint`
Jokerteckensuttrycket ska börja med katalognamnet.

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
      has_code("bash", incorrect_msg = 'Anropade du `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Körde du filen `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Angav du filerna som ska bearbetas med `seasonal/*`?')
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
Kör `date-range.sh` på alla fyra säsongsdatafiler med `seasonal/*.csv` för att matcha deras namn,
och skicka utdata vidare till `sort` via ett rör för att se att dina skript kan användas precis som Unix inbyggda kommandon.

`@hint`
Använd samma jokerteckensuttryck som du använde tidigare.

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
      has_code("bash", incorrect_msg = 'Anropade du `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Körde du filen `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Angav du filerna som ska bearbetas med `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Skickade du skriptets utdata via pipe till `sort`?'),
      has_code("sort", incorrect_msg = 'Anropade du `sort`?')
    )
  )
)
Ex().success_msg("Fantastiskt! Lägg märke till hur sammansättningsbara alla de saker vi har lärt oss är.")
```

---

## Vad händer om jag inte anger filnamn?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Ett vanligt misstag i shellskript – och interaktiva kommandon – är att placera filnamn på fel ställe.
Om du skriver:

```{shell}
tail -n 3
```

väntar `tail` på indata från tangentbordet, eftersom inget filnamn har angetts.
Det innebär att om du skriver:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

skriver `tail` ut de tre sista raderna i `somefile.txt` som förväntat,
men `head` väntar i all oändlighet på tangentbordsindata –
eftersom det varken fick ett filnamn eller tar emot data via en pipe.

<hr>

Anta att du av misstag skriver:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Vad bör du göra nu?

`@possible_answers`
- Vänta 10 sekunder på att `head` ska tajma ut.
- Skriv `somefile.txt` och tryck Enter för att ge `head` indata.
- Använd `Ctrl` + `C` för att avbryta det körande `head`-programmet.

`@hint`
Vad gör `head` om det inte får ett filnamn och inget skickas till det via en pipe?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Nej, kommandon kommer inte att ta slut på tid.'
a2 = 'Nej, det kommer att ge `head` texten `somefile.txt` att bearbeta, men sedan kommer det att hänga och vänta på mer inmatning.'
a3 = "Ja! Du bör använda `Ctrl` + `C` för att stoppa ett program som körs. Detta avslutar den här introduktionskursen! Om du är intresserad av att lära dig mer om kommandoradsverktyg rekommenderar vi varmt att du tar vår kostnadsfria introduktionskurs till Git!"
Ex().has_chosen(3, [a1, a2, a3])
```

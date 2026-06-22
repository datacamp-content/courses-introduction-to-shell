---
title: Hantera data
description: >-
  Kommandona i föregående kapitel visade hur du flyttar runt saker i
  filsystemet. Det här kapitlet visar hur du arbetar med innehållet i filerna.
  Verktygen vi använder är enkla men utgör ett stabilt fundament.
lessons:
  - nb_of_exercises: 12
    title: Hur visar jag innehållet i en fil?
---

## Hur visar jag innehållet i en fil?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Innan du byter namn på eller tar bort filer
kanske du vill titta på deras innehåll.
Det enklaste sättet är att använda `cat`,
som skriver ut innehållet i filer direkt på skärmen.
(Namnet är en förkortning av "concatenate", det vill säga "att länka ihop saker",
eftersom kommandot skriver ut alla filer vars namn du anger, en efter en.)

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
Skriv ut innehållet i `course.txt` på skärmen.

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
    has_expr_output(incorrect_msg="Ditt kommando genererade inte rätt utdata. Har du använt `cat` följt av filnamnet, `course.txt`?")
)
Ex().success_msg("Bra! Låt oss titta på andra sätt att visa en fils innehåll.")
```

---

## Hur visar jag ett filinnehåll bit för bit?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Du kan använda `cat` för att skriva ut stora filer och sedan bläddra genom utdata,
men det är oftast bekvämare att **bläddra** igenom utdata sida för sida.
Den ursprungliga kommandot för detta kallades `more`,
men det har ersatts av ett kraftfullare kommando som heter `less`.
(Den här typen av namngivning är vad som räknas som humor i Unix-världen.)
När du kör `less` på en fil visas ett sida i taget;
du kan trycka på mellanslagstangenten för att bläddra ned eller skriva `q` för att avsluta.

Om du anger flera filnamn till `less`
kan du skriva `:n` (kolon och ett gement 'n') för att gå till nästa fil,
`:p` för att gå tillbaka till föregående,
eller `:q` för att avsluta.

Obs: Om du tittar på lösningar till övningar som använder `less`
kommer du att se ett extra kommando i slutet som stänger av sidvisningen
så att vi kan testa dina lösningar på ett effektivt sätt.

`@instructions`
Använd `less seasonal/spring.csv seasonal/summer.csv` för att visa de två filerna i den ordningen.
Tryck på mellanslagstangenten för att bläddra ned, `:n` för att gå till den andra filen och `:q` för att avsluta.

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
                 incorrect_msg='Använd `less` och filnamnen. Kom ihåg att `:n` flyttar dig till nästa fil.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Hur visar jag början av en fil?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Det första de flesta datavetare gör när de får ett nytt dataset att analysera är
att ta reda på vilka fält det innehåller och vilka värden dessa fält har.
Om datasetet har exporterats från en databas eller ett kalkylblad
lagras det ofta som **kommaseparerade värden** (CSV).
Ett snabbt sätt att få en överblick är att titta på de första raderna.

Det kan vi göra i terminalen med kommandot `head`.
Som namnet antyder
skriver det ut de första raderna i en fil
(där "några" betyder 10),
så kommandot:

```{shell}
head seasonal/summer.csv
```

visar:

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

Vad händer om filen innehåller färre än 10 rader när du kör `head`?
(Ta reda på det genom att titta på toppen av `people/agarwal.txt`.)

`@possible_answers`
- Skriver ut ett felmeddelande eftersom filen är för kort.
- Visar så många rader som finns.
- Fyller på med tomma rader tills totalen når 10.

`@hint`
Vad är det mest användbara den skulle kunna göra?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Felaktigt: det är inte det mest användbara det kan göra.",
                    "Korrekt!",
                    "Felaktigt: det skulle vara omöjligt att skilja från en fil som slutade med ett antal tomma rader."])
```

---

## Hur skriver du mindre?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Ett av skalens kraftfulla verktyg är **tabbkomplettering**.
Om du börjar skriva ett filnamn och sedan trycker på tabb-tangenten
försöker skalet automatiskt komplettera sökvägen.
Om du till exempel skriver `sea` och trycker på tabb
fylls katalognamnet `seasonal/` i (med ett avslutande snedstreck).
Om du sedan skriver `a` och trycker på tabb
kompletteras sökvägen till `seasonal/autumn.csv`.

Om sökvägen är tvetydig,
till exempel `seasonal/s`,
visas en lista med möjliga alternativ om du trycker på tabb en gång till.
Skriv ytterligare ett tecken eller två för att göra sökvägen mer specifik
och tryck sedan på tabb
för att fylla i resten av namnet.

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
Kör `head seasonal/autumn.csv` utan att skriva hela filnamnet.

`@hint`
Skriv så mycket av sökvägen som behövs, tryck sedan på tabb och upprepa.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Kontrollanten kunde inte hitta rätt utdata i ditt kommando. Är du säker på att du anropade `head` på `seasonal/autumn.csv`?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Kör `head seasonal/spring.csv` utan att skriva hela filnamnet.

`@hint`
Skriv så mycket av sökvägen som behövs, tryck sedan på tabb och upprepa.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Kontrollen kunde inte hitta rätt utdata i ditt kommando. Är du säker på att du anropade `head` på `seasonal/spring.csv`?")
)
Ex().success_msg("Bra jobbat! När du väl vant dig vid att använda tabbkomplettering kommer det att spara dig mycket tid!")
```

---

## Hur styr jag vad kommandon gör?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Du vill inte alltid visa de första 10 raderna i en fil,
och därför kan du ändra `head`s beteende
genom att ge det en **kommandoradsflagga** (eller bara "flagga" för kort).
Om du kör kommandot:

```{shell}
head -n 3 seasonal/summer.csv
```

visar `head` bara de tre första raderna i filen.
Kör du `head -n 100`,
visas de första 100 raderna (förutsatt att det finns så många),
och så vidare.

En flaggas namn anger vanligtvis dess syfte
(till exempel är `-n` tänkt att signalera "**n**umber of lines").
Kommandoflaggor behöver inte bestå av ett `-` följt av en enda bokstav,
men det är en vanligt förekommande konvention.

Obs: det anses god praxis att placera alla flaggor *före* eventuella filnamn,
och i den här kursen
godkänner vi därför bara svar som följer den regeln.

`@instructions`
Visa de första 5 raderna i `winter.csv` i katalogen `seasonal`.

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
        has_expr_output(incorrect_msg="Är du säker på att du anropar `head` på filen `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Är du säker på att du använde flaggan `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Är du säker på att du använde flaggan `-n 5`?")
)
Ex().success_msg("Bra! Med den här tekniken kan du undvika att ditt skal kraschar om du vill titta på större textfiler.")
```

---

## Hur listar jag allt under en katalog?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

För att se allt som finns under en katalog,
oavsett hur djupt det är nästlat,
kan du ge `ls` flaggan `-R`
(som står för "recursive", det vill säga rekursiv).
Om du kör `ls -R` i din hemkatalog
ser du något i stil med:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Detta visar alla filer och kataloger på den aktuella nivån,
sedan allt i varje underkatalog,
och så vidare.

`@instructions`
För att göra det lättare att se vad som är vad
har `ls` ytterligare en flagga, `-F`, som skriver ut ett `/` efter namnet på varje katalog
och ett `*` efter namnet på varje körbart program.
Kör `ls` med de två flaggorna `-R` och `-F` samt den absoluta sökvägen till din hemkatalog
för att se allt den innehåller.
(Ordningen på flaggorna spelar ingen roll, men katalognamnet måste komma sist.)

`@hint`
Din hemkatalog kan anges med `~` eller `.` eller dess absoluta sökväg.

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
  has_expr_output(incorrect_msg='Använd antingen `ls -R -F` eller `ls -F -R` och sökvägen `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Använd antingen `ls -R -F` eller `ls -F -R` och sökvägen `/home/repl`.')
)
Ex().success_msg("Det är en ganska bra översikt, eller hur?")
```

---

## Hur får jag hjälp med ett kommando?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

För att ta reda på vad kommandon gör använde man förr kommandot `man` (förkortning av "manual"). Kommandot `man head` visar till exempel den här informationen:

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

`man` startar automatiskt `less`, så du kan behöva trycka på mellanslagstangenten för att bläddra igenom informationen och `:q` för att avsluta.

Enradsbeskrivningen under `NAME` berättar kort vad kommandot gör, och sammanfattningen under `SYNOPSIS` listar alla flaggor det känner till. Valfria delar visas inom hakparenteser `[...]`, antingen/eller-alternativ separeras med `|`, och saker som kan upprepas markeras med `...`. Manualsidan för `head` talar alltså om att du *antingen* kan ange ett radantal med `-n` eller ett byteantal med `-c`, och att du kan ange valfritt antal filnamn.

Problemet med Unix-manualen är att du måste veta vad du letar efter. Om du inte gör det kan du söka på [Stack Overflow](https://stackoverflow.com/), ställa en fråga i DataCamps Slack-kanaler, eller titta i `SEE ALSO`-avsnitten för de kommandon du redan känner till.

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
Läs manualsidan för kommandot `tail` för att ta reda på vad ett `+`-tecken framför talet i flaggan `-n` gör. (Kom ihåg att trycka på mellanslagstangenten för att bläddra ned och/eller skriva `q` för att avsluta.)

`@hint`
Kom ihåg: `man` är en förkortning av "manual".

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Använd `man` och kommandonamnet.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Använd `tail` med flaggan `-n +7` för att visa alla rader utom de första sex i `seasonal/spring.csv`.

`@hint`
Använd ett plustecken '+' framför antalet rader du vill visa.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Anropar du `tail` på `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Är du säker på att du använde flaggan `-n +7`?")
)
```

---

## Hur väljer man kolumner från en fil?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` och `tail` låter dig välja rader från en textfil.
Om du vill välja kolumner kan du använda kommandot `cut`.
Det har flera alternativ (använd `man cut` för att utforska dem),
men det vanligaste ser ut ungefär så här:

```{shell}
cut -f 2-5,8 -d , values.csv
```

Detta innebär
"välj kolumnerna 2 till 5 och kolumn 8,
med kommatecken som avgränsare".
`cut` använder `-f` (av engelskans "fields") för att ange kolumner
och `-d` (av engelskans "delimiter") för att ange avgränsaren.
Du behöver ange den sistnämnda eftersom vissa filer kan använda mellanslag, tabbar eller kolon för att separera kolumner.

<hr>

Vilket kommando väljer den första kolumnen (med datum) från filen `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Endera av ovanstående.
- Inget av ovanstående, eftersom `-f` måste komma före `-d`.

`@hint`
Ordningen på flaggorna spelar ingen roll.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Yes, but that is not all', 'Yes, but that is not all', 'Correct! Adding a space after the flag is good style, but not compulsory.', 'No, flag order doesn\'t matter'])
```

---

## Vad kan inte cut göra?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` är ett enkelt kommando.
Det förstår framför allt inte citerade strängar.
Om din fil till exempel ser ut så här:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

kommer:

```{shell}
cut -f 2 -d , everyone.csv
```

att ge:

```
Age
Ranjit"
Rupinder"
```

i stället för allas ålder,
eftersom kommandot tolkar kommatecknet mellan efternamn och förnamn som en kolumnavgränsare.

<hr>

Vad ger `cut -d : -f 2-4` på raden:

```
first:second:third:
```

(Observera det avslutande kolonet.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Inget av ovanstående, eftersom det inte finns fyra fält.

`@hint`
Var uppmärksam på det avslutande kolonet.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Nej, det finns mer.', 'Nej, det finns mer.', 'Korrekt! Det avslutande kolonet skapar ett tomt fjärde fält.', 'Nej, `cut` gör sitt bästa.'])
```

---

## Hur upprepar jag kommandon?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

En av de största fördelarna med att använda kommandoraden är att
det är enkelt att upprepa saker du redan gjort.
Om du har kört några kommandon kan du trycka på uppåtpilen för att bläddra tillbaka genom dem.
Du kan också använda vänster- och högerpilarna samt delete-tangenten för att redigera dem.
Tryck sedan på Enter för att köra det ändrade kommandot.

Ännu bättre: `history` skriver ut en lista över kommandon du nyligen har kört.
Varje kommando föregås av ett löpnummer, vilket gör det enkelt att köra om ett specifikt kommando:
skriver du till exempel `!55` körs det 55:e kommandot i din historik (om du har så många).
Du kan också köra om ett kommando genom att skriva ett utropstecken följt av kommandots namn,
till exempel `!head` eller `!cut`,
vilket kör om den senaste användningen av det kommandot.

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
Kör `head summer.csv` i din hemkatalog (det bör misslyckas).

`@hint`
Tabbkomplettering fungerar inte om det inte finns ett matchande filnamn.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Använd `head` och ett filnamn, `summer.csv`. Oroa dig inte om det misslyckas. Det ska det.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Byt katalog till `seasonal`.

`@hint`
Kom ihåg att `cd` står för "change directory" (byt katalog).

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Om din nuvarande arbetskatalog (ta reda på det med `pwd`) är `/home/repl`, kan du flytta till mappen `seasonal` med `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Kör om kommandot `head` med `!head`.

`@hint`
Skriv inga mellanslag mellan `!` och det som följer.

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
                        incorrect_msg='Använd `!head` för att upprepa kommandot `head`.'),
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
Använd `history` för att se vad du har gjort.

`@hint`
Observera att `history` visar de senaste kommandona sist, så att de syns på skärmen när körningen är klar.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Använd `history` utan flaggor för att få en lista över tidigare kommandon.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Kör om `head` igen med hjälp av `!` följt av ett kommandonummer.

`@hint`
Skriv *inte* några mellanslag mellan `!` och det som följer.

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
                        incorrect_msg='Har du använt `!<a_number>` för att köra om det senaste `head`-kommandot från historiken?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Bra gjort! Till nästa!")
```

---

## Hur väljer jag rader som innehåller specifika värden?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` och `tail` väljer rader,
`cut` väljer kolumner,
och `grep` väljer rader baserat på vad de innehåller.
I sin enklaste form tar `grep` en textsträng följt av ett eller flera filnamn
och skriver ut alla rader i dessa filer som innehåller den texten.
Till exempel skriver
`grep bicuspid seasonal/winter.csv`
ut rader från `winter.csv` som innehåller "bicuspid".

`grep` kan även söka efter mönster –
detta utforskar vi i nästa kurs.
Mer relevant just nu är några av `grep`s vanligaste flaggor:

- `-c`: skriv ut antalet matchande rader i stället för själva raderna
- `-h`: skriv *inte* ut filnamn vid sökning i flera filer
- `-i`: ignorera skiftläge (dvs. behandla "Regression" och "regression" som matchningar)
- `-l`: skriv ut namnen på filer som innehåller matchningar, inte matchningarna själva
- `-n`: skriv ut radnummer för matchande rader
- `-v`: invertera matchningen, dvs. visa bara rader som *inte* matchar

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
Skriv ut innehållet i alla rader som innehåller ordet `molar` i `seasonal/autumn.csv`
genom att köra ett enda kommando från din hemkatalog. Använd inga flaggor.

`@hint`
Använd `grep` med det ord du söker efter och namnet på den eller de filer du vill söka i.

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
      has_code("grep", incorrect_msg = "Anropade du `grep`?"),
      has_code("molar", incorrect_msg = "Sökte du efter `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Sökte du i filen `seasonal/autumn.csv`?")
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
Invertera matchningen för att hitta alla rader som *inte* innehåller ordet `molar` i `seasonal/spring.csv`, och visa deras radnummer.
Kom ihåg att det anses vara god stil att placera alla flaggor *före* andra värden som filnamn eller söktermen "molar".

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
      has_code("grep", incorrect_msg = "Anropade du `grep`?"),
      has_code("-v", incorrect_msg = "Inverterade du matchningen med `-v`?"),
      has_code("-n", incorrect_msg = "Visade du radnummer med `-n`?"),
      has_code("molar", incorrect_msg = "Sökte du efter `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Sökte du i filen `seasonal/spring.csv`?")
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
Räkna hur många rader som innehåller ordet `incisor` i `autumn.csv` och `winter.csv` tillsammans.
(Kör även här ett enda kommando från din hemkatalog.)

`@hint`
Kom ihåg att använda flaggan `-c` med `grep` för att räkna rader.

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
      has_code("grep", incorrect_msg = "Anropade du `grep`?"),
      has_code("-c", incorrect_msg = "Fick du antal med `-c`?"),
      has_code("incisor", incorrect_msg = "Sökte du efter `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Sökte du i filen `seasonal/autumn.csv`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Sökte du i filen `seasonal/winter.csv`?")
    )
  )
)
```

---

## Varför är det inte alltid säkert att behandla data som text?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

Avsnittet `SEE ALSO` på manualsidan för `cut` hänvisar till ett kommando som heter `paste`,
som kan användas för att kombinera datafiler i stället för att dela upp dem.

<hr>

Läs manualsidan för `paste`,
och kör sedan `paste` för att kombinera höst- och vinterfilerna i en enda tabell
med kommatecken som avgränsare.
Vad är problemet med utdata ur ett dataanalytiskt perspektiv?

`@possible_answers`
- Kolumnrubrikerna upprepas.
- De sista raderna har fel antal kolumner.
- En del data från `winter.csv` saknas.

`@hint`
Om du kör `cut` på utdata från `paste` med kommatecken som avgränsare,
får du då rätt svar?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Sant, men det är inte nödvändigtvis ett fel.'
correct2 = 'Rätt: att sammanfoga raderna med kolumner skapar bara en tom kolumn i början, inte två.'
err3 = 'Nej, alla vinterdata finns där.'
Ex().has_chosen(2, [err1, correct2, err3])
```

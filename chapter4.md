---
title: Batchbearbetning
description: >-
  De flesta skalkommandon kan bearbeta många filer på en gång. Det här kapitlet
  visar hur du får dina egna pipelines att göra detsamma. På vägen ser du hur
  skalet använder variabler för att lagra information.
lessons:
  - nb_of_exercises: 10
    title: Hur lagrar skalet information?
---

## Hur lagrar skalet information?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Precis som andra program lagrar skalet information i variabler.
En del av dessa kallas **miljövariabler**
och är alltid tillgängliga.
Miljövariablers namn skrivs enligt konvention med stora bokstäver,
och några av de vanligast förekommande visas nedan.

| Variabel | Syfte                                      | Värde                  |
|----------|--------------------------------------------|------------------------|
| `HOME`   | Användarens hemkatalog                     | `/home/repl`           |
| `PWD `   | Aktuell arbetskatalog                      | Samma som `pwd`-kommandot |
| `SHELL`  | Vilket skalprogram som används             | `/bin/bash`            |
| `USER`   | Användarens ID                             | `repl`                 |

För att se en fullständig lista (som är ganska lång)
kan du skriva `set` i skalet.

<hr>

Använd `set` och `grep` med ett rör för att visa värdet på `HISTFILESIZE`,
som styr hur många gamla kommandon som sparas i din kommandohistorik.
Vad är dess värde?

`@possible_answers`
- 10
- 500
- [2000]
- Variabeln finns inte.

`@hint`
Använd `set | grep HISTFILESIZE` för att hitta den rad du behöver.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nej: skalet registrerar mer historik än så."
err2 = "Nej: skalet registrerar mer historik än så."
correct3 = "Rätt: skalet sparar 2000 gamla kommandon som standard på det här systemet."
err4 = "Nej: variabeln `HISTFILESIZE` finns där."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Hur skriver man ut en variabels värde?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Ett enklare sätt att ta reda på en variabels värde är att använda kommandot `echo`, som skriver ut sina argument. Om du skriver

```{shell}
echo hello DataCamp!
```

skrivs

```
hello DataCamp!
```

ut. Om du försöker använda det för att skriva ut en variabels värde så här:

```{shell}
echo USER
```

skrivs variabelns namn ut, alltså `USER`.

För att få ut variabelns värde måste du sätta ett dollartecken `$` framför det. Om du skriver

```{shell}
echo $USER
```

skrivs

```
repl
```

ut. Detta gäller överallt:
för att hämta värdet av en variabel som heter `X`
måste du skriva `$X`.
(På så sätt kan skalet avgöra om du menar "en fil med namnet X"
eller "värdet av en variabel med namnet X".)

`@instructions`
Variabeln `OSTYPE` innehåller namnet på den typ av operativsystem du använder.
Visa dess värde med hjälp av `echo`.

`@hint`
Anropa `echo` med variabeln `OSTYPE` föregången av `$`.

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
            has_code('echo', incorrect_msg="Anropade du `echo`?"),
            has_code('OSTYPE', incorrect_msg="Skrev du ut miljövariabeln `OSTYPE`?"),
            has_code(r'\$OSTYPE', incorrect_msg="Se till att inleda `OSTYPE` med ett `$`.")
        )
    )
)
Ex().success_msg("Utmärkt användning av miljövariabler med echo! Det är en bra start. Låt oss fortsätta!")
```

---

## Hur lagrar skalet information på andra sätt?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Den andra typen av variabel kallas **skalvariabel** och fungerar ungefär som en lokal variabel i ett programmeringsspråk.

För att skapa en skalvariabel tilldelar du ett värde till ett namn:

```{shell}
training=seasonal/summer.csv
```

*utan* några mellanslag före eller efter `=`-tecknet.
När du har gjort det kan du kontrollera variabelns värde med:

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
Definiera en variabel som heter `testing` med värdet `seasonal/winter.csv`.

`@hint`
Det ska *inte* finnas mellanslag mellan variabelns namn och dess värde.

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
        has_code('testing', incorrect_msg='Definierade du en skalvariabel med namnet `testing`?'),
        has_code('testing=', incorrect_msg='Skrev du `=` direkt efter testing, utan mellanslag?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Ställde du in värdet av `testing` till `seasonal/winter.csv`?')
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
Använd `head -n 1 SOMETHING` för att hämta den första raden från `seasonal/winter.csv`
genom att använda variabeln `testing` i stället för filnamnet.

`@hint`
Kom ihåg att använda `$testing` i stället för bara `testing`
(`$` behövs för att hämta variabelns värde).

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
    has_code(r'\$testing', incorrect_msg="Refererade du till skalvariabeln med `$testing`?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Anropade du `head`?"),
            has_code('-n', incorrect_msg="Begränsade du antalet rader med `-n`?"),
            has_code(r'-n\s+1', incorrect_msg="Valde du att behålla 1 rad med `-n 1`?")     
        )
    )
)
Ex().success_msg("Utmärkt! Låt oss se hur du enkelt kan upprepa kommandon.")
```

---

## Hur kan jag upprepa ett kommando många gånger?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Skalvariabler används även i **loopar**,
som upprepar kommandon många gånger.
Om vi kör det här kommandot:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

ger det:

```
gif
jpg
png
```

Observera följande om loopen:

1. Strukturen är `for` ...variabel... `in` ...lista... `; do` ...kropp... `; done`
2. Listan med element som loopen ska bearbeta (i det här fallet orden `gif`, `jpg` och `png`).
3. Variabeln som håller reda på vilket element loopen bearbetar just nu (i det här fallet `filetype`).
4. Loopens kropp som utför bearbetningen (i det här fallet `echo $filetype`).

Observera att kroppen använder `$filetype` för att hämta variabelns värde, inte bara `filetype` –
precis som med andra skalvariabler.
Observera också var semikolonen placeras:
det första kommer mellan listan och nyckelordet `do`,
och det andra kommer mellan kroppen och nyckelordet `done`.

`@instructions`
Ändra loopen så att den skriver ut:

```
docx
odt
pdf
```

Använd `filetype` som namn på loopvariabeln.

`@hint`
Använd kodstrukturen från introduktionstexten och byt ut bildfilstyperna mot dokumentfilstyper.

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
      has_code('for', incorrect_msg='Använde du `for`?'),
      has_code('filetype', incorrect_msg='Använde du `filetype` som loopvariabel?'),
      has_code('in', incorrect_msg='Använde du `in` före listan med filtyper?'),
      has_code('docx odt pdf', incorrect_msg='Loopade du över `docx`, `odt` och `pdf` i den ordningen?'),
      has_code(r'pdf\s*;', incorrect_msg='Satte du ett semikolon efter det sista loop-elementet?'),
      has_code(r';\s*do', incorrect_msg='Använde du `do` efter det första semikolonet?'),
      has_code('echo', incorrect_msg='Använde du `echo`?'),
      has_code(r'\$filetype', incorrect_msg='Ekade du `$filetype`?'),
      has_code(r'filetype\s*;', incorrect_msg='Satte du ett semikolon efter loop-kroppen?'),
      has_code('; done', incorrect_msg='Avslutade du med `done`?')
    )
  )
)
Ex().success_msg("Förstklassig for-loop! Loopar är utmärkta om du vill göra samma sak hundratals eller tusentals gånger.")
```

---

## Hur upprepar man ett kommando för varje fil?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Du kan alltid skriva in namnen på de filer du vill bearbeta när du skriver en slinga,
men det är oftast bättre att använda jokertecken.
Testa att köra den här slingan i konsolen:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Den skriver ut:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

eftersom skalet expanderar `seasonal/*.csv` till en lista med fyra filnamn
innan slingan körs.

`@instructions`
Ändra jokerteckensuttrycket till `people/*`
så att slingan skriver ut namnen på filerna i katalogen `people`,
oavsett om de har en filändelse eller inte.
Använd `filename` som namn på din slingvariabel.

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
      has_code('for', incorrect_msg='Använde du `for`?'),
      has_code('filename', incorrect_msg='Använde du `filename` som loopvariabel?'),
      has_code('in', incorrect_msg='Använde du `in` före listan med filtyper?'),
      has_code('people/\*', incorrect_msg='Angav du en lista med filer med `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='Satte du ett semikolon efter listan med filer?'),
      has_code(r';\s*do', incorrect_msg='Använde du `do` efter det första semikolonet?'),
      has_code('echo', incorrect_msg='Använde du `echo`?'),
      has_code(r'\$filename', incorrect_msg='Använde du echo med `$filename`?'),
      has_code(r'filename\s*;', incorrect_msg='Satte du ett semikolon efter loopens innehåll?'),
      has_code('; done', incorrect_msg='Avslutade du med `done`?')
    )
  )
)
Ex().success_msg("Loopar på loopar! Jokertecken och loopar är en kraftfull kombination.")
```

---

## Hur sparar man namnen på en uppsättning filer?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Det är vanligt att tilldela en variabel ett värde med hjälp av ett jokerteckenuttryck för att spara en lista med filnamn.
Till exempel,
om du definierar `datasets` så här:

```{shell}
datasets=seasonal/*.csv
```

kan du visa filnamnen senare med:

```{shell}
for filename in $datasets; do echo $filename; done
```

Detta minskar mängden skrivning och gör det mindre troligt att fel uppstår.

<hr>

Om du kör dessa två kommandon i din hemkatalog,
hur många rader utdata skrivs ut?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Inga: eftersom `files` definieras på en separat rad har den inget värde på den andra raden.
- En: ordet "files".
- Fyra: namnen på alla fyra säsongsdatafiler.

`@hint`
Kom ihåg att `X` på egen hand bara är "X", medan `$X` är värdet på variabeln `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nej: du behöver inte definiera en variabel på samma rad som du använder den."
err2 = "Nej: det här exemplet definierar och använder variabeln `files` i samma skal."
correct3 = "Rätt. Kommandot är ekvivalent med `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## En variabels namn kontra dess värde

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Ett vanligt misstag är att glömma att använda `$` framför variabelnamnet.
När det händer använder skalet det namn du har skrivit
i stället för variabelns värde.

Ett annat vanligt misstag, särskilt för mer erfarna användare, är att stava variabelnamnet fel.
Om du till exempel definierar `datasets` så här:

```{shell}
datasets=seasonal/*.csv
```

och sedan skriver:

```{shell}
echo $datsets
```

skriver skalet ingenting ut,
eftersom `datsets` (utan det andra "a") inte är definierat.

<hr>

Om du kör dessa två kommandon i din hemkatalog,
vad skulle skrivas ut?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Läs den första delen av loopen noga innan du svarar.)

`@hint`
Kom ihåg att `X` på egen hand är bara "X", medan `$X` är värdet på variabeln `X`.

`@possible_answers`
- [En rad: ordet "files".]
- Fyra rader: namnen på alla fyra säsongsdatafilerna.
- Fyra tomma rader: variabeln `f` tilldelas inget värde.

`@feedback`
- Rätt: loopen använder `files` i stället för `$files`, så listan består av ordet "files".
- Nej: loopen använder `files` i stället för `$files`, så listan består av ordet "files" snarare än expansionen av `files`.
- Nej: variabeln `f` definieras automatiskt av `for`-loopen.

---

## Hur kör jag många kommandon i en enda loop?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Att skriva ut filnamn är användbart vid felsökning,
men det egentliga syftet med loopar är att utföra operationer på flera filer.
Den här loopen skriver ut den andra raden i varje datafil:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Den har samma struktur som de andra loopar du redan sett:
enda skillnaden är att loopens kropp är en pipeline med två kommandon i stället för ett enda kommando.

`@instructions`
Skriv en loop som skriver ut den sista posten från juli 2017 (`2017-07`) i varje säsongsfil. Den ska ge ett liknande utdata som:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

men för **_varje_** säsongsfil separat. Använd `file` som namn på loopvariabeln och kom ihåg att loopa igenom fillistan `seasonal/*.csv` (_i stället för 'seasonal/winter.csv' som i exemplet_).

`@hint`
Loopens kropp är grep-kommandot som visas i instruktionerna, med `seasonal/winter.csv` ersatt av `$file`.

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
  has_code('for', incorrect_msg='Använde ni `for`?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Använde ni `file` som loopvariabel?'),
      has_code('in', incorrect_msg='Använde ni `in` före fillistan?'),
      has_code('seasonal/\*', incorrect_msg='Angav ni en fillista med `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Satte ni ett semikolon efter fillistan?'),
      has_code(r';\s*do', incorrect_msg='Använde ni `do` efter det första semikolonet?'),
      has_code('grep', incorrect_msg='Anropade ni `grep`?'),
      has_code('2017-07', incorrect_msg='Matchade ni på `2017-07`?'),
      has_code(r'\$file', incorrect_msg='Använde ni `$file` som namn på loopvariabeln?'),
      has_code(r'file\s*|', incorrect_msg='Använde ni ett rör för att koppla ihop ert andra kommando?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Använde ni `tail -n 1` för att skriva ut den sista posten i varje sökning i ert andra kommando?'),
      has_code('; done', incorrect_msg='Avslutade ni med `done`?')
    )
  )
)

Ex().success_msg("Utmärkt loopning! Jokertecken och loopar är en kraftfull kombination.")
```

---

## Varför ska jag inte använda mellanslag i filnamn?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Det känns naturligt att ge filer namn med flera ord, som `July 2017.csv`,
när du använder en grafisk filutforskare.
Det skapar däremot problem när du arbetar i skalet.
Antag till exempel att du vill byta namn på `July 2017.csv` till `2017 July data.csv`.
Du kan inte skriva:

```{shell}
mv July 2017.csv 2017 July data.csv
```

eftersom skalet tolkar det som att du försöker flytta
fyra filer som heter `July`, `2017.csv`, `2017` och `July` (igen)
till en katalog som heter `data.csv`.
I stället måste du sätta citattecken runt filnamnen
så att skalet behandlar vart och ett som en enskild parameter:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Om du har två filer som heter `current.csv` och `last year.csv`
(med ett mellanslag i namnet)
och du skriver:

```{shell}
rm current.csv last year.csv
```

vad händer då:

`@hint`
Vad skulle du tro att kommandot gör om någon visade det för dig och du inte visste vilka filer som fanns?

`@possible_answers`
- Skalet skriver ut ett felmeddelande eftersom `last` och `year.csv` inte finns.
- Skalet tar bort `current.csv`.
- [Båda alternativen ovan.]
- Ingenting.

`@feedback`
- Ja, men det är inte allt.
- Ja, men det är inte allt.
- Rätt. Du kan använda enkla citattecken, `'`, eller dubbla citattecken, `"`, runt filnamnen.
- Tyvärr inte.

---

## Hur gör man många saker i en enda loop?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

De loopar du har sett hittills har alla haft ett enda kommando eller en enda pipeline i sin kropp,
men en loop kan innehålla valfritt antal kommandon.
För att tala om för skalet var ett kommando slutar och nästa börjar
måste du separera dem med semikolon:

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

Anta att du glömmer semikolonet mellan kommandona `echo` och `head` i föregående loop,
så att du ber skalet köra:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Vad kommer skalet att göra?

`@possible_answers`
- Skriva ut ett felmeddelande.
- Skriva ut en rad för var och en av de fyra filerna.
- Skriva ut en rad för `autumn.csv` (den första filen).
- Skriva ut den sista raden i varje fil.

`@hint`
Du kan skicka utdata från `echo` vidare till `tail` med ett pipe.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nej: loopen kommer att köras, den kommer bara inte att göra något vettigt."
correct2 = "Ja: `echo` producerar en rad som inkluderar filnamnet två gånger, vilket `tail` sedan kopierar."
err3 = "Nej: loopen körs en gång för vart och ett av de fyra filnamnen."
err4 = "Nej: indata till `tail` är utdata från `echo` för varje filnamn."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

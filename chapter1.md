---
title: Hantera filer och kataloger
description: >-
  Det här kapitlet är en kort introduktion till Unix-skalet. Du får lära dig
  varför det fortfarande används efter nästan 50 år, hur det skiljer sig från de
  grafiska verktyg du kanske är mer van vid, hur du navigerar i skalet samt hur
  du skapar, ändrar och tar bort filer och mappar.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Hur skiljer sig skalet från ett grafiskt gränssnitt?
---

## Hur förhåller sig skalet till ett grafiskt skrivbordsgränssnitt?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Ett operativsystem som Windows, Linux eller macOS är ett speciellt slags program.
Det styr datorns processor, hårddisk och nätverksanslutning,
men dess viktigaste uppgift är att köra andra program.

Eftersom människor inte är digitala
behöver de ett gränssnitt för att interagera med operativsystemet.
Det vanligaste i dag är en grafisk filhanterare,
som översätter klick och dubbelklick till kommandon för att öppna filer och köra program.
Innan datorer hade grafiska skärmar
skrev folk däremot in instruktioner i ett program som kallas **kommandoradsskal**.
Varje gång ett kommando anges
kör skalet något annat program,
skriver ut resultatet i ett läsbart format
och visar sedan en *prompt* för att signalera att det är redo att ta emot nästa kommando.
(Namnet kommer från idén att det är datorns "yttre skal".)

Att skriva kommandon i stället för att klicka och dra kan verka omständligt till en början,
men som du kommer att se:
så snart du börjar formulera exakt vad du vill att datorn ska göra
kan du kombinera gamla kommandon för att skapa nya
och automatisera återkommande uppgifter
med bara några få tangenttryckningar.

<hr>
Vad är förhållandet mellan den grafiska filhanterare som de flesta använder och kommandoradsskalet?

`@hint`
Kom ihåg att en användare bara kan interagera med ett operativsystem via ett program.

`@possible_answers`
- Med filhanteraren kan du visa och redigera filer, medan skalet låter dig köra program.
- Filhanteraren är byggd ovanpå skalet.
- Skalet är en del av operativsystemet, medan filhanteraren är fristående.
- [De är båda gränssnitt för att skicka kommandon till operativsystemet.]

`@feedback`
- Båda låter dig visa och redigera filer samt köra program.
- Grafiska filhanterare och skalet anropar samma underliggande operativsystemsfunktioner.
- Skalet och filhanteraren är båda program som översätter användarkommandon (skrivna eller klickade) till anrop mot operativsystemet.
- Rätt! Båda tar emot användarens kommandon – oavsett om de skrivs eller klickas – och skickar dem vidare till operativsystemet.

---

## Var är jag?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**Filsystemet** hanterar filer och kataloger (eller mappar).
Varje fil och katalog identifieras av en **absolut sökväg**
som visar hur man når den från filsystemets **rotkatalog**:
`/home/repl` är katalogen `repl` i katalogen `home`,
medan `/home/repl/course.txt` är filen `course.txt` i den katalogen,
och `/` ensamt är rotkatalogen.

För att ta reda på var du befinner dig i filsystemet
kör du kommandot `pwd`
(förkortning för "**p**rint **w**orking **d**irectory", dvs. skriv ut arbetskatalogen).
Det skriver ut den absoluta sökvägen till din **aktuella arbetskatalog** –
där skalet kör kommandon och letar efter filer som standard.

<hr>
Kör `pwd`.
Var befinner du dig just nu?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
I Unix-system finns vanligtvis alla användares hemkataloger under `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Det är inte den korrekta sökvägen."
correct = "Rätt - du befinner dig i `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Hur identifierar man filer och kataloger?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` visar var du befinner dig.
För att se vad som finns där,
skriver du `ls` (kort för "**l**i**s**ting") och trycker på enter.
På egen hand
listar `ls` innehållet i din aktuella katalog
(den som visas av `pwd`).
Om du lägger till namn på filer
listar `ls` dem,
och om du lägger till namn på kataloger
visas deras innehåll.
Till exempel visar
`ls /home/repl` vad som finns i din startkatalog
(som brukar kallas din **hemkatalog**).

<hr>
Använd `ls` med ett lämpligt argument för att lista filerna i katalogen `/home/repl/seasonal`
(som innehåller information om tandbehandlingar per datum, uppdelat efter säsong).
Vilken av dessa filer finns *inte* i den katalogen?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Om du anger en sökväg till `ls` visas vad som finns i den sökvägen.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Den filen finns i katalogen `seasonal`."
correct = "Rätt – den filen finns *inte* i katalogen `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Hur kan jag identifiera filer och kataloger på andra sätt?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

En absolut sökväg fungerar som latitud och longitud: den har samma värde oavsett var du befinner dig. En **relativ sökväg** anger däremot en plats med utgångspunkt från din nuvarande position – ungefär som att säga "20 kilometer norrut".

Som exempel:
- Om du befinner dig i katalogen `/home/repl` pekar den **relativa** sökvägen `seasonal` på samma katalog som den **absoluta** sökvägen `/home/repl/seasonal`. 
- Om du befinner dig i katalogen `/home/repl/seasonal` pekar den **relativa** sökvägen `winter.csv` på samma fil som den **absoluta** sökvägen `/home/repl/seasonal/winter.csv`.

Shellen avgör om en sökväg är absolut eller relativ genom att titta på det första tecknet: Om den börjar med `/` är den absolut. Om den *inte* börjar med `/` är den relativ.

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
Du befinner dig i `/home/repl`. Använd `ls` med en **relativ sökväg** för att lista filen med den absoluta sökvägen `/home/repl/course.txt` (och endast den filen).

`@hint`
Du kan ofta konstruera den relativa sökvägen till en fil eller katalog under din nuvarande plats
genom att subtrahera den absoluta sökvägen till din nuvarande plats
från den absoluta sökvägen till det du vill nå.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Du använde inte `ls` för att generera fillistan."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Ditt kommando genererade inte rätt fillista. Använd `ls` följt av en relativ sökväg till `/home/repl/course.txt`.")
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
Du befinner dig i `/home/repl`.
Använd `ls` med en **relativ** sökväg
för att lista filen `/home/repl/seasonal/summer.csv` (och endast den filen).

`@hint`
Relativa sökvägar börjar *inte* med ett inledande '/'.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Du använde inte `ls` för att generera fillistan."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Ditt kommando genererade inte rätt fillista. Använd `ls` följt av en relativ sökväg till `/home/repl/seasonal/summer.csv`.")
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
Du befinner dig i `/home/repl`.
Använd `ls` med en **relativ** sökväg
för att lista innehållet i katalogen `/home/repl/people`.

`@hint`
Relativa sökvägar börjar inte med ett inledande '/'.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Du använde inte `ls` för att generera fillistan."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Ditt kommando genererade inte rätt fillista. Använd `ls` följt av en relativ sökväg till `/home/repl/people`.")
    )
)
Ex().success_msg("Bra gjort. Nu när du vet hur man listar filer och kataloger, låt oss se hur du kan navigera i filsystemet!")
```

---

## Hur byter jag katalog?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Precis som du navigerar i en filhanterare genom att dubbelklicka på mappar
kan du röra dig i filsystemet med kommandot `cd`
(som står för "change directory").

Om du skriver `cd seasonal` och sedan `pwd`
berättar skalet att du nu befinner dig i `/home/repl/seasonal`.
Kör du sedan `ls` utan argument
visas innehållet i `/home/repl/seasonal`,
eftersom det är där du befinner dig.
Vill du komma tillbaka till din hemkatalog `/home/repl`
använder du kommandot `cd /home/repl`.

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
Du befinner dig i `/home/repl`/.
Byt katalog till `/home/repl/seasonal` med hjälp av en relativ sökväg.

`@hint`
Kom ihåg att `cd` står för "change directory" och att relativa sökvägar inte börjar med '/'.

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
key: e69c8eac15
xp: 35
```

`@instructions`
Använd `pwd` för att kontrollera att du är på rätt plats.

`@hint`
Kom ihåg att trycka på "enter" eller "return" efter att du angett kommandot.

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
Använd `ls` utan några sökvägar för att se vad som finns i katalogen.

`@hint`
Kom ihåg att trycka på "enter" eller "return" efter kommandot.

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
      has_code('ls', incorrect_msg="Ditt kommando genererade inte rätt utdata. Har du använt `ls` utan sökvägar för att visa innehållet i den aktuella katalogen?")
    )
)

Ex().success_msg("Snyggt! Det här handlade om att navigera ned till underkataloger. Vad sägs om att flytta uppåt? Låt oss ta reda på det!")
```

---

## Hur flyttar jag uppåt i katalogstrukturen?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

**Föräldern** till en katalog är katalogen ovanför den.
Till exempel är `/home` förälder till `/home/repl`,
och `/home/repl` är förälder till `/home/repl/seasonal`.
Du kan alltid ange den absoluta sökvägen till din förälderkatalog i kommandon som `cd` och `ls`.
Vanligare är dock att du utnyttjar det faktum att den speciella sökvägen `..`
(två punkter utan mellanslag) betyder "katalogen ovanför den jag befinner mig i nu".
Om du är i `/home/repl/seasonal` tar `cd ..` dig upp till `/home/repl`.
Använder du `cd ..` en gång till hamnar du i `/home`.
Ännu ett `cd ..` tar dig till *rotkatalogen* `/`,
som är längst upp i filsystemet.
(Kom ihåg att ha ett mellanslag mellan `cd` och `..` – det är ett kommando och en sökväg, inte ett enda fyrabokstavskommando.)

En ensam punkt, `.`, betyder alltid "den aktuella katalogen".
Därför gör `ls` och `ls .` samma sak,
medans `cd .` inte har någon effekt
(eftersom du flyttas till den katalog du redan befinner dig i).

En sista speciell sökväg är `~` (tildetecknet),
som betyder "din hemkatalog",
exempelvis `/home/repl`.
Oavsett var du befinner dig listar `ls ~` alltid innehållet i din hemkatalog,
och `cd ~` tar dig alltid hem.

<hr>
Om du är i `/home/repl/seasonal`,
var hamnar du med `cd ~/../.`?

`@hint`
Följ sökvägen ett katalogsteg i taget.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (rotkatalogen)

`@feedback`
- Nej, men antingen `~` eller `..` ensamt skulle ta dig dit.
- Rätt! Sökvägen betyder 'hemkatalogen', 'ett steg uppåt', 'här'.
- Nej, men `.` ensamt skulle göra det.
- Nej, den sista delen av sökvägen är `.` (som betyder "här") snarare än `..` (som betyder "uppåt").

---

## Hur kopierar man filer?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Det är vanligt att man vill kopiera filer,
flytta dem till andra kataloger för att organisera dem,
eller byta namn på dem.
Ett kommando för detta är `cp`, som är en förkortning av "copy".
Om `original.txt` är en befintlig fil,
så skapar:

```{shell}
cp original.txt duplicate.txt
```

en kopia av `original.txt` med namnet `duplicate.txt`.
Om det redan finns en fil som heter `duplicate.txt`,
skrivs den över.
Om den sista parametern till `cp` är en befintlig katalog,
kommer ett kommando som:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

att kopiera *alla* angivna filer till den katalogen.

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
Skapa en kopia av `seasonal/summer.csv` i katalogen `backup` (som också finns i `/home/repl`),
och ge den nya filen namnet `summer.bck`.

`@hint`
Kombinera namnet på målkatalogen och namnet på den kopierade filen
för att skapa en relativ sökväg till den nya filen.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` verkar inte finnas i katalogen `backup`. Ange två sökvägar till `cp`: den befintliga filen (`seasonal/summer.csv`) och målfilen (`backup/summer.bck`)."),
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
Kopiera `spring.csv` och `summer.csv` från katalogen `seasonal` till katalogen `backup`
*utan* att ändra din nuvarande arbetskatalog (`/home/repl`).

`@hint`
Använd `cp` med namnen på de filer du vill kopiera
och *sedan* namnet på katalogen du vill kopiera dem till.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` verkar inte ha kopierats till katalogen `backup`. Ange två filnamn och ett katalognamn till `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Se till att kopiera filerna medan du befinner dig i `{{dir}}`! Använd `cd {{dir}}` för att navigera tillbaka dit."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Bra jobbat. Förutom att kopiera bör vi även kunna flytta filer från en katalog till en annan. Lär dig mer om det i nästa övning!")
```

---

## Hur flyttar man en fil?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Medan `cp` kopierar en fil
flyttar `mv` den från en katalog till en annan,
precis som om du hade dragit den i en grafisk filhanterare.
Kommandot tar samma parametrar som `cp`,
så kommandot:

```{shell}
mv autumn.csv winter.csv ..
```

flyttar filerna `autumn.csv` och `winter.csv` från den aktuella arbetskatalogen
ett steg upp till dess överordnade katalog
(eftersom `..` alltid refererar till katalogen ovanför din nuvarande plats).

`@instructions`
Du befinner dig i `/home/repl`, som har underkatalogerna `seasonal` och `backup`.
Använd ett enda kommando för att flytta `spring.csv` och `summer.csv` från `seasonal` till `backup`.

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
backup_patt="Filen `%s` finns inte i katalogen `backup`. Har du använt `mv` korrekt? Använd två filnamn och en katalog som parametrar till `mv`."
seasonal_patt="Filen `%s` finns fortfarande i katalogen `seasonal`. Se till att flytta filerna med `mv` i stället för att kopiera dem med `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Bra jobbat, låt oss hålla det här skaltåget igång!")
```

---

## Hur byter man namn på filer?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` kan också användas för att byta namn på filer. Om du kör:

```{shell}
mv course.txt old-course.txt
```

flyttes filen `course.txt` i den aktuella arbetskatalogen till filen `old-course.txt`.
Detta skiljer sig från hur filhanterare fungerar,
men är ofta praktiskt.

En varning:
precis som `cp`
skriver `mv` över befintliga filer.
Om du till exempel redan har en fil som heter `old-course.txt`
kommer kommandot ovan att ersätta den med innehållet i `course.txt`.

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
Navigera till katalogen `seasonal`.

`@hint`
Kom ihåg att `cd` står för "change directory" och att relativa sökvägar inte börjar med ett inledande '/'.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
Byt namn på filen `winter.csv` till `winter.csv.bck`.

`@hint`
Använd `mv` med filens nuvarande namn följt av det namn du vill ge den, i den ordningen.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Använd `mv` med två argument: filen du vill byta namn på (`winter.csv`) och det nya namnet för filen (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Vi förväntade oss att hitta `winter.csv.bck` i katalogen." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Vi förväntade oss inte längre att `winter.csv` skulle finnas i katalogen." + hint)
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
Kör `ls` för att kontrollera att allt har fungerat.

`@hint`
Kom ihåg att trycka på "enter" eller "return" för att köra kommandot.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Har du använt `ls` för att lista innehållet i din aktuella arbetskatalog?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Ditt kommando genererade inte korrekt fillista. Använd `ls` utan argument för att lista innehållet i din aktuella arbetskatalog.")
    )
)
Ex().success_msg("Kopiering, flyttning, namnbyte – du har koll på allt! Nästa steg: att ta bort filer.")
```

---

## Hur tar man bort filer?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Vi kan kopiera filer och flytta dem;
för att ta bort dem använder vi `rm`,
som står för "remove".
Precis som med `cp` och `mv`
kan du ange hur många filnamn som helst, till exempel:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

Detta tar bort både `thesis.txt` och `backup/thesis-2017-08.txt`.

`rm` gör precis det namnet antyder,
och det sker omedelbart:
olikt grafiska filhanterare
har skalet inget papperskorg,
så när du skriver kommandot ovan
är filen borta för gott.

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
Du befinner dig i `/home/repl`.
Gå in i katalogen `seasonal`.

`@hint`
Kom ihåg att `cd` står för "change directory" och att en relativ sökväg inte börjar med '/'.

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
Ta bort `autumn.csv`.

`@hint`
Kom ihåg att `rm` står för "remove".

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Vi förväntade oss inte att `autumn.csv` fortfarande skulle finnas i katalogen `seasonal`. Använd `rm` med sökvägen till filen du vill ta bort."),
    has_code('rm', incorrect_msg = 'Använd `rm` för att ta bort filen, snarare än att flytta den.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Gå tillbaka till din hemkatalog.

`@hint`
Om du kör `cd` utan några argument kommer du tillbaka till din hemkatalog.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Använd `cd ..` eller `cd ~` för att återgå till hemkatalogen.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Ta bort `seasonal/summer.csv` utan att byta katalog igen.

`@hint`
Kom ihåg att `rm` står för "remove".

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Vi förväntade oss inte att `summer.csv` fortfarande skulle finnas i katalogen `seasonal`. Använd `rm` med sökvägen till filen du vill ta bort."),
    has_code('rm', incorrect_msg = 'Använd `rm` för att ta bort filen, istället för att flytta den.')
)
Ex().success_msg("Imponerande! Vidare till nästa!")
```

---

## Hur skapar och tar man bort kataloger?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` hanterar kataloger på samma sätt som filer:
om du befinner dig i din hemkatalog och kör `mv seasonal by-season`
ändrar `mv` till exempel namnet på katalogen `seasonal` till `by-season`.
Däremot fungerar `rm` annorlunda.

Om du försöker ta bort en katalog med `rm`
skriver skalet ut ett felmeddelande om att det inte går,
främst för att hindra dig från att råka ta bort en hel katalog med arbete.
Istället kan du använda ett separat kommando som heter `rmdir`.
Av säkerhetsskäl fungerar det bara när katalogen är tom,
så du måste ta bort filerna i en katalog *innan* du tar bort katalogen själv.
(Erfarna användare kan använda flaggan `-r` till `rm` för att uppnå samma sak;
vi tar upp kommandoflaggor i nästa kapitel.)

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
Ta bort filen `agarwal.txt` i katalogen `people` utan att byta katalog.

`@hint`
Kom ihåg att `rm` står för "remove" och att en relativ sökväg inte börjar med '/'.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` ska inte längre finnas i `/home/repl/people`. Har du använt `rm` på rätt sätt?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'Det finns fortfarande filer i katalogen `people`. Om du bara flyttade `agarwal.txt`, eller skapade nya filer, ta bort dem alla.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Nu när katalogen `people` är tom
använder du ett enda kommando för att ta bort den.

`@hint`
Kom ihåg att `rm` bara fungerar på filer.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "Katalogen 'people' ska inte längre finnas i din hemkatalog. Använd `rmdir` för att ta bort den!")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Eftersom en katalog inte är en fil
måste du använda kommandot `mkdir directory_name`
för att skapa en ny (tom) katalog.
Använd det här kommandot för att skapa en ny katalog med namnet `yearly` under din hemkatalog.

`@hint`
Kör `mkdir` med namnet på den katalog du vill skapa.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Det finns ingen `yearly`-katalog i din hemkatalog. Använd `mkdir yearly` för att skapa en!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Nu när `yearly` finns
skapar du en katalog till med namnet `2017` inuti den
*utan* att lämna din hemkatalog.

`@hint`
Använd en relativ sökväg för den underkatalog du vill skapa.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Det går inte att hitta en '2017'-katalog i '/home/repl/yearly'. Du kan skapa den här katalogen med den relativa sökvägen `yearly/2017`.")
)
Ex().success_msg("Bra! Låt oss avsluta det här kapitlet med en övning som upprepar några av dess koncept!")
```

---

## Sammanfattning

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

När du analyserar data skapar du ofta mellanliggande filer.
Istället för att lagra dem i din hemkatalog
kan du placera dem i `/tmp`,
där både användare och program brukar spara filer som bara behövs en kort stund.
(Observera att `/tmp` ligger direkt under rotkatalogen `/`,
*inte* under din hemkatalog.)
Den här avslutande övningen visar dig hur det går till.

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
Använd `cd` för att navigera till `/tmp`.

`@hint`
Kom ihåg att `cd` står för "change directory" och att en absolut sökväg börjar med '/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Du befinner dig i fel katalog. Använd `cd` för att byta katalog till `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Lista innehållet i `/tmp` *utan* att ange något katalognamn.

`@hint`
Om du inte anger något argument till `ls` visas innehållet i din aktuella katalog.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Du anropade inte `ls` för att generera fillistan."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Ditt kommando genererade inte rätt fillista. Använd `ls` utan`.")
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
Skapa en ny katalog inuti `/tmp` som heter `scratch`.

`@hint`
Använd `mkdir` för att skapa kataloger.

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
      has_code('mkdir +scratch', incorrect_msg="Det går inte att hitta en 'scratch'-katalog under '/tmp'. Se till att använda `mkdir` korrekt.")
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
Flytta `/home/repl/people/agarwal.txt` till `/tmp/scratch`.
Vi rekommenderar att du använder genvägen `~` för din hemkatalog och en relativ sökväg för det andra argumentet i stället för en absolut sökväg.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Det går inte att hitta 'agarwal.txt' i '/tmp/scratch'. Använd `mv` med `~/people/agarwal.txt` som den första parametern och `scratch` som den andra.")
)
Ex().success_msg("Detta avslutar Kapitel 1 av Introduktion till Shell! Skynda dig till nästa kapitel för att lära dig mer om att manipulera data!")
```

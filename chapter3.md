---
title: Kombinera verktyg
description: >-
  Unix-skalets verkliga styrka ligger inte i de enskilda kommandona, utan i hur
  enkelt de kan kombineras för att göra nya saker. Det här kapitlet visar hur du
  utnyttjar den kraften för att välja ut den data du vill ha, och introducerar
  kommandon för att sortera värden och ta bort dubbletter.
lessons:
  - nb_of_exercises: 12
    title: Hur sparar jag ett kommandos utdata till en fil?
---

## Hur sparar jag utdata från ett kommando i en fil?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Alla verktyg du har sett hittills låter dig ange indatafiler.
De flesta saknar ett alternativ för att ange en utdatafil, eftersom det inte behövs.
Istället kan du använda **omdirigering** för att spara utdata från vilket kommando som helst, var du vill.
Om du kör det här kommandot:

```{shell}
head -n 5 seasonal/summer.csv
```

skrivs de första 5 raderna av sommardata ut på skärmen.
Om du istället kör det här kommandot:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

visas ingenting på skärmen.
Istället sparas utdata från `head` i en ny fil som heter `top.csv`.
Du kan titta på filens innehåll med `cat`:

```{shell}
cat top.csv
```

Tecknet `>` instruerar skalet att omdirigera utdata från `head` till en fil.
Det är inte en del av kommandot `head` – det fungerar med alla skalkommandon som producerar utdata.

`@instructions`
Kombinera `tail` med omdirigering för att spara de sista 5 raderna av `seasonal/winter.csv` i en fil som heter `last.csv`.

`@hint`
Använd `tail -n 5` för att hämta de sista 5 raderna.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "Raden `%s` borde finnas i filen `last.csv`, men det gör den inte. Omdirigera utdata från `tail -n 5 seasonal/winter.csv` till `last.csv` med `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` har för många rader. Använde du flaggan `-n 5` med `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Bra! Låt oss öva lite mer!")
```

---

## Hur kan jag använda ett kommandos utdata som indata?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Anta att du vill hämta rader från mitten av en fil.
Mer specifikt, anta att du vill hämta raderna 3–5 från en av våra datafiler.
Du kan börja med att använda `head` för att hämta de första 5 raderna
och omdirigera dem till en fil,
och sedan använda `tail` för att välja de sista 3:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

En snabb kontroll bekräftar att detta är raderna 3–5 i originalfilen,
eftersom det är de sista 3 raderna av de första 5.

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
Välj de två sista raderna från `seasonal/winter.csv`
och spara dem i en fil som heter `bottom.csv`.

`@hint`
Använd `tail` för att välja rader och `>` för att omdirigera utdata från `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="Raden `%s` bör finnas i filen `bottom.csv`, men det gör den inte. Omdirigera utdata från `tail -n 2 seasonal/winter.csv` till `bottom.csv` med `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` innehåller för många rader. Använde du flaggan `-n 2` med `tail`?'),
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
Välj den första raden från `bottom.csv`
för att hämta den näst sista raden i originalfilen.

`@hint`
Använd `head` för att välja den rad du vill ha.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Det är något fel med filen `bottom.csv`. Se till att du inte ändrar den!"),
    has_expr_output(strict=True, incorrect_msg="Har du använt `head` korrekt på `bottom.csv`? Se till att använda flaggan `-n` på rätt sätt.")
)

Ex().success_msg("Bra gjort. Gå vidare till nästa övning för att lära dig om bättre sätt att kombinera kommandon.")
```

---

## Finns det ett bättre sätt att kombinera kommandon?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Att använda omdirigering för att kombinera kommandon har två nackdelar:

1. Det lämnar kvar många mellanliggande filer (som `top.csv`).
2. Kommandona som producerar slutresultatet är utspridda över flera rader i historiken.

Shellen erbjuder ett annat verktyg som löser båda dessa problem på en gång – ett så kallat **pipe**.
Börja igen med att köra `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

Istället för att skicka utdata från `head` till en fil,
lägg till ett lodrätt streck och kommandot `tail` *utan* ett filnamn:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Pipe-symbolen talar om för shellen att använda utdata från kommandot till vänster som indata till kommandot till höger.

`@instructions`
Använd `cut` för att välja ut alla tandnamn från kolumn 2 i den kommaavgränsade filen `seasonal/summer.csv`, och skicka sedan resultatet via pipe till `grep` med inverterad matchning för att utesluta rubrikraden som innehåller ordet "Tooth". *`cut` och `grep` behandlades i detalj i kapitel 2, övning 8 respektive 11.*

`@hint`
- Den första delen av kommandot har formen `cut -d field_delimiter -f column_number filename`.
- Den andra delen av kommandot har formen `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'Har du skickat resultatet av `cut -d , -f 2 seasonal/summer.csv` till `grep -v Tooth` med `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Uteslöt du rubrikraden `"Tooth"` med `grep`?')
)
Ex().success_msg("Perfekt piping! Det här kanske är första gången du använde `|`, men det kommer definitivt inte att vara den sista!")
```

---

## Hur kombinerar man många kommandon?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Du kan kedja ihop hur många kommandon som helst.
Till exempel gör det här kommandot följande:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

1. väljer den första kolumnen från vårdata;
2. tar bort rubrikraden som innehåller ordet "Date"; och
3. väljer de första 10 raderna med faktiska data.

`@instructions`
I föregående övning använde du följande kommando för att välja alla tandnamn från kolumn 2 i `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Bygg ut den här pipeline-kedjan med ett `head`-kommando så att bara det allra första tandnamnet väljs.

`@hint`
Kopiera och klistra in koden från instruktionerna, lägg till ett pipe-tecken och anropa sedan `head` med flaggan `-n`.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Har du använt `|` för att utöka pipelinen med ett `head`-kommando? Se till att ange flaggan `-n` korrekt."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Har du använt `|` för att utöka pipelinen med ett `head`-kommando?")
)
Ex().success_msg("Glädjande kedjebyggande! Genom att kedja ihop flera kommandon kan du bygga kraftfulla datamanipuleringspipelines.")
```

---

## Hur räknar jag poster i en fil?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Kommandot `wc` (förkortning för "word count") skriver ut antalet **t**ecken, **o**rd och **r**ader i en fil.
Du kan begränsa utdata till enbart ett av dessa värden med flaggorna `-c`, `-w` respektive `-l`.

`@instructions`
Räkna hur många poster i `seasonal/spring.csv` som har datum i juli 2017 (`2017-07`). 
- Använd `grep` med ett partiellt datum för att välja ut raderna och skicka resultatet vidare till `wc` med lämplig flagga för att räkna raderna.

`@hint`
- Använd `head seasonal/spring.csv` för att påminna dig om datumformatet.
- Den första delen av kommandot har formen `grep thing_to_match filename`.
- Efter pipe-tecknet, `|`, anropar du `wc` med flaggan `-l`.

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
      has_code("grep", incorrect_msg = "Anropade du `grep`?"),
      has_code("2017-07", incorrect_msg = "Sökte du efter `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Sökte du i filen `seasonal/spring.csv`?"),
      has_code("|", incorrect_msg = "Skickade du vidare till `wc` med hjälp av `|`?"),      
      has_code("wc", incorrect_msg = "Anropade du `wc`?"),
      has_code("-l", incorrect_msg = "Räknade du rader med `-l`?")
    )
  )
)
Ex().success_msg("Noggrant räknande! Att fastställa hur mycket data du har är ett utmärkt första steg i all dataanalys.")
```

---

## Hur anger jag flera filer på en gång?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

De flesta shell-kommandon fungerar på flera filer om du anger flera filnamn.
Du kan till exempel hämta den första kolumnen från alla säsongsbaserade datafiler på en gång:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Men att skriva ut namnen på många filer om och om igen är opraktiskt:
det tar tid, och förr eller senare missar du en fil eller råkar upprepa ett filnamn.
Därför kan du använda **jokertecken** i shellet för att ange en lista med filer via ett enda uttryck.
Det vanligaste jokertecknet är `*`, som betyder "matcha noll eller flera tecken".
Med det kan vi förkorta `cut`-kommandot ovan till:

```{shell}
cut -d , -f 1 seasonal/*
```

eller:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Skriv ett enda kommando med `head` för att hämta de tre första raderna från både `seasonal/spring.csv` och `seasonal/summer.csv` – totalt sex rader data – men *inte* från höst- eller vinterfilerna.
Använd ett jokertecken i stället för att skriva ut filnamnen i sin helhet.

`@hint`
- Kommandot har formen `head -n number_of_lines filename_pattern`.
- Du kan till exempel matcha filer i katalogen `a` som börjar med `b` med hjälp av `a/b*`.

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
    has_expr_output(incorrect_msg = "Du kan använda `seasonal/s*` för att välja `seasonal/spring.csv` och `seasonal/summer.csv`. Se till att endast inkludera de tre första raderna i varje fil med flaggan `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Inkludera inte utdata för `seasonal/autumn.csv`. Du kan använda `seasonal/s*` för att välja `seasonal/spring.csv` och `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Inkludera inte utdata för `seasonal/winter.csv`. Du kan använda `seasonal/s*` för att välja `seasonal/spring.csv` och `seasonal/summer.csv`")
)
Ex().success_msg("Utmärkt användning av jokertecken! Detta blir ännu viktigare om din katalog innehåller hundratals eller tusentals filer.")
```

---

## Vilka andra jokertecken kan jag använda?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Skalet har även andra jokertecken,
om än de används mer sällan:

- `?` matchar ett enskilt tecken, så `201?.txt` matchar `2017.txt` eller `2018.txt`, men inte `2017-01.txt`.
- `[...]` matchar vilket som helst av tecknen inom hakparenteserna, så `201[78].txt` matchar `2017.txt` eller `2018.txt`, men inte `2016.txt`.
- `{...}` matchar något av de kommaseparerade mönstren inom klammerparenteserna, så `{*.txt, *.csv}` matchar alla filer vars namn slutar på `.txt` eller `.csv`, men inte filer vars namn slutar på `.pdf`.

<hr/>

Vilket uttryck matchar `singh.pdf` och `johel.txt` men *inte* `sandhu.pdf` eller `sandhu.txt`?

`@hint`
Testa varje uttryck mot varje filnamn i tur och ordning.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Nej: `.pdf` och `.txt` är inte filnamn.
- Nej: det här matchar `sandhu.pdf`.
- Nej: uttrycket inom hakparenteser matchar bara ett enda tecken, inte hela ord.
- Rätt!

---

## Hur sorterar jag textrader?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Som namnet antyder sorterar `sort` data i en bestämd ordning.
Som standard sorteras data i stigande alfabetisk ordning,
men flaggorna `-n` och `-r` kan användas för att sortera numeriskt respektive i omvänd ordning.
Flaggan `-b` ignorerar inledande blanksteg
och `-f` gör sökningen skiftlägesokänslig ("**f**old case").
I pipelines används ofta `grep` för att filtrera bort oönskade rader
och sedan `sort` för att ordna de återstående raderna.

`@instructions`
Minns du kombinationen av `cut` och `grep` för att välja ut alla tandnamn från kolumn 2 i `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Utifrån det här kommandot, sortera tandnamnen i `seasonal/winter.csv` (inte `summer.csv`) i fallande alfabetisk ordning. Bygg ut pipelinen med ett `sort`-steg för att göra det.

`@hint`
Kopiera och klistra in kommandot i instruktionerna, ändra filnamnet, lägg till ett pipe-tecken och anropa sedan `sort` med flaggan `-r`.

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
      has_code("cut", incorrect_msg = "Anropade du `cut`?"),
      has_code("-d", incorrect_msg = "Angav du en fältavgränsare med `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Hämtade du data från filen `seasonal/winter.csv`?"),
      has_code("|", incorrect_msg = "Skickade du utdata från `cut` till `grep` till `sort` med hjälp av `|`?"),      
      has_code("grep", incorrect_msg = "Anropade du `grep`?"),
      has_code("-v", incorrect_msg = "Inverterade du matchningen med `-v`?"),
      has_code("Tooth", incorrect_msg = "Sökte du efter `Tooth`?"),
      has_code("sort", incorrect_msg = "Anropade du `sort`?"),
      has_code("-r", incorrect_msg = "Vände du på sorteringsordningen med `-r`?")
    )
  )
)
Ex().success_msg("Sorterat! `sort` har många användningsområden. Till exempel visar `sort -n` skickat till `head` de största värdena.")
```

---

## Hur tar jag bort dubbletter av rader?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Ett annat kommando som ofta används tillsammans med `sort` är `uniq`,
som tar bort duplicerade rader.
Närmare bestämt tar det bort *angränsande* duplicerade rader.
Om en fil innehåller:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

kommer `uniq` att producera:

```
2017-07-03
2017-08-03
```

Men om filen innehåller:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

skriver `uniq` ut alla fyra rader.
Anledningen är att `uniq` är byggt för att hantera mycket stora filer.
För att ta bort icke-angränsande dubbletter skulle kommandot behöva hålla hela filen i minnet
(eller åtminstone alla unika rader som setts hittills).
Genom att bara ta bort angränsande dubbletter behöver det bara hålla den senaste unika raden i minnet.

`@instructions`
Bygg en pipeline som:

- hämtar den andra kolumnen från `seasonal/winter.csv`,
- tar bort ordet "Tooth" från utdata så att bara tandnamn visas,
- sorterar utdata så att alla förekomster av ett visst tandnamn hamnar intill varandra, och
- visar varje tandnamn en gång tillsammans med en räkning av hur ofta det förekommer.

Början på din pipeline är densamma som i föregående övning:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Bygg ut den med ett `sort`-kommando och använd `uniq -c` för att visa unika rader med en räkning av hur ofta var och en förekommer, i stället för att kombinera `uniq` och `wc`.

`@hint`
Kopiera och klistra in kommandot från instruktionerna, skicka det vidare till `sort` utan flaggor och sedan vidare till `uniq` med flaggan `-c`.

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
                     incorrect_msg="Du bör börja med det här kommandot: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Utöka det nu!"),
            has_code('\|\s+sort', incorrect_msg="Har du utökat kommandot med `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="Har du utökat kommandot med `| uniq`?"),
            has_code('-c', incorrect_msg="Har du inkluderat antal med `-c`?")
        )
    )
)
Ex().success_msg("Bra gjort! Efter allt detta arbete med ett rör vore det trevligt om vi kunde lagra resultatet, eller hur?")
```

---

## Hur sparar jag utdata från en pipe?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Skalet låter oss omdirigera utdata från en sekvens av pipade kommandon:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Däremot måste `>` stå i slutet av pipelinen.
Om vi försöker använda det i mitten, så här:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

skrivs all utdata från `cut` till `teeth-only.txt`,
så det finns inget kvar för `grep`
och det väntar för evigt på indata.

<hr>

Vad händer om vi placerar omdirigeringen i början av en pipeline, som här:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [Kommandots utdata omdirigeras till filen som vanligt.]
- Skalet rapporterar det som ett fel.
- Skalet väntar för evigt på indata.

`@hint`
Prova det i skalet.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Korrekt!', 'Nej; skalet kan faktiskt köra detta.', 'Nej; skalet kan faktiskt köra detta.'])
```

---

## Hur stoppar jag ett program som körs?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

De kommandon och skript du har kört hittills har alla körts snabbt,
men vissa uppgifter kan ta minuter, timmar eller till och med dagar att slutföra.
Du kan också råka placera en omdirigering mitt i en pipeline,
vilket gör att den hänger sig.
Om du vill avbryta ett program som körs
kan du skriva `Ctrl` + `C` för att stoppa det.
Detta skrivs ofta som `^C` i Unix-dokumentation;
observera att 'c' kan vara en liten bokstav.

`@instructions`
Kör kommandot:

```{shell}
head
```

utant argument (så att det väntar på indata som aldrig kommer)
och stoppa det sedan genom att skriva `Ctrl` + `C`.

`@hint`
Skriv bara head, tryck på Enter och avsluta programmet med `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Har du använt `head`?")
```

---

## Sammanfattning

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Som avslutning ska du bygga en pipeline för att ta reda på hur många rader den kortaste av de säsongsbaserade datafilerna innehåller.

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
Använd `wc` med lämpliga parametrar för att lista antalet rader i alla säsongsbaserade datafiler.
(Använd ett jokertecken för filnamnen i stället för att skriva in dem ett och ett.)

`@hint`
Använd `-l` för att bara lista antalet rader och `*` för att matcha filnamn.

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
      has_code("wc", incorrect_msg = "Anropade du `wc`?"),
      has_code("-l", incorrect_msg = "Räknade du antalet rader med `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Hämtade du data från alla `seasonal/*`-filer?")
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
Lägg till ytterligare ett kommando efter det föregående med hjälp av ett pipe för att ta bort raden som innehåller ordet "total".

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
      has_code("wc", incorrect_msg = "Anropade du `wc`?"),
      has_code("-l", incorrect_msg = "Räknade du antalet rader med `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Hämtade du data från alla `seasonal/*`-filer?"),
      has_code("|", incorrect_msg = "Skickade du utdata från `wc` till `grep` med hjälp av `|`?"),      
      has_code("grep", incorrect_msg = "Anropade du `grep`?"),
      has_code("-v", incorrect_msg = "Inverterade du matchningen med `-v`?"),
      has_code("total", incorrect_msg = "Sökte du efter `total`?")
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
Lägg till ytterligare två steg i pipelinen med `sort -n` och `head -n 1` för att hitta filen med färst antal rader.

`@hint`
- Använd flaggan `-n` med `sort` för att sortera numeriskt.
- Använd flaggan `-n` med `head` för att begränsa utdata till 1 rad.

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
      has_code("wc", incorrect_msg = "Anropade du `wc`?"),
      has_code("-l", incorrect_msg = "Räknade du antalet rader med `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Hämtade du data från alla `seasonal/*`-filer?"),
      has_code("|", incorrect_msg = "Skickade du data från `wc` till `grep` till `sort` till `head` med hjälp av `|`?"),      
      has_code("grep", incorrect_msg = "Anropade du `grep`?"),
      has_code("-v", incorrect_msg = "Inverterade du matchningen med `-v`?"),
      has_code("total", incorrect_msg = "Sökte du efter `total`?"),
      has_code("sort", incorrect_msg = "Anropade du `sort`?"),
      has_code("-n", incorrect_msg = "Angav du antalet rader att behålla med `-n`?"),
      has_code("1", incorrect_msg = "Angav du 1 rad att behålla med `-n 1`?")
    )
  )
)
Ex().success_msg("Bra gjort! Det visar sig att `autumn.csv` är filen med färst rader. Skynda dig till kapitel 4 för att lära dig mer om batchbearbetning!")
```

---
title: Kombinování nástrojů
description: >-
  Skutečná síla shellu Unixu nespočívá v jednotlivých příkazech, ale v tom, jak
  snadno je lze kombinovat a dělat s nimi nové věci. Tato kapitola ti ukáže, jak
  tuto sílu využít k výběru dat, a představí příkazy pro řazení hodnot a
  odstraňování duplicit.
lessons:
  - nb_of_exercises: 12
    title: Jak uložit výstup příkazu do souboru?
---

## Jak uložit výstup příkazu do souboru?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Všechny nástroje, které jsi dosud viděl/a, umožňují zadat vstupní soubory.
Většina z nich nenabízí možnost pojmenovat výstupní soubor, protože to jednoduše není potřeba.
Místo toho můžeš použít **přesměrování** a uložit výstup libovolného příkazu kamkoli chceš.
Spustíš-li tento příkaz:

```{shell}
head -n 5 seasonal/summer.csv
```

vypíše prvních 5 řádků letních dat na obrazovku.
Pokud ale spustíš tento příkaz:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

na obrazovce se nic nezobrazí.
Místo toho se výstup příkazu `head` uloží do nového souboru s názvem `top.csv`.
Obsah tohoto souboru si můžeš prohlédnout pomocí `cat`:

```{shell}
cat top.csv
```

Znak `>` říká shellu, aby přesměroval výstup příkazu `head` do souboru.
Není součástí samotného příkazu `head` –
funguje se všemi příkazy shellu, které nějaký výstup produkují.

`@instructions`
Zkombinuj příkaz `tail` s přesměrováním a ulož posledních 5 řádků souboru `seasonal/winter.csv` do souboru `last.csv`.

`@hint`
Použij `tail -n 5` k získání posledních 5 řádků.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "Řádek `%s` by měl být v souboru `last.csv`, ale není. Přesměrujte výstup příkazu `tail -n 5 seasonal/winter.csv` do souboru `last.csv` pomocí `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` obsahuje příliš mnoho řádků. Použili jste příznak `-n 5` s příkazem `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Výborně! Pojďme si procvičit ještě více!")
```

---

## Jak použít výstup příkazu jako vstup?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Řekněme, že chceš získat řádky z prostředku souboru.
Konkrétně třeba řádky 3–5 z jednoho z našich datových souborů.
Můžeš začít tak, že pomocí `head` vezmeš prvních 5 řádků
a přesměruješ je do souboru,
a pak pomocí `tail` vybereš poslední 3:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Rychlá kontrola potvrdí, že jde skutečně o řádky 3–5 původního souboru,
protože jsou to poslední 3 řádky z prvních 5.

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
Vyber poslední dva řádky ze souboru `seasonal/winter.csv`
a ulož je do souboru `bottom.csv`.

`@hint`
Použij `tail` pro výběr řádků a `>` pro přesměrování výstupu příkazu `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="Řádek `%s` by měl být v souboru `bottom.csv`, ale není. Přesměrujte výstup příkazu `tail -n 2 seasonal/winter.csv` do souboru `bottom.csv` pomocí `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = 'Soubor `bottom.csv` obsahuje příliš mnoho řádků. Použili jste přepínač `-n 2` u příkazu `tail`?'),
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
Vyber první řádek ze souboru `bottom.csv`,
abys získal/a předposlední řádek původního souboru.

`@hint`
Použij `head` pro výběr požadovaného řádku.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Se souborem `bottom.csv` je něco špatně. Ujistěte se, že jej neměníte!"),
    has_expr_output(strict=True, incorrect_msg="Použili jste `head` správně na `bottom.csv`? Ujistěte se, že správně používáte příznak `-n`.")
)

Ex().success_msg("Výborně. Přejděte k dalšímu cvičení a zjistěte více o lepších způsobech kombinování příkazů.")
```

---

## Jak lépe kombinovat příkazy?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Kombinování příkazů přes přesměrování má dvě nevýhody:

1. Zanechává spoustu mezilehlých souborů (jako třeba `top.csv`).
2. Příkazy vedoucí k výslednému výstupu jsou rozházené přes několik řádků v historii.

Shell nabízí nástroj, který oba problémy řeší najednou – říká se mu **roura** (pipe).
Nejdřív spusť `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

Místo toho, aby ses výstup `head` uložil do souboru,
přidej svislou čáru a příkaz `tail` *bez* názvu souboru:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Symbol roury říká shellu, aby použil výstup příkazu na levé straně
jako vstup příkazu na pravé straně.

`@instructions`
Pomocí `cut` vyber všechny názvy zubů ze sloupce 2 souboru s oddělovačem čárka `seasonal/summer.csv`, a výsledek pak předej rourou do `grep` s invertovaným hledáním, aby se vyloučil řádek záhlaví obsahující slovo "Tooth". *Příkazy `cut` a `grep` byly podrobně popsány v kapitole 2, cvičeních 8 a 11.*

`@hint`
- První část příkazu má tvar `cut -d field_delimiter -f column_number filename`.
- Druhá část příkazu má tvar `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'Předali jste výsledek příkazu `cut -d , -f 2 seasonal/summer.csv` do příkazu `grep -v Tooth` pomocí `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Vyloučili jste řádek záhlaví `"Tooth"` pomocí příkazu `grep`?')
)
Ex().success_msg("Výborné použití roury! Možná jste použili `|` poprvé, ale rozhodně ne naposledy!")
```

---

## Jak zkombinovat více příkazů?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Dohromady můžeš řetězit libovolný počet příkazů.
Například
tento příkaz:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

Provede:

1. výběr prvního sloupce z jarních dat;
2. odstranění řádku záhlaví obsahujícího slovo „Date"; a
3. výběr prvních 10 řádků se skutečnými daty.

`@instructions`
V předchozím cvičení jsi použil/a tento příkaz k výběru všech názvů zubů z druhého sloupce souboru `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Rozšiř tento řetězec příkazů o příkaz `head`, který vybere pouze úplně první název zubu.

`@hint`
Zkopíruj a vlož kód z instrukcí, přidej rouru a pak zavolej `head` s přepínačem `-n`.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Použili jste `|` k rozšíření pipeline o příkaz `head`? Ujistěte se, že jste správně nastavili příznak `-n`."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Použili jste `|` k rozšíření pipeline o příkaz `head`?")
)
Ex().success_msg("Skvělé řetězení! Spojením několika příkazů dohromady můžete vytvořit výkonné pipeline pro manipulaci s daty.")
```

---

## Jak spočítat záznamy v souboru?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Příkaz `wc` (zkratka z „word count") vypíše počet **z**naků, **s**lov a **ř**ádků v souboru.
Pomocí přepínačů `-c`, `-w` nebo `-l` můžeš zobrazit vždy jen jeden z těchto údajů.

`@instructions`
Spočítej, kolik záznamů v souboru `seasonal/spring.csv` má datum v červenci 2017 (`2017-07`). 
- Použij `grep` s částí data pro výběr odpovídajících řádků a výsledek předej rourou do `wc` s vhodným přepínačem pro počítání řádků.

`@hint`
- Pomocí `head seasonal/spring.csv` si připomeň formát data.
- První část příkazu má tvar `grep thing_to_match filename`.
- Za rourou `|` zavolej `wc` s přepínačem `-l`.

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
      has_code("grep", incorrect_msg = "Zavolali jste `grep`?"),
      has_code("2017-07", incorrect_msg = "Hledali jste `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Prohledávali jste soubor `seasonal/spring.csv`?"),
      has_code("|", incorrect_msg = "Použili jste rouru `|` pro předání výstupu do `wc`?"),      
      has_code("wc", incorrect_msg = "Zavolali jste `wc`?"),
      has_code("-l", incorrect_msg = "Počítali jste řádky pomocí `-l`?")
    )
  )
)
Ex().success_msg("Pečlivé počítání! Zjistit, kolik dat máte k dispozici, je skvělým prvním krokem při každé analýze dat.")
```

---

## Jak zadat více souborů najednou?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

Většina shellových příkazů umí pracovat s více soubory najednou, pokud jim zadáš více názvů souborů.
Například první sloupec ze všech souborů se sezónními daty získáš takto:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Neustálé opisování názvů souborů ale není dobrý nápad:
zabírá čas a dřív nebo později buď na nějaký soubor zapomeneš, nebo ho zadáš dvakrát.
Aby ti to shell usnadnil, můžeš k zadání seznamu souborů jediným výrazem použít **zástupné znaky** (wildcards).
Nejčastějším zástupným znakem je `*`,
který znamená „odpovídá nule nebo více znakům".
S jeho pomocí lze zkrátit výše uvedený příkaz `cut` na:

```{shell}
cut -d , -f 1 seasonal/*
```

nebo:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Napiš jediný příkaz s `head`, který získá první tři řádky ze souborů `seasonal/spring.csv` a `seasonal/summer.csv` — celkem šest řádků dat — ale *ne* ze souborů s podzimními nebo zimními daty.
Místo plných názvů souborů použij zástupný znak.

`@hint`
- Příkaz má tvar `head -n number_of_lines filename_pattern`.
- Soubory v adresáři `a` začínající na `b` můžeš například vybrat vzorem `a/b*`.

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
    has_expr_output(incorrect_msg = "Můžete použít `seasonal/s*` pro výběr souborů `seasonal/spring.csv` a `seasonal/summer.csv`. Ujistěte se, že zahrnujete pouze první tři řádky každého souboru pomocí příznaku `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Nezahrnujte výstup pro `seasonal/autumn.csv`. Můžete použít `seasonal/s*` pro výběr souborů `seasonal/spring.csv` a `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Nezahrnujte výstup pro `seasonal/winter.csv`. Můžete použít `seasonal/s*` pro výběr souborů `seasonal/spring.csv` a `seasonal/summer.csv`")
)
Ex().success_msg("Výborná práce se zástupnými znaky! To se stává ještě důležitějším, pokud váš adresář obsahuje stovky nebo tisíce souborů.")
```

---

## Jaké další zástupné znaky můžu použít?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Shell podporuje i další zástupné znaky,
i když se používají méně často:

- `?` odpovídá jednomu libovolnému znaku, takže `201?.txt` odpovídá `2017.txt` nebo `2018.txt`, ale ne `2017-01.txt`.
- `[...]` odpovídá libovolnému jednomu znaku z těch, které jsou uvedeny v hranatých závorkách, takže `201[78].txt` odpovídá `2017.txt` nebo `2018.txt`, ale ne `2016.txt`.
- `{...}` odpovídá libovolnému ze vzorů oddělených čárkou uvnitř složených závorek, takže `{*.txt, *.csv}` odpovídá každému souboru, jehož název končí na `.txt` nebo `.csv`, ale ne souborům s příponou `.pdf`.

<hr/>

Který výraz odpovídá souborům `singh.pdf` a `johel.txt`, ale *ne* souborům `sandhu.pdf` nebo `sandhu.txt`?

`@hint`
Postupně porovnej každý výraz s každým názvem souboru.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Ne: `.pdf` a `.txt` nejsou názvy souborů.
- Ne: tento výraz odpovídá i souboru `sandhu.pdf`.
- Ne: výraz v hranatých závorkách odpovídá pouze jednomu znaku, ne celým slovům.
- Správně!

---

## Jak seřadit řádky textu?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Jak napovídá název,
`sort` řadí data do pořadí.
Výchozí řazení je vzestupné abecední,
ale přepínače `-n` a `-r` umožňují řadit numericky a obrátit pořadí výstupu,
`-b` ignoruje úvodní mezery
a `-f` sjednocuje velikost písmen (tedy rozlišování ignoruje).
V rouře se obvykle nejprve použije `grep` k odfiltrování nežádoucích záznamů
a poté `sort` k seřazení těch zbývajících.

`@instructions`
Pamatuješ na kombinaci `cut` a `grep`, která vybrala všechny názvy zubů ze sloupce 2 souboru `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Vycházej z tohoto příkazu a seřaď názvy zubů ze souboru `seasonal/winter.csv` (ne `summer.csv`) v sestupném abecedním pořadí. Rozšiř rouru o krok se `sort`.

`@hint`
Zkopíruj příkaz z instrukce, změň název souboru, přidej rouru a zavolej `sort` s přepínačem `-r`.

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
      has_code("cut", incorrect_msg = "Zavolali jste `cut`?"),
      has_code("-d", incorrect_msg = "Zadali jste oddělovač polí pomocí `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Získali jste data ze souboru `seasonal/winter.csv`?"),
      has_code("|", incorrect_msg = "Propojili jste `cut`, `grep` a `sort` pomocí `|`?"),      
      has_code("grep", incorrect_msg = "Zavolali jste `grep`?"),
      has_code("-v", incorrect_msg = "Invertovali jste shodu pomocí `-v`?"),
      has_code("Tooth", incorrect_msg = "Hledali jste `Tooth`?"),
      has_code("sort", incorrect_msg = "Zavolali jste `sort`?"),
      has_code("-r", incorrect_msg = "Obrátili jste pořadí řazení pomocí `-r`?")
    )
  )
)
Ex().success_msg("Seřazeno! Příkaz `sort` má mnoho využití. Například přesměrování výstupu `sort -n` do `head` zobrazí největší hodnoty.")
```

---

## Jak odstraním duplicitní řádky?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Příkaz, který se často používá spolu s `sort`, je `uniq`.
Jeho úkolem je odstranit duplicitní řádky –
přesněji řečeno odstraní *sousední* duplicitní řádky.
Pokud soubor obsahuje:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

`uniq` vrátí:

```
2017-07-03
2017-08-03
```

Ale pokud soubor obsahuje:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

`uniq` vypíše všechny čtyři řádky.
Důvod je ten, že `uniq` je navržen pro práci s velmi velkými soubory.
Aby mohl odstranit nesousední duplicity,
musel by mít celý soubor v paměti
(nebo alespoň všechny dosud zaznamenané jedinečné řádky).
Odstraněním pouze sousedních duplicit si v paměti stačí uchovat jen poslední jedinečný řádek.

`@instructions`
Sestav pipeline, která:

- získá druhý sloupec ze souboru `seasonal/winter.csv`,
- odstraní z výstupu slovo "Tooth", aby se zobrazovaly pouze názvy zubů,
- seřadí výstup tak, aby byly všechny výskyty daného názvu zubu sousední, a
- zobrazí každý název zubu jednou spolu s počtem, kolikrát se vyskytuje.

Začátek pipeline je stejný jako v předchozím cvičení:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Rozšiř ho o příkaz `sort` a použij `uniq -c` k zobrazení jedinečných řádků s počtem výskytů – místo kombinace `uniq` a `wc`.

`@hint`
Zkopíruj a vlož příkaz z instrukcí, přidej rouru na `sort` bez přepínačů a pak další rouru na `uniq` s přepínačem `-c`.

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
                     incorrect_msg="Měli byste začít tímto příkazem: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Nyní jej rozšiřte!"),
            has_code('\|\s+sort', incorrect_msg="Rozšířili jste příkaz o `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="Rozšířili jste příkaz o `| uniq`?"),
            has_code('-c', incorrect_msg="Zahrnuli jste počty pomocí `-c`?")
        )
    )
)
Ex().success_msg("Výborně! Po veškeré této práci s rourou by bylo užitečné, kdybychom mohli výsledek uložit, že ano?")
```

---

## Jak uložit výstup roury?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Shell umožňuje přesměrovat výstup celé sekvence příkazů spojených rourou:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Znak `>` ale musí stát vždy na konci roury.
Pokud ho zkusíš umístit doprostřed, například takto:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

pak se celý výstup příkazu `cut` zapíše do souboru `teeth-only.txt`,
na `grep` tak nezůstane nic a ten bude čekat na vstup donekonečna.

<hr>

Co se stane, když přesměrování umístíme na začátek roury, jako zde:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [Výstup příkazu se přesměruje do souboru jako obvykle.]
- Shell to vyhodnotí jako chybu.
- Shell bude čekat na vstup donekonečna.

`@hint`
Vyzkoušej to v shellu.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Správně!', 'Ne; shell to ve skutečnosti může spustit.', 'Ne; shell to ve skutečnosti může spustit.'])
```

---

## Jak zastavit spuštěný program?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Všechny příkazy a skripty, které jsi dosud spouštěl/a, proběhly rychle,
ale některé úlohy mohou trvat minuty, hodiny nebo i celé dny.
Může se také stát, že omylem vložíš přesměrování doprostřed pipeline
a program se zasekne.
Pokud se rozhodneš, že chceš běžící program zastavit,
stačí stisknout `Ctrl` + `C`.
V dokumentaci Unixu se to často zapisuje jako `^C`;
poznámka: písmeno 'c' může být malé.

`@instructions`
Spusť příkaz:

```{shell}
head
```

bez jakýchkoli argumentů (program tak bude čekat na vstup, který nikdy nepřijde)
a pak ho zastav stisknutím `Ctrl` + `C`.

`@hint`
Stačí zadat head, stisknout Enter a spuštěný program ukončit pomocí `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Použili jste `head`?")
```

---

## Shrnutí

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Na závěr sestavíš pipeline, která zjistí, kolik záznamů obsahuje nejkratší ze souborů se sezónními daty.

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
Pomocí příkazu `wc` s odpovídajícími parametry vypiš počet řádků ve všech souborech se sezónními daty.
(Místo ručního zadávání každého názvu souboru použij zástupný znak.)

`@hint`
Použij přepínač `-l` pro výpis pouze počtu řádků a `*` pro shodu s názvy souborů.

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
      has_code("wc", incorrect_msg = "Použili jste příkaz `wc`?"),
      has_code("-l", incorrect_msg = "Počítáte počet řádků pomocí `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Získáváte data ze všech souborů `seasonal/*`?")
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
Přidej k předchozímu příkazu pomocí roury další příkaz, který odstraní řádek obsahující slovo "total".

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
      has_code("wc", incorrect_msg = "Zavolali jste `wc`?"),
      has_code("-l", incorrect_msg = "Počítali jste počet řádků pomocí `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Získali jste data ze všech souborů `seasonal/*`?"),
      has_code("|", incorrect_msg = "Použili jste rouru z `wc` do `grep` pomocí `|`?"),      
      has_code("grep", incorrect_msg = "Zavolali jste `grep`?"),
      has_code("-v", incorrect_msg = "Obrátili jste shodu pomocí `-v`?"),
      has_code("total", incorrect_msg = "Hledali jste `total`?")
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
Přidej do pipeline další dvě fáze využívající `sort -n` a `head -n 1`, které najdou soubor s nejmenším počtem řádků.

`@hint`
- Použij přepínač `-n` příkazu `sort` pro numerické řazení.
- Použij přepínač `-n` příkazu `head` pro omezení výstupu na 1 řádek.

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
      has_code("wc", incorrect_msg = "Zavolali jste `wc`?"),
      has_code("-l", incorrect_msg = "Počítali jste počet řádků pomocí `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Získali jste data ze všech souborů `seasonal/*`?"),
      has_code("|", incorrect_msg = "Propojili jste `wc`, `grep`, `sort` a `head` pomocí `|`?"),      
      has_code("grep", incorrect_msg = "Zavolali jste `grep`?"),
      has_code("-v", incorrect_msg = "Invertovali jste shodu pomocí `-v`?"),
      has_code("total", incorrect_msg = "Hledali jste `total`?"),
      has_code("sort", incorrect_msg = "Zavolali jste `sort`?"),
      has_code("-n", incorrect_msg = "Zadali jste počet řádků k zachování pomocí `-n`?"),
      has_code("1", incorrect_msg = "Zadali jste 1 řádek k zachování pomocí `-n 1`?")
    )
  )
)
Ex().success_msg("Výborně! Ukázalo se, že `autumn.csv` je soubor s nejmenším počtem řádků. Přejděte do kapitoly 4 a dozvíte se více o dávkovém zpracování!")
```

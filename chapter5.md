---
title: Vytváření vlastních nástrojů
description: >-
  Historie ti umožní opakovat příkazy jen s několika stisky kláves a roury ti
  dovolí kombinovat existující příkazy a vytvářet z nich nové. V této kapitole
  uděláš krok dál a vytvoříš si vlastní příkazy.
lessons:
  - nb_of_exercises: 9
    title: Jak upravit soubor?
---

## Jak upravit soubor?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix nabízí překvapivě velké množství textových editorů.
V tomto kurzu budeme používat jednoduchý editor jménem Nano.
Pokud zadáš `nano filename`,
otevře se soubor `filename` k úpravám
(nebo se vytvoří nový, pokud ještě neexistuje).
Pohybovat se můžeš pomocí šipek,
mazat znaky klávesou Backspace
a provádět další operace pomocí klávesových zkratek s Ctrl:

- `Ctrl` + `K`: smazání řádku.
- `Ctrl` + `U`: obnovení smazaného řádku.
- `Ctrl` + `O`: uložení souboru (písmeno „O" jako „output"). _Nezapomeň potvrdit název souboru stisknutím Enter!_
- `Ctrl` + `X`: zavření editoru.

`@instructions`
Spusť příkaz `nano names.txt` a otevři tak nový soubor ve svém domovském adresáři.
Zadej do něj tyto čtyři řádky:

```
Lovelace
Hopper
Johnson
Wilson
```

Až budeš hotový/hotová,
uložení provedeš stiskem `Ctrl` + `O`,
potom potvrdíš název souboru klávesou Enter
a editor zavřeš pomocí `Ctrl` + `X`.

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
patt = "Zahrnuli jste řádek `%s` do souboru `names.txt`? Použijte `nano names.txt` znovu k aktualizaci souboru. Pro uložení použijte `Ctrl` + `O` a pro ukončení `Ctrl` + `X`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Výborně! Přejdeme na další!")
```

---

## Jak si zaznamenat, co jsem právě udělal/a?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Při složitější analýze se ti bude hodit mít záznam příkazů, které jsi použil/a.
Můžeš to udělat pomocí nástrojů, které už znáš:

1. Spusť `history`.
2. Výstup přesměruj přes rouru do `tail -n 10` (nebo jiného počtu posledních kroků, které chceš uložit).
3. Výsledek přesměruj do souboru s názvem třeba `figure-5.history`.

To je spolehlivější než ruční zápisky v laboratorním deníku –
jsi tak jistý/á, že ti žádný krok neunikne.
Zároveň to vystihuje základní myšlenku shellu:
jednoduchá nástroje, která produkují a zpracovávají řádky textu,
lze kombinovat mnoha různými způsoby
a řešit tak širokou škálu úloh.

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
Zkopíruj soubory `seasonal/spring.csv` a `seasonal/summer.csv` do svého domovského adresáře.

`@hint`
K zkopírování použij `cp` a jako zkratku pro cestu k domovskému adresáři `~`.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Použili jste příkaz `cp seasonal/s* ~` ke zkopírování požadovaných souborů do domovského adresáře?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Pozoruhodné vedení záznamů! Pokud jste zadali nějaké příkazy chybně, můžete vždy použít `nano` k vyčištění souboru s historií uložení.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Použij `grep` s přepínačem `-h` (potlačí výpis názvů souborů)
a `-v Tooth` (vybere řádky, které *neodpovídají* řádku záhlaví),
až vybereš datové záznamy ze souborů `spring.csv` a `summer.csv` v tomto pořadí
a přesměruj výstup do souboru `temp.csv`.

`@hint`
Přepínače uváděj před názvy souborů.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Ujistěte se, že přesměrujete výstup příkazu `grep` do souboru `temp.csv` pomocí `>`!"
msg2 = "Použili jste příkaz `grep -h -v ___ ___ ___` (doplňte mezery) pro naplnění souboru `temp.csv`?"
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
Přesměruj výstup příkazu `history` přes rouru do `tail -n 3`
a výsledek ulož přesměrováním do souboru `steps.txt`,
aby se v něm uložily poslední tři příkazy.
(Je potřeba uložit tři místo dvou,
protože samotný příkaz `history` bude součástí seznamu.)

`@hint`
Nezapomeň, že přesměrování pomocí `>` se zapisuje na konec celého řetězce příkazů spojených rourou.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Ujistěte se, že přesměrujete výstup příkazu do souboru `steps.txt`."
msg2="Použili jste `history | tail ___ ___` (doplňte mezery) k naplnění souboru `steps.txt`?"
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
Ex().success_msg("Výborně! Pojďme to posunout na vyšší úroveň!")
```

---

## Jak uložit příkazy pro pozdější opakované spuštění?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Zatím jsi shell používal/a interaktivně.
Protože příkazy, které zadáváš, jsou ale jen text,
můžeš je uložit do souborů a nechat shell, aby je spouštěl znovu a znovu.
Aby sis tuhle mocnou funkci vyzkoušel/a v praxi,
vlož následující příkaz do souboru s názvem `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Tento příkaz vybere první řádek z každého CSV souboru v adresáři `seasonal`.
Jakmile soubor vytvoříš,
můžeš ho spustit zadáním:

```{shell}
bash headers.sh
```

Tím říkáš shellu (což je program jménem `bash`),
aby spustil příkazy obsažené v souboru `headers.sh`.
Výsledek je stejný, jako kdybys příkazy zadal/a přímo.

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
Pomocí `nano dates.sh` vytvoř soubor `dates.sh`,
který bude obsahovat tento příkaz:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

Ten slouží k extrakci prvního sloupce ze všech CSV souborů v adresáři `seasonal`.

`@hint`
Vlož zadané příkazy do souboru bez nadbytečných prázdných řádků nebo mezer.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Zahrnuli jste řádek `cut -d , -f 1 seasonal/*.csv` do souboru `dates.sh`? Použijte `nano dates.sh` znovu k aktualizaci souboru. Pro uložení použijte `Ctrl` + `O` a pro ukončení `Ctrl` + `X`."
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
Pomocí `bash` spusť soubor `dates.sh`.

`@hint`
Soubor spustíš pomocí `bash název_souboru`.

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
      has_code("bash", incorrect_msg = 'Zavolali jste `bash`?'),
      has_code("dates.sh", incorrect_msg = 'Zadali jste soubor `dates.sh`?')
    )
  )
)
```

---

## Jak znovu využít roury?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Soubor obsahující shellové příkazy se nazývá ***shellový skript**,
nebo zkráceně jen „skript". Skripty nemusí mít názvy končící na `.sh`,
ale v této lekci budeme tuto konvenci dodržovat,
aby bylo snadno poznat, které soubory jsou skripty.

Skripty mohou také obsahovat roury.
Například,
pokud `all-dates.sh` obsahuje tento řádek:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

pak:

```{shell}
bash all-dates.sh > dates.out
```

vyextrahuje jedinečná data ze souborů se sezónními daty
a uloží je do `dates.out`.

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
V domovském adresáři na tebe čeká soubor `teeth.sh`, ale obsahuje několik prázdných míst.
Pomocí Nano soubor uprav a nahraď oba zástupné symboly `____`
hodnotami `seasonal/*.csv` a `-c`, aby skript vypsal počet výskytů
každého názvu zubu v CSV souborech ve složce `seasonal`.

`@hint`
K úpravě souboru použij `nano teeth.sh`.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Nahradili jste správně prázdná místa tak, aby příkaz v `teeth.sh` zněl `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Použijte `nano teeth.sh` znovu a proveďte požadované změny."
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
Spusť `teeth.sh` pomocí `bash` a přesměruj jeho výstup do `teeth.out` pomocí `>`.

`@hint`
Nezapomeň, že `> teeth.out` musí být uvedeno *za* příkazem, který generuje výstup.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Přesměrovali jste výsledek příkazu `bash teeth.sh` do souboru `teeth.out` pomocí operátoru `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Použili jste příkaz `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Spustili jste soubor `teeth.sh`?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Přesměrovali jste výstup do souboru `teeth.out`?')
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
Spusť `cat teeth.out` a zkontroluj výsledky.

`@hint`
Nezapomeň, že můžeš zadat prvních několik znaků názvu souboru a pak stisknout tabulátor pro automatické doplnění.

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
      has_code("cat", incorrect_msg = 'Zavolali jste `cat`?'),
      has_code("teeth.out", incorrect_msg = 'Zadali jste soubor `teeth.out`?')
    )
  )
)
Ex().success_msg("Skvěle! Zpočátku to může působit uměle, ale výhodou je, že postupně automatizujete části svého pracovního postupu. Něco, co se jako datový vědec velmi hodí!")
```

---

## Jak předávat názvy souborů skriptům?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Skript, který zpracovává konkrétní soubory, je užitečný jako záznam toho, co jsi udělal/a – ale ještě užitečnější je skript, který dokáže zpracovat libovolné soubory.
K tomu slouží speciální výraz `$@` (znak dolaru bezprostředně následovaný zavináčem), který znamená „všechny parametry předané skriptu na příkazové řádce".

Například pokud soubor `unique-lines.sh` obsahuje `sort $@ | uniq`, pak při spuštění:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

shell nahradí `$@` hodnotou `seasonal/summer.csv` a zpracuje jeden soubor. Pokud spustíš:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

zpracují se dva datové soubory, a tak dále.

_Připomínka: pro uložení souboru v Nano stiskni `Ctrl` + `O`, potvrď název souboru klávesou Enter a editor zavři pomocí `Ctrl` + `X`._

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
Otevři skript `count-records.sh` v Nano a doplň dva zástupné symboly `____`
hodnotami `$@` a `-l` (_písmeno_) tak, aby skript počítal počet řádků v jednom nebo více souborech
a přeskočil přitom první řádek každého z nich.

`@hint`
* Použij `nano count-records.sh` k úpravě souboru.
* Zkontroluj, že zadáváš _písmeno_ `-l`, nikoli číslici jedna.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Nahradili jste správně prázdná místa tak, aby příkaz v `count-records.sh` zněl `tail -q -n +2 $@ | wc -l`? Použijte `nano count-records.sh` znovu a proveďte požadované změny."
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
Spusť skript `count-records.sh` na souborech `seasonal/*.csv`
a přesměruj výstup do souboru `num-records.out` pomocí `>`.

`@hint`
Pro přesměrování výstupu použij `>`.

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
      has_code("bash", incorrect_msg = 'Zavolali jste `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Spustili jste soubor `count-records.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Zadali jste soubory ke zpracování pomocí `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Přesměrovali jste výstup do souboru `num-records.out`?')
    )
  )
)
Ex().success_msg("Výborně! Vaše znalosti shellu se neustále rozrůstají!")
```

---

## Jak zpracovat jeden argument?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Kromě `$@` ti shell umožňuje používat `$1`, `$2` a tak dále pro odkazování na konkrétní parametry příkazové řádky.
Díky tomu můžeš psát příkazy, které působí jednodušeji nebo přirozeněji než samotný shell.
Například můžeš vytvořit skript `column.sh`, který vybere jeden sloupec z CSV souboru,
když uživatel zadá název souboru jako první parametr a číslo sloupce jako druhý:

```{shell}
cut -d , -f $2 $1
```

a pak ho spustit takto:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Všimni si, že skript používá oba parametry v opačném pořadí.

<hr>

Skript `get-field.sh` má za úkol přijmout název souboru,
číslo řádku k výběru,
číslo sloupce k výběru
a vypsat právě toto pole z CSV souboru.
Například:

```
bash get-field.sh seasonal/summer.csv 4 2
```

by mělo vybrat druhé pole ze čtvrtého řádku souboru `seasonal/summer.csv`.
Který z následujících příkazů patří do skriptu `get-field.sh`?

`@hint`
Nezapomeň, že parametry příkazové řádky se číslují zleva doprava.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Ne: tím bys zkusil/a použít název souboru jako počet řádků pro `head`.
- Správně!
- Ne: tím bys zaměnil/a číslo sloupce za číslo řádku a naopak.
- Ne: tím bys použil/a číslo pole jako název souboru a naopak.

---

## Jak může jeden shell skript dělat víc věcí najednou?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Naše shell skripty měly zatím jediný příkaz nebo rouru, ale skript může obsahovat mnoho řádků příkazů. Můžeš například vytvořit skript, který ti řekne, kolik záznamů mají nejkratší a nejdelší z tvých datových souborů – tedy rozsah délek tvých datasetů.

Pozor: v Nano se „kopírování a vkládání" provádí tak, že přejdeš na řádek, který chceš zkopírovat, stiskneš `CTRL` + `K` pro jeho vyjmutí a pak dvakrát `CTRL` + `U` pro vložení dvou kopií.

_Připomínka: pro uložení souboru v Nano stiskni `Ctrl` + `O`, potvrď název souboru klávesou Enter a editor zavři pomocí `Ctrl` + `X`._

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
V Nano uprav skript `range.sh`
a nahraď dvě zástupná místa `____`
hodnotami `$@` a `-v`,
aby skript vypsal názvy a počty řádků všech souborů zadaných na příkazovém řádku
*bez* zobrazení celkového počtu řádků ze všech souborů.
(Počty řádků záhlaví sloupců od souborů neodečítej.)

`@hint`
Pomocí `wc -l $@` spočítej řádky ve všech souborech zadaných na příkazovém řádku.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Nahradili jste správně prázdná místa tak, aby příkaz v `range.sh` zněl `wc -l $@ | grep -v total`? Použijte `nano range.sh` znovu k provedení požadovaných změn."
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
Znovu otevři Nano a přidej do roury v `range.sh` příkazy `sort -n` a `head -n 1` v tomto pořadí,
aby skript zobrazil název a počet řádků nejkratšího předaného souboru.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Přidali jste `sort -n` a `head -n 1` s rourami do souboru `range.sh`? Použijte `nano range.sh` znovu a proveďte požadované změny."
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
V Nano přidej do `range.sh` druhý řádek, který vypíše název a počet záznamů
*nejdelšího* souboru v adresáři *spolu s* nejkratším.
Tento řádek by měl být duplikátem toho, který jsi už napsal/a,
ale s `sort -n -r` místo `sort -n`.

`@hint`
Zkopíruj první řádek a uprav pořadí řazení.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Ponechte první řádek v souboru `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Zduplikovali jste první řádek v `range.sh` a provedli malou změnu? `sort -n -r` místo `sort -n`!"
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
Spusť skript nad soubory v adresáři `seasonal`
a pomocí `seasonal/*.csv` zahrň všechny soubory.
Výstup přesměruj pomocí `>`
do souboru `range.out` ve svém domovském adresáři.

`@hint`
Spusť skript příkazem `bash range.sh`, soubory zadej pomocí `seasonal/*.csv` a výstup přesměruj pomocí `> range.out`.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Přesměrovali jste správně výsledek příkazu `bash range.sh seasonal/*.csv` do souboru `range.out` pomocí `>`?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Zavolali jste `bash`?'),
has_code("bash\s+range.sh", incorrect_msg = 'Spustili jste soubor `range.sh`?'),
has_code("seasonal/\*", incorrect_msg = 'Zadali jste soubory ke zpracování pomocí `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = 'Přesměrovali jste výstup do souboru `range.out`?')
)
)

Ex().success_msg("Vše probíhá dobře. Přejděte na další cvičení a naučte se psát smyčky!")
```

---

## Jak psát smyčky ve shell skriptu?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shell skripty mohou obsahovat i smyčky. Můžeš je zapsat pomocí středníků, nebo je rozdělit na více řádků bez středníků – tím bude kód přehlednější:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Příkazy uvnitř smyčky odsazovat nemusíš, ale odsazení zpřehlední kód.)

První řádek tohoto skriptu je **komentář**, který čtenářům vysvětluje, co skript dělá. Komentáře začínají znakem `#` a pokračují až do konce řádku. Tvoje budoucí já ti poděkuje za stručné poznámky, jako je tato – přidávej je ke každému skriptu, který napíšeš.

_Připomínáme: pro uložení souboru v Nano stiskni `Ctrl` + `O`, potom potvrď název souboru klávesou Enter a editor zavři kombinací `Ctrl` + `X`._

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
Doplň zástupné symboly ve skriptu `date-range.sh`
hodnotami `$filename` (dvakrát), `head` a `tail`,
aby skript vypsal první a poslední datum z jednoho nebo více souborů.

`@hint`
Nezapomeň použít `$filename` pro získání aktuální hodnoty proměnné smyčky.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="V `date-range.sh`, změnili jste %s řádek ve smyčce na `%s`? Pro provedení změn použijte `nano date-range.sh`."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('první', cmdpatt%'head')
msg2=msgpatt%('druhý', cmdpatt%'tail')
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
Spusť `date-range.sh` na všech čtyřech souborech se sezónními daty
a k jejich výběru použij výraz `seasonal/*.csv`.

`@hint`
Výraz se zástupným znakem by měl začínat názvem adresáře.

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
      has_code("bash", incorrect_msg = 'Zavolali jste `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Spustili jste soubor `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Zadali jste soubory ke zpracování pomocí `seasonal/*`?')
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
Spusť `date-range.sh` na všech čtyřech souborech se sezónními daty s použitím `seasonal/*.csv`
a výstup předej rourou do příkazu `sort` – uvidíš, že tvoje skripty lze používat stejně jako vestavěné příkazy Unixu.

`@hint`
Použij stejný výraz se zástupným znakem jako v předchozím kroku.

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
      has_code("bash", incorrect_msg = 'Zavolali jste `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Spustili jste soubor `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Zadali jste soubory ke zpracování pomocí `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Přesměrovali jste výstup skriptu do `sort` pomocí roury?'),
      has_code("sort", incorrect_msg = 'Zavolali jste `sort`?')
    )
  )
)
Ex().success_msg("Skvělé! Všimněte si, jak lze vše, co jsme se naučili, vzájemně kombinovat.")
```

---

## Co se stane, když nezadám názvy souborů?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Častá chyba ve shellových skriptech (i při interaktivním zadávání příkazů) je uvést názvy souborů na špatném místě.
Pokud napíšeš:

```{shell}
tail -n 3
```

`tail` nedostane žádný soubor, a proto čeká na vstup z klávesnice.
To znamená, že pokud napíšeš:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

`tail` bez problémů vypíše poslední tři řádky souboru `somefile.txt`,
ale `head` čeká donekonečna na vstup z klávesnice,
protože nedostal žádný soubor a v rouru před ním nic není.

<hr>

Představ si, že omylem zadáš:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Co bys měl/a udělat?

`@possible_answers`
- Počkat 10 sekund, než `head` vyprší časový limit.
- Zadat `somefile.txt` a stisknout Enter, aby `head` dostal vstup.
- Použít `Ctrl` + `C` a zastavit běžící program `head`.

`@hint`
Co dělá `head`, pokud nedostane žádný soubor a nic mu nepředchází v rouru?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Ne, příkazy nevyprší.'
a2 = 'Ne, tím předáte příkazu `head` text `somefile.txt` ke zpracování, ale poté bude čekat na další vstup.'
a3 = "Ano! Pro zastavení běžícího programu byste měli použít `Ctrl` + `C`. Tím končí tento úvodní kurz! Pokud máte zájem dozvědět se více o nástrojích příkazové řádky, důrazně doporučujeme absolvovat náš bezplatný úvodní kurz o systému Git!"
Ex().has_chosen(3, [a1, a2, a3])
```

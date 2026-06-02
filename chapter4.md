---
title: Hromadné zpracování
description: >-
  Většina příkazů shellu zpracovává najednou mnoho souborů. Tato kapitola ti
  ukáže, jak to zařídit i ve vlastních rourách. Zároveň uvidíš, jak shell
  používá proměnné k ukládání informací.
lessons:
  - nb_of_exercises: 10
    title: Jak shell ukládá informace?
---

## Jak shell ukládá informace?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Shell, stejně jako jiné programy, ukládá informace do proměnných.
Některé z nich,
zvané **proměnné prostředí**,
jsou dostupné neustále.
Názvy proměnných prostředí se podle konvence píší velkými písmeny.
Několik nejčastěji používaných je uvedeno níže.

| Proměnná | Účel                                      | Hodnota               |
|----------|-------------------------------------------|-----------------------|
| `HOME`   | Domovský adresář uživatele                | `/home/repl`          |
| `PWD `   | Aktuální pracovní adresář                 | Stejné jako příkaz `pwd` |
| `SHELL`  | Který shell program se používá            | `/bin/bash`           |
| `USER`   | ID uživatele                              | `repl`                |

Úplný seznam (který je poměrně dlouhý) zobrazíš příkazem `set` v shellu.

<hr>

Pomocí `set` a `grep` s rourou zobraz hodnotu proměnné `HISTFILESIZE`,
která určuje, kolik starých příkazů se uchovává v historii příkazů.
Jaká je její hodnota?

`@possible_answers`
- 10
- 500
- [2000]
- Tato proměnná tam není.

`@hint`
Pomocí `set | grep HISTFILESIZE` získáš řádek, který hledáš.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Ne: shell zaznamenává více historie než to."
err2 = "Ne: shell zaznamenává více historie než to."
correct3 = "Správně: shell ve výchozím nastavení ukládá v tomto systému 2000 starých příkazů."
err4 = "Ne: proměnná `HISTFILESIZE` tam je."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Jak vypsat hodnotu proměnné?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Jednodušší způsob, jak zjistit hodnotu proměnné, je příkaz `echo`, který vypíše své argumenty. Zadáním

```{shell}
echo hello DataCamp!
```

se vypíše

```
hello DataCamp!
```

Když se ale pokusíš takhle vypsat hodnotu proměnné:

```{shell}
echo USER
```

vypíše se název proměnné, tedy `USER`.

Aby ses dostal/a k hodnotě proměnné, musíš před ni napsat znak dolaru `$`. Zadáním

```{shell}
echo $USER
```

se vypíše

```
repl
```

Toto platí vždy:
chceš-li získat hodnotu proměnné `X`,
musíš napsat `$X`.
(Shell tak rozliší, jestli myslíš „soubor s názvem X",
nebo „hodnotu proměnné X".)

`@instructions`
Proměnná `OSTYPE` obsahuje název typu operačního systému, který používáš.
Zobraz její hodnotu pomocí `echo`.

`@hint`
Zavolej `echo` s proměnnou `OSTYPE`, před kterou přidáš `$`.

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
            has_code('echo', incorrect_msg="Zavolali jste `echo`?"),
            has_code('OSTYPE', incorrect_msg="Vypsal jste proměnnou prostředí `OSTYPE`?"),
            has_code(r'\$OSTYPE', incorrect_msg="Nezapomeňte před `OSTYPE` uvést znak `$`.")
        )
    )
)
Ex().success_msg("Výborně, proměnná prostředí byla úspěšně zobrazena! Dobrý začátek. Pojďme pokračovat!")
```

---

## Jak ještě shell uchovává informace?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Druhý typ proměnné se nazývá **proměnná shellu** – je podobná lokální proměnné v programovacím jazyce.

Proměnnou shellu vytvoříš jednoduše tak, že přiřadíš hodnotu k názvu:

```{shell}
training=seasonal/summer.csv
```

*bez* mezer před znakem `=` nebo za ním.
Jakmile to uděláš, můžeš hodnotu proměnné zkontrolovat pomocí:

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
Definuj proměnnou s názvem `testing` a přiřaď jí hodnotu `seasonal/winter.csv`.

`@hint`
Mezi názvem proměnné a její hodnotou *nesmí* být mezery.

`@solution`
```{shell}
testing=seasonal/winter.csv

```

`@sct`
```{python}
# Z nějakého důvodu testování shellové proměnné přímo vždy projde, takže nemůžeme použít následující.
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
        has_code('testing', incorrect_msg='Definovali jste shellovou proměnnou s názvem `testing`?'),
        has_code('testing=', incorrect_msg='Napsali jste `=` přímo za `testing`, bez mezer?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Nastavili jste hodnotu proměnné `testing` na `seasonal/winter.csv`?')
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
Pomocí příkazu `head -n 1 SOMETHING` získej první řádek ze souboru `seasonal/winter.csv` –
místo názvu souboru použij hodnotu proměnné `testing`.

`@hint`
Nezapomeň použít `$testing` místo pouhého `testing`
(znak `$` je nutný k získání hodnoty proměnné).

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
    has_code(r'\$testing', incorrect_msg="Odkazovali jste na proměnnou shellu pomocí `$testing`?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Zavolali jste `head`?"),
            has_code('-n', incorrect_msg="Omezili jste počet řádků pomocí `-n`?"),
            has_code(r'-n\s+1', incorrect_msg="Zvolili jste zachování 1 řádku pomocí `-n 1`?")     
        )
    )
)
Ex().success_msg("Výborně! Podívejme se, jak lze snadno opakovat příkazy.")
```

---

## Jak opakovat příkaz vícekrát?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Shellové proměnné se používají také ve **smyčkách**,
které opakují příkazy vícekrát.
Pokud spustíš tento příkaz:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

vypíše se:

```
gif
jpg
png
```

Všimni si několika věcí týkajících se smyčky:

1. Struktura je `for` ...proměnná... `in` ...seznam... `; do` ...tělo... `; done`
2. Seznam položek, které má smyčka zpracovat (v tomto případě slova `gif`, `jpg` a `png`).
3. Proměnná, která sleduje, která položka se právě zpracovává (v tomto případě `filetype`).
4. Tělo smyčky, které provádí samotné zpracování (v tomto případě `echo $filetype`).

Všimni si, že tělo používá `$filetype` pro získání hodnoty proměnné, nikoli jen `filetype` –
stejně jako u jakékoli jiné shellové proměnné.
Také si všimni rozmístění středníků:
první patří mezi seznam a klíčové slovo `do`,
druhý mezi tělo a klíčové slovo `done`.

`@instructions`
Uprav smyčku tak, aby vypsala:

```
docx
odt
pdf
```

Jako název proměnné smyčky použij `filetype`.

`@hint`
Použij strukturu kódu z úvodního textu a nahraď typy obrázkových souborů typy dokumentů.

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
      has_code('for', incorrect_msg='Použili jste `for`?'),
      has_code('filetype', incorrect_msg='Použili jste `filetype` jako proměnnou smyčky?'),
      has_code('in', incorrect_msg='Použili jste `in` před seznamem typů souborů?'),
      has_code('docx odt pdf', incorrect_msg='Prošli jste smyčkou přes `docx`, `odt` a `pdf` v tomto pořadí?'),
      has_code(r'pdf\s*;', incorrect_msg='Vložili jste středník za poslední prvek smyčky?'),
      has_code(r';\s*do', incorrect_msg='Použili jste `do` za prvním středníkem?'),
      has_code('echo', incorrect_msg='Použili jste `echo`?'),
      has_code(r'\$filetype', incorrect_msg='Vypsali jste `$filetype` pomocí echo?'),
      has_code(r'filetype\s*;', incorrect_msg='Vložili jste středník za tělo smyčky?'),
      has_code('; done', incorrect_msg='Ukončili jste smyčku pomocí `done`?')
    )
  )
)
Ex().success_msg("Výborně, zvládli jste smyčku! Smyčky jsou skvělé, pokud chcete provést stejnou věc stokrát nebo tisíckrát.")
```

---

## Jak zopakovat příkaz pro každý soubor?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Při psaní smyčky můžeš vždy zadat názvy souborů ručně,
ale většinou je lepší použít zástupné znaky (wildcards).
Zkus spustit tuto smyčku v konzoli:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Vypíše:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

protože shell před spuštěním smyčky rozbalí výraz `seasonal/*.csv` na seznam čtyř názvů souborů.

`@instructions`
Uprav výraz se zástupným znakem na `people/*`,
aby smyčka vypisovala názvy souborů v adresáři `people`
bez ohledu na to, jakou příponu mají nebo nemají.
Jako název proměnné smyčky použij `filename`.

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
      has_code('for', incorrect_msg='Použili jste `for`?'),
      has_code('filename', incorrect_msg='Použili jste `filename` jako proměnnou cyklu?'),
      has_code('in', incorrect_msg='Použili jste `in` před seznamem typů souborů?'),
      has_code('people/\*', incorrect_msg='Zadali jste seznam souborů pomocí `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='Vložili jste středník za seznam souborů?'),
      has_code(r';\s*do', incorrect_msg='Použili jste `do` za prvním středníkem?'),
      has_code('echo', incorrect_msg='Použili jste `echo`?'),
      has_code(r'\$filename', incorrect_msg='Vypsali jste `$filename` pomocí echo?'),
      has_code(r'filename\s*;', incorrect_msg='Vložili jste středník za tělo cyklu?'),
      has_code('; done', incorrect_msg='Ukončili jste cyklus pomocí `done`?')
    )
  )
)
Ex().success_msg("Výborně! Zástupné znaky a cykly tvoří mocnou kombinaci.")
```

---

## Jak si uložit názvy skupiny souborů?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Proměnné se často nastavují pomocí zástupných výrazů, aby uchovávaly seznam názvů souborů.
Například,
pokud definuješ `datasets` takto:

```{shell}
datasets=seasonal/*.csv
```

názvy souborů si můžeš zobrazit později pomocí:

```{shell}
for filename in $datasets; do echo $filename; done
```

Takhle ušetříš psaní a snížíš riziko chyb.

<hr>

Pokud spustíš tyto dva příkazy ve svém domovském adresáři,
kolik řádků výstupu se vypíše?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Žádný: protože `files` je definováno na samostatném řádku, nemá ve druhém řádku žádnou hodnotu.
- Jeden: slovo "files".
- Čtyři: názvy všech čtyř datových souborů ze složky seasonal.

`@hint`
Pamatuj, že samotné `X` je jen "X", zatímco `$X` je hodnota proměnné `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Ne: nemusíte definovat proměnnou na stejném řádku, na kterém ji používáte."
err2 = "Ne: tento příklad definuje a používá proměnnou `files` ve stejném shellu."
correct3 = "Správně. Příkaz je ekvivalentní k `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Název proměnné versus její hodnota

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Častou chybou je zapomenout napsat `$` před název proměnné.
Pokud to uděláš,
shell použije zadaný název
místo hodnoty dané proměnné.

Zkušenější uživatelé zase občas chybně napíší název proměnné.
Například,
pokud definuješ `datasets` takto:

```{shell}
datasets=seasonal/*.csv
```

a pak napíšeš:

```{shell}
echo $datsets
```

shell nevypíše nic,
protože `datsets` (bez druhého "a") není definováno.

<hr>

Kdyby ses spustil/a tyto dva příkazy ve svém domovském adresáři,
jaký výstup by se zobrazil?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Před odpovědí si pozorně přečti první část smyčky.)

`@hint`
Pamatuj, že `X` samo o sobě je jen "X", zatímco `$X` je hodnota proměnné `X`.

`@possible_answers`
- [Jeden řádek: slovo "files".]
- Čtyři řádky: názvy všech čtyř souborů se sezónními daty.
- Čtyři prázdné řádky: proměnné `f` není přiřazena žádná hodnota.

`@feedback`
- Správně: smyčka používá `files` místo `$files`, takže seznam obsahuje pouze slovo "files".
- Ne: smyčka používá `files` místo `$files`, takže seznam obsahuje slovo "files", nikoli rozvinutou hodnotu proměnné `files`.
- Ne: proměnná `f` je definována automaticky smyčkou `for`.

---

## Jak spustit více příkazů v jedné smyčce?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Výpis názvů souborů se hodí při ladění kódu,
ale skutečným účelem smyček je pracovat s více soubory najednou.
Tato smyčka vypíše druhý řádek každého datového souboru:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Má stejnou strukturu jako ostatní smyčky, které jsi už viděl/a:
jedinný rozdíl je, že její tělo tvoří pipeline dvou příkazů místo jednoho.

`@instructions`
Napiš smyčku, která vypíše poslední záznam z července 2017 (`2017-07`) z každého sezónního souboru. Výstup by měl být podobný tomuto:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

ale zvlášť pro **_každý_** sezónní soubor. Jako název proměnné smyčky použij `file` a nezapomeň procházet seznam souborů `seasonal/*.csv` (_místo 'seasonal/winter.csv' jako v příkladu_).

`@hint`
Tělo smyčky tvoří příkaz grep uvedený v instrukcích, kde místo `seasonal/winter.csv` použiješ `$file`.

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
  has_code('for', incorrect_msg='Použili jste `for`?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Použili jste `file` jako proměnnou smyčky?'),
      has_code('in', incorrect_msg='Použili jste `in` před seznamem souborů?'),
      has_code('seasonal/\*', incorrect_msg='Zadali jste seznam souborů pomocí `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Umístili jste středník za seznam souborů?'),
      has_code(r';\s*do', incorrect_msg='Použili jste `do` za prvním středníkem?'),
      has_code('grep', incorrect_msg='Použili jste `grep`?'),
      has_code('2017-07', incorrect_msg='Hledali jste shodu s `2017-07`?'),
      has_code(r'\$file', incorrect_msg='Použili jste `$file` jako název proměnné smyčky?'),
      has_code(r'file\s*|', incorrect_msg='Použili jste rouru pro propojení druhého příkazu?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Použili jste `tail -n 1` pro výpis posledního záznamu každého hledání ve druhém příkazu?'),
      has_code('; done', incorrect_msg='Ukončili jste příkaz pomocí `done`?')
    )
  )
)

Ex().success_msg("Výborně! Zástupné znaky a smyčky tvoří mocnou kombinaci.")
```

---

## Proč nepoužívat mezery v názvech souborů?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Při práci v grafickém správci souborů je přirozené pojmenovávat soubory víceslovnými názvy, jako třeba `July 2017.csv`.
V shellu ale takové názvy způsobují problémy.
Představ si například, že chceš přejmenovat soubor `July 2017.csv` na `2017 July data.csv`.
Nemůžeš napsat:

```{shell}
mv July 2017.csv 2017 July data.csv
```

protože shell tento příkaz interpretuje tak, že se pokoušíš přesunout
čtyři soubory s názvy `July`, `2017.csv`, `2017` a `July` (znovu)
do adresáře `data.csv`.
Místo toho musíš názvy souborů uzavřít do uvozovek,
aby je shell považoval za jeden parametr:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Máš dva soubory: `current.csv` a `last year.csv`
(s mezerou v názvu)
a zadáš příkaz:

```{shell}
rm current.csv last year.csv
```

Co se stane?

`@hint`
Co bys čekal/a, že se stane, kdyby ti někdo ukázal tento příkaz a ty bys nevěděl/a, jaké soubory existují?

`@possible_answers`
- Shell zobrazí chybovou zprávu, protože soubory `last` a `year.csv` neexistují.
- Shell smaže soubor `current.csv`.
- [Obojí z výše uvedeného.]
- Nic.

`@feedback`
- Ano, ale to není vše.
- Ano, ale to není vše.
- Správně. Názvy souborů můžeš obalit jednoduchými uvozovkami `'` nebo dvojitými uvozovkami `"`.
- Bohužel ne.

---

## Jak provést více akcí v jediné smyčce?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Smyčky, které jsi dosud viděl/a, měly v těle vždy jen jeden příkaz nebo rouru,
ale smyčka může obsahovat libovolný počet příkazů.
Aby shell věděl, kde jeden příkaz končí a druhý začíná,
musíš je oddělit středníky:

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

Představ si, že zapomeneš středník mezi příkazy `echo` a `head` z předchozí smyčky
a shellu tak zadáš:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Co shell udělá?

`@possible_answers`
- Vypíše chybové hlášení.
- Vypíše jeden řádek pro každý ze čtyř souborů.
- Vypíše jeden řádek pro `autumn.csv` (první soubor).
- Vypíše poslední řádek každého souboru.

`@hint`
Výstup příkazu `echo` můžeš přesměrovat do `tail` pomocí roury.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Ne: smyčka proběhne, jen neudělá nic smysluplného."
correct2 = "Ano: `echo` vypíše jeden řádek, který obsahuje název souboru dvakrát, a `tail` ho pak zkopíruje."
err3 = "Ne: smyčka proběhne jednou pro každý ze čtyř názvů souborů."
err4 = "Ne: vstupem příkazu `tail` je výstup `echo` pro každý název souboru."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

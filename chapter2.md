---
title: Práce s daty
description: >-
  Příkazy z předchozí kapitoly ti umožnily přesouvat věci v souborovém systému.
  Tato kapitola ti ukáže, jak pracovat s daty v souborech. Nástroje, které
  použijeme, jsou celkem jednoduché, ale tvoří pevné základy pro další práci.
lessons:
  - nb_of_exercises: 12
    title: Jak zobrazit obsah souboru?
---

## Jak zobrazit obsah souboru?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Než soubory přejmenováš nebo smažeš,
možná si budeš chtít prohlédnout jejich obsah.
Nejjednodušší způsob, jak to udělat, je příkaz `cat`,
který jednoduše vypíše obsah souborů na obrazovku.
(Název pochází ze slova „concatenate", tedy „řetězit" nebo „spojovat",
protože příkaz vypíše všechny zadané soubory za sebou.)

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
Vypiš obsah souboru `course.txt` na obrazovku.

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
    has_expr_output(incorrect_msg="Váš příkaz nevygeneroval správný výstup. Použili jste `cat` následovaný názvem souboru `course.txt`?")
)
Ex().success_msg("Výborně! Podívejme se na další způsoby zobrazení obsahu souboru.")
```

---

## Jak zobrazit obsah souboru po částech?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Velkého souboru se dá vypsat pomocí `cat` a pak procházet výstup rolováním,
ale obvykle je pohodlnější výstup **stránkovat**.
Původní příkaz pro stránkování se jmenoval `more`,
nahradil ho však výkonnější příkaz `less`.
(Takový humor je v unixovém světě zcela běžný.)
Když soubor otevřeš přes `less`,
zobrazí se vždy jedna stránka;
mezerníkem se přesuneš na další stránku, klávesou `q` zobrazení ukončíš.

Pokud příkazu `less` předáš více souborů,
můžeš napsat `:n` (dvojtečka a malé 'n') pro přechod na další soubor,
`:p` pro návrat na předchozí
nebo `:q` pro ukončení.

Poznámka: Pokud si prohlédneš řešení cvičení, která používají `less`,
uvidíš na konci extra příkaz, který stránkování *vypne* –
tím pádem můžeme tvá řešení efektivně otestovat.

`@instructions`
Pomocí příkazu `less seasonal/spring.csv seasonal/summer.csv` zobraz tyto dva soubory v daném pořadí.
Mezerníkem se přesuň na další stránku, pomocí `:n` přejdi na druhý soubor a pomocí `:q` zobrazení ukonči.

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
                 incorrect_msg='Použijte `less` a názvy souborů. Nezapomeňte, že `:n` vás přesune na další soubor.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Jak se podívat na začátek souboru?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Když datový vědec dostane novou datovou sadu k analýze, většinou začne tím,
že zjistí, jaká pole obsahuje a jaké hodnoty v nich jsou.
Pokud byla datová sada exportována z databáze nebo tabulkového procesoru,
bývá uložena jako **hodnoty oddělené čárkami** (CSV).
Rychlý způsob, jak zjistit, co sada obsahuje, je podívat se na prvních několik řádků.

V shellu to zvládneme příkazem `head`.
Jak napovídá jeho název,
vypíše prvních několik řádků souboru
(přičemž „několik" znamená 10),
takže příkaz:

```{shell}
head seasonal/summer.csv
```

zobrazí:

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

Co udělá `head`, když soubor nemá ani 10 řádků?
(Vyzkoušej to na souboru `people/agarwal.txt`.)

`@possible_answers`
- Vypíše chybovou zprávu, protože soubor je příliš krátký.
- Zobrazí tolik řádků, kolik soubor obsahuje.
- Doplní prázdné řádky tak, aby celkový počet byl 10.

`@hint`
Co by bylo nejužitečnější?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Nesprávně: to není nejužitečnější věc, kterou by to mohlo dělat.",
                    "Správně!",
                    "Nesprávně: to by bylo nemožné odlišit od souboru, který končil řadou prázdných řádků."])
```

---

## Jak psát méně?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Jedním z mocných nástrojů shellu je **doplňování tabulátorem** (tab completion).
Pokud začneš psát název souboru a stiskneš klávesu Tab,
shell se pokusí cestu automaticky doplnit.
Například, pokud napíšeš `sea` a stiskneš Tab,
doplní název adresáře `seasonal/` (včetně lomítka na konci).
Pokud pak napíšeš `a` a stiskneš Tab znovu,
cesta se dokončí jako `seasonal/autumn.csv`.

Pokud je cesta nejednoznačná,
například `seasonal/s`,
druhou stisknutou Tab zobrazíš seznam možností.
Stačí dopsat jeden nebo dva znaky, aby byla cesta jednoznačná,
a po dalším stisku Tab
shell doplní zbytek názvu za tebe.

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
Spusť příkaz `head seasonal/autumn.csv`, aniž bys zadal/a celý název souboru.

`@hint`
Napiš tolik znaků cesty, kolik potřebuješ, pak stiskni Tab a opakuj.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Kontrola nenašla správný výstup ve vašem příkazu. Jste si jistý/á, že jste zavolal/a `head` na `seasonal/autumn.csv`?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Spusť příkaz `head seasonal/spring.csv`, aniž bys zadal/a celý název souboru.

`@hint`
Napiš tolik znaků cesty, kolik potřebuješ, pak stiskni Tab a opakuj.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Kontrola nenalezla správný výstup ve vašem příkazu. Jste si jistý/á, že jste zavolal/a `head` na `seasonal/spring.csv`?")
)
Ex().success_msg("Výborně! Jakmile si zvyknete na používání doplňování tabulátorem, ušetří vám to spoustu času!")
```

---

## Jak ovládat chování příkazů?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Ne vždy budeš chtít zobrazit prvních 10 řádků souboru,
proto shell umožňuje změnit chování příkazu `head`
pomocí tzv. **přepínače** (anglicky "command-line flag").
Pokud spustíš příkaz:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` zobrazí pouze první tři řádky souboru.
Pokud spustíš `head -n 100`,
zobrazí prvních 100 řádků (za předpokladu, že jich tolik existuje),
a tak dále.

Název přepínače většinou napovídá, k čemu slouží
(například `-n` odkazuje na anglické "**n**umber of lines", tedy počet řádků).
Přepínače nemusí mít nutně tvar `-` následovaný jediným písmenem,
ale jde o hojně rozšířenou konvenci.

Poznámka: za správný styl se považuje uvádět všechny přepínače *před* názvy souborů,
a proto v tomto kurzu
akceptujeme pouze odpovědi, které toto pravidlo dodržují.

`@instructions`
Zobraz prvních 5 řádků souboru `winter.csv` v adresáři `seasonal`.

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
        has_expr_output(incorrect_msg="Jste si jistý/á, že voláte `head` na souboru `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Jste si jistý/á, že jste použil/a příznak `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Jste si jistý/á, že jste použil/a příznak `-n 5`?")
)
Ex().success_msg("Výborně! Pomocí této techniky můžete zabránit přetížení shellu, pokud si chcete prohlédnout větší textové soubory.")
```

---

## Jak zobrazit vše v adresáři?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Pokud chceš vidět veškerý obsah adresáře bez ohledu na to, jak hluboko je zanořený, použij u příkazu `ls` přepínač `-R` (z anglického „recursive", tedy rekurzivní). Spustíš-li `ls -R` ve svém domovském adresáři, uvidíš něco podobného:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Výstup zobrazí všechny soubory a adresáře na aktuální úrovni, pak obsah každého podadresáře a tak dále.

`@instructions`
Aby sis snáz rozlišil/a, co je co, nabízí `ls` další přepínač `-F`, který přidá `/` za název každého adresáře a `*` za název každého spustitelného programu. Spusť `ls` s oběma přepínači, `-R` a `-F`, a absolutní cestou ke svému domovskému adresáři, abys viděl/a vše, co obsahuje. (Pořadí přepínačů nehraje roli, ale název adresáře musí být vždy poslední.)

`@hint`
Domovský adresář lze zadat pomocí `~`, `.` nebo jeho absolutní cesty.

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
  has_expr_output(incorrect_msg='Použijte buď `ls -R -F`, nebo `ls -F -R` a cestu `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Použijte buď `ls -R -F`, nebo `ls -F -R` a cestu `/home/repl`.')
)
Ex().success_msg("To je pěkný přehled, že ano?")
```

---

## Jak získat nápovědu k příkazu?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Ke zjištění, co jednotlivé příkazy dělají,
se dříve používal příkaz `man`
(zkratka anglického slova „manual").
Například příkaz `man head` zobrazí tyto informace:

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

`man` automaticky spustí `less`,
takže pro procházení informací možná budeš muset stisknout mezerník
a pro ukončení použít `:q`.

Jednořádkový popis v sekci `NAME` stručně vysvětluje, co příkaz dělá,
a přehled v sekci `SYNOPSIS` uvádí všechny podporované přepínače.
Vše, co je volitelné, je uvedeno v hranatých závorkách `[...]`,
alternativy jsou odděleny symbolem `|`
a opakující se prvky jsou označeny `...`.
Manuálová stránka příkazu `head` ti tedy říká, že můžeš zadat buď počet řádků pomocí `-n`,
*nebo* počet bajtů pomocí `-c`,
a jako vstup mu předat libovolný počet názvů souborů.

Problém unixového manuálu spočívá v tom, že musíš vědět, co hledáš.
Pokud to nevíš,
můžeš zkusit [Stack Overflow](https://stackoverflow.com/),
zeptat se na Slack kanálech DataCampu
nebo se podívat do sekce `SEE ALSO` příkazů, které již znáš.

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
Přečti si manuálovou stránku příkazu `tail` a zjisti,
co se stane, když před číslo použité s přepínačem `-n` vložíš znak `+`.
(Pro posunutí dolů stiskni mezerník a pro ukončení zadej `q`.)

`@hint`
Nezapomeň: `man` je zkratka anglického slova „manual".

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Použijte `man` a název příkazu.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Použij příkaz `tail` s přepínačem `-n +7` pro zobrazení souboru `seasonal/spring.csv` *bez* prvních šesti řádků.

`@hint`
Před počet řádků, které chceš zobrazit, přidej znaménko plus '+'.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Voláte `tail` na `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Jste si jistý/á, že jste použil/a příznak `-n +7`?")
)
```

---

## Jak vybrat sloupce ze souboru?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` a `tail` umožňují vybírat řádky z textového souboru.
Pokud chceš vybírat sloupce,
pomůže ti příkaz `cut`.
Má několik možností (prozkoumej je pomocí `man cut`),
nejčastější použití ale vypadá nějak takto:

```{shell}
cut -f 2-5,8 -d , values.csv
```

Co znamená:
„vyber sloupce 2 až 5 a sloupec 8,
použij čárku jako oddělovač".
`cut` používá přepínač `-f` (z anglického „fields", tj. pole) pro určení sloupců
a `-d` (z anglického „delimiter", tj. oddělovač) pro určení oddělovacího znaku.
Oddělovač je potřeba zadat, protože některé soubory mohou ke oddělení sloupců používat mezery, tabulátory nebo dvojtečky.

<hr>

Jakým příkazem vybereš první sloupec (obsahující data) ze souboru `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Obojí výše uvedené.
- Žádná z výše uvedených možností, protože `-f` musí být před `-d`.

`@hint`
Na pořadí přepínačů nezáleží.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Ano, ale to není všechno', 'Ano, ale to není všechno', 'Správně! Mezera za příznakem je dobrý styl, ale není povinná.', 'Ne, na pořadí příznaků nezáleží'])
```

---

## Co cut neumí?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` je poměrně jednoduchý příkaz.
Zejména nerozumí řetězcům uzavřeným v uvozovkách.
Pokud například tvůj soubor vypadá takto:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

pak příkaz:

```{shell}
cut -f 2 -d , everyone.csv
```

vyprodukuje:

```
Age
Ranjit"
Rupinder"
```

místo věku každé osoby,
protože čárku mezi příjmením a jménem považuje za oddělovač sloupců.

<hr>

Jaký bude výstup příkazu `cut -d : -f 2-4` pro tento řádek:

```
first:second:third:
```

(Všimni si dvojtečky na konci.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Žádná z výše uvedených možností, protože řádek neobsahuje čtyři pole.

`@hint`
Všimni si dvojtečky na konci řádku.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Ne, je toho více.', 'Ne, je toho více.', 'Správně! Koncová dvojtečka vytváří prázdné čtvrté pole.', 'Ne, `cut` dělá to nejlepší, co může.'])
```

---

## Jak zopakovat příkazy?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Jedna z největších výhod shellu je, že ti umožňuje snadno opakovat věci, které jsi už dělal/a.
Pokud zadáš nějaké příkazy, můžeš se k nim vrátit stiskem klávesy se šipkou nahoru.
Stiskem šipek doleva a doprava nebo klávesy Delete je pak můžeš upravovat.
Stisknutím Enter upravený příkaz spustíš.

Ještě šikovnější je příkaz `history`, který vypíše seznam naposledy spuštěných příkazů.
Každý z nich má přiřazené pořadové číslo, takže konkrétní příkaz snadno spustíš znovu:
stačí zadat `!55` a znovu se provede 55. příkaz v historii (pokud jich tolik máš).
Příkaz můžeš zopakovat i tak, že napíšeš vykřičník a za ním název příkazu,
například `!head` nebo `!cut` — tím znovu spustíš poslední použití daného příkazu.

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
Spusť `head summer.csv` ve svém domovském adresáři (příkaz by měl selhat).

`@hint`
Doplňování tabulátorem nefunguje, pokud neexistuje žádný odpovídající název souboru.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Použijte `head` a název souboru `summer.csv`. Nevadí, pokud příkaz selže. To je v pořádku.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Přejdi do adresáře `seasonal`.

`@hint`
Nezapomeň, že `cd` je zkratka pro „change directory" (změna adresáře).

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Pokud je váš aktuální pracovní adresář (zjistíte pomocí `pwd`) `/home/repl`, můžete přejít do složky `seasonal` pomocí `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Znovu spusť příkaz `head` pomocí `!head`.

`@hint`
Mezi `!` a tím, co za ním následuje, nezadávej žádnou mezeru.

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
                        incorrect_msg='Použijte `!head` pro opakování příkazu `head`.'),
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
Podívej se na historii příkazů pomocí `history`.

`@hint`
Všimni si, že `history` zobrazuje nejnovější příkazy na konci, takže zůstanou viditelné na obrazovce i po dokončení.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Použijte `history` bez příznaků pro získání seznamu předchozích příkazů.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Spusť `head` znovu pomocí `!` a čísla příkazu z historie.

`@hint`
Mezi `!` a tím, co za ním následuje, *nezadávej* žádnou mezeru.

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
                        incorrect_msg='Použili jste `!<a_number>` pro opětovné spuštění posledního příkazu `head` z historie?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Výborně! Pojďme na další!")
```

---

## Jak vybrat řádky obsahující konkrétní hodnoty?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` a `tail` vybírají řádky,
`cut` vybírá sloupce
a `grep` vybírá řádky podle jejich obsahu.
V nejjednodušší podobě přijímá `grep` hledaný text a jeden nebo více názvů souborů
a vypíše všechny řádky v těchto souborech, které daný text obsahují.
Například
`grep bicuspid seasonal/winter.csv`
vypíše řádky ze souboru `winter.csv`, které obsahují slovo „bicuspid".

`grep` umí vyhledávat i podle vzorů;
to si ukážeme v dalším kurzu.
Důležitější jsou teď nejčastěji používané přepínače `grep`u:

- `-c`: místo samotných řádků vypíše jejich počet
- `-h`: při prohledávání více souborů *nevypisuje* názvy souborů
- `-i`: ignoruje velikost písmen (např. „Regression" a „regression" bere jako shodu)
- `-l`: vypíše názvy souborů obsahujících shody, nikoli shody samotné
- `-n`: zobrazí čísla řádků u nalezených shod
- `-v`: obrátí vyhledávání, tj. zobrazí pouze řádky, které *neodpovídají* hledanému výrazu

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
Vypiš obsah všech řádků obsahujících slovo `molar` v souboru `seasonal/autumn.csv`
jedním příkazem spuštěným z domovského adresáře. Nepoužívej žádné přepínače.

`@hint`
Použij `grep` se slovem, které hledáš, a názvem souboru (nebo souborů), ve kterém hledáš.

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
      has_code("grep", incorrect_msg = "Zavolali jste `grep`?"),
      has_code("molar", incorrect_msg = "Hledali jste `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Prohledali jste soubor `seasonal/autumn.csv`?")
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
Obrať vyhledávání tak, aby se zobrazily všechny řádky, které slovo `molar` *neobsahují*, v souboru `seasonal/spring.csv`, a zobraz jejich čísla řádků.
Měj na paměti, že je dobrým zvykem uvádět všechny přepínače *před* ostatními hodnotami, jako jsou názvy souborů nebo hledaný výraz „molar".

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
      has_code("grep", incorrect_msg = "Zavolali jste `grep`?"),
      has_code("-v", incorrect_msg = "Invertovali jste shodu pomocí `-v`?"),
      has_code("-n", incorrect_msg = "Zobrazili jste čísla řádků pomocí `-n`?"),
      has_code("molar", incorrect_msg = "Hledali jste výraz `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Prohledávali jste soubor `seasonal/spring.csv`?")
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
Zjisti, kolik řádků celkem obsahuje slovo `incisor` v souborech `autumn.csv` a `winter.csv`.
(Opět použij jediný příkaz spuštěný z domovského adresáře.)

`@hint`
Nezapomeň použít přepínač `-c` spolu s `grep` pro počítání řádků.

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
      has_code("grep", incorrect_msg = "Zavolali jste `grep`?"),
      has_code("-c", incorrect_msg = "Získali jste počty pomocí `-c`?"),
      has_code("incisor", incorrect_msg = "Hledali jste `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Prohledali jste soubor `seasonal/autumn.csv`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Prohledali jste soubor `seasonal/winter.csv`?")
    )
  )
)
```

---

## Proč není vždy bezpečné pracovat s daty jako s textem?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

Sekce `SEE ALSO` na manuálové stránce příkazu `cut` odkazuje na příkaz `paste`,
který slouží ke spojování datových souborů místo jejich rozdělování.

<hr>

Přečti si manuálovou stránku příkazu `paste`,
a pak ho použij ke spojení datových souborů pro podzim a zimu do jedné tabulky
s čárkou jako oddělovačem.
Co je na výstupu z pohledu datové analýzy problematické?

`@possible_answers`
- Záhlaví sloupců se opakují.
- Posledních několik řádků má špatný počet sloupců.
- Část dat ze souboru `winter.csv` chybí.

`@hint`
Pokud použiješ `cut` na výstup příkazu `paste` s čárkou jako oddělovačem,
dostaneš správný výsledek?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Pravda, ale není to nutně chyba.'
correct2 = 'Správně: spojení řádků se sloupci vytvoří na začátku pouze jeden prázdný sloupec, nikoli dva.'
err3 = 'Ne, všechna zimní data jsou přítomna.'
Ex().has_chosen(2, [err1, correct2, err3])
```

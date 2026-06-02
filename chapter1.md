---
title: Práce se soubory a složkami
description: >-
  Tato kapitola je stručným úvodem do shellu Unixu. Dozvíš se, proč se používá
  již téměř 50 let, jak se liší od grafických nástrojů, které možná znáš lépe,
  jak se v shellu pohybovat a jak vytvářet, upravovat a mazat soubory a složky.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Jak se shell liší od grafického rozhraní?
---

## Čím se shell liší od grafického rozhraní?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Operační systém, jako je Windows, Linux nebo macOS, je zvláštní druh programu.
Řídí procesor počítače, pevný disk a síťové připojení,
ale jeho nejdůležitějším úkolem je spouštět ostatní programy.

Protože lidé nejsou digitální bytosti,
potřebují nějaké rozhraní, přes které mohou s operačním systémem komunikovat.
Dnes je nejrozšířenější grafický správce souborů,
který překládá kliknutí a poklepání na příkazy k otevírání souborů a spouštění programů.
Dříve, než počítače dostaly grafické displeje,
však
lidé zadávali instrukce do programu zvaného **příkazový řádek (shell)**.
Pokaždé, když zadáš příkaz,
shell spustí příslušné programy,
vypíše jejich výstup v čitelné podobě
a zobrazí *prompt* jako signál, že je připravený přijmout další příkaz.
(Název „shell" vychází z představy, že tvoří „vnější schránku" počítače.)

Zadávání příkazů místo klikání a přetahování může zpočátku působit neohrabaně,
ale jak brzy uvidíš,
jakmile začneš přesně říkat počítači, co má dělat,
můžeš kombinovat stávající příkazy a vytvářet nové
a automatizovat opakující se úkony
jenom s pár stisky kláves.

<hr>
Jaký je vztah mezi grafickým správcem souborů, který většina lidí používá, a příkazovým řádkem (shellem)?

`@hint`
Nezapomeň, že uživatel může s operačním systémem pracovat jen prostřednictvím nějakého programu.

`@possible_answers`
- Správce souborů umožňuje prohlížet a upravovat soubory, zatímco shell slouží ke spouštění programů.
- Správce souborů je postaven na shellu.
- Shell je součástí operačního systému, zatímco správce souborů je oddělený.
- [Obojí jsou rozhraní pro zadávání příkazů operačnímu systému.]

`@feedback`
- Obě rozhraní umožňují prohlížet a upravovat soubory i spouštět programy.
- Grafický správce souborů i shell volají stejné funkce operačního systému.
- Shell i správce souborů jsou programy, které převádějí příkazy uživatele (zadané textem nebo kliknutím) na volání operačního systému.
- Správně! Obě rozhraní přijímají příkazy od uživatele (ať už zadané textem, nebo kliknutím) a předávají je operačnímu systému.

---

## Kde jsem?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**Souborový systém** spravuje soubory a adresáře (neboli složky).
Každý z nich je identifikován **absolutní cestou**,
která ukazuje, jak se k němu dostat od **kořenového adresáře** souborového systému:
`/home/repl` je adresář `repl` uvnitř adresáře `home`,
`/home/repl/course.txt` je soubor `course.txt` v tomto adresáři
a `/` samotné představuje kořenový adresář.

Aby ses dozvěděl/a, kde v souborovém systému právě jsi,
spusť příkaz `pwd`
(zkratka z anglického „**p**rint **w**orking **d**irectory", tedy „vypsat pracovní adresář").
Ten zobrazí absolutní cestu k tvému **aktuálnímu pracovnímu adresáři** –
to je místo, kde shell ve výchozím nastavení spouští příkazy a hledá soubory.

<hr>
Spusť příkaz `pwd`.
Kde se právě nacházíš?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix systémy většinou ukládají domovské adresáře všech uživatelů do `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "To není správná cesta."
correct = "Správně – nacházíte se v `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Jak rozpoznat soubory a adresáře?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` ti ukáže, kde se právě nacházíš.
Chceš-li zjistit, co se tam nachází,
zadej `ls` (zkratka z anglického „**l**i**s**ting") a stiskni Enter.
Samotný příkaz `ls` vypíše obsah tvého aktuálního adresáře
(toho, který zobrazuje `pwd`).
Pokud zadáš názvy souborů,
`ls` je vypíše,
a pokud zadáš názvy adresářů,
zobrazí jejich obsah.
Například
`ls /home/repl` ukáže obsah tvého výchozího adresáře
(obvykle nazývaného **domovský adresář**).

<hr>
Použij `ls` s vhodným argumentem a vypiš soubory v adresáři `/home/repl/seasonal`
(který obsahuje informace o zubních ošetřeních podle data, rozdělené podle ročních období).
Který z těchto souborů v daném adresáři *není*?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Pokud příkazu `ls` zadáš cestu, zobrazí obsah daného umístění.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Tento soubor se nachází v adresáři `seasonal`."
correct = "Správně – tento soubor se *nenachází* v adresáři `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Jak jinak můžu identifikovat soubory a adresáře?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Absolutní cesta je jako zeměpisná souřadnice: má stejnou hodnotu bez ohledu na to, kde se nacházíš. **Relativní cesta** naopak určuje umístění od místa, kde právě jsi – je to jako říct „20 kilometrů na sever".

Příklady:
- Pokud se nacházíš v adresáři `/home/repl`, **relativní** cesta `seasonal` odkazuje na stejný adresář jako **absolutní** cesta `/home/repl/seasonal`.
- Pokud se nacházíš v adresáři `/home/repl/seasonal`, **relativní** cesta `winter.csv` odkazuje na stejný soubor jako **absolutní** cesta `/home/repl/seasonal/winter.csv`.

Shell rozpozná, zda je cesta absolutní nebo relativní, podle prvního znaku: začíná-li znakem `/`, jde o absolutní cestu. Pokud `/` *nezačíná*, jde o relativní cestu.

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
Nacházíš se v `/home/repl`. Použij `ls` s **relativní cestou** a vypiš soubor, jehož absolutní cesta je `/home/repl/course.txt` (a pouze ten soubor).

`@hint`
Relativní cestu k souboru nebo adresáři nebo souboru, který se nachází pod tvou aktuální polohou,
lze často sestavit tak, že od absolutní cesty k cílovému souboru odečteš absolutní cestu tvého aktuálního umístění.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Nezavolali jste `ls` pro vygenerování výpisu souborů."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Váš příkaz nevygeneroval správný výpis souborů. Použijte `ls` následované relativní cestou k `/home/repl/course.txt`.")
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
Nacházíš se v `/home/repl`.
Použij `ls` s **relativní** cestou
a vypiš soubor `/home/repl/seasonal/summer.csv` (a pouze ten soubor).

`@hint`
Relativní cesty *nezačínají* lomítkem '/'.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Nezavolali jste `ls` pro vygenerování výpisu souborů."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Váš příkaz nevygeneroval správný výpis souborů. Použijte `ls` následované relativní cestou k `/home/repl/seasonal/summer.csv`.")
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
Nacházíš se v `/home/repl`.
Použij `ls` s **relativní** cestou
a vypiš obsah adresáře `/home/repl/people`.

`@hint`
Relativní cesty nezačínají lomítkem '/'.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Nezavolali jste `ls` pro vygenerování výpisu souborů."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Váš příkaz nevygeneroval správný výpis souborů. Použijte `ls` následované relativní cestou k `/home/repl/people`.")
    )
)
Ex().success_msg("Výborně. Nyní, když víte, jak vypisovat soubory a adresáře, podívejme se, jak se můžete pohybovat po souborovém systému!")
```

---

## Jak se přesunout do jiného adresáře?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Stejně jako se v prohlížeči souborů přesouváš poklepáním na složky,
můžeš se v souborovém systému pohybovat příkazem `cd`
(zkratka anglického „change directory", tedy „změnit adresář").

Pokud zadáš `cd seasonal` a pak `pwd`,
shell ti oznámí, že se teď nacházíš v `/home/repl/seasonal`.
Spustíš-li pak `ls` bez argumentů,
zobrací se obsah adresáře `/home/repl/seasonal`,
protože právě tam se nacházíš.
Pokud se chceš vrátit do svého domovského adresáře `/home/repl`,
použij příkaz `cd /home/repl`.

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
Nacházíš se v `/home/repl`/.
Přesuň se do adresáře `/home/repl/seasonal` pomocí relativní cesty.

`@hint`
Pamatuj, že `cd` je zkratka pro „change directory" a že relativní cesty nezačínají lomítkem '/'.

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
key: e69c8eac15
xp: 35
```

`@instructions`
Pomocí `pwd` ověř, že se tam skutečně nacházíš.

`@hint`
Nezapomeň po zadání příkazu stisknout „Enter".

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
Spusť `ls` bez argumentů a zjisti, co se v tomto adresáři nachází.

`@hint`
Nezapomeň po zadání příkazu stisknout „Enter".

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
      has_code('ls', incorrect_msg="Váš příkaz nevygeneroval správný výstup. Použili jste `ls` bez cest pro zobrazení obsahu aktuálního adresáře?")
    )
)

Ex().success_msg("Výborně! Toto bylo o navigaci do podadresářů. Co přesun nahoru? Pojďme to zjistit!")
```

---

## Jak se přesunout o adresář výš?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

**Nadřazený** adresář je adresář ležící o úroveň výš.
Například `/home` je nadřazený adresář `/home/repl`
a `/home/repl` je nadřazený adresář `/home/repl/seasonal`.
Příkazům jako `cd` a `ls` můžeš vždy zadat absolutní cestu k nadřazenému adresáři.
Častěji ale využiješ toho, že speciální cesta `..`
(dvě tečky bez mezer) znamená „adresář nad tím, ve kterém se právě nacházím".
Pokud jsi v `/home/repl/seasonal`,
příkaz `cd ..` tě přesune do `/home/repl`.
Pokud použiješ `cd ..` ještě jednou,
okázneš se v `/home`.
Další `cd ..` tě přesune do *kořenového adresáře* `/`,
který je úplně na vrcholu souborového systému.
(Nezapomeň dát mezeru mezi `cd` a `..` – jde o příkaz a cestu, ne o jediný čtyřpísmenný příkaz.)

Samotná jednoduchá tečka, `.`, vždy znamená „aktuální adresář",
takže `ls` a `ls .` dělají totéž,
zatímco `cd .` nemá žádný efekt
(protože tě přesune do adresáře, ve kterém už jsi).

Posledním speciálním znakem je `~` (vlnovka),
která znamená „tvůj domovský adresář",
například `/home/repl`.
Kdekoli se nacházíš,
`ls ~` vždy zobrazí obsah tvého domovského adresáře
a `cd ~` tě vždy přesune domů.

<hr>
Pokud jsi v `/home/repl/seasonal`,
kam tě přesune `cd ~/../.`?

`@hint`
Sleduj cestu adresář po adresáři.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (kořenový adresář)

`@feedback`
- Ne, ale samotné `~` nebo `..` by tě tam dostalo.
- Správně! Cesta znamená „domovský adresář", „o úroveň výš", „zde".
- Ne, ale samotná `.` by to udělala.
- Ne, poslední část cesty je `.` (tedy „zde"), nikoli `..` (tedy „výš").

---

## Jak kopírovat soubory?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Soubory budeš často chtít kopírovat,
přesouvat do jiných adresářů, abys je lépe uspořádal/a,
nebo přejmenovávat.
K tomu slouží příkaz `cp`, zkratka anglického slova „copy".
Pokud soubor `original.txt` existuje,
pak příkaz:

```{shell}
cp original.txt duplicate.txt
```

vytvoří jeho kopii s názvem `duplicate.txt`.
Pokud soubor `duplicate.txt` již existoval,
bude přepsán.
Pokud je posledním parametrem příkazu `cp` existující adresář,
pak příkaz jako:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

skopíruje *všechny* uvedené soubory do tohoto adresáře.

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
Vytvoř kopii souboru `seasonal/summer.csv` v adresáři `backup` (který se také nachází v `/home/repl`)
a pojmenuj nový soubor `summer.bck`.

`@hint`
Spoj název cílového adresáře s názvem kopírovaného souboru
a vytvoř tak relativní cestu k novému souboru.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` se zdá, že neexistuje v adresáři `backup`. Zadejte dvě cesty k příkazu `cp`: existující soubor (`seasonal/summer.csv`) a cílový soubor (`backup/summer.bck`)."),
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
Zkopíruj soubory `spring.csv` a `summer.csv` z adresáře `seasonal` do adresáře `backup`
*bez* změny aktuálního pracovního adresáře (`/home/repl`).

`@hint`
Použij `cp` s názvy souborů, které chceš zkopírovat,
a *pak* uveď název adresáře, do kterého je chceš zkopírovat.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` nebyl zkopírován do adresáře `backup`. Zadejte příkazu `cp` dva názvy souborů a název adresáře."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Ujistěte se, že kopírujete soubory v adresáři `{{dir}}`! Použijte příkaz `cd {{dir}}` pro návrat zpět."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Výborně. Kromě kopírování bychom také měli být schopni přesouvat soubory z jednoho adresáře do druhého. Dozvíte se o tom v následujícím cvičení!")
```

---

## Jak přesunout soubor?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Zatímco `cp` soubor kopíruje,
`mv` ho přesune z jednoho adresáře do druhého –
stejně jako kdybys ho přetáhl/a v grafickém správci souborů.
Parametry fungují stejně jako u `cp`,
takže příkaz:

```{shell}
mv autumn.csv winter.csv ..
```

přesune soubory `autumn.csv` a `winter.csv` z aktuálního pracovního adresáře
o úroveň výš do nadřazeného adresáře
(protože `..` vždy odkazuje na adresář nad tvou aktuální polohou).

`@instructions`
Nacházíš se v `/home/repl`, který obsahuje podadresáře `seasonal` a `backup`.
Jedním příkazem přesuň soubory `spring.csv` a `summer.csv` z adresáře `seasonal` do adresáře `backup`.

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
backup_patt="Soubor `%s` se nenachází v adresáři `backup`. Použili jste příkaz `mv` správně? Jako parametry příkazu `mv` použijte dva názvy souborů a adresář."
seasonal_patt="Soubor `%s` se stále nachází v adresáři `seasonal`. Ujistěte se, že soubory přesouváte pomocí příkazu `mv`, nikoli kopírujete pomocí příkazu `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Výborně, pokračujme dále!")
```

---

## Jak přejmenovat soubory?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` lze také použít k přejmenování souborů. Pokud spustíš:

```{shell}
mv course.txt old-course.txt
```

soubor `course.txt` v aktuálním pracovním adresáři se „přesune" do souboru `old-course.txt`.
To se liší od způsobu, jakým fungují správci souborů,
ale často se to hodí.

Jedno upozornění:
stejně jako `cp`
i `mv` přepíše existující soubory.
Pokud například
already máš soubor s názvem `old-course.txt`,
příkaz uvedený výše ho nahradí obsahem souboru `course.txt`.

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
Přejdi do adresáře `seasonal`.

`@hint`
Pamatuj, že `cd` znamená „change directory" a že relativní cesty nezačínají lomítkem '/'.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
Přejmenuj soubor `winter.csv` na `winter.csv.bck`.

`@hint`
Použij `mv` se stávajícím názvem souboru a požadovaným názvem – v tomto pořadí.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Použijte `mv` se dvěma argumenty: soubor, který chcete přejmenovat (`winter.csv`), a nový název souboru (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Očekávali jsme, že `winter.csv.bck` bude nalezen v adresáři." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Již jsme neočekávali, že `winter.csv` bude v adresáři." + hint)
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
Spusť `ls` a ověř, že vše proběhlo správně.

`@hint`
Nezapomeň stisknout Enter, aby se příkaz spustil.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Použili jste `ls` k zobrazení obsahu aktuálního pracovního adresáře?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Váš příkaz nevygeneroval správný výpis souborů. Použijte `ls` bez argumentů k zobrazení obsahu aktuálního pracovního adresáře.")
    )
)
Ex().success_msg("Kopírování, přesouvání, přejmenování – to vše již ovládáte! Jako další přijde na řadu: mazání souborů.")
```

---

## Jak mazat soubory?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Soubory umíme kopírovat i přesouvat;
pro jejich smazání slouží příkaz `rm`,
který je zkratkou anglického "remove" (odebrat).
Stejně jako u `cp` a `mv`
můžeš příkazu `rm` předat najednou libovolný počet souborů:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

Tento příkaz smaže jak `thesis.txt`, tak `backup/thesis-2017-08.txt`.

`rm` dělá přesně to, co říká jeho název,
a udělá to okamžitě:
na rozdíl od grafických správců souborů
shell nemá koš,
takže jakmile příkaz zadáš,
soubor je nenávratně pryč.

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
Nacházíš se v `/home/repl`.
Přejdi do adresáře `seasonal`.

`@hint`
Nezapomeň, že `cd` je zkratka pro "change directory" a že relativní cesta nezačíná lomítkem '/'.

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
Smaž soubor `autumn.csv`.

`@hint`
Nezapomeň, že `rm` je zkratka pro "remove".

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Neočekávali jsme, že `autumn.csv` bude stále v adresáři `seasonal`. Použijte `rm` s cestou k souboru, který chcete odstranit."),
    has_code('rm', incorrect_msg = 'Použijte `rm` k odstranění souboru, nikoli k jeho přesunutí.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Vrať se do svého domovského adresáře.

`@hint`
Pokud zadáš `cd` bez jakékoli cesty, přesune tě do domovského adresáře.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Použijte `cd ..` nebo `cd ~` pro návrat do domovského adresáře.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Smaž soubor `seasonal/summer.csv` bez toho, aby ses znovu přepínal/a do jiného adresáře.

`@hint`
Nezapomeň, že `rm` je zkratka pro "remove".

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Neočekávali jsme, že `summer.csv` bude stále v adresáři `seasonal`. Použijte `rm` s cestou k souboru, který chcete odstranit."),
    has_code('rm', incorrect_msg = 'Použijte `rm` k odstranění souboru, nikoli k jeho přesunutí.')
)
Ex().success_msg("Výborně! Přejdeme na další!")
```

---

## Jak vytvářet a mazat adresáře?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` pracuje s adresáři stejně jako se soubory:
když jsi v domovském adresáři a spustíš příkaz `mv seasonal by-season`,
`mv` přejmenuje adresář `seasonal` na `by-season`.
Jinak je to ale s příkazem `rm`.

Pokud se pokusíš smazat adresář pomocí `rm`,
shell vypíše chybovou zprávu, že to takto nejde –
hlavně proto, aby ses omylem nepřipravil/a o celý adresář plný práce.
Místo toho slouží speciální příkaz `rmdir`.
Pro větší bezpečnost funguje pouze na prázdných adresářích,
takže musíš soubory v adresáři smazat *dříve*, než smažeš adresář samotný.
(Zkušenější uživatelé mohou použít přepínač `-r` u příkazu `rm` pro stejný výsledek;
k přepínačům příkazů se dostaneme v příští kapitole.)

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
Bez přechodu do jiného adresáře
smaž soubor `agarwal.txt` v adresáři `people`.

`@hint`
Pamatuj, že `rm` je zkratka pro „remove" (odebrat) a že relativní cesta nezačíná lomítkem '/'.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` by již neměl být v `/home/repl/people`. Použili jste `rm` správně?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'V adresáři `people` se stále nacházejí soubory. Pokud jste `agarwal.txt` pouze přesunuli nebo vytvořili nové soubory, odstraňte je všechny.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Teď, když je adresář `people` prázdný,
smaž ho jediným příkazem.

`@hint`
Pamatuj, že `rm` funguje pouze na souborech.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "Adresář 'people' by se již neměl nacházet ve vašem domovském adresáři. Použijte příkaz `rmdir` k jeho odstranění!")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Adresář není soubor,
proto pro jeho vytvoření použij příkaz `mkdir directory_name`.
Vytvoř tímto příkazem nový (prázdný) adresář s názvem `yearly` ve svém domovském adresáři.

`@hint`
Spusť `mkdir` s názvem adresáře, který chceš vytvořit.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Ve vašem domovském adresáři neexistuje adresář `yearly`. Použijte `mkdir yearly` pro jeho vytvoření!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Teď, když `yearly` existuje,
vytvoř uvnitř něj další adresář s názvem `2017`
*bez* opuštění domovského adresáře.

`@hint`
Pro podadresář, který chceš vytvořit, použij relativní cestu.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Adresář '2017' nebyl nalezen v '/home/repl/yearly'. Tento adresář můžete vytvořit pomocí relativní cesty `yearly/2017`.")
)
Ex().success_msg("Skvěle! Zakončeme tuto kapitolu cvičením, které zopakuje některé její koncepty!")
```

---

## Závěrečné shrnutí

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Při analýze dat často vznikají mezilehlé soubory.
Místo ukládání do domovského adresáře
je můžeš ukládat do `/tmp`,
kde lidé i programy běžně uchovávají soubory, které potřebují jen dočasně.
(Pozor: `/tmp` je přímo pod kořenovým adresářem `/`,
*ne* pod tvým domovským adresářem.)
Toto závěrečné cvičení ti ukáže, jak na to.

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
Pomocí `cd` přejdi do `/tmp`.

`@hint`
Pamatuj, že `cd` znamená „change directory" (přejít do adresáře) a že absolutní cesta začíná znakem '/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Nacházíte se ve špatném adresáři. Použijte `cd` pro přechod do adresáře `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Vypiš obsah `/tmp` *bez* zadání názvu adresáře.

`@hint`
Pokud příkazu `ls` nezadáš žádný adresář, zobrazí obsah aktuálního adresáře.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Nezavolali jste `ls` pro vytvoření výpisu souborů."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Váš příkaz nevygeneroval správný výpis souborů. Použijte `ls` bez`.")
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
Uvnitř `/tmp` vytvoř nový adresář s názvem `scratch`.

`@hint`
Pro vytvoření adresáře použij příkaz `mkdir`.

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
      has_code('mkdir +scratch', incorrect_msg="Nelze najít adresář 'scratch' v '/tmp'. Ujistěte se, že používáte příkaz `mkdir` správně.")
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
Přesuň soubor `/home/repl/people/agarwal.txt` do `/tmp/scratch`.
Doporučujeme použít zkratku `~` pro domovský adresář a pro druhý argument použít relativní cestu místo absolutní.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Soubor 'agarwal.txt' nelze najít v '/tmp/scratch'. Použijte příkaz `mv` s parametrem `~/people/agarwal.txt` jako prvním argumentem a `scratch` jako druhým.")
)
Ex().success_msg("Tím končí 1. kapitola kurzu Úvod do shellu! Přejděte na další kapitolu a dozvíte se více o manipulaci s daty!")
```

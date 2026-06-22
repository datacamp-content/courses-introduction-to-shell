---
title: Створення нових інструментів
description: >-
  Історія команд дає змогу повторювати дії кількома натисканнями клавіш, а
  конвеєри дозволяють поєднувати наявні команди, створюючи нові. У цьому розділі
  ви підете ще далі й створите власні команди.
lessons:
  - nb_of_exercises: 9
    title: Як редагувати файл?
---

## Як редагувати файл?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

У Unix є вражаюче різноманіття текстових редакторів.
У цьому курсі
ми скористаємося простим редактором під назвою Nano.
Якщо ви наберете `nano filename`,
він відкриє `filename` для редагування
(або створить його, якщо файла ще не існує).
Переміщуйтеся стрілками,
видаляйте символи клавішею Backspace,
а інші дії виконуйте поєднаннями з клавішею Ctrl:

- `Ctrl` + `K`: видалити рядок.
- `Ctrl` + `U`: повернути видалений рядок.
- `Ctrl` + `O`: зберегти файл ("O" означає "output"). _Вам також потрібно натиснути Enter, щоб підтвердити ім'я файла!_
- `Ctrl` + `X`: вийти з редактора.

`@instructions`
Запустіть `nano names.txt`, щоб відредагувати новий файл у вашому домашньому каталозі,
і введіть такі чотири рядки:

```
Lovelace
Hopper
Johnson
Wilson
```

Щоб зберегти написане,
натисніть `Ctrl` + `O`, щоб записати файл,
потім Enter, щоб підтвердити ім'я файла,
потім `Ctrl` + `X`, щоб вийти з редактора.

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
patt = "Чи включили Ви рядок `%s` у файл `names.txt`? Використовуйте `nano names.txt` знову, щоб оновити свій файл. Використовуйте `Ctrl` + `O`, щоб зберегти, і `Ctrl` + `X`, щоб вийти."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Чудово! Переходимо до наступного завдання!")
```

---

## Як зафіксувати те, що я щойно зробив?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Коли ви виконуєте складний аналіз,
часто потрібно зберегти перелік команд, які ви використовували.
Це можна зробити за допомогою інструментів, які ви вже бачили:

1. Запустіть `history`.
2. Передайте його результат у `tail -n 10` (або стільки останніх кроків, скільки хочете зберегти).
3. Перенаправте це у файл із назвою на кшталт `figure-5.history`.

Це краще, ніж записувати все в лабораторний зошит,
бо так ви гарантовано не пропустите жодного кроку.
Це також ілюструє центральну ідею оболонки:
простi інструменти, які створюють і споживають рядки тексту,
можна поєднувати у найрізноманітніші способи,
щоб розв'язувати широкий спектр завдань.

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
Скопіюйте файли `seasonal/spring.csv` і `seasonal/summer.csv` до вашого домашнього каталогу.

`@hint`
Скористайтеся `cp` для копіювання і `~` як скорочення шляху до вашого домашнього каталогу.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Ви використали `cp seasonal/s* ~`, щоб скопіювати необхідні файли до вашого домашнього каталогу?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Вражаюче ведення записів! Якщо Ви неправильно ввели будь-які команди, Ви завжди можете використовувати `nano`, щоб очистити файл історії збережень пізніше.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Використайте `grep` із прапорцем `-h` (щоб він не друкував назви файлів)
і `-v Tooth` (щоб вибрати рядки, які не збігаються з рядком заголовка),
щоб отримати записи даних із `spring.csv` та `summer.csv` у такому порядку
і перенаправити результат у `temp.csv`.

`@hint`
Розташуйте прапорці перед назвами файлів.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Переконайтеся, що ви перенаправляєте вивід команди `grep` до `temp.csv` за допомогою `>`!"
msg2 = "Чи використовували ви `grep -h -v ___ ___ ___` (заповніть пропуски) для заповнення `temp.csv`?"
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
Передайте `history` через конвеєр у `tail -n 3`
і перенаправте результат у `steps.txt`,
щоб зберегти останні три команди у файл.
(Потрібно зберегти три, а не дві,
оскільки сама команда `history` теж буде в списку.)

`@hint`
Пам'ятайте, що перенаправлення за допомогою `>` стоїть наприкінці послідовності команд, з'єднаних через конвеєр.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Переконайтеся, що перенаправили вивід вашої команди до `steps.txt`."
msg2="Чи використовували Ви `history | tail ___ ___` (заповніть пропуски), щоб заповнити `steps.txt`?"
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
Ex().success_msg("Чудова робота! Давайте підвищимо рівень!")
```

---

## Як зберегти команди, щоб запускати їх пізніше?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Дотепер ви працювали з оболонкою інтерактивно.
Але оскільки команди, які ви вводите, — це просто текст,
їх можна зберігати у файлах, щоб оболонка виконувала їх знову і знову.
Щоб почати досліджувати цю потужну можливість,
помістіть таку команду у файл з назвою `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Ця команда вибирає перший рядок з кожного CSV-файла в каталозі `seasonal`.
Щойно ви створите цей файл,
його можна запустити, ввівши:

```{shell}
bash headers.sh
```

Це вказує оболонці (яка є просто програмою під назвою `bash`)
виконати команди, що містяться у файлі `headers.sh`,
і це дає такий самий результат, як і безпосередній запуск команд.

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
Використайте `nano dates.sh`, щоб створити файл `dates.sh`,
який містить таку команду:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

щоб видобути перший стовпець з усіх CSV-файлів у `seasonal`.

`@hint`
Розмістіть наведені команди у файлі без зайвих порожніх рядків чи пробілів.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Чи включили Ви рядок `cut -d , -f 1 seasonal/*.csv` у файл `dates.sh`? Використовуйте `nano dates.sh` знову, щоб оновити Ваш файл. Використовуйте `Ctrl` + `O` для збереження і `Ctrl` + `X` для виходу."
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
Скористайтеся `bash`, щоб запустити файл `dates.sh`.

`@hint`
Скористайтеся `bash filename`, щоб запустити файл.

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
      has_code("bash", incorrect_msg = 'Ви викликали `bash`?'),
      has_code("dates.sh", incorrect_msg = 'Ви вказали файл `dates.sh`?')
    )
  )
)
```

---

## Як можна повторно використовувати конвеєри (pipes)?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Файл із набором команд оболонки називається ***скриптом оболонки**,
або коротко «скриптом». Скрипти не обов'язково мають закінчуватися на `.sh`,
але в цьому уроці ми дотримуватимемося такої домовленості,
щоб вам було легше відстежувати, які файли є скриптами.

Скрипти також можуть містити конвеєри.
Наприклад,
якщо `all-dates.sh` містить такий рядок:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

тоді:

```{shell}
bash all-dates.sh > dates.out
```

вибере унікальні дати з сезонних файлів даних
і збереже їх у `dates.out`.

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
Файл `teeth.sh` у вашому домашньому каталозі вже підготовлено, але в ньому є пропуски.
Використайте Nano, щоб відредагувати файл і замінити два заповнювачі `____`
на `seasonal/*.csv` і `-c`, щоб цей скрипт виводив підрахунок
кількості появ кожної назви зуба у CSV‑файлах у каталозі `seasonal`.

`@hint`
Скористайтеся `nano teeth.sh`, щоб відредагувати файл.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Чи замінили Ви пропуски належним чином, щоб команда в `teeth.sh` виглядала як `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Використайте `nano teeth.sh` знову, щоб внести необхідні зміни."
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
Використайте `bash`, щоб запустити `teeth.sh`, і `>`, щоб перенаправити його вивід до `teeth.out`.

`@hint`
Пам'ятайте, що `> teeth.out` має стояти ПІСЛЯ команди, яка продукує вивід.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Чи правильно Ви перенаправили результат виконання `bash teeth.sh` у `teeth.out` за допомогою `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Чи викликали Ви `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Чи запустили Ви файл `teeth.sh`?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Чи перенаправили Ви у файл `teeth.out`?')
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
Запустіть `cat teeth.out`, щоб переглянути результати.

`@hint`
Пам'ятайте: ви можете ввести перші кілька символів назви файлу, а потім натиснути Tab для автодоповнення.

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
      has_code("cat", incorrect_msg = 'Ви викликали `cat`?'),
      has_code("teeth.out", incorrect_msg = 'Ви вказали файл `teeth.out`?')
    )
  )
)
Ex().success_msg("Чудово! Спочатку все це може здаватися надуманим, але гарна річ у тому, що Ви автоматизуєте частини свого робочого процесу крок за кроком. Це дуже стане в нагоді як науковцю з даних!")
```

---

## Як передавати імена файлів у скрипти?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Скрипт, який обробляє конкретні файли, корисний як запис того, що ви зробили, але ще корисніший — той, що дає змогу обробляти будь‑які потрібні файли.
Щоб це підтримати,
можна використати спеціальний вираз `$@` (знак долара одразу за яким стоїть «@»),
який означає «усі параметри командного рядка, передані скрипту».

Наприклад, якщо у `unique-lines.sh` є `sort $@ | uniq`, і ви запускаєте:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

оболонка замінює `$@` на `seasonal/summer.csv` і обробляє один файл. Якщо ви запустите:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

буде оброблено два файли даних і так далі.

_На згадку: щоб зберегти написане в Nano, натисніть `Ctrl` + `O`, щоб записати файл, потім Enter, щоб підтвердити назву файлу, і `Ctrl` + `X`, щоб вийти з редактора._

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
Відредагуйте скрипт `count-records.sh` у Nano і заповніть два заповнювачі `____`
відповідно `\$@` та `-l` (_літера_), щоб він рахував кількість рядків в одному або кількох файлах,
виключаючи перший рядок у кожному.

`@hint`
* Використайте `nano count-records.sh`, щоб відредагувати назву файлу.
* Переконайтеся, що вказуєте _літеру_ `-l`, а не цифру один.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Чи замінили Ви пропуски належним чином, щоб команда в `count-records.sh` виглядала як `tail -q -n +2 $@ | wc -l`? Використайте `nano count-records.sh` знову, щоб внести необхідні зміни."
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
Запустіть `count-records.sh` на `seasonal/*.csv`
і перенаправте вивід до `num-records.out` за допомогою `>`.

`@hint`
Скористайтеся `>` для перенаправлення виводу.

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
      has_code("bash", incorrect_msg = 'Чи викликали Ви `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Чи запустили Ви файл `count-records.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Чи вказали Ви файли для обробки за допомогою `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Чи перенаправили Ви в файл `num-records.out`?')
    )
  )
)
Ex().success_msg("Чудова робота! Ваша майстерність роботи з оболонкою постійно зростає!")
```

---

## Як обробити один аргумент?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Окрім `$@`,
оболонка дає змогу використовувати `$1`, `$2` тощо, щоб посилатися на конкретні параметри командного рядка.
Це допомагає писати команди, які здаються простішими або природнішими, ніж у самій оболонці.
Наприклад,
ви можете створити скрипт `column.sh`, який вибирає один стовпець із файла CSV,
якщо користувач передає ім'я файла першим параметром, а номер стовпця — другим:

```{shell}
cut -d , -f $2 $1
```

а потім запустити його так:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Зверніть увагу, що у скрипті ці два параметри використано у зворотному порядку.

<hr>

Скрипт `get-field.sh` має приймати ім'я файла,
номер рядка для вибірки,
номер стовпця для вибірки
і виводити лише це поле з файла CSV.
Наприклад:

```
bash get-field.sh seasonal/summer.csv 4 2
```

має вибрати друге поле з 4-го рядка файла `seasonal/summer.csv`.
Яку з наведених команд слід помістити в `get-field.sh`, щоб це зробити?

`@hint`
Пам'ятайте, що параметри командного рядка нумеруються зліва направо.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Ні: так ви спробуєте використати ім'я файла як кількість рядків для вибірки за допомогою `head`.
- Правильно!
- Ні: так ви спробуєте використати номер стовпця як номер рядка і навпаки.
- Ні: так буде використано номер поля як ім'я файла і навпаки.

---

## Як один shell-скрипт може виконувати багато дій?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Наші shell-скрипти дотепер мали одну команду або пайп, але скрипт може містити багато рядків команд. Наприклад, ви можете створити скрипт, який покаже, скільки записів у найкоротшому та найдовшому з ваших файлів даних, тобто діапазон довжин ваших наборів даних.

Зауважте, що в Nano «копіювання та вставлення» виконується так: перейдіть до рядка, який хочете скопіювати, натисніть `CTRL` + `K`, щоб вирізати рядок, а потім двічі `CTRL` + `U`, щоб вставити дві його копії.

_Нагадування: щоб зберегти написане в Nano, натисніть `Ctrl` + `O`, щоб записати файл, потім Enter, щоб підтвердити назву файлу, і `Ctrl` + `X`, щоб вийти з редактора._

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
Скористайтеся Nano, щоб відредагувати скрипт `range.sh`
і замінити два заповнювачі `____`
на `$@` і `-v`,
щоб перелічити назви та кількість рядків в усіх файлах, переданих у командному рядку,
і *не* показувати загальну кількість рядків у всіх файлах.
(Не намагайтеся віднімати рядки заголовків стовпчиків із файлів.)

`@hint`
Використайте `wc -l $@`, щоб порахувати рядки в усіх файлах, переданих у командному рядку.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Чи замінили Ви пропуски належним чином, щоб команда в `range.sh` виглядала як `wc -l $@ | grep -v total`? Використайте `nano range.sh` знову, щоб внести необхідні зміни."
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
Знову скористайтеся Nano, щоб додати `sort -n` і `head -n 1` у такому порядку
до пайплайна в `range.sh`,
щоб показати назву та кількість рядків у найкоротшому переданому файлі.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Чи додали Ви `sort -n` та `head -n 1` з конвеєрами до файлу `range.sh`? Використайте `nano range.sh` знову, щоб внести необхідні зміни."
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
Знову в Nano додайте другий рядок до `range.sh`, щоб вивести назву та кількість записів
для *найдовшого* файла в каталозі *а також* для найкоротшого.
Цей рядок має дублювати вже написаний вами,
але з `sort -n -r` замість `sort -n`.

`@hint`
Скопіюйте перший рядок і змініть порядок сортування.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Залиште перший рядок у файлі `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Ви дублювали перший рядок у `range.sh` і внесли невелику зміну? `sort -n -r` замість `sort -n`!"
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
Запустіть скрипт на файлах у каталозі `seasonal`,
використовуючи `seasonal/*.csv`, щоб охопити всі файли,
та переспрямуйте вивід за допомогою `>`
до файла з назвою `range.out` у вашому домашньому каталозі.

`@hint`
Скористайтеся `bash range.sh`, щоб запустити скрипт, `seasonal/*.csv`, щоб вказати файли, і `> range.out`, щоб переспрямувати вивід.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Чи правильно Ви перенаправили результат `bash range.sh seasonal/*.csv` до `range.out` за допомогою `>`?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Ви викликали `bash`?'),
has_code("bash\s+range.sh", incorrect_msg = 'Ви запустили файл `range.sh`?'),
has_code("seasonal/\*", incorrect_msg = 'Ви вказали файли для обробки за допомогою `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = 'Ви перенаправили до файлу `range.out`?')
)
)

Ex().success_msg("Все йде добре. Перейдіть до наступної вправи, щоб дізнатися про написання циклів!")
```

---

## Як писати цикли в shell-скрипті?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shell-скрипти також можуть містити цикли. Їх можна записувати через крапку з комою або розбивати на кілька рядків без крапок з комою, щоб зробити читання зручнішим:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Не обов'язково робити відступи для команд усередині циклу, але це робить код зрозумілішим.)

Перший рядок цього скрипту — це **коментар**, який пояснює, що робить скрипт. Коментарі починаються з символу `#` і тягнуться до кінця рядка. Ваше майбутнє «ви» подякує за короткі пояснення на кшталт цього в кожному скрипті, який ви пишете.

_Нагадаємо: щоб зберегти написане в Nano, натисніть `Ctrl` + `O`, щоб записати файл, потім Enter, щоб підтвердити ім'я файлу, і `Ctrl` + `X`, щоб вийти з редактора._

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
Заповніть пропуски у скрипті `date-range.sh`
вставивши `$filename` (двічі), `head` і `tail`,
щоб він виводив першу і останню дату з одного або кількох файлів.

`@hint`
Пам'ятайте використовувати `$filename`, щоб отримати поточне значення змінної циклу.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="У файлі `date-range.sh` Ви змінили рядок %s у циклі на `%s`? Використовуйте `nano date-range.sh` для внесення змін."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('перший', cmdpatt%'head')
msg2=msgpatt%('другий', cmdpatt%'tail')
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
Запустіть `date-range.sh` для всіх чотирьох сезонних файлів даних,
використавши `seasonal/*.csv`, щоб підібрати їхні назви.

`@hint`
Шаблон з підстановним символом має починатися з назви каталогу.

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
      has_code("bash", incorrect_msg = 'Ви викликали `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Ви запустили файл `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Ви вказали файли для обробки за допомогою `seasonal/*`?')
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
Запустіть `date-range.sh` для всіх чотирьох сезонних файлів даних, використавши `seasonal/*.csv` для відповідності їхнім назвам,
і передайте його вивід через конвеєр до `sort`, щоб переконатися, що ваші скрипти можна використовувати так само, як і вбудовані команди Unix.

`@hint`
Використайте той самий шаблон з підстановним символом, що й раніше.

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
      has_code("bash", incorrect_msg = 'Чи викликали Ви `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Чи запустили Ви файл `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Чи вказали Ви файли для обробки за допомогою `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Чи передали Ви дані з виходу скрипта до `sort`?'),
      has_code("sort", incorrect_msg = 'Чи викликали Ви `sort`?')
    )
  )
)
Ex().success_msg("Чудово! Зверніть увагу, наскільки всі вивчені речі є взаємозамінними.")
```

---

## Що станеться, якщо не вказати назви файлів?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Поширена помилка у shell-скриптах (і інтерактивних командах) — поставити назви файлів не на своє місце.
Якщо ви введете:

```{shell}
tail -n 3
```

то, оскільки `tail` не отримав жодної назви файла,
він чекатиме на введення з клавіатури.
Це означає, що якщо ви наберете:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

то `tail` просто виведе останні три рядки з `somefile.txt`,
а `head` безкінечно чекатиме на введення з клавіатури,
оскільки йому не передали назву файла і перед ним у конвеєрі нічого немає.

<hr>

Припустімо, ви випадково ввели:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Що слід зробити далі?

`@possible_answers`
- Почекайте 10 секунд, поки `head` не завершиться за тайм-аутом.
- Введіть `somefile.txt` і натисніть Enter, щоб подати `head` якийсь вхід.
- Натисніть `Ctrl` + `C`, щоб зупинити запущену програму `head`.

`@hint`
Що робить `head`, якщо йому не передали назву файла і перед ним у конвеєрі нічого немає?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Ні, команди не завершаться за часом.'
a2 = 'Ні, це передасть `head` текст `somefile.txt` для обробки, але потім він зависне, очікуючи на додаткове введення.'
a3 = "Так! Ви повинні використовувати `Ctrl` + `C`, щоб зупинити програму, що виконується. Це завершує цей вступний курс! Якщо ви зацікавлені у вивченні інших інструментів командного рядка, ми настійно рекомендуємо пройти наш безкоштовний вступний курс з Git!"
Ex().has_chosen(3, [a1, a2, a3])
```

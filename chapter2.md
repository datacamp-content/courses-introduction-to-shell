---
title: Опрацювання даних
description: >-
  Команди з попереднього розділу давали змогу переміщувати об'єкти у файловій
  системі. У цьому розділі ви навчитеся працювати з даними у цих файлах.
  Інструменти, які ми використаємо, досить прості, проте це надійні будівельні
  блоки.
lessons:
  - nb_of_exercises: 12
    title: Як переглянути вміст файла?
---

## Як переглянути вміст файла?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Перш ніж перейменовувати або видаляти файли,
можете спершу переглянути їхній вміст.
Найпростіший спосіб зробити це — скористатися `cat`,
яка просто виводить вміст файлів на екран.
(Її назва — скорочення від "concatenate", тобто «об'єднати»,
адже вона виведе всі файли, імена яких ви їй передасте, один за одним.)

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
Виведіть на екран вміст файла `course.txt`.

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
    has_expr_output(incorrect_msg="Ваша команда не створила правильний вивід. Ви використали `cat`, за яким слідує назва файлу, `course.txt`?")
)
Ex().success_msg("Чудово! Давайте розглянемо інші способи перегляду вмісту файлу.")
```

---

## Як переглядати вміст файла частинами?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Ви можете використовувати `cat`, щоб виводити великі файли й прокручувати результат,
але зазвичай зручніше **гортати** вивід посторінково.
Початкову команду для цього назвали `more`,
але згодом її замінила потужніша команда `less`.
(Такі назви — своєрідний гумор у світі Unix.)
Коли ви застосовуєте `less` до файла,
вміст показується по одній сторінці;
натискайте пробіл, щоб переглянути наступну сторінку, або введіть `q`, щоб вийти.

Якщо передати `less` імена кількох файлів,
введіть `:n` (двокрапка і мала літера «n»), щоб перейти до наступного файла,
`:p`, щоб повернутися до попереднього,
або `:q`, щоб вийти.

Примітка: Якщо ви переглядаєте розв'язки вправ, де використовується `less`,
в кінці буде додано ще одну команду, яка вимикає посторінковий режим,
щоб ми могли ефективно тестувати ваші розв'язки.

`@instructions`
Використайте `less seasonal/spring.csv seasonal/summer.csv`, щоб переглянути ці два файли саме в такому порядку.
Натискайте пробіл, щоб гортати сторінки вниз, `:n`, щоб перейти до другого файла, і `:q`, щоб вийти.

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
                 incorrect_msg='Використовуйте `less` та імена файлів. Пам\'ятайте, що `:n` переміщує вас до наступного файлу.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Як переглянути початок файла?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Перше, що зазвичай роблять дата-сайєнтисти, отримавши новий набір даних для аналізу, — з'ясовують, які поля він містить і які значення мають ці поля.
Якщо набір даних експортували з бази даних або електронної таблиці,
його часто зберігають як **значення, розділені комами** (CSV).
Швидкий спосіб зрозуміти, що всередині, — подивитися на перші кілька рядків.

У shell це можна зробити командою `head`.
Як підказує назва,
вона виводить перші кілька рядків файла
(де «кілька» означає 10),
тож команда:

```{shell}
head seasonal/summer.csv
```

відображає:

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

Що робить `head`, якщо у файлі менше ніж 10 рядків?
(Щоб дізнатися, перегляньте верхню частину `people/agarwal.txt`.)

`@possible_answers`
- Вивести повідомлення про помилку, бо файл закороткий.
- Відобразити стільки рядків, скільки є.
- Відобразити достатньо порожніх рядків, щоб разом було 10.

`@hint`
Яку найкориснішу річ ця команда могла б зробити?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Неправильно: це не найкорисніше, що він міг би зробити.",
                    "Правильно!",
                    "Неправильно: це було б неможливо відрізнити від файлу, який закінчується купою порожніх рядків."])
```

---

## Як набирати менше?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Одним із потужних інструментів оболонки є **доповнення за табуляцією**.
Якщо ви почнете вводити назву файла, а потім натиснете клавішу Tab,
оболонка спробує автоматично доповнити шлях.
Наприклад,
якщо ви введете `sea` і натиснете Tab,
вона підставить назву каталогу `seasonal/` (із завершальним слешем).
Далі, якщо ви наберете `a` і натиснете Tab,
шлях буде доповнено до `seasonal/autumn.csv`.

Якщо шлях неоднозначний,
наприклад `seasonal/s`,
повторне натискання Tab покаже список можливих варіантів.
Наберіть ще один-два символи, щоб зробити шлях конкретнішим,
а тоді натисніть Tab,
і оболонка заповнить решту назви.

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
Запустіть `head seasonal/autumn.csv`, не вводячи повну назву файла.

`@hint`
Введіть стільки шляху, скільки потрібно, натисніть Tab і повторіть за потреби.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Перевіряючий не зміг знайти правильний результат у вашій команді. Ви впевнені, що викликали `head` на `seasonal/autumn.csv`?")
)

```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Запустіть `head seasonal/spring.csv`, не вводячи повну назву файла.

`@hint`
Введіть стільки шляху, скільки потрібно, натисніть Tab і повторіть за потреби.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Перевірка не змогла знайти правильний результат у вашій команді. Ви впевнені, що викликали `head` на `seasonal/spring.csv`?")
)
Ex().success_msg("Гарна робота! Як тільки ви звикнете використовувати автозаповнення, це заощадить вам багато часу!")
```

---

## Як керувати тим, що роблять команди?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Вам не завжди потрібно переглядати перші 10 рядків файла,
тому оболонка дає змогу змінити поведінку `head`,
передавши їй **прапорець командного рядка** (скорочено — «прапорець»).
Якщо ви запустите команду:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` покаже лише перші три рядки файла.
Якщо запустити `head -n 100`,
вона виведе перші 100 (якщо стільки є),
і так далі.

Назва прапорця зазвичай підказує його призначення
(наприклад, `-n` означає «кількість рядків» — від "**n**umber of lines").
Прапорці команд не обов'язково мають бути у вигляді `-` плюс одна літера,
але це дуже поширена домовленість.

Зауваження: вважається гарним стилем розміщувати всі прапорці *перед* назвами файлів,
тож у цьому курсі
ми приймаємо лише такі відповіді.

`@instructions`
Виведіть перші 5 рядків файла `winter.csv` у каталозі `seasonal`.

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
        has_expr_output(incorrect_msg="Ви впевнені, що викликаєте `head` для файлу `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Ви впевнені, що використали прапорець `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Ви впевнені, що використали прапорець `-n 5`?")
)
Ex().success_msg("Чудово! За допомогою цієї техніки ви можете уникнути перевантаження вашої оболонки, якщо захочете переглянути великі текстові файли.")
```

---

## Як перелічити все вміст каталогу рекурсивно?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Щоб побачити все, що міститься всередині каталогу,
незалежно від глибини вкладеності,
ви можете передати `ls` прапорець `-R`
(означає «recursive» — рекурсивно).
Якщо запустити `ls -R` у вашому домашньому каталозі,
ви побачите приблизно таке:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Тут спершу показано всі файли й каталоги на поточному рівні,
далі — в кожному підкаталозі,
і так далі.

`@instructions`
Щоб легше розрізняти об'єкти,
`ls` має ще один прапорець `-F`, який додає `/` після назви кожного каталогу
та `*` після назви кожної програми, яку можна виконати.
Запустіть `ls` з двома прапорцями, `-R` і `-F`, і з абсолютним шляхом до вашого домашнього каталогу,
щоб побачити весь його вміст.
(Порядок прапорців не має значення, але назва каталогу має бути останньою.)

`@hint`
Ваш домашній каталог можна вказати за допомогою `~` або `.` або його абсолютного шляху.

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
  has_expr_output(incorrect_msg='Використовуйте або `ls -R -F`, або `ls -F -R` і шлях `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Використовуйте або `ls -R -F`, або `ls -F -R` і шлях `/home/repl`.')
)
Ex().success_msg("Це досить акуратний огляд, чи не так?")
```

---

## Як отримати довідку щодо команди?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Щоб дізнатися, що робить команда,
раніше користувалися командою `man`
(скорочення від «manual», тобто «посібник»).
Наприклад,
команда `man head` відкриває таку інформацію:

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

`man` автоматично запускає `less`,
тому, можливо, доведеться натискати пробіл, щоб перегортати сторінки,
а щоб вийти — ввести `:q`.

Однорядковий опис у розділі `NAME` коротко пояснює призначення команди,
а зведення в `SYNOPSIS` перелічує всі доступні прапорці.
Усе необов'язкове подано в квадратних дужках `[...]`,
альтернативи «або/або» розділено символом `|`,
а те, що може повторюватися, позначено `...`,
тож довідка для `head` повідомляє, що ви можете або задати кількість рядків через `-n`,
або кількість байтів через `-c`,
і що можна передати будь-яку кількість назв файлів.

Проблема з посібником Unix у тому, що потрібно знати, що саме шукати.
Якщо ні —
шукайте на [Stack Overflow](https://stackoverflow.com/),
ставте запитання в Slack-каналах DataCamp
або перегляньте розділи `SEE ALSO` в командах, які ви вже знаєте.

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
Прочитайте сторінку посібника для команди `tail`, щоб з'ясувати,
що означає знак `+` перед числом, яке використовують із прапорцем `-n`.
(Пам'ятайте: натискайте пробіл, щоб перегорнути вниз, і/або введіть `q`, щоб вийти.)

`@hint`
Пам'ятайте: `man` — це скорочення від «manual».

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Використовуйте `man` та назву команди.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Використайте `tail` із прапорцем `-n +7`, щоб показати всі рядки, окрім перших шести, у `seasonal/spring.csv`.

`@hint`
Поставте знак «+» перед кількістю рядків, які хочете відобразити.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Ви викликаєте `tail` на `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Ви впевнені, що використали прапорець `-n +7`?")
)
```

---

## Як вибрати стовпці з файлу?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` і `tail` дають змогу вибирати рядки з текстового файлу.
Якщо потрібно вибрати стовпці,
скористайтеся командою `cut`.
У неї є кілька параметрів (перегляньте їх за допомогою `man cut`),
але найпоширеніший приклад виглядає так:

```{shell}
cut -f 2-5,8 -d , values.csv
```

Це означає:
«вибрати стовпці з 2 по 5 і стовпець 8,
використовуючи кому як роздільник».
`cut` використовує `-f` (від «fields», поля), щоб указати стовпці,
та `-d` (від «delimiter», роздільник), щоб указати символ-роздільник.
Останній потрібно вказати, тому що в деяких файлах стовпці розділяються пробілами, табуляцією або двокрапками.

<hr>

Яка команда вибере перший стовпець (із датами) з файлу `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Будь-яка з наведених вище.
- Жодна з наведених вище, тому що `-f` має стояти перед `-d`.

`@hint`
Порядок прапорців не має значення.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Так, але це не все', 'Так, але це не все', 'Вірно! Додавання пробілу після прапора є гарним стилем, але не обов\'язковим.', 'Ні, порядок прапорів не має значення'])
```

---

## Чого не вміє cut?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` — це доволі простенька команда.
Зокрема,
вона не розуміє рядків у лапках.
Якщо, наприклад, ваш файл такий:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

то:

```{shell}
cut -f 2 -d , everyone.csv
```

виведе:

```
Age
Ranjit"
Rupinder"
```

а не вік кожного,
тому що вважатиме кому між прізвищем і ім'ям розділювачем стовпців.

<hr>

Яким буде результат виконання `cut -d : -f 2-4` для рядка:

```
first:second:third:
```

(Зверніть увагу на двокрапку в кінці.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Жоден із наведених варіантів, адже тут немає чотирьох полів.

`@hint`
Зверніть увагу на двокрапку в кінці.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Ні, є ще.', 'Ні, є ще.', 'Правильно! Двокрапка в кінці створює четверте порожнє поле.', 'Ні, `cut` робить все можливе.'])
```

---

## Як повторювати команди?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Одна з найбільших переваг роботи в оболонці —
можливість легко повторювати дії.
Після виконання кількох команд
натисніть стрілку вгору, щоб перегортати їх назад.
Ви також можете редагувати їх стрілками ліворуч/праворуч і клавішею видалення.
Натиснувши Enter, ви запустите змінену команду.

Ще краще: `history` виведе список нещодавно виконаних вами команд.
Кожна має порядковий номер, тож повторно запустити потрібну команду дуже просто:
наберіть `!55`, щоб повторити 55-ту команду у вашій історії (якщо їх стільки є).
Також можна перевиконати команду, ввівши знак оклику та її назву —
наприклад, `!head` або `!cut` —
це запустить найостанніше використання цієї команди.

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
Запустіть `head summer.csv` у вашому домашньому каталозі (ця спроба має завершитися з помилкою).

`@hint`
Доповнення табуляцією не спрацює, якщо немає файлу з відповідною назвою.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Використовуйте `head` та ім'я файлу, `summer.csv`. Не хвилюйтеся, якщо це не вдасться. Так і має бути.")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Перейдіть до каталогу `seasonal`.

`@hint`
Пам'ятайте, що `cd` означає «change directory» (змінити каталог).

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Якщо ваша поточна робоча директорія (дізнайтеся за допомогою `pwd`) - це `/home/repl`, ви можете перейти до папки `seasonal` за допомогою `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Повторіть команду `head` за допомогою `!head`.

`@hint`
Не ставте пробілів між `!` і тим, що йде після нього.

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
                        incorrect_msg='Використовуйте `!head`, щоб повторити команду `head`.'),
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
Скористайтеся `history`, щоб переглянути виконані дії.

`@hint`
Зверніть увагу: `history` показує найновіші команди в кінці, щоб після завершення їх було видно на екрані.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Використовуйте `history` без прапорців, щоб отримати список попередніх команд.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Знову запустіть `head`, використавши `!` і номер команди.

`@hint`
Не ставте пробілів між `!` і тим, що йде після нього.

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
                        incorrect_msg='Ви використали `!<a_number>` для повторного виконання останньої команди `head` з історії?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Чудово! До наступного завдання!")
```

---

## Як вибрати рядки, що містять певні значення?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` і `tail` вибирають рядки,
`cut` вибирає стовпці,
а `grep` вибирає рядки залежно від їхнього вмісту.
У найпростішому випадку
`grep` отримує фрагмент тексту та один або кілька імен файлів
і виводить усі рядки в цих файлах, які містять цей текст.
Наприклад,
`grep bicuspid seasonal/winter.csv`
виводить рядки з `winter.csv`, що містять «bicuspid».

`grep` також уміє шукати за шаблонами;
ми розглянемо це в наступному курсі.
Наразі важливіші деякі з найуживаніших прапорців `grep`:

- `-c`: вивести кількість рядків, що збіглися, замість самих рядків
- `-h`: не виводити імена файлів під час пошуку в кількох файлах
- `-i`: ігнорувати регістр (наприклад, вважати «Regression» і «regression» збігами)
- `-l`: вивести імена файлів, що містять збіги, а не самі збіги
- `-n`: вивести номери рядків для рядків зі збігами
- `-v`: інвертувати збіг, тобто показувати лише рядки, які не збігаються

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
Виведіть вміст усіх рядків, що містять слово `molar`, у `seasonal/autumn.csv`,
запустивши одну команду з домашнього каталогу. Не використовуйте жодних прапорців.

`@hint`
Скористайтеся `grep` зі словом, яке ви шукаєте, та іменем файла(ів), у якому потрібно шукати.

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
      has_code("grep", incorrect_msg = "Ви викликали `grep`?"),
      has_code("molar", incorrect_msg = "Ви шукали `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Ви шукали файл `seasonal/autumn.csv`?")
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
Інвертуйте збіг, щоб знайти всі рядки, які не містять слова `molar`, у `seasonal/spring.csv`, і покажіть їхні номери рядків.
Пам'ятайте: вважається доброю практикою ставити всі прапорці перед іншими значеннями, як-от іменами файлів або пошуковим словом «molar».

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
      has_code("grep", incorrect_msg = "Ви викликали `grep`?"),
      has_code("-v", incorrect_msg = "Ви інвертували збіг за допомогою `-v`?"),
      has_code("-n", incorrect_msg = "Ви показали номери рядків за допомогою `-n`?"),
      has_code("molar", incorrect_msg = "Ви шукали `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Ви шукали файл `seasonal/spring.csv`?")
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
Підрахуйте, скільки рядків містить слово `incisor` у сукупності в `autumn.csv` та `winter.csv`.
(Знову ж таки, запустіть одну команду з домашнього каталогу.)

`@hint`
Не забудьте використати `-c` з `grep`, щоб порахувати рядки.

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
      has_code("grep", incorrect_msg = "Ви викликали `grep`?"),
      has_code("-c", incorrect_msg = "Ви отримали підрахунки за допомогою `-c`?"),
      has_code("incisor", incorrect_msg = "Ви шукали `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Ви шукали файл `seasonal/autumn.csv`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Ви шукали файл `seasonal/winter.csv`?")
    )
  )
)

```

---

## Чому не завжди безпечно трактувати дані як звичайний текст?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

Розділ `SEE ALSO` на сторінці керівництва для `cut` посилається на команду `paste`,
яку можна використати, щоб об'єднувати файли даних замість їх розрізання.

<hr>

Прочитайте сторінку керівництва для `paste`,
а потім запустіть `paste`, щоб об'єднати файли даних за осінь і зиму в одну таблицю,
використовуючи кому як роздільник.
Що не так з цим виводом з погляду аналізу даних?

`@possible_answers`
- Заголовки стовпчиків повторюються.
- В останніх кількох рядках неправильна кількість стовпчиків.
- Частина даних із `winter.csv` відсутня.

`@hint`
Якщо ви застосуєте `cut` до виводу `paste`, використовуючи коми як роздільник,
чи отримаєте ви правильну відповідь?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Правильно, але це не обов\'язково є помилкою.'
correct2 = 'Вірно: об\'єднання рядків зі стовпцями створює лише один порожній стовпець на початку, а не два.'
err3 = 'Ні, всі зимові дані присутні.'
Ex().has_chosen(2, [err1, correct2, err3])
```

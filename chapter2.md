---
title: Работа с данными
description: >-
  Команды из предыдущей главы позволяли перемещать объекты в файловой системе. В
  этой главе вы научитесь работать с содержимым файлов. Инструменты достаточно
  просты, но служат надёжной основой для дальнейшей работы.
lessons:
  - nb_of_exercises: 12
    title: Как просмотреть содержимое файла?
---

## Как просмотреть содержимое файла?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Прежде чем переименовывать или удалять файлы,
может быть полезно заглянуть в их содержимое.
Проще всего это сделать с помощью команды `cat`,
которая выводит содержимое файлов прямо на экран.
(Название происходит от слова "concatenate" — «объединять»,
поскольку команда выводит все указанные файлы один за другим.)

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
Выведите содержимое файла `course.txt` на экран.

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
    has_expr_output(incorrect_msg="Ваша команда не сгенерировала правильный вывод. Вы использовали `cat` с именем файла `course.txt`?")
)
Ex().success_msg("Отлично! Давайте рассмотрим другие способы просмотра содержимого файла.")
```

---

## Как просматривать содержимое файла по частям?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Команда `cat` позволяет вывести содержимое большого файла и прокрутить его, но гораздо удобнее использовать **постраничный** просмотр.
Изначально для этого служила команда `more`, однако её вытеснила более мощная команда `less`.
(Такой юмор — вполне в духе мира Unix.)
Командa `less` отображает файл по одной странице за раз;
нажмите пробел, чтобы перейти на следующую страницу, или введите `q`, чтобы выйти.

Если передать команде `less` несколько файлов,
можно ввести `:n` (двоеточие и строчную букву «n»), чтобы перейти к следующему файлу,
`:p` — чтобы вернуться к предыдущему,
или `:q` — чтобы выйти.

Примечание: если вы будете просматривать решения упражнений, использующих `less`,
вы заметите дополнительную команду в конце — она отключает постраничный вывод,
чтобы мы могли эффективно проверять ваши решения.

`@instructions`
Выполните команду `less seasonal/spring.csv seasonal/summer.csv`, чтобы просмотреть эти два файла в указанном порядке.
Нажмите пробел для перехода на следующую страницу, `:n` — для перехода ко второму файлу, `:q` — для выхода.

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
                 incorrect_msg='Используйте `less` и имена файлов. Помните, что `:n` переходит к следующему файлу.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Как просмотреть начало файла?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Первое, что обычно делают специалисты по данным, получив новый набор данных для анализа, — это выяснить, какие поля он содержит и какие значения в них хранятся.
Если набор данных был выгружен из базы данных или электронной таблицы,
он, как правило, сохраняется в формате **значений, разделённых запятыми** (CSV).
Быстрый способ понять, что находится в файле, — посмотреть на первые несколько строк.

В оболочке для этого используется команда `head`.
Как следует из её названия,
она выводит первые несколько строк файла
(под «несколькими» подразумевается 10),
поэтому команда:

```{shell}
head seasonal/summer.csv
```

выводит:

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

Что произойдёт, если в файле меньше 10 строк?
(Проверьте это, просмотрев начало файла `people/agarwal.txt`.)

`@possible_answers`
- Выведет сообщение об ошибке, так как файл слишком короткий.
- Отобразит столько строк, сколько есть в файле.
- Дополнит вывод пустыми строками до 10.

`@hint`
Что было бы наиболее логичным в этом случае?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Неверно: это не самое полезное действие, которое он мог бы выполнить.",
                    "Верно!",
                    "Неверно: это было бы невозможно отличить от файла, заканчивающегося несколькими пустыми строками."])
```

---

## Как набирать меньше текста?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Одним из мощных инструментов командной строки является **автодополнение по Tab**.
Если начать вводить имя файла и нажать клавишу Tab,
команднная строка постарается автоматически завершить путь.
Например,
если ввести `sea` и нажать Tab,
она подставит имя директории `seasonal/` (с косой чертой в конце).
Если затем ввести `a` и снова нажать Tab,
путь будет дополнен до `seasonal/autumn.csv`.

Если путь неоднозначен,
например `seasonal/s`,
повторное нажатие Tab выведет список возможных вариантов.
Достаточно ввести ещё один-два символа, чтобы уточнить путь,
и затем нажать Tab —
командная строка дополнит оставшуюся часть имени.

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
Выполните команду `head seasonal/autumn.csv`, не вводя полное имя файла вручную.

`@hint`
Введите столько символов пути, сколько нужно, затем нажмите Tab и повторите.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Проверяющая система не смогла найти правильный вывод в вашей команде. Вы уверены, что вызвали `head` для `seasonal/autumn.csv`?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Выполните команду `head seasonal/spring.csv`, не вводя полное имя файла вручную.

`@hint`
Введите столько символов пути, сколько нужно, затем нажмите Tab и повторите.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Проверяющая система не смогла найти правильный вывод в вашей команде. Вы уверены, что вызвали `head` для `seasonal/spring.csv`?")
)
Ex().success_msg("Отличная работа! Как только вы привыкнете использовать автодополнение по клавише Tab, это сэкономит вам много времени!")
```

---

## Как управлять поведением команд?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Не всегда нужно просматривать первые 10 строк файла,
поэтому оболочка позволяет изменить поведение `head`
с помощью **флага командной строки** (или просто «флага»).
Если выполнить команду:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` выведет только первые три строки файла.
Если запустить `head -n 100`,
будут выведены первые 100 строк (при условии, что их столько есть),
и так далее.

Название флага, как правило, отражает его назначение
(например, `-n` обозначает «**n**umber of lines» — количество строк).
Флаги не обязательно состоят из `-` и одной буквы,
но это широко распространённое соглашение.

Обратите внимание: хорошим стилем считается указывать все флаги *перед* именами файлов,
поэтому в этом курсе
принимаются только ответы, соответствующие этому правилу.

`@instructions`
Выведите первые 5 строк файла `winter.csv` из каталога `seasonal`.

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
        has_expr_output(incorrect_msg="Вы уверены, что вызываете `head` для файла `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Вы уверены, что использовали флаг `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Вы уверены, что использовали флаг `-n 5`?")
)
Ex().success_msg("Отлично! С помощью этого приёма вы можете избежать переполнения оболочки, если хотите просмотреть более крупные текстовые файлы.")
```

---

## Как просмотреть содержимое каталога целиком?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Чтобы увидеть всё содержимое каталога — независимо от глубины вложенности, — используйте команду `ls` с флагом `-R` (от слова «recursive», то есть «рекурсивный»). Если выполнить `ls -R` в домашнем каталоге, вывод будет выглядеть примерно так:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Сначала отображаются все файлы и каталоги текущего уровня, затем — содержимое каждого подкаталога, и так далее по всей иерархии.

`@instructions`
Чтобы лучше ориентироваться в выводе, у `ls` есть ещё один флаг — `-F`. Он добавляет `/` после имени каждого каталога и `*` после имени каждой исполняемой программы. Запустите `ls` с двумя флагами, `-R` и `-F`, и укажите абсолютный путь к домашнему каталогу, чтобы увидеть всё его содержимое. (Порядок флагов не важен, однако имя каталога должно стоять последним.)

`@hint`
Домашний каталог можно указать с помощью `~`, `.` или его абсолютного пути.

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
  has_expr_output(incorrect_msg='Используйте либо `ls -R -F`, либо `ls -F -R` и путь `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Используйте либо `ls -R -F`, либо `ls -F -R` и путь `/home/repl`.')
)
Ex().success_msg("Довольно удобный обзор, не правда ли?")
```

---

## Как получить справку по команде?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Чтобы узнать, что делает та или иная команда,
раньше использовали команду `man`
(сокращение от «manual» — «руководство»).
Например,
команда `man head` выводит следующую информацию:

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

`man` автоматически запускает `less`,
поэтому для прокрутки содержимого может потребоваться нажать пробел,
а для выхода — ввести `:q`.

Однострочное описание в разделе `NAME` кратко объясняет, что делает команда,
а сводка в разделе `SYNOPSIS` перечисляет все поддерживаемые флаги.
Необязательные элементы заключены в квадратные скобки `[...]`,
альтернативные варианты разделены знаком `|`,
а повторяющиеся элементы обозначены `...`.
Таким образом, страница руководства для `head` сообщает, что можно *либо* задать количество строк с помощью `-n`,
либо количество байт с помощью `-c`,
а также указать любое количество имён файлов.

Основная сложность при работе с Unix-руководством состоит в том, что нужно заранее знать, что именно искать.
Если вы не знаете, с чего начать,
можно воспользоваться [Stack Overflow](https://stackoverflow.com/),
задать вопрос в каналах Slack на DataCamp
или изучить разделы `SEE ALSO` уже знакомых вам команд.

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
Откройте страницу руководства для команды `tail` и узнайте,
что происходит, если поставить знак `+` перед числом при использовании флага `-n`.
(Не забывайте: пробел — для прокрутки вниз, `q` — для выхода.)

`@hint`
Помните: `man` — это сокращение от «manual» («руководство»).

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Используйте `man` и имя команды.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Используйте `tail` с флагом `-n +7`, чтобы вывести все строки файла `seasonal/spring.csv`, *кроме* первых шести.

`@hint`
Поставьте знак плюс '+' перед числом строк, которые хотите отобразить.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Вы вызываете `tail` для `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Вы уверены, что использовали флаг `-n +7`?")
)
```

---

## Как выбрать столбцы из файла?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

Команды `head` и `tail` позволяют выбирать строки из текстового файла.
Если же вам нужно выбрать столбцы,
воспользуйтесь командой `cut`.
У неё есть несколько параметров (изучите их с помощью `man cut`),
но чаще всего она используется примерно так:

```{shell}
cut -f 2-5,8 -d , values.csv
```

Это означает:
«выбрать столбцы с 2 по 5 и столбец 8,
используя запятую в качестве разделителя».
Флаг `-f` (от английского «fields» — поля) задаёт столбцы,
a `-d` (от «delimiter» — разделитель) указывает символ-разделитель.
Задавать разделитель необходимо, поскольку в разных файлах столбцы могут разделяться пробелами, табуляцией или двоеточиями.

<hr>

Какая команда выберет первый столбец (с датами) из файла `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Любая из перечисленных выше.
- Ни одна из перечисленных выше, так как флаг `-f` должен стоять перед `-d`.

`@hint`
Порядок флагов не имеет значения.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Yes, but that is not all', 'Yes, but that is not all', 'Correct! Adding a space after the flag is good style, but not compulsory.', 'No, flag order doesn\'t matter'])
```

---

## Что не умеет cut?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` — довольно простая команда.
В частности,
она не понимает строки в кавычках.
Например, если ваш файл содержит:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

то команда:

```{shell}
cut -f 2 -d , everyone.csv
```

выведет:

```
Age
Ranjit"
Rupinder"
```

a не возраст каждого человека,
потому что запятая между фамилией и именем будет воспринята как разделитель столбцов.

<hr>

Каков результат выполнения `cut -d : -f 2-4` для строки:

```
first:second:third:
```

(Обратите внимание на двоеточие в конце строки.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Ни один из перечисленных вариантов, так как в строке нет четырёх полей.

`@hint`
Обратите внимание на двоеточие в конце строки.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Нет, это не так.', 'Нет, это не так.', 'Верно! Завершающее двоеточие создаёт пустое четвёртое поле.', 'Нет, `cut` делает всё возможное.'])
```

---

## Как повторять команды?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Одно из главных преимуществ командной оболочки — возможность легко повторять ранее выполненные команды.
Если вы уже вводили какие-то команды,
нажмите клавишу со стрелкой вверх, чтобы прокрутить их список.
Клавиши со стрелками влево и вправо, а также клавиша Delete позволяют отредактировать команду.
Нажмите Enter — и изменённая команда будет выполнена.

Ещё удобнее использовать `history`: эта команда выводит список недавно выполненных команд.
Каждая из них пронумерована, что упрощает повторный запуск нужной:
например, введите `!55`, чтобы повторно выполнить команду под номером 55 (если у вас столько команд в истории).
Можно также повторить команду, указав восклицательный знак и её название —
nапример, `!head` или `!cut` —
и будет выполнен самый последний вызов этой команды.

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
Выполните команду `head summer.csv` в домашнем каталоге (она должна завершиться ошибкой).

`@hint`
Автодополнение по Tab не сработает, если нет подходящего имени файла.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Используйте `head` и имя файла `summer.csv`. Не беспокойтесь, если это не сработает. Так и должно быть.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Перейдите в каталог `seasonal`.

`@hint`
Помните, что `cd` — это сокращение от «change directory» (сменить каталог).

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Если ваш текущий рабочий каталог (узнайте с помощью `pwd`) — `/home/repl`, вы можете перейти в папку `seasonal` с помощью команды `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Повторно выполните команду `head` с помощью `!head`.

`@hint`
Не ставьте пробел между `!` и тем, что следует за ним.

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
                        incorrect_msg='Используйте `!head` для повторения команды `head`.'),
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
Используйте `history`, чтобы просмотреть историю выполненных команд.

`@hint`
Обратите внимание: `history` отображает самые последние команды в конце списка, чтобы они оставались видимыми на экране после завершения вывода.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Используйте `history` без флагов, чтобы получить список предыдущих команд.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Повторно выполните `head`, используя `!` и номер команды из истории.

`@hint`
*Не* ставьте пробел между `!` и тем, что следует за ним.

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
                        incorrect_msg='Вы использовали `!<a_number>` для повторного запуска последней команды `head` из истории?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Отлично! Переходим к следующему заданию!")
```

---

## Как выбрать строки с определёнными значениями?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` и `tail` выбирают строки,
`cut` выбирает столбцы,
а `grep` выбирает строки по их содержимому.
В простейшем виде
`grep` принимает фрагмент текста и одно или несколько имён файлов,
а затем выводит все строки этих файлов, содержащие указанный текст.
Например,
`grep bicuspid seasonal/winter.csv`
выводит строки из `winter.csv`, в которых встречается слово "bicuspid".

`grep` умеет искать и по шаблонам;
мы рассмотрим это в следующем курсе.
Сейчас важнее познакомиться с наиболее часто используемыми флагами `grep`:

- `-c`: выводит количество совпадающих строк, а не сами строки
- `-h`: *не* выводит имена файлов при поиске по нескольким файлам
- `-i`: игнорирует регистр (например, считает "Regression" и "regression" совпадением)
- `-l`: выводит имена файлов, содержащих совпадения, а не сами совпадения
- `-n`: выводит номера строк для совпадающих строк
- `-v`: инвертирует поиск, то есть показывает только строки, которые *не* совпадают

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
Выведите содержимое всех строк, содержащих слово `molar`, из файла `seasonal/autumn.csv`,
выполнив одну команду из домашней директории. Флаги не используйте.

`@hint`
Используйте `grep`, указав искомое слово и имя файла (или файлов), в которых нужно выполнить поиск.

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
      has_code("grep", incorrect_msg = "Вы вызвали `grep`?"),
      has_code("molar", incorrect_msg = "Вы выполнили поиск `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Вы выполнили поиск в файле `seasonal/autumn.csv`?")
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
Инвертируйте поиск, чтобы найти все строки, которые *не* содержат слово `molar`, в файле `seasonal/spring.csv`, и отобразите их с номерами строк.
Помните: принято указывать все флаги *перед* остальными аргументами — именами файлов или поисковым словом "molar".

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
      has_code("grep", incorrect_msg = "Вы вызвали `grep`?"),
      has_code("-v", incorrect_msg = "Вы инвертировали совпадение с помощью `-v`?"),
      has_code("-n", incorrect_msg = "Вы включили отображение номеров строк с помощью `-n`?"),
      has_code("molar", incorrect_msg = "Вы выполнили поиск по слову `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Вы выполнили поиск в файле `seasonal/spring.csv`?")
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
Подсчитайте, сколько строк содержат слово `incisor` в файлах `autumn.csv` и `winter.csv` вместе.
(Выполните одну команду из домашней директории.)

`@hint`
Не забудьте использовать флаг `-c` с командой `grep` для подсчёта строк.

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
      has_code("grep", incorrect_msg = "Вы вызвали `grep`?"),
      has_code("-c", incorrect_msg = "Вы получили количество совпадений с помощью `-c`?"),
      has_code("incisor", incorrect_msg = "Вы выполнили поиск по слову `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Вы выполнили поиск в файле `seasonal/autumn.csv`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Вы выполнили поиск в файле `seasonal/winter.csv`?")
    )
  )
)
```

---

## Почему с данными не всегда безопасно работать как с обычным текстом?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

В разделе `SEE ALSO` справочной страницы команды `cut` упоминается команда `paste`,
которая позволяет объединять файлы с данными, а не разбивать их.

<hr>

Прочитайте справочную страницу команды `paste`,
а затем выполните `paste`, чтобы объединить файлы с данными за осень и зиму в одну таблицу,
используя запятую в качестве разделителя.
Что не так с полученным результатом с точки зрения анализа данных?

`@possible_answers`
- Заголовки столбцов повторяются.
- В нескольких последних строках неверное количество столбцов.
- Часть данных из `winter.csv` отсутствует.

`@hint`
Если применить `cut` к выводу `paste`, используя запятую в качестве разделителя,
получится ли правильный результат?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Верно, но это не обязательно является ошибкой.'
correct2 = 'Верно: объединение строк со столбцами создаёт только один пустой столбец в начале, а не два.'
err3 = 'Нет, все данные за зиму присутствуют.'
Ex().has_chosen(2, [err1, correct2, err3])
```

---
title: Создание новых инструментов
description: >-
  История команд позволяет повторять действия несколькими нажатиями клавиш, а
  конвейеры — комбинировать существующие команды для создания новых. В этой
  главе вы сделаете ещё один шаг вперёд и научитесь создавать собственные
  команды.
lessons:
  - nb_of_exercises: 9
    title: Как редактировать файл?
---

## Как редактировать файл?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

В Unix существует огромное множество текстовых редакторов.
В этом курсе мы будем использовать простой редактор под названием Nano.
Если ввести `nano filename`,
редактор откроет файл `filename` для редактирования
(или создаст его, если он ещё не существует).
Перемещаться по тексту можно с помощью клавиш со стрелками,
удалять символы — клавишей Backspace,
а выполнять другие операции — сочетаниями клавиш с Ctrl:

- `Ctrl` + `K`: удалить строку.
- `Ctrl` + `U`: восстановить удалённую строку.
- `Ctrl` + `O`: сохранить файл (O означает «output» — вывод). _После этого нужно нажать Enter, чтобы подтвердить имя файла!_
- `Ctrl` + `X`: выйти из редактора.

`@instructions`
Выполните команду `nano names.txt`, чтобы создать новый файл в домашнем каталоге,
и введите следующие четыре строки:

```
Lovelace
Hopper
Johnson
Wilson
```

Чтобы сохранить введённый текст,
нажмите `Ctrl` + `O` для записи файла,
затем Enter для подтверждения имени файла,
а после этого `Ctrl` + `X` для выхода из редактора.

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
patt = "Вы включили строку `%s` в файл `names.txt`? Используйте `nano names.txt` ещё раз для обновления файла. Используйте `Ctrl` + `O` для сохранения и `Ctrl` + `X` для выхода."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Отлично! Переходим к следующему заданию!")
```

---

## Как сохранить историю выполненных команд?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

При выполнении сложного анализа часто бывает полезно сохранить запись использованных команд.
Сделать это можно с помощью уже знакомых вам инструментов:

1. Запустите `history`.
2. Передайте вывод команде `tail -n 10` (или укажите нужное количество последних шагов).
3. Перенаправьте результат в файл, например `figure-5.history`.

Это надёжнее, чем вести записи вручную в лабораторном журнале:
такой способ гарантирует, что ни один шаг не будет пропущен.
Кроме того, он наглядно демонстрирует ключевую идею командной оболочки:
простые инструменты, которые читают и выводят текстовые строки,
можно комбинировать самыми разными способами
для решения широкого круга задач.

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
Скопируйте файлы `seasonal/spring.csv` и `seasonal/summer.csv` в домашний каталог.

`@hint`
Используйте `cp` для копирования и `~` как сокращение пути к домашнему каталогу.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Вы использовали `cp seasonal/s* ~` для копирования необходимых файлов в домашний каталог?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Замечательное ведение записей! Если вы допустили ошибку при вводе команд, вы всегда можете использовать `nano` для очистки файла истории сохранений.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Используйте `grep` с флагом `-h` (чтобы не выводить имена файлов)
и `-v Tooth` (чтобы выбрать строки, *не совпадающие* со строкой заголовка).
Выберите записи данных из `spring.csv` и `summer.csv` именно в таком порядке
и перенаправьте вывод в файл `temp.csv`.

`@hint`
Укажите флаги перед именами файлов.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Убедитесь, что вы перенаправляете вывод команды `grep` в `temp.csv` с помощью `>`!"
msg2 = "Использовали ли вы `grep -h -v ___ ___ ___` (заполните пропуски) для заполнения `temp.csv`?"
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
Передайте вывод `history` команде `tail -n 3`
и перенаправьте результат в файл `steps.txt`,
чтобы сохранить три последние команды.
(Нужно сохранить три команды, а не две,
потому что сама команда `history` тоже попадёт в список.)

`@hint`
Помните, что перенаправление с помощью `>` указывается в конце цепочки команд, соединённых каналом.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Убедитесь, что вы перенаправили вывод команды в `steps.txt`."
msg2="Использовали ли вы `history | tail ___ ___` (заполните пропуски) для заполнения `steps.txt`?"
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
Ex().success_msg("Отлично! Усложним задачу!")
```

---

## Как сохранить команды для повторного запуска?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

До сих пор вы работали с оболочкой в интерактивном режиме.
Однако команды, которые вы вводите, — это просто текст,
а значит, их можно сохранить в файл и запускать снова и снова.
Чтобы познакомиться с этой возможностью,
запишите следующую команду в файл `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Эта команда извлекает первую строку из каждого CSV-файла в каталоге `seasonal`.
Когда файл будет создан,
запустить его можно так:

```{shell}
bash headers.sh
```

Так вы указываете оболочке (программе `bash`)
выполнить команды, записанные в файле `headers.sh`.
Результат будет таким же, как при вводе команд вручную.

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
С помощью `nano dates.sh` создайте файл `dates.sh`,
который содержит следующую команду:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

Она извлекает первый столбец из всех CSV-файлов в каталоге `seasonal`.

`@hint`
Введите команды в файл без лишних пустых строк и пробелов.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Вы включили строку `cut -d , -f 1 seasonal/*.csv` в файл `dates.sh`? Используйте `nano dates.sh` ещё раз для обновления файла. Используйте `Ctrl` + `O` для сохранения и `Ctrl` + `X` для выхода."
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
Запустите файл `dates.sh` с помощью `bash`.

`@hint`
Используйте `bash имя_файла`, чтобы запустить файл.

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
      has_code("bash", incorrect_msg = 'Вы вызвали `bash`?'),
      has_code("dates.sh", incorrect_msg = 'Вы указали файл `dates.sh`?')
    )
  )
)
```

---

## Как повторно использовать конвейеры?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Файл, содержащий команды оболочки, называется ***сценарием оболочки**,
или просто «сценарием» для краткости. Имена сценариев не обязательно должны заканчиваться на `.sh`,
но в этом уроке мы будем придерживаться такого соглашения,
чтобы вам было удобнее отличать сценарии от других файлов.

Сценарии также могут содержать конвейеры.
Например,
если файл `all-dates.sh` содержит следующую строку:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

то команда:

```{shell}
bash all-dates.sh > dates.out
```

извлечёт уникальные даты из сезонных файлов данных
и сохранит их в файл `dates.out`.

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
В вашем домашнем каталоге уже подготовлен файл `teeth.sh`, однако в нём есть пропуски.
Откройте файл в Nano и замените оба заполнителя `____`
на `seasonal/*.csv` и `-c`, чтобы сценарий выводил количество вхождений
каждого названия зуба в CSV-файлах каталога `seasonal`.

`@hint`
Используйте команду `nano teeth.sh`, чтобы открыть файл для редактирования.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Правильно ли вы заполнили пропуски, чтобы команда в `teeth.sh` выглядела как `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Используйте `nano teeth.sh` ещё раз, чтобы внести необходимые изменения."
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
Запустите `teeth.sh` с помощью `bash` и перенаправьте вывод в файл `teeth.out` с помощью `>`.

`@hint`
Помните, что `> teeth.out` нужно указывать *после* команды, которая генерирует вывод.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Правильно ли вы перенаправили результат выполнения `bash teeth.sh` в `teeth.out` с помощью `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Вы использовали команду `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Вы запустили файл `teeth.sh`?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Вы перенаправили вывод в файл `teeth.out`?')
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
Выполните команду `cat teeth.out`, чтобы проверить результаты.

`@hint`
Напоминаем: введите первые несколько символов имени файла и нажмите Tab для автодополнения.

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
      has_code("cat", incorrect_msg = 'Вы вызвали `cat`?'),
      has_code("teeth.out", incorrect_msg = 'Вы указали файл `teeth.out`?')
    )
  )
)
Ex().success_msg("Отлично! Поначалу всё это может казаться надуманным, но приятная особенность заключается в том, что вы автоматизируете части своего рабочего процесса шаг за шагом. Это очень удобно для специалиста по данным!")
```

---

## Как передать имена файлов скриптам?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Скрипт, обрабатывающий конкретные файлы, полезен как запись выполненных действий, но ещё удобнее скрипт, который позволяет обрабатывать любые нужные файлы.
Для этого можно использовать специальное выражение `$@` (знак доллара, сразу за которым следует знак @), обозначающее «все параметры командной строки, переданные скрипту».

Например, если файл `unique-lines.sh` содержит команду `sort $@ | uniq`, то при запуске:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

оболочка заменяет `$@` на `seasonal/summer.csv` и обрабатывает один файл. Если же выполнить:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

будут обработаны два файла данных, и так далее.

_Напоминаем: чтобы сохранить файл в Nano, нажмите `Ctrl` + `O` для записи файла, затем Enter для подтверждения имени файла, а затем `Ctrl` + `X` для выхода из редактора._

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
Откройте скрипт `count-records.sh` в Nano и заполните два заполнителя `____`
значениями `$@` и `-l` (_буква_) соответственно, чтобы скрипт подсчитывал количество строк в одном или нескольких файлах,
исключая первую строку каждого из них.

`@hint`
* Используйте `nano count-records.sh`, чтобы открыть файл для редактирования.
* Убедитесь, что вы указываете _букву_ `-l`, а не цифру один.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Правильно ли вы заполнили пропуски, чтобы команда в `count-records.sh` выглядела как `tail -q -n +2 $@ | wc -l`? Используйте `nano count-records.sh` ещё раз, чтобы внести необходимые изменения."
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
Запустите `count-records.sh` для файлов `seasonal/*.csv`
и перенаправьте вывод в файл `num-records.out` с помощью `>`.

`@hint`
Используйте `>` для перенаправления вывода.

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
      has_code("bash", incorrect_msg = 'Вы вызвали `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Вы запустили файл `count-records.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Вы указали файлы для обработки с помощью `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Вы выполнили перенаправление в файл `num-records.out`?')
    )
  )
)
Ex().success_msg("Отличная работа! Ваши навыки работы с оболочкой постоянно растут!")
```

---

## Как обработать один аргумент?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Помимо `$@`,
оболочка позволяет использовать `$1`, `$2` и так далее для обращения к конкретным параметрам командной строки.
Это даёт возможность создавать команды, которые выглядят проще и естественнее стандартных.
Например,
вы можете написать скрипт `column.sh`, который выбирает один столбец из CSV-файла:
пользователь передаёт имя файла первым параметром, а номер столбца — вторым:

```{shell}
cut -d , -f $2 $1
```

Запустить его можно так:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Обратите внимание, что скрипт использует два параметра в обратном порядке.

<hr>

Скрипт `get-field.sh` должен принимать имя файла,
номер строки,
номер столбца
и выводить соответствующее поле из CSV-файла.
Например, команда:

```
bash get-field.sh seasonal/summer.csv 4 2
```

должна вернуть второе поле из четвёртой строки файла `seasonal/summer.csv`.
Какую из приведённых команд нужно поместить в `get-field.sh`?

`@hint`
Помните, что параметры командной строки нумеруются слева направо.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Нет: в этом случае имя файла будет передано в качестве количества строк для команды `head`.
- Верно!
- Нет: в этом случае номер столбца будет использован как номер строки, и наоборот.
- Нет: в этом случае номер поля будет использован как имя файла, и наоборот.

---

## Как один скрипт может выполнять несколько задач?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

До сих пор наши скрипты содержали одну команду или конвейер, но скрипт может включать и несколько строк команд. Например, можно написать скрипт, который покажет количество записей в самом коротком и самом длинном из ваших файлов данных — то есть диапазон длин наборов данных.

Обратите внимание: в Nano «копирование и вставка» выполняется следующим образом: перейдите к нужной строке, нажмите `CTRL` + `K`, чтобы вырезать её, а затем дважды нажмите `CTRL` + `U`, чтобы вставить две копии.

_Напоминаем: чтобы сохранить файл в Nano, нажмите `Ctrl` + `O` для записи файла, затем Enter для подтверждения имени файла, а после этого `Ctrl` + `X` для выхода из редактора._

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
Откройте скрипт `range.sh` в Nano
и замените два заполнителя `____`
на `$@` и `-v`,
чтобы скрипт выводил имена и количество строк всех файлов, переданных в командной строке,
*без* отображения общего числа строк по всем файлам.
(Вычитать строки с заголовками столбцов не нужно.)

`@hint`
Используйте `wc -l $@` для подсчёта строк во всех файлах, переданных в командной строке.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Вы правильно заполнили пропуски, чтобы команда в `range.sh` читалась как `wc -l $@ | grep -v total`? Используйте `nano range.sh` ещё раз, чтобы внести необходимые изменения."
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
Снова откройте Nano и добавьте `sort -n` и `head -n 1` именно в таком порядке
в конвейер в файле `range.sh`,
чтобы скрипт выводил имя и количество строк самого короткого из переданных файлов.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Вы добавили `sort -n` и `head -n 1` с каналами в файл `range.sh`? Используйте `nano range.sh` ещё раз, чтобы внести необходимые изменения."
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
Снова используя Nano, добавьте в `range.sh` вторую строку, которая выводит имя и количество записей
*самого длинного* файла в директории *вместе с* самым коротким.
Эта строка должна быть копией уже написанной,
но с `sort -n -r` вместо `sort -n`.

`@hint`
Скопируйте первую строку и измените порядок сортировки.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Сохраните первую строку в файле `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Вы продублировали первую строку в `range.sh` и внесли небольшое изменение? `sort -n -r` вместо `sort -n`!"
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
Запустите скрипт для файлов в директории `seasonal`,
используя `seasonal/*.csv` для указания всех файлов,
и перенаправьте вывод с помощью `>`
в файл `range.out` в вашей домашней директории.

`@hint`
Используйте `bash range.sh` для запуска скрипта, `seasonal/*.csv` для указания файлов и `> range.out` для перенаправления вывода.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Вы правильно перенаправили результат `bash range.sh seasonal/*.csv` в `range.out` с помощью `>`?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Вы вызвали `bash`?'),
has_code("bash\s+range.sh", incorrect_msg = 'Вы запустили файл `range.sh`?'),
has_code("seasonal/\*", incorrect_msg = 'Вы указали файлы для обработки с помощью `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = 'Вы перенаправили вывод в файл `range.out`?')
)
)

Ex().success_msg("Всё идёт хорошо. Переходите к следующему упражнению, чтобы узнать о написании циклов!")
```

---

## Как писать циклы в shell-скрипте?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shell-скрипты также могут содержать циклы. Их можно записывать через точку с запятой или разбивать на несколько строк — это делает код нагляднее:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Отступы внутри цикла не обязательны, но они делают код значительно понятнее.)

Первая строка этого скрипта — **комментарий**, который объясняет, что делает скрипт. Комментарии начинаются с символа `#` и продолжаются до конца строки. Краткие пояснения, подобные приведённому здесь, здорово помогут вам самим, когда вы вернётесь к своим скриптам позже.

_Напоминаем: чтобы сохранить файл в Nano, нажмите `Ctrl` + `O`, затем Enter для подтверждения имени файла и `Ctrl` + `X` для выхода из редактора._

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
Заполните пропуски в скрипте `date-range.sh`:
вставьте `$filename` (дважды), `head` и `tail`,
чтобы скрипт выводил первую и последнюю дату из одного или нескольких файлов.

`@hint`
Не забудьте использовать `$filename`, чтобы получить текущее значение переменной цикла.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="В файле `date-range.sh`, изменили ли вы %s строку в цикле на `%s`? Используйте `nano date-range.sh` для внесения изменений."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('первую', cmdpatt%'head')
msg2=msgpatt%('вторую', cmdpatt%'tail')
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
Запустите `date-range.sh` для всех четырёх файлов сезонных данных,
используя `seasonal/*.csv` для указания их имён.

`@hint`
Шаблонное выражение должно начинаться с имени каталога.

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
      has_code("bash", incorrect_msg = 'Вы вызвали `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Вы запустили файл `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Вы указали файлы для обработки с помощью `seasonal/*`?')
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
Запустите `date-range.sh` для всех четырёх файлов сезонных данных, используя `seasonal/*.csv` для указания их имён,
и передайте результат в `sort` через конвейер — убедитесь, что ваши скрипты работают так же, как встроенные команды Unix.

`@hint`
Используйте то же шаблонное выражение, что и раньше.

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
      has_code("bash", incorrect_msg = 'Вы вызвали `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Вы запустили файл `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Вы указали файлы для обработки с помощью `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Вы использовали конвейер для передачи вывода скрипта в `sort`?'),
      has_code("sort", incorrect_msg = 'Вы вызвали `sort`?')
    )
  )
)
Ex().success_msg("Превосходно! Обратите внимание, насколько хорошо всё, что мы изучили, сочетается друг с другом.")
```

---

## Что происходит, если не указать имена файлов?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Одна из распространённых ошибок в shell-скриптах (и при интерактивной работе) — указать имена файлов не на том месте.
Если вы введёте:

```{shell}
tail -n 3
```

то, поскольку команде `tail` не передано ни одного файла,
она будет ждать ввода с клавиатуры.
Это значит, что если вы введёте:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

то `tail` выведет последние три строки файла `somefile.txt`,
а `head` будет бесконечно ждать ввода с клавиатуры,
поскольку ей не передан файл и нет никаких данных из предыдущей команды в конвейере.

<hr>

Предположим, вы случайно ввели:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Что следует сделать в этом случае?

`@possible_answers`
- Подождать 10 секунд, пока `head` завершится по таймауту.
- Ввести `somefile.txt` и нажать Enter, чтобы передать данные команде `head`.
- Нажать `Ctrl` + `C`, чтобы остановить выполнение `head`.

`@hint`
Что делает `head`, если ему не передано ни имя файла, ни входные данные из предыдущей команды?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Нет, команды не будут прерываться по тайм-ауту.'
a2 = 'Нет, это передаст команде `head` текст `somefile.txt` для обработки, но затем она зависнет в ожидании дополнительного ввода.'
a3 = 'Да! Для остановки запущенной программы следует использовать `Ctrl` + `C`. На этом вводный курс завершён! Если вас интересует изучение дополнительных инструментов командной строки, мы настоятельно рекомендуем пройти наш бесплатный вводный курс по Git!'
Ex().has_chosen(3, [a1, a2, a3])
```

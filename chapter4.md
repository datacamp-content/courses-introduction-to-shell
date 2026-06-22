---
title: Пакетна обробка
description: >-
  Більшість команд оболонки можуть обробляти багато файлів одночасно. У цьому
  розділі ви дізнаєтеся, як змусити ваші конвеєри робити те саме. Дорогою ви
  побачите, як оболонка зберігає інформацію у змінних.
lessons:
  - nb_of_exercises: 10
    title: Як оболонка зберігає інформацію?
---

## Як оболонка зберігає інформацію?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Як і інші програми, оболонка зберігає інформацію у змінних.
Деякі з них — це **змінні середовища**,
і вони доступні постійно.
Назви змінних середовища зазвичай пишуть великими літерами,
а кілька найуживаніших наведено нижче.

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | Домашній каталог користувача      | `/home/repl`          |
| `PWD `   | Поточний робочий каталог          | Те саме, що команда `pwd` |
| `SHELL`  | Яка оболонка використовується     | `/bin/bash`           |
| `USER`   | Ідентифікатор користувача         | `repl`                |

Щоб отримати повний список (він досить довгий),
можете ввести в оболонці `set`.

<hr>

Скористайтеся `set` і `grep`, з'єднавши їх через пайп, щоб відобразити значення `HISTFILESIZE`,
яке визначає, скільки старих команд зберігається в історії.
Яке його значення?

`@possible_answers`
- 10
- 500
- [2000]
- Такої змінної немає.

`@hint`
Скористайтеся `set | grep HISTFILESIZE`, щоб отримати потрібний рядок.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Ні: оболонка зберігає більше історії, ніж це."
err2 = "Ні: оболонка зберігає більше історії, ніж це."
correct3 = "Вірно: оболонка зберігає 2000 старих команд за замовчуванням на цій системі."
err4 = "Ні: змінна `HISTFILESIZE` існує."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Як вивести значення змінної?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Простіший спосіб дізнатися значення змінної — скористатися командою `echo`, яка виводить свої аргументи. Якщо ввести

```{shell}
echo hello DataCamp!
```

ви отримаєте

```
hello DataCamp!
```

Якщо спробувати використати її, щоб вивести значення змінної ось так:

```{shell}
echo USER
```

вона виведе назву змінної, `USER`.

Щоб отримати значення змінної, потрібно поставити знак долара `$` перед її назвою. Якщо ввести 

```{shell}
echo $USER
```

буде надруковано

```
repl
```

Це працює всюди:
щоб отримати значення змінної з назвою `X`,
потрібно написати `$X`.
(Так оболонка може відрізнити, чи ви маєте на увазі «файл з назвою X»,
чи «значення змінної з назвою X».)

`@instructions`
Змінна `OSTYPE` містить назву типу операційної системи, якою ви користуєтеся.
Виведіть її значення за допомогою `echo`.

`@hint`
Викличте `echo` зі змінною `OSTYPE`, додавши перед нею `$`.

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
            has_code('echo', incorrect_msg="Ви викликали `echo`?"),
            has_code('OSTYPE', incorrect_msg="Ви вивели змінну середовища `OSTYPE`?"),
            has_code(r'\$OSTYPE', incorrect_msg="Переконайтеся, що перед `OSTYPE` стоїть `$`.")
        )
    )
)
Ex().success_msg("Відмінне відображення змінних середовища! Ви добре почали. Продовжимо!")
```

---

## Які ще способи зберігання інформації має shell?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Інший тип змінної називається **змінна shell**,
вона подібна до локальної змінної в мовах програмування.

Щоб створити змінну shell,
просто надайте імʼя та значення:

```{shell}
training=seasonal/summer.csv
```

*без* жодних пробілів до або після знака `=`.
Після цього ви можете перевірити значення змінної так:

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
Створіть змінну з назвою `testing` і значенням `seasonal/winter.csv`.

`@hint`
Між назвою змінної та її значенням не має бути пробілів.

`@solution`
```{shell}
testing=seasonal/winter.csv

```

`@sct`
```{python}
# For some reason, testing the shell variable directly always passes, so we can't do the following.
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
        has_code('testing', incorrect_msg='Ви визначили змінну оболонки з назвою `testing`?'),
        has_code('testing=', incorrect_msg='Ви написали `=` безпосередньо після testing, без пробілів?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Ви встановили значення `testing` на `seasonal/winter.csv`?')
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
Використайте `head -n 1 SOMETHING`, щоб отримати перший рядок з `seasonal/winter.csv`,
підставивши значення змінної `testing` замість назви файла.

`@hint`
Памʼятайте використовувати `$testing`, а не просто `testing`
(знак `$` потрібен, щоб отримати значення змінної).

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
    has_code(r'\$testing', incorrect_msg="Ви посилалися на змінну оболонки, використовуючи `$testing`?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Ви викликали `head`?"),
            has_code('-n', incorrect_msg="Ви обмежили кількість рядків за допомогою `-n`?"),
            has_code(r'-n\s+1', incorrect_msg="Ви обрали залишити 1 рядок за допомогою `-n 1`?")     
        )
    )
)
Ex().success_msg("Чудово! Давайте подивимося, як ви можете легко повторювати команди.")
```

---

## Як повторити команду багато разів?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Змінні shell також використовують у **циклах**,
які багаторазово повторюють команди.
Якщо запустити цю команду:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

вона виведе:

```
gif
jpg
png
```

Зверніть увагу на таке в циклі:

1. Структура: `for` ...змінна... `in` ...список... `; do` ...тіло... `; done`
2. Список елементів, які має опрацювати цикл (у нашому випадку слова `gif`, `jpg` і `png`).
3. Змінна, що відстежує, який саме елемент зараз опрацьовує цикл (у нашому випадку `filetype`).
4. Тіло циклу, яке виконує опрацювання (у нашому випадку `echo $filetype`).

Зауважте, що в тілі використано `$filetype`, щоб отримати значення змінної, а не просто `filetype`,
так само, як і з будь-якою іншою змінною shell.
Також зверніть увагу на крапки з комою:
перша стоїть між списком і ключовим словом `do`,
а друга — між тілом і ключовим словом `done`.

`@instructions`
Змініть цикл так, щоб він вивів:

```
docx
odt
pdf
```

Будь ласка, використайте `filetype` як назву змінної циклу.

`@hint`
Скористайтеся структурою коду з вступного тексту, замінивши типи файлів зображень на типи документів.

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
      has_code('for', incorrect_msg='Ви викликали `for`?'),
      has_code('filetype', incorrect_msg='Ви використали `filetype` як змінну циклу?'),
      has_code('in', incorrect_msg='Ви використали `in` перед списком типів файлів?'),
      has_code('docx odt pdf', incorrect_msg='Ви перебрали `docx`, `odt` та `pdf` у такому порядку?'),
      has_code(r'pdf\s*;', incorrect_msg='Ви поставили крапку з комою після останнього елемента циклу?'),
      has_code(r';\s*do', incorrect_msg='Ви використали `do` після першої крапки з комою?'),
      has_code('echo', incorrect_msg='Ви викликали `echo`?'),
      has_code(r'\$filetype', incorrect_msg='Ви вивели `$filetype`?'),
      has_code(r'filetype\s*;', incorrect_msg='Ви поставили крапку з комою після тіла циклу?'),
      has_code('; done', incorrect_msg='Ви завершили `done`?')
    )
  )
)
Ex().success_msg("Відмінно для циклу! Цикли чудові, якщо ви хочете виконати одну й ту ж дію сотні або тисячі разів.")
```

---

## Як повторити команду один раз для кожного файла?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Ви завжди можете вручну ввести назви файлів, які хочете обробити в циклі,
але зазвичай краще використовувати символи підстановки (wildcards).
Спробуйте запустити в консолі цей цикл:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Він виведе:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

тому що оболонка розгортає `seasonal/*.csv` у список з чотирьох назв файлів
перед тим, як запустити цикл.

`@instructions`
Змініть вираз із символами підстановки на `people/*`,
щоб цикл виводив назви файлів у каталозі `people`
незалежно від того, який суфікс вони мають або не мають.
Будь ласка, використовуйте `filename` як назву змінної циклу.

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
      has_code('for', incorrect_msg='Ви викликали `for`?'),
      has_code('filename', incorrect_msg='Ви використали `filename` як змінну циклу?'),
      has_code('in', incorrect_msg='Ви використали `in` перед списком типів файлів?'),
      has_code('people/\*', incorrect_msg='Ви вказали список файлів за допомогою `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='Ви поставили крапку з комою після списку файлів?'),
      has_code(r';\s*do', incorrect_msg='Ви використали `do` після першої крапки з комою?'),
      has_code('echo', incorrect_msg='Ви викликали `echo`?'),
      has_code(r'\$filename', incorrect_msg='Ви вивели `$filename` за допомогою echo?'),
      has_code(r'filename\s*;', incorrect_msg='Ви поставили крапку з комою після тіла циклу?'),
      has_code('; done', incorrect_msg='Ви завершили `done`?')
    )
  )
)
Ex().success_msg("Циклічне повторення! Символи підстановки та цикли утворюють потужну комбінацію.")
```

---

## Як записати назви набору файлів?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Часто змінну задають через шаблон з підстановкою, щоб зберегти список назв файлів.
Наприклад,
якщо ви визначите `datasets` ось так:

```{shell}
datasets=seasonal/*.csv
```

то згодом зможете вивести назви файлів за допомогою:

```{shell}
for filename in $datasets; do echo $filename; done
```

Це економить введення та зменшує ймовірність помилок.

<hr>

Якщо ви запустите ці дві команди у вашому домашньому каталозі,
скільки рядків виводу вони надрукують?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Жодного: оскільки `files` визначено в окремому рядку, воно не має значення в другому рядку.
- Один: слово «files».
- Чотири: назви всіх чотирьох файлів із сезонними даними.

`@hint`
Пам'ятайте: сам по собі `X` — це просто «X», а `$X` — це значення змінної `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Ні: вам не потрібно визначати змінну на тому ж рядку, де ви її використовуєте."
err2 = "Ні: у цьому прикладі змінна `files` визначається та використовується в тій самій оболонці."
correct3 = "Вірно. Команда еквівалентна `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Ім'я змінної проти її значення

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Поширена помилка — забути поставити `$` перед іменем змінної.
Коли ви так робите,
оболонка використовує набране вами ім'я,
а не значення цієї змінної.

Ще поширеніша помилка в досвідчених користувачів — помилитися в написанні імені змінної.
Наприклад,
якщо ви оголосите `datasets` так:

```{shell}
datasets=seasonal/*.csv
```

а потім наберете:

```{shell}
echo $datsets
```

оболонка нічого не виведе,
бо `datsets` (без другої «a») не визначено.

<hr>

Якби ви запустили ці дві команди у своїй домашній теці,
який був би вивід?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Перш ніж відповісти, уважно прочитайте першу частину циклу.)

`@hint`
Пам'ятайте: сам по собі `X` — це просто «X», тоді як `$X` — це значення змінної `X`.

`@possible_answers`
- [Один рядок: слово «files».]
- Чотири рядки: назви всіх чотирьох файлів із сезонними даними.
- Чотири порожні рядки: змінній `f` не присвоєно значення.

`@feedback`
- Правильно: у циклі використано `files` замість `$files`, тож список складається зі слова «files».
- Ні: у циклі використано `files` замість `$files`, тож список складається зі слова «files», а не з підстановки `files`.
- Ні: змінну `f` автоматично визначає цикл `for`.

---

## Як запустити багато команд в одному циклі?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Друкувати назви файлів корисно для налагодження,
але справжня мета циклів — виконувати дії з багатьма файлами.
Ось цикл, що виводить другий рядок кожного файла з даними:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Він має ту саму структуру, що й інші цикли, які ви вже бачили:
єдина відмінність у тому, що його тіло — це конвеєр із двох команд, а не одна команда.

`@instructions`
Напишіть цикл, який виводить останній запис за липень 2017 (`2017-07`) у кожному сезонному файлі. Він має давати схожий результат на:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

але окремо для **_кожного_** сезонного файла. Використайте `file` як імʼя змінної циклу та не забудьте ітеруватися списком файлів `seasonal/*.csv` (_замість 'seasonal/winter.csv', як у прикладі_).

`@hint`
Тіло циклу — це команда grep, показана в інструкціях, але з підстановкою `$file` замість `seasonal/winter.csv`.

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
  has_code('for', incorrect_msg='Ви викликали `for`?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Ви використали `file` як змінну циклу?'),
      has_code('in', incorrect_msg='Ви використали `in` перед списком файлів?'),
      has_code('seasonal/\*', incorrect_msg='Ви вказали список файлів за допомогою `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Ви поставили крапку з комою після списку файлів?'),
      has_code(r';\s*do', incorrect_msg='Ви використали `do` після першої крапки з комою?'),
      has_code('grep', incorrect_msg='Ви викликали `grep`?'),
      has_code('2017-07', incorrect_msg='Ви здійснили пошук за `2017-07`?'),
      has_code(r'\$file', incorrect_msg='Ви використали `$file` як ім\'я змінної циклу?'),
      has_code(r'file\s*|', incorrect_msg='Ви використали конвеєр для з\'єднання вашої другої команди?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Ви використали `tail -n 1` для виведення останнього запису кожного пошуку у вашій другій команді?'),
      has_code('; done', incorrect_msg='Ви завершили `done`?')
    )
  )
)

Ex().success_msg("Циклічне повторення! Символи підстановки та цикли утворюють потужну комбінацію.")
```

---

## Чому не варто використовувати пробіли в назвах файлів?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Коли ви користуєтеся графічним провідником файлів, давати файлам багатослівні назви на кшталт `July 2017.csv` — це легко й логічно.
Однак у командній оболонці це створює проблеми.
Наприклад, припустімо, ви хочете перейменувати `July 2017.csv` на `2017 July data.csv`.
Ви не можете ввести:

```{shell}
mv July 2017.csv 2017 July data.csv
```

бо для оболонки це виглядає так, ніби ви намагаєтеся перемістити
чотири файли з назвами `July`, `2017.csv`, `2017` і знову `July`
до каталогу з назвою `data.csv`.
Натомість потрібно взяти назви файлів у лапки,
щоб оболонка сприймала кожну назву як один параметр:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Якщо у вас є два файли `current.csv` і `last year.csv`
(з пробілом у назві), і ви введете:

```{shell}
rm current.csv last year.csv
```

що відбудеться:

`@hint`
Що б ви подумали, що станеться, якби вам показали цю команду, а ви не знали, які файли існують?

`@possible_answers`
- Оболонка виведе повідомлення про помилку, тому що `last` і `year.csv` не існують.
- Оболонка видалить `current.csv`.
- [Обидва варіанти.]
- Нічого.

`@feedback`
- Так, але це ще не все.
- Так, але це ще не все.
- Правильно. Ви можете взяти назви файлів у одинарні лапки, `'`, або в подвійні лапки, `"`.
- На жаль, ні.

---

## Як виконати багато дій в одному циклі?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Цикли, які ви бачили до цього, містили лише одну команду або конвеєр у тілі,
але цикл може містити будь-яку кількість команд.
Щоб підказати оболонці, де закінчується одна команда і починається наступна,
потрібно розділяти їх крапкою з комою:

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

Припустімо, ви забули крапку з комою між командами `echo` і `head` у попередньому циклі,
і попросили оболонку виконати:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Що зробить оболонка?

`@possible_answers`
- Виведе повідомлення про помилку.
- Виведе по одному рядку для кожного з чотирьох файлів.
- Виведе один рядок для `autumn.csv` (першого файлу).
- Виведе останній рядок кожного файлу.

`@hint`
Ви можете передати вивід `echo` через конвеєр до `tail`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Ні: цикл буде виконуватися, просто він не робитиме нічого розумного."
correct2 = "Так: `echo` створює один рядок, який містить ім'я файлу двічі, який `tail` потім копіює."
err3 = "Ні: цикл виконується один раз для кожного з чотирьох імен файлів."
err4 = "Ні: вхідні дані для `tail` - це вихідні дані `echo` для кожного імені файлу."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

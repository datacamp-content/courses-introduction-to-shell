---
title: Поєднання інструментів
description: >-
  Справжня сила оболонки Unix — не в окремих командах, а в тому, як легко
  поєднувати їх для нових завдань. У цьому розділі ви навчитеся використовувати
  цю можливість, щоб вибирати потрібні дані, а також познайомитеся з командами
  для сортування значень і видалення дублікатів.
lessons:
  - nb_of_exercises: 12
    title: Як зберегти результат виконання команди у файл?
---

## Як зберегти вивід команди у файл?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

У всіх інструментів, які ви бачили досі, можна вказати вхідні файли.
Більшість не мають опції для назви вихідного файла, бо вона їм не потрібна.
Натомість
можна використати **перенаправлення**, щоб зберегти вивід будь-якої команди куди завгодно.
Якщо запустити цю команду:

```{shell}
head -n 5 seasonal/summer.csv
```

вона виведе на екран перші 5 рядків літніх даних.
Якщо ж запустити цю команду:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

на екрані нічого не зʼявиться.
Натомість
вивід `head` буде записано в новий файл `top.csv`.
Переглянути вміст цього файла можна за допомогою `cat`:

```{shell}
cat top.csv
```

Знак «більше» `>` наказує оболонці перенаправити вивід `head` у файл.
Він не є частиною команди `head`;
зате
працює з будь-якою командою оболонки, що створює вивід.

`@instructions`
Поєднайте `tail` із перенаправленням, щоб зберегти останні 5 рядків з `seasonal/winter.csv` у файл `last.csv`.

`@hint`
Скористайтеся `tail -n 5`, щоб отримати останні 5 рядків.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "Рядок `%s` повинен бути у файлі `last.csv`, але його немає. Перенаправте вивід `tail -n 5 seasonal/winter.csv` до `last.csv` за допомогою `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` має занадто багато рядків. Ви використали прапорець `-n 5` з `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Чудово! Давайте попрактикуємося ще!")
```

---

## Як використати вивід команди як вхідні дані?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Припустімо, ви хочете отримати рядки з середини файлу.
Точніше,
припустімо, вам потрібні рядки 3–5 з одного з наших файлів даних.
Можна почати з використання `head`, щоб отримати перші 5 рядків,
переспрямувати їх у файл,
а потім застосувати `tail`, щоб вибрати останні 3:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Швидка перевірка підтверджує, що це рядки 3–5 з нашого початкового файлу,
адже це останні 3 рядки з перших 5.

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
Виберіть останні два рядки з `seasonal/winter.csv`
і збережіть їх у файлі з назвою `bottom.csv`.

`@hint`
Скористайтеся `tail`, щоб вибрати рядки, і `>`, щоб переспрямувати вивід `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="Рядок `%s` має бути у файлі `bottom.csv`, але його там немає. Перенаправте вивід `tail -n 2 seasonal/winter.csv` до `bottom.csv` за допомогою `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` має занадто багато рядків. Чи використовували Ви прапорець `-n 2` з `tail`?'),
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
Виберіть перший рядок з `bottom.csv`,
щоб отримати передостанній рядок початкового файлу.

`@hint`
Скористайтеся `head`, щоб вибрати потрібний рядок.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Щось не так із файлом `bottom.csv`. Переконайтеся, що Ви його не змінюєте!"),
    has_expr_output(strict=True, incorrect_msg="Ви правильно використали `head` на `bottom.csv`? Переконайтеся, що правильно використовуєте прапорець `-n`.")
)

Ex().success_msg("Чудово. Перейдіть до наступної вправи, щоб дізнатися про кращі способи комбінування команд.")                             

```

---

## Як краще поєднувати команди?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

У поєднання команд через перенаправлення є два недоліки:

1. Залишається багато проміжних файлів (наприклад, `top.csv`).
2. Команди для отримання підсумкового результату розкидані по кількох рядках історії.

У shell є інший інструмент, який розв'язує обидві ці проблеми одночасно, — це **pipe** (конвеєр).
Ще раз
почніть із запуску `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

Замість надсилання виводу `head` у файл
додайте вертикальну риску та команду `tail` *без* імені файлу:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Символ конвеєра вказує shell використати вивід команди ліворуч
як вхід для команди праворуч.

`@instructions`
Скористайтеся `cut`, щоб вибрати всі назви зубів із 2-го стовпця у файлі з комами-роздільниками `seasonal/summer.csv`, а потім передайте результат через конвеєр до `grep` з інверсією збігу, щоб вилучити заголовок із словом «Tooth». *`cut` і `grep` детально розглянуті у Розділі 2, вправах 8 і 11 відповідно.*

`@hint`
- Перша частина команди має вигляд `cut -d field_delimiter -f column_number filename`.
- Друга частина команди має вигляд `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'Чи передали Ви результат `cut -d , -f 2 seasonal/summer.csv` у `grep -v Tooth` за допомогою `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Чи виключили Ви рядок заголовка `"Tooth"` за допомогою `grep`?')
)
Ex().success_msg("Ідеальне використання конвеєра! Можливо, це перший раз, коли Ви використовуєте `|`, але точно не останній!")
```

---

## Як поєднати багато команд?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Ви можете послідовно з'єднати будь-яку кількість команд.
Наприклад,
ця команда:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

виконає таке:

1. вибере перший стовпець із весняних даних;
2. вилучить рядок заголовка, що містить слово «Date»; і
3. вибере перші 10 рядків реальних даних.

`@instructions`
У попередній вправі ви використали таку команду, щоб вибрати всі назви зубів із стовпця 2 файлу `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Розширте цей конвеєр командою `head`, щоб вибрати лише саму першу назву зуба.

`@hint`
Скопіюйте й вставте код з інструкцій, додайте вертикальну риску, потім викличте `head` із прапорцем `-n`.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Чи використовували Ви `|`, щоб розширити конвеєр командою `head`? Переконайтеся, що прапор `-n` встановлено правильно."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Чи використовували Ви `|`, щоб розширити конвеєр командою `head`?")
)
Ex().success_msg("Радісне з'єднання! Об'єднуючи кілька команд разом, Ви можете створювати потужні конвеєри для обробки даних.")
```

---

## Як порахувати кількість записів у файлі?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Команда `wc` (скорочення від «word count») виводить кількість **c**имволів, **w**слів і **l**рядків у файлі.
Ви можете змусити її виводити лише один із цих показників, використавши відповідно `-c`, `-w` або `-l`.

`@instructions`
Порахуйте, скільки записів у `seasonal/spring.csv` мають дати за липень 2017 року (`2017-07`). 
- Для цього скористайтеся `grep` із частковою датою, щоб вибрати потрібні рядки, і передайте результат через конвеєр у `wc` з відповідним прапорцем для підрахунку рядків.

`@hint`
- Використайте `head seasonal/spring.csv`, щоб пригадати формат дати.
- Перша частина команди має вигляд `grep thing_to_match filename`.
- Після конвеєра `|` викличте `wc` із прапорцем `-l`.

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
      has_code("grep", incorrect_msg = "Ви викликали `grep`?"),
      has_code("2017-07", incorrect_msg = "Ви шукали `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Ви шукали файл `seasonal/spring.csv`?"),
      has_code("|", incorrect_msg = "Ви передали в `wc` за допомогою `|`?"),      
      has_code("wc", incorrect_msg = "Ви викликали `wc`?"),
      has_code("-l", incorrect_msg = "Ви підрахували кількість рядків за допомогою `-l`?")
    )
  )
)
Ex().success_msg("Уважний підрахунок! Визначення обсягу даних - це чудовий перший крок у будь-якому аналізі даних.")
```

---

## Як вказати багато файлів одночасно?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

Більшість команд оболонки працюють з кількома файлами, якщо передати їм кілька назв файлів.
Наприклад,
можна отримати перший стовпчик одразу з усіх сезонних файлів даних так:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Але багаторазово набирати назви файлів — погана ідея:
це витрачає час,
і рано чи пізно ви або пропустите файл, або повторите назву файла.
Щоб спростити роботу,
оболонка дає змогу використовувати **підстановні символи** (wildcards), щоб задати список файлів одним виразом.
Найпоширеніший підстановний символ — `*`,
який означає «відповідає нулю або більшій кількості символів».
З його допомогою
ми можемо скоротити наведену вище команду `cut` до такого варіанта:

```{shell}
cut -d , -f 1 seasonal/*
```

або:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Напишіть одну команду з `head`, щоб отримати перші три рядки як з `seasonal/spring.csv`, так і з `seasonal/summer.csv` — усього шість рядків даних, але не з осіннього чи зимового файлів даних.
Використайте підстановний символ, а не прописуйте повні назви файлів.

`@hint`
- Команда має вигляд `head -n number_of_lines filename_pattern`.
- Наприклад, можна підібрати файли в каталозі `a`, що починаються на `b`, так: `a/b*`.

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
    has_expr_output(incorrect_msg = "Ви можете використовувати `seasonal/s*` для вибору `seasonal/spring.csv` та `seasonal/summer.csv`. Переконайтеся, що включили лише перші три рядки кожного файлу за допомогою прапора `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Не включайте вивід для `seasonal/autumn.csv`. Ви можете використовувати `seasonal/s*` для вибору `seasonal/spring.csv` та `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Не включайте вивід для `seasonal/winter.csv`. Ви можете використовувати `seasonal/s*` для вибору `seasonal/spring.csv` та `seasonal/summer.csv`")
)
Ex().success_msg("Чудова робота з використанням шаблонів! Це стає ще важливішим, якщо ваш каталог містить сотні або тисячі файлів.")
```

---

## Які ще шаблони-замінники можна використовувати?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

У оболонці є й інші шаблони-замінники, хоча їх використовують рідше:

- `?` відповідає одному символу, тож `201?.txt` збігатиметься з `2017.txt` або `2018.txt`, але не з `2017-01.txt`.
- `[...]` відповідає будь-якому одному символу з наведених у квадратних дужках, тож `201[78].txt` збігатиметься з `2017.txt` або `2018.txt`, але не з `2016.txt`.
- `{...}` відповідає будь-якому зі зразків, розділених комами, у фігурних дужках, тож `{*.txt, *.csv}` збігатиметься з будь-яким файлом, назва якого закінчується на `.txt` або `.csv`, але не з файлами, чиї назви закінчуються на `.pdf`.

<hr/>

Який вираз збігатиметься з `singh.pdf` і `johel.txt`, але не з `sandhu.pdf` або `sandhu.txt`?

`@hint`
Послідовно зіставте кожен вираз із кожною назвою файла.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Ні: `.pdf` і `.txt` — це не назви файлів.
- Ні: цей вираз також збігатиметься з `sandhu.pdf`.
- Ні: вираз у квадратних дужках відповідає лише одному символу, а не цілим словам.
- Правильно!

---

## Як відсортувати рядки тексту?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Як підказує назва,
`sort` упорядковує дані.
Типово це відбувається у зростальному алфавітному порядку,
але прапорці `-n` і `-r` дають змогу сортувати за числовим значенням і виводити в зворотному порядку відповідно,
тоді як `-b` наказує ігнорувати початкові пропуски,
а `-f` — **f**old case (тобто не зважати на регістр).
У конвеєрах часто спершу використовують `grep`, щоб прибрати непотрібні записи,
а потім `sort`, щоб упорядкувати решту.

`@instructions`
Пам'ятаєте поєднання `cut` і `grep`, щоб вибрати всі назви зубів із 2‑го стовпця файлу `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Почніть із цього рецепту та відсортуйте назви зубів у файлі `seasonal/winter.csv` (не `summer.csv`) у спадному алфавітному порядку. Для цього розширте конвеєр кроком `sort`.

`@hint`
Скопіюйте й вставте команду з інструкцій, змініть імʼя файлу, додайте конвеєр, потім викличте `sort` із прапорцем `-r`.

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
      has_code("cut", incorrect_msg = "Ви викликали `cut`?"),
      has_code("-d", incorrect_msg = "Ви вказали роздільник полів за допомогою `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Ви отримали дані з файлу `seasonal/winter.csv`?"),
      has_code("|", incorrect_msg = "Ви використовували конвеєр від `cut` до `grep` до `sort` за допомогою `|`?"),      
      has_code("grep", incorrect_msg = "Ви викликали `grep`?"),
      has_code("-v", incorrect_msg = "Ви інвертували збіг за допомогою `-v`?"),
      has_code("Tooth", incorrect_msg = "Ви шукали `Tooth`?"),
      has_code("sort", incorrect_msg = "Ви викликали `sort`?"),
      has_code("-r", incorrect_msg = "Ви змінили порядок сортування на зворотний за допомогою `-r`?")
    )
  )
)
Ex().success_msg("Відсортовано! `sort` має багато застосувань. Наприклад, конвеєр `sort -n` до `head` показує вам найбільші значення.")
```

---

## Як вилучити дублікати рядків?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Ще одна команда, яку часто використовують із `sort`, — це `uniq`,
завдання якої — вилучати повторювані рядки.
Точніше кажучи,
вона прибирає лише *суміжні* дублікати рядків.
Якщо файл містить:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

то `uniq` виведе:

```
2017-07-03
2017-08-03
```

але якщо він містить:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

тоді `uniq` надрукує всі чотири рядки.
Причина в тому, що `uniq` створено для роботи з дуже великими файлами.
Щоб вилучити несуміжні дублікати з файла,
їй довелося б тримати в пам'яті весь файл
(або принаймні
усі унікальні рядки, які вже зустрілися).
Прибираючи лише суміжні дублікати,
вона має зберігати в пам'яті лише останній унікальний рядок.

`@instructions`
Напишіть конвеєр, щоб:

- отримати другий стовпець із `seasonal/winter.csv`,
- прибрати слово "Tooth" з виводу, щоб залишилися лише назви зубів,
- відсортувати вивід так, щоб усі входження певної назви зуба були суміжними; та
- показати кожну назву зуба один раз разом із кількістю її появ.

Початок вашого конвеєра такий самий, як у попередній вправі:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Доповніть його командою `sort`, а також використайте `uniq -c`, щоб показати унікальні рядки разом із кількістю появ кожного, замість використання `uniq` і `wc`.

`@hint`
Скопіюйте й вставте команду з інструкцій, передайте в конвеєрі до `sort` без прапорів, потім ще раз передайте в конвеєрі до `uniq` з прапором `-c`.

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
                     incorrect_msg="Ви повинні почати з цієї команди: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Тепер розширте її!"),
            has_code('\|\s+sort', incorrect_msg="Ви розширили команду за допомогою `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="Ви розширили команду за допомогою `| uniq`?"),
            has_code('-c', incorrect_msg="Ви включили підрахунки за допомогою `-c`?")
        )
    )
)
Ex().success_msg("Чудово! Після всієї цієї роботи з конвеєром було б непогано, якби ми могли зберегти результат, чи не так?")
```

---

## Як зберегти вивід конвеєра?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Оболонка дає змогу перенаправити вивід послідовності з'єднаних конвеєром команд:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Однак `>` має стояти наприкінці конвеєра:
якщо спробувати використати його посередині, ось так:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

то весь вивід `cut` буде записано до `teeth-only.txt`,
тож для `grep` нічого не залишиться,
і він безкінечно чекатиме на вхідні дані.

<hr>

Що станеться, якщо поставити перенаправлення на початку конвеєра, як тут:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [Вивід команди буде, як зазвичай, перенаправлено у файл.]
- Оболонка повідомить про помилку.
- Оболонка безкінечно чекатиме на вхідні дані.

`@hint`
Спробуйте це в оболонці.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Правильно!', 'Ні; оболонка насправді може виконати це.', 'Ні; оболонка насправді може виконати це.'])
```

---

## Як зупинити запущену програму?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Команди та скрипти, які ви запускали досі, виконувалися швидко,
але деякі завдання можуть тривати хвилини, години або навіть дні.
Ви також можете помилково поставити перенаправлення посеред конвеєра,
через що він «зависне».
Якщо ви вирішили, що програма не має продовжувати роботу,
натисніть `Ctrl` + `C`, щоб завершити її.
У документації Unix це часто позначають як `^C`;
зверніть увагу, що літера «c» може бути малою.

`@instructions`
Запустіть команду:

```{shell}
head
```

без аргументів (щоб вона чекала на вхідні дані, яких ніколи не буде)
і тоді зупиніть її, натиснувши `Ctrl` + `C`.

`@hint`
Просто введіть head, натисніть Enter і завершіть роботу запущеної програми за допомогою `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Ви використали `head`?")
```

---

## Підсумуємо

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

На завершення
ви створите конвеєр, щоб з'ясувати, скільки записів у найкоротшому з файлів сезонних даних.

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
Скористайтеся `wc` з відповідними параметрами, щоб вивести кількість рядків у всіх сезонних файлах даних.
(Використайте шаблон з підстановкою для імен файлів замість того, щоб вводити їх вручну.)

`@hint`
Використайте `-l`, щоб показати лише кількість рядків, і `*`, щоб зіставити імена файлів.

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
      has_code("wc", incorrect_msg = "Ви викликали `wc`?"),
      has_code("-l", incorrect_msg = "Ви підрахували кількість рядків за допомогою `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Ви отримали дані з усіх файлів `seasonal/*`?")
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
Додайте ще одну команду до попередньої, використавши пайп, щоб прибрати рядок, який містить слово «total».

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
      has_code("wc", incorrect_msg = "Ви викликали `wc`?"),
      has_code("-l", incorrect_msg = "Ви підрахували кількість рядків за допомогою `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Ви отримали дані з усіх файлів `seasonal/*`?"),
      has_code("|", incorrect_msg = "Ви передали дані з `wc` до `grep` за допомогою `|`?"),      
      has_code("grep", incorrect_msg = "Ви викликали `grep`?"),
      has_code("-v", incorrect_msg = "Ви інвертували збіг за допомогою `-v`?"),
      has_code("total", incorrect_msg = "Ви шукали `total`?")
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
Додайте ще два етапи до конвеєра, використавши `sort -n` і `head -n 1`, щоб знайти файл із найменшою кількістю рядків.

`@hint`
- Використайте прапорець `-n` команди `sort`, щоб сортувати чисельно.
- Використайте прапорець `-n` команди `head`, щоб обмежити вивід 1 рядком.

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
      has_code("wc", incorrect_msg = "Ви викликали `wc`?"),
      has_code("-l", incorrect_msg = "Ви підрахували кількість рядків за допомогою `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Ви отримали дані з усіх файлів `seasonal/*`?"),
      has_code("|", incorrect_msg = "Ви використовували конвеєр від `wc` до `grep` до `sort` до `head` за допомогою `|`?"),      
      has_code("grep", incorrect_msg = "Ви викликали `grep`?"),
      has_code("-v", incorrect_msg = "Ви інвертували збіг за допомогою `-v`?"),
      has_code("total", incorrect_msg = "Ви шукали `total`?"),
      has_code("sort", incorrect_msg = "Ви викликали `sort`?"),
      has_code("-n", incorrect_msg = "Ви вказали кількість рядків, які потрібно залишити, за допомогою `-n`?"),
      has_code("1", incorrect_msg = "Ви вказали 1 рядок, який потрібно залишити, за допомогою `-n 1`?")
    )
  )
)
Ex().success_msg("Чудово! Виявляється, `autumn.csv` - це файл з найменшою кількістю рядків. Поспішайте до розділу 4, щоб дізнатися більше про пакетну обробку!")
```

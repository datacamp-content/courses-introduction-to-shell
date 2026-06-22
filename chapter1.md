---
title: Робота з файлами та каталогами
description: >-
  Цей розділ — короткий вступ до оболонки Unix. Ви дізнаєтеся, чому її й досі
  використовують після майже 50 років, чим вона відрізняється від графічних
  інструментів, до яких ви могли звикнути, як пересуватися в оболонці, а також
  як створювати, змінювати й видаляти файли та теки.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Чим оболонка відрізняється від інтерфейсу робочого столу?
---

## Як shell порівнюється з інтерфейсом стільниці?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Операційна система на кшталт Windows, Linux або Mac OS — це особливий тип програми.
Вона керує процесором комп'ютера, жорстким диском і мережевим з'єднанням,
але її найважливіше завдання — запускати інші програми.

Оскільки люди не є цифровими,
їм потрібен інтерфейс для взаємодії з операційною системою.
Найпоширеніший сьогодні — графічний файловий провідник,
який перетворює клацання та подвійні клацання на команди для відкриття файлів і запуску програм.
До появи графічних дисплеїв
люди вводили інструкції в програму під назвою **командний інтерпретатор (command-line shell)**.
Щоразу, коли вводять команду,
shell запускає інші програми,
виводить їхні результати у зручному для читання вигляді,
а потім показує *запрошення* (prompt), сигналізуючи, що готовий прийняти наступну команду.
(Назва походить від уявлення, що це «зовнішня оболонка» комп'ютера.)

Набирання команд замість клацань і перетягувань може спершу здаватися незручним,
але, як ви побачите,
коли ви починаєте чітко формулювати, що саме комп'ютер має зробити,
ви можете поєднувати наявні команди, щоб створювати нові
та автоматизувати повторювані дії
лише кількома натисканнями клавіш.

<hr>
Який зв'язок між графічним файловим провідником, яким користується більшість людей, і командним інтерпретатором (shell)?

`@hint`
Пам'ятайте, що користувач може взаємодіяти з операційною системою лише через програму.

`@possible_answers`
- Файловий провідник дає змогу переглядати й редагувати файли, а shell — запускати програми.
- Файловий провідник побудований поверх shell.
- Shell є частиною операційної системи, а файловий провідник — окремо.
- [Обидва є інтерфейсами для надсилання команд операційній системі.]

`@feedback`
- Обидва дають змогу переглядати й редагувати файли та запускати програми.
- Графічні файлові провідники та shell викликають ті самі базові функції операційної системи.
- І shell, і файловий провідник — це програми, які перекладають команди користувача (набрані з клавіатури чи клацаннями) на виклики до операційної системи.
- Правильно! Обидва отримують команди користувача (чи то набрані, чи клацаннями) і передають їх операційній системі.

---

## Де я зараз?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**Файлова система** керує файлами та каталогами (папками).
Кожен елемент має **абсолютний шлях**,
який показує, як дістатися до нього від **кореневого каталогу** файлової системи:
`/home/repl` — це каталог `repl` у каталозі `home`,
а `/home/repl/course.txt` — це файл `course.txt` у цьому каталозі,
а сам по собі `/` — це кореневий каталог.

Щоб дізнатися, де ви перебуваєте у файловій системі,
запустіть команду `pwd`
(скорочення від "**p**rint **w**orking **d**irectory" — «вивести робочий каталог»).
Вона виведе абсолютний шлях до вашого **поточного робочого каталогу**,
де оболонка зазвичай виконує команди та шукає файли.

<hr>
Запустіть `pwd`.
Де ви зараз?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
У системах Unix зазвичай усі домашні каталоги користувачів містяться всередині `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Це неправильний шлях."
correct = "Вірно - ви знаходитесь у `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Як відрізнити файли від каталогів?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` показує, де ви зараз.
Щоб дізнатися, що там є,
наберіть `ls` (скорочення від "**l**i**s**ting") і натисніть Enter.
Якщо запустити без аргументів,
`ls` перелічить вміст вашого поточного каталогу
(того, який показує `pwd`).
Якщо додати імена файлів,
`ls` перелічить саме їх,
а якщо додати імена каталогів,
перелічить їхній вміст.
Наприклад,
`ls /home/repl` показує, що міститься у вашому початковому каталозі
(його зазвичай називають **домашнім каталогом**).

<hr>
Скористайтеся `ls` з відповідним аргументом, щоб перелічити файли в каталозі `/home/repl/seasonal`
(у ньому зберігається інформація про стоматологічні операції за датами, розподілена за сезонами).
Якого з перелічених файлів у цьому каталозі немає?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Якщо ви передасте `ls` шлях, вона покаже, що міститься за цим шляхом.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Цей файл знаходиться в каталозі `seasonal`."
correct = "Вірно - цей файл *не* знаходиться в каталозі `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Якими ще способами можна ідентифікувати файли й каталоги?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Абсолютний шлях подібний до широти й довготи: він має те саме значення, де б ви не були. **Відносний шлях**, своєю чергою, задає розташування, відштовхуючись від поточного місця: це як сказати «20 кілометрів на північ».

Наприклад:
- Якщо ви в каталозі `/home/repl`, то **відносний** шлях `seasonal` указує на той самий каталог, що й **абсолютний** шлях `/home/repl/seasonal`. 
- Якщо ви в каталозі `/home/repl/seasonal`, то **відносний** шлях `winter.csv` указує на той самий файл, що й **абсолютний** шлях `/home/repl/seasonal/winter.csv`.

Командна оболонка визначає, чи шлях абсолютний, чи відносний, за першим символом: якщо шлях починається з `/`, він абсолютний. Якщо він *не* починається з `/`, він відносний.

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
Ви перебуваєте в `/home/repl`. Використайте `ls` із **відносним шляхом**, щоб вивести файл, абсолютний шлях до якого — `/home/repl/course.txt` (і тільки цей файл).

`@hint`
Часто можна побудувати відносний шлях до файла або каталогу нижче поточного розташування,
віднявши абсолютний шлях вашого поточного місця
від абсолютного шляху об'єкта, який потрібен.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Ви не викликали `ls`, щоб створити список файлів."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Ваша команда не створила правильний список файлів. Використовуйте `ls`, за яким слідує відносний шлях до `/home/repl/course.txt`.")
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
Ви перебуваєте в `/home/repl`.
Використайте `ls` із **відносним** шляхом,
щоб вивести файл `/home/repl/seasonal/summer.csv` (і тільки цей файл).

`@hint`
Відносні шляхи *не* починаються з початкового символу '/'.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Ви не викликали `ls`, щоб створити список файлів."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Ваша команда не створила правильний список файлів. Використовуйте `ls`, за яким слідує відносний шлях до `/home/repl/seasonal/summer.csv`.")
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
Ви перебуваєте в `/home/repl`.
Використайте `ls` із **відносним** шляхом,
щоб вивести вміст каталогу `/home/repl/people`.

`@hint`
Відносні шляхи не починаються з початкового символу '/'.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Ви не викликали `ls`, щоб створити список файлів."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Ваша команда не створила правильний список файлів. Використовуйте `ls`, за яким слідує відносний шлях до `/home/repl/people`.")
    )
)
Ex().success_msg("Чудово. Тепер, коли Ви знаєте, як перераховувати файли та каталоги, давайте подивимося, як Ви можете переміщатися по файловій системі!")
```

---

## Як перейти до іншого каталогу?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Так само, як ви переходите між папками у файловому переглядачі подвійним клацанням,
у файловій системі можна переміщатися командою `cd`
(скорочення від "change directory" — змінити каталог).

Якщо ввести `cd seasonal`, а потім `pwd`,
оболонка повідомить, що ви зараз у `/home/repl/seasonal`.
Якщо після цього запустити `ls` без аргументів,
ви побачите вміст `/home/repl/seasonal`,
адже саме там ви перебуваєте.
Щоб повернутися до вашого домашнього каталогу `/home/repl`,
скористайтеся командою `cd /home/repl`.

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
Ви в каталозі `/home/repl`.
Перейдіть до `/home/repl/seasonal`, використовуючи відносний шлях.

`@hint`
Пам'ятайте, що `cd` означає "change directory" і що відносні шляхи не починаються зі скісної риски '/'.

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
key: e69c8eac15
xp: 35
```

`@instructions`
Скористайтеся `pwd`, щоб перевірити, що ви там.

`@hint`
Не забудьте натиснути "enter" або "return" після введення команди.

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
Виконайте `ls` без шляхів, щоб переглянути вміст цього каталогу.

`@hint`
Не забудьте натиснути "enter" або "return" після команди.

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
      has_code('ls', incorrect_msg="Ваша команда не створила правильний вивід. Чи використовували Ви `ls` без шляхів, щоб показати вміст поточної директорії?")
    )
)

Ex().success_msg("Чудово! Це було про навігацію до підкаталогів. А як щодо переміщення вгору? Давайте дізнаємося!")
```

---

## Як піднятися на рівень вище в ієрархії каталогів?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

**Батьківський** каталог — це каталог над поточним.
Наприклад, `/home` є батьківським для `/home/repl`,
а `/home/repl` — батьківським для `/home/repl/seasonal`.
Ви завжди можете вказати абсолютний шлях до батьківського каталогу в командах на кшталт `cd` і `ls`.
Частіше ж
ви скористаєтеся тим, що спеціальний шлях `..`
(дві крапки без пробілів) означає «каталог на рівень вище від поточного».
Якщо ви в `/home/repl/seasonal`,
то `cd ..` підніме вас до `/home/repl`.
Якщо ще раз використаєте `cd ..`,
ви опинитеся в `/home`.
Ще одне `cd ..` переведе вас до *кореневого каталогу* `/`,
який є самою верхівкою файлової системи.
(Пам'ятайте про пробіл між `cd` і `..` — це команда та шлях, а не одна чотирилітерна команда.)

Окрема крапка, `.` — це завжди «поточний каталог»,
тому `ls` саме по собі та `ls .` роблять те саме,
а `cd .` не має ефекту
(адже воно переводить вас у каталог, у якому ви вже перебуваєте).

Ще один спеціальний шлях — це `~` (символ тильда),
який означає «ваш домашній каталог»,
наприклад `/home/repl`.
Де б ви не були,
`ls ~` завжди покаже вміст вашого домашнього каталогу,
а `cd ~` завжди поверне вас додому.

<hr>
Якщо ви в `/home/repl/seasonal`,
куди приведе `cd ~/../.`?

`@hint`
Відстежуйте шлях по одному каталогу за раз.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (кореневий каталог)

`@feedback`
- Ні, але самі по собі `~` або `..` відвели б вас туди.
- Правильно! Шлях означає «домашній каталог», «на рівень вище», «тут».
- Ні, але сам по собі `.` зробив би саме це.
- Ні, остання частина шляху — це `.` (означає «тут»), а не `..` (означає «на рівень вище»).

---

## Як скопіювати файли?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Вам часто знадобиться копіювати файли,
переміщувати їх в інші каталоги для впорядкування
або перейменовувати.
Одна з команд для цього — `cp` (скорочення від "copy").
Якщо `original.txt` — це наявний файл,
то:

```{shell}
cp original.txt duplicate.txt
```

створює копію `original.txt` з назвою `duplicate.txt`.
Якщо файл із назвою `duplicate.txt` уже існував,
він буде перезаписаний.
Якщо останній параметр `cp` — це наявний каталог,
тоді команда на кшталт:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

копіює всі ці файли до цього каталогу.

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
Створіть копію `seasonal/summer.csv` у каталозі `backup` (який також розташований у `/home/repl`),
надавши новому файлу назву `summer.bck`.

`@hint`
Об'єднайте назву цільового каталогу та назву копійованого файлу,
щоб утворити відносний шлях для нового файлу.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` не існує в каталозі `backup`. Вкажіть два шляхи для `cp`: існуючий файл (`seasonal/summer.csv`) та файл призначення (`backup/summer.bck`)."),
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
Скопіюйте `spring.csv` і `summer.csv` з каталогу `seasonal` до каталогу `backup`
не змінюючи вашу поточну робочу теку (`/home/repl`).

`@hint`
Використайте `cp` із назвами файлів, які хочете скопіювати,
а потім вкажіть назву каталогу, куди їх копіювати.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` не виглядає скопійованим у директорію `backup`. Вкажіть два імені файлів та ім'я директорії для `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Переконайтеся, що файли скопійовані, перебуваючи в `{{dir}}`! Використовуйте `cd {{dir}}`, щоб повернутися туди."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Гарна робота. Окрім копіювання, ми також повинні вміти переміщувати файли з однієї директорії в іншу. Дізнайтеся про це в наступній вправі!")
```

---

## Як перемістити файл?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Хоча `cp` копіює файл,
`mv` переміщує його з одного каталогу до іншого,
так само, якби ви перетягнули його у графічному файловому менеджері.
Він обробляє параметри так само, як `cp`,
тому команда:

```{shell}
mv autumn.csv winter.csv ..
```

переміщує файли `autumn.csv` і `winter.csv` з поточного робочого каталогу
на рівень вище — до батьківського каталогу
(адже `..` завжди означає каталог над вашим поточним розташуванням).

`@instructions`
Ви перебуваєте в `/home/repl`, де є підкаталоги `seasonal` і `backup`.
Однією командою перемістіть `spring.csv` і `summer.csv` з `seasonal` до `backup`.

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
backup_patt="Файл `%s` не знаходиться в каталозі `backup`. Ви правильно використали `mv`? Використовуйте два імені файлів та каталог як параметри для `mv`."
seasonal_patt="Файл `%s` все ще знаходиться в каталозі `seasonal`. Переконайтеся, що ви переміщуєте файли за допомогою `mv`, а не копіюєте їх за допомогою `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Чудово, давайте продовжимо цю подорож оболонкою!")
```

---

## Як перейменувати файли?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` також можна використовувати для перейменування файлів. Якщо ви виконаєте:

```{shell}
mv course.txt old-course.txt
```

то файл `course.txt` у поточному робочому каталозі буде «переміщено» у файл `old-course.txt`.
Це відрізняється від роботи графічних файлових менеджерів,
але часто зручно.

Попередження:
так само, як і `cp`,
`mv` перезаписує наявні файли.
Якщо,
наприклад,
у вас уже є файл з назвою `old-course.txt`,
то наведена вище команда замінить його вмістом із `course.txt`.

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
Перейдіть до каталогу `seasonal`.

`@hint`
Пам'ятайте, що `cd` означає «change directory» (змінити каталог), а відносні шляхи не починаються з початкового '/'.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
Перейменуйте файл `winter.csv` на `winter.csv.bck`.

`@hint`
Скористайтеся `mv`, указавши спочатку поточну назву файлу, а потім бажану нову назву.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Use `mv` with two arguments: the file you want to rename (`winter.csv`) and the new name for the file (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Ми очікували знайти `winter.csv.bck` у каталозі." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Ми більше не очікували, що `winter.csv` буде у каталозі." + hint)
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
Запустіть `ls`, щоб перевірити, що все спрацювало.

`@hint`
Не забудьте натиснути «enter» або «return», щоб виконати команду.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Чи використали Ви `ls`, щоб перелічити вміст Вашого поточного робочого каталогу?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Ваша команда не створила правильний список файлів. Використовуйте `ls` без аргументів, щоб перелічити вміст Вашого поточного робочого каталогу.")
    )
)
Ex().success_msg("Копіювання, переміщення, перейменування, Ви все зрозуміли! Далі: видалення файлів.")
```

---

## Як вилучати файли?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Ми можемо копіювати файли та переміщувати їх;
щоб вилучати їх,
використовуємо `rm`,
скорочення від "remove" — «вилучити».
Так само, як із `cp` та `mv`,
ви можете передати `rm` стільки назв файлів, скільки потрібно, тож:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

вилучає і `thesis.txt`, і `backup/thesis-2017-08.txt`.

`rm` робить саме те, що обіцяє,
і робить це негайно:
на відміну від графічних файлових переглядачів,
у оболонки немає «кошика»,
тож коли ви запускаєте команду вище,
ваш файл дисертації зникає остаточно.

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
Ви знаходитесь у `/home/repl`.
Перейдіть до каталогу `seasonal`.

`@hint`
Пам'ятайте, що `cd` — це "change directory" («змінити каталог»), а відносний шлях не починається зі знака '/'.

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
Вилучіть `autumn.csv`.

`@hint`
Пам'ятайте, що `rm` — це "remove" («вилучити»).

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Ми не очікували, що файл `autumn.csv` все ще буде в каталозі `seasonal`. Використовуйте `rm` з шляхом до файлу, який Ви хочете видалити."),
    has_code('rm', incorrect_msg = 'Використовуйте `rm` для видалення файлу, а не для його переміщення.')
)

```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Поверніться до домашнього каталогу.

`@hint`
Якщо використати `cd` без шляху, ви повернетеся до домашнього каталогу.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Використовуйте `cd ..` або `cd ~`, щоб повернутися до домашнього каталогу.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Вилучіть `seasonal/summer.csv`, не змінюючи поточний каталог.

`@hint`
Пам'ятайте, що `rm` — це "remove" («вилучити»).

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Ми не очікували, що `summer.csv` все ще буде в каталозі `seasonal`. Використовуйте `rm` з шляхом до файлу, який ви хочете видалити."),
    has_code('rm', incorrect_msg = 'Використовуйте `rm` для видалення файлу, а не для його переміщення.')
)
Ex().success_msg("Вражаюча робота! Переходимо до наступного завдання!")
```

---

## Як створювати й видаляти каталоги?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` працює з каталогами так само, як і з файлами:
якщо ви у своєму домашньому каталозі й виконаєте `mv seasonal by-season`,
наприклад,
`mv` змінить назву каталогу `seasonal` на `by-season`.
Однак
`rm` працює інакше.

Якщо ви спробуєте застосувати `rm` до каталогу,
оболонка виведе повідомлення про помилку, що так зробити не можна,
передусім щоб уберегти вас від випадкового видалення цілого каталогу з роботою.
Натомість
можна використати окрему команду `rmdir`.
Для додаткової безпеки
вона спрацьовує лише тоді, коли каталог порожній,
тому спочатку потрібно видалити файли в каталозі, *перш ніж* видаляти сам каталог.
(Досвідчені користувачі можуть використати опцію `-r` для `rm`, щоб досягти того самого ефекту;
про опції команд ми поговоримо в наступному розділі.)

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
Не змінюючи поточного каталогу,
видаліть файл `agarwal.txt` у каталозі `people`.

`@hint`
Памʼятайте, що `rm` означає «remove» (видалити) і що відносний шлях не починається зі скісної риски '/'.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` більше не повинно бути в `/home/repl/people`. Чи правильно Ви використали `rm`?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'У каталозі `people` все ще є файли. Якщо Ви просто перемістили `agarwal.txt` або створили нові файли, видаліть їх усі.')
)

```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Тепер, коли каталог `people` порожній,
видаліть його однією командою.

`@hint`
Памʼятайте, що `rm` працює лише з файлами.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "Каталог 'people' більше не повинен бути у вашому домашньому каталозі. Використовуйте `rmdir`, щоб видалити його!")
)

```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Оскільки каталог — це не файл,
вам потрібно використати команду `mkdir directory_name`,
щоб створити новий (порожній) каталог.
Скористайтеся цією командою, щоб створити новий каталог `yearly` під вашим домашнім каталогом.

`@hint`
Запустіть `mkdir` з назвою каталогу, який хочете створити.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="У Вашій домашній директорії немає директорії `yearly`. Використовуйте `mkdir yearly`, щоб створити її!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Тепер, коли `yearly` існує,
створіть усередині нього ще один каталог під назвою `2017`
*не виходячи* з вашого домашнього каталогу.

`@hint`
Використайте відносний шлях для підкаталогу, який хочете створити.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Не вдалося знайти каталог '2017' у '/home/repl/yearly'. Ви можете створити цей каталог, використовуючи відносний шлях `yearly/2017`.")
)
Ex().success_msg("Чудово! Давайте завершимо цей розділ вправою, яка повторює деякі з його концепцій!")
```

---

## Підсумуємо

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Під час аналізу даних ви часто створюєте проміжні файли.
Замість того щоб зберігати їх у своєму домашньому каталозі,
ви можете покласти їх у `/tmp` —
це місце, де користувачі й програми зазвичай тримають файли, потрібні лише ненадовго.
(Зверніть увагу, що `/tmp` міститься безпосередньо під кореневим каталогом `/`,
а не в межах вашого домашнього каталогу.)
У цій підсумковій вправі ви побачите, як це зробити.

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
Перейдіть у `/tmp` за допомогою `cd`.

`@hint`
Пам'ятайте, що `cd` означає «change directory» (змінити каталог), а абсолютний шлях починається зі «/».

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Ви в неправильному каталозі. Використовуйте `cd`, щоб змінити каталог на `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Виведіть вміст `/tmp` без зазначення назви каталогу.

`@hint`
Якщо ви не вкажете, що саме перерахувати, `ls` покаже вміст поточного каталогу.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Ви не викликали `ls`, щоб створити список файлів."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Ваша команда не створила правильний список файлів. Використовуйте `ls` без `.`.")
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
Створіть усередині `/tmp` новий каталог з назвою `scratch`.

`@hint`
Скористайтеся командою `mkdir`, щоб створити каталоги.

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
      has_code('mkdir +scratch', incorrect_msg="Не вдалося знайти директорію 'scratch' у '/tmp'. Переконайтеся, що ви правильно використовуєте `mkdir`.")
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
Перемістіть `/home/repl/people/agarwal.txt` до `/tmp/scratch`.
Радимо використати скорочення `~` для вашого домашнього каталогу та відносний шлях для другого аргументу замість абсолютного шляху.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Не вдалося знайти 'agarwal.txt' у '/tmp/scratch'. Використовуйте `mv` з `~/people/agarwal.txt` як перший параметр і `scratch` як другий.")
)
Ex().success_msg("Це завершує Розділ 1 Вступу до Shell! Поспішайте до наступного розділу, щоб дізнатися більше про маніпулювання даними!")
```

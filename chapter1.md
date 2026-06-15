---
title: 操作文件和目录
description: >-
  本章将简要介绍 Unix shell。您将了解它为何在近 50 年后仍被广泛使用、它与您可能更熟悉的图形工具有何不同、如何在 shell
  中导航，以及如何创建、修改和删除文件与文件夹。
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: shell 与桌面界面有何不同？
---

## 命令行 shell 与桌面界面有何不同？

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Windows、Linux 或 Mac OS 这样的操作系统是一种特殊的程序。
它控制计算机的处理器、硬盘和网络连接，
但最重要的工作是运行其他程序。

由于人类不是数字化的，
因此需要一个接口与操作系统交互。
如今最常见的是图形文件管理器，
它把单击和双击转换为打开文件和运行程序的命令。
在计算机拥有图形显示之前，
人们会把指令输入到一个名为 **命令行 shell** 的程序中。
每次输入命令时，
shell 都会运行其他程序，
以人类可读的形式打印它们的输出，
然后显示一个提示符（prompt），表示已准备好接受下一个命令。
（这个名字来自它是计算机"外壳"的概念。）

相比于点击和拖拽，输入命令一开始可能显得笨拙，
但正如您将看到的，
一旦您开始准确描述希望计算机执行的操作，
就可以把现有命令组合起来创造新用法，
并用寥寥几次按键自动化重复性操作。

<hr>
大多数人使用的图形文件管理器与命令行 shell 之间是什么关系？

`@hint`
请记住，用户只能通过某个程序与操作系统交互。

`@possible_answers`
- 文件管理器让您查看和编辑文件，而 shell 让您运行程序。
- 文件管理器是构建在 shell 之上的。
- shell 是操作系统的一部分，而文件管理器是独立的。
- [它们都是向操作系统发出命令的接口。]

`@feedback`
- 它们都允许您查看和编辑文件，并运行程序。
- 图形文件管理器和 shell 都会调用相同的底层操作系统函数。
- shell 和文件管理器都是把用户命令（输入或点击）翻译为对操作系统调用的程序。
- 正确！两者都会获取用户的命令（无论是键入还是点击）并发送给操作系统。

---

## 我在哪里？

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**文件系统**用来管理文件和目录（或称文件夹）。
每个对象都有一个 **绝对路径**，用于表示从文件系统的 **根目录** 到它的路径：
`/home/repl` 表示目录 `home` 下的目录 `repl`，
而 `/home/repl/course.txt` 则是该目录中的文件 `course.txt`，
单独的 `/` 就是根目录。

要查看您在文件系统中的当前位置，
运行命令 `pwd`
（是 "**p**rint **w**orking **d**irectory" 的缩写，意为"打印当前工作目录"）。
该命令会输出您当前的 **工作目录** 的绝对路径，
Shell 默认会在这里运行命令并查找文件。

<hr>
运行 `pwd`。
您现在在哪里？

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix 系统通常会把所有用户的主目录放在 `/home` 下面。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "这不是正确的路径。"
correct = "正确 - 您在 `/home/repl`。"

Ex().has_chosen(3, [err, err, correct])
```

---

## 如何识别文件和目录？

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` 会告诉您当前位置。
要查看这里有什么，
输入 `ls`（是 "**l**i**s**ting" 的缩写）并按回车键。
单独使用时，
`ls` 会列出您当前目录的内容
（也就是 `pwd` 显示的那个目录）。
如果您在后面加上一些文件名，
`ls` 会列出这些文件；
如果加上目录名，
它会列出这些目录的内容。
例如，
`ls /home/repl` 会显示您的起始目录中的内容
（通常称为您的 **home 目录**）。

<hr>
使用带合适参数的 `ls` 列出目录 `/home/repl/seasonal` 中的文件
（其中按季节拆分了按日期统计的牙科手术信息）。
下面哪个文件不在该目录中？

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
如果给 `ls` 一个路径，它会显示该路径中的内容。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "该文件位于 `seasonal` 目录中。"
correct = "正确 - 该文件*不*在 `seasonal` 目录中。"

Ex().has_chosen(2, [err, correct, err, err])
```

---

## 还有哪些方式可以标识文件和目录？

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

绝对路径就像经纬度：无论您身在何处，它的含义都不变。**相对路径**则从您当前所在位置开始描述位置：类似于说"向北 20 公里"。

例如：
- 如果您位于目录 `/home/repl`，则**相对**路径 `seasonal` 与**绝对**路径 `/home/repl/seasonal` 指向同一目录。
- 如果您位于目录 `/home/repl/seasonal`，则**相对**路径 `winter.csv` 与**绝对**路径 `/home/repl/seasonal/winter.csv` 指向同一文件。

Shell 会通过路径的第一个字符来判断它是绝对还是相对：如果以 `/` 开头，则是绝对路径；如果*不*以 `/` 开头，则是相对路径。

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
您当前在 `/home/repl`。请使用带**相对路径**的 `ls`，仅列出绝对路径为 `/home/repl/course.txt` 的那个文件。

`@hint`
当目标位于您当前位置之下时，常可通过"用目标的绝对路径减去当前位置的绝对路径"来构造到该文件或目录的相对路径。

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "您没有调用 `ls` 来生成文件列表。"), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "您的命令没有生成正确的文件列表。请使用 `ls` 后跟相对路径 `/home/repl/course.txt`。")
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
您当前在 `/home/repl`。
请使用带**相对路径**的 `ls`
仅列出文件 `/home/repl/seasonal/summer.csv`。

`@hint`
相对路径*不会*以开头的 '/' 起始。

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "您没有调用 `ls` 来生成文件列表。"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "您的命令没有生成正确的文件列表。请使用 `ls` 后跟相对路径 `/home/repl/seasonal/summer.csv`。")
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
您当前在 `/home/repl`。
请使用带**相对路径**的 `ls`
列出目录 `/home/repl/people` 的内容。

`@hint`
相对路径不会以开头的 '/' 起始。

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "您没有调用 `ls` 来生成文件列表。"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "您的命令没有生成正确的文件列表。请使用 `ls` 后跟相对路径 `/home/repl/people`。")
    )
)
Ex().success_msg("做得好。现在您已经了解了如何列出文件和目录，让我们看看如何在文件系统中移动！")
```

---

## 如何切换到另一个目录？

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

就像在文件浏览器中双击文件夹即可在各处移动，
您也可以使用命令 `cd`（意为 "change directory"，更改目录）在文件系统中移动。

如果您输入 `cd seasonal`，然后输入 `pwd`，
shell 会告诉您现在位于 `/home/repl/seasonal`。
接着如果单独运行 `ls`，
它会显示 `/home/repl/seasonal` 的内容，
因为您当前就在该目录中。
如果您想回到主目录 `/home/repl`，
可以使用命令 `cd /home/repl`。

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
您当前在 `/home/repl`。
请使用相对路径切换到 `/home/repl/seasonal`。

`@hint`
请记住，`cd` 表示 "change directory"（更改目录），并且相对路径不以前导 '/' 开头。

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="如果您的当前工作目录（使用 `pwd` 查看）是 `/home/repl`，您可以使用 `cd seasonal` 移动到 `seasonal` 文件夹。")
)
```

***

```yaml
type: ConsoleExercise
key: e69c8eac15
xp: 35
```

`@instructions`
使用 `pwd` 检查您已到达该目录。

`@hint`
输入命令后请按 "enter" 或 "return"。

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
不带任何路径使用 `ls`，查看该目录中的内容。

`@hint`
在命令后请按 "enter" 或 "return"。

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
      has_code('ls', incorrect_msg="您的命令未生成正确的输出。您是否使用了不带路径的 `ls` 来显示当前目录的内容？")
    )
)

Ex().success_msg("很好！这涉及到导航到子目录。那向上移动呢？让我们找出答案！")
```

---

## 如何上移到上一层目录？

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

目录的**父目录**是其上一级的目录。
例如，`/home` 是 `/home/repl` 的父目录，
而 `/home/repl` 是 `/home/repl/seasonal` 的父目录。
在使用 `cd` 和 `ls` 等命令时，您始终可以提供父目录的绝对路径。
不过，
更常见的是，
您会利用特殊路径 `..` 的含义：
（两个点，中间没有空格）表示"我当前所在目录的上一级"。
如果您在 `/home/repl/seasonal`，
运行 `cd ..` 会将您上移到 `/home/repl`。
如果再次使用 `cd ..`，
则会到达 `/home`。
再运行一次 `cd ..` 会将您带到*根目录* `/`，
也就是文件系统的最顶层。
（请记得在 `cd` 和 `..` 之间加一个空格——它分别是一个命令和一条路径，而不是一个四个字符的单一命令。）

单独一个点 `.` 始终表示"当前目录"，
因此单独的 `ls` 与 `ls .` 等效，
而 `cd .` 则没有任何效果
（因为它会把您"移动"到您已经所在的目录）。

最后一个特殊路径是 `~`（波浪号字符），
它表示"您的主目录"，
例如 `/home/repl`。
无论您身在何处，
`ls ~` 都会列出您的主目录内容，
而 `cd ~` 会把您带回主目录。

<hr>
如果您在 `/home/repl/seasonal`，
执行 `cd ~/../.` 会把您带到哪里？

`@hint`
一次移动一个目录，按路径逐段追踪。

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (the root directory)

`@feedback`
- 不对，但单独使用 `~` 或 `..` 都能把您带到那里。
- 正确！该路径表示"主目录"、"上一级"、"此处"。
- 不对，但单独使用 `.` 可以做到这一点。
- 不对，路径的最后一部分是 `.`（表示"此处"），而不是 `..`（表示"上一级"）。

---

## 如何复制文件？

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

您经常需要复制文件、
把它们移动到其他目录以便整理、
或重命名。
用于此目的的一个命令是 `cp`，它是 "copy" 的缩写。
如果 `original.txt` 是一个已存在的文件，
那么：

```{shell}
cp original.txt duplicate.txt
```

会创建 `original.txt` 的一个副本，命名为 `duplicate.txt`。
如果已经存在名为 `duplicate.txt` 的文件，
它会被覆盖。
如果 `cp` 的最后一个参数是一个已存在的目录，
那么像下面这样的命令：

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

会将这些文件的副本全部复制到该目录中。

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
请在 `backup` 目录（它也在 `/home/repl` 中）里创建 `seasonal/summer.csv` 的一份拷贝，
并将新文件命名为 `summer.bck`。

`@hint`
将目标目录名与要复制的文件名组合起来，
为新文件创建一个相对路径。

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` 似乎不存在于 `backup` 目录中。请为 `cp` 提供两个路径：现有文件 (`seasonal/summer.csv`) 和目标文件 (`backup/summer.bck`)。"),
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
在不改变当前工作目录（`/home/repl`）的情况下，
将 `seasonal` 目录中的 `spring.csv` 和 `summer.csv` 复制到 `backup` 目录中。

`@hint`
使用 `cp` 时先写要复制的源文件名，
然后写要复制到的目标目录名。

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` 似乎没有被复制到 `backup` 目录中。请提供两个文件名和一个目录名给 `cp`。"
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="请确保在 `{{dir}}` 目录中复制文件！使用 `cd {{dir}}` 返回到该目录。"),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("做得好。除了复制，我们还应该能够将文件从一个目录移动到另一个目录。在下一个练习中了解它！")
```

---

## 如何移动文件？

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

`cp` 会复制文件，
而 `mv` 会将文件从一个目录移动到另一个目录，
就像在图形化文件浏览器中拖动一样。
它的参数用法与 `cp` 相同，
因此下面的命令：

```{shell}
mv autumn.csv winter.csv ..
```

会把当前工作目录中的 `autumn.csv` 和 `winter.csv` 两个文件
向上移动一级到其父目录
（因为 `..` 始终指向您当前位置的上一级目录）。

`@instructions`
您现在位于 `/home/repl`，其中包含子目录 `seasonal` 和 `backup`。
请用一条命令，将 `seasonal` 中的 `spring.csv` 和 `summer.csv` 移动到 `backup`。

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
backup_patt="文件 `%s` 不在 `backup` 目录中。您是否正确使用了 `mv`？请使用两个文件名和一个目录作为 `mv` 的参数。"
seasonal_patt="文件 `%s` 仍在 `seasonal` 目录中。请确保使用 `mv` 移动文件，而不是使用 `cp` 复制文件！"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("做得好，让我们继续这个 shell 训练！")
```

---

## 如何重命名文件？

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` 也可用于重命名文件。如果您运行：

```{shell}
mv course.txt old-course.txt
```

那么当前工作目录中的 `course.txt` 文件会被"移动"为 `old-course.txt` 文件。
这与文件浏览器的工作方式不同，
但常常很方便。

需要注意：
与 `cp` 一样，
`mv` 会覆盖已存在的文件。
例如，
如果您已经有一个名为 `old-course.txt` 的文件，
那么上面的命令会用 `course.txt` 的内容替换它。

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
进入 `seasonal` 目录。

`@hint`
请记住，`cd` 代表 "change directory"（切换目录），而相对路径不以斜杠 '/' 开头。

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="如果您的当前工作目录（使用 `pwd` 查看）是 `/home/repl`，您可以使用 `cd seasonal` 移动到 `seasonal` 文件夹。")
)
```

***

```yaml
type: ConsoleExercise
key: ed5fe1df23
xp: 35
```

`@instructions`
将文件 `winter.csv` 重命名为 `winter.csv.bck`。

`@hint`
按顺序使用 `mv`，先写文件当前的名字，再写您想要的新名字。

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " 使用 `mv` 命令并带有两个参数：您想要重命名的文件 (`winter.csv`) 和文件的新名称 (`winter.csv.bck`)。"
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="我们期望在目录中找到 `winter.csv.bck`。" + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="我们不再期望目录中有 `winter.csv`。" + hint)
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
运行 `ls`，检查是否一切正常。

`@hint`
请记得按 "enter" 或 "return" 以运行命令。

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="您是否使用了 `ls` 来列出当前工作目录的内容？")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "您的命令未生成正确的文件列表。使用不带参数的 `ls` 来列出当前工作目录的内容。")
    )
)
Ex().success_msg("复制、移动、重命名，您都掌握了！接下来：删除文件。")
```

---

## 如何删除文件？

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

我们可以复制文件并在各处移动；要删除它们，用 `rm`，意思是 "remove"（移除）。与 `cp` 和 `mv` 一样，您可以把任意数量的文件名传给 `rm`，例如：

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

会同时删除 `thesis.txt` 和 `backup/thesis-2017-08.txt`。

`rm` 顾名思义，就是移除文件，并且会立即执行：与图形化文件浏览器不同，Shell 没有回收站；因此当您输入上面的命令后，论文文件就会被永久删除。

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
您当前位于 `/home/repl`。进入 `seasonal` 目录。

`@hint`
请记住，`cd` 是 "change directory"（切换目录）的意思，并且相对路径不以前导的 '/' 开头。

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
删除 `autumn.csv`。

`@hint`
请记住，`rm` 是 "remove"（删除）的意思。

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="我们不希望 `autumn.csv` 仍然在 `seasonal` 目录中。使用 `rm` 和文件路径来删除它。"),
    has_code('rm', incorrect_msg = '使用 `rm` 来删除文件，而不是移动它。')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
返回到您的主目录。

`@hint`
如果不带任何路径使用 `cd`，它会把您带回主目录。

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="使用 `cd ..` 或 `cd ~` 返回到主目录。")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
在不再切换目录的情况下，删除 `seasonal/summer.csv`。

`@hint`
请记住，`rm` 是 "remove"（删除）的意思。

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="我们不期望 `summer.csv` 仍然在 `seasonal` 目录中。使用 `rm` 和您想要删除的文件路径。"),
    has_code('rm', incorrect_msg = '使用 `rm` 来删除文件，而不是移动它。')
)
Ex().success_msg("令人印象深刻！继续下一个！")
```

---

## 如何创建和删除目录？

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` 对目录的处理方式与对文件相同：例如，如果您在主目录中运行 `mv seasonal by-season`，`mv` 会把 `seasonal` 目录重命名为 `by-season`。然而，`rm` 的工作方式不同。

如果您尝试对目录使用 `rm`，shell 会打印一条错误信息，告诉您无法这样做，主要是为了防止您不小心删除装着大量工作的整个目录。相应地，您可以使用一个单独的命令 `rmdir`。为了更安全，它只在目录为空时才会生效，因此您必须在删除目录之前，先删除目录中的文件。（有经验的用户可以对 `rm` 使用 `-r` 选项来达到同样的效果；我们将在下一章讨论命令选项。）

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
在不切换目录的情况下，删除 `people` 目录中的文件 `agarwal.txt`。

`@hint`
记住 `rm` 表示 "remove"，而相对路径不以前导 '/' 开头。

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` 不应再位于 `/home/repl/people` 中。您是否正确使用了 `rm`？"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = '`people` 目录中仍然有文件。如果您只是移动了 `agarwal.txt`，或者创建了新文件，请删除它们。')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
现在 `people` 目录已经为空，使用一条命令将其删除。

`@hint`
请记住，`rm` 只能用于文件。

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "您的主目录中不应再有 'people' 目录。请使用 `rmdir` 将其删除！")
)

```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
由于目录不是文件，您必须使用命令 `mkdir directory_name` 来创建一个新的（空）目录。使用该命令在您的主目录下创建一个名为 `yearly` 的新目录。

`@hint`
运行 `mkdir`，后跟您想创建的目录名。

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="您的主目录中没有 `yearly` 目录。请使用 `mkdir yearly` 创建一个！")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
现在 `yearly` 已经存在，在不离开您的主目录的情况下，在其中创建另一个名为 `2017` 的目录。

`@hint`
为要创建的子目录使用相对路径。

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="在 '/home/repl/yearly' 中找不到 '2017' 目录。您可以使用相对路径 `yearly/2017` 创建此目录。")
)
Ex().success_msg("太好了！让我们用一个练习来结束本章，该练习重复了一些概念！")
```

---

## 总结

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

在分析数据时，您经常会创建中间文件。
与其把它们存放在您的主目录中，
不如放到 `/tmp` 下，
人和程序通常会把只需短暂使用的文件放在那里。
（请注意，`/tmp` 位于根目录 `/` 之下，
而不是您的主目录之下。）
这个收尾练习将向您展示如何做到这一点。

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
使用 `cd` 进入 `/tmp`。

`@hint`
请记住，`cd` 是 "change directory"（切换目录）的缩写，绝对路径以 '/' 开头。

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = '您在错误的目录中。使用 `cd` 将目录更改为 `/tmp`。')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
在不输入目录名的情况下，列出 `/tmp` 的内容。

`@hint`
如果您不告诉 `ls` 要列出什么，它会显示您当前目录中的内容。

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "您没有调用 `ls` 来生成文件列表。"),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "您的命令没有生成正确的文件列表。请使用 `ls`。")
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
在 `/tmp` 下新建名为 `scratch` 的目录。

`@hint`
使用 `mkdir` 创建目录。

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
      has_code('mkdir +scratch', incorrect_msg="在 '/tmp' 下找不到 'scratch' 目录。请确保正确使用 `mkdir`。")
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
将 `/home/repl/people/agarwal.txt` 移动到 `/tmp/scratch`。
建议您对主目录使用 `~` 快捷方式，并对第二个路径使用相对路径，而不是绝对路径。

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="无法在 '/tmp/scratch' 中找到 'agarwal.txt'。请使用 `mv`，将 `~/people/agarwal.txt` 作为第一个参数，`scratch` 作为第二个参数。")
)
Ex().success_msg("这就结束了《Shell 入门》第 1 章！赶紧进入下一章，学习更多关于数据操作的知识吧！")
```

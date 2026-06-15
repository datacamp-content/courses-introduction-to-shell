---
title: 处理数据
description: 上一章中的命令可让您在文件系统中移动内容。本章将向您展示如何处理这些文件中的数据。我们将使用的工具相对简单，但非常扎实，适合作为构建模块。
lessons:
  - nb_of_exercises: 12
    title: 如何查看文件内容？
---

## 如何查看文件内容？

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

在重命名或删除文件之前，
您可能需要先看看它们的内容。
最简单的方法是使用 `cat`，
它会把文件的内容直接打印到屏幕上。
（它的名称是 "concatenate" 的缩写，意思是"连接起来"，
因为它会按顺序打印您提供的所有文件名所对应的文件内容。）

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
将 `course.txt` 的内容打印到屏幕上。

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
    has_expr_output(incorrect_msg="您的命令未生成正确的输出。您是否使用了 `cat` 后跟文件名 `course.txt`？")
)
Ex().success_msg("很好！让我们看看查看文件内容的其他方法。")
```

---

## 如何分段查看文件内容？

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

您可以使用 `cat` 打印大文件，然后通过滚动查看输出，但更常用也更方便的方式是对输出进行**分页**。
最早用于分页的命令叫做 `more`，后来被功能更强的 `less` 取代。
（这种命名算是 Unix 世界里的幽默。）
当您对一个文件使用 `less` 时，会一次展示一页；
您可以按空格键向下翻页，或输入 `q` 退出。

如果您把多个文件名传给 `less`，
可以输入 `:n`（冒号加小写字母 n）跳到下一个文件，
输入 `:p` 返回上一个文件，
或输入 `:q` 退出。

注意：如果您查看使用 `less` 的练习答案，
会在末尾看到一个额外的命令用于关闭分页，
以便我们高效地测试您的解答。

`@instructions`
使用 `less seasonal/spring.csv seasonal/summer.csv` 按该顺序查看这两个文件。
按空格键向下翻页，输入 `:n` 切换到第二个文件，输入 `:q` 退出。

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
                 incorrect_msg='请使用 `less` 和文件名。请记住，`:n` 会将您移动到下一个文件。'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## 如何查看文件的开头？

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

大多数数据科学家拿到一个新数据集时，第一件事就是
弄清它包含哪些字段，以及这些字段的取值。
如果数据集是从数据库或电子表格导出的，
通常会以 **逗号分隔值**（CSV）格式存储。
快速了解其内容的一个方法，是先看前几行。

我们可以在 shell 中使用一个叫做 `head` 的命令来完成。
顾名思义，
它会打印文件的前几行
（这里的「几行」指 10 行），
因此命令：

```{shell}
head seasonal/summer.csv
```

会显示：

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

如果文件里没有 10 行，`head` 会怎么做？
（要找出答案，请用它查看 `people/agarwal.txt` 的开头。）

`@possible_answers`
- 打印错误信息，因为文件太短。
- 显示现有的所有行数。
- 显示足够的空行，使总数达到 10。

`@hint`
它最有用的功能是什么？

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["不正确：这不是它能做的最有用的事情。",
                    "正确！",
                    "不正确：这将无法与以一堆空行结尾的文件区分开来。"])
```

---

## 怎样才能少打字？

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Shell 的一大利器是**Tab 补全**。
当您开始输入文件名并按下 Tab 键时，
Shell 会尽力为您自动补全路径。
例如，
如果您输入 `sea` 并按下 Tab，
它会补全为目录名 `seasonal/`（带有斜杠结尾）。
接着如果您再输入 `a` 并按下 Tab，
将会把路径补全为 `seasonal/autumn.csv`。

如果路径不唯一，
例如 `seasonal/s`，
第二次按下 Tab 会显示所有可能的选项。
再多输入一两个字符以使路径更具体，
然后再按 Tab，
就会补全剩余的名称。

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
在不完整输入文件名的情况下运行 `head seasonal/autumn.csv`。

`@hint`
先输入路径中需要的部分，然后按 Tab，并重复这个过程。

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="检查器无法在您的命令中找到正确的输出。您确定在 `seasonal/autumn.csv` 上调用了 `head` 吗？")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
在不完整输入文件名的情况下运行 `head seasonal/spring.csv`。

`@hint`
先输入路径中需要的部分，然后按 Tab，并重复这个过程。

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="检查器无法在您的命令中找到正确的输出。您确定在 `seasonal/spring.csv` 上调用了 `head` 吗？")
)
Ex().success_msg("做得好！一旦您习惯使用制表符补全，它将为您节省大量时间！")
```

---

## 如何控制命令的行为？

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

您并不总是只想查看文件的前 10 行，
因此可以通过在命令后添加 **命令行标志**（简称"标志"）来更改 `head` 的行为。
如果运行以下命令：

```{shell}
head -n 3 seasonal/summer.csv
```

`head` 只会显示该文件的前三行。
如果运行 `head -n 100`，
它会显示前 100 行（如果文件至少有这么多），
以此类推。

标志的名字通常表明其用途
（例如，`-n` 表示"行数"的意思）。
命令标志不一定都是一个 `-` 加单个字母，
但这是被广泛采用的约定。

注意：将所有标志放在文件名*之前*被认为是良好风格，
所以在本课程中，
我们只接受按照这一规范书写的答案。

`@instructions`
显示 `seasonal` 目录中 `winter.csv` 的前 5 行。

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
        has_expr_output(incorrect_msg="您确定您正在对 `seasonal/winter.csv` 文件调用 `head` 吗？"),
        has_expr_output(strict=True, incorrect_msg="您确定您使用了标志 `-n 5` 吗？")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "您确定您使用了标志 `-n 5` 吗？")
)
Ex().success_msg("很好！使用这种技术，如果您想查看较大的文本文件，可以避免您的 shell 崩溃。")
```

---

## 如何列出某个目录下的所有内容？

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

若要查看某个目录下的一切内容，
无论嵌套有多深，
都可以给 `ls` 加上 `-R` 参数
（表示"递归"）。
如果您在主目录中使用 `ls -R`，
会看到类似下面的输出：

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

这会先显示当前层级中的所有文件和目录，
然后依次显示每个子目录中的所有内容，
以此类推。

`@instructions`
为便于区分类型，
`ls` 还有一个参数 `-F`，它会在每个目录名后加上 `/`，
并在每个可运行的程序后加上 `*`。
请使用 `ls` 同时带上两个参数 `-R` 和 `-F`，并提供您主目录的绝对路径，
以查看其中包含的全部内容。
（参数的先后顺序无关紧要，但目录名必须放在最后。）

`@hint`
您的主目录可以用 `~`、`.` 或它的绝对路径来表示。

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
  has_expr_output(incorrect_msg='请使用 `ls -R -F` 或 `ls -F -R` 和路径 `/home/repl`。'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='请使用 `ls -R -F` 或 `ls -F -R` 和路径 `/home/repl`。')
)
Ex().success_msg("这真是一个相当简洁的概览，不是吗？")
```

---

## 如何获取某个命令的帮助？

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

为了了解命令的作用，过去人们常用 `man` 命令（"manual" 的缩写）。例如，运行 `man head` 会显示如下信息：

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

`man` 会自动调用 `less`，因此您可能需要按空格键翻页，并使用 `:q` 退出。

`NAME` 下的一行描述会简要说明该命令的功能，而 `SYNOPSIS` 下的摘要列出了它支持的所有标志。任何可选项会用方括号 `[...]` 表示，二选一的选项用 `|` 分隔，可以重复的内容用 `...` 表示。所以，`head` 的手册页告诉您：您可以用 `-n` 提供行数，或用 `-c` 提供字节数，并且可以提供任意数量的文件名。

Unix 手册的问题在于，您必须先知道要找什么。如果不清楚，您可以搜索 [Stack Overflow](https://stackoverflow.com/)、在 DataCamp 的 Slack 频道提问，或查看您已掌握命令的 `SEE ALSO` 部分。

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
阅读 `tail` 命令的手册页面，了解在与 `-n` 标志一起使用的数字前加上 `+` 号会有什么效果。（请按空格键向下翻页，或输入 `q` 退出。）

`@hint`
请记住：`man` 是 "manual" 的缩写。

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='请使用 `man` 和命令名称。')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
使用 `tail` 和标志 `-n +7` 显示 `seasonal/spring.csv` 中除前 6 行以外的所有内容。

`@hint`
在希望显示的行数前加上加号 '+'。

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="您是否在调用 `seasonal/spring.csv` 上的 `tail`？"),
    has_expr_output(strict=True, incorrect_msg="您确定使用了标志 `-n +7` 吗？")
)
```

---

## 如何从文件中选择列？

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` 和 `tail` 可以从文本文件中选择行。
如果您想选择列，
可以使用 `cut` 命令。
它有多个选项（使用 `man cut` 查看），
但最常见的用法类似：

```{shell}
cut -f 2-5,8 -d , values.csv
```

这表示：
"选择第 2 到第 5 列以及第 8 列，
以逗号作为分隔符"。
`cut` 使用 `-f`（表示"字段"）来指定列，
并使用 `-d`（表示"分隔符"）来指定分隔符。
需要指定后者，因为有些文件可能使用空格、制表符或冒号来分隔列。

<hr>

哪个命令可以从文件 `spring.csv` 中选出第一列（包含日期）？

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- 上述任意一个。
- 都不对，因为 `-f` 必须在 `-d` 之前。

`@hint`
标志的顺序无关紧要。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['是的，但这还不是全部', '是的，但这还不是全部', '正确！在标志后添加空格是良好的风格，但不是强制性的。', '不，标志的顺序无关紧要'])
```

---

## `cut` 做不到什么？

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` 是一个思路很简单的命令。
尤其是，
它不理解带引号的字符串。
例如，如果您的文件是：

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

那么：

```{shell}
cut -f 2 -d , everyone.csv
```

将会产生：

```
Age
Ranjit"
Rupinder"
```

而不是每个人的年龄，
因为它会把姓和名之间的逗号当作列分隔符。

<hr>

对这一行执行 `cut -d : -f 2-4` 的输出是什么：

```
first:second:third:
```

（注意末尾的冒号。）

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- 以上都不对，因为并不存在 4 个字段。

`@hint`
请注意末尾的冒号。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['不，答案不止于此。', '不，答案不止于此。', '正确！尾随的冒号创建了一个空的第四字段。', '不，`cut` 已经尽力了。'])
```

---

## 如何重复运行命令？

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

使用 shell 的一大优势是，
它能让您轻松地重复执行操作。
当您运行过一些命令后，
可以按向上箭头键在历史命令中回溯浏览。
您还可以用左右箭头键和删除键来编辑命令。
按回车后就会运行修改后的命令。

更方便的是，`history` 会打印您最近运行过的命令列表。
每条命令前都有一个序号，便于您重新运行特定命令：
只需输入 `!55` 就能重新运行历史中的第 55 条命令（如果您的历史里有这么多）。
您也可以通过输入感叹号加命令名来重新运行某个命令，
如 `!head` 或 `!cut`，
这将重新运行该命令最近一次的使用。

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
在您的主目录中运行 `head summer.csv`（该命令应当会失败）。

`@hint`
如果没有匹配的文件名，Tab 自动补全将无法工作。

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="请使用 `head` 和文件名 `summer.csv`。即使失败也不用担心。")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
切换到 `seasonal` 目录。

`@hint`
请记住，`cd` 是 "change directory"（切换目录）的缩写。

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
key: 74f5c8d2fc
xp: 20
```

`@instructions`
使用 `!head` 重新运行 `head` 命令。

`@hint`
在 `!` 与其后内容之间不要输入空格。

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
                        incorrect_msg='请使用 `!head` 来重复 `head` 命令。'),
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
使用 `history` 查看您做过的操作。

`@hint`
请注意，`history` 会把最新的命令显示在最后，这样当它运行结束时这些命令会留在屏幕上。

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='使用 `history` 不带标志来获取以前命令的列表。')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
再次使用 `!` 加命令编号来重新运行 `head`。

`@hint`
请勿在 `!` 与其后内容之间输入空格。

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
                        incorrect_msg='您是否使用了 `!<a_number>` 来重新运行历史记录中的最后一个 `head` 命令？'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("做得好！继续下一个！")
```

---

## 如何筛选包含特定值的行？

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` 和 `tail` 用于选择行，
`cut` 用于选择列，
而 `grep` 则根据内容选择行。
在最简单的用法中，
`grep` 接受一段文本，后跟一个或多个文件名，
并打印这些文件中所有包含该文本的行。
例如，
`grep bicuspid seasonal/winter.csv`
会打印 `winter.csv` 中包含 "bicuspid" 的行。

`grep` 也可以搜索模式；
我们将在下一门课程中进一步探讨。
现在更重要的是了解一些 `grep` 的常用选项：

- `-c`：打印匹配行的数量，而不是行本身
- `-h`：在搜索多个文件时，*不*打印文件名
- `-i`：忽略大小写（例如，将 "Regression" 和 "regression" 视为匹配）
- `-l`：打印包含匹配项的文件名，而不是匹配的内容
- `-n`：为匹配的行打印行号
- `-v`：反转匹配，即只显示*不*匹配的行

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
在主目录下用一条命令，打印 `seasonal/autumn.csv` 中所有包含单词 `molar` 的行的内容。不要使用任何选项。

`@hint`
将要查找的词与要搜索的文件名一起传给 `grep`。

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
      has_code("grep", incorrect_msg = "您是否调用了 `grep`？"),
      has_code("molar", incorrect_msg = "您是否搜索了 `molar`？"),
      has_code("seasonal/autumn.csv", incorrect_msg = "您是否搜索了 `seasonal/autumn.csv` 文件？")
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
反转匹配，查找 `seasonal/spring.csv` 中所有*不*包含单词 `molar` 的行，并显示其行号。
请记住，良好的风格是将所有选项放在其他值（如文件名或搜索词 "molar"）之前。

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
      has_code("grep", incorrect_msg = "您是否调用了 `grep`？"),
      has_code("-v", incorrect_msg = "您是否使用 `-v` 反转了匹配？"),
      has_code("-n", incorrect_msg = "您是否使用 `-n` 显示了行号？"),
      has_code("molar", incorrect_msg = "您是否搜索了 `molar`？"),
      has_code("seasonal/spring.csv", incorrect_msg = "您是否搜索了 `seasonal/spring.csv` 文件？")
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
统计 `autumn.csv` 和 `winter.csv` 中合计有多少行包含单词 `incisor`。
（同样，从主目录运行一条命令完成。）

`@hint`
记得在 `grep` 中使用 `-c` 来统计行数。

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
      has_code("grep", incorrect_msg = "您是否调用了 `grep`？"),
      has_code("-c", incorrect_msg = "您是否使用 `-c` 获取了计数？"),
      has_code("incisor", incorrect_msg = "您是否搜索了 `incisor`？"),
      has_code("seasonal/autumn.csv", incorrect_msg = "您是否搜索了 `seasonal/autumn.csv` 文件？"),
      has_code("seasonal/winter.csv", incorrect_msg = "您是否搜索了 `seasonal/winter.csv` 文件？")
    )
  )
)
```

---

## 为什么把数据当作纯文本处理并不总是安全？

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

`cut` 手册页的 `SEE ALSO` 部分提到了一个名为 `paste` 的命令，
它可以用来合并数据文件，而不是将它们切分。

<hr>

请阅读 `paste` 的手册页，
然后运行 `paste`，使用逗号作为分隔符，将 autumn 和 winter 两个数据文件合并成一张表。
从数据分析的角度看，输出结果哪里有问题？

`@possible_answers`
- 列名被重复了。
- 最后几行的列数不对。
- `winter.csv` 中有部分数据丢失。

`@hint`
如果对 `paste` 的输出使用逗号作为分隔符再用 `cut`，
能得到正确的答案吗？

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = '正确，但这不一定是一个错误。'
correct2 = '正确：用列连接行只会在开始时创建一个空列，而不是两个。'
err3 = '不，全冬季的数据都在这里。'
Ex().has_chosen(2, [err1, correct2, err3])
```

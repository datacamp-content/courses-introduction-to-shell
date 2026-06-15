---
title: 批处理
description: 大多数 shell 命令可以一次处理多个文件。本章将演示如何让您自己的管道也做到这一点。同时，您还将看到 shell 如何使用变量来存储信息。
lessons:
  - nb_of_exercises: 10
    title: shell 如何存储信息？
---

## Shell 如何存储信息？

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

与其他程序一样，shell 会把信息存储在变量中。
其中一部分称为 **环境变量**，始终可用。
环境变量的名称按惯例使用全大写字母，
下面列出了几个常用的例子。

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | 用户的主目录                      | `/home/repl`          |
| `PWD `   | 当前工作目录                      | 与 `pwd` 命令相同     |
| `SHELL`  | 正在使用的 shell 程序             | `/bin/bash`           |
| `USER`   | 用户 ID                           | `repl`                |

如需查看完整列表（会很长），
您可以在 shell 中输入 `set`。

<hr>

使用带管道的 `set` 和 `grep` 显示 `HISTFILESIZE` 的值，
它决定了命令历史中会保存多少条旧命令。
它的值是多少？

`@possible_answers`
- 10
- 500
- [2000]
- 该变量不存在。

`@hint`
使用 `set | grep HISTFILESIZE` 获取所需的那一行。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "不对：shell 记录的历史比这更多。"
err2 = "不对：shell 记录的历史比这更多。"
correct3 = "正确：在此系统上，shell 默认保存 2000 条旧命令。"
err4 = "不对：变量 `HISTFILESIZE` 存在。"
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## 如何打印变量的值？

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

查找变量值更简单的方法是使用名为 `echo` 的命令，它会打印传入的参数。输入

```{shell}
echo hello DataCamp!
```

将输出：

```
hello DataCamp!
```

如果您尝试像这样用它来打印变量的值：

```{shell}
echo USER
```

它会打印变量名 `USER`。

要获取变量的值，必须在变量名前加上美元符号 `$`。输入

```{shell}
echo $USER
```

将输出：

```
repl
```

这一点在任何地方都适用：
要得到名为 `X` 的变量的值，
您必须写成 `$X`。
（这样做是为了让 shell 能分辨您说的是"名为 X 的文件"
还是"名为 X 的变量的值"。）

`@instructions`
变量 `OSTYPE` 保存了您正在使用的操作系统类型名称。
请使用 `echo` 显示它的值。

`@hint`
在变量名前加上 `$`，然后用 `echo` 输出变量 `OSTYPE`。

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
            has_code('echo', incorrect_msg="您是否调用了 `echo`？"),
            has_code('OSTYPE', incorrect_msg="您是否打印了 `OSTYPE` 环境变量？"),
            has_code(r'\$OSTYPE', incorrect_msg="请确保在 `OSTYPE` 前加上 `$`。")
        )
    )
)
Ex().success_msg("环境变量的回显非常出色！您有一个良好的开端。让我们继续！")
```

---

## Shell 还会怎样存储信息？

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

另一种变量称为**Shell 变量**，类似于编程语言中的局部变量。

要创建一个 Shell 变量，
只需给名称赋值即可：

```{shell}
training=seasonal/summer.csv
```

在 `=` 符号的前后都不要有空格。
完成后，
您可以用下面的命令检查变量的取值：

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
定义一个名为 `testing` 的变量，取值为 `seasonal/winter.csv`。

`@hint`
变量名与其值之间不应有空格。

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
        has_code('testing', incorrect_msg='您是否定义了一个名为 `testing` 的 shell 变量？'),
        has_code('testing=', incorrect_msg='您是否在 testing 后直接写了 `=`，没有空格？'),
        has_code('=seasonal/winter\.csv', incorrect_msg='您是否将 `testing` 的值设置为 `seasonal/winter.csv`？')
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
使用 `head -n 1 SOMETHING` 获取 `seasonal/winter.csv` 的首行，
并用变量 `testing` 的值替代文件名。

`@hint`
请记得使用 `$testing` 而不是只写 `testing`
（需要 `$` 才能取得变量的值）。

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
    has_code(r'\$testing', incorrect_msg="您是否使用 `$testing` 引用了 shell 变量？"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="您是否调用了 `head`？"),
            has_code('-n', incorrect_msg="您是否使用 `-n` 限制了行数？"),
            has_code(r'-n\s+1', incorrect_msg="您是否选择使用 `-n 1` 保留 1 行？")     
        )
    )
)
Ex().success_msg("太棒了！让我们看看您如何轻松重复命令。")
```

---

## 如何把一条命令重复执行多次？

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Shell 变量也常用于**循环**，用于把命令重复执行多次。若我们运行下面的命令：

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

会得到：

```
gif
jpg
png
```

请留意这个循环的几个部分：

1. 结构是 `for` ...变量... `in` ...列表... `; do` ...主体... `; done`
2. 循环要处理的项目列表（本例中是单词 `gif`、`jpg` 和 `png`）。
3. 用来记录循环当前处理到哪个项目的变量（本例中是 `filetype`）。
4. 执行处理的循环主体（本例中是 `echo $filetype`）。

请注意，主体中使用 `$filetype` 来获取变量的值，而不是直接写 `filetype`，这与使用其他 shell 变量的方式相同。还要注意分号的位置：第一个分号在列表与关键字 `do` 之间；第二个分号在主体与关键字 `done` 之间。

`@instructions`
请修改循环，使其输出：

```
docx
odt
pdf
```

请使用 `filetype` 作为循环变量名。

`@hint`
参考引导文本中的代码结构，把图像文件类型换成文档文件类型即可。

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
      has_code('for', incorrect_msg='您是否调用了 `for`？'),
      has_code('filetype', incorrect_msg='您是否使用 `filetype` 作为循环变量？'),
      has_code('in', incorrect_msg='您是否在文件类型列表之前使用了 `in`？'),
      has_code('docx odt pdf', incorrect_msg='您是否按顺序遍历了 `docx`、`odt` 和 `pdf`？'),
      has_code(r'pdf\s*;', incorrect_msg='您是否在最后一个循环元素后加了分号？'),
      has_code(r';\s*do', incorrect_msg='您是否在第一个分号后使用了 `do`？'),
      has_code('echo', incorrect_msg='您是否调用了 `echo`？'),
      has_code(r'\$filetype', incorrect_msg='您是否回显了 `$filetype`？'),
      has_code(r'filetype\s*;', incorrect_msg='您是否在循环体后加了分号？'),
      has_code('; done', incorrect_msg='您是否以 `done` 结束？')
    )
  )
)
Ex().success_msg("循环一流！如果您想做成百上千次相同的事情，循环是很棒的。")
```

---

## 如何让一条命令对每个文件各运行一次？

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

在编写循环时，您当然可以手动输入要处理的文件名，
但通常更好的做法是使用通配符。
请在控制台中运行下面这个循环：

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

它会输出：

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

这是因为在运行循环之前，shell 会先将 `seasonal/*.csv` 展开为包含 4 个文件名的列表。

`@instructions`
将通配符表达式修改为 `people/*`
这样循环就会打印 `people` 目录中的所有文件名，
无论它们有没有后缀或后缀是什么。
请将循环变量命名为 `filename`。

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
      has_code('for', incorrect_msg='您是否调用了 `for`？'),
      has_code('filename', incorrect_msg='您是否使用 `filename` 作为循环变量？'),
      has_code('in', incorrect_msg='您是否在文件类型列表之前使用了 `in`？'),
      has_code('people/\*', incorrect_msg='您是否使用 `people/*` 指定了文件列表？'),
      has_code(r'people/\*\s*;', incorrect_msg='您是否在文件列表后加了分号？'),
      has_code(r';\s*do', incorrect_msg='您是否在第一个分号后使用了 `do`？'),
      has_code('echo', incorrect_msg='您是否调用了 `echo`？'),
      has_code(r'\$filename', incorrect_msg='您是否回显了 `$filename`？'),
      has_code(r'filename\s*;', incorrect_msg='您是否在循环体后加了分号？'),
      has_code('; done', incorrect_msg='您是否以 `done` 结束？')
    )
  )
)
Ex().success_msg("循环的乐趣！通配符和循环是强大的组合。")
```

---

## 如何记录一组文件的名称？

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

人们常用通配符表达式给变量赋值，用来记录一组文件名。
例如，
如果像这样定义 `datasets`：

```{shell}
datasets=seasonal/*.csv
```

那么您稍后可以用下面的方式显示这些文件名：

```{shell}
for filename in $datasets; do echo $filename; done
```

这样可以减少输入量，也更不容易出错。

<hr>

如果您在主目录中运行下面两条命令，
它们会打印出多少行输出？

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- 没有：因为 `files` 是在单独一行中定义的，所以在第二行中没有值。
- 一行：单词 "files"。
- 四行：四个季节性数据文件的文件名。

`@hint`
请记住，单独的 `X` 只是字符串 "X"，而 `$X` 才是变量 `X` 的值。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "不：您不必在使用变量的同一行定义它。"
err2 = "不：此示例在同一个 shell 中定义并使用了变量 `files`。"
correct3 = "正确。该命令等同于 `for f in seasonal/*.csv; do echo $f; done`。"
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## 变量名与变量值

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

一个常见错误是忘记在变量名前加 `$`。
这样做时，shell 会使用您输入的名字，而不是该变量的取值。

对于有经验的用户，更常见的错误是把变量名拼错。
例如，若您像这样定义 `datasets`：

```{shell}
datasets=seasonal/*.csv
```

然后输入：

```{shell}
echo $datsets
```

shell 不会打印任何内容，因为 `datsets`（少了第二个 "a"）并未定义。

<hr>

如果您在主目录中运行下面两条命令，会打印出什么？

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

（作答前请仔细阅读循环的第一部分。）

`@hint`
请记住，单独的 `X` 只是字符串 "X"，而 `$X` 才是变量 `X` 的取值。

`@possible_answers`
- [一行：单词 "files"。]
- 四行：四个季节性数据文件的文件名。
- 四行空白：变量 `f` 没有被赋值。

`@feedback`
- 正确：循环使用的是 `files` 而不是 `$files`，因此列表只包含单词 "files"。
- 不对：循环使用的是 `files` 而不是 `$files`，因此列表包含的是单词 "files"，而不是对 `files` 的展开结果。
- 不对：变量 `f` 是由 `for` 循环自动定义的。

---

## 如何在一个循环中运行多条命令？

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

打印文件名有助于调试，
但循环的真正目的，是对多个文件执行操作。
下面这个循环会打印每个数据文件的第二行：

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

它与您之前见过的其他循环结构相同：
唯一不同的是，其循环体是由两条命令构成的管道，而不是单条命令。

`@instructions`
编写一个循环，打印每个 seasonal 文件中 2017 年 7 月（`2017-07`）的最后一条记录。输出应与以下命令相似：

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

但需要对每个 seasonal 文件分别执行。请使用 `file` 作为循环变量名，并记得遍历文件列表 `seasonal/*.csv`（而不是示例中的 'seasonal/winter.csv'）。

`@hint`
循环体就是说明中给出的 grep 命令，只需把 `seasonal/winter.csv` 替换为 `$file`。

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
  has_code('for', incorrect_msg='您是否调用了 `for`？'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='您是否使用了 `file` 作为循环变量？'),
      has_code('in', incorrect_msg='您是否在文件列表前使用了 `in`？'),
      has_code('seasonal/\*', incorrect_msg='您是否使用 `seasonal/*` 指定了文件列表？'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='您是否在文件列表后加了分号？'),
      has_code(r';\s*do', incorrect_msg='您是否在第一个分号后使用了 `do`？'),
      has_code('grep', incorrect_msg='您是否调用了 `grep`？'),
      has_code('2017-07', incorrect_msg='您是否匹配了 `2017-07`？'),
      has_code(r'\$file', incorrect_msg='您是否使用了 `$file` 作为循环变量的名称？'),
      has_code(r'file\s*|', incorrect_msg='您是否使用管道连接了第二个命令？'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='您是否使用 `tail -n 1` 打印了每次搜索的最后一条记录？'),
      has_code('; done', incorrect_msg='您是否以 `done` 结束？')
    )
  )
)

Ex().success_msg("循环的乐趣！通配符和循环是强大的组合。")
```

---

## 为什么不应该在文件名中使用空格？

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

在图形化文件管理器中，给文件起像 `July 2017.csv` 这样的多词名称既容易又合理。
然而，在 shell 中工作时，这会带来问题。
例如，假设您想把 `July 2017.csv` 重命名为 `2017 July data.csv`。
您不能输入：

```{shell}
mv July 2017.csv 2017 July data.csv
```

因为在 shell 看来，您像是在尝试把名为 `July`、`2017.csv`、`2017` 和 `July`（再次出现）的四个文件
移动到名为 `data.csv` 的目录中。
相反，您必须给文件名加引号，
这样 shell 才会把每个文件名当作一个单独的参数：

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

如果您有两个文件，分别叫做 `current.csv` 和 `last year.csv`
（名称中包含空格），并输入：

```{shell}
rm current.csv last year.csv
```

会发生什么：

`@hint`
如果有人把这条命令给您看，而您并不知道当前有哪些文件，您会觉得会发生什么？

`@possible_answers`
- shell 会打印一条错误信息，因为 `last` 和 `year.csv` 不存在。
- shell 会删除 `current.csv`。
- [以上两者都会发生。]
- 什么也不会发生。

`@feedback`
- 没错，但不止如此。
- 没错，但不止如此。
- 正确。您可以在文件名两侧使用单引号 `'`，或双引号 `"`。
- 很遗憾，不是这样。

---

## 如何在一个循环中完成多步操作？

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

到目前为止，您看到的循环在循环体内只有一条命令或一条管道，
但循环体中可以包含任意数量的命令。
要告诉 shell 一条命令结束、下一条开始，
您必须用分号将它们分隔开：

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

假设您在上一个循环中忘了在 `echo` 和 `head` 命令之间写分号，
于是让 shell 运行：

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

shell 会怎么做？

`@possible_answers`
- 打印一条错误信息。
- 为这四个文件中的每一个打印一行。
- 只打印 `autumn.csv`（第一个文件）的一行。
- 打印每个文件的最后一行。

`@hint`
您可以将 `echo` 的输出通过管道传给 `tail`。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "不：循环将运行，只是不会执行有意义的操作。"
correct2 = "是的：`echo` 生成一行，其中包含两次文件名，然后 `tail` 复制该行。"
err3 = "不：循环针对四个文件名中的每一个运行一次。"
err4 = "不：`tail` 的输入是每个文件名的 `echo` 输出。"
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

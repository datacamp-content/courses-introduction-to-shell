---
title: 组合工具
description: >-
  Unix shell
  的真正威力不在于单个命令本身，而在于它们可以轻松组合以完成新任务。本章将展示如何利用这种能力选择所需数据，并介绍用于排序数值和去重的命令。
lessons:
  - nb_of_exercises: 12
    title: 如何将命令输出保存到文件中？
---

## 如何把命令的输出保存到文件中？

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

到目前为止，您看到的所有工具都允许您指定输入文件。
多数工具没有用于指定输出文件的选项，因为并不需要。
相反，您可以使用**重定向**把任意命令的输出保存到您想要的位置。
如果您运行下面的命令：

```{shell}
head -n 5 seasonal/summer.csv
```

它会在屏幕上打印夏季数据的前 5 行。
如果改为运行：

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

屏幕上不会显示任何内容。
取而代之，`head` 的输出会被写入一个名为 `top.csv` 的新文件中。
您可以使用 `cat` 查看该文件的内容：

```{shell}
cat top.csv
```

大于号 `>` 告诉 shell 将 `head` 的输出重定向到文件。
它不是 `head` 命令的一部分；
相反，它适用于每一个会产生输出的 shell 命令。

`@instructions`
将 `tail` 与重定向结合使用，把 `seasonal/winter.csv` 的最后 5 行保存到名为 `last.csv` 的文件中。

`@hint`
使用 `tail -n 5` 获取最后 5 行。

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "行 `%s` 应该在文件 `last.csv` 中，但它不在。使用 `>` 将 `tail -n 5 seasonal/winter.csv` 的输出重定向到 `last.csv`。"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` 行数过多。您是否在 `tail` 中使用了 `-n 5` 标志？'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("很好！让我们再练习一些！")
```

---

## 如何把一个命令的输出当作另一个命令的输入？

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

假设您想从文件的中间取出若干行。
更具体地说，您想从我们的某个数据文件中获取第 3–5 行。
您可以先用 `head` 取出前 5 行，并将其重定向到一个文件，
然后再用 `tail` 选出最后 3 行：

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

快速检查可以确认这正是原始文件的第 3–5 行，
因为它是前 5 行中的最后 3 行。

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
从 `seasonal/winter.csv` 中选取最后两行，
并将其保存到名为 `bottom.csv` 的文件中。

`@hint`
使用 `tail` 选择行，并用 `>` 重定向 `tail` 的输出。

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="The line `%s` should be in the file `bottom.csv`, but it isn't. Redirect the output of `tail -n 2 seasonal/winter.csv` to `bottom.csv` with `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` 有太多行。您是否使用了 `tail` 的 `-n 2` 标志？'),
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
从 `bottom.csv` 中选取第一行，
以得到原始文件中倒数第二行。

`@hint`
使用 `head` 选择您需要的那一行。

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="`bottom.csv` 文件有问题。请确保您没有更改它！"),
    has_expr_output(strict=True, incorrect_msg="您是否在 `bottom.csv` 上正确使用了 `head`？请确保正确使用 `-n` 标志。")
)

Ex().success_msg("做得好。前往下一个练习，了解有关组合命令的更好方法。")                             

```

---

## 怎样更好地组合命令？

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

使用重定向来组合命令有两个缺点：

1. 会留下许多中间文件（如 `top.csv`）。
2. 生成最终结果的命令分散在多行历史记录里。

Shell 提供了另一个一次性解决这两个问题的工具，叫作 **pipe（管道）**。
再次，从运行 `head` 开始：

```{shell}
head -n 5 seasonal/summer.csv
```

这次不要把 `head` 的输出写入文件，
而是加上竖线并在其后使用不带文件名的 `tail` 命令：

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

管道符会告诉 Shell：把左侧命令的输出，作为右侧命令的输入。

`@instructions`
使用 `cut` 从以逗号分隔的文件 `seasonal/summer.csv` 的第 2 列选出所有牙齿名称，然后将结果通过管道传给 `grep`，并使用反向匹配来排除包含单词 "Tooth" 的表头行。*`cut` 和 `grep` 的详细用法分别在第 2 章的练习 8 和 11 中讲解过。*

`@hint`
- 命令的第一部分形式为 `cut -d field_delimiter -f column_number filename`。
- 命令的第二部分形式为 `grep -v thing_to_match`。

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
    has_expr_output(incorrect_msg = '您是否已将 `cut -d , -f 2 seasonal/summer.csv` 的结果通过 `|` 管道传输到 `grep -v Tooth`？'),
    check_not(has_output("Tooth"), incorrect_msg = '您是否使用 `grep` 排除了 `"Tooth"` 标题行？')
)
Ex().success_msg("完美的管道操作！这可能是您第一次使用 `|`，但绝对不会是最后一次！")
```

---

## 如何把多个命令组合起来？

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

您可以把任意数量的命令串联在一起。
例如，下面这条命令：

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

将会：

1. 从 spring 数据中选取第 1 列；
2. 去掉包含单词 "Date" 的表头行；
3. 只保留前 10 行实际数据。

`@instructions`
在上一个练习中，您使用了下面的命令，从 `seasonal/summer.csv` 的第 2 列中选出所有牙名：

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

在这条管道后再接一个 `head` 命令，只选出最前面的那个牙名。

`@hint`
复制并粘贴说明中的代码，追加一个管道符，然后使用带有 `-n` 选项的 `head` 命令。

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
    has_output('^\s*canine\s*$', incorrect_msg = "您是否使用了 `|` 来将管道扩展为 `head` 命令？请确保正确设置 `-n` 标志。"),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "您是否使用了 `|` 来将管道扩展为 `head` 命令？")
)
Ex().success_msg("愉快的链式操作！通过将多个命令链接在一起，您可以构建强大的数据处理管道。")
```

---

## 如何统计文件中的记录数？

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

命令 `wc`（"word count"的缩写）会打印文件中的**字**符数、**单**词数和**行**数。
您可以分别使用 `-c`、`-w` 或 `-l` 只打印其中一项。

`@instructions`
统计 `seasonal/spring.csv` 中日期位于 2017 年 7 月（`2017-07`）的记录数量。
- 为此，请使用 `grep` 通过部分日期筛选行，并将结果通过管道传给 `wc`，使用合适的标志统计行数。

`@hint`
- 使用 `head seasonal/spring.csv` 回顾日期格式。
- 命令的第一部分形式为 `grep 要匹配的内容 文件名`。
- 在管道符 `|` 之后，使用带有 `-l` 标志的 `wc`。

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
      has_code("grep", incorrect_msg = "您是否调用了 `grep`？"),
      has_code("2017-07", incorrect_msg = "您是否搜索了 `2017-07`？"),
      has_code("seasonal/spring.csv", incorrect_msg = "您是否搜索了 `seasonal/spring.csv` 文件？"),
      has_code("|", incorrect_msg = "您是否使用 `|` 管道传输到 `wc`？"),      
      has_code("wc", incorrect_msg = "您是否调用了 `wc`？"),
      has_code("-l", incorrect_msg = "您是否使用 `-l` 统计了行数？")
    )
  )
)
Ex().success_msg("仔细计数！确定您拥有多少数据是任何数据分析的第一步。")
```

---

## 如何一次性指定多个文件？

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

如果您提供多个文件名，大多数 shell 命令都可以对多个文件一起操作。
例如，
您可以一次性从所有季节性数据文件中提取第一列，如下所示：

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

但反复手动输入多个文件名并不是好主意：
既费时，
而且迟早会漏掉某个文件或重复某个文件名。
为此，
shell 允许您使用**通配符**，用一个表达式就能指定一组文件。
最常见的通配符是 `*`，
表示"匹配零个或多个字符"。
借助它，
我们可以把上面的 `cut` 命令缩短为：

```{shell}
cut -d , -f 1 seasonal/*
```

或者：

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
请写一条使用 `head` 的命令，只获取 `seasonal/spring.csv` 和 `seasonal/summer.csv` 各自的前三行数据，总共 6 行，但不要包含 autumn 或 winter 的数据文件。
请使用通配符，而不要把文件名完整拼写出来。

`@hint`
- 该命令的形式为 `head -n number_of_lines filename_pattern`。
- 例如，您可以用 `a/b*` 匹配目录 `a` 中以 `b` 开头的文件。

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
    has_expr_output(incorrect_msg = "您可以使用 `seasonal/s*` 来选择 `seasonal/spring.csv` 和 `seasonal/summer.csv`。请确保仅包含每个文件的前三行，并使用 `-n` 标志！"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "不要包含 `seasonal/autumn.csv` 的输出。您可以使用 `seasonal/s*` 来选择 `seasonal/spring.csv` 和 `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "不要包含 `seasonal/winter.csv` 的输出。您可以使用 `seasonal/s*` 来选择 `seasonal/spring.csv` 和 `seasonal/summer.csv`")
)
Ex().success_msg("精彩的通配符工作！如果您的目录包含数百或数千个文件，这一点变得更加重要。")
```

---

## 我还能使用哪些通配符？

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Shell 还有其他通配符，
不过使用频率较低：

- `?` 匹配单个字符，因此 `201?.txt` 会匹配 `2017.txt` 或 `2018.txt`，但不匹配 `2017-01.txt`。
- `[...]` 匹配方括号内的任意一个字符，因此 `201[78].txt` 会匹配 `2017.txt` 或 `2018.txt`，但不匹配 `2016.txt`。
- `{...}` 匹配花括号内以逗号分隔的任一模式，因此 `{*.txt, *.csv}` 会匹配所有以 `.txt` 或 `.csv` 结尾的文件，但不匹配以 `.pdf` 结尾的文件。

<hr/>

下列哪个表达式可以匹配 `singh.pdf` 和 `johel.txt`，但不会匹配 `sandhu.pdf` 或 `sandhu.txt`？

`@hint`
依次用每个通配符表达式去匹配每个文件名。

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- 不对：`.pdf` 和 `.txt` 不是文件名。
- 不对：这个会匹配到 `sandhu.pdf`。
- 不对：方括号中的表达式只匹配单个字符，而不是整个单词。
- 正确！

---

## 如何对文本行进行排序？

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

顾名思义，`sort` 用于对数据排序。默认按字母顺序升序排列，但可以使用标志 `-n` 按数值排序，使用 `-r` 将输出顺序反转；`-b` 会忽略开头的空格，而 `-f` 会进行大小写折叠（即不区分大小写）。管道中常先用 `grep` 去除不需要的记录，然后用 `sort` 对剩余记录排序。

`@instructions`
还记得用 `cut` 和 `grep` 从 `seasonal/summer.csv` 的第 2 列选出所有牙齿名称的组合吗？

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

以此为起点，对 `seasonal/winter.csv`（不是 `summer.csv`）中的牙齿名称按字母顺序降序排序。为此，在管道中追加一个 `sort` 步骤。

`@hint`
复制并粘贴说明中的命令，修改文件名，追加一个管道，然后使用带有 `-r` 标志的 `sort`。

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
      has_code("cut", incorrect_msg = "您是否调用了 `cut`？"),
      has_code("-d", incorrect_msg = "您是否使用 `-d` 指定了字段分隔符？"),
      has_code("seasonal/winter.csv", incorrect_msg = "您是否从 `seasonal/winter.csv` 文件中获取了数据？"),
      has_code("|", incorrect_msg = "您是否使用 `|` 从 `cut` 管道到 `grep` 再到 `sort`？"),      
      has_code("grep", incorrect_msg = "您是否调用了 `grep`？"),
      has_code("-v", incorrect_msg = "您是否使用 `-v` 反转了匹配？"),
      has_code("Tooth", incorrect_msg = "您是否搜索了 `Tooth`？"),
      has_code("sort", incorrect_msg = "您是否调用了 `sort`？"),
      has_code("-r", incorrect_msg = "您是否使用 `-r` 反转了排序顺序？")
    )
  )
)
Ex().success_msg("已排序！`sort` 有很多用途。例如，将 `sort -n` 管道到 `head` 可以显示最大的值。")
```

---

## 如何去除重复的行？

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

另一个常与 `sort` 搭配使用的命令是 `uniq`，
它的作用是删除重复的行。
更准确地说，
它只会删除「相邻」的重复行。
如果文件内容是：

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

那么 `uniq` 会输出：

```
2017-07-03
2017-08-03
```

但如果文件内容是：

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

那么 `uniq` 将打印这四行全部内容。
原因是 `uniq` 旨在处理非常大的文件。
为了从文件中删除不相邻的重复行，
它必须把整个文件保存在内存中
（或者至少，
保留到目前为止出现过的所有唯一行）。
只删除相邻的重复行时，
它只需在内存中保留最近的一行唯一内容即可。

`@instructions`
编写一条管道以：

- 从 `seasonal/winter.csv` 获取第 2 列，
- 从输出中去掉单词 "Tooth"，只保留牙齿名称，
- 对输出进行排序，使相同的牙齿名称相邻；以及
- 每个牙齿名称仅显示一次，并附带其出现次数。

您的管道开头与上一个练习相同：

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

在此基础上添加一个 `sort` 命令，并使用 `uniq -c` 来显示唯一行及其出现次数，而不是分别使用 `uniq` 和 `wc`。

`@hint`
复制并粘贴说明中的命令，先通过管道传给不带任何标志的 `sort`，再通过管道传给带有 `-c` 标志的 `uniq`。

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
                     incorrect_msg="您应该从这个命令开始：`cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`。现在扩展它！"),
            has_code('\|\s+sort', incorrect_msg="您是否用 `| sort` 扩展了命令？"),
            has_code('\|\s+uniq', incorrect_msg="您是否用 `| uniq` 扩展了命令？"),
            has_code('-c', incorrect_msg="您是否用 `-c` 包含了计数？")
        )
    )
)
Ex().success_msg("太好了！经过所有这些关于管道的工作，如果我们能存储结果，那不是很好吗？")
```

---

## 如何保存管道的输出？

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Shell 允许我们重定向一系列通过管道连接的命令的输出：

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

不过，`>` 必须出现在管道的末尾：
如果我们尝试把它放在中间，例如：

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

那么 `cut` 的所有输出都会被写入 `teeth-only.txt`，
因此就没有留给 `grep` 的内容，
它会一直等待输入。

<hr>

如果我们把重定向放在管道的最前面会怎样，例如：

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [命令的输出照常被重定向到文件。]
- Shell 会报告错误。
- Shell 会一直等待输入。

`@hint`
在 shell 中试一试。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['正确！', '不；实际上，shell 可以执行此操作。', '不；实际上，shell 可以执行此操作。'])
```

---

## 如何停止正在运行的程序？

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

到目前为止，您运行的命令和脚本都执行得很快，
但有些任务可能需要几分钟、几小时，甚至几天才能完成。
您也可能不小心在管道中间使用了重定向，
从而导致进程挂起。
如果您决定不再让某个程序继续运行，
可以按 `Ctrl` + `C` 将其终止。
在 Unix 文档中，这通常写作 `^C`；
注意字母 c 可以是小写。

`@instructions`
运行以下命令：

```{shell}
head
```

不给任何参数（这样它会一直等待永远不会到来的输入），
然后按 `Ctrl` + `C` 将其停止。

`@hint`
只需输入 head，按 Enter，然后用 `Ctrl` + `C` 结束正在运行的程序。

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="您是否使用了 `head`？")
```

---

## 总结

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

作为收尾，
您将构建一条管道，找出季节性数据文件中行数最少的那个文件包含多少条记录。

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
使用带合适参数的 `wc` 列出所有季节性数据文件的行数。
（使用通配符匹配文件名，而不是手动逐个输入。）

`@hint`
使用 `-l` 仅统计行数，并用 `*` 匹配文件名。

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
      has_code("wc", incorrect_msg = "您是否调用了 `wc`？"),
      has_code("-l", incorrect_msg = "您是否使用 `-l` 统计了行数？"),
      has_code("seasonal/\*", incorrect_msg = "您是否从所有 `seasonal/*` 文件中获取了数据？")
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
在上一条命令后通过管道再接一个命令，去掉包含单词 "total" 的那一行。

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
      has_code("wc", incorrect_msg = "您是否调用了 `wc`？"),
      has_code("-l", incorrect_msg = "您是否使用 `-l` 统计了行数？"),
      has_code("seasonal/\*", incorrect_msg = "您是否从所有 `seasonal/*` 文件中获取了数据？"),
      has_code("|", incorrect_msg = "您是否使用 `|` 从 `wc` 管道传输到 `grep`？"),      
      has_code("grep", incorrect_msg = "您是否调用了 `grep`？"),
      has_code("-v", incorrect_msg = "您是否使用 `-v` 反转了匹配？"),
      has_code("total", incorrect_msg = "您是否搜索了 `total`？")
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
再为管道添加两个阶段，使用 `sort -n` 和 `head -n 1` 找到行数最少的那个文件。

`@hint`
- 使用 `sort` 的 `-n` 标志按数值排序。
- 使用 `head` 的 `-n` 标志只保留 1 行。

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
      has_code("wc", incorrect_msg = "您是否调用了 `wc`？"),
      has_code("-l", incorrect_msg = "您是否使用 `-l` 统计了行数？"),
      has_code("seasonal/\*", incorrect_msg = "您是否从所有 `seasonal/*` 文件中获取了数据？"),
      has_code("|", incorrect_msg = "您是否使用 `|` 从 `wc` 管道到 `grep` 再到 `sort` 然后到 `head`？"),      
      has_code("grep", incorrect_msg = "您是否调用了 `grep`？"),
      has_code("-v", incorrect_msg = "您是否使用 `-v` 反转了匹配？"),
      has_code("total", incorrect_msg = "您是否搜索了 `total`？"),
      has_code("sort", incorrect_msg = "您是否调用了 `sort`？"),
      has_code("-n", incorrect_msg = "您是否指定了要保留的行数 `-n`？"),
      has_code("1", incorrect_msg = "您是否使用 `-n 1` 指定保留 1 行？")
    )
  )
)
Ex().success_msg("太棒了！事实证明 `autumn.csv` 是行数最少的文件。赶快进入第 4 章了解更多关于批处理的信息！")
```

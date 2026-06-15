---
title: 创建新工具
description: 历史记录让您只需按几下键就能重复操作，管道让您组合现有命令来创建新功能。在本章中，您将再进一步，学习如何创建您自己的新命令。
lessons:
  - nb_of_exercises: 9
    title: 如何编辑文件？
---

## 我怎样编辑文件？

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix 有多种多样的文本编辑器，常常让人眼花缭乱。
在本课程中，
我们将使用一个名为 Nano 的简单编辑器。
如果您输入 `nano filename`，
它会打开 `filename` 供您编辑
（如果文件不存在则会创建）。
您可以使用方向键移动光标，
用退格键删除字符，
并通过控制键组合执行其他操作：

- `Ctrl` + `K`：删除一行。
- `Ctrl` + `U`：撤销删除一行。
- `Ctrl` + `O`：保存文件（"O" 代表 "output"）。_您还需要按 Enter 确认文件名！_
- `Ctrl` + `X`：退出编辑器。

`@instructions`
运行 `nano names.txt` 在您的主目录中编辑一个新文件，
然后输入以下四行：

```
Lovelace
Hopper
Johnson
Wilson
```

要保存您写的内容，
按 `Ctrl` + `O` 将文件写出，
然后按 Enter 确认文件名，
最后按 `Ctrl` + `X` 退出编辑器。

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
patt = "您是否在 `names.txt` 文件中包含了行 `%s`？请再次使用 `nano names.txt` 更新您的文件。使用 `Ctrl` + `O` 保存并使用 `Ctrl` + `X` 退出。"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("做得好！继续下一个！")
```

---

## 我刚做的事要如何记录？

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

当您在做复杂分析时，
通常需要保留您使用过的命令记录。
您可以使用之前已经见过的工具来完成：

1. 运行 `history`。
2. 将其输出通过管道传给 `tail -n 10`（或者您想要保存的最近步骤数）。
3. 将结果重定向到一个类似 `figure-5.history` 的文件中。

这比把内容记在实验笔记本里更好，
因为它能保证不会遗漏任何步骤。
这也体现了 shell 的核心思想：
能产生和消费文本行的简单工具，
可以通过多种方式组合，
来解决各种各样的问题。

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
将文件 `seasonal/spring.csv` 和 `seasonal/summer.csv` 复制到您的主目录。

`@hint`
使用 `cp` 进行复制，并用 `~` 作为您主目录路径的快捷方式。

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="您是否使用了 `cp seasonal/s* ~` 将所需文件复制到您的主目录？"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("记录保存得非常好！如果您输入了错误的命令，您可以随时使用 `nano` 来清理保存的历史文件。")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
使用携带 `-h` 选项的 `grep`（阻止打印文件名）
以及 `-v Tooth`（选择与表头不匹配的行）
按顺序从 `spring.csv` 和 `summer.csv` 中筛选数据记录，
并将输出重定向到 `temp.csv`。

`@hint`
将选项放在文件名之前。

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "请确保您使用 `>` 将 `grep` 命令的输出重定向到 `temp.csv`！"
msg2 = "您是否使用了 `grep -h -v ___ ___ ___`（填空）来填充 `temp.csv`？"
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
将 `history` 通过管道传给 `tail -n 3`，
并把输出重定向到 `steps.txt`，
以便将最近的 3 条命令保存到文件中。
（需要保存 3 条而不是 2 条，
因为 `history` 命令本身也会出现在列表中。）

`@hint`
请记住，使用 `>` 进行重定向要放在整条管道命令序列的末尾。

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="请确保将命令的输出重定向到 `steps.txt`。"
msg2="您是否使用了 `history | tail ___ ___`（填空）来填充 `steps.txt`？"
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
Ex().success_msg("做得好！让我们更进一步！")
```

---

## 如何保存命令以便稍后重复运行？

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

到目前为止，您一直在交互式地使用 shell。
但由于您输入的命令只是文本，
您可以把它们保存在文件中，让 shell 反复运行。
要开始探索这一强大的能力，
请将下面的命令放入名为 `headers.sh` 的文件中：

```{shell}
head -n 1 seasonal/*.csv
```

该命令会从 `seasonal` 目录中的每个 CSV 文件中选取第一行。
创建好这个文件后，
您可以通过输入：

```{shell}
bash headers.sh
```

来运行它。
这会告诉 shell（它其实就是一个名为 `bash` 的程序）
去运行文件 `headers.sh` 中包含的命令，
其输出与直接运行这些命令相同。

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
使用 `nano dates.sh` 创建一个名为 `dates.sh` 的文件，
其中包含以下命令：

```{shell}
cut -d , -f 1 seasonal/*.csv
```

以便从 `seasonal` 中的所有 CSV 文件中提取第一列。

`@hint`
将所示命令原样放入文件中，不要添加多余的空行或空格。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "您是否在 `dates.sh` 文件中包含了 `cut -d , -f 1 seasonal/*.csv` 这一行？请再次使用 `nano dates.sh` 更新您的文件。使用 `Ctrl` + `O` 保存并使用 `Ctrl` + `X` 退出。"
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
使用 `bash` 运行文件 `dates.sh`。

`@hint`
使用 `bash filename` 来运行该文件。

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
      has_code("bash", incorrect_msg = '您是否调用了 `bash`？'),
      has_code("dates.sh", incorrect_msg = '您是否指定了 `dates.sh` 文件？')
    )
  )
)
```

---

## 如何复用管道？

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

包含一组 Shell 命令的文件称为***shell 脚本**，
有时也直接简称为 "script"（脚本）。脚本文件名不一定要以 `.sh` 结尾，
但本课将使用这一约定，
便于您分辨哪些文件是脚本。

脚本也可以包含管道。
例如，
如果 `all-dates.sh` 包含如下这一行：

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

那么：

```{shell}
bash all-dates.sh > dates.out
```

将会从季节性数据文件中提取唯一日期，
并将它们保存到 `dates.out` 中。

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
您的主目录中已为您准备好一个 `teeth.sh` 文件，但其中留有一些空白。
请使用 Nano 编辑该文件，并将两个 `____` 占位符
分别替换为 `seasonal/*.csv` 和 `-c`，以便此脚本打印出在 `seasonal` 目录下 CSV 文件中
每个牙齿名称出现的次数统计。

`@hint`
使用 `nano teeth.sh` 来编辑该文件。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="您是否已正确替换空白，以便 `teeth.sh` 中的命令为 `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`？请再次使用 `nano teeth.sh` 进行必要的更改。"
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
使用 `bash` 运行 `teeth.sh`，并用 `>` 将其输出重定向到 `teeth.out`。

`@hint`
请记住，`> teeth.out` 必须放在产生输出的命令之后。

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="您是否已正确地将 `bash teeth.sh` 的结果重定向到 `teeth.out` 文件中，并使用了 `>`？"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = '您是否调用了 `bash`？'),
      has_code("bash\s+teeth.sh", incorrect_msg = '您是否运行了 `teeth.sh` 文件？'),
      has_code(">\s+teeth.out", incorrect_msg = '您是否重定向到了 `teeth.out` 文件？')
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
运行 `cat teeth.out` 查看结果。

`@hint`
请记住，您可以先键入文件名的前几个字符，然后按 Tab 键自动补全。

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
      has_code("cat", incorrect_msg = '您调用了 `cat` 吗？'),
      has_code("teeth.out", incorrect_msg = '您指定了 `teeth.out` 文件吗？')
    )
  )
)
Ex().success_msg("很好！一开始这可能会显得很刻意，但好处是您正在逐步自动化工作流程的各个部分。作为数据科学家，这一点非常有用！")
```

---

## 如何将文件名传递给脚本？

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

处理特定文件的脚本可以作为您已完成工作的记录，但能处理任意文件的脚本更有用。
为此，您可以使用特殊表达式 `$@`（美元符号紧跟 at 符号），表示"传给脚本的所有命令行参数"。

例如，若 `unique-lines.sh` 中包含 `sort $@ | uniq`，当您运行：

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

shell 会将 `$@` 替换为 `seasonal/summer.csv` 并处理一个文件。若您运行：

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

它会处理两个数据文件，依此类推。

_提示：在 Nano 中保存您编写的内容，按 `Ctrl` + `O` 写出文件，回车确认文件名，然后按 `Ctrl` + `X` 退出编辑器。_

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
使用 Nano 编辑脚本 `count-records.sh`，将两个 `____` 占位符分别填写为 `$@` 和 `-l`（字母），以便统计一个或多个文件的行数，并排除每个文件的第一行。

`@hint`
* 使用 `nano count-records.sh` 编辑文件名。
* 请确保指定的是字母 `-l`，不是数字 1。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="您是否已正确替换空白，以便 `count-records.sh` 中的命令读取为 `tail -q -n +2 $@ | wc -l`？请再次使用 `nano count-records.sh` 进行所需的更改。"
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
在 `seasonal/*.csv` 上运行 `count-records.sh`，并使用 `>` 将输出重定向到 `num-records.out`。

`@hint`
使用 `>` 重定向输出。

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
      has_code("bash", incorrect_msg = '您是否调用了 `bash`？'),
      has_code("bash\s+count-records.sh", incorrect_msg = '您是否运行了 `count-records.sh` 文件？'),
      has_code("seasonal/\*", incorrect_msg = '您是否使用 `seasonal/*` 指定了要处理的文件？'),
      has_code(">\s+num-records.out", incorrect_msg = '您是否重定向到了 `num-records.out` 文件？')
    )
  )
)
Ex().success_msg("做得好！您的 shell 能力正在不断扩展！")
```

---

## 如何处理单个参数？

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

除了 `$@` 之外，
shell 还允许您使用 `$1`、`$2` 等来引用特定的命令行参数。
您可以利用这一点来编写比 shell 自带命令更简洁或更自然的脚本。
例如，
您可以创建一个名为 `column.sh` 的脚本，从 CSV 文件中选择单个列，
当用户把文件名作为第 1 个参数、列号作为第 2 个参数传入时：

```{shell}
cut -d , -f $2 $1
```

然后通过以下方式运行：

```{shell}
bash column.sh seasonal/autumn.csv 1
```

请注意，脚本对这两个参数的使用顺序是相反的。

<hr>

脚本 `get-field.sh` 需要接受一个文件名、
要选择的行号、
要选择的列号，
并仅从一个 CSV 文件中打印该字段。
例如：

```
bash get-field.sh seasonal/summer.csv 4 2
```

应当从 `seasonal/summer.csv` 的第 4 行选择第 2 个字段。
下面哪些命令应写入 `get-field.sh` 才能实现上述功能？

`@hint`
请记住，命令行参数是从左到右编号的。

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- 不对：那样会把文件名当作 `head` 要选择的行数来用。
- 正确！
- 不对：那样会把列号当作行号，反之亦然。
- 不对：那样会把字段号当作文件名，反之亦然。

---

## 如何让一个 shell 脚本完成多件事？

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

到目前为止，我们的 shell 脚本只包含一个命令或一条管道，但脚本可以包含多行命令。比如，您可以创建一个脚本，告诉您数据文件中最短和最长文件各有多少条记录，也就是数据集长度的范围。

注意，在 Nano 中，"复制粘贴"的方式是：先移动到要复制的那一行，按下 `CTRL` + `K` 剪切该行，然后按两次 `CTRL` + `U` 以粘贴出两份副本。

_提醒一下，在 Nano 中保存您写的内容：按 `Ctrl` + `O` 写入文件，然后按 Enter 确认文件名，最后按 `Ctrl` + `X` 退出编辑器。_

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
使用 Nano 编辑脚本 `range.sh`
并将两个 `____` 占位符
替换为 `$@` 和 `-v`
使其列出命令行中给出的所有文件的名称和行数，且
不要
显示所有文件行数的总计。
（不要尝试从文件中减去列表头这一行。）

`@hint`
使用 `wc -l $@` 统计命令行中给出的所有文件的行数。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="您是否已正确替换空白，以便 `range.sh` 中的命令读取为 `wc -l $@ | grep -v total`？请再次使用 `nano range.sh` 进行所需的更改。"
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
再次使用 Nano，在 `range.sh` 的管道中按顺序加入 `sort -n` 和 `head -n 1`
以显示传入文件中最短文件的名称和行数。

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="您是否已将 `sort -n` 和 `head -n 1` 与管道添加到 `range.sh` 文件中？请再次使用 `nano range.sh` 进行所需的更改。"
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
仍然使用 Nano，在 `range.sh` 中再添加一行，以打印目录中
最长
文件的名称和记录数，
并同时显示最短文件。
这一行应与您已写的那一行完全相同，
只是将 `sort -n` 改为 `sort -n -r`。

`@hint`
复制第一行并修改排序顺序。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="请保留 `range.sh` 文件中的第一行：`wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="您是否在 `range.sh` 中复制了第一行并做了一个小改动？使用 `sort -n -r` 代替 `sort -n`！"
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
在 `seasonal` 目录中的文件上运行该脚本，
使用 `seasonal/*.csv` 匹配所有文件，
并使用 `>` 重定向输出，
将结果写到您主目录中的名为 `range.out` 的文件。

`@hint`
使用 `bash range.sh` 运行脚本，使用 `seasonal/*.csv` 指定文件，并用 `> range.out` 重定向输出。

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="您是否已正确地将 `bash range.sh seasonal/*.csv` 的结果重定向到 `range.out`，并使用了 `>`？"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = '您是否调用了 `bash`？'),
has_code("bash\s+range.sh", incorrect_msg = '您是否运行了 `range.sh` 文件？'),
has_code("seasonal/\*", incorrect_msg = '您是否使用 `seasonal/*` 指定了要处理的文件？'),
has_code(">\s+range.out", incorrect_msg = '您是否重定向到了 `range.out` 文件？')
)
)

Ex().success_msg("进展顺利。继续进行下一个练习，学习如何编写循环！")
```

---

## 如何在 shell 脚本中编写循环？

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shell 脚本也可以包含循环。您可以用分号把它们写在同一行，或者为了更易读，将它们分成多行且不加分号：

```{shell}
# 打印每个文件的第一条和最后一条数据记录。
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

（循环体内的命令不一定要缩进，但缩进会让结构更清晰。）

脚本的第一行是一个**注释**，用于告诉读者脚本的作用。注释以 `#` 开头并一直延续到行尾。给您未来的自己一个便利，请像这里这样为您编写的每个脚本加上简短说明。

_提醒一下：在 Nano 中保存您写好的内容时，先按 `Ctrl` + `O` 写出文件，回车确认文件名，然后按 `Ctrl` + `X` 退出编辑器。_

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
在脚本 `date-range.sh` 中填充占位符，
用 `$filename`（两处）、`head` 和 `tail`
使其能从一个或多个文件中打印第一天和最后一天的日期。

`@hint`
请记得使用 `$filename` 来获取循环变量的当前值。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="在 `date-range.sh` 中，您是否已将循环中的 %s 行更改为 `%s`？使用 `nano date-range.sh` 进行更改。"
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('first', cmdpatt%'head')
msg2=msgpatt%('second', cmdpatt%'tail')
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
对 4 个季节性数据文件运行 `date-range.sh`，
使用 `seasonal/*.csv` 来匹配它们的文件名。

`@hint`
通配符表达式应以目录名开头。

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
      has_code("bash", incorrect_msg = '您是否调用了 `bash`？'),
      has_code("bash\s+date-range.sh", incorrect_msg = '您是否运行了 `date-range.sh` 文件？'),
      has_code("seasonal/\*", incorrect_msg = '您是否使用 `seasonal/*` 指定了要处理的文件？')
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
对 4 个季节性数据文件运行 `date-range.sh`，使用 `seasonal/*.csv` 来匹配它们的文件名，
并将其输出通过管道传给 `sort`，以验证您的脚本可以像 Unix 内置命令一样使用。

`@hint`
使用与之前相同的通配符表达式。

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
      has_code("bash", incorrect_msg = '您是否调用了 `bash`？'),
      has_code("bash\s+date-range.sh", incorrect_msg = '您是否运行了 `date-range.sh` 文件？'),
      has_code("seasonal/\*", incorrect_msg = '您是否使用 `seasonal/*` 指定了要处理的文件？'),
      has_code("|", incorrect_msg = '您是否将脚本输出通过管道传递给 `sort`？'),
      has_code("sort", incorrect_msg = '您是否调用了 `sort`？')
    )
  )
)
Ex().success_msg("太棒了！注意我们所学的一切是多么具有组合性。")
```

---

## 如果我不提供文件名，会发生什么？

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

在 shell 脚本（以及交互式命令）中，一个常见错误是把文件名放错位置。
如果您输入：

```{shell}
tail -n 3
```

由于没有给 `tail` 提供任何文件名，
它会等待从您的键盘读取输入。
这意味着如果您输入：

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

那么 `tail` 会照常打印 `somefile.txt` 的最后 3 行，
但 `head` 会一直等待键盘输入，
因为它没有得到文件名，且在管道中它前面没有任何输入源。

<hr>

假设您不小心输入了：

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

接下来应该怎么做？

`@possible_answers`
- 等待 10 秒让 `head` 超时。
- 输入 `somefile.txt` 并按 Enter，为 `head` 提供一些输入。
- 使用 `Ctrl` + `C` 停止正在运行的 `head` 程序。

`@hint`
如果 `head` 没有得到文件名，且其上游没有任何输入，它会做什么？

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = '不，命令不会超时。'
a2 = '不，那会给 `head` 文本 `somefile.txt` 进行处理，但随后它会挂起等待更多输入。'
a3 = "是的！您应该使用 `Ctrl` + `C` 来停止正在运行的程序。这就结束了本入门课程！如果您有兴趣学习更多命令行工具，我们强烈推荐参加我们的免费 Git 入门课程！"
Ex().has_chosen(3, [a1, a2, a3])
```

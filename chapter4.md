---
title: 批次處理
description: 多數 shell 指令可以一次處理許多檔案。本章將說明如何讓你自己的管線也做到這點。過程中，你會看到 shell 如何用變數來儲存資訊。
lessons:
  - nb_of_exercises: 10
    title: shell 如何儲存資訊？
---

## Shell 如何儲存資訊？

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

和其他程式一樣，shell 會把資訊存放在變數中。
其中有一部分稱為 **環境變數**，隨時都可用。
環境變數的名稱慣例上使用全大寫，
下面列出幾個常用的例子。

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | 使用者的家目錄                    | `/home/repl`          |
| `PWD `   | 目前工作目錄                      | 與 `pwd` 指令相同     |
| `SHELL`  | 正在使用的 shell 程式             | `/bin/bash`           |
| `USER`   | 使用者的 ID                        | `repl`                |

若要取得完整清單（會相當長），
你可以在 shell 中輸入 `set`。

<hr>

使用 `set` 搭配管線與 `grep` 顯示 `HISTFILESIZE` 的值，
它決定指令歷史會保留多少舊指令。
它的值是多少？

`@possible_answers`
- 10
- 500
- [2000]
- 變數不存在。

`@hint`
使用 `set | grep HISTFILESIZE` 來取得你需要的那一行。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "不對：shell 記錄的歷史比這個多。"
err2 = "不對：shell 記錄的歷史比這個多。"
correct3 = "正確：在此系統上，shell 預設會保存 2000 條舊命令。"
err4 = "不對：變數 `HISTFILESIZE` 存在。"
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## 怎麼印出變數的值？

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

找出變數值更簡單的方法是使用 `echo` 指令，它會印出所收到的引數。輸入：

```{shell}
echo hello DataCamp!
```

會印出：

```
hello DataCamp!
```

如果你嘗試用它像這樣印出變數的值：

```{shell}
echo USER
```

它會印出變數的名稱 `USER`。

若要取得變數的值，必須在前面加上錢號 `$`。輸入：

```{shell}
echo $USER
```

會印出：

```
repl
```

各處都是相同的規則：
如果要取得名為 `X` 的變數值，
你必須寫成 `$X`。
（這樣做是為了讓 shell 能分辨你指的是「名為 X 的檔案」
還是「名為 X 的變數值」。）

`@instructions`
變數 `OSTYPE` 保存你所使用作業系統的名稱。
使用 `echo` 顯示它的值。

`@hint`
在變數 `OSTYPE` 前面加上 `$`，再呼叫 `echo`。

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
            has_code('echo', incorrect_msg="您是否呼叫了 `echo`？"),
            has_code('OSTYPE', incorrect_msg="您是否列印了 `OSTYPE` 環境變數？"),
            has_code(r'\$OSTYPE', incorrect_msg="請確保在 `OSTYPE` 前加上 `$`。")
        )
    )
)
Ex().success_msg("環境變數的回音非常出色！您有了一個良好的開始。讓我們繼續！")
```

---

## Shell 還會用哪些方式儲存資訊？

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

另一種變數稱為 **shell 變數**，
類似於程式語言中的區域變數。

要建立一個 shell 變數，
只要把值指派給一個名稱即可：

```{shell}
training=seasonal/summer.csv
```

`=` 兩側都不要有空白字元。
完成後，
你可以用下列指令檢查變數的值：

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
定義一個名為 `testing` 的變數，值為 `seasonal/winter.csv`。

`@hint`
變數名稱與其值之間不應該有空白字元。

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
        has_code('testing', incorrect_msg='您是否定義了一個名為 `testing` 的 shell 變數？'),
        has_code('testing=', incorrect_msg='您是否在 testing 之後直接寫了 `=`，沒有空格？'),
        has_code('=seasonal/winter\.csv', incorrect_msg='您是否將 `testing` 的值設置為 `seasonal/winter.csv`？')
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
使用 `head -n 1 SOMETHING` 取得 `seasonal/winter.csv` 的第一行，
並用變數 `testing` 的值來代替檔名。

`@hint`
請記得使用 `$testing` 而不是只用 `testing`
（需要加上 `$` 才能取得變數的值）。

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
    has_code(r'\$testing', incorrect_msg="您是否使用 `$testing` 來引用 shell 變數？"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="您是否呼叫了 `head`？"),
            has_code('-n', incorrect_msg="您是否使用 `-n` 限制了行數？"),
            has_code(r'-n\s+1', incorrect_msg="您是否選擇使用 `-n 1` 保留 1 行？")     
        )
    )
)
Ex().success_msg("太棒了！讓我們看看您如何輕鬆重複命令。")
```

---

## 我要如何重複執行同一個指令多次？

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Shell 變數也常用在**迴圈**中，
用來把同一個指令重複執行很多次。
如果我們執行以下指令：

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

會得到：

```
gif
jpg
png
```

請注意這個迴圈的幾個重點：

1. 結構是 `for` …變數… `in` …清單… `; do` …主體… `; done`
2. 要讓迴圈處理的清單（在這裡是 `gif`、`jpg`、`png` 這些字）。
3. 記錄目前迴圈正在處理哪一個項目的變數（在這裡是 `filetype`）。
4. 進行處理的迴圈主體（在這裡是 `echo $filetype`）。

注意，主體使用 `$filetype` 來取得變數的值，而不是僅寫 `filetype`，
就跟使用其他 shell 變數時一樣。
另外也要留意分號的位置：
第一個分號在清單與關鍵字 `do` 之間，
第二個分號在主體與關鍵字 `done` 之間。

`@instructions`
修改這個迴圈，讓它印出：

```
docx
odt
pdf
```

請使用 `filetype` 作為迴圈變數名稱。

`@hint`
使用前言中的程式碼結構，把影像檔案類型換成文件檔案類型即可。

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
      has_code('for', incorrect_msg='您是否呼叫了 `for`？'),
      has_code('filetype', incorrect_msg='您是否使用 `filetype` 作為迴圈變數？'),
      has_code('in', incorrect_msg='您是否在檔案類型列表之前使用了 `in`？'),
      has_code('docx odt pdf', incorrect_msg='您是否按順序遍歷了 `docx`、`odt` 和 `pdf`？'),
      has_code(r'pdf\s*;', incorrect_msg='您是否在最後一個迴圈元素後加上了分號？'),
      has_code(r';\s*do', incorrect_msg='您是否在第一個分號後使用了 `do`？'),
      has_code('echo', incorrect_msg='您是否呼叫了 `echo`？'),
      has_code(r'\$filetype', incorrect_msg='您是否回顯了 `$filetype`？'),
      has_code(r'filetype\s*;', incorrect_msg='您是否在迴圈體後加上了分號？'),
      has_code('; done', incorrect_msg='您是否以 `done` 結束？')
    )
  )
)
Ex().success_msg("一流的迴圈！如果您想做相同的事情數百或數千次，迴圈是很棒的選擇。")
```

---

## 我怎麼針對每個檔案各執行一次指令？

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

在寫迴圈時，你當然可以手動輸入要處理的檔名，
但通常用萬用字元會更好。
試著在主控台執行這個迴圈：

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

它會印出：

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

因為 shell 會在執行迴圈之前，先把 `seasonal/*.csv` 展開成四個檔名的清單。

`@instructions`
把萬用字元的表達式改成 `people/*`，
讓迴圈印出 `people` 資料夾中的所有檔名，
不論它們有沒有任何副檔名。
請使用 `filename` 作為你的迴圈變數名稱。

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
      has_code('for', incorrect_msg='您有呼叫 `for` 嗎？'),
      has_code('filename', incorrect_msg='您有使用 `filename` 作為迴圈變數嗎？'),
      has_code('in', incorrect_msg='您有在檔案類型列表之前使用 `in` 嗎？'),
      has_code('people/\*', incorrect_msg='您有使用 `people/*` 指定檔案列表嗎？'),
      has_code(r'people/\*\s*;', incorrect_msg='您有在檔案列表後加上分號嗎？'),
      has_code(r';\s*do', incorrect_msg='您有在第一個分號後使用 `do` 嗎？'),
      has_code('echo', incorrect_msg='您有呼叫 `echo` 嗎？'),
      has_code(r'\$filename', incorrect_msg='您有回顯 `$filename` 嗎？'),
      has_code(r'filename\s*;', incorrect_msg='您有在迴圈主體後加上分號嗎？'),
      has_code('; done', incorrect_msg='您有以 `done` 結束嗎？')
    )
  )
)
Ex().success_msg("迴圈的迴圈！萬用字元和迴圈是強大的組合。")
```

---

## 我要如何記錄一組檔案的名稱？

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

人們常用萬用字元運算式來設定一個變數，用以記錄檔名清單。
例如，若你像這樣定義 `datasets`：

```{shell}
datasets=seasonal/*.csv
```

之後就能用下列方式顯示這些檔案的名稱：

```{shell}
for filename in $datasets; do echo $filename; done
```

這麼做可以少打不少字，也比較不容易出錯。

<hr>

如果你在自己的家目錄中執行以下兩行指令，
它們會印出幾行輸出？

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- 沒有：因為 `files` 是在前一行定義的，所以在第二行沒有值。
- 一行：就是「files」這個字。
- 四行：四個季節性資料檔的檔名。

`@hint`
記住，單獨的 `X` 只是「X」，而 `$X` 代表變數 `X` 的值。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "不：您不必在使用變數的同一行定義它。"
err2 = "不：此範例在同一個 shell 中定義並使用了變數 `files`。"
correct3 = "正確。該命令等同於 `for f in seasonal/*.csv; do echo $f; done`。"
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## 變數名稱與其值的差別

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

一個常見的錯誤是忘了在變數名稱前加上 `$`。
當你這麼做時，
shell 會使用你輸入的名稱，
而不是該變數的值。

對有經驗的使用者來說，更常見的錯誤是把變數名稱打錯。
例如，
如果你這樣定義 `datasets`：

```{shell}
datasets=seasonal/*.csv
```

然後輸入：

```{shell}
echo $datsets
```

shell 不會印出任何東西，
因為 `datsets`（少了第二個「a」）沒有被定義。

<hr>

如果你在家目錄執行下列兩個指令，
會印出什麼輸出？

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

（回答前請仔細閱讀迴圈的第一部分。）

`@hint`
記住，單獨寫 `X` 只是字串「X」，而 `$X` 才是變數 `X` 的值。

`@possible_answers`
- [一行：字詞「files」。]
- 四行：四個季節性資料檔的所有檔名。
- 四行空白：變數 `f` 沒有被指定值。

`@feedback`
- 正確：這個迴圈使用的是 `files` 而不是 `$files`，所以清單只包含字詞「files」。
- 不對：這個迴圈使用的是 `files` 而不是 `$files`，所以清單只包含字詞「files」，而不是 `files` 展開後的內容。
- 不對：變數 `f` 是由 `for` 迴圈自動定義的。

---

## 如何在同一個迴圈中執行多個指令？

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

列印檔名對除錯很有幫助，
但迴圈的真正用途是一次處理多個檔案。
下面這個迴圈會列印每個資料檔的第 2 行：

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

它的結構和你已經看過的其他迴圈相同：
唯一不同的是，它的主體不是單一指令，而是由兩個指令組成的管線。

`@instructions`
撰寫一個迴圈，列印每個 seasonal 檔案中 2017 年 7 月（`2017-07`）的最後一筆記錄。輸出應與下列結果類似：

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

但要對每一個 seasonal 檔案分別執行。請使用 `file` 作為迴圈變數名稱，並記得要遍歷 `seasonal/*.csv` 這份檔案清單（而不是像範例中使用的『seasonal/winter.csv』）。

`@hint`
迴圈主體就是說明中顯示的 grep 指令，將 `seasonal/winter.csv` 改成 `$file` 即可。

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
  has_code('for', incorrect_msg='您有使用 `for` 嗎？'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='您有使用 `file` 作為迴圈變數嗎？'),
      has_code('in', incorrect_msg='您有在檔案列表前使用 `in` 嗎？'),
      has_code('seasonal/\*', incorrect_msg='您有使用 `seasonal/*` 指定檔案列表嗎？'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='您有在檔案列表後加上分號嗎？'),
      has_code(r';\s*do', incorrect_msg='您有在第一個分號後使用 `do` 嗎？'),
      has_code('grep', incorrect_msg='您有使用 `grep` 嗎？'),
      has_code('2017-07', incorrect_msg='您有匹配 `2017-07` 嗎？'),
      has_code(r'\$file', incorrect_msg='您有使用 `$file` 作為迴圈變數的名稱嗎？'),
      has_code(r'file\s*|', incorrect_msg='您有使用管道來連接第二個命令嗎？'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='您有在第二個命令中使用 `tail -n 1` 來列印每次搜尋的最後一個條目嗎？'),
      has_code('; done', incorrect_msg='您有以 `done` 結束嗎？')
    )
  )
)

Ex().success_msg("迴圈的迴圈！萬用字元和迴圈是強大的組合。")
```

---

## 為什麼檔名不該包含空白？

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

在使用圖形化檔案總管時，給檔案取像是 `July 2017.csv` 這樣的多字名稱既簡單又合理。
不過，當你在 shell 中工作時，這會造成問題。
例如，假設你想把 `July 2017.csv` 重新命名為 `2017 July data.csv`。
你不能輸入：

```{shell}
mv July 2017.csv 2017 July data.csv
```

因為在 shell 看來，你像是要把四個檔案 `July`、`2017.csv`、`2017` 和（再次出現的）`July`，
移動到名為 `data.csv` 的目錄中。
相反地，
你必須為檔名加上引號，
讓 shell 把每個檔名視為單一參數：

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

如果你有兩個檔案，分別叫做 `current.csv` 和 `last year.csv`
（後者的檔名中有空白），
而你輸入：

```{shell}
rm current.csv last year.csv
```

會發生什麼事：

`@hint`
如果有人給你看了這個指令，而你又不知道目前有哪些檔案存在，你會預期會發生什麼事？

`@possible_answers`
- shell 會印出錯誤訊息，因為 `last` 和 `year.csv` 並不存在。
- shell 會刪除 `current.csv`。
- [以上皆是。]
- 什麼也不會發生。

`@feedback`
- 沒錯，但不只如此。
- 沒錯，但不只如此。
- 正確。你可以用單引號（`'`）或雙引號（`"`）把檔名包起來。
- 很可惜不是這樣。

---

## 如何在單一迴圈中完成多件事？

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

到目前為止你看到的迴圈，迴圈主體中都只包含一個指令或一條管線，
但其實一個迴圈可以包含任意多個指令。
為了告訴 shell 一個指令何時結束、下一個指令何時開始，
你必須用分號分隔它們：

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

假設你忘了在前一個迴圈中的 `echo` 與 `head` 指令之間加上分號，
因此你要 shell 執行：

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

shell 會怎麼做？

`@possible_answers`
- 列印錯誤訊息。
- 對四個檔案各列印一行。
- 只列印 `autumn.csv`（第一個檔案）的一行。
- 列印每個檔案的最後一行。

`@hint`
你可以把 `echo` 的輸出以管線傳給 `tail`。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "不：迴圈會運行，只是它不會執行有意義的操作。"
correct2 = "是的：`echo` 會產生一行，其中包含兩次檔案名，然後 `tail` 會複製該行。"
err3 = "不：迴圈對於四個檔案名中的每一個都會運行一次。"
err4 = "不：`tail` 的輸入是每個檔案名的 `echo` 輸出。"
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

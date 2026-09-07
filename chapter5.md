---
title: 建立新工具
description: 歷史功能讓你用幾個按鍵就能重做先前的操作，而管線則能將既有指令組合成新功能。本章將帶你更進一步，建立屬於你自己的新指令。
lessons:
  - nb_of_exercises: 9
    title: 我要如何編輯檔案？
---

## 我要如何編輯檔案？

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix 有非常多種文字編輯器，可能讓人眼花撩亂。
在本課程中，
我們會使用一個簡單的編輯器，叫做 Nano。
如果你輸入 `nano filename`，
它會開啟 `filename` 讓你編輯
（如果檔案不存在，會自動建立）。
你可以用方向鍵移動游標，
用退格鍵刪除字元，
並透過控制鍵組合做其他操作：

- `Ctrl` + `K`：刪除一整行。
- `Ctrl` + `U`：還原上一個被刪除的行。
- `Ctrl` + `O`：儲存檔案（「O」代表 output）。_你也需要按 Enter 來確認檔名！_
- `Ctrl` + `X`：離開編輯器。

`@instructions`
執行 `nano names.txt` 在你的家目錄中編輯一個新檔案，
然後輸入以下四行內容：

```
Lovelace
Hopper
Johnson
Wilson
```

若要儲存你輸入的內容，
按 `Ctrl` + `O` 將檔案寫出，
再按 Enter 確認檔名，
最後按 `Ctrl` + `X` 離開編輯器。

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
patt = "您是否已在 `names.txt` 文件中包含了行 `%s`？再次使用 `nano names.txt` 更新您的文件。使用 `Ctrl` + `O` 保存，`Ctrl` + `X` 退出。"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("做得好！繼續下一個！")
```

---

## 我要如何記錄我剛剛做了什麼？

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

當你在做一個複雜的分析時，
通常會想要保留你所使用指令的紀錄。
你可以用之前看過的工具來做到：

1. 執行 `history`。
2. 把它的輸出 pipe 到 `tail -n 10`（或任意你想保留的最近步驟數）。
3. 再把結果重新導向到一個像 `figure-5.history` 這樣的檔案。

這比在實驗筆記本上手寫下來更好，
因為它能保證不會漏掉任何步驟。
這也說明了 shell 的核心理念：
能產生與消耗純文字行的簡單工具，
可以用多種方式組合，
來解決各式各樣的問題。

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
將 `seasonal/spring.csv` 和 `seasonal/summer.csv` 複製到你的家目錄。

`@hint`
使用 `cp` 來複製，並用 `~` 當作家目錄路徑的捷徑。

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="您是否使用了 `cp seasonal/s* ~` 將所需的文件複製到您的主目錄中？"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("卓越的記錄保存！如果您輸入了錯誤的命令，您可以隨時使用 `nano` 來清理保存的歷史文件。")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
使用 `grep` 搭配 `-h` 旗標（避免輸出檔名）
以及 `-v Tooth`（選出「不」符合表頭行的那些列），
依序從 `spring.csv` 與 `summer.csv` 取出資料記錄，
並把輸出重新導向到 `temp.csv`。

`@hint`
把旗標放在檔名之前。

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "請確保您使用 `>` 將 `grep` 命令的輸出重定向到 `temp.csv`！"
msg2 = "您是否使用了 `grep -h -v ___ ___ ___`（填寫空格）來填充 `temp.csv`？"
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
將 `history` pipe 到 `tail -n 3`，
並把輸出重新導向到 `steps.txt`，
把最後 3 個指令存到檔案中。
（你需要存 3 個而不是 2 個，
因為 `history` 這個指令本身也會出現在清單裡。）

`@hint`
記得使用 `>` 做重新導向時，要放在整段 pipe 指令序列的最後面。

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="請確保將命令的輸出重定向到 `steps.txt`。"
msg2="您是否使用了 `history | tail ___ ___`（填寫空格）來填充 `steps.txt`？"
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
Ex().success_msg("做得好！讓我們更進一步！")
```

---

## 我要如何儲存指令以便之後重複執行？

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

到目前為止，你一直是互動式地使用 shell。
但因為你輸入的指令其實就是文字，
你可以把它們存成檔案，讓 shell 一次又一次地執行。
為了開始體驗這個強大的功能，
請把以下指令放到一個名為 `headers.sh` 的檔案中：

```{shell}
head -n 1 seasonal/*.csv
```

這個指令會從 `seasonal` 目錄裡的每個 CSV 檔案擷取第一列。
建立好這個檔案後，
你可以這樣執行它：

```{shell}
bash headers.sh
```

這是在告訴 shell（其實就是名為 `bash` 的程式）
去執行 `headers.sh` 檔案中的指令，
其輸出會和你直接執行這些指令時相同。

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
使用 `nano dates.sh` 建立一個名為 `dates.sh` 的檔案，
內容包含以下指令：

```{shell}
cut -d , -f 1 seasonal/*.csv
```

用來從 `seasonal` 目錄中的所有 CSV 檔案擷取第一欄。

`@hint`
把顯示的指令原樣放進檔案中，不要多加空白行或空白字元。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "您是否已在 `dates.sh` 文件中包含了這行 `cut -d , -f 1 seasonal/*.csv`？請再次使用 `nano dates.sh` 更新您的文件。使用 `Ctrl` + `O` 保存，`Ctrl` + `X` 退出。"
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
使用 `bash` 來執行檔案 `dates.sh`。

`@hint`
使用 `bash 檔名` 來執行該檔案。

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
      has_code("bash", incorrect_msg = '您是否呼叫了 `bash`？'),
      has_code("dates.sh", incorrect_msg = '您是否指定了 `dates.sh` 檔案？')
    )
  )
)
```

---

## 我要如何重複使用管線？

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

包含大量 shell 指令的檔案稱為***shell script***，
或簡稱「script」。Script 不一定要以 `.sh` 作為副檔名，
但本課會沿用這個慣例，
以方便你分辨哪些檔案是 script。

Script 也可以包含管線。
例如，
如果 `all-dates.sh` 含有以下這一行：

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

那麼：

```{shell}
bash all-dates.sh > dates.out
```

就會從 seasonal 的資料檔中擷取不重複的日期，
並將結果存到 `dates.out`。

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
你的家目錄中已經為你準備好一個 `teeth.sh` 檔案，但裡面有幾處空白。
使用 Nano 編輯該檔案，將兩個 `____` 佔位符分別替換為 `seasonal/*.csv` 和 `-c`，
讓這個 script 能列印各牙齒名稱在 `seasonal` 目錄下 CSV 檔案中出現的次數統計。

`@hint`
使用 `nano teeth.sh` 來編輯檔案。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="您是否已正確替換空白處，以便 `teeth.sh` 中的命令為 `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`？請再次使用 `nano teeth.sh` 進行所需的更改。"
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
使用 `bash` 執行 `teeth.sh`，並用 `>` 將其輸出重新導向到 `teeth.out`。

`@hint`
記得 `> teeth.out` 必須放在產生輸出的指令之後。

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="您是否已正確地將 `bash teeth.sh` 的結果重定向到 `teeth.out`，並使用 `>`？"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = '您有呼叫 `bash` 嗎？'),
      has_code("bash\s+teeth.sh", incorrect_msg = '您有執行 `teeth.sh` 檔案嗎？'),
      has_code(">\s+teeth.out", incorrect_msg = '您有將結果重定向到 `teeth.out` 檔案嗎？')
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
執行 `cat teeth.out` 檢視結果。

`@hint`
提醒你，可以先輸入檔名的前幾個字元，然後按下 Tab 鍵自動完成。

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
      has_code("cat", incorrect_msg = '您有呼叫 `cat` 嗎？'),
      has_code("teeth.out", incorrect_msg = '您有指定 `teeth.out` 檔案嗎？')
    )
  )
)
Ex().success_msg("很好！一開始這一切可能感覺有些刻意，但好處是您正在逐步自動化工作流程的部分。這對於資料科學家來說非常有用！")
```

---

## 我要如何把檔名傳給腳本？

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

會處理特定檔案的腳本能記錄你做過什麼，但能讓你處理任何想要的檔案的腳本更實用。
為了支援這點，
你可以使用特殊表示式 `$@`（美元符號後面緊接著 at 符號）
來代表「傳給腳本的所有命令列參數」。

例如，如果 `unique-lines.sh` 裡是 `sort $@ | uniq`，當你執行：

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

shell 會把 `$@` 替換成 `seasonal/summer.csv`，並處理單一檔案。若你改執行：

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

它就會處理 2 個資料檔案，依此類推。

_提醒你，在 Nano 中儲存編寫內容：請按 `Ctrl` + `O` 將檔案寫出，然後按 Enter 確認檔名，最後按 `Ctrl` + `X` 離開編輯器。_

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
使用 Nano 編輯 `count-records.sh`，將兩個 `____` 佔位符分別填入 `$@` 和 `-l`（字母），讓它能在一個或多個檔案中計算行數，並排除每個檔案的第一行。

`@hint`
* 使用 `nano count-records.sh` 來編輯檔名。
* 確認你指定的是字母 `-l`，而不是數字 1。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="您是否已正確替換空白處，使 `count-records.sh` 中的命令為 `tail -q -n +2 $@ | wc -l`？請再次使用 `nano count-records.sh` 進行所需的更改。"
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
在 `seasonal/*.csv` 上執行 `count-records.sh`，並使用 `>` 將輸出重新導向到 `num-records.out`。

`@hint`
使用 `>` 重新導向輸出。

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
      has_code("bash", incorrect_msg = '您有呼叫 `bash` 嗎？'),
      has_code("bash\s+count-records.sh", incorrect_msg = '您有執行 `count-records.sh` 檔案嗎？'),
      has_code("seasonal/\*", incorrect_msg = '您有使用 `seasonal/*` 指定要處理的檔案嗎？'),
      has_code(">\s+num-records.out", incorrect_msg = '您有將輸出重定向到 `num-records.out` 檔案嗎？')
    )
  )
)
Ex().success_msg("做得好！您的 shell 技能正在不斷擴展！")
```

---

## 我要如何處理單一引數？

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

除了 `$@` 以外，
shell 也允許你用 `$1`、`$2` 等來指涉特定的命令列參數。
你可以用這個方式撰寫比 shell 更直覺、可讀性更好的指令。
例如，
你可以建立一個名為 `column.sh` 的腳本，
當使用者把檔名當作第一個參數、欄位當作第二個參數傳入時，
從 CSV 檔中選出單一欄位：

```{shell}
cut -d , -f $2 $1
```

接著使用以下方式執行：

```{shell}
bash column.sh seasonal/autumn.csv 1
```

請注意，這個腳本使用了相反順序來取用兩個參數。

<hr>

`get-field.sh` 這個腳本的設計是接收一個檔名、
要選取的列（行）號、
要選取的欄號，
並從 CSV 檔中只印出該欄位。
例如：

```
bash get-field.sh seasonal/summer.csv 4 2
```

應該要從 `seasonal/summer.csv` 的第 4 行選出第 2 個欄位。
以下哪一個指令應該放進 `get-field.sh` 才能達成這件事？

`@hint`
請記住，命令列參數是由左到右編號的。

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- 不正確：那會把檔名當成 `head` 要選取的行數來用。
- 正確！
- 不正確：那會把欄號當成行號、行號當成欄號。
- 不正確：那會把欄位編號當成檔名、檔名當成欄位編號。

---

## 一支 shell 腳本可以做很多事嗎？

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

到目前為止，我們的 shell 腳本只包含單一指令或管線，但一個腳本其實可以包含多行指令。舉例來說，你可以建立一個腳本，告訴你資料檔裡最短與最長各有多少筆紀錄，也就是資料集長度的範圍。

請注意，在 Nano 中，「複製貼上」的做法是移動到你想複製的那一行，按下 `CTRL` + `K` 來剪下該行，然後按兩次 `CTRL` + `U` 以貼上兩份副本。

_提醒你，若要在 Nano 中儲存已編寫的內容，請按 `Ctrl` + `O` 將檔案寫出，接著按 Enter 確認檔名，最後按 `Ctrl` + `X` 離開編輯器。_

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
使用 Nano 編輯 `range.sh` 腳本，
將兩個 `____` 佔位符
分別替換成 `$@` 與 `-v`，
讓它列出命令列所提供所有檔案的名稱與行數，
且「不要」顯示所有檔案行數的總計。
（不要嘗試從檔案中扣除欄位標頭那一行。）

`@hint`
使用 `wc -l $@` 來計算命令列上所有檔案的行數。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="您是否已正確替換空白，以便 `range.sh` 中的命令讀作 `wc -l $@ | grep -v total`？請再次使用 `nano range.sh` 進行所需的更改。"
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
再用 Nano，在 `range.sh` 的管線中依序加入 `sort -n` 與 `head -n 1`，
以顯示提供給它的最短檔案的名稱與行數。

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="您是否已經將 `sort -n` 和 `head -n 1` 與管道添加到 `range.sh` 文件中？請再次使用 `nano range.sh` 進行所需的更改。"
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
同樣使用 Nano，在 `range.sh` 中新增第二行，
同時印出目錄中「最長」檔案與最短檔案的名稱與筆數。
這一行應該與你已寫好的那一行相同，
但將 `sort -n` 改成 `sort -n -r`。

`@hint`
複製第一行並修改排序順序。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="保留 `range.sh` 檔案中的第一行：`wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="您是否在 `range.sh` 中複製了第一行並做了一些小改動？`sort -n -r` 代替 `sort -n`！"
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
對 `seasonal` 目錄中的檔案執行此腳本，
使用 `seasonal/*.csv` 來比對所有檔案，
並使用 `>` 重新導向輸出，
將結果寫到你家目錄中的 `range.out` 檔案。

`@hint`
使用 `bash range.sh` 執行你的腳本，`seasonal/*.csv` 指定檔案，並用 `> range.out` 重新導向輸出。

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="您是否已正確地將 `bash range.sh seasonal/*.csv` 的結果重定向到 `range.out`，並使用 `>`？"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = '您是否呼叫了 `bash`？'),
has_code("bash\s+range.sh", incorrect_msg = '您是否執行了 `range.sh` 檔案？'),
has_code("seasonal/\*", incorrect_msg = '您是否使用 `seasonal/*` 指定要處理的檔案？'),
has_code(">\s+range.out", incorrect_msg = '您是否將結果重定向到 `range.out` 檔案？')
)
)

Ex().success_msg("進展順利。前往下一個練習以學習如何撰寫迴圈！")
```

---

## 我要如何在 shell 指令稿裡寫迴圈？

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shell 指令稿也能包含迴圈。你可以用分號把指令寫在同一行，或是為了提高可讀性，把它們分成多行而不加分號：

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

（不一定要縮排迴圈裡的指令，不過縮排能讓內容更清楚。）

這個指令稿的第一行是**註解**，用來告訴讀者這個指令稿會做什麼。註解以 `#` 字元開頭，直到該行結尾。你未來的自己會很感謝你在每支指令稿中加上像這樣的簡短說明。

_提醒一下：在 Nano 裡儲存你寫的內容時，請按 `Ctrl` + `O` 將檔案寫出，然後按 Enter 確認檔名，最後按 `Ctrl` + `X` 離開編輯器。_

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
在 `date-range.sh` 指令稿中填入預留位置，將 `$filename`（兩次）、`head` 和 `tail` 補上，讓它能印出一個或多個檔案中的第一個與最後一個日期。

`@hint`
記得使用 `$filename` 來取得迴圈變數目前的值。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="在 `date-range.sh` 中，您是否已將迴圈中的 %s 行更改為 `%s`？使用 `nano date-range.sh` 進行更改。"
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
使用 `seasonal/*.csv` 來比對檔名，對四個季節性資料檔全部執行 `date-range.sh`。

`@hint`
萬用字元的表達式應該以目錄名稱開頭。

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
      has_code("bash", incorrect_msg = '您是否呼叫了 `bash`？'),
      has_code("bash\s+date-range.sh", incorrect_msg = '您是否執行了 `date-range.sh` 檔案？'),
      has_code("seasonal/\*", incorrect_msg = '您是否使用 `seasonal/*` 指定要處理的檔案？')
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
使用 `seasonal/*.csv` 來比對檔名，對四個季節性資料檔全部執行 `date-range.sh`，並把它的輸出用管線傳給 `sort`，看看你的指令稿是否能像 Unix 內建指令一樣使用。

`@hint`
使用你先前用過的同一個萬用字元表達式。

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
      has_code("bash", incorrect_msg = '您是否呼叫了 `bash`？'),
      has_code("bash\s+date-range.sh", incorrect_msg = '您是否執行了 `date-range.sh` 檔案？'),
      has_code("seasonal/\*", incorrect_msg = '您是否使用 `seasonal/*` 指定要處理的檔案？'),
      has_code("|", incorrect_msg = '您是否將腳本輸出透過管道傳遞給 `sort`？'),
      has_code("sort", incorrect_msg = '您是否呼叫了 `sort`？')
    )
  )
)
Ex().success_msg("太神奇了！注意我們所學的一切是多麼具有組合性。")
```

---

## 如果我沒有提供檔名會發生什麼事？

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

在 shell 指令稿（以及互動式指令）中，一個常見的錯誤是把檔名放錯位置。
如果你輸入：

```{shell}
tail -n 3
```

由於沒有把任何檔名給 `tail`，
它會等待從你的鍵盤讀取輸入。
這表示如果你輸入：

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

`tail` 會直接列印 `somefile.txt` 的最後 3 行，
但 `head` 會一直等待鍵盤輸入，
因為它沒有拿到檔名，而且管線中它前面也沒有任何輸入。

<hr>

假設你不小心真的打了：

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

接下來你應該怎麼做？

`@possible_answers`
- 等 10 秒讓 `head` 自動逾時。
- 輸入 `somefile.txt` 並按下 Enter，提供一些輸入給 `head`。
- 使用 `Ctrl` + `C` 停止正在執行的 `head` 程式。

`@hint`
如果 `head` 沒有給定檔名，且前面也沒有任何指令的輸出接到它，`head` 會怎麼做？

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = '不，命令不會超時。'
a2 = '不，那會給 `head` 文本 `somefile.txt` 來處理，但隨後它會掛起等待更多的輸入。'
a3 = "是的！您應該使用 `Ctrl` + `C` 來停止正在運行的程序。這結束了本入門課程！如果您有興趣學習更多命令行工具，我們強烈推薦參加我們的免費 Git 入門課程！"
Ex().has_chosen(3, [a1, a2, a3])
```

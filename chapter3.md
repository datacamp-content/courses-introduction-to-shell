---
title: 整合工具
description: >-
  Unix shell
  的真正威力不在於單一指令，而在於它們能輕鬆組合來完成新任務。本章將示範如何運用這種威力選取你要的資料，並介紹用來排序數值與移除重複項的指令。
lessons:
  - nb_of_exercises: 12
    title: 如何將指令的輸出存到檔案中？
---

## 要如何把指令的輸出存到檔案？

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

到目前為止你看到的工具，都允許你指定輸入檔案。
多數情況下並沒有提供命名輸出檔案的選項，因為不需要。
相反地，
你可以用**重新導向（redirection）**把任何指令的輸出存到你想要的位置。
如果你執行這個指令：

```{shell}
head -n 5 seasonal/summer.csv
```

它會在畫面上印出夏季資料的前 5 行。
如果改成執行這個指令：

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

畫面上不會出現任何東西。
相反地，
`head` 的輸出會被放到一個名為 `top.csv` 的新檔案裡。
你可以用 `cat` 來查看該檔案的內容：

```{shell}
cat top.csv
```

大於號 `>` 會告訴 shell 要把 `head` 的輸出重新導向到檔案。
它不是 `head` 指令的一部分；
而是適用於每一個會產生輸出的 shell 指令。

`@instructions`
把 `tail` 和重新導向搭配使用，將 `seasonal/winter.csv` 的最後 5 行儲存到名為 `last.csv` 的檔案中。

`@hint`
使用 `tail -n 5` 來取得最後 5 行。

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "行 `%s` 應該在檔案 `last.csv` 中，但它不在。使用 `>` 將 `tail -n 5 seasonal/winter.csv` 的輸出重定向到 `last.csv`。"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` 有太多行。您是否使用了 `tail` 的 `-n 5` 標誌？'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("很好！讓我們再多練習一些！")
```

---

## 我要怎麼把某個指令的輸出當成另一個指令的輸入？

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

假設你想從檔案的中間取出幾行。
更具體一點，
你想從其中一個資料檔案裡擷取第 3–5 行。
你可以先用 `head` 取出前 5 行，
把結果重新導向到一個檔案，
然後再用 `tail` 選出最後 3 行：

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

快速檢查可以確認這確實是原始檔案的第 3–5 行，
因為它正是前 5 行裡的最後 3 行。

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
從 `seasonal/winter.csv` 選出最後兩行，
並將它們儲存到名為 `bottom.csv` 的檔案。

`@hint`
使用 `tail` 選取行，並用 `>` 重新導向 `tail` 的輸出。

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
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` 有太多行。您是否使用了 `tail` 的 `-n 2` 標誌？'),
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
從 `bottom.csv` 選出第 1 行，
以取得原始檔案的倒數第 2 行。

`@hint`
使用 `head` 選出你要的那一行。

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="`bottom.csv` 檔案有問題。請確保您沒有更改它！"),
    has_expr_output(strict=True, incorrect_msg="您是否正確地在 `bottom.csv` 上使用了 `head`？請確保正確使用 `-n` 參數。")
)

Ex().success_msg("做得好。前往下一個練習以了解更好的方法來組合命令。")                             

```

---

## 有沒有更好的方式來組合指令？

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

使用重新導向來組合指令有兩個缺點：

1. 會留下許多中間檔案（像是 `top.csv`）。
2. 產生最終結果的指令分散在多行歷史記錄中。

Shell 提供了另一個一次解決這兩個問題的工具，稱為 **pipe**（管線）。
再一次，
先執行 `head`：

```{shell}
head -n 5 seasonal/summer.csv
```

這次不要把 `head` 的輸出寫到檔案，
而是加上一個直線符號，再接上沒有檔名的 `tail` 指令：

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

pipe 符號會告訴 shell：把左邊指令的輸出，
當作右邊指令的輸入。

`@instructions`
使用 `cut` 從以逗號分隔的檔案 `seasonal/summer.csv` 的第 2 欄選出所有牙齒名稱，然後將結果用 pipe 傳給 `grep`，並用反向比對來排除包含「Tooth」這個字的標題列。＊`cut` 與 `grep` 的詳解分別在第 2 章的練習 8 與 11。＊

`@hint`
- 指令的第一部分格式為 `cut -d field_delimiter -f column_number filename`。
- 指令的第二部分格式為 `grep -v thing_to_match`。

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
    has_expr_output(incorrect_msg = '您是否已將 `cut -d , -f 2 seasonal/summer.csv` 的結果通過 `|` 管道傳遞給 `grep -v Tooth`？'),
    check_not(has_output("Tooth"), incorrect_msg = '您是否使用 `grep` 排除了 `"Tooth"` 標題行？')
)
Ex().success_msg("完美的管道操作！這可能是您第一次使用 `|`，但絕對不會是最後一次！")
```

---

## 我要如何把多個指令串在一起？

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

你可以把任意數量的指令串接在一起。
例如，以下這個指令：

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

會：

1. 從 spring 的資料中選出第 1 欄；
2. 移除包含「Date」一詞的標頭列；以及
3. 選出實際資料的前 10 列。

`@instructions`
在上一個練習中，你使用下列指令，從 `seasonal/summer.csv` 的第 2 欄選出所有牙名：

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

把這個管線再接上一個 `head` 指令，只選出最前面的那一個牙名。

`@hint`
複製並貼上說明中的程式碼，接著加上一個管線符號，再呼叫帶有 `-n` 旗標的 `head`。

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
    has_output('^\s*canine\s*$', incorrect_msg = "您是否使用 `|` 將管道延伸至 `head` 命令？請確保正確設置 `-n` 參數。"),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "您是否使用 `|` 將管道延伸至 `head` 命令？")
)
Ex().success_msg("愉快的鏈接！通過將多個命令鏈接在一起，您可以構建強大的數據操作管道。")
```

---

## 我要如何計算檔案中的筆數？

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

`wc` 指令（「word count」的縮寫）會印出檔案中的字**c**（characters）、字**w**（words）、以及行**l**（lines）數量。
你可以分別使用 `-c`、`-w`、或 `-l`，只印出其中一種。

`@instructions`
計算在 `seasonal/spring.csv` 中，有多少筆日期屬於 2017 年 7 月（`2017-07`）。
- 為此，先用 `grep` 搭配部分日期來篩選出該些行，然後以管線將結果傳給 `wc`，並加上適當的旗標來計算行數。

`@hint`
- 先用 `head seasonal/spring.csv` 檢視一下日期的格式。
- 指令的第一部分格式是 `grep 要比對的字串 檔名`。
- 管線符號 `|` 之後，使用帶有 `-l` 旗標的 `wc`。

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
      has_code("grep", incorrect_msg = "您有呼叫 `grep` 嗎？"),
      has_code("2017-07", incorrect_msg = "您有搜尋 `2017-07` 嗎？"),
      has_code("seasonal/spring.csv", incorrect_msg = "您有搜尋 `seasonal/spring.csv` 檔案嗎？"),
      has_code("|", incorrect_msg = "您有使用 `|` 管道傳輸到 `wc` 嗎？"),      
      has_code("wc", incorrect_msg = "您有呼叫 `wc` 嗎？"),
      has_code("-l", incorrect_msg = "您有使用 `-l` 計算行數嗎？")
    )
  )
)
Ex().success_msg("仔細計算！確定您擁有多少數據是任何數據分析的第一步。")
```

---

## 我要怎麼一次指定很多檔案？

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

大多數 shell 指令在你提供多個檔名時，都能同時處理多個檔案。
例如，
你可以一次從所有季節性的資料檔取出第 1 欄，如下所示：

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

但反覆輸入一長串檔名並不是好主意：
這會浪費時間，
而且早晚你會漏掉某個檔案，或是重複某個檔名。
為了讓事情更輕鬆，
shell 允許你使用**萬用字元（wildcards）**，用一個運算式就指定一串檔案。
最常見的萬用字元是 `*`，
意思是「比對 0 個或多個字元」。
利用它，
我們可以把上面的 `cut` 指令縮短成：

```{shell}
cut -d , -f 1 seasonal/*
```

或：

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
請寫一行使用 `head` 的指令，從 `seasonal/spring.csv` 與 `seasonal/summer.csv` 各取出前 3 行，共 6 行資料，但不要讀取 autumn 或 winter 的資料檔。
請使用萬用字元，而不要把檔名完整拼出。

`@hint`
- 指令的形式是 `head -n number_of_lines filename_pattern`。
- 例如，你可以用 `a/b*` 來比對目錄 `a` 中以 `b` 開頭的檔案。

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
    has_expr_output(incorrect_msg = "您可以使用 `seasonal/s*` 選擇 `seasonal/spring.csv` 和 `seasonal/summer.csv`。請確保僅包含每個文件的前三行，並使用 `-n` 標誌！"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "不要包含 `seasonal/autumn.csv` 的輸出。您可以使用 `seasonal/s*` 選擇 `seasonal/spring.csv` 和 `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "不要包含 `seasonal/winter.csv` 的輸出。您可以使用 `seasonal/s*` 選擇 `seasonal/spring.csv` 和 `seasonal/summer.csv`")
)
Ex().success_msg("精彩的萬用字元工作！如果您的目錄包含數百或數千個文件，這一點變得更加重要。")
```

---

## 還能用哪些萬用字元？

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Shell 也有其他萬用字元，
只是比較少用：

- `?` 會比對單一字元，所以 `201?.txt` 會比對到 `2017.txt` 或 `2018.txt`，但不會比對到 `2017-01.txt`。
- `[...]` 會比對中括號內的任一個字元，所以 `201[78].txt` 會比對到 `2017.txt` 或 `2018.txt`，但不會比對到 `2016.txt`。
- `{...}` 會比對大括號內以逗號分隔的任一個樣式，所以 `{*.txt, *.csv}` 會比對任何檔名以 `.txt` 或 `.csv` 結尾的檔案，但不會比對到檔名以 `.pdf` 結尾的檔案。

<hr/>

以下哪一個表示式會比對到 `singh.pdf` 和 `johel.txt`，但「不會」比對到 `sandhu.pdf` 或 `sandhu.txt`？

`@hint`
依序將每個表示式拿去比對每個檔名。

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- 不對：`.pdf` 和 `.txt` 不是檔名。
- 不對：這會比對到 `sandhu.pdf`。
- 不對：中括號內的表示式只會比對單一字元，不是整個單字。
- 正確！

---

## 我要如何排序文字行？

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

顧名思義，
`sort` 會把資料排好順序。
預設是依字母遞增排序，
但可以用 `-n` 與 `-r` 兩個旗標來分別做數值排序與反轉輸出順序，
`-b` 會忽略前導空白，
而 `-f` 會將大小寫視為相同（也就是不區分大小寫）。
在管線中常見的做法是先用 `grep` 篩掉不要的紀錄，
再用 `sort` 將剩下的紀錄排好順序。

`@instructions`
還記得用 `cut` 搭配 `grep`，從 `seasonal/summer.csv` 的第 2 欄選出所有牙齒名稱的組合嗎？

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

以這個範例為起點，請將 `seasonal/winter.csv`（不是 `summer.csv`）中的牙齒名稱依字母遞減排序。為此，請在管線後面加上一個 `sort` 步驟。

`@hint`
複製並貼上說明中的指令，修改檔名，接上管線符號，然後使用帶有 `-r` 旗標的 `sort`。

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
      has_code("cut", incorrect_msg = "您有呼叫 `cut` 嗎？"),
      has_code("-d", incorrect_msg = "您有使用 `-d` 指定欄位分隔符號嗎？"),
      has_code("seasonal/winter.csv", incorrect_msg = "您有從 `seasonal/winter.csv` 檔案中取得資料嗎？"),
      has_code("|", incorrect_msg = "您有使用 `|` 從 `cut` 管道到 `grep` 再到 `sort` 嗎？"),      
      has_code("grep", incorrect_msg = "您有呼叫 `grep` 嗎？"),
      has_code("-v", incorrect_msg = "您有使用 `-v` 反轉匹配嗎？"),
      has_code("Tooth", incorrect_msg = "您有搜尋 `Tooth` 嗎？"),
      has_code("sort", incorrect_msg = "您有呼叫 `sort` 嗎？"),
      has_code("-r", incorrect_msg = "您有使用 `-r` 反轉排序順序嗎？")
    )
  )
)
Ex().success_msg("已排序！`sort` 有很多用途。例如，將 `sort -n` 管道到 `head` 可以顯示最大的值。")
```

---

## 我要怎麼移除重複的列？

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

另一個經常和 `sort` 一起用的指令是 `uniq`，
它的工作是移除重複的列。
更精確地說，
它會移除「相鄰」的重複列。
如果檔案內容是：

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

那麼 `uniq` 會產生：

```
2017-07-03
2017-08-03
```

但如果內容是：

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

那 `uniq` 會印出全部四行。
原因是 `uniq` 是為了處理非常大的檔案而設計的。
若要從檔案中移除不相鄰的重複列，
它就必須把整個檔案放在記憶體中
（或至少，
把到目前為止看過的所有不重複列都放在記憶體中）。
只移除相鄰的重複時，
它只需要在記憶體中保留最近一次出現的不重複列即可。

`@instructions`
撰寫一個管線以：

- 取得 `seasonal/winter.csv` 的第 2 欄，
- 從輸出中移除「Tooth」這個字，讓只剩牙齒名稱，
- 將輸出排序，讓同一個牙齒名稱的所有出現相鄰；以及
- 每個牙齒名稱只顯示一次，並附上出現次數。

你的管線開頭與上一個練習相同：

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

接著加上 `sort` 指令，並使用 `uniq -c` 來顯示不重複的列與其出現次數，而不是分別使用 `uniq` 和 `wc`。

`@hint`
複製並貼上說明中的指令，先用管線接到不帶旗標的 `sort`，再接到帶有 `-c` 旗標的 `uniq`。

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
                     incorrect_msg="您應該從此命令開始：`cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`。現在擴展它！"),
            has_code('\|\s+sort', incorrect_msg="您是否已經用 `| sort` 擴展了命令？"),
            has_code('\|\s+uniq', incorrect_msg="您是否已經用 `| uniq` 擴展了命令？"),
            has_code('-c', incorrect_msg="您是否已經用 `-c` 包含了計數？")
        )
    )
)
Ex().success_msg("太好了！經過這麼多管道的工作，我們可以將結果存儲起來，不是嗎？")
```

---

## 我要如何儲存管線的輸出？

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Shell 允許我們重新導向一串以管線串接的指令輸出：

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

不過，`>` 必須出現在管線的最後面：
如果我們嘗試把它放在中間，像這樣：

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

那麼 `cut` 的所有輸出都會寫進 `teeth-only.txt`，
因此就沒有東西留給 `grep`，
而它會一直等著輸入而卡住。

<hr>

如果我們把重新導向放在管線最前面，像這樣，會發生什麼事：

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [指令的輸出會如常被重新導向到檔案。]
- Shell 會回報這是錯誤。
- Shell 會一直等待輸入。

`@hint`
在 shell 裡親自試試看。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['正確！', '不；實際上，shell 可以執行此操作。', '不；實際上，shell 可以執行此操作。'])
```

---

## 要如何停止正在執行的程式？

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

到目前為止，你執行的指令與腳本大多很快就完成，
但有些工作可能需要數分鐘、數小時，甚至數天。
你也可能不小心把重新導向放在管線的中間，
導致指令卡住不動。
如果你決定不要讓某個程式繼續執行，
可以按下 `Ctrl` + `C` 將它終止。
在 Unix 文件中常寫成 `^C`；
注意這裡的 c 可以是小寫。

`@instructions`
執行下列指令：

```{shell}
head
```

不要帶任何引數（這樣它會一直等待永遠不會到來的輸入），
然後按下 `Ctrl` + `C` 將它停止。

`@hint`
只要輸入 head，按下 Enter，然後用 `Ctrl` + `C` 結束執行中的程式。

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

## 總結

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

做個總結，
你將建立一個管線，找出季節性資料檔案中，哪一個檔案的紀錄數最少，以及它有多少筆紀錄。

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
使用 `wc` 與合適的參數，列出所有季節性資料檔案各自的行數。
（檔名請用萬用字元，不要一個一個手動輸入。）

`@hint`
使用 `-l` 只列出行數，並用 `*` 比對檔名。

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
      has_code("wc", incorrect_msg = "您是否呼叫了 `wc`？"),
      has_code("-l", incorrect_msg = "您是否使用 `-l` 計算行數？"),
      has_code("seasonal/\*", incorrect_msg = "您是否從所有 `seasonal/*` 檔案中獲取資料？")
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
在前一個指令後面加上一個經由管線串接的指令，移除包含「total」這個字的那一行。

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
      has_code("wc", incorrect_msg = "您是否呼叫了 `wc`？"),
      has_code("-l", incorrect_msg = "您是否使用 `-l` 計算行數？"),
      has_code("seasonal/\*", incorrect_msg = "您是否從所有 `seasonal/*` 檔案中獲取資料？"),
      has_code("|", incorrect_msg = "您是否使用 `|` 將 `wc` 的輸出導入 `grep`？"),      
      has_code("grep", incorrect_msg = "您是否呼叫了 `grep`？"),
      has_code("-v", incorrect_msg = "您是否使用 `-v` 反轉匹配？"),
      has_code("total", incorrect_msg = "您是否搜尋了 `total`？")
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
在管線中再加入兩個階段，使用 `sort -n` 和 `head -n 1` 找出行數最少的檔案。

`@hint`
- 使用 `sort` 的 `-n` 旗標以數值方式排序。
- 使用 `head` 的 `-n` 旗標只保留 1 行。

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
      has_code("wc", incorrect_msg = "您有呼叫 `wc` 嗎？"),
      has_code("-l", incorrect_msg = "您有使用 `-l` 計算行數嗎？"),
      has_code("seasonal/\*", incorrect_msg = "您有從所有 `seasonal/*` 檔案中獲取資料嗎？"),
      has_code("|", incorrect_msg = "您有使用 `|` 從 `wc` 管道到 `grep` 再到 `sort` 然後到 `head` 嗎？"),      
      has_code("grep", incorrect_msg = "您有呼叫 `grep` 嗎？"),
      has_code("-v", incorrect_msg = "您有使用 `-v` 反轉匹配嗎？"),
      has_code("total", incorrect_msg = "您有搜尋 `total` 嗎？"),
      has_code("sort", incorrect_msg = "您有呼叫 `sort` 嗎？"),
      has_code("-n", incorrect_msg = "您有指定要保留的行數 `-n` 嗎？"),
      has_code("1", incorrect_msg = "您有指定要保留 1 行 `-n 1` 嗎？")
    )
  )
)
Ex().success_msg("太棒了！結果顯示 `autumn.csv` 是行數最少的檔案。趕快進入第 4 章學習更多關於批次處理的內容吧！")
```

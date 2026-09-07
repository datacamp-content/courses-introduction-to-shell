---
title: 操作資料
description: 前一章的指令讓你能在檔案系統中移動東西。本章將示範如何處理那些檔案中的資料。我們要用的工具相當簡單，但足以作為穩固的基礎元件。
lessons:
  - nb_of_exercises: 12
    title: 如何檢視檔案內容？
---

## 我要怎麼查看檔案內容？

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

在你重新命名或刪除檔案之前，
你可能會想先看看它們的內容。
最簡單的方式是使用 `cat`，
它會把檔案的內容直接印在螢幕上。
（它的名字是「concatenate」的縮寫，意思是「把東西串接在一起」，
因為它會依你提供的檔名逐一列印所有檔案的內容。）

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
將 `course.txt` 的內容印到螢幕上。

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
    has_expr_output(incorrect_msg="您的命令未產生正確的輸出。您是否使用了 `cat` 後接檔案名稱 `course.txt`？")
)
Ex().success_msg("很好！讓我們看看查看檔案內容的其他方法。")
```

---

## 要怎麼分頁逐步查看檔案內容？

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

你可以用 `cat` 列印大型檔案，然後往回捲動輸出；
但通常更方便的是把輸出「分頁」顯示。
最早用的指令叫做 `more`，
後來被功能更強的 `less` 取代。
（在 Unix 世界，這種命名就算是一種幽默了。）
當你用 `less` 查看檔案時，
系統一次只會顯示一頁；
你可以按空白鍵往下翻頁，或輸入 `q` 離開。

如果你把多個檔案名稱給 `less`，
可以輸入 `:n`（冒號加小寫 n）切換到下一個檔案，
用 `:p` 回到上一個，
或用 `:q` 結束。

注意：如果你查看使用 `less` 的練習解答，
會在最後看到一個把分頁功能關閉的額外指令，
這樣我們才能有效率地測試你的解答。

`@instructions`
使用 `less seasonal/spring.csv seasonal/summer.csv` 依序查看這兩個檔案。
按空白鍵往下翻頁，用 `:n` 前往第二個檔案，然後用 `:q` 離開。

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
                 incorrect_msg='使用 `less` 和檔案名稱。請記得 `:n` 會將您移至下一個檔案。'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## 我要怎麼查看檔案開頭？

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

多數資料科學家拿到新的資料集時，第一件事就是先了解它有哪些欄位，以及各欄位出現哪些值。
如果資料集是從資料庫或試算表匯出，通常會儲存成 **逗號分隔值**（CSV）。
想快速了解它的內容，可以先看前幾列資料。

在 shell 中，我們可以用 `head` 指令來做到。
顧名思義，它會印出檔案的前幾行（這裡的「幾行」指的是 10 行），所以以下指令：

```{shell}
head seasonal/summer.csv
```

會顯示：

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

如果檔案沒有 10 行，`head` 會怎麼做？
（要找出答案，請用它來查看 `people/agarwal.txt` 的開頭。）

`@possible_answers`
- 會印出錯誤訊息，因為檔案太短。
- 顯示實際存在的行數。
- 顯示足夠的空白行，讓總數補到 10 行。

`@hint`
它最有用的功能是什麼？

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["不正確：這不是它能做的最有用的事情。",
                    "正確！",
                    "不正確：這將無法與以一堆空白行結尾的文件區分開來。"])
```

---

## 怎麼少打一點字？

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Shell 的強大工具之一是 **Tab 自動完成**。
當你開始輸入檔名，然後按下 Tab 鍵，
shell 會盡力自動完成路徑。
例如，
如果你輸入 `sea` 並按下 Tab，
它會補上目錄名稱 `seasonal/`（包含結尾的斜線）。
接著如果你再輸入 `a` 並按 Tab，
就會把路徑補完整為 `seasonal/autumn.csv`。

如果路徑有多種可能，
像是 `seasonal/s`，
第二次按 Tab 會顯示所有可能的選項。
再多輸入一兩個字元讓路徑更明確，
然後再按 Tab，
就會把剩下的名稱自動補齊。

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
在不完整輸入檔名的情況下，執行 `head seasonal/autumn.csv`。

`@hint`
輸入你需要的那部分路徑後按 Tab，重複此步驟即可。

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="檢查器無法在您的命令中找到正確的輸出。您確定您在 `seasonal/autumn.csv` 上調用了 `head` 嗎？")
)

```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
在不完整輸入檔名的情況下，執行 `head seasonal/spring.csv`。

`@hint`
輸入你需要的那部分路徑後按 Tab，重複此步驟即可。

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="檢查器無法在您的命令中找到正確的輸出。您確定對 `seasonal/spring.csv` 使用了 `head` 嗎？")
)
Ex().success_msg("做得好！一旦您習慣使用制表符補全，它將為您節省大量時間！")
```

---

## 我要如何控制指令的行為？

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

你不一定總是想看檔案的前 10 行，
所以殼層允許你透過提供 **命令列旗標**（簡稱「旗標」）來改變 `head` 的行為。
如果你執行以下指令：

```{shell}
head -n 3 seasonal/summer.csv
```

`head` 只會顯示該檔案的前三行。
如果你執行 `head -n 100`，
它會顯示前 100 行（假設檔案行數足夠），
以此類推。

旗標的名稱通常會暗示其用途
（例如，`-n` 代表「行數 number of lines」）。
指令旗標不一定是 `-` 後面接單一字母，
但這是相當普遍的慣例。

注意：較好的風格是把所有旗標放在檔名「之前」，
因此在本課程中，
我們只接受遵守此規則的答案。

`@instructions`
在 `seasonal` 目錄中，顯示 `winter.csv` 的前 5 行。

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
        has_expr_output(incorrect_msg="您確定您正在對 `seasonal/winter.csv` 文件調用 `head` 嗎？"),
        has_expr_output(strict=True, incorrect_msg="您確定您使用了標誌 `-n 5` 嗎？")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "您確定您使用了標誌 `-n 5` 嗎？")
)
Ex().success_msg("很好！使用此技術，您可以避免在查看較大的文本文件時讓您的 shell 崩潰。")
```

---

## 我要如何列出某個目錄底下的所有內容？

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

如果你想看到一個目錄底下的所有內容，
不論巢狀有多深，
你可以在 `ls` 加上 `-R` 旗標
（代表「遞迴」）。
如果你在家目錄使用 `ls -R`，
你會看到像這樣的輸出：

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

這會先顯示目前層級中的每個檔案與目錄，
接著顯示每個子目錄中的所有內容，
以此類推。

`@instructions`
為了幫助你辨識各種類型，
`ls` 還有另一個旗標 `-F`，會在每個目錄名稱後加上 `/`，
並在每個可執行的程式名稱後加上 `*`。
請用兩個旗標 `-R` 和 `-F`，再加上你家目錄的絕對路徑來執行 `ls`，
以查看其中包含的所有內容。
（旗標的順序無所謂，但目錄名稱一定要放在最後。）

`@hint`
你的家目錄可以用 `~`、`.`，或其絕對路徑來表示。

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
  has_expr_output(incorrect_msg='請使用 `ls -R -F` 或 `ls -F -R` 並指定路徑 `/home/repl`。'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='請使用 `ls -R -F` 或 `ls -F -R` 並指定路徑 `/home/repl`。')
)
Ex().success_msg('這是一個相當不錯的概覽，不是嗎？')
```

---

## 我要如何查詢指令的說明？

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

為了瞭解各個指令的用途，早期大家會使用 `man` 指令（「manual」的縮寫）。例如，執行 `man head` 會顯示以下資訊：

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

`man` 會自動呼叫 `less`，所以你可能需要按空白鍵往下翻頁，並用 `:q` 離開。

`NAME` 底下那一行會用一句話簡短說明指令的功能，而 `SYNOPSIS` 的摘要則列出所有可用旗標。方括號 `[...]` 表示選用項目，選擇其一的替代關係用 `|` 分隔，可以重複的項目以 `...` 表示。因此，`head` 的手冊頁面告訴你：你可以用 `-n` 指定行數，或用 `-c` 指定位元組數，二擇一，且可以提供任意數量的檔名。

Unix 手冊的缺點是你必須先知道自己在找什麼。如果不知道，你可以搜尋 Stack Overflow（https://stackoverflow.com/）、在 DataCamp 的 Slack 頻道發問，或查看你已熟悉指令的 `SEE ALSO` 區段。

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
閱讀 `tail` 指令的手冊頁，找出在 `-n` 旗標所用的數字前加上 `+` 號會有什麼效果。（記得按空白鍵往下翻，或輸入 `q` 離開。）

`@hint`
記住：`man` 是「manual」的縮寫。

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='使用 `man` 和命令名稱。')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
使用 `tail` 搭配 `-n +7` 旗標，顯示 `seasonal/spring.csv` 中除前 6 行之外的所有內容。

`@hint`
在要顯示的行數前面加上加號「+」。

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="您是否在 `seasonal/spring.csv` 上使用了 `tail`？"),
    has_expr_output(strict=True, incorrect_msg="您是否確定使用了標誌 `-n +7`？")
)
```

---

## 要怎麼從檔案中選取欄？

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` 和 `tail` 可以從純文字檔中選取列。
如果你想選取欄，
可以使用指令 `cut`。
它有好幾個選項（用 `man cut` 了解更多），
但最常見的用法像這樣：

```{shell}
cut -f 2-5,8 -d , values.csv
```

意思是：
「選取第 2 到第 5 欄，以及第 8 欄，
以逗號作為分隔符」。
`cut` 使用 `-f`（代表「fields」）來指定欄，
並用 `-d`（代表「delimiter」）來指定分隔符。
你需要指定分隔符，因為有些檔案可能用空白、定位字元（tab）或冒號來分隔欄。

<hr>

要用哪個指令從檔案 `spring.csv` 中選取第一欄（包含日期）？

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- 上述任一個皆可。
- 以上皆非，因為 `-f` 一定要在 `-d` 之前。

`@hint`
旗標的順序沒有關係。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['是的，但這還不是全部', '是的，但這還不是全部', '正確！在標誌後添加空格是良好的風格，但不是必須的。', '不，標誌的順序並不重要'])
```

---

## `cut` 做不到什麼？

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` 是個相當單純的指令。
特別是，
它不會理解帶引號的字串。
例如，若你的檔案是：

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

那麼：

```{shell}
cut -f 2 -d , everyone.csv
```

會產生：

```
Age
Ranjit"
Rupinder"
```

而不是每個人的年齡，
因為它會把姓與名之間的逗號誤認為欄位分隔符。

<hr>

對於這一行執行 `cut -d : -f 2-4` 的輸出是什麼：

```
first:second:third:
```

（注意最後面的冒號。）

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- 以上皆非，因為沒有四個欄位。

`@hint`
注意最後面的冒號。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['不，還有更多。', '不，還有更多。', '正確！結尾的冒號創建了一個空的第四個字段。', '不，`cut` 已經盡力了。'])
```

---

## 我要如何重複執行指令？

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

使用 shell 的最大優勢之一，是能讓你輕鬆把事情再做一次。
當你執行過一些指令後，
可以按方向鍵上鍵來回顧先前輸入過的指令。
你也可以用左右方向鍵和刪除鍵來編輯它們。
按下 Enter 之後，就會執行你修改過的指令。

更棒的是，`history` 會列出你最近執行過的指令。
每個指令前都有一個序號，方便你重新執行特定指令：
只要輸入 `!55`，就能重新執行歷史紀錄中的第 55 個指令（如果你有那麼多的話）。
你也可以輸入驚嘆號加上指令名稱來重跑該指令，
例如 `!head` 或 `!cut`，
這會重新執行最近一次使用過的該指令。

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
在你的家目錄中執行 `head summer.csv`（應該會失敗）。

`@hint`
如果沒有符合的檔名，Tab 自動補全不會生效。

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="使用 `head` 和檔案名稱 `summer.csv`。即使失敗也不用擔心。")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
切換目錄到 `seasonal`。

`@hint`
記住，`cd` 是「change directory（切換目錄）」的縮寫。

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="如果您的當前工作目錄（使用 `pwd` 查詢）是 `/home/repl`，您可以使用 `cd seasonal` 移動到 `seasonal` 資料夾。")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
用 `!head` 重新執行 `head` 指令。

`@hint`
不要在 `!` 和後面的內容之間輸入任何空白。

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
                        incorrect_msg='使用 `!head` 來重複 `head` 指令。'),
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
使用 `history` 檢視你剛才做了什麼。

`@hint`
請注意，`history` 會把最新的指令顯示在最後，這樣在它執行結束時會留在你的螢幕上。

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='使用 `history` 不帶任何標誌來獲取先前命令的列表。')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
再用驚嘆號加上指令編號的方式，重新執行 `head`。

`@hint`
請「不要」在 `!` 和後面的內容之間輸入任何空白。

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
                        incorrect_msg='您是否使用 `!<a_number>` 來重新執行歷史記錄中的最後一個 `head`？'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("做得好！繼續下一個！")
```

---

## 我要如何選出包含特定值的行？

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` 和 `tail` 會選出列，
`cut` 會選出欄，
而 `grep` 會依照內容選出行。
最簡單的用法是：
`grep` 接上一段文字以及一個或多個檔名，
然後列印那些檔案中所有包含該文字的行。
例如，
`grep bicuspid seasonal/winter.csv`
會印出 `winter.csv` 中包含「bicuspid」的行。

`grep` 也能搜尋樣式；
我們會在下一門課再深入探討。
現在更重要的是熟悉 `grep` 幾個常見的旗標：

- `-c`：列印符合的行數，而不是行本身
- `-h`：在搜尋多個檔案時，不要列印檔名
- `-i`：忽略大小寫（例如將「Regression」與「regression」視為相同）
- `-l`：只列印包含符合結果的檔案名稱，不顯示內容
- `-n`：顯示符合行的行號
- `-v`：反轉比對，也就是只顯示「不」符合的行

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
在家目錄下以單一指令，印出 `seasonal/autumn.csv` 中所有包含 `molar` 這個字的行內容。不要使用任何旗標。

`@hint`
使用 `grep`，在後面接上要找的字以及要搜尋的檔案名稱。

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
      has_code("grep", incorrect_msg = "您是否呼叫了 `grep`？"),
      has_code("molar", incorrect_msg = "您是否搜尋了 `molar`？"),
      has_code("seasonal/autumn.csv", incorrect_msg = "您是否搜尋了 `seasonal/autumn.csv` 檔案？")
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
反轉比對，找出 `seasonal/spring.csv` 中所有「不」包含 `molar` 這個字的行，並顯示其行號。
記得，把所有旗標放在其他值（例如檔名或搜尋字詞「molar」）「之前」被視為良好風格。

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
      has_code("grep", incorrect_msg = "您是否呼叫了 `grep`？"),
      has_code("-v", incorrect_msg = "您是否使用 `-v` 反轉了匹配？"),
      has_code("-n", incorrect_msg = "您是否使用 `-n` 顯示了行號？"),
      has_code("molar", incorrect_msg = "您是否搜尋了 `molar`？"),
      has_code("seasonal/spring.csv", incorrect_msg = "您是否搜尋了 `seasonal/spring.csv` 檔案？")
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
計算 `autumn.csv` 與 `winter.csv` 合計有多少行包含 `incisor` 這個字。
（同樣地，請在家目錄下以單一指令完成。）

`@hint`
記得搭配 `-c` 與 `grep` 來計算行數。

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
      has_code("grep", incorrect_msg = "您是否呼叫了 `grep`？"),
      has_code("-c", incorrect_msg = "您是否使用 `-c` 來獲取計數？"),
      has_code("incisor", incorrect_msg = "您是否搜尋了 `incisor`？"),
      has_code("seasonal/autumn.csv", incorrect_msg = "您是否搜尋了 `seasonal/autumn.csv` 檔案？"),
      has_code("seasonal/winter.csv", incorrect_msg = "您是否搜尋了 `seasonal/winter.csv` 檔案？")
    )
  )
)

```

---

## 為什麼把資料一律當成純文字處理並不安全？

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

`cut` 的說明手冊頁面裡的 `SEE ALSO` 區段提到一個名為 `paste` 的指令，
它可以用來合併資料檔，而不是把它們切開。

<hr>

請先閱讀 `paste` 的手冊頁面，
然後執行 `paste`，以逗號作為分隔符，將秋季與冬季的資料檔合併成同一個表格。
從資料分析的角度來看，這份輸出有什麼問題？

`@possible_answers`
- 欄位標題被重複了。
- 最後幾列的欄位數量不正確。
- `winter.csv` 中有部分資料不見了。

`@hint`
如果你把 `paste` 的輸出再用 `cut`，並以逗號作為分隔符，
會得到正確的答案嗎？

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = '正確，但這不一定是錯誤。'
correct2 = '正確：將行與列連接只會在開始時創建一個空列，而不是兩個。'
err3 = '不，所有的冬季數據都在那裡。'
Ex().has_chosen(2, [err1, correct2, err3])
```

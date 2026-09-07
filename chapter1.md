---
title: 操作檔案與目錄
description: >-
  本章將簡介 Unix shell。你會了解為何它在近 50 年後仍被廣泛使用、它與你可能更熟悉的圖形化工具有何不同、如何在 shell
  中移動，以及如何建立、修改與刪除檔案與資料夾。
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: shell 與桌面介面有何不同？
---

## Shell 與桌面介面有何不同？

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

像 Windows、Linux 或 Mac OS 這類作業系統，是一種特殊的程式。
它會控制電腦的處理器、硬碟與網路連線，
但最重要的工作是執行其他程式。

由於人類不是數位的，
因此需要一個介面來與作業系統互動。
現在最常見的是圖形化檔案總管，
它把點按與雙擊轉換成開啟檔案與執行程式的指令。
在電腦還沒有圖形顯示之前，
人們會把指令輸入到一個稱為 **命令列 shell** 的程式中。
每次輸入指令時，
shell 會執行其他程式，
以人類可讀的形式印出它們的輸出，
接著顯示一個「提示字元」（prompt），表示已準備好接受下一個指令。
（它的名字來自於「電腦的外層殼」這個概念。）

一開始用打字下指令而不是用滑鼠點選與拖曳可能會顯得不順手，
但你很快就會發現，
當你把想要電腦做的事清楚說明出來之後，
你可以把舊指令組合成新功能，
並用幾個按鍵就自動化重複性的工作。

<hr>
大多數人使用的圖形化檔案總管與命令列 shell 之間是什麼關係？

`@hint`
記住，使用者只能透過某個程式來與作業系統互動。

`@possible_answers`
- 檔案總管讓你檢視與編輯檔案，而 shell 讓你執行程式。
- 檔案總管是建構在 shell 之上。
- shell 是作業系統的一部分，而檔案總管是獨立的。
- [它們都是向作業系統下達指令的介面。]

`@feedback`
- 兩者都能讓你檢視與編輯檔案，並執行程式。
- 圖形化檔案總管與 shell 都會呼叫相同的底層作業系統函式。
- shell 和檔案總管都是把使用者的指令（打字或點擊）轉換成對作業系統呼叫的程式。
- 正確！兩者都會接收使用者的指令（無論是輸入或點擊），再傳給作業系統。

---

## 我在哪裡？

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**檔案系統（filesystem）** 會管理檔案與目錄（或稱資料夾）。
每個項目都有一個從檔案系統的 **根目錄** 開始一路指向它的 **絕對路徑**：
`/home/repl` 代表在目錄 `home` 裡的目錄 `repl`，
而 `/home/repl/course.txt` 則是該目錄中的檔案 `course.txt`，
單獨的 `/` 就是根目錄。

想知道你目前在檔案系統的哪裡，
請執行 `pwd`
（是 "**p**rint **w**orking **d**irectory" 的縮寫）。
它會印出你 **目前的工作目錄** 的絕對路徑，
而 shell 預設會在這個位置執行指令並尋找檔案。

<hr>
執行 `pwd`。
你現在位於哪裡？

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix 系統通常會把所有使用者的家目錄放在 `/home` 底下。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "這不是正確的路徑。"
correct = "正確 - 您在 `/home/repl`。"

Ex().has_chosen(3, [err, err, correct])
```

---

## 我要如何辨識檔案與目錄？

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` 會告訴你目前所在的位置。
若要查看那裡有哪些東西，
輸入 `ls`（是「**l**i**s**ting」的縮寫）然後按下 Enter 鍵。
單獨使用時，
`ls` 會列出你目前目錄的內容
（也就是 `pwd` 顯示的那個目錄）。
如果你在後面加上一些檔案名稱，
`ls` 會列出那些檔案，
而如果你加上目錄名稱，
它會列出那些目錄的內容。
例如，
`ls /home/repl` 會顯示你起始目錄中的內容
（通常稱為你的「home 目錄」）。

<hr>
請使用 `ls` 搭配合適的引數，列出目錄 `/home/repl/seasonal` 裡的檔案
（這個目錄依季節區分，按日期整理牙科手術的資訊）。
以下哪一個檔案「不在」該目錄中？

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
如果你把路徑給 `ls`，它會顯示該路徑裡的內容。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "該檔案位於 `seasonal` 目錄中。"
correct = "正確 - 該檔案*不*在 `seasonal` 目錄中。"

Ex().has_chosen(2, [err, correct, err, err])
```

---

## 還能用哪些方式辨識檔案與目錄？

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

絕對路徑就像經緯度：不論你身在何處，值都一樣。相對地，**相對路徑**是從你目前所在位置開始指定位置；有點像說「往北 20 公里」。

例如：
- 若你在目錄 `/home/repl`，則**相對**路徑 `seasonal` 指向的目錄和**絕對**路徑 `/home/repl/seasonal` 相同。
- 若你在目錄 `/home/repl/seasonal`，則**相對**路徑 `winter.csv` 指向的檔案和**絕對**路徑 `/home/repl/seasonal/winter.csv` 相同。

Shell 會用路徑的第一個字元來判斷它是絕對還是相對：如果以 `/` 開頭，就是絕對路徑；如果「沒有」以 `/` 開頭，就是相對路徑。

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
你目前在 `/home/repl`。使用 `ls` 搭配**相對路徑**，只列出絕對路徑為 `/home/repl/course.txt` 的那個檔案。

`@hint`
你常可透過「用你目前位置的絕對路徑，去減掉你想要目標的絕對路徑」的方式，來構造位於你目前位置之下的檔案或目錄的相對路徑。

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "您沒有呼叫 `ls` 來生成文件列表。"), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "您的命令未生成正確的文件列表。請使用 `ls` 後接相對路徑 `/home/repl/course.txt`。")
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
你目前在 `/home/repl`。
使用 `ls` 搭配**相對**路徑，
只列出檔案 `/home/repl/seasonal/summer.csv`。

`@hint`
相對路徑「不會」以前導的 '/' 開頭。

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "您沒有呼叫 `ls` 來生成文件列表。"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "您的命令未生成正確的文件列表。請使用 `ls` 後接相對路徑 `/home/repl/seasonal/summer.csv`。")
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
你目前在 `/home/repl`。
使用 `ls` 搭配**相對**路徑，
列出目錄 `/home/repl/people` 的內容。

`@hint`
相對路徑不會以前導的 '/' 開頭。

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "您沒有呼叫 `ls` 來生成文件列表。"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "您的命令未生成正確的文件列表。請使用 `ls` 後接 `/home/repl/people` 的相對路徑。")
    )
)
Ex().success_msg("做得好。現在您已經了解如何列出文件和目錄，讓我們看看如何在文件系統中移動！")
```

---

## 我要怎麼切換到其他目錄？

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

就像你在檔案瀏覽器裡用滑鼠連按兩下資料夾來移動一樣，
你也可以用指令 `cd`（意為「change directory」，切換目錄）在檔案系統中移動。

如果你輸入 `cd seasonal`，然後再輸入 `pwd`，
shell 會告訴你目前所在位置是 `/home/repl/seasonal`。
接著如果只執行 `ls`，
它會顯示 `/home/repl/seasonal` 的內容，
因為你就在那個目錄裡。
如果你想回到家目錄 `/home/repl`，
可以用指令 `cd /home/repl`。

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
你目前在 `/home/repl`。
請用相對路徑切換到 `/home/repl/seasonal`。

`@hint`
記住，`cd` 代表「change directory（切換目錄）」，而且相對路徑不會以開頭的 '/' 起始。

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
key: e69c8eac15
xp: 35
```

`@instructions`
使用 `pwd` 確認你已在該目錄。

`@hint`
輸入指令後記得按下「enter」或「return」。

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
直接執行 `ls`（不帶路徑）來查看該目錄的內容。

`@hint`
在輸入完指令後記得按下「enter」或「return」。

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
      has_code('ls', incorrect_msg="您的命令未產生正確的輸出。您是否使用了不帶路徑的 `ls` 來顯示當前目錄的內容？")
    )
)

Ex().success_msg("很好！這是關於導航到子目錄。那麼向上移動呢？讓我們來看看！")
```

---

## 我要怎麼往上移動一層目錄？

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

資料夾的**父層**就是它上面那一層的資料夾。
例如，`/home` 是 `/home/repl` 的父層，
而 `/home/repl` 是 `/home/repl/seasonal` 的父層。
你隨時都可以把父層資料夾的絕對路徑提供給像 `cd` 和 `ls` 這樣的指令。
不過，更常見的做法，
是利用特殊路徑 `..`（兩個點，中間沒有空格），代表「我目前所在資料夾的上一層」。
如果你在 `/home/repl/seasonal`，
那麼 `cd ..` 會把你往上移到 `/home/repl`。
如果再用一次 `cd ..`，
就會到 `/home`。
再來一次 `cd ..` 會把你帶到*根目錄* `/`，
也就是檔案系統的最上層。
（記得在 `cd` 和 `..` 之間要有一個空白——它是一個指令加上一個路徑，而不是單一四個字母的指令。）

單獨的一個點 `.`，永遠代表「目前的資料夾」，
所以單獨輸入 `ls` 和 `ls .` 的效果一樣，
而 `cd .` 不會有任何影響
（因為它會把你移動到你已經所在的資料夾）。

最後一個特殊路徑是 `~`（波浪號），
代表「你的家目錄」，
例如 `/home/repl`。
不管你身在何處，
`ls ~` 會永遠列出你的家目錄內容，
而 `cd ~` 會永遠把你帶回家。

<hr>
如果你在 `/home/repl/seasonal`，
執行 `cd ~/../.` 會把你帶到哪裡？

`@hint`
一步一步地逐層追蹤路徑。

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (the root directory)

`@feedback`
- 不對，但單獨輸入 `~` 或 `..` 都能把你帶到那裡。
- 正確！這個路徑代表「家目錄」、「往上一層」、「這裡」。
- 不對，但單獨用 `.` 就能做到那件事。
- 不對，路徑最後一段是 `.`（表示「這裡」），而不是 `..`（表示「往上」）。

---

## 我要如何複製檔案？

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

你常常會需要複製檔案、
把它們移到其他目錄來整理、
或重新命名。
可以使用的指令之一是 `cp`，也就是「copy」的縮寫。
如果 `original.txt` 是已存在的檔案，
那麼：

```{shell}
cp original.txt duplicate.txt
```

會建立一份名為 `duplicate.txt` 的 `original.txt` 複本。
如果已經有名為 `duplicate.txt` 的檔案，
它會被覆寫。
如果 `cp` 的最後一個參數是已存在的目錄，
那麼像這樣的指令：

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

會把這些檔案「全部」複製到該目錄中。

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
在 `backup` 目錄中（它也在 `/home/repl`），建立一份 `seasonal/summer.csv` 的複本，
並將新檔案命名為 `summer.bck`。

`@hint`
把目標目錄名稱和要複製的檔案名稱組合起來，
為新檔案建立相對路徑。

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` 似乎不存在於 `backup` 目錄中。請提供兩個路徑給 `cp`：現有的檔案 (`seasonal/summer.csv`) 和目標檔案 (`backup/summer.bck`)。"),
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
把 `seasonal` 目錄裡的 `spring.csv` 與 `summer.csv` 複製到 `backup` 目錄，
且「不要」變更你目前的工作目錄（`/home/repl`）。

`@hint`
使用 `cp`，先列出你要複製的檔案名稱，
「然後」再放要複製到的目錄名稱。

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` 似乎沒有被複製到 `backup` 目錄中。請提供兩個檔案名稱和一個目錄名稱給 `cp`。"
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="請確保在 `{{dir}}` 目錄中複製檔案！使用 `cd {{dir}}` 來返回該目錄。"),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("做得好。除了複製之外，我們還應該能夠將檔案從一個目錄移動到另一個目錄。在下一個練習中了解它！")
```

---

## 我要怎麼移動檔案？

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

`cp` 會複製檔案，
`mv` 則會把檔案從一個目錄移到另一個目錄，
就像你在圖形化檔案瀏覽器中拖曳一樣。
它處理參數的方式和 `cp` 相同，
所以以下指令：

```{shell}
mv autumn.csv winter.csv ..
```

會把目前工作目錄中的 `autumn.csv` 和 `winter.csv` 兩個檔案
往上移動一層到它的父目錄
（因為 `..` 一律代表你目前位置的上一層目錄）。

`@instructions`
你現在位於 `/home/repl`，其中有 `seasonal` 和 `backup` 兩個子目錄。
請用一行指令，將 `seasonal` 裡的 `spring.csv` 和 `summer.csv` 移動到 `backup`。

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
backup_patt="檔案 `%s` 不在 `backup` 目錄中。您是否正確使用了 `mv`？請使用兩個檔名和一個目錄作為 `mv` 的參數。"
seasonal_patt="檔案 `%s` 仍在 `seasonal` 目錄中。請確保使用 `mv` 移動檔案，而不是使用 `cp` 複製它們！"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("做得好，讓我們繼續這趟 shell 列車！")
```

---

## 我要如何重新命名檔案？

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` 也可以用來重新命名檔案。若你執行：

```{shell}
mv course.txt old-course.txt
```

目前工作目錄中的 `course.txt` 會被「移動」成 `old-course.txt`。
這和你熟悉的檔案瀏覽器做法不同，
但常常很實用。

要特別注意：
就像 `cp` 一樣，
`mv` 會覆寫已存在的檔案。
例如，
如果你已經有一個叫做 `old-course.txt` 的檔案，
那上面這個指令會把它用 `course.txt` 的內容取代。

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
切換到 `seasonal` 目錄。

`@hint`
記住，`cd` 代表「change directory（切換目錄）」，而相對路徑不會以前導的 '/' 開頭。

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
key: ed5fe1df23
xp: 35
```

`@instructions`
把檔案 `winter.csv` 重新命名為 `winter.csv.bck`。

`@hint`
使用 `mv`，依序放上檔案目前的名稱，以及你想要改成的名稱。

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " 使用 `mv` 搭配兩個參數：您想要重新命名的檔案 (`winter.csv`) 和檔案的新名稱 (`winter.csv.bck`)。"
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="我們預期在目錄中找到 `winter.csv.bck`。" + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="我們不再預期在目錄中找到 `winter.csv`。" + hint)
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
執行 `ls` 以確認一切都運作正常。

`@hint`
記得按下「enter」或「return」來執行指令。

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="您是否已使用 `ls` 列出當前工作目錄的內容？")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "您的命令未生成正確的文件列表。請使用不帶參數的 `ls` 列出當前工作目錄的內容。")
    )
)
Ex().success_msg("複製、移動、重命名，您都已經掌握了！接下來：刪除文件。")
```

---

## 我要如何刪除檔案？

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

我們可以複製檔案並在不同位置之間移動；
若要刪除它們，
請使用 `rm`，
它代表「remove」。
就像 `cp` 和 `mv` 一樣，
你可以把想刪除的多個檔名一次交給 `rm`，例如：

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

會同時移除 `thesis.txt` 和 `backup/thesis-2017-08.txt`。

`rm` 顧名思義，
而且會立刻執行：
和圖形化的檔案瀏覽器不同，
shell 沒有資源回收桶，
所以當你輸入上面的指令後，
你的論文就真的被刪掉了。

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
你現在位於 `/home/repl`。
進入 `seasonal` 目錄。

`@hint`
記得 `cd` 代表「change directory」，而且相對路徑不會以開頭的 '/' 起始。

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
刪除 `autumn.csv`。

`@hint`
記得 `rm` 代表「remove」。

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="我們不期望 `autumn.csv` 仍然在 `seasonal` 目錄中。使用 `rm` 和您想要刪除的文件路徑。"),
    has_code('rm', incorrect_msg = '使用 `rm` 來刪除文件，而不是移動它。')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
回到你的家目錄。

`@hint`
如果不加任何路徑使用 `cd`，它會把你帶回家目錄。

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="使用 `cd ..` 或 `cd ~` 返回主目錄。")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
不要再變更目錄，直接刪除 `seasonal/summer.csv`。

`@hint`
記得 `rm` 代表「remove」。

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="我們不期望 `summer.csv` 仍然在 `seasonal` 目錄中。使用 `rm` 和您想要刪除的文件路徑。"),
    has_code('rm', incorrect_msg = '使用 `rm` 來刪除文件，而不是移動它。')
)
Ex().success_msg("令人印象深刻！繼續下一個！")
```

---

## 我要如何建立與刪除目錄？

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` 對目錄的處理方式和對檔案一樣：
例如，若你在家目錄下執行 `mv seasonal by-season`，
`mv` 會把 `seasonal` 這個目錄改名為 `by-season`。
然而，
`rm` 的行為不同。

如果你嘗試對目錄使用 `rm`，
shell 會顯示錯誤訊息，告訴你無法這麼做，
主要是為了避免你不小心把整個裝滿工作的目錄刪掉。
作為替代方案，
你可以使用另一個指令 `rmdir`。
為了更安全，
它只會在目錄是空的時候運作，
所以你必須在刪除目錄「之前」先刪掉其中的檔案。
（有經驗的使用者可以在 `rm` 加上 `-r` 選項達到相同效果；
我們會在下一章討論指令選項。）

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
不要切換目錄，
刪除 `people` 目錄中的檔案 `agarwal.txt`。

`@hint`
記住 `rm` 是「remove」的縮寫，另外，相對路徑不會以前導的 '/' 開頭。

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` 不應再位於 `/home/repl/people` 中。您是否正確使用了 `rm`？"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = '`people` 目錄中仍然有文件。如果您只是移動了 `agarwal.txt`，或創建了新文件，請刪除它們。')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
現在 `people` 目錄已經是空的，
用一個指令把它刪掉。

`@hint`
記住 `rm` 只能用在檔案上。

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "您的主目錄中不應再有 'people' 目錄。請使用 `rmdir` 將其移除！")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
由於目錄不是檔案，
你必須使用 `mkdir directory_name` 這個指令
來建立一個新的（空的）目錄。
使用這個指令在你的家目錄下建立一個名為 `yearly` 的新目錄。

`@hint`
執行 `mkdir`，後面接上你想建立的目錄名稱。

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="您的主目錄中沒有 `yearly` 目錄。請使用 `mkdir yearly` 來創建一個！")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
既然 `yearly` 已經存在，
在其中建立另一個名為 `2017` 的目錄，
而且不要離開你的家目錄。

`@hint`
對你要建立的子目錄使用相對路徑。

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="在 '/home/repl/yearly' 中找不到 '2017' 目錄。您可以使用相對路徑 `yearly/2017` 來創建此目錄。")
)
Ex().success_msg("太好了！讓我們用一個重複本章某些概念的練習來結束這一章！")
```

---

## 總結

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

在分析資料時，你常會建立中間檔案。
與其把它們放在你的家目錄，
不如放到 `/tmp`，
這是人和程式只需暫時使用的檔案常放的位置。
（注意，`/tmp` 位於根目錄 `/` 之下，
而不是在你的家目錄之下。）
這個總結練習會示範該怎麼做。

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
使用 `cd` 切換到 `/tmp`。

`@hint`
記得 `cd` 代表「change directory（變更目錄）」且絕對路徑會以 '/' 開頭。

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = '您在錯誤的目錄中。使用 `cd` 將目錄更改為 `/tmp`。')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
在不輸入目錄名稱的情況下，列出 `/tmp` 的內容。

`@hint`
如果你沒有告訴 `ls` 要列出什麼，它會顯示你目前目錄的內容。

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "您沒有呼叫 `ls` 來生成檔案清單。"),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "您的命令未生成正確的檔案清單。請使用 `ls`。")
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
在 `/tmp` 裡建立名為 `scratch` 的新目錄。

`@hint`
使用 `mkdir` 建立目錄。

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
      has_code('mkdir +scratch', incorrect_msg="無法在 '/tmp' 下找到 'scratch' 目錄。請確保正確使用 `mkdir`。")
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
將 `/home/repl/people/agarwal.txt` 移動到 `/tmp/scratch`。
建議你針對家目錄使用 `~` 快捷方式，並為第二個路徑使用相對路徑，而不要用絕對路徑。

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="無法在 '/tmp/scratch' 中找到 'agarwal.txt'。請使用 `mv`，將 `~/people/agarwal.txt` 作為第一個參數，`scratch` 作為第二個參數。")
)
Ex().success_msg("這是《Shell 簡介》第 1 章的結尾！趕快進入下一章，學習更多關於數據操作的知識！")
```

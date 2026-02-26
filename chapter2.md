---
title: データの操作
description: >-
  前の章で見たコマンドは、ファイルシステム内でモノを移動するためのものでした。この章では、それらのファイルの中のデータを扱う方法を学びます。使うツールは比較的シンプルですが、確かな基礎となるものです。
lessons:
  - nb_of_exercises: 12
    title: ファイルの中身はどうやって表示しますか？
---

## ファイルの中身はどうやって確認できますか？

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

ファイル名を変更したり削除したりする前に、まずは中身を確認したいことがあります。
これを行う最も簡単な方法は `cat` を使うことです。
`cat` はファイルの内容をそのまま画面に表示します。
（名前は「concatenate（連結する）」の略で、指定した複数のファイルを順番に続けて表示できることに由来します。）

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
`course.txt` の内容を画面に表示してください。

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
    has_expr_output(incorrect_msg="コマンドが正しい出力を生成しませんでした。`cat`の後にファイル名`course.txt`を使用しましたか？")
)
Ex().success_msg("素晴らしいです！ファイルの内容を表示する他の方法を見てみましょう。")
```

---

## ファイルの中身を少しずつ表示するにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

大きなファイルは `cat` で表示してスクロールすることもできますが、通常は出力を**ページ送り**にするほうが便利です。
このための元のコマンドは `more` でしたが、今ではより強力な `less` に置き換えられています。
（この名前付けは、Unix界隈のユーモアです。）
`less` でファイルを開くと、1ページずつ表示されます。
スペースキーで次のページに進み、`q` で終了できます。

`less` に複数のファイル名を渡すと、
次のファイルに進むには `:n`（コロンと小文字の n）、
前のファイルに戻るには `:p`、
終了するには `:q` と入力します。

注意: `less` を使う演習の模範解答を表示すると、最後にページ送りをオフにするための追加コマンドが入っています。
これはあなたの解答を効率よく採点するためです。

`@instructions`
`less seasonal/spring.csv seasonal/summer.csv` を使って、2つのファイルをその順番で表示してください。
スペースキーでページを進み、`:n` で2つ目のファイルへ、`:q` で終了します。

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
                 incorrect_msg='`less`とファイル名を使用してください。`:n`で次のファイルに移動することを忘れないでください。'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## ファイルの先頭を確認するには？

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

データサイエンティストが新しいデータセットを受け取ったとき、最初に行うことの多くは、どんなフィールドがあり、それぞれにどんな値が入っているかを把握することです。
データベースやスプレッドシートからエクスポートされたデータセットは、多くの場合 **comma-separated values**（CSV）として保存されています。
中身を手早く知る方法は、先頭の数行を確認することです。

シェルでは、`head` というコマンドでこれができます。
名前が示すとおり、ファイルの先頭の数行（ここでは 10 行）を表示します。
例えば、次のコマンドは:

```{shell}
head seasonal/summer.csv
```

次のように表示します:

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

もしファイルに 10 行なかったら、`head` はどう動作しますか？
（`people/agarwal.txt` の先頭を表示して確かめてみましょう。）

`@possible_answers`
- ファイルが短すぎるためエラーメッセージを表示する。
- 存在する行数だけ表示する。
- 合計が 10 行になるように空行を追加して表示する。

`@hint`
最も役立つ動作は何でしょうか？

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["不正解：それは最も有用なことではありません。",
                    "正解です！",
                    "不正解：それは、末尾に多数の空白行があるファイルと区別することが不可能です。"])
```

---

## どうすれば入力を減らせますか？

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

シェルの強力な機能のひとつが、**タブ補完**です。
ファイル名の一部を入力してから Tab キーを押すと、
シェルが可能な限りパスを自動補完してくれます。
たとえば、
`sea` と入力して Tab を押すと、
ディレクトリ名 `seasonal/`（末尾のスラッシュ付き）が補完されます。
続けて `a` と入力して Tab を押すと、
パスは `seasonal/autumn.csv` まで補完されます。

パスがあいまいな場合、
たとえば `seasonal/s` のようなときは、
Tab をもう一度押すと候補の一覧が表示されます。
さらに文字を1〜2個追加してパスをより具体的にし、
もう一度 Tab を押すと、
残りの名前が補完されます。

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
ファイル名をすべて入力せずに、`head seasonal/autumn.csv` を実行してください。

`@hint`
必要なところまでパスを入力したら Tab を押し、必要に応じて繰り返してください。

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="チェッカーはコマンド内で正しい出力を見つけることができませんでした。`seasonal/autumn.csv` に対して `head` を呼び出したことを確認してください。")
)

```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
ファイル名をすべて入力せずに、`head seasonal/spring.csv` を実行してください。

`@hint`
必要なところまでパスを入力したら Tab を押し、必要に応じて繰り返してください。

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="チェッカーはコマンドで正しい出力を見つけることができませんでした。`seasonal/spring.csv` に対して `head` を呼び出したことを確認してください。")
)
Ex().success_msg("よくできました！タブ補完の使用に慣れると、多くの時間を節約できますよ！")
```

---

## コマンドの動作はどうやって制御できますか？

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

ファイルの最初の10行だけを常に見たいとは限りません。
そのためシェルでは、**コマンドラインフラグ**（略して「フラグ」）を指定して、`head` の挙動を変えられます。
次のコマンドを実行すると、

```{shell}
head -n 3 seasonal/summer.csv
```

`head` はファイルの最初の3行だけを表示します。
`head -n 100` を実行すれば、（行数があれば）最初の100行を表示します。

フラグ名は通常、その目的を示しています（たとえば、`-n` は「行数（**n**umber of lines）」を表します）。
コマンドのフラグは必ずしも `-` に1文字が続く形式である必要はありませんが、広く使われている慣例です。

注意: 一般的には、すべてのフラグはファイル名よりも*前*に置くのが良いスタイルとされています。
このコースでも、その形式のみを正解として受け付けます。

`@instructions`
`seasonal` ディレクトリにある `winter.csv` の先頭5行を表示してください。

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
        has_expr_output(incorrect_msg="`head` コマンドを `seasonal/winter.csv` ファイルに対して実行していることを確認してください。"),
        has_expr_output(strict=True, incorrect_msg="`-n 5` フラグを使用したことを確認してください。")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "`-n 5` フラグを使用したことを確認してください。")
)
Ex().success_msg("素晴らしいです！この技術を使えば、より大きなテキストファイルを確認したい場合にシェルがクラッシュするのを防ぐことができます。")
```

---

## ディレクトリ配下のすべてを一覧するには？

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

あるディレクトリの下にあるものを、
どれだけ深く入れ子になっていてもすべて確認したいときは、
`ls` にフラグ `-R`（「再帰的」の意味）を付けます。
ホームディレクトリで `ls -R` を使うと、次のように表示されます。

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

これは、まず現在の階層にあるすべてのファイルとディレクトリを示し、
その後に各サブディレクトリの中身を、
さらにその下層へと順に表示していきます。

`@instructions`
何が何かを見分けやすくするために、
`ls` にはもう一つフラグ `-F` があり、ディレクトリ名の後ろに `/`、
実行可能なプログラム名の後ろに `*` を付けて表示します。
`ls` をフラグ `-R` と `-F` の両方、およびホームディレクトリへの絶対パスと一緒に実行して、
その中身をすべて確認してください。
（フラグの順序はどちらでも構いませんが、ディレクトリ名は最後に指定する必要があります。）

`@hint`
ホームディレクトリは、`~` や `.`、または絶対パスで指定できます。

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
  has_expr_output(incorrect_msg='`ls -R -F` または `ls -F -R` とパス `/home/repl` を使用してください。'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='`ls -R -F` または `ls -F -R` とパス `/home/repl` を使用してください。')
)
Ex().success_msg('なかなか素晴らしい概要ですね。')
```

---

## コマンドのヘルプはどうやって参照できますか？

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

コマンドが何をするかを調べるために、昔からよく使われているのが `man` コマンド（"manual" の略）です。たとえば、`man head` と入力すると次の情報が表示されます。

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

`man` は自動的に `less` を起動します。情報をページ送りするにはスペースキーを押し、終了するには `:q` を入力する必要がある場合があります。

`NAME` の下にある1行の説明はコマンドの概要を示し、`SYNOPSIS` の要約には利用できるフラグが一覧されています。省略可能なものは角括弧 `[...]` で示され、どちらか一方を選ぶものは `|` で区切られ、繰り返し可能なものは `...` で示されます。つまり、`head` のマニュアルページは、`-n` で行数、または `-c` でバイト数のいずれかを指定でき、さらに任意の数のファイル名を渡せることを伝えています。

Unix のマニュアルの難点は、探しているものをあらかじめ知っている必要があることです。わからない場合は、[Stack Overflow](https://stackoverflow.com/) で検索したり、DataCamp の Slack チャンネルで質問したり、すでに知っているコマンドの `SEE ALSO` セクションを参照したりできます。

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
`tail` コマンドのマニュアルページを読み、`-n` フラグで使う数値の前に `+` 記号を付けると何が起きるかを確認してください。（ページを下に進めるにはスペースキー、終了するには `q` を入力することを忘れないでください。）

`@hint`
`man` は "manual"（マニュアル）の略です。

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='`man`とコマンド名を使用してください。')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
`tail` にフラグ `-n +7` を付けて、`seasonal/spring.csv` の先頭6行以外のすべてを表示してください。

`@hint`
表示したい行数の前にプラス記号 '+' を付けてください。

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="`seasonal/spring.csv` に対して `tail` を呼び出していますか？"),
    has_expr_output(strict=True, incorrect_msg="`-n +7` フラグを使用したことを確認しましたか？")
)
```

---

## ファイルから列を選択するにはどうすればよいですか？

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` と `tail` は、テキストファイルから行を選択できます。
列を選択したい場合は、`cut` コマンドが使えます。
`cut` にはいくつかのオプションがあります（`man cut` で確認できます）が、最も一般的なのは次のような使い方です。

```{shell}
cut -f 2-5,8 -d , values.csv
```

これは
「区切り文字にカンマを使い、2 列目から 5 列目と 8 列目を選ぶ」
という意味です。
`cut` では列を指定するのに `-f`（"fields" の意味）、
区切り文字を指定するのに `-d`（"delimiter" の意味）を使います。
ファイルによっては、列の区切りにスペース、タブ、コロンが使われていることがあるため、後者は明示的に指定する必要があります。

<hr>

ファイル `spring.csv` から最初の列（日付が入っている列）を選択するコマンドはどれですか？

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- 上のどちらでもよい。
- どちらも誤り。`-f` は `-d` の前に来なければならないため。

`@hint`
フラグの順序は関係ありません。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['はい、しかしそれだけではありません', 'はい、しかしそれだけではありません', '正解です！フラグの後にスペースを追加するのは良いスタイルですが、必須ではありません。', 'いいえ、フラグの順序は重要ではありません'])
```

---

## cut にできないことは？

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` は単純なコマンドです。
特に、引用符で囲まれた文字列を理解しません。
たとえば、ファイルが次のような場合:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

次のコマンドは:

```{shell}
cut -f 2 -d , everyone.csv
```

以下の出力になります:

```
Age
Ranjit"
Rupinder"
```

すべての人の年齢ではなくこの結果になるのは、姓と名の間のカンマを列の区切りと見なしてしまうためです。

<hr>

次の行に対して `cut -d : -f 2-4` を実行すると、出力はどうなりますか？

```
first:second:third:
```

（末尾のコロンに注意してください。）

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- 上記のどれでもない。4 つのフィールドがないため。

`@hint`
末尾のコロンに注意してください。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['いいえ、もっとあります。', 'いいえ、もっとあります。', '正解です！末尾のコロンが空の第4フィールドを作成します。', 'いいえ、`cut`はできる限りのことをします。'])
```

---

## コマンドを繰り返すにはどうすればよいですか？

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

シェルを使う大きな利点のひとつは、同じ作業を簡単に繰り返せることです。
いくつかコマンドを実行したら、上矢印キーでそれらをさかのぼって呼び出せます。
左右の矢印キーや削除キーで編集することもできます。
その後、リターンキーを押すと、編集後のコマンドが実行されます。

さらに便利なのが、`history` です。最近実行したコマンドの一覧を表示してくれます。
各コマンドには通し番号が付いているので、特定のコマンドを簡単に再実行できます。
たとえば、履歴の55番目のコマンドを再実行するには `!55` と入力します（その数だけ履歴がある場合）。
また、感嘆符に続けてコマンド名を入力する方法でも再実行できます。
たとえば `!head` や `!cut` のように入力すると、そのコマンドの直近の実行が再実行されます。

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
ホームディレクトリで `head summer.csv` を実行してください（失敗するはずです）。

`@hint`
一致するファイル名がない場合は、Tab 補完は機能しません。

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="`head` とファイル名 `summer.csv` を使用してください。失敗しても心配しないでください。それで大丈夫です。")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
`seasonal` ディレクトリに移動してください。

`@hint`
`cd` は "change directory"（ディレクトリを変更）を表します。

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="現在の作業ディレクトリ（`pwd`で確認） が `/home/repl` の場合、`cd seasonal` で `seasonal` フォルダに移動できます。")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
`!head` を使って `head` コマンドを再実行してください。

`@hint`
`!` とその後に続く文字のあいだにスペースを入れないでください。

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
                        incorrect_msg='`!head` を使用して `head` コマンドを繰り返してください。'),
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
`history` を使って、これまでの操作を確認してください。

`@hint`
`history` は最新のコマンドを最後に表示します。実行後も画面に残るので確認しやすいです。

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='フラグを使用せずに `history` を使用して、以前のコマンドのリストを取得してください。')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
コマンド番号の前に `!` を付けて、もう一度 `head` を再実行してください。

`@hint`
`!` とその後に続く文字のあいだにスペースを入れないでください。

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
                        incorrect_msg='`!<a_number>`を使用して、履歴から最後の`head`を再実行しましたか？'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("よくできました！次に進みましょう！")
```

---

## 特定の値を含む行をどのように抽出できますか？

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` と `tail` は行（行頭・行末）を選び、
`cut` は列を選び、
`grep` は行の内容に基づいて行を選びます。
いちばん基本的な使い方では、
`grep` は検索したいテキストに続けて1つ以上のファイル名を受け取り、
そのテキストを含む行をすべて表示します。
たとえば、
`grep bicuspid seasonal/winter.csv`
は、"bicuspid" を含む `winter.csv` の行を表示します。

`grep` はパターン検索もできますが、
それは次のコースで扱います。
今大事なのは、`grep` のよく使うフラグです。

- `-c`: 行そのものではなく、一致した行数を表示します
- `-h`: 複数ファイルを検索するときに、ファイル名を表示しません
- `-i`: 大文字小文字を無視します（例: "Regression" と "regression" を一致とみなす）
- `-l`: 一致を含むファイル名のみを表示し、一致した行は表示しません
- `-n`: 一致した行の行番号を表示します
- `-v`: 一致を反転します。つまり、一致「しない」行だけを表示します

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
ホームディレクトリにいる状態で、`seasonal/autumn.csv` の中で単語 `molar` を含むすべての行の内容を、1つのコマンドで表示してください。フラグは使わないでください。

`@hint`
探したい単語と検索対象のファイル名を指定して `grep` を使ってください。

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
      has_code("grep", incorrect_msg = "`grep`を呼び出しましたか？"),
      has_code("molar", incorrect_msg = "`molar`を検索しましたか？"),
      has_code("seasonal/autumn.csv", incorrect_msg = "`seasonal/autumn.csv`ファイルを検索しましたか？")
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
一致を反転して、`seasonal/spring.csv` の中で単語 `molar` を含まない行をすべて見つけ、その行番号を表示してください。
なお、検索語「molar」やファイル名などの値よりも、フラグを先に書くのがよい書き方とされています。

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
      has_code("grep", incorrect_msg = "「grep」を呼び出しましたか？"),
      has_code("-v", incorrect_msg = "「-v」で一致を反転しましたか？"),
      has_code("-n", incorrect_msg = "「-n」で行番号を表示しましたか？"),
      has_code("molar", incorrect_msg = "「molar」を検索しましたか？"),
      has_code("seasonal/spring.csv", incorrect_msg = "「seasonal/spring.csv」ファイルを検索しましたか？")
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
`autumn.csv` と `winter.csv` を合わせて、単語 `incisor` を含む行がいくつあるか数えてください。
（こちらも、ホームディレクトリから1つのコマンドで実行してください。）

`@hint`
行数を数えるには `grep` に `-c` を付けることを思い出してください。

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
      has_code("grep", incorrect_msg = "「grep」を呼び出しましたか？"),
      has_code("-c", incorrect_msg = "「-c」でカウントを取得しましたか？"),
      has_code("incisor", incorrect_msg = "「incisor」を検索しましたか？"),
      has_code("seasonal/autumn.csv", incorrect_msg = "「seasonal/autumn.csv」ファイルを検索しましたか？"),
      has_code("seasonal/winter.csv", incorrect_msg = "「seasonal/winter.csv」ファイルを検索しましたか？")
    )
  )
)
```

---

## なぜデータを常にテキストとして扱うのは安全ではないのですか？

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

`cut` のマニュアルページの `SEE ALSO` セクションには、データを分割する代わりに結合できる `paste` というコマンドが記載されています。

<hr>

まず `paste` のマニュアルページを読み、次に `paste` を実行して、秋と冬のデータファイルをカンマ区切りで1つの表に結合してください。
データ分析の観点から見て、この出力のどこが問題でしょうか？

`@possible_answers`
- 列ヘッダーが繰り返されています。
- 末尾の数行で列数が合っていません。
- `winter.csv` の一部のデータが欠けています。

`@hint`
`paste` の出力を、区切り文字にカンマを使って `cut` したら、正しい答えになりますか？

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = '正しいですが、必ずしもエラーではありません。'
correct2 = '正解です: 列で行を結合すると、最初に空の列が1つだけ作成され、2つではありません。'
err3 = 'いいえ、すべての冬のデータがそこにあります。'
Ex().has_chosen(2, [err1, correct2, err3])
```

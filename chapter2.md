---
title: データの操作
description: >-
  前の章で見たコマンドを使えば、ファイルシステム内で物事を移動できます。この章では、それらのファイル内のデータを扱う方法を学びます。使用するツールはかなりシンプルですが、しっかりした構成要素です。
lessons:
  - nb_of_exercises: 12
    title: ファイルの中身を確認するにはどうすればよいですか？
---

## ファイルの内容を確認するにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

ファイルの名前を変更したり削除したりする前に、
その内容を確認しておきたい場合があります。
最も簡単な方法は `cat` を使うことです。
このコマンドはファイルの内容を画面に表示するだけのシンプルなものです。
（名前は「連結する」の略で、
指定した複数のファイルの内容を順番につなげて表示することから来ています。）

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

## ファイルの内容を一つずつ見るにはどうすればいいですか?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

`cat` を使えば大きなファイルを出力して、その出力をスクロールして確認できます。
しかし、通常は出力を**ページ単位で表示**したほうが便利です。
これを行うための最初のコマンドは `more` と呼ばれていましたが、
より高機能な `less` というコマンドに取って代わられました。
（このような名前の付け方が、Unix の世界ではユーモアとして通用しています。）
`less` でファイルを表示すると、
一度に1ページずつ表示されます。
スペースキーを押すと次のページに進み、`q` と入力すると終了します。

`less` に複数のファイル名を指定した場合、
`:n`（コロンと小文字の「n」）と入力すると次のファイルに移動でき、
`:p` と入力すると前のファイルに戻り、
`:q` と入力すると終了できます。

注: `less` を使う演習の解答例を見ると、
最後にページ表示を*オフ*にする追加のコマンドが含まれています。
これは、みなさんの解答を効率的にテストできるようにするためです。

`@instructions`
`less seasonal/spring.csv seasonal/summer.csv` を使って、この2つのファイルをその順番で表示してください。
スペースキーでページ送り、`:n` で2つ目のファイルに移動し、`:q` で終了します。

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

## ファイルの先頭を見るにはどうすればよいでしょうか？

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

データサイエンティストが新しいデータセットを分析するとき、まず行うのは
そのデータにどんな項目があり、それぞれにどんな値が入っているかを把握することです。
データセットがデータベースやスプレッドシートから書き出されたものであれば、
多くの場合、**カンマ区切り値**（CSV）として保存されています。
中身を手早く確認するには、最初の数行を見ればよいでしょう。

シェルでは、`head` というコマンドを使ってこれを行えます。
名前のとおり、
ファイルの先頭から数行（「数行」とは10行のことです）を表示するので、
次のコマンドを実行すると:

```{shell}
head seasonal/summer.csv
```

次のように表示されます:

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

`head` は、ファイルに10行未満しかない場合どうなるでしょうか。
（確かめるには、`people/agarwal.txt` の先頭を見てみましょう。）

`@possible_answers`
- ファイルが短すぎるため、エラーメッセージを表示する。
- 行数があるだけ表示する。
- 合計が10行になるように、十分な空白行を表示する。

`@hint`
最も役立つことは何でしょうか？

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

## 入力を減らすにはどうすればよいでしょうか？

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

シェルの強力なツールの1つが**タブ補完**です。
ファイル名の入力を始めてから タブ キーを押すと、
シェルがパスを可能な限り自動補完してくれます。
例えば、
`sea` と入力して Tab キーを押すと、
ディレクトリ名 `seasonal/`（末尾のスラッシュ付き）が補完されます。
そこからさらに `a` と入力して タブ キーを押すと、
パスは `seasonal/autumn.csv` として補完されます。

`seasonal/s` のようにパスが曖昧な場合は、
もう一度 タブ キーを押すと、
候補の一覧が表示されます。
もう1文字か2文字入力してパスをより具体的にしてから
タブ キーを押すと、
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
ファイル名をすべて入力せずに、`head seasonal/autumn.csv`を実行してください。

`@hint`
必要なだけパスを入力し、タブキーを押して繰り返してください。

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
ファイル名をすべて入力せずに、`head seasonal/spring.csv`を実行してください。

`@hint`
必要なだけパスを入力し、タブキーを押して繰り返してください。

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

## コマンドが何をするかをどうやって制御すればいいですか?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

必ずしもファイルの最初の10行だけを見たいとは限りません。
そのため、シェルでは`head`の動作を
コマンドラインフラグ(略して「フラグ」)を付けることで変更できます。
次のコマンドを実行すると:

```{shell}
head -n 3 seasonal/summer.csv
```

`head`はファイルの最初の3行のみを表示します。
`head -n 100`を実行すると、
最初の100行(それほど多くあれば)を表示します。
などなど。

フラグの名前は通常、その目的を示します
(例えば、`-n`は「行数」を示すためのものです。)
コマンドフラグは必ずしも`-`の後に単一の文字が続くものではありませんが、
それは広く使われている慣習です。

注意:すべてのフラグをファイル名の前に置くのが良いスタイルとされています。
このコースでは、
そのようにした答えのみを受け入れます。

`@instructions`
`winter.csv`ディレクトリに最初の5行の`seasonal`を表示します。

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

## ディレクトリ以下のすべての内容を一覧表示するには?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

あるディレクトリの下にあるすべての内容を、
どれだけ深い階層にあっても確認したい場合は、
`ls` に `-R` のフラグを与えます
（「再帰的」という意味です）。
ホームディレクトリで `ls -R` を実行すると、
次のような出力が得られます。

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

この出力は、まず現在の階層にあるすべてのファイルとディレクトリを表示し、
続いて各サブディレクトリの中身を表示するという形で、
以降も同様に続いていきます。

`@instructions`
何が何であるかをわかりやすくするために、
`ls` には、ディレクトリ名の後に `-F` を、実行可能なプログラム名の後に `/` を表示する `*` という別のフラグがあります。
`ls` に `-R` と `-F` の2つのフラグとホームディレクトリの絶対パスを指定して実行し、
その中にあるものをすべて見てみましょう。
（フラグの順序はどちらでも構いませんが、ディレクトリ名は必ず最後に指定してください。）

`@hint`
ホームディレクトリは`~`または`.`またはその絶対パスを指定できます。

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

## コマンドのヘルプを見るにはどうすればいいですか？

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

コマンドが何をするかを調べるために、以前は `man` コマンド（"manual"の略）が使われていました。
たとえば、`man head` コマンドを実行すると、次のような情報が表示されます。

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

`man` は自動的に `less` を呼び出すため、情報をページ送りするにはスペースキーを、
終了するには `:q` を押す必要がある場合があります。

`NAME` の下にある1行の説明は、そのコマンドが何をするかを簡潔に示しています。
また、`SYNOPSIS` の下の要約には、そのコマンドが認識するすべてのフラグが記載されています。
オプションであることを示す場合は角括弧 `[...]` で囲まれ、
どちらか一方の代替は `|` で区切られ、
繰り返し可能なものは `...` で示されます。
つまり `head` のマニュアルページは、`-n` で行数を指定するか `-c` でバイト数を指定するか、
そしてファイル名をいくつでも指定できることを示しています。

Unix のマニュアルの問題点は、何を探しているかをあらかじめ知っておく必要があることです。
もしわからない場合は、[Stack Overflow](https://stackoverflow.com/) で検索したり、
DataCamp の Slack チャンネルで質問したり、
すでに知っているコマンドの `SEE ALSO` セクションを確認したりすることができます。

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
`tail`コマンドのマニュアルページを読んで、
`+`の記号を、`-n`フラグで使う番号の前に付けると何が起こるのかを確認してください。
(ページを下に進めるにはスペースバーを押し、終了するには`q`と入力してください。)

`@hint`
`man` は「マニュアル」の略であることを思い出しましょう。

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
`tail` に `-n +7` フラグを付けて使用し、`seasonal/spring.csv` の最初の6行を除くすべての行を表示します。

`@hint`
表示したい行数の前にプラス記号「+」を付けてください。

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

## ファイルから列を選択するにはどうすればよいですか?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` と `tail` を使うと、テキストファイルから行を選択できます。
列を選択したい場合は、`cut` コマンドを使用します。
このコマンドには複数のオプションがあります（`man cut` で確認できます）が、最も一般的な使い方は次のようになります。

```{shell}
cut -f 2-5,8 -d , values.csv
```

これは「カンマを区切り文字として、2列目から5列目と8列目を選択する」という意味です。
`cut` では、列を指定するために `-f`（「フィールド」の意味）を使い、区切り文字を指定するために `-d`（「デリミタ」の意味）を使います。
ファイルによってはスペースやタブ、コロンを列の区切りに使っている場合があるため、区切り文字を明示的に指定する必要があります。

<hr>

ファイル `spring.csv` から最初の列（日付が含まれる列）を選択するには、どのコマンドを使えばよいでしょうか?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- 上記のいずれかです。
- 上記のどちらでもありません。`-f` は `-d` より前に指定する必要があるためです。

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

## cut でできないことは何ですか?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` は単純な仕組みのコマンドです。
特に、引用符で囲まれた文字列を認識できません。
例えば、ファイルの内容が次のようになっているとします。

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

この場合、次のコマンドを実行すると:

```{shell}
cut -f 2 -d , everyone.csv
```

次のような出力になります。

```
Age
Ranjit"
Rupinder"
```

これは全員の年齢ではありません。姓と名の間にあるカンマを列の区切り文字と認識してしまうためです。

<hr>

次の行に対して `cut -d : -f 2-4` を実行すると、出力はどうなりますか。

```
first:second:third:
```

（末尾のコロンに注意してください。）

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- 上記のいずれでもない。なぜなら欄は4つないからだ。

`@hint`
末尾のコロンに注目してください。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['いいえ、もっとあります。', 'いいえ、もっとあります。', '正解です！末尾のコロンが空の第4フィールドを作成します。', 'いいえ、`cut`はできる限りのことをします。'])
```

---

## コマンドを繰り返すにはどうすればよいでしょうか？

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

シェルを使う最大の利点の一つは、
何度でも簡単に同じことを繰り返せることです。
いくつかのコマンドを実行すると、
その後、上矢印キーを押してそれらをさかのぼることができます。
左右の矢印キーと削除キーを使用して編集することもできます。
リターンキーを押すと、修正したコマンドが実行されます。

さらに便利なのは、`history`を使うと、最近実行したコマンドの一覧を出力できることです。
各コマンドの前には連番が付いているので、特定のコマンドを簡単に再実行できます:
`!55`と入力すれば、履歴の55番目のコマンドを再実行できます(もしそれだけの数があれば)。
また、感嘆符の後にコマンド名を入力してコマンドを再実行することもできます。
`!head`や`!cut`のようにすると、
そのコマンドの直近の実行を再度行います。

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
一致するファイル名がない場合、タブ補完は機能しません。

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
`seasonal`にディレクトリを変更する。

`@hint`
`cd`は「ディレクトリの変更」を意味することを覚えておいてください。

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
`head`で`!head`コマンドを再実行してください。

`@hint`
`!`とその後に続く文字列の間にスペースを入力しないでください。

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
`history` を使って、あなたが行ったことを見てください。

`@hint`
`history` は最新のコマンドを最後に表示するため、実行が終わったときに画面に残ることに注意してください。

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
`head`にコマンド番号を付けて再度`!`を実行してください。

`@hint`
`!`とその後に続く内容の間に、いかなるスペースも入力しないでください。

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

## 特定の値を含む行を選択するにはどうすればいいですか?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head`および`tail`選択行、
`cut`列を選択します。
`grep`は行の内容に応じて選択します。
最も単純な形で言えば、
`grep`テキストの後に1つ以上のファイル名を付けます
そして、そのテキストを含むファイル内のすべての行を印刷します。
例えば、
`grep bicuspid seasonal/winter.csv`
「bicuspid」を含む`winter.csv`行を印刷します。

`grep`パターンも探すことができます。
それらは次のコースで探っていきます。
今より重要なのは、`grep`のよくあるフラッグのいくつかです:

- `-c`:行自体ではなく、一致する行の数を印刷します
- `-h`:複数のファイルを検索する際にファイル名を印刷しないでください
- `-i`:大文字を無視する(例:「回帰」と「回帰」をマッチとして扱う)
- `-l`:マッチを含むファイル名を印刷し、マッチを印刷しません
- `-n`:行を照合するための印刷行番号
- `-v`:マッチを逆にする、つまり*一致しない*線だけを表示する

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
`molar`という単語を含むすべての行の内容を`seasonal/autumn.csv`に印刷してください。ホームディレクトリ内で単一のコマンドを実行して行ってください。
オプションは使わないでください。

`@hint`
検索する単語と検索対象のファイル名を使って、`grep`を実行してください。

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
一致を反転させて、`molar` の中で単語 `seasonal/spring.csv` を含ま*ない*すべての行を見つけ、その行番号を表示しましょう。
なお、ファイル名や検索語 "molar" などの他の値よりも前にすべてのフラグを置くのが良いスタイルとされています。

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
`incisor`と`autumn.csv`を合わせて単語`winter.csv`を含む行数を数えてみてください。
(繰り返しますが、ホームディレクトリから1つのコマンドを実行してください。)

`@hint`
行数を数えるには、`-c` に `grep` を付けることを忘れないようにしましょう。

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

## データをテキストとして扱うのが常に安全とは限らないのはなぜですか

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

`SEE ALSO`のマニュアルページの`cut`セクションには、`paste`というコマンドが記載されています。
これは、データファイルを分割するのではなく、結合するために使えます。

<hr>

`paste`のマニュアルページを読んで、
`paste`を実行し、秋と冬のデータファイルをコンマ区切りで1つの表に結合してください。
データ分析の観点から、出力の何が問題なのでしょうか?

`@possible_answers`
- 列の見出しが繰り返されている。
- 最後の数行は列数が間違っている。
- `winter.csv` のデータの一部が欠落している。

`@hint`
`cut` の出力をカンマ区切りで `paste` した場合、正しい答えが得られるでしょうか。

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

---
title: バッチ処理
description: >-
  多くのシェルコマンドは複数のファイルを一度に処理できます。この章では、自分のパイプラインでもそれを実現する方法を学びます。その過程で、シェルが情報を保存するために変数をどのように使うかも見ていきます。
lessons:
  - nb_of_exercises: 10
    title: シェルは情報をどのように保存しますか？
---

## シェルはどのように情報を保存しますか？

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

他のプログラムと同様に、シェルも情報を変数に保存します。
その中には **環境変数** と呼ばれる、常に利用できるものがあります。
環境変数の名前は慣例的に大文字で書かれ、よく使われるものの一部を以下に示します。

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | ユーザーのホームディレクトリ       | `/home/repl`          |
| `PWD `   | 現在の作業ディレクトリ             | `pwd` コマンドと同じ  |
| `SHELL`  | 使用中のシェルプログラム           | `/bin/bash`           |
| `USER`   | ユーザー ID                        | `repl`                |

完全な一覧（かなり長いです）を得るには、シェルで `set` を入力します。

<hr>

パイプで `set` と `grep` を組み合わせて、コマンド履歴に保存される過去のコマンド数を決める `HISTFILESIZE` の値を表示してください。
その値はいくつですか？

`@possible_answers`
- 10
- 500
- [2000]
- その変数は存在しません。

`@hint`
必要な行を取り出すには、`set | grep HISTFILESIZE` を使います。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "いいえ: シェルはそれ以上の履歴を記録します。"
err2 = "いいえ: シェルはそれ以上の履歴を記録します。"
correct3 = "正解です: このシステムでは、シェルはデフォルトで2000個の古いコマンドを保存します。"
err4 = "いいえ: 変数 `HISTFILESIZE` は存在します。"
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## 変数の値を表示するには？

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

変数の値を調べるもっと簡単な方法は、引数をそのまま表示するコマンド `echo` を使うことです。次のように入力すると、

```{shell}
echo hello DataCamp!
```

次のように表示されます。

```
hello DataCamp!
```

もし次のように、変数の値を表示しようとして:

```{shell}
echo USER
```

と入力すると、表示されるのは変数名 `USER` です。

変数の値を得るには、先頭にドル記号 `$` を付ける必要があります。次のように入力すると、

```{shell}
echo $USER
```

次のように表示されます。

```
repl
```

これはどこでも同じです。
`X` という変数の値を得たいときは、`$X` と書きます。
（こうすることで、シェルは「X という名前のファイル」を指しているのか、
「X という名前の変数の値」を指しているのかを判別できます。）

`@instructions`
変数 `OSTYPE` には、使用しているオペレーティングシステムの種類が入っています。
`echo` を使ってその値を表示してください。

`@hint`
変数名の前に `$` を付けて、`OSTYPE` を `echo` で呼び出してください。

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
            has_code('echo', incorrect_msg="`echo`を呼び出しましたか？"),
            has_code('OSTYPE', incorrect_msg="`OSTYPE`環境変数を出力しましたか？"),
            has_code(r'\$OSTYPE', incorrect_msg="`OSTYPE`の前に`$`を付けることを確認してください。")
        )
    )
)
Ex().success_msg("環境変数の素晴らしいエコーです！良いスタートを切りましたね。この調子で続けましょう！")
```

---

## シェルはほかにどのように情報を保存しますか？

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

もう一つの種類の変数は **シェル変数** と呼ばれ、プログラミング言語のローカル変数のようなものです。

シェル変数を作成するには、
次のように名前に値を代入します。

```{shell}
training=seasonal/summer.csv
```

`=` 記号の前後にスペースを入れないでください。
この設定ができたら、
次のコマンドで変数の値を確認できます。

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
`testing` という変数に `seasonal/winter.csv` を代入してください。

`@hint`
変数名とその値の間にスペースを入れないでください。

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
        has_code('testing', incorrect_msg='`testing`という名前のシェル変数を定義しましたか？'),
        has_code('testing=', incorrect_msg='スペースを入れずに`testing`の直後に`=`を書きましたか？'),
        has_code('=seasonal/winter\.csv', incorrect_msg='`testing`の値を`seasonal/winter.csv`に設定しましたか？')
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
`head -n 1 SOMETHING` を使って `seasonal/winter.csv` の最初の1行を取得します。
ただし、ファイル名の代わりに変数 `testing` の値を使ってください。

`@hint`
`testing` ではなく `$testing` を使うことを忘れないでください
（変数の値を参照するには `$` が必要です）。

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
    has_code(r'\$testing', incorrect_msg="シェル変数を `$testing` を使用して参照しましたか？"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="`head` を呼び出しましたか？"),
            has_code('-n', incorrect_msg="`-n` で行数を制限しましたか？"),
            has_code(r'-n\s+1', incorrect_msg="`-n 1` で1行を保持することを選択しましたか？")     
        )
    )
)
Ex().success_msg("素晴らしいです！コマンドを簡単に繰り返す方法を見てみましょう。")
```

---

## コマンドを何度も繰り返すにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

シェル変数は、コマンドを何度も繰り返す**ループ**でも使われます。
次のコマンドを実行すると:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

次のように出力されます:

```
gif
jpg
png
```

このループについて、次の点に注目してください。

1. 構造は `for` ...変数... `in` ...リスト... `; do` ...本体... `; done` です。
2. ループが処理する対象のリスト（ここでは `gif`、`jpg`、`png` という語）。
3. 現在どの要素を処理しているかを保持する変数（ここでは `filetype`）。
4. 実際の処理を行うループ本体（ここでは `echo $filetype`）。

本体では、他のシェル変数と同様に、単なる `filetype` ではなく `$filetype` を使って変数の値を取得していることに注意してください。
また、セミコロンの位置にも注意しましょう。
1つ目はリストとキーワード `do` の間、2つ目は本体とキーワード `done` の間に置きます。

`@instructions`
ループを修正して、次のように表示されるようにしてください。

```
docx
odt
pdf
```

ループ変数の名前は `filetype` を使ってください。

`@hint`
導入文のコード構造を参考にして、画像ファイル形式をドキュメントファイル形式に置き換えてください。

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
      has_code('for', incorrect_msg='`for`を呼び出しましたか？'),
      has_code('filetype', incorrect_msg='ループ変数として`filetype`を使用しましたか？'),
      has_code('in', incorrect_msg='ファイルタイプのリストの前に`in`を使用しましたか？'),
      has_code('docx odt pdf', incorrect_msg='`docx`、`odt`、`pdf`をその順番でループしましたか？'),
      has_code(r'pdf\s*;', incorrect_msg='最後のループ要素の後にセミコロンを付けましたか？'),
      has_code(r';\s*do', incorrect_msg='最初のセミコロンの後に`do`を使用しましたか？'),
      has_code('echo', incorrect_msg='`echo`を呼び出しましたか？'),
      has_code(r'\$filetype', incorrect_msg='`$filetype`をエコーしましたか？'),
      has_code(r'filetype\s*;', incorrect_msg='ループ本体の後にセミコロンを付けましたか？'),
      has_code('; done', incorrect_msg='`done`で終了しましたか？')
    )
  )
)
Ex().success_msg("ループのための一流のコードです！ループは、同じことを何百回、何千回も行いたい場合に素晴らしいです。")
```

---

## 各ファイルに対してコマンドを1回ずつ実行するには？

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

ループを書くときに、処理したいファイル名を直接入力してもかまいませんが、
通常はワイルドカードを使うほうが便利です。
次のループをコンソールで実行してみてください。

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

次のように表示されます。

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

これは、シェルがループを実行する前に `seasonal/*.csv` を4つのファイル名のリストに展開するためです。

`@instructions`
ワイルドカード表現を `people/*` に変更し、
拡張子の有無に関係なく `people` ディレクトリ内のファイル名がループで表示されるようにしてください。
ループ変数の名前は `filename` を使ってください。

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
      has_code('for', incorrect_msg='`for`を呼び出しましたか？'),
      has_code('filename', incorrect_msg='ループ変数として`filename`を使用しましたか？'),
      has_code('in', incorrect_msg='ファイルタイプのリストの前に`in`を使用しましたか？'),
      has_code('people/\*', incorrect_msg='`people/*`でファイルのリストを指定しましたか？'),
      has_code(r'people/\*\s*;', incorrect_msg='ファイルのリストの後にセミコロンを付けましたか？'),
      has_code(r';\s*do', incorrect_msg='最初のセミコロンの後に`do`を使用しましたか？'),
      has_code('echo', incorrect_msg='`echo`を呼び出しましたか？'),
      has_code(r'\$filename', incorrect_msg='`$filename`をエコーしましたか？'),
      has_code(r'filename\s*;', incorrect_msg='ループ本体の後にセミコロンを付けましたか？'),
      has_code('; done', incorrect_msg='`done`で終了しましたか？')
    )
  )
)
Ex().success_msg("ループのループ！ワイルドカードとループは強力な組み合わせです。")
```

---

## 複数のファイル名をどうやって記録できますか？

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

ワイルドカード式を使って変数にファイル名の一覧を記録することはよくあります。
たとえば、`datasets` を次のように定義すると、

```{shell}
datasets=seasonal/*.csv
```

後で次のコマンドでファイル名を表示できます。

```{shell}
for filename in $datasets; do echo $filename; done
```

こうすることで、入力の手間が減り、ミスも起こりにくくなります。

<hr>

これら2つのコマンドをホームディレクトリで実行すると、
出力は何行になりますか？

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- 0行：`files` は別の行で定義されているため、2行目では値がありません。
- 1行：「files」という単語だけ。
- 4行：4つの季節データファイルの名前。

`@hint`
`X` はそれ自体では単なる「X」ですが、`$X` は変数 `X` の値になります。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "いいえ: 変数を使用する行で定義する必要はありません。"
err2 = "いいえ: この例では、同じシェルで変数 `files` を定義して使用しています。"
correct3 = "正解です。このコマンドは `for f in seasonal/*.csv; do echo $f; done` と同等です。"
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## 変数名とその値の違い

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

よくあるミスは、変数名の前に `$` を付け忘れることです。
これをしてしまうと、シェルはその変数の値ではなく、入力した名前そのものを使ってしまいます。

経験者により多いミスは、変数名をタイプミスすることです。
たとえば、次のように `datasets` を定義しておいて:

```{shell}
datasets=seasonal/*.csv
```

その後に次を入力すると:

```{shell}
echo $datsets
```

`datsets`（2つ目の "a" がない）という変数は定義されていないため、
シェルは何も表示しません。

<hr>

ホームディレクトリで次の2つのコマンドを実行した場合、
どのような出力が表示されますか?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

（回答する前に、ループの最初の部分をよく読んでください。）

`@hint`
単独の `X` はただの文字列「X」ですが、`$X` は変数 `X` の値になります。

`@possible_answers`
- [1行: 単語「files」。]
- 4行: 4つの季節データファイル名すべて。
- 空行が4行: 変数 `f` に値が代入されていない。

`@feedback`
- 正解です: ループでは `$files` ではなく `files` を使っているため、リストは単語「files」になります。
- いいえ: ループでは `$files` ではなく `files` を使っているため、リストは `files` の展開結果ではなく、単語「files」になります。
- いいえ: 変数 `f` は `for` ループによって自動的に定義されます。

---

## 1つのループで多くのコマンドをどう実行しますか？

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

ファイル名を表示するのはデバッグに便利ですが、ループの本当の目的は複数ファイルに対して処理を行うことです。
次のループは、各データファイルの2行目を表示します:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

これまで見てきた他のループと同じ構造で、異なるのは本体が1つのコマンドではなく2つのコマンドからなるパイプラインになっている点だけです。

`@instructions`
各 seasonal ファイルごとに、2017年7月（`2017-07`）の最後の行を表示するループを書いてください。出力は次のようなものに近くなるはずです:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

ただし、seasonal ファイルを**それぞれ**個別に処理します。ループ変数の名前は `file` を使い、例のような 'seasonal/winter.csv' ではなく、`seasonal/*.csv` というファイル一覧に対してループすることを忘れないでください。

`@hint`
ループ本体は、指示にある grep コマンドの `seasonal/winter.csv` を `$file` に置き換えたものです。

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
  has_code('for', incorrect_msg='`for`を呼び出しましたか？'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='ループ変数として`file`を使用しましたか？'),
      has_code('in', incorrect_msg='ファイルのリストの前に`in`を使用しましたか？'),
      has_code('seasonal/\*', incorrect_msg='`seasonal/*`でファイルのリストを指定しましたか？'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='ファイルのリストの後にセミコロンを付けましたか？'),
      has_code(r';\s*do', incorrect_msg='最初のセミコロンの後に`do`を使用しましたか？'),
      has_code('grep', incorrect_msg='`grep`を呼び出しましたか？'),
      has_code('2017-07', incorrect_msg='`2017-07`にマッチしましたか？'),
      has_code(r'\$file', incorrect_msg='ループ変数の名前として`$file`を使用しましたか？'),
      has_code(r'file\s*|', incorrect_msg='2番目のコマンドを接続するためにパイプを使用しましたか？'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='2番目のコマンドで各検索の最後のエントリを出力するために`tail -n 1`を使用しましたか？'),
      has_code('; done', incorrect_msg='`done`で終了しましたか？')
    )
  )
)

Ex().success_msg("ループのループ！ワイルドカードとループは強力な組み合わせです。")
```

---

## なぜファイル名にスペースを使うべきではないのですか？

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

グラフィカルなファイルエクスプローラを使うときは、`July 2017.csv` のように複数語からなる名前を付けるのは簡単で理にかなっています。
しかし、シェルで作業するときには問題になります。
たとえば、`July 2017.csv` を `2017 July data.csv` にリネームしたいとします。
次のようには入力できません。

```{shell}
mv July 2017.csv 2017 July data.csv
```

これはシェルから見ると、
`July`、`2017.csv`、`2017`、そして（再び）`July` という4つのファイルを、`data.csv` というディレクトリに移動しようとしているように見えるためです。
その代わりに、
シェルがそれぞれを1つの引数として扱うように、
ファイル名をクォートで囲む必要があります。

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

`current.csv` と、名前にスペースを含む `last year.csv` という2つのファイルがあり、
次のように入力した場合：

```{shell}
rm current.csv last year.csv
```

何が起こるでしょうか：

`@hint`
誰かにこのコマンドを見せられて、どんなファイルがあるのか知らなかったとしたら、何が起こりそうだと思いますか？

`@possible_answers`
- シェルは、`last` と `year.csv` が存在しないためエラーメッセージを表示します。
- シェルは `current.csv` を削除します。
- [上の両方。]
- 何も起こりません。

`@feedback`
- そうですが、それだけではありません。
- そうですが、それだけではありません。
- 正解です。ファイル名はシングルクォート（`'`）またはダブルクォート（`"`）で囲むことができます。
- 残念ながら違います。

---

## 1 回のループで多くのことを行うにはどうすればよいですか？

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

これまで見てきたループは、本文に 1 つのコマンドまたはパイプラインしか含んでいませんでしたが、ループにはいくつでもコマンドを入れられます。
どこで 1 つが終わり、次が始まるかをシェルに伝えるには、セミコロンで区切る必要があります。

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

前のループで `echo` と `head` のコマンドの間のセミコロンを入れ忘れて、
次のようにシェルに実行させたとします。

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

シェルは何をするでしょうか？

`@possible_answers`
- エラーメッセージを表示する。
- 4 つのファイルそれぞれについて 1 行を表示する。
- `autumn.csv`（最初のファイル）について 1 行を表示する。
- 各ファイルの最後の行を表示する。

`@hint`
`echo` の出力を `tail` にパイプできます。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "いいえ: ループは実行されますが、意味のあることはしません。"
correct2 = "はい: `echo` はファイル名を2回含む1行を生成し、それを `tail` がコピーします。"
err3 = "いいえ: ループは4つのファイル名のそれぞれに対して1回実行されます。"
err4 = "いいえ: `tail` の入力は各ファイル名に対する `echo` の出力です。"
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

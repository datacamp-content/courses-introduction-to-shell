---
title: バッチ処理
description: >-
  ほとんどの shell
  コマンドは、一度に多くのファイルを処理できます。この章では、自分で作成するパイプラインでも同じことを実現する方法を紹介します。あわせて、shell
  が変数を使って情報を保存する仕組みについても見ていきます。
lessons:
  - nb_of_exercises: 10
    title: Shell はどのように情報を保存するのか
---

## シェルはどのように情報を保持しますか？

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

他のプログラムと同様に、シェルも情報を変数に保存します。
これらの一部は**環境変数**と呼ばれ、
常に利用可能です。
環境変数の名前は慣例的に大文字で書かれ、
よく使われるものの一部を以下に示します。

| 変数     | 用途                               | 値                     |
|----------|-----------------------------------|-----------------------|
| `HOME`   | ユーザーのホームディレクトリ         | `/home/repl`          |
| `PWD `   | 現在の作業ディレクトリ               | `pwd` コマンドと同じ値 |
| `SHELL`  | 使用中のシェルプログラム             | `/bin/bash`           |
| `USER`   | ユーザーの ID                       | `repl`                |

完全な一覧（かなり長いです）を取得するには、
シェルで `set` と入力しましょう。

<hr>

`set` と `grep` をパイプでつないで使用し、`HISTFILESIZE` の値を表示してみましょう。
この変数は、コマンド履歴に保存される過去のコマンドの数を決定します。
その値は何ですか?

`@possible_answers`
- 10
- 500
- [2000]
- その変数は存在しません。

`@hint`
必要な行を取得するには `set | grep HISTFILESIZE` を使用してください。

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

## 変数の値を表示するにはどうすればよいでしょうか？

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

変数の値を調べるもっと簡単な方法は、引数をそのまま表示する `echo` というコマンドを使うことです。これは引数を表示します。次のように入力すると

```{shell}
echo hello DataCamp!
```

次のように表示されます。

```
hello DataCamp!
```

次のように変数の値を表示しようとすると

```{shell}
echo USER
```

変数名である `USER` がそのまま表示されます。

変数の値を取得するには、変数名の前にドル記号 `$` を付ける必要があります。次のように入力すると

```{shell}
echo $USER
```

次のように表示されます。

```
repl
```

これはどの場合でも同じです。変数 `X` の値を取得するには `$X` と書く必要があります。これは、シェルが「X という名前のファイル」と「X という名前の変数の値」を区別できるようにするためです。

`@instructions`
変数 `OSTYPE` には、使用しているオペレーティングシステムの種類が格納されています。
`echo` を使ってその値を表示しましょう。

`@hint`
`echo`を前に付けた変数`OSTYPE`で`$`を呼び出します。

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

## 他にシェルはどのように情報を保存しているのでしょうか?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

もう一つの種類の変数は**シェル変数**と呼ばれ、プログラミング言語におけるローカル変数のようなものです。

シェル変数を作成するには、名前に値を代入するだけです。

```{shell}
training=seasonal/summer.csv
```

*`=`の前後に空白を入れずにしてください。
これを行ったら、次のように変数の値を確認できます。

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
`testing`という変数を`seasonal/winter.csv`の値で定義します。

`@hint`
変数名とその値の間に空白を入れてはなりません。

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
`head -n 1 SOMETHING`を使って`seasonal/winter.csv`の最初の行を取得します
ファイル名の名前の代わりに、変数`testing`の値を使ってください。

`@hint`
`$testing` ではなく、単に `testing` を使うのではないことを忘れないでください
（変数の値を取得するには `$` が必要です）。

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

## コマンドを何度も繰り返すにはどうすればよいですか?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

シェル変数は**ループ**でも使われます。
ループはコマンドを何度も繰り返し実行する仕組みです。
次のコマンドを実行すると:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

以下のような結果が出力されます。

```
gif
jpg
png
```

このループについて、次の点に注目してください。

1. 構造は `for` ...変数... `in` ...リスト... `; do` ...本体... `; done` となっています。
2. ループが処理する対象のリスト（この例では `gif`、`jpg`、`png` という単語）。
3. ループが現在処理している対象を保持する変数（この例では `filetype`）。
4. 実際の処理を行うループの本体（この例では `echo $filetype`）。

本体では、他のシェル変数と同様に、変数の値を取得するために `$filetype` ではなく `filetype` を使っている点に注目してください。
また、セミコロンの位置にも注目してください。
1つ目はリストとキーワード `do` の間に置かれ、
2つ目は本体とキーワード `done` の間に置かれます。

`@instructions`
次のように出力されるようにループを変更してください。

```
docx
odt
pdf
```

ループ変数の名前には `filetype` を使用してください。

`@hint`
導入文のコード構造を使用し、画像ファイルの種類をドキュメントファイルの種類に置き換えてください。

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

## 各ファイルに対してコマンドを1回ずつ繰り返すにはどうすればよいでしょうか？

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

ループを書くときに処理したいファイル名を直接指定することもできますが、通常はワイルドカードを使う方が便利です。
コンソールで次のループを実行してみましょう。

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

出力は次のとおりです。

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

これは、ループを実行する前にシェルが `seasonal/*.csv` を4つのファイル名のリストに展開するためです。

`@instructions`
ワイルドカード式を `people/*` に変更して、ループが `people` ディレクトリ内のファイル名を、拡張子の有無に関係なくすべて表示するようにしましょう。
ループ変数の名前には `filename` を使用してください。

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

## 一連のファイルの名前を記録するにはどうすればよいでしょうか？

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

人々は、ファイル名の一覧を記録するために、ワイルドカード式を使って変数を設定することがよくあります。
例えば、`datasets` を次のように定義した場合:

```{shell}
datasets=seasonal/*.csv
```

後で次のようにファイル名を表示できます。

```{shell}
for filename in $datasets; do echo $filename; done
```

これにより、入力の手間が省け、ミスも起こりにくくなります。

<hr>

ホームディレクトリで次の 2 つのコマンドを実行すると、出力は何行になりますか?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- なし: `files` は別の行で定義されているため、2行目には値がありません。
- 1つ目：「ファイル」という単語。
- 4つ: 4つの季節のデータファイルの名前。

`@hint`
`X`単独では単に「X」であり、`$X`は変数`X`の値であることを覚えておいてください。

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

## 変数の名前とその値

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

よくある間違いの一つは、変数名の前に `$` を付け忘れることです。
これを忘れると、シェルは変数の値ではなく、入力した名前そのものを使ってしまいます。

経験を積んだユーザーによく見られるもう一つの間違いは、変数名のスペルミスです。
たとえば、次のように `datasets` を定義したとします。

```{shell}
datasets=seasonal/*.csv
```

そして、次のように入力すると:

```{shell}
echo $datsets
```

シェルは何も出力しません。
なぜなら、`datsets`（2つ目の「a」がない状態）は定義されていないからです。

<hr>

もし、ホームディレクトリで次の2つのコマンドを実行した場合、
どのような出力が表示されるでしょうか。

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(答える前に、ループの最初の部分をよく確認してください。)

`@hint`
`X` はそのまま「X」という文字列を表しますが、`$X` は変数 `X` の値を表します。

`@possible_answers`
- [1行だけ表示される: 「files」という単語。]
- 4行表示される: 4つの季節データファイルすべての名前。
- 空白の行が4行表示される: 変数 `f` に値が割り当てられていないため。

`@feedback`
- 正解です。このループでは `files` ではなく `$files` を使っているため、リストは「files」という単語だけで構成されます。
- 不正解です。このループでは `files` ではなく `$files` を使っているため、リストは `files` の展開結果ではなく「files」という単語になります。
- 不正解です。変数 `f` は `for` ループによって自動的に定義されます。

---

## 1つのループで複数のコマンドを実行するにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

ファイル名を表示するのはデバッグに役立ちますが、ループ本来の目的は複数のファイルに対して処理を行うことです。
次のループは、各データファイルの2行目を出力します。

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

これは、これまでに見てきた他のループと同じ構造を持っています。異なるのは、本体が単一のコマンドではなく、2つのコマンドから成るパイプラインになっている点だけです。

`@instructions`
2017年7月(`2017-07`)の最後の記録をすべての季節ファイルに対して出力するループを書いてください。出力は以下のようになるはずです:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

ただし、**_それぞれの_**季節ファイルごとに別々に行ってください。ループ変数の名前には `file` を使い、ファイルのリスト `seasonal/*.csv` をループ処理することを忘れないでください（例の 'seasonal/winter.csv' の代わりに）。

`@hint`
ループの本体は指示文に示されている grep コマンドで、`seasonal/winter.csv` を `$file` に置き換えたものです。

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

## なぜファイル名にスペースを使わないのですか?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

グラフィカルなファイルエクスプローラーを使っているときは、`July 2017.csv` のような複数の単語からなるファイル名を付けるのは簡単で自然なことです。
しかし、シェルで作業する場合はこれが問題を引き起こします。
例えば、`July 2017.csv` の名前を `2017 July data.csv` に変更したいとします。
次のようには入力できません。

```{shell}
mv July 2017.csv 2017 July data.csv
```

これでは、シェルには `July`、`2017.csv`、`2017`、`July`（再び）という4つのファイルを `data.csv` というディレクトリに移動しようとしているように見えてしまいます。
そのため、シェルが各ファイル名を1つのパラメータとして扱うように、ファイル名をクォートで囲む必要があります。

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

`current.csv` と `last year.csv`（名前にスペースが含まれる）という2つのファイルがあるとして、次のように入力した場合：

```{shell}
rm current.csv last year.csv
```

何が起こるでしょうか？

`@hint`
誰かがこのコマンドを見せてきて、しかもどんなファイルが存在するのか分からないとしたら、何が起こると思いますか？

`@possible_answers`
- `last` と `year.csv` が存在しないため、シェルはエラーメッセージを表示します。
- シェルは `current.csv` を削除します。
- [上記の両方。]
- なし。

`@feedback`
- はい、でもそれだけではありません。
- はい、でもそれだけではありません。
- そのとおりです。ファイル名はシングルクォート、`'`、またはダブルクォート、`"`、で囲むことができます。
- 残念ながら違います。

---

## 1つのループで複数の処理を行うにはどうすればよいですか？

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

ここまで見てきたループは、本体に単一のコマンドまたはパイプラインを含むものでした。
しかし、ループにはいくつでもコマンドを含めることができます。
シェルに、1つのコマンドがどこで終わり、次のコマンドがどこから始まるかを伝えるには、
それらをセミコロンで区切らなければなりません。

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

前のループで `echo` コマンドと `head` コマンドの間のセミコロンを忘れたとしましょう。
すると、シェルに次のように実行させることになります。

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

シェルはどうするでしょうか？

`@possible_answers`
- エラーメッセージを出力する。
- 4つのファイルそれぞれについて1行ずつ表示する。
- `autumn.csv`（最初のファイル）について1行だけ表示する。
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

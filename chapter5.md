---
title: 新しいツールの作成
description: >-
  ヒストリー機能を使えば、数回のキー入力で処理を繰り返せますし、パイプを使えば既存のコマンドを組み合わせて新しい処理を作れます。この章では、さらに一歩進めて、自分自身の新しいコマンドを作成する方法を学びます。
lessons:
  - nb_of_exercises: 9
    title: ファイルを編集するには？
---

## ファイルはどうやって編集できますか？

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix には多種多様なテキストエディタがあります。
このコースでは、Nano というシンプルなエディタを使います。
`nano filename` と入力すると、
`filename` が編集用に開きます
（まだ存在しない場合は新規作成されます）。
矢印キーで移動でき、
バックスペースで文字を削除できます。
そのほかの操作は Ctrl キーとの組み合わせで行います。

- `Ctrl` + `K`: 行を削除します。
- `Ctrl` + `U`: 行の削除を元に戻します。
- `Ctrl` + `O`: ファイルを保存します（'O' は 'output' の意味）。_ファイル名の確認で Enter を押す必要があります！_
- `Ctrl` + `X`: エディタを終了します。

`@instructions`
ホームディレクトリで新しいファイルを編集するために、`nano names.txt` を実行し、次の4行を入力します。

```
Lovelace
Hopper
Johnson
Wilson
```

入力した内容を保存するには、
`Ctrl` + `O` で書き出し、
Enter でファイル名を確認し、
その後 `Ctrl` + `X` でエディタを終了します。

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
patt = "ファイル `names.txt` に行 `%s` を含めましたか？再度 `nano names.txt` を使用してファイルを更新してください。`Ctrl` + `O` で保存し、`Ctrl` + `X` で終了します。"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("よくできました！次に進みましょう！")
```

---

## いま実行した作業を記録するには？

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

複雑な分析をしていると、実行したコマンドを記録しておきたくなることがよくあります。
これまでに見てきたツールだけで、次のように実現できます。

1. `history` を実行します。
2. その出力を `tail -n 10`（保存したい直近の手順数に合わせて変更）にパイプします。
3. それを `figure-5.history` のような名前のファイルにリダイレクトします。

これは実験ノートに手で書くよりも確実で、手順の抜け漏れがありません。
また、シェルの中心的な考え方も示しています。
テキスト行を出力し、テキスト行を入力として受け取るシンプルなツールは、
さまざまな組み合わせでつなぎ合わせることで、幅広い問題を解くことができます。

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
`seasonal/spring.csv` と `seasonal/summer.csv` をホームディレクトリにコピーしてください。

`@hint`
`cp` でコピーし、ホームディレクトリへの近道として `~` を使います。

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="`cp seasonal/s* ~` を使用して、必要なファイルをホームディレクトリにコピーしましたか？"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("素晴らしい記録管理です！もしコマンドを誤って入力した場合は、後で `nano` を使用して保存履歴ファイルを整理することができます。")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
`grep` を `-h` フラグ（ファイル名を表示しない）と `-v Tooth`（ヘッダー行に一致する行を除外）で使い、
その順序で `spring.csv` と `summer.csv` からデータレコードを抽出し、出力を `temp.csv` にリダイレクトしてください。

`@hint`
フラグはファイル名の前に置きます。

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "「grep」コマンドの出力を「>」を使って「temp.csv」にリダイレクトしていることを確認してください！"
msg2 = "「grep -h -v ___ ___ ___」を使用して「temp.csv」を作成しましたか？（空欄を埋めてください）"
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
`history` を `tail -n 3` にパイプし、出力を `steps.txt` にリダイレクトして、直近3つのコマンドをファイルに保存してください。
（`history` 自身の実行もリストに含まれるため、2つではなく3つを保存する必要があります。）

`@hint`
リダイレクトの `>` は、パイプでつないだコマンド列の最後に書くことを忘れないでください。

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="コマンドの出力を `steps.txt` にリダイレクトすることを確認してください。"
msg2="`history | tail ___ ___`（空欄を埋めてください）を使用して `steps.txt` を作成しましたか？"
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
Ex().success_msg("よくできました！次のステップに進みましょう！")
```

---

## 後で再実行するためにコマンドを保存するには？

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

これまでは対話的にシェルを使ってきました。
しかし、入力するコマンドは単なるテキストなので、
シェルに何度でも実行させるためにファイルに保存できます。
この強力な機能の第一歩として、
次のコマンドを `headers.sh` という名前のファイルに入れてください。

```{shell}
head -n 1 seasonal/*.csv
```

このコマンドは、`seasonal` ディレクトリ内の各CSVファイルから最初の行を取り出します。
ファイルを作成したら、次のように入力して実行できます。

```{shell}
bash headers.sh
```

これは、シェル（`bash` というプログラムです）に、
`headers.sh` ファイルに含まれるコマンドを実行するよう指示するもので、
コマンドを直接実行したときと同じ出力が得られます。

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
`nano dates.sh` を使って `dates.sh` というファイルを作成し、
次のコマンドを含めてください。

```{shell}
cut -d , -f 1 seasonal/*.csv
```

これにより、`seasonal` 内のすべてのCSVファイルから最初の列を抽出します。

`@hint`
余計な空行やスペースを入れずに、表示されたコマンドをそのままファイルに書き込みます。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "ファイル `dates.sh` に行 `cut -d , -f 1 seasonal/*.csv` を含めましたか？再度 `nano dates.sh` を使用してファイルを更新してください。`Ctrl` + `O` で保存し、`Ctrl` + `X` で終了します。"
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
`bash` を使って `dates.sh` ファイルを実行してください。

`@hint`
ファイルを実行するには `bash filename` を使います。

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
      has_code("bash", incorrect_msg = '`bash`を呼び出しましたか？'),
      has_code("dates.sh", incorrect_msg = '`dates.sh`ファイルを指定しましたか？')
    )
  )
)
```

---

## パイプを再利用するには？

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

シェルコマンドを書き込んだファイルは、***シェルスクリプト**（shell script）と呼ばれ、短く「スクリプト」と呼ぶこともあります。スクリプトの名前は `.sh` で終わる必要はありませんが、このレッスンではどのファイルがスクリプトか見分けやすくするために、その慣例に従います。

スクリプトにはパイプも含めることができます。たとえば、`all-dates.sh` に次の行が含まれているとします:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

その場合は次のようにします:

```{shell}
bash all-dates.sh > dates.out
```

これで季節データファイルから日付の重複を取り除いて抽出し、`dates.out` に保存します。

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
ホームディレクトリにある `teeth.sh` ファイルが用意されていますが、いくつか空欄があります。Nano を使ってファイルを編集し、2 つの `____` プレースホルダーを `seasonal/*.csv` と `-c` に置き換えて、このスクリプトが `seasonal` ディレクトリ内の CSV ファイルに現れる各歯の名前の出現回数を集計して表示するようにしてください。

`@hint`
`nano teeth.sh` を使ってファイルを編集します。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="`teeth.sh` 内のコマンドが `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c` として正しく空欄を埋めましたか？ 必要な変更を加えるために再度 `nano teeth.sh` を使用してください。"
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
`bash` で `teeth.sh` を実行し、`>` を使ってその出力を `teeth.out` にリダイレクトします。

`@hint`
`> teeth.out` は、出力を生成するコマンドの「後ろ」に置く必要があることを思い出してください。

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="`bash teeth.sh` の結果を `>` を使って `teeth.out` に正しくリダイレクトしましたか？"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = '`bash` を呼び出しましたか？'),
      has_code("bash\s+teeth.sh", incorrect_msg = '`teeth.sh` ファイルを実行しましたか？'),
      has_code(">\s+teeth.out", incorrect_msg = '`teeth.out` ファイルにリダイレクトしましたか？')
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
`cat teeth.out` を実行して結果を確認します。

`@hint`
ファイル名の最初の数文字を入力して、Tab キーを押すと自動補完できます。

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
      has_code("cat", incorrect_msg = '`cat`を呼び出しましたか？'),
      has_code("teeth.out", incorrect_msg = '`teeth.out`ファイルを指定しましたか？')
    )
  )
)
Ex().success_msg("素晴らしいです！最初は不自然に感じるかもしれませんが、素晴らしいことに、ワークフローの一部を一歩一歩自動化しています。データサイエンティストとして非常に役立つことです！")
```

---

## スクリプトにファイル名を渡すには？

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

特定のファイルを処理するスクリプトは、自分が何をしたかの記録として便利ですが、任意のファイルを処理できるスクリプトのほうがさらに有用です。
これを実現するには、特別な表現 `$@`（ドル記号の直後にアットマーク）を使って、
「スクリプトに与えられたすべてのコマンドライン引数」を表せます。

たとえば、`unique-lines.sh` に `sort $@ | uniq` と書いておき、次を実行すると:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

シェルは `$@` を `seasonal/summer.csv` に置き換え、1 つのファイルを処理します。次を実行すると:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

2 つのデータファイルを処理し、このように続けていけます。

_補足: Nano で書いた内容を保存するには、`Ctrl` + `O` で書き出し、Enter でファイル名を確定し、その後 `Ctrl` + `X` でエディタを終了します。_

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
Nano でスクリプト `count-records.sh` を開き、2 つの `____` プレースホルダーをそれぞれ `$@` と `-l`（文字）で埋めて、1 つ以上のファイルについて先頭行を除いた行数を数えられるようにしてください。

`@hint`
* `nano count-records.sh` でそのファイルを編集します。
* 数字の 1 ではなく、必ず「文字」の `-l` を指定してください。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="`count-records.sh` のコマンドが `tail -q -n +2 $@ | wc -l` となるように空欄を適切に埋めましたか？再度 `nano count-records.sh` を使用して必要な変更を行ってください。"
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
`seasonal/*.csv` に対して `count-records.sh` を実行し、`>` を使って出力を `num-records.out` にリダイレクトしてください。

`@hint`
出力のリダイレクトには `>` を使います。

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
      has_code("bash", incorrect_msg = '`bash`を呼び出しましたか？'),
      has_code("bash\s+count-records.sh", incorrect_msg = '`count-records.sh`ファイルを実行しましたか？'),
      has_code("seasonal/\*", incorrect_msg = '`seasonal/*`で処理するファイルを指定しましたか？'),
      has_code(">\s+num-records.out", incorrect_msg = '`num-records.out`ファイルにリダイレクトしましたか？')
    )
  )
)
Ex().success_msg("よくできました！あなたのシェルの力はますます拡大しています！")
```

---

## 単一の引数をどのように処理できますか？

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

`$@` に加えて、
シェルでは特定のコマンドライン引数を指すために `$1`、`$2` などを使えます。
これを使うと、シェルの書き方よりも直感的でシンプルなコマンドを書くことができます。
たとえば、ユーザーが最初の引数にファイル名、2番目に列番号を渡すと、CSV から単一の列を抽出するスクリプト `column.sh` を作成できます。

```{shell}
cut -d , -f $2 $1
```

そして次のように実行します。

```{shell}
bash column.sh seasonal/autumn.csv 1
```

このスクリプトが 2 つの引数を逆順で使っている点に注目してください。

<hr>

スクリプト `get-field.sh` は、ファイル名、
抽出する行番号、
抽出する列番号を受け取り、
CSV ファイルからそのフィールドだけを出力する想定です。
たとえば次のコマンドは、

```
bash get-field.sh seasonal/summer.csv 4 2
```

`seasonal/summer.csv` の 4 行目の 2 番目のフィールドを選ぶはずです。
それを実現するには、`get-field.sh` に次のどのコマンドを入れるべきでしょうか。

`@hint`
コマンドライン引数は、左から右へ順番に番号が振られていることを思い出してください。

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- いいえ：それでは、`head` で選ぶ行数としてファイル名を使おうとしてしまいます。
- 正解です！
- いいえ：それでは、列番号を行番号として、行番号を列番号として使おうとしてしまいます。
- いいえ：それでは、フィールド番号をファイル名として、ファイル名をフィールド番号として使おうとしてしまいます。

---

## 1つのシェルスクリプトで多くのことを行うには？

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

これまでのシェルスクリプトは単一のコマンドやパイプだけでしたが、スクリプトには複数行のコマンドを含めることができます。たとえば、各データファイルのうち最短と最長のレコード数（つまり、データセットの長さの範囲）を教えてくれるスクリプトを作成できます。

なお、Nano では「コピー＆ペースト」は、コピーしたい行に移動してから `CTRL` + `K` で行を切り取り、その後 `CTRL` + `U` を2回押して2回貼り付けます。

_念のためのリマインダーとして、Nano で書いた内容を保存するには、`Ctrl` + `O` でファイルを書き出し、Enter でファイル名を確定し、`Ctrl` + `X` でエディタを終了します。_

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
Nano を使って `range.sh` スクリプトを編集し、2つの `____` プレースホルダーを `$@` と `-v` に置き換えて、コマンドラインで与えられたすべてのファイルの名前と行数を一覧表示し、かつ全ファイルの合計行数は表示しないようにしてください。（列見出し行を引き算しようとはしないでください。）

`@hint`
コマンドラインで指定されたすべてのファイルの行数を数えるには、`wc -l $@` を使います。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="`range.sh` のコマンドが `wc -l $@ | grep -v total` と正しくなるように空欄を埋めましたか？再度 `nano range.sh` を使用して必要な変更を行ってください。"
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
もう一度 Nano を使って、`range.sh` のパイプラインにこの順序で `sort -n` と `head -n 1` を追加し、与えられた中で最も短いファイルの名前と行数を表示してください。

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="`sort -n` と `head -n 1` をパイプでつないで `range.sh` ファイルに追加しましたか？ `nano range.sh` を再度使用して、必要な変更を行ってください。"
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
同様に Nano を使って、ディレクトリ内で最短だけでなく、最長のファイルの名前とレコード数も表示するように `range.sh` に2行目を追加してください。この行はすでに書いた行の複製ですが、`sort -n` の代わりに `sort -n -r` を使います。

`@hint`
最初の行をコピーして、ソート順を変更してください。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="`range.sh`ファイルの最初の行を保持してください: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="`range.sh`の最初の行を複製し、小さな変更を加えましたか？`sort -n`の代わりに`sort -n -r`を使用してください！"
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
`seasonal` ディレクトリ内のファイルに対してスクリプトを実行し、`seasonal/*.csv` で全ファイルにマッチさせ、出力は `>` を使ってホームディレクトリ内の `range.out` というファイルにリダイレクトしてください。

`@hint`
スクリプトの実行には `bash range.sh`、ファイル指定には `seasonal/*.csv`、出力のリダイレクトには `> range.out` を使います。

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="`bash range.sh seasonal/*.csv` の結果を `>` を使って `range.out` に正しくリダイレクトしましたか？"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = ' `bash` を呼び出しましたか？'),
has_code("bash\s+range.sh", incorrect_msg = ' `range.sh` ファイルを実行しましたか？'),
has_code("seasonal/\*", incorrect_msg = ' `seasonal/*` で処理するファイルを指定しましたか？'),
has_code(">\s+range.out", incorrect_msg = ' `range.out` ファイルにリダイレクトしましたか？')
)
)

Ex().success_msg("順調です。次の演習に進んで、ループの書き方を学びましょう！")
```

---

## シェルスクリプトでループを書くには？

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

シェルスクリプトにはループも書けます。セミコロンを使って1行で書くこともできますし、読みやすくするためにセミコロンなしで複数行に分けて書くこともできます。

```{shell}
# 各ファイルの最初と最後のデータ行を表示します。
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

（ループ内のコマンドは字下げしなくても動きますが、インデントすると見やすくなります。）

このスクリプトの最初の行は、スクリプトが何をするかを読者に伝えるための**コメント**です。コメントは `#` で始まり、その行の終わりまで続きます。ここで示したような簡潔な説明を、作成するすべてのスクリプトに付けておくと、将来の自分が助かります。

_念のためのリマインドです。Nano で書いた内容を保存するには、`Ctrl` + `O` でファイルを書き出し、Enter でファイル名を確定し、`Ctrl` + `X` でエディタを終了します。_

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
スクリプト `date-range.sh` のプレースホルダーを、`$filename`（2回）、`head`、`tail` で埋めて、1つ以上のファイルから最初と最後の日付を表示するようにしましょう。

`@hint`
ループ変数の現在の値を得るには `$filename` を使うことを思い出してください。

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="`date-range.sh` で、ループ内の %s 行を `%s` に変更しましたか？ `nano date-range.sh` を使用して変更を行ってください。"
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('最初の', cmdpatt%'head')
msg2=msgpatt%('2 番目の', cmdpatt%'tail')
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
`seasonal/*.csv` を使って名前にマッチさせ、4つすべての季節データファイルに対して `date-range.sh` を実行してください。

`@hint`
ワイルドカード式はディレクトリ名から始めてください。

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
      has_code("bash", incorrect_msg = '「bash」を呼び出しましたか？'),
      has_code("bash\s+date-range.sh", incorrect_msg = '「date-range.sh」ファイルを実行しましたか？'),
      has_code("seasonal/\*", incorrect_msg = '「seasonal/*」で処理するファイルを指定しましたか？')
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
`seasonal/*.csv` を使って4つすべての季節データファイルに対して `date-range.sh` を実行し、その出力を `sort` にパイプして、作成したスクリプトが Unix の組み込みコマンドと同じように使えることを確かめてください。

`@hint`
先ほど使ったものと同じワイルドカード式を使ってください。

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
      has_code("bash", incorrect_msg = '「bash」を呼び出しましたか？'),
      has_code("bash\s+date-range.sh", incorrect_msg = '「date-range.sh」ファイルを実行しましたか？'),
      has_code("seasonal/\*", incorrect_msg = '「seasonal/*」で処理するファイルを指定しましたか？'),
      has_code("|", incorrect_msg = 'スクリプトの出力を「sort」にパイプしましたか？'),
      has_code("sort", incorrect_msg = '「sort」を呼び出しましたか？')
    )
  )
)
Ex().success_msg("素晴らしいです！これまで学んだことがどれほど組み合わせ可能であるかに注目してください。")
```

---

## ファイル名を指定しないとどうなりますか？

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

シェルスクリプト（や対話的なコマンド）でよくあるミスは、ファイル名を置く場所を間違えることです。
次のように入力すると、

```{shell}
tail -n 3
```

`tail` にはファイル名が渡されていないので、キーボードからの入力を待ち続けます。
つまり、次を入力すると、

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

`tail` は `somefile.txt` の末尾3行をそのまま表示しますが、`head` はファイル名が指定されておらず、パイプラインの前段にも何もないため、キーボード入力を永遠に待ち続けます。

<hr>

もし誤って次のように入力してしまったとします。

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

次に何をすればよいでしょうか？

`@possible_answers`
- `head` がタイムアウトするまで10秒待つ。
- `somefile.txt` と入力して Enter を押し、`head` に入力を与える。
- 実行中の `head` プログラムを停止するために `Ctrl` + `C` を使う。

`@hint`
`head` にファイル名がなく、かつ上流から何も流れてこない場合、`head` は何をしますか？

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'いいえ、コマンドはタイムアウトしません。'
a2 = 'いいえ、それでは `head` に `somefile.txt` というテキストを処理させることになりますが、その後さらに入力を待ってハングアップします。'
a3 = "はい！ 実行中のプログラムを停止するには `Ctrl` + `C` を使用する必要があります。これでこの入門コースは終了です！ さらにコマンドラインツールを学びたい場合は、無料のGit入門コースを強くお勧めします！"
Ex().has_chosen(3, [a1, a2, a3])
```

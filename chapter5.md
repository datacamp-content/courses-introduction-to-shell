---
title: 新しいツールの作成
description: >-
  履歴機能を使えば、数回のキー入力で操作を繰り返すことができ、パイプを使えば既存のコマンドを組み合わせて新しいコマンドを作成できます。この章では、さらに一歩進んで独自のコマンドを作成する方法を学びます。
lessons:
  - nb_of_exercises: 9
    title: ファイルをどうやって編集できますか?
---

## ファイルをどうやって編集できますか?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix にはさまざまなテキストエディタが存在し、その数の多さに戸惑うかもしれません。
このコースでは、Nano というシンプルなエディタを使用します。
`nano filename` と入力すると、`filename` を編集用に開きます
（ファイルが存在しない場合は新規作成します）。
矢印キーでカーソルを移動でき、
バックスペースで文字を削除できます。
そのほかの操作は、コントロールキーの組み合わせで行います。

- `Ctrl` + `K`：行を削除します。
- `Ctrl` + `U`：削除した行を元に戻します。
- `Ctrl` + `O`：ファイルを保存します（O は「出力」の頭文字です）。 _ファイル名を確定するためにエンターキーを押す必要もあります。_
- `Ctrl` + `X`：エディタを終了します。

`@instructions`
`nano names.txt` を実行して、ホームディレクトリに新しいファイルを作成し、
次の 4 行を入力しましょう。

```
Lovelace
Hopper
Johnson
Wilson
```

入力した内容を保存するには、
`Ctrl` + `O` と入力してファイルを書き出し、
エンター キーを押してファイル名を確定し、
最後に `Ctrl` + `X` を押してエディタを終了しましょう。

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

## どうすれば、今行ったことの履歴を記録できますか？

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

複雑な分析を行うときは、
使用したコマンドの記録を残しておきたいことがよくあります。
これまでに学んだツールを使えば、次の方法で実現できます。

1. `history` を実行します。
2. その出力を `tail -n 10`（保存したい直近のステップ数に応じて）にパイプで渡します。
3. その結果を `figure-5.history` のような名前のファイルにリダイレクトします。

この方法は、実験ノートに手書きで記録するよりも優れています。
なぜなら、どのステップも漏れなく記録できることが保証されているからです。
また、これはシェルの中心的な考え方をよく表しています。
つまり、テキストの行を生成・処理するシンプルなツールを
さまざまな形で組み合わせることで、
幅広い問題を解決できるということです。

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
ファイル `seasonal/spring.csv` と `seasonal/summer.csv` をホームディレクトリにコピーしてください。

`@hint`
コピーには `cp` を、ホームディレクトリへのパスのショートカットとして `~` を使ってください。

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
`grep` に `-h` フラグ（ファイル名を表示しないようにするため）と
`-v Tooth` フラグ（ヘッダー行に一致*しない*行を選択するため）を付けて使い、
`spring.csv` と `summer.csv` からこの順番でデータレコードを選択し、
その出力を `temp.csv` にリダイレクトしましょう。

`@hint`
ファイル名の前にフラグを指定してください。

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
`history` を `tail -n 3` にパイプでつなぎ、
その出力を `steps.txt` にリダイレクトして、
直近3つのコマンドをファイルに保存しましょう。
（2つではなく3つ保存する必要があるのは、
`history` コマンド自体もリストに含まれるためです。）

`@hint`
`>` によるリダイレクトは、パイプでつないだコマンドの並びの最後に置くことを忘れないでください。

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

## コマンドを保存して、後で再実行するにはどうすればよいでしょうか？

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

これまでは、シェルを対話的に使ってきました。
しかし、入力するコマンドは単なるテキストなので、ファイルに保存しておけば、何度でも実行できます。
この強力な機能を試すために、次のコマンドを `headers.sh` というファイルに保存しましょう。

```{shell}
head -n 1 seasonal/*.csv
```

このコマンドは、`seasonal` ディレクトリ内の各 CSV ファイルから最初の行を選択します。
ファイルを作成したら、次のように入力して実行できます。

```{shell}
bash headers.sh
```

これは、シェル（`bash` という名前のプログラムにすぎません）に対して、`headers.sh` ファイルに含まれるコマンドを実行するよう指示しています。直接コマンドを実行した場合と同じ出力が得られます。

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
`nano dates.sh` を使って `dates.sh` という名前のファイルを作成し、そのファイルに次のコマンドを含めてください。

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`seasonal` 内のすべての CSV ファイルから最初の列を抽出するためのものです。

`@hint`
表示されているコマンドを、余分な空行やスペースを入れずにファイルに記述してください。

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
`bash`を使ってファイル`dates.sh`を実行してください。

`@hint`
`bash filename` を使ってファイルを実行します。

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

## パイプを再利用するには?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

シェルコマンドを詰め込んだファイルは***シェルスクリプト**、または単に「スクリプト」と呼ばれます。スクリプト自体の名前が必ずしも `.sh` で終わる必要はありませんが、
このレッスンではどのファイルがスクリプトかを分かりやすくするために、この規則を使います。

スクリプトにはパイプを含めることもできます。
例えば、`all-dates.sh` に次の行が含まれているとします。

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

この場合、

```{shell}
bash all-dates.sh > dates.out
```

を実行すると、季節データファイルから重複のない日付が抽出され、`dates.out` に保存されます。

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
ホームディレクトリに用意されている `teeth.sh` には、いくつかの空欄があります。
Nano を使ってこのファイルを編集し、2つの `____` プレースホルダーをそれぞれ `seasonal/*.csv` と `-c` に置き換えましょう。
こうすることで、このスクリプトは `seasonal` ディレクトリ内の CSV ファイルに含まれる歯の名前ごとの出現回数を表示します。

`@hint`
`nano teeth.sh` を使ってファイルを編集してください。

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
`bash`を使って`teeth.sh`を実行し、`>`を使って出力を`teeth.out`にリダイレクトします。

`@hint`
`> teeth.out` は、出力を生成するコマンドの*後*に置く必要があることを覚えておきましょう。

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
`cat teeth.out` を実行して、結果を確認してください。

`@hint`
ファイル名の最初の数文字を入力してからTabキーを押すと、自動的に補完できることを覚えておきましょう。

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

## スクリプトにファイル名を渡すにはどうすればよいでしょうか？

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

特定のファイルを処理するスクリプトは、実行内容の記録として役立ちます。しかし、任意のファイルを処理できるスクリプトのほうが、さらに便利です。
これを実現するには、特殊な表現である `$@`（ドル記号の直後にアットマークを続けたもの）を使います。これは「スクリプトに渡されたすべてのコマンドラインパラメータ」を意味します。

例えば、`unique-lines.sh` に `sort $@ | uniq` と書かれている場合、次のように実行すると:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

シェルは `$@` を `seasonal/summer.csv` に置き換え、1つのファイルを処理します。次のように実行すると:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

2つのデータファイルを処理します。ファイルの数が増えても同様です。

_念のため、Nano で書いた内容を保存するには、`Ctrl` + `O` を押してファイルを書き出し、Enter キーでファイル名を確定してから、`Ctrl` + `X` でエディタを終了してください。_

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
Nanoでスクリプト`count-records.sh`を編集し、2つの`____`プレースホルダーを
それぞれ`$@`と`-l`(_the letter_)で埋めて、1つ以上のファイルの行数を
各ファイルの先頭行を除いて数えるようにします。

`@hint`
* `nano count-records.sh` を使ってファイル名を編集してください。
* 指定するのは _文字_ `-l` であり、数字の 1 ではないことを確認してください。

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
`count-records.sh`を`seasonal/*.csv`に対して実行し、出力を`num-records.out`にリダイレクトするために`>`を使用してください。

`@hint`
出力をリダイレクトするには `>` を使用してください。

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

## 1つの引数を処理するにはどうすればよいでしょうか？

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

`$@` と同様に、シェルでは `$1`、`$2` などを使って特定のコマンドラインパラメータを参照できます。
これを使うと、シェル自体よりも簡潔で自然に感じられるコマンドを書くことができます。
例えば、ユーザーが最初のパラメータとしてファイル名、2番目のパラメータとして列を指定すると、
CSVファイルから1つの列を選択する `column.sh` というスクリプトを作成できます。

```{shell}
cut -d , -f $2 $1
```

そして、次のように実行します。

```{shell}
bash column.sh seasonal/autumn.csv 1
```

このスクリプトでは、2つのパラメータを逆の順序で使っている点に注目してください。

<hr>

次のスクリプト `get-field.sh` は、ファイル名、選択する行の番号、選択する列の番号を受け取り、
CSVファイルからそのフィールドだけを出力することを目的としています。
例えば、

```
bash get-field.sh seasonal/summer.csv 4 2
```

は、`seasonal/summer.csv` の4行目から2番目のフィールドを選択するはずです。
これを実現するには、`get-field.sh` に次のうちどのコマンドを記述すればよいでしょうか？

`@hint`
コマンドラインパラメータは左から右へ番号が振られることを思い出しましょう。

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- いいえ：それではファイル名を、で選択する行数として使用しようとします。`head`。
- 正解!
- いいえ：それでは列番号を行番号として、またその逆として使用することになります。
- いいえ：それではフィールド番号をファイル名として、またその逆として使用することになります。

---

## 1つのシェルスクリプトでどうやって多くのことを行えるのでしょうか？

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

これまでのシェルスクリプトには、単一のコマンドやパイプしか含まれていませんでした。しかし、スクリプトには複数行のコマンドを含めることができます。たとえば、データファイルの中で最も短いものと最も長いもののレコード数、つまりデータセットの長さの範囲を調べるスクリプトを作成できます。

Nano では、コピーしたい行に移動し、`CTRL` + `K` で行を切り取った後、`CTRL` + `U` を2回押すことで、その行を2つ貼り付けることができます。これが Nano における「コピー＆ペースト」の方法です。

_確認しておくと、Nano で書いた内容を保存するには、`Ctrl` + `O` を押してファイルを書き出し、エンター キーでファイル名を確定し、`Ctrl` + `X` でエディタを終了します。_

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
Nano を使ってスクリプト `range.sh` を編集し、2つの `____` プレースホルダーを `$@` と `-v` に置き換えてください。これにより、コマンドラインで指定したすべてのファイルの名前と行数を一覧表示しつつ、全ファイルの合計行数は*表示しない*ようにします。（各ファイルの列見出し行を差し引く必要はありません。）

`@hint`
コマンドラインで指定したすべてのファイルの行数を数えるには、`wc -l $@` を使用してください。

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
再び Nano を使って、`sort -n` と `head -n 1` をこの順序で
`range.sh` のパイプラインに追加し、
それに与えられた最短のファイルの名前と行数を表示します。

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
再び Nano を使って、`range.sh` に2行目を追加し、ディレクトリ内で最も長いファイルの名前とレコード数を、*最も短い*ファイルと*同様に*表示できるようにしましょう。この行は、すでに書いた行を複製し、`sort -n -r` の代わりに `sort -n` を使うようにします。

`@hint`
最初の行をコピーしてソート順を変更します。

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
`seasonal` ディレクトリ内のファイルに対してスクリプトを実行し、`seasonal/*.csv` を使ってすべてのファイルに一致させ、`>` を使って出力をホームディレクトリの `range.out` というファイルにリダイレクトします。

`@hint`
`bash range.sh`でスクリプトを実行し、`seasonal/*.csv`でファイルを指定し、`> range.out`で出力をリダイレクトします。

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

## シェルスクリプトでループを書くにはどうすればよいですか？

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

シェルスクリプトにはループも記述できます。セミコロンを使って一行で書くこともできますが、セミコロンを使わずに複数行に分けて書くと読みやすくなります。

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

（ループ内のコマンドをインデントする必要はありませんが、インデントすると内容が分かりやすくなります。）

このスクリプトの最初の行は、スクリプトの内容を読み手に伝える**コメント**です。コメントは `#` 文字で始まり、その行の末尾まで続きます。このような簡単な説明をスクリプトごとに追加しておくと、後で見直すときに自分自身が助かります。

_確認: Nano で書いた内容を保存するには、`Ctrl` + `O` を押してファイルを書き出し、エンター キーでファイル名を確定し、`Ctrl` + `X` でエディタを終了します。_

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
スクリプト `date-range.sh` 内のプレースホルダーを `$filename`（2 か所）、`head`、`tail` で埋めて、1 つ以上のファイルから最初と最後の日付を表示できるようにしましょう。

`@hint`
ループ変数の現在の値を取得するには `$filename` を使うことを忘れないでください。

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
4つの季節データファイルすべてで`date-range.sh`を実行し
名前に合わせるために`seasonal/*.csv`を使ってください。

`@hint`
ワイルドカード式はディレクトリ名から始める必要があります。

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
`date-range.sh` を使って名前を一致させ、季節データファイル 4 つすべてに対して `seasonal/*.csv` を実行し、その出力を `sort` にパイプしてください。これにより、自分で作成したスクリプトも Unix の組み込みコマンドと同じように使えることが分かります。

`@hint`
先ほど使ったものと同じワイルドカード式を使いましょう。

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

## ファイル名を指定しないとどうなりますか?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

シェルスクリプト（や対話的なコマンド）でよくある間違いは、ファイル名を間違った場所に置いてしまうことです。
次のように入力したとします。

```{shell}
tail -n 3
```

この場合、`tail` にはファイル名が渡されていないため、キーボードからの入力を待ち続けます。
つまり、次のように入力すると：

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

`tail` は `somefile.txt` の最後の3行をそのまま出力しますが、`head` はファイル名を指定されておらず、パイプラインの前段にも何もないため、キーボード入力を永遠に待ち続けます。

これは、コマンドの引数の位置を間違えると起こりがちな問題です。

<hr>

では、誤って次のように入力してしまったとします。

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

このとき、次に何をすればよいでしょうか。

`@possible_answers`
- `head` がタイムアウトするまで10秒待つ。
- `somefile.txt` と入力してエンター を押し、`head` に入力を与える。
- `Ctrl` + `C` を使って実行中の `head` を停止する。

`@hint`
ファイル名がなく、上流にも何もない場合、`head`はどうなるのでしょうか?

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

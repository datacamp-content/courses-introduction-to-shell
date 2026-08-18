---
title: ツールの組み合わせ
description: >-
  Unix Shell
  の真の力は、個々のコマンドそのものではなく、それらを簡単に組み合わせて新しいことを実現できる点にあります。この章では、この力を使って欲しいデータを選び出す方法を示し、さらに値を並べ替えたり重複を削除したりするコマンドを紹介します。
lessons:
  - nb_of_exercises: 12
    title: コマンドの出力をファイルに保存するにはどうすればよいですか？
---

## コマンドの出力をファイルに保存するにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

これまで見てきたツールはすべて、入力ファイルを指定できます。
しかし、その必要がないため、出力ファイルを指定するオプションを持たないものがほとんどです。
その代わりに、**リダイレクト**を使えば、任意のコマンドの出力を好きな場所に保存できます。
次のコマンドを実行すると:

```{shell}
head -n 5 seasonal/summer.csv
```

夏 データの最初の5行が画面に表示されます。
代わりに次のコマンドを実行すると:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

画面には何も表示されません。
その代わり、`head` の出力は `top.csv` という新しいファイルに書き込まれます。
このファイルの内容は `cat` を使って確認できます:

```{shell}
cat top.csv
```

不等号記号 `>` は、シェルに `head` の出力をファイルへリダイレクトするよう指示します。
これは `head` コマンド固有の機能ではなく、出力を生成するすべてのシェルコマンドで使用できます。

`@instructions`
`tail`とリダイレクトを組み合わせて、`seasonal/winter.csv`の最後の5行を`last.csv`というファイルに保存します。

`@hint`
最後の5行を取得するには `tail -n 5` を使用します。

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "行 `%s` はファイル `last.csv` にあるべきですが、ありません。`tail -n 5 seasonal/winter.csv` の出力を `>` を使って `last.csv` にリダイレクトしてください。"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` に行が多すぎます。`tail` に `-n 5` フラグを使用しましたか？'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("素晴らしいです！もう少し練習しましょう！")
```

---

## コマンドの出力を入力として使うにはどうすればよいですか？

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

ファイルの途中にある行を取得したいとします。
具体的には、データファイルの1つから3行目から5行目を取得したいとしましょう。
`head` を使って最初の5行を取得し、それをファイルにリダイレクトしてから、
そのファイルに対して `tail` を使って最後の3行を選択します:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

簡単に確認すると、これは元のファイルの3行目から5行目であり、
最初の5行のうち最後の3行だからです。

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
`seasonal/winter.csv` から最後の2行を選択し、
`bottom.csv` という名前のファイルに保存してください。

`@hint`
`tail` を使用して行を選択し、`>` を使用して `tail` の出力をリダイレクトします。

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="行 `%s` はファイル `bottom.csv` にあるべきですが、ありません。`tail -n 2 seasonal/winter.csv` の出力を `>` を使って `bottom.csv` にリダイレクトしてください。"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` に行が多すぎます。`tail` に `-n 2` フラグを使用しましたか？'),
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
元のファイルの最後から2番目の行を取得するために、`bottom.csv`
から最初の行を選択してください。

`@hint`
`head`を使って、必要な行を選択してください。

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="`bottom.csv`ファイルに何か問題があります。変更しないようにしてください！"),
    has_expr_output(strict=True, incorrect_msg="`bottom.csv`で`head`を正しく使用しましたか？`-n`フラグを正しく使用するようにしてください。")
)

Ex().success_msg("よくできました。次の演習に進んで、コマンドを組み合わせるより良い方法を見つけてください。")                             

```

---

## コマンドを組み合わせるもっと良い方法はありますか？

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

リダイレクトを使ってコマンドを組み合わせる方法には、2つの欠点があります。

1. `top.csv` のような中間ファイルが大量に残ってしまいます。
2. 最終結果を作成するためのコマンドが、履歴の複数行に分散してしまいます。

シェルには、この両方の問題を一度に解決するツールがあります。それが **パイプ** です。
まずはもう一度、`head` を実行してみましょう。

```{shell}
head -n 5 seasonal/summer.csv
```

今度は `head` の出力をファイルに送る代わりに、縦棒とファイル名を指定しない `tail` コマンドを追加します。

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

パイプ記号は、左側のコマンドの出力を右側のコマンドの入力として使うよう、シェルに指示します。

`@instructions`
`cut`を使って、カンマ区切りファイル`seasonal/summer.csv`の2列目からすべての歯名を選択し、結果を`grep`にパイプし、逆一致で「歯」という単語を含むヘッダー行を除外します。*`cut`と`grep`はそれぞれ第2章の演習8と11で詳細に扱われています。*

`@hint`
- コマンドの前半部分は `cut -d field_delimiter -f column_number filename` という形式になります。
- コマンドの後半部分は `grep -v thing_to_match` という形式になります。

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
    has_expr_output(incorrect_msg = '結果を `cut -d , -f 2 seasonal/summer.csv` から `grep -v Tooth` に `|` でパイプしましたか？'),
    check_not(has_output("Tooth"), incorrect_msg = '`grep` を使用して `"Tooth"` ヘッダー行を除外しましたか？')
)
Ex().success_msg("完璧なパイピングです！これが `|` を初めて使用したときかもしれませんが、これが最後ではありません！")
```

---

## 複数のコマンドを組み合わせるにはどうすればよいですか?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

いくつものコマンドを繋げることができます。
例えば、
このコマンド:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

ウィル:

1. スプリングデータから最初の列を選択する;
2. 「日付」という単語を含むヘッダー行を削除する;
3. 実際のデータの最初の10行を選択します。

`@instructions`
前回の演習では、`seasonal/summer.csv`の2列目からすべての歯名を選択するコマンドを使いました。

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

このパイプラインを`head`コマンドで拡張して、最初の歯の名前だけを選択してください。

`@hint`
指示のコードをコピーして貼り付け、パイプ記号「|」を追加し、その後 `head` を `-n` フラグ付きで呼び出します。

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
    has_output('^\s*canine\s*$', incorrect_msg = "パイプラインを `head` コマンドで拡張するために `|` を使用しましたか？ `-n` フラグを正しく設定してください。"),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "パイプラインを `head` コマンドで拡張するために `|` を使用しましたか？")
)
Ex().success_msg("楽しいチェーン！ 複数のコマンドを連鎖させることで、強力なデータ操作パイプラインを構築できます。")
```

---

## ファイル内のレコード数を数えるにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

コマンド`wc`(「ワードカウント」の略)は、ファイル内の**c**文字、**w**単語、**l**行の数を表示します。
`-c`、`-w`、`-l`をそれぞれ使うと、文字、単語、行のうち1つだけを表示できます。

`@instructions`
`seasonal/spring.csv` の中で、2017年7月（`2017-07`）の日付を含むレコードが何件あるか数えます。
- そのためには、`grep` で日付の一部を指定して該当行を抽出し、その結果を `wc` で行数を数えるための適切なフラグを付けてパイプでつなぎます。

`@hint`
- `head seasonal/spring.csv` を使って日付の形式を思い出してください。
- コマンドの前半部分は `grep thing_to_match filename` という形式になります。
- パイプの後に `|`、`wc` フラグを付けて `-l` を呼び出します。

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
      has_code("grep", incorrect_msg = "`grep`を呼び出しましたか？"),
      has_code("2017-07", incorrect_msg = "`2017-07`を検索しましたか？"),
      has_code("seasonal/spring.csv", incorrect_msg = "`seasonal/spring.csv`ファイルを検索しましたか？"),
      has_code("|", incorrect_msg = "`|`を使用して`wc`にパイプしましたか？"),      
      has_code("wc", incorrect_msg = "`wc`を呼び出しましたか？"),
      has_code("-l", incorrect_msg = "`-l`で行数を数えましたか？")
    )
  )
)
Ex().success_msg("慎重に数えましたね！データ分析の最初のステップとして、どれだけのデータがあるかを確認することは重要です。")
```

---

## 複数のファイルを一度に指定するにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

ほとんどのシェルコマンドは、複数のファイル名を指定すると複数のファイルに対して動作します。
例えば、次のようにすると、季節ごとのデータファイルすべてから最初の列を一度に取得できます。

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

しかし、多くのファイル名を何度も入力するのは良い方法ではありません。
時間の無駄になるうえ、いずれファイルを書き忘れたり、同じファイル名を重複して入力したりしてしまうでしょう。
こうした手間を減らすために、シェルでは**ワイルドカード**を使って、1 つの式で複数のファイルのリストを指定できます。
最もよく使われるワイルドカードは `*` で、「0 文字以上の任意の文字列に一致する」という意味です。
これを使うと、先ほどの `cut` コマンドは次のように短縮できます。

```{shell}
cut -d , -f 1 seasonal/*
```

または:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
`head`を使って最初の3行を`seasonal/spring.csv`と`seasonal/summer.csv`の両方から取得する単一のコマンドを書きます。合計6行のデータですが、秋や冬のデータファイルからは*得られません*。
ファイル名を完全に綴るのではなく、ワイルドカードを使いましょう。

`@hint`
- コマンドの形式は `head -n number_of_lines filename_pattern` です。
- 例えば、`a` のディレクトリ内で `b` で始まるファイルを `a/b*` を使って一致させることができます。

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
    has_expr_output(incorrect_msg = "季節/春.csv` と `季節/夏.csv` を選択するには `seasonal/s*` を使用できます。`-n` フラグを使用して各ファイルの最初の3行のみを含めるようにしてください！"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "季節/秋.csv` の出力を含めないでください。`季節/春.csv` と `季節/夏.csv` を選択するには `seasonal/s*` を使用できます"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "季節/冬.csv` の出力を含めないでください。`季節/春.csv` と `季節/夏.csv` を選択するには `seasonal/s*` を使用できます")
)
Ex().success_msg("ワイルドカードの作業がうまくいきました！ディレクトリに数百または数千のファイルが含まれている場合、これはさらに重要になります。")
```

---

## 他にどんなワイルドカードが使えますか？

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

シェルには他にもワイルドカードがありますが、
あまり頻繁には使われません:

- `?` は 1 文字に一致します。そのため `201?.txt` は `2017.txt` や `2018.txt` には一致しますが、`2017-01.txt` には一致しません。
- `[...]` は角括弧内のいずれか 1 文字に一致します。そのため `201[78].txt` は `2017.txt` や `2018.txt` に一致しますが、`2016.txt` には一致しません。
- `{...}` は波括弧内のカンマ区切りのパターンのいずれかに一致します。そのため `{*.txt, *.csv}` は `.txt` または `.csv` で終わるファイルに一致しますが、`.pdf` で終わるファイルには一致しません。

<hr/>

どの式が `singh.pdf` と `johel.txt` には一致するが、`sandhu.pdf` や `sandhu.txt` には一致しないでしょうか？

`@hint`
各式を各ファイル名と順番に照合します。

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- いいえ: `.pdf` と `.txt` はファイル名ではありません。
- いいえ: これは `sandhu.pdf` に一致します。
- いいえ: 角括弧内の式は 1 文字にのみ一致し、単語全体には一致しません。
- はい！

---

## テキストの行を並べ替えるにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

その名前が示すとおり、
`sort` はデータを並べ替えます。
デフォルトではアルファベット順の昇順で並べ替えますが、`-n` フラグと `-r` フラグを使うと、それぞれ数値として並べ替えたり、出力の順序を逆にしたりできます。
また、`-b` は先頭の空白を無視するよう指定し、`-f` は大文字・小文字を区別しない（フォールドケース）よう指定します。
パイプラインでは、`grep` で不要なレコードを取り除いてから `sort` で残ったレコードを並べ替えるという使い方がよく行われます。

`@instructions`
`cut` の列 2 からすべての歯の名前を選択するために `grep` と `seasonal/summer.csv` の組み合わせを覚えていますか。

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

このレシピを出発点として、`seasonal/winter.csv` の歯の名前を `summer.csv` ではなく、アルファベット順の降順で並べ替えてください。そのためには、パイプラインに `sort` ステップを追加します。

`@hint`
手順にあるコマンドをコピーして貼り付け、ファイル名を変更し、パイプを追加してから、`sort`を`-r`フラグ付きで呼び出してください。

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
      has_code("cut", incorrect_msg = "「cut」を呼び出しましたか？"),
      has_code("-d", incorrect_msg = "「-d」でフィールド区切り文字を指定しましたか？"),
      has_code("seasonal/winter.csv", incorrect_msg = "「seasonal/winter.csv」ファイルからデータを取得しましたか？"),
      has_code("|", incorrect_msg = "「|」を使用して「cut」から「grep」へ、「grep」から「sort」へパイプしましたか？"),      
      has_code("grep", incorrect_msg = "「grep」を呼び出しましたか？"),
      has_code("-v", incorrect_msg = "「-v」で一致を反転しましたか？"),
      has_code("Tooth", incorrect_msg = "「Tooth」を検索しましたか？"),
      has_code("sort", incorrect_msg = "「sort」を呼び出しましたか？"),
      has_code("-r", incorrect_msg = "「-r」でソート順を逆にしましたか？")
    )
  )
)
Ex().success_msg("ソート完了！「sort」には多くの用途があります。例えば、「sort -n」を「head」にパイプすると、最大値を表示できます。")
```

---

## 重複した行を削除するにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

`sort` とよく一緒に使われるもう1つのコマンドが `uniq` です。
このコマンドは、重複した行を削除する役割を持ちます。
より正確には、*隣接する*重複行を削除します。
例えば、あるファイルに次の内容が含まれているとします。

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

この場合、`uniq` は次のように出力します。

```
2017-07-03
2017-08-03
```

しかし、ファイルの内容が次のようになっている場合、

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

`uniq` は4行すべてを出力します。
これは、`uniq` が非常に大きなファイルでも扱えるように設計されているためです。
隣接していない重複行までまとめて削除しようとすると、
ファイル全体（少なくとも、それまでに出現したすべてのユニークな行）を
メモリ上に保持しておく必要があります。
隣接する重複だけを削除する仕組みにすることで、
直前のユニークな行だけをメモリに保持すればよくなるのです。

`@instructions`
次の処理を行うパイプラインを作成してください。

- `seasonal/winter.csv` の2列目を取得する
- 出力から "Tooth" という単語を取り除き、歯の名前だけが表示されるようにする
- 同じ歯の名前がすべて隣接するように出力を並べ替える
- 各歯の名前を1回ずつ、それぞれの出現回数とともに表示する

パイプラインの冒頭部分は、前の演習と同じです。

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

これに `sort` コマンドを追加し、`uniq -c` と `uniq` を組み合わせる代わりに `wc` を使って、ユニークな行とその出現回数を表示してください。

`@hint`
指示にあるコマンドをコピー＆ペーストし、フラグなしで `sort` にパイプした後、さらに `uniq` に `-c` フラグを付けてパイプしてください。

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
                     incorrect_msg="このコマンドから始めるべきです: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`。今、それを拡張してください！"),
            has_code('\|\s+sort', incorrect_msg="コマンドを `| sort` で拡張しましたか？"),
            has_code('\|\s+uniq', incorrect_msg="コマンドを `| uniq` で拡張しましたか？"),
            has_code('-c', incorrect_msg="`-c` を使ってカウントを含めましたか？")
        )
    )
)
Ex().success_msg("素晴らしいです！このパイプでの作業の後、結果を保存できたらいいですね？")
```

---

## パイプの出力を保存するにはどうすればよいですか？

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

シェルでは、パイプでつないだ一連のコマンドの出力をリダイレクトできます。

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

ただし、`>` はパイプラインの末尾に置く必要があります。
次のように途中で使おうとすると:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

`cut` の出力がすべて `teeth-only.txt` に書き込まれてしまいます。
そのため `grep` に渡すデータが残らず、
それは入力をいつまでも待ち続けることになります。

<hr>

では、次のようにリダイレクトをパイプラインの先頭に置くとどうなるでしょうか。

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [コマンドの出力は、通常どおりファイルにリダイレクトされます。]
- シェルはそれをエラーとして報告します。
- シェルは入力をいつまでも待ち続けます。

`@hint`
Shellで試してみてください。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['正解です！', 'いいえ；シェルは実際にこれを実行できます。', 'いいえ；シェルは実際にこれを実行できます。'])
```

---

## 実行中のプログラムを停止するには？

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

これまで実行したコマンドやスクリプトはすぐに完了するものばかりでしたが、タスクによっては完了までに数分、数時間、あるいは数日かかることもあります。
また、誤ってパイプラインの途中にリダイレクトを入れてしまい、処理が止まってしまうこともあります。
プログラムの実行を続けたくない場合は、`Ctrl` + `C` と入力すれば終了できます。
これは Unix のドキュメントでは `^C` と表記されることが多く、'c' は小文字で書かれる場合もあるので注意してください。

`@instructions`
次のコマンドを実行してください。

```{shell}
head
```

引数なしで実行し（つまり、決して来ない入力を待つようにし）、
その後、`Ctrl` + `C` を入力して停止させてください。

`@hint`
head と入力して Enter キーを押し、実行中のプログラムを `Ctrl` + `C` で終了してください。

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="`head` を使用しましたか？")
```

---

## まとめ

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

まとめると、
季節データファイルの中で最も短いものにどれだけのレコードがあるかを調べるためのパイプラインを作成します。

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
`wc` を適切なパラメータとともに使い、すべての季節データファイルの行数を一覧表示してください。
（ファイル名をすべて手入力する代わりに、ワイルドカードを使ってください。）

`@hint`
行だけを一覧表示するには `-l` を、ファイル名を一致させるには `*` を使用します。

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
      has_code("wc", incorrect_msg = "`wc`を呼び出しましたか？"),
      has_code("-l", incorrect_msg = "`-l`で行数を数えましたか？"),
      has_code("seasonal/\*", incorrect_msg = "すべての`seasonal/*`ファイルからデータを取得しましたか？")
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
パイプを使用して前のコマンドに別のコマンドを追加し、「合計」という単語を含む行を削除してください。

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
      has_code("wc", incorrect_msg = "「wc」を呼び出しましたか？"),
      has_code("-l", incorrect_msg = "「-l」で行数を数えましたか？"),
      has_code("seasonal/\*", incorrect_msg = "すべての「seasonal/*」ファイルからデータを取得しましたか？"),
      has_code("|", incorrect_msg = "「|」を使用して「wc」から「grep」へパイプしましたか？"),      
      has_code("grep", incorrect_msg = "「grep」を呼び出しましたか？"),
      has_code("-v", incorrect_msg = "「-v」で一致を反転しましたか？"),
      has_code("total", incorrect_msg = "「total」を検索しましたか？")
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
パイプラインにさらに2つのステージを追加して、`sort -n`と`head -n 1`を使って最も少ない行を含むファイルを見つけます。

`@hint`
- `sort`の`-n`フラグを使って数値的にソートします。
- `head`の`-n`フラグを使って1行に保ちます。

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
      has_code("wc", incorrect_msg = "`wc`を呼び出しましたか？"),
      has_code("-l", incorrect_msg = "`-l`で行数を数えましたか？"),
      has_code("seasonal/\*", incorrect_msg = "すべての`seasonal/*`ファイルからデータを取得しましたか？"),
      has_code("|", incorrect_msg = "`wc`から`grep`、`sort`、`head`に`|`を使ってパイプしましたか？"),      
      has_code("grep", incorrect_msg = "`grep`を呼び出しましたか？"),
      has_code("-v", incorrect_msg = "`-v`で一致を反転しましたか？"),
      has_code("total", incorrect_msg = "`total`を検索しましたか？"),
      has_code("sort", incorrect_msg = "`sort`を呼び出しましたか？"),
      has_code("-n", incorrect_msg = "`-n`で保持する行数を指定しましたか？"),
      has_code("1", incorrect_msg = "`-n 1`で1行を保持するように指定しましたか？")
    )
  )
)
Ex().success_msg("素晴らしいです！`autumn.csv`が最も行数の少ないファイルであることが判明しました。バッチ処理についてもっと学ぶために、第4章に急いでください！")
```

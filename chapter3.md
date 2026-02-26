---
title: ツールの組み合わせ
description: >-
  Unix
  シェルの真の力は、個々のコマンドそのものではなく、それらを簡単に組み合わせて新しい処理を行える点にあります。この章では、必要なデータを抽出する方法を学び、値のソートや重複の削除を行うコマンドを紹介します。
lessons:
  - nb_of_exercises: 12
    title: コマンドの出力をファイルに保存するには？
---

## コマンドの出力をファイルに保存するにはどうすればよいですか？

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

これまで見てきたツールは、入力ファイル名を指定できました。
多くのコマンドには出力ファイル名を指定するオプションがありません。必要ないからです。
その代わりに、任意のコマンドの出力を好きな場所に保存できるよう、**リダイレクト**を使います。
次のコマンドを実行すると、

```{shell}
head -n 5 seasonal/summer.csv
```

summer のデータの先頭5行が画面に表示されます。
代わりに次のコマンドを実行すると、

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

画面には何も表示されません。
その代わり、
`head` の出力は `top.csv` という新しいファイルに書き込まれます。
そのファイルの中身は `cat` で確認できます。

```{shell}
cat top.csv
```

不等号の `>` は、シェルに `head` の出力をファイルへリダイレクトするよう指示します。
これは `head` コマンドの一部ではありません。
代わりに、出力を生成するあらゆるシェルコマンドで機能します。

`@instructions`
`tail` とリダイレクトを組み合わせて、`seasonal/winter.csv` の最後の5行を `last.csv` というファイルに保存してください。

`@hint`
最後の5行を取得するには、`tail -n 5` を使います。

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

## コマンドの出力を別のコマンドの入力として使うには？

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

ファイルの途中の行を取り出したいとします。
もう少し具体的には、データファイルの3–5行目を取得したいとします。
まずは `head` を使って先頭5行を取り出し、
それをファイルにリダイレクトし、
続けて `tail` で最後の3行を選びます。

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

簡単に確認すると、元のファイルの3–5行目になっていることがわかります。
先頭5行のうちの最後の3行だからです。

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
`seasonal/winter.csv` から最後の2行を選び、
`bottom.csv` というファイルに保存してください。

`@hint`
`tail` で行を選び、`>` で `tail` の出力をリダイレクトします。

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
元のファイルの最後から2番目の行を得るために、
`bottom.csv` から先頭の1行を選んでください。

`@hint`
目的の行を選ぶには `head` を使います。

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

## コマンドを組み合わせるより良い方法は？

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

リダイレクトでコマンドを組み合わせる方法には、次の2つの欠点があります。

1. 中間ファイル（`top.csv` など）が大量に残ってしまいます。
2. 最終的な結果を得るためのコマンドが履歴の複数行に分散してしまいます。

シェルには、これらの問題を一度に解決する **パイプ** と呼ばれるツールがあります。
もう一度、まずは `head` を実行してみましょう:

```{shell}
head -n 5 seasonal/summer.csv
```

`head` の出力をファイルに送る代わりに、縦棒とファイル名なしの `tail` コマンドを追加します:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

パイプ記号は、左側のコマンドの出力を右側のコマンドの入力として使うように、シェルに指示します。

`@instructions`
`cut` を使って、カンマ区切りファイル `seasonal/summer.csv` の2列目からすべての歯の名前を抽出し、その結果をパイプで `grep` に渡して、反転マッチで「Tooth」という語を含むヘッダー行を除外してください。※`cut` と `grep` の詳細は、第2章の演習8と11で扱いました。

`@hint`
- コマンドの前半は `cut -d field_delimiter -f column_number filename` の形になります。
- コマンドの後半は `grep -v thing_to_match` の形になります。

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

## 複数のコマンドをどう組み合わせればよいですか？

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

任意の数のコマンドを連結して実行できます。
たとえば、次のコマンドは：

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

次の処理を行います。

1. spring のデータから最初の列を抽出します。
2. 「Date」という語を含むヘッダー行を除外します。
3. 実データの先頭 10 行を取得します。

`@instructions`
前の演習では、次のコマンドを使って `seasonal/summer.csv` の 2 列目からすべての歯の名前を抽出しました。

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

このパイプラインの末尾に `head` コマンドを追加して、最初の 1 件の歯の名前だけを選択してください。

`@hint`
指示にあるコードをコピー＆ペーストし、末尾にパイプを追加してから、`-n` フラグを付けて `head` を呼び出してください。

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

## ファイル内のレコード数を数えるには？

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

`wc` コマンド（"word count" の略）は、ファイルに含まれる**文字数**、**単語数**、**行数**を表示します。
それぞれを単独で表示したい場合は、`-c`、`-w`、`-l` を使います。

`@instructions`
`seasonal/spring.csv` のうち、日付が 2017 年 7 月（`2017-07`）のレコードがいくつあるか数えてください。
- そのために、部分的な日付で `grep` を使って該当する行を選び、その結果をパイプで `wc` に渡し、行数を数えるための適切なフラグを付けてください。

`@hint`
- 日付の形式を思い出すには `head seasonal/spring.csv` を使います。
- コマンドの前半は `grep 検索したいもの ファイル名` の形になります。
- パイプ `|` の後で、行数を数えるために `wc` に `-l` フラグを付けて呼び出します。

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

## 複数のファイルを一度に指定するには？

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

ほとんどのシェルコマンドは、複数のファイル名を渡せば複数ファイルに対して動作します。
たとえば、次のようにして四季のデータファイルすべてから最初の列を一度に取得できます:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

しかし、多くのファイル名を何度も手で入力するのは得策ではありません。
時間がかかりますし、いずれファイルを入れ忘れたり、同じ名前を重複してしまったりします。
そこで便利なのが、シェルの**ワイルドカード**です。1つの表現でファイルの一覧を指定できます。
最も一般的なワイルドカードは `*` で、
「0 文字以上にマッチする」という意味です。
これを使うと、上の `cut` コマンドは次のように短くできます:

```{shell}
cut -d , -f 1 seasonal/*
```

または次のようにも書けます:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
`head` を使って、`seasonal/spring.csv` と `seasonal/summer.csv` の両方から最初の3行、合計6行のデータを取得するコマンドを1行で書いてください。ただし、autumn と winter のファイルは含めないでください。
ファイル名をすべて書き出すのではなく、ワイルドカードを使用してください。

`@hint`
- コマンドの形式は `head -n number_of_lines filename_pattern` です。
- たとえば、ディレクトリ `a` 内で `b` で始まるファイルにマッチさせるには、`a/b*` を使います。

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

## ほかに使えるワイルドカードは？

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

シェルにはほかにもワイルドカードがありますが、使用頻度はやや低めです。

- `?` は1文字にマッチします。たとえば `201?.txt` は `2017.txt` や `2018.txt` にマッチしますが、`2017-01.txt` にはマッチしません。
- `[...]` は角括弧内のいずれか1文字にマッチします。たとえば `201[78].txt` は `2017.txt` や `2018.txt` にマッチしますが、`2016.txt` にはマッチしません。
- `{...}` は波括弧内のカンマ区切りのいずれかのパターンにマッチします。たとえば `{*.txt, *.csv}` は名前が `.txt` または `.csv` で終わるファイルにマッチしますが、`.pdf` で終わるファイルにはマッチしません。

<hr/>

`singh.pdf` と `johel.txt` にはマッチし、かつ `sandhu.pdf` や `sandhu.txt` にはマッチ「しない」表現はどれですか？

`@hint`
それぞれの表現を、各ファイル名に順番に当てはめて考えてみてください。

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- いいえ: `.pdf` と `.txt` はファイル名そのものではありません。
- いいえ: これは `sandhu.pdf` にもマッチします。
- いいえ: 角括弧内の表現は単一の文字にしかマッチせず、単語全体にはなりません。
- 正解です！

---

## テキストの行をどのように並べ替えられますか？

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

名前の通り、`sort` はデータを並べ替えます。既定ではアルファベット順の昇順で並べ替えますが、`-n` と `-r` を使うと数値でのソートや出力順の反転ができます。`-b` は先頭の空白を無視し、`-f` は大文字小文字を折りたたみ（つまり大文字小文字を区別しない）ます。パイプラインでは、不要なレコードを `grep` で取り除き、その後 `sort` で残りのレコードを順序付けるのが一般的です。

`@instructions`
`seasonal/summer.csv` の2列目からすべての歯の名前を選ぶために使った、`cut` と `grep` の組み合わせを覚えていますか？

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

このレシピを出発点にして、`seasonal/winter.csv`（`summer.csv` ではありません）の歯の名前をアルファベットの降順で並べ替えてください。そのために、パイプラインに `sort` のステップを追加しましょう。

`@hint`
指示にあるコマンドをコピー＆ペーストし、ファイル名を変更して、パイプを追加し、その後に `-r` フラグ付きで `sort` を実行します。

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

## 重複した行を取り除くにはどうしますか？

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

しばしば `sort` と一緒に使われるコマンドに `uniq` があります。
`uniq` の役割は、重複した行を取り除くことです。
より正確には、*隣接する* 重複行だけを取り除きます。
もしファイルが次のようになっている場合は:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

`uniq` は次のように出力します:

```
2017-07-03
2017-08-03
```

しかし、もし次のようになっている場合は:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

`uniq` は4行すべてを表示します。
その理由は、`uniq` が非常に大きなファイルで動作するよう設計されているためです。
隣接していない重複行を取り除くには、
ファイル全体（少なくとも、これまでに現れたすべてのユニークな行）を
メモリに保持する必要があります。
隣接する重複だけを取り除くことで、
直近のユニークな1行だけをメモリに保持すればよくなります。

`@instructions`
次の処理を行うパイプラインを書いてください:

- `seasonal/winter.csv` から2列目を取得する。
- 出力から "Tooth" という単語を取り除き、歯の名前だけを表示する。
- 同じ歯の名前が隣り合うように出力を並べ替える。
- 各歯の名前を一度だけ表示し、その出現回数も一緒に表示する。

パイプラインの最初の部分は前の演習と同じです:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

ここに `sort` コマンドを続け、`uniq -c` を使って、各ユニークな行を出現回数付きで表示してください。`uniq` と `wc` を組み合わせる代わりに使います。

`@hint`
指示にあるコマンドをコピー＆ペーストし、フラグなしの `sort` にパイプし、さらに `uniq` に `-c` フラグを付けてパイプします。

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

シェルでは、パイプでつないだコマンド列の出力をリダイレクトできます。

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

ただし、`>` はパイプラインの末尾に置く必要があります。
次のように途中で使おうとすると、

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

`cut` の出力はすべて `teeth-only.txt` に書き出され、
`grep` に渡されるものがなくなるため、
`grep` は入力をずっと待ち続けてしまいます。

<hr>

では、次のようにパイプラインの先頭にリダイレクトを書いた場合はどうなるでしょうか。

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [コマンドの出力は通常どおりファイルにリダイレクトされます。]
- シェルはエラーとして報告します。
- シェルは入力を永遠に待ち続けます。

`@hint`
シェルで実際に試してみてください。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['正解です！', 'いいえ；シェルは実際にこれを実行できます。', 'いいえ；シェルは実際にこれを実行できます。'])
```

---

## 実行中のプログラムを止めるには？

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

これまでに実行したコマンドやスクリプトはすべてすぐに終わりましたが、処理によっては数分、数時間、あるいは数日かかることもあります。パイプラインの途中に誤ってリダイレクトを入れてしまい、ハングしてしまうこともあります。もしプログラムをこれ以上動かしたくないと思ったら、`Ctrl` + `C` を入力して終了できます。これは Unix のドキュメントではしばしば `^C` と書かれます。なお、'c' は小文字でも構いません。

`@instructions`
次のコマンドを実行します。

```{shell}
head
```

引数なしで実行し（決して来ない入力を待つ状態にして）、`Ctrl` + `C` を入力して停止してください。

`@hint`
単に head と入力して Enter を押し、実行中のプログラムは `Ctrl` + `C` で終了します。

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

仕上げとして、季節ごとのデータファイルのうち、最も短いファイルに含まれるレコード数を調べるパイプラインを作成します。

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
`wc` に適切なパラメータを指定して、すべての季節データファイルの行数を一覧表示してください。
（ファイル名は手入力せず、ワイルドカードを使いましょう。）

`@hint`
`-l` を使って行数のみを表示し、`*` を使ってファイル名にマッチさせます。

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
前のコマンドにパイプでコマンドをもう一つ追加し、"total" という語を含む行を取り除いてください。

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
パイプラインにさらに 2 段追加し、`sort -n` と `head -n 1` を使って、最も行数が少ないファイルを見つけてください。

`@hint`
- 数値として並べ替えるには `sort` の `-n` フラグを使います。
- 1 行だけ残すには `head` の `-n` フラグを使います。

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

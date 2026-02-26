---
title: ファイルとディレクトリの操作
description: >-
  この章では Unix シェルの概要を短く紹介します。なぜ約 50
  年経った今でも使われているのか、慣れ親しんだグラフィカルツールとどう違うのか、シェル内での移動方法、そしてファイルやフォルダの作成・変更・削除の方法を学びます。
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: シェルはデスクトップの操作とどう違うのですか？
---

## シェルはデスクトップのインターフェースとどう違いますか？

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Windows、Linux、Mac OS などのオペレーティングシステムは、特殊な種類のプログラムです。
これはコンピューターのプロセッサ、ハードドライブ、ネットワーク接続を制御しますが、最も重要な仕事はほかのプログラムを実行することです。

人間はデジタルそのものではないので、オペレーティングシステムとやり取りするにはインターフェースが必要です。
今日もっとも一般的なのはグラフィカルなファイルエクスプローラーで、クリックやダブルクリックを、ファイルを開いたりプログラムを実行したりするコマンドに変換します。
一方で、コンピューターにグラフィカル表示がなかった時代は、人々は**コマンドラインシェル**というプログラムに対して指示をタイプしていました。
コマンドが入力されるたびに、シェルは別のプログラムを実行し、その出力を人間が読める形で表示し、次のコマンドを受け付ける準備ができたことを示す*プロンプト*を表示します。
（「コンピューターの外側の殻」という発想から、その名が付いています。）

クリックやドラッグの代わりにコマンドを打ち込むのは最初は不器用に感じるかもしれませんが、ご覧のとおり、コンピューターにしてほしいことを言葉で正確に指定できるようになると、既存のコマンドを組み合わせて新しい処理を作れますし、繰り返しの作業も数回のキー入力だけで自動化できます。

<hr>
多くの人が使うグラフィカルなファイルエクスプローラーと、コマンドラインシェルの関係は何でしょうか？

`@hint`
ユーザーは、プログラムを通じてのみオペレーティングシステムとやり取りできることを思い出してください。

`@possible_answers`
- ファイルエクスプローラーはファイルの表示と編集を行い、シェルはプログラムの実行を行います。
- ファイルエクスプローラーはシェルの上に構築されています。
- シェルはオペレーティングシステムの一部で、ファイルエクスプローラーは別物です。
- [どちらも、オペレーティングシステムにコマンドを発行するためのインターフェースです。]

`@feedback`
- どちらも、ファイルの表示・編集やプログラムの実行ができます。
- グラフィカルなファイルエクスプローラーもシェルも、同じ基盤となるオペレーティングシステムの関数を呼び出しています。
- シェルとファイルエクスプローラーはいずれも、ユーザーのコマンド（入力やクリック）をオペレーティングシステムへの呼び出しに翻訳するプログラムです。
- 正解です！どちらも、ユーザーの操作（入力でもクリックでも）を受け取り、オペレーティングシステムに送ります。

---

## 今いる場所は？

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

ファイルシステムは、ファイルやディレクトリ（フォルダ）を管理します。
それぞれは、ファイルシステムのルートディレクトリからのたどり方を示す絶対パスで識別されます。
たとえば、`/home/repl` は `home` ディレクトリの中にある `repl` ディレクトリ、
`/home/repl/course.txt` はその中にあるファイル `course.txt` を指します。
単独の `/` はルートディレクトリです。

ファイルシステム上で自分が今どこにいるかを知るには、
`pwd` コマンドを実行します
（"print working directory" の略です）。
これにより、現在の作業ディレクトリの絶対パスが表示されます。
シェルは既定でこの場所でコマンドを実行し、ファイルを探します。

<hr>
`pwd` を実行しましょう。
いま、あなたはどこにいますか？

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix システムでは、通常すべてのユーザーのホームディレクトリは `/home` の下に配置されています。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "それは正しいパスではありません。"
correct = "正解です - あなたは `/home/repl` にいます。"

Ex().has_chosen(3, [err, err, correct])
```

---

## ファイルとディレクトリをどう見分ければよいですか？

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` は今どこにいるかを教えてくれます。
そこに何があるかを知るには、
`ls`（"**l**i**s**ting" の略）と入力して Enter キーを押します。
`ls` 単体では、
現在のディレクトリの内容を一覧表示します
（`pwd` に表示されている場所です）。
ファイル名を追加すると、
そのファイル名を一覧表示し、
ディレクトリ名を追加すると、
そのディレクトリの中身を一覧表示します。
たとえば、
`ls /home/repl` は開始ディレクトリにあるものを表示します
（通常は **ホームディレクトリ** と呼ばれます）。

<hr>
`ls` に適切な引数を付けて、ディレクトリ `/home/repl/seasonal` にあるファイルを一覧表示してください
（このディレクトリには、季節ごとに日付別の歯科手術に関する情報が入っています）。
次のうち、このディレクトリに「ない」ファイルはどれですか？

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
`ls` にパスを渡すと、そのパスの中身を表示します。

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "そのファイルは `seasonal` ディレクトリにあります。"
correct = "正解です - そのファイルは `seasonal` ディレクトリには *ありません*。"

Ex().has_chosen(2, [err, correct, err, err])
```

---

## ファイルやディレクトリを見分けるほかの方法はありますか？

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

絶対パスは緯度と経度のようなもので、どこにいても同じ値になります。一方、**相対パス**は今いる場所からの位置を指定します。たとえば「北に20キロ」のような表現です。

例として：
- もしディレクトリ`/home/repl`にいるなら、**相対**パス`seasonal`は、**絶対**パス`/home/repl/seasonal`と同じディレクトリを指します。
- もしディレクトリ`/home/repl/seasonal`にいるなら、**相対**パス`winter.csv`は、**絶対**パス`/home/repl/seasonal/winter.csv`と同じファイルを指します。

シェルはパスの最初の文字を見て、それが絶対か相対かを判断します。先頭が`/`で始まれば絶対パス、`/`で始まらなければ相対パスです。

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
あなたは`/home/repl`にいます。`ls`に**相対パス**を指定して、絶対パスが`/home/repl/course.txt`のファイル（そのファイルだけ）を一覧表示してください。

`@hint`
現在位置より下にあるファイルやディレクトリへの相対パスは、求めたい対象の絶対パスから現在位置の絶対パスを差し引くことで組み立てられることが多いです。

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "「ls」を呼び出してファイルリストを生成していません。"), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "コマンドが正しいファイルリストを生成しませんでした。「ls」に続けて`/home/repl/course.txt`への相対パスを使用してください。")
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
あなたは`/home/repl`にいます。
`ls`に**相対**パスを指定して、
ファイル`/home/repl/seasonal/summer.csv`（そのファイルだけ）を一覧表示してください。

`@hint`
相対パスは先頭に'/'を付けては*いけません*。

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "ファイルリストを生成するために`ls`を呼び出していません。"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "コマンドが正しいファイルリストを生成しませんでした。`ls`の後に`/home/repl/seasonal/summer.csv`への相対パスを使用してください。")
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
あなたは`/home/repl`にいます。
`ls`に**相対**パスを指定して、
ディレクトリ`/home/repl/people`の中身を一覧表示してください。

`@hint`
相対パスは先頭に'/'を付けません。

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "ファイルリストを生成するために `ls` を呼び出していません。"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "コマンドが正しいファイルリストを生成していません。`ls` の後に `/home/repl/people` への相対パスを続けて使用してください。")
    )
)
Ex().success_msg("よくできました。ファイルとディレクトリのリストを作成する方法を学んだので、次はファイルシステム内を移動する方法を見てみましょう！")
```

---

## 別のディレクトリに移動するには？

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

ファイルブラウザでフォルダをダブルクリックして移動できるのと同じように、
コマンド `cd`（"change directory" の略）を使ってファイルシステム内を移動できます。

`cd seasonal` と入力してから `pwd` と入力すると、
シェルは現在の場所が `/home/repl/seasonal` であることを教えてくれます。
その後に単独で `ls` を実行すると、
今いる場所である `/home/repl/seasonal` の中身が表示されます。
ホームディレクトリ `/home/repl` に戻りたい場合は、
コマンド `cd /home/repl` を使います。

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
現在は `/home/repl` にいます。
相対パスを使って `/home/repl/seasonal` に移動してください。

`@hint`
`cd` は "change directory" の略で、相対パスは先頭に '/' を付けないことを思い出してください。

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="現在の作業ディレクトリが `/home/repl` である場合（`pwd` で確認できます）、`cd seasonal` を使用して `seasonal` フォルダに移動できます。")
)
```

***

```yaml
type: ConsoleExercise
key: e69c8eac15
xp: 35
```

`@instructions`
`pwd` を使って、そこにいることを確認してください。

`@hint`
コマンドを入力したら「enter」または「return」キーを押すのを忘れないでください。

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
パスを付けずに `ls` を使って、そのディレクトリの中身を確認してください。

`@hint`
コマンドの後に「enter」または「return」キーを押してください。

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
      has_code('ls', incorrect_msg="コマンドが正しい出力を生成しませんでした。現在のディレクトリの内容を表示するために、パスを指定せずに `ls` を使用しましたか？")
    )
)

Ex().success_msg("素晴らしいです！これはサブディレクトリに移動することについてでした。上に移動するのはどうでしょうか？見てみましょう！")
```

---

## どうすれば1つ上のディレクトリに移動できますか？

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

ディレクトリの**親（parent）**とは、直上にあるディレクトリのことです。
たとえば、`/home` は `/home/repl` の親で、
`/home/repl` は `/home/repl/seasonal` の親です。
`cd` や `ls` のようなコマンドには、親ディレクトリの絶対パスをいつでも指定できます。
しかし多くの場合、
特別なパス `..`（スペースなしのドット2つ）が
「今いる場所の1つ上のディレクトリ」を意味することを利用します。
もし `/home/repl/seasonal` にいるなら、
`cd ..` は `/home/repl` に上がります。
もう一度 `cd ..` を使うと、
`/home` に移動します。
さらにもう一度 `cd ..` を実行すると、
ファイルシステムの最上位である*ルートディレクトリ* `/` に移動します。
（`cd` と `..` の間にはスペースを入れてください。これは4文字の1つのコマンドではなく、コマンドとパスです。）

単独の1つのドット `.` は常に「現在のディレクトリ」を意味します。
そのため、`ls` 単独と `ls .` は同じ動作をし、
`cd .` は（今いるディレクトリに移動するだけなので）何も起こりません。

もう1つの特別なパスが `~`（チルダ）で、
これは「自分のホームディレクトリ」
（例：`/home/repl`）を意味します。
どこにいても、
`ls ~` は常にホームディレクトリの中身を表示し、
`cd ~` で必ずホームに戻れます。

<hr>
もしあなたが `/home/repl/seasonal` にいるとして、
`cd ~/../.` はどこに移動しますか？

`@hint`
ディレクトリを1つずつたどって考えてみてください。

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (the root directory)

`@feedback`
- いいえ。ただし、`~` か `..` のどちらか単独であれば、そこに移動できます。
- 正解です！このパスは「ホームディレクトリ」「1つ上」「現在地」を意味します。
- いいえ。ですが、`.` だけであればそうなります。
- いいえ。パスの最後の部分は `..`（「上へ」）ではなく、`.`（「ここ」）です。

---

## ファイルはどうやってコピーできますか？

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

ファイルをコピーしたり、整理のために別のディレクトリへ移動したり、名前を変えたりすることはよくあります。
これを行うコマンドのひとつが `cp`（"copy" の略）です。
もし `original.txt` という既存のファイルがあるなら、次のようにします。

```{shell}
cp original.txt duplicate.txt
```

これで `original.txt` のコピーが `duplicate.txt` という名前で作成されます。
すでに `duplicate.txt` というファイルが存在している場合は、上書きされます。
`cp` の最後の引数が既存のディレクトリであれば、次のようなコマンドは:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

これらのファイルをそのディレクトリにまとめてコピーします。

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
`seasonal/summer.csv` のコピーを `backup` ディレクトリ（`/home/repl` にもあります）に作成し、
新しいファイル名は `summer.bck` としてください。

`@hint`
コピー先ディレクトリ名とコピーするファイル名を組み合わせて、
新しいファイルの相対パスを作成してください。

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` が `backup` ディレクトリに存在しないようです。`cp` に 2 つのパスを指定してください: 存在するファイル (`seasonal/summer.csv`) と宛先ファイル (`backup/summer.bck`)。"),
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
現在の作業ディレクトリ（`/home/repl`）を変更せずに、`seasonal` ディレクトリから `spring.csv` と `summer.csv` を `backup` ディレクトリにコピーしてください。

`@hint`
`cp` を使い、まずコピーしたいファイル名を並べてから、
最後にコピー先ディレクトリ名を指定します。

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` が `backup` ディレクトリにコピーされていないようです。2つのファイル名とディレクトリ名を `cp` に提供してください。"
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="ファイルをコピーする際は `{{dir}}` にいることを確認してください！`cd {{dir}}` を使用してそこに戻ってください。"),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("よくできました。コピー以外にも、ファイルをあるディレクトリから別のディレクトリに移動することもできるはずです。次の演習でそれについて学びましょう！")
```

---

## ファイルを移動するには？

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

`cp` はファイルをコピーしますが、
`mv` はファイルをあるディレクトリから別のディレクトリへ移動します。
これは、グラフィカルなファイルブラウザでドラッグするのと同じ動作です。
引数の扱いは `cp` と同じなので、次のコマンドは：

```{shell}
mv autumn.csv winter.csv ..
```

カレント作業ディレクトリにある `autumn.csv` と `winter.csv` を
1 つ上の親ディレクトリに移動します
（`..` は常に現在位置の 1 つ上のディレクトリを指します）。

`@instructions`
あなたは `/home/repl` にいます。ここにはサブディレクトリ `seasonal` と `backup` があります。
1 回のコマンドで、`seasonal` から `backup` に `spring.csv` と `summer.csv` を移動してください。

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
backup_patt="ファイル `%s` は `backup` ディレクトリにありません。`mv` を正しく使用しましたか？ `mv` のパラメータとして2つのファイル名と1つのディレクトリを使用してください。"
seasonal_patt="ファイル `%s` はまだ `seasonal` ディレクトリにあります。`cp` でコピーするのではなく、`mv` でファイルを移動することを確認してください！"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("よくできました。この調子でシェルトレインを続けましょう！")
```

---

## ファイル名はどう変えられますか？

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` はファイル名の変更にも使えます。次を実行すると:

```{shell}
mv course.txt old-course.txt
```

現在の作業ディレクトリにある `course.txt` というファイルが、`old-course.txt` というファイルに「移動」されます。
これは一般的なファイルブラウザの動作とは異なりますが、便利なことがよくあります。

注意点が1つあります。
`cp` と同様に、
`mv` は既存のファイルを上書きします。
たとえば、
すでに `old-course.txt` というファイルがある場合、
上のコマンドはそれを `course.txt` の中身で置き換えてしまいます。

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
`seasonal` ディレクトリに移動してください。

`@hint`
`cd` は「ディレクトリを変更する」の略で、相対パスは先頭に '/' を付けません。

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
key: ed5fe1df23
xp: 35
```

`@instructions`
ファイル `winter.csv` の名前を `winter.csv.bck` に変更してください。

`@hint`
`mv` は、現在のファイル名と変更後のファイル名の順に指定して使います。

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " `mv`を2つの引数と共に使用してください: 名前を変更したいファイル（`winter.csv`）とファイルの新しい名前（`winter.csv.bck`）。"
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="ディレクトリ内に`winter.csv.bck`があることを期待していました。" + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="ディレクトリ内に`winter.csv`がないことを期待していました。" + hint)
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
`ls` を実行して、すべて正しく動作したか確認してください。

`@hint`
コマンドを実行するには、"enter" または "return" を押してください。

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="`ls`を使用して、現在の作業ディレクトリの内容をリストしましたか？")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "コマンドが正しいファイルリストを生成しませんでした。引数なしで`ls`を使用して、現在の作業ディレクトリの内容をリストしてください。")
    )
)
Ex().success_msg("コピー、移動、名前の変更、すべて理解されていますね！次はファイルの削除です。")
```

---

## ファイルはどうやって削除しますか？

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

ファイルはコピーしたり移動したりできます。
削除するときは `rm`（"remove" の略）を使います。
`cp` や `mv` と同様に、`rm` には複数のファイル名を渡せます。たとえば、次のようにします。

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

これで `thesis.txt` と `backup/thesis-2017-08.txt` の両方が削除されます。

`rm` は名前のとおり、すぐに削除を実行します。
グラフィカルなファイルブラウザと違って、シェルにはごみ箱がありません。
そのため、上のコマンドを実行すると、論文ファイルは完全に消えてしまいます。

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
現在は `/home/repl` にいます。
`seasonal` ディレクトリに移動してください。

`@hint`
`cd` は "change directory"（ディレクトリを移動）の略で、相対パスは先頭に '/' が付きません。

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
`autumn.csv` を削除してください。

`@hint`
`rm` は "remove"（削除）の略です。

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="`autumn.csv` が `seasonal` ディレクトリにまだ存在していることを想定していませんでした。削除したいファイルのパスを指定して `rm` を使用してください。"),
    has_code('rm', incorrect_msg = '`rm` を使用してファイルを削除してください。移動するのではなく。')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
ホームディレクトリに戻ってください。

`@hint`
パスを指定せずに `cd` を使うと、ホームディレクトリに移動します。

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="`cd ..` または `cd ~` を使用してホームディレクトリに戻ってください。")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
ディレクトリを移動せずに、`seasonal/summer.csv` を削除してください。

`@hint`
`rm` は "remove"（削除）の略です。

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="`summer.csv` が `seasonal` ディレクトリにまだ存在することを予期していませんでした。削除したいファイルへのパスを指定して `rm` を使用してください。"),
    has_code('rm', incorrect_msg = '`rm` を使用してファイルを削除してください。移動するのではなく。')
)
Ex().success_msg("素晴らしいです！次に進みましょう！")
```

---

## ディレクトリはどう作成・削除しますか？

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` はディレクトリもファイルと同じように扱います。
たとえば、ホームディレクトリにいて `mv seasonal by-season` を実行すると、
`mv` は `seasonal` ディレクトリの名前を `by-season` に変更します。
一方で、
`rm` の動作は異なります。

ディレクトリに対して `rm` を実行しようとすると、
シェルはそれはできないというエラーメッセージを表示します。
これは主に、作業が詰まったディレクトリ全体を誤って削除してしまうのを防ぐためです。
その代わりに、
`rmdir` という別のコマンドを使えます。
安全性を高めるために、
これはディレクトリが空の場合にのみ動作します。
そのため、ディレクトリを削除する前に、その中のファイルを削除する必要があります。
（慣れているユーザーは、`rm` に `-r` オプションを付けて同じ効果を得られます。
コマンドオプションについては次の章で説明します。）

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
ディレクトリを移動せずに、
`people` ディレクトリ内の `agarwal.txt` ファイルを削除してください。

`@hint`
`rm` は "remove"（削除）の略であり、相対パスは先頭に '/' が付きません。

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` はもう `/home/repl/people` に存在しないはずです。`rm` を正しく使用しましたか？"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'まだ `people` ディレクトリにファイルがあります。単に `agarwal.txt` を移動した場合や、新しいファイルを作成した場合は、それらをすべて削除してください。')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
`people` ディレクトリが空になったので、
1つのコマンドで削除してください。

`@hint`
`rm` はファイルに対してのみ動作することを思い出してください。

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "ホームディレクトリに 'people' ディレクトリが存在しないようにしてください。`rmdir` を使用して削除してください。")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
ディレクトリはファイルではないため、
新しい（空の）ディレクトリを作成するには
`mkdir directory_name` コマンドを使います。
このコマンドを使って、ホームディレクトリの直下に `yearly` という新しいディレクトリを作成してください。

`@hint`
作成したいディレクトリ名を指定して `mkdir` を実行します。

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="ホームディレクトリに `yearly` ディレクトリがありません。`mkdir yearly` を使用して作成してください！")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
`yearly` ができたので、
ホームディレクトリから離れずに、その中に `2017` というディレクトリを作成してください。

`@hint`
作成したいサブディレクトリには相対パスを使いましょう。

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="「/home/repl/yearly」に「2017」ディレクトリが見つかりません。相対パス「yearly/2017」を使用してこのディレクトリを作成できます。")
)
Ex().success_msg("素晴らしいです！この章のいくつかの概念を繰り返す演習でこの章を締めくくりましょう！")
```

---

## まとめ

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

データを分析するときは、中間ファイルを作成することがよくあります。
それらをホームディレクトリに保存するのではなく、`/tmp` に置くことができます。
`/tmp` は、人やプログラムが一時的にしか必要としないファイルをよく保管する場所です。
（`/tmp` はルートディレクトリ `/` の直下であり、ホームディレクトリの下では*ありません*。）
このまとめの演習では、そのやり方を確認します。

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
`cd` を使って `/tmp` に移動してください。

`@hint`
`cd` は "change directory"（ディレクトリを移動）の略で、絶対パスは '/' から始まることを思い出してください。

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = '間違ったディレクトリにいます。`cd`を使用してディレクトリを`/tmp`に変更してください。')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
ディレクトリ名を入力せずに、`/tmp` の内容を一覧表示してください。

`@hint`
`ls` に何を一覧表示するかを指定しない場合、現在のディレクトリの中身を表示します。

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "ファイルリストを生成するために `ls` を呼び出していません。"),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "コマンドが正しいファイルリストを生成しませんでした。`ls` を使用してください。")
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
`/tmp` の中に `scratch` という新しいディレクトリを作成してください。

`@hint`
ディレクトリを作成するには `mkdir` を使います。

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
      has_code('mkdir +scratch', incorrect_msg="'/tmp'の下に'scratch'ディレクトリが見つかりません。`mkdir`を正しく使用してください。")
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
`/home/repl/people/agarwal.txt` を `/tmp/scratch` に移動してください。
ホームディレクトリには `~` のショートカットを使い、2つ目のパスには絶対パスではなく相対パスを使うことをおすすめします。

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="'/tmp/scratch'に'agarwal.txt'が見つかりません。最初のパラメータとして`~/people/agarwal.txt`を、2番目のパラメータとして`scratch`を使用して`mv`を使用してください。")
)
Ex().success_msg("これで「シェル入門」の第1章が終了です！次の章に急いで進み、データ操作についてさらに学びましょう！")
```

---
title: ファイルとディレクトリの操作
description: >-
  この章では、Unixシェルについて簡単に紹介します。約50年が経った今でもUnixシェルが使われ続けている理由、より慣れ親しんでいるかもしれないグラフィカルツールとの違い、シェル内を移動する方法、ファイルやフォルダを作成、変更、削除する方法を学びます。
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: shellはデスクトップインターフェースとどのように比較されますか？
---

## シェルはデスクトップインターフェースとどう比較されるのでしょうか？

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Windows、Linux、Mac OSのようなオペレーティングシステムは、特別な種類のプログラムです。
コンピュータのプロセッサ、ハードドライブ、ネットワーク接続を制御します。
しかし、最も重要な仕事は他のプログラムを実行することです。

人間はデジタルではないので、
OSとやり取りするためのインターフェースが必要です。
最近最も一般的なのはグラフィカルなファイルエクスプローラーです。
クリックやダブルクリックを、ファイルを開いたりプログラムを実行したりするコマンドに変換します。
コンピューターにグラフィカルディスプレイがなかった時代には、
人々は**コマンドラインシェル**と呼ばれるプログラムに命令を入力していました。
コマンドが入力されるたびに、
シェルは他のプログラムを実行し、
人間が読みやすい形で出力を表示し、
そして次のコマンドを受け入れる準備ができたことを示す*プロンプト*を表示します。
(その名前は、コンピュータの「外殻」であるという考えに由来します。)

クリックやドラッグではなくコマンドを入力するのは、最初は不器用に感じるかもしれません。
しかし、ご覧のとおり、一度コンピューターに何をしてほしいかを言葉で表し始めると、
古いコマンドを組み合わせて新しいコマンドを作成でき、
繰り返し作業を自動化できます。

<hr>
多くの人が使うグラフィカルなファイルエクスプローラーとコマンドラインシェルの関係はどうなっているのでしょうか?

`@hint`
ユーザーはプログラムを通じてのみオペレーティングシステムを操作できることを覚えておいてください。

`@possible_answers`
- ファイルエクスプローラーはファイルの閲覧や編集を可能にし、シェルはプログラムの実行を可能にします。
- ファイルエクスプローラーはシェルを基盤として構築されています。
- シェルはオペレーティングシステムの一部であり、ファイルエクスプローラーは別のものです。
- [どちらもオペレーティングシステムにコマンドを送るためのインターフェースです。]

`@feedback`
- どちらもファイルの閲覧や編集、プログラムの実行ができます。
- グラフィカルファイルエクスプローラーとシェルは、どちらも同じオペレーティングシステムの機能を呼び出しています。
- シェルとファイルエクスプローラーは、どちらもユーザーのコマンド（入力またはクリック）をオペレーティングシステムへの要求に変換するプログラムです。
- 正解です！どちらもユーザーのコマンド（入力かクリックかを問わず）を受け取り、オペレーティングシステムに送っています。

---

## ここはどこ?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**ファイルシステム**は、ファイルやディレクトリ(フォルダ)を管理します。
それぞれは**絶対パス**によって識別され、
ファイルシステムの**ルートディレクトリ**からどうたどり着くかを示します。
`/home/repl` は `repl` ディレクトリの中にある `home` というディレクトリを指し、
`/home/repl/course.txt` はそのディレクトリの中にある `course.txt` というファイルを指します。
また、`/` 単体はルートディレクトリを表します。

ファイルシステム上の現在位置を確認するには、
`pwd`(「**p**rint **w**orking **d**irectory」の略)コマンドを実行します。
このコマンドは、**現在の作業ディレクトリ**の絶対パスを表示します。
作業ディレクトリとは、シェルがコマンドを実行し、デフォルトでファイルを探す場所のことです。

<hr>
`pwd` を実行しましょう。
今、あなたはどこにいますか?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix システムでは通常、すべてのユーザーのホームディレクトリは `/home` の下に配置されます。

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

## ファイルとディレクトリを識別するにはどうすればよいでしょうか？

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` は現在地を教えてくれます。
そこに何があるかを確認するには、
`ls`（「**l**i**s**ting」の略）と入力し、エンター キーを押します。
`ls` は単体で使うと、
現在のディレクトリ（`pwd` で表示される場所）の中身を一覧表示します。
ファイル名を指定すると、
`ls` はそのファイルを表示し、
ディレクトリ名を指定すると、
その中身を一覧表示します。
たとえば、
`ls /home/repl` と入力すると、開始ディレクトリ（通常は**ホームディレクトリ**と呼ばれます）の中身が表示されます。

<hr>
`ls` に適切な引数を指定して、ディレクトリ `/home/repl/seasonal`（季節ごとに分類された歯科手術の日付情報が保存されています）の中のファイルを一覧表示してください。
次のうち、そのディレクトリに*含まれていない*ファイルはどれですか？

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
`ls` にパスを指定すると、そのパスの中身が表示されます。

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

## ファイルやディレクトリを他にどう識別できますか？

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

絶対パスは緯度と経度のようなものです。どこにいても同じ値を示します。一方、**相対パス**は、今いる場所を基準にして位置を示します。「北へ20キロメートル」と言うようなものです。

例を見てみましょう。
- `/home/repl` というディレクトリにいる場合、**相対**パス `seasonal` は、**絶対**パス `/home/repl/seasonal` と同じディレクトリを指します。
- `/home/repl/seasonal` というディレクトリにいる場合、**相対**パス `winter.csv` は、**絶対**パス `/home/repl/seasonal/winter.csv` と同じファイルを指します。

シェルは、パスの先頭の文字を見て絶対パスか相対パスかを判断します。`/` で始まっていれば絶対パスです。`/` で始まっていなければ相対パスです。

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
あなたは `/home/repl` にいます。**相対パス**を使って `ls` で絶対パスが `/home/repl/course.txt` であるファイル（それのみ）を一覧表示してください。

`@hint`
現在の場所より下にあるファイルやディレクトリへの相対パスを作成できることがよくあります
目的のものの絶対パスから現在の場所の絶対パスを引くことで。

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
あなたは `/home/repl` にいます。
`ls` を **相対** パスで使って
ファイル `/home/repl/seasonal/summer.csv` を一覧表示してください（そのファイルのみ）。

`@hint`
相対パスは先頭に「/」を付けません。

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
`ls`を**相対**パスで使って
ディレクトリ`/home/repl/people`の内容をリストアップします。

`@hint`
相対パスは先頭に「/」が付きません。

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

## どうすれば別のディレクトリに移動できますか?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

ファイルブラウザでフォルダをダブルクリックして移動するのと同じように、
コマンド `cd`（「ディレクトリを変更する」の略）を使うことで
ファイルシステム内を移動できます。

`cd seasonal` と入力してから `pwd` を実行すると、
シェルは現在 `/home/repl/seasonal` にいることを教えてくれます。
そのまま `ls` を実行すると、`/home/repl/seasonal` の内容が表示されます。
これは、今いる場所がそこだからです。
ホームディレクトリ `/home/repl` に戻りたい場合は、
`cd /home/repl` というコマンドを使います。

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
現在 `/home/repl`/ にいます。
相対パスを使って `/home/repl/seasonal` にディレクトリを移動してください。

`@hint`
`cd`は「ディレクトリの変更」を表し、相対パスは先頭の「/」で始まらないことを覚えておいてください。

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
`pwd`を使って、そこにいるか確認してください。

`@hint`
コマンドを入力した後は「エンター」または「リターン」キーを押してください。

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
パスを指定せずに `ls` を使って、そのディレクトリの中身を確認してください。

`@hint`
コマンドの後は「エンター」または「リターン」キーを押してください。

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

## どうすれば親ディレクトリに移動できますか?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

あるディレクトリの**親ディレクトリ**とは、そのディレクトリの1つ上にあるディレクトリのことです。
例えば、`/home` は `/home/repl` の親ディレクトリであり、
`/home/repl` は `/home/repl/seasonal` の親ディレクトリです。
`cd` や `ls` などのコマンドには、常に親ディレクトリの絶対パスを指定できます。
ただし、多くの場合は、
特殊なパスである `..`（スペースを入れずに2つのドット）を使うほうが便利です。
これは「現在のディレクトリの1つ上」を意味します。
`/home/repl/seasonal` にいる場合、
`cd ..` を実行すると `/home/repl` に移動します。
もう一度 `cd ..` を実行すると、
`/home` に移動します。
さらに `cd ..` を実行すると、*ルートディレクトリ* `/` に移動します。
これはファイルシステムの最上位です。
（`cd` と `..` の間にはスペースを入れることを忘れないようにしましょう。これは1つの4文字のコマンドではなく、コマンドとパスの組み合わせです。）

単独のドット `.` は、常に「現在のディレクトリ」を意味します。
そのため、`ls` 単独と `ls .` は同じ結果になりますが、
`cd .` は何も変化を起こしません
（現在いるディレクトリ自体に移動することになるためです）。

最後にもう1つの特殊なパスとして `~`（チルダ記号）があります。
これは「自分のホームディレクトリ」を意味し、
例えば `/home/repl` を指します。
どこにいても、`ls ~` は常にホームディレクトリの内容を一覧表示し、`cd ~` は常にホームディレクトリに移動します。

<hr>
もし `/home/repl/seasonal` にいるなら、`cd ~/../.` はどこにあなたを移動させますか?

`@hint`
パスを一つのディレクトリずつ追跡します。

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (ルートディレクトリ)

`@feedback`
- 不正解です。ただし、`~` または `..` 単独であればそこに移動できます。
- 正解です！ このパスは「ホームディレクトリ」「1つ上」「ここ」という意味になります。
- 不正解です。ただし、`.` 単独であればそれが可能です。
- 不正解です。このパスの最後の部分は「ここ」を意味する `.` であり、「1つ上」を意味する `..` ではありません。

---

## ファイルをコピーするにはどうすればよいですか？

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

ファイルをコピーしたり、
整理のために別のディレクトリへ移動したり、
名前を変更したりしたい場面はよくあります。
これを行うコマンドの1つが「コピー」を意味する `cp` です。
もし `original.txt` が既存のファイルであれば、
次のようにすると:

```{shell}
cp original.txt duplicate.txt
```

`original.txt` のコピーが `duplicate.txt` という名前で作成されます。
もし `duplicate.txt` という名前のファイルがすでに存在していた場合は、
そのファイルが上書きされます。
`cp` の最後のパラメータが既存のディレクトリである場合、
次のようなコマンドは:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

*すべての*ファイルをそのディレクトリにコピーします。

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
`seasonal/summer.csv` のコピーを `backup` ディレクトリ（同じく `/home/repl` 内にあります）に作成し、
新しいファイル名を `summer.bck` にしてください。

`@hint`
宛先ディレクトリの名前とコピーしたファイルの名前を組み合わせて
新しいファイルの相対パスを作成します。

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
`spring.csv`と`summer.csv`を`seasonal`ディレクトリから`backup`ディレクトリにコピーします
*現在のワーキングディレクトリ(`/home/repl`)を変更せずに*

`@hint`
コピーしたいファイルの名前と`cp`を指定し、
*その後に*コピー先のディレクトリ名を指定して使いましょう。

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

## ファイルを移動するにはどうすればいいですか？

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

`cp`がファイルをコピーするのに対し、
`mv`はそれをあるディレクトリから別のディレクトリへ移動します。
まるでグラフィカルなファイルブラウザでドラッグしたかのようです。
パラメータの扱いは`cp`と同じです。
そのため、次のコマンドは:

```{shell}
mv autumn.csv winter.csv ..
```

現在のワーキングディレクトリからファイル`autumn.csv`と`winter.csv`を
親ディレクトリへ移動します
(`..`は常に現在の位置の1つ上のディレクトリを指すためです。)

`@instructions`
現在、`/home/repl` にいて、`seasonal` と `backup` というサブディレクトリがあります。
1つのコマンドを使って、`spring.csv` と `summer.csv` を `seasonal` から `backup` へ移動しましょう。

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

## ファイルの名前を変更するには？

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` はファイル名の変更にも使えます。次のコマンドを実行すると:

```{shell}
mv course.txt old-course.txt
```

現在のワーキングディレクトリにある `course.txt` というファイルが `old-course.txt` に「移動」されます。
これはファイルブラウザの動作とは異なりますが、便利に使える場面が多くあります。

注意点が一つあります。`cp` と同様に、`mv` も既存のファイルを上書きします。
例えば、すでに `old-course.txt` というファイルがある場合、上記のコマンドを実行すると `course.txt` の内容でそのファイルが置き換えられてしまいます。

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
`seasonal` ディレクトリに移動しましょう。

`@hint`
`cd`は「ディレクトリの変更」を意味し、相対パスは先頭に「/」が付かないことを覚えておいてください。

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
ファイル `winter.csv` を `winter.csv.bck` に名前変更してください。

`@hint`
現在のファイル名と、変更後の名前をその順番で`mv`してください。

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
を実行して、`ls`すべてが正常に動作したことを確認してください。

`@hint`
コマンドを実行するときは「エンター」または「リターン」を押すのを忘れないでください。

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

## ファイルを削除するにはどうすればよいですか？

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

これまでファイルのコピーや移動を行ってきました。
ファイルを削除するには、`rm` を使います。
これは「取り除く」の略です。
`cp` や `mv` と同じように、`rm` にも好きなだけファイル名を指定できます。つまり：

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

このコマンドは `thesis.txt` と `backup/thesis-2017-08.txt` の両方を削除します。

`rm` はその名前の通り、削除をその場で実行します。
グラフィカルなファイルブラウザとは異なり、シェルにはごみ箱がありません。
そのため、上記のコマンドを実行すると、ファイルは完全に消えてしまいます。

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
あなたは`/home/repl`にいます。
`seasonal`ディレクトリに入ってください。

`@hint`
`cd` は「ディレクトリを変更する」を表し、相対パスは先頭に「/」が付かないことを思い出してください。

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
`autumn.csv`を取り除く。

`@hint`
`rm`は「削除」を意味することを覚えておいてください。

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
パスを指定せずに `cd` を使うと、ホームへ移動します。

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
ディレクトリを再度変更せずに `seasonal/summer.csv` を取り除いてください。

`@hint`
`rm`は「削除」を意味することを覚えておいてください。

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

## ディレクトリはどのように作成・削除できますか？

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` はディレクトリもファイルと同じ方法で扱います。
たとえば、ホームディレクトリにいる状態で `mv seasonal by-season` を実行すると、
`mv` は `seasonal` ディレクトリの名前を `by-season` に変更します。
しかし、
`rm` の動作は異なります。

ディレクトリに対して `rm` を実行しようとすると、シェルはそれができないというエラーメッセージを表示します。
これは主に、作業ファイルがたくさん入ったディレクトリを誤って削除してしまうのを防ぐためです。
代わりに、
`rmdir` という別のコマンドを使用できます。
安全性を高めるため、
このコマンドはディレクトリが空の場合にのみ動作します。
つまり、ディレクトリを削除する*前に*、その中のファイルを削除しておく必要があります。
（上級者は `-r` に `rm` オプションを付けることで同じ効果を得られます。
コマンドのオプションについては次の章で説明します。）

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
ディレクトリを変えずに、
`agarwal.txt` ディレクトリ内のファイル `people` を削除してください。

`@hint`
`rm`は「削除」を意味し、相対パスは先頭に「/」が付かないことを覚えておいてください。

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
1 つのコマンドで削除してください。

`@hint`
`rm` はファイルに対してのみ動作することを覚えておいてください。

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
新しい（空の）ディレクトリを作成するには `mkdir directory_name` というコマンドを使用する必要があります。
このコマンドを使って、ホームディレクトリの直下に `yearly` という新しいディレクトリを作成してください。

`@hint`
作成したいディレクトリの名前を指定して `mkdir` を実行してください。

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
`yearly` が存在したら、
ホームディレクトリから*移動せずに*、
その中に別のディレクトリ `2017` を作成してください。

`@hint`
作成したいサブディレクトリには相対パスを使用してください。

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

データを分析する際には、しばしば中間ファイルを作成します。
ホームディレクトリに保存するのではなく、
`/tmp`に入れてください。
そこは、人々やプログラムが短時間しか必要としないファイルをよく置いておく場所です。
(`/tmp`はルートディレクトリ`/`の直下にあります。
*ホームディレクトリの下では*ありません。)
このまとめの演習では、その方法を示します。

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
を使って`cd`に移動してください`/tmp`。

`@hint`
`cd`は「ディレクトリを変更する」を意味し、絶対パスは「/」で始まることを覚えておきましょう。

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
ディレクトリ名を入力せずに`/tmp`の内容を一覧表示してください。

`@hint`
何を一覧表示するか `ls` に指定しない場合、現在のディレクトリにあるものが表示されます。

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
`/tmp` の中に `scratch` という名前の新しいディレクトリを作成してください。

`@hint`
`mkdir` を使用してディレクトリを作成します。

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
`/home/repl/people/agarwal.txt` を `/tmp/scratch` に移動しましょう。
1つ目のパスにはホームディレクトリを表す `~` のショートカットを、2つ目のパスには絶対パスではなく相対パスを使うことをおすすめします。

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

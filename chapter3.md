---
title       : Combining tools
description : >-
  The real power of the Unix shell lies not in the individual commands,
  but in how easily they can be combined to do new things.
  This chapter will show you how to use this power to select the data you want,
  and introduce commands for sorting values and removing duplicates.

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:07a427d50c
## How can I store a command's output in a file?

All of the tools you have seen so far let you name input files.
Most don't have an option for naming an output file because they don't need one.
Instead,
you can use **redirection** to save any command's output anywhere you want.
If you run this command:

```{shell}
head -n 5 seasonal/summer.csv
```

it prints the first 5 lines of the summer data on the screen.
If you run this command instead:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

nothing appears on the screen.
Instead,
`head`'s output is put in a new file called `top.csv`.
You can take a look at that file's contents using `cat`:

```{shell}
cat top.csv
```

The greater-than sign `>` tells the shell to redirect `head`'s output to a file.
It isn't part of the `head` command;
instead,
it works with every shell command that produces output.

*** =instructions

Combine `tail` with redirection to save the last 5 lines of `seasonal/winter.csv` in a file called `last.csv`.

*** =hint

Use `tail -n 5` to get the last 5 lines.

*** =solution
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

*** =sct
```{python}
patt = "The line `%s` should be in the file `last.csv`, but it isn't. Redirect the output of `tail -n 5 seasonal/winter.csv` to `last.csv` with `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` has too many lines. Did you use the flag `-n 5` with `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Nice! Let's practice some more!")
```

--- type:BulletConsoleExercise key:f47d337593
## How can I use a command's output as an input?

Suppose you want to get lines from the middle of a file.
More specifically,
suppose you want to get lines 3-5 from one of our data files.
You can start by using `head` to get the first 5 lines
and redirect that to a file,
and then use `tail` to select the last 3:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

A quick check confirms that this is lines 3-5 of our original file,
because it is the last 3 lines of the first 5.

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 35bbb5520e

*** =xp1: 10

*** =instructions1

Select the last two lines from `seasonal/winter.csv`
and save them in a file called `bottom.csv`.

*** =hint1

Use `tail` to select lines and `>` to redirect `tail`'s output.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv
```

*** =sct1
```{python}
patt="The line `%s` should be in the file `bottom.csv`, but it isn't. Redirect the output of `tail -n 2 seasonal/winter.csv` to `bottom.csv` with `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` has too many lines. Did you use the flag `-n 2` with `tail`?'),
        has_code('2017-08-11,wisdom', incorrect_msg=patt%"2017-08-11,wisdom"),
        has_code('2017-08-13,canine', incorrect_msg=patt%"2017-08-13,canine")
    )
)
```

*** =type2: ConsoleExercise
*** =key2: c94d3936a7

*** =xp2: 10

*** =instructions2

Select the first line from `bottom.csv`
in order to get the second-to-last line of the original file.

*** =hint2

Use `head` to select the line you want.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
head -n 1 bottom.csv
```

*** =sct2
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="There's something wrong with the `bottom.csv` file. Make sure you don't change it!"),
    has_expr_output(strict=True, incorrect_msg="Have you used `head` correctly on `bottom.csv`? Make sure to use the `-n` flag correctly.")
)

Ex().success_msg("Well done. Head over to the next exercise to find out about better ways to combine commands.")                             
```

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:b36aea9a1e
## What's a better way to combine commands?

Using redirection to combine commands has two drawbacks:

1. It leaves a lot of intermediate files lying around (like `top.csv`).
2. The commands to produce your final result are scattered across several lines of history.

The shell provides another tool that solves both of these problems at once called a **pipe**.
Once again,
start by running `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

Instead of sending `head`'s output to a file,
add a vertical bar and the `tail` command *without* a filename:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

The pipe symbol tells the shell to use the output of the command on the left
as the input to the command on the right.

*** =instructions

Use `cut` to select all of the tooth names from column 2 of the comma delimited file `seasonal/summer.csv`, then pipe the result to `grep`, with an inverted match, to exclude the header line containing the word "Tooth". *`cut` and `grep` were covered in detail in Chapter 2, exercises 8 and 11 respectively.*

*** =hint

- The first part of the command takes the form `cut -d field_delimiter -f column_number filename`.
- The second part of the command takes the form `grep -v thing_to_match`.

*** =solution
```{shell}
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

*** =sct
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg = 'Have you piped the result of `cut -d , -f 2 seasonal/summer.csv` into `grep -v Tooth` with `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Did you exclude the `"Tooth"` header line using `grep`?')
)
Ex().success_msg("Perfect piping! This may be the first time you used `|`, but it's definitely not the last!")
```

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:b8753881d6
## How can I combine many commands?

You can chain any number of commands together.
For example,
this command:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

will:

1. select the first column from the spring data;
2. remove the header line containing the word "Date"; and
3. select the first 10 lines of actual data.

*** =instructions

In the previous exercise, you used the following command to select all the tooth names from column 2 of `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Extend this pipeline with a `head` command to only select the very first tooth name.

*** =hint

Copy and paste the code in the instructions, append a pipe, then call `head` with the `-n` flag.

*** =solution
```{shell}
cut -d , -f 2 seasonal/autumn.csv | grep -v Tooth | head -n 1
```

*** =sct
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    # for some reason has_expr_output with strict=True does not work here...
    has_output('^\s*canine\s*$', incorrect_msg = "Have you used `|` to extend the pipeline with a `head` command? Make sure to set the `-n` flag correctly."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Have you used `|` to extend the pipeline with a `head` command?")
)
Ex().success_msg("Cheerful chaining! By chaining several commands together, you can build powerful data manipulation pipelines.")
```

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:ae6a48d6aa
## How can I count the records in a file?

The command `wc` (short for "word count") prints the number of characters, words, and lines in a file.
You can make it print only one of these using `-c`, `-w`, or `-l` respectively.

*** =instructions
Count how many records in `seasonal/spring.csv` have dates in July 2017. To do this, use `grep` with a partial date to select the lines and pipe this result into `wc` with an appropriate flag to count the lines.

*** =hint

- Use `head seasonal/spring.csv` to remind yourself of the date format.
- The first part of the command tkaes the form `grep thing_to_match filename`.
- After the pipe, `|`, call `wc` with the `-l` flag.

*** =solution
```{shell}
grep 2017-07 seasonal/spring.csv | wc -l
```

*** =sct
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("grep", incorrect_msg = "Did you call `grep`?"),
      has_code("2017-07", incorrect_msg = "Did you search for `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Did you search the `seasonal/spring.csv` file?"),
      has_code("|", incorrect_msg = "Did you pipe to `wc` using `|`?"),      
      has_code("wc", incorrect_msg = "Did you call `wc`?"),
      has_code("-l", incorrect_msg = "Did you count lines with `-l`?")
    )
  )
)
Ex().success_msg("Careful counting! Determining how much data you have is a great first step in any data analysis.")
```

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:602d47e70c
## How can I specify many files at once?

Most shell commands will work on multiple files if you give them multiple filenames.
For example,
you can get the first column from all of the seasonal data files at once like this:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

But typing the names of many files over and over is a bad idea:
it wastes time,
and sooner or later you will either leave a file out or repeat a file's name.
To make your life better,
the shell allows you to use **wildcards** to specify a list of files with a single expression.
The most common wildcard is `*`,
which means "match zero or more characters".
Using it,
we can shorten the `cut` command above to this:

```{shell}
cut -d , -f 1 seasonal/*
```

or:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

*** =instructions

Write a single command using `head` to get the first three lines from both `seasonal/spring.csv` and `seasonal/summer.csv`, a total of six lines of data, but *not* from the autumn or winter data files.
Use a wildcard instead of spelling out the files' names in full.

*** =hint

- The command takes the form `head -n number_of_lines filename_pattern`.
- You could match files in directory `a`, starting with `b`, using `a/b*`, for example.

*** =solution
```{shell}
head -n 3 seasonal/s* # ...or seasonal/s*.csv, or even s*/s*.csv
```

*** =sct
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg = "You can use `seasonal/s*` to select `seasonal/spring.csv` and `seasonal/summer.csv`. Make sure to only include the first three lines of each file with the `-n` flag!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Don't include the output for `seasonal/autumn.csv`. You can use `seasonal/s*` to select `seasonal/spring.csv` and `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Don't include the output for `seasonal/winter.csv`. You can use `seasonal/s*` to select `seasonal/spring.csv` and `seasonal/summer.csv`")
)
Ex().success_msg("Wild wildcard work! This becomes even more important if your directory contains hundreds or thousands of files.")
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:f8feeacd8c
## What other wildcards can I use?

The shell has other wildcards as well,
though they are less commonly used:

- `?` matches a single character, so `201?.txt` will match `2017.txt` or `2018.txt`, but not `2017-01.txt`.
- `[...]` matches any one of the characters inside the square brackets, so `201[78].txt` matches `2017.txt` or `2018.txt`, but not `2016.txt`.
- `{...}` matches any of the comma-separated patterns inside the curly brackets, so `{*.txt, *.csv}` matches any file whose name ends with `.txt` or `.csv`, but not files whose names end with `.pdf`.

<hr/>

Which expression would match `singh.pdf` and `johel.txt` but *not* `sandhu.pdf` or `sandhu.txt`?

*** =possible_answers
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

*** =hint

Match each expression against each filename in turn.

*** =feedback
- No: `.pdf` and `.txt` are not filenames.
- No: this will match `sandhu.pdf`.
- No: the expression in square brackets matches only one character, not entire words.
- Correct!

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:f06d9e310e
## How can I sort lines of text?

As its name suggests,
`sort` puts data in order.
By default it does this in ascending alphabetical order,
but the flags `-n` and `-r` can be used to sort numerically and reverse the order of its output,
while `-b` tells it to ignore leading blanks
and `-f` tells it to **f**old case (i.e., be case-insensitive).
Pipelines often use `grep` to get rid of unwanted records
and then `sort` to put the remaining records in order.

*** =instructions

Remember the combination of `cut` and `grep` to select all the tooth names from column 2 of `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Starting from this recipe, sort the names of the teeth in `seasonal/winter.csv` (not `summer.csv`) in descending alphabetical order. To do this, extend the pipeline with a `sort` step.

*** =hint

Copy and paste the command in the instructions, change the filename, append a pipe, then call `sort` with the `-r` flag.

*** =solution
```{shell}
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth | sort -r
```

*** =sct
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("cut", incorrect_msg = "Did you call `cut`?"),
      has_code("-d", incorrect_msg = "Did you specify a field delimiter with `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Did you get data from the `seasonal/winter.csv` file?"),
      has_code("|", incorrect_msg = "Did you pipe from `cut` to `grep` to `sort` using `|`?"),      
      has_code("grep", incorrect_msg = "Did you call `grep`?"),
      has_code("-v", incorrect_msg = "Did you invert the match with `-v`?"),
      has_code("Tooth", incorrect_msg = "Did you search for `Tooth`?"),
      has_code("sort", incorrect_msg = "Did you call `sort`?"),
      has_code("-r", incorrect_msg = "Did you reverse the sort order with `-r`?")
    )
  )
)
Ex().success_msg("Sorted! `sort` has many uses. For example, piping `sort -n` to `head` shows you the largest values.")
```

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:ed77aed337
## How can I remove duplicate lines?

Another command that is often used with `sort` is `uniq`,
whose job is to remove duplicated lines.
More specifically,
it removes *adjacent* duplicated lines.
If a file contains:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

then `uniq` will produce:

```
2017-07-03
2017-08-03
```

but if it contains:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

then `uniq` will print all four lines.
The reason is that `uniq` is built to work with very large files.
In order to remove non-adjacent lines from a file,
it would have to keep the whole file in memory
(or at least,
all the unique lines seen so far).
By only removing adjacent duplicates,
it only has to keep the most recent unique line in memory.

*** =instructions

Write a pipeline to:

- get the second column from `seasonal/winter.csv`,
- remove the word "Tooth" from the output so that only tooth names are displayed,
- sort the output so that all occurrences of a particular tooth name are adjacent; and
- display each tooth name once along with a count of how often it occurs.

The start of your pipeline is the same as the previous exercise:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Extend it with a `sort` command, and use `uniq -c` to display unique lines with a count of how often each occurs rather than using `uniq` and `wc`.

*** =hint

Copy and paste the command in the instructions, pipe to `sort` without flags, then pipe again to `uniq` with a `-c` flag.

*** =solution
```{shell}
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth | sort | uniq -c
```

*** =sct
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_correct(
        has_expr_output(),
        multi(
            has_code('cut\s+-d\s+,\s+-f\s+2\s+seasonal/winter.csv\s+\|\s+grep\s+-v\s+Tooth',
                     incorrect_msg="You should start from this command: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Now extend it!"),
            has_code('\|\s+sort', incorrect_msg="Have you extended the command with `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="Have you extended the command with `| uniq`?"),
            has_code('-c', incorrect_msg="Have you included counts with `-c`?")
        )
    )
)
Ex().success_msg("Great! After all of this work on a pipe, it would be nice if we could store the result, no?")
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:4115aa25b2
## How can I save the output of a pipe?

The shell lets us redirect the output of a sequence of piped commands:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

However, `>` must appear at the end of the pipeline:
if we try to use it in the middle, like this:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

then all of the output from `cut` is written to `teeth-only.txt`,
so there is nothing left for `grep`
and it waits forever for some input.

<hr>

What happens if we put redirection at the front of a pipeline as in:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

*** =instructions
- [The command's output is redirected to the file as usual.]
- The shell reports it as an error.
- The shell waits for input forever.

*** =hint

Try it out in the shell.

*** =pre_exercise_code
```{python}
```

*** =sct
```{python}
Ex().has_chosen(1, ['Correct!', 'No; the shell can actually execute this.', 'No; the shell can actually execute this.'])
```

--- type:ConsoleExercise xp:100 key:d1694dbdcd
## How can I stop a running program?

The commands and scripts that you have run so far have all executed quickly,
but some tasks will take minutes, hours, or even days to complete.
You may also mistakenly put redirection in the middle of a pipeline,
causing it to hang up.
If you decide that you don't want a program to keep running,
you can type Ctrl-C to end it.
This is often written `^C` in Unix documentation;
note that the 'c' can be lower-case.

*** =instructions

Run the command:

```{shell}
head
```

with no arguments (so that it waits for input that will never come)
and then stop it by typing <kbd>Ctrl</kbd> + <kbd>C</kbd>.

*** =hint

Simply type head, hit Enter and exit the running program with Ctrl + C.

*** =solution
```{shell}
# Simply type head, hit Enter and exit the running program with Ctrl + C.
```

*** =sct
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Have you used `head`?")
```

--- type:BulletConsoleExercise key:659d3caa48
## Wrapping up

To wrap up,
you will build a pipeline to find out how many records are in the shortest of the seasonal data files.

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: b1f9c8ff84

*** =xp1: 10

*** =instructions1

Use `wc` with appropriate parameters to list the number of lines in all of the seasonal data files.
(Use a wildcard for the filenames instead of typing them all in by hand.)

*** =hint1

Use `-l` to list only the lines and `*` to match filenames.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
wc -l seasonal/*.csv
```

*** =sct1
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("wc", incorrect_msg = "Did you call `wc`?"),
      has_code("-l", incorrect_msg = "Did you count the number of lines with `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Did you get data from all `seasonal/*` files?")
    )
  )
)
```

*** =type2: ConsoleExercise
*** =key2: 7f94acc679

*** =xp2: 20

*** =instructions2

Add another command to the previous one using a pipe to remove the line containing the word "total".

*** =hint3

Use `grep` with the `-v` flag, seraching for `total` to select lines that *don't* contain the word "total".

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
wc -l seasonal/*.csv | grep -v total
```

*** =sct2
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("wc", incorrect_msg = "Did you call `wc`?"),
      has_code("-l", incorrect_msg = "Did you count the number of lines with `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Did you get data from all `seasonal/*` files?"),
      has_code("|", incorrect_msg = "Did you pipe from `wc` to `grep` using `|`?"),      
      has_code("grep", incorrect_msg = "Did you call `grep`?"),
      has_code("-v", incorrect_msg = "Did you invert the match with `-v`?"),
      has_code("total", incorrect_msg = "Did you search for `total`?")
    )
  )
)
```

*** =type3: ConsoleExercise
*** =key3: c5f55bff6b

*** =xp3: 30

*** =instructions3

Add two more stages to the pipeline that use `sort -n` and `head -n 1` to find the file containing the fewest lines.

*** =hint3

- Use `sort`'s `-n` flag to sort numerically.
- Use `head`'s `-n` flag to limit to keeping 1 line. 

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
wc -l seasonal/*.csv | grep -v total | sort -n | head -n 1
```

*** =sct3
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("wc", incorrect_msg = "Did you call `wc`?"),
      has_code("-l", incorrect_msg = "Did you count the number of lines with `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Did you get data from all `seasonal/*` files?"),
      has_code("|", incorrect_msg = "Did you pipe from `wc` to `grep` to `sort` to `head` using `|`?"),      
      has_code("grep", incorrect_msg = "Did you call `grep`?"),
      has_code("-v", incorrect_msg = "Did you invert the match with `-v`?"),
      has_code("total", incorrect_msg = "Did you search for `total`?"),
      has_code("sort", incorrect_msg = "Did you call `sort`?"),
      has_code("-n", incorrect_msg = "Did you specify the number of lines to keep with `-n`?"),
      has_code("1", incorrect_msg = "Did you specify 1 line to keep with `-n 1`?")
    )
  )
)
Ex().success_msg("Great! It turns out `autumn.csv` is the file with the fewest lines. Rush over to chapter 4 to learn more about batch processing!")
```

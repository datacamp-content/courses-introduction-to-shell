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

Save the last 5 lines of `seasonal/winter.csv` in a file called `last.csv`.
(Use `tail` to get the last 5 lines.)

*** =solution
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

*** =sct
```{python}
import os
from shellwhat_ext import test_cmdline, test_file_content_condition, rxc
Ex() >> test_cmdline([['tail', 'n:', rxc(r'seasonal/winter.csv$'), {'-n': '5'}]],
                     redirect='last.csv',
                     msg='Use `tail` (with the proper flag) and `>` together.') \
     >> test_file_content_condition('/home/repl/last.csv',
                                    lambda t: len(t.strip().split()) == 5,
                                    'Expected to find 5 lines in last.csv')
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
from shellwhat_ext import test_cmdline, test_file_content_condition, rxc
Ex() >> test_cmdline([['tail', 'n:', rxc(r'seasonal/winter.csv$'), {'-n' : '2'}]],
                     redirect='bottom.csv',
                     msg='Use `tail` and `>` together.') \
     >> test_file_content_condition('/home/repl/bottom.csv',
                                    lambda t: len(t.strip().split()) == 2,
                                    'Expected to find 2 lines in bottom.csv')
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
from shellwhat_ext import test_cmdline, test_output_condition, rxc
Ex() >> test_cmdline([['head', 'n:', rxc(r'bottom.csv$'), {'-n' : '1'}]],
                     msg='Use `head` on the temporary file.') \
     >> test_output_condition(lambda s: len(s.strip().split('\n')) == 1,
                              msg="Expected a single line of output")
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

Write a pipeline that uses `cut` to select all of the tooth names from column 2 of `seasonal/summer.csv`
and then `grep -v` to exclude the header line containing the word "Tooth".

*** =solution
```{shell}
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

*** =sct
```{python}
from shellwhat_ext import test_cmdline, test_output_does_not_contain, rxc
Ex() >> test_cmdline([['cut', 'd:f:', rxc(r'seasonal/summer.csv$'), {'-d' : ',', '-f' : '2'}],
                      ['grep', 'v', 'Tooth', {'-v': None}]],
                     msg='Use `cut` with `-d` and `-f` on `seasonal/summer.csv` and then `grep` with `-v` and the word to exclude.')
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

Write a pipeline that uses `cut`, `grep`, and `head` in that order
to select the first value in column 2 of `seasonal/autumn.csv`
*after* the header "Tooth".

*** =solution
```{shell}
cut -d , -f 2 seasonal/autumn.csv | grep -v Tooth | head -n 1
```

*** =sct
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['cut', 'd:f:', re.compile(r'^([.~]/)?seasonal/autumn.csv$'), {'-d' : ',', '-f' : '2'}],
                      ['grep', 'v', 'Tooth', {'-v': None}],
                      ['head', 'n:', None, {'-n' : '1'}]],
                     msg='Use `cut` to get columns, `grep` to remove the header line, and `head` to select one row.')
```

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:ae6a48d6aa
## How can I count the records in a file?

The command `wc` (short for "word count") prints the number of characters, words, and lines in a file.
You can make it print only one of these using `-c`, `-w`, or `-l` respectively.

*** =instructions

Use `grep` and `wc` in a pipe to count how many records in `seasonal/spring.csv`
have dates in July 2017.
(Use `grep` with a partial date to select the lines and `wc` with an appropriate flag to count.
Remember, the two columns in the CSV file are `Date` and `Tooth`.)

*** =solution
```{shell}
grep 2017-07 seasonal/spring.csv | wc -l
```

*** =sct
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['grep', '', [re.compile('((2017)?-07-?)|(((2017)?-)?07-)'), re.compile(r'^([.~]/)?seasonal/spring.csv$')]],
                      ['wc', 'l']],
                     msg='Use `grep` and `wc`.') \
     >> test_output_contains('3', msg="That doesn't appear to be the right number of lines.")
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

Write a single command using `head` to get the first three lines from both `seasonal/spring.csv` and `seasonal/summer.csv`
(a total of six lines of data)
but *not* from the autumn or winter data files.
Use a wildcard instead of spelling out the files' names in full.

*** =solution
```{shell}
head -n 3 seasonal/s* # ...or seasonal/s*.csv, or even s*/s*.csv
```

*** =sct
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_student_typed(r'\s*head\s+-n\s+3\s+(([.~]/)?s.+/s.+)\s*',
                           fixed=False,
                           msg='Remember that "spring" and "summer" both start with "s".') \
     >> test_output_contains('seasonal/spring.csv',
                             msg="The name of the spring data file should have been in the output") \
     >> test_output_contains('seasonal/summer.csv',
                             msg="The name of the summer data file should have been in the output")
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

*** =feedbacks
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

Write a pipeline to sort the names of the teeth in `seasonal/winter.csv` in descending alphabetical order
*without* including the header "Tooth".
Use `cut`, `grep`, and `sort` in that order,
and remember that the names are in column 2.
(Please use tab completion to fill in the complete filename rather than using wildcards.)

*** =solution
```{shell}
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth | sort -r
```

*** =sct
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['cut', 'd:f:', re.compile(r'^([.~]/)?seasonal/winter.csv$'), {'-d': ',', '-f' : '2'}],
                      ['grep', 'v', 'Tooth', {'-v': None}],
                      ['sort', 'r']],
                     msg='Use `cut` to get the column, `grep` to get rid of the header, and `sort -r` to sort.') \
     >> test_output_does_not_contain('Tooth', msg='The word "Tooth" should not be in the output') \
     >> test_output_condition(lambda s: len(s.strip().split('\n')) == 25,
                              msg="The output doesn't have the expected number of lines")
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

Use `uniq -c` to display unique lines with a count of how often each occurs
rather than using `uniq` and `wc`.

*** =solution
```{shell}
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth | sort | uniq -c
```

*** =sct
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['cut', 'd:f:', re.compile(r'^([.~]/)?s.+/.*\*.*$'), {'-d': ',', '-f' : '2'}],
                      ['grep', 'v', 'Tooth', {'-v': None}],
                      ['sort', 'r'],
                      ['uniq', 'c']],
                     msg='Use `cut`, `grep -v`, `sort`, and `uniq -c`.') \
     >> test_output_condition(lambda s: len(s.strip().split('\n')) == 5,
                              msg="Expected to find 5 different kinds of teeth")
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
Ex() >> test_mc(1, ['Correct!',
                    'No: the shell can actually execute this.',
                    'No: the shell can actually execute this.'])
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
and then stop it by typing Ctrl-C.

*** =solution
```{bash}
# Use 'echo' rather than actually running the command to prevent automated tests hanging up: 
echo 'head'
```

*** =sct
```{python}
Ex() >> test_student_typed(r'\s*head\s*',
                           fixed=False,
                           msg="Use the control key and 'c' at the same time to stop the script.")
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
from shellwhat_ext import test_cmdline, test_output_condition, rxc
Ex() >> test_cmdline([['wc', 'l', rxc(r'seasonal/\*.*?$')]],
                     msg='Use `wc -l` and `seasonal/*.csv`.') \
     >> test_output_condition(lambda s: len(s.strip().split('\n')) == 5,
                              msg="There should be one line of output for each file, plus another for the total")
```

*** =type2: ConsoleExercise
*** =key2: 7f94acc679

*** =xp2: 20

*** =instructions2

Add another command to the previous one using a pipe to remove the line containing the word "total".

*** =hint3

Use `grep -v` to select lines that *don't* contain certain text.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
wc -l seasonal/*.csv | grep -v total
```

*** =sct2
```{python}

from shellwhat_ext import test_cmdline, test_output_condition
Ex() >> test_cmdline([['wc', 'l', '+'],
                      ['grep' ,'v', 'total']],
                     msg='Use `grep -v total` as the second stage of the pipe.') \
     >> test_output_condition(lambda s: len(s.strip().split('\n')) == 4,
                              msg="There should be exactly one line of output for each file")
```

*** =type3: ConsoleExercise
*** =key3: c5f55bff6b

*** =xp3: 30

*** =instructions3

Add two more stages to the pipeline that use `sort` and `head -n 1` to find the file containing the fewest lines.

*** =hint3

Remember to use `sort -n` to sort numerically.

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
wc -l seasonal/*.csv | grep -v total | sort -n | head -n 1
```

*** =sct3
```{python}
from shellwhat_ext import test_cmdline, test_output_condition
Ex() >> test_cmdline([['wc', 'l', '+'],
                      ['grep', 'v', 'total', {'-v': None}],
                      ['sort', 'n'],
                      ['head', 'n:', None, {'-n' : '1'}]],
                     msg='Use `sort -n` and `head -n 1`.') \
     >> test_output_condition(lambda s: len(s.strip().split('\n')) == 1,
                              msg="There should only be one line of output") \
     >> test_output_contains('autumn.csv',
                             msg="The file 'autumn.csv' is the shortest.")
```

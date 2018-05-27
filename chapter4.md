---
title       : Batch processing
description : >-
  Most shell commands will process many files at once.
  This chapter will show you how to make your own pipelines do that.
  Along the way, you will see how the shell uses variables to store information.

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:e4d5f4adea
## How does the shell store information?

Like other programs, the shell stores information in variables.
Some of these,
called **[environment variables](http://datacamp.github.io/glossary/#(http://datacamp.github.io/glossary/#environment-variable)**,
are available all the time.
Environment variables' names are conventionally written in upper case,
and a few of the more commonly-used ones are shown below.

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | User's home directory             | `/home/repl`          |
| `PWD `   | Present working directory         | Same as `pwd` command |
| `SHELL`  | Which shell program is being used | `/bin/bash`           |
| `USER`   | User's ID                         | `repl`                |

To get a complete list (which is quite long),
you can type `set` in the shell.

<hr>

Use `set` and `grep` with a pipe to display the value of `HISTFILESIZE`,
which determines how many old commands are stored in your command history.
What is its value?

*** =instructions
- 10
- 500
- [2000]
- The variable is not there.

*** =hint

Use `set | grep HISTFILESIZE` to get the line you need.

*** =pre_exercise_code
```{python}
```

*** =sct
```{python}
err1 = "No: the shell records more history than that."
err2 = "No: the shell records more history than that."
correct3 = "Correct: the shell saves 2000 old commands by default on this system."
err4 = "No: the variable `HISTFILESIZE` is there."
Ex() >> test_mc(3, [err1, err2, correct3, err4])
```

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:afae0f33a7
## How can I print a variable's value?

A simpler way to find a variable's value is to use a command called `echo`,
which prints its arguments:

```{shell}
echo hello DataCamp!
```
```
hello DataCamp!
```

If you try to use it to print a variable's value like this:

```{shell}
echo USER
```
```
USER
```

it will print the variable's name.
To get the variable's value,
you must put a dollar sign `$` in front of it:

```{shell}
echo $USER
```
```
repl
```

This is true everywhere:
to get the value of a variable called `X`,
you must write `$X`.
(This is so that the shell can tell whether you mean "a file named X"
or "the value of a variable named X".)

*** =instructions

The variable `OSTYPE` holds the name of the kind of operating system you are using.
Display its value using `echo`.

*** =solution
```{shell}
echo $OSTYPE
```

*** =sct
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['echo', '', re.compile(r'\$OSTYPE')]],
                     msg='Remember to put `$` in front of the variable name')
```

--- type:BulletConsoleExercise key:e925da48e4
## How else does the shell store information?

The other kind of variable is called a **[shell variable](http://datacamp.github.io/glossary/#shell-variable)**,
which is like a local variable in a programming language.

To create a shell variable,
you simply assign a value to a name:

```{shell}
training=seasonal/summer.csv
```

*without* any spaces before or after the `=` sign.
Once you have done this,
you can check the variable's value with:

```{shell}
echo $training
```
```
seasonal/summer.csv
```

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 78f7fd446f

*** =xp1: 10

*** =instructions1

Define a variable called `testing` with the value `seasonal/winter.csv`.

*** =hint1

There should *not* be spaces between the variable's name and its value.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
testing=seasonal/winter.csv
```

*** =sct1
```{python}
Ex() >> test_student_typed(r'\s*testing=seasonal/winter\.csv\s*',
                           fixed=False,
                           msg='Set `testing` with `variable=value`.')
```

*** =type2: ConsoleExercise
*** =key2: d5e7224f55

*** =xp2: 10

*** =instructions2

Use `head -n 1 SOMETHING` to get the first line from `seasonal/winter.csv`
using the value of the variable `testing` instead of the name of the file.

*** =hint2


Remember to use `$testing` rather than just `testing`
(the `$` is needed to get the value of the variable).


*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
# We need to re-set the variable for testing purposes for this exercise - you should only run "head -n 1 $testing"
testing=seasonal/winter.csv
head -n 1 $testing
```

*** =sct2
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['head', 'n:', re.compile(r'\$testing'), {'-n' : '1'}]],
                     last_line=True,
                     msg='Did you use `head` with `$testing` as an argument?') \
     >> test_expr('head -n 1 seasonal/winter.csv', msg = 'Did you use `head` with `$testing` as an argument?')
```

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:920d1887e3
## How can I repeat a command many times?

Shell variables are also used in **[loops](http://datacamp.github.io/glossary/#loop)**,
which repeat commands many times.
If we run this command:

```{shell}
for suffix in gif jpg png; do echo $suffix; done
```

it produces:

```
gif
jpg
png
```

The loop's parts are:

1. The skeleton `for` ...variable... `in` ...list... `; do` ...body... `; done`
2. The list of things the loop is to process (in our case, the words `gif`, `jpg`, and `png`).
3. The variable that keeps track of which thing the loop is currently processing (in our case, `suffix`).
4. The body of the loop that does the processing (in our case, `echo $suffix`).

Notice that the body uses `$suffix` to get the variable's value instead of just `suffix`,
just like it does with any other shell variable.
Also notice where the semi-colons go:
the first one comes between the list and the keyword `do`,
and the second comes between the body and the keyword `done`.

*** =instructions

Modify the loop so that it prints:

```
docx
odt
pdf
```

Please use `suffix` as the name of the loop variable.

*** =solution
```{shell}
for suffix in docx odt pdf; do echo $suffix; done
```

*** =sct
```{python}
Ex() >> test_student_typed(r'\s*for\s+suffix\s+in\s+docx\s+odt\s+pdf\s*;\s*do\s+echo\s+\$suffix\s*;\s*done\s*',
                           fixed=False,
                           msg='Change the list of suffix names that the loop operatores on.')
```

--- type:ConsoleExercise xp:100 key:8468b70a71
## How can I repeat a command once for each file?

You can always type in the names of the files you want to process when writing the loop,
but it's usually better to use wildcards.
Try running this loop in the console:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

It prints:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

because the shell expands `seasonal/*.csv` to be a list of four filenames
before it runs the loop.

*** =instructions

Modify the wildcard expression to `people/*`
so that the loop prints the names of the files in the `people` directory
regardless of what suffix they do or don't have.
Please use `filename` as the name of your loop variable.

*** =solution
```{bash}
for filename in people/*; do echo $filename; done
```

*** =sct
```{python}
Ex() >> test_student_typed(r'\s*for\s+filename\s+in\s+([~.]/)?people/\*\s*;\s*do\s+echo\s+\$filename\s*;\s*done\s*',
                           fixed=False,
                           msg='Use `people/*` to get the name of all the files in the `people` directory.')
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:153ca10317
## How can I record the names of a set of files?

People often set a variable using a wildcard expression to record a list of filenames.
For example,
if you define `datasets` like this:

```{shell}
datasets=seasonal/*.csv
```

you can display the files' names later using:

```{shell}
for filename in $datasets; do echo $filename; done
```

This saves typing and makes errors less likely.

<hr>

If you run these two commands in your home directory,
how many lines of output will they print?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

*** =instructions
- None: since `files` is defined on a separate line, it has no value in the second line.
- One: the word "files".
- Four: the names of all four seasonal data files.

*** =hint

Remember that `X` on its own is just "X", while `$X` is the value of the variable `X`.

*** =pre_exercise_code
```{python}
```

*** =sct
```{python}
err1 = "No: you do not have to define a variable on the same line you use it."
err2 = "No: this example defines and uses the variable `files` in the same shell."
correct3 = "Correct."
Ex() >> test_mc(3, [err1, err2, correct3])
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:4fcfb63c4f
## What's the difference between a variable's name and its value?

A common mistake is to forget to use `$` before the name of a variable.
When you do this,
the shell uses the name you have typed
rather than the value of that variable.

A more common mistake for experienced users is to mis-type the variable's name.
For example,
if you define `datasets` like this:

```{shell}
datasets=seasonal/*.csv
```

and then type:

```{shell}
echo $datsets
```

the shell doesn't print anything,
because `datsets` (without the second "a") isn't defined.

<hr>

If you were to run these two commands in your home directory,
what output would be printed?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Read the first part of the loop carefully before answering.)

*** =possible_answers
- [One line: the word "files".]
- Four lines: the names of all four seasonal data files.
- Four blank lines: the variable `f` isn't assigned a value.

*** =hint

Remember that `X` on its own is just "X", while `$X` is the value of the variable `X`.

*** =feedbacks
- Correct: the loop uses `files` instead of `$files`, so the list consists of the word "files".
- No: the loop uses `files` instead of `$files`, so the list consists of the word "files" rather than the expansion of `files`.
- No: the variable `f` is defined automatically by the `for` loop.

--- type:ConsoleExercise xp:100 key:39b5dcf81a
## How can I run many commands in a single loop?

Printing filenames is useful for debugging,
but the real purpose of loops is to do things with multiple files.
This loop prints the second line of each data file:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

It has the same structure as the other loops you have already seen:
all that's different is that its body is a pipeline of two commands instead of a single command.

*** =instructions

Write a loop that produces the same output as

```{shell}
grep -h 2017-07 seasonal/*.csv
```

but uses a loop to process each file separately.
Please use `file` as the name of the loop variable,
and remember that the `-h` flag used above tells `grep` *not* to print filenames in the output.

*** =solution
```{bash}
for file in seasonal/*.csv; do grep 2017-07 $file; done
```

*** =sct
```{python}
Ex() >> test_student_typed(r'\s*for\s+file\s+in\s+seasonal/\*\.csv\s*;\s*do\s+grep(\s+-h)?\s+2017-07\s+\$file\s*;\s*done\s*',
                           fixed=False,
                           msg='Use `grep 2017-07 $file` as the body of the loop.')
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:b974b7f45a
## Why shouldn't I use spaces in filenames?

It's easy and sensible to give files multi-word names like `July 2017.csv`
when you are using a graphical file explorer.
However,
this causes problems when you are working in the shell.
For example,
suppose you wanted to rename `July 2017.csv` to be `2017 July data.csv`.
You cannot type:

```{shell}
mv July 2017.csv 2017 July data.csv
```

because it looks to the shell as though you are trying to move
four files called `July`, `2017.csv`, `2017`, and `July` (again)
into a directory called `data.csv`.
Instead,
you have to quote the files' names
so that the shell treats each one as a single parameter:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

If you have two files called `current.csv` and `last year.csv`
(with a space in its name)
and you type:

```{shell}
rm current.csv last year.csv
```

what will happen:

*** =possible_answers
- The shell will print an error message because `last` and `year.csv` do not exist.
- The shell will delete `current.csv`.
- [Both of the above.]
- Nothing.

*** =hint

What would you think was going to happen if someone showed you the command and you didn't know what files existed?

*** =feedbacks
- Yes, but that's not all.
- Yes, but that's not all.
- Correct.
- Unfortunately not.

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:f6d0530991
## How can I do many things in a single loop?

The loops you have seen so far all have a single command or pipeline in their body,
but a loop can contain any number of commands.
To tell the shell where one ends and the next begins,
you must separate them with semi-colons:

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

Suppose you forget the semi-colon between the `echo` and `head` commands in the previous loop,
so that you ask the shell to run:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

What will the shell do?

*** =instructions
- Print an error message.
- Print one line for each of the four files.
- Print one line for `autumn.csv` (the first file).
- Print the last line of each file.

*** =hint

You can pipe the output of `echo` to `tail`.

*** =pre_exercise_code
```{python}
```

*** =sct
```{python}
err1 = "No: the loop will run, it just won't do something sensible."
correct2 = "Yes: `echo` produces one line that includes the filename twice, which `tail` then copies."
err3 = "No: the loop runs one for each of the four filenames."
err4 = "No: the input of `tail` is the output of `echo` for each filename."
Ex() >> test_mc(2, [err1, correct2, err3, err4])
```

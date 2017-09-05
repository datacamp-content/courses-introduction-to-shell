---
title       : Batch processing
description : >-
  Most shell commands will process many files at once.
  This chapter will show you how to make your own pipelines do that.
  Along the way, you will see how the shell uses variables to store information.

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:e4d5f4adea
## Environment variables

Like other programs, the shell stores information in variables.
Some of these,
called *environment variables*,
are created by the operating system and available all the time.
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

Use `set` and `grep` to display the value of `HISTFILESIZE`,
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
```{shell}
```

*** =sct
```{python}
err1 = "No: the shell records more history than that."
err2 = "No: the shell records more history than that."
correct3 = "Correct: the shell saves 500 old commands by default on this system."
err4 = "No: the variable `HISTFILESIZE` is there."
Ex().test_mc(3, [err1, err2, correct3, err4])
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:afae0f33a7
## Using echo

The `echo` command prints its arguments:

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

This is true elsewhere as well:
to get the value of a variable called `X`,
you must write `$X`.
(This is so that the shell can tell whether you mean "a file named X"
or "the value of a variable named X".)

*** =instructions

The variable `OSTYPE` holds the name of the kind of operating system you are using.
Display its value using `echo`.

*** =hint

Remember to use `$OSTYPE` to get the variable's value.

*** =pre_exercise_code
```{shell}
```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
echo $OSTYPE
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*echo\s+\$OSTYPE\s*',
                        fixed=False,
                        msg='Remember to put `$` in front of the variable name')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:e925da48e4
## Shell variables

The other kind of variable available to you is called a *shell variable*.
It's like a local variable in a regular programming language,
in that it only has a value in the shell,
not in any programs you run from the shell.

To create a shell variable,
you simply assign a value to a name:

```{shell}
training=seasonal/summer.csv
```

and test its value with `echo`:

```{shell}
echo $training
```
```
seasonal/summer.csv
```

Any time you use `$training` after that,
the shell will replace it with `seasonal/summer.csv`.

*** =instructions

Define a shell variable called `testing` with the value `seasonal/winter.csv`,
and then use `head -n 1 $testing` to check its value.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
testing=seasonal/winter.csv
head -n 1 $testing
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*testing=seasonal/winter.csv\s+head\s+-n\s+1\s+\$testing\s*',
                        fixed=False,
                        msg='Set `testing` with `variable=value` then run `head` with `$testing`.')
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:ed34d567c3
## Creating environment variables

You create a normal shell variable by assigning a name to a value.
To create an environment variable,
you must prefix the assignment with the keyword `export`:

```{shell}
export testing=seasonal/winter.csv
```

To see the difference between the two kinds of variables,
you can define `training` to be `seasonal/summer.csv`
and `testing` to be `seasonal/winter.csv`
and then run a shell script that contains these two lines:

```{shell}
echo training is $training
echo testing is $testing
```

it prints:

```
training is
testing is seasonal/winter.csv
```

because the shell variable `training` *isn't* set in the script,
while the environment variable `testing` *is*.
(Note that if a variable doesn't have a value,
the shell replaces it with an empty string.)

<hr>

If you define two variables like this:

```{shell}
export priors=/tmp/training-set.csv
tests=/tmp/user-data.csv
```

and then run this shell script:

```{shell}
echo Priors and testing data are $priors and $tests
```

what is its output?

*** =possible_answers
- Priors and testing data are /tmp/training-set.csv and /tmp/user-data.csv
- [Priors and testing data are /tmp/training-set.csv and ]
- Priors and testing data are  and /tmp/user-data.csv
- Priors and testing data are  and 

*** =hint

The value of an undefined variable is an empty string.

*** =feedbacks
- No: `tests` is not an environment variable.
- Correct!
- No: `priors` is an environment variable but `tests` is not.
- No: `priors` is an environment variable.

--- type:NormalExercise lang:shell xp:100 skills:1 key:920d1887e3
## Loops

Shell variables are also used in *loops*,
which repeat commands many times.
Copy and paste this command into the shell:

```{shell}
for suffix in gif jpg png; do echo $suffix; done
```

and run it by pressing enter.
It produces:

```
gif
jpg
png
```

The loop's parts are:

1. The skeleton `for ...variable... in ...list...; ...body...; done
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

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
for suffix in docx odt pdf; do echo $suffix; done
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*for\s+suffix\s+in\s+docx\s+odt\s+pdf;\s+do\s+echo\s+\$suffix;\s+done\s*',
                        fixed=False,
                        msg='Change the list of suffix names that the loop operatores on.')
```

--- type:ConsoleExercise xp:100 key:8468b70a71
## Loops and wildcards

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

Modify the wildcard expression so that the loop prints the names of all the files in the `people` directory
(regardless of what suffix they do or don't have).

*** =solution
```{bash}
for filename in people/*; do echo $filename; done
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*for\s+filename\s+in\s+people/\*;\s+do\s+echo\s+\$filename;\s+done\s*',
                        fixed=False,
                        msg='Use `people/*` to get the name of all the files in the `people` directory.')
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:153ca10317
## Using variables for sets of files

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
- None: since the first line doesn't say `export files`, that variable has no value in the second line.
- One: the word "files".
- Four: the names of all four seasonal data files.

*** =hint

Remember that `X` on its own is just "X",
while `$X` is the value of the variable `X`.

*** =pre_exercise_code
```{shell}

```

*** =sct
```{python}
err1 = "No: you do not have to export a shell variable to use it in the same shell."
err2 = "No: this example defines and uses the variable `files` in the same shell."
correct3 = "Correct."
Ex().test_mc(3, [err1, err2, correct3])
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:4fcfb63c4f
## Names and values

A common mistake is to forget to use `$` before the name of a variable.
When you do this,
the shell uses the name you have typed
rather than the value of that variable.

Another common mistake is to mis-type the variable's name.
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

If you run these two commands in your home directory,
how many lines of output will they print?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Read the first part of the loop carefully before answering.)

*** =possible_answers
- None: since the first line doesn't say `export files`, that variable has no value in the second line.
- [One: the word "files".]
- Four: the names of all four seasonal data files.

*** =hint

Remember that `X` on its own is just "X", while `$X` is the value of the variable `X`.

*** =feedbacks
- No: this example defines and uses the variable `files` in the same shell.
- Correct: the loop uses `files` instead of `$files`, so the list consists of the word "files".
- No: the loop uses `files` instead of `$files`, so the list consists of the word "files" rather than the expansion of `files`.

--- type:ConsoleExercise xp:100 key:39b5dcf81a
## Pipes in loops

Printing filenames is useful for debugging,
but the real purpose of loops is to do things with multiple files.
This loop:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

prints the second line of each data file.
It has the same structure as the others you have already seen:
all that's different is that its body is a pipeline of two commands instead of a single command.

*** =instructions

Write a loop that produces the same output as

```{shell}
grep -h 2017-07 seasonal/*.csv
```

but uses a loop to process each file separately.
(Remember that the `-h` flag tells `grep` *not* to print filenames in the output.)
Use `file` as the name of the loop variable.

*** =solution
```{bash}
for file in seasonal/*.csv; do grep 2017-07 $file; done
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*for\s+(file)\s+in\s+seasonal/\*.csv;\s+do\s+grep\s+2017-07\s+\$\1;\s+done\s*',
                        fixed=False,
                        msg='Use `grep 2017-07 $file` as the body of the loop.')
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:b974b7f45a
## Spaces in filenames

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
you have quote the files' names
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

*** =feedbacks
- Yes, but that's not all.
- Yes, but that's not all.
- Correct.
- Unfortunately not.

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:f6d0530991
## Multiple commands in loops

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
```{shell}

```

*** =sct
```{python}
err1 = "No: the loop will run, it just won't do something sensible."
correct2 = "Yes: `echo` produces one line that includes the filename twice, which `tail` then copies."
err3 = "No: the loop runs one for each of the four filenames."
err4 = "No: the input of `tail` is the output of `echo` for each filename."
Ex().test_mc(2, [err1, correct2, err3, err4])
```

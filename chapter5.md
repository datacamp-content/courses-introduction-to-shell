---
title       : Batch processing
description : >-
  Most Unix commands will process many files at once.
  This chapter will show you how to make your own pipelines do that.
  Along the way, you will see how the shell uses variables to store information.

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:e4d5f4adea
## Environment variables

Like other programs, the shell stores information in variables.
Soem of these,
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
- 50
- 100
- [500]
- The variable is not there.

*** =hint

Use `set | grep HISTFILESIZE` to get the line you need.

*** =pre_exercise_code
```{shell}

```

*** =sct
```{python}
# FIXME
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:afae0f33a7
## Using echo

The `echo` command prints its arguments:

```{shell}
echo hello DataCamp!
hello DataCamp!
```

If you try to use it to print a variable's value like this:

```{shell}
echo HOME
HOME
```

it will print the variable's name.
To get the variable's value,
you must put a dollar sign `$` in front of it:

```{shell}
echo $HOME
/home/repl
```

This is true elsewhere as well:
to get the value of a variable called `X`,
you must write `$X`.
(This is so that the shell can tell whether you mean "a file named X"
or "the value of a variable named X".)

*** =instructions

Use `echo` to display the message:

```{shell}
Home is /home/repl.
```

but using the variable `HOME` instead of typing `/home/repl` in directly.

*** =hint

Remember to use `$HOME` to get the variable's value.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
echo Home is $HOME.
```

*** =sct
```{python}
# FIXME
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

Any time you use `$training` after that,
the shell will replace it with `seasonal/summer.csv`.

*** =instructions

Define a shell variable called `testing` with the value `seasonal/winter.csv`,
and then run the command `head -n 1 $testing` to check its value.

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
head -n $1 $testing
```

*** =sct
```{python}
# FIXME
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:ed34d567c3
## Creating environment variables

You create a normal shell variable by assigning a name to a value.
To create an environment variable,
you must also use the keyword `export`:

```{shell}
export testing=seasonal/winter.csv
```

To see the difference between the two kinds of variables,
you can define `training` to be `seasonal/summer.csv`
and `testing` to be `seasonal/winter.csv`
and then run the shell script `bin/show-data-sets.sh`,
which contains these two lines:

```{shell}
echo training is $training
echo testing is $testing
```

It prints:

```
training is
testing is seasonal/winter.csv
```

because the shell variable `training` *isn't* set in the script,
while the environment variable `testing` *is*.

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

--- type:ConsoleExercise xp:100 key:cea10c99b8
## Loops

Shell variables are also used in *loops*,
which repeat commands many times.
Copy and paste the following command into the shell prompt:

```{shell}
for suffix in gif jpg png; do echo $suffix; done
```

When you run it by pressing enter,
it produces:

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

*** =solution
```{bash}
for suffix in docx odt pdf; do echo $suffix; done
```

*** =sct
```{python}
# FIXME
```

--- type:ConsoleExercise xp:100 key:8468b70a71
## Loops and wildcards

If you want to loop over a set of files,
you can type in the names of those files by hand when writing the loop.
Alternatively,
you can rely the shell's expansion of wildcards.
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
*before* it runs the loop.

*** =instructions

Modify the wildcard expression so that the loop only prints the names of the spring and summer data files.

*** =solution
```{bash}
for filename in seasonal/s*.csv; do echo $filename; done
```

*** =sct
```{python}
# FIXME
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:fc218bad02
## Using variables for sets of files

It's very common to define a variable using a wildcard
in order to store the names of a set of files,
and then use that variable later.
For example,
you could define a variable like this:

```{shell}
datasets=seasonal/*.csv
```

and then display the files' names using:

```{shell}
for filename in $datasets; do echo $filename; done
```

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
- The shell will display an error message saying that `files` is not defined in the second line.

*** =hint

Remember that `X` on its own is just "X", while `$X` is the value of the variable `X`.

*** =feedbacks
- No: this example defines and uses the variable `files` in the same shell.
- Correct: the loop uses `files` instead of `$files`, so the list consists of the word "files".
- No: the loop uses `files` instead of `$files`, so the list consists of the word "files" rather than the expansion of `files`.
- No: this example defines and uses the variable `files` in the same shell.

--- type:ConsoleExercise xp:100 key:
## Pipes in loops

Printing filenames is sometimes useful for debugging,
but the main purpose of loops is to run commands independently on multiple files.
For example,
this loop:

```{shell}
for file in seasonal/*.csv; do cut -d , -f 1 $file | grep -v Date | sort | head -n 1; done
```

will print the first date in each data file separately.
The loop has the same structure as the others you have already seen:
all that's different is that its body is a pipeline of several commands instead of a single command.

*** =instructions

Write a loop that produces the same output as

```{shell}
grep -h 2017-07 seasonal/*.csv
```

but uses a loop to process each file separately.
(The `-h` flag tells `grep` *not* to print filenames in the output.)

*** =solution
```{bash}
for file in seasonal/*.csv; do grep 2017-07 $file; done
```

*** =sct
```{python}
# FIXME
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:
## Title

When you are interacting with the computer through a graphical file explorer,
it's easy and sensible to give files multi-word names like `July 2017.csv`.
However,
doing this causes problems when you are working in the shell.
For example,
suppose you wanted to rename `July 2017.csv` to be `2017 July data.csv`.
It would be natural to type:

```{shell}
mv July 2017.csv 2017 July data.csv
```

but this doesn't work,
because it looks to the shell as though you are trying to move
four files called `July`, `2017.csv`, `2017`, and `July` (again)
into a directory called `data.csv`.
Instead,
you have to put quotes around the files' names
so that the shell treats each one as a single character string:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

Rather than quoting,
it's simpler not to use spaces in filenames in the first place.

<hr>

Suppose the directory `samples` contains files called `march 2017.csv` and `october 2017.csv`.
How many lines of output will this loop produce?

```{shell}
for f in samples/*.csv; do echo $f; done
```

*** =possible_answers
- One: `samples/*.csv`.
- [Two: `samples/march 2017.csv` and `samples/october 2017.csv`]
- Four: `samples/march`, `2017.csv`, `samples/october`, and `2017.csv` again.
- Three: `samples/march`, `2017.csv`, and `samples/october` (without repeating `2017.csv`).

*** =hint

*** =feedbacks
- No: the shell expands the wildcard.
- Yes: the shell automatically quotes wildcard expansions for you.
- No: the shell automatically quotes wildcard expansions for you.
- No: the shell doesn't remove duplicates from lists.

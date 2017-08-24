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

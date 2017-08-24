---
title       : Batch processing
description : >-
  Most Unix commands will process many files at once.
  This chapter will show you how to make your own pipelines do that.
  Along the way, you will see how the shell uses variables to store information.

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:
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

--- type:NormalExercise lang:shell xp:100 skills:1 key:
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

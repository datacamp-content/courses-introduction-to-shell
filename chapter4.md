---
title       : Creating new tools
description : >-
  History lets you repeat things with just a few keystrokes,
  and pipes let you combine existing commands to create new ones.
  In this chapter, you will see how to go one step further
  and create new commands of your own.
  
--- type:NormalExercise lang:shell xp:100 skills:1 key:864f978f0d
## Shell scripts

You have been using the shell interactively so far:
each time you want to do something,
you enter a command
and the shell runs it right away.
But since the commands you type in are just text,
the shell lets you store them in files to use over and over again.

To start exploring this powerful capability,
put the following command in a file called `dates.sh`:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

Reading from left to right,
this selects the first column from all of the CSV files in the `seasonal` directory,
removes lines with the word "Date",
sorts the result,
and removes duplicates.
In short,
this pipeline produces a list of the unique dates in the seasonal date.

Once you have created this file,
run the following command:

```{shell}
bash dates.sh
```

This tells Bash (which is the shell we are using)
to run the commands contained in the file `dates.sh`.
Sure enough,
it produces the same list of dates that would have been produced
if you had typed the commands directly into the shell.
By putting those commands in a file,
though,
you have saved yourself having to remember the steps a second, third, or hundredth time,
and you can be sure that you are doing exactly the same thing
each time you get the files' unique dates.

A file full of shell commands is called a *shell script*,
or sometimes just a "script" for short.
Shell scripts don't have to have names ending in `.sh`,
but this lesson will use that convention
to help you keep track of which files are scripts and which are not.

*** =instructions

Create another shell script called `teeth.sh`
that prints a count of the number of times each tooth name appears in the seasonal data.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c
```

*** =sct
```{shell}

```

--- type:NormalExercise lang:shell xp:100 skills:1 key:1b0da86491
## Passing filenames to scripts

A script that re-runs exactly the same commands on exactly the same files is useful
as a record of what you did,
but one that allows you specify what files you want to process is usually more useful.
To help you do this,
the shell has a special expression `$@` (dollar sign immediately followed by ampersand)
that means "all of the command-line parameters given by the user when the script was run".
To see how this works,
edit `dates.sh` and replace `seasonal/*.csv` with `$@`
so that the file contains the line:

```{shell}
cut -d , -f 1 $@ | grep -v Date | sort | uniq
```

If you run the command with:

```{shell}
bash dates.sh seasonal/summer.csv`
```

then the shell replaces `$@` with `seasonal.summer.csv`
and the pipeline processes only that file.
If you run it like this:

```{shell}
bash dates.sh seasonal/autumn.csv seasonal/winter.csv
```

it processes those two files,
while:

```{shell}
bash dates.sh seasonal/*.csv
```

processes all four files,
just like the original script.

*** =instructions

Along with `$@`,
the shell lets you use `$1`, `$2`, and so on to refer to specific command-line parameters.
Use this to write a script called `column.sh` that selects a single column from a CSV file
when the user provides the filename as the first parameter and the column as the second:

```{shell}
bash column.sh seasonal/autumn.dat 1
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
cut -d , -f $2 $1
```

*** =sct
```{shell}

```

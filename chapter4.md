---
title       : Creating new tools
description : >-
  History lets you repeat things with just a few keystrokes,
  and pipes let you combine existing commands to create new ones.
  In this chapter, you will see how to go one step further
  and create new commands of your own.

--- type:NormalExercise lang:shell xp:100 skills:1 key:864f978f0d
## Saving commands

You have been using the shell interactively so far:
each time you want to do something,
you enter a command
and the shell runs it right away.
But since the commands you type in are just text,
the shell lets you store them in files to use over and over again.
To start exploring this powerful capability,
put the following command in a file called `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

This selects the first row from each of the CSV files in the `seasonal` directory.
Once you have created this file,
you can run it with:

```{shell}
bash headers.sh
```

This tells Bash (which is the shell we are using)
to run the commands contained in the file `dates.sh`.
Sure enough,
it produces the same output you would have got
if you had typed the commands directly into the shell.

*** =instructions

Create another shell script called `dates.sh`
that extracts the date column (including header)
from all of the seasonal data files.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
# FIXME: how to trigger comparison.
```

*** =sct
```{python}
# @dates.sh
# cut -d , -f 1 seasonal/*.csv
script = 'dates.sh'
Ex().test_file_compare(f'$HOME/{script}', f'Put your solution in `{script}`.',
                       f'$ANSWERS/chapter4/{script}', f'`{script}` does not contain expected contents.',
                       ignore_whitespace=True)
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:
## Shell scripts

A file full of shell commands is called a *shell script*,
or sometimes just a "script" for short.
Shell scripts don't have to have names ending in `.sh`,
but this lesson will use that convention
to help you keep track of which files are scripts and which are not.

Most shell scripts contain more than a single command.
For example,
create a script called `alldates.sh` that contains this:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

This pipeline produces a list of the unique dates in the seasonal date.
You can then run it with `bash alldates.sh`
or save its output using redirection:

```{shell}
bash alldates.sh > dates.out
```

*** =instructions

Create a shell script called `teeth.sh`
that prints a count of the number of times each tooth name appears in the seasonal data.
Run it and save its output in `teeth.out`.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
```

*** =solution
```{shell}
Ex().test_student_typed(r'\s*bash\s+teeth.sh\s*>\s*teeth.out\s*',
                        fixed=False,
                        msg='Run the script with `bash` and use `>` to redirect its output.')
```

*** =sct
```{python}
# @teeth.sh
# cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c
# @teeth.out
#  15 bicuspid
#  31 canine
#  18 incisor
#  11 molar
#  17 wisdom
script = 'teeth.sh'
output = 'teeth.out'
Ex().test_file_compare(f'$HOME/{script}', f'Put your solution in `{script}`.',
                       f'$ANSWERS/{script}', f'`{script}` does not contain expected commands.',
                       ignore_whitespace=True)
Ex().test_file_compare(f'$HOME/{output}', f'Redirect output to `{output}`.',
                       f'$ANSWERS/chapter4/{output}', f'`{output}` does not contain expected lines.',
                       ignore_whitespace=True)
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:1b0da86491
## Passing filenames to scripts

A script that runs commands on specific files is a useful record of what you did,
but one that allows you process any files you want is a more useful tool.
To help you do this,
the shell has a special expression `$@` (dollar sign immediately followed by ampersand)
that means "all of the command-line parameters given by the user when the script was run".
To try this out,
put the following in `alldates.sh`:

```{shell}
cut -d , -f 1 $@ | grep -v Date | sort | uniq
```

When you run it like this:

```{shell}
bash alldates.sh seasonal/summer.csv`
```

the shell replaces `$@` with `seasonal/summer.csv` and processes only that file.
If you run it like this:

```{shell}
bash alldates.sh seasonal/*.csv
```

it processes all four data files.

*** =instructions

- Write a script called `count-data.sh`
  that counts the number of lines in one or more files,
  excluding the first line of each.
  Use the `-q` flag to `tail` to stop it from printing title lines.
- Run it on all of the seasonal data files
  and save the output in `line-count.out`.

```{shell}
bash count-data.sh seasonal/*.csv > line-count.out
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
```

*** =sct
```{python}
# @count-data.sh
# tail -q -n +2 $@ | wc -l
# @line-count.out
#       92
script = 'count-data.sh'
output = 'line-count.out'
Ex().test_file_compare(f'$HOME/{script}', f'Put your solution in `{script}`.',
                       f'$ANSWERS/{script}', f'`{script}` does not contain expected commands.',
                       ignore_whitespace=True)
Ex().test_file_compare(f'$HOME/{output}', f'Redirect output to `{output}`.',
                       f'$ANSWERS/chapter4/{output}', f'`{output}` does not contain expected lines.',
                       ignore_whitespace=True)
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:
## Working with single filenames

Along with `$@`,
the shell lets you use `$1`, `$2`, and so on to refer to specific command-line parameters.
You can use this to write commands that feel simpler or more natural than the shell's.
For example,
you can create a script called `column.sh` that selects a single column from a CSV file
when the user provides the filename as the first parameter and the column as the second:

```{shell}
cut -d , -f $2 $1
```

and then run it using:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Notice how the script uses the two parameters in reverse order.

*** =instructions

Write a shell script called `count-dates.sh`
that takes the name of a single file and a year-month pair like `2017-08` as parameters
and uses `grep` to count how many lines in the file contain that date.
For example:

```{shell}
bash count-dates.sh seasonal/autumn.csv 2017-08
```

should print `2`,
because there are two records in the file with `2017-08` in their date.

*** =hint

Use `grep -c` to select and count records.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}

```

*** =sct
```{python}
# @count-dates.sh
# grep -c $2 $1
script = 'count-dates.sh'
Ex().test_file_compare(f'$HOME/{script}', f'Put your solution in `{script}`.',
                       f'$ANSWERS/{script}', f'`{script}` does not contain expected commands.',
                       ignore_whitespace=True)
```

--- type:PureMultipleChoiceExercise lang:shell xp:100 skills:1 key:4cfeef4849
## File details

Unix stores a set of properties for each file along with its contents.
`ls` with the `-l` flag will display these.
For example,
`ls -l seasonal` displays something like this:

```
-rw-r--r--  1 repl  staff  399 18 Aug 09:27 autumn.csv
-rw-r--r--  1 repl  staff  458 18 Aug 09:27 spring.csv
-rw-r--r--  1 repl  staff  479 18 Aug 09:27 summer.csv
-rw-r--r--  1 repl  staff  497 18 Aug 09:27 winter.csv
```

Ignoring the first two columns for now,
this listing shows that the files are owned by a user named `repl`
who belongs to a group named `staff`,
that they range in size from 399 to 497 bytes,
and that they were last modified on August 18 at 9:27 in the morning.

<hr>
How many bytes are in the file `course.txt`?

*** =possible_answers
- 1
- 18
- [485]

*** =hint
Use the same command shown in the lesson.

*** =feedbacks
- No - you are looking at the wrong column.
- No - you are looking at the wrong column.
- Yes.

--- type:PlainMultipleChoiceExercise lang:shell xp:50 skills:1 key:934eccc0a9
## File permissions

Unix keeps track of what it is allowed to do with files and directories
by storing a set of *permissions* for each one.
The three permissions are *read*, *write*, and *execute* (i.e., run as a program).
These are often written `rwx` with dashes for permissions that are missing,
so `rw-` means "can read and write but not execute"
and `r-x` means "can read and execute but not modify".

Unix was designed as a multi-user operating system,
so it stores three sets of permissions for each file or directory:
one for the owner,
a second for everyone else in the owner's group,
and a third for everyone else.
Thus,
when `ls -l seasonal` displays this:

```
-rw-r--r--  1 repl  staff  399 18 Aug 09:27 autumn.csv
-rw-r--r--  1 repl  staff  458 18 Aug 09:27 spring.csv
-rw-r--r--  1 repl  staff  479 18 Aug 09:27 summer.csv
-rw-r--r--  1 repl  staff  497 18 Aug 09:27 winter.csv
```

it means that each file can be read and written by their owner (the first `rw-`),
read by other people in the `staff` group (`r--`),
and also read by everyone else on the machine (`r--`).
(The first character is "-" for files and "d" for directories.)

*** =instructions

What can other users who *aren't* members of your group do with the file `course.txt`?

*** =possible_answers
- [Read.]
- Read and write.
- Read and execute.
- None of the above.

*** =hint

Use `ls -l` and read the permissions in groups of three characters.

*** =feedbacks
- Correct.
- No - the third group of characters does not contain a "w".
- No - the third group of characters does not contain an "x".
- No - the third group of characters contains an "r".

--- type:NormalExercise lang:shell xp:100 skills:1 key:b1d307aae6
## Changing permissions

You can change a file's permissions using `chmod`
(which stands for "change mode").
Its first parameter describes what permissions you want the file to have;
all the other parameters should be the names of the files whose permissions you are changing.

To describe permissions,
you write an expression like `u=rw` or `g=rwx`.
The first letter is one of "u", "g", or "o",
meaning "user" (you),
"group" (other people in your group),
or "other" (for everyone else).
The letters after the equals sign specify the permissions you want to give the file.
Thus,
to stop yourself from accidentally editing `course.txt`
you would write:

```{shell}
chmod u=r course.txt
```

*** =instructions

Change the permissions on `people/agarwal.txt` so that everyone in your group can read and write it.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
chmod g=rw people/agarwal.txt
```

*** =sct
```{shell}
Ex().test_student_typed(r'\s*chmod\s+g=rw\s+people/agarwal.txt\s*', fixed=False, msg='Use `chmod` with `g=rw` and the filename.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:
## Adding and subtracting permissions

As well as specifying absolute permissions using an expression like `u=rwx`,
you can add or subtract permissions using an expression like  `u+x`,
meaning "add execute permission for this user".
You can similarly write `g-x` to mean "remove execute permission for members of my group".

*** =instructions

Write a shell script called `safe.sh` that removes execute permission
from one or more files
for everyone who isn't you or a member of your group.

*** =hint

Use `o-x` as the permission.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
```

*** =sct
```{shell}
# @safe.sh
# chmod o-x $@
script = 'safe.sh'
Ex().test_file_compare(f'$HOME/{script}', f'Put your solution in `{script}`.',
                       f'$ANSWERS/{script}', f'`{script}` does not contain expected commands.',
                       ignore_whitespace=True)
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:
## Creating first-class commands

FIXME: check that `~/bin` is in `PATH`.

As you use the shell to work with data,
you will build up your own toolbox of useful scripts.
By convention,
most users put these in a directory called `bin` underneath their home directory.
If a script is there,
and if it has execute permission,
the shell will run it when you type its name *without* saying "bash" first.

*** =instructions

- Write a script called `~/bin/lines.sh` that uses `wc -l` and `grep` to report the number of lines in one or more files
  *without* reporting the total number of lines.
- Use `chmod` to change the script's permissions so that you can read, write, and execute it.
- Run the script by typing `lines.sh seasonal/*.csv` *without* typing the command `bash`.

*** =hint

Use `o-x` as the permission.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
lines.sh seasonal/*.csv
```

*** =sct
```{shell}
# @bin/lines.sh
# wc -l $@ | grep -v total
import os
script = 'bin/lines.sh'
Ex().test_file_compare(f'$HOME/{script}', f'Put your solution in `{script}`.',
                       f'$ANSWERS/{script}', f'`{script}` does not contain expected commands.',
                       ignore_whitespace=True)
Ex().test(os.access(f'$HOME/{script}', os.X_OK), f'{script} is not executable (did you forget `chmod`?).')
```

--- type:BulletConsoleExercise key:99eae18d67
## BulletConsoleExercise Example

All of the shell scripts you have seen so far contain a single command,
but a script can contain any number of commands.
To wrap up this course,
you will create one that tells you how many records are in the shortest and longest of your data files.

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: a1e55487fb

*** =xp1: 10

*** =instructions1

Create a script called `bin/range.sh`
that uses `wc -l`, `grep`, `sort`, and `head` in a pipeline in that order
to list the names and number of lines in all of the files given on the command line.
(Do not try to subtract the header lines from the files.)

*** =hint1

You solved this problem when we first introduced pipes.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
```

*** =sct1
```{python}
# @bin/range.sh
# wc -l $@ | grep -v total
import os
script = 'bin/range.sh'
Ex().test_file_compare(f'$HOME/{script}', f'Put your solution in `{script}`.',
                       f'$ANSWERS/{script}', f'`{script}` does not contain expected commands.',
                       ignore_whitespace=True)
```

*** =type2: ConsoleExercise
*** =key2: e8ece27fe7

*** =xp2: 20

*** =instructions2

Rewrite `bin/range.sh` so that it displays the name and line count of the shortest file given to it.

*** =hint3

Use `sort -n` and `head -n 1` to select the shortest line.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}

```

*** =sct2
```{python}
# @bin/range.sh
# wc -l $@ | grep -v total | sort -n | head -n 1
import os
script = 'bin/range.sh'
Ex().test_file_compare(f'$HOME/{script}', f'Put your solution in `{script}`.',
                       f'$ANSWERS/{script}', f'`{script}` does not contain expected commands.',
                       ignore_whitespace=True)
```

*** =type3: ConsoleExercise
*** =key3: a3b36a746e

*** =xp3: 30

*** =instructions3

Add a second line to `range.sh` to print the name and record count of
the *longest* file in the directory *as well as* the shortest.
Use `sort -n -r` and `head` rather than `sort -n` and `tail`.

*** =hint3

A shell script can contain any number of commands.

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
```

*** =sct3
```{python}
# @bin/range.sh
# wc -l $@ | grep -v total | sort -n | head -n 1
# wc -l $@ | grep -v total | sort -n -r | head -n 1
import os
script = 'bin/range.sh'
Ex().test_file_compare(f'$HOME/{script}', f'Put your solution in `{script}`.',
                       f'$ANSWERS/{script}', f'`{script}` does not contain expected commands.',
                       ignore_whitespace=True)
```

*** =type4: ConsoleExercise
*** =key4:

*** =xp4: 30

*** =instructions4

Add execute permission to the script for yourself.

*** =hint4

Use `chmod` and `u+x`.

*** =sample_code4
```{shell}
```

*** =solution4
```{shell}
chmod u+x bin/range.sh
```

*** =sct4
```{python}
Ex().test_student_typed(r'\s*chmod\s+u+x\s+bin/range.sh\s*', fixed=False, msg='Use `chmod u+x` and the path to the script.')
```

*** =type5: ConsoleExercise
*** =key5:

*** =xp5: 30

*** =instructions5

Run the script on the files in the `seasonal` directory
by typing the name of the script and a wildcard expression to match all of the files,
*without* typing `bin/`.

*** =hint5

Remember, if the script is executable and in `bin`, you can just type its name.

*** =sample_code5
```{shell}
```

*** =solution5
```{shell}
range.sh seasonal/*.csv
```

*** =sct5
```{python}
Ex().test_student_typed(r'\s*range.sh seasonal/*.csv\s*', fixed=False, msg='Use `range.sh` and `seasonal/*.csv`.')
```

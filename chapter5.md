---
title       : Creating new tools
description : >-
  History lets you repeat things with just a few keystrokes,
  and pipes let you combine existing commands to create new ones.
  In this chapter, you will see how to go one step further
  and create new commands of your own.

--- type:NormalExercise lang:shell xp:100 skills:1 key:39eee3cfc0
## How can I edit a file?

Unix has a bewildering variety of text editors,
some of which combine the power of a full-blown IDE
with the readability of Egyptian hieroglyphics.
For this course,
we will use a very simple editor called Nano.
If you type `nano filename`,
it will open `filename` for editing
(or create it if it doesn't already exist).
You can then move around with the arrow keys,
delete characters with the backspace key,
and so on.
You can also do a few other operations with control-key combinations:

| Key    | Effect |
| ------ | ------ |
| Ctrl-K | delete a line |
| Ctrl-U | un-delete a line |
| Ctrl-O | save the file ('O' stands for 'output') |
| Ctrl-X | exit the editor |

*** =instructions

Use Nano to create a file in your home directory called `names.txt`
that contains the following four lines:

```
Lovelace
Hopper
Johnson
Wilson
```

Make sure there are no blank lines before or after these four lines.

*** =hint

Use the down-arrow to go to the bottom of the file to check for blank lines
and Ctrl-K to delete them.

*** =pre_exercise_code
```{shell}
```

*** =sample_code
```{shell}
```

*** =solution
```{shell}
cp /solutions/names.txt .
```

*** =sct
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('names.txt', '/solutions/names.txt')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:4507a0dbd8
## How can I save commands to re-run later?

You have been using the shell interactively so far.
But since the commands you type in are just text,
you can store them in files for the shell to run over and over again.
To start exploring this powerful capability,
put the following command in a file called `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

This command selects the first row from each of the CSV files in the `seasonal` directory.
Once you have created this file,
you can run it by typing:

```{shell}
bash headers.sh
```

This tells the shell (which is just a program called `bash`)
to run the commands contained in the file `headers.sh`,
which produces the same output as running the commands directly.

*** =instructions

- Create another file called `dates.sh`
  that uses the `cut` command to extract the first column
  from all of the CSV files in `seasonal`.
- Run this file. 

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
```

*** =solution
```{shell}
cp /solutions/dates.sh .
bash dates.sh
```

*** =sct
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('dates.sh', '/solutions/dates.sh') \
     >> test_student_typed(r'.+\s*bash\s+dates.sh\s*', \
                           fixed=False, \
                           msg='Use `bash` and the name of the file to run.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:da13667750
## How can I re-use pipes?

A file full of shell commands is called a *shell script*,
or sometimes just a "script" for short.
Scripts don't have to have names ending in `.sh`,
but this lesson will use that convention
to help you keep track of which files are scripts.

Scripts may contain pipes.
For example,
if `all-dates.sh` contains this line:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

then:

```{shell}
bash all-dates.sh > dates.out
```

will extract the unique dates from the seasonal data files
and save them in `dates.out`.

*** =instructions

- Create a shell script called `teeth.sh`
  that prints a count of the number of times each tooth name appears in the seasonal data.
- Run it and use redirection to save its output in `teeth.out`.

*** =hint

*** =pre_exercise_code
```{shell}
```

*** =sample_code
```{shell}
```

*** =solution
```{shell}
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out
```

*** =sct
```{python}
from shellwhat_ext import test_compare_file_to_file
import os
with open('teeth.out', 'r') as reader:
     content = reader.read()
debug = 'curdir is {} contents are {} teeth.out is "{}"'.format(os.getcwd(), str(os.listdir(os.curdir)), str(content))
Ex() >> test_compare_file_to_file('teeth.sh', '/solutions/teeth.sh') \
     >> test_compare_file_to_file('teeth.out', '/solutions/teeth.out', debug=debug)

# FIXME: SCT doesn't pass.
#     test_student_typed(r'.+bash\s+teeth.sh\s*>\s*teeth.out\s*',
#                        fixed=False,
#                        msg='Run the script with `bash` and use `>` to redirect its output.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:c2623b9c14
## How can I pass filenames to scripts?

A script that processes specific files is useful as a record of what you did,
but one that allows you process any files you want is more useful.
To support this,
you can use the special expression `$@` (dollar sign immediately followed by ampersand)
to mean "all of the command-line parameters given to the script".
For example,
if `some-dates.sh` contains this:

```{shell}
cut -d , -f 1 $@ | grep -v Date | sort | uniq
```

then when you run:

```{shell}
bash some-dates.sh seasonal/summer.csv`
```

the shell replaces `$@` with `seasonal/summer.csv` and processes one file.
If you run this:

```{shell}
bash some-dates.sh seasonal/*.csv
```

it processes all four data files.

*** =instructions

- Write a script called `count-records.sh`
  that counts the number of lines in one or more files,
  excluding the first line of each.
  Use the `-q` flag to `tail` to stop it from printing title lines.
- Run it on all of the seasonal data files
  and save the output in `num-records.out`.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
cp /solutions/count-records.sh .
bash count-records.sh seasonal/*.csv > num-records.out
```

*** =sct
```{python}
from shellwhat_ext import test_compare_file_to_file
import os
with open('num-records.out', 'r') as reader:
     content = reader.read()
debug = 'curdir is {} contents are {} num-records.out is "{}"'.format(os.getcwd(), str(os.listdir(os.curdir)), str(content))
Ex() >> test_compare_file_to_file('count-records.sh', '/solutions/count-records.sh') \
     >> test_compare_file_to_file('num-records.out', '/solutions/num-records.out', debug=debug)

# FIXME: SCT doesn't pass.
#     test_student_typed(r'.+\s*bash\s+count-records.sh\s+seasonal/*.csv\s*>\s*num-records.out\s*',
#                        fixed=False,
#                        msg='Run the script with `bash` and some filenames and use `>` to redirect its output.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:4092cb4cda
## How can I process a single argument?

As well as `$@`,
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

The script `get-lines.sh` is supposed to take
a start line,
and an end line as arguments,
and select that range of lines from that file.
For example:

```
bash get-lines.sh seasonal/summer.csv 5 8
```

should select lines 5-8 from `seasonal/summer.csv`.
Edit the file `get-lines.sh` and replace the `____` placeholders
so that it does this.

*** =hint

*** =pre_exercise_code
```{shell}
```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
cp /solutions/get-lines.sh .
```

*** =sct
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('get-lines.sh', '/solutions/get-lines.sh')
```


--- type:PureMultipleChoiceExercise lang:shell xp:100 skills:1 key:59f0e1cf33
## How can I get detailed information about a file?

In order to take the next step with scripting,
you need to know more about how Unix manages files.
First,
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

--- type:PureMultipleChoiceExercise lang:shell xp:50 skills:1 key:3061b5a818
## How does Unix control who can do what with a file?

Unix keeps track of who can do what to files and directories
by storing a set of **permissions** for each one.
The three permissions are *read*, *write*, and *execute* (i.e., run as a program).
These are often written `rwx` with dashes for permissions that are missing,
so `rw-` means "can read and write but not execute"
and `r-x` means "can read and execute but not modify".

Unix is a multi-user operating system,
so it stores three sets of permissions for each file or directory:
one for the owner,
a second for other people in the owner's group,
and a third for everyone else.
When `ls -l seasonal` displays this:

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

--- type:NormalExercise lang:shell xp:100 skills:1 key:f1988ccaf6
## How can I change a file's permissions?

You can change a file's permissions using `chmod`
(which stands for "change mode").
Its first parameter describes what permissions you want the file to have;
the other parameters should be the names of files.

To describe permissions,
you write an expression like `u=rw` or `g=rwx`.
The first is "u" for "user" (i.e., you),
"g" for "group" (other people in your group),
or "o" for "other" (everyone else).
The letters after the equals sign specify the permissions you want to give the file.
Thus,
to stop yourself from accidentally editing `course.txt`
you would write:

```{shell}
chmod u=r course.txt
```

*** =instructions

Set the permissions on `people/agarwal.txt` so that you can read it
but not write to it or execute it.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
chmod u=r people/agarwal.txt
```

*** =sct
```{shell}
from shellwhat_ext import test_file_perms
import os
debug = 'contents of {}: {}'.format(os.getcwd(), os.listdir(os.curdir))
debug += '\nand contents of people: {}'.format(os.listdir('people'))
Ex() >> test_file_perms('people/agarwal.txt', 'r', 'is not readable.', debug=debug)
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:6445630844
## How can I use my scripts like other commands?

As you use the shell to work with data,
you will build up your own toolbox of useful scripts.
Most users put these in a directory called `bin` under their home directory.
If a script is there,
and if it has execute permission,
the shell will run it when you type its name *without* saying "bash" first.

*** =instructions

The script `lines.sh` reports the number of lines in one or more files
without reporting the total number of lines.

- Move the script to `~/bin`.
- Use `chmod` to change its permissions so that you can read, write, and execute it.
- Run the script on `seasonal/*.csv` *without* typing the command `bash`.

*** =hint

Use `o=rwx` as the permission.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
cp /solutions/lines.sh bin/lines.sh
chmod u=rwx bin/lines.sh
lines.sh seasonal/*.csv
```

*** =sct
```{shell}
from shellwhat_ext import test_file_perms
import os
debug = 'contents of bin: {}'.format(os.getcwd(), os.listdir('bin'))
Ex() >> test_file_perms('bin/lines.sh', 'x',
                        'is not executable (did you forget `chmod`?).', debug=debug)

# FIXME: SCT is not passing.
#     test_student_typed(r'.+\s*lines.sh\s+seasonal/*.csv\s*',
#                        fixed=False,
#                        msg='Type the name of the script and the wildcard pattern for the files.')
```

--- type:BulletConsoleExercise key:6a3eb1d64d
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
cp /solutions/range-1.sh bin/range.sh
```

*** =sct1
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('bin/range.sh', '/solutions/range-1.sh', debug='range-1')
```

*** =type2: ConsoleExercise
*** =key2: e8ece27fe7

*** =xp2: 20

*** =instructions2

Rewrite `bin/range.sh` so that it uses `sort -n` and `head -n 1` to display
the name and line count of the shortest file given to it.

*** =hint3

Use `sort -n` and `head -n 1` to select the shortest line.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
cp /solutions/range-2.sh bin/range.sh
```

*** =sct2
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('bin/range.sh', '/solutions/range-2.sh', debug='range-2')
```

*** =type3: ConsoleExercise
*** =key3: a3b36a746e

*** =xp3: 30

*** =instructions3

Add a second line to `bin/range.sh` to print the name and record count of
the *longest* file in the directory *as well as* the shortest.
(Use `sort -n -r` and `head` rather than `sort -n` and `tail`.)

*** =hint3

Remember that a shell script can contain any number of commands.

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
cp /solutions/range-3.sh bin/range.sh
```

*** =sct3
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('bin/range.sh', '/solutions/range-3.sh', debug='range-3')
```

*** =type4: ConsoleExercise
*** =key4: 7ef95165b6

*** =xp4: 30

*** =instructions4

Give yourself read, write, and execute permission on `bin/range.sh`.

*** =hint4

Use `chmod` and `u=rwx`.

*** =sample_code4
```{shell}
```

*** =solution4
```{shell}
cp /solutions/range-3.sh bin/range.sh
chmod u=rwx bin/range.sh
```

*** =sct4
```{python}
from shellwhat_ext import test_file_perms
Ex() >> test_student_typed(r'.+\s*chmod\s+u=rwx\s+bin/range.sh\s*', \
                           fixed=False, \
                           msg='Use `chmod u+x` and the path to the script.') \
     >> test_file_perms('bin/range.sh', 'x', \
                        'is not executable (use `chmod`).')
```

*** =type5: ConsoleExercise
*** =key5: 7ad3b76529

*** =xp5: 30

*** =instructions5

Run the script on the files in the `seasonal` directory
by typing the name of the script and a wildcard expression to match all of the files,
*without* typing `bin/`.
Save the output in a file called `range.out` in your home directory.

*** =hint5

Remember, if the script is executable and in `bin`, you can just type its name.

*** =sample_code5
```{shell}
```

*** =solution5
```{shell}
cp /solutions/range-3.sh bin/range.sh
chmod u=rwx bin/range.sh
range.sh seasonal/*.csv > range.out
```

*** =sct5
```{python}
Ex() >> test_student_typed(r'.+\s*range.sh seasonal/*.csv\s*>\s*range.out\s*',
                           fixed=False,
                           msg='Use `range.sh` and `seasonal/*.csv`.')
```

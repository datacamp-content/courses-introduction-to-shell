--- type:MultipleChoiceExercise lang:shell xp:100 skills:1 key:59f0e1cf33
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

*** =instructions
- 1
- 18
- 485

*** =hint

Use the same command shown in the lesson.

*** =sct
```{python}
err = "No - you are looking at the wrong column."
correct = "That's correct!"
Ex().has_chosen(3, [err, err, correct])
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:3061b5a818
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
(The first character on each line is "-" for files and "d" for directories.)

<hr>

What can users who *aren't* members of your group do with the file `course.txt`?

*** =instructions
- Read.
- Read and write.
- Read and execute.
- None of the above.

*** =hint

Use `ls -l` and read the permissions in groups of three characters.

*** =sct
```{python}
a1 = 'Correct!'
a2 = 'No: the third group of characters does not contain a "w".'
a3 = 'No: the third group of characters does not contain an "x".'
a4 = 'No: the third group of characters contains an "r".'
Ex().has_chosen(1, [a1, a2, a3, a4])
```

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:f1988ccaf6
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
```{python}
import os
os.system('chmod 000 people/agarwal.txt')
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
# Ex() >> test_file_perms('people/agarwal.txt', 'r', 'is not readable.')
```

--- type:BulletConsoleExercise key:6445630844
## How can I use my scripts like other commands?

As you use the shell to work with data,
you will build up your own toolbox of useful scripts.
Most users put these in a directory called `bin` under their home directory.
If a script is there,
and if it has execute permission,
the shell will run it when you type its name *without* also typing `bash`.

*** =pre_exercise_code
```{python}
import shutil
shutil.copyfile('/solutions/lines.sh', 'bin/lines.sh')
```

*** =type1: ConsoleExercise
*** =key1: d0173a85f4

*** =xp1: 10

*** =instructions1

The script `bin/lines.sh`
reports the number of lines in one or more files
without reporting the total number of lines.
Use `chmod` to change its permissions
so that you can read, write, and execute it.

*** =hint1

Use `o=rwx` as the permission.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
cp /solutions/lines.sh bin
chmod u=rwx bin/lines.sh
```

*** =sct1
```{python}
#Ex() >> test_file_perms('bin/lines.sh', 'x', 'is not executable (did you forget `chmod`?).')
```

*** =type2: ConsoleExercise
*** =key2: 4925a72bc2

*** =xp2: 10

*** =instructions2

Run the script on `seasonal/*.csv` *without* typing the command `bash`
*or* the word `bin`.

*** =hint2

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
cp /solutions/lines.sh bin
chmod u=rwx bin/lines.sh
lines.sh seasonal/*.csv
```

*** =sct2
```{python}
Ex().has_code(r'\s*lines\.sh\s+seasonal/\*\.csv\s*',
              fixed=False, incorrect_msg='Type the name of the script and the wildcard pattern for the files.')
```


---
title       : Manipulating files and directories
description : >-
  This chapter is a brief introduction to the Unix shell.  You'll learn
  why it is still in use after almost fifty years, how it compares to the
  graphical tools you may be more familiar with, how to move around in the
  shell, and how to create, modify, and delete files and folders.


--- type:PureMultipleChoiceExercise lang:bash xp:50 key:badd717ea4
## How does the shell compare to a graphical user interface?

An operating system like Windows, Linux, or Mac OS is a special kind of program.
It controls the computer's processor, hard drive, and network connection,
but its most important job is to run other programs.

Since human beings aren't digital,
they need an interface to interact with the operating system.
The most common one these days is a graphical file explorer,
which translates clicks and double-clicks into commands to open files and run programs.
Before computers had graphical displays,
though,
people typed instructions into a program called a **command-line shell**.
Each time a command is entered,
the shell runs some other programs,
prints their output in human-readable form,
and then displays a *prompt* to signal that it's ready to accept the next command.
(Its name comes from the notion that it's the "outer shell" of the computer.)

Typing commands instead of clicking and dragging may seem clumsy at first,
but as you will see,
once you start spelling out what you want the computer to do,
you can combine old commands to create new ones
and automate repetitive operations
with just a few keystrokes.

<hr>
What is the relationship between the graphical file explorer that most people use and the command-line shell?

*** =possible_answers
- The file explorer lets you view and edit files, while the shell lets you run programs.
- The file explorer is built on top of the shell.
- The shell is part of the operating system, while the file explorer is separate.
- [They are both interfaces for issuing commands to the operating system.]

*** =hint
Remember that a user can only interact with an operating system through a program.

*** =feedbacks
- Both allow you to view and edit files and run programs.
- Graphical file explorers and the shell both call the same underlying operating system functions.
- The shell and the file explorer are both programs that translate user commands (typed or clicked) into calls to the operating system.
- Correct! Both take the user's commands (whether typed or clicked) and send them to the operating system.

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:7c1481dbd3
## Where am I?

The part of the operating system responsible for managing files and directories
is called the **filesystem**.
It organizes data into files,
which hold information,
and directories (also called "folders"),
which hold files or other directories.

Every file or directory is identified by an **absolute path**
that specifies how to get to it from the top (or **root**) of the filesystem.
For example,
the path `/home/repl` is the path to a directory called `repl` inside a directory called `home`,
while the path `/home/repl/course.txt` identifies a file called `course.txt` inside that directory.

To find out where you are in the filesystem,
type the command `pwd`
(which stands for "print working directory").
This tells you the absolute path of your **current working directory**,
which is where the shell will run commands and look for files
unless and until you tell it to do so elsewhere.
You can also use the command `whoami` to find out who the computer thinks you are.

<hr>
Run `pwd` in the shell window to the right.
Where are you right now?

*** =instructions
- `/home`
- `/repl`
- `/home/repl`

*** =hint


*** =pre_exercise_code
```{shell}

```

*** =sct
```{python}
err = "That is not the correct path."
correct = "Correct - you are in `/home/repl`."

Ex().test_mc(3, [err, err, correct])
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:f5b0499835
## How can I identify files and directories?

`pwd` tells you where you are,
but doesn't tell you what files and directories are there.
To find out,
you can use the command `ls` (which is short for "listing").
Entered on its own,
it lists the contents of your current working directory
(the one displayed by `pwd`).
If you add the names of one or more files,
`ls` will list those files,
and if you add the names of directories,
it will list the contents of those directories.
For example,
`ls /home/repl` will show you the contents of your starting directory
(usually called your **home directory**),
which is the same as what it shows you if you are in that directory and type `ls` on its own.

<hr>
Use `ls` with an appropriate argument to get a listing of the files in the directory `/home/repl/seasonal`
(which holds information on dental surgeries by date, broken down by season).
Which of the following files is *not* in that directory?

*** =instructions
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

*** =hint
If you give `ls` a path, it shows what's in that path.

*** =pre_exercise_code
```{shell}

```

*** =sct
```{python}
err = "That file is in the `seasonal` directory."
correct = "Correct - that file is *not* in the `seasonal` directory."

Ex().test_mc(2, [err, correct, err, err])
```

--- type:BulletConsoleExercise key:a766184b59
## How else can I identify files and directories?

An absolute path is like the latitude and longitude of a point on a map:
it specifies the same thing no matter where you are.
A **relative path**,
on the other hand,
specifies a location starting from where you are:
it's like saying "20 kilometers north".

For example,
if you are in the directory `/home/repl`,
the relative path `seasonal` specifies the same directory as `/home/repl/seasonal`,
and the relative path `seasonal/winter.csv` specifies the same file as `/home/repl/seasonal/winter.csv`.
The shell can tell whether a path is absolute or relative by looking at its first character.
If the path begins with `/`, it is absolute;
if it doesn't,
it is relative.

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 9db1ed7afd

*** =xp1: 10

*** =instructions1

You are in `/home/repl`.
Use `ls some/relative/path` to list
the file `/home/repl/course.txt` (and only that file).

*** =hint1

You can often construct the relative path to a file or directory below your current location
by subtracting the absolute path of your current location
from the absolute path of the thing you want.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
ls course.txt
```

*** =sct1
```{python}
Ex() >> test_student_typed(r'\s*ls\s+course.txt\s*',
                           fixed=False,
                           msg='Use `ls` followed by a path.')
```

*** =type2: ConsoleExercise
*** =key2: 4165425bf6

*** =xp2: 10

*** =instructions2

You are in `/home/repl`.
Use `ls some/relative/path` to list
the file `/home/repl/seasonal/summer.csv` (and only that file).

*** =hint2

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
ls seasonal/summer.csv
```

*** =sct2
```{python}
Ex() >> test_student_typed(r'\s*ls\s+seasonal/summer.csv\s*',
                           fixed=False,
                           msg='Use `ls` followed by a path.')
```

*** =type3: ConsoleExercise
*** =key3: b5e66d3741

*** =xp3: 10

*** =instructions3

You are in `/home/repl`.
Use `ls some/relative/path` to list
the contents of the directory `/home/repl/people`.

*** =hint3

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
ls people
```

*** =sct3
```{python}
Ex() >> test_student_typed(r'\s*ls\s+people/agarwal.txt\s*',
                           fixed=False,
                           msg='Use `ls` followed by a path, but do not put spaces inside the path.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:dbdaec5610
## How can I move to another directory?

Just as you can move around in a file browser by double-clicking on folders,
you can move around in the filesystem using the command `cd`
(which stands for "change directory").

If you type `cd seasonal` and then type `pwd`,
the shell will tell you that you are now in `/home/repl/seasonal`.
If you then run `ls` on its own,
it shows you the contents of `/home/repl/seasonal`,
because that's where you are.
If you want to get back to your home directory `/home/repl`,
you can use the command `cd /home/repl`.

*** =instructions

- Go into `/home/repl/seasonal` using a relative path.
- Use `pwd` to check that you're there.
- Use `ls` without any paths to see what's in that directory.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
# Go into `/home/repl/seasonal` using a relative path


# Check where you are


# List the contents of this directory

```

*** =solution
```{shell}
# Go into `/home/repl/seasonal` using a relative path
cd seasonal

# Check where you are
pwd

# List the contents of this directory
ls
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*cd\s+seasonal\s*', fixed=False, msg='Use `cd` followed by a path.')
Ex().test_student_typed(r'\s*pwd\s*', fixed=False, msg='Remember: "print working directory".')
Ex().test_student_typed(r'\s*pwd\s*', fixed=False, msg='`ls` with no paths will show the contents of the current directory.')
```

--- type:PureMultipleChoiceExercise lang:shell xp:50 skills:1 key:09c717ef76
## How can I move up a directory?

The **parent** of a directory is the directory above it.
For example, `/home` is the parent of `/home/repl`,
and `/home/repl` is the parent of `/home/repl/seasonal`.
You can always give the absolute path of your parent directory to commands like `cd` and `ls`.
More often,
though,
you will take advantage of the fact that the special path `..`
(two dots with no spaces) means "the directory above the one I'm currently in.
If you are in `/home/repl/seasonal`,
then `cd ..` moves you up to `/home/repl`.
If you use `cd ..` once again,
it puts you in `/home`.
One more `cd ..` puts you in the *root directory* `/`,
which is the very top of the filesystem.

A single dot on its own, `.`, always means "the current directory",
so `ls` on its own and `ls .` do the same thing,
while `cd .` has no effect
(because it moves you into the directory you're currently in).

One final special path is `~`
(the tilde character, pronounced *til-duh*),
which means "your home directory".
No matter where you are,
`ls ~` will always list the contents of your home directory,
and `cd ~` will always take you home.

<hr>
If you are in `/home/repl/seasonal`,
where does `cd ~/../.` take you?

*** =possible_answers
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`

*** =hint
Trace the path one directory at a time.

*** =feedbacks
- No, but either `~` or `..` on its own would take you there.
- Correct - the path means 'home directory', 'up a level', 'here'.
- No, but `.` on its own would do that.

Ex().test_mc(2, [err1, correct, err3])

--- type:NormalExercise lang:shell xp:100 skills:1 key:c749675192
## How can I copy a file?

Once you have some files,
you will often want to make copies,
move them into other directories in order to organize them,
or rename them.
One command to do this is `cp`, which is short for "copy".
If `original.txt` is an existing file,
then the command:

```{shell}
cp original.txt duplicate.txt
```

creates a copy of `original.txt` called `duplicate.txt`.
If there already was a file called `duplicate.txt`,
it is overwritten.

*** =instructions

Make a copy of `seasonal/summer.csv` in the `backup` directory,
calling the new file `summer.bck`.

*** =hint

Combine the name of the destination directory and the name of the copied file
to create a relative path for the new file.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
cp seasonal/summer.csv backup/summer.bck
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*cp\s+seasonal/summer.csv\s+backup/summer.bck\s*', fixed=False, msg='Provide two paths to `cp`.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:b055c990e7
## How can I copy multiple files?

`cp` can do more than copy one file at a time.
If the second parameter is an existing directory such as `backup`,
then the command:

```{shell}
cp original.txt backup
```

creates a new file called `backup/original.txt`.
In fact,
if the last parameter is a directory,
and all the parameters before it are the names of files,
then `cp` copies *all* of those files into that directory,
which means that:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv ~
```

will copy two files from the `seasonal` directory into your home directory.

*** =instructions

Copy the spring and summer data files into the `backup` directory
*without* changing directory
(i.e., run a single command from your home directory).

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*cp\s+seasonal/spring.csv\s+seasonal/summer.csv\s+backup\s*', fixed=False, msg='Provide two filenames and a directory name to `cp`.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:663a083a3c
## How can I move a file?

While `cp` gives you a way to copy a file,
`mv` lets you move it from one directory to another,
just as if you had dragged it in a graphical file browser.
It handles its parameters the same way as `cp`,
so the command:

```{shell}
mv autumn.csv winter.csv ..
```

moves the files `autumn.csv` and `winter.csv` from the current working directory
up one level to its parent directory
(because `..` always refers to the directory above your current location).

*** =instructions

Using a single command,
move the spring and summer data files to the `backup` directory.

*** =hint

Use two filenames and a directory name as parameters.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
mv seasonal/spring.csv seasonal/summer.csv backup
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*mv\s+seasonal/spring.csv\s+seasonal/summer.csv\s+backup\s*', fixed=False, msg='Use two filenames and a directory name as parameters.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:8cbc17793f
## How can I rename fils?

`mv` can also be used to rename files.
If you run:

```{shell}
mv course.txt old-course.txt
```

then the file `course.txt` in the current working directory is "moved" to the file `old-course.txt`.
This is different from the way file browsers work,
but is often handy.

One warning:
just like `cp`,
`mv` will overwrite existing files.
If,
for example,
you already have a file called `old-course.txt`,
then the command shown above will replace it with whatever is in `course.txt`.

*** =instructions

Go into the `seasonal` directory
and rename the file `winter.csv` to be `winter.csv.bck`,
then run `ls` to check that everything has worked.

*** =hint

You will need to use three commands.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
# Change directory to seasonal


# Rename winter.csv to winter.csv.bck


# List the directory's contents to check

```

*** =solution
```{shell}
# Change directory to seasonal
cd seasonal

# Rename winter.csv to winter.csv.bck
mv winter.csv winter.csv.bck

# List the directory's contents to check
ls
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*cd\s+seasonal\s*', fixed=False, msg='Use `cd` to change directory.')
Ex().test_student_typed(r'\s*mv\s+winter.csv\s+winter.csv.bck\s*', fixed=False, msg='Use `mv` to rename a file.')
Ex().test_student_typed(r'\s*ls\s*', fixed=False, msg='Use `ls` to list the directory contents.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:2734680614
## How can I delete files?

We can create files,
copy them,
and move them around;
the only thing left is to delete them.
The command to do this is `rm`,
which stands for "remove".
As with `cp` and `mv`,
you can give `rm` the names of as many files as you'd like.

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

removes both `thesis.txt` and `backup/thesis-2017-08.txt`

`rm` does exactly what its name says,
and it does it right away:
unlike graphical file browsers,
the shell doesn't have a trash can,
so when you type the command above,
your thesis is gone for good.

*** =instructions

- Go into the `seasonal` directory and remove `autumn.csv`
- Go back to your home directory and remove `summer.csv` from there.

*** =hint

Remember, `cd ..` moves you up one level, and `cd ~` moves you to your home directory.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
# Change directory to seasonal


# Remove autumn.csv


# Return to your home directory


# Remove summer.csv from the seasonal directory

```

*** =solution
```{shell}
# Change directory to seasonal
cd seasonal

# Remove autumn.csv
rm autumn.csv

# Return to your home directory
cd .. # or cd ~

# Remove summer.csv from the seasonal directory
rm seasonal/summer.csv
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*cd\s+seasonal\s*', fixed=False, msg='Use `cd` to change directory.')
Ex().test_student_typed(r'\s*rm\s+autumn.csv\s*', fixed=False, msg='Use `rm` to remove a single file.')
Ex().test_student_typed(r'\s*cd\s+(\.\.|\~)\s*', fixed=False, msg='Use `cd ..` to go up a level or `cd ~` to return home.')
Ex().test_student_typed(r'\s*rm\s+seasonal/summer.csv\s*', fixed=False, msg='`rm` works with paths.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:63e8fbd0c2
## How can I delete directories?

`mv` treats directories the same way it treats files:
if you are in your home directory and run `mv seasonal by-season`,
for example,
`mv` changes the name of the `seasonal` directory to `by-season`.
However,
`rm` works differently.

If you try to `rm` a directory,
the shell will print an error message telling you that it can't do that,
primarily to stop you from accidentally deleting an entire directory full of work.
Instead,
you must use a separate command called `rmdir`.
For added safety,
it only works when the directory is empty,
so you must delete all the files in a directory *before* you delete the directory.

*** =instructions

Without changing directory,
use two commands to delete the `people` directory.

*** =hint

Remove the directory's contents first,
then remove the directory.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
rm people/agarwal.txt
rmdir people
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*rm\s+people/agarwal.txt\s*', fixed=False, msg='Remove the file inside `people`.')
Ex().test_student_typed(r'\s*rmdir\s+people\s*', fixed=False, msg='Remove the directory `people`.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:9b157134df
## How can I create directories?

A directory is a different kind of thing than a text file,
so you cannot create directories using a text editor.
Instead,
you must use the command `mkdir`
(which stands for "make directory").
For example,
if you want to store a copy of `course.txt` in a directory called `info`,
which doesn't yet exist,
you could run:

```{shell}
mkdir info
cp course.txt info
```

*** =instructions

Using two commands,
create a new directory called `2017` inside a new directory called `yearly`.
Do not change directory while doing this.

*** =hint

Make the upper directory first,
then create the lower directory inside it.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
mkdir yearly
mkdir yearly/2017
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*mkdir\s+yearly\s*', fixed=False, msg='Make the upper directory.')
Ex().test_student_typed(r'\s*mkdir\s+yearly/2017\s*', fixed=False, msg='Make the lower directory using a relative path.')
```

--- type:BulletConsoleExercise key:b1990e9a42
## Wrapping up

You will often create intermediate files when analyzing data.
Rather than storing them in your home directory,
you can put them in `/tmp`,
which is where programs typically keep files that they only need briefly.
This wrap-up exercise will show you how to do that.

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 59781bc43b

*** =xp1: 10

*** =instructions1
Go into the `/tmp` directory.

*** =hint1

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
cd /tmp
```

*** =sct1
```{python}
Ex().test_student_typed(r'\s*cd\s+/tmp\s*',
                        fixed=False,
                        msg='Change your directory to `/tmp`.')
```


*** =type2: ConsoleExercise
*** =key2: 7e6ada440d

*** =xp2: 10

*** =instructions2
List the contents of `/tmp` *without* typing a directory name.

*** =hint2

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
ls
```

*** =sct2
```{python}
Ex().test_student_typed(r'\s*ls\s*',
                        fixed=False,
                        msg='Use `ls` to see what files and directories you have.')
```

*** =type3: ConsoleExercise
*** =key3: edaf1bcf96

*** =xp3: 20

*** =instructions3
Make a new directory called `scratch`.

*** =hint3
Use `mkdir` to make directories.

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
mkdir scratch
```

*** =sct3
```{python}
Ex().test_student_typed(r'\s*mkdir\s+scratch\s*',
                        fixed=False,
                        msg='Use `mkdir` followed by the relative path of the directory you want to create.')
```

*** =type4: ConsoleExercise
*** =key4: a904a3a719

*** =xp4: 30

*** =instructions4
Move `/home/repl/people/agarwal.txt` into `/tmp/scratch`
using the `~` shortcut for your home directory
and a relative path for the target directory.

*** =sample_code4
```{shell}
```

*** =solution4
```{shell}
mv ~/people/agarwal.txt scratch
```

*** =sct4
```{python}
Ex().test_student_typed(r'\s*mv\s+~/people/agarwal.txt\s+scratch\s*',
                        fixed=False,
                        msg='Use `~/people/agarwal.txt` for the first parameter and `scratch` for the second.')
```

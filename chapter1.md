---
title       : Manipulating files and directories
description : >-
  This chapter is a brief introduction to the Unix shell.  You'll learn
  why it is still in use after almost fifty years, how it compares to the
  graphical tools you may be more familiar with, how to move around in the
  shell, and how to create, modify, and delete files and folders.


--- type:PureMultipleChoiceExercise lang:bash xp:50 key:badd717ea4
## The shell and your file explorer

An operating system like Windows, Linux, or Mac OS is a special kind of program.
It controls the computer's processor, hard drive, and network connection,
and can run (and stop) other programs.
Each operating system provides a set of functions
that other programs can call to create and delete files,
fetch data from the network,
and so on.
The differences between these functions are what give each operating system its unique personality.

Since human beings aren't digital,
they need some sort of interface to interact with the functions the operating system provides.
The most common interface these days is a graphical file explorer,
which translates clicks and double-clicks into commands to open files and run programs,
and understands that dragging an icon into the trash can means "delete this thing".
Before computers had graphical displays,
though,
people typed instructions into a program called a *command-line shell*,
or just "shell" for short.
Each time a command is entered,
the shell calls one or more operating system functions,
prints their output in human-readable form,
and then displays a *prompt* to signal that it's ready to accept the next command.

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

Ex().test_mc(4, [err1, err2, err3, correct])
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:7c1481dbd3
## Where am I?

The part of the operating system responsible for managing files and directories
is called the *file system*.
It organizes our data into files,
which hold information,
and directories (also called "folders"),
which hold files or other directories.

Every file or directory is identified by an *absolute path*
that specifies how to get to it from the top (or *root*) of the file system.
For example,
the path `/home/repl` is the path to a directory called `repl` inside a directory called `home`,
while the path `/home/repl/course.txt` identifies a file called `output.txt` inside a directory called `tmp`.

To find out where you are in the file system,
type the command `pwd`
(which stands for "print working directory").
This tells you the absolute path of the directory where the shell will run commands and look for files
unless and until you tell it to do so elsewhere.

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
correct = "Correct - you are in /home/repl."

Ex().test_mc(3, [err, err, correct])
```

--- type:PlainMultipleChoiceExercise lang:shell xp:50 skills:1 key:f5b0499835
## What's where?

`pwd` tells you where you are,
but doesn't tell you what files and directories are there.
To find out,
you can use the command `ls` (which is short for "listing").
Entered on its own,
it lists the contents of your current working directory
(the one displayed by `pwd`).
If you add the names of one or more files or directories to the line,
`ls` will list those files and the contents of those directories.
For example,
`ls /home/repl` will show you the contents of your home directory
(which is the same as what it shows you if you are in that directory and type `ls` on its own).

<hr>
Use `ls` with an appropriate argument to get a listing of the files in the directory `/home/repl/seasonal`.
Which of the following files is *not* in that directory?

*** =instructions
- `autumn.dat`
- `fall.dat`
- `spring.dat`
- `winter.dat`

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

--- type:NormalExercise lang:shell xp:100 skills:1 key:a766184b59
## Relative paths

An absolute path is like the latitude and longitude of a point on a map:
it specifies the same thing no matter where you are.
A *relative path*,
on the other hand,
specifies a location starting from where you are:
it's like saying "20 kilometers north".
For example,
if you are in the directory `/home/repl`,
the relative path `course.txt` specifies the same file as `/home/repl/course.txt`,
and the relative path `seasonal/winter.dat` specifies the same file as `/home/repl/seasonal/winter.dat`.

The shell can tell whether a path is absolute or relative by looking at its first character.
If the path begins with `/`, it is absolute;
if it doesn't,
it is relative.

*** =instructions

You are in the directory `/home/repl`.
Use `ls some/relative/path` to list the files identified by each of the absolute paths in the sample code one by one.

*** =hint
You can often construct the relative path to a file or directory below your current location
by subtracting the absolute path of your current location
from the absolute path of the thing you want.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
# /home/repl/instructions.txt

# /home/repl/people/jasmine.dat

```

*** =solution
```{shell}
ls instructions.txt
ls people/jasmine.dat
```

*** =sct
```{shell}
Ex().test_student_typed(r'\s*ls\s+instructions.txt\s*', fixed=False, msg='Use ls followed by a path')
Ex().text_student_typed(r'\s*ls\s+people/jasmine.dat\s*', fixed=False, msg='Use ls followed by a path, but do not put spaces inside the path')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:dbdaec5610
## Changing directories

Just as you can move around in a file browser by double-clicking on folders,
you can move around in the shell using the command `cd`
(which stands for "change directory").
If you type `cd seasonal` and then type `pwd`,
the shell will tell you that you are now in `/home/repl/seasonal`.
If you run `ls` on its own,
it now shows you the contents of `/home/repl/seasonal`,
because that's where you are.
If you want to get back to your home directory `/home/repl`,
you can use the command `cd /home/repl`.

*** =instructions

1. Go into `/home/repl/seasonal` using a relative path.
2. Use `pwd` to check that you're there.
3. Use `ls` without any paths to see what's in that directory.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
# Go into `/home/repl/seasonal` using a relative path.

# Check where you are.

# List the contents of this directory.

```

*** =solution
```{shell}
cd seasonal
pwd
ls
```

*** =sct
```{shell}
Ex().test_student_typed(r'\s*cd\s+seasonal\s*', fixed=False, msg='Use cd followed by a path')
Ex().test_student_typed(r'\s*pwd\s*', fixed=False, msg='Remember: "print working directory"')
Ex().test_student_typed(r'\s*pwd\s*', fixed=False, msg='ls with no paths will show the contents of the current directory')
```

--- type:PlainMultipleChoiceExercise lang:shell xp:50 skills:1 key:09c717ef76
## Special paths

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
which is the very top of the file system.

A single dot on its own, `.`, always means "the current directory",
so `ls` on its own and `ls .` do the same thing,
while `cd .` has no effect
(because it moves you into the directory you're currently in).
This may not seem particularly useful,
but `.` is to paths what zero is to arithmetic:
we will see situations later where it's very handy.

One final special path is `~`
(the tilde character),
which means "your home directory".
No matter where you are,
`ls ~` will always list the contents of your home directory,
and `cd ~` will always take you home.

<hr>
If you are in `/home/repl/seasonal`,
where does `cd ~/../.` take you?

*** =instructions
- `/home/repl`
- `/home`
- `/home/repl/seasonal`

*** =hint
Trace the path one directory at a time.

*** =pre_exercise_code
```{shell}

```

*** =sct
```{shell}
err1 = "No, but either ~ or .. on its own would take you there."
correct = "Correct - the path means 'home directory', 'up a level', 'here'."
err3 = "No, but '.' on its own would do that."

Ex().test_mc(2, [err1, correct, err3])
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:3493f8c02f
## Editing files

FIXME: fill this in once we know how learners will edit files in the web app.

*** =instructions

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
```{shell}

```
--- type:NormalExercise lang:shell xp:100 skills:1 key:c749675192
## Copying files

Once you have some files,
you will often want to make copies,
move them into other directories in order to organize them,
or rename them.
Unix provides several tools to do this.
The first is `cp`, which is short for "copy".
If `original.txt` is an existing file,
then the command:

```{shell}
cp original.txt duplicate.txt
```

creates a copy of `original.txt` called `duplicate.txt`.
If there already was a file called `duplicate.txt`,
it is overwritten.

But `cp` can do more than this.
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
cp seasonal/autumn.dat seasonal/winter.dat ~
```

will copy two files from the `seasonal` directory into your home directory.

*** =instructions

Using a single command,
make a copy of `seasonal/summer.dat` in the `backup` directory,
changing the name to `summer.bck`.

*** =hint

Since you are changing the name,
you need to provide a path for the destination
rather than just a directory.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
cp seasonal/summer.dat backup/summer.bck
```

*** =sct
```{shell}
Ex().test_student_typed(r'\s*cp\s+seasonal/summer.dat\s+backup/summer.bck\s*', fixed=False, msg='Provide two paths to cp')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:663a083a3c
## Moving and renaming files

While `cp` gives you a way to copy a file,
`mv` lets you move it from one directory to another,
just as if you had dragged it in a graphical file browser.
It handles its parameters the same way as `cp`,
so the command:

```{shell}
mv autumn.dat winter.dat ..
```

moves the files `autumn.dat` and `winter.dat` from the current working directory
up one level to its parent directory
(because `..` always refers to the directory above your current location).

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
and rename the file `winter.dat` to be `winter.dat.bck`,
then run `ls` to check that everything has worked.

*** =hint

You will need to use three commands.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
# Change directory to seasonal.

# Rename winter.dat to winter.dat.bck.

# List the directory's contents to check
```

*** =solution
```{shell}
cd seasonal
mv winter.dat winter.dat.bck
ls
```

*** =sct
```{shell}
Ex().test_student_typed(r'\s*cd\s+seasonal\s*', fixed=False, msg='Use cd to change directory')
Ex().test_student_typed(r'\s*mv\s+winter.dat\s+winter.dat.bck\s*', fixed=False, msg='Use mv to rename a file')
Ex().test_student_typed(r'\s*ls\s*', fixed=False, msg='Use ls to list the directory contents')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:2734680614
## Deleting files

We can create files,
copy them,
and move them around:
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

1. Go into the `seasonal` directory and remove `autumn.dat`
2. Go back to your home directory and remove `summer.dat` from there.

*** =hint

Remember, `cd ..` moves you up one level, and `cd ~` moves you to your home directory.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
# Change directory to seasonal.

# Remove autumn.dat

# Return to your home directory.

# Remove summer.dat from the seasonal directory.
```

*** =solution
```{shell}
cd seasonal
rm autumn.dat
cd .. # or cd ~
rm seasonal/summer.dat
```

*** =sct
```{shell}
Ex().test_student_typed(r'\s*cd\s+seasonal\s*', fixed=False, msg='Use cd to change directory')
Ex().test_student_typed(r'\s*rm\s+autumn.dat\s*', fixed=False, msg='Use rm to remove a single file')
Ex().test_student_typed(r'\s*cd\s+(\.\.|\~)\s*', fixed=False, msg='Use cd .. to go up a level or cd ~ to return home')
Ex().test_student_typed(r'\s*rm\s+seasonal/summer.dat\s*', fixed=False, msg='rm works with paths')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:9b157134df
## Creating and deleting directories

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
you must use a separate command called `rmdir` to remove a directory.
For added safety,
it only works when the directory is empty,
so you must delete all the files in a directory *before* you delete the directory.

To create a new directory,
you must use another commmand called `mkdir`
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

Create a new directory called `2017` inside a new directory called `backup`.
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
mkdir backup
mkdir backup/2017
```

*** =sct
```{shell}
Ex().test_student_typed(r'\s*mkdir\s+backup\s*', fixed=False, msg='Make the upper directory')
Ex().test_student_typed(r'\s*cd\s+backup/2017\s*', fixed=False, msg='Make the lower directory using a relative path')
```

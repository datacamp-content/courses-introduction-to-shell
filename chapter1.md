---
title       : Manipulating files and directories
description : >-
  This chapter is a brief introduction to the Unix shell.  You'll learn
  why it is still in use after almost fifty years, how it compares to the
  graphical tools you may be more familiar with, how to move around in the
  shell, and how to create, modify, and delete files and folders.


--- type:PlainMultipleChoiceExercise lang:bash xp:50 key:badd717ea4
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

*** =instructions
- The file explorer lets you view and edit files, while the shell lets you run programs.
- The file explorer is built on top of the shell.
- The shell is part of the operating system, while the file explorer is separate.
- They are both interfaces for issuing commands to the operating system.

*** =hint
Remember that a user can only interact with an operating system through a program.

*** =pre_exercise_code
```{python}

```

*** =sct
```{python}
err1 = "Both allow you to view and edit files and run programs."
err2 = "Graphical file explorers and the shell both call the same underlying operating system functions."
err3 = "The shell and the file explorer are both programs that translate user commands (typed or clicked) into calls to the operating system."
correct = "Correct! Both take the user's commands (whether typed or clicked) and send them to the operating system."

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

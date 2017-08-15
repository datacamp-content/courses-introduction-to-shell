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

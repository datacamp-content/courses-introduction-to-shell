---
title: 'Manipulating files and directories'
description: 'This chapter is a brief introduction to the Unix shell.  You''ll learn why it is still in use after almost fifty years, how it compares to the graphical tools you may be more familiar with, how to move around in the shell, and how to create, modify, and delete files and folders.'
free_preview: true
---

## How does the shell compare to a desktop interface?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

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

`@hint`
Remember that a user can only interact with an operating system through a program.

`@possible_answers`
- The file explorer lets you view and edit files, while the shell lets you run programs.
- The file explorer is built on top of the shell.
- The shell is part of the operating system, while the file explorer is separate.
- [They are both interfaces for issuing commands to the operating system.]

`@feedback`
- Both allow you to view and edit files and run programs.
- Graphical file explorers and the shell both call the same underlying operating system functions.
- The shell and the file explorer are both programs that translate user commands (typed or clicked) into calls to the operating system.
- Correct! Both take the user's commands (whether typed or clicked) and send them to the operating system.

---

## Where am I?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

The **filesystem** manages files and directories (or folders).
Each is identified by an **absolute path**
that shows how to reach it from the filesystem's **root directory**:
`/home/repl` is the directory `repl` in the directory `home`,
while `/home/repl/course.txt` is a file `course.txt` in that directory,
and `/` on its own is the root directory.

To find out where you are in the filesystem,
run the command `pwd`
(short for "**p**rint **w**orking **d**irectory").
This prints the absolute path of your **current working directory**,
which is where the shell runs commands and looks for files by default.

<hr>
Run `pwd`.
Where are you right now?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix systems typically place all users' home directories underneath `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "That is not the correct path."
correct = "Correct - you are in `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## How can I identify files and directories?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` tells you where you are.
To find out what's there,
type `ls` (which is short for "**l**i**s**ting") and press the enter key.
On its own,
`ls` lists the contents of your current directory
(the one displayed by `pwd`).
If you add the names of some files,
`ls` will list them,
and if you add the names of directories,
it will list their contents.
For example,
`ls /home/repl` shows you what's in your starting directory
(usually called your **home directory**).

<hr>
Use `ls` with an appropriate argument to list the files in the directory `/home/repl/seasonal`
(which holds information on dental surgeries by date, broken down by season).
Which of these files is *not* in that directory?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
If you give `ls` a path, it shows what's in that path.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "That file is in the `seasonal` directory."
correct = "Correct - that file is *not* in the `seasonal` directory."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## How else can I identify files and directories?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

An absolute path is like a latitude and longitude:
it has the same value no matter where you are.
A **relative path**,
on the other hand,
specifies a location starting from where you are:
it's like saying "20 kilometers north".

For example,
if you are in the directory `/home/repl`,
the relative path `seasonal` specifies the same directory as `/home/repl/seasonal`,
while `seasonal/winter.csv` specifies the same file as `/home/repl/seasonal/winter.csv`.
The shell decides if a path is absolute or relative by looking at its first character:
if it begins with `/`, it is absolute,
and if it doesn't,
it is relative.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 9db1ed7afd
xp: 35
```

`@instructions`
You are in `/home/repl`.
Use `ls` with a relative path
to list the file `/home/repl/course.txt` (and only that file).

`@hint`
You can often construct the relative path to a file or directory below your current location
by subtracting the absolute path of your current location
from the absolute path of the thing you want.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "You didn't call `ls` to generate the file listing."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Your command didn't generate the correct file listing. Use `ls` followed by a relative path to `/home/repl/course.txt`.")
    )
)

```

***

```yaml
type: ConsoleExercise
key: 4165425bf6
xp: 35
```

`@instructions`
You are in `/home/repl`.
Use `ls` with a relative path
to list the file `/home/repl/seasonal/summer.csv` (and only that file).

`@hint`
Relative paths do *not* start with a leading '/'.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "You didn't call `ls` to generate the file listing."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Your command didn't generate the correct file listing. Use `ls` followed by a relative path to `/home/repl/seasonal/summer.csv`.")
    )
)
```

***

```yaml
type: ConsoleExercise
key: b5e66d3741
xp: 30
```

`@instructions`
You are in `/home/repl`.
Use `ls` with a relative path
to list the contents of the directory `/home/repl/people`.

`@hint`
Relative paths do not start with a leading '/'.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "You didn't call `ls` to generate the file listing."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Your command didn't generate the correct file listing. Use `ls` followed by a relative path to `/home/repl/people`.")
    )
)
Ex().success_msg("Well done. Now that you know about listing files and directories, let's see how you can move around the filesystem!")

```

---

## How can I move to another directory?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

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

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 3d0bfdd77d
xp: 35
```

`@instructions`
You are in `/home/repl`/.
Change directory to `/home/repl/seasonal` using a relative path.

`@hint`
Remember that `cd` stands for "change directory" and that relative paths do not start with a leading '/'.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="If your current working directory (find out with `pwd`) is `/home/repl`, you can move to the `seasonal` folder with `cd seasonal`.")
)

```

***

```yaml
type: ConsoleExercise
key: e69c8eac15
xp: 35
```

`@instructions`
Use `pwd` to check that you're there.

`@hint`
Remember to press "enter" or "return" after entering the command.

`@solution`
```{shell}
pwd

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_correct(
      has_expr_output(),
      has_code('pwd')
    )
)

```

***

```yaml
type: ConsoleExercise
key: f6b265bd7f
xp: 30
```

`@instructions`
Use `ls` without any paths to see what's in that directory.

`@hint`
Remember to press "enter" or "return" after the command.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_correct(
      has_expr_output(),
      has_code('ls', incorrect_msg="Your command did not generate the correct output. Have you used `ls` with no paths to show the contents of the current directory?")
    )
)

Ex().success_msg("Neat! This was about navigating down to subdirectories. What about moving up? Let's find out!")

```

---

## How can I move up a directory?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

The **parent** of a directory is the directory above it.
For example, `/home` is the parent of `/home/repl`,
and `/home/repl` is the parent of `/home/repl/seasonal`.
You can always give the absolute path of your parent directory to commands like `cd` and `ls`.
More often,
though,
you will take advantage of the fact that the special path `..`
(two dots with no spaces) means "the directory above the one I'm currently in".
If you are in `/home/repl/seasonal`,
then `cd ..` moves you up to `/home/repl`.
If you use `cd ..` once again,
it puts you in `/home`.
One more `cd ..` puts you in the *root directory* `/`,
which is the very top of the filesystem.
(Remember to put a space between `cd` and `..` - it is a command and a path, not a single four-letter command.)

A single dot on its own, `.`, always means "the current directory",
so `ls` on its own and `ls .` do the same thing,
while `cd .` has no effect
(because it moves you into the directory you're currently in).

One final special path is `~` (the tilde character),
which means "your home directory",
such as `/home/repl`.
No matter where you are,
`ls ~` will always list the contents of your home directory,
and `cd ~` will always take you home.

<hr>
If you are in `/home/repl/seasonal`,
where does `cd ~/../.` take you?

`@hint`
Trace the path one directory at a time.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (the root directory)

`@feedback`
- No, but either `~` or `..` on its own would take you there.
- Correct! The path means 'home directory', 'up a level', 'here'.
- No, but `.` on its own would do that.
- No, the final part of the path is `.` (meaning "here") rather than `..` (meaning "up").

---

## How can I copy files?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

You will often want to copy files,
move them into other directories to organize them,
or rename them.
One command to do this is `cp`, which is short for "copy".
If `original.txt` is an existing file,
then:

```{shell}
cp original.txt duplicate.txt
```

creates a copy of `original.txt` called `duplicate.txt`.
If there already was a file called `duplicate.txt`,
it is overwritten.
If the last parameter to `cp` is an existing directory,
then a command like:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

copies *all* of the files into that directory.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 6ab3fb1e25
xp: 50
```

`@instructions`
Make a copy of `seasonal/summer.csv` in the `backup` directory (which is also in `/home/repl`),
calling the new file `summer.bck`.

`@hint`
Combine the name of the destination directory and the name of the copied file
to create a relative path for the new file.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` doesn't appear to exist in the `backup` directory. Provide two paths to `cp`: the existing file (`seasonal/summer.csv`) and the destination file (`backup/summer.bck`)."),
    has_cwd('/home/repl')
)

```

***

```yaml
type: ConsoleExercise
key: d9e1214bb0
xp: 50
```

`@instructions`
Copy `spring.csv` and `summer.csv` from the `seasonal` directory into the `backup` directory
*without* changing your current working directory (`/home/repl`).

`@hint`
Use `cp` with the names of the files you want to copy
and *then* the name of the directory to copy them to.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` doesn't appear to have been copied into the `backup` directory. Provide two filenames and a directory name to `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Make sure to copy the files while in `{{dir}}`! Use `cd {{dir}}` to navigate back there."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Good job. Other than copying, we should also be able to move files from one directory to another. Learn about it in the next exerise!")
```

---

## How can I move a file?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

While `cp` copies a file,
`mv` moves it from one directory to another,
just as if you had dragged it in a graphical file browser.
It handles its parameters the same way as `cp`,
so the command:

```{shell}
mv autumn.csv winter.csv ..
```

moves the files `autumn.csv` and `winter.csv` from the current working directory
up one level to its parent directory
(because `..` always refers to the directory above your current location).

`@instructions`
You are in `/home/repl`, which has sub-directories `seasonal` and `backup`.
Using a single command, move `spring.csv` and `summer.csv` from `seasonal` to `backup`.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
mv seasonal/spring.csv seasonal/summer.csv backup
```

`@sct`
```{python}
backup_patt="The file `%s` is not in the `backup` directory. Have you used `mv` correctly? Use two filenames and a directory as parameters to `mv`."
seasonal_patt="The file `%s` is still in the `seasonal` directory. Make sure to move the files with `mv` rather than copying them with `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Well done, let's keep this shell train going!")
```

---

## How can I rename files?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` can also be used to rename files. If you run:

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

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 710187c8c7
xp: 35
```

`@instructions`
Go into the `seasonal` directory.

`@hint`
Remember that `cd` stands for "change directory" and that relative paths do not start with a leading '/'.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="If your current working directory (find out with `pwd`) is `/home/repl`, you can move to the `seasonal` folder with `cd seasonal`.")
)

```

***

```yaml
type: ConsoleExercise
key: ed5fe1df23
xp: 35
```

`@instructions`
Rename the file `winter.csv` to be `winter.csv.bck`.

`@hint`
Use `mv` with the current name of the file and the name you want it to have in that order.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Use `mv` with two arguments: the file you want to rename (`winter.csv`) and the new name for the file (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="We expected to find `winter.csv.bck` in the directory." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="We were no longer expecting `winter.csv` to be in the directory." + hint)
    )
)

```

***

```yaml
type: ConsoleExercise
key: 1deee4c768
xp: 30
```

`@instructions`
Run `ls` to check that everything has worked.

`@hint`
Remember to press "enter" or "return" to run the command.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Have you used `ls` to list the contents of your current working directory?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Your command didn't generate the correct file listing. Use `ls` without arguments to list the contents of your current working directory.")
    )
)
Ex().success_msg("Copying, moving, renaming, you've all got it figured out! Next up: deleting files.")

```

---

## How can I delete files?

```yaml
type: BulletConsoleExercise
key: 2734680614
xp: 100
```

We can copy files and move them around;
to delete them,
we use `rm`,
which stands for "remove".
As with `cp` and `mv`,
you can give `rm` the names of as many files as you'd like, so:

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

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: d7580f7bd4
xp: 25
```

`@instructions`
You are in `/home/repl`.
Go into the `seasonal` directory.

`@hint`
Remember that `cd` stands for "change directory" and that a relative path does not start with a leading '/'.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().has_cwd('/home/repl/seasonal')

```

***

```yaml
type: ConsoleExercise
key: 1c21cc7039
xp: 25
```

`@instructions`
Remove `autumn.csv`.

`@hint`
Remember that `rm` stands for "remove".

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="We weren't expecting `autumn.csv` to still be in the `seasonal` directory. Use `rm` with the path to the file you want to remove."),
    has_code('rm', incorrect_msg = 'Use `rm` to remove the file, rather than moving it.')
)

```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Go back to your home directory.

`@hint`
If you use `cd` without any paths, it takes you home.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Use `cd ..` or `cd ~` to return to the home directory.")

```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Remove `seasonal/summer.csv` without changing directories again.

`@hint`
Remember that `rm` stands for "remove".

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="We weren't expecting `summer.csv` to still be in the `seasonal` directory. Use `rm` with the path to the file you want to remove."),
    has_code('rm', incorrect_msg = 'Use `rm` to remove the file, rather than moving it.')
)
Ex().success_msg("Impressive stuff! Off to the next one!")

```

---

## How can I create and delete directories?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` treats directories the same way it treats files:
if you are in your home directory and run `mv seasonal by-season`,
for example,
`mv` changes the name of the `seasonal` directory to `by-season`.
However,
`rm` works differently.

If you try to `rm` a directory,
the shell prints an error message telling you it can't do that,
primarily to stop you from accidentally deleting an entire directory full of work.
Instead,
you can use a separate command called `rmdir`.
For added safety,
it only works when the directory is empty,
so you must delete the files in a directory *before* you delete the directory.
(Experienced users can use the `-r` option to `rm` to get the same effect;
we will discuss command options in the next chapter.)

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 5a81bb8589
xp: 25
```

`@instructions`
Without changing directories,
delete the file `agarwal.txt` in the `people` directory.

`@hint`
Remember that `rm` stands for "remove" and that a relative path does not start with a leading '/'.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` should no longer be in `/home/repl/people`. Have you used `rm` correctly?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'There are still files in the `people` directory. If you simply moved `agarwal.txt`, or created new files, delete them all.')
)

```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Now that the `people` directory is empty,
use a single command to delete it.

`@hint`
Remember that `rm` only works on files.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "The 'people' directory should no longer be in your home directory. Use `rmdir` to remove it!")
)

```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Since a directory is not a file,
you must use the command `mkdir directory_name`
to create a new (empty) directory.
Use this command to create a new directory called `yearly` below your home directory.

`@hint`
Run `mkdir` with the name of the directory you want to create.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', incorrect_msg="There is no `yearly` directory in your home directory. Use `mkdir yearly` to make one!")
)

```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Now that `yearly` exists,
create another directory called `2017` inside it
*without* leaving your home directory.

`@hint`
Use a relative path for the sub-directory you want to create.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            incorrect_msg="Cannot find a '2017' directory in '/home/repl/yearly'. You can make this directory using the relative path `yearly/2017`.")
)
Ex().success_msg("Cool! Let's wrap up this chapter with an exercise that repeats some of its concepts!")

```

---

## Wrapping up

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

You will often create intermediate files when analyzing data.
Rather than storing them in your home directory,
you can put them in `/tmp`,
which is where people and programs often keep files they only need briefly.
(Note that `/tmp` is immediately below the root directory `/`,
*not* below your home directory.)
This wrap-up exercise will show you how to do that.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 59781bc43b
xp: 25
```

`@instructions`
Use `cd` to go into `/tmp`.

`@hint`
Remember that `cd` stands for "change directory" and that an absolute path starts with a '/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'You are in the wrong directory. Use `cd` to change directory to `/tmp`.')
)

```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
List the contents of `/tmp` *without* typing a directory name.

`@hint`
If you don't tell `ls` what to list, it shows you what's in your current directory.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "You didn't call `ls` to generate the file listing."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Your command didn't generate the correct file listing. Use `ls` without`.")
    )
)

```

***

```yaml
type: ConsoleExercise
key: edaf1bcf96
xp: 25
```

`@instructions`
Make a new directory inside `/tmp` called `scratch`.

`@hint`
Use `mkdir` to make directories.

`@solution`
```{shell}
mkdir scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_correct(
      has_dir('/tmp/scratch'),
      has_code('mkdir +scratch', incorrect_msg="Cannot find a 'scratch' directory under '/tmp'. Make sure to use `mkdir` correctly.")
    )
)

```

***

```yaml
type: ConsoleExercise
key: a904a3a719
xp: 25
```

`@instructions`
Move `/home/repl/people/agarwal.txt` into `/tmp/scratch`.
We suggest you use the `~` shortcut for your home directory and a relative path for the second rather than the absolute path.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Cannot find 'agarwal.txt' in '/tmp/scratch'. Use `mv` with `~/people/agarwal.txt` as the first parameter and `scratch` as the second.")
)
Ex().success_msg("This concludes chapter 1 of the intro to Shell for Data Science course! Rush over to the next chapter to learn more about manipulating data!")

```

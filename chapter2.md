---
title       : Manipulating data
description : >-
  The commands you saw in the previous chapter let you move things around in the file system.
  This chapter will show you how to work with the data that's in those files.
  The tools we will look at are fairly simple,
  but are the model for everything that's more powerful.


--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:82bdc9af65
## Looking at file headers

The first thing most data scientists do when given a new dataset to analyze is
figure out what fields it contains and what values those fields have.
If the dataset has been exported from a database or spreadsheet,
it will often be stored as *comma-separated values* (CSV).
A quick way to figure out what it contains is to look at the first few rows.

We can do this in the shell using a command called `head`.
As its name suggests,
it prints the first few lines of a file
(where "a few" means 10),
so the command:

```{shell}
head seasonal/summer.csv
```

displays:

```
Date,Tooth
2017-01-11,canine
2017-01-18,wisdom
2017-01-21,bicuspid
2017-02-02,molar
2017-02-27,wisdom
2017-02-27,wisdom
2017-03-07,bicuspid
2017-03-15,wisdom
2017-03-20,canine
```

<hr>

What does `head` do if there aren't 10 lines in the file?
(To find out, use it to look at the top of `people/agarwal.txt`.)

*** =instructions
- Print an error message because the file is too short.
- Display as many lines as there are.
- Display enough blank lines to bring the total to 10.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sct
```{shell}
Ex().test_mc(2, ['no', 'yes', 'no'])
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:9eb608f6c9
## Modifying commands

You won't always want to look at the first 10 lines of a file,
so the shell lets you change `head`'s behavior
by giving it a *command-line flag* (or just "flag" for short).
If you run the command:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` will only display the first three lines of the file.
If you run `head -n 100`,
it will display the first 100 (assuming there are that many),
and so on.

Command flags don't have to be a `-` followed by a single letter,
but it's a widely-used convention.
A flag's name usually indicates its purpose
(for example, `-n` is meant to signal "**n**umber of lines"),
but what was obvious to the person who created the command
sometimes isn't obvious to everyone else.

*** =instructions

Display the first 5 lines of the winter data in the `seasonal` directory.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
head -n 5 seasonal/winter.csv
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*head\s+-n\s+5\s+seasonal/winter.csv\s*',
                        fixed=False,
                        msg='Use `head` with `-n` and the number of lines you want.')
```


--- type:NormalExercise lang:shell xp:50 skills:1 key:7b90b8a7cd
## Getting help

In order to find out what a command does and how to get it to do what you want,
you can use `man` (which stands for "manual").
For example,
the command `man head` produces something like this:

```
HEAD(1)               BSD General Commands Manual              HEAD(1)

NAME
     head -- display first lines of a file

SYNOPSIS
     head [-n count | -c bytes] [file ...]

DESCRIPTION
     This filter displays the first count lines or bytes of each of
     the specified files, or of the standard input if no files are
     specified.  If count is omitted it defaults to 10.

     If more than a single file is specified, each file is preceded by
     a header consisting of the string ``==> XXX <=='' where ``XXX''
     is the name of the file.

SEE ALSO
     tail(1)
```

The one-line description under `NAME` tells you briefly what the command does,
and the summary under `SYNOPSIS` lists all of the options.
Anything that is optional is shown in square brackets `[...]`,
either/or alternatives are separated by `|`,
and things that can be repeated are shown by `...`,
so `head`'s manual page is telling you that you can *either* give a line count with `-n`
or a byte count with `-c`,
and that you can give it any number of filenames.

The problem with the Unix manual is that you have to know what you're looking for.
If you don't,
you can search on [Stack Overflow](https://stackoverflow.com/),
ask a question on DataCamp's Slack channels,
or look at the `SEE ALSO` sections of the commands you already know.

*** =instructions

Look at the manual page for `tail`,
and then use it to display all *but* the first six lines of `seasonal/spring.csv`.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
tail -n +6 seasonal/spring.csv
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*man\s+tail\s*',
                        fixed=False,
                        msg='Use `man` followed by the name of a command.')
Ex().test_student_typed(r'\s*tail\s+-n\s+\+6\s+seasonal/spring.csv\s*',
                        fixed=False,
                        msg='Use `+NUMBER` to display lines after the first NUMBER.')
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:925e9d645a
## Selecting columns

`head` and `tail` let you select rows from a text file.
If you want to select columns,
you can use the command `cut`.
It has several options (use `man cut` to explore them),
but the most common is something like:

```{shell}
cut -f 2-5,8 -d , values.csv
```

which means
"select columns 2 through 5 and columns 8,
using comma as the separator".
`cut` uses `-f` (meaning "fields") to specify columns
and `-d` (meaning "delimiter") to specify the separator.
You need to specify thelatter because some files may use spaces, tabs, or colons to separate columns.

`cut` is a simple-minded command.
In particular,
it doesn't understand quoted strings.
If, for example, your file is:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

then:

```{shell}
cut -f 2 -d , everyone.csv`
```

will produce:

```
Age
Ranjit"
Rupinder"
```

rather than everyone's age,
because it will think the comma between last and first names is a column separator.
We will meet more intelligent commands that understand quoting and much else later in this course.

<hr>

What command will select the first column (containing dates) from the spring data?
starting with `spring.csv`?

*** =instructions

- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Either of the above.
- Neither of the above, because `-f` must come before `-d`.

*** =hint

The order of the flags doesn't matter.

*** =pre_exercise_code
```{shell}

```

*** =sct
```{python}
Ex().test_mc(3, ['Yes, but that is not all', 'Yes, but that is not all', 'Correct!', 'No, flag order doesn\'t matter'])
```

--- type:TabConsoleExercise key:32c0d30049
## Repeating commands

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 188a2fab38

*** =xp1: 10

One of the biggest advantages of using the shell is that
it makes it easy for you to do things over again.
If you run some commands,
you can then press the up-arrow key to cycle back through them.
You can also use the left and right arrow keys and the delete key to edit them.
Pressing return will then run the modified command.

Even better, `history` will print a list of commands you have run recently.
Each one is preceded by a serial number to make it easy to re-run particular commands:
just type `!55` to re-run the 55th command in your history.
You can also re-run a command by typing an exclamation mark followed by the command's name,
such as `!head` or `!cut`,
which will re-run the most recent use of that command.

*** =instructions1

Run `head summer.csv` in your home directory (which should fail).

*** =hint1

*** =sample_code1
```{bash}

```

*** =solution1
```{bash}
head summer.csv
```

*** =sct1
```{python}
Ex().test_student_typed(r'\s*head\s+summer.csv\s*',
                        fixed=False,
                        msg='Use `head` and a filename.')
```

*** =type2: ConsoleExercise
*** =key2: cba6bf99a5

*** =xp2: 10

To make the previous command work,
you need to be in the `seasonal` directory.

*** =instructions2

Change directory to `seasonal`.

*** =hint2

*** =sample_code2
```{bash}

```

*** =solution2
```{bash}
cd seasonal
```

*** =sct2
```{python}
Ex().test_student_typed(r'\s*cd\s+seasonal\s*',
                        fixed=False,
                        msg='Use `cd` and a directory name.')
```

*** =type3: ConsoleExercise
*** =key3: 74f5c8d2fc

*** =xp3: 10

You can now repeat your previous `head` command without retyping it.

*** =instructions3

Re-run the `head` command using `!` followed by the command name.

*** =hint3

*** =sample_code3
```{bash}
```

*** =solution3
```{bash}
!head
```

*** =sct3
```{python}
Ex().test_student_typed(r'\s*!head\s*',
                        fixed=False,
                        msg='Use `!` followed by the name of the command.')
```

*** =type4: ConsoleExercise
*** =key4: a28555575a

*** =xp4: 10

To find out how to repeat the command by number,
you must take a look at what you've done.

*** =instructions4

Use `history` to look at what you have done.

*** =hint4

*** =sample_code4
```{bash}
```

*** =solution4
```{bash}
history
```

*** =sct4
```{python}
Ex().test_student_typed(r'\s*history\s*',
                        fixed=False,
                        msg='Use `history` to get a list.')
```

*** =type5: ConsoleExercise
*** =key5: 0629b2adf3

*** =xp5: 10

You can now repeat your earlier `head` command using its serial number.

*** =instructions5

Re-run `head` again using `!` followed by a command number.

*** =hint5

*** =sample_code5
```{bash}
```

*** =solution5
```{bash}
!3
```

*** =sct5
```{python}
Ex().test_student_typed(r'\s*!3\s*',
                        fixed=False,
                        msg='Use `!` followed by a number.')
```

--- type:NormalExercise lang:shell xp:100 skills:1 key:b887e95637
## Tab completion

Another shell power tool is *tab completion*.
If you start typing the name of a file and then press the tab key,
the shell will do its best to auto-complete the path.
For example,
if you type `sea` and press tab,
it will fill in the word `seasonal`.
If you then type `a` and tab,
it will complete the path as `seasonal/autumn.csv`.
If the path is ambiguous,
such as `seasonal/s`,
pressing tab a second time will display a list of possibilities.
Typing another character or two to make your path more specific
and then pressing tab
will fill in the rest of the name.

*** =instructions

- Run `head seasonal/autumn.csv` without typing the full filename.
- Run `head seasonal/spring.csv` without typing the full filename.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}
# Run head seasonal/autumn.csv, typing as few characters as possible.


# Run head seasonal/spring.csv, typing as few characters as possible.

```

*** =solution
```{shell}
head seasonal/autumn.csv
head seasonal/spring.csv
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*head\s+seasonal/autumn.csv\s*',
                        fixed=False,
                        msg='Type `head s`, a tab, `a`, and a tab.')
Ex().test_student_typed(r'\s*head\s+seasonal/spring.csv\s*',
                        fixed=False,
                        msg='Type `head s`, a tab, `sp`, and a tab.')
```

--- type:BulletConsoleExercise key:adf1516acf
## Selecting by value

`head` and `tail` select rows,
`cut` selects columns,
and `grep` selects lines according to what they contain.
In its simplest form,
`grep` takes a piece of text followed by one or more filenames
and prints all of the linesin those files that contain that text.
For example,
`grep bicuspid seasonal/winter.csv`
prints all of the lines from the winter data that contain "bicuspid".

`grep` can search for patterns as well;
we will explore those in the next course.
What's more important right now is some of `grep`'s more common flags:

- `-c`: print a count of matching lines rather than the lines themselves
- `-h`: do *not* print the names of files when searching multiple files
- `-i`: ignore case (e.g., treat "Regression" and "regression" as matches)
- `-l`: print the names of files that contain matches, not the matches
- `-n`: print line numbers for matching lines
- `-v`: invert the match, i.e., only show lines that *don't* match

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 0d7ef2baa0

*** =xp1: 10

*** =instructions1

Find all of the lines containing the word `molar` in the autumn data.

*** =hint1

Use `grep` with the word you are searching for and the name of the file(s) to search in.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
grep molar seasonal/autumn.csv
```

*** =sct1
```{python}
Ex().test_student_typed(r'\s*grep\s+molar\s+seasonal/autumn.csv\s*',
                        fixed=False,
                        msg='Use the relative path to the file to search.')
```

*** =type2: ConsoleExercise
*** =key2: a0eee34d1e

*** =xp2: 20

*** =instructions2

Find all of the lines that *don't* contain the word `molar` in the spring data, and show their line numbers.

*** =hint3

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
grep -v -n molar seasonal/spring.csv
```

*** =sct2
```{python}
Ex().test_student_typed(r'\s*grep\s+((-v\s+-n)|(-n\s+\v))\s+molar\s+seasonal/spring.csv\s*',
                        fixed=False,
                        msg='Use `-v` or `-n` in either order.')
```

*** =type3: ConsoleExercise
*** =key3: f5641234fe

*** =xp3: 30

*** =instructions3

Count how many lines contain the word `incisor` in the autumn and winter data combined.

*** =hint3

*** =sample_code3
```{shell}

```

*** =solution3
```{shell}
grep -c incisor seasonal/autumn.csv seasonal/winter.csv
```

*** =sct3
```{python}
Ex().test_student_typed(r'\s*grep\s+-c\s+incisor\s+((seasonal/autumn.csv\s+seasonal/winter.csv)|(seasonal/winter.csv\s+seaonal/autumn.csv))\s*',
                        fixed=False,
                        msg='Use `-c` to get a count.')
```

--- type:BulletConsoleExercise key:2054e64e49
## Wrapping up

To pull together everything we have done in this chapter,
you will find and use a command that stitches data files together in columns.

FIXME: this exercise doesn't work right now because of platform limitations.

*** =type1: ConsoleExercise
*** =key1: 8ad337a04f

*** =xp1: 20

*** =instructions1

The `SEE ALSO` section of the manual page for `cut` refers to `colrm` and `paste`.
Read the manual page for `paste`,
and then run `paste` to combine the autumn and winter data files in a single table.

*** =hint1

Like many commands, `paste` takes any number of filenames as parameters.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
paste seasonal/autumn.csv seasonal/winter.csv
```

*** =sct1
```{python}
Ex().test_student_typed(r'\s*paste\s+seasonal/autumn.csv\s+seasonal/winter.csv\s*',
                        fixed=False,
                        msg='Use `paste` with the names of both files.')
```

*** =type2: ConsoleExercise
*** =key2: a45f125925

*** =xp2: 30

*** =instructions2

Modify your previous command so that it joins the two files with a comma instead of a tab.
That that the output of the answer to this question
is incorrect from a data analysis point of view
because joining the lines has produced rows with different numbers of columns:
there's a missing `,` whenever the second file overflows.

*** =hint2

Re-read the manual page if necessary to find out what flag you need to use.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
paste -d , seasonal/autumn.csv seasonal/winter.csv
```

*** =sct2
```{python}
Ex().test_student_typed(r'\s*paste\s+-d\s*,s+seasonal/autumn.csv\s+seasonal/winter.csv\s*',
                        fixed=False,
                        msg='Use `paste -d ,` with the names of both files.')
```

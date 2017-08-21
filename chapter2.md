---
title       : Manipulating data
description : >-
  The commands you saw in the previous chapter let you move things around in the file system.
  This chapter will show you how to work with the data that's in those files.
  The tools we will look at are fairly simple,
  but are the model for everything that's more powerful.
  
--- type:NormalExercise lang:shell xp:100 skills:1 key:088c6f17e3
## Looking at file headers

The first thing most data scientists do when given a new dataset to analyze is
figure out what fields it contains and what values those fields have.
If the dataset has been exported from a database or spreadsheet,
it will often be stored as *comma-separated values* (CSV).
A quick way to figure out what it contains is to look at the first few rows.

We can do this in the shell using a command called `head`.
As its name suggests,
it prints the first few lines of a file
(where "a few" means 10).
Thus,
the command:

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

*** =instructions

What does `head` do when a file contains fewer than 10 lines?
To find out,
look at the head of `people/agarwal.txt`.

FIXME: need to convert this to an MCQ with console code.

*** =hint

`head` takes the path to a file as its sole parameter.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
head people/agarwal.txt
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*head\s+people/agarwal.txt\s*', fixed=False, msg='Use `head` on a short file.')
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
but it's a widely-used convention for more common options.
More advanced or less-frequently-used flags will often have the form `--longer-name`,
i.e.,
two dashes followed by the flag's meaning spelled out in full.
A flag's name usually indicates its purpose
(for example, `-n` is meant to signal "**n**umber of lines"),
but what was obvious to the person who created the command
sometimes isn't obvious to everyone else.

*** =instructions

Display the first 5 lines of the winter data.

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
Ex().test_student_typed(r'\s*head\s+-n\s+5\s+seasonal/winter.csv\s*', fixed=False, msg='Use `head` with `-n` and the number of lines you want.')
```


--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:7b90b8a7cd
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

The problem with the Unix manual is that
you have to know what you're looking for in order to get help.
If you don't know the name of the command you need,
your best alternative is to search on a site like [Stack Overflow](https://stackoverflow.com/),
or to ask a question on DataCamp's Slack channels.
Once you know a couple of dozen commands,
their `SEE ALSO` sections will also help you find what you need.

FIXME: is there a way to introduce the `less` pager here?  If not, introduce another exercise to teach it explicitly.

*** =instructions

- Look at the manual page for `tail`.
- What flags would you give to `tail` to have it display the *first* 6 lines of a file in reverse order?

FIXME: MCQ for `tail -r -n +6`

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sct
```{python}
Ex().test_student_typed(r'\s*man\s+tail\s*', fixed=False, msg='Use `man` followed by the name of a command.')
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:925e9d645a
## Selecting columns

`head` and `tail` let you select rows from a text file.
If you want to select columns,
you can use the command `cut`.
It has several options (use `man cut` to explore them),
but the most common is something like:

```{shell}
cut -d , -f 2-5,8 values.csv
```

which means
"select columns 2 through 5 and columns 8,
using comma as the separator".
(You need to specify a separator because some files may use spaces, tabs, or colons to separate columns.)

`cut` is a useful command,
but there are things it can't do.
In particular,
it cannot re-order columns:
`-d 2,1` will produce an error message rather than swapping the first two columns of a file.
`cut` also doesn't understand quoted strings.
If, for example, your file is:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

then the command:

```{shell}
cut -d , -f 2 everyone.csv`
```

will produce:

```
Age
Ranjit"
Rupinder"
```

rather than everyone's age.
(Note that the closing double quote around the name is included in the output as well.)
We will meet more intelligent commands that understand quoting and much else later in this course.

<hr>

What command will select the date columns from all of the files in the `seasonal` directory in calendar order,
starting with `spring.csv`?

*** =instructions

- cut -d , -f 1 seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv seasonal/winter.csv
- cut -d, -f1 seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv seasonal/winter.csv
- Both of the above.
- Neither of the above.

*** =hint

Provide multiple filenames to `cut`.

*** =pre_exercise_code
```{shell}

```

--- type:NormalExercise lang:shell xp:100 skills:1 key:03a4873a16
## Repeating commands

One of the biggest advantages of using the shell is that
it makes it easy for you to do things over again.
If you run some commands,
you can then press the up-arrow key to cycle back through them.
You can also use the left and right arrow keys and the delete key to edit them,
and then press the return key to run the modified the command.

FIXME: how to insert very short video clip here of running commands, cycling back through them, and re-running.

If you want an overview of what you have done recently,
the `history` command will print a list.
Each command is preceded by a serial number,
which makes it easy to re-run a particular command:
just type `!55` to re-run the 55th command in your history.
You can also re-run a command by typing an exclamation mark followed by the command's name,
such as `!head` or `!cut`,
which will re-run the most recent use of that command.

One final power tool is *tab completion*.
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

- Run `head summer.csv` in your home directory (which should fail).
- Change directory to `seasonal`.
- Re-run the `head` command using `!` followed by the command name.
- Use `history` to look at what you have done.
- Re-run `head` again using `!` followed by a command number.
- Run `head autumn.dat` without typing the full filename.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
head summer.csv
cd seasonal
!head
history
!3
head autumn.dat
```

*** =sct
```{python}

```

--- type:NormalExercise lang:shell xp:50 skills:1 key:1e207b45b3
## Selecting by value

`head` and `tail` select rows,
`cut` selects columns,
and the inelegantly-named command `grep` selects lines according to what they contain.
In its simplest form,
`grep` takes a piece of text as its first parameter,
followed by one or more filenames,
and prints all of the lines that contain that text.
For example,
`grep bicuspid seasonal/winter.csv`
will select all of the lines from the winter data file that contain the word "bicuspid".

`grep` can actually search for patterns, not just specific pieces of text;
we will explore those patterns in the second course in this sequence.
What's more important right now is some of `grep`'s more common flags,
including:

- `-c`: print a count of matching lines rather than the lines themselves
- `-h`: do *not* print the names of files when searching multiple files
- `-i`: ignore case (e.g., treat "Regression" and "regression" as matches)
- `-l`: only print the names of files that contain matches, not the matches themselves
- `-n`: print line numbers for matching lines
- `-v`: invert the match, i.e., only show lines that *don't* match

*** =instructions

- Find all of the lines containing the word `molar` in the autumn data.
- Find all of the lines that *don't* contain the word `molar` in the spring data, and show their line numbers.
- Count how many lines contain the word `incisor` in all four of the seasonal data files using a single command.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
grep molar seasonal/autumn.csv
grep -v -n molar seasonal/spring.csv
grep -c incisor seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

*** =sct
```{python}

```

--- type:BulletConsoleExercise key:2054e64e49
## Wrapping up

To pull together everything we have done in this chapter,
you will find and use a command that stitches data files together in columns.

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 98a32c7a4d

*** =xp1: 10

*** =instructions1

Read the `SEE ALSO` section of the manual page for `cut`.
One of the commands listed there is `colrm`.
Type in the name of the other without any parameters
to get a one-line summary of its usage.

*** =hint1

We often say "cut and something" when editing text, where "something" is the name of this command.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
paste
```

*** =sct1
```{python}
Ex().test_student_typed(r'\s*paste\s*', fixed=False, msg='Use `paste` on a line by itself to get a short usage summary.')
```

*** =type2: ConsoleExercise
*** =key2: 8ad337a04f

*** =xp2: 20

*** =instructions2

- Read the manual page for `paste`.
- Run `paste` to combine the autumn and winter data files in a single table.

*** =hint3

Like many commands, `paste` takes any number of filenames as parameters.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
paste seasonal/autumn.csv seasonal/winter.csv
```

*** =sct2
```{python}
Ex().test_student_typed(r'\s*paste\s+seasonal/autumn.csv\s+seasonal/winter.csv\s*', fixed=False, msg='Use `paste` with the names of both files.')
```

*** =type3: ConsoleExercise
*** =key3: a45f125925

*** =xp3: 30

*** =instructions3

Modify your previous command so that it joins the two files with a comma instead of a tab.

*** =hint3

Re-read the manual page if necessary to find out what flag you need to use.

FIXME: need to comment here about the fact that the output file isn't usable because lines have been joined, not columns - there's a missing `,` to make two-column space whenever the second file overflows.

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
paste -d , seasonal/autumn.csv seasonal/winter.csv
```

*** =sct3
```{python}
Ex().test_student_typed(r'\s*paste\s+-d\s*,\s+seasonal/autumn.csv\s+seasonal/winter.csv\s*', fixed=False, msg='Use `paste -d ,` with the names of both files.')
```

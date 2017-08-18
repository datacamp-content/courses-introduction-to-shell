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
```{shell}
FIXME
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
```{shell}
FIXME
```


--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:7b90b8a7cd
## Getting help

In order to find out what a command does and how to get it to do what you want,
you can use `man` (which stands for "manual").
For example,
the command `man head` produces something like this:

```
HEAD(1)                   BSD General Commands Manual                  HEAD(1)

NAME
     head -- display first lines of a file

SYNOPSIS
     head [-n count | -c bytes] [file ...]

DESCRIPTION
     This filter displays the first count lines or bytes of each of the specified files, or of the standard
     input if no files are specified.  If count is omitted it defaults to 10.

     If more than a single file is specified, each file is preceded by a header consisting of the string
     ``==> XXX <=='' where ``XXX'' is the name of the file.

EXIT STATUS
     The head utility exits 0 on success, and >0 if an error occurs.

SEE ALSO
     tail(1)
```

The one-line description under `NAME` tells you briefly what the command does,
and the summary under `SYNOPSIS` lists all of the options.
By convention,
anything that is optional is shown in square brackets `[...]`,
either/or alternatives are separated by `|`,
and things that can be repeated are shown by `...`,
so `head`'s manual page is telling you that you can *either* give a line count with `-n`
or a byte count with `-c`,
and that you can give it zero or more filenames.
(We will look at what happens when you don't give it any filenames in the next chapter.)
The `EXIT STATUS` section will be explained later as well.

The problem with the Unix manual from a newcomer's point of view is that
you have to know what you're looking for in order to get help.
If you don't know the name of the command you need,
your best alternative is to search on a site like [Stack Overflow](https://stackoverflow.com/),
or to ask a question on DataCamp's Slack channels.
Once you know a couple of dozen commands,
their `SEE ALSO` sections will also help you find what you need.

*** =instructions

1. Look at the manual page for `tail`.
2. What flags would you give to `tail` to have it display the *first* 6 lines of a file in reverse order?

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sct
```{shell}
FIXME: test that they run `man tail`.
FIXME: MCQ for `tail -r -n +6`
```

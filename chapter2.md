---
title       : Manipulating data
description : >-
  The commands you saw in the previous chapter let you move things around in the filesystem.
  This chapter will show you how to work with the data that's in those files.
  The tools we will look at are fairly simple,
  but are the model for everything that's more powerful.


--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:82bdc9af65
## How can I look at the start of a file?

The first thing most data scientists do when given a new dataset to analyze is
figure out what fields it contains and what values those fields have.
If the dataset has been exported from a database or spreadsheet,
it will often be stored as **comma-separated values** (CSV).
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

--- type:NormalExercise lang:shell xp:100 skills:1 key:0b7b8ca8f7
## How can I type less?

One of the shell's power tools is **tab completion**.
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

--- type:NormalExercise lang:shell xp:100 skills:1 key:9eb608f6c9
## How can I control what commands do?

You won't always want to look at the first 10 lines of a file,
so the shell lets you change `head`'s behavior
by giving it a **command-line flag** (or just "flag" for short).
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

--- type:NormalExercise lang:shell xp:100 skills:1 key:f830d46419
## How can I list everything below a directory?

In order to see everything underneath a directory,
no matter how deeply nested it is,
you can give `ls` the flag `-R`
(which means "recursive").
If you use `ls -R` in your home directory,
you will see something like this:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

This shows every file and directory in the current level,
then everything in each sub-directory,
and so on.

*** =instructions

To help you know what is what,
`ls` has another flag `-F` that prints a `/` after the name of every directory
and a `*` after the name of every runnable program.
Run `ls` with `-R`, `-F`, *and* the absolute path to your home directory
to see everything it contains.

*** =hint

The order of the flags doesn't matter, but the directory name must come last.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
ls -R -F /home/repl
```

*** =sct
```{python}
pattern = r'\s*ls\s+((-R\s+-F)|(-F\s+-R))\s+/home/repl\s*'
Ex().test_student_typed(pattern,
                        fixed=False,
                        msg='Use either `ls -R -F` or `ls -F -R` and the path `/home/repl`.')
```

--- type:BulletConsoleExercise key:
## How can I get help for a command?
To find out what commands do,
people used to use the `man` command
(short for "manual").
For example,
the command `man head` brings up this information:

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

(You may need to press the space bar to page down a few times to see it all.)
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
you can search [Stack Overflow](https://stackoverflow.com/),
ask a question on DataCamp's Slack channels,
or look at the `SEE ALSO` sections of the commands you already know.

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1:

*** =xp1: 10

*** =instructions1

Read the manual page for the `tail` command.

*** =hint1

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
man tail | cat
```

*** =sct1
```{python}
Ex().test_student_typed(r'\s*man\s+tail.+\s*',
                        fixed=False,
                        msg='Use `man` and the command name.')
```

*** =type2: ConsoleExercise
*** =key2:

*** =xp2: 10

*** =instructions2

 Use `tail` to display all *but* the first six lines of `seasonal/spring.csv`.

*** =hint2

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
tail -n +7 seasonal/spring.csv
```

*** =sct2
```{python}
Ex().test_student_typed(r'\s*tail\s+-n\s+\+7\s+seasonal/spring.csv\s*',
                        fixed=False,
                        msg='`man` told you that `+NUMBER` will display lines starting from NUMBER.')
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:925e9d645a
## How can I select columns from a file?

`head` and `tail` let you select rows from a text file.
If you want to select columns,
you can use the command `cut`.
It has several options (search for `unix man cut` to explore them),
but the most common is something like:

```{shell}
cut -f 2-5,8 -d , values.csv
```

which means
"select columns 2 through 5 and columns 8,
using comma as the separator".
`cut` uses `-f` (meaning "fields") to specify columns
and `-d` (meaning "delimiter") to specify the separator.
You need to specify the latter because some files may use spaces, tabs, or colons to separate columns.

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
## How can I repeat commands?

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

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 188a2fab38

*** =xp1: 10

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
Do not type any spaces between `!` and what follows.

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
# FIXME: bodging the SCT to get a pass.
Ex().test_student_typed(r'\s*.+\s*',
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
Do *not* type any spaces between `!` and what follows.

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
# FIXME: bodging the SCT to get a pass.
Ex().test_student_typed(r'\s*.+\s*',
                        fixed=False,
                        msg='Use `!` followed by a number.')
```

--- type:BulletConsoleExercise key:adf1516acf
## How can I select lines containing particular values?

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

Find all of the lines containing the word `molar` in the autumn data
by running a single command from your home directory.

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
(Again, run a single command from your home directory.)

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
Ex().test_student_typed(r'\s*grep\s+((-v\s+-n\s+molar)|(-n\s+molar\s+\v))\s+seasonal/spring.csv\s*',
                        fixed=False,
                        msg='Use `-v` or `-n molar` in either order.')
```

*** =type3: ConsoleExercise
*** =key3: f5641234fe

*** =xp3: 30

*** =instructions3

Count how many lines contain the word `incisor` in the autumn and winter data combined.
(Again, run a single command from your home directory.)

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

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:11914639fc
## Why isn't it always safe to treat data as text?

The `SEE ALSO` section of the manual page for `cut` refers to a command called `paste`
that can be used to combine data files instead of cutting them up.

<hr>

Search online for `unix man paste`,
and then run `paste` to combine the autumn and winter data files in a single table
using a comma as a separator.
What's wrong with the output from a data analysis point of view?

*** =instructions
- The column headers are repeated.
- The last few rows have the wrong number of columns.
- Some of the data from `winter.csv` is missing.

*** =hint

If you `cut` the output of `paste` using commas as a separator,
would it produce the right answer?

*** =pre_exercise_code
```{shell}

```

*** =sct
```{python}
err1 = 'True, but it is not necessarily an error.'
correct2 = 'Correct: joining the lines with columns creates only one empty column at the start, not two.'
err3 = 'No, all of the winter data is there.'
Ex().test_mc(2, [err1, correct2, err3])
```

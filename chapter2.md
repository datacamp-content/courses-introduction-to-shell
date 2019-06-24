---
title: 'Manipulating data'
description: 'The commands you saw in the previous chapter let you move things around in the filesystem. This chapter will show you how to work with the data that''s in those files. The tools we will look at are fairly simple, but are the model for everything that''s more powerful.'
---

## How can I view a file's contents?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Before you rename or delete files,
you may want to have a look at their contents.
The simplest way to do this is with `cat`,
which just prints the contents of files onto the screen.
(Its name is short for "concatenate", meaning "to link things together",
since it will print all the files whose names you give it, one after the other.)

```{shell}
cat agarwal.txt
```
```
name: Agarwal, Jasmine
position: RCT2
start: 2017-04-01
benefits: full
```

`@instructions`
Print the contents of `course.txt` to the screen.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
cat course.txt
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Your command didn't generate the right output. Have you used `cat` followed by the name of the file, `course.txt`?")
)
Ex().success_msg("Nice! Let's look at other ways to view a file's contents.")
```

---

## How can I view a file's contents piece by piece?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

You can use `cat` to print large files and then scroll through the output,
but it is usually more convenient to **page** the output.
The original command for doing this was called `more`,
but it has been superseded by a more powerful command called `less`.
(This kind of naming is what passes for humor in the Unix world.)
When you `less` a file,
one page is displayed at a time;
you can press spacebar to page down or type `q` to quit.

If you give `less` the names of several files,
you can type `:n` (colon and a lower-case 'n') to move to the next file,
`:p` to go back to the previous one,
or `:q` to quit.

Note: If you view solutions to exercises that use `less`,
you will see an extra command at the end that turns paging *off*
so that we can test your solutions efficiently.

`@instructions`
Use `less seasonal/spring.csv seasonal/summer.csv` to view those two files in that order.
Press spacebar to page down, `:n` to go to the second file, and `:q` to quit.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
# You can leave out the '| cat' part here:
less seasonal/spring.csv seasonal/summer.csv | cat
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_or(
        has_code(r'\s*less\s+seasonal/spring\.csv\s+seasonal/summer\.csv\s*',
                 incorrect_msg='Use `less` and the filenames. Remember that `:n` moves you to the next file.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## How can I look at the start of a file?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills: 1
```

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

`@possible_answers`
- Print an error message because the file is too short.
- Display as many lines as there are.
- Display enough blank lines to bring the total to 10.

`@hint`
What is the most useful thing it could do?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Incorrect: that isn't the most useful thing it could do.",
                    "Correct!",
                    "Incorrect: that would be impossible to distinguish from a file that ended with a bunch of blank lines."])
```

---

## How can I type less?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

One of the shell's power tools is **tab completion**.
If you start typing the name of a file and then press the tab key,
the shell will do its best to auto-complete the path.
For example,
if you type `sea` and press tab,
it will fill in the directory name `seasonal/` (with a trailing slash).
If you then type `a` and tab,
it will complete the path as `seasonal/autumn.csv`.

If the path is ambiguous,
such as `seasonal/s`,
pressing tab a second time will display a list of possibilities.
Typing another character or two to make your path more specific
and then pressing tab
will fill in the rest of the name.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 4e30296c27
xp: 50
```

`@instructions`
Run `head seasonal/autumn.csv` without typing the full filename.

`@hint`
Type as much of the path as you need to, then press tab, and repeat.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="The checker couldn't find the right output in your command. Are you sure you called `head` on `seasonal/autumn.csv`?")
)

```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Run `head seasonal/spring.csv` without typing the full filename.

`@hint`
Type as much of the path as you need to, then press tab, and repeat.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="The checker couldn't find the right output in your command. Are you sure you called `head` on `seasonal/spring.csv`?")
)
Ex().success_msg("Good work! Once you get used to using tab completion, it will save you a lot of time!")

```

---

## How can I control what commands do?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

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

A flag's name usually indicates its purpose
(for example, `-n` is meant to signal "**n**umber of lines").
Command flags don't have to be a `-` followed by a single letter,
but it's a widely-used convention.

Note: it's considered good style to put all flags *before* any filenames,
so in this course,
we only accept answers that do that.

`@instructions`
Display the first 5 lines of `winter.csv` in the `seasonal` directory.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
head -n 5 seasonal/winter.csv
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_correct(
        has_expr_output(incorrect_msg="Are you sure you're calling `head` on the `seasonal/winter.csv` file?"),
        has_expr_output(strict=True, incorrect_msg="Are you sure you used the flag `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Are you sure you used the flag `-n 5`?")
)
Ex().success_msg("Nice! With this technique, you can avoid your shell from blowing up if you want to have a look at larger text files.")
```

---

## How can I list everything below a directory?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

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

`@instructions`
To help you know what is what,
`ls` has another flag `-F` that prints a `/` after the name of every directory
and a `*` after the name of every runnable program.
Run `ls` with the two flags, `-R` and `-F`, and the absolute path to your home directory
to see everything it contains.
(The order of the flags doesn't matter, but the directory name must come last.)

`@hint`
Your home directory can be specified using `~` or `.` or its absolute path.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
ls -R -F /home/repl
```

`@sct`
```{python}
Ex().check_or(
  has_expr_output(incorrect_msg='Use either `ls -R -F` or `ls -F -R` and the path `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Use either `ls -R -F` or `ls -F -R` and the path `/home/repl`.')
)
Ex().success_msg("That's a pretty neat overview, isn't it?")
```

---

## How can I get help for a command?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

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

`man` automatically invokes `less`,
so you may need to press spacebar to page through the information
and `:q` to quit.

The one-line description under `NAME` tells you briefly what the command does,
and the summary under `SYNOPSIS` lists all the flags it understands.
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

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 52d629048a
xp: 50
```

`@instructions`
Read the manual page for the `tail` command to find out
what putting a `+` sign in front of the number used with the `-n` flag does.
(Remember to press spacebar to page down and/or type `q` to quit.)

`@hint`
Remember: `man` is short for "manual".

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Use `man` and the command name.')

```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Use `tail` with the flag `-n +7` to display all *but* the first six lines of `seasonal/spring.csv`.

`@hint`
Use a plus sign '+' in front of the number of lines you want displayed.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Are you calling `tail` on `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Are you share you used the flag `-n +7`?")
)

```

---

## How can I select columns from a file?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

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
You need to specify the latter because some files may use spaces, tabs, or colons to separate columns.

<hr>

What command will select the first column (containing dates) from the  file `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Either of the above.
- Neither of the above, because `-f` must come before `-d`.

`@hint`
The order of the flags doesn't matter.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Yes, but that is not all', 'Yes, but that is not all', 'Correct! Adding a space after the flag is good style, but not compulsory.', 'No, flag order doesn\'t matter'])
```

---

## What can't cut do?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

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
cut -f 2 -d , everyone.csv
```

will produce:

```
Age
Ranjit"
Rupinder"
```

rather than everyone's age,
because it will think the comma between last and first names is a column separator.

<hr>

What is the output of `cut -d : -f 2-4` on the line:

```
first:second:third:
```

(Note the trailing colon.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- None of the above, because there aren't four fields.

`@hint`
Pay attention to the trailing colon.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['No, there is more.', 'No, there is more.', 'Correct! The trailing colon creates an empty fourth field.', 'No, `cut` does the best it can.'])
```

---

## How can I repeat commands?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

One of the biggest advantages of using the shell is that
it makes it easy for you to do things over again.
If you run some commands,
you can then press the up-arrow key to cycle back through them.
You can also use the left and right arrow keys and the delete key to edit them.
Pressing return will then run the modified command.

Even better, `history` will print a list of commands you have run recently.
Each one is preceded by a serial number to make it easy to re-run particular commands:
just type `!55` to re-run the 55th command in your history (if you have that many).
You can also re-run a command by typing an exclamation mark followed by the command's name,
such as `!head` or `!cut`,
which will re-run the most recent use of that command.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 188a2fab38
xp: 20
```

`@instructions`
Run `head summer.csv` in your home directory (which should fail).

`@hint`
Tab completion won't work if there isn't a matching filename.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Use `head` and a filename, `summer.csv`. Don't worry if it fails. It should.")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Change directory to `seasonal`.

`@hint`
Remember that `cd` stands for "change directory".

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
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Re-run the `head` command with `!head`.

`@hint`
Do not type any spaces between `!` and what follows.

`@solution`
```{shell}
!head

```

`@sct`
```{python}
# !head is expanded into head summer.csv by the terminal, so manually specify expression
# This won't work for the validator though, so we have to use check_or to satisfy it.
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_or(
        has_expr_output(expr = 'head summer.csv',
                        incorrect_msg='Use `!head` to repeat the `head` command.'),
        has_code('!head')
    )
)

```

***

```yaml
type: ConsoleExercise
key: a28555575a
xp: 20
```

`@instructions`
Use `history` to look at what you have done.

`@hint`
Notice that `history` shows the most recent commands last, so that they are left on your screen when it finishes running.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Use `history` without flags to get a list of previous commands.')

```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Re-run `head` again using `!` followed by a command number.

`@hint`
Do *not* type any spaces between `!` and what follows.

`@solution`
```{shell}
!3

```

`@sct`
```{python}
# !3 is expanded into head summer.csv by the terminal, so manually specify expression
# This won't work for the validator though, so we have to use check_or to satisfy it.
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_or(
        has_expr_output(expr = 'head summer.csv',
                        incorrect_msg='Have you used `!<a_number>` to rerun the last `head` from the history?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Well done! To the next one!")

```

---

## How can I select lines containing specific values?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` and `tail` select rows,
`cut` selects columns,
and `grep` selects lines according to what they contain.
In its simplest form,
`grep` takes a piece of text followed by one or more filenames
and prints all of the lines in those files that contain that text.
For example,
`grep bicuspid seasonal/winter.csv`
prints lines from `winter.csv` that contain "bicuspid".

`grep` can search for patterns as well;
we will explore those in the next course.
What's more important right now is some of `grep`'s more common flags:

- `-c`: print a count of matching lines rather than the lines themselves
- `-h`: do *not* print the names of files when searching multiple files
- `-i`: ignore case (e.g., treat "Regression" and "regression" as matches)
- `-l`: print the names of files that contain matches, not the matches
- `-n`: print line numbers for matching lines
- `-v`: invert the match, i.e., only show lines that *don't* match

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 0d7ef2baa0
xp: 35
```

`@instructions`
Print the contents of all of the lines containing the word `molar` in `seasonal/autumn.csv`
by running a single command while in your home directory. Don't use any flags.

`@hint`
Use `grep` with the word you are searching for and the name of the file(s) to search in.

`@solution`
```{shell}
grep molar seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("grep", incorrect_msg = "Did you call `grep`?"),
      has_code("molar", incorrect_msg = "Did you search for `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Did you search the `seasonal/autumn.csv` file?")
    )
  )
)

```

***

```yaml
type: ConsoleExercise
key: a0eee34d1e
xp: 35
```

`@instructions`
Invert the match to find all of the lines that *don't* contain the word `molar` in `seasonal/spring.csv`, and show their line numbers.
Remember, it's considered good style to put all of the flags *before* other values like filenames or the search term "molar".

`@hint`


`@solution`
```{shell}
grep -v -n molar seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("grep", incorrect_msg = "Did you call `grep`?"),
      has_code("-v", incorrect_msg = "Did you invert the match with `-v`?"),
      has_code("-n", incorrect_msg = "Did you show line numbers with `-n`?"),
      has_code("molar", incorrect_msg = "Did you search for `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Did you search the `seasonal/spring.csv` file?")
    )
  )
)

```

***

```yaml
type: ConsoleExercise
key: f5641234fe
xp: 30
```

`@instructions`
Count how many lines contain the word `incisor` in `autumn.csv` and `winter.csv` combined.
(Again, run a single command from your home directory.)

`@hint`
Remember to use `-c` with `grep` to count lines.

`@solution`
```{shell}
grep -c incisor seasonal/autumn.csv seasonal/winter.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("grep", incorrect_msg = "Did you call `grep`?"),
      has_code("-c", incorrect_msg = "Did you get counts with `-c`?"),
      has_code("incisor", incorrect_msg = "Did you search for `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Did you search the `seasonal/autumn.csv` file?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Did you search the `seasonal/winter.csv` file?")
    )
  )
)

```

---

## Why isn't it always safe to treat data as text?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

The `SEE ALSO` section of the manual page for `cut` refers to a command called `paste`
that can be used to combine data files instead of cutting them up.

<hr>

Read the manual page for `paste`,
and then run `paste` to combine the autumn and winter data files in a single table
using a comma as a separator.
What's wrong with the output from a data analysis point of view?

`@possible_answers`
- The column headers are repeated.
- The last few rows have the wrong number of columns.
- Some of the data from `winter.csv` is missing.

`@hint`
If you `cut` the output of `paste` using commas as a separator,
would it produce the right answer?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'True, but it is not necessarily an error.'
correct2 = 'Correct: joining the lines with columns creates only one empty column at the start, not two.'
err3 = 'No, all of the winter data is there.'
Ex().has_chosen(2, [err1, correct2, err3])
```

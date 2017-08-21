---
title       : Combining tools
description : >-
  The real power of the Unix shell lies not in the individual commands,
  but in how easily they can be combined to do new things.
  This chapter will show you how to use this power to select the data you want,
  and introduce commands for sorting values and removing duplicates.
  
--- type:NormalExercise lang:shell xp:100 skills:1 key:07a427d50c
## Redirection

`head` and `tail` will select the first and last lines of a file,
but what if you want lines from the middle?
More specifically,
suppose you want to get lines 3-5 from one of our data files:
how can you do that?

The shell doesn't have a special command for that because it doesn't need one:
you can do what you want by combining what you have.
To start,
run the command:

```{shell}
head -n 5 seasonal/summer.csv
```

which prints the first 5 lines of the summer data on the screen.
Try running this command instead:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

Nothing appears on the screen.
Instead,
`head`'s output is put in a new file called `top.csv`.
You can take a look at that file's contents using `cat`,
which just prints the contents of one or more files:

```{shell}
cat top.csv
```

The greater-than sign `>` is what tells the shell to *redirect* `head`'s output to a file.
It isn't part of the `head` command;
instead,
it works with every shell command that produces output.

Now that you have the first 5 lines of our data in a file,
you can use `tail` to select the last 3:

```{shell}
tail -n 3 top.csv
```

A quick check confirms that this is lines 3-5 of our original file,
because it is the last 3 lines of the first 5.

*** =instructions

Use two commands to select the second-to-last line from `seasonal/winter.csv`.
Call your intermediate file `bottom.csv`.

*** =hint

The second-to-last line is the first line of the last two lines of the file.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv
head -1 bottom.csv
```

*** =sct
```{python}

```

--- type:NormalExercise lang:shell xp:100 skills:1 key:b36aea9a1e
## Pipes

Redirection can be used to combine any series of commands,
but has two drawbacks:

1. It leaves a lot of intermediate files lying around (like `top.csv`).
2. The commands to produce your final result are scattered across several lines of history.

The shell provides another tool that solves both of these problems at once called a *pipe*.
Once again,
start by running `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

Instead of sending `head`'s output to a file,
add a vertical bar and the `tail` command *without* a filename:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

The pipe symbol tells the shell to use the output of the command on the left
as the input to the command on the right
without creating any intermediate files.
The data might be written temporarily to disk,
stored in memory,
or bounced off a mirror on the moon via laser
(yes, this has actually been done);
all you need to know is that what comes out of the first command goes into the second.

Combining commands with pipes is like combining functions in math,
but instead of reading from the inside out,
you read from left to right.
And just like functions,
you can chain any number of commands together.
For example,
this pipe:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

does the following:

1. Select the first column from the spring data.
2. Remove the header line containing the word "Date".
3. Select the first 10 lines of actual data.

*** =instructions

The command `wc` (short for "word count") will print the number of characters, words, and lines in a file.
Look at its manual page to see how to get it to print only the number of lines,
and then write a one-line command using pipes to count how many records there are in `seasonal/spring.csv`
from July 2017.

*** =hint

Use `grep` with a partial date to select the lines and `wc` with an appropriate flag to count.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
grep 2017-07 seasonal/spring.csv | wc -l
```

*** =sct
```{python}

```


--- type:NormalExercise lang:shell xp:100 skills:1 key:602d47e70c
## Wildcards

Most Unix commands will work on multiple files at once
provided you give them the names of those files.
For example,
you can get the first column from all of the seasonal data files at once like this:

```{shell}
cut -d , -f 1 seasonal/winter.csv sesaonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

But typing the names of many files over and over is a bad idea:
it wastes time,
and sooner or later you will either leave a file out or repeat a file's name.
To make your life better,
the shell allows you to use *wildcards* to specify a list of files with a single expression.
The most commonly used wildcard is the `*` character,
which means "match zero or more characters".
For example,
we can run the same `cut` command shown above like this:

```{shell}
cut -d , -f 1 seasonal/*
```

or:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

or even:

```{shell}
cut -d , -f 1 sea*/*.c*
```

In each case,
the shell *expands* the `*` to find all files whose names match the pattern.

The shell has other wildcards as well,
though they are less commonly used:

- `?` matches a single character, so `201?.txt` will match `2017.txt` or `2018.txt`, but not `2017-01.txt`.
- `[...]` matches any one of the characters inside the square brackets, so `201[78].txt` matches `2017.txt` or `2018.txt`, but not `2016.txt`.
- `{...}` matches any of the command-separated patterns inside the curly brackets, so `{*.txt, *.csv}` matches any file whose name ends with `.txt` or `.csv`, but not files whose names end with `.pdf`.

*** =instructions

Write a single command to get the first three lines from the spring and summer data files but *not* the autumn or winter data files.
Use a wildcard instead of spelling out the files' names in full.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
head seasonal/s*.csv
```

*** =sct
```{python}

```
--- type:NormalExercise lang:shell xp:100 skills:1 key:ed77aed337
## Sorting and removing duplicates

To get some more practice with pipes,
and to see how to perform some other common operations on data,
have a look at the manual pages for the two commands `sort` and `uniq`.
As its name suggests,
`sort` puts data in order.
By default it does this in ascending alphabetical order,
but flags like `-n` and `-r` can be used to sort numerically and reverse the order of its output,
while other flags like `-b` and `-f` will tell it to ignore leading blanks or upper and lower case.

`uniq`'s job is to remove duplicated lines - more specifically,
*adjacent* duplicated lines.
If a file contains:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

then `uniq` will produce:

```
2017-07-03
2017-08-03
```

but if the file contains:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

then `uniq` will print all four lines.
The reason is that `uniq` is built to work with very large files.
In order to remove non-adjacent lines from a file,
it would have to keep the whole file in memory
(or at least,
all the unique lines seen so far).
By only removing adjacent duplicates,
it only has to keep the most recent unique line in memory.

*** =instructions

Write a single-line command using pipes to do each of the following tasks.
You can write each command by using up-arrow to repeat the previous line
and appending the next command to it.

- Get the second column from all of the data files in `seasonal`.
- As above, and remove the word "Tooth" from the output so that only tooth names are displayed.
- As above, and sort the output so that all occurrences of a particular tooth name are adjacent
- As above, and display each tooth name once along with a count of how often it occurs.

Consult the manual page for `uniq` to see how to display a count of unique lines.
This select/sort/count idiom is very common in command-line data processing.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
cut -d , -f 2 seasonal/*.csv
cut -d , -f 2 seasonal/*.csv | grep -v Tooth
cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort
cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c
```

*** =sct
```{python}

```

--- type:BulletConsoleExercise key:
## Wrapping up

To wrap up,
you will build a pipeline to find out how many records are in the shortest of the seasonal data files.

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1:
*** =xp1: 10

*** =instructions1

Use `wc` with appropriate parameters to list the number of lines in all of the seasonal data files.
(Use a wildcard for the filenames instead of typing them all in by hand.)

*** =hint1

Use `-l` to list only the lines and `*` to match filenames.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
wc -l seasonal/*.csv
```

*** =sct1
```{python}
Ex().test_student_typed(r'\s*wc\s+-l\s+seasonal/\*\.csv\s*', fixed=False, msg='Use `wc -l` and `seasonal/*.csv`.')
```

*** =type2: ConsoleExercise
*** =key2:
*** =xp2: 20

*** =instructions2

Add another command to the previous one using a pipe to remove the line reporting the total number of lines.

*** =hint3

Use `grep -v` to select lines that *don't* contain certain text.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
wc -l seasonal/*.csv | grep -v total
```

*** =sct2
```{python}
Ex().test_student_typed(r'\s*wc\s+-l\s+seasonal/\*\.csv\s*|\s*grep\s+-v\s+total\s*', fixed=False, msg='Use `grep -v total` as the second stage of the pipe.')
```

*** =type3: ConsoleExercise
*** =key3:
*** =xp3: 30

*** =instructions3

Add two more stages to the pipeline that use `sort` and `head` to find the file containing the fewest lines.

*** =hint3

Remember to use `sort -n` to sort numerically.

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
wc -l seasonal/*.csv | grep -v total | sort -n | head -n 1
```

*** =sct3
```{python}
Ex().test_student_typed(r'\s*wc\s+-l\s+seasonal/\*\.csv\s*|\s*grep\s+-v\s+total\s*|\s*sort\s+-n\s*|\s*head\s+-n\s+1\s*', fixed=False, msg='Use `sort -n` and `head -n 1`.')
```

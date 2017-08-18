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

This trick can be used to combine any series of commands,
but has two drawbacks:

1. It leaves a lot of intermediate files lying around (like `top.csv`).
2. The commands to produce your final result are scattered across several lines of history.

The next exercise in this chapter will show you a more elegant way to do this.

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
```{shell}

```

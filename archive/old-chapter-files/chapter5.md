---
title: Building New Commands
description: >-
  - putting fixed commands in a shell script

  - executing scripts with `bash scriptname`

  - making scripts executable with `chmod` (hate to introduce this in passing,
  but...)

  - handling multiple filenames with `$@`

  - using wildcards `*` and `?`

  - using `history | tail > file.sh` to start a shell script

--- type:NormalExercise lang:python xp:100 skills:2 key:82122da595
## Using Wildcards in Pipes

We want to find the three files in our current directory which have the least number of lines. Which command listed below would work?

1. `wc -l * > sort -n > head -n 3`
2. `wc -l * | sort -n | head -n 1-3`
3. `wc -l * | head -n 3 | sort -n`
4. `wc -l * | sort -n | head -n 3`

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sample_code
```{python}

```

*** =solution
```{python}

```

*** =sct
```{python}

```

--- type:NormalExercise lang:python xp:100 skills:2 key:800a245406
## Removing Unneeded Files

Suppose you want to delete your processed data files, and only keep your raw files and processing script to save storage. The raw files end in `.dat` and the processed files end in `.txt`. Which of the following would remove all the processed data files, and *only* the processed data files?

1. `rm ?.txt`
2. `rm *.txt`
3. `rm * .txt`
4. `rm *.*`

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sample_code
```{python}

```

*** =solution
```{python}

```

*** =sct
```{python}

```

--- type:NormalExercise lang:python xp:100 skills:2 key:07e4f21bbc
## Wildcard Expressions

The wildcard `[xy]` matches *either* a single `x` or a single `y` character. Fill in the blank in the expression below to list only the files from 2012 and 2013.

```
ls ____.dat
```

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sample_code
```{python}

```

*** =solution
```{python}

```

*** =sct
```{python}

```

--- type:NormalExercise lang:python xp:100 skills:2 key:3465394f15
## Reproducing Your Work

Fill in the blanks in the shell script `dates.sh` to select unique dates from the file `mortality.txt`.

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sample_code
```{python}

```

*** =solution
```{python}

```

*** =sct
```{python}

```

--- type:NormalExercise lang:python xp:100 skills:2 key:d1d309e992
## Generalizing Your Work

Fill in the blanks in the shell script `dates.sh` to select unique dates from a single file whose name is given as the script's sole command-line argument.

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sample_code
```{python}

```

*** =solution
```{python}

```

*** =sct
```{python}

```

--- type:NormalExercise lang:python xp:100 skills:2 key:a3d484129c
## Diagnosis

When you run this command:

```
head -10 | tail -3 mortality.txt
```

it prints the last 3 lines of `mortality.txt` and then hangs (i.e., it doesn't give you a fresh shell prompt for writing more commands).  Why?

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sample_code
```{python}

```

*** =solution
```{python}

```

*** =sct
```{python}

```

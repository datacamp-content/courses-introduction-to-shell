---
title: Manipulating Data
description: |-
  - `head` and `tail`
  - `cut`
  - `grep` (with very simple patterns)
  - `sort`
  - `uniq`
  - `nl`
  - `man`

--- type:NormalExercise lang:python xp:100 skills:2 key:b25231fd77
## Selecting Dates and Names

Write a command that selects *only* the date and name field from each record in `mortality.txt`.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:813626aa9f
## Selecting Specific Years

Write a command that selects *only* the data from 2000, 2005, and 2010 from `mortality.txt`.

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

--- type:MultipleChoiceExercise lang:python xp:50 skills:2 key:bbd401e455
## Removing Duplicates from Multiple Files

You want to remove duplicate lines from multiple files with one command, so you write `uniq births.txt mortality.txt`. What actually happens?

1. The command removes any duplicate lines that occur in either `births.txt` or `mortality.txt`.
2. The command removes duplicate lines in `births.txt` and `mortality.txt` independently.
3. The command removes duplicate lines in `births.txt` and `mortality.txt`, *and* removes the first line(s) of `second.txt` if they duplicate the last line(s) of `births.txt`.
4. The command removes duplicate lines from `births.txt` and stores the result in `mortality.txt`.

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sct
```{python}

```

--- type:NormalExercise lang:python xp:100 skills:2 key:142f05d04d
## Unintended Consequences

Given your answer to the previous question, what happens if you run the command `uniq births.txt births.txt`?

1. It removes duplicate lines from `births.txt` and stores the result in `births.txt`.
2. It erases the contents of `births.txt`.
3. It produces no output, because every line of input now appears to be duplicated.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:70719cd907
## Sorting Multiple Files

What does `sort births.txt mortality.txt` do?

1. It sorts the contents of `births.txt` and then the contents of `mortality.txt` separately.
2. It sorts the merged contents of `births.txt` and `mortality.txt` as if they were one file.
3. It sorts `births.txt` and writes the output to `mortality.txt` (overwriting whatever was there).
4. None of the above.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:4642d03585
## Suppressing Headers

By default, `tail` displays the names of the files it is tailing when it is asked to tail multiple files. Use `man tail` to examine its documentation (or type `man tail` into your favorite search engine) and then write a single command that displays the last line of `birth.txt` and `mortality.txt` *without* filename headers.

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

---
title: Reusing and Combining Commands
description: |-
  - `history`
  - re-executing with `!name` and `!number`
  - output redirection with `>`
  - why this is a clumsy way to combine multiple commands
  - using `|`

--- type:NormalExercise lang:python xp:100 skills:2 key:c8849c910a
## Unique Dates

Using pipes to combine two or more basic commands, write a single-line command that displays unique dates in `mortality.txt`.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:88bdea13ed
## Counting Causes

Using pipes to combine two or more basic commands, write a single-line command that displays a list of causes of death in `mortality.txt` sorted in order of decreasing frequency. Display the frequency as well as the cause.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:4735a5c485
## Unique Causes

Using pipes to combine two or more basic commands, write a single-line command that lists unique causes of death in `mortality.txt`, i.e., causes that only occur once.  Display only the frequency, *not* the cause.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:b36da33088
## File Lengths

Use `man wc` to find out how to count the number of lines in one or more files, and then use it in a pipe to list `births.txt`, `mortality.txt`, and `accidents.txt` from fewest to greatest number of lines.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:9da43b400e
## Analyzing Pipelines

A file called `animals.txt` contains the following data:

```
2012-11-05,deer
2012-11-05,rabbit
2012-11-05,raccoon
2012-11-06,rabbit
2012-11-06,deer
2012-11-06,fox
2012-11-07,rabbit
2012-11-07,bear
```

What text passes through each of the pipes and the final redirect in the pipeline below?

```
$ cat animals.txt | head -n 5 | tail -n 3 | sort -r > final.txt
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

--- type:MultipleChoiceExercise lang:python xp:50 skills:2 key:1f083596da
## Which Pipeline?

`animals.txt` contains data formatted as follows:

```
2012-11-05,deer
2012-11-05,rabbit
2012-11-05,raccoon
2012-11-06,rabbit
...
```

What command would you use to produce a table that shows the total count of each type of animal in the file?

1.  `grep {deer, rabbit, raccoon, deer, fox, bear} animals.txt | wc -l`
2.  `sort animals.txt | uniq -c`
3.  `sort -t, -k2,2 animals.txt | uniq -c`
4.  `cut -d, -f 2 animals.txt | uniq -c`
5.  `cut -d, -f 2 animals.txt | sort | uniq -c`
6.  `cut -d, -f 2 animals.txt | sort | uniq -c | wc -l`

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sct
```{python}

```

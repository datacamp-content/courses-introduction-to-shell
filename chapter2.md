---
title: Core Commands
description: >-
  - `whoami`

  - `pwd` and a comment on how cryptic commands are

  - interpreting output of `pwd`: folders containing folders

  - `ls` (depends on a certain file setup)

  - `cat`

  - Editing text files (use `nano` and explain how a shell can have multiple
  personalities)

  - Text vs. binary files

  - `cp`

  - `mv`

  - `rm`

  - `mkdir` and `rmdir`

--- type:MultipleChoiceExercise lang:python xp:50 skills:2 key:19bb331e1c
## Absolute and Relative Paths

Starting from `/Users/jasmine/data/`, which of the following commands could Jasmine use to navigate to  `/Users/jasmine`?

1. `cd .`
2. `cd /`
3. `cd /home/jasmine`
4. `cd ../..`
5. `cd ~`
6. `cd home`
7. `cd ~/data/..`
8. `cd`
9. `cd ..`

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sct
```{python}

```

--- type:MultipleChoiceExercise lang:python xp:50 skills:2 key:faac5e0c68
## Relative Path Resolution

Using the filesystem diagram below, if `pwd` displays `/Users/jasmine`, what will `ls ../backup` display?

1.  `../backup: No such file or directory`
2.  `2012-12-01 2013-01-08 2013-01-27`
3.  `2012-12-01/ 2013-01-08/ 2013-01-27/`
4.  `original report_final report_sub`

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sct
```{python}

```

--- type:NormalExercise lang:python xp:100 skills:2 key:aa916a8c86
## Listing Options

Given the filesystem shown below, if `pwd` displays `/Users/backup`, and `-r` tells `ls` to display things in reverse order, what command will display:

```
report_sub/ report_final/ original/
```

1.  `ls pwd`
2.  `ls -r -F`
3.  `ls -r -F /Users/backup`
4.  Either #2 or #3 above, but not #1.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:d4caf012d2
## Combining Listing Options

The command `ls -R` lists the contents of directories recursively, i.e., lists their sub-directories, sub-sub-directories, and so on in alphabetical order at each level. The command `ls -t` lists things by time of last change, with most recently changed files or directories first. In what order does `ls -R -t` display things?

1. All files and then all directories in order of last change.
2. All directories in alphabetical order followed by all files in order of last change.
3. Directories alphabetically by level, and their contents in order of last change.
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

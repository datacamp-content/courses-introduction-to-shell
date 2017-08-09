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

--- type:MultipleChoiceExercise lang:python xp:50 skills:2 key:3c36a404e3
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

--- type:MultipleChoiceExercise lang:python xp:50 skills:2 key:a2300beaf5
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

--- type:NormalExercise lang:python xp:100 skills:2 key:87da33fbda
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

--- type:NormalExercise lang:python xp:100 skills:2 key:008da94660
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

--- type:NormalExercise lang:python xp:100 skills:2 key:adbd2e5456
## Editing a File

Use `nano` to create a file called `workplan.txt` in the directory `personal` that contains the following text:

```
Step 1: choose problem.
Step 2: think really hard.
Step 3: profit!
```

Make sure there are no trailing spaces at the ends of lines, or blank lines at the end of the file.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:a1ae5f329b
## Backing Up Files

Create a new directory called `backup` below your home directory, and then copy the files `biography.txt` and `thesis.txt` into that directory.  When you are done, the command `ls backup` should show you:

```
biography.txt .   thesis.txt
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

--- type:MultipleChoiceExercise lang:python xp:50 skills:2 key:f62cab7227
## Special Directory Names

What is the difference between `cd ./..` and `cd ../.` ?

1. Both move you up one directory.
2. The first moves you up one directory, while the second leaves you where you are.
3. The first leaves you where you are, while the second moves you up one directory.
4. Both leave you where you are.

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sct
```{python}

```

--- type:NormalExercise lang:python xp:100 skills:2 key:7efd0b7685
## Moving and Copying

What is the output of the closing `ls` command in the sequence shown below?

```
$ pwd
/Users/jasmine/data

$ ls
mortality.dat

$ mkdir old
$ mv mortality.dat old
$ cp old/mortality.dat ../mortality-saved.dat
$ ls
```

1. `mortality-saved.dat old`
2. `old`
3. `mortality.dat old`
4. `mortality-saved.dat`

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

--- type:MultipleChoiceExercise lang:python xp:50 skills:2 key:096cc49804
## Copy With Multiple Filenames

```
$ ls -F
analysis/  births/  home-ownership.txt  mortality.txt  temp/

$ cp mortality.txt home-ownership.txt births
```

1. Produces an error message.
2. Makes backup copies of both files and the entire `births` directory.
3. Copies the two files to the `births` directory.

*** =instructions

*** =hint

*** =pre_exercise_code
```{python}

```

*** =sct
```{python}

```

--- type:NormalExercise lang:python xp:100 skills:2 key:11caae65ea
## More Copying With Multiple Filenames

Given your answer to the previous exercise, what would happen if you ran the following command instead:

```
$ cp mortality.txt births home-ownership.txt
```

1. Produce an error message.
2. Copy `mortality.txt` to `births`.
3. Copy the two files to the `births` directory.

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

--- type:NormalExercise lang:python xp:100 skills:2 key:82459d8221
## Moving to the Current Folder

You are in the directory `~/analyzed`, and the directory `~/raw` contains a file called `output.txt`. Run a single command to move the file to the `analyzed` directory.  (Remember that `~` is a shorthand for your home directory.)

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

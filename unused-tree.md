--- type:NormalExercise lang:shell xp:100 skills:1 key:89ac1f57de
## Displaying the file system

If the command `tree` has been installed on your computer,
you can use it to draw a picture of the filesystem.
If you run it in your home directory,
it displays:

```
.
├── backup
├── course.txt
├── people
│   └── agarwal.txt
└── seasonal
    ├── autumn.csv
    ├── spring.csv
    ├── summer.csv
    └── winter.csv

3 directories, 6 files
```

Note the use of `.` to mean "the directory you are currently in".

*** =instructions

If you give `tree` the path to a directory,
it will show you the filesystem below that directory.
Run a command to draw a picture of the files and directories inside `/tmp`.

*** =hint

Use `tree` and the path to the directory you're interested in.

*** =pre_exercise_code
```{shell}

```

*** =sample_code
```{shell}

```

*** =solution
```{shell}
tree /tmp
```

*** =sct
```{python}
Ex().test_student_typed(r'\s*tree\s+/tmp\s*', fixed=False, msg='Use `tree` with `/tmp` as a parameter.')
```

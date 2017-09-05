--- type:NormalExercise lang:shell xp:100 skills:1 key:b887e95637
## Tab completion

Another shell power tool is *tab completion*.
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

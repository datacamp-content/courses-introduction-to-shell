---
title       : Example chapter 1
description : Some description.

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:ed8e15ca12
## Example of MultipleChoiceExercise

This is a MultipleChoiceExercise.

*** =instructions
- response a
- response b (correct)
- response c
- response d

*** =hint
The second one is correct.

*** =sct
```{shell}
Ex().test_mc(2, ['wrong', 'right', 'wrong', 'wrong'])
```

--- type:PlainMultipleChoiceExercise lang:shell xp:50 skills:1 key:e0f8fe3b7c
## Example of PlainMultipleChoiceExercise

This is a PlainMultipleChoiceExercise.

*** =instructions
- response a
- response b (correct)
- response c
- response d

*** =hint
The second one is correct.

*** =sct
```{shell}
Ex().test_mc(2, ['wrong', 'right', 'wrong', 'wrong'])
```

--- type:NormalExercise xp:100 key:c778ff1b1a
## Example of NormalExercise

This is a NormalExercise

*** =instructions
- Create a variable `a`, equal to `'2'` and print it out.

*** =pre_exercise_code
```{python}
```

*** =sample_code
```{bash}
# Create variable a


# Print out a

```

*** =solution
```{bash}
# Create variable a
a='2'

# Print out a
echo $a
```

*** =sct
```{python}
Ex().test_student_typed("a='2'", fixed = True)
Ex().success_msg("Great!")
```


--- type:ConsoleExercise xp:100 key:4dd1296871
## Example of ConsoleExercise

*** =instructions
- Create a new directory, called `test`.

*** =solution
```{bash}
mkdir test
```

*** =sct
```{python}
# see https://stackoverflow.com/questions/59838/check-if-a-directory-exists-in-a-shell-script
Ex().test_expr_error('[ -d "test" ]')
Ex().success_msg("Great!")
```

--- type:TabConsoleExercise key:ed98f7522c
## TabConsoleExercise

This is a TabConsoleExercise. Great! Super great!
XP should be defined at the subexercise level

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: f8b2c20c47
*** =xp1: 10

*** =instructions1
Create a folder named `films`

*** =hint1
Here's a hint for instruction 1

*** =sample_code1
```{bash}
echo no sample code
```

*** =solution1
```{bash}
mkdir films;
```

*** =sct1
```{python}
Ex().test_expr_error('ls films', output = "0")
Ex().success_msg("Great!")
```

*** =type2: ConsoleExercise
*** =key2: a4d37ad20b
*** =xp2: 20

*** =instructions2
List me all the files/folders in the current directory

*** =hint3
Here's a hint for instruction 2

*** =sample_code2
```{bash}
echo no sample code
```

*** =solution2
```{bash}
ls;
```

*** =sct2
```{python}
# MC-NOTE: if these exercises aren't stateful, won't have anything in cwd, so SCT will fail
Ex().test_output_contains('films', "Does the output of your command include the `films`?")
Ex().success_msg("Great!")
```

*** =type3: ConsoleExercise
*** =key3: 936cddd386
*** =xp3: 30

*** =instructions3
List me all the files/folders in the current directory with the permissions of each files/folders

*** =hint3
Here's a hint for instruction 3

*** =sample_code3
```{bash}
echo no sample code
```

*** =solution3
```{bash}
ls -la;
```

*** =sct3
```{python}
Ex().test_expr_output('ls -la')
Ex().success_msg("Great!")
```

--- type:BulletConsoleExercise key:6713a94c6b
## BulletConsoleExercise Example

This is a BulletConsoleExercise. Great! Super great!

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 1c22440a1b
*** =xp1: 10

*** =instructions1
Create a folder named `films`

*** =hint1
Here's a hint for instruction 1

*** =sample_code1
```{bash}
echo no sample code
```

*** =solution1
```{bash}
mkdir films;
```

*** =sct1
```{python}
Ex().success_msg("Great!")
```

*** =type2: ConsoleExercise
*** =key2: 0c25cc523d
*** =xp2: 20

*** =instructions2
List me all the files/folders in the current directory

*** =hint3
Here's a hint for instruction 2

*** =sample_code2
```{bash}
echo no sample code
```

*** =solution2
```{bash}
ls;
```

*** =sct2
```{python}
# MC-NOTE: if these exercises aren't stateful, won't have anything in cwd, so SCT will fail
Ex().test_output_contains('films', "Does the output of your command include the `films`?")
Ex().success_msg("Great!")
```

*** =type3: ConsoleExercise
*** =key3: 7c098026e2
*** =xp3: 30

*** =instructions3
List me all the files/folders in the current directory with the permissions of each files/folders

*** =hint3
Here's a hint for instruction 3

*** =sample_code3
```{bash}
echo no code
```

*** =solution3
```{bash}
ls -la;
```

*** =sct3
```{python}
Ex().test_expr_output('ls -la')
Ex().success_msg("Great!")
```

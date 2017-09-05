--- type:PureMultipleChoiceExercise lang:bash xp:50 key:ed34d567c3
## Creating environment variables

You create a normal shell variable by assigning a name to a value.
To create an environment variable,
you must prefix the assignment with the keyword `export`:

```{shell}
export testing=seasonal/winter.csv
```

To see the difference between the two kinds of variables,
you can define `training` to be `seasonal/summer.csv`
and `testing` to be `seasonal/winter.csv`
and then run a shell script that contains these two lines:

```{shell}
echo training is $training
echo testing is $testing
```

it prints:

```
training is
testing is seasonal/winter.csv
```

because the shell variable `training` *isn't* set in the script,
while the environment variable `testing` *is*.
(Note that if a variable doesn't have a value,
the shell replaces it with an empty string.)

<hr>

If you define two variables like this:

```{shell}
export priors=/tmp/training-set.csv
tests=/tmp/user-data.csv
```

and then run this shell script:

```{shell}
echo Priors and testing data are $priors and $tests
```

what is its output?

*** =possible_answers
- Priors and testing data are /tmp/training-set.csv and /tmp/user-data.csv
- [Priors and testing data are /tmp/training-set.csv and ]
- Priors and testing data are  and /tmp/user-data.csv
- Priors and testing data are  and 

*** =hint

The value of an undefined variable is an empty string.

*** =feedbacks
- No: `tests` is not an environment variable.
- Correct!
- No: `priors` is an environment variable but `tests` is not.
- No: `priors` is an environment variable.

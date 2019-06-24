---
title: 'Creating new tools'
description: 'History lets you repeat things with just a few keystrokes, and pipes let you combine existing commands to create new ones. In this chapter, you will see how to go one step further and create new commands of your own.'
---

## How can I edit a file?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix has a bewildering variety of text editors.
For this course,
we will use a simple one called Nano.
If you type `nano filename`,
it will open `filename` for editing
(or create it if it doesn't already exist).
You can move around with the arrow keys,
delete characters using backspace,
and do other operations with control-key combinations:

- `Ctrl` + `K`: delete a line.
- `Ctrl` + `U`: un-delete a line.
- `Ctrl` + `O`: save the file ('O' stands for 'output').
- `Ctrl` + `X`: exit the editor.

`@instructions`
Run `nano names.txt` to edit a new file in your home directory
and enter the following four lines:

```
Lovelace
Hopper
Johnson
Wilson
```

To save what you have written,
type `Ctrl` + `O` to write the file out,
then Enter to confirm the filename,
then `Ctrl` + `X` and Enter to exit the editor.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/names.txt /home/repl
```

`@sct`
```{python}
patt = "Have you included the line `%s` in the `names.txt` file? Use `nano names.txt` again to update your file. Use `Ctrl` + `O` to save and `Ctrl` + `X` to exit."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Well done! Off to the next one!")
```

---

## How can I record what I just did?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

When you are doing a complex analysis,
you will often want to keep a record of the commands you used.
You can do this with the tools you have already seen:

1. Run `history`.
2. Pipe its output to `tail -n 10` (or however many recent steps you want to save).
3. Redirect that to a file called something like `figure-5.history`.

This is better than writing things down in a lab notebook
because it is guaranteed not to miss any steps.
It also illustrates the central idea of the shell:
simple tools that produce and consume lines of text
can be combined in a wide variety of ways
to solve a broad range of problems.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 144ca955ca
xp: 35
```

`@instructions`
Copy the files `seasonal/spring.csv` and `seasonal/summer.csv` to your home directory.

`@hint`
Use `cp` to copy and `~` as a shortcut for the path to your home directory.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Have you used `cp seasonal/s* ~` to copy the required files to your home directory?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Remarkable record-keeping! If you mistyped any commands, you can always use `nano` to clean up the saves history file afterwards.")

```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Use `grep` with the `-h` flag (to stop it from printing filenames)
and `-v Tooth` (to select lines that *don't* match the header line)
to select the data records from `spring.csv` and `summer.csv` in that order
and redirect the output to `temp.csv`.

`@hint`
Put the flags before the filenames.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Make sure you redirect the output of the `grep` command to `temp.csv` with `>`!"
msg2 = "Have you used `grep -h -v ___ ___ ___` (fill in the blanks) to populate `temp.csv`?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/temp.csv', missing_msg=msg1).multi(
        has_code(r'2017-08-04,canine', incorrect_msg=msg2),
        has_code(r'2017-03-14,incisor', incorrect_msg=msg2),
        has_code(r'2017-03-12,wisdom', incorrect_msg=msg2)
    )
)

```

***

```yaml
type: ConsoleExercise
key: c40348c1e5
xp: 30
```

`@instructions`
Pipe `history` into `tail -n 3`
and redirect the output to `steps.txt`
to save the last three commands in a file.
(You need to save three instead of just two
because the `history` command itself will be in the list.)

`@hint`
Remember that redirection with `>` comes at the end of the seuqence of piped commands.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Make sure to redirect the output of your command to `steps.txt`."
msg2="Have you used `history | tail ___ ___` (fill in the blanks) to populate `steps.txt`?"
Ex().multi(
    has_cwd('/home/repl'),
    # When run by the validator, solution3 doesn't pass, so including a has_code for that
    check_or(
        check_file('/home/repl/steps.txt', missing_msg=msg1).multi(
            has_code(r'\s+1\s+', incorrect_msg=msg2),
            has_code(r'\s+3\s+history', incorrect_msg=msg2)
        ),
        has_code(r'history\s+|\s+tail\s+-n\s+4\s+>\s+steps\.txt')
    )
)
Ex().success_msg("Well done! Let's step it up!")

```

---

## How can I save commands to re-run later?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

You have been using the shell interactively so far.
But since the commands you type in are just text,
you can store them in files for the shell to run over and over again.
To start exploring this powerful capability,
put the following command in a file called `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

This command selects the first row from each of the CSV files in the `seasonal` directory.
Once you have created this file,
you can run it by typing:

```{shell}
bash headers.sh
```

This tells the shell (which is just a program called `bash`)
to run the commands contained in the file `headers.sh`,
which produces the same output as running the commands directly.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 316ad2fec6
xp: 50
```

`@instructions`
Use `nano dates.sh` to create a file called `dates.sh`
that contains this command:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

to extract the first column from all of the CSV files in `seasonal`.

`@hint`
Put the commands shown into the file without extra blank lines or spaces.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh .

```

`@sct`
```{python}
msg = "Have you included the line `cut -d , -f 1 seasonal/*.csv` in the `dates.sh` file? Use `nano dates.sh` again to update your file. Use `Ctrl` + `O` to save and `Ctrl` + `X` to exit."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/dates.sh').\
        has_code('cut -d , -f 1 seasonal/*.csv', fixed=True, incorrect_msg=msg)
)

```

***

```yaml
type: ConsoleExercise
key: 30a8fa953e
xp: 50
```

`@instructions`
Use `bash` to run the file `dates.sh`.

`@hint`
Use `bash filename` to run the file.

`@solution`
```{shell}
bash dates.sh

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("bash", incorrect_msg = 'Did you call `bash`?'),
      has_code("dates.sh", incorrect_msg = 'Did you specify the `dates.sh` file?')
    )
  )
)

```

---

## How can I re-use pipes?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

A file full of shell commands is called a ***shell script**,
or sometimes just a "script" for short. Scripts don't have to have names ending in `.sh`,
but this lesson will use that convention
to help you keep track of which files are scripts.

Scripts can also contain pipes.
For example,
if `all-dates.sh` contains this line:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

then:

```{shell}
bash all-dates.sh > dates.out
```

will extract the unique dates from the seasonal data files
and save them in `dates.out`.

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/teeth-start.sh', 'teeth.sh')
```

***

```yaml
type: ConsoleExercise
key: 6fae90f320
xp: 35
```

`@instructions`
A file `teeth.sh` in your home directory has been prepared for you, but contains some blanks.
Use Nano to edit the file and replace the two `____` placeholders
with `seasonal/*.csv` and `-c` so that this script prints a count of the
number of times each tooth name appears in the CSV files in the `seasonal` directory.

`@hint`
Use `nano teeth.sh` to edit the file.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh .

```

`@sct`
```{python}
msg="Have you a replaced the blanks properly so the command in `teeth.sh` reads `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Use `nano teeth.sh` again to make the required changes."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/teeth.sh').\
        has_code(r'cut\s+-d\s+,\s+-f\s+2\s+seasonal/\*\.csv\s+\|\s+grep\s+-v\s+Tooth\s+\|\s+sort\s+\|\s+uniq\s+-c', incorrect_msg=msg)
)

```

***

```yaml
type: ConsoleExercise
key: dcfccb51e2
xp: 35
```

`@instructions`
Use `bash` to run `teeth.sh` and `>` to redirect its output to `teeth.out`.

`@hint`
Remember that `> teeth.out` must come *after* the command that is producing output.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Have you correctly redirected the result of `bash teeth.sh` to `teeth.out` with the `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Did you call `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Did you run the `teeth.sh` file?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Did you redirect to the `teeth.out` file?')
    )
  )
)

```

***

```yaml
type: ConsoleExercise
key: c8c9a11e3c
xp: 30
```

`@instructions`
Run `cat teeth.out` to inspect your results.

`@hint`
Remember, you can type the first few characters of a filename and then press the tab key to auto-complete.

`@solution`
```{shell}
cat teeth.out

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("cat", incorrect_msg = 'Did you call `cat`?'),
      has_code("teeth.out", incorrect_msg = 'Did you specify the `teeth.out` file?')
    )
  )
)
Ex().success_msg("Nice! This all may feel contrived at first, but the nice thing is that you are automating parts of your workflow step by step. Something that comes in really handy as a data scientist!")

```

---

## How can I pass filenames to scripts?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

A script that processes specific files is useful as a record of what you did,
but one that allows you to process any files you want is more useful.
To support this,
you can use the special expression `$@` (dollar sign immediately followed by at-sign)
to mean "all of the command-line parameters given to the script".
For example,
if `unique-lines.sh` contains this:

```{shell}
sort $@ | uniq
```

then when you run:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

the shell replaces `$@` with `seasonal/summer.csv` and processes one file.
If you run this:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

it processes two data files,
and so on.

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/count-records-start.sh', 'count-records.sh')
```

***

```yaml
type: ConsoleExercise
key: 7a893623af
xp: 50
```

`@instructions`
Edit the script `count-records.sh` with Nano and fill in the two `____` placeholders
with `$@` and `-l` respectively so that it counts the number of lines in one or more files,
excluding the first line of each.

`@hint`
Use `nano count-records.sh` to edit the filename.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh .

```

`@sct`
```{python}
msg="Have you a replaced the blanks properly so the command in `count-records.sh` reads `tail -q -n +2 $@ | wc -l`? Use `nano count-records.sh` again to make the required changes."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/count-records.sh').\
        has_code(r'tail\s+-q\s+-n\s+\+2\s+\$@\s+|\s+wc\s+-l', incorrect_msg=msg)
)

```

***

```yaml
type: ConsoleExercise
key: d0da324516
xp: 50
```

`@instructions`
Run `count-records.sh` on `seasonal/*.csv`
and redirect the output to `num-records.out` using `>`.

`@hint`
Use `>` to redirect the output.

`@solution`
```{shell}
bash count-records.sh seasonal/*.csv > num-records.out

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/num-records.out').has_code(r'92'),
    multi(
      has_code("bash", incorrect_msg = 'Did you call `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Did you run the `count-records.sh` file?'),
      has_code("seasonal/\*", incorrect_msg = 'Did you specify the files to process with `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Did you redirect to the `num-records.out` file?')
    )
  )
)
Ex().success_msg("A job well done! Your shell power is ever-expanding!")

```

---

## How can I process a single argument?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

As well as `$@`,
the shell lets you use `$1`, `$2`, and so on to refer to specific command-line parameters.
You can use this to write commands that feel simpler or more natural than the shell's.
For example,
you can create a script called `column.sh` that selects a single column from a CSV file
when the user provides the filename as the first parameter and the column as the second:

```{shell}
cut -d , -f $2 $1
```

and then run it using:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Notice how the script uses the two parameters in reverse order.

<hr>

The script `get-field.sh` is supposed to take a filename,
the number of the row to select,
the number of the column to select,
and print just that field from a CSV file.
For example:

```
bash get-field.sh seasonal/summer.csv 4 2
```

should select the second field from line 4 of `seasonal/summer.csv`.
Which of the following commands should be put in `get-field.sh` to do that?

`@hint`
Remember that command-line parameters are numbered left to right.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- No: that will try to use the filename as the number of lines to select with `head`.
- Correct!
- No: that will try to use the column number as the line number and vice versa.
- No: that will use the field number as the filename and vice versa.

---

## How can one shell script do many things?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Our shells scripts so far have had a single command or pipe,
but a script can contain many lines of commands.
For example,
you can create one that tells you how many records are in the shortest and longest of your data files,
i.e.,
the range of your datasets' lengths.

Note that in Nano, "copy and paste" is achieved by navigating to the line you want to copy, pressing `CTRL` + `K` to cut the line, then `CTRL` + `U` twice to paste two copies of it.

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/range-start-1.sh', 'range.sh')
```

***

```yaml
type: ConsoleExercise
key: a1e55487fb
xp: 25
```

`@instructions`
Use Nano to edit the script `range.sh`
and replace the two `____` placeholders
with `$@` and `-v`
so that it lists the names and number of lines in all of the files given on the command line
*without* showing the total number of lines in all files.
(Do not try to subtract the column header lines from the files.)

`@hint`
Use `wc -l $@` to count lines in all the files given on the command line.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Have you a replaced the blanks properly so the command in `range.sh` reads `wc -l $@ | grep -v total`? Use `nano range.sh` again to make the required changes."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').\
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total', incorrect_msg=msg)
)

```

***

```yaml
type: ConsoleExercise
key: e8ece27fe7
xp: 25
```

`@instructions`
Add `sort -n` and `head -n 1` in that order
to the pipeline in `range.sh`
to display the name and line count of the shortest file given to it.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Have you added `sort -n` and `head -n 1` with pipes to the `range.sh` file? Use `nano range.sh` again to make the required changes."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').\
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total\s+\|\s+sort\s+-n\s+|\s+head\s+-n\s+1', incorrect_msg=msg)
)

```

***

```yaml
type: ConsoleExercise
key: a3b36a746e
xp: 25
```

`@instructions`
Add a second line to `range.sh` to print the name and record count of
the *longest* file in the directory *as well as* the shortest.
This line should be a duplicate of the one you have already written,
but with `sort -n -r` rather than `sort -n`.

`@hint`
Copy the first line and modify the sorting order.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Keep the first line in the `range.sh` file: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Have you duplicated the first line in `range.sh` and made a small change? `sort -n -r` instead of `sort -n`!"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').multi(
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total\s+\|\s+sort\s+-n\s+|\s+head\s+-n\s+1', incorrect_msg=msg1),
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total\s+\|\s+sort\s+-n\s+-r\s+|\s+head\s+-n\s+1', incorrect_msg=msg2)
    )
)

```

***

```yaml
type: ConsoleExercise
key: cba93a77c3
xp: 25
```

`@instructions`
Run the script on the files in the `seasonal` directory
using `seasonal/*.csv` to match all of the files
and redirect the output using `>`
to a file called `range.out` in your home directory.

`@hint`
Use `bash range.sh` to run your script, `seasonal/*.csv` to specify files, and `> range.out` to redirect the output.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Have you correctly redirected the result of `bash range.sh seasonal/*.csv` to `range.out` with the `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/range.out').multi(
      has_code('21 seasonal/autumn.csv', fixed=True, incorrect_msg=msg),
      has_code('26 seasonal/winter.csv', fixed=True, incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Did you call `bash`?'),
      has_code("bash\s+range.sh", incorrect_msg = 'Did you run the `range.sh` file?'),
      has_code("seasonal/\*", incorrect_msg = 'Did you specify the files to process with `seasonal/*`?'),
      has_code(">\s+range.out", incorrect_msg = 'Did you redirect to the `range.out` file?')
    )
  )
)
Ex().success_msg("This is going well. Head over to the next exercise to learn about writing loops!")

```

---

## How can I write loops in a shell script?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shell scripts can also contain loops.
You can write them using semi-colons,
or split them across lines without semi-colons to make them more readable:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(You don't have to indent the commands inside the loop,
but doing so makes things clearer.)

The first line of this script is a **comment**
to tell readers what the script does.
Comments start with the `#` character and run to the end of the line.
Your future self will thank you for adding brief explanations like the one shown here
to every script you write.

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/date-range-start.sh', 'date-range.sh')
```

***

```yaml
type: ConsoleExercise
key: 8ca2adb6c4
xp: 35
```

`@instructions`
Fill in the placeholders in the script `date-range.sh`
with `$filename` (twice), `head`, and `tail`
so that it prints the first and last date from one or more files.

`@hint`
Remember to use `$filename` to get the current value of the loop variable.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="In `date-range.sh`, have you changed the %s line in the loop to be `%s`? Use `nano date-range.sh` to make changes."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('first', cmdpatt%'head')
msg2=msgpatt%('second', cmdpatt%'tail')
patt='cut\s+-d\s+,\s+-f\s+1\s+\$filename\s+\|\s+grep\s+-v\s+Date\s+\|\s+sort\s+\|\s+%s\s+-n\s+1'
patt1 = patt%'head'
patt2 = patt%'tail'
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/date-range.sh').multi(
        has_code(patt1, incorrect_msg=msg1),
        has_code(patt2, incorrect_msg=msg2)
    )
)

```

***

```yaml
type: ConsoleExercise
key: ec1271356d
xp: 35
```

`@instructions`
Run `date-range.sh` on all four of the seasonal data files
using `seasonal/*.csv` to match their names.

`@hint`
The wildcard expression should start with the directory name.

`@solution`
```{shell}
bash date-range.sh seasonal/*.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("bash", incorrect_msg = 'Did you call `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Did you run the `date-range.sh` file?'),
      has_code("seasonal/\*", incorrect_msg = 'Did you specify the files to process with `seasonal/*`?')
    )
  )
)

```

***

```yaml
type: ConsoleExercise
key: 0323c7d68d
xp: 30
```

`@instructions`
Run `date-range.sh` on all four of the seasonal data files using `seasonal/*.csv` to match their names,
and pipe its output to `sort` to see that your scripts can be used just like Unix's built-in commands.

`@hint`
Use the same wildcard expression you used earlier.

`@solution`
```{shell}
bash date-range.sh seasonal/*.csv | sort

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("bash", incorrect_msg = 'Did you call `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Did you run the `date-range.sh` file?'),
      has_code("seasonal/\*", incorrect_msg = 'Did you specify the files to process with `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Did you pipe from the script output to `sort`?'),
      has_code("sort", incorrect_msg = 'Did you call `sort`?')
    )
  )
)
Ex().success_msg("Magic! Notice how composable all the things we've learned are.")

```

---

## What happens when I don't provide filenames?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

A common mistake in shell scripts (and interactive commands) is to put filenames in the wrong place.
If you type:

```{shell}
tail -n 3
```

then since `tail` hasn't been given any filenames,
it waits to read input from your keyboard.
This means that if you type:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

then `tail` goes ahead and prints the last three lines of `somefile.txt`,
but `head` waits forever for keyboard input,
since it wasn't given a filename and there isn't anything ahead of it in the pipeline.

<hr>

Suppose you do accidentally type:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

What should you do next?

`@possible_answers`
- Wait 10 seconds for `head` to time out.
- Type `somefile.txt` and press Enter to give `head` some input.
- Use `Ctrl` + `C` to stop the running `head` program.

`@hint`
What does `head` do if it doesn't have a filename and nothing is upstream from it?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'No, commands will not time out.'
a2 = 'No, that will give `head` the text `somefile.txt` to process, but then it will hang up waiting for still more input.'
a3 = "Yes! You should use `Ctrl` + `C` to stop a running program. This concludes this introductory course! If you're interested to learn more command line tools, we thoroughly recommend taking our free intro to Git course!"
Ex().has_chosen(3, [a1, a2, a3])
```

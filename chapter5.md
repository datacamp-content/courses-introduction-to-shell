---
title       : Creating new tools
description : >-
  History lets you repeat things with just a few keystrokes,
  and pipes let you combine existing commands to create new ones.
  In this chapter, you will see how to go one step further
  and create new commands of your own.

--- type:ConsoleExercise lang:shell xp:100 skills:1 key:39eee3cfc0
## How can I edit a file?

Unix has a bewildering variety of text editors.
For this course,
we will use a simple one called Nano.
If you type `nano filename`,
it will open `filename` for editing
(or create it if it doesn't already exist).
You can move around with the arrow keys,
delete characters using backspace,
and do other operations with control-key combinations:

- Ctrl-K: delete a line.
- Ctrl-U: un-delete a line.
- Ctrl-O: save the file ('O' stands for 'output').
- Ctrl-X: exit the editor.

*** =instructions

Run `nano names.txt` to edit a new file in your home directory
and enter the following four lines:

```
Lovelace
Hopper
Johnson
Wilson
```

To save what you have written,
type Ctrl-O to write the file out,
then Enter to confirm the filename,
then Ctrl-X and Enter to exit the editor.

Note: if you view our solution,
it uses `cp` instead of `nano` for our automated back end to check,
because the back end can't edit files interactively.

*** =solution
```{shell}
# Run "nano names.txt" instead of the command below.
cp /solutions/names.txt .
```

*** =sct
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('names.txt', '/solutions/names.txt')
```

--- type:BulletConsoleExercise key:80c3532985
## How can I record what I just did?

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

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 144ca955ca

*** =xp1: 10

*** =instructions1

Copy the files `seasonal/spring.csv` and `seasonal/summer.csv` to your home directory.

*** =hint1

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
cp seasonal/s*.csv ~
```

*** =sct1
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('spring.csv', 'seasonal/spring.csv') \
     >> test_compare_file_to_file('summer.csv', 'seasonal/summer.csv')
```

*** =type2: ConsoleExercise
*** =key2: 09a432e4df

*** =xp2: 10

*** =instructions2

Use `grep` with the `-h` flag (to stop it from printing filenames)
and `-v Tooth` (to select lines that *don't* match the header line)
to select the data records from `spring.csv` and `summer.csv` in that order
and redirect the output to `temp.csv`.

*** =hint2

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv
```

*** =sct2
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['grep', 'hv', ['Tooth', 'spring.csv', 'summer.csv']]],
                     redirect='temp.csv',
                     msg='Use `-h` and `-v Tooth` with `spring.csv` and `summer.csv`.')
```

*** =type3: ConsoleExercise
*** =key3: c40348c1e5

*** =xp3: 10

*** =instructions3

Pipe `history` into `tail -n 3`
and redirect the output to `steps.txt`
to save the last three commands in a file.
(You need to save three instead of just two
because the `history` command itself will be in the list.)

*** =hint3

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
history | tail -n 3 > steps.txt
```

*** =sct3
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['history'],
                      ['tail', 'n:', None, {'-n' : '3'}]],
                     redirect='steps.txt',
                     msg='Remember to redirect the output to `steps.txt`.')
```

--- type:BulletConsoleExercise key:4507a0dbd8
## How can I save commands to re-run later?

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

*** =pre_exercise_code
```{python}
```

*** =type1: ConsoleExercise
*** =key1: 316ad2fec6

*** =xp1: 10

*** =instructions1

Use `nano dates.sh` to create a file called `dates.sh`
that uses this command:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

to extract the first column from all of the CSV files in `seasonal`.

*** =hint1

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
# Run "nano dates.sh" instead of the command below.
cp /solutions/dates.sh .
```

*** =sct1
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('dates.sh', '/solutions/dates.sh')
```

*** =type2: ConsoleExercise
*** =key2: 30a8fa953e

*** =xp2: 10

*** =instructions2

Use `bash` to run the file `dates.sh`.

*** =hint2

Use `bash filename` to run the file.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
bash dates.sh
```

*** =sct2
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['bash', '', 'dates.sh']],
                     msg='Use `bash` and the name of the file to run.')
```

--- type:BulletConsoleExercise key:da13667750
## How can I re-use pipes?

A file full of shell commands is called a *shell script*,
or sometimes just a "script" for short.
Scripts don't have to have names ending in `.sh`,
but this lesson will use that convention
to help you keep track of which files are scripts.

Scripts may contain pipes.
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

*** =pre_exercise_code
```{python}
import shutil
shutil.copyfile('/solutions/teeth-start.sh', 'teeth.sh')
```

*** =type1: ConsoleExercise
*** =key1: 6fae90f320

*** =xp1: 10

*** =instructions1

Use Nano to edit the shell script `teeth.sh`
and replace the `____` placeholders
so that this script prints a count of the number of times each tooth name appears in the seasonal data.

*** =hint1

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
# Run "nano teeth.sh" instead of the command below.
cp /solutions/teeth.sh .
```

*** =sct1
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('teeth.sh', '/solutions/teeth.sh')
```

*** =type2: ConsoleExercise
*** =key2: dcfccb51e2

*** =xp2: 10

*** =instructions2

Use `bash` to run `teeth.sh` and redirect its output to `teeth.out`.

*** =hint2

Use `>` to redirect the output.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out
```

*** =sct2
```{python}
from shellwhat_ext import test_compare_file_to_file, test_cmdline
Ex() >> test_cmdline([['bash', '', 'teeth.sh']],
                     redirect='teeth.out',
                     last_line=True,
                     msg='Run the script with `bash` and use `>` to redirect its output.') \
     >> test_compare_file_to_file('teeth.out', '/solutions/teeth.out')
```

*** =type3: ConsoleExercise
*** =key3: c8c9a11e3c

*** =xp3: 10

*** =instructions3

Use `cat teeth.out` to inspect your results.

*** =hint3

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
cat teeth.out
```

*** =sct3
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_cmdline([['cat', '', 'teeth.out']],
                     msg='Run the indicated command.')
```

--- type:BulletConsoleExercise key:c2623b9c14
## How can I pass filenames to scripts?

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
bash unique-lines.sh seasonal/*.csv
```

it processes all four data files,
and so on.

*** =pre_exercise_code
```{python}
import shutil
shutil.copyfile('/solutions/count-records-start.sh', 'count-records.sh')
```

*** =type1: ConsoleExercise
*** =key1: 7a893623af

*** =xp1: 10

*** =instructions1

Open the script `count-records.sh` in Nano and fill in the `____` placeholders
so that it counts the number of lines in one or more files,
excluding the first line of each.

*** =hint1

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
# Run "nano count-records.sh" instead of the command below.
cp /solutions/count-records.sh .
```

*** =sct1
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('count-records.sh', '/solutions/count-records.sh')
```

*** =type2: ConsoleExercise
*** =key2: d0da324516

*** =xp2: 10

*** =instructions2

Run `count-records.sh` on all of the seasonal data files
and redirect the output to `num-records.out`.

*** =hint2

Use `>` to redirect the output.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
cp /solutions/count-records.sh .
bash count-records.sh seasonal/*.csv > num-records.out
```

*** =sct2
```{python}
from shellwhat_ext import test_compare_file_to_file, test_cmdline
Ex() >> test_student_typed(r'\s*bash\s+count-records\.sh\s+.+>\s*num-records.out\s*',
                           fixed=False, 
                           msg='Run the script with `bash` and some filenames and use `>` to redirect its output.') \
     >> test_compare_file_to_file('num-records.out', '/solutions/num-records.out')
```

--- type:PureMultipleChoiceExercise lang:bash xp:50 key:4092cb4cda
## How can I process a single argument?

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

The script `get-lines.sh` is supposed to take
a start line,
and an end line as arguments,
and select that range of lines from that file.
For example:

```
bash get-lines.sh seasonal/summer.csv 5 8
```

should select lines 5-8 from `seasonal/summer.csv`.
Which of the following commands should be put in `get-lines.sh` to do that?

*** =possible_answers
- `head -n $1 $2 | tail -n $3`
- `head -n $2 $1 | tail -n $3`
- `head -n $3 $2 | tail -n $1`
- [`head -n $3 $1 | tail -n $2`]

*** =hint

*** =feedbacks
- No: that will try to use the filename as the number of lines to select with `head`.
- No: that will try to use the end line number as the filename.
- No: that one uses the starting line number as the filename.
- Correct!

--- type:TabConsoleExercise key:846bc70e9d
## How can one shell script do many things?

Our shells scripts so far have had a single command or pipe,
but a script can contain many lines of commands.
For example,
you can create one that tells you how many records are in the shortest and longest of your data files,
i.e.,
the range of your datasets' lengths.

*** =pre_exercise_code
```{python}
import shutil
shutil.copyfile('/solutions/range-start-1.sh', 'range.sh')
```

*** =type1: ConsoleExercise
*** =key1: a1e55487fb

*** =xp1: 10

*** =instructions1

Use Nano to edit the script `range.sh`
and replace the `____` placeholders so that it lists
the names and number of lines in all of the files given on the command line
*without* showing the total number of lines in all files.
(Do not try to subtract the column header lines from the files.)

*** =hint1

Use `wc -l $@` to count lines in all the files given on the command line.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
# Run "nano range.sh" instead of the command below.
cp /solutions/range-1.sh range.sh
```

*** =sct1
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('range.sh', '/solutions/range-1.sh')
```

*** =type2: ConsoleExercise
*** =key2: e8ece27fe7

*** =xp2: 20

*** =instructions2

Extend the pipeline in `range.sh`
so that it uses `sort -n` and `head -n 1` in that order
to display the name and line count of the shortest file given to it.

*** =hint3

Use `sort -n` to sort by the number of lines
and then `head -n 1` to select the shortest line.

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
cp /solutions/range-2.sh range.sh
```

*** =sct2
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('range.sh', '/solutions/range-2.sh')
```

*** =type3: ConsoleExercise
*** =key3: a3b36a746e

*** =xp3: 30

*** =instructions3

Add a second line to `range.sh` to print the name and record count of
the *longest* file in the directory *as well as* the shortest.
(Use `sort -n -r` and `head` rather than `sort -n` and `tail`.)

*** =hint3

Copy the first line and modify the sorting order.

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
cp /solutions/range-3.sh range.sh
```

*** =sct3
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('range.sh', '/solutions/range-3.sh')
```

*** =type4: ConsoleExercise
*** =key4: cba93a77c3

*** =xp4: 30

*** =instructions4

Run the script on the files in the `seasonal` directory
using a wildcard expression to match all of the files
and redirect the output to a file called `range.out` in your home directory.

*** =hint4

*** =sample_code4
```{shell}
```

*** =solution4
```{shell}
cp /solutions/range-3.sh range.sh
bash range.sh seasonal/*.csv > range.out
```

*** =sct4
```{python}
from shellwhat_ext import test_cmdline
Ex() >> test_student_typed(r'\s*bash\s+range\.sh\s+.+>\s*range.out\s*',
                           fixed=False, 
                           msg='Run the script with `bash` and some filenames and use `>` to redirect its output.')
```

--- type:BulletConsoleExercise key:6be8ca6009
## How can I write loops in a shell script?

Shell scripts can contain loops as well as pipes and multiple command lines.
You can write these loops using semi-colons,
or to make them more readable,
you can split them across multiple lines like this:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

You don't have to indent the commands inside the loop,
but it make scripts more readable.

The first line of this script is a **comment**
to tell readers what the script does.
Comments start with the `#` character and run to the end of the line.
Your future self will thank you for adding brief explanations like the one shown here
to every script you write.

*** =pre_exercise_code
```{python}
import shutil
shutil.copyfile('/solutions/date-range-start.sh', 'date-range.sh')
```

*** =type1: ConsoleExercise
*** =key1: 8ca2adb6c4

*** =xp1: 10

*** =instructions1

Modify the script `date-range.sh`
so that it prints the first and last date from one or more files.

*** =hint1

Remember to use `$filename` to get the current value of the loop variable.

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
cp /solutions/date-range.sh date-range.sh
```

*** =sct1
```{python}
from shellwhat_ext import test_compare_file_to_file
Ex() >> test_compare_file_to_file('date-range.sh', '/solutions/date-range.sh')
```

*** =type2: ConsoleExercise
*** =key2: ec1271356d

*** =xp2: 10

*** =instructions2

Run `date-range.sh` on all four of the seasonal data files,
using a wildcard expression for the files.

*** =hint2

*** =sample_code2
```{shell}
```

*** =solution2
```{shell}
bash date-range.sh seasonal/*.csv
```

*** =sct2
```{python}
Ex() >> test_student_typed(r'.*\s*bash\s+date-range\.sh\s+seasonal/\*(\.csv)?\s*',
                           fixed=False,
                           msg='Use `bash date-range.sh` on `seasonal/*.csv`.')
```

*** =type3: ConsoleExercise
*** =key3: 0323c7d68d

*** =xp3: 10

*** =instructions3

Run `date-range.sh` on all four of the seasonal data files,
using a wildcard expression for the files,
and pipe its output to `sort`
to see how your scripts can be used just like Unix's built-in commands.

*** =hint3

*** =sample_code3
```{shell}
```

*** =solution3
```{shell}
bash date-range.sh seasonal/*.csv | sort
```

*** =sct3
```{python}
Ex() >> test_student_typed(r'.*\s*bash\s+date-range\.sh\s+seasonal/\*(\.csv)?\s*|\s*sort\s*',
                           fixed=False,
                           msg='Pipe `bash date-range.sh` with `seasonal/*.csv` to `sort`.')
```

--- type:BulletConsoleExercise key:c0b03ca7d1
## How can I stop a running program?

The commands and scripts that you have run so far have all executed quickly,
but some tasks will take minutes, hours, or even days to complete.
If you decide that you don't want a program to keep running,
you can type Ctrl-C to end it.
This is often written `^C` in Unix documentation;
note that the 'c' can be lower-case.

*** =pre_exercise_code
```{python}
import shutil
shutil.copyfile('/solutions/current-time.sh', 'current-time.sh')
```

*** =type1: ConsoleExercise
*** =key1: 7cdb55125f

*** =xp1: 10

*** =instructions1

The script `current-time.sh` prints the current time at one-second intervals forever.
Run it with `bash current-time.sh`
and then use Ctrl-C to stop it.

*** =hint1

*** =sample_code1
```{shell}
```

*** =solution1
```{shell}
# Use echo to prevent execution of never-ending script.
echo bash current-time.sh
```

*** =sct1
```{python}
Ex() >> test_student_typed(r'\s*bash\s+current-time\.sh\s*',
                           fixed=False,
                           msg="Use the control key and 'c' at the same time to stop the script.")
```

--- type:MultipleChoiceExercise lang:shell xp:50 skills:1 key:8a162c4d54
## What happens when I don't provide filenames?

A common mistake in shell scripts (and interactive commands) is to put filenames in the wrong place.
If you type:

```{shell}
tail -n 3 somefile.txt
```

then `tail` prints the last three lines of the file.
If, on the other hand, you type:

```{shell}
head -n 5 somefile.txt | tail -n 3
```

then since `tail` hasn't been given the names of any files to process,
it waits for some other program (in this case, `head`) to send it data.

<hr>

What happens if you run the command:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

*** =instructions
- It prints lines 3-5 of `somefile.txt` and halts.
- It prints lines 3-5 of `somefile.txt` and waits for more input.
- It prints the last 3 lines of `somefile.txt` and halts.
- It prints the last 3 lines of `somefile.txt` and waits for more input.

*** =hint

*** =pre_exercise_code
```{shell}

```

*** =sct
```{python}
a1 = 'No: `tail` prints the last 3 lines of the file, but since `head` has not been given any filenames, it waits for input.'
a2 = 'No: `tail` prints the last 3 lines of the file, but since `head` has not been given any filenames, it waits for input.'
a3 = 'No: `tail` does print the last 3 lines of the file, but since `head` has not been given any filenames, it waits for input.'
a4 = 'Correct: `tail` prints the last 3 lines of the file, but `head` then waits forever for input.'
Ex() >> test_mc(3, [a1, a2, a3, a4])
```

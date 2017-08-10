---
---
# Introduction to the Unix Shell for Data Science

*This document is a starting point for discussion of
what a new DataCamp course outline and development procedure might look like.
Feedback would be greatly appreciated.*

*Terminology:*

- *CL: curriculum lead*
- *CD: course developer*

## Step 0: Learner Profiles

*Terms like "beginner" and "expert" mean different things to different people,
so these profiles make the course's intended audience concrete.
Profiles typically have [five parts][learner-profiles]:
the learner's general background,
what they already know,
what they think they want to do,
any special needs they might have,
and how the course will help them.
DataCamp will have a handful of stock profiles that define the first four points;
particular course outlines will reference these and add the fifth.*

*Output: brief descriptions of intended audience.*

*Owner: CL (shared).*

(Images courtesy of [RoboHash][robohash].)

**Jasmine**

![Jasmine](img/jasmine.png)

1. Jasmine, 28, did a commerce degree at the University of North Carolina,
   and then an MBA at Georgia State.
   In the three years since completing it,
   she has been doing health insurance policy research for an underwriter.

2. Jasmine did a stats class as an undergrad
   and another in grad school (which covered almost exactly the same material).
   She uses Excel every day,
   and is comfortable doing simple operations in SAS.

3. Jasmine would like to start teaching data analysis at her alma mater.
   Her boss has given her two afternoons a week of work release to do this,
   and she wants to level up her statistical and computing skills
   as quickly as she can.

4. Jasmine is partially deaf,
   and strongly prefers written and visual material to spoken material.

5. This course will give Jasmine a basic understanding of the Unix shell
   so that she can help her students solve the problems they encounter
   using the university's systems in their statistics courses.

**Thanh**

![Thanh](img/thanh.png)

1. Thanh, 35, has an undergraduate degree in psychology with a minor in statistics.
   He now works for the Quebec Ministry of Education,
   where he helps administer programs for children with learning disabilities.

2. Thanh uses classical statistical methods every day.
   He taught himself the basics of R,
   and then used DataCamp's courses to learn more.

3. Thanh is about to join a consortium that is analyzing different approaches to special education.
   As part of this,
   he wants to start building tools that other consortium members can use.

4. Thanh is fluent in Vietnamese and French,
   but only has high school English
   (supplemented by a solid technical vocabulary).

5. This course will show Thanh how to build command-line tools
   and use remote computing resources (such as clusters),
   and is a step toward building [robust software][robust-software].

## Step 1: Concept Map

*This is a brainstorming stage to determine what we want learners to know at the end of the course.
Its concrete output is usually a [concept map][concept-map] showing the main ideas and their relationships,
but in some cases it may be more productive to represent the learning as a map,
a [decision tree][abela-chart],
or some other form.*

*Output: graphical representation of learner's final mental model.*

*Owner: CL (per course).*

![Basic Unix Concepts](img/unix.png)

*Notes:*

1. *It's tempting to write learning objectives at this point.
   Resist!
   Step 4 will almost certainly result in material being cut.*

2. *New instructors may struggle with this step,
   so we will walk them through it for their first course
   as part of their onboarding process.*

## Step 2: Summative Assessment

*The best way to make the goal of a course concrete is
to present examples of what learners will be able to do at its end.
This is directly analogous to [test-driven development][tdd]:
rather than working forward from a (probably ambiguous) set of learning objectives,
designers work backward from concrete examples of where their learners are going.*

*Output: 2-3 exercises that use all of the skills the learner is to develop.*

*Owner: CL.*

### Summative Exercise 1: Shell Scripts

You have several dozen data files, each of which is formatted like this:

```
2013-11-05,deer,5
2013-11-05,rabbit,22
2013-11-05,raccoon,7
2013-11-06,rabbit,19
2013-11-06,deer,2
2013-11-06,fox,1
2013-11-07,rabbit,18
2013-11-07,bear,1
```

Write a shell script called `unique.sh`
that takes any number of filenames as command-line parameters
and prints the names of the species found in each file
in alphabetical order.
Each file is processed separately.

> **Solution**
>
> ```
> #!/usr/bin/env bash
> 
> # Find unique species in CSV files where species is the second data
> # field.  This script accepts any number of filenames as arguments
> # and processes each separately.
> 
> for file in $@ 
> do
>   echo $file
>   cut -d , -f 2 $file | sort | uniq
> done
> ```

### Summative Exercise 2: Wildcards

The directory `./data` contains four CSV files and three shell scripts:

```
$ ls *.csv
autumn.csv	spring.csv	summer.csv	winter.csv

$ ls *.sh
first.sh	second.sh	third.sh
```

If the shell scripts contain the commands shown below,
what will be the output of:

1. `./first.sh *.*`
2. `./second.sh *.*`
3. `./third.sh *.*`

```
# first.sh
echo *.*
```

```
# second.sh
for filename in $1 $2 $3
do
  cat $filename
done
```

```
# third.sh
echo $@.csv
```

> **Solution**
>
> `first.sh` will display:
>
> ```
> autumn.csv first.sh second.sh spring.csv summer.csv third.sh winter.csv
> ```
>
> because `*.*` inside the script matches all two-part filenames,
> and the command-line arguments are ignored.
>
> `second.sh` will display the contents of `autumn.csv`, `spring.csv`, and `summer.csv`.
>
> `third.sh` will display:
>
> ```
> autumn.csv spring.csv summer.csv winter.csv.csv
> ```
>
> Note the double `.csv` at the end:
> the expression `$@` expands to the names of the command-line arguments,
> and then the explicit `.csv` in the script is tacked on.

*Notes:*

1. *These summative assessments will normally be included in the course
   as its final capstone exercises.*

2. *If CLs and CDs find this approach productive,
   we may eventually stitch these concept maps together
   to create something like Kamran Ahmed's [developer roadmap][developer-roadmap].

## Step 3: Formative Assessments

*Formative assessments are exercises done while learning is taking place,
rather than at the end to determine whether it has.
Formative assessments serve two purposes:
to tell the learner and the instructor if learners are making progress
(or conversely, what they still need to work on),
and to give learners a chance to exercise the skills and knowledge
they will need in the summative assessment.*

*In order to create formative assessments,
the CL works backward from the summative assessment written in Step 2.*

*Output: 2-3 formative assessments for each chapter of the course.
As with the summative assessments,
their purpose is to communicate concrete goals to the CD.*

*Owner: CL.*

### Formative Exercise 1: The Shell vs. GUIs

What is the relationship between the shell
and graphical file explorer that most people use?

1. The file explorer lets you view and edit files, while the shell lets you run programs.
2. The file explorer is built on top of the shell.
3. The shell is part of the operating system, while the file explorer is separate.
4. They are both interfaces for issuing commands to the operating system.

### Formative Exercise 2: Manipulating Files and Directories

What is the output of the final `ls` command in the sequence shown below?

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

### Formative Exercise 3: Selecting Data by Value

Write a command that selects *only* the date and name fields (columns 2 and 3)
from each record in `mortality.txt`.

### Formative Exercise 4: Selecting Data by Field

Write a command that selects *only* the data from the years 2000, 2005, and 2010
from `mortality.txt`.

### Formative Exercise 5: Creating Pipes

Using pipes to combine two or more basic commands,
write a single-line command that displays unique dates in `mortality.txt`.

### Formative Exercise 6: Tracing Pipes and Redirection

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

### Formative Exercise 7: Wildcards

Suppose you want to delete your processed data files,
and only keep your raw files and processing script to save storage.
The raw files end in `.dat` and the processed files end in `.txt`.
Which of the following would remove all the processed data files,
and *only* the processed data files?

1. `rm ?.txt`
2. `rm *.txt`
3. `rm * .txt`
4. `rm *.*`

### Formative Exercise 8: Shell Scripts

Fill in the blanks in the shell script `dates.sh`
to select unique dates from a single file
whose name is given as the script's sole command-line argument.

## Step 4: Course Outline

*In this stage,
formative assessments are put in an order that respects their dependencies.
This is the point at which the CL discovers all the dependencies she forgot to list earlier.
The CL then creates a point-form outline of chapters and lessons:
each chapter has a title,
and each lesson has a handful of keywords describing what it will cover.*

*Output: an instructional sequence.*

*Owner: CL.*

The formative assessments in Step 3 are already in order.
The chapter and lesson outline is:

1. Manipulating Files and Directories
   1. What a shell is; how it compares to a graphical interface.
   2. `whoami`; `pwd`; files vs. directories
   3. `ls`; `cp`; `mv`; `rm`
   4. `cat`; `nano`
   5. `mkdir`; `rmdir`
2. Manipulating Data
   1. `head`; `tail`; command-line flags
   2. `man`
   3. `cut`
   4. `history`; `!number` and `!command`
   4. `grep`; single-quoting
   5. `uniq`; `sort`
3. Combining Tools
   1. Redirection with `>`
   2. Piping with `|`
   3. Using the `*` and `?` wildcards
4. Automating Repeated Tasks
   1. Storing commands in files; running files with `bash script.sh`
   2. Permissions; changing permissions; using `!#`
   3. Using positional arguments `$1`, `$2`, etc.
   4. Using `$@`

## Step 5: Course Description

*The CL is now ready to write the course's learning objectives,
to write a short blurb for the course,
and to specify the course's prerequisites.
Doing this earlier often wastes effort,
since material may be added or cut in Step 4.*

*Output: learning objectives, course overview, and prerequisites.*

*Owner: CL.*

**Learning Objectives**

- Explain the similarities and differences between the Unix shell and graphical user interfaces.
- Demonstrate fluency with core Unix commands.
- Explain what files and directories are.
- Match files and directories to relative and absolute paths.
- Demonstrate fluency with basic data manipulation commands.
- Find and interpret help.
- Predict the paths matched by wildcards and specify wildcards to match sets of paths.
- Combine programs using pipes to process large data sets.
- Write shell scripts to re-run command pipes with a varying number of command-line arguments.

**Course Description**

The Unix command line has survived and thrived for almost fifty years
because it lets people to do complex things with just a few keystrokes.
Sometimes called "the duct tape of programming",
it helps users combine existing programs in new ways,
automate repetitive tasks,
and run programs on clusters and clouds
that may be halfway around the world.
This course will introduce its key elements
and show you how to use them efficiently.

**Prerequisites**

None.

## Conclusion

Thirty years ago,
[Parnas and Clements][parnas-clements] wrote:

> Many have sought a software design process that allows a program to be derived systematically
> from a precise statement of requirements.
> It is proposed that,
> although designing a real product in that way will not be successful,
> it is possible to produce documentation that makes it appear that the software was designed by such a process.

The same is true of courses:
this process is described as a one-way flow,
but in practice,
the CL will loop back repeatedly
as each stage informs her of something she overlooked.
Similarly,
the CD may add, move, or remove some specific lesson items as she fills in content
(though she must review any significant changes with the CL).
With practice,
those loops become tighter and more productive,
and multi-author maintenance of lessons will become less expensive.

[abela-chart]: http://extremepresentation.typepad.com/.shared/image.html?/photos/uncategorized/choosing_a_good_chart.jpg
[concept-map]: http://third-bit.com/teaching/memory.html#concept-maps
[developer-roadmap]: https://github.com/kamranahmedse/developer-roadmap
[learner-profiles]: http://third-bit.com/teaching/lessons.html#learner-profiles
[parnas-clements]: http://ieeexplore.ieee.org/document/6312940/
[robohash]: http://robohash.org
[robust-software]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005412
[tdd]: https://en.wikipedia.org/wiki/Test-driven_development

---
title: การจัดการข้อมูล
description: >-
  คำสั่งในบทที่แล้วช่วยให้ย้ายสิ่งต่าง ๆ ในระบบไฟล์ได้
  บทนี้จะแสดงวิธีทำงานกับข้อมูลภายในไฟล์เหล่านั้น
  เครื่องมือที่ใช้ค่อนข้างเรียบง่าย
  แต่เป็นรากฐานที่แข็งแกร่งสำหรับการใช้งานต่อไป
lessons:
  - nb_of_exercises: 12
    title: วิธีดูเนื้อหาของไฟล์
---

## จะดูเนื้อหาในไฟล์ได้อย่างไร?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

ก่อนจะเปลี่ยนชื่อหรือลบไฟล์
อาจต้องการดูเนื้อหาในไฟล์นั้นก่อน
วิธีที่ง่ายที่สุดคือใช้คำสั่ง `cat`
ซึ่งจะแสดงเนื้อหาของไฟล์ออกทางหน้าจอ
(ชื่อย่อมาจาก "concatenate" ที่แปลว่า "เชื่อมต่อสิ่งต่าง ๆ เข้าด้วยกัน"
เพราะคำสั่งนี้จะแสดงเนื้อหาของทุกไฟล์ที่ระบุชื่อไว้ ทีละไฟล์ต่อเนื่องกัน)

```{shell}
cat agarwal.txt
```
```
name: Agarwal, Jasmine
position: RCT2
start: 2017-04-01
benefits: full
```

`@instructions`
แสดงเนื้อหาของ `course.txt` ออกทางหน้าจอ

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
cat course.txt
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="คำสั่งของท่านไม่ได้สร้างผลลัพธ์ที่ถูกต้อง ท่านได้ใช้ `cat` ตามด้วยชื่อไฟล์ `course.txt` หรือไม่?")
)
Ex().success_msg("ดีมาก! มาดูวิธีอื่นในการดูเนื้อหาของไฟล์กัน")
```

---

## จะดูเนื้อหาไฟล์ทีละส่วนได้อย่างไร?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

สามารถใช้ `cat` เพื่อแสดงไฟล์ขนาดใหญ่แล้วเลื่อนดูผลลัพธ์ได้ แต่โดยทั่วไปการ **เลื่อนหน้า** ผลลัพธ์จะสะดวกกว่า
คำสั่งดั้งเดิมที่ใช้ทำสิ่งนี้คือ `more` แต่ปัจจุบันถูกแทนที่ด้วยคำสั่งที่มีความสามารถมากกว่าอย่าง `less`
(การตั้งชื่อแบบนี้ถือเป็นอารมณ์ขันในแบบฉบับของโลก Unix)
เมื่อใช้ `less` กับไฟล์ ระบบจะแสดงผลครั้งละหนึ่งหน้า
กด spacebar เพื่อเลื่อนลง หรือพิมพ์ `q` เพื่อออก

หากระบุชื่อไฟล์หลายไฟล์ให้กับ `less`
สามารถพิมพ์ `:n` (เครื่องหมายโคลอนตามด้วยตัวอักษร 'n' พิมพ์เล็ก) เพื่อไปยังไฟล์ถัดไป
`:p` เพื่อย้อนกลับไปไฟล์ก่อนหน้า
หรือ `:q` เพื่อออกจากโปรแกรม

หมายเหตุ: หากดูเฉลยของแบบฝึกหัดที่ใช้ `less` จะเห็นคำสั่งเพิ่มเติมต่อท้ายที่ทำหน้าที่ปิดการเลื่อนหน้า *ออก*
เพื่อให้ระบบทดสอบคำตอบได้อย่างมีประสิทธิภาพ

`@instructions`
ใช้ `less seasonal/spring.csv seasonal/summer.csv` เพื่อดูไฟล์ทั้งสองตามลำดับ
กด spacebar เพื่อเลื่อนหน้าลง `:n` เพื่อไปยังไฟล์ที่สอง และ `:q` เพื่อออก

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
# You can leave out the '| cat' part here:
less seasonal/spring.csv seasonal/summer.csv | cat
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_or(
        has_code(r'\s*less\s+seasonal/spring\.csv\s+seasonal/summer\.csv\s*',
                 incorrect_msg='ใช้ `less` และชื่อไฟล์ โปรดจำไว้ว่า `:n` จะนำคุณไปยังไฟล์ถัดไป'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## ดูข้อมูลส่วนต้นของไฟล์ได้อย่างไร?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

สิ่งแรกที่นักวิทยาศาสตร์ข้อมูลมักทำเมื่อได้รับชุดข้อมูลใหม่มาวิเคราะห์ คือการดูว่าชุดข้อมูลนั้นมีฟิลด์อะไรบ้าง และแต่ละฟิลด์มีค่าอะไร
หากชุดข้อมูลถูกส่งออกมาจากฐานข้อมูลหรือสเปรดชีต มักจะถูกจัดเก็บในรูปแบบ **ค่าที่คั่นด้วยจุลภาค** (CSV)
วิธีที่รวดเร็วในการดูเนื้อหาของไฟล์คือการดูแค่ไม่กี่แถวแรก

ใน shell สามารถทำได้ด้วยคำสั่ง `head`
ตามชื่อของมัน คำสั่งนี้จะแสดงบรรทัดแรกของไฟล์
(โดย "ไม่กี่บรรทัด" หมายถึง 10 บรรทัด)
ดังนั้นคำสั่ง:

```{shell}
head seasonal/summer.csv
```

จะแสดงผลลัพธ์:

```
Date,Tooth
2017-01-11,canine
2017-01-18,wisdom
2017-01-21,bicuspid
2017-02-02,molar
2017-02-27,wisdom
2017-02-27,wisdom
2017-03-07,bicuspid
2017-03-15,wisdom
2017-03-20,canine
```

<hr>

`head` จะทำอะไรหากไฟล์มีไม่ถึง 10 บรรทัด?
(ลองใช้คำสั่งนี้กับไฟล์ `people/agarwal.txt` เพื่อหาคำตอบ)

`@possible_answers`
- แสดงข้อความแสดงข้อผิดพลาด เพราะไฟล์มีความยาวไม่เพียงพอ
- แสดงบรรทัดทั้งหมดเท่าที่มีในไฟล์
- เติมบรรทัดว่างให้ครบ 10 บรรทัด

`@hint`
คำสั่งนี้มีประโยชน์สูงสุดในแง่ใด?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["ไม่ถูกต้อง: นั่นไม่ใช่สิ่งที่มีประโยชน์ที่สุดที่สามารถทำได้",
                    "ถูกต้อง!",
                    "ไม่ถูกต้อง: เป็นไปไม่ได้ที่จะแยกความแตกต่างจากไฟล์ที่ลงท้ายด้วยบรรทัดว่างจำนวนมาก"])
```

---

## พิมพ์น้อยลงได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

หนึ่งในเครื่องมืออันทรงพลังของ shell คือ **tab completion**
เมื่อเริ่มพิมพ์ชื่อไฟล์แล้วกดปุ่ม tab shell จะพยายามเติมพาธให้โดยอัตโนมัติ
ตัวอย่างเช่น ถ้าพิมพ์ `sea` แล้วกด tab shell จะเติมชื่อไดเรกทอรีเป็น `seasonal/` (พร้อม slash ต่อท้าย)
จากนั้นถ้าพิมพ์ `a` แล้วกด tab อีกครั้ง shell จะเติมพาธให้สมบูรณ์เป็น `seasonal/autumn.csv`

หากพาธยังไม่ชัดเจนพอ เช่น `seasonal/s` การกด tab ครั้งที่สองจะแสดงรายการตัวเลือกที่เป็นไปได้
พิมพ์ตัวอักษรเพิ่มอีกหนึ่งหรือสองตัวเพื่อให้พาธเฉพาะเจาะจงขึ้น แล้วกด tab เพื่อเติมชื่อที่เหลือให้ครบ

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 4e30296c27
xp: 50
```

`@instructions`
รัน `head seasonal/autumn.csv` โดยไม่ต้องพิมพ์ชื่อไฟล์แบบเต็ม

`@hint`
พิมพ์พาธให้มากพอที่จะระบุได้ แล้วกด tab จากนั้นทำซ้ำตามต้องการ

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="ตัวตรวจสอบไม่พบผลลัพธ์ที่ถูกต้องในคำสั่งของคุณ คุณแน่ใจหรือไม่ว่าได้เรียกใช้ `head` กับ `seasonal/autumn.csv`?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
รัน `head seasonal/spring.csv` โดยไม่ต้องพิมพ์ชื่อไฟล์แบบเต็ม

`@hint`
พิมพ์พาธให้มากพอที่จะระบุได้ แล้วกด tab จากนั้นทำซ้ำตามต้องการ

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="ตัวตรวจสอบไม่พบผลลัพธ์ที่ถูกต้องในคำสั่งของท่าน ท่านแน่ใจหรือไม่ว่าได้เรียกใช้ `head` กับ `seasonal/spring.csv`?")
)
Ex().success_msg("ทำได้ดีมาก! เมื่อท่านคุ้นเคยกับการใช้การเติมคำด้วย Tab แล้ว จะช่วยประหยัดเวลาของท่านได้มาก!")
```

---

## จะควบคุมการทำงานของคำสั่งได้อย่างไร?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

บางครั้งเราอาจไม่ต้องการดูแค่ 10 บรรทัดแรกของไฟล์เสมอไป
ดังนั้น shell จึงให้เปลี่ยนพฤติกรรมของ `head` ได้
โดยใช้ **command-line flag** (หรือเรียกสั้นๆ ว่า "flag")
หากรันคำสั่ง:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` จะแสดงเพียง 3 บรรทัดแรกของไฟล์
หากรัน `head -n 100`
ก็จะแสดง 100 บรรทัดแรก (หากไฟล์มีจำนวนบรรทัดมากพอ)
และเป็นเช่นนี้ต่อไปเรื่อยๆ

ชื่อของ flag มักบ่งบอกถึงความหมายของมัน
(เช่น `-n` ย่อมาจาก "**n**umber of lines" หรือจำนวนบรรทัด)
แม้ว่า flag ไม่จำเป็นต้องเป็น `-` ตามด้วยตัวอักษรเพียงตัวเดียวเสมอไป
แต่นี่เป็นรูปแบบที่นิยมใช้กันอย่างแพร่หลาย

หมายเหตุ: เป็น style ที่ดีในการวาง flag ทั้งหมด *ก่อน* ชื่อไฟล์
ดังนั้นในคอร์สนี้ จะรับเฉพาะคำตอบที่เขียนในรูปแบบดังกล่าวเท่านั้น

`@instructions`
แสดง 5 บรรทัดแรกของ `winter.csv` ในไดเรกทอรี `seasonal`

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
head -n 5 seasonal/winter.csv
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_correct(
        has_expr_output(incorrect_msg="คุณแน่ใจหรือไม่ว่าคุณกำลังเรียกใช้ `head` กับไฟล์ `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="คุณแน่ใจหรือไม่ว่าคุณใช้แฟล็ก `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "คุณแน่ใจหรือไม่ว่าคุณใช้แฟล็ก `-n 5`?")
)
Ex().success_msg("ดีมาก! ด้วยเทคนิคนี้ คุณสามารถป้องกันไม่ให้เชลล์ของคุณทำงานผิดพลาด หากคุณต้องการดูไฟล์ข้อความขนาดใหญ่ได้")
```

---

## จะดูรายการไฟล์ทั้งหมดภายใต้ไดเรกทอรีได้อย่างไร?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

หากต้องการดูไฟล์และโฟลเดอร์ทั้งหมดภายในไดเรกทอรี
ไม่ว่าจะซ้อนกันลึกแค่ไหนก็ตาม
ให้ใช้ `ls` พร้อมแฟล็ก `-R`
(ย่อมาจาก "recursive" หรือ "การทำซ้ำแบบเวียนเกิด")
หากรัน `ls -R` ในโฮมไดเรกทอรี
จะเห็นผลลัพธ์ประมาณนี้:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

ผลลัพธ์นี้แสดงไฟล์และไดเรกทอรีทั้งหมดในระดับปัจจุบัน
ตามด้วยเนื้อหาในแต่ละไดเรกทอรีย่อย
และดำเนินต่อไปเรื่อย ๆ จนครบทุกระดับ

`@instructions`
เพื่อให้แยกแยะประเภทของรายการได้ง่ายขึ้น
`ls` มีแฟล็กอีกตัวคือ `-F` ซึ่งจะพิมพ์ `/` ต่อท้ายชื่อไดเรกทอรีทุกรายการ
และ `*` ต่อท้ายชื่อโปรแกรมที่รันได้
ให้รัน `ls` โดยใส่แฟล็กทั้งสองตัวคือ `-R` และ `-F` พร้อมกับพาธแบบสมบูรณ์ของโฮมไดเรกทอรี
เพื่อดูรายการทั้งหมดที่อยู่ภายใน
(ลำดับของแฟล็กไม่มีผลต่อการทำงาน แต่ต้องวางชื่อไดเรกทอรีไว้ท้ายสุดเสมอ)

`@hint`
ระบุโฮมไดเรกทอรีได้โดยใช้ `~` หรือ `.` หรือพาธแบบสมบูรณ์

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
ls -R -F /home/repl
```

`@sct`
```{python}
Ex().check_or(
  has_expr_output(incorrect_msg='ใช้ `ls -R -F` หรือ `ls -F -R` และเส้นทาง `/home/repl`'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='ใช้ `ls -R -F` หรือ `ls -F -R` และเส้นทาง `/home/repl`')
)
Ex().success_msg("นั่นเป็นภาพรวมที่ดีทีเดียว ใช่ไหม?")
```

---

## จะขอความช่วยเหลือสำหรับคำสั่งได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

ในการค้นหาว่าคำสั่งต่าง ๆ ทำงานอย่างไร
ในอดีตผู้คนมักใช้คำสั่ง `man`
(ย่อมาจากคำว่า "manual" หรือคู่มือ)
ตัวอย่างเช่น
คำสั่ง `man head` จะแสดงข้อมูลดังนี้:

```
HEAD(1)               BSD General Commands Manual              HEAD(1)

NAME
     head -- display first lines of a file

SYNOPSIS
     head [-n count | -c bytes] [file ...]

DESCRIPTION
     This filter displays the first count lines or bytes of each of
     the specified files, or of the standard input if no files are
     specified.  If count is omitted it defaults to 10.

     If more than a single file is specified, each file is preceded by
     a header consisting of the string ``==> XXX <=='' where ``XXX''
     is the name of the file.

SEE ALSO
     tail(1)
```

`man` จะเรียกใช้ `less` โดยอัตโนมัติ
ดังนั้นอาจต้องกดแป้นเว้นวรรคเพื่อเลื่อนดูข้อมูล
และกด `:q` เพื่อออก

คำอธิบายสั้น ๆ ใต้หัวข้อ `NAME` จะบอกคร่าว ๆ ว่าคำสั่งนั้นทำอะไร
ส่วนสรุปใต้หัวข้อ `SYNOPSIS` จะแสดงรายการ flag ทั้งหมดที่คำสั่งรองรับ
รายการที่เป็นตัวเลือก (ไม่บังคับ) จะอยู่ในวงเล็บเหลี่ยม `[...]`
ตัวเลือกแบบเลือกอย่างใดอย่างหนึ่งจะคั่นด้วย `|`
และรายการที่สามารถระบุซ้ำได้จะแสดงด้วย `...`
ดังนั้น หน้าคู่มือของ `head` กำลังบอกว่าสามารถระบุจำนวนบรรทัดด้วย `-n` *หรือ* จำนวนไบต์ด้วย `-c`
และสามารถระบุชื่อไฟล์ได้หลายชื่อ

ข้อจำกัดของคู่มือ Unix คือต้องรู้ก่อนว่ากำลังมองหาอะไร
หากยังไม่แน่ใจ
ลองค้นหาได้ที่ [Stack Overflow](https://stackoverflow.com/)
ตั้งคำถามในช่อง Slack ของ DataCamp
หรือดูในส่วน `SEE ALSO` ของคำสั่งที่รู้จักอยู่แล้ว

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 52d629048a
xp: 50
```

`@instructions`
อ่านหน้าคู่มือของคำสั่ง `tail` เพื่อดูว่าการใส่เครื่องหมาย `+` นำหน้าตัวเลขที่ใช้กับ flag `-n` นั้นมีผลอย่างไร
(กดแป้นเว้นวรรคเพื่อเลื่อนลง และ/หรือพิมพ์ `q` เพื่อออก)

`@hint`
จำไว้ว่า `man` ย่อมาจาก "manual" หรือคู่มือ

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='ใช้ `man` และชื่อคำสั่ง')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
ใช้คำสั่ง `tail` พร้อม flag `-n +7` เพื่อแสดงทุกบรรทัด *ยกเว้น* หกบรรทัดแรกของไฟล์ `seasonal/spring.csv`

`@hint`
ใช้เครื่องหมายบวก '+' นำหน้าจำนวนบรรทัดที่ต้องการแสดง

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="คุณกำลังเรียกใช้ `tail` บน `seasonal/spring.csv` หรือไม่?"),
    has_expr_output(strict=True, incorrect_msg="คุณแน่ใจหรือไม่ว่าได้ใช้แฟล็ก `-n +7`?")
)
```

---

## วิธีเลือกคอลัมน์จากไฟล์

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` และ `tail` ช่วยให้เลือกแถวจากไฟล์ข้อความได้
หากต้องการเลือกคอลัมน์ ให้ใช้คำสั่ง `cut`
คำสั่งนี้มีหลายตัวเลือก (ใช้ `man cut` เพื่อดูรายละเอียด)
แต่รูปแบบที่ใช้บ่อยที่สุดมีลักษณะดังนี้:

```{shell}
cut -f 2-5,8 -d , values.csv
```

ซึ่งหมายความว่า
"เลือกคอลัมน์ 2 ถึง 5 และคอลัมน์ 8
โดยใช้เครื่องหมายจุลภาคเป็นตัวคั่น"
`cut` ใช้ `-f` (ย่อมาจาก "fields") เพื่อระบุคอลัมน์
และ `-d` (ย่อมาจาก "delimiter") เพื่อระบุตัวคั่น
ต้องระบุตัวคั่นเสมอ เนื่องจากบางไฟล์อาจใช้ช่องว่าง แท็บ หรือเครื่องหมายโคลอนแทน

<hr>

คำสั่งใดที่จะเลือกคอลัมน์แรก (ซึ่งเก็บข้อมูลวันที่) จากไฟล์ `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- ใช้ได้ทั้งสองแบบ
- ไม่มีแบบใดถูกต้อง เพราะ `-f` ต้องอยู่ก่อน `-d`

`@hint`
ลำดับของ flag ไม่มีผลต่อการทำงาน

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Yes, but that is not all', 'Yes, but that is not all', 'Correct! Adding a space after the flag is good style, but not compulsory.', 'No, flag order doesn\'t matter'])
```

---

## `cut` ทำอะไรไม่ได้บ้าง?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` เป็นคำสั่งที่ทำงานแบบตรงไปตรงมา
โดยเฉพาะอย่างยิ่ง มันไม่เข้าใจสตริงที่อยู่ในเครื่องหมายคำพูด
ตัวอย่างเช่น ถ้าไฟล์มีเนื้อหาดังนี้:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

เมื่อรันคำสั่ง:

```{shell}
cut -f 2 -d , everyone.csv
```

จะได้ผลลัพธ์เป็น:

```
Age
Ranjit"
Rupinder"
```

แทนที่จะได้อายุของแต่ละคน เพราะ `cut` จะตีความเครื่องหมายคอมมาระหว่างนามสกุลและชื่อว่าเป็นตัวคั่นคอลัมน์

<hr>

ผลลัพธ์ของ `cut -d : -f 2-4` บนบรรทัดนี้คืออะไร:

```
first:second:third:
```

(สังเกตเครื่องหมายโคลอนที่ต่อท้าย)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- ไม่มีข้อใดถูก เพราะมีฟิลด์ไม่ครบสี่ฟิลด์

`@hint`
สังเกตเครื่องหมายโคลอนที่ต่อท้ายด้วย

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['ไม่ใช่ มีมากกว่านั้น', 'ไม่ใช่ มีมากกว่านั้น', 'ถูกต้อง! เครื่องหมายโคลอนท้ายสร้างฟิลด์ที่สี่ที่ว่างเปล่า', 'ไม่ใช่ `cut` ทำได้ดีที่สุดเท่าที่จะทำได้'])
```

---

## จะรันคำสั่งซ้ำได้อย่างไร?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

หนึ่งในข้อดีที่สุดของการใช้ Shell คือทำให้การทำงานซ้ำเป็นเรื่องง่าย
หลังจากรันคำสั่งไปแล้ว สามารถกดปุ่มลูกศรขึ้นเพื่อวนกลับไปยังคำสั่งก่อนหน้าได้
นอกจากนี้ยังใช้ปุ่มลูกศรซ้าย-ขวาและปุ่ม Delete เพื่อแก้ไขคำสั่งได้ด้วย
เมื่อพร้อมแล้วให้กด Enter เพื่อรันคำสั่งที่แก้ไขแล้ว

ยิ่งไปกว่านั้น `history` จะแสดงรายการคำสั่งที่รันไปล่าสุด
แต่ละคำสั่งจะมีหมายเลขกำกับ ทำให้สามารถเรียกใช้คำสั่งที่ต้องการซ้ำได้ง่าย:
เพียงพิมพ์ `!55` เพื่อรันคำสั่งที่ 55 ในประวัติของคุณ (หากมีจำนวนมากพอ)
นอกจากนี้ยังรันคำสั่งซ้ำได้โดยพิมพ์เครื่องหมายอัศเจรีย์ตามด้วยชื่อคำสั่ง
เช่น `!head` หรือ `!cut` ซึ่งจะรันคำสั่งนั้นที่ใช้ล่าสุดอีกครั้ง

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 188a2fab38
xp: 20
```

`@instructions`
รัน `head summer.csv` ใน home directory (ซึ่งควรจะเกิดข้อผิดพลาด)

`@hint`
Tab completion จะไม่ทำงานหากไม่มีชื่อไฟล์ที่ตรงกัน

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="ใช้ `head` และชื่อไฟล์ `summer.csv` ไม่ต้องกังวลหากเกิดข้อผิดพลาด นั่นเป็นเรื่องปกติ")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
เปลี่ยนไดเรกทอรีไปที่ `seasonal`

`@hint`
จำไว้ว่า `cd` ย่อมาจาก "change directory" (เปลี่ยนไดเรกทอรี)

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="หากไดเรกทอรีการทำงานปัจจุบันของท่าน (ตรวจสอบด้วย `pwd`) คือ `/home/repl` ท่านสามารถย้ายไปยังโฟลเดอร์ `seasonal` ได้ด้วยคำสั่ง `cd seasonal`")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
รันคำสั่ง `head` ซ้ำโดยใช้ `!head`

`@hint`
อย่าเว้นวรรคระหว่าง `!` กับส่วนที่ตามมา

`@solution`
```{shell}
!head

```

`@sct`
```{python}
# !head is expanded into head summer.csv by the terminal, so manually specify expression
# This won't work for the validator though, so we have to use check_or to satisfy it.
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_or(
        has_expr_output(expr = 'head summer.csv',
                        incorrect_msg='ใช้ `!head` เพื่อทำซ้ำคำสั่ง `head`'),
        has_code('!head')
    )
)
```

***

```yaml
type: ConsoleExercise
key: a28555575a
xp: 20
```

`@instructions`
ใช้ `history` เพื่อดูคำสั่งที่ผ่านมา

`@hint`
สังเกตว่า `history` จะแสดงคำสั่งล่าสุดไว้ท้ายสุด เพื่อให้เห็นได้ชัดเมื่อคำสั่งรันเสร็จ

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='ใช้ `history` โดยไม่มีแฟล็กเพื่อรับรายการคำสั่งก่อนหน้า')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
รัน `head` ซ้ำอีกครั้งโดยใช้ `!` ตามด้วยหมายเลขคำสั่ง

`@hint`
*อย่า*เว้นวรรคระหว่าง `!` กับส่วนที่ตามมา

`@solution`
```{shell}
!3

```

`@sct`
```{python}
# !3 is expanded into head summer.csv by the terminal, so manually specify expression
# This won't work for the validator though, so we have to use check_or to satisfy it.
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_or(
        has_expr_output(expr = 'head summer.csv',
                        incorrect_msg='คุณได้ใช้ `!<a_number>` เพื่อรันคำสั่ง `head` ล่าสุดจากประวัติอีกครั้งหรือไม่?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("ยอดเยี่ยมมาก! ไปยังข้อถัดไปกันเลย!")
```

---

## จะเลือกบรรทัดที่มีค่าที่ต้องการได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` และ `tail` ใช้เลือกแถว
`cut` ใช้เลือกคอลัมน์
ส่วน `grep` ใช้เลือกบรรทัดตามเนื้อหาที่บรรทัดนั้นมี
ในรูปแบบพื้นฐาน `grep` รับข้อความที่ต้องการค้นหา ตามด้วยชื่อไฟล์หนึ่งไฟล์หรือมากกว่า
แล้วแสดงทุกบรรทัดในไฟล์เหล่านั้นที่มีข้อความนั้นอยู่
ตัวอย่างเช่น
`grep bicuspid seasonal/winter.csv`
จะแสดงบรรทัดใน `winter.csv` ที่มีคำว่า "bicuspid"

`grep` สามารถค้นหาตามรูปแบบ (pattern) ได้ด้วย
ซึ่งจะได้ศึกษาเพิ่มเติมในคอร์สถัดไป
สิ่งที่สำคัญกว่าตอนนี้คือ flag ที่ใช้บ่อยของ `grep`:

- `-c`: แสดงจำนวนบรรทัดที่ตรงกัน แทนที่จะแสดงตัวบรรทัด
- `-h`: *ไม่* แสดงชื่อไฟล์เมื่อค้นหาในหลายไฟล์
- `-i`: ไม่สนใจตัวพิมพ์เล็ก/ใหญ่ (เช่น ถือว่า "Regression" กับ "regression" ตรงกัน)
- `-l`: แสดงชื่อไฟล์ที่มีผลลัพธ์ที่ตรงกัน แทนที่จะแสดงผลลัพธ์นั้น
- `-n`: แสดงหมายเลขบรรทัดของบรรทัดที่ตรงกัน
- `-v`: กลับผลการค้นหา คือแสดงเฉพาะบรรทัดที่ *ไม่* ตรงกัน

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 0d7ef2baa0
xp: 35
```

`@instructions`
แสดงเนื้อหาทุกบรรทัดที่มีคำว่า `molar` ใน `seasonal/autumn.csv`
โดยรันคำสั่งเดียวจาก home directory อย่าใช้ flag ใด ๆ

`@hint`
ใช้ `grep` พร้อมคำที่ต้องการค้นหาและชื่อไฟล์ที่จะค้นใน

`@solution`
```{shell}
grep molar seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("grep", incorrect_msg = "คุณเรียกใช้ `grep` หรือไม่?"),
      has_code("molar", incorrect_msg = "คุณค้นหา `molar` หรือไม่?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "คุณค้นหาในไฟล์ `seasonal/autumn.csv` หรือไม่?")
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: a0eee34d1e
xp: 35
```

`@instructions`
กลับผลการค้นหาเพื่อหาบรรทัดที่ *ไม่* มีคำว่า `molar` ใน `seasonal/spring.csv` และแสดงหมายเลขบรรทัดด้วย
จำไว้ว่าแนวทางที่ดีคือใส่ flag ทั้งหมด *ก่อน* ค่าอื่น เช่น ชื่อไฟล์หรือคำค้นหา "molar"

`@hint`


`@solution`
```{shell}
grep -v -n molar seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("grep", incorrect_msg = "คุณเรียกใช้ `grep` หรือไม่?"),
      has_code("-v", incorrect_msg = "คุณใช้ `-v` เพื่อกลับผลการค้นหาหรือไม่?"),
      has_code("-n", incorrect_msg = "คุณใช้ `-n` เพื่อแสดงหมายเลขบรรทัดหรือไม่?"),
      has_code("molar", incorrect_msg = "คุณค้นหาคำว่า `molar` หรือไม่?"),
      has_code("seasonal/spring.csv", incorrect_msg = "คุณค้นหาในไฟล์ `seasonal/spring.csv` หรือไม่?")
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: f5641234fe
xp: 30
```

`@instructions`
นับจำนวนบรรทัดที่มีคำว่า `incisor` ใน `autumn.csv` และ `winter.csv` รวมกัน
(รันคำสั่งเดียวจาก home directory เช่นกัน)

`@hint`
อย่าลืมใช้ `-c` ร่วมกับ `grep` เพื่อนับจำนวนบรรทัด

`@solution`
```{shell}
grep -c incisor seasonal/autumn.csv seasonal/winter.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("grep", incorrect_msg = "คุณเรียกใช้ `grep` หรือไม่?"),
      has_code("-c", incorrect_msg = "คุณได้รับจำนวนนับด้วย `-c` หรือไม่?"),
      has_code("incisor", incorrect_msg = "คุณค้นหา `incisor` หรือไม่?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "คุณค้นหาในไฟล์ `seasonal/autumn.csv` หรือไม่?"),
      has_code("seasonal/winter.csv", incorrect_msg = "คุณค้นหาในไฟล์ `seasonal/winter.csv` หรือไม่?")
    )
  )
)
```

---

## เหตุใดการมองข้อมูลเป็นแค่ข้อความจึงไม่ปลอดภัยเสมอไป?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

ในส่วน `SEE ALSO` ของหน้า manual สำหรับ `cut` มีการอ้างถึงคำสั่งชื่อ `paste`
ซึ่งใช้รวมไฟล์ข้อมูลเข้าด้วยกันแทนที่จะตัดแบ่งออก

<hr>

อ่านหน้า manual ของ `paste` จากนั้นรัน `paste` เพื่อรวมไฟล์ข้อมูลฤดูใบไม้ร่วงและฤดูหนาวให้อยู่ในตารางเดียว
โดยใช้เครื่องหมายจุลภาคเป็นตัวคั่น
ผลลัพธ์ที่ได้มีปัญหาอะไรในแง่ของการวิเคราะห์ข้อมูล?

`@possible_answers`
- ส่วนหัวคอลัมน์ถูกแสดงซ้ำ
- แถวท้ายบางแถวมีจำนวนคอลัมน์ไม่ถูกต้อง
- ข้อมูลบางส่วนจาก `winter.csv` หายไป

`@hint`
ถ้าใช้ `cut` กับผลลัพธ์ของ `paste` โดยใช้เครื่องหมายจุลภาคเป็นตัวคั่น
จะได้ผลลัพธ์ที่ถูกต้องหรือไม่?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'ถูกต้อง แต่ไม่จำเป็นต้องเป็นข้อผิดพลาด'
correct2 = 'ถูกต้อง: การรวมบรรทัดที่มีคอลัมน์เข้าด้วยกันจะสร้างคอลัมน์ว่างเพียงหนึ่งคอลัมน์ที่จุดเริ่มต้น ไม่ใช่สองคอลัมน์'
err3 = 'ไม่ใช่ ข้อมูลฤดูหนาวทั้งหมดยังคงอยู่ครบถ้วน'
Ex().has_chosen(2, [err1, correct2, err3])
```

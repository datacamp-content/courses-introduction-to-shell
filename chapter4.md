---
title: การประมวลผลแบบกลุ่ม
description: >-
  คำสั่ง Shell ส่วนใหญ่สามารถประมวลผลหลายไฟล์พร้อมกันได้ บทนี้จะแสดงวิธีทำให้
  pipeline ของคุณทำงานแบบนั้น พร้อมทั้งแนะนำการใช้ตัวแปรใน Shell เพื่อเก็บข้อมูล
lessons:
  - nb_of_exercises: 10
    title: Shell เก็บข้อมูลอย่างไร
---

## Shell เก็บข้อมูลอย่างไร?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

เช่นเดียวกับโปรแกรมอื่น ๆ shell จะเก็บข้อมูลไว้ในตัวแปร
ตัวแปรบางตัวเรียกว่า **environment variables** (ตัวแปรสภาพแวดล้อม)
ซึ่งพร้อมใช้งานตลอดเวลา
โดยทั่วไปชื่อของ environment variables จะเขียนด้วยตัวพิมพ์ใหญ่
ตัวแปรที่ใช้บ่อยบางส่วนแสดงไว้ในตารางด้านล่าง

| ตัวแปร | วัตถุประสงค์                              | ค่า                   |
|----------|-----------------------------------|-----------------------|
| `HOME`   | โฮมไดเรกทอรีของผู้ใช้             | `/home/repl`          |
| `PWD `   | ไดเรกทอรีปัจจุบันที่กำลังทำงานอยู่         | เหมือนกับคำสั่ง `pwd` |
| `SHELL`  | โปรแกรม shell ที่กำลังใช้งาน | `/bin/bash`           |
| `USER`   | ID ของผู้ใช้                         | `repl`                |

หากต้องการดูรายการทั้งหมด (ซึ่งค่อนข้างยาว)
ให้พิมพ์ `set` ใน shell

<hr>

ใช้ `set` และ `grep` ร่วมกับ pipe เพื่อแสดงค่าของ `HISTFILESIZE`
ซึ่งกำหนดจำนวนคำสั่งเก่าที่จัดเก็บไว้ในประวัติคำสั่งของคุณ
ค่าดังกล่าวคืออะไร?

`@possible_answers`
- 10
- 500
- [2000]
- ไม่มีตัวแปรนี้

`@hint`
ใช้ `set | grep HISTFILESIZE` เพื่อดึงบรรทัดที่ต้องการ

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "ไม่ถูกต้อง: เชลล์บันทึกประวัติมากกว่านั้น"
err2 = "ไม่ถูกต้อง: เชลล์บันทึกประวัติมากกว่านั้น"
correct3 = "ถูกต้อง: เชลล์บันทึกคำสั่งเก่า 2000 คำสั่งโดยค่าเริ่มต้นในระบบนี้"
err4 = "ไม่ถูกต้อง: ตัวแปร `HISTFILESIZE` มีอยู่"
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## วิธีแสดงค่าของตัวแปร

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

วิธีที่ง่ายกว่าในการดูค่าของตัวแปรคือใช้คำสั่ง `echo` ซึ่งจะพิมพ์อาร์กิวเมนต์ที่ส่งเข้าไป ตัวอย่างเช่น เมื่อพิมพ์

```{shell}
echo hello DataCamp!
```

จะได้ผลลัพธ์

```
hello DataCamp!
```

แต่ถ้าลองใช้คำสั่งนี้เพื่อแสดงค่าของตัวแปรแบบนี้:

```{shell}
echo USER
```

ระบบจะพิมพ์ชื่อตัวแปรออกมาเลย คือ `USER`

หากต้องการให้แสดง*ค่า*ของตัวแปร ต้องใส่เครื่องหมายดอลลาร์ `$` นำหน้าตัวแปรนั้น เมื่อพิมพ์

```{shell}
echo $USER
```

จะได้

```
repl
```

กฎนี้ใช้ได้ทุกที่: หากต้องการดึงค่าของตัวแปรชื่อ `X` ให้เขียนเป็น `$X`
(เพื่อให้ shell แยกแยะได้ว่าหมายถึง "ไฟล์ชื่อ X" หรือ "ค่าของตัวแปรชื่อ X")

`@instructions`
ตัวแปร `OSTYPE` เก็บชื่อประเภทของระบบปฏิบัติการที่ใช้งานอยู่
แสดงค่าของตัวแปรนี้โดยใช้คำสั่ง `echo`

`@hint`
เรียกใช้ `echo` โดยใส่ `$` นำหน้าตัวแปร `OSTYPE`

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
echo $OSTYPE
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_correct(
        has_expr_output(strict = True),
        multi(
            has_code('echo', incorrect_msg="คุณเรียกใช้ `echo` หรือไม่?"),
            has_code('OSTYPE', incorrect_msg="คุณพิมพ์ตัวแปรสภาพแวดล้อม `OSTYPE` หรือไม่?"),
            has_code(r'\$OSTYPE', incorrect_msg="โปรดตรวจสอบให้แน่ใจว่าได้เติม `$` ไว้หน้า `OSTYPE`")
        )
    )
)
Ex().success_msg("ยอดเยี่ยมมากสำหรับการแสดงผลตัวแปรสภาพแวดล้อม! คุณเริ่มต้นได้ดีมาก มาดำเนินการต่อกันเลย!")
```

---

## เชลล์เก็บข้อมูลด้วยวิธีอื่นอีกอย่างไร?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

ตัวแปรอีกประเภทหนึ่งเรียกว่า **shell variable**
ซึ่งทำงานคล้ายกับตัวแปรแบบ local ในภาษาโปรแกรมมิ่ง

ในการสร้าง shell variable
ให้กำหนดค่าให้กับชื่อตัวแปรโดยตรง:

```{shell}
training=seasonal/summer.csv
```

*โดยไม่มี* ช่องว่างก่อนหรือหลังเครื่องหมาย `=`
เมื่อกำหนดค่าแล้ว สามารถตรวจสอบค่าของตัวแปรได้ด้วย:

```{shell}
echo $training
```
```
seasonal/summer.csv
```

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 78f7fd446f
xp: 50
```

`@instructions`
กำหนดตัวแปรชื่อ `testing` ให้มีค่าเป็น `seasonal/winter.csv`

`@hint`
*ไม่ควร* มีช่องว่างระหว่างชื่อตัวแปรกับค่าที่กำหนด

`@solution`
```{shell}
testing=seasonal/winter.csv

```

`@sct`
```{python}
# For some reason, testing the shell variable directly always passes, so we can't do the following.
# Ex().multi(
#     has_cwd('/home/repl'),
#     has_expr_output(
#         expr='echo $testing',
#         output='seasonal/winter.csv',
#         incorrect_msg="Have you used `testing=seasonal/winter.csv` to define the `testing` variable?"
#     )
# )
Ex().multi(
    has_cwd('/home/repl'),
    multi(
        has_code('testing', incorrect_msg='คุณได้กำหนดตัวแปร shell ชื่อ `testing` หรือไม่?'),
        has_code('testing=', incorrect_msg='คุณได้เขียน `=` ต่อท้าย testing โดยตรงโดยไม่มีช่องว่างหรือไม่?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='คุณได้กำหนดค่าของ `testing` เป็น `seasonal/winter.csv` หรือไม่?')
    )
)
```

***

```yaml
type: ConsoleExercise
key: d5e7224f55
xp: 50
```

`@instructions`
ใช้ `head -n 1 SOMETHING` เพื่อดึงบรรทัดแรกจาก `seasonal/winter.csv`
โดยใช้ค่าของตัวแปร `testing` แทนการระบุชื่อไฟล์โดยตรง

`@hint`
อย่าลืมใช้ `$testing` แทนที่จะใช้แค่ `testing`
(ต้องใส่ `$` เพื่อดึงค่าของตัวแปร)

`@solution`
```{shell}
# We need to re-set the variable for testing purposes for this exercise
# you should only run "head -n 1 $testing"
testing=seasonal/winter.csv
head -n 1 $testing

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\$testing', incorrect_msg="คุณอ้างอิงตัวแปร shell โดยใช้ `$testing` หรือไม่?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="คุณเรียกใช้ `head` หรือไม่?"),
            has_code('-n', incorrect_msg="คุณจำกัดจำนวนบรรทัดด้วย `-n` หรือไม่?"),
            has_code(r'-n\s+1', incorrect_msg="คุณเลือกเก็บ 1 บรรทัดด้วย `-n 1` หรือไม่?")     
        )
    )
)
Ex().success_msg("ยอดเยี่ยม! มาดูกันว่าคุณสามารถทำซ้ำคำสั่งได้อย่างง่ายดายอย่างไร")
```

---

## จะทำให้คำสั่งทำงานซ้ำหลายครั้งได้อย่างไร?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

ตัวแปร Shell ยังถูกใช้ใน **ลูป (loops)**
ซึ่งทำให้คำสั่งทำงานซ้ำหลายครั้ง
หากรันคำสั่งนี้:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

จะได้ผลลัพธ์:

```
gif
jpg
png
```

สังเกตสิ่งต่อไปนี้เกี่ยวกับลูป:

1. โครงสร้างคือ `for` ...ตัวแปร... `in` ...รายการ... `; do` ...คำสั่งหลัก... `; done`
2. รายการของสิ่งที่ลูปจะประมวลผล (ในกรณีนี้คือคำว่า `gif`, `jpg`, และ `png`)
3. ตัวแปรที่ติดตามว่าลูปกำลังประมวลผลสิ่งใดอยู่ (ในกรณีนี้คือ `filetype`)
4. คำสั่งหลักของลูปที่ทำการประมวลผล (ในกรณีนี้คือ `echo $filetype`)

สังเกตว่าคำสั่งหลักใช้ `$filetype` เพื่อดึงค่าของตัวแปร ไม่ใช่แค่ `filetype`
เช่นเดียวกับการใช้ตัวแปร Shell ทั่วไป
และให้สังเกตตำแหน่งของเครื่องหมายเซมิโคลอน:
อันแรกอยู่ระหว่างรายการและคีย์เวิร์ด `do`
ส่วนอันที่สองอยู่ระหว่างคำสั่งหลักและคีย์เวิร์ด `done`

`@instructions`
แก้ไขลูปให้แสดงผลลัพธ์ดังนี้:

```
docx
odt
pdf
```

ให้ใช้ `filetype` เป็นชื่อตัวแปรของลูป

`@hint`
ใช้โครงสร้างโค้ดในข้อความแนะนำ โดยเปลี่ยนนามสกุลไฟล์รูปภาพเป็นนามสกุลไฟล์เอกสารแทน

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
for filetype in docx odt pdf; do echo $filetype; done
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('for', incorrect_msg='คุณเรียกใช้ `for` หรือไม่?'),
      has_code('filetype', incorrect_msg='คุณใช้ `filetype` เป็นตัวแปรในลูปหรือไม่?'),
      has_code('in', incorrect_msg='คุณใช้ `in` ก่อนรายการประเภทไฟล์หรือไม่?'),
      has_code('docx odt pdf', incorrect_msg='คุณวนลูปผ่าน `docx`, `odt` และ `pdf` ตามลำดับนั้นหรือไม่?'),
      has_code(r'pdf\s*;', incorrect_msg='คุณใส่เครื่องหมายเซมิโคลอนหลังองค์ประกอบสุดท้ายของลูปหรือไม่?'),
      has_code(r';\s*do', incorrect_msg='คุณใช้ `do` หลังเครื่องหมายเซมิโคลอนแรกหรือไม่?'),
      has_code('echo', incorrect_msg='คุณเรียกใช้ `echo` หรือไม่?'),
      has_code(r'\$filetype', incorrect_msg='คุณใช้ echo กับ `$filetype` หรือไม่?'),
      has_code(r'filetype\s*;', incorrect_msg='คุณใส่เครื่องหมายเซมิโคลอนหลังเนื้อหาของลูปหรือไม่?'),
      has_code('; done', incorrect_msg='คุณลงท้ายด้วย `done` หรือไม่?')
    )
  )
)
Ex().success_msg("ยอดเยี่ยมมากสำหรับการใช้ลูป! ลูปมีประโยชน์อย่างมากหากคุณต้องการทำสิ่งเดิมซ้ำหลายร้อยหรือหลายพันครั้ง")
```

---

## จะวนซ้ำคำสั่งสำหรับแต่ละไฟล์ได้อย่างไร?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

สามารถพิมพ์ชื่อไฟล์ที่ต้องการประมวลผลลงไปในลูปได้โดยตรง
แต่โดยทั่วไปการใช้ wildcard จะสะดวกกว่า
ลองรันลูปนี้ใน console:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

ผลลัพธ์ที่ได้คือ:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

เพราะ shell จะขยาย `seasonal/*.csv` ให้เป็นรายชื่อไฟล์ทั้ง 4 ไฟล์
ก่อนที่จะรันลูป

`@instructions`
แก้ไข wildcard expression เป็น `people/*`
เพื่อให้ลูปแสดงชื่อไฟล์ทั้งหมดในไดเรกทอรี `people`
ไม่ว่าไฟล์จะมีนามสกุลหรือไม่ก็ตาม
กรุณาใช้ `filename` เป็นชื่อตัวแปรของลูป

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
for filename in people/*; do echo $filename; done
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('for', incorrect_msg='คุณเรียกใช้ `for` หรือไม่?'),
      has_code('filename', incorrect_msg='คุณใช้ `filename` เป็นตัวแปรในลูปหรือไม่?'),
      has_code('in', incorrect_msg='คุณใช้ `in` ก่อนรายการประเภทไฟล์หรือไม่?'),
      has_code('people/\*', incorrect_msg='คุณระบุรายการไฟล์ด้วย `people/*` หรือไม่?'),
      has_code(r'people/\*\s*;', incorrect_msg='คุณใส่เครื่องหมายเซมิโคลอนหลังรายการไฟล์หรือไม่?'),
      has_code(r';\s*do', incorrect_msg='คุณใช้ `do` หลังเครื่องหมายเซมิโคลอนแรกหรือไม่?'),
      has_code('echo', incorrect_msg='คุณเรียกใช้ `echo` หรือไม่?'),
      has_code(r'\$filename', incorrect_msg='คุณใช้ `echo` กับ `$filename` หรือไม่?'),
      has_code(r'filename\s*;', incorrect_msg='คุณใส่เครื่องหมายเซมิโคลอนหลังเนื้อหาของลูปหรือไม่?'),
      has_code('; done', incorrect_msg='คุณสิ้นสุดด้วย `done` หรือไม่?')
    )
  )
)
Ex().success_msg("ยอดเยี่ยมมาก! อักขระไวลด์การ์ดและลูปเป็นการผสมผสานที่มีประสิทธิภาพอย่างมาก")
```

---

## จะบันทึกชื่อของชุดไฟล์ได้อย่างไร?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

มักนิยมกำหนดค่าตัวแปรด้วย wildcard expression เพื่อเก็บรายชื่อไฟล์ไว้ใช้งาน
ตัวอย่างเช่น
หากกำหนด `datasets` แบบนี้:

```{shell}
datasets=seasonal/*.csv
```

ก็สามารถแสดงชื่อไฟล์ในภายหลังได้ด้วย:

```{shell}
for filename in $datasets; do echo $filename; done
```

วิธีนี้ช่วยลดการพิมพ์ซ้ำและลดโอกาสเกิดข้อผิดพลาดได้

<hr>

ถ้ารันสองคำสั่งนี้ใน home directory จะได้ผลลัพธ์กี่บรรทัด?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- ไม่มีเลย: เนื่องจาก `files` ถูกกำหนดในบรรทัดแยกต่างหาก จึงไม่มีค่าในบรรทัดที่สอง
- หนึ่งบรรทัด: คำว่า "files"
- สี่บรรทัด: ชื่อไฟล์ข้อมูลตามฤดูกาลทั้งสี่ไฟล์

`@hint`
จำไว้ว่า `X` เพียงอย่างเดียวหมายถึง "X" ตามตัวอักษร ในขณะที่ `$X` คือค่าของตัวแปร `X`

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "ไม่ถูกต้อง: คุณไม่จำเป็นต้องกำหนดตัวแปรในบรรทัดเดียวกับที่คุณใช้งาน"
err2 = "ไม่ถูกต้อง: ตัวอย่างนี้กำหนดและใช้งานตัวแปร `files` ใน shell เดียวกัน"
correct3 = "ถูกต้อง คำสั่งนี้เทียบเท่ากับ `for f in seasonal/*.csv; do echo $f; done`"
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## ชื่อตัวแปรกับค่าของตัวแปร

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

ข้อผิดพลาดที่พบบ่อยคือการลืมใส่ `$` ไว้หน้าชื่อตัวแปร
เมื่อเกิดเหตุการณ์นี้
เชลล์จะใช้ชื่อที่พิมพ์เข้าไปตรงๆ
แทนที่จะใช้ค่าของตัวแปรนั้น

อีกข้อผิดพลาดที่ผู้ใช้ที่มีประสบการณ์มักเจอคือการพิมพ์ชื่อตัวแปรผิด
ตัวอย่างเช่น
หากกำหนดตัวแปร `datasets` แบบนี้:

```{shell}
datasets=seasonal/*.csv
```

แล้วพิมพ์:

```{shell}
echo $datsets
```

เชลล์จะไม่แสดงผลใดๆ
เพราะ `datsets` (ที่ขาดตัว "a" ตัวที่สอง) ยังไม่ได้ถูกกำหนดไว้

<hr>

หากรันคำสั่งสองบรรทัดนี้ใน home directory ผลลัพธ์ที่ได้จะเป็นอะไร?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(อ่านส่วนแรกของลูปให้ดีก่อนตอบ)

`@hint`
จำไว้ว่า `X` เพียงอย่างเดียวคือแค่ "X" ในขณะที่ `$X` คือค่าของตัวแปร `X`

`@possible_answers`
- [หนึ่งบรรทัด: คำว่า "files"]
- สี่บรรทัด: ชื่อของไฟล์ข้อมูล seasonal ทั้งสี่ไฟล์
- สี่บรรทัดว่างเปล่า: ตัวแปร `f` ไม่ได้ถูกกำหนดค่าไว้

`@feedback`
- ถูกต้อง: ลูปใช้ `files` แทน `$files` ดังนั้นรายการจึงประกอบด้วยคำว่า "files" เพียงคำเดียว
- ไม่ใช่: ลูปใช้ `files` แทน `$files` ดังนั้นรายการจึงประกอบด้วยคำว่า "files" ไม่ใช่การขยายค่าของตัวแปร `files`
- ไม่ใช่: ตัวแปร `f` ถูกกำหนดโดยอัตโนมัติโดยลูป `for`

---

## จะรันหลายคำสั่งในลูปเดียวได้อย่างไร?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

การแสดงชื่อไฟล์มีประโยชน์สำหรับการดีบัก
แต่จุดประสงค์หลักของลูปคือการทำงานกับไฟล์หลายไฟล์พร้อมกัน
ลูปด้านล่างนี้แสดงบรรทัดที่สองของไฟล์ข้อมูลแต่ละไฟล์:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

ลูปนี้มีโครงสร้างเดียวกับลูปที่เคยเห็นมาแล้ว
ความแตกต่างเพียงอย่างเดียวคือเนื้อหาของลูปเป็น pipeline ของสองคำสั่งแทนที่จะเป็นคำสั่งเดียว

`@instructions`
เขียนลูปเพื่อแสดงรายการล่าสุดของเดือนกรกฎาคม 2017 (`2017-07`) จากทุกไฟล์ในชุดข้อมูล seasonal ผลลัพธ์ควรคล้ายกับ:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

แต่ให้ทำงานกับ**_ทุก_**ไฟล์ใน seasonal แยกกัน ใช้ `file` เป็นชื่อตัวแปรของลูป และวนลูปผ่านรายการไฟล์ `seasonal/*.csv` (_แทนที่จะเป็น 'seasonal/winter.csv' อย่างในตัวอย่าง_)

`@hint`
ส่วนเนื้อหาของลูปคือคำสั่ง grep ที่แสดงในคำแนะนำ โดยแทนที่ `seasonal/winter.csv` ด้วย `$file`

`@pre_exercise_code`
```{python}

```

`@solution`
```{bash}
for file in seasonal/*.csv; do grep 2017-07 $file | tail -n 1; done
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  # Enforce use of for loop, so students can't just use grep -h 2017-07 seasonal/*.csv
  has_code('for', incorrect_msg='คุณเรียกใช้ `for` หรือไม่?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='คุณใช้ `file` เป็นตัวแปรของลูปหรือไม่?'),
      has_code('in', incorrect_msg='คุณใช้ `in` ก่อนรายการไฟล์หรือไม่?'),
      has_code('seasonal/\*', incorrect_msg='คุณระบุรายการไฟล์ด้วย `seasonal/*` หรือไม่?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='คุณใส่เครื่องหมายเซมิโคลอนหลังรายการไฟล์หรือไม่?'),
      has_code(r';\s*do', incorrect_msg='คุณใช้ `do` หลังเครื่องหมายเซมิโคลอนแรกหรือไม่?'),
      has_code('grep', incorrect_msg='คุณเรียกใช้ `grep` หรือไม่?'),
      has_code('2017-07', incorrect_msg='คุณจับคู่กับ `2017-07` หรือไม่?'),
      has_code(r'\$file', incorrect_msg='คุณใช้ `$file` เป็นชื่อตัวแปรของลูปหรือไม่?'),
      has_code(r'file\s*|', incorrect_msg='คุณใช้ไปป์เพื่อเชื่อมต่อคำสั่งที่สองหรือไม่?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='คุณใช้ `tail -n 1` เพื่อแสดงรายการสุดท้ายของการค้นหาแต่ละครั้งในคำสั่งที่สองหรือไม่?'),
      has_code('; done', incorrect_msg='คุณลงท้ายด้วย `done` หรือไม่?')
    )
  )
)

Ex().success_msg("ยอดเยี่ยมมาก! อักขระตัวแทนและลูปเป็นการผสมผสานที่มีประสิทธิภาพอย่างยิ่ง")
```

---

## ทำไมไม่ควรใช้ช่องว่างในชื่อไฟล์?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

การตั้งชื่อไฟล์แบบหลายคำ เช่น `July 2017.csv` ดูเป็นเรื่องง่ายและสะดวกเมื่อใช้งานผ่าน file explorer แบบกราฟิก
แต่จะสร้างปัญหาเมื่อทำงานใน shell
ตัวอย่างเช่น หากต้องการเปลี่ยนชื่อไฟล์ `July 2017.csv` เป็น `2017 July data.csv`
คุณไม่สามารถพิมพ์คำสั่งแบบนี้ได้:

```{shell}
mv July 2017.csv 2017 July data.csv
```

เพราะ shell จะตีความว่าคุณกำลังพยายามย้ายไฟล์สี่ไฟล์ ได้แก่ `July`, `2017.csv`, `2017`, และ `July` (ซ้ำ)
ไปไว้ในไดเรกทอรีชื่อ `data.csv`
แทนที่จะทำเช่นนั้น ต้องใส่เครื่องหมายคำพูดครอบชื่อไฟล์
เพื่อให้ shell มองแต่ละชื่อเป็น parameter เดียว:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

สมมติว่ามีไฟล์สองไฟล์ชื่อ `current.csv` และ `last year.csv`
(ซึ่งมีช่องว่างในชื่อ)
แล้วพิมพ์คำสั่ง:

```{shell}
rm current.csv last year.csv
```

จะเกิดอะไรขึ้น:

`@hint`
ลองคิดดูว่าถ้ามีคนแสดงคำสั่งนี้ให้คุณดู โดยที่คุณไม่รู้ว่ามีไฟล์ใดอยู่บ้าง คุณจะคาดว่าจะเกิดอะไรขึ้น?

`@possible_answers`
- Shell จะแสดงข้อความแจ้งข้อผิดพลาด เพราะไม่มีไฟล์ชื่อ `last` และ `year.csv` อยู่
- Shell จะลบไฟล์ `current.csv`
- [เกิดทั้งสองกรณีข้างต้น]
- ไม่มีอะไรเกิดขึ้น

`@feedback`
- ถูกต้อง แต่ยังไม่ครบทั้งหมด
- ถูกต้อง แต่ยังไม่ครบทั้งหมด
- ถูกต้อง สามารถใช้เครื่องหมายคำพูดเดี่ยว `'` หรือเครื่องหมายคำพูดคู่ `"` ครอบชื่อไฟล์ได้
- ไม่ถูกต้อง

---

## จะรันคำสั่งหลายคำสั่งในลูปเดียวได้อย่างไร?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

ลูปที่เห็นมาจนถึงตอนนี้มีคำสั่งหรือ pipeline เพียงอันเดียวในส่วนตัวลูป
แต่ในความเป็นจริง ลูปสามารถมีคำสั่งได้หลายคำสั่ง
ในการบอก shell ว่าคำสั่งแต่ละคำสั่งสิ้นสุดที่ไหนและเริ่มต้นที่ไหน
ต้องคั่นคำสั่งแต่ละคำสั่งด้วยเครื่องหมายเซมิโคลอน:

```{shell}
for f in seasonal/*.csv; do echo $f; head -n 2 $f | tail -n 1; done
```

```
seasonal/autumn.csv
2017-01-05,canine
seasonal/spring.csv
2017-01-25,wisdom
seasonal/summer.csv
2017-01-11,canine
seasonal/winter.csv
2017-01-03,bicuspid
```

<hr>

สมมติว่าลืมใส่เครื่องหมายเซมิโคลอนระหว่างคำสั่ง `echo` กับ `head` ในลูปข้างต้น
ทำให้ shell ต้องรันคำสั่งนี้แทน:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

จะเกิดอะไรขึ้น?

`@possible_answers`
- แสดงข้อความแจ้งข้อผิดพลาด
- แสดงผลลัพธ์หนึ่งบรรทัดสำหรับไฟล์ทั้ง 4 ไฟล์
- แสดงผลลัพธ์หนึ่งบรรทัดสำหรับ `autumn.csv` (ไฟล์แรก)
- แสดงบรรทัดสุดท้ายของแต่ละไฟล์

`@hint`
สามารถใช้ pipe ส่งผลลัพธ์จาก `echo` ไปยัง `tail` ได้

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "ไม่ถูกต้อง: ลูปจะทำงาน เพียงแต่จะไม่ดำเนินการในลักษณะที่สมเหตุสมผล"
correct2 = "ถูกต้อง: `echo` สร้างบรรทัดเดียวที่มีชื่อไฟล์ปรากฏสองครั้ง จากนั้น `tail` จะคัดลอกบรรทัดนั้น"
err3 = "ไม่ถูกต้อง: ลูปทำงานหนึ่งครั้งสำหรับแต่ละชื่อไฟล์จากทั้งสี่ชื่อไฟล์"
err4 = "ไม่ถูกต้อง: อินพุตของ `tail` คือเอาต์พุตของ `echo` สำหรับแต่ละชื่อไฟล์"
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

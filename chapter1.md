---
title: การจัดการไฟล์และไดเรกทอรี
description: >-
  บทนี้เป็นบทแนะนำ Unix shell เบื้องต้น จะได้เรียนรู้ว่าเหตุใด Shell
  จึงยังคงถูกใช้งานมาเกือบ 50 ปี แตกต่างจากเครื่องมือแบบกราฟิกที่คุ้นเคยอย่างไร
  วิธีเคลื่อนไหวภายใน Shell รวมถึงการสร้าง แก้ไข และลบไฟล์และโฟลเดอร์
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Shell ต่างจากอินเทอร์เฟซแบบเดสก์ท็อปอย่างไร
---

## Shell ต่างจากอินเทอร์เฟซแบบเดสก์ท็อปอย่างไร?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

ระบบปฏิบัติการอย่าง Windows, Linux หรือ Mac OS คือโปรแกรมประเภทพิเศษ
มันควบคุมโปรเซสเซอร์, ฮาร์ดไดรฟ์, และการเชื่อมต่อเครือข่ายของคอมพิวเตอร์
แต่หน้าที่สำคัญที่สุดคือการรันโปรแกรมอื่น ๆ

เนื่องจากมนุษย์ไม่ได้เป็นดิจิทัล
จึงต้องมีอินเทอร์เฟซสำหรับโต้ตอบกับระบบปฏิบัติการ
อินเทอร์เฟซที่นิยมใช้ในปัจจุบันคือโปรแกรมจัดการไฟล์แบบกราฟิก
ซึ่งแปลงการคลิกและดับเบิลคลิกให้เป็นคำสั่งสำหรับเปิดไฟล์และรันโปรแกรม
แต่ก่อนที่คอมพิวเตอร์จะมีจอแสดงผลแบบกราฟิก
ผู้คนพิมพ์คำสั่งเข้าไปในโปรแกรมที่เรียกว่า **command-line shell**
ทุกครั้งที่ป้อนคำสั่ง shell จะรันโปรแกรมอื่น
แสดงผลลัพธ์ในรูปแบบที่มนุษย์อ่านได้
จากนั้นแสดง *prompt* เพื่อบอกว่าพร้อมรับคำสั่งถัดไปแล้ว
(ชื่อนี้มาจากแนวคิดที่ว่ามันคือ "เปลือกชั้นนอก" ของคอมพิวเตอร์)

การพิมพ์คำสั่งแทนการคลิกและลากอาจดูยุ่งยากในตอนแรก
แต่อย่างที่จะได้เห็นกัน เมื่อเริ่มระบุสิ่งที่ต้องการให้คอมพิวเตอร์ทำ
ก็สามารถนำคำสั่งเดิมมาผสมกันเพื่อสร้างคำสั่งใหม่
และทำงานซ้ำ ๆ ให้เป็นอัตโนมัติได้ด้วยการกดแป้นพิมพ์เพียงไม่กี่ครั้ง

<hr>
โปรแกรมจัดการไฟล์แบบกราฟิกที่ผู้คนทั่วไปใช้กันกับ command-line shell มีความสัมพันธ์กันอย่างไร?

`@hint`
จำไว้ว่าผู้ใช้จะโต้ตอบกับระบบปฏิบัติการได้ก็ต่อเมื่อผ่านโปรแกรมเท่านั้น

`@possible_answers`
- โปรแกรมจัดการไฟล์ใช้สำหรับดูและแก้ไขไฟล์ ส่วน shell ใช้สำหรับรันโปรแกรม
- โปรแกรมจัดการไฟล์ถูกสร้างขึ้นมาบน shell
- Shell เป็นส่วนหนึ่งของระบบปฏิบัติการ ในขณะที่โปรแกรมจัดการไฟล์แยกออกมาต่างหาก
- [ทั้งสองต่างเป็นอินเทอร์เฟซสำหรับส่งคำสั่งไปยังระบบปฏิบัติการ]

`@feedback`
- ทั้งสองแบบช่วยให้ดูและแก้ไขไฟล์ รวมถึงรันโปรแกรมได้
- โปรแกรมจัดการไฟล์แบบกราฟิกและ shell ต่างก็เรียกใช้ฟังก์ชันของระบบปฏิบัติการชุดเดียวกัน
- Shell และโปรแกรมจัดการไฟล์ต่างก็เป็นโปรแกรมที่แปลงคำสั่งของผู้ใช้ (ไม่ว่าจะพิมพ์หรือคลิก) ให้เป็นคำสั่งที่ส่งไปยังระบบปฏิบัติการ
- ถูกต้อง! ทั้งสองรับคำสั่งจากผู้ใช้ (ไม่ว่าจะพิมพ์หรือคลิก) แล้วส่งต่อไปยังระบบปฏิบัติการ

---

## ตอนนี้อยู่ที่ไหน?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**ระบบไฟล์ (filesystem)** ทำหน้าที่จัดการไฟล์และไดเรกทอรี (หรือโฟลเดอร์)
แต่ละรายการจะถูกระบุด้วย **absolute path**
ซึ่งแสดงเส้นทางจาก **root directory** ของระบบไฟล์:
`/home/repl` คือไดเรกทอรี `repl` ที่อยู่ภายในไดเรกทอรี `home`,
ส่วน `/home/repl/course.txt` คือไฟล์ `course.txt` ที่อยู่ในไดเรกทอรีนั้น,
และ `/` เพียงอย่างเดียวคือ root directory

หากต้องการทราบว่าอยู่ที่ตำแหน่งใดในระบบไฟล์
ให้รันคำสั่ง `pwd`
(ย่อมาจาก "**p**rint **w**orking **d**irectory")
คำสั่งนี้จะแสดง absolute path ของ **current working directory**
ซึ่งเป็นตำแหน่งที่ shell ใช้รันคำสั่งและค้นหาไฟล์โดยค่าเริ่มต้น

<hr>
รัน `pwd`
ตอนนี้อยู่ที่ตำแหน่งใด?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
โดยทั่วไประบบ Unix จะจัดเก็บโฮมไดเรกทอรีของผู้ใช้ทุกคนไว้ภายใต้ `/home`

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "นั่นไม่ใช่เส้นทางที่ถูกต้อง"
correct = "ถูกต้อง - คุณอยู่ใน `/home/repl`"

Ex().has_chosen(3, [err, err, correct])
```

---

## จะระบุไฟล์และไดเรกทอรีได้อย่างไร?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` บอกให้รู้ว่าตอนนี้อยู่ที่ไหน
ส่วนถ้าอยากดูว่ามีอะไรอยู่บ้าง
ให้พิมพ์ `ls` (ย่อมาจาก "**l**i**s**ting") แล้วกด Enter
เมื่อใช้เพียงอย่างเดียว
`ls` จะแสดงรายการไฟล์และโฟลเดอร์ในไดเรกทอรีปัจจุบัน
(ไดเรกทอรีที่ `pwd` แสดงอยู่)
ถ้าระบุชื่อไฟล์เพิ่มเข้าไป
`ls` จะแสดงรายการไฟล์เหล่านั้น
และถ้าระบุชื่อไดเรกทอรี
มันจะแสดงเนื้อหาภายในไดเรกทอรีนั้น
ตัวอย่างเช่น
`ls /home/repl` จะแสดงไฟล์และโฟลเดอร์ทั้งหมดในไดเรกทอรีเริ่มต้นของคุณ
(มักเรียกว่า **home directory**)

<hr>
ใช้ `ls` พร้อม argument ที่เหมาะสม เพื่อดูรายการไฟล์ในไดเรกทอรี `/home/repl/seasonal`
(ซึ่งเก็บข้อมูลการผ่าตัดทางทันตกรรมตามวันที่ แบ่งตามฤดูกาล)
ไฟล์ใดต่อไปนี้ *ไม่มี* อยู่ในไดเรกทอรีนั้น?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
ถ้าระบุ path ให้กับ `ls` มันจะแสดงไฟล์และโฟลเดอร์ที่อยู่ใน path นั้น

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "ไฟล์นั้นอยู่ในไดเรกทอรี `seasonal`"
correct = "ถูกต้อง - ไฟล์นั้น *ไม่ได้* อยู่ในไดเรกทอรี `seasonal`"

Ex().has_chosen(2, [err, correct, err, err])
```

---

## มีวิธีอื่นในการระบุไฟล์และไดเรกทอรีอีกไหม?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

พาธแบบสัมบูรณ์เปรียบได้กับพิกัดละติจูดและลองจิจูด คือมีค่าเดิมเสมอไม่ว่าจะอยู่ที่ใด ส่วน**พาธแบบสัมพัทธ์**นั้นระบุตำแหน่งโดยอ้างอิงจากที่ที่คุณอยู่ในขณะนั้น เหมือนกับการบอกว่า "ไปทางเหนือ 20 กิโลเมตร"

ตัวอย่างเช่น:
- ถ้าอยู่ในไดเรกทอรี `/home/repl` พาธ**สัมพัทธ์** `seasonal` จะชี้ไปยังไดเรกทอรีเดียวกับพาธ**สัมบูรณ์** `/home/repl/seasonal`
- ถ้าอยู่ในไดเรกทอรี `/home/repl/seasonal` พาธ**สัมพัทธ์** `winter.csv` จะชี้ไปยังไฟล์เดียวกับพาธ**สัมบูรณ์** `/home/repl/seasonal/winter.csv`

เชลล์จะตัดสินว่าพาธเป็นแบบสัมบูรณ์หรือสัมพัทธ์โดยดูที่อักขระตัวแรก ถ้าขึ้นต้นด้วย `/` คือสัมบูรณ์ ถ้า*ไม่*ขึ้นต้นด้วย `/` คือสัมพัทธ์

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 9db1ed7afd
xp: 35
```

`@instructions`
ขณะนี้อยู่ที่ `/home/repl` ใช้ `ls` พร้อม**พาธสัมพัทธ์**เพื่อแสดงเฉพาะไฟล์ที่มีพาธสัมบูรณ์เป็น `/home/repl/course.txt`

`@hint`
โดยทั่วไปสามารถสร้างพาธสัมพัทธ์ไปยังไฟล์หรือไดเรกทอรีที่อยู่ภายใต้ตำแหน่งปัจจุบันได้
โดยตัดพาธสัมบูรณ์ของตำแหน่งปัจจุบันออกจากพาธสัมบูรณ์ของสิ่งที่ต้องการ

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "คุณไม่ได้เรียกใช้ `ls` เพื่อสร้างรายการไฟล์"), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "คำสั่งของคุณไม่ได้สร้างรายการไฟล์ที่ถูกต้อง กรุณาใช้ `ls` ตามด้วยเส้นทางสัมพัทธ์ไปยัง `/home/repl/course.txt`")
    )
)
```

***

```yaml
type: ConsoleExercise
key: 4165425bf6
xp: 35
```

`@instructions`
ขณะนี้อยู่ที่ `/home/repl`
ใช้ `ls` พร้อมพาธ**สัมพัทธ์**
เพื่อแสดงเฉพาะไฟล์ `/home/repl/seasonal/summer.csv`

`@hint`
พาธสัมพัทธ์จะ*ไม่*ขึ้นต้นด้วย '/'

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "คุณไม่ได้เรียกใช้ `ls` เพื่อสร้างรายการไฟล์"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "คำสั่งของคุณไม่ได้สร้างรายการไฟล์ที่ถูกต้อง กรุณาใช้ `ls` ตามด้วยเส้นทางสัมพัทธ์ไปยัง `/home/repl/seasonal/summer.csv`")
    )
)
```

***

```yaml
type: ConsoleExercise
key: b5e66d3741
xp: 30
```

`@instructions`
ขณะนี้อยู่ที่ `/home/repl`
ใช้ `ls` พร้อมพาธ**สัมพัทธ์**
เพื่อแสดงเนื้อหาในไดเรกทอรี `/home/repl/people`

`@hint`
พาธสัมพัทธ์จะไม่ขึ้นต้นด้วย '/'

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "คุณไม่ได้เรียกใช้ `ls` เพื่อสร้างรายการไฟล์"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "คำสั่งของคุณไม่ได้สร้างรายการไฟล์ที่ถูกต้อง กรุณาใช้ `ls` ตามด้วยเส้นทางสัมพัทธ์ไปยัง `/home/repl/people`")
    )
)
Ex().success_msg("ยินดีด้วย เมื่อคุณทราบเกี่ยวกับการแสดงรายการไฟล์และไดเรกทอรีแล้ว มาดูวิธีการเคลื่อนที่ในระบบไฟล์กัน!")
```

---

## วิธีย้ายไปยังไดเรกทอรีอื่น

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

เช่นเดียวกับที่เราเปิดโฟลเดอร์ด้วยการดับเบิลคลิกใน File Browser ก็สามารถย้ายตำแหน่งในระบบไฟล์ได้ด้วยคำสั่ง `cd`
(ย่อมาจาก "change directory" หรือ "เปลี่ยนไดเรกทอรี")

หากพิมพ์ `cd seasonal` แล้วพิมพ์ `pwd`
เชลล์จะแสดงว่าตอนนี้อยู่ที่ `/home/repl/seasonal`
จากนั้นถ้ารัน `ls` โดยไม่มีพารามิเตอร์
ก็จะเห็นเนื้อหาของ `/home/repl/seasonal`
เพราะนั่นคือตำแหน่งปัจจุบัน
หากต้องการกลับไปยังโฮมไดเรกทอรี `/home/repl`
ให้ใช้คำสั่ง `cd /home/repl`

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 3d0bfdd77d
xp: 35
```

`@instructions`
ขณะนี้อยู่ที่ `/home/repl`/.
ย้ายไปยัง `/home/repl/seasonal` โดยใช้พาธแบบสัมพัทธ์

`@hint`
จำไว้ว่า `cd` ย่อมาจาก "change directory" และพาธแบบสัมพัทธ์จะไม่ขึ้นต้นด้วย '/'

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
key: e69c8eac15
xp: 35
```

`@instructions`
ใช้ `pwd` เพื่อตรวจสอบว่าอยู่ในไดเรกทอรีที่ถูกต้องแล้ว

`@hint`
อย่าลืมกด "Enter" หรือ "Return" หลังจากพิมพ์คำสั่งแล้ว

`@solution`
```{shell}
pwd

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_correct(
      has_expr_output(),
      has_code('pwd')
    )
)
```

***

```yaml
type: ConsoleExercise
key: f6b265bd7f
xp: 30
```

`@instructions`
ใช้ `ls` โดยไม่ต้องระบุพาธ เพื่อดูเนื้อหาในไดเรกทอรีนั้น

`@hint`
อย่าลืมกด "Enter" หรือ "Return" หลังจากพิมพ์คำสั่งแล้ว

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_correct(
      has_expr_output(),
      has_code('ls', incorrect_msg="คำสั่งของคุณไม่ได้สร้างผลลัพธ์ที่ถูกต้อง คุณได้ใช้ `ls` โดยไม่มีเส้นทางเพื่อแสดงเนื้อหาของไดเรกทอรีปัจจุบันหรือไม่?")
    )
)

Ex().success_msg("ยอดเยี่ยม! นี่เป็นเรื่องเกี่ยวกับการนำทางลงไปยังไดเรกทอรีย่อย แล้วการเลื่อนขึ้นล่ะ? มาดูกันเลย!")
```

---

## จะเลื่อนขึ้นไปยังไดเรกทอรีระดับบนได้อย่างไร?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

**ไดเรกทอรีแม่** (parent) คือไดเรกทอรีที่อยู่ระดับสูงกว่า
ตัวอย่างเช่น `/home` คือไดเรกทอรีแม่ของ `/home/repl`
และ `/home/repl` คือไดเรกทอรีแม่ของ `/home/repl/seasonal`
สามารถระบุ absolute path ของไดเรกทอรีแม่ให้กับคำสั่งอย่าง `cd` และ `ls` ได้เสมอ
แต่ในทางปฏิบัติ
มักใช้ประโยชน์จาก path พิเศษ `..`
(จุดสองจุดไม่มีช่องว่าง) ซึ่งหมายถึง "ไดเรกทอรีที่อยู่เหนือไดเรกทอรีปัจจุบัน"
หากอยู่ใน `/home/repl/seasonal`
คำสั่ง `cd ..` จะพาขึ้นไปยัง `/home/repl`
หากใช้ `cd ..` อีกครั้ง
จะไปถึง `/home`
และใช้ `cd ..` อีกหนึ่งครั้งก็จะอยู่ที่ *root directory* `/`
ซึ่งเป็นระดับสูงสุดของระบบไฟล์
(อย่าลืมเว้นช่องว่างระหว่าง `cd` กับ `..` เพราะเป็นคำสั่งและ path คนละส่วน ไม่ใช่คำสั่งสี่ตัวอักษรเดียว)

จุดเดี่ยว `.` หมายถึง "ไดเรกทอรีปัจจุบัน" เสมอ
ดังนั้น `ls` และ `ls .` จึงให้ผลเหมือนกัน
ส่วน `cd .` ไม่มีผลใดๆ
(เพราะเป็นการย้ายไปยังไดเรกทอรีที่อยู่อยู่แล้ว)

 path พิเศษอีกอย่างหนึ่งคือ `~` (อักขระ tilde)
ซึ่งหมายถึง "โฮมไดเรกทอรีของคุณ" เช่น `/home/repl`
ไม่ว่าจะอยู่ที่ใด
`ls ~` จะแสดงเนื้อหาของโฮมไดเรกทอรีเสมอ
และ `cd ~` จะพากลับไปยังโฮมไดเรกทอรีเสมอ

<hr>
หากอยู่ใน `/home/repl/seasonal`
`cd ~/../.` จะพาไปที่ใด?

`@hint`
ติดตามเส้นทางทีละไดเรกทอรี

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (root directory)

`@feedback`
- ไม่ใช่ แต่การใช้ `~` หรือ `..` เพียงอย่างเดียวก็จะพาไปที่นั่นได้
- ถูกต้อง! เส้นทางนี้หมายถึง 'โฮมไดเรกทอรี', 'ขึ้นหนึ่งระดับ', 'ที่นี่'
- ไม่ใช่ แต่การใช้ `.` เพียงอย่างเดียวจะให้ผลแบบนั้น
- ไม่ใช่ ส่วนสุดท้ายของเส้นทางคือ `.` (หมายถึง "ที่นี่") ไม่ใช่ `..` (หมายถึง "ขึ้นระดับบน")

---

## การคัดลอกไฟล์ทำอย่างไร?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

บ่อยครั้งที่ต้องการคัดลอกไฟล์ ย้ายไฟล์ไปยังไดเรกทอรีอื่นเพื่อจัดระเบียบ หรือเปลี่ยนชื่อไฟล์
คำสั่งที่ใช้สำหรับสิ่งนี้คือ `cp` ซึ่งย่อมาจาก "copy"
หากมีไฟล์ชื่อ `original.txt` อยู่แล้ว คำสั่งต่อไปนี้:

```{shell}
cp original.txt duplicate.txt
```

จะสร้างสำเนาของ `original.txt` โดยตั้งชื่อว่า `duplicate.txt`
ถ้ามีไฟล์ชื่อ `duplicate.txt` อยู่ก่อนแล้ว ไฟล์นั้นจะถูกเขียนทับ
หากพารามิเตอร์สุดท้ายของ `cp` เป็นไดเรกทอรีที่มีอยู่แล้ว คำสั่งเช่น:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

จะคัดลอกไฟล์ *ทั้งหมด* ไปยังไดเรกทอรีนั้น

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 6ab3fb1e25
xp: 50
```

`@instructions`
สร้างสำเนาของ `seasonal/summer.csv` ในไดเรกทอรี `backup` (ซึ่งอยู่ใน `/home/repl` เช่นกัน) โดยตั้งชื่อไฟล์ใหม่ว่า `summer.bck`

`@hint`
รวมชื่อไดเรกทอรีปลายทางกับชื่อไฟล์ที่คัดลอก เพื่อสร้าง relative path สำหรับไฟล์ใหม่

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` ดูเหมือนจะไม่มีอยู่ในไดเรกทอรี `backup` กรุณาระบุเส้นทางสองเส้นทางให้กับ `cp`: ไฟล์ที่มีอยู่ (`seasonal/summer.csv`) และไฟล์ปลายทาง (`backup/summer.bck`)"),
    has_cwd('/home/repl')
)
```

***

```yaml
type: ConsoleExercise
key: d9e1214bb0
xp: 50
```

`@instructions`
คัดลอก `spring.csv` และ `summer.csv` จากไดเรกทอรี `seasonal` ไปยังไดเรกทอรี `backup` *โดยไม่ต้องเปลี่ยน* current working directory (`/home/repl`)

`@hint`
ใช้ `cp` พร้อมระบุชื่อไฟล์ที่ต้องการคัดลอก *แล้วตามด้วย* ชื่อไดเรกทอรีปลายทาง

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` ดูเหมือนว่าจะไม่ได้ถูกคัดลอกไปยังไดเรกทอรี `backup` กรุณาระบุชื่อไฟล์สองชื่อและชื่อไดเรกทอรีให้กับ `cp`"
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="กรุณาตรวจสอบให้แน่ใจว่าได้คัดลอกไฟล์ขณะอยู่ใน `{{dir}}`! ใช้ `cd {{dir}}` เพื่อนำทางกลับไปที่นั่น"),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("ทำได้ดีมาก นอกจากการคัดลอกแล้ว เราควรสามารถย้ายไฟล์จากไดเรกทอรีหนึ่งไปยังอีกไดเรกทอรีหนึ่งได้ด้วย เรียนรู้เพิ่มเติมได้ในแบบฝึกหัดถัดไป!")
```

---

## จะย้ายไฟล์ได้อย่างไร?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

คำสั่ง `cp` ใช้คัดลอกไฟล์ ส่วน `mv` ใช้ย้ายไฟล์จากไดเรกทอรีหนึ่งไปยังอีกที่หนึ่ง เหมือนกับการลากไฟล์ในโปรแกรมจัดการไฟล์แบบกราฟิก
การระบุพารามิเตอร์ใช้วิธีเดียวกับ `cp` ตัวอย่างเช่น คำสั่ง:

```{shell}
mv autumn.csv winter.csv ..
```

จะย้ายไฟล์ `autumn.csv` และ `winter.csv` จากไดเรกทอรีปัจจุบันขึ้นไปหนึ่งระดับสู่ไดเรกทอรีแม่
(เนื่องจาก `..` หมายถึงไดเรกทอรีที่อยู่เหนือตำแหน่งปัจจุบันเสมอ)

`@instructions`
ขณะนี้อยู่ที่ `/home/repl` ซึ่งมีไดเรกทอรีย่อยชื่อ `seasonal` และ `backup`
ใช้คำสั่งเดียว ย้าย `spring.csv` และ `summer.csv` จาก `seasonal` ไปยัง `backup`

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
mv seasonal/spring.csv seasonal/summer.csv backup
```

`@sct`
```{python}
backup_patt="ไฟล์ `%s` ไม่อยู่ในไดเรกทอรี `backup` คุณได้ใช้ `mv` อย่างถูกต้องหรือไม่? กรุณาใช้ชื่อไฟล์สองชื่อและไดเรกทอรีเป็นพารามิเตอร์ของ `mv`"
seasonal_patt="ไฟล์ `%s` ยังคงอยู่ในไดเรกทอรี `seasonal` กรุณาย้ายไฟล์ด้วย `mv` แทนการคัดลอกด้วย `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("เยี่ยมมาก เราไปต่อกันเลย!")
```

---

## การเปลี่ยนชื่อไฟล์ทำได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` ยังสามารถใช้เปลี่ยนชื่อไฟล์ได้ด้วย ตัวอย่างเช่น ถ้ารันคำสั่ง:

```{shell}
mv course.txt old-course.txt
```

ไฟล์ `course.txt` ในไดเรกทอรีปัจจุบันจะถูก "ย้าย" ไปเป็นไฟล์ `old-course.txt`
วิธีนี้ต่างจากการทำงานของตัวจัดการไฟล์แบบกราฟิก แต่ก็มีประโยชน์มากในหลายสถานการณ์

ข้อควรระวัง:
เช่นเดียวกับ `cp` คำสั่ง `mv` จะเขียนทับไฟล์ที่มีอยู่แล้ว
ตัวอย่างเช่น ถ้ามีไฟล์ชื่อ `old-course.txt` อยู่แล้ว คำสั่งข้างต้นจะแทนที่ไฟล์นั้นด้วยเนื้อหาจาก `course.txt`

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 710187c8c7
xp: 35
```

`@instructions`
เข้าไปในไดเรกทอรี `seasonal`

`@hint`
จำไว้ว่า `cd` ย่อมาจาก "change directory" และพาธแบบ relative จะไม่ขึ้นต้นด้วย '/'

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
key: ed5fe1df23
xp: 35
```

`@instructions`
เปลี่ยนชื่อไฟล์ `winter.csv` เป็น `winter.csv.bck`

`@hint`
ใช้ `mv` โดยระบุชื่อไฟล์ปัจจุบันก่อน ตามด้วยชื่อที่ต้องการ

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " ใช้ `mv` พร้อมกับอาร์กิวเมนต์สองตัว: ไฟล์ที่ต้องการเปลี่ยนชื่อ (`winter.csv`) และชื่อใหม่ของไฟล์ (`winter.csv.bck`)"
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="คาดว่าจะพบ `winter.csv.bck` ในไดเรกทอรี" + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="ไม่คาดว่าจะพบ `winter.csv` ในไดเรกทอรีอีกต่อไป" + hint)
    )
)
```

***

```yaml
type: ConsoleExercise
key: 1deee4c768
xp: 30
```

`@instructions`
รัน `ls` เพื่อตรวจสอบว่าทุกอย่างถูกต้อง

`@hint`
อย่าลืมกด "Enter" หรือ "Return" เพื่อรันคำสั่ง

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="คุณได้ใช้ `ls` เพื่อแสดงรายการเนื้อหาในไดเรกทอรีการทำงานปัจจุบันของคุณหรือไม่?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "คำสั่งของคุณไม่ได้สร้างรายการไฟล์ที่ถูกต้อง กรุณาใช้ `ls` โดยไม่มีอาร์กิวเมนต์เพื่อแสดงรายการเนื้อหาในไดเรกทอรีการทำงานปัจจุบันของคุณ")
    )
)
Ex().success_msg("การคัดลอก การย้าย การเปลี่ยนชื่อ คุณเข้าใจทุกอย่างแล้ว! ต่อไป: การลบไฟล์")
```

---

## จะลบไฟล์ได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

เราสามารถคัดลอกและย้ายไฟล์ได้
ส่วนการลบไฟล์นั้นใช้คำสั่ง `rm`
ซึ่งย่อมาจากคำว่า "remove"
เช่นเดียวกับ `cp` และ `mv`
สามารถระบุชื่อไฟล์ได้หลายไฟล์พร้อมกัน เช่น:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

คำสั่งนี้จะลบทั้ง `thesis.txt` และ `backup/thesis-2017-08.txt`

`rm` ทำงานตรงตามชื่อ
และลบไฟล์ทันที:
ต่างจากโปรแกรมจัดการไฟล์แบบกราฟิก
เชลล์ไม่มีถังขยะ
ดังนั้นเมื่อพิมพ์คำสั่งข้างต้น ไฟล์จะหายไปอย่างถาวร

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: d7580f7bd4
xp: 25
```

`@instructions`
ขณะนี้อยู่ที่ `/home/repl`
เข้าไปยังไดเรกทอรี `seasonal`

`@hint`
จำไว้ว่า `cd` ย่อมาจาก "change directory" และพาธแบบ relative จะไม่ขึ้นต้นด้วย '/'

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().has_cwd('/home/repl/seasonal')
```

***

```yaml
type: ConsoleExercise
key: 1c21cc7039
xp: 25
```

`@instructions`
ลบไฟล์ `autumn.csv`

`@hint`
จำไว้ว่า `rm` ย่อมาจาก "remove"

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="เราไม่คาดว่า `autumn.csv` จะยังคงอยู่ในไดเรกทอรี `seasonal` กรุณาใช้ `rm` พร้อมกับเส้นทางของไฟล์ที่ต้องการลบ"),
    has_code('rm', incorrect_msg = 'กรุณาใช้ `rm` เพื่อลบไฟล์ แทนที่จะย้ายไฟล์')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
กลับไปยังโฮมไดเรกทอรี

`@hint`
หากใช้ `cd` โดยไม่ระบุพาธ คำสั่งจะพาไปยังโฮมไดเรกทอรี

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="ใช้ `cd ..` หรือ `cd ~` เพื่อกลับไปยังไดเรกทอรีหลัก")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
ลบไฟล์ `seasonal/summer.csv` โดยไม่ต้องเปลี่ยนไดเรกทอรีอีกครั้ง

`@hint`
จำไว้ว่า `rm` ย่อมาจาก "remove"

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="เราไม่คาดว่า `summer.csv` จะยังคงอยู่ในไดเรกทอรี `seasonal` กรุณาใช้ `rm` พร้อมกับเส้นทางของไฟล์ที่ต้องการลบ"),
    has_code('rm', incorrect_msg = 'กรุณาใช้ `rm` เพื่อลบไฟล์ แทนที่จะย้ายไฟล์')
)
Ex().success_msg("ยอดเยี่ยมมาก! ไปยังขั้นตอนถัดไปกันเลย!")
```

---

## จะสร้างและลบไดเรกทอรีได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` จัดการไดเรกทอรีเหมือนกับไฟล์ทั่วไป:
ตัวอย่างเช่น ถ้าอยู่ในโฮมไดเรกทอรีแล้วรัน `mv seasonal by-season`
`mv` จะเปลี่ยนชื่อไดเรกทอรี `seasonal` เป็น `by-season`
อย่างไรก็ตาม `rm` ทำงานต่างออกไป

หากลอง `rm` ไดเรกทอรี
เชลล์จะแสดงข้อความแจ้งข้อผิดพลาดว่าไม่สามารถทำได้
เพื่อป้องกันการลบไดเรกทอรีทั้งหมดโดยไม่ตั้งใจ
ให้ใช้คำสั่งแยกต่างหากชื่อ `rmdir` แทน
เพื่อความปลอดภัยยิ่งขึ้น คำสั่งนี้จะทำงานได้เฉพาะเมื่อไดเรกทอรีว่างเปล่าเท่านั้น
จึงต้องลบไฟล์ภายในไดเรกทอรี *ก่อน* จึงจะลบไดเรกทอรีได้
(ผู้ใช้ที่มีประสบการณ์สามารถใช้ option `-r` กับ `rm` เพื่อให้ได้ผลลัพธ์เดียวกัน
เราจะพูดถึง option ของคำสั่งในบทถัดไป)

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 5a81bb8589
xp: 25
```

`@instructions`
โดยไม่ต้องเปลี่ยนไดเรกทอรี
ให้ลบไฟล์ `agarwal.txt` ในไดเรกทอรี `people`

`@hint`
จำไว้ว่า `rm` ย่อมาจาก "remove" และพาธแบบ relative จะไม่ขึ้นต้นด้วย '/'

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` ไม่ควรอยู่ใน `/home/repl/people` อีกต่อไป คุณใช้ `rm` อย่างถูกต้องหรือไม่?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'ยังคงมีไฟล์อยู่ในไดเรกทอรี `people` หากคุณเพียงแค่ย้าย `agarwal.txt` หรือสร้างไฟล์ใหม่ โปรดลบไฟล์เหล่านั้นทั้งหมด')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
เมื่อไดเรกทอรี `people` ว่างเปล่าแล้ว
ให้ใช้คำสั่งเดียวเพื่อลบมัน

`@hint`
จำไว้ว่า `rm` ใช้ได้กับไฟล์เท่านั้น

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "ไดเรกทอรี 'people' ไม่ควรอยู่ในไดเรกทอรีหลักของคุณอีกต่อไป กรุณาใช้ `rmdir` เพื่อลบออก!")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
เนื่องจากไดเรกทอรีไม่ใช่ไฟล์
จึงต้องใช้คำสั่ง `mkdir directory_name`
เพื่อสร้างไดเรกทอรีใหม่ (ที่ว่างเปล่า)
ใช้คำสั่งนี้เพื่อสร้างไดเรกทอรีใหม่ชื่อ `yearly` ภายใต้โฮมไดเรกทอรี

`@hint`
รัน `mkdir` พร้อมระบุชื่อไดเรกทอรีที่ต้องการสร้าง

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="ไม่มีไดเรกทอรี `yearly` ในไดเรกทอรีหลักของคุณ กรุณาใช้คำสั่ง `mkdir yearly` เพื่อสร้างไดเรกทอรีดังกล่าว!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
เมื่อมี `yearly` แล้ว
ให้สร้างไดเรกทอรีอีกอันชื่อ `2017` ภายใน
*โดยไม่ต้องออกจาก*โฮมไดเรกทอรี

`@hint`
ใช้พาธแบบ relative สำหรับไดเรกทอรีย่อยที่ต้องการสร้าง

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="ไม่พบไดเรกทอรี '2017' ใน '/home/repl/yearly' คุณสามารถสร้างไดเรกทอรีนี้โดยใช้เส้นทางสัมพัทธ์ `yearly/2017`")
)
Ex().success_msg("ยอดเยี่ยม! มาสรุปบทนี้ด้วยแบบฝึกหัดที่ทบทวนแนวคิดบางส่วนของบทนี้กันเถอะ!")
```

---

## สรุปท้ายบท

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

ในการวิเคราะห์ข้อมูล มักจะมีการสร้างไฟล์ชั่วคราวขึ้นมาระหว่างกระบวนการ
แทนที่จะเก็บไว้ใน home directory
สามารถนำไปไว้ใน `/tmp` ได้
ซึ่งเป็นที่ที่ผู้ใช้และโปรแกรมมักเก็บไฟล์ที่ต้องการเพียงชั่วคราว
(สังเกตว่า `/tmp` อยู่ใต้ root directory `/` โดยตรง
*ไม่ใช่* อยู่ใต้ home directory ของคุณ)
แบบฝึกหัดสรุปท้ายบทนี้จะแสดงวิธีการทำสิ่งดังกล่าว

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 59781bc43b
xp: 25
```

`@instructions`
ใช้ `cd` เพื่อไปยัง `/tmp`

`@hint`
จำไว้ว่า `cd` ย่อมาจาก "change directory" และ absolute path จะขึ้นต้นด้วย '/'

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'คุณอยู่ในไดเรกทอรีที่ไม่ถูกต้อง กรุณาใช้ `cd` เพื่อเปลี่ยนไดเรกทอรีไปยัง `/tmp`')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
แสดงรายการเนื้อหาใน `/tmp` *โดยไม่ต้อง* พิมพ์ชื่อ directory

`@hint`
หากไม่ระบุชื่อ directory ให้ `ls` `ls` จะแสดงเนื้อหาใน directory ปัจจุบัน

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "คุณไม่ได้เรียกใช้ `ls` เพื่อสร้างรายการไฟล์"),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "คำสั่งของคุณไม่ได้สร้างรายการไฟล์ที่ถูกต้อง กรุณาใช้ `ls` โดยไม่มีอาร์กิวเมนต์")
    )
)
```

***

```yaml
type: ConsoleExercise
key: edaf1bcf96
xp: 25
```

`@instructions`
สร้าง directory ใหม่ภายใน `/tmp` ชื่อว่า `scratch`

`@hint`
ใช้ `mkdir` เพื่อสร้าง directory

`@solution`
```{shell}
mkdir scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_correct(
      has_dir('/tmp/scratch'),
      has_code('mkdir +scratch', incorrect_msg="ไม่พบไดเรกทอรี 'scratch' ภายใต้ '/tmp' กรุณาตรวจสอบให้แน่ใจว่าใช้คำสั่ง `mkdir` อย่างถูกต้อง")
    )
)
```

***

```yaml
type: ConsoleExercise
key: a904a3a719
xp: 25
```

`@instructions`
ย้ายไฟล์ `/home/repl/people/agarwal.txt` ไปยัง `/tmp/scratch`
แนะนำให้ใช้ชอร์ตคัต `~` แทน home directory และใช้ relative path สำหรับปลายทาง แทนการพิมพ์ absolute path

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="ไม่พบ 'agarwal.txt' ใน '/tmp/scratch' กรุณาใช้ `mv` โดยระบุ `~/people/agarwal.txt` เป็นพารามิเตอร์แรก และ `scratch` เป็นพารามิเตอร์ที่สอง")
)
Ex().success_msg("นี่คือบทสรุปของบทที่ 1 ในหลักสูตร Introduction to Shell! รีบไปยังบทถัดไปเพื่อเรียนรู้เพิ่มเติมเกี่ยวกับการจัดการข้อมูล!")
```

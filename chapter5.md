---
title: การสร้างเครื่องมือใหม่
description: >-
  ประวัติคำสั่งช่วยให้ทำซ้ำได้ด้วยการพิมพ์เพียงไม่กี่ครั้ง และ pipe
  ช่วยให้รวมคำสั่งที่มีอยู่เพื่อสร้างคำสั่งใหม่ได้
  ในบทนี้จะได้เรียนรู้วิธีก้าวไปอีกขั้นด้วยการสร้างคำสั่งของตัวเอง
lessons:
  - nb_of_exercises: 9
    title: วิธีแก้ไขไฟล์
---

## จะแก้ไขไฟล์ได้อย่างไร?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix มีโปรแกรมแก้ไขข้อความให้เลือกใช้หลากหลายมาก
ในคอร์สนี้ เราจะใช้โปรแกรมที่เรียบง่ายชื่อว่า Nano
หากพิมพ์ `nano filename` โปรแกรมจะเปิด `filename` เพื่อแก้ไข
(หรือสร้างไฟล์ใหม่หากยังไม่มี)
สามารถเลื่อนเคอร์เซอร์ด้วยปุ่มลูกศร,
ลบตัวอักษรด้วยปุ่ม Backspace,
และใช้คีย์ลัด Ctrl เพื่อทำงานต่าง ๆ ได้ดังนี้:

- `Ctrl` + `K`: ลบทั้งบรรทัด
- `Ctrl` + `U`: เรียกบรรทัดที่ลบกลับคืน
- `Ctrl` + `O`: บันทึกไฟล์ (O ย่อมาจาก 'output') _จากนั้นต้องกด Enter เพื่อยืนยันชื่อไฟล์ด้วย!_
- `Ctrl` + `X`: ออกจากโปรแกรมแก้ไข

`@instructions`
รัน `nano names.txt` เพื่อสร้างและแก้ไขไฟล์ใหม่ในโฮมไดเรกทอรี
แล้วพิมพ์ข้อความสี่บรรทัดต่อไปนี้:

```
Lovelace
Hopper
Johnson
Wilson
```

เมื่อพิมพ์เสร็จแล้ว ให้กด `Ctrl` + `O` เพื่อบันทึกไฟล์,
จากนั้นกด Enter เพื่อยืนยันชื่อไฟล์,
แล้วกด `Ctrl` + `X` เพื่อออกจากโปรแกรมแก้ไข

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
patt = "คุณได้รวมบรรทัด `%s` ในไฟล์ `names.txt` หรือไม่? ใช้ `nano names.txt` อีกครั้งเพื่ออัปเดตไฟล์ของคุณ ใช้ `Ctrl` + `O` เพื่อบันทึกและ `Ctrl` + `X` เพื่อออก"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("ยอดเยี่ยม! ไปยังข้อถัดไปกันเลย!")
```

---

## จะบันทึกสิ่งที่เพิ่งทำได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

เมื่อทำการวิเคราะห์ที่ซับซ้อน มักจะต้องการเก็บบันทึกคำสั่งที่ใช้ไว้
ทำได้โดยใช้เครื่องมือที่รู้จักอยู่แล้ว:

1. รัน `history`
2. ส่งผลลัพธ์ผ่าน pipe ไปยัง `tail -n 10` (หรือจำนวนขั้นตอนล่าสุดที่ต้องการบันทึก)
3. เปลี่ยนทิศทาง (redirect) ผลลัพธ์นั้นไปยังไฟล์ชื่อเช่น `figure-5.history`

วิธีนี้ดีกว่าการจดลงในสมุดบันทึกแล็บ เพราะรับประกันได้ว่าจะไม่มีขั้นตอนใดหลุดหาย
นอกจากนี้ยังสะท้อนให้เห็นแนวคิดหลักของ shell ได้ชัดเจน นั่นคือ เครื่องมือเรียบง่ายที่รับและส่งออกข้อมูลเป็นบรรทัดข้อความ สามารถนำมาประกอบกันได้หลากหลายรูปแบบ เพื่อแก้ปัญหาได้อย่างกว้างขวาง

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
คัดลอกไฟล์ `seasonal/spring.csv` และ `seasonal/summer.csv` ไปยังโฮมไดเรกทอรี

`@hint`
ใช้ `cp` เพื่อคัดลอกไฟล์ และใช้ `~` เป็นชื่อย่อสำหรับพาธของโฮมไดเรกทอรี

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="คุณได้ใช้ `cp seasonal/s* ~` เพื่อคัดลอกไฟล์ที่ต้องการไปยังไดเรกทอรีหลักของคุณหรือไม่?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("การบันทึกข้อมูลที่น่าประทับใจ! หากคุณพิมพ์คำสั่งผิดพลาด คุณสามารถใช้ `nano` เพื่อแก้ไขไฟล์ประวัติการบันทึกได้ในภายหลัง")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
ใช้ `grep` พร้อม flag `-h` (เพื่อไม่ให้แสดงชื่อไฟล์)
และ `-v Tooth` (เพื่อเลือกบรรทัดที่ *ไม่* ตรงกับบรรทัดส่วนหัว)
เพื่อดึงข้อมูลจาก `spring.csv` และ `summer.csv` ตามลำดับนั้น
แล้ว redirect ผลลัพธ์ไปยัง `temp.csv`

`@hint`
ระบุ flag ก่อนชื่อไฟล์เสมอ

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "โปรดตรวจสอบให้แน่ใจว่าคุณได้เปลี่ยนเส้นทางผลลัพธ์ของคำสั่ง `grep` ไปยัง `temp.csv` ด้วย `>`!"
msg2 = "คุณได้ใช้ `grep -h -v ___ ___ ___` (กรอกข้อมูลในช่องว่าง) เพื่อเติมข้อมูลใน `temp.csv` หรือไม่?"
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
ส่งผลลัพธ์จาก `history` ผ่าน pipe ไปยัง `tail -n 3`
แล้ว redirect ผลลัพธ์ไปยัง `steps.txt`
เพื่อบันทึกคำสั่งสามรายการล่าสุดลงในไฟล์
(ต้องบันทึกสามรายการแทนที่จะเป็นสองรายการ
เพราะคำสั่ง `history` เองก็จะปรากฏอยู่ในรายการด้วย)

`@hint`
อย่าลืมว่าการเปลี่ยนทิศทางด้วย `>` จะอยู่ท้ายสุดของชุดคำสั่งที่เชื่อมด้วย pipe

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="ตรวจสอบให้แน่ใจว่าได้เปลี่ยนเส้นทางผลลัพธ์ของคำสั่งไปยัง `steps.txt`"
msg2="คุณได้ใช้ `history | tail ___ ___` (กรอกข้อมูลในช่องว่าง) เพื่อเติมข้อมูลใน `steps.txt` หรือไม่?"
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
Ex().success_msg("ยอดเยี่ยม! มาเพิ่มระดับความท้าทายกันเถอะ!")
```

---

## จะบันทึกคำสั่งเพื่อรันซ้ำในภายหลังได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

จนถึงตอนนี้ คุณใช้ shell แบบโต้ตอบโดยตรง
แต่เนื่องจากคำสั่งที่พิมพ์เข้าไปนั้นเป็นแค่ข้อความ
จึงสามารถเก็บไว้ในไฟล์เพื่อให้ shell รันซ้ำได้เรื่อย ๆ
ลองเริ่มสำรวจความสามารถนี้ด้วยการนำคำสั่งต่อไปนี้ไปใส่ในไฟล์ชื่อ `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

คำสั่งนี้จะดึงแถวแรกจากไฟล์ CSV แต่ละไฟล์ในไดเรกทอรี `seasonal`
เมื่อสร้างไฟล์แล้ว ให้รันด้วยคำสั่ง:

```{shell}
bash headers.sh
```

คำสั่งนี้บอกให้ shell (ซึ่งก็คือโปรแกรมที่ชื่อ `bash`)
รันคำสั่งที่อยู่ในไฟล์ `headers.sh`
ซึ่งจะให้ผลลัพธ์เหมือนกับการรันคำสั่งโดยตรงทุกประการ

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
ใช้ `nano dates.sh` เพื่อสร้างไฟล์ชื่อ `dates.sh`
ที่มีคำสั่งต่อไปนี้:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

เพื่อดึงคอลัมน์แรกจากไฟล์ CSV ทั้งหมดในไดเรกทอรี `seasonal`

`@hint`
ใส่คำสั่งที่กำหนดลงในไฟล์โดยไม่ต้องมีบรรทัดว่างหรือช่องว่างเพิ่มเติม

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "คุณได้รวมบรรทัด `cut -d , -f 1 seasonal/*.csv` ไว้ในไฟล์ `dates.sh` หรือไม่? ใช้ `nano dates.sh` อีกครั้งเพื่ออัปเดตไฟล์ของคุณ ใช้ `Ctrl` + `O` เพื่อบันทึกและ `Ctrl` + `X` เพื่อออก"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/dates.sh').\
        has_code('cut -d *, *-f +1 +seasonal\/\*\.csv', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: 30a8fa953e
xp: 50
```

`@instructions`
ใช้ `bash` เพื่อรันไฟล์ `dates.sh`

`@hint`
ใช้ `bash filename` เพื่อรันไฟล์

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
      has_code("bash", incorrect_msg = 'คุณเรียกใช้ `bash` หรือไม่?'),
      has_code("dates.sh", incorrect_msg = 'คุณระบุไฟล์ `dates.sh` หรือไม่?')
    )
  )
)
```

---

## จะนำ pipe กลับมาใช้ซ้ำได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

ไฟล์ที่รวบรวมคำสั่ง shell ไว้เรียกว่า ***shell script*** หรือเรียกสั้น ๆ ว่า "script" ชื่อไฟล์ script ไม่จำเป็นต้องลงท้ายด้วย `.sh` แต่ในบทเรียนนี้จะใช้รูปแบบดังกล่าวเพื่อให้แยกแยะไฟล์ script ได้ง่ายขึ้น

Script ยังสามารถมี pipe อยู่ภายในได้ด้วย
ตัวอย่างเช่น ถ้า `all-dates.sh` มีบรรทัดนี้:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

แล้วรัน:

```{shell}
bash all-dates.sh > dates.out
```

จะดึงวันที่ที่ไม่ซ้ำกันออกจากไฟล์ข้อมูลตามฤดูกาล และบันทึกผลลัพธ์ไว้ใน `dates.out`

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
ไฟล์ `teeth.sh` ในโฮมไดเรกทอรีถูกเตรียมไว้ให้แล้ว แต่ยังมีส่วนที่ว่างอยู่
ให้ใช้ Nano แก้ไขไฟล์และแทนที่ตัวแทน `____` ทั้งสองจุดด้วย `seasonal/*.csv` และ `-c` เพื่อให้ script นี้แสดงจำนวนครั้งที่ชื่อฟันแต่ละชื่อปรากฏในไฟล์ CSV ภายในไดเรกทอรี `seasonal`

`@hint`
ใช้ `nano teeth.sh` เพื่อแก้ไขไฟล์

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="คุณได้แทนที่ช่องว่างอย่างถูกต้องหรือไม่ เพื่อให้คำสั่งใน `teeth.sh` อ่านว่า `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? ใช้ `nano teeth.sh` อีกครั้งเพื่อทำการเปลี่ยนแปลงที่จำเป็น"
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
ใช้ `bash` รัน `teeth.sh` และใช้ `>` เพื่อเปลี่ยนเส้นทางผลลัพธ์ไปยัง `teeth.out`

`@hint`
จำไว้ว่า `> teeth.out` ต้องอยู่ *หลัง* คำสั่งที่สร้างผลลัพธ์

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="คุณได้เปลี่ยนเส้นทางผลลัพธ์ของ `bash teeth.sh` ไปยัง `teeth.out` ด้วย `>` อย่างถูกต้องหรือไม่?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'คุณได้เรียกใช้ `bash` หรือไม่?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'คุณได้รันไฟล์ `teeth.sh` หรือไม่?'),
      has_code(">\s+teeth.out", incorrect_msg = 'คุณได้เปลี่ยนเส้นทางไปยังไฟล์ `teeth.out` หรือไม่?')
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
รัน `cat teeth.out` เพื่อตรวจสอบผลลัพธ์

`@hint`
พิมพ์อักขระแรกสองสามตัวของชื่อไฟล์ แล้วกดปุ่ม Tab เพื่อให้ระบบเติมชื่อให้อัตโนมัติ

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
      has_code("cat", incorrect_msg = 'คุณเรียกใช้ `cat` หรือไม่?'),
      has_code("teeth.out", incorrect_msg = 'คุณระบุไฟล์ `teeth.out` หรือไม่?')
    )
  )
)
Ex().success_msg("ยอดเยี่ยม! ในตอนแรกสิ่งเหล่านี้อาจดูเหมือนถูกสร้างขึ้นมาโดยไม่จำเป็น แต่สิ่งที่ดีคือคุณกำลังทำให้ขั้นตอนการทำงานของคุณเป็นแบบอัตโนมัติทีละขั้นตอน ซึ่งเป็นสิ่งที่มีประโยชน์อย่างมากในฐานะนักวิทยาศาสตร์ข้อมูล!")
```

---

## จะส่งชื่อไฟล์ให้สคริปต์ได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

สคริปต์ที่ประมวลผลไฟล์เฉพาะเจาะจงมีประโยชน์ในฐานะบันทึกสิ่งที่ทำไป แต่สคริปต์ที่ให้ประมวลผลไฟล์ใดก็ได้ตามต้องการนั้นมีประโยชน์มากกว่า
เพื่อรองรับสิ่งนี้ สามารถใช้นิพจน์พิเศษ `$@` (เครื่องหมายดอลลาร์ตามด้วยเครื่องหมาย at ทันที)
ซึ่งหมายถึง "พารามิเตอร์ทั้งหมดที่ส่งให้สคริปต์ผ่าน command line"

ตัวอย่างเช่น หาก `unique-lines.sh` มีเนื้อหาว่า `sort $@ | uniq` เมื่อรันคำสั่งนี้:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

เชลล์จะแทนที่ `$@` ด้วย `seasonal/summer.csv` และประมวลผลไฟล์เดียว แต่ถ้ารันคำสั่งนี้:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

ก็จะประมวลผลไฟล์ข้อมูลสองไฟล์ และสามารถเพิ่มได้เรื่อย ๆ

_เตือนความจำ: หากต้องการบันทึกสิ่งที่เขียนใน Nano ให้พิมพ์ `Ctrl` + `O` เพื่อเขียนไฟล์ จากนั้นกด Enter เพื่อยืนยันชื่อไฟล์ แล้วกด `Ctrl` + `X` เพื่อออกจากตัวแก้ไข_

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
แก้ไขสคริปต์ `count-records.sh` ด้วย Nano และเติมช่องว่าง `____` ทั้งสองแห่ง
ด้วย `$@` และ `-l` (_ตัวอักษร_) ตามลำดับ เพื่อให้สคริปต์นับจำนวนบรรทัดในไฟล์หนึ่งไฟล์หรือมากกว่า
โดยไม่นับบรรทัดแรกของแต่ละไฟล์

`@hint`
* ใช้ `nano count-records.sh` เพื่อแก้ไขไฟล์
* ตรวจสอบให้แน่ใจว่าระบุ _ตัวอักษร_ `-l` ไม่ใช่ตัวเลข 1

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="คุณได้แทนที่ช่องว่างอย่างถูกต้องหรือไม่ เพื่อให้คำสั่งใน `count-records.sh` อ่านว่า `tail -q -n +2 $@ | wc -l`? ใช้ `nano count-records.sh` อีกครั้งเพื่อทำการเปลี่ยนแปลงที่จำเป็น"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/count-records.sh').\
        has_code('tail\s+-q\s+-n\s+\+2\s+\$\@\s+\|\s+wc\s+-l', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: d0da324516
xp: 50
```

`@instructions`
รัน `count-records.sh` กับ `seasonal/*.csv`
แล้วเปลี่ยนเส้นทางผลลัพธ์ไปยัง `num-records.out` โดยใช้ `>`

`@hint`
ใช้ `>` เพื่อเปลี่ยนเส้นทางผลลัพธ์

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
      has_code("bash", incorrect_msg = 'คุณเรียกใช้ `bash` หรือไม่?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'คุณรันไฟล์ `count-records.sh` หรือไม่?'),
      has_code("seasonal/\*", incorrect_msg = 'คุณระบุไฟล์ที่ต้องการประมวลผลด้วย `seasonal/*` หรือไม่?'),
      has_code(">\s+num-records.out", incorrect_msg = 'คุณเปลี่ยนเส้นทางไปยังไฟล์ `num-records.out` หรือไม่?')
    )
  )
)
Ex().success_msg("ทำได้ดีมาก! ทักษะการใช้เชลล์ของคุณกำลังพัฒนาขึ้นเรื่อยๆ!")
```

---

## การประมวลผลอาร์กิวเมนต์เดี่ยวทำได้อย่างไร?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

นอกจาก `$@` แล้ว
เชลล์ยังให้ใช้ `$1`, `$2` และอื่น ๆ เพื่ออ้างอิงพารามิเตอร์บรรทัดคำสั่งแต่ละตัวได้โดยตรง
สามารถนำไปใช้เขียนคำสั่งที่ดูเรียบง่ายและเป็นธรรมชาติมากขึ้น
ตัวอย่างเช่น สร้างสคริปต์ชื่อ `column.sh` สำหรับเลือกคอลัมน์เดียวจากไฟล์ CSV
โดยให้ผู้ใช้ระบุชื่อไฟล์เป็นพารามิเตอร์แรก และระบุคอลัมน์เป็นพารามิเตอร์ที่สอง:

```{shell}
cut -d , -f $2 $1
```

จากนั้นรันด้วยคำสั่ง:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

สังเกตว่าสคริปต์ใช้พารามิเตอร์ทั้งสองในลำดับที่สลับกัน

<hr>

สคริปต์ `get-field.sh` ถูกออกแบบมาให้รับชื่อไฟล์,
หมายเลขแถวที่ต้องการเลือก,
หมายเลขคอลัมน์ที่ต้องการเลือก,
แล้วแสดงเฉพาะฟิลด์นั้นจากไฟล์ CSV
ตัวอย่างเช่น:

```
bash get-field.sh seasonal/summer.csv 4 2
```

ควรเลือกฟิลด์ที่สองจากบรรทัดที่ 4 ของ `seasonal/summer.csv`
ควรใส่คำสั่งใดลงใน `get-field.sh` เพื่อให้ได้ผลลัพธ์นั้น?

`@hint`
จำไว้ว่าพารามิเตอร์บรรทัดคำสั่งจะถูกนับจากซ้ายไปขวา

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- ไม่ใช่: คำสั่งนี้จะพยายามใช้ชื่อไฟล์เป็นจำนวนบรรทัดที่จะเลือกด้วย `head`
- ถูกต้อง!
- ไม่ใช่: คำสั่งนี้จะสลับการใช้หมายเลขคอลัมน์กับหมายเลขบรรทัด
- ไม่ใช่: คำสั่งนี้จะสลับการใช้หมายเลขฟิลด์กับชื่อไฟล์

---

## Shell script หนึ่งไฟล์ทำงานได้หลายอย่างได้อย่างไร?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Shell script ที่ผ่านมามีคำสั่งหรือ pipe เพียงชุดเดียว แต่ script หนึ่งไฟล์สามารถมีคำสั่งได้หลายบรรทัด ตัวอย่างเช่น สามารถสร้าง script ที่บอกจำนวนระเบียนในไฟล์ข้อมูลที่สั้นที่สุดและยาวที่สุด นั่นคือช่วงความยาวของชุดข้อมูลทั้งหมด

ใน Nano การ "คัดลอกและวาง" ทำได้โดยเลื่อนไปยังบรรทัดที่ต้องการคัดลอก กด `CTRL` + `K` เพื่อตัดบรรทัด จากนั้นกด `CTRL` + `U` สองครั้งเพื่อวางสำเนาสองชุด

_เป็นการเตือนความจำ: หากต้องการบันทึกสิ่งที่เขียนใน Nano ให้กด `Ctrl` + `O` เพื่อเขียนไฟล์ออก จากนั้นกด Enter เพื่อยืนยันชื่อไฟล์ แล้วกด `Ctrl` + `X` เพื่อออกจาก editor_

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
ใช้ Nano แก้ไข script `range.sh`
แล้วแทนที่ตัวแทน `____` ทั้งสอง
ด้วย `$@` และ `-v`
เพื่อให้แสดงชื่อและจำนวนบรรทัดของไฟล์ทั้งหมดที่ระบุผ่าน command line
*โดยไม่* แสดงจำนวนบรรทัดรวมของทุกไฟล์
(ไม่ต้องหักบรรทัด header ของคอลัมน์ออกจากไฟล์)

`@hint`
ใช้ `wc -l $@` เพื่อนับจำนวนบรรทัดในไฟล์ทั้งหมดที่ระบุผ่าน command line

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="คุณได้แทนที่ช่องว่างอย่างถูกต้องแล้วหรือไม่ เพื่อให้คำสั่งใน `range.sh` อ่านว่า `wc -l $@ | grep -v total`? ใช้ `nano range.sh` อีกครั้งเพื่อทำการเปลี่ยนแปลงที่จำเป็น"
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
ใช้ Nano เพิ่ม `sort -n` และ `head -n 1` ตามลำดับนั้น
เข้าไปใน pipeline ใน `range.sh`
เพื่อแสดงชื่อและจำนวนบรรทัดของไฟล์ที่สั้นที่สุดที่ส่งเข้ามา

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="คุณได้เพิ่ม `sort -n` และ `head -n 1` พร้อมกับ pipes ลงในไฟล์ `range.sh` แล้วหรือไม่? กรุณาใช้ `nano range.sh` อีกครั้งเพื่อทำการเปลี่ยนแปลงที่จำเป็น"
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
ใช้ Nano เพิ่มบรรทัดที่สองใน `range.sh` เพื่อแสดงชื่อและจำนวนระเบียนของ
ไฟล์ที่ *ยาวที่สุด* ในไดเรกทอรี *พร้อมกับ* ไฟล์ที่สั้นที่สุดด้วย
บรรทัดนี้ควรเป็นสำเนาของบรรทัดที่เขียนไปแล้ว
แต่ใช้ `sort -n -r` แทน `sort -n`

`@hint`
คัดลอกบรรทัดแรก แล้วเปลี่ยนลำดับการเรียงข้อมูล

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="คงบรรทัดแรกในไฟล์ `range.sh` ไว้: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="คุณได้ทำการคัดลอกบรรทัดแรกในไฟล์ `range.sh` และแก้ไขเล็กน้อยหรือไม่? ใช้ `sort -n -r` แทน `sort -n`!"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').multi(
        has_code("wc -l $@ | grep -v total | sort -n | head -n 1", fixed=True, incorrect_msg = msg1),
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
รัน script กับไฟล์ในไดเรกทอรี `seasonal`
โดยใช้ `seasonal/*.csv` เพื่อจับคู่ไฟล์ทั้งหมด
แล้วเปลี่ยนทิศทางผลลัพธ์โดยใช้ `>`
ไปยังไฟล์ชื่อ `range.out` ในโฮมไดเรกทอรีของคุณ

`@hint`
ใช้ `bash range.sh` เพื่อรัน script, `seasonal/*.csv` เพื่อระบุไฟล์ และ `> range.out` เพื่อเปลี่ยนทิศทางผลลัพธ์

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="คุณได้เปลี่ยนเส้นทางผลลัพธ์ของ `bash range.sh seasonal/*.csv` ไปยัง `range.out` ด้วย `>` อย่างถูกต้องหรือไม่?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'คุณได้เรียกใช้ `bash` หรือไม่?'),
has_code("bash\s+range.sh", incorrect_msg = 'คุณได้รันไฟล์ `range.sh` หรือไม่?'),
has_code("seasonal/\*", incorrect_msg = 'คุณได้ระบุไฟล์ที่ต้องการประมวลผลด้วย `seasonal/*` หรือไม่?'),
has_code(">\s+range.out", incorrect_msg = 'คุณได้เปลี่ยนเส้นทางไปยังไฟล์ `range.out` หรือไม่?')
)
)

Ex().success_msg("ดำเนินการได้ดีมาก โปรดไปยังแบบฝึกหัดถัดไปเพื่อเรียนรู้เกี่ยวกับการเขียนลูป!")
```

---

## จะเขียนลูปในเชลล์สคริปต์ได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

เชลล์สคริปต์สามารถมีลูปได้เช่นกัน สามารถเขียนโดยใช้เซมิโคลอนคั่น หรือจะแยกเป็นหลายบรรทัดโดยไม่ใช้เซมิโคลอนก็ได้ เพื่อให้อ่านง่ายขึ้น:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(ไม่จำเป็นต้องย่อหน้าคำสั่งภายในลูป แต่การย่อหน้าจะช่วยให้โค้ดอ่านง่ายขึ้น)

บรรทัดแรกของสคริปต์นี้คือ **คอมเมนต์** ที่บอกให้ผู้อ่านรู้ว่าสคริปต์ทำอะไร คอมเมนต์เริ่มต้นด้วยอักขระ `#` และมีผลถึงท้ายบรรทัด การเพิ่มคำอธิบายสั้น ๆ แบบนี้ไว้ในทุกสคริปต์ที่เขียนจะเป็นประโยชน์มากในอนาคต

_ขอเตือนว่า หากต้องการบันทึกสิ่งที่เขียนใน Nano ให้กด `Ctrl` + `O` เพื่อบันทึกไฟล์ จากนั้นกด Enter เพื่อยืนยันชื่อไฟล์ แล้วกด `Ctrl` + `X` เพื่อออกจากโปรแกรมแก้ไข_

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/date-range-start.sh', '/home/repl/date-range.sh')
```

***

```yaml
type: ConsoleExercise
key: 8ca2adb6c4
xp: 35
```

`@instructions`
เติมตัวแทนที่ว่างในสคริปต์ `date-range.sh`
ด้วย `$filename` (สองครั้ง), `head` และ `tail`
เพื่อให้สคริปต์แสดงวันที่แรกและวันที่สุดท้ายจากไฟล์อย่างน้อยหนึ่งไฟล์

`@hint`
อย่าลืมใช้ `$filename` เพื่อดึงค่าปัจจุบันของตัวแปรลูป

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="ใน `date-range.sh` คุณได้เปลี่ยนบรรทัด %s ในลูปเป็น `%s` หรือไม่? ใช้ `nano date-range.sh` เพื่อทำการเปลี่ยนแปลง"
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('แรก', cmdpatt%'head')
msg2=msgpatt%('ที่สอง', cmdpatt%'tail')
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
รัน `date-range.sh` กับไฟล์ข้อมูลตามฤดูกาลทั้งสี่ไฟล์
โดยใช้ `seasonal/*.csv` เพื่อจับคู่ชื่อไฟล์

`@hint`
นิพจน์ wildcard ควรขึ้นต้นด้วยชื่อไดเรกทอรี

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
      has_code("bash", incorrect_msg = 'คุณเรียกใช้ `bash` หรือไม่?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'คุณรันไฟล์ `date-range.sh` หรือไม่?'),
      has_code("seasonal/\*", incorrect_msg = 'คุณระบุไฟล์ที่ต้องการประมวลผลด้วย `seasonal/*` หรือไม่?')
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
รัน `date-range.sh` กับไฟล์ข้อมูลตามฤดูกาลทั้งสี่ไฟล์โดยใช้ `seasonal/*.csv` เพื่อจับคู่ชื่อไฟล์
แล้ว pipe ผลลัพธ์ไปยัง `sort` เพื่อดูว่าสคริปต์ที่เขียนสามารถใช้งานได้เหมือนกับคำสั่งในตัวของ Unix

`@hint`
ใช้นิพจน์ wildcard เดิมที่ใช้ไปก่อนหน้านี้

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
      has_code("bash", incorrect_msg = 'คุณเรียกใช้ `bash` หรือไม่?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'คุณรันไฟล์ `date-range.sh` หรือไม่?'),
      has_code("seasonal/\*", incorrect_msg = 'คุณระบุไฟล์ที่ต้องการประมวลผลด้วย `seasonal/*` หรือไม่?'),
      has_code("|", incorrect_msg = 'คุณใช้ pipe จากผลลัพธ์ของสคริปต์ไปยัง `sort` หรือไม่?'),
      has_code("sort", incorrect_msg = 'คุณเรียกใช้ `sort` หรือไม่?')
    )
  )
)
Ex().success_msg("วิเศษมาก! โปรดสังเกตว่าสิ่งต่าง ๆ ที่เราได้เรียนรู้มานั้นสามารถนำมาประกอบกันได้อย่างไร")
```

---

## จะเกิดอะไรขึ้นเมื่อไม่ระบุชื่อไฟล์?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

ข้อผิดพลาดที่พบบ่อยใน shell script (และการใช้คำสั่งแบบโต้ตอบ) คือการวางชื่อไฟล์ผิดตำแหน่ง
หากพิมพ์:

```{shell}
tail -n 3
```

เนื่องจาก `tail` ไม่ได้รับชื่อไฟล์ใดๆ ระบบจะรอรับข้อมูลจากคีย์บอร์ดแทน
นั่นหมายความว่าหากพิมพ์:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

`tail` จะแสดง 3 บรรทัดสุดท้ายของ `somefile.txt` ตามปกติ แต่ `head` จะรอรับข้อมูลจากคีย์บอร์ดไปเรื่อยๆ เพราะไม่ได้รับชื่อไฟล์และไม่มีคำสั่งใดส่งข้อมูลมาให้ใน pipeline

<hr>

สมมติว่าพิมพ์คำสั่งนี้โดยไม่ตั้งใจ:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

ควรทำอย่างไรต่อไป?

`@possible_answers`
- รอ 10 วินาทีเพื่อให้ `head` หมดเวลา
- พิมพ์ `somefile.txt` แล้วกด Enter เพื่อส่งข้อมูลให้ `head`
- ใช้ `Ctrl` + `C` เพื่อหยุดการทำงานของ `head`

`@hint`
`head` จะทำอะไรถ้าไม่มีชื่อไฟล์ระบุและไม่มีคำสั่งใดอยู่ก่อนหน้าใน pipeline?

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

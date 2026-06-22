---
title: การรวมเครื่องมือ
description: >-
  พลังที่แท้จริงของ Unix shell ไม่ได้อยู่ที่คำสั่งแต่ละคำสั่ง
  แต่อยู่ที่การนำคำสั่งเหล่านั้นมาผสมผสานกันได้อย่างง่ายดาย
  บทนี้จะแสดงวิธีใช้ความสามารถนี้เพื่อเลือกข้อมูลที่ต้องการ
  และแนะนำคำสั่งสำหรับเรียงลำดับค่าและลบข้อมูลซ้ำ
lessons:
  - nb_of_exercises: 12
    title: วิธีบันทึกผลลัพธ์ของคำสั่งลงในไฟล์
---

## จะบันทึกผลลัพธ์ของคำสั่งลงในไฟล์ได้อย่างไร?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

เครื่องมือทุกตัวที่เคยใช้มาช่วยให้ระบุชื่อไฟล์อินพุตได้
ส่วนใหญ่ไม่มีตัวเลือกสำหรับระบุชื่อไฟล์เอาต์พุต เพราะไม่จำเป็นต้องใช้
แต่สามารถใช้ **การเปลี่ยนเส้นทาง (redirection)** เพื่อบันทึกผลลัพธ์ของคำสั่งใดก็ได้ไปยังที่ที่ต้องการ
ลองรันคำสั่งนี้:

```{shell}
head -n 5 seasonal/summer.csv
```

คำสั่งนี้จะแสดง 5 บรรทัดแรกของข้อมูลฤดูร้อนบนหน้าจอ
แต่ถ้ารันคำสั่งนี้แทน:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

จะไม่มีอะไรปรากฏบนหน้าจอ
แต่ผลลัพธ์ของ `head` จะถูกบันทึกลงในไฟล์ใหม่ชื่อ `top.csv`
ดูเนื้อหาของไฟล์นั้นได้โดยใช้ `cat`:

```{shell}
cat top.csv
```

เครื่องหมาย `>` บอก shell ให้เปลี่ยนเส้นทางผลลัพธ์ของ `head` ไปยังไฟล์
มันไม่ใช่ส่วนหนึ่งของคำสั่ง `head` แต่ใช้ได้กับทุกคำสั่ง shell ที่มีการแสดงผลลัพธ์

`@instructions`
ใช้ `tail` ร่วมกับการเปลี่ยนเส้นทางเพื่อบันทึก 5 บรรทัดสุดท้ายของ `seasonal/winter.csv` ลงในไฟล์ชื่อ `last.csv`

`@hint`
ใช้ `tail -n 5` เพื่อดึง 5 บรรทัดสุดท้าย

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "บรรทัด `%s` ควรอยู่ในไฟล์ `last.csv` แต่ไม่พบบรรทัดดังกล่าว กรุณาเปลี่ยนเส้นทางผลลัพธ์ของ `tail -n 5 seasonal/winter.csv` ไปยัง `last.csv` ด้วย `>`"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` มีบรรทัดมากเกินไป ท่านได้ใช้แฟล็ก `-n 5` กับ `tail` หรือไม่?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("ยอดเยี่ยม! มาฝึกฝนเพิ่มเติมกันต่อเลย!")
```

---

## จะใช้ผลลัพธ์ของคำสั่งเป็น input ได้อย่างไร?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

สมมติว่าต้องการดึงบรรทัดจากช่วงกลางของไฟล์
โดยเฉพาะอย่างยิ่ง สมมติว่าต้องการดึงบรรทัดที่ 3-5 จากไฟล์ข้อมูลของเรา
เริ่มต้นได้โดยใช้ `head` เพื่อดึง 5 บรรทัดแรก
แล้ว redirect ผลลัพธ์ไปยังไฟล์
จากนั้นใช้ `tail` เพื่อเลือก 3 บรรทัดสุดท้าย:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

ตรวจสอบดูแล้วจะพบว่านี่คือบรรทัดที่ 3-5 ของไฟล์ต้นฉบับ
เพราะเป็น 3 บรรทัดสุดท้ายของ 5 บรรทัดแรกนั่นเอง

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 35bbb5520e
xp: 50
```

`@instructions`
เลือก 2 บรรทัดสุดท้ายจาก `seasonal/winter.csv`
แล้วบันทึกลงในไฟล์ชื่อ `bottom.csv`

`@hint`
ใช้ `tail` เพื่อเลือกบรรทัด และใช้ `>` เพื่อ redirect ผลลัพธ์ของ `tail`

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="บรรทัด `%s` ควรอยู่ในไฟล์ `bottom.csv` แต่ไม่พบ โปรดเปลี่ยนเส้นทางผลลัพธ์ของ `tail -n 2 seasonal/winter.csv` ไปยัง `bottom.csv` ด้วย `>`"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` มีบรรทัดมากเกินไป คุณใช้แฟล็ก `-n 2` กับ `tail` หรือไม่?'),
        has_code('2017-08-11,wisdom', incorrect_msg=patt%"2017-08-11,wisdom"),
        has_code('2017-08-13,canine', incorrect_msg=patt%"2017-08-13,canine")
    )
)
```

***

```yaml
type: ConsoleExercise
key: c94d3936a7
xp: 50
```

`@instructions`
เลือกบรรทัดแรกจาก `bottom.csv`
เพื่อดึงบรรทัดที่สองจากท้ายของไฟล์ต้นฉบับ

`@hint`
ใช้ `head` เพื่อเลือกบรรทัดที่ต้องการ

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="มีบางอย่างผิดพลาดกับไฟล์ `bottom.csv` กรุณาตรวจสอบว่าท่านไม่ได้แก้ไขไฟล์ดังกล่าว!"),
    has_expr_output(strict=True, incorrect_msg="ท่านได้ใช้คำสั่ง `head` กับไฟล์ `bottom.csv` อย่างถูกต้องหรือไม่? กรุณาตรวจสอบว่าท่านใช้แฟล็ก `-n` อย่างถูกต้อง")
)

Ex().success_msg("ยินดีด้วย กรุณาดำเนินการไปยังแบบฝึกหัดถัดไปเพื่อเรียนรู้เกี่ยวกับวิธีที่ดีกว่าในการรวมคำสั่งต่างๆ")
```

---

## มีวิธีที่ดีกว่าในการรวมคำสั่งไหม?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

การใช้การเปลี่ยนเส้นทางเพื่อรวมคำสั่งมีข้อเสีย 2 ประการ:

1. ทิ้งไฟล์ขั้นกลางไว้จำนวนมาก (เช่น `top.csv`)
2. คำสั่งที่ใช้สร้างผลลัพธ์สุดท้ายกระจายอยู่หลายบรรทัดในประวัติคำสั่ง

เชลล์มีเครื่องมืออีกตัวที่แก้ปัญหาทั้งสองนี้ได้พร้อมกัน เรียกว่า **pipe**
ลองเริ่มต้นด้วยการรัน `head` ก่อน:

```{shell}
head -n 5 seasonal/summer.csv
```

แทนที่จะส่งผลลัพธ์ของ `head` ไปยังไฟล์ ให้เพิ่มแถบแนวตั้งแล้วตามด้วยคำสั่ง `tail` *โดยไม่ต้องระบุชื่อไฟล์*:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

สัญลักษณ์ pipe บอกให้เชลล์นำผลลัพธ์จากคำสั่งทางซ้ายไปใช้เป็นข้อมูลนำเข้าของคำสั่งทางขวา

`@instructions`
ใช้ `cut` เพื่อดึงชื่อฟันทั้งหมดจากคอลัมน์ที่ 2 ของไฟล์ที่คั่นด้วยจุลภาค `seasonal/summer.csv` จากนั้น pipe ผลลัพธ์ไปยัง `grep` โดยใช้การจับคู่แบบกลับด้าน เพื่อกรองบรรทัดส่วนหัวที่มีคำว่า "Tooth" ออก *`cut` และ `grep` ได้อธิบายโดยละเอียดในบทที่ 2 แบบฝึกหัดที่ 8 และ 11 ตามลำดับ*

`@hint`
- ส่วนแรกของคำสั่งมีรูปแบบ `cut -d field_delimiter -f column_number filename`
- ส่วนที่สองของคำสั่งมีรูปแบบ `grep -v thing_to_match`

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg = 'คุณได้ใช้ไปป์ผลลัพธ์ของ `cut -d , -f 2 seasonal/summer.csv` ไปยัง `grep -v Tooth` ด้วย `|` หรือไม่?'),
    check_not(has_output("Tooth"), incorrect_msg = 'คุณได้ยกเว้นบรรทัดส่วนหัว `"Tooth"` โดยใช้ `grep` หรือไม่?')
)
Ex().success_msg("การใช้ไปป์สมบูรณ์แบบมาก! นี่อาจเป็นครั้งแรกที่คุณใช้ `|` แต่แน่นอนว่าจะไม่ใช่ครั้งสุดท้าย!")
```

---

## จะรวมคำสั่งหลายคำสั่งเข้าด้วยกันได้อย่างไร?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

สามารถเชื่อมคำสั่งต่อกันได้กี่คำสั่งก็ได้
ตัวอย่างเช่น
คำสั่งนี้:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

จะทำงานดังนี้:

1. เลือกคอลัมน์แรกจากข้อมูล spring;
2. ลบบรรทัดส่วนหัวที่มีคำว่า "Date" ออก; และ
3. เลือก 10 บรรทัดแรกของข้อมูลจริง

`@instructions`
ในแบบฝึกหัดที่แล้ว คุณใช้คำสั่งต่อไปนี้เพื่อเลือกชื่อฟันทั้งหมดจากคอลัมน์ 2 ของ `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

ต่อยอด pipeline นี้ด้วยคำสั่ง `head` เพื่อเลือกเฉพาะชื่อฟันแรกสุดเพียงรายการเดียว

`@hint`
คัดลอกและวางโค้ดในคำแนะนำ จากนั้นต่อท่อ แล้วเรียกใช้ `head` พร้อมแฟล็ก `-n`

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth | head -n 1
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    # for some reason has_expr_output with strict=True does not work here...
    has_output('^\s*canine\s*$', incorrect_msg = "คุณได้ใช้ `|` เพื่อต่อท่อส่งข้อมูลด้วยคำสั่ง `head` หรือไม่? กรุณาตรวจสอบให้แน่ใจว่าได้ตั้งค่าแฟล็ก `-n` อย่างถูกต้อง"),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "คุณได้ใช้ `|` เพื่อต่อท่อส่งข้อมูลด้วยคำสั่ง `head` หรือไม่?")
)
Ex().success_msg("ยอดเยี่ยมมากสำหรับการเชื่อมต่อคำสั่ง! ด้วยการเชื่อมต่อคำสั่งหลายคำสั่งเข้าด้วยกัน คุณสามารถสร้างท่อส่งข้อมูลสำหรับการจัดการข้อมูลที่มีประสิทธิภาพได้")
```

---

## นับจำนวนระเบียนในไฟล์ได้อย่างไร?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

คำสั่ง `wc` (ย่อมาจาก "word count") แสดงจำนวน**ตัวอักษร** **คำ** และ**บรรทัด**ในไฟล์
สามารถให้แสดงเฉพาะค่าใดค่าหนึ่งได้โดยใช้ `-c`, `-w`, หรือ `-l` ตามลำดับ

`@instructions`
นับจำนวนระเบียนใน `seasonal/spring.csv` ที่มีวันที่อยู่ในเดือนกรกฎาคม 2017 (`2017-07`)
- ให้ใช้ `grep` พร้อมวันที่บางส่วนเพื่อกรองบรรทัดที่ต้องการ แล้วส่งผลลัพธ์ผ่านไปป์ไปยัง `wc` พร้อมแฟล็กที่เหมาะสมเพื่อนับจำนวนบรรทัด

`@hint`
- ใช้ `head seasonal/spring.csv` เพื่อดูรูปแบบวันที่
- ส่วนแรกของคำสั่งมีรูปแบบเป็น `grep thing_to_match filename`
- หลังไปป์ `|` ให้เรียกใช้ `wc` พร้อมกับแฟล็ก `-l`

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
grep 2017-07 seasonal/spring.csv | wc -l
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("grep", incorrect_msg = "คุณเรียกใช้ `grep` หรือไม่?"),
      has_code("2017-07", incorrect_msg = "คุณค้นหา `2017-07` หรือไม่?"),
      has_code("seasonal/spring.csv", incorrect_msg = "คุณค้นหาในไฟล์ `seasonal/spring.csv` หรือไม่?"),
      has_code("|", incorrect_msg = "คุณใช้ `|` เพื่อส่งต่อไปยัง `wc` หรือไม่?"),      
      has_code("wc", incorrect_msg = "คุณเรียกใช้ `wc` หรือไม่?"),
      has_code("-l", incorrect_msg = "คุณนับจำนวนบรรทัดด้วย `-l` หรือไม่?")
    )
  )
)
Ex().success_msg("นับได้อย่างระมัดระวัง! การตรวจสอบปริมาณข้อมูลที่มีอยู่เป็นขั้นตอนแรกที่ดีเยี่ยมในการวิเคราะห์ข้อมูลใดๆ")
```

---

## จะระบุไฟล์หลายไฟล์พร้อมกันได้อย่างไร?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

คำสั่ง shell ส่วนใหญ่สามารถทำงานกับหลายไฟล์พร้อมกันได้ เพียงระบุชื่อไฟล์หลายชื่อ
ตัวอย่างเช่น สามารถดึงคอลัมน์แรกจากไฟล์ข้อมูลตามฤดูกาลทั้งหมดได้ในคำสั่งเดียว ดังนี้:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

แต่การพิมพ์ชื่อไฟล์ซ้ำแล้วซ้ำเล่าเป็นเรื่องที่ไม่สะดวกนัก เพราะเสียเวลา และอาจเผลอลืมไฟล์บางตัวหรือพิมพ์ชื่อซ้ำโดยไม่ตั้งใจ
เพื่อแก้ปัญหานี้ shell อนุญาตให้ใช้ **wildcards** เพื่อระบุรายการไฟล์ด้วยนิพจน์เดียว
 wildcard ที่ใช้บ่อยที่สุดคือ `*` ซึ่งหมายถึง "จับคู่กับอักขระศูนย์ตัวหรือมากกว่า"
ด้วยวิธีนี้ สามารถย่อคำสั่ง `cut` ข้างต้นให้สั้นลงได้เป็น:

```{shell}
cut -d , -f 1 seasonal/*
```

หรือ:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
เขียนคำสั่งเดียวโดยใช้ `head` เพื่อดึง 3 บรรทัดแรกจากทั้ง `seasonal/spring.csv` และ `seasonal/summer.csv` รวมเป็นข้อมูล 6 บรรทัด โดย *ไม่* รวมไฟล์ฤดูใบไม้ร่วงหรือฤดูหนาว
ให้ใช้ wildcard แทนการพิมพ์ชื่อไฟล์แบบเต็ม

`@hint`
- คำสั่งมีรูปแบบเป็น `head -n number_of_lines filename_pattern`
- ตัวอย่างเช่น หากต้องการจับคู่ไฟล์ในไดเรกทอรี `a` ที่ขึ้นต้นด้วย `b` ให้ใช้ `a/b*`

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
head -n 3 seasonal/s* # ...or seasonal/s*.csv, or even s*/s*.csv
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg = "คุณสามารถใช้ `seasonal/s*` เพื่อเลือก `seasonal/spring.csv` และ `seasonal/summer.csv` โปรดตรวจสอบให้แน่ใจว่าแสดงเฉพาะสามบรรทัดแรกของแต่ละไฟล์โดยใช้แฟล็ก `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "อย่าแสดงผลลัพธ์สำหรับ `seasonal/autumn.csv` คุณสามารถใช้ `seasonal/s*` เพื่อเลือก `seasonal/spring.csv` และ `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "อย่าแสดงผลลัพธ์สำหรับ `seasonal/winter.csv` คุณสามารถใช้ `seasonal/s*` เพื่อเลือก `seasonal/spring.csv` และ `seasonal/summer.csv`")
)
Ex().success_msg("ยอดเยี่ยมมากกับการใช้ไวลด์การ์ด! สิ่งนี้มีความสำคัญมากยิ่งขึ้นหากไดเรกทอรีของคุณมีไฟล์หลายร้อยหรือหลายพันไฟล์")
```

---

## Wildcard อื่น ๆ ที่ใช้ได้มีอะไรบ้าง?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Shell ยังมี wildcard อื่น ๆ อีก แม้จะพบได้น้อยกว่า:

- `?` จับคู่กับอักขระเพียงตัวเดียว เช่น `201?.txt` จะตรงกับ `2017.txt` หรือ `2018.txt` แต่ไม่ตรงกับ `2017-01.txt`
- `[...]` จับคู่กับอักขระตัวใดก็ได้ที่อยู่ในวงเล็บเหลี่ยม เช่น `201[78].txt` จะตรงกับ `2017.txt` หรือ `2018.txt` แต่ไม่ตรงกับ `2016.txt`
- `{...}` จับคู่กับรูปแบบใดก็ได้ที่คั่นด้วยเครื่องหมายจุลภาคภายในวงเล็บปีกกา เช่น `{*.txt, *.csv}` จะตรงกับไฟล์ที่ชื่อลงท้ายด้วย `.txt` หรือ `.csv` แต่ไม่ตรงกับไฟล์ที่ลงท้ายด้วย `.pdf`

<hr/>

นิพจน์ใดที่จับคู่กับ `singh.pdf` และ `johel.txt` แต่ *ไม่* ตรงกับ `sandhu.pdf` หรือ `sandhu.txt`?

`@hint`
ลองจับคู่แต่ละนิพจน์กับชื่อไฟล์ทีละรายการ

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- ไม่ใช่: `.pdf` และ `.txt` ไม่ใช่ชื่อไฟล์
- ไม่ใช่: นิพจน์นี้จะจับคู่กับ `sandhu.pdf` ด้วย
- ไม่ใช่: นิพจน์ในวงเล็บเหลี่ยมจะจับคู่ได้แค่อักขระเดียว ไม่ใช่ทั้งคำ
- ถูกต้อง!

---

## การเรียงลำดับบรรทัดข้อความทำได้อย่างไร?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

ตามชื่อที่บอกไว้
`sort` ใช้สำหรับเรียงลำดับข้อมูล
โดยค่าเริ่มต้นจะเรียงตามตัวอักษรจากน้อยไปมาก
แต่สามารถใช้แฟล็ก `-n` เพื่อเรียงตามตัวเลข และ `-r` เพื่อกลับลำดับผลลัพธ์
ส่วน `-b` จะละเว้นช่องว่างนำหน้า
และ `-f` จะทำให้ไม่แยกตัวพิมพ์ใหญ่-เล็ก (**f**old case)
ใน pipeline มักใช้ `grep` เพื่อกรองข้อมูลที่ไม่ต้องการออก แล้วตามด้วย `sort` เพื่อเรียงลำดับข้อมูลที่เหลือ

`@instructions`
จำการใช้ `cut` ร่วมกับ `grep` เพื่อดึงชื่อฟันทั้งหมดจากคอลัมน์ที่ 2 ของไฟล์ `seasonal/summer.csv` ได้ไหม?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

จากสูตรนี้ ให้เรียงลำดับชื่อฟันใน `seasonal/winter.csv` (ไม่ใช่ `summer.csv`) ตามตัวอักษรจากมากไปน้อย โดยต่อ pipeline ด้วยขั้นตอน `sort` เพิ่มเข้าไป

`@hint`
คัดลอกและวางคำสั่งในคำแนะนำ จากนั้นเปลี่ยนชื่อไฟล์ เพิ่ม pipe ต่อท้าย แล้วเรียกใช้ `sort` พร้อมแฟล็ก `-r`

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth | sort -r
```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("cut", incorrect_msg = "คุณเรียกใช้ `cut` หรือไม่?"),
      has_code("-d", incorrect_msg = "คุณระบุตัวคั่นฟิลด์ด้วย `-d` หรือไม่?"),
      has_code("seasonal/winter.csv", incorrect_msg = "คุณดึงข้อมูลจากไฟล์ `seasonal/winter.csv` หรือไม่?"),
      has_code("|", incorrect_msg = "คุณใช้ไปป์จาก `cut` ไปยัง `grep` ไปยัง `sort` โดยใช้ `|` หรือไม่?"),      
      has_code("grep", incorrect_msg = "คุณเรียกใช้ `grep` หรือไม่?"),
      has_code("-v", incorrect_msg = "คุณกลับผลการค้นหาด้วย `-v` หรือไม่?"),
      has_code("Tooth", incorrect_msg = "คุณค้นหา `Tooth` หรือไม่?"),
      has_code("sort", incorrect_msg = "คุณเรียกใช้ `sort` หรือไม่?"),
      has_code("-r", incorrect_msg = "คุณกลับลำดับการเรียงด้วย `-r` หรือไม่?")
    )
  )
)
Ex().success_msg("เรียบร้อย! `sort` มีประโยชน์หลายอย่าง ตัวอย่างเช่น การใช้ไปป์ `sort -n` ไปยัง `head` จะแสดงค่าที่มากที่สุด")
```

---

## จะลบบรรทัดที่ซ้ำกันได้อย่างไร?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

คำสั่งที่มักใช้คู่กับ `sort` อีกคำสั่งหนึ่งคือ `uniq`
ซึ่งทำหน้าที่ลบบรรทัดที่ซ้ำกันออก
โดยเฉพาะอย่างยิ่ง จะลบเฉพาะบรรทัดที่ซ้ำกัน*ติดต่อกัน*เท่านั้น
หากไฟล์มีเนื้อหาดังนี้:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

`uniq` จะแสดงผลเป็น:

```
2017-07-03
2017-08-03
```

แต่ถ้าไฟล์มีเนื้อหาดังนี้:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

`uniq` จะแสดงผลทั้ง 4 บรรทัด
เหตุผลคือ `uniq` ถูกออกแบบมาให้ทำงานกับไฟล์ขนาดใหญ่
หากต้องการลบบรรทัดที่ซ้ำกันแม้ไม่ได้อยู่ติดกัน
ก็จำเป็นต้องเก็บข้อมูลทั้งไฟล์ไว้ในหน่วยความจำ
(หรืออย่างน้อยก็ทุกบรรทัดที่ไม่ซ้ำที่เจอมาแล้ว)
การลบเฉพาะบรรทัดที่ซ้ำกันติดต่อกันจึงช่วยให้ต้องเก็บเพียงบรรทัดล่าสุดที่ไม่ซ้ำไว้ในหน่วยความจำเท่านั้น

`@instructions`
เขียน pipeline เพื่อ:

- ดึงคอลัมน์ที่ 2 จาก `seasonal/winter.csv`
- ลบคำว่า "Tooth" ออกจากผลลัพธ์ เพื่อแสดงเฉพาะชื่อฟัน
- เรียงลำดับผลลัพธ์เพื่อให้ชื่อฟันที่เหมือนกันอยู่ติดกัน และ
- แสดงชื่อฟันแต่ละชื่อหนึ่งครั้งพร้อมกับจำนวนครั้งที่ปรากฏ

จุดเริ่มต้นของ pipeline เหมือนกับแบบฝึกหัดก่อนหน้า:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

ต่อด้วยคำสั่ง `sort` แล้วใช้ `uniq -c` เพื่อแสดงบรรทัดที่ไม่ซ้ำพร้อมจำนวนครั้งที่ปรากฏ แทนการใช้ `uniq` และ `wc` แยกกัน

`@hint`
คัดลอกคำสั่งในคำแนะนำ แล้วต่อท่อไปยัง `sort` โดยไม่ใส่ flag จากนั้นต่อท่ออีกครั้งไปยัง `uniq` พร้อม flag `-c`

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth | sort | uniq -c
```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_correct(
        has_expr_output(),
        multi(
            has_code('cut\s+-d\s+,\s+-f\s+2\s+seasonal/winter.csv\s+\|\s+grep\s+-v\s+Tooth',
                     incorrect_msg="คุณควรเริ่มต้นด้วยคำสั่งนี้: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth` แล้วจึงขยายคำสั่งต่อไป"),
            has_code('\|\s+sort', incorrect_msg="คุณได้ขยายคำสั่งด้วย `| sort` แล้วหรือไม่?"),
            has_code('\|\s+uniq', incorrect_msg="คุณได้ขยายคำสั่งด้วย `| uniq` แล้วหรือไม่?"),
            has_code('-c', incorrect_msg="คุณได้ระบุการนับจำนวนด้วย `-c` แล้วหรือไม่?")
        )
    )
)
Ex().success_msg("ยอดเยี่ยม! หลังจากที่ได้ทำงานกับ pipe มามากขนาดนี้ คงจะดีไม่น้อยหากเราสามารถจัดเก็บผลลัพธ์ได้ใช่ไหม?")
```

---

## จะบันทึกผลลัพธ์ของ pipe ได้อย่างไร?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

เชลล์ช่วยให้เราเปลี่ยนเส้นทางผลลัพธ์ของคำสั่งที่ต่อกันด้วย pipe ได้:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

อย่างไรก็ตาม `>` ต้องอยู่ที่ท้ายสุดของ pipeline เสมอ:
ถ้าลองวางไว้กลาง pipeline แบบนี้:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

ผลลัพธ์ทั้งหมดจาก `cut` จะถูกเขียนลงไฟล์ `teeth-only.txt`
ทำให้ไม่มีข้อมูลเหลือส่งต่อไปให้ `grep`
และ `grep` จะรอรับข้อมูลอยู่อย่างนั้นไม่สิ้นสุด

<hr>

จะเกิดอะไรขึ้นถ้าวาง redirection ไว้ที่ต้นของ pipeline แบบนี้:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [ผลลัพธ์ของคำสั่งจะถูกเปลี่ยนเส้นทางไปยังไฟล์ตามปกติ]
- เชลล์แจ้งข้อผิดพลาด
- เชลล์รอรับข้อมูลอยู่อย่างนั้นไม่สิ้นสุด

`@hint`
ลองรันในเชลล์ดูได้เลย

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['ถูกต้อง!', 'ไม่ใช่ เชลล์สามารถรันคำสั่งนี้ได้จริง', 'ไม่ใช่ เชลล์สามารถรันคำสั่งนี้ได้จริง'])
```

---

## จะหยุดโปรแกรมที่กำลังทำงานอยู่ได้อย่างไร?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

คำสั่งและสคริปต์ที่รันมาทั้งหมดนั้นทำงานเสร็จอย่างรวดเร็ว
แต่บางงานอาจใช้เวลาเป็นนาที ชั่วโมง หรือแม้แต่หลายวัน
บางครั้งอาจใส่การเปลี่ยนเส้นทาง (redirection) ผิดตำแหน่งในไปป์ไลน์
ทำให้โปรแกรมค้างอยู่โดยไม่ทำงานต่อ
หากต้องการหยุดโปรแกรมที่กำลังทำงานอยู่ สามารถกด `Ctrl` + `C` เพื่อยุติได้
ในเอกสาร Unix มักเขียนแทนด้วย `^C`
โดยตัวอักษร 'c' จะเป็นตัวพิมพ์เล็กหรือพิมพ์ใหญ่ก็ได้

`@instructions`
รันคำสั่งต่อไปนี้:

```{shell}
head
```

โดยไม่ใส่อาร์กิวเมนต์ใดๆ (เพื่อให้โปรแกรมรอรับข้อมูลที่ไม่มีวันมาถึง)
จากนั้นหยุดโปรแกรมโดยกด `Ctrl` + `C`

`@hint`
พิมพ์ head แล้วกด Enter จากนั้นออกจากโปรแกรมที่กำลังทำงานอยู่ด้วย `Ctrl` + `C`

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="คุณได้ใช้ `head` หรือไม่?")
```

---

## สรุปทบทวน

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

เพื่อสรุปสิ่งที่เรียนมา
จะสร้าง pipeline เพื่อหาว่าไฟล์ข้อมูลตามฤดูกาลที่สั้นที่สุดมีกี่ระเบียน

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: b1f9c8ff84
xp: 35
```

`@instructions`
ใช้ `wc` พร้อมพารามิเตอร์ที่เหมาะสมเพื่อแสดงจำนวนบรรทัดในไฟล์ข้อมูลตามฤดูกาลทั้งหมด
(ใช้ wildcard สำหรับชื่อไฟล์ แทนการพิมพ์ทีละชื่อ)

`@hint`
ใช้ `-l` เพื่อแสดงเฉพาะจำนวนบรรทัด และใช้ `*` เพื่อจับคู่ชื่อไฟล์

`@solution`
```{shell}
wc -l seasonal/*.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("wc", incorrect_msg = "คุณเรียกใช้ `wc` หรือไม่?"),
      has_code("-l", incorrect_msg = "คุณนับจำนวนบรรทัดด้วย `-l` หรือไม่?"),
      has_code("seasonal/\*", incorrect_msg = "คุณดึงข้อมูลจากไฟล์ `seasonal/*` ทั้งหมดหรือไม่?")
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: 7f94acc679
xp: 35
```

`@instructions`
เพิ่มคำสั่งถัดไปต่อจากคำสั่งเดิมโดยใช้ pipe เพื่อลบบรรทัดที่มีคำว่า "total" ออก

`@hint`


`@solution`
```{shell}
wc -l seasonal/*.csv | grep -v total

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("wc", incorrect_msg = "คุณเรียกใช้ `wc` หรือไม่?"),
      has_code("-l", incorrect_msg = "คุณนับจำนวนบรรทัดด้วย `-l` หรือไม่?"),
      has_code("seasonal/\*", incorrect_msg = "คุณดึงข้อมูลจากไฟล์ `seasonal/*` ทั้งหมดหรือไม่?"),
      has_code("|", incorrect_msg = "คุณใช้ไปป์จาก `wc` ไปยัง `grep` โดยใช้ `|` หรือไม่?"),      
      has_code("grep", incorrect_msg = "คุณเรียกใช้ `grep` หรือไม่?"),
      has_code("-v", incorrect_msg = "คุณกลับผลการค้นหาด้วย `-v` หรือไม่?"),
      has_code("total", incorrect_msg = "คุณค้นหา `total` หรือไม่?")
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: c5f55bff6b
xp: 30
```

`@instructions`
เพิ่มอีก 2 ขั้นตอนใน pipeline โดยใช้ `sort -n` และ `head -n 1` เพื่อค้นหาไฟล์ที่มีจำนวนบรรทัดน้อยที่สุด

`@hint`
- ใช้แฟล็ก `-n` ของ `sort` เพื่อเรียงลำดับตามตัวเลข
- ใช้แฟล็ก `-n` ของ `head` เพื่อจำกัดผลลัพธ์ให้เหลือเพียง 1 บรรทัด

`@solution`
```{shell}
wc -l seasonal/*.csv | grep -v total | sort -n | head -n 1

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(strict=True),
    multi(
      has_code("wc", incorrect_msg = "คุณเรียกใช้ `wc` หรือไม่?"),
      has_code("-l", incorrect_msg = "คุณนับจำนวนบรรทัดด้วย `-l` หรือไม่?"),
      has_code("seasonal/\*", incorrect_msg = "คุณดึงข้อมูลจากไฟล์ `seasonal/*` ทั้งหมดหรือไม่?"),
      has_code("|", incorrect_msg = "คุณใช้ `|` เพื่อเชื่อมต่อ `wc` กับ `grep` กับ `sort` กับ `head` หรือไม่?"),      
      has_code("grep", incorrect_msg = "คุณเรียกใช้ `grep` หรือไม่?"),
      has_code("-v", incorrect_msg = "คุณกลับผลการค้นหาด้วย `-v` หรือไม่?"),
      has_code("total", incorrect_msg = "คุณค้นหา `total` หรือไม่?"),
      has_code("sort", incorrect_msg = "คุณเรียกใช้ `sort` หรือไม่?"),
      has_code("-n", incorrect_msg = "คุณระบุจำนวนบรรทัดที่ต้องการเก็บด้วย `-n` หรือไม่?"),
      has_code("1", incorrect_msg = "คุณระบุ 1 บรรทัดที่ต้องการเก็บด้วย `-n 1` หรือไม่?")
    )
  )
)
Ex().success_msg("ยอดเยี่ยม! ปรากฏว่า `autumn.csv` คือไฟล์ที่มีจำนวนบรรทัดน้อยที่สุด รีบไปที่บทที่ 4 เพื่อเรียนรู้เพิ่มเติมเกี่ยวกับการประมวลผลแบบกลุ่มได้เลย!")
```

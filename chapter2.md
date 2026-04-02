---
title: Xử lý dữ liệu
description: >-
  Các lệnh bạn đã thấy ở chương trước cho phép bạn di chuyển dữ liệu trong hệ
  thống tệp. Chương này sẽ chỉ cho bạn cách làm việc với dữ liệu bên trong các
  tệp đó. Những công cụ chúng ta dùng khá đơn giản, nhưng là những khối xây dựng
  vững chắc.
lessons:
  - nb_of_exercises: 12
    title: Làm sao xem nội dung của một tệp?
---

## Làm thế nào để xem nội dung của một tệp?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Trước khi bạn đổi tên hoặc xóa tệp,
bạn có thể muốn xem qua nội dung của chúng.
Cách đơn giản nhất là dùng `cat`,
lệnh này chỉ việc in nội dung tệp ra màn hình.
(Tên của nó viết tắt từ "concatenate", nghĩa là "nối các thứ lại với nhau",
vì nó sẽ in tất cả các tệp có tên bạn cung cấp, lần lượt từng tệp một.)

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
In nội dung của `course.txt` ra màn hình.

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
    has_expr_output(incorrect_msg="Lệnh của bạn đã không tạo ra đầu ra đúng. Bạn đã sử dụng `cat` theo sau là tên của tệp, `course.txt` chưa?")
)
Ex().success_msg("Tuyệt! Hãy xem các cách khác để xem nội dung của một tệp.")
```

---

## Làm sao để xem nội dung tệp theo từng phần?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Bạn có thể dùng `cat` để in ra các tệp lớn rồi cuộn qua phần đầu ra,
nhưng thường tiện hơn nếu **phân trang** đầu ra.
Lệnh ban đầu để làm việc này là `more`,
nhưng nó đã được thay thế bởi lệnh mạnh hơn tên là `less`.
(Kiểu đặt tên này được xem là hài hước trong thế giới Unix.)
Khi bạn dùng `less` cho một tệp,
mỗi lần sẽ hiển thị một trang;
bạn có thể nhấn phím cách để chuyển trang xuống hoặc gõ `q` để thoát.

Nếu bạn đưa cho `less` nhiều tên tệp,
bạn có thể gõ `:n` (dấu hai chấm và chữ 'n' thường) để sang tệp tiếp theo,
`:p` để quay lại tệp trước đó,
hoặc `:q` để thoát.

Lưu ý: Nếu bạn xem lời giải cho các bài tập dùng `less`,
bạn sẽ thấy một lệnh bổ sung ở cuối để tắt chế độ phân trang
nhằm giúp chúng tôi kiểm thử lời giải của bạn hiệu quả hơn.

`@instructions`
Dùng `less seasonal/spring.csv seasonal/summer.csv` để xem hai tệp đó theo đúng thứ tự.
Nhấn phím cách để chuyển trang xuống, `:n` để sang tệp thứ hai, và `:q` để thoát.

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
                 incorrect_msg='Sử dụng `less` và tên tệp. Hãy nhớ rằng `:n` sẽ chuyển bạn đến tệp tiếp theo.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Làm sao để xem phần đầu của một tệp?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Việc đầu tiên hầu hết các nhà khoa học dữ liệu làm khi nhận một bộ dữ liệu mới là
xác định nó có những trường nào và các trường đó chứa giá trị gì.
Nếu bộ dữ liệu được xuất từ cơ sở dữ liệu hoặc bảng tính,
thì thường sẽ được lưu ở dạng **giá trị phân tách bằng dấu phẩy** (CSV).
Một cách nhanh để nắm được nội dung là xem vài dòng đầu.

Bạn có thể làm điều này trong shell bằng lệnh `head`.
Đúng như tên gọi,
nó in ra một vài dòng đầu của tệp
(trong đó "một vài" nghĩa là 10),
vì vậy lệnh:

```{shell}
head seasonal/summer.csv
```

sẽ hiển thị:

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

`head` làm gì nếu tệp không có đủ 10 dòng?
(Để biết, hãy dùng nó để xem phần đầu của `people/agarwal.txt`.)

`@possible_answers`
- In thông báo lỗi vì tệp quá ngắn.
- Hiển thị bao nhiêu dòng có sẵn thì bấy nhiêu.
- Hiển thị thêm các dòng trống để đủ tổng cộng 10 dòng.

`@hint`
Điều hữu ích nhất mà nó có thể làm là gì?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Không chính xác: đó không phải là điều hữu ích nhất mà nó có thể làm.",
                    "Chính xác!",
                    "Không chính xác: điều đó sẽ không thể phân biệt được với một tệp kết thúc bằng một loạt các dòng trống."])
```

---

## Làm sao để gõ ít hơn?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Một trong những công cụ mạnh của shell là **tab completion**.
Khi bạn bắt đầu gõ tên tệp rồi nhấn phím tab,
shell sẽ cố gắng tự động hoàn thành đường dẫn.
Ví dụ,
nếu bạn gõ `sea` và nhấn tab,
nó sẽ điền tên thư mục `seasonal/` (kèm dấu gạch chéo ở cuối).
Nếu sau đó bạn gõ `a` và nhấn tab,
nó sẽ hoàn thành đường dẫn thành `seasonal/autumn.csv`.

Nếu đường dẫn có thể hiểu theo nhiều cách,
chẳng hạn `seasonal/s`,
nhấn tab lần thứ hai sẽ hiển thị danh sách các khả năng.
Gõ thêm một vài ký tự để làm đường dẫn cụ thể hơn
rồi nhấn tab
sẽ điền nốt phần còn lại của tên.

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
Chạy `head seasonal/autumn.csv` mà không gõ đầy đủ tên tệp.

`@hint`
Gõ đủ một phần của đường dẫn, sau đó nhấn tab và lặp lại.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Trình kiểm tra không thể tìm thấy đầu ra đúng trong lệnh của bạn. Bạn có chắc chắn rằng bạn đã gọi `head` trên `seasonal/autumn.csv` không?")
)

```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Chạy `head seasonal/spring.csv` mà không gõ đầy đủ tên tệp.

`@hint`
Gõ đủ một phần của đường dẫn, sau đó nhấn tab và lặp lại.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Trình kiểm tra không thể tìm thấy đầu ra đúng trong lệnh của bạn. Bạn có chắc chắn rằng bạn đã gọi `head` trên `seasonal/spring.csv` không?")
)
Ex().success_msg("Làm tốt lắm! Khi bạn quen với việc sử dụng tính năng hoàn thành tab, nó sẽ giúp bạn tiết kiệm rất nhiều thời gian!")
```

---

## Làm sao mình kiểm soát hành vi của lệnh?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Bạn sẽ không phải lúc nào cũng muốn xem 10 dòng đầu của một tệp,
nên shell cho phép bạn thay đổi cách `head` hoạt động
bằng cách truyền cho nó một **cờ dòng lệnh** (gọi ngắn gọn là "cờ").
Nếu bạn chạy lệnh:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` sẽ chỉ hiển thị ba dòng đầu tiên của tệp.
Nếu bạn chạy `head -n 100`,
nó sẽ hiển thị 100 dòng đầu (nếu tệp có đủ),
và tương tự như vậy.

Tên của một cờ thường cho biết mục đích của nó
(ví dụ, `-n` dùng để chỉ "**s**ố lượng dòng").
Cờ lệnh không nhất thiết phải là một `-` theo sau bởi một chữ cái duy nhất,
nhưng đó là một quy ước được dùng rất phổ biến.

Lưu ý: cách viết chuẩn là đặt tất cả các cờ *trước* bất kỳ tên tệp nào,
vì vậy trong khóa học này,
chúng tôi chỉ chấp nhận các câu trả lời tuân theo quy tắc đó.

`@instructions`
Hiển thị 5 dòng đầu tiên của `winter.csv` trong thư mục `seasonal`.

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
        has_expr_output(incorrect_msg="Bạn có chắc chắn rằng bạn đang gọi `head` trên tệp `seasonal/winter.csv` không?"),
        has_expr_output(strict=True, incorrect_msg="Bạn có chắc chắn rằng bạn đã sử dụng cờ `-n 5` không?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Bạn có chắc chắn rằng bạn đã sử dụng cờ `-n 5` không?")
)
Ex().success_msg("Tuyệt vời! Với kỹ thuật này, bạn có thể tránh việc shell của bạn bị quá tải nếu bạn muốn xem các tệp văn bản lớn hơn.")
```

---

## Làm thế nào để liệt kê mọi thứ bên dưới một thư mục?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Để xem mọi thứ bên trong một thư mục,
dù lồng nhau sâu đến đâu,
bạn có thể đưa cho `ls` cờ `-R`
(nghĩa là "đệ quy").
Nếu bạn dùng `ls -R` trong thư mục home của mình,
bạn sẽ thấy thứ gì đó như sau:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Đầu ra này hiển thị mọi tệp và thư mục ở cấp hiện tại,
sau đó là mọi thứ trong từng thư mục con,
và cứ thế tiếp tục.

`@instructions`
Để giúp bạn phân biệt đâu là gì,
`ls` có thêm cờ `-F` sẽ in một dấu `/` sau tên mỗi thư mục
và một dấu `*` sau tên mỗi chương trình có thể chạy được.
Chạy `ls` với hai cờ `-R` và `-F`, cùng với đường dẫn tuyệt đối tới thư mục home của bạn
để xem tất cả những gì nó chứa.
(Thứ tự của các cờ không quan trọng, nhưng tên thư mục phải đặt ở cuối.)

`@hint`
Thư mục home của bạn có thể được chỉ định bằng `~` hoặc `.` hoặc bằng đường dẫn tuyệt đối của nó.

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
  has_expr_output(incorrect_msg='Sử dụng `ls -R -F` hoặc `ls -F -R` và đường dẫn `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Sử dụng `ls -R -F` hoặc `ls -F -R` và đường dẫn `/home/repl`.')
)
Ex().success_msg('Đó là một cái nhìn tổng quan khá gọn gàng, phải không?')
```

---

## Làm sao để xem trợ giúp cho một lệnh?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Để tìm hiểu một lệnh dùng để làm gì,
trước đây người ta thường dùng lệnh `man`
(viết tắt của "manual").
Ví dụ,
lệnh `man head` sẽ hiển thị thông tin sau:

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

`man` tự động gọi `less`,
vì vậy bạn có thể cần nhấn phím cách để cuộn qua thông tin
và gõ `:q` để thoát.

Phần mô tả một dòng dưới `NAME` cho bạn biết ngắn gọn lệnh đó làm gì,
và phần tóm tắt dưới `SYNOPSIS` liệt kê tất cả các cờ (flag) mà lệnh hiểu.
Bất cứ thứ gì là tùy chọn sẽ được đặt trong ngoặc vuông `[...]`,
các lựa chọn một trong hai được phân tách bằng `|`,
và những thứ có thể lặp lại được hiển thị bằng `...`,
nên trang hướng dẫn của `head` đang nói rằng bạn có thể đặt *hoặc* số dòng với `-n`
hoặc số byte với `-c`,
và bạn có thể đưa vào bất kỳ số lượng tên tệp nào.

Vấn đề với sổ tay Unix là bạn phải biết mình đang tìm gì.
Nếu không,
bạn có thể tìm trên [Stack Overflow](https://stackoverflow.com/),
đặt câu hỏi trên các kênh Slack của DataCamp,
hoặc xem phần `SEE ALSO` của những lệnh bạn đã biết.

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
Đọc trang hướng dẫn (manual) của lệnh `tail` để biết
việc đặt dấu `+` trước con số dùng với cờ `-n` có tác dụng gì.
(Hãy nhớ nhấn phím cách để cuộn xuống và/hoặc gõ `q` để thoát.)

`@hint`
Hãy nhớ: `man` là viết tắt của "manual".

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Sử dụng `man` và tên lệnh.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Dùng `tail` với cờ `-n +7` để hiển thị tất cả các dòng *trừ* sáu dòng đầu của `seasonal/spring.csv`.

`@hint`
Dùng dấu cộng '+' đứng trước số dòng bạn muốn hiển thị.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Bạn có đang gọi `tail` trên `seasonal/spring.csv` không?"),
    has_expr_output(strict=True, incorrect_msg="Bạn có chắc rằng bạn đã sử dụng cờ `-n +7` không?")
)

```

---

## Làm thế nào để chọn các cột từ một tệp?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` và `tail` cho phép bạn chọn các hàng từ một tệp văn bản.
Nếu muốn chọn các cột,
bạn có thể dùng lệnh `cut`.
Lệnh này có vài tùy chọn (dùng `man cut` để tìm hiểu),
nhưng cách dùng phổ biến là như sau:

```{shell}
cut -f 2-5,8 -d , values.csv
```

có nghĩa là
"chọn các cột từ 2 đến 5 và cột 8,
dùng dấu phẩy làm ký tự phân tách".
`cut` dùng `-f` (viết tắt của "fields") để chỉ định cột
và `-d` (viết tắt của "delimiter") để chỉ định ký tự phân tách.
Bạn cần chỉ định cái sau vì một số tệp có thể dùng khoảng trắng, tab hoặc dấu hai chấm để phân tách cột.

<hr>

Lệnh nào sẽ chọn cột đầu tiên (chứa ngày tháng) từ tệp `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Một trong hai lệnh trên.
- Không lệnh nào ở trên, vì `-f` phải đứng trước `-d`.

`@hint`
Thứ tự của các cờ (flags) không quan trọng.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Có, nhưng đó không phải là tất cả', 'Có, nhưng đó không phải là tất cả', 'Chính xác! Thêm một khoảng trắng sau cờ là phong cách tốt, nhưng không bắt buộc.', 'Không, thứ tự của cờ không quan trọng'])
```

---

## cut không làm được gì?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` là một lệnh khá đơn giản.
Cụ thể là
nó không hiểu các chuỗi có dấu ngoặc kép.
Ví dụ, nếu tệp của bạn là:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

thì:

```{shell}
cut -f 2 -d , everyone.csv
```

sẽ cho ra:

```
Age
Ranjit"
Rupinder"
```

thay vì tuổi của mọi người,
vì nó sẽ nghĩ dấu phẩy giữa họ và tên là ký tự phân tách cột.

<hr>

Đầu ra của `cut -d : -f 2-4` trên dòng sau là gì:

```
first:second:third:
```

(Lưu ý dấu hai chấm ở cuối.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Không có đáp án nào đúng, vì không có bốn trường.

`@hint`
Chú ý đến dấu hai chấm ở cuối dòng.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Không, vẫn còn nữa.', 'Không, vẫn còn nữa.', 'Chính xác! Dấu hai chấm ở cuối tạo ra một trường thứ tư rỗng.', 'Không, `cut` làm tốt nhất có thể.'])
```

---

## Làm sao mình lặp lại lệnh đã chạy?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Một trong những ưu điểm lớn nhất của shell là
nó giúp bạn dễ dàng lặp lại thao tác.
Khi bạn đã chạy vài lệnh,
bạn có thể nhấn phím mũi tên lên để cuộn lại qua các lệnh đó.
Bạn cũng có thể dùng phím mũi tên trái/phải và phím xóa để chỉnh sửa lệnh.
Nhấn Enter sẽ chạy lệnh đã chỉnh sửa.

Tốt hơn nữa, `history` sẽ in ra danh sách các lệnh bạn đã chạy gần đây.
Mỗi lệnh có kèm số thứ tự để bạn dễ chạy lại lệnh cụ thể:
chỉ cần gõ `!55` để chạy lại lệnh thứ 55 trong lịch sử (nếu bạn có nhiều đến vậy).
Bạn cũng có thể chạy lại một lệnh bằng cách gõ dấu chấm than theo sau là tên lệnh,
ví dụ `!head` hoặc `!cut`,
để chạy lại lần sử dụng gần nhất của lệnh đó.

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
Chạy `head summer.csv` trong thư mục home của bạn (lệnh này sẽ thất bại).

`@hint`
Tự động hoàn thành bằng Tab sẽ không hoạt động nếu không có tên tệp phù hợp.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Sử dụng `head` và một tên tệp, `summer.csv`. Đừng lo lắng nếu nó không thành công. Nó nên như vậy.")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Chuyển thư mục sang `seasonal`.

`@hint`
Hãy nhớ `cd` là viết tắt của "change directory" (đổi thư mục).

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Nếu thư mục làm việc hiện tại của bạn (tìm hiểu với `pwd`) là `/home/repl`, bạn có thể di chuyển đến thư mục `seasonal` với `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Chạy lại lệnh `head` bằng `!head`.

`@hint`
Đừng gõ bất kỳ khoảng trắng nào giữa `!` và phần theo sau.

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
                        incorrect_msg='Sử dụng `!head` để lặp lại lệnh `head`.'),
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
Dùng `history` để xem bạn đã làm gì.

`@hint`
Lưu ý `history` hiển thị các lệnh gần đây nhất ở cuối, để chúng vẫn nằm trên màn hình sau khi chạy xong.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Sử dụng `history` mà không có cờ để lấy danh sách các lệnh trước đó.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Chạy lại `head` lần nữa bằng `!` theo sau là số thứ tự lệnh.

`@hint`
Đừng gõ bất kỳ khoảng trắng nào giữa `!` và phần theo sau.

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
                        incorrect_msg='Bạn đã sử dụng `!<a_number>` để chạy lại lệnh `head` cuối cùng từ lịch sử chưa?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Làm tốt lắm! Tiếp theo nào!")
```

---

## Làm sao chọn các dòng chứa giá trị cụ thể?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` và `tail` chọn theo hàng,
`cut` chọn theo cột,
và `grep` chọn các dòng dựa trên nội dung của chúng.
Ở dạng đơn giản nhất,
`grep` nhận một đoạn văn bản theo sau bởi một hoặc nhiều tên tệp
và in ra mọi dòng trong các tệp đó có chứa đoạn văn bản ấy.
Ví dụ,
`grep bicuspid seasonal/winter.csv`
sẽ in các dòng từ `winter.csv` có chứa "bicuspid".

`grep` cũng có thể tìm theo mẫu;
chúng ta sẽ khám phá điều này trong khóa học tiếp theo.
Điều quan trọng hơn lúc này là một số cờ thường dùng của `grep`:

- `-c`: in số lượng dòng khớp thay vì chính các dòng
- `-h`: KHÔNG in tên tệp khi tìm trong nhiều tệp
- `-i`: bỏ qua chữ hoa/chữ thường (ví dụ, coi "Regression" và "regression" là khớp)
- `-l`: in tên các tệp có chứa kết quả khớp, không phải nội dung khớp
- `-n`: in số dòng cho các dòng khớp
- `-v`: đảo ngược điều kiện khớp, tức chỉ hiển thị các dòng KHÔNG khớp

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
In toàn bộ các dòng chứa từ `molar` trong `seasonal/autumn.csv`
bằng cách chạy một lệnh duy nhất khi đang ở thư mục chính của bạn. Không dùng cờ nào.

`@hint`
Dùng `grep` với từ bạn muốn tìm và tên tệp (các tệp) cần tìm trong đó.

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
      has_code("grep", incorrect_msg = "Bạn đã gọi `grep` chưa?"),
      has_code("molar", incorrect_msg = "Bạn đã tìm kiếm `molar` chưa?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Bạn đã tìm kiếm tệp `seasonal/autumn.csv` chưa?")
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
Đảo ngược điều kiện khớp để tìm tất cả các dòng KHÔNG chứa từ `molar` trong `seasonal/spring.csv`, và hiển thị số dòng của chúng.
Nhớ rằng, một thực hành tốt là đặt tất cả các cờ TRƯỚC các giá trị khác như tên tệp hoặc từ khóa tìm kiếm "molar".

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
      has_code("grep", incorrect_msg = "Bạn đã gọi `grep` chưa?"),
      has_code("-v", incorrect_msg = "Bạn đã đảo ngược kết quả khớp với `-v` chưa?"),
      has_code("-n", incorrect_msg = "Bạn đã hiển thị số dòng với `-n` chưa?"),
      has_code("molar", incorrect_msg = "Bạn đã tìm kiếm `molar` chưa?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Bạn đã tìm kiếm tệp `seasonal/spring.csv` chưa?")
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
Đếm có bao nhiêu dòng chứa từ `incisor` trong cả `autumn.csv` và `winter.csv` gộp lại.
(Một lần nữa, hãy chạy một lệnh duy nhất từ thư mục chính của bạn.)

`@hint`
Nhớ dùng `-c` với `grep` để đếm số dòng.

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
      has_code("grep", incorrect_msg = "Bạn đã gọi `grep` chưa?"),
      has_code("-c", incorrect_msg = "Bạn đã lấy số lượng với `-c` chưa?"),
      has_code("incisor", incorrect_msg = "Bạn đã tìm kiếm `incisor` chưa?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Bạn đã tìm kiếm tệp `seasonal/autumn.csv` chưa?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Bạn đã tìm kiếm tệp `seasonal/winter.csv` chưa?")
    )
  )
)

```

---

## Tại sao không phải lúc nào cũng an toàn khi xử lý dữ liệu như văn bản thuần?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

Mục `SEE ALSO` trong trang hướng dẫn của `cut` có nhắc tới lệnh `paste`
có thể dùng để ghép các tệp dữ liệu thay vì cắt chúng.

<hr>

Đọc trang hướng dẫn của `paste`,
rồi chạy `paste` để ghép hai tệp dữ liệu autumn và winter vào cùng một bảng,
dùng dấu phẩy làm dấu phân tách.
Về mặt phân tích dữ liệu, đầu ra có vấn đề gì?

`@possible_answers`
- Tiêu đề cột bị lặp lại.
- Vài hàng cuối có sai số lượng cột.
- Một số dữ liệu từ `winter.csv` bị thiếu.

`@hint`
Nếu bạn `cut` đầu ra của `paste` dùng dấu phẩy làm dấu tách,
liệu có cho ra đáp án đúng không?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Đúng, nhưng điều đó không nhất thiết là một lỗi.'
correct2 = 'Chính xác: nối các dòng với các cột chỉ tạo ra một cột trống ở đầu, không phải hai.'
err3 = 'Không, tất cả dữ liệu mùa đông đều có ở đó.'
Ex().has_chosen(2, [err1, correct2, err3])
```

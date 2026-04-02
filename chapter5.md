---
title: Tạo công cụ mới
description: >-
  History giúp bạn lặp lại thao tác chỉ với vài phím bấm, và pipes cho phép kết
  hợp các lệnh sẵn có để tạo ra lệnh mới. Ở chương này, bạn sẽ tiến thêm một
  bước để tự tạo các lệnh của riêng mình.
lessons:
  - nb_of_exercises: 9
    title: Làm sao chỉnh sửa một tệp?
---

## Làm sao để chỉnh sửa một tệp?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix có rất nhiều trình soạn thảo văn bản khiến bạn dễ rối.
Trong khóa học này,
chúng ta sẽ dùng một công cụ đơn giản tên là Nano.
Nếu bạn gõ `nano filename`,
nó sẽ mở `filename` để chỉnh sửa
(hoặc tạo mới nếu tệp chưa tồn tại).
Bạn có thể di chuyển bằng các phím mũi tên,
xóa ký tự bằng phím backspace,
và thực hiện các thao tác khác bằng tổ hợp phím Ctrl:

- `Ctrl` + `K`: xóa một dòng.
- `Ctrl` + `U`: khôi phục dòng vừa xóa.
- `Ctrl` + `O`: lưu tệp ('O' là viết tắt của 'output'). _Bạn cũng cần nhấn Enter để xác nhận tên tệp!_
- `Ctrl` + `X`: thoát khỏi trình soạn thảo.

`@instructions`
Chạy `nano names.txt` để chỉnh sửa một tệp mới trong thư mục home của bạn
và nhập bốn dòng sau:

```
Lovelace
Hopper
Johnson
Wilson
```

Để lưu những gì bạn đã viết,
gõ `Ctrl` + `O` để ghi tệp ra đĩa,
rồi nhấn Enter để xác nhận tên tệp,
sau đó `Ctrl` + `X` để thoát trình soạn thảo.

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
patt = "Bạn đã bao gồm dòng `%s` trong tệp `names.txt` chưa? Sử dụng `nano names.txt` một lần nữa để cập nhật tệp của bạn. Sử dụng `Ctrl` + `O` để lưu và `Ctrl` + `X` để thoát."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Làm tốt lắm! Tiếp tục đến cái tiếp theo!")
```

---

## Làm sao lưu lại những gì tôi vừa làm?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Khi bạn đang thực hiện một phân tích phức tạp,
bạn thường sẽ muốn lưu lại các lệnh đã dùng.
Bạn có thể làm điều này với các công cụ bạn đã thấy:

1. Chạy `history`.
2. Pipe đầu ra của nó vào `tail -n 10` (hoặc số bước gần đây bạn muốn lưu).
3. Chuyển hướng đầu ra đó vào một tệp có tên như `figure-5.history`.

Cách này tốt hơn việc ghi chép vào sổ tay phòng thí nghiệm
vì nó đảm bảo không bỏ sót bất kỳ bước nào.
Nó cũng minh họa ý tưởng cốt lõi của shell:
những công cụ đơn giản tạo và tiêu thụ các dòng văn bản
có thể được kết hợp theo nhiều cách khác nhau
để giải quyết một loạt vấn đề rộng lớn.

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
Sao chép các tệp `seasonal/spring.csv` và `seasonal/summer.csv` vào thư mục home của bạn.

`@hint`
Dùng `cp` để sao chép và `~` như lối tắt tới đường dẫn thư mục home của bạn.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Bạn đã sử dụng `cp seasonal/s* ~` để sao chép các tệp cần thiết vào thư mục chính của bạn chưa?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Lưu trữ đáng chú ý! Nếu bạn đã gõ sai bất kỳ lệnh nào, bạn luôn có thể sử dụng `nano` để dọn dẹp tệp lịch sử lưu sau đó.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Dùng `grep` với cờ `-h` (để không in tên tệp)
và `-v Tooth` (để chọn các dòng *không* khớp với dòng tiêu đề)
để chọn các bản ghi dữ liệu từ `spring.csv` và `summer.csv` theo thứ tự đó
và chuyển hướng đầu ra vào `temp.csv`.

`@hint`
Đặt các cờ (flags) trước tên tệp.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Hãy đảm bảo rằng bạn chuyển hướng đầu ra của lệnh `grep` đến `temp.csv` với `>`!"
msg2 = "Bạn đã sử dụng `grep -h -v ___ ___ ___` (điền vào chỗ trống) để điền `temp.csv` chưa?"
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
Pipe `history` vào `tail -n 3`
và chuyển hướng đầu ra vào `steps.txt`
để lưu ba lệnh gần nhất vào một tệp.
(Bạn cần lưu ba lệnh thay vì chỉ hai
vì chính lệnh `history` cũng sẽ có trong danh sách.)

`@hint`
Nhớ rằng chuyển hướng với `>` đặt ở cuối chuỗi lệnh được pipe.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Hãy đảm bảo chuyển hướng đầu ra của lệnh của bạn đến `steps.txt`."
msg2="Bạn đã sử dụng `history | tail ___ ___` (điền vào chỗ trống) để điền vào `steps.txt` chưa?"
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
Ex().success_msg("Làm tốt lắm! Hãy nâng cao hơn nữa!")
```

---

## Làm sao lưu lệnh để chạy lại sau này?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Đến giờ bạn đã dùng shell theo cách tương tác.
Nhưng vì các lệnh bạn gõ chỉ là văn bản,
bạn có thể lưu chúng vào tệp để shell chạy đi chạy lại.
Để bắt đầu khám phá khả năng mạnh mẽ này,
hãy đặt lệnh sau vào một tệp tên là `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Lệnh này chọn hàng đầu tiên từ mỗi tệp CSV trong thư mục `seasonal`.
Sau khi tạo xong tệp này,
bạn có thể chạy nó bằng cách gõ:

```{shell}
bash headers.sh
```

Lệnh này bảo shell (vốn là một chương trình tên `bash`)
chạy các lệnh có trong tệp `headers.sh`,
và tạo ra đầu ra giống như khi bạn chạy các lệnh đó trực tiếp.

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
Dùng `nano dates.sh` để tạo một tệp tên `dates.sh`
chứa lệnh sau:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

để trích xuất cột đầu tiên từ tất cả các tệp CSV trong `seasonal`.

`@hint`
Đặt đúng các lệnh đã cho vào tệp, không thêm dòng trống hay khoảng trắng thừa.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Bạn đã bao gồm dòng lệnh `cut -d , -f 1 seasonal/*.csv` trong tệp `dates.sh` chưa? Sử dụng `nano dates.sh` để cập nhật tệp của bạn. Sử dụng `Ctrl` + `O` để lưu và `Ctrl` + `X` để thoát."
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
Dùng `bash` để chạy tệp `dates.sh`.

`@hint`
Dùng `bash filename` để chạy tệp.

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
      has_code("bash", incorrect_msg = 'Bạn đã gọi `bash` chưa?'),
      has_code("dates.sh", incorrect_msg = 'Bạn đã chỉ định tệp `dates.sh` chưa?')
    )
  )
)
```

---

## Làm thế nào để tái sử dụng pipes?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Một tệp chứa đầy lệnh shell được gọi là ***shell script**,
hoặc ngắn gọn là "script". Script không nhất thiết phải có tên kết thúc bằng `.sh`,
nhưng bài học này sẽ dùng quy ước đó
để giúp bạn nhận ra tệp nào là script.

Script cũng có thể chứa pipes.
Ví dụ,
nếu `all-dates.sh` có dòng sau:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

thì:

```{shell}
bash all-dates.sh > dates.out
```

sẽ trích xuất các ngày duy nhất từ các tệp dữ liệu theo mùa
và lưu chúng vào `dates.out`.

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
Một tệp `teeth.sh` trong thư mục home của bạn đã được chuẩn bị sẵn, nhưng còn vài chỗ trống.
Hãy dùng Nano để chỉnh sửa tệp và thay hai chỗ giữ chỗ `____`
bằng `seasonal/*.csv` và `-c` để script này in ra số đếm
số lần mỗi tên răng xuất hiện trong các tệp CSV trong thư mục `seasonal`.

`@hint`
Dùng `nano teeth.sh` để chỉnh sửa tệp.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Bạn đã thay thế các khoảng trống một cách chính xác để lệnh trong `teeth.sh` là `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c` chưa? Hãy sử dụng `nano teeth.sh` một lần nữa để thực hiện các thay đổi cần thiết."
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
Dùng `bash` để chạy `teeth.sh` và dùng `>` để chuyển hướng đầu ra của nó vào `teeth.out`.

`@hint`
Hãy nhớ rằng `> teeth.out` phải đặt sau lệnh tạo ra đầu ra.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Bạn đã chuyển hướng chính xác kết quả của `bash teeth.sh` sang `teeth.out` với `>` chưa?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Bạn đã gọi `bash` chưa?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Bạn đã chạy tệp `teeth.sh` chưa?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Bạn đã chuyển hướng đến tệp `teeth.out` chưa?')
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
Chạy `cat teeth.out` để xem kết quả của bạn.

`@hint`
Bạn có thể gõ vài ký tự đầu của tên tệp rồi nhấn phím tab để tự động hoàn thành.

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
      has_code("cat", incorrect_msg = 'Bạn đã gọi `cat` chưa?'),
      has_code("teeth.out", incorrect_msg = 'Bạn đã chỉ định tệp `teeth.out` chưa?')
    )
  )
)
Ex().success_msg("Tuyệt vời! Ban đầu tất cả điều này có thể cảm thấy gượng ép, nhưng điều tuyệt vời là bạn đang tự động hóa các phần của quy trình làm việc của mình từng bước một. Điều này thực sự hữu ích khi bạn là một nhà khoa học dữ liệu!")
```

---

## Làm sao truyền tên tệp cho script?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Một script xử lý các tệp cụ thể thì hữu ích để ghi lại bạn đã làm gì, nhưng một script cho phép bạn xử lý bất kỳ tệp nào bạn muốn còn hữu ích hơn.
Để hỗ trợ điều này,
bạn có thể dùng biểu thức đặc biệt `$@` (dấu đô-la theo ngay sau là ký tự a còng)
để chỉ "tất cả các tham số dòng lệnh được truyền cho script".

Ví dụ, nếu `unique-lines.sh` chứa `sort $@ | uniq`, khi bạn chạy:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

shell sẽ thay `$@` bằng `seasonal/summer.csv` và xử lý một tệp. Nếu bạn chạy:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

nó sẽ xử lý hai tệp dữ liệu, và tương tự cho nhiều tệp hơn.

_Nhắc lại: để lưu những gì bạn đã viết trong Nano, gõ `Ctrl` + `O` để ghi tệp, sau đó Enter để xác nhận tên tệp, rồi `Ctrl` + `X` để thoát trình soạn thảo._

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
Chỉnh sửa script `count-records.sh` bằng Nano và điền vào hai chỗ trống `____`
bằng `$@` và `-l` (_chữ cái_) tương ứng để script đếm số dòng trong một hoặc nhiều tệp,
loại trừ dòng đầu tiên của mỗi tệp.

`@hint`
* Dùng `nano count-records.sh` để chỉnh sửa tên tệp.
* Hãy chắc chắn bạn chỉ định _chữ cái_ `-l`, không phải số một.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Bạn đã thay thế các khoảng trống đúng cách để lệnh trong `count-records.sh` đọc là `tail -q -n +2 $@ | wc -l` chưa? Sử dụng `nano count-records.sh` một lần nữa để thực hiện các thay đổi cần thiết."
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
Chạy `count-records.sh` trên `seasonal/*.csv`
và chuyển hướng đầu ra vào `num-records.out` bằng `>`.

`@hint`
Dùng `>` để chuyển hướng đầu ra.

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
      has_code("bash", incorrect_msg = 'Bạn đã gọi `bash` chưa?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Bạn đã chạy tệp `count-records.sh` chưa?'),
      has_code("seasonal/\*", incorrect_msg = 'Bạn đã chỉ định các tệp để xử lý với `seasonal/*` chưa?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Bạn đã chuyển hướng đến tệp `num-records.out` chưa?')
    )
  )
)
Ex().success_msg("Làm tốt lắm! Sức mạnh shell của bạn đang ngày càng mở rộng!")
```

---

## Làm thế nào để xử lý một đối số đơn lẻ?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Bên cạnh `$@`,
shell cho phép bạn dùng `$1`, `$2`, v.v. để tham chiếu tới các tham số dòng lệnh cụ thể.
Bạn có thể dùng cách này để viết các lệnh trông đơn giản hoặc tự nhiên hơn so với lệnh của shell.
Ví dụ,
bạn có thể tạo một script tên là `column.sh` để chọn một cột duy nhất từ tệp CSV
khi người dùng cung cấp tên tệp làm tham số thứ nhất và số cột làm tham số thứ hai:

```{shell}
cut -d , -f $2 $1
```

rồi chạy nó bằng:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Lưu ý script dùng hai tham số theo thứ tự ngược lại.

<hr>

Script `get-field.sh` dự kiến sẽ nhận một tên tệp,
số của hàng cần chọn,
số của cột cần chọn,
và in ra đúng trường đó từ một tệp CSV.
Ví dụ:

```
bash get-field.sh seasonal/summer.csv 4 2
```

sẽ chọn trường thứ hai ở dòng 4 của `seasonal/summer.csv`.
Trong số các lệnh sau, lệnh nào cần đặt vào `get-field.sh` để làm được việc đó?

`@hint`
Hãy nhớ rằng các tham số dòng lệnh được đánh số từ trái sang phải.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Không đúng: lệnh đó sẽ cố dùng tên tệp làm số dòng để chọn với `head`.
- Chính xác!
- Không đúng: lệnh đó sẽ hoán đổi, dùng số cột làm số dòng và ngược lại.
- Không đúng: lệnh đó sẽ dùng số trường làm tên tệp và ngược lại.

---

## Một shell script có thể làm nhiều việc như thế nào?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Các shell script của bạn đến giờ mới chỉ có một lệnh hoặc một pipeline, nhưng một script có thể chứa nhiều dòng lệnh. Ví dụ, bạn có thể tạo một script cho biết có bao nhiêu bản ghi trong tệp dữ liệu ngắn nhất và dài nhất của bạn, tức là phạm vi độ dài của các tập dữ liệu.

Lưu ý: trong Nano, "copy and paste" được thực hiện bằng cách di chuyển tới dòng bạn muốn sao chép, nhấn `CTRL` + `K` để cắt dòng, rồi nhấn `CTRL` + `U` hai lần để dán hai bản sao của dòng đó.

_Nhắc lại: để lưu những gì bạn đã viết trong Nano, gõ `Ctrl` + `O` để ghi tệp ra, rồi Enter để xác nhận tên tệp, sau đó `Ctrl` + `X` để thoát trình soạn thảo._

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
Dùng Nano để chỉnh sửa script `range.sh`
và thay hai chỗ giữ chỗ `____`
bằng `$@` và `-v`
để liệt kê tên và số dòng của tất cả các tệp được truyền trên dòng lệnh
mà KHÔNG hiển thị tổng số dòng của tất cả các tệp.
(Đừng cố trừ dòng tiêu đề cột khỏi các tệp.)

`@hint`
Dùng `wc -l $@` để đếm số dòng trong tất cả các tệp được truyền trên dòng lệnh.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Bạn đã thay thế các chỗ trống một cách chính xác để lệnh trong `range.sh` đọc là `wc -l $@ | grep -v total` chưa? Sử dụng `nano range.sh` một lần nữa để thực hiện các thay đổi cần thiết."
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
Tiếp tục dùng Nano để thêm `sort -n` và `head -n 1` theo đúng thứ tự đó
vào pipeline trong `range.sh`
để hiển thị tên và số dòng của tệp ngắn nhất được truyền vào.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Bạn đã thêm `sort -n` và `head -n 1` với các đường ống vào tệp `range.sh` chưa? Sử dụng `nano range.sh` một lần nữa để thực hiện các thay đổi cần thiết."
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
Vẫn với Nano, thêm một dòng thứ hai vào `range.sh` để in tên và số bản ghi của
tệp DÀI NHẤT trong thư mục đồng thời với tệp ngắn nhất.
Dòng này sẽ là bản sao của dòng bạn đã viết,
nhưng dùng `sort -n -r` thay vì `sort -n`.

`@hint`
Sao chép dòng đầu tiên và chỉnh lại thứ tự sắp xếp.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Giữ dòng đầu tiên trong tệp `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Bạn đã sao chép dòng đầu tiên trong `range.sh` và thực hiện một thay đổi nhỏ chưa? `sort -n -r` thay vì `sort -n`!"
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
Chạy script trên các tệp trong thư mục `seasonal`
sử dụng `seasonal/*.csv` để khớp tất cả các tệp
và chuyển hướng đầu ra bằng `>`
đến một tệp có tên `range.out` trong thư mục home của bạn.

`@hint`
Dùng `bash range.sh` để chạy script, `seasonal/*.csv` để chỉ định tệp, và `> range.out` để chuyển hướng đầu ra.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Bạn đã chuyển hướng chính xác kết quả của `bash range.sh seasonal/*.csv` sang `range.out` với `>` chưa?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Bạn đã gọi `bash` chưa?'),
has_code("bash\s+range.sh", incorrect_msg = 'Bạn đã chạy tệp `range.sh` chưa?'),
has_code("seasonal/\*", incorrect_msg = 'Bạn đã chỉ định các tệp để xử lý với `seasonal/*` chưa?'),
has_code(">\s+range.out", incorrect_msg = 'Bạn đã chuyển hướng đến tệp `range.out` chưa?')
)
)

Ex().success_msg("Mọi thứ đang diễn ra tốt đẹp. Hãy chuyển sang bài tập tiếp theo để tìm hiểu về cách viết vòng lặp!")
```

---

## Làm thế nào để viết vòng lặp trong shell script?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shell script cũng có thể chứa các vòng lặp. Bạn có thể viết chúng trên một dòng với dấu chấm phẩy, hoặc tách thành nhiều dòng không có dấu chấm phẩy để dễ đọc hơn:

```{shell}
# In ra bản ghi dữ liệu đầu tiên và cuối cùng của mỗi tệp.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Bạn không bắt buộc phải thụt lề các lệnh bên trong vòng lặp, nhưng làm vậy sẽ rõ ràng hơn.)

Dòng đầu tiên của script này là **comment** để cho người đọc biết script làm gì. Comment bắt đầu bằng ký tự `#` và kéo dài đến hết dòng. Phiên bản bạn trong tương lai sẽ cảm ơn bạn vì đã thêm các giải thích ngắn gọn như ví dụ này vào mọi script bạn viết.

_Nhắc lại: để lưu nội dung bạn đã viết trong Nano, nhấn `Ctrl` + `O` để ghi tệp, rồi Enter để xác nhận tên tệp, sau đó `Ctrl` + `X` để thoát trình soạn thảo._

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
Điền các chỗ trống trong script `date-range.sh`
với `$filename` (hai lần), `head`, và `tail`
để nó in ra ngày đầu tiên và cuối cùng từ một hoặc nhiều tệp.

`@hint`
Hãy nhớ dùng `$filename` để lấy giá trị hiện tại của biến vòng lặp.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="Trong `date-range.sh`, bạn đã thay đổi dòng %s trong vòng lặp thành `%s` chưa? Sử dụng `nano date-range.sh` để thực hiện thay đổi."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('đầu tiên', cmdpatt%'head')
msg2=msgpatt%('thứ hai', cmdpatt%'tail')
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
Chạy `date-range.sh` trên cả bốn tệp dữ liệu theo mùa
bằng cách dùng `seasonal/*.csv` để khớp tên của chúng.

`@hint`
Biểu thức ký tự đại diện nên bắt đầu bằng tên thư mục.

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
      has_code("bash", incorrect_msg = 'Bạn đã gọi `bash` chưa?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Bạn đã chạy tệp `date-range.sh` chưa?'),
      has_code("seasonal/\*", incorrect_msg = 'Bạn đã chỉ định các tệp để xử lý với `seasonal/*` chưa?')
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
Chạy `date-range.sh` trên cả bốn tệp dữ liệu theo mùa bằng `seasonal/*.csv` để khớp tên của chúng,
và chuyển (pipe) đầu ra của nó sang `sort` để thấy rằng script của bạn có thể được dùng giống như các lệnh dựng sẵn của Unix.

`@hint`
Hãy dùng lại biểu thức ký tự đại diện bạn đã dùng trước đó.

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
      has_code("bash", incorrect_msg = 'Bạn đã gọi `bash` chưa?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Bạn đã chạy tệp `date-range.sh` chưa?'),
      has_code("seasonal/\*", incorrect_msg = 'Bạn đã chỉ định các tệp để xử lý với `seasonal/*` chưa?'),
      has_code("|", incorrect_msg = 'Bạn đã chuyển từ đầu ra của script sang `sort` chưa?'),
      has_code("sort", incorrect_msg = 'Bạn đã gọi `sort` chưa?')
    )
  )
)
Ex().success_msg("Thật kỳ diệu! Hãy chú ý cách mà tất cả những điều chúng ta đã học có thể kết hợp với nhau.")
```

---

## Điều gì xảy ra khi tôi không cung cấp tên tệp?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Một lỗi thường gặp trong script shell (và khi gõ lệnh tương tác) là đặt tên tệp sai chỗ.
Nếu bạn gõ:

```{shell}
tail -n 3
```

thì vì `tail` không được cung cấp tên tệp nào,
nó sẽ chờ đọc dữ liệu từ bàn phím của bạn.
Điều này có nghĩa là nếu bạn gõ:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

thì `tail` sẽ tiếp tục và in ra ba dòng cuối của `somefile.txt`,
nhưng `head` sẽ chờ mãi dữ liệu từ bàn phím,
vì nó không được đưa tên tệp và cũng không có gì ở phía trước nó trong pipeline.

<hr>

Giả sử bạn lỡ gõ:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Bạn nên làm gì tiếp theo?

`@possible_answers`
- Chờ 10 giây để `head` tự hết thời gian.
- Gõ `somefile.txt` và nhấn Enter để cung cấp đầu vào cho `head`.
- Dùng `Ctrl` + `C` để dừng chương trình `head` đang chạy.

`@hint`
`head` sẽ làm gì nếu không có tên tệp và không có gì ở phía trước nó trong đường ống?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Không, các lệnh sẽ không bị hết thời gian chờ.'
a2 = 'Không, điều đó sẽ đưa cho `head` văn bản `somefile.txt` để xử lý, nhưng sau đó nó sẽ bị treo chờ thêm đầu vào.'
a3 = "Đúng vậy! Bạn nên sử dụng `Ctrl` + `C` để dừng một chương trình đang chạy. Khóa học giới thiệu này kết thúc tại đây! Nếu bạn quan tâm đến việc học thêm các công cụ dòng lệnh, chúng tôi khuyến khích bạn tham gia khóa học giới thiệu miễn phí về Git của chúng tôi!"
Ex().has_chosen(3, [a1, a2, a3])
```

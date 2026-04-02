---
title: Xử lý hàng loạt
description: >-
  Hầu hết các lệnh shell có thể xử lý nhiều tệp cùng lúc. Chương này cho bạn
  thấy cách khiến các pipeline của riêng bạn cũng làm được điều đó. Đồng thời,
  bạn sẽ thấy shell sử dụng biến để lưu trữ thông tin như thế nào.
lessons:
  - nb_of_exercises: 10
    title: Shell lưu trữ thông tin như thế nào?
---

## Shell lưu trữ thông tin như thế nào?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Giống như các chương trình khác, shell lưu thông tin trong các biến.
Một số biến trong đó,
được gọi là **environment variables** (biến môi trường),
luôn sẵn có.
Tên của các biến môi trường theo quy ước được viết IN HOA,
và một vài biến thường dùng được liệt kê bên dưới.

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | Thư mục home của người dùng       | `/home/repl`          |
| `PWD `   | Thư mục làm việc hiện tại         | Giống lệnh `pwd`      |
| `SHELL`  | Trình shell đang được sử dụng     | `/bin/bash`           |
| `USER`   | ID người dùng                     | `repl`                |

Để xem đầy đủ danh sách (khá dài),
bạn có thể gõ `set` trong shell.

<hr>

Dùng `set` và `grep` với một pipe để hiển thị giá trị của `HISTFILESIZE`,
biến quyết định có bao nhiêu lệnh cũ được lưu trong lịch sử lệnh của bạn.
Giá trị của nó là bao nhiêu?

`@possible_answers`
- 10
- 500
- [2000]
- The variable is not there.

`@hint`
Dùng `set | grep HISTFILESIZE` để lấy dòng bạn cần.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Không: shell ghi lại nhiều lịch sử hơn thế."
err2 = "Không: shell ghi lại nhiều lịch sử hơn thế."
correct3 = "Chính xác: shell lưu 2000 lệnh cũ theo mặc định trên hệ thống này."
err4 = "Không: biến `HISTFILESIZE` có ở đó."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Làm sao để in giá trị của một biến?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Cách đơn giản hơn để tìm giá trị của một biến là dùng lệnh `echo`, lệnh này sẽ in ra các đối số của nó. Gõ

```{shell}
echo hello DataCamp!
```

sẽ in

```
hello DataCamp!
```

Nếu bạn thử dùng nó để in giá trị của một biến như sau:

```{shell}
echo USER
```

nó sẽ in tên của biến, `USER`.

Để lấy giá trị của biến, bạn phải đặt ký hiệu đô-la `$` ở phía trước. Gõ 

```{shell}
echo $USER
```

sẽ in

```
repl
```

Điều này đúng ở mọi nơi:
để lấy giá trị của một biến tên là `X`,
bạn phải viết `$X`.
(Điều này giúp shell phân biệt giữa "một tệp tên là X"
và "giá trị của một biến tên là X".)

`@instructions`
Biến `OSTYPE` chứa tên của loại hệ điều hành bạn đang dùng.
Hiển thị giá trị của nó bằng `echo`.

`@hint`
Gọi `echo` với biến `OSTYPE` được thêm ký hiệu `$` ở phía trước.

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
            has_code('echo', incorrect_msg="Bạn đã gọi `echo` chưa?"),
            has_code('OSTYPE', incorrect_msg="Bạn đã in biến môi trường `OSTYPE` chưa?"),
            has_code(r'\$OSTYPE', incorrect_msg="Hãy chắc chắn thêm `$` trước `OSTYPE`.") 
        )
    )
)
Ex().success_msg("Bạn đã thực hiện xuất sắc việc echo các biến môi trường! Bạn đã có một khởi đầu tốt. Hãy tiếp tục!")
```

---

## Còn những cách nào khác mà shell lưu trữ thông tin?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Loại biến còn lại được gọi là **biến shell**,
giống như biến cục bộ trong một ngôn ngữ lập trình.

Để tạo một biến shell,
bạn chỉ cần gán một giá trị cho một tên:

```{shell}
training=seasonal/summer.csv
```

*lưu ý không* có khoảng trắng trước hoặc sau dấu `=`.
Sau khi làm vậy,
bạn có thể kiểm tra giá trị của biến bằng:

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
Định nghĩa một biến tên `testing` với giá trị `seasonal/winter.csv`.

`@hint`
Không được có khoảng trắng giữa tên biến và giá trị của nó.

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
        has_code('testing', incorrect_msg='Bạn đã định nghĩa một biến shell có tên là `testing` chưa?'),
        has_code('testing=', incorrect_msg='Bạn đã viết `=` ngay sau `testing`, không có khoảng trắng nào chưa?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Bạn đã đặt giá trị của `testing` thành `seasonal/winter.csv` chưa?')
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
Dùng `head -n 1 SOMETHING` để lấy dòng đầu tiên từ `seasonal/winter.csv`
sử dụng giá trị của biến `testing` thay cho tên tệp.

`@hint`
Nhớ dùng `$testing` thay vì chỉ `testing`
(ký hiệu `$` là cần thiết để lấy giá trị của biến).

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
    has_code(r'\$testing', incorrect_msg="Bạn đã tham chiếu biến shell bằng `$testing` chưa?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Bạn đã gọi `head` chưa?"),
            has_code('-n', incorrect_msg="Bạn đã giới hạn số dòng với `-n` chưa?"),
            has_code(r'-n\s+1', incorrect_msg="Bạn đã chọn giữ lại 1 dòng với `-n 1` chưa?")     
        )
    )
)
Ex().success_msg("Tuyệt vời! Hãy xem cách bạn có thể lặp lại các lệnh một cách dễ dàng.")
```

---

## Làm sao để lặp lại một lệnh nhiều lần?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Biến shell cũng được dùng trong **vòng lặp**,
để lặp lại lệnh nhiều lần.
Nếu bạn chạy lệnh sau:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

nó sẽ in ra:

```
gif
jpg
png
```

Lưu ý những điểm sau về vòng lặp:

1. Cấu trúc là `for` ...biến... `in` ...danh_sách... `; do` ...phần_thân... `; done`
2. Danh sách các mục mà vòng lặp sẽ xử lý (trong ví dụ này là các từ `gif`, `jpg` và `png`).
3. Biến dùng để theo dõi mục mà vòng lặp đang xử lý (trong ví dụ này là `filetype`).
4. Phần thân của vòng lặp thực hiện xử lý (trong ví dụ này là `echo $filetype`).

Lưu ý rằng phần thân dùng `$filetype` để lấy giá trị của biến thay vì chỉ `filetype`,
giống như bạn vẫn làm với bất kỳ biến shell nào khác.
Cũng lưu ý vị trí của dấu chấm phẩy:
dấu thứ nhất nằm giữa danh sách và từ khóa `do`,
và dấu thứ hai nằm giữa phần thân và từ khóa `done`.

`@instructions`
Sửa vòng lặp để nó in ra:

```
docx
odt
pdf
```

Vui lòng dùng `filetype` làm tên biến vòng lặp.

`@hint`
Hãy dùng cấu trúc mã trong phần giới thiệu, nhưng đổi loại tệp hình ảnh thành loại tệp tài liệu.

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
      has_code('for', incorrect_msg='Bạn đã gọi `for` chưa?'),
      has_code('filetype', incorrect_msg='Bạn đã sử dụng `filetype` làm biến vòng lặp chưa?'),
      has_code('in', incorrect_msg='Bạn đã sử dụng `in` trước danh sách các loại tệp chưa?'),
      has_code('docx odt pdf', incorrect_msg='Bạn đã lặp qua `docx`, `odt` và `pdf` theo thứ tự đó chưa?'),
      has_code(r'pdf\s*;', incorrect_msg='Bạn đã đặt dấu chấm phẩy sau phần tử cuối cùng của vòng lặp chưa?'),
      has_code(r';\s*do', incorrect_msg='Bạn đã sử dụng `do` sau dấu chấm phẩy đầu tiên chưa?'),
      has_code('echo', incorrect_msg='Bạn đã gọi `echo` chưa?'),
      has_code(r'\$filetype', incorrect_msg='Bạn đã echo `$filetype` chưa?'),
      has_code(r'filetype\s*;', incorrect_msg='Bạn đã đặt dấu chấm phẩy sau thân vòng lặp chưa?'),
      has_code('; done', incorrect_msg='Bạn đã kết thúc với `done` chưa?')
    )
  )
)
Ex().success_msg("Thật tuyệt vời khi sử dụng vòng lặp! Vòng lặp rất tuyệt vời nếu bạn muốn làm cùng một việc hàng trăm hoặc hàng nghìn lần.")
```

---

## Làm sao lặp lại một lệnh cho từng tệp?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Bạn luôn có thể gõ trực tiếp tên các tệp muốn xử lý khi viết vòng lặp,
nhưng thường thì dùng ký tự đại diện sẽ tốt hơn.
Hãy thử chạy vòng lặp này trong console:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Vòng lặp in ra:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

vì shell sẽ mở rộng `seasonal/*.csv` thành danh sách bốn tên tệp
trước khi chạy vòng lặp.

`@instructions`
Sửa biểu thức ký tự đại diện thành `people/*`
để vòng lặp in tên các tệp trong thư mục `people`
bất kể chúng có hay không có phần đuôi nào.
Vui lòng dùng `filename` làm tên biến vòng lặp của bạn.

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
      has_code('for', incorrect_msg='Bạn đã gọi `for` chưa?'),
      has_code('filename', incorrect_msg='Bạn đã sử dụng `filename` làm biến vòng lặp chưa?'),
      has_code('in', incorrect_msg='Bạn đã sử dụng `in` trước danh sách các loại tệp chưa?'),
      has_code('people/\*', incorrect_msg='Bạn đã chỉ định danh sách các tệp với `people/*` chưa?'),
      has_code(r'people/\*\s*;', incorrect_msg='Bạn đã đặt dấu chấm phẩy sau danh sách các tệp chưa?'),
      has_code(r';\s*do', incorrect_msg='Bạn đã sử dụng `do` sau dấu chấm phẩy đầu tiên chưa?'),
      has_code('echo', incorrect_msg='Bạn đã gọi `echo` chưa?'),
      has_code(r'\$filename', incorrect_msg='Bạn đã echo `$filename` chưa?'),
      has_code(r'filename\s*;', incorrect_msg='Bạn đã đặt dấu chấm phẩy sau thân vòng lặp chưa?'),
      has_code('; done', incorrect_msg='Bạn đã kết thúc với `done` chưa?')
    )
  )
)
Ex().success_msg("Vòng lặp Loopy! Ký tự đại diện và vòng lặp tạo thành một sự kết hợp mạnh mẽ.")
```

---

## Làm sao để lưu lại tên của một nhóm tệp?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Mọi người thường gán một biến bằng biểu thức wildcard để lưu danh sách tên tệp.
Ví dụ,
nếu bạn định nghĩa `datasets` như sau:

```{shell}
datasets=seasonal/*.csv
```

bạn có thể hiển thị tên các tệp sau đó bằng:

```{shell}
for filename in $datasets; do echo $filename; done
```

Cách này giúp đỡ phải gõ nhiều và giảm khả năng mắc lỗi.

<hr>

Nếu bạn chạy hai lệnh này trong thư mục home của mình,
chúng sẽ in ra bao nhiêu dòng?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Không có: vì `files` được định nghĩa ở một dòng riêng, nên nó không có giá trị ở dòng thứ hai.
- Một: từ "files".
- Bốn: tên của cả bốn tệp dữ liệu theo mùa.

`@hint`
Hãy nhớ rằng `X` khi đứng một mình chỉ là "X", còn `$X` là giá trị của biến `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Không: bạn không cần phải định nghĩa một biến trên cùng một dòng mà bạn sử dụng nó."
err2 = "Không: ví dụ này định nghĩa và sử dụng biến `files` trong cùng một shell."
correct3 = "Chính xác. Lệnh này tương đương với `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Tên biến và giá trị của biến

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Một lỗi thường gặp là quên đặt `$` trước tên biến.
Khi làm vậy,
shell sẽ dùng chính cái tên bạn gõ
thay vì giá trị của biến đó.

Một lỗi phổ biến khác với người dùng có kinh nghiệm là gõ sai tên biến.
Ví dụ,
nếu bạn định nghĩa `datasets` như sau:

```{shell}
datasets=seasonal/*.csv
```

rồi gõ:

```{shell}
echo $datsets
```

thì shell sẽ không in gì cả,
vì `datsets` (thiếu chữ "a" thứ hai) chưa được định nghĩa.

<hr>

Nếu bạn chạy hai lệnh sau trong thư mục home của mình,
đầu ra sẽ in ra gì?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Hãy đọc kỹ phần đầu của vòng lặp trước khi trả lời.)

`@hint`
Hãy nhớ rằng `X` tự thân chỉ là "X", còn `$X` mới là giá trị của biến `X`.

`@possible_answers`
- [Một dòng: từ "files".]
- Bốn dòng: tên của cả bốn tệp dữ liệu theo mùa.
- Bốn dòng trống: biến `f` không được gán giá trị.

`@feedback`
- Đúng: vòng lặp dùng `files` thay vì `$files`, nên danh sách chỉ gồm từ "files".
- Không: vòng lặp dùng `files` thay vì `$files`, nên danh sách gồm từ "files" chứ không phải phần mở rộng của `files`.
- Không: biến `f` được `for` tự động gán trong vòng lặp.

---

## Làm sao chạy nhiều lệnh trong một vòng lặp duy nhất?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

In tên tệp rất hữu ích để gỡ lỗi,
nhưng mục đích thực sự của vòng lặp là xử lý nhiều tệp.
Vòng lặp này in ra dòng thứ hai của mỗi tệp dữ liệu:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Nó có cùng cấu trúc với các vòng lặp bạn đã thấy trước đó:
điểm khác biệt là phần thân của nó là một pipeline gồm hai lệnh thay vì một lệnh đơn.

`@instructions`
Hãy viết một vòng lặp in ra mục cuối cùng của tháng 7 năm 2017 (`2017-07`) trong mỗi tệp seasonal. Vòng lặp nên cho đầu ra tương tự như:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

nhưng áp dụng riêng cho **_từng_** tệp seasonal. Vui lòng dùng `file` làm tên biến vòng lặp, và nhớ lặp qua danh sách tệp `seasonal/*.csv` (_thay vì 'seasonal/winter.csv' như trong ví dụ_).

`@hint`
Phần thân vòng lặp là lệnh grep được nêu trong phần hướng dẫn, với `seasonal/winter.csv` được thay bằng `$file`.

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
  has_code('for', incorrect_msg='Bạn đã gọi `for` chưa?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Bạn đã sử dụng `file` làm biến vòng lặp chưa?'),
      has_code('in', incorrect_msg='Bạn đã sử dụng `in` trước danh sách các tệp chưa?'),
      has_code('seasonal/\*', incorrect_msg='Bạn đã chỉ định danh sách các tệp với `seasonal/*` chưa?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Bạn đã đặt dấu chấm phẩy sau danh sách các tệp chưa?'),
      has_code(r';\s*do', incorrect_msg='Bạn đã sử dụng `do` sau dấu chấm phẩy đầu tiên chưa?'),
      has_code('grep', incorrect_msg='Bạn đã gọi `grep` chưa?'),
      has_code('2017-07', incorrect_msg='Bạn đã khớp với `2017-07` chưa?'),
      has_code(r'\$file', incorrect_msg='Bạn đã sử dụng `$file` làm tên biến vòng lặp chưa?'),
      has_code(r'file\s*|', incorrect_msg='Bạn đã sử dụng một pipe để kết nối lệnh thứ hai của bạn chưa?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Bạn đã sử dụng `tail -n 1` để in mục cuối cùng của mỗi lần tìm kiếm trong lệnh thứ hai của bạn chưa?'),
      has_code('; done', incorrect_msg='Bạn đã kết thúc với `done` chưa?')
    )
  )
)

Ex().success_msg("Vòng lặp loopy! Ký tự đại diện và vòng lặp tạo thành một sự kết hợp mạnh mẽ.")
```

---

## Vì sao không nên dùng dấu cách trong tên tệp?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Khi dùng trình quản lý tệp đồ họa, đặt tên tệp nhiều từ như `July 2017.csv` vừa dễ vừa hợp lý.
Tuy nhiên,
điều này gây rắc rối khi bạn làm việc trong shell.
Ví dụ,
giả sử bạn muốn đổi tên `July 2017.csv` thành `2017 July data.csv`.
Bạn không thể gõ:

```{shell}
mv July 2017.csv 2017 July data.csv
```

vì shell sẽ nghĩ rằng bạn đang cố di chuyển
bốn tệp tên là `July`, `2017.csv`, `2017`, và `July` (lần nữa)
vào một thư mục tên `data.csv`.
Thay vào đó,
bạn phải đặt tên tệp trong dấu nháy
để shell coi mỗi tên là một tham số đơn lẻ:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Nếu bạn có hai tệp tên `current.csv` và `last year.csv`
(có dấu cách trong tên)
và bạn gõ:

```{shell}
rm current.csv last year.csv
```

thì chuyện gì sẽ xảy ra:

`@hint`
Bạn sẽ nghĩ điều gì sẽ xảy ra nếu ai đó đưa bạn lệnh này mà bạn không biết trong thư mục đang có những tệp nào?

`@possible_answers`
- Shell sẽ in thông báo lỗi vì `last` và `year.csv` không tồn tại.
- Shell sẽ xóa `current.csv`.
- [Cả hai ý trên.]
- Không có gì xảy ra.

`@feedback`
- Đúng, nhưng chưa phải tất cả.
- Đúng, nhưng chưa phải tất cả.
- Chính xác. Bạn có thể dùng dấu nháy đơn, `'`, hoặc dấu nháy kép, `"`, để bao quanh tên tệp.
- Tiếc là không đúng.

---

## Làm sao để thực hiện nhiều việc trong một vòng lặp duy nhất?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Các vòng lặp bạn đã thấy đến giờ chỉ có một lệnh hoặc một pipeline trong thân,
nhưng một vòng lặp có thể chứa bao nhiêu lệnh cũng được.
Để cho shell biết lệnh này kết thúc và lệnh kế tiếp bắt đầu ở đâu,
bạn phải ngăn cách chúng bằng dấu chấm phẩy:

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

Giả sử bạn quên dấu chấm phẩy giữa `echo` và `head` trong vòng lặp trước,
để rồi yêu cầu shell chạy:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Shell sẽ làm gì?

`@possible_answers`
- In ra một thông báo lỗi.
- In một dòng cho mỗi trong bốn tệp.
- In một dòng cho `autumn.csv` (tệp đầu tiên).
- In dòng cuối của mỗi tệp.

`@hint`
Bạn có thể pipe đầu ra của `echo` vào `tail`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Không: vòng lặp sẽ chạy, chỉ là nó sẽ không thực hiện điều gì có ý nghĩa."
correct2 = "Đúng: `echo` tạo ra một dòng bao gồm tên tệp hai lần, sau đó `tail` sao chép."
err3 = "Không: vòng lặp chạy một lần cho mỗi trong bốn tên tệp."
err4 = "Không: đầu vào của `tail` là đầu ra của `echo` cho mỗi tên tệp."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

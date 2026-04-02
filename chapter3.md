---
title: Kết hợp công cụ
description: >-
  Sức mạnh thực sự của Unix shell không nằm ở từng lệnh riêng lẻ, mà ở khả năng
  kết hợp chúng dễ dàng để làm những việc mới. Chương này sẽ hướng dẫn bạn tận
  dụng sức mạnh đó để chọn dữ liệu mong muốn, và giới thiệu các lệnh để sắp xếp
  giá trị và loại bỏ trùng lặp.
lessons:
  - nb_of_exercises: 12
    title: Làm sao lưu đầu ra của một lệnh vào tệp?
---

## Làm thế nào để lưu đầu ra của một lệnh vào tệp?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Tất cả các công cụ bạn đã thấy đến giờ đều cho phép bạn chỉ định tệp đầu vào.
Hầu hết không có tùy chọn đặt tên tệp đầu ra vì họ không cần.
Thay vào đó,
bạn có thể dùng **chuyển hướng (redirection)** để lưu đầu ra của bất kỳ lệnh nào đến nơi bạn muốn.
Nếu bạn chạy lệnh này:

```{shell}
head -n 5 seasonal/summer.csv
```

nó sẽ in 5 dòng đầu tiên của dữ liệu mùa hè lên màn hình.
Nếu thay vào đó bạn chạy lệnh này:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

sẽ không có gì xuất hiện trên màn hình.
Thay vào đó,
đầu ra của `head` được ghi vào một tệp mới tên là `top.csv`.
Bạn có thể xem nội dung của tệp đó bằng `cat`:

```{shell}
cat top.csv
```

Dấu lớn hơn `>` cho shell biết cần chuyển hướng đầu ra của `head` vào một tệp.
Nó không phải là một phần của lệnh `head`;
thay vào đó,
nó hoạt động với mọi lệnh shell tạo ra đầu ra.

`@instructions`
Kết hợp `tail` với chuyển hướng để lưu 5 dòng cuối của `seasonal/winter.csv` vào một tệp tên `last.csv`.

`@hint`
Dùng `tail -n 5` để lấy 5 dòng cuối cùng.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "Dòng `%s` phải có trong tệp `last.csv`, nhưng không có. Hãy chuyển hướng đầu ra của `tail -n 5 seasonal/winter.csv` đến `last.csv` với `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` có quá nhiều dòng. Bạn đã sử dụng cờ `-n 5` với `tail` chưa?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Tuyệt! Hãy thực hành thêm một chút nữa!")
```

---

## Làm cách nào dùng đầu ra của lệnh này làm đầu vào cho lệnh khác?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Giả sử bạn muốn lấy các dòng ở giữa một tệp.
Cụ thể hơn,
giả sử bạn muốn lấy các dòng 3–5 từ một trong các tệp dữ liệu của chúng ta.
Bạn có thể bắt đầu bằng cách dùng `head` để lấy 5 dòng đầu tiên
rồi chuyển hướng đầu ra đó vào một tệp,
sau đó dùng `tail` để chọn 3 dòng cuối:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Kiểm tra nhanh cho thấy đây đúng là các dòng 3–5 của tệp gốc,
vì đó chính là 3 dòng cuối trong 5 dòng đầu tiên.

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
Chọn hai dòng cuối cùng từ `seasonal/winter.csv`
và lưu vào một tệp tên `bottom.csv`.

`@hint`
Dùng `tail` để chọn các dòng và `>` để chuyển hướng đầu ra của `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="Dòng `%s` phải có trong tệp `bottom.csv`, nhưng không có. Hãy chuyển hướng đầu ra của `tail -n 2 seasonal/winter.csv` đến `bottom.csv` với `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` có quá nhiều dòng. Bạn đã sử dụng cờ `-n 2` với `tail` chưa?'),
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
Chọn dòng đầu tiên từ `bottom.csv`
để lấy dòng áp chót của tệp gốc.

`@hint`
Dùng `head` để chọn dòng bạn cần.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Có điều gì đó không ổn với tệp `bottom.csv`. Hãy chắc chắn rằng bạn không thay đổi nó!"),
    has_expr_output(strict=True, incorrect_msg="Bạn đã sử dụng `head` đúng cách trên `bottom.csv` chưa? Hãy chắc chắn sử dụng cờ `-n` đúng cách.")
)

Ex().success_msg("Làm tốt lắm. Hãy chuyển sang bài tập tiếp theo để tìm hiểu về những cách tốt hơn để kết hợp các lệnh.")                             

```

---

## Kết hợp các lệnh theo cách nào hiệu quả hơn?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Kết hợp các lệnh bằng chuyển hướng có hai nhược điểm:

1. Nó để lại rất nhiều tệp trung gian (như `top.csv`).
2. Các lệnh để tạo ra kết quả cuối cùng bị rải rác qua nhiều dòng trong lịch sử.

Shell cung cấp một công cụ khác giải quyết cả hai vấn đề này cùng lúc, gọi là **pipe**.
Một lần nữa,
bắt đầu bằng cách chạy `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

Thay vì gửi đầu ra của `head` vào một tệp,
thêm một dấu gạch dọc và lệnh `tail` *không* có tên tệp:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Ký hiệu pipe cho shell biết dùng đầu ra của lệnh bên trái
làm đầu vào cho lệnh bên phải.

`@instructions`
Dùng `cut` để chọn tất cả tên răng từ cột 2 của tệp phân tách bằng dấu phẩy `seasonal/summer.csv`, rồi pipe kết quả sang `grep` với chế độ đối sánh đảo ngược để loại trừ dòng tiêu đề chứa từ "Tooth". *`cut` và `grep` đã được trình bày chi tiết ở Chương 2, lần lượt trong bài tập 8 và 11.*

`@hint`
- Phần đầu của lệnh có dạng `cut -d field_delimiter -f column_number filename`.
- Phần thứ hai của lệnh có dạng `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'Bạn đã chuyển kết quả của `cut -d , -f 2 seasonal/summer.csv` vào `grep -v Tooth` với `|` chưa?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Bạn đã loại trừ dòng tiêu đề `"Tooth"` bằng cách sử dụng `grep` chưa?')
)
Ex().success_msg("Thao tác chuyển đổi hoàn hảo! Đây có thể là lần đầu tiên bạn sử dụng `|`, nhưng chắc chắn không phải là lần cuối cùng!")
```

---

## Làm sao để kết hợp nhiều lệnh?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Bạn có thể xâu chuỗi bất kỳ số lượng lệnh nào lại với nhau.
Ví dụ,
lệnh này:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

sẽ:

1. chọn cột đầu tiên từ dữ liệu mùa xuân;
2. loại bỏ dòng tiêu đề chứa từ "Date"; và
3. chọn 10 dòng dữ liệu thực đầu tiên.

`@instructions`
Trong bài trước, bạn đã dùng lệnh sau để lấy tất cả tên răng ở cột 2 của `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Mở rộng pipeline này với lệnh `head` để chỉ lấy duy nhất tên răng đầu tiên.

`@hint`
Sao chép và dán đoạn mã trong phần hướng dẫn, thêm một dấu ống, rồi gọi `head` với cờ `-n`.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Bạn đã sử dụng `|` để mở rộng pipeline với lệnh `head` chưa? Hãy chắc chắn đặt cờ `-n` đúng cách."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Bạn đã sử dụng `|` để mở rộng pipeline với lệnh `head` chưa?")
)
Ex().success_msg("Liên kết vui vẻ! Bằng cách liên kết nhiều lệnh lại với nhau, bạn có thể xây dựng các pipeline xử lý dữ liệu mạnh mẽ.")
```

---

## Làm sao đếm số bản ghi trong một tệp?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Lệnh `wc` (viết tắt của "word count") in ra số **k**ý tự, **t**ừ và **d**òng trong một tệp.
Bạn có thể bắt nó chỉ in một trong các thông tin này lần lượt bằng `-c`, `-w`, hoặc `-l`.

`@instructions`
Hãy đếm có bao nhiêu bản ghi trong `seasonal/spring.csv` có ngày thuộc tháng 7 năm 2017 (`2017-07`). 
- Để làm điều này, dùng `grep` với một phần của ngày để chọn các dòng, rồi pipe kết quả này sang `wc` với cờ phù hợp để đếm số dòng.

`@hint`
- Dùng `head seasonal/spring.csv` để xem lại định dạng ngày tháng.
- Phần đầu của lệnh có dạng `grep thing_to_match filename`.
- Sau dấu pipe `|`, gọi `wc` với cờ `-l`.

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
      has_code("grep", incorrect_msg = "Bạn đã gọi `grep` chưa?"),
      has_code("2017-07", incorrect_msg = "Bạn đã tìm kiếm `2017-07` chưa?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Bạn đã tìm kiếm tệp `seasonal/spring.csv` chưa?"),
      has_code("|", incorrect_msg = "Bạn đã sử dụng `|` để chuyển tiếp đến `wc` chưa?"),      
      has_code("wc", incorrect_msg = "Bạn đã gọi `wc` chưa?"),
      has_code("-l", incorrect_msg = "Bạn đã đếm số dòng với `-l` chưa?")
    )
  )
)
Ex().success_msg("Đếm cẩn thận! Xác định lượng dữ liệu bạn có là bước đầu tiên tuyệt vời trong bất kỳ phân tích dữ liệu nào.")
```

---

## Làm sao chỉ định nhiều tệp cùng lúc?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

Hầu hết các lệnh shell sẽ chạy trên nhiều tệp nếu bạn đưa cho chúng nhiều tên tệp.
Ví dụ,
bạn có thể lấy cột đầu tiên từ tất cả các tệp dữ liệu theo mùa cùng lúc như sau:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Nhưng việc gõ lặp đi lặp lại nhiều tên tệp là một ý tưởng tệ:
vừa tốn thời gian,
và sớm muộn gì bạn cũng sẽ bỏ sót một tệp hoặc lặp lại tên tệp.
Để giúp bạn làm việc hiệu quả hơn,
shell cho phép dùng **wildcard** để chỉ định một danh sách tệp bằng một biểu thức duy nhất.
Wildcard phổ biến nhất là `*`,
nghĩa là "khớp không hoặc nhiều ký tự".
Dùng ký tự này,
chúng ta có thể rút gọn lệnh `cut` ở trên thành:

```{shell}
cut -d , -f 1 seasonal/*
```

hoặc:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Viết một lệnh duy nhất dùng `head` để lấy ba dòng đầu tiên từ cả `seasonal/spring.csv` và `seasonal/summer.csv`, tổng cộng sáu dòng dữ liệu, nhưng không lấy từ các tệp dữ liệu autumn hoặc winter.
Hãy dùng wildcard thay vì gõ đầy đủ tên các tệp.

`@hint`
- Lệnh có dạng `head -n number_of_lines filename_pattern`.
- Bạn có thể khớp các tệp trong thư mục `a`, bắt đầu bằng `b`, bằng cách dùng `a/b*`, chẳng hạn.

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
    has_expr_output(incorrect_msg = "Bạn có thể sử dụng `seasonal/s*` để chọn `seasonal/spring.csv` và `seasonal/summer.csv`. Hãy chắc chắn chỉ bao gồm ba dòng đầu tiên của mỗi tệp với cờ `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Đừng bao gồm đầu ra cho `seasonal/autumn.csv`. Bạn có thể sử dụng `seasonal/s*` để chọn `seasonal/spring.csv` và `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Đừng bao gồm đầu ra cho `seasonal/winter.csv`. Bạn có thể sử dụng `seasonal/s*` để chọn `seasonal/spring.csv` và `seasonal/summer.csv`")
)
Ex().success_msg("Công việc wildcard tuyệt vời! Điều này trở nên quan trọng hơn nếu thư mục của bạn chứa hàng trăm hoặc hàng nghìn tệp.")
```

---

## Mình còn có thể dùng những ký tự đại diện nào khác?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Shell còn có những ký tự đại diện khác,
mặc dù chúng ít dùng hơn:

- `?` khớp một ký tự đơn, nên `201?.txt` sẽ khớp `2017.txt` hoặc `2018.txt`, nhưng không khớp `2017-01.txt`.
- `[...]` khớp bất kỳ một ký tự nào bên trong dấu ngoặc vuông, nên `201[78].txt` khớp `2017.txt` hoặc `2018.txt`, nhưng không khớp `2016.txt`.
- `{...}` khớp bất kỳ mẫu nào, phân tách bằng dấu phẩy, bên trong dấu ngoặc nhọn, nên `{*.txt, *.csv}` khớp mọi tệp có tên kết thúc bằng `.txt` hoặc `.csv`, nhưng không khớp các tệp có tên kết thúc bằng `.pdf`.

<hr/>

Biểu thức nào sẽ khớp `singh.pdf` và `johel.txt` nhưng KHÔNG khớp `sandhu.pdf` hoặc `sandhu.txt`?

`@hint`
Lần lượt so khớp từng biểu thức với từng tên tệp.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Không đúng: `.pdf` và `.txt` không phải là tên tệp.
- Không đúng: biểu thức này sẽ khớp `sandhu.pdf`.
- Không đúng: biểu thức trong dấu ngoặc vuông chỉ khớp MỘT ký tự, không phải cả từ.
- Chính xác!

---

## Làm thế nào để sắp xếp các dòng văn bản?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Đúng như tên gọi, `sort` dùng để sắp xếp dữ liệu. Mặc định, lệnh này sắp xếp theo thứ tự bảng chữ cái tăng dần, nhưng bạn có thể dùng các cờ `-n` và `-r` để sắp xếp theo số và đảo ngược thứ tự đầu ra. Cờ `-b` yêu cầu bỏ qua khoảng trắng ở đầu dòng và `-f` yêu cầu **f**old chữ hoa/thường (tức là không phân biệt hoa thường). Các pipeline thường dùng `grep` để loại bỏ các bản ghi không mong muốn rồi dùng `sort` để sắp xếp các bản ghi còn lại.

`@instructions`
Bạn còn nhớ cách kết hợp `cut` và `grep` để lấy tất cả tên răng ở cột 2 của `seasonal/summer.csv` chứ?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Bắt đầu từ “công thức” này, hãy sắp xếp tên các răng trong `seasonal/winter.csv` (không phải `summer.csv`) theo thứ tự bảng chữ cái giảm dần. Để làm điều này, hãy mở rộng pipeline với một bước `sort`.

`@hint`
Sao chép và dán lệnh trong phần hướng dẫn, đổi tên tệp, thêm một pipe, rồi gọi `sort` với cờ `-r`.

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
      has_code("cut", incorrect_msg = "Bạn đã gọi `cut` chưa?"),
      has_code("-d", incorrect_msg = "Bạn đã chỉ định một dấu phân cách trường với `-d` chưa?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Bạn đã lấy dữ liệu từ tệp `seasonal/winter.csv` chưa?"),
      has_code("|", incorrect_msg = "Bạn đã sử dụng `|` để chuyển từ `cut` sang `grep` rồi `sort` chưa?"),      
      has_code("grep", incorrect_msg = "Bạn đã gọi `grep` chưa?"),
      has_code("-v", incorrect_msg = "Bạn đã đảo ngược kết quả khớp với `-v` chưa?"),
      has_code("Tooth", incorrect_msg = "Bạn đã tìm kiếm `Tooth` chưa?"),
      has_code("sort", incorrect_msg = "Bạn đã gọi `sort` chưa?"),
      has_code("-r", incorrect_msg = "Bạn đã đảo ngược thứ tự sắp xếp với `-r` chưa?")
    )
  )
)
Ex().success_msg("Đã sắp xếp! `sort` có nhiều cách sử dụng. Ví dụ, chuyển `sort -n` sang `head` sẽ hiển thị cho bạn các giá trị lớn nhất.")
```

---

## Làm thế nào để loại bỏ các dòng trùng lặp?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Một lệnh khác thường dùng với `sort` là `uniq`,
chức năng của nó là loại bỏ các dòng trùng lặp.
Cụ thể hơn,
nó loại bỏ các dòng trùng lặp đứng cạnh nhau.
Nếu một tệp chứa:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

thì `uniq` sẽ tạo ra:

```
2017-07-03
2017-08-03
```

nhưng nếu tệp chứa:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

thì `uniq` sẽ in cả bốn dòng.
Lý do là `uniq` được thiết kế để làm việc với các tệp rất lớn.
Để loại bỏ các dòng trùng lặp không liền kề khỏi một tệp,
nó sẽ phải giữ toàn bộ tệp trong bộ nhớ
(hoặc ít nhất là
mọi dòng duy nhất đã thấy cho đến lúc đó).
Bằng cách chỉ loại bỏ các bản sao liền kề,
nó chỉ cần giữ dòng duy nhất gần nhất trong bộ nhớ.

`@instructions`
Viết một pipeline để:

- lấy cột thứ hai từ `seasonal/winter.csv`,
- loại bỏ từ "Tooth" khỏi đầu ra để chỉ còn tên răng được hiển thị,
- sắp xếp đầu ra để mọi lần xuất hiện của cùng một tên răng nằm cạnh nhau; và
- hiển thị mỗi tên răng một lần kèm số lần xuất hiện.

Phần bắt đầu của pipeline giống bài trước:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Mở rộng nó với lệnh `sort`, và dùng `uniq -c` để hiển thị các dòng duy nhất kèm số lần xuất hiện của mỗi dòng, thay vì dùng `uniq` và `wc`.

`@hint`
Sao chép và dán lệnh trong phần hướng dẫn, pipe sang `sort` không dùng cờ, rồi pipe tiếp sang `uniq` với cờ `-c`.

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
                     incorrect_msg="Bạn nên bắt đầu từ lệnh này: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Bây giờ hãy mở rộng nó!"),
            has_code('\|\s+sort', incorrect_msg="Bạn đã mở rộng lệnh với `| sort` chưa?"),
            has_code('\|\s+uniq', incorrect_msg="Bạn đã mở rộng lệnh với `| uniq` chưa?"),
            has_code('-c', incorrect_msg="Bạn đã bao gồm số đếm với `-c` chưa?")
        )
    )
)
Ex().success_msg("Tuyệt vời! Sau tất cả công việc này trên một đường ống, sẽ rất tốt nếu chúng ta có thể lưu trữ kết quả, phải không?")
```

---

## Làm sao lưu đầu ra của một pipeline?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Shell cho phép bạn chuyển hướng đầu ra của một chuỗi lệnh được nối bằng pipe:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Tuy nhiên, `>` phải xuất hiện ở cuối pipeline:
nếu bạn cố dùng nó ở giữa, như thế này:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

thì toàn bộ đầu ra từ `cut` sẽ được ghi vào `teeth-only.txt`,
nên không còn gì cho `grep`
và nó sẽ chờ vô hạn để nhận đầu vào.

<hr>

Điều gì xảy ra nếu chúng ta đặt chuyển hướng ở đầu một pipeline như sau:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [Đầu ra của lệnh được chuyển hướng vào tệp như bình thường.]
- Shell báo lỗi.
- Shell chờ đầu vào vô thời hạn.

`@hint`
Hãy thử chạy ngay trong shell.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Chính xác!', 'Không; thực tế là shell có thể thực thi điều này.', 'Không; thực tế là shell có thể thực thi điều này.'])
```

---

## Làm thế nào để dừng một chương trình đang chạy?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Các lệnh và script bạn đã chạy đến giờ đều thực thi rất nhanh,
nhưng một số tác vụ có thể mất hàng phút, hàng giờ, thậm chí vài ngày để hoàn thành.
Bạn cũng có thể lỡ đặt chuyển hướng ở giữa một pipeline,
khiến nó treo.
Nếu bạn quyết định không muốn chương trình tiếp tục chạy nữa,
bạn có thể nhấn `Ctrl` + `C` để kết thúc.
Cách viết này thường được ghi là `^C` trong tài liệu Unix;
chú ý rằng chữ 'c' có thể là chữ thường.

`@instructions`
Chạy lệnh:

```{shell}
head
```

không kèm đối số (để nó chờ đầu vào sẽ không bao giờ đến)
rồi dừng lại bằng cách nhấn `Ctrl` + `C`.

`@hint`
Chỉ cần gõ head, nhấn Enter và thoát chương trình đang chạy bằng `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Bạn đã sử dụng `head` chưa?")
```

---

## Tổng kết

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Để tổng kết,
bạn sẽ xây dựng một pipeline để tìm xem trong các tệp dữ liệu theo mùa, tệp ngắn nhất có bao nhiêu bản ghi.

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
Dùng `wc` với các tham số phù hợp để liệt kê số dòng trong tất cả các tệp dữ liệu theo mùa.
(Hãy dùng ký tự đại diện cho tên tệp thay vì gõ thủ công từng tên.)

`@hint`
Dùng `-l` để chỉ liệt kê số dòng và `*` để khớp tên tệp.

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
      has_code("wc", incorrect_msg = "Bạn đã gọi `wc` chưa?"),
      has_code("-l", incorrect_msg = "Bạn đã đếm số dòng với `-l` chưa?"),
      has_code("seasonal/\*", incorrect_msg = "Bạn đã lấy dữ liệu từ tất cả các tệp `seasonal/*` chưa?")
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
Thêm một lệnh nữa vào lệnh trước đó bằng một pipe để loại bỏ dòng chứa từ "total".

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
      has_code("wc", incorrect_msg = "Bạn đã gọi `wc` chưa?"),
      has_code("-l", incorrect_msg = "Bạn đã đếm số dòng với `-l` chưa?"),
      has_code("seasonal/\*", incorrect_msg = "Bạn đã lấy dữ liệu từ tất cả các tệp `seasonal/*` chưa?"),
      has_code("|", incorrect_msg = "Bạn đã sử dụng `|` để chuyển từ `wc` sang `grep` chưa?"),      
      has_code("grep", incorrect_msg = "Bạn đã gọi `grep` chưa?"),
      has_code("-v", incorrect_msg = "Bạn đã đảo ngược kết quả khớp với `-v` chưa?"),
      has_code("total", incorrect_msg = "Bạn đã tìm kiếm `total` chưa?")
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
Thêm hai bước nữa vào pipeline, dùng `sort -n` và `head -n 1` để tìm tệp có ít dòng nhất.

`@hint`
- Dùng cờ `-n` của `sort` để sắp xếp theo số.
- Dùng cờ `-n` của `head` để giới hạn còn 1 dòng.

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
      has_code("wc", incorrect_msg = "Bạn đã gọi `wc` chưa?"),
      has_code("-l", incorrect_msg = "Bạn đã đếm số dòng với `-l` chưa?"),
      has_code("seasonal/\*", incorrect_msg = "Bạn đã lấy dữ liệu từ tất cả các tệp `seasonal/*` chưa?"),
      has_code("|", incorrect_msg = "Bạn đã sử dụng `|` để chuyển từ `wc` sang `grep` sang `sort` sang `head` chưa?"),      
      has_code("grep", incorrect_msg = "Bạn đã gọi `grep` chưa?"),
      has_code("-v", incorrect_msg = "Bạn đã đảo ngược kết quả khớp với `-v` chưa?"),
      has_code("total", incorrect_msg = "Bạn đã tìm kiếm `total` chưa?"),
      has_code("sort", incorrect_msg = "Bạn đã gọi `sort` chưa?"),
      has_code("-n", incorrect_msg = "Bạn đã chỉ định số dòng cần giữ lại với `-n` chưa?"),
      has_code("1", incorrect_msg = "Bạn đã chỉ định 1 dòng cần giữ lại với `-n 1` chưa?")
    )
  )
)
Ex().success_msg("Tuyệt vời! Hóa ra `autumn.csv` là tệp có ít dòng nhất. Hãy chuyển sang chương 4 để tìm hiểu thêm về xử lý hàng loạt!")
```

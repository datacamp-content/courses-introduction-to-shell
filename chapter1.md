---
title: Làm việc với tệp và thư mục
description: >-
  Chương này là phần giới thiệu ngắn về Unix shell. Bạn sẽ biết vì sao nó vẫn
  được dùng sau gần 50 năm, nó khác gì so với các công cụ đồ họa mà bạn quen
  thuộc, cách di chuyển trong shell, và cách tạo, sửa, xóa tệp và thư mục.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Shell khác gì so với giao diện desktop?
---

## So sánh shell với giao diện desktop như thế nào?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Một hệ điều hành như Windows, Linux hoặc Mac OS là một loại chương trình đặc biệt.
Nó điều khiển bộ xử lý, ổ cứng và kết nối mạng của máy tính,
nhưng nhiệm vụ quan trọng nhất của nó là chạy các chương trình khác.

Vì con người không phải là số hóa,
họ cần một giao diện để tương tác với hệ điều hành.
Ngày nay, cách phổ biến nhất là trình duyệt tệp dạng đồ họa,
chuyển các cú nhấp và nhấp đúp thành lệnh để mở tệp và chạy chương trình.
Trước khi máy tính có màn hình đồ họa,
thì
mọi người gõ hướng dẫn vào một chương trình gọi là **command-line shell**.
Mỗi khi một lệnh được nhập,
shell sẽ chạy một số chương trình khác,
in đầu ra của chúng ở dạng con người có thể đọc được,
và sau đó hiển thị một *prompt* để báo hiệu rằng nó đã sẵn sàng nhận lệnh tiếp theo.
(Tên của nó xuất phát từ ý tưởng rằng nó là "lớp vỏ ngoài" của máy tính.)

Gõ lệnh thay vì nhấp và kéo có thể có vẻ vụng về lúc đầu,
nhưng như bạn sẽ thấy,
khi bạn bắt đầu diễn đạt rõ ràng điều bạn muốn máy tính thực hiện,
bạn có thể kết hợp các lệnh cũ để tạo ra lệnh mới
và tự động hóa các thao tác lặp lại
chỉ với vài lần gõ phím.

<hr>
Mối quan hệ giữa trình duyệt tệp dạng đồ họa mà hầu hết mọi người sử dụng và command-line shell là gì?

`@hint`
Hãy nhớ rằng người dùng chỉ có thể tương tác với hệ điều hành thông qua một chương trình.

`@possible_answers`
- Trình duyệt tệp cho phép bạn xem và chỉnh sửa tệp, còn shell cho phép bạn chạy chương trình.
- Trình duyệt tệp được xây dựng dựa trên shell.
- Shell là một phần của hệ điều hành, còn trình duyệt tệp là riêng biệt.
- [Cả hai đều là giao diện để phát lệnh cho hệ điều hành.]

`@feedback`
- Cả hai đều cho phép bạn xem và chỉnh sửa tệp cũng như chạy chương trình.
- Trình duyệt tệp dạng đồ họa và shell đều gọi cùng các hàm hệ điều hành nằm bên dưới.
- Shell và trình duyệt tệp đều là các chương trình chuyển lệnh của người dùng (gõ hoặc nhấp) thành các lời gọi tới hệ điều hành.
- Chính xác! Cả hai đều nhận lệnh của người dùng (dù gõ hay nhấp) và gửi chúng tới hệ điều hành.

---

## Mình đang ở đâu?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**Hệ thống tệp** quản lý các tệp và thư mục (hay còn gọi là thư mục/folder).
Mỗi tệp hoặc thư mục được xác định bằng một **đường dẫn tuyệt đối**
chỉ cách đi tới nó từ **thư mục gốc** của hệ thống tệp:
`/home/repl` là thư mục `repl` bên trong thư mục `home`,
trong khi `/home/repl/course.txt` là tệp `course.txt` trong thư mục đó,
và riêng `/` là thư mục gốc.

Để biết bạn đang ở đâu trong hệ thống tệp,
hãy chạy lệnh `pwd`
(viết tắt của "**p**rint **w**orking **d**irectory").
Lệnh này in ra đường dẫn tuyệt đối của **thư mục làm việc hiện tại** của bạn,
nơi shell chạy các lệnh và mặc định sẽ tìm tệp.

<hr>
Chạy `pwd`.
Bây giờ bạn đang ở đâu?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Hệ thống Unix thường đặt tất cả thư mục home của người dùng bên dưới `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Đó không phải là đường dẫn chính xác."
correct = "Chính xác - bạn đang ở trong `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Làm sao để phân biệt tệp và thư mục?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` cho bạn biết bạn đang ở đâu.
Để xem có những gì ở đó,
gõ `ls` (viết tắt của "**l**i**s**ting") rồi nhấn phím Enter.
Khi dùng một mình,
`ls` sẽ liệt kê nội dung của thư mục hiện tại
(thư mục được hiển thị bởi `pwd`).
Nếu bạn thêm tên một số tệp,
`ls` sẽ liệt kê chúng,
và nếu bạn thêm tên các thư mục,
nó sẽ liệt kê nội dung của các thư mục đó.
Ví dụ,
`ls /home/repl` cho bạn thấy nội dung của thư mục bắt đầu của bạn
(thường được gọi là **home directory**).

<hr>
Hãy dùng `ls` với một đối số phù hợp để liệt kê các tệp trong thư mục `/home/repl/seasonal`
(thư mục này chứa thông tin về các ca phẫu thuật nha khoa theo ngày, phân tách theo mùa).
Trong số các tệp dưới đây, tệp nào KHÔNG nằm trong thư mục đó?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Nếu bạn cung cấp cho `ls` một đường dẫn, nó sẽ hiển thị nội dung trong đường dẫn đó.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Tệp đó nằm trong thư mục `seasonal`."
correct = "Chính xác - tệp đó *không* nằm trong thư mục `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Còn cách nào khác để nhận diện tệp và thư mục?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Một đường dẫn tuyệt đối giống như vĩ độ và kinh độ: nó có cùng giá trị bất kể bạn đang ở đâu. Ngược lại, **đường dẫn tương đối** chỉ vị trí bắt đầu từ nơi bạn đang đứng: giống như nói "20 kilomet về phía bắc".

Ví dụ:
- Nếu bạn đang ở thư mục `/home/repl`, đường dẫn **tương đối** `seasonal` chỉ cùng một thư mục với đường dẫn **tuyệt đối** `/home/repl/seasonal`. 
- Nếu bạn đang ở thư mục `/home/repl/seasonal`, đường dẫn **tương đối** `winter.csv` chỉ cùng một tệp với đường dẫn **tuyệt đối** `/home/repl/seasonal/winter.csv`.

Shell quyết định một đường dẫn là tuyệt đối hay tương đối bằng cách nhìn vào ký tự đầu tiên: Nếu nó bắt đầu bằng `/`, đó là tuyệt đối. Nếu nó *không* bắt đầu bằng `/`, đó là tương đối.

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
Bạn đang ở `/home/repl`. Dùng `ls` với **đường dẫn tương đối** để liệt kê tệp có đường dẫn tuyệt đối là `/home/repl/course.txt` (và chỉ tệp đó).

`@hint`
Bạn thường có thể dựng đường dẫn tương đối đến một tệp hoặc thư mục nằm dưới vị trí hiện tại
bằng cách lấy đường dẫn tuyệt đối của thứ bạn muốn
trừ đi đường dẫn tuyệt đối của vị trí hiện tại.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Bạn đã không gọi `ls` để tạo danh sách tệp."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Lệnh của bạn đã không tạo ra danh sách tệp đúng. Sử dụng `ls` theo sau bởi một đường dẫn tương đối đến `/home/repl/course.txt`.")
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
Bạn đang ở `/home/repl`.
Dùng `ls` với đường dẫn **tương đối**
để liệt kê tệp `/home/repl/seasonal/summer.csv` (và chỉ tệp đó).

`@hint`
Đường dẫn tương đối *không* bắt đầu bằng dấu '/' ở đầu.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Bạn đã không gọi `ls` để tạo danh sách tệp."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Lệnh của bạn đã không tạo ra danh sách tệp đúng. Sử dụng `ls` theo sau là đường dẫn tương đối đến `/home/repl/seasonal/summer.csv`.")
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
Bạn đang ở `/home/repl`.
Dùng `ls` với đường dẫn **tương đối**
để liệt kê nội dung của thư mục `/home/repl/people`.

`@hint`
Đường dẫn tương đối không bắt đầu bằng dấu '/' ở đầu.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Bạn đã không gọi `ls` để tạo danh sách tệp."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Lệnh của bạn đã không tạo ra danh sách tệp đúng. Sử dụng `ls` theo sau là đường dẫn tương đối đến `/home/repl/people`.")
    )
)
Ex().success_msg("Làm tốt lắm. Bây giờ bạn đã biết về cách liệt kê tệp và thư mục, hãy xem cách bạn có thể di chuyển xung quanh hệ thống tệp!")
```

---

## Làm sao chuyển sang thư mục khác?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Giống như bạn có thể di chuyển trong trình quản lý tệp bằng cách nhấp đúp vào thư mục,
bạn cũng có thể di chuyển trong hệ thống tệp bằng lệnh `cd`
(viết tắt của "change directory" — đổi thư mục).

Nếu bạn gõ `cd seasonal` rồi gõ `pwd`,
shell sẽ cho biết bạn đang ở `/home/repl/seasonal`.
Sau đó nếu chạy `ls` không kèm gì thêm,
nó sẽ hiển thị nội dung của `/home/repl/seasonal`,
vì đó là nơi bạn đang đứng.
Nếu muốn quay về thư mục chính của bạn là `/home/repl`,
bạn có thể dùng lệnh `cd /home/repl`.

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
Bạn đang ở `/home/repl`/.
Chuyển sang thư mục `/home/repl/seasonal` bằng đường dẫn tương đối.

`@hint`
Nhớ rằng `cd` là viết tắt của "change directory" và đường dẫn tương đối thì không bắt đầu bằng dấu '/'.

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
key: e69c8eac15
xp: 35
```

`@instructions`
Dùng `pwd` để kiểm tra bạn đã ở đó.

`@hint`
Hãy nhớ nhấn "enter" hoặc "return" sau khi nhập lệnh.

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
Dùng `ls` không kèm đường dẫn để xem có gì trong thư mục đó.

`@hint`
Hãy nhớ nhấn "enter" hoặc "return" sau khi nhập lệnh.

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
      has_code('ls', incorrect_msg="Lệnh của bạn không tạo ra đầu ra chính xác. Bạn đã sử dụng `ls` mà không có đường dẫn để hiển thị nội dung của thư mục hiện tại chưa?")
    )
)

Ex().success_msg("Tuyệt! Đây là về việc điều hướng xuống các thư mục con. Còn việc di chuyển lên thì sao? Hãy cùng tìm hiểu!")
```

---

## Làm sao để đi lên một thư mục?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

Thư mục **cha** của một thư mục là thư mục nằm ngay phía trên nó.
Ví dụ, `/home` là thư mục cha của `/home/repl`,
và `/home/repl` là thư mục cha của `/home/repl/seasonal`.
Bạn luôn có thể đưa đường dẫn tuyệt đối tới thư mục cha cho các lệnh như `cd` và `ls`.
Tuy nhiên, thường thì
bạn sẽ tận dụng việc đường dẫn đặc biệt `..`
(hai dấu chấm liền nhau, không có khoảng trắng) có nghĩa là "thư mục ở phía trên thư mục hiện tại của tôi".
Nếu bạn đang ở `/home/repl/seasonal`,
thì `cd ..` sẽ đưa bạn lên `/home/repl`.
Nếu bạn dùng `cd ..` thêm lần nữa,
bạn sẽ ở `/home`.
Thêm một lần `cd ..` nữa sẽ đưa bạn vào *thư mục gốc* `/`,
là đỉnh cao nhất của hệ thống tệp.
(Hãy nhớ chèn một khoảng trắng giữa `cd` và `..` - đây là một lệnh và một đường dẫn, không phải một lệnh bốn ký tự.)

Một dấu chấm đơn lẻ, `.`, luôn có nghĩa là "thư mục hiện tại",
nên `ls` và `ls .` cho kết quả như nhau,
trong khi `cd .` không có tác dụng
(vì nó chuyển bạn vào chính thư mục bạn đang ở).

Một đường dẫn đặc biệt cuối cùng là `~` (ký tự tilde),
có nghĩa là "thư mục nhà của bạn",
chẳng hạn như `/home/repl`.
Dù bạn đang ở đâu,
`ls ~` sẽ luôn liệt kê nội dung thư mục nhà của bạn,
và `cd ~` sẽ luôn đưa bạn về nhà.

<hr>
Nếu bạn đang ở `/home/repl/seasonal`,
`cd ~/../.` sẽ đưa bạn đến đâu?

`@hint`
Lần theo đường dẫn từng thư mục một.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (thư mục gốc)

`@feedback`
- Chưa đúng, nhưng chỉ cần `~` hoặc `..` riêng lẻ là đưa bạn đến đó.
- Chính xác! Đường dẫn có nghĩa là 'thư mục nhà', 'lên một cấp', 'ở đây'.
- Chưa đúng, nhưng chỉ `.` riêng lẻ sẽ làm được điều đó.
- Chưa đúng, phần cuối của đường dẫn là `.` (nghĩa là "ở đây") chứ không phải `..` (nghĩa là "đi lên").

---

## Làm thế nào để sao chép tệp?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Bạn sẽ thường muốn sao chép tệp,
di chuyển chúng vào các thư mục khác để sắp xếp,
hoặc đổi tên chúng.
Một lệnh để làm việc này là `cp`, viết tắt của "copy".
Nếu `original.txt` là một tệp đã tồn tại,
thì:

```{shell}
cp original.txt duplicate.txt
```

sẽ tạo một bản sao của `original.txt` với tên `duplicate.txt`.
Nếu đã có sẵn một tệp tên `duplicate.txt`,
thì nó sẽ bị ghi đè.
Nếu tham số cuối cùng của `cp` là một thư mục đã tồn tại,
thì một lệnh như:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

sẽ sao chép *tất cả* các tệp vào thư mục đó.

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
Tạo một bản sao của `seasonal/summer.csv` trong thư mục `backup` (cũng nằm trong `/home/repl`),
và đặt tên tệp mới là `summer.bck`.

`@hint`
Kết hợp tên thư mục đích và tên tệp được sao chép
để tạo một đường dẫn tương đối cho tệp mới.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` dường như không tồn tại trong thư mục `backup`. Hãy cung cấp hai đường dẫn cho `cp`: tệp hiện có (`seasonal/summer.csv`) và tệp đích (`backup/summer.bck`)."),
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
Sao chép `spring.csv` và `summer.csv` từ thư mục `seasonal` vào thư mục `backup`
*mà không* thay đổi thư mục làm việc hiện tại của bạn (`/home/repl`).

`@hint`
Dùng `cp` với tên các tệp bạn muốn sao chép
và *sau đó* là tên thư mục cần sao chép vào.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` dường như chưa được sao chép vào thư mục `backup`. Cung cấp hai tên tệp và một tên thư mục cho `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Hãy chắc chắn sao chép các tệp khi đang ở trong `{{dir}}`! Sử dụng `cd {{dir}}` để điều hướng trở lại đó."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Làm tốt lắm. Ngoài việc sao chép, chúng ta cũng nên có khả năng di chuyển tệp từ thư mục này sang thư mục khác. Tìm hiểu về điều đó trong bài tập tiếp theo!")
```

---

## Làm thế nào để di chuyển một tệp?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Trong khi `cp` là lệnh sao chép tệp,
`mv` sẽ di chuyển tệp từ thư mục này sang thư mục khác,
giống như khi bạn kéo thả trong trình quản lý tệp đồ họa.
Cách nhận tham số của nó giống hệt `cp`,
nên lệnh:

```{shell}
mv autumn.csv winter.csv ..
```

sẽ di chuyển các tệp `autumn.csv` và `winter.csv` từ thư mục làm việc hiện tại
lên một cấp sang thư mục cha
(vì `..` luôn chỉ thư mục ở phía trên vị trí hiện tại của bạn).

`@instructions`
Bạn đang ở `/home/repl`, trong đó có các thư mục con `seasonal` và `backup`.
Hãy dùng một lệnh duy nhất để di chuyển `spring.csv` và `summer.csv` từ `seasonal` sang `backup`.

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
backup_patt="Tệp `%s` không nằm trong thư mục `backup`. Bạn đã sử dụng `mv` đúng cách chưa? Sử dụng hai tên tệp và một thư mục làm tham số cho `mv`."
seasonal_patt="Tệp `%s` vẫn nằm trong thư mục `seasonal`. Hãy chắc chắn di chuyển các tệp bằng `mv` thay vì sao chép chúng bằng `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Làm tốt lắm, hãy tiếp tục chuyến tàu shell này!")
```

---

## Làm thế nào để đổi tên tệp?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` cũng có thể dùng để đổi tên tệp. Nếu bạn chạy:

```{shell}
mv course.txt old-course.txt
```

thì tệp `course.txt` trong thư mục làm việc hiện tại sẽ được "di chuyển" thành tệp `old-course.txt`.
Cách này khác với cách trình duyệt tệp hoạt động,
nhưng thường rất tiện lợi.

Một lưu ý:
giống như `cp`,
`mv` sẽ ghi đè lên các tệp đã tồn tại.
Nếu,
ví dụ,
bạn đã có một tệp tên là `old-course.txt`,
thì lệnh ở trên sẽ thay thế nó bằng nội dung trong `course.txt`.

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
Đi vào thư mục `seasonal`.

`@hint`
Hãy nhớ rằng `cd` là viết tắt của "change directory" (đổi thư mục) và rằng đường dẫn tương đối không bắt đầu với dấu '/' ở đầu.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
Đổi tên tệp `winter.csv` thành `winter.csv.bck`.

`@hint`
Dùng `mv` với tên hiện tại của tệp và tên bạn muốn đặt cho nó theo đúng thứ tự đó.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Sử dụng `mv` với hai đối số: tệp bạn muốn đổi tên (`winter.csv`) và tên mới cho tệp (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Chúng tôi mong đợi tìm thấy `winter.csv.bck` trong thư mục." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Chúng tôi không còn mong đợi `winter.csv` có trong thư mục." + hint)
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
Chạy `ls` để kiểm tra rằng mọi thứ đã hoạt động đúng.

`@hint`
Hãy nhớ nhấn "enter" hoặc "return" để chạy lệnh.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Bạn đã sử dụng `ls` để liệt kê nội dung của thư mục làm việc hiện tại chưa?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Lệnh của bạn không tạo ra danh sách tệp đúng. Sử dụng `ls` mà không có đối số để liệt kê nội dung của thư mục làm việc hiện tại.")
    )
)
Ex().success_msg("Sao chép, di chuyển, đổi tên, bạn đã hiểu hết rồi! Tiếp theo: xóa tệp.")
```

---

## Làm thế nào để xóa tệp?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Chúng ta có thể sao chép tệp và di chuyển chúng;
để xóa, bạn dùng `rm`,
viết tắt của "remove" (xóa).
Cũng như `cp` và `mv`,
bạn có thể đưa cho `rm` tên của bao nhiêu tệp tùy ý, ví dụ:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

sẽ xóa cả `thesis.txt` và `backup/thesis-2017-08.txt`

`rm` làm đúng như tên gọi
và thực hiện ngay lập tức:
khác với trình duyệt tệp đồ họa,
shell không có thùng rác,
vì vậy khi bạn gõ lệnh trên,
luận văn của bạn sẽ biến mất vĩnh viễn.

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
Bạn đang ở `/home/repl`.
Đi vào thư mục `seasonal`.

`@hint`
Hãy nhớ `cd` là viết tắt của "change directory" (đổi thư mục) và đường dẫn tương đối thì không bắt đầu bằng dấu '/'.

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
Xóa `autumn.csv`.

`@hint`
Hãy nhớ `rm` là viết tắt của "remove" (xóa).

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Chúng tôi không mong đợi `autumn.csv` vẫn còn trong thư mục `seasonal`. Sử dụng `rm` với đường dẫn đến tệp bạn muốn xóa."),
    has_code('rm', incorrect_msg = 'Sử dụng `rm` để xóa tệp, thay vì di chuyển nó.')
)

```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Quay lại thư mục home của bạn.

`@hint`
Nếu bạn dùng `cd` mà không kèm đường dẫn, bạn sẽ trở về thư mục home.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Sử dụng `cd ..` hoặc `cd ~` để quay lại thư mục chính.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Xóa `seasonal/summer.csv` mà không cần đổi thư mục lần nữa.

`@hint`
Hãy nhớ `rm` là viết tắt của "remove" (xóa).

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Chúng tôi không mong đợi `summer.csv` vẫn còn trong thư mục `seasonal`. Sử dụng `rm` với đường dẫn đến tệp bạn muốn xóa."),
    has_code('rm', incorrect_msg = 'Sử dụng `rm` để xóa tệp, thay vì di chuyển nó.')
)
Ex().success_msg("Thật ấn tượng! Tiếp tục với cái tiếp theo nào!")
```

---

## Làm thế nào để tạo và xóa thư mục?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` xử lý thư mục giống hệt như xử lý tệp:
nếu bạn đang ở thư mục home và chạy `mv seasonal by-season`,
chẳng hạn,
`mv` sẽ đổi tên thư mục `seasonal` thành `by-season`.
Tuy nhiên,
`rm` hoạt động khác.

Nếu bạn thử `rm` một thư mục,
shell sẽ in thông báo lỗi cho biết không thể làm vậy,
chủ yếu để ngăn bạn vô tình xóa cả một thư mục đầy công việc.
Thay vào đó,
bạn có thể dùng một lệnh riêng gọi là `rmdir`.
Để tăng độ an toàn,
`rmdir` chỉ hoạt động khi thư mục trống,
vì vậy bạn phải xóa các tệp trong thư mục *trước khi* xóa chính thư mục đó.
(Người dùng có kinh nghiệm có thể dùng tùy chọn `-r` của `rm` để đạt hiệu quả tương tự;
chúng ta sẽ thảo luận về các tùy chọn lệnh ở chương tiếp theo.)

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
Không thay đổi thư mục làm việc,
hãy xóa tệp `agarwal.txt` trong thư mục `people`.

`@hint`
Hãy nhớ `rm` là viết tắt của "remove" và đường dẫn tương đối thì không bắt đầu bằng dấu '/' ở đầu.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` không nên còn trong `/home/repl/people`. Bạn đã sử dụng `rm` đúng cách chưa?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'Vẫn còn tệp trong thư mục `people`. Nếu bạn chỉ di chuyển `agarwal.txt`, hoặc tạo tệp mới, hãy xóa tất cả chúng.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Bây giờ thư mục `people` đã trống,
hãy dùng một lệnh duy nhất để xóa nó.

`@hint`
Hãy nhớ rằng `rm` chỉ hoạt động với tệp.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "Thư mục 'people' không nên còn trong thư mục chính của bạn. Sử dụng `rmdir` để xóa nó!")
)

```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Vì thư mục không phải là tệp,
bạn phải dùng lệnh `mkdir directory_name`
để tạo một thư mục (trống) mới.
Hãy dùng lệnh này để tạo một thư mục mới tên `yearly` dưới thư mục home của bạn.

`@hint`
Chạy `mkdir` với tên của thư mục bạn muốn tạo.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Không có thư mục `yearly` trong thư mục chính của bạn. Sử dụng `mkdir yearly` để tạo một thư mục!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Giờ `yearly` đã tồn tại,
hãy tạo thêm một thư mục tên `2017` bên trong nó
*mà không* rời thư mục home của bạn.

`@hint`
Dùng đường dẫn tương đối cho thư mục con bạn muốn tạo.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Không thể tìm thấy thư mục '2017' trong '/home/repl/yearly'. Bạn có thể tạo thư mục này bằng cách sử dụng đường dẫn tương đối `yearly/2017`.")
)
Ex().success_msg("Tuyệt! Hãy kết thúc chương này với một bài tập ôn lại một số khái niệm của nó!")
```

---

## Tổng kết

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Khi phân tích dữ liệu, bạn thường sẽ tạo ra các tệp trung gian.
Thay vì lưu chúng trong thư mục home của bạn,
bạn có thể đặt chúng vào `/tmp`,
nơi mọi người và chương trình thường giữ các tệp chỉ cần dùng trong thời gian ngắn.
(Lưu ý rằng `/tmp` nằm ngay bên dưới thư mục gốc `/`,
chứ *không phải* bên dưới thư mục home của bạn.)
Bài tập tổng kết này sẽ hướng dẫn bạn cách làm điều đó.

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
Dùng `cd` để đi vào `/tmp`.

`@hint`
Nhớ rằng `cd` là viết tắt của "change directory" (đổi thư mục) và một đường dẫn tuyệt đối bắt đầu bằng '/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Bạn đang ở sai thư mục. Sử dụng `cd` để thay đổi thư mục sang `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Liệt kê nội dung của `/tmp` mà *không* gõ tên thư mục.

`@hint`
Nếu bạn không nói `ls` cần liệt kê gì, nó sẽ hiển thị nội dung trong thư mục hiện tại của bạn.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Bạn đã không gọi `ls` để tạo danh sách tệp."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Lệnh của bạn đã không tạo ra danh sách tệp chính xác. Sử dụng `ls` mà không có gì khác.")
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
Tạo một thư mục mới bên trong `/tmp` tên là `scratch`.

`@hint`
Dùng `mkdir` để tạo thư mục.

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
      has_code('mkdir +scratch', incorrect_msg="Không thể tìm thấy thư mục 'scratch' dưới '/tmp'. Hãy chắc chắn sử dụng `mkdir` đúng cách.")
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
Di chuyển `/home/repl/people/agarwal.txt` vào `/tmp/scratch`.
Chúng tôi gợi ý bạn dùng lối tắt `~` cho thư mục home của bạn và dùng đường dẫn tương đối cho đích thay vì đường dẫn tuyệt đối.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Không thể tìm thấy 'agarwal.txt' trong '/tmp/scratch'. Sử dụng `mv` với `~/people/agarwal.txt` làm tham số đầu tiên và `scratch` làm tham số thứ hai.")
)
Ex().success_msg("Điều này kết thúc Chương 1 của Giới thiệu về Shell! Hãy nhanh chóng chuyển sang chương tiếp theo để tìm hiểu thêm về cách thao tác dữ liệu!")
```

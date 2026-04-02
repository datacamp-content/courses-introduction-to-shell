---
title: Pemrosesan batch
description: >-
  Kebanyakan perintah shell akan memproses banyak berkas sekaligus. Bab ini
  menunjukkan cara membuat pipa Anda sendiri melakukan hal yang sama. Di
  sepanjang proses, Anda akan melihat bagaimana shell menggunakan variabel untuk
  menyimpan informasi.
lessons:
  - nb_of_exercises: 10
    title: Bagaimana shell menyimpan informasi?
---

## Bagaimana shell menyimpan informasi?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Seperti program lain, shell menyimpan informasi dalam variabel.
Beberapa di antaranya,
disebut **environment variables**,
tersedia setiap saat.
Nama environment variables secara konvensional ditulis dengan huruf kapital,
dan beberapa yang paling umum digunakan ditunjukkan di bawah ini.

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | Direktori home pengguna            | `/home/repl`          |
| `PWD `   | Direktori kerja saat ini           | Sama seperti perintah `pwd` |
| `SHELL`  | Program shell yang digunakan       | `/bin/bash`           |
| `USER`   | ID pengguna                        | `repl`                |

Untuk mendapatkan daftar lengkap (yang cukup panjang),
Anda dapat mengetik `set` di shell.

<hr>

Gunakan `set` dan `grep` dengan pipa untuk menampilkan nilai `HISTFILESIZE`,
yang menentukan berapa banyak perintah lama yang disimpan dalam riwayat perintah Anda.
Berapakah nilainya?

`@possible_answers`
- 10
- 500
- [2000]
- The variable is not there.

`@hint`
Gunakan `set | grep HISTFILESIZE` untuk mendapatkan baris yang Anda perlukan.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Tidak: shell mencatat lebih banyak riwayat dari itu."
err2 = "Tidak: shell mencatat lebih banyak riwayat dari itu."
correct3 = "Benar: shell menyimpan 2000 perintah lama secara default pada sistem ini."
err4 = "Tidak: variabel `HISTFILESIZE` ada di sana."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Bagaimana cara mencetak nilai sebuah variabel?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Cara yang lebih sederhana untuk mengetahui nilai sebuah variabel adalah menggunakan perintah bernama `echo`, yang mencetak argumennya. Mengetik

```{shell}
echo hello DataCamp!
```

akan mencetak

```
hello DataCamp!
```

Jika Anda mencoba menggunakannya untuk mencetak nilai variabel seperti ini:

```{shell}
echo USER
```

maka yang dicetak adalah nama variabelnya, `USER`.

Untuk mendapatkan nilai variabel, Anda harus menambahkan tanda dolar `$` di depannya. Mengetik 

```{shell}
echo $USER
```

akan mencetak

```
repl
```

Hal ini berlaku di mana pun:
untuk mendapatkan nilai variabel bernama `X`,
Anda harus menuliskannya sebagai `$X`.
(Hal ini agar shell dapat membedakan apakah Anda bermaksud "berkas bernama X"
atau "nilai variabel bernama X".)

`@instructions`
Variabel `OSTYPE` menyimpan nama jenis sistem operasi yang Anda gunakan.
Tampilkan nilainya menggunakan `echo`.

`@hint`
Panggil `echo` dengan variabel `OSTYPE` yang diawali dengan `$`.

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
            has_code('echo', incorrect_msg="Apakah Anda memanggil `echo`?"),
            has_code('OSTYPE', incorrect_msg="Apakah Anda mencetak variabel lingkungan `OSTYPE`?"),
            has_code(r'\$OSTYPE', incorrect_msg="Pastikan untuk menambahkan `$` di depan `OSTYPE`.")
        )
    )
)
Ex().success_msg("Pencetakan variabel lingkungan yang sangat baik! Anda memulai dengan baik. Mari kita lanjutkan!")
```

---

## Bagaimana lagi shell menyimpan informasi?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Jenis variabel lainnya disebut **variabel shell**,
mirip seperti variabel lokal dalam bahasa pemrograman.

Untuk membuat variabel shell,
Anda cukup menetapkan sebuah nilai ke sebuah nama:

```{shell}
training=seasonal/summer.csv
```

*tanpa* spasi di sebelum atau sesudah tanda `=`.
Setelah Anda melakukannya,
Anda dapat memeriksa nilai variabel dengan:

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
Definisikan variabel bernama `testing` dengan nilai `seasonal/winter.csv`.

`@hint`
Tidak boleh ada spasi antara nama variabel dan nilainya.

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
        has_code('testing', incorrect_msg='Apakah Anda mendefinisikan variabel shell bernama `testing`?'),
        has_code('testing=', incorrect_msg='Apakah Anda menulis `=` langsung setelah testing, tanpa spasi?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Apakah Anda menetapkan nilai `testing` ke `seasonal/winter.csv`?')
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
Gunakan `head -n 1 SESUATU` untuk mengambil baris pertama dari `seasonal/winter.csv`
dengan menggunakan nilai variabel `testing` alih-alih nama berkasnya.

`@hint`
Ingat untuk menggunakan `$testing`, bukan hanya `testing`
(tanda `$` diperlukan untuk mengambil nilai variabel).

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
    has_code(r'\$testing', incorrect_msg="Apakah Anda merujuk variabel shell menggunakan `$testing`?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Apakah Anda memanggil `head`?"),
            has_code('-n', incorrect_msg="Apakah Anda membatasi jumlah baris dengan `-n`?"),
            has_code(r'-n\s+1', incorrect_msg="Apakah Anda memilih untuk menyimpan 1 baris dengan `-n 1`?")     
        )
    )
)
Ex().success_msg("Luar biasa! Mari kita lihat bagaimana Anda dapat mengulangi perintah dengan mudah.")

```

---

## Bagaimana saya dapat mengulang sebuah perintah berkali-kali?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Variabel shell juga digunakan dalam **loop**,
yang mengulang perintah berkali-kali.
Jika kita menjalankan perintah ini:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

hasilnya adalah:

```
gif
jpg
png
```

Perhatikan hal-hal berikut tentang loop tersebut:

1. Strukturnya adalah `for` ...variabel... `in` ...daftar... `; do` ...badan... `; done`
2. Daftar hal yang akan diproses oleh loop (dalam contoh kita, kata `gif`, `jpg`, dan `png`).
3. Variabel yang melacak item mana yang sedang diproses oleh loop (dalam contoh kita, `filetype`).
4. Badan loop yang melakukan pemrosesan (dalam contoh kita, `echo $filetype`).

Perhatikan bahwa badan loop menggunakan `$filetype` untuk mengambil nilai variabel, bukan hanya `filetype`,
sama seperti pada variabel shell lainnya.
Perhatikan juga posisi tanda titik koma:
yang pertama berada di antara daftar dan kata kunci `do`,
dan yang kedua berada di antara badan loop dan kata kunci `done`.

`@instructions`
Ubah loop sehingga mencetak:

```
docx
odt
pdf
```

Harap gunakan `filetype` sebagai nama variabel loop.

`@hint`
Gunakan struktur kode pada teks pengantar, dengan menukar jenis berkas gambar menjadi jenis berkas dokumen.

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
      has_code('for', incorrect_msg='Apakah Anda memanggil `for`?'),
      has_code('filetype', incorrect_msg='Apakah Anda menggunakan `filetype` sebagai variabel loop?'),
      has_code('in', incorrect_msg='Apakah Anda menggunakan `in` sebelum daftar tipe file?'),
      has_code('docx odt pdf', incorrect_msg='Apakah Anda melakukan loop pada `docx`, `odt`, dan `pdf` dalam urutan tersebut?'),
      has_code(r'pdf\s*;', incorrect_msg='Apakah Anda meletakkan titik koma setelah elemen loop terakhir?'),
      has_code(r';\s*do', incorrect_msg='Apakah Anda menggunakan `do` setelah titik koma pertama?'),
      has_code('echo', incorrect_msg='Apakah Anda memanggil `echo`?'),
      has_code(r'\$filetype', incorrect_msg='Apakah Anda melakukan echo `$filetype`?'),
      has_code(r'filetype\s*;', incorrect_msg='Apakah Anda meletakkan titik koma setelah badan loop?'),
      has_code('; done', incorrect_msg='Apakah Anda mengakhiri dengan `done`?')
    )
  )
)
Ex().success_msg("Luar biasa untuk looping! Loop sangat brilian jika Anda ingin melakukan hal yang sama ratusan atau ribuan kali.")
```

---

## Bagaimana cara mengulang perintah sekali untuk setiap berkas?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Anda selalu dapat mengetikkan nama berkas yang ingin diproses saat menulis loop,
amun biasanya lebih baik menggunakan wildcard.
Coba jalankan loop ini di konsol:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Ini mencetak:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

karena shell mengembangkan `seasonal/*.csv` menjadi daftar empat nama berkas
sebelum menjalankan loop.

`@instructions`
Ubah ekspresi wildcard menjadi `people/*`
agar loop mencetak nama berkas di direktori `people`
apa pun akhiran yang mereka miliki atau tidak miliki.
Silakan gunakan `filename` sebagai nama variabel loop Anda.

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
      has_code('for', incorrect_msg='Apakah Anda memanggil `for`?'),
      has_code('filename', incorrect_msg='Apakah Anda menggunakan `filename` sebagai variabel loop?'),
      has_code('in', incorrect_msg='Apakah Anda menggunakan `in` sebelum daftar jenis file?'),
      has_code('people/\*', incorrect_msg='Apakah Anda menentukan daftar file dengan `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='Apakah Anda meletakkan titik koma setelah daftar file?'),
      has_code(r';\s*do', incorrect_msg='Apakah Anda menggunakan `do` setelah titik koma pertama?'),
      has_code('echo', incorrect_msg='Apakah Anda memanggil `echo`?'),
      has_code(r'\$filename', incorrect_msg='Apakah Anda menampilkan `$filename`?'),
      has_code(r'filename\s*;', incorrect_msg='Apakah Anda meletakkan titik koma setelah badan loop?'),
      has_code('; done', incorrect_msg='Apakah Anda menyelesaikan dengan `done`?')
    )
  )
)
Ex().success_msg("Looping yang berulang! Wildcards dan loop membuat kombinasi yang kuat.")
```

---

## Bagaimana cara mencatat nama sekelompok berkas?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Sering kali orang menetapkan sebuah variabel menggunakan ekspresi wildcard untuk mencatat daftar nama berkas.
Sebagai contoh,
jika Anda mendefinisikan `datasets` seperti ini:

```{shell}
datasets=seasonal/*.csv
```

Anda dapat menampilkan nama berkasnya nanti dengan:

```{shell}
for filename in $datasets; do echo $filename; done
```

Ini menghemat pengetikan dan mengurangi kemungkinan kesalahan.

<hr>

Jika Anda menjalankan dua perintah ini di direktori home Anda,
berapa banyak baris keluaran yang akan dicetak?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Tidak ada: karena `files` didefinisikan pada baris terpisah, variabel tersebut tidak memiliki nilai pada baris kedua.
- Satu: kata "files".
- Empat: nama dari keempat berkas data musiman.

`@hint`
Ingat bahwa `X` sendiri hanyalah "X", sedangkan `$X` adalah nilai dari variabel `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Tidak: Anda tidak harus mendefinisikan variabel pada baris yang sama saat Anda menggunakannya."
err2 = "Tidak: contoh ini mendefinisikan dan menggunakan variabel `files` dalam shell yang sama."
correct3 = "Benar. Perintah ini setara dengan `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Nama variabel versus nilainya

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Kesalahan yang umum terjadi adalah lupa menambahkan `$` sebelum nama variabel.
Saat hal ini terjadi,
shell akan menggunakan nama yang Anda ketikkan
alih-alih nilai dari variabel tersebut.

Kesalahan yang lebih sering terjadi pada pengguna berpengalaman adalah salah ketik nama variabel.
Sebagai contoh,
jika Anda mendefinisikan `datasets` seperti ini:

```{shell}
datasets=seasonal/*.csv
```

lalu mengetik:

```{shell}
echo $datsets
```

shell tidak akan mencetak apa pun,
karena `datsets` (tanpa huruf "a" kedua) tidak didefinisikan.

<hr>

Jika Anda menjalankan dua perintah berikut di direktori home Anda,
output apa yang akan dicetak?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Baca bagian pertama dari loop dengan saksama sebelum menjawab.)

`@hint`
Ingat bahwa `X` sendiri hanya berupa "X", sedangkan `$X` adalah nilai dari variabel `X`.

`@possible_answers`
- [Satu baris: kata "files".]
- Empat baris: nama keempat berkas data musiman.
- Empat baris kosong: variabel `f` tidak diberi nilai.

`@feedback`
- Benar: loop menggunakan `files` alih-alih `$files`, sehingga daftar tersebut berisi kata "files".
- Tidak: loop menggunakan `files` alih-alih `$files`, sehingga daftar tersebut berisi kata "files" alih-alih hasil ekspansi `files`.
- Tidak: variabel `f` didefinisikan secara otomatis oleh loop `for`.

---

## Bagaimana saya dapat menjalankan banyak perintah dalam satu loop?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Mencetak nama berkas berguna untuk debug,
namun tujuan utama loop adalah memproses banyak berkas.
Loop berikut mencetak baris kedua dari setiap berkas data:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Strukturnya sama seperti loop lain yang sudah Anda lihat:
perbedaannya hanya pada badan loop yang berupa pipeline dari dua perintah, bukan satu perintah tunggal.

`@instructions`
Tulis sebuah loop yang mencetak entri terakhir dari Juli 2017 (`2017-07`) di setiap berkas seasonal. Hasilnya harus mirip dengan:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

namun diterapkan pada **_setiap_** berkas seasonal secara terpisah. Gunakan `file` sebagai nama variabel loop, dan ingat untuk melakukan loop melalui daftar berkas `seasonal/*.csv` (_bukan 'seasonal/winter.csv' seperti pada contoh_).

`@hint`
Badan loop adalah perintah grep yang ditunjukkan pada instruksi, dengan `seasonal/winter.csv` diganti menjadi `$file`.

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
  has_code('for', incorrect_msg='Apakah Anda memanggil `for`?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Apakah Anda menggunakan `file` sebagai variabel loop?'),
      has_code('in', incorrect_msg='Apakah Anda menggunakan `in` sebelum daftar file?'),
      has_code('seasonal/\*', incorrect_msg='Apakah Anda menentukan daftar file dengan `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Apakah Anda meletakkan titik koma setelah daftar file?'),
      has_code(r';\s*do', incorrect_msg='Apakah Anda menggunakan `do` setelah titik koma pertama?'),
      has_code('grep', incorrect_msg='Apakah Anda memanggil `grep`?'),
      has_code('2017-07', incorrect_msg='Apakah Anda mencocokkan dengan `2017-07`?'),
      has_code(r'\$file', incorrect_msg='Apakah Anda menggunakan `$file` sebagai nama variabel loop?'),
      has_code(r'file\s*|', incorrect_msg='Apakah Anda menggunakan pipe untuk menghubungkan perintah kedua Anda?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Apakah Anda menggunakan `tail -n 1` untuk mencetak entri terakhir dari setiap pencarian dalam perintah kedua Anda?'),
      has_code('; done', incorrect_msg='Apakah Anda menyelesaikan dengan `done`?')
    )
  )
)

Ex().success_msg("Pengulangan yang berulang! Wildcards dan loop membuat kombinasi yang kuat.")
```

---

## Mengapa saya sebaiknya tidak menggunakan spasi dalam nama file?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Memberi nama file dengan beberapa kata seperti `July 2017.csv` itu mudah dan masuk akal saat Anda menggunakan penjelajah file grafis.
Namun, ini menimbulkan masalah saat Anda bekerja di shell.
Sebagai contoh, misalkan Anda ingin mengubah nama `July 2017.csv` menjadi `2017 July data.csv`.
Anda tidak dapat mengetik:

```{shell}
mv July 2017.csv 2017 July data.csv
```

karena bagi shell, seolah-olah Anda mencoba memindahkan
empat file bernama `July`, `2017.csv`, `2017`, dan `July` (lagi)
ke dalam direktori bernama `data.csv`.
Sebagai gantinya, Anda harus memberi tanda petik pada nama file
agar shell memperlakukan masing-masing sebagai satu parameter:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Jika Anda memiliki dua file bernama `current.csv` dan `last year.csv`
(dengan spasi pada namanya)
dan Anda mengetik:

```{shell}
rm current.csv last year.csv
```

apa yang akan terjadi:

`@hint`
Apa yang Anda pikir akan terjadi jika seseorang menunjukkan perintah tersebut kepada Anda dan Anda tidak tahu file apa saja yang ada?

`@possible_answers`
- Shell akan mencetak pesan galat karena `last` dan `year.csv` tidak ada.
- Shell akan menghapus `current.csv`.
- [Keduanya di atas.]
- Tidak terjadi apa-apa.

`@feedback`
- Ya, tetapi itu bukan satu-satunya.
- Ya, tetapi itu bukan satu-satunya.
- Benar. Anda dapat menggunakan tanda petik tunggal, `'`, atau tanda petik ganda, `"`, di sekeliling nama file.
- Sayangnya tidak.

---

## Bagaimana saya dapat melakukan banyak hal dalam satu loop?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Loop yang Anda lihat sejauh ini hanya memiliki satu perintah atau pipeline di dalamnya,
amun sebuah loop dapat berisi sejumlah perintah.
Untuk memberi tahu shell di mana satu perintah berakhir dan berikutnya dimulai,
Anda harus memisahkannya dengan titik koma:

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

Misalkan Anda lupa menambahkan titik koma di antara perintah `echo` dan `head` pada loop sebelumnya,
sehingga Anda meminta shell untuk menjalankan:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Apa yang akan dilakukan shell?

`@possible_answers`
- Mencetak pesan galat.
- Mencetak satu baris untuk masing-masing dari empat berkas.
- Mencetak satu baris untuk `autumn.csv` (berkas pertama).
- Mencetak baris terakhir dari setiap berkas.

`@hint`
Anda dapat mengalirkan (pipe) keluaran dari `echo` ke `tail`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Tidak: loop akan berjalan, hanya saja tidak akan melakukan sesuatu yang masuk akal."
correct2 = "Ya: `echo` menghasilkan satu baris yang menyertakan nama file dua kali, yang kemudian disalin oleh `tail`."
err3 = "Tidak: loop berjalan satu kali untuk masing-masing dari empat nama file."
err4 = "Tidak: input dari `tail` adalah output dari `echo` untuk setiap nama file."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

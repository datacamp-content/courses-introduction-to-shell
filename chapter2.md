---
title: Memanipulasi data
description: >-
  Perintah yang Anda lihat pada bab sebelumnya memungkinkan Anda memindahkan
  sesuatu di dalam sistem berkas. Bab ini akan menunjukkan cara bekerja dengan
  data di dalam berkas-berkas tersebut. Alat yang akan kita gunakan cukup
  sederhana, tetapi merupakan fondasi yang kuat.
lessons:
  - nb_of_exercises: 12
    title: Bagaimana cara melihat isi sebuah berkas?
---

## Bagaimana cara melihat isi sebuah file?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Sebelum Anda mengganti nama atau menghapus file,
Anda mungkin ingin melihat isinya terlebih dahulu.
Cara termudah untuk melakukannya adalah dengan `cat`,
yang hanya mencetak isi file ke layar.
(Namanya berasal dari "concatenate", yang berarti "menggabungkan",
karena perintah ini akan mencetak semua file yang Anda sebutkan namanya, satu demi satu.)

```{shell}
cat agarwal.txt
```
```
nama: Agarwal, Jasmine
posisi: RCT2
mulai: 2017-04-01
benefit: penuh
```

`@instructions`
Cetak isi `course.txt` ke layar.

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
    has_expr_output(incorrect_msg="Perintah Anda tidak menghasilkan keluaran yang benar. Apakah Anda sudah menggunakan `cat` diikuti dengan nama file, `course.txt`?")
)
Ex().success_msg("Bagus! Mari kita lihat cara lain untuk melihat isi file.")
```

---

## Bagaimana cara melihat isi berkas sedikit demi sedikit?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Anda dapat menggunakan `cat` untuk mencetak berkas berukuran besar lalu menggulirkan keluarannya,
namun biasanya lebih nyaman untuk **menampilkan per halaman** keluarannya.
Perintah awal untuk melakukan ini adalah `more`,
namun kini telah digantikan oleh perintah yang lebih kuat bernama `less`.
(Penamaan seperti ini dianggap humor di dunia Unix.)
Saat Anda menjalankan `less` pada sebuah berkas,
layar akan menampilkan satu halaman setiap kali;
Anda dapat menekan tombol spasi untuk berpindah ke halaman berikutnya atau mengetik `q` untuk keluar.

Jika Anda memberikan `less` beberapa nama berkas sekaligus,
Anda dapat mengetik `:n` (titik dua dan huruf 'n' kecil) untuk berpindah ke berkas berikutnya,
`:p` untuk kembali ke berkas sebelumnya,
atau `:q` untuk keluar.

Catatan: Jika Anda melihat solusi untuk latihan yang menggunakan `less`,
Anda akan melihat perintah tambahan di akhir yang mematikan penayangan per halaman
agar kami dapat menguji solusi Anda secara efisien.

`@instructions`
Gunakan `less seasonal/spring.csv seasonal/summer.csv` untuk melihat kedua berkas tersebut dalam urutan itu.
Tekan spasi untuk pindah halaman, `:n` untuk ke berkas kedua, dan `:q` untuk keluar.

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
                 incorrect_msg='Gunakan `less` dan nama file. Ingat bahwa `:n` memindahkan Anda ke file berikutnya.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Bagaimana cara melihat awal sebuah berkas?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Hal pertama yang biasanya dilakukan sebagian besar data scientist saat menerima himpunan data baru untuk dianalisis adalah
mengetahui bidang apa saja yang ada dan nilai apa yang dimiliki bidang-bidang tersebut.
Jika himpunan data diekspor dari basis data atau spreadsheet,
sering kali disimpan sebagai **comma-separated values** (CSV).
Cara cepat untuk mengetahui isinya adalah dengan melihat beberapa baris pertama.

Kita dapat melakukannya di shell menggunakan perintah `head`.
Sesuai namanya,
perintah ini mencetak beberapa baris pertama dari sebuah berkas
(di mana "beberapa" berarti 10),
jadi perintah:

```{shell}
head seasonal/summer.csv
```

menampilkan:

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

Apa yang dilakukan `head` jika tidak ada 10 baris dalam berkas?
(Untuk mengetahuinya, gunakan perintah tersebut untuk melihat bagian atas `people/agarwal.txt`.)

`@possible_answers`
- Mencetak pesan kesalahan karena berkas terlalu pendek.
- Menampilkan sebanyak mungkin baris yang ada.
- Menampilkan cukup baris kosong hingga totalnya menjadi 10.

`@hint`
Apa hal paling berguna yang bisa dilakukannya?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Incorrect: itu bukanlah hal paling berguna yang dapat dilakukan.",
                    "Benar!",
                    "Incorrect: itu akan mustahil dibedakan dari file yang diakhiri dengan banyak baris kosong."])
```

---

## Bagaimana cara saya mengetik lebih sedikit?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Salah satu alat andalan shell adalah **pelengkapan tab**.
Jika Anda mulai mengetik nama sebuah berkas lalu menekan tombol tab,
shell akan berusaha melengkapi jalur (path) secara otomatis.
Sebagai contoh,
jika Anda mengetik `sea` lalu menekan tab,
shell akan melengkapi nama direktori menjadi `seasonal/` (dengan garis miring di akhir).
Jika kemudian Anda mengetik `a` dan menekan tab,
jalurnya akan dilengkapi menjadi `seasonal/autumn.csv`.

Jika jalurnya ambigu,
seperti `seasonal/s`,
menekan tab untuk kedua kalinya akan menampilkan daftar kemungkinan.
Ketik satu atau dua karakter lagi untuk membuat jalur lebih spesifik,
lalu tekan tab
agar sisa namanya dilengkapi.

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
Jalankan `head seasonal/autumn.csv` tanpa mengetik nama berkas secara lengkap.

`@hint`
Ketik sebagian jalur sesuai kebutuhan, lalu tekan tab, dan ulangi.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Pemeriksa tidak dapat menemukan keluaran yang benar dalam perintah Anda. Apakah Anda yakin telah memanggil `head` pada `seasonal/autumn.csv`?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Jalankan `head seasonal/spring.csv` tanpa mengetik nama berkas secara lengkap.

`@hint`
Ketik sebagian jalur sesuai kebutuhan, lalu tekan tab, dan ulangi.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Pemeriksa tidak dapat menemukan keluaran yang benar dalam perintah Anda. Apakah Anda yakin telah memanggil `head` pada `seasonal/spring.csv`?")
)
Ex().success_msg("Kerja bagus! Setelah Anda terbiasa menggunakan penyelesaian tab, itu akan menghemat banyak waktu Anda!")
```

---

## Bagaimana saya dapat mengendalikan apa yang dilakukan perintah?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Anda tidak selalu ingin melihat 10 baris pertama dari sebuah file,
sehingga shell memungkinkan Anda mengubah perilaku `head`
dengan memberinya **flag baris perintah** (atau singkatnya "flag").
Jika Anda menjalankan perintah:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` hanya akan menampilkan tiga baris pertama dari file.
Jika Anda menjalankan `head -n 100`,
perintah akan menampilkan 100 baris pertama (jika memang sebanyak itu),
dan seterusnya.

Nama sebuah flag biasanya menunjukkan tujuannya
(misalnya, `-n` dimaksudkan untuk menandai "**jumlah (n)** baris").
Flag perintah tidak harus berupa `-` diikuti satu huruf,
namun itu adalah konvensi yang banyak digunakan.

Catatan: praktik yang baik adalah menempatkan semua flag *sebelum* nama file apa pun,
jadi dalam kursus ini,
kami hanya menerima jawaban yang mengikuti aturan tersebut.

`@instructions`
Tampilkan 5 baris pertama dari `winter.csv` di direktori `seasonal`.

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
        has_expr_output(incorrect_msg="Apakah Anda yakin Anda memanggil `head` pada file `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Apakah Anda yakin Anda menggunakan flag `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Apakah Anda yakin Anda menggunakan flag `-n 5`?")
)
Ex().success_msg("Bagus! Dengan teknik ini, Anda dapat menghindari shell Anda dari meledak jika Anda ingin melihat file teks yang lebih besar.")
```

---

## Bagaimana cara menampilkan daftar semua isi di bawah sebuah direktori?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Untuk melihat semua yang berada di bawah sebuah direktori,
apa pun tingkat kedalamannya,
Anda dapat memberikan bendera `-R` pada `ls`
(yang berarti "rekursif").
Jika Anda menggunakan `ls -R` di direktori home Anda,
Anda akan melihat sesuatu seperti ini:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Ini menampilkan setiap berkas dan direktori pada level saat ini,
kemudian semua yang ada di setiap subdirektori,
dan seterusnya.

`@instructions`
Agar Anda tahu mana yang mana,
`ls` memiliki bendera lain `-F` yang mencetak `/` setelah nama setiap direktori
dan `*` setelah nama setiap program yang dapat dijalankan.
Jalankan `ls` dengan dua bendera, `-R` dan `-F`, serta jalur absolut ke direktori home Anda
untuk melihat semua isinya.
(Urutan bendera tidak masalah, tetapi nama direktori harus diletakkan terakhir.)

`@hint`
Direktori home Anda dapat ditentukan menggunakan `~` atau `.` atau jalur absolutnya.

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
  has_expr_output(incorrect_msg='Gunakan `ls -R -F` atau `ls -F -R` dan jalur `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Gunakan `ls -R -F` atau `ls -F -R` dan jalur `/home/repl`.')
)
Ex().success_msg("Itu adalah gambaran yang cukup rapi, bukan?")
```

---

## Bagaimana cara mendapatkan bantuan untuk sebuah perintah?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Untuk mengetahui apa yang dilakukan suatu perintah,
orang dahulu menggunakan perintah `man`
(singkatannya dari "manual").
Sebagai contoh,
perintah `man head` akan menampilkan informasi berikut:

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

`man` secara otomatis memanggil `less`,
jadi Anda mungkin perlu menekan spasi untuk menggulir halaman informasi
dan `:q` untuk keluar.

Deskripsi satu baris di bawah `NAME` memberi tahu Anda secara singkat apa yang dilakukan perintah tersebut,
dan ringkasan di bawah `SYNOPSIS` mencantumkan semua flag yang dikenali.
Apa pun yang opsional ditunjukkan dalam tanda kurung siku `[...]`,
pilihan salah satu dari beberapa alternatif dipisahkan oleh `|`,
dan hal-hal yang dapat diulang ditunjukkan dengan `...`,
jadi halaman manual `head` memberi tahu Anda bahwa Anda dapat memberikan jumlah baris dengan `-n`
atau jumlah byte dengan `-c`,
dan bahwa Anda dapat memberikan sejumlah nama berkas.

Masalah dengan manual Unix adalah Anda harus tahu apa yang Anda cari.
Jika tidak,
Anda dapat mencari di [Stack Overflow](https://stackoverflow.com/),
bertanya di saluran Slack DataCamp,
atau melihat bagian `SEE ALSO` dari perintah yang sudah Anda kenal.

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
Baca halaman manual untuk perintah `tail` untuk mengetahui
apa fungsi menempatkan tanda `+` di depan angka yang digunakan dengan flag `-n`.
(Ingat untuk menekan spasi untuk menggulir ke bawah dan/atau ketik `q` untuk keluar.)

`@hint`
Ingat: `man` adalah singkatan dari "manual".

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Gunakan `man` dan nama perintahnya.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Gunakan `tail` dengan flag `-n +7` untuk menampilkan semua baris *kecuali* enam baris pertama dari `seasonal/spring.csv`.

`@hint`
Gunakan tanda plus '+' di depan jumlah baris yang ingin Anda tampilkan.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Apakah Anda memanggil `tail` pada `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Apakah Anda yakin telah menggunakan bendera `-n +7`?")
)
```

---

## Bagaimana cara memilih kolom dari sebuah file?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` dan `tail` memungkinkan Anda memilih baris dari sebuah file teks.
Jika Anda ingin memilih kolom,
Anda dapat menggunakan perintah `cut`.
Perintah ini memiliki beberapa opsi (gunakan `man cut` untuk mempelajarinya),
namun yang paling umum adalah seperti berikut:

```{shell}
cut -f 2-5,8 -d , values.csv
```

yang berarti
"pilih kolom 2 sampai 5 dan kolom 8,
dengan menggunakan koma sebagai pemisah".
`cut` menggunakan `-f` ("fields") untuk menentukan kolom
dan `-d` ("delimiter") untuk menentukan pemisah.
Anda perlu menentukan yang terakhir karena beberapa file mungkin menggunakan spasi, tab, atau titik dua untuk memisahkan kolom.

<hr>

Perintah apa yang akan memilih kolom pertama (berisi tanggal) dari file `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Salah satu dari keduanya.
- Tidak ada keduanya, karena `-f` harus diletakkan sebelum `-d`.

`@hint`
Urutan flag tidak memengaruhi hasil.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Ya, tetapi itu bukan semua', 'Ya, tetapi itu bukan semua', 'Benar! Menambahkan spasi setelah bendera adalah gaya yang baik, tetapi tidak wajib.', 'Tidak, urutan bendera tidak masalah'])
```

---

## Apa yang tidak bisa dilakukan cut?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` adalah perintah yang sederhana.
Secara khusus,
perintah ini tidak memahami string yang diberi tanda kutip.
Jika, misalnya, berkas Anda adalah:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

maka:

```{shell}
cut -f 2 -d , everyone.csv
```

akan menghasilkan:

```
Age
Ranjit"
Rupinder"
```

bukan usia semua orang,
karena perintah ini akan mengira koma antara nama belakang dan nama depan adalah pemisah kolom.

<hr>

Apa keluaran dari `cut -d : -f 2-4` pada baris:

```
first:second:third:
```

(Perhatikan titik dua di bagian akhir.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Tidak satu pun di atas, karena tidak ada empat ruas.

`@hint`
Perhatikan tanda titik dua di bagian akhir.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Tidak, masih ada lagi.', 'Tidak, masih ada lagi.', 'Benar! Tanda titik dua di akhir membuat bidang keempat yang kosong.', 'Tidak, `cut` melakukan yang terbaik yang bisa dilakukan.'])
```

---

## Bagaimana saya dapat mengulang perintah?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Salah satu keunggulan terbesar menggunakan shell adalah
memudahkan Anda untuk mengulangi sesuatu.
Jika Anda menjalankan beberapa perintah,
Anda dapat menekan tombol panah atas untuk menelusuri kembali perintah-perintah tersebut.
Anda juga dapat menggunakan tombol panah kiri dan kanan serta tombol delete untuk mengeditnya.
Menekan return kemudian akan menjalankan perintah yang telah diubah.

Lebih baik lagi, `history` akan menampilkan daftar perintah yang baru-baru ini Anda jalankan.
Masing-masing didahului oleh nomor seri agar mudah menjalankan ulang perintah tertentu:
cukup ketik `!55` untuk menjalankan ulang perintah ke-55 dalam riwayat Anda (jika Anda memilikinya sebanyak itu).
Anda juga dapat menjalankan ulang perintah dengan mengetik tanda seru diikuti nama perintah,
seperti `!head` atau `!cut`,
 yang akan menjalankan ulang penggunaan perintah tersebut yang paling baru.

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
Jalankan `head summer.csv` di direktori home Anda (yang seharusnya gagal).

`@hint`
Pelengkapan tab tidak akan berfungsi jika tidak ada nama berkas yang cocok.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Gunakan `head` dan nama file, `summer.csv`. Jangan khawatir jika gagal. Seharusnya begitu.")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Ganti direktori ke `seasonal`.

`@hint`
Ingat bahwa `cd` berarti "change directory" (ganti direktori).

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Jika direktori kerja Anda saat ini (temukan dengan `pwd`) adalah `/home/repl`, Anda dapat pindah ke folder `seasonal` dengan `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Jalankan ulang perintah `head` dengan `!head`.

`@hint`
Jangan ketik spasi apa pun antara `!` dan yang mengikutinya.

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
                        incorrect_msg='Gunakan `!head` untuk mengulangi perintah `head`.'),
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
Gunakan `history` untuk melihat apa yang telah Anda lakukan.

`@hint`
Perhatikan bahwa `history` menampilkan perintah terbaru di bagian akhir, sehingga tetap terlihat di layar Anda saat selesai berjalan.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Gunakan `history` tanpa flag untuk mendapatkan daftar perintah sebelumnya.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Jalankan ulang `head` lagi menggunakan `!` diikuti nomor perintah.

`@hint`
Jangan mengetik spasi apa pun antara `!` dan yang mengikutinya.

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
                        incorrect_msg='Apakah Anda telah menggunakan `!<a_number>` untuk menjalankan ulang `head` terakhir dari riwayat?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Kerja bagus! Lanjut ke yang berikutnya!")
```

---

## Bagaimana cara memilih baris yang berisi nilai tertentu?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` dan `tail` memilih baris,
`cut` memilih kolom,
dan `grep` memilih baris berdasarkan isinya.
Dalam bentuk paling sederhana,
`grep` menerima potongan teks diikuti satu atau lebih nama berkas
dan mencetak semua baris dalam berkas-berkas tersebut yang memuat teks itu.
Sebagai contoh,
`grep bicuspid seasonal/winter.csv`
akan mencetak baris dari `winter.csv` yang berisi "bicuspid".

`grep` juga dapat mencari pola;
ini akan kita bahas di kursus berikutnya.
Yang lebih penting saat ini adalah beberapa flag `grep` yang umum:

- `-c`: mencetak jumlah baris yang cocok alih-alih menampilkan barisnya
- `-h`: jangan mencetak nama berkas saat mencari di banyak berkas
- `-i`: abaikan perbedaan huruf besar/kecil (mis., anggap "Regression" dan "regression" sebagai kecocokan)
- `-l`: mencetak nama berkas yang berisi kecocokan, bukan kecocokannya
- `-n`: mencetak nomor baris untuk baris yang cocok
- `-v`: membalik kecocokan, yaitu hanya menampilkan baris yang tidak cocok

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
Cetak isi semua baris yang berisi kata `molar` dalam `seasonal/autumn.csv`
dengan menjalankan satu perintah saat berada di direktori home Anda. Jangan gunakan flag apa pun.

`@hint`
Gunakan `grep` dengan kata yang Anda cari dan nama berkas tempat melakukan pencarian.

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
      has_code("grep", incorrect_msg = "Apakah Anda memanggil `grep`?"),
      has_code("molar", incorrect_msg = "Apakah Anda mencari `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Apakah Anda mencari file `seasonal/autumn.csv`?")
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
Balikkan kecocokan untuk menemukan semua baris yang tidak berisi kata `molar` dalam `seasonal/spring.csv`, dan tampilkan nomor barisnya.
Ingat, gaya yang baik adalah menempatkan semua flag sebelum nilai lain seperti nama berkas atau istilah pencarian "molar".

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
      has_code("grep", incorrect_msg = "Apakah Anda memanggil `grep`?"),
      has_code("-v", incorrect_msg = "Apakah Anda membalikkan pencocokan dengan `-v`?"),
      has_code("-n", incorrect_msg = "Apakah Anda menampilkan nomor baris dengan `-n`?"),
      has_code("molar", incorrect_msg = "Apakah Anda mencari `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Apakah Anda mencari file `seasonal/spring.csv`?")
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
Hitung berapa banyak baris yang berisi kata `incisor` di `autumn.csv` dan `winter.csv` secara gabungan.
(Sekali lagi, jalankan satu perintah dari direktori home Anda.)

`@hint`
Ingat untuk menggunakan `-c` dengan `grep` untuk menghitung baris.

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
      has_code("grep", incorrect_msg = "Apakah Anda memanggil `grep`?"),
      has_code("-c", incorrect_msg = "Apakah Anda mendapatkan hitungan dengan `-c`?"),
      has_code("incisor", incorrect_msg = "Apakah Anda mencari `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Apakah Anda mencari file `seasonal/autumn.csv`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Apakah Anda mencari file `seasonal/winter.csv`?")
    )
  )
)

```

---

## Mengapa tidak selalu aman memperlakukan data sebagai teks?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

Bagian `SEE ALSO` pada halaman manual untuk `cut` merujuk pada sebuah perintah bernama `paste`
yang dapat digunakan untuk menggabungkan berkas data alih-alih memotongnya.

<hr>

Baca halaman manual untuk `paste`,
kemudian jalankan `paste` untuk menggabungkan berkas data autumn dan winter ke dalam satu tabel
menggunakan koma sebagai pemisah.
Apa yang salah dengan keluarannya dari sudut pandang analisis data?

`@possible_answers`
- Judul kolom diulang.
- Beberapa baris terakhir memiliki jumlah kolom yang salah.
- Sebagian data dari `winter.csv` hilang.

`@hint`
Jika Anda menjalankan `cut` pada keluaran `paste` dengan koma sebagai pemisah,
apakah itu akan menghasilkan jawaban yang benar?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Benar, tetapi hal ini tidak selalu merupakan sebuah kesalahan.'
correct2 = 'Benar: menggabungkan baris dengan kolom hanya membuat satu kolom kosong di awal, bukan dua.'
err3 = 'Tidak, semua data musim dingin ada di sana.'
Ex().has_chosen(2, [err1, correct2, err3])
```

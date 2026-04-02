---
title: Memanipulasi berkas dan direktori
description: >-
  Bab ini adalah pengantar singkat tentang shell Unix. Anda akan mempelajari
  mengapa shell masih digunakan setelah hampir 50 tahun, bagaimana
  perbandingannya dengan alat grafis yang mungkin lebih Anda kenal, cara
  berpindah di dalam shell, serta cara membuat, mengubah, dan menghapus berkas
  serta folder.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Bagaimana shell dibandingkan dengan antarmuka desktop?
---

## Bagaimana perbandingan shell dengan antarmuka desktop?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Sistem operasi seperti Windows, Linux, atau Mac OS adalah jenis program khusus.
Program ini mengendalikan prosesor komputer, hard drive, dan koneksi jaringan,
namun tugas terpentingnya adalah menjalankan program lain.

Karena manusia tidak bersifat digital,
mereka memerlukan antarmuka untuk berinteraksi dengan sistem operasi.
Yang paling umum saat ini adalah penjelajah file grafis,
yang menerjemahkan klik dan klik ganda menjadi perintah untuk membuka file dan menjalankan program.
Sebelum komputer memiliki tampilan grafis,
orang-orang mengetikkan instruksi ke dalam program yang disebut **command-line shell**.
Setiap kali sebuah perintah dimasukkan,
shell menjalankan program lain,
menampilkan keluarannya dalam bentuk yang dapat dibaca manusia,
dan kemudian menampilkan sebuah *prompt* sebagai tanda siap menerima perintah berikutnya.
(Namanya berasal dari gagasan bahwa ia adalah "outer shell" dari komputer.)

Mengetik perintah alih-alih mengklik dan menyeret mungkin terasa canggung pada awalnya,
namun seperti yang akan Anda lihat,
setelah Anda mulai merinci apa yang ingin dilakukan komputer,
Anda dapat menggabungkan perintah lama untuk membuat perintah baru
dan mengotomatisasi operasi berulang
dengan hanya beberapa ketukan tombol.

<hr>
Apa hubungan antara penjelajah file grafis yang paling sering digunakan orang dan command-line shell?

`@hint`
Ingat bahwa pengguna hanya dapat berinteraksi dengan sistem operasi melalui sebuah program.

`@possible_answers`
- Penjelajah file memungkinkan Anda melihat dan mengedit file, sedangkan shell memungkinkan Anda menjalankan program.
- Penjelajah file dibangun di atas shell.
- Shell adalah bagian dari sistem operasi, sedangkan penjelajah file terpisah.
- [Keduanya merupakan antarmuka untuk memberikan perintah kepada sistem operasi.]

`@feedback`
- Keduanya memungkinkan Anda melihat dan mengedit file serta menjalankan program.
- Penjelajah file grafis dan shell sama-sama memanggil fungsi sistem operasi yang mendasarinya.
- Shell dan penjelajah file keduanya adalah program yang menerjemahkan perintah pengguna (diketik atau diklik) menjadi panggilan ke sistem operasi.
- Benar! Keduanya menerima perintah pengguna (baik diketik maupun diklik) dan mengirimkannya ke sistem operasi.

---

## Saya berada di mana?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**Filesystem** mengelola file dan direktori (atau folder).
Masing-masing diidentifikasi oleh **path absolut**
yang menunjukkan cara mencapainya dari **root directory** filesystem:
`/home/repl` adalah direktori `repl` di dalam direktori `home`,
sedangkan `/home/repl/course.txt` adalah file `course.txt` di direktori tersebut,
dan `/` sendiri adalah root directory.

Untuk mengetahui lokasi Anda di dalam filesystem,
jalankan perintah `pwd`
(kependekan dari "**p**rint **w**orking **d**irectory").
Perintah ini mencetak path absolut dari **current working directory** Anda,
yaitu lokasi tempat shell menjalankan perintah dan mencari file secara default.

<hr>
Jalankan `pwd`.
Anda sedang berada di mana sekarang?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Sistem Unix umumnya menempatkan semua direktori home pengguna di bawah `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Itu bukan jalur yang benar."
correct = "Benar - Anda berada di `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Bagaimana cara saya mengenali file dan direktori?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` memberi tahu Anda posisi saat ini.
Untuk melihat apa saja yang ada di sana,
ketik `ls` (singkatan dari "**l**i**s**ting") lalu tekan tombol enter.
Jika dijalankan tanpa argumen,
`ls` menampilkan isi direktori Anda saat ini
(yang ditunjukkan oleh `pwd`).
Jika Anda menambahkan nama beberapa file,
`ls` akan menampilkannya,
dan jika Anda menambahkan nama direktori,
perintah ini akan menampilkan isi direktori tersebut.
Sebagai contoh,
`ls /home/repl` menampilkan isi direktori awal Anda
(yang biasanya disebut **home directory**).

<hr>
Gunakan `ls` dengan argumen yang sesuai untuk menampilkan file di direktori `/home/repl/seasonal`
(yang berisi informasi tentang operasi gigi berdasarkan tanggal, diuraikan per musim).
Manakah dari file berikut yang tidak ada di direktori tersebut?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Jika Anda memberikan sebuah path kepada `ls`, perintah ini akan menampilkan apa saja yang ada di path tersebut.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "File tersebut ada di direktori `seasonal`."
correct = "Benar - file tersebut *tidak* ada di direktori `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Apa lagi cara saya mengidentifikasi berkas dan direktori?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Path absolut mirip dengan garis lintang dan bujur: nilainya sama di mana pun Anda berada. Sementara itu, **path relatif** menentukan lokasi mulai dari posisi Anda saat ini: seperti berkata "20 kilometer ke utara".

Sebagai contoh:
- Jika Anda berada di direktori `/home/repl`, **path relatif** `seasonal` menunjuk direktori yang sama dengan **path absolut** `/home/repl/seasonal`. 
- Jika Anda berada di direktori `/home/repl/seasonal`, **path relatif** `winter.csv` menunjuk berkas yang sama dengan **path absolut** `/home/repl/seasonal/winter.csv`.

Shell menentukan apakah sebuah path absolut atau relatif dengan melihat karakter pertamanya: Jika dimulai dengan `/`, itu adalah absolut. Jika *tidak* dimulai dengan `/`, itu adalah relatif.

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
Anda berada di `/home/repl`. Gunakan `ls` dengan **path relatif** untuk menampilkan berkas yang memiliki path absolut `/home/repl/course.txt` (dan hanya berkas itu).

`@hint`
Sering kali Anda dapat menyusun path relatif ke sebuah berkas atau direktori di bawah lokasi Anda saat ini
dengan mengurangkan path absolut lokasi Anda saat ini
dari path absolut objek yang Anda inginkan.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Anda tidak memanggil `ls` untuk menghasilkan daftar file."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Perintah Anda tidak menghasilkan daftar file yang benar. Gunakan `ls` diikuti dengan path relatif ke `/home/repl/course.txt`.")
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
Anda berada di `/home/repl`.
Gunakan `ls` dengan **path relatif**
untuk menampilkan berkas `/home/repl/seasonal/summer.csv` (dan hanya berkas itu).

`@hint`
Path relatif *tidak* diawali dengan '/' di depan.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Anda tidak memanggil `ls` untuk menghasilkan daftar file."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Perintah Anda tidak menghasilkan daftar file yang benar. Gunakan `ls` diikuti dengan path relatif ke `/home/repl/seasonal/summer.csv`.")
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
Anda berada di `/home/repl`.
Gunakan `ls` dengan **path relatif**
untuk menampilkan isi direktori `/home/repl/people`.

`@hint`
Path relatif tidak diawali dengan '/' di depan.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Anda belum memanggil `ls` untuk menghasilkan daftar file."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Perintah Anda tidak menghasilkan daftar file yang benar. Gunakan `ls` diikuti dengan path relatif ke `/home/repl/people`.")
    )
)
Ex().success_msg("Kerja bagus. Sekarang setelah Anda mengetahui tentang daftar file dan direktori, mari kita lihat bagaimana Anda dapat berpindah di sekitar sistem file!")
```

---

## Bagaimana cara berpindah ke direktori lain?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Sama seperti Anda dapat berpindah di penjelajah berkas dengan mengeklik ganda folder, Anda dapat berpindah di sistem berkas menggunakan perintah `cd` (singkatan dari "change directory").

Jika Anda mengetik `cd seasonal` lalu mengetik `pwd`, shell akan memberi tahu bahwa Anda sekarang berada di `/home/repl/seasonal`.
Jika Anda kemudian menjalankan `ls` tanpa argumen, perintah tersebut menampilkan isi `/home/repl/seasonal`, karena itulah lokasi Anda saat ini.
Jika Anda ingin kembali ke direktori home Anda `/home/repl`, Anda dapat menggunakan perintah `cd /home/repl`.

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
Anda berada di `/home/repl`/.
Ubah direktori ke `/home/repl/seasonal` menggunakan path relatif.

`@hint`
Ingat bahwa `cd` adalah singkatan dari "change directory" dan bahwa path relatif tidak diawali dengan '/' di depan.

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
key: e69c8eac15
xp: 35
```

`@instructions`
Gunakan `pwd` untuk memastikan bahwa Anda sudah di sana.

`@hint`
Jangan lupa menekan "enter" atau "return" setelah memasukkan perintah.

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
Gunakan `ls` tanpa path apa pun untuk melihat isi direktori tersebut.

`@hint`
Jangan lupa menekan "enter" atau "return" setelah perintah.

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
      has_code('ls', incorrect_msg="Perintah Anda tidak menghasilkan keluaran yang benar. Apakah Anda telah menggunakan `ls` tanpa jalur untuk menampilkan isi dari direktori saat ini?")
    )
)

Ex().success_msg("Bagus! Ini tentang menavigasi ke subdirektori. Bagaimana dengan bergerak ke atas? Mari kita cari tahu!")
```

---

## Bagaimana saya bisa naik satu direktori?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

**Induk** dari sebuah direktori adalah direktori di atasnya.
Sebagai contoh, `/home` adalah induk dari `/home/repl`,
dan `/home/repl` adalah induk dari `/home/repl/seasonal`.
Anda selalu dapat memberikan path absolut dari direktori induk Anda ke perintah seperti `cd` dan `ls`.
Namun, lebih sering,
Anda akan memanfaatkan fakta bahwa path khusus `..`
(dua titik tanpa spasi) berarti "direktori di atas direktori saya saat ini".
Jika Anda berada di `/home/repl/seasonal`,
maka `cd ..` akan membawa Anda naik ke `/home/repl`.
Jika Anda menggunakan `cd ..` sekali lagi,
Anda akan berada di `/home`.
Satu `cd ..` lagi akan menempatkan Anda di *root directory* `/`,
yaitu bagian paling atas dari sistem berkas.
(Ingat untuk memberi spasi antara `cd` dan `..` - itu adalah sebuah perintah dan sebuah path, bukan satu perintah empat huruf.)

Satu titik tunggal, `.`, selalu berarti "direktori saat ini",
jadi `ls` sendiri dan `ls .` melakukan hal yang sama,
sedangkan `cd .` tidak berdampak apa pun
(karena itu memindahkan Anda ke direktori tempat Anda sudah berada).

Satu path khusus terakhir adalah `~` (karakter tilde),
yang berarti "direktori home Anda",
seperti `/home/repl`.
Di mana pun Anda berada,
`ls ~` akan selalu menampilkan isi direktori home Anda,
dan `cd ~` akan selalu membawa Anda kembali ke home.

<hr>
Jika Anda berada di `/home/repl/seasonal`,
ke mana `cd ~/../.` akan membawa Anda?

`@hint`
Telusuri jalurnya satu direktori demi satu direktori.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (root directory)

`@feedback`
- Tidak, tetapi `~` atau `..` sendiri akan membawa Anda ke sana.
- Benar! Jalur tersebut berarti 'direktori home', 'naik satu tingkat', 'di sini'.
- Tidak, tetapi `.` sendiri akan melakukan itu.
- Tidak, bagian akhir jalurnya adalah `.` (berarti "di sini") bukan `..` (berarti "naik").

---

## Bagaimana cara menyalin file?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Sering kali Anda ingin menyalin file,
memindahkannya ke direktori lain untuk menata,
atau mengganti namanya.
Salah satu perintah untuk melakukan ini adalah `cp`, singkatan dari "copy".
Jika `original.txt` adalah file yang sudah ada,
maka:

```{shell}
cp original.txt duplicate.txt
```

membuat salinan `original.txt` bernama `duplicate.txt`.
Jika sudah ada file bernama `duplicate.txt`,
file tersebut akan ditimpa.
Jika parameter terakhir untuk `cp` adalah direktori yang sudah ada,
maka perintah seperti:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

menyalin *semua* file tersebut ke dalam direktori itu.

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
Buat salinan `seasonal/summer.csv` di direktori `backup` (yang juga berada di `/home/repl`),
dengan menamai file baru tersebut `summer.bck`.

`@hint`
Gabungkan nama direktori tujuan dan nama file yang disalin
untuk membuat path relatif bagi file baru.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` tampaknya tidak ada di direktori `backup`. Berikan dua jalur ke `cp`: file yang ada (`seasonal/summer.csv`) dan file tujuan (`backup/summer.bck`)."),
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
Salin `spring.csv` dan `summer.csv` dari direktori `seasonal` ke direktori `backup`
*tanpa* mengubah direktori kerja Anda saat ini (`/home/repl`).

`@hint`
Gunakan `cp` dengan nama file yang ingin Anda salin
dan *kemudian* nama direktori tujuan penyalinan.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` tampaknya belum disalin ke dalam direktori `backup`. Berikan dua nama file dan satu nama direktori ke `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Pastikan untuk menyalin file saat berada di `{{dir}}`! Gunakan `cd {{dir}}` untuk kembali ke sana."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Kerja bagus. Selain menyalin, kita juga harus bisa memindahkan file dari satu direktori ke direktori lain. Pelajari lebih lanjut di latihan berikutnya!")
```

---

## Bagaimana cara memindahkan sebuah file?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Sementara `cp` menyalin sebuah file,
`mv` memindahkannya dari satu direktori ke direktori lain,
seperti ketika Anda menyeretnya di peramban file grafis.
Perintah ini menangani parameternya dengan cara yang sama seperti `cp`,
jadi perintah:

```{shell}
mv autumn.csv winter.csv ..
```

memindahkan file `autumn.csv` dan `winter.csv` dari direktori kerja saat ini
naik satu tingkat ke direktori induknya
(karena `..` selalu merujuk ke direktori di atas lokasi Anda saat ini).

`@instructions`
Anda berada di `/home/repl`, yang memiliki subdirektori `seasonal` dan `backup`.
Dengan satu perintah, pindahkan `spring.csv` dan `summer.csv` dari `seasonal` ke `backup`.

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
backup_patt="File `%s` tidak ada di direktori `backup`. Apakah Anda telah menggunakan `mv` dengan benar? Gunakan dua nama file dan satu direktori sebagai parameter untuk `mv`."
seasonal_patt="File `%s` masih ada di direktori `seasonal`. Pastikan untuk memindahkan file dengan `mv` daripada menyalinnya dengan `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Bagus sekali, mari kita lanjutkan pelatihan shell ini!")
```

---

## Bagaimana cara mengubah nama file?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` juga dapat digunakan untuk mengubah nama file. Jika Anda menjalankan:

```{shell}
mv course.txt old-course.txt
```

maka file `course.txt` di direktori kerja saat ini akan "dipindahkan" menjadi file `old-course.txt`.
Ini berbeda dengan cara kerja peramban file,
namun sering kali berguna.

Satu peringatan:
sama seperti `cp`,
`mv` akan menimpa file yang sudah ada.
Jika,
misalnya,
Anda sudah memiliki file bernama `old-course.txt`,
maka perintah di atas akan menggantinya dengan apa pun yang ada di `course.txt`.

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
Masuk ke direktori `seasonal`.

`@hint`
Ingat bahwa `cd` adalah singkatan dari "change directory" dan bahwa path relatif tidak diawali dengan '/'.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
Ubah nama file `winter.csv` menjadi `winter.csv.bck`.

`@hint`
Gunakan `mv` dengan nama file saat ini dan nama yang Anda inginkan dalam urutan tersebut.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Gunakan `mv` dengan dua argumen: file yang ingin Anda ganti namanya (`winter.csv`) dan nama baru untuk file tersebut (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Kami mengharapkan untuk menemukan `winter.csv.bck` di dalam direktori." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Kami tidak lagi mengharapkan `winter.csv` berada di dalam direktori." + hint)
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
Jalankan `ls` untuk memeriksa bahwa semuanya berhasil.

`@hint`
Jangan lupa menekan "enter" atau "return" untuk menjalankan perintah.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Apakah Anda telah menggunakan `ls` untuk mencantumkan isi dari direktori kerja Anda saat ini?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Perintah Anda tidak menghasilkan daftar file yang benar. Gunakan `ls` tanpa argumen untuk mencantumkan isi dari direktori kerja Anda saat ini.")
    )
)
Ex().success_msg("Menyalin, memindahkan, mengganti nama, Anda sudah menguasainya! Selanjutnya: menghapus file.")
```

---

## Bagaimana cara saya menghapus file?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Kita dapat menyalin file dan memindahkannya;
untuk menghapusnya,
kita menggunakan `rm`,
yang merupakan singkatan dari "remove".
Seperti halnya `cp` dan `mv`,
Anda dapat memberikan `rm` sebanyak mungkin nama file yang Anda inginkan, jadi:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

menghapus baik `thesis.txt` maupun `backup/thesis-2017-08.txt`

`rm` melakukan persis seperti namanya,
dan melakukannya seketika:
berbeda dengan penelusur file grafis,
shell tidak memiliki tempat sampah,
jadi saat Anda mengetik perintah di atas,
skripsi Anda akan hilang secara permanen.

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
Anda berada di `/home/repl`.
Masuk ke direktori `seasonal`.

`@hint`
Ingat bahwa `cd` adalah singkatan dari "change directory" dan bahwa path relatif tidak diawali dengan '/'.

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
Hapus `autumn.csv`.

`@hint`
Ingat bahwa `rm` adalah singkatan dari "remove".

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Kami tidak mengharapkan `autumn.csv` masih ada di direktori `seasonal`. Gunakan `rm` dengan path ke file yang ingin Anda hapus."),
    has_code('rm', incorrect_msg = 'Gunakan `rm` untuk menghapus file, daripada memindahkannya.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Kembali ke direktori home Anda.

`@hint`
Jika Anda menggunakan `cd` tanpa path apa pun, Anda akan dibawa ke direktori home Anda.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Gunakan `cd ..` atau `cd ~` untuk kembali ke direktori home.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Hapus `seasonal/summer.csv` tanpa mengganti direktori lagi.

`@hint`
Ingat bahwa `rm` adalah singkatan dari "remove".

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Kami tidak mengharapkan `summer.csv` masih ada di direktori `seasonal`. Gunakan `rm` dengan path ke file yang ingin Anda hapus."),
    has_code('rm', incorrect_msg = 'Gunakan `rm` untuk menghapus file, daripada memindahkannya.')
)
Ex().success_msg("Kerja yang mengesankan! Lanjut ke yang berikutnya!")
```

---

## Bagaimana cara saya membuat dan menghapus direktori?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` memperlakukan direktori sama seperti memperlakukan file:
jika Anda berada di direktori home dan menjalankan `mv seasonal by-season`,
misalnya,
`mv` akan mengubah nama direktori `seasonal` menjadi `by-season`.
Namun,
`rm` bekerja secara berbeda.

Jika Anda mencoba menjalankan `rm` pada sebuah direktori,
shell akan menampilkan pesan galat yang memberitahukan bahwa perintah itu tidak dapat dilakukan,
terutama untuk mencegah Anda tidak sengaja menghapus seluruh direktori yang berisi pekerjaan.
Sebagai gantinya,
Anda dapat menggunakan perintah terpisah bernama `rmdir`.
Untuk keamanan tambahan,
perintah ini hanya berfungsi ketika direktori tersebut kosong,
jadi Anda harus menghapus file dalam sebuah direktori *sebelum* Anda menghapus direktori tersebut.
(Pengguna berpengalaman dapat menggunakan opsi `-r` pada `rm` untuk mendapatkan efek yang sama;
kami akan membahas opsi perintah di bab berikutnya.)

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
Tanpa berpindah direktori,
hapus file `agarwal.txt` di direktori `people`.

`@hint`
Ingat bahwa `rm` adalah singkatan dari "remove" dan bahwa path relatif tidak diawali dengan '/' di depannya.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` seharusnya tidak lagi berada di `/home/repl/people`. Apakah Anda telah menggunakan `rm` dengan benar?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'Masih ada file di direktori `people`. Jika Anda hanya memindahkan `agarwal.txt`, atau membuat file baru, hapus semuanya.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Sekarang direktori `people` sudah kosong,
gunakan satu perintah untuk menghapusnya.

`@hint`
Ingat bahwa `rm` hanya berfungsi pada file.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "Direktori 'people' seharusnya tidak lagi ada di direktori home Anda. Gunakan `rmdir` untuk menghapusnya!")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Karena direktori bukan file,
Anda harus menggunakan perintah `mkdir directory_name`
untuk membuat direktori baru (kosong).
Gunakan perintah ini untuk membuat direktori baru bernama `yearly` di bawah direktori home Anda.

`@hint`
Jalankan `mkdir` dengan nama direktori yang ingin Anda buat.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Tidak ada direktori `yearly` di direktori home Anda. Gunakan `mkdir yearly` untuk membuatnya!")
)

```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Sekarang `yearly` sudah ada,
buat direktori lain bernama `2017` di dalamnya
*tanpa* meninggalkan direktori home Anda.

`@hint`
Gunakan path relatif untuk subdirektori yang ingin Anda buat.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Tidak dapat menemukan direktori '2017' di '/home/repl/yearly'. Anda dapat membuat direktori ini menggunakan path relatif `yearly/2017`.")
)
Ex().success_msg("Keren! Mari kita akhiri bab ini dengan latihan yang mengulang beberapa konsepnya!")
```

---

## Menyimpulkan

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Anda sering kali akan membuat berkas perantara saat menganalisis data.
Alih-alih menyimpannya di direktori home,
Anda dapat menaruhnya di `/tmp`,
yaitu tempat orang dan program sering menyimpan berkas yang hanya dibutuhkan sebentar.
(Perhatikan bahwa `/tmp` berada tepat di bawah direktori root `/`,
*bukan* di bawah direktori home Anda.)
Latihan penutup ini akan menunjukkan cara melakukannya.

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
Gunakan `cd` untuk masuk ke `/tmp`.

`@hint`
Ingat bahwa `cd` adalah singkatan dari "change directory" dan bahwa path absolut diawali dengan '/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Anda berada di direktori yang salah. Gunakan `cd` untuk mengubah direktori ke `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Daftar isi `/tmp` *tanpa* mengetikkan nama direktori.

`@hint`
Jika Anda tidak memberi tahu `ls` apa yang akan didaftar, perintah ini akan menampilkan isi direktori saat ini.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Anda tidak memanggil `ls` untuk menghasilkan daftar file."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Perintah Anda tidak menghasilkan daftar file yang benar. Gunakan `ls` tanpa`.")
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
Buat direktori baru di dalam `/tmp` bernama `scratch`.

`@hint`
Gunakan `mkdir` untuk membuat direktori.

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
      has_code('mkdir +scratch', incorrect_msg="Tidak dapat menemukan direktori 'scratch' di bawah '/tmp'. Pastikan untuk menggunakan `mkdir` dengan benar.")
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
Pindahkan `/home/repl/people/agarwal.txt` ke `/tmp/scratch`.
Kami menyarankan Anda menggunakan pintasan `~` untuk direktori home Anda dan path relatif untuk yang kedua alih-alih path absolut.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Tidak dapat menemukan 'agarwal.txt' di '/tmp/scratch'. Gunakan `mv` dengan `~/people/agarwal.txt` sebagai parameter pertama dan `scratch` sebagai parameter kedua.")
)
Ex().success_msg("Ini mengakhiri Bab 1 dari Pengantar Shell! Bergegaslah ke bab berikutnya untuk mempelajari lebih lanjut tentang memanipulasi data!")
```

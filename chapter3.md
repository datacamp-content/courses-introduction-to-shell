---
title: Menggabungkan alat
description: >-
  Kekuatan sebenarnya dari shell Unix tidak terletak pada perintah-perintah
  individual, melainkan pada betapa mudahnya menggabungkannya untuk melakukan
  hal baru. Bab ini akan menunjukkan cara memanfaatkan kekuatan tersebut untuk
  memilih data yang Anda inginkan, serta memperkenalkan perintah untuk
  mengurutkan nilai dan menghapus duplikat.
lessons:
  - nb_of_exercises: 12
    title: Bagaimana cara menyimpan keluaran perintah ke dalam sebuah berkas?
---

## Bagaimana cara menyimpan keluaran perintah ke dalam sebuah file?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Semua alat yang Anda lihat sejauh ini memungkinkan Anda menyebutkan file masukan.
Kebanyakan tidak memiliki opsi untuk menamai file keluaran karena tidak membutuhkannya.
Sebagai gantinya,
Anda dapat menggunakan **pengalihan (redirection)** untuk menyimpan keluaran perintah apa pun ke mana pun Anda mau.
Jika Anda menjalankan perintah ini:

```{shell}
head -n 5 seasonal/summer.csv
```

perintah tersebut menampilkan 5 baris pertama data musim panas di layar.
Jika sebagai gantinya Anda menjalankan perintah ini:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

tidak ada yang muncul di layar.
Sebagai gantinya,
keluaran `head` dimasukkan ke file baru bernama `top.csv`.
Anda dapat melihat isi file tersebut menggunakan `cat`:

```{shell}
cat top.csv
```

Tanda lebih besar `>` memberi tahu shell untuk mengalihkan keluaran `head` ke sebuah file.
Tanda itu bukan bagian dari perintah `head`;
sebaliknya,
itu bekerja dengan setiap perintah shell yang menghasilkan keluaran.

`@instructions`
Gabungkan `tail` dengan pengalihan untuk menyimpan 5 baris terakhir dari `seasonal/winter.csv` ke dalam file bernama `last.csv`.

`@hint`
Gunakan `tail -n 5` untuk mengambil 5 baris terakhir.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "Baris `%s` seharusnya ada di dalam file `last.csv`, tetapi tidak ada. Arahkan keluaran dari `tail -n 5 seasonal/winter.csv` ke `last.csv` dengan `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` memiliki terlalu banyak baris. Apakah Anda menggunakan bendera `-n 5` dengan `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Bagus! Mari berlatih lebih banyak lagi!")
```

---

## Bagaimana saya dapat menggunakan keluaran sebuah perintah sebagai masukan?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Misalkan Anda ingin mengambil baris dari bagian tengah sebuah berkas.
Lebih khusus lagi,
misalkan Anda ingin mengambil baris ke-3 hingga ke-5 dari salah satu berkas data kami.
Anda dapat mulai dengan menggunakan `head` untuk mengambil 5 baris pertama
lalu mengalihkan hasilnya ke sebuah berkas,
dan kemudian menggunakan `tail` untuk memilih 3 baris terakhir:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Pemeriksaan singkat mengonfirmasi bahwa ini adalah baris ke-3 hingga ke-5 dari berkas asli,
karena itu merupakan 3 baris terakhir dari 5 baris pertama.

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
Pilih dua baris terakhir dari `seasonal/winter.csv`
dan simpan dalam berkas bernama `bottom.csv`.

`@hint`
Gunakan `tail` untuk memilih baris dan `>` untuk mengalihkan keluaran `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="Baris `%s` seharusnya ada di dalam file `bottom.csv`, tetapi tidak ada. Arahkan keluaran dari `tail -n 2 seasonal/winter.csv` ke `bottom.csv` dengan `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` memiliki terlalu banyak baris. Apakah Anda menggunakan bendera `-n 2` dengan `tail`?'),
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
Pilih baris pertama dari `bottom.csv`
untuk mendapatkan baris kedua dari belakang dari berkas asli.

`@hint`
Gunakan `head` untuk memilih baris yang Anda inginkan.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Ada yang salah dengan file `bottom.csv`. Pastikan Anda tidak mengubahnya!"),
    has_expr_output(strict=True, incorrect_msg="Apakah Anda telah menggunakan `head` dengan benar pada `bottom.csv`? Pastikan untuk menggunakan flag `-n` dengan benar.")
)

Ex().success_msg("Kerja bagus. Lanjutkan ke latihan berikutnya untuk mengetahui cara yang lebih baik dalam menggabungkan perintah.")                             

```

---

## Apa cara yang lebih baik untuk menggabungkan perintah?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Menggunakan pengalihan untuk menggabungkan perintah memiliki dua kelemahan:

1. Menyisakan banyak berkas perantara (seperti `top.csv`).
2. Perintah untuk menghasilkan hasil akhir tersebar di beberapa baris riwayat.

Shell menyediakan alat lain yang menyelesaikan kedua masalah ini sekaligus yang disebut **pipe**.
Sekali lagi,
mulailah dengan menjalankan `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

Alih-alih mengirim keluaran `head` ke sebuah berkas,
tambahkan sebuah garis vertikal dan perintah `tail` *tanpa* nama berkas:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Simbol pipe memberi tahu shell untuk menggunakan keluaran perintah di sebelah kiri
sebagai masukan ke perintah di sebelah kanan.

`@instructions`
Gunakan `cut` untuk memilih semua nama gigi dari kolom 2 pada berkas berformat koma `seasonal/summer.csv`, lalu salurkan hasilnya ke `grep`, dengan pencocokan terbalik, untuk mengecualikan baris header yang berisi kata "Tooth". *`cut` dan `grep` telah dibahas secara rinci di Bab 2, masing-masing pada latihan 8 dan 11.*

`@hint`
- Bagian pertama perintah berbentuk `cut -d field_delimiter -f column_number filename`.
- Bagian kedua perintah berbentuk `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'Apakah Anda telah mengalirkan hasil dari `cut -d , -f 2 seasonal/summer.csv` ke dalam `grep -v Tooth` dengan `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Apakah Anda telah mengecualikan baris header `"Tooth"` menggunakan `grep`?')
)
Ex().success_msg("Penyambungan sempurna! Ini mungkin pertama kalinya Anda menggunakan `|`, tetapi ini pasti bukan yang terakhir!")
```

---

## Bagaimana cara menggabungkan banyak perintah?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Anda dapat merangkai sejumlah perintah.
Sebagai contoh,
perintah berikut:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

akan:

1. memilih kolom pertama dari data spring;
2. menghapus baris header yang berisi kata "Date"; dan
3. memilih 10 baris pertama dari data sebenarnya.

`@instructions`
Pada latihan sebelumnya, Anda menggunakan perintah berikut untuk memilih semua nama gigi dari kolom 2 berkas `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Perluas pipeline ini dengan perintah `head` untuk hanya memilih nama gigi yang paling pertama.

`@hint`
Salin dan tempelkan kode pada instruksi, tambahkan pipe, lalu panggil `head` dengan flag `-n`.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Apakah Anda telah menggunakan `|` untuk memperpanjang pipeline dengan perintah `head`? Pastikan untuk mengatur flag `-n` dengan benar."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Apakah Anda telah menggunakan `|` untuk memperpanjang pipeline dengan perintah `head`?")
)
Ex().success_msg("Penggabungan yang ceria! Dengan menggabungkan beberapa perintah bersama-sama, Anda dapat membangun pipeline manipulasi data yang kuat.")
```

---

## Bagaimana cara menghitung jumlah rekaman dalam sebuah berkas?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Perintah `wc` (singkatan dari "word count") menampilkan jumlah **c**aracter (karakter), **w**ords (kata), dan **l**ines (baris) dalam sebuah berkas.
Anda dapat membuatnya hanya menampilkan salah satu di antaranya dengan menggunakan `-c`, `-w`, atau `-l` masing-masing.

`@instructions`
Hitung berapa banyak rekaman di `seasonal/spring.csv` yang memiliki tanggal pada Juli 2017 (`2017-07`). 
- Untuk melakukannya, gunakan `grep` dengan tanggal parsial untuk memilih baris, lalu teruskan hasilnya ke `wc` dengan flag yang sesuai untuk menghitung baris.

`@hint`
- Gunakan `head seasonal/spring.csv` untuk mengingat kembali format tanggal.
- Bagian pertama perintah berbentuk `grep thing_to_match filename`.
- Setelah pipa, `|`, panggil `wc` dengan flag `-l`.

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
      has_code("grep", incorrect_msg = "Apakah Anda memanggil `grep`?"),
      has_code("2017-07", incorrect_msg = "Apakah Anda mencari `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Apakah Anda mencari file `seasonal/spring.csv`?"),
      has_code("|", incorrect_msg = "Apakah Anda mengalirkan ke `wc` menggunakan `|`?"),      
      has_code("wc", incorrect_msg = "Apakah Anda memanggil `wc`?"),
      has_code("-l", incorrect_msg = "Apakah Anda menghitung baris dengan `-l`?")
    )
  )
)
Ex().success_msg("Penghitungan yang cermat! Menentukan seberapa banyak data yang Anda miliki adalah langkah pertama yang baik dalam analisis data apa pun.")
```

---

## Bagaimana cara menentukan banyak berkas sekaligus?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

Sebagian besar perintah shell dapat bekerja pada banyak berkas jika Anda memberikan banyak nama berkas.
Sebagai contoh,
Anda dapat mengambil kolom pertama dari semua berkas data musiman sekaligus seperti ini:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Namun, mengetikkan banyak nama berkas berulang kali bukanlah ide yang baik:
itu membuang waktu,
dan cepat atau lambat Anda akan melewatkan sebuah berkas atau mengulangi nama berkas.
Agar pekerjaan Anda lebih mudah,
shell memungkinkan Anda menggunakan **wildcard** untuk menentukan daftar berkas dengan satu ekspresi.
Wildcard yang paling umum adalah `*`,
yang berarti "cocokkan nol atau lebih karakter".
Dengan menggunakannya,
kita dapat memendekkan perintah `cut` di atas menjadi seperti ini:

```{shell}
cut -d , -f 1 seasonal/*
```

atau:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Tulis satu perintah menggunakan `head` untuk mengambil tiga baris pertama dari `seasonal/spring.csv` dan `seasonal/summer.csv`, total enam baris data, tetapi bukan dari berkas data autumn atau winter.
Gunakan wildcard alih-alih menuliskan nama berkas secara lengkap.

`@hint`
- Perintahnya berbentuk `head -n jumlah_baris pola_nama_berkas`.
- Anda dapat mencocokkan berkas di direktori `a` yang diawali huruf `b` dengan `a/b*`, sebagai contoh.

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
    has_expr_output(incorrect_msg = "Anda dapat menggunakan `seasonal/s*` untuk memilih `seasonal/spring.csv` dan `seasonal/summer.csv`. Pastikan hanya menyertakan tiga baris pertama dari setiap file dengan flag `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Jangan sertakan output untuk `seasonal/autumn.csv`. Anda dapat menggunakan `seasonal/s*` untuk memilih `seasonal/spring.csv` dan `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Jangan sertakan output untuk `seasonal/winter.csv`. Anda dapat menggunakan `seasonal/s*` untuk memilih `seasonal/spring.csv` dan `seasonal/summer.csv`")
)
Ex().success_msg("Kerja wildcard yang luar biasa! Ini menjadi lebih penting jika direktori Anda berisi ratusan atau ribuan file.")
```

---

## Wildcard lain apa yang bisa saya gunakan?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Shell juga memiliki wildcard lain,
meskipun lebih jarang digunakan:

- `?` mencocokkan satu karakter, sehingga `201?.txt` akan cocok dengan `2017.txt` atau `2018.txt`, tetapi tidak dengan `2017-01.txt`.
- `[...]` mencocokkan salah satu karakter di dalam tanda kurung siku, sehingga `201[78].txt` cocok dengan `2017.txt` atau `2018.txt`, tetapi tidak dengan `2016.txt`.
- `{...}` mencocokkan salah satu pola yang dipisahkan koma di dalam tanda kurung kurawal, sehingga `{*.txt, *.csv}` mencocokkan berkas apa pun yang namanya diakhiri dengan `.txt` atau `.csv`, tetapi tidak berkas yang namanya diakhiri dengan `.pdf`.

<hr/>

Ekspresi mana yang akan cocok dengan `singh.pdf` dan `johel.txt` tetapi tidak dengan `sandhu.pdf` atau `sandhu.txt`?

`@hint`
Cocokkan setiap ekspresi dengan setiap nama berkas secara berurutan.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Tidak: `.pdf` dan `.txt` bukan nama berkas.
- Tidak: ini akan cocok dengan `sandhu.pdf`.
- Tidak: ekspresi dalam tanda kurung siku hanya mencocokkan satu karakter, bukan seluruh kata.
- Benar!

---

## Bagaimana saya dapat mengurutkan baris teks?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Sesuai namanya,
`sort` menata data.
Secara bawaan, ini dilakukan dalam urutan alfabet naik,
namun flag `-n` dan `-r` dapat digunakan untuk mengurutkan secara numerik dan membalik urutan keluarannya,
sedangkan `-b` memerintahkannya untuk mengabaikan spasi di awal baris
dan `-f` memerintahkannya untuk **f**old case (yakni tidak peka huruf besar-kecil).
Pipa sering menggunakan `grep` untuk menyingkirkan rekaman yang tidak diinginkan
lalu `sort` untuk menata rekaman yang tersisa.

`@instructions`
Masih ingat kombinasi `cut` dan `grep` untuk memilih semua nama gigi dari kolom 2 berkas `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Mulai dari resep ini, urutkan nama gigi dalam `seasonal/winter.csv` (bukan `summer.csv`) dalam urutan alfabet menurun. Untuk melakukannya, perluas pipeline dengan langkah `sort`.

`@hint`
Salin dan tempel perintah pada instruksi, ganti nama berkas, tambahkan pipe, lalu panggil `sort` dengan flag `-r`.

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
      has_code("cut", incorrect_msg = "Apakah Anda memanggil `cut`?"),
      has_code("-d", incorrect_msg = "Apakah Anda menentukan pembatas bidang dengan `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Apakah Anda mendapatkan data dari file `seasonal/winter.csv`?"),
      has_code("|", incorrect_msg = "Apakah Anda menggunakan pipe dari `cut` ke `grep` ke `sort` menggunakan `|`?"),      
      has_code("grep", incorrect_msg = "Apakah Anda memanggil `grep`?"),
      has_code("-v", incorrect_msg = "Apakah Anda membalikkan pencocokan dengan `-v`?"),
      has_code("Tooth", incorrect_msg = "Apakah Anda mencari `Tooth`?"),
      has_code("sort", incorrect_msg = "Apakah Anda memanggil `sort`?"),
      has_code("-r", incorrect_msg = "Apakah Anda membalikkan urutan pengurutan dengan `-r`?")
    )
  )
)
Ex().success_msg("Diurutkan! `sort` memiliki banyak kegunaan. Sebagai contoh, menggunakan pipe `sort -n` ke `head` menunjukkan nilai terbesar.")
```

---

## Bagaimana cara menghapus baris duplikat?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Perintah lain yang sering digunakan dengan `sort` adalah `uniq`,
yang bertugas menghapus baris yang terduplikasi.
Lebih spesifik lagi,
perintah ini menghapus baris duplikat yang *berdampingan*.
Jika sebuah file berisi:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

maka `uniq` akan menghasilkan:

```
2017-07-03
2017-08-03
```

namun jika berisi:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

maka `uniq` akan mencetak keempat baris tersebut.
Alasannya adalah `uniq` dibuat untuk bekerja dengan file yang sangat besar.
Untuk menghapus baris yang tidak berdampingan dari sebuah file,
perintah ini harus menyimpan seluruh file dalam memori
(atau setidaknya,
semua baris unik yang sudah ditemui).
Dengan hanya menghapus duplikat yang berdampingan,
perintah ini hanya perlu menyimpan baris unik terbaru di memori.

`@instructions`
Tulis sebuah pipeline untuk:

- mengambil kolom kedua dari `seasonal/winter.csv`,
- menghapus kata "Tooth" dari output sehingga hanya nama gigi yang ditampilkan,
- mengurutkan output sehingga semua kemunculan sebuah nama gigi saling berdampingan; dan
- menampilkan setiap nama gigi satu kali beserta hitungannya seberapa sering muncul.

Awal pipeline Anda sama seperti latihan sebelumnya:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Perluas dengan perintah `sort`, dan gunakan `uniq -c` untuk menampilkan baris unik beserta jumlah kemunculannya alih-alih menggunakan `uniq` dan `wc`.

`@hint`
Salin dan tempel perintah pada instruksi, pipe ke `sort` tanpa flag, lalu pipe lagi ke `uniq` dengan flag `-c`.

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
                     incorrect_msg="Anda harus memulai dari perintah ini: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Sekarang perpanjanglah!"),
            has_code('\|\s+sort', incorrect_msg="Apakah Anda telah memperpanjang perintah dengan `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="Apakah Anda telah memperpanjang perintah dengan `| uniq`?"),
            has_code('-c', incorrect_msg="Apakah Anda telah menyertakan hitungan dengan `-c`?")
        )
    )
)
Ex().success_msg("Bagus! Setelah semua pekerjaan ini pada pipe, akan menyenangkan jika kita bisa menyimpan hasilnya, bukan?")
```

---

## Bagaimana cara menyimpan keluaran dari sebuah pipe?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Shell memungkinkan kita mengalihkan keluaran dari rangkaian perintah yang dipipe:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Namun, `>` harus diletakkan di akhir pipeline:
jika kita mencoba menggunakannya di tengah, seperti ini:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

maka seluruh keluaran dari `cut` akan ditulis ke `teeth-only.txt`,
sehingga tidak ada yang tersisa untuk `grep`
dan `grep` akan menunggu masukan selamanya.

<hr>

Apa yang terjadi jika kita menaruh pengalihan di bagian depan pipeline seperti berikut:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [Keluaran perintah dialihkan ke berkas seperti biasa.]
- Shell melaporkannya sebagai sebuah kesalahan.
- Shell menunggu masukan selamanya.

`@hint`
Cobalah langsung di shell.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Benar!', 'Tidak; shell sebenarnya dapat mengeksekusi ini.', 'Tidak; shell sebenarnya dapat mengeksekusi ini.'])
```

---

## Bagaimana cara menghentikan program yang sedang berjalan?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Perintah dan skrip yang telah Anda jalankan sejauh ini dieksekusi dengan cepat,
amun beberapa tugas dapat memakan waktu menit, jam, atau bahkan hari untuk diselesaikan.
Anda juga bisa keliru menaruh pengalihan di tengah sebuah pipeline,
yang menyebabkan proses macet.
Jika Anda memutuskan tidak ingin program terus berjalan,
Anda dapat menekan `Ctrl` + `C` untuk mengakhiri proses tersebut.
Ini sering ditulis sebagai `^C` dalam dokumentasi Unix;
perhatikan bahwa huruf 'c' dapat menggunakan huruf kecil.

`@instructions`
Jalankan perintah:

```{shell}
head
```

tanpa argumen (sehingga menunggu masukan yang tidak akan pernah datang)
dan kemudian hentikan dengan menekan `Ctrl` + `C`.

`@hint`
Cukup ketik head, tekan Enter, lalu keluar dari program yang berjalan dengan `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Apakah Anda telah menggunakan `head`?")
```

---

## Menutup pembahasan

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Sebagai penutup,
Anda akan membangun sebuah pipeline untuk mengetahui berapa banyak rekaman yang ada dalam berkas data musiman yang paling sedikit isinya.

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
Gunakan `wc` dengan parameter yang sesuai untuk menampilkan jumlah baris di semua berkas data musiman.
(Gunakan wildcard untuk nama berkas alih-alih mengetikkannya satu per satu.)

`@hint`
Gunakan `-l` untuk hanya menampilkan jumlah baris dan `*` untuk mencocokkan nama berkas.

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
      has_code("wc", incorrect_msg = "Apakah Anda memanggil `wc`?"),
      has_code("-l", incorrect_msg = "Apakah Anda menghitung jumlah baris dengan `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Apakah Anda mendapatkan data dari semua file `seasonal/*`?")
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
Tambahkan perintah lain ke perintah sebelumnya menggunakan pipe untuk menghapus baris yang berisi kata "total".

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
      has_code("wc", incorrect_msg = "Apakah Anda memanggil `wc`?"),
      has_code("-l", incorrect_msg = "Apakah Anda menghitung jumlah baris dengan `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Apakah Anda mendapatkan data dari semua file `seasonal/*`?"),
      has_code("|", incorrect_msg = "Apakah Anda melakukan pipe dari `wc` ke `grep` menggunakan `|`?"),      
      has_code("grep", incorrect_msg = "Apakah Anda memanggil `grep`?"),
      has_code("-v", incorrect_msg = "Apakah Anda membalikkan pencocokan dengan `-v`?"),
      has_code("total", incorrect_msg = "Apakah Anda mencari `total`?")
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
Tambahkan dua tahap lagi ke pipeline yang menggunakan `sort -n` dan `head -n 1` untuk menemukan berkas yang berisi paling sedikit baris.

`@hint`
- Gunakan flag `-n` pada `sort` untuk mengurutkan secara numerik.
- Gunakan flag `-n` pada `head` untuk membatasi agar hanya menyisakan 1 baris.

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
      has_code("wc", incorrect_msg = "Apakah Anda memanggil `wc`?"),
      has_code("-l", incorrect_msg = "Apakah Anda menghitung jumlah baris dengan `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Apakah Anda mendapatkan data dari semua file `seasonal/*`?"),
      has_code("|", incorrect_msg = "Apakah Anda menggunakan `|` untuk mengalirkan dari `wc` ke `grep` ke `sort` ke `head`?"),      
      has_code("grep", incorrect_msg = "Apakah Anda memanggil `grep`?"),
      has_code("-v", incorrect_msg = "Apakah Anda membalikkan pencocokan dengan `-v`?"),
      has_code("total", incorrect_msg = "Apakah Anda mencari `total`?"),
      has_code("sort", incorrect_msg = "Apakah Anda memanggil `sort`?"),
      has_code("-n", incorrect_msg = "Apakah Anda menentukan jumlah baris yang akan disimpan dengan `-n`?"),
      has_code("1", incorrect_msg = "Apakah Anda menentukan 1 baris untuk disimpan dengan `-n 1`?")
    )
  )
)
Ex().success_msg("Bagus! Ternyata `autumn.csv` adalah file dengan jumlah baris paling sedikit. Segera lanjutkan ke bab 4 untuk mempelajari lebih lanjut tentang pemrosesan batch!")
```

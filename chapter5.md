---
title: Membuat alat baru
description: >-
  Riwayat memungkinkan Anda mengulangi sesuatu hanya dengan beberapa ketukan
  tombol, dan pipa memungkinkan Anda menggabungkan perintah yang ada untuk
  membuat yang baru. Dalam bab ini, Anda akan melihat bagaimana melangkah lebih
  jauh dan membuat perintah baru milik Anda sendiri.
lessons:
  - nb_of_exercises: 9
    title: Bagaimana cara mengedit sebuah berkas?
---

## Bagaimana cara saya mengedit sebuah file?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix memiliki beragam penyunting teks yang membingungkan.
Untuk kursus ini,
kita akan menggunakan penyunting sederhana bernama Nano.
Jika Anda mengetik `nano filename`,
itu akan membuka `filename` untuk diedit
(atau membuatnya jika belum ada).
Anda dapat berpindah menggunakan tombol panah,
menghapus karakter dengan tombol backspace,
dan melakukan operasi lain dengan kombinasi tombol kontrol:

- `Ctrl` + `K`: hapus satu baris.
- `Ctrl` + `U`: batalkan penghapusan baris.
- `Ctrl` + `O`: simpan file ('O' berarti 'output'). _Anda juga perlu menekan Enter untuk mengonfirmasi nama file!_
- `Ctrl` + `X`: keluar dari editor.

`@instructions`
Jalankan `nano names.txt` untuk mengedit file baru di direktori home Anda
dan masukkan empat baris berikut:

```
Lovelace
Hopper
Johnson
Wilson
```

Untuk menyimpan apa yang telah Anda tulis,
ketik `Ctrl` + `O` untuk menulis file,
kemudian Enter untuk mengonfirmasi nama file,
lalu `Ctrl` + `X` untuk keluar dari editor.

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
patt = "Apakah Anda sudah menyertakan baris `%s` dalam file `names.txt`? Gunakan `nano names.txt` lagi untuk memperbarui file Anda. Gunakan `Ctrl` + `O` untuk menyimpan dan `Ctrl` + `X` untuk keluar."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Kerja bagus! Lanjut ke yang berikutnya!")
```

---

## Bagaimana cara merekam apa yang baru saja saya lakukan?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Saat Anda melakukan analisis yang kompleks,
sering kali Anda ingin menyimpan catatan perintah yang digunakan.
Anda dapat melakukannya dengan alat yang sudah Anda lihat:

1. Jalankan `history`.
2. Pipa keluarannya ke `tail -n 10` (atau sebanyak langkah terbaru yang ingin Anda simpan).
3. Arahkan ulang hasilnya ke sebuah berkas bernama seperti `figure-5.history`.

Ini lebih baik daripada menuliskannya di buku catatan laboratorium
karena dijamin tidak melewatkan langkah apa pun.
Ini juga menggambarkan gagasan utama shell:
alat-alat sederhana yang menghasilkan dan mengonsumsi baris-baris teks
bisa dikombinasikan dalam berbagai cara
to solve a broad range of problems.

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
Salin berkas `seasonal/spring.csv` dan `seasonal/summer.csv` ke direktori home Anda.

`@hint`
Gunakan `cp` untuk menyalin dan `~` sebagai pintasan ke path direktori home Anda.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Apakah Anda telah menggunakan `cp seasonal/s* ~` untuk menyalin file yang diperlukan ke direktori home Anda?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Pencatatan yang luar biasa! Jika Anda salah mengetik perintah apa pun, Anda selalu dapat menggunakan `nano` untuk membersihkan file riwayat simpanan setelahnya.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Gunakan `grep` dengan flag `-h` (agar tidak mencetak nama berkas)
dan `-v Tooth` (untuk memilih baris yang tidak cocok dengan baris header)
untuk memilih rekaman data dari `spring.csv` dan `summer.csv` dalam urutan tersebut
dan arahkan ulang keluarannya ke `temp.csv`.

`@hint`
Letakkan flag sebelum nama berkas.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Pastikan Anda mengarahkan keluaran dari perintah `grep` ke `temp.csv` dengan `>`!"
msg2 = "Apakah Anda telah menggunakan `grep -h -v ___ ___ ___` (isi bagian yang kosong) untuk mengisi `temp.csv`?"
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
Pipakan `history` ke `tail -n 3`
dan arahkan ulang keluarannya ke `steps.txt`
untuk menyimpan tiga perintah terakhir ke sebuah berkas.
(Anda perlu menyimpan tiga, bukan hanya dua,
karena perintah `history` itu sendiri akan ada dalam daftar.)

`@hint`
Ingat bahwa pengalihan dengan `>` diletakkan di akhir rangkaian perintah yang dipipa.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Pastikan untuk mengarahkan keluaran perintah Anda ke `steps.txt`."
msg2="Apakah Anda telah menggunakan `history | tail ___ ___` (isi bagian yang kosong) untuk mengisi `steps.txt`?"
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
Ex().success_msg("Kerja bagus! Mari kita tingkatkan!")
```

---

## Bagaimana cara menyimpan perintah untuk dijalankan kembali nanti?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Sejauh ini Anda menggunakan shell secara interaktif.
Namun karena perintah yang Anda ketik hanyalah teks,
Anda dapat menyimpannya dalam berkas agar shell menjalankannya berulang kali.
Untuk mulai mengeksplorasi kemampuan yang kuat ini,
letakkan perintah berikut dalam sebuah berkas bernama `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Perintah ini memilih baris pertama dari setiap berkas CSV di direktori `seasonal`.
Setelah Anda membuat berkas ini,
Anda dapat menjalankannya dengan mengetik:

```{shell}
bash headers.sh
```

Ini memberi tahu shell (yang hanyalah program bernama `bash`)
untuk menjalankan perintah di dalam berkas `headers.sh`,
yang menghasilkan keluaran yang sama seperti menjalankan perintahnya secara langsung.

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
Gunakan `nano dates.sh` untuk membuat berkas bernama `dates.sh`
yang berisi perintah berikut:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

untuk mengekstrak kolom pertama dari semua berkas CSV di `seasonal`.

`@hint`
Masukkan perintah yang ditampilkan ke dalam berkas tanpa baris kosong atau spasi tambahan.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Apakah Anda sudah menyertakan baris `cut -d , -f 1 seasonal/*.csv` dalam file `dates.sh`? Gunakan `nano dates.sh` lagi untuk memperbarui file Anda. Gunakan `Ctrl` + `O` untuk menyimpan dan `Ctrl` + `X` untuk keluar."
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
Gunakan `bash` untuk menjalankan berkas `dates.sh`.

`@hint`
Gunakan `bash filename` untuk menjalankan berkas.

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
      has_code("bash", incorrect_msg = 'Apakah Anda memanggil `bash`?'),
      has_code("dates.sh", incorrect_msg = 'Apakah Anda menentukan file `dates.sh`?')
    )
  )
)
```

---

## Bagaimana saya dapat memakai ulang pipa?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Berkas yang berisi banyak perintah shell disebut ***skrip shell**,
atau sering disingkat "skrip". Skrip tidak harus diberi nama berakhiran `.sh`,
amun pelajaran ini akan menggunakan konvensi tersebut
untuk membantu Anda membedakan berkas mana yang merupakan skrip.

Skrip juga dapat berisi pipa.
Sebagai contoh,
jika `all-dates.sh` berisi baris berikut:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

maka:

```{shell}
bash all-dates.sh > dates.out
```

akan mengekstrak tanggal unik dari berkas data musiman
dan menyimpannya ke `dates.out`.

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
Berkas `teeth.sh` di direktori home Anda telah disiapkan, tetapi masih ada beberapa bagian kosong.
Gunakan Nano untuk mengedit berkas tersebut dan ganti dua placeholder `____`
dengan `seasonal/*.csv` dan `-c` agar skrip ini mencetak hitungan
berapa kali setiap nama gigi muncul dalam berkas CSV di direktori `seasonal`.

`@hint`
Gunakan `nano teeth.sh` untuk mengedit berkasnya.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Apakah Anda telah mengganti bagian yang kosong dengan benar sehingga perintah di `teeth.sh` terbaca `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Gunakan `nano teeth.sh` lagi untuk membuat perubahan yang diperlukan."
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
Gunakan `bash` untuk menjalankan `teeth.sh` dan `>` untuk mengalihkan keluarannya ke `teeth.out`.

`@hint`
Ingat bahwa `> teeth.out` harus diletakkan *setelah* perintah yang menghasilkan keluaran.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Apakah Anda telah mengarahkan hasil dari `bash teeth.sh` ke `teeth.out` dengan `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Apakah Anda memanggil `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Apakah Anda menjalankan file `teeth.sh`?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Apakah Anda mengarahkan ke file `teeth.out`?')
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
Jalankan `cat teeth.out` untuk memeriksa hasil Anda.

`@hint`
Ingat, Anda dapat mengetik beberapa karakter pertama nama berkas lalu tekan tombol tab untuk melengkapi otomatis.

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
      has_code("cat", incorrect_msg = 'Apakah Anda memanggil `cat`?'),
      has_code("teeth.out", incorrect_msg = 'Apakah Anda menentukan file `teeth.out`?')
    )
  )
)
Ex().success_msg("Bagus! Semua ini mungkin terasa dibuat-buat pada awalnya, tetapi hal yang baik adalah Anda mengotomatisasi bagian dari alur kerja Anda langkah demi langkah. Sesuatu yang sangat berguna sebagai seorang ilmuwan data!")
```

---

## Bagaimana cara saya meneruskan nama berkas ke skrip?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Skrip yang memproses berkas tertentu berguna sebagai catatan atas apa yang Anda lakukan, tetapi skrip yang memungkinkan Anda memproses berkas apa pun yang Anda inginkan lebih berguna.
Untuk mendukung hal ini,
Anda dapat menggunakan ekspresi khusus `$@` (tanda dolar yang diikuti langsung oleh tanda at)
untuk berarti "semua parameter baris perintah yang diberikan ke skrip".

Sebagai contoh, jika `unique-lines.sh` berisi `sort $@ | uniq`, saat Anda menjalankan:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

shell akan mengganti `$@` dengan `seasonal/summer.csv` dan memproses satu berkas. Jika Anda menjalankan ini:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

skrip akan memproses dua berkas data, dan seterusnya.

_Sebagai pengingat, untuk menyimpan yang telah Anda tulis di Nano, ketik `Ctrl` + `O` untuk menuliskan berkas, lalu Enter untuk mengonfirmasi nama berkas, kemudian `Ctrl` + `X` untuk keluar dari editor._

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
Edit skrip `count-records.sh` dengan Nano dan isi dua placeholder `____`
dengan `$@` dan `-l` (huruf) masing-masing sehingga skrip menghitung jumlah baris dalam satu atau lebih berkas,
mengecualikan baris pertama dari setiap berkas.

`@hint`
* Gunakan `nano count-records.sh` untuk mengedit nama berkas.
* Pastikan Anda menentukan huruf `-l`, bukan angka satu.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Apakah Anda telah mengganti bagian yang kosong dengan benar sehingga perintah dalam `count-records.sh` terbaca `tail -q -n +2 $@ | wc -l`? Gunakan `nano count-records.sh` lagi untuk membuat perubahan yang diperlukan."
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
Jalankan `count-records.sh` pada `seasonal/*.csv`
dan alihkan keluarannya ke `num-records.out` menggunakan `>`.

`@hint`
Gunakan `>` untuk mengalihkan keluaran.

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
      has_code("bash", incorrect_msg = 'Apakah Anda memanggil `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Apakah Anda menjalankan file `count-records.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Apakah Anda menentukan file yang akan diproses dengan `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Apakah Anda mengarahkan ke file `num-records.out`?')
    )
  )
)
Ex().success_msg("Pekerjaan yang sangat baik! Kekuatan shell Anda semakin berkembang!")
```

---

## Bagaimana cara memroses satu argumen?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Selain `$@`,
shell memungkinkan Anda menggunakan `$1`, `$2`, dan seterusnya untuk merujuk ke parameter baris perintah tertentu.
Anda dapat menggunakannya untuk menulis perintah yang terasa lebih sederhana atau lebih natural daripada milik shell.
Sebagai contoh,
Anda dapat membuat skrip bernama `column.sh` yang memilih satu kolom dari berkas CSV
ketika pengguna memberikan nama berkas sebagai parameter pertama dan kolom sebagai parameter kedua:

```{shell}
cut -d , -f $2 $1
```

lalu menjalankannya dengan:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Perhatikan bagaimana skrip menggunakan kedua parameter tersebut dalam urutan terbalik.

<hr>

Skrip `get-field.sh` seharusnya menerima sebuah nama berkas,
nomor baris yang akan dipilih,
nomor kolom yang akan dipilih,
dan mencetak hanya kolom tersebut dari berkas CSV.
Sebagai contoh:

```
bash get-field.sh seasonal/summer.csv 4 2
```

seharusnya memilih kolom kedua dari baris ke-4 pada `seasonal/summer.csv`.
Perintah manakah berikut yang harus dimasukkan ke dalam `get-field.sh` untuk melakukan hal tersebut?

`@hint`
Ingat bahwa parameter baris perintah diberi nomor dari kiri ke kanan.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Tidak: itu akan mencoba menggunakan nama berkas sebagai jumlah baris yang dipilih dengan `head`.
- Benar!
- Tidak: itu akan mencoba menggunakan nomor kolom sebagai nomor baris dan sebaliknya.
- Tidak: itu akan menggunakan nomor kolom sebagai nama berkas dan sebaliknya.

---

## Bagaimana satu skrip shell dapat melakukan banyak hal?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Sejauh ini skrip shell kita hanya memiliki satu perintah atau pipa, tetapi sebuah skrip dapat berisi banyak baris perintah. Misalnya, Anda dapat membuat skrip yang memberi tahu berapa banyak record dalam berkas data terpendek dan terpanjang, yaitu rentang panjang himpunan data Anda.

Perhatikan bahwa di Nano, "copy and paste" dilakukan dengan menavigasi ke baris yang ingin Anda salin, menekan `CTRL` + `K` untuk memotong baris tersebut, lalu `CTRL` + `U` dua kali untuk menempelkan dua salinan.

_Sebagai pengingat, untuk menyimpan yang Anda tulis di Nano, ketik `Ctrl` + `O` untuk menuliskan berkas, lalu Enter untuk mengonfirmasi nama berkas, kemudian `Ctrl` + `X` untuk keluar dari editor._

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
Gunakan Nano untuk mengedit skrip `range.sh`
dan ganti dua placeholder `____`
dengan `$@` dan `-v`
agar skrip tersebut menampilkan nama dan jumlah baris di semua berkas yang diberikan pada baris perintah
dan *tanpa* menampilkan total jumlah baris di semua berkas.
(Jangan mencoba mengurangkan baris header kolom dari berkas.)

`@hint`
Gunakan `wc -l $@` untuk menghitung baris di semua berkas yang diberikan pada baris perintah.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Apakah Anda telah mengganti bagian yang kosong dengan benar sehingga perintah dalam `range.sh` terbaca `wc -l $@ | grep -v total`? Gunakan `nano range.sh` lagi untuk membuat perubahan yang diperlukan."
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
Gunakan Nano lagi untuk menambahkan `sort -n` dan `head -n 1` secara berurutan
ke pipeline di `range.sh`
untuk menampilkan nama dan jumlah baris dari berkas terpendek yang diberikan kepadanya.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Apakah Anda telah menambahkan `sort -n` dan `head -n 1` dengan pipes ke file `range.sh`? Gunakan `nano range.sh` lagi untuk membuat perubahan yang diperlukan."
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
Masih menggunakan Nano, tambahkan baris kedua ke `range.sh` untuk mencetak nama dan jumlah record dari
berkas *terpanjang* di direktori *serta* yang terpendek.
Baris ini harus merupakan duplikat dari yang sudah Anda tulis,
namun dengan `sort -n -r` alih-alih `sort -n`.

`@hint`
Salin baris pertama dan ubah urutan pengurutan.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Pertahankan baris pertama dalam file `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Apakah Anda telah menduplikasi baris pertama di `range.sh` dan membuat sedikit perubahan? `sort -n -r` alih-alih `sort -n`!"
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
Jalankan skrip pada berkas-berkas di direktori `seasonal`
dengan menggunakan `seasonal/*.csv` untuk mencocokkan semua berkas
dan alihkan keluarannya menggunakan `>`
ke sebuah berkas bernama `range.out` di direktori home Anda.

`@hint`
Gunakan `bash range.sh` untuk menjalankan skrip Anda, `seasonal/*.csv` untuk menentukan berkas, dan `> range.out` untuk mengalihkan keluarannya.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Apakah Anda telah mengarahkan hasil dari `bash range.sh seasonal/*.csv` ke `range.out` dengan `>` dengan benar?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Apakah Anda memanggil `bash`?'),
has_code("bash\s+range.sh", incorrect_msg = 'Apakah Anda menjalankan file `range.sh`?'),
has_code("seasonal/\*", incorrect_msg = 'Apakah Anda menentukan file yang akan diproses dengan `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = 'Apakah Anda mengarahkan ke file `range.out`?')
)
)

Ex().success_msg("Ini berjalan dengan baik. Lanjutkan ke latihan berikutnya untuk belajar tentang menulis loop!")
```

---

## Bagaimana cara menulis loop dalam skrip shell?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Skrip shell juga dapat berisi loop. Anda dapat menulisnya menggunakan titik koma, atau memecahnya ke beberapa baris tanpa titik koma agar lebih mudah dibaca:

```{shell}
# Cetak rekaman data pertama dan terakhir dari setiap berkas.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Anda tidak harus membuat inden untuk perintah di dalam loop, tetapi melakukannya akan membuatnya lebih jelas.)

Baris pertama skrip ini adalah **komentar** untuk memberi tahu pembaca apa yang dilakukan skrip. Komentar diawali dengan karakter `#` dan berlangsung hingga akhir baris. Diri Anda di masa depan akan berterima kasih karena Anda menambahkan penjelasan singkat seperti ini pada setiap skrip yang Anda tulis.

_Sebagai pengingat, untuk menyimpan yang telah Anda tulis di Nano, tekan `Ctrl` + `O` untuk menulis berkas, lalu Enter untuk mengonfirmasi nama berkas, kemudian `Ctrl` + `X` untuk keluar dari editor._

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
Lengkapi placeholder dalam skrip `date-range.sh`
dengan `$filename` (dua kali), `head`, dan `tail`
agar mencetak tanggal pertama dan terakhir dari satu atau beberapa berkas.

`@hint`
Ingat untuk menggunakan `$filename` untuk mengambil nilai saat ini dari variabel loop.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="Di `date-range.sh`, apakah Anda telah mengubah baris %s dalam loop menjadi `%s`? Gunakan `nano date-range.sh` untuk membuat perubahan."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('pertama', cmdpatt%'head')
msg2=msgpatt%('kedua', cmdpatt%'tail')
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
Jalankan `date-range.sh` pada keempat berkas data musiman
menggunakan `seasonal/*.csv` untuk mencocokkan nama mereka.

`@hint`
Ekspresi wildcard harus diawali dengan nama direktori.

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
      has_code("bash", incorrect_msg = 'Apakah Anda memanggil `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Apakah Anda menjalankan file `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Apakah Anda menentukan file yang akan diproses dengan `seasonal/*`?')
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
Jalankan `date-range.sh` pada keempat berkas data musiman menggunakan `seasonal/*.csv` untuk mencocokkan nama mereka,
dan teruskan keluarannya ke `sort` untuk melihat bahwa skrip Anda dapat digunakan seperti perintah bawaan Unix.

`@hint`
Gunakan ekspresi wildcard yang sama seperti sebelumnya.

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
      has_code("bash", incorrect_msg = 'Apakah Anda memanggil `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Apakah Anda menjalankan file `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Apakah Anda menentukan file yang akan diproses dengan `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Apakah Anda mengalirkan keluaran skrip ke `sort`?'),
      has_code("sort", incorrect_msg = 'Apakah Anda memanggil `sort`?')
    )
  )
)
Ex().success_msg("Ajaib! Perhatikan betapa dapat digabungkannya semua hal yang telah kita pelajari.")
```

---

## Apa yang terjadi jika saya tidak memberikan nama berkas?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Kesalahan umum dalam skrip shell (dan perintah interaktif) adalah menempatkan nama berkas di tempat yang salah.
Jika Anda mengetik:

```{shell}
tail -n 3
```

maka karena `tail` tidak diberi nama berkas apa pun,
program akan menunggu masukan dari keyboard Anda.
Ini berarti jika Anda mengetik:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

maka `tail` akan langsung mencetak tiga baris terakhir dari `somefile.txt`,
tetapi `head` akan menunggu selamanya untuk masukan dari keyboard,
karena tidak diberi nama berkas dan tidak ada apa pun di depannya dalam pipeline.

<hr>

Misalkan Anda tidak sengaja mengetik:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Apa yang sebaiknya Anda lakukan selanjutnya?

`@possible_answers`
- Tunggu 10 detik hingga `head` kehabisan waktu (time out).
- Ketik `somefile.txt` lalu tekan Enter untuk memberi masukan ke `head`.
- Gunakan `Ctrl` + `C` untuk menghentikan program `head` yang sedang berjalan.

`@hint`
Apa yang dilakukan `head` jika tidak memiliki nama berkas dan tidak ada apa pun di hulu (upstream) darinya?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Tidak, perintah tidak akan kedaluwarsa.'
a2 = 'Tidak, itu akan memberikan teks `somefile.txt` ke `head` untuk diproses, tetapi kemudian akan berhenti menunggu masukan lebih lanjut.'
a3 = "Ya! Anda harus menggunakan `Ctrl` + `C` untuk menghentikan program yang sedang berjalan. Ini mengakhiri kursus pengantar ini! Jika Anda tertarik untuk mempelajari lebih banyak alat baris perintah, kami sangat merekomendasikan mengikuti kursus pengantar Git gratis kami!"
Ex().has_chosen(3, [a1, a2, a3])
```

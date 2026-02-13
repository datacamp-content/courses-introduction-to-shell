---
title: Toplu işleme
description: >-
  Çoğu kabuk komutu bir kerede birçok dosyayı işler. Bu bölüm, kendi boru
  hatlarının bunu nasıl yapacağını gösterir. Bu sırada, kabuğun bilgiyi saklamak
  için değişkenleri nasıl kullandığını da göreceksin.
lessons:
  - nb_of_exercises: 10
    title: Kabuk bilgiyi nasıl saklar?
---

## Kabuk bilgiyi nasıl saklar?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Diğer programlar gibi kabuk da bilgiyi değişkenlerde saklar.
Bunlardan bazıları,
**ortam değişkenleri** olarak adlandırılır,
ve her zaman kullanılabilir.
Ortam değişkenlerinin adları geleneksel olarak büyük harfle yazılır
ve en yaygın kullanılanlardan birkaçı aşağıda gösterilmiştir.

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | Kullanıcının ana dizini           | `/home/repl`          |
| `PWD `   | Geçerli çalışma dizini            | `pwd` komutuyla aynı  |
| `SHELL`  | Hangi kabuk programının kullanıldığı | `/bin/bash`        |
| `USER`   | Kullanıcının kimliği              | `repl`                |

Tam listeyi (oldukça uzundur) almak için
kabukta `set` yazabilirsin.

<hr>

`HISTFILESIZE` değerini göstermek için `set` ve `grep`i bir boru ile birlikte kullan;
bu değer komut geçmişinde kaç eski komutun saklanacağını belirler.
Değeri nedir?

`@possible_answers`
- 10
- 500
- [2000]
- Değişken orada yok.

`@hint`
İhtiyacın olan satırı almak için `set | grep HISTFILESIZE` komutunu kullan.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Hayır: kabuk bundan daha fazla geçmiş kaydeder."
err2 = "Hayır: kabuk bundan daha fazla geçmiş kaydeder."
correct3 = "Doğru: kabuk bu sistemde varsayılan olarak 2000 eski komutu kaydeder."
err4 = "Hayır: `HISTFILESIZE` değişkeni orada."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Bir değişkenin değerini nasıl yazdırırım?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Bir değişkenin değerini bulmanın daha basit bir yolu, argümanlarını yazdıran `echo` komutunu kullanmaktır. Şunu yazdığında

```{shell}
echo hello DataCamp!
```

şu çıktıyı alırsın:

```
hello DataCamp!
```

Eğer bir değişkenin değerini şöyle yazdırmaya çalışırsan:

```{shell}
echo USER
```

bu, değişkenin adını, yani `USER`'ı yazdırır.

Değişkenin değerini almak için başına dolar işareti `$` koymalısın. Şunu yazdığında 

```{shell}
echo $USER
```

şunu yazdırır:

```
repl
```

Bu her yerde geçerlidir:
`X` adlı bir değişkenin değerini almak istiyorsan,
`$X` yazmalısın.
(Bu sayede kabuk, "adı X olan bir dosya" mı
yoksa "adı X olan bir değişkenin değeri" mi demek istediğini ayırt edebilir.)

`@instructions`
`OSTYPE` değişkeni, kullandığın işletim sistemi türünün adını tutar.
Değerini `echo` kullanarak göster.

`@hint`
`OSTYPE` değişkeninin önüne `$` ekleyerek `echo` ile çağır.

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
            has_code('echo', incorrect_msg="`echo` komutunu çağırdınız mı?"),
            has_code('OSTYPE', incorrect_msg="`OSTYPE` ortam değişkenini yazdırdınız mı?"),
            has_code(r'\$OSTYPE', incorrect_msg="`OSTYPE`'in önüne bir `$` eklediğinizden emin olun.")
        )
    )
)
Ex().success_msg("Ortam değişkenlerini mükemmel bir şekilde yankıladınız! İyi bir başlangıç yaptınız. Devam edelim!")
```

---

## Kabuk bilgiyi başka nasıl saklar?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Diğer değişken türüne **kabuk değişkeni** denir,
bu da programlama dillerindeki yerel değişkenlere benzer.

Bir kabuk değişkeni oluşturmak için
bir ada bir değer ataman yeter:

```{shell}
training=seasonal/summer.csv
```

`=` işaretinin önünde veya arkasında boşluk olmadan.
Bunu yaptıktan sonra,
değişkenin değerini şununla kontrol edebilirsin:

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
`testing` adında, değeri `seasonal/winter.csv` olan bir değişken tanımla.

`@hint`
Değişkenin adıyla değeri arasında boşluk olmamalı.

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
        has_code('testing', incorrect_msg='`testing` adında bir kabuk değişkeni tanımladınız mı?'),
        has_code('testing=', incorrect_msg='Boşluk bırakmadan `testing`\'den hemen sonra `=` yazdınız mı?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='`testing`\'in değerini `seasonal/winter.csv` olarak ayarladınız mı?')
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
`head -n 1 BIRSEY` komutunu kullanarak, dosya adının yerine `testing` değişkeninin değerini kullanıp `seasonal/winter.csv` dosyasının ilk satırını al.

`@hint`
Sadece `testing` yerine `$testing` kullanmayı unutma
(değişkenin değerini almak için `$` gerekir).

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
    has_code(r'\$testing', incorrect_msg="Kabuk değişkenine `$testing` kullanarak başvurdunuz mu?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="`head` fonksiyonunu çağırdınız mı?"),
            has_code('-n', incorrect_msg="Satır sayısını `-n` ile sınırladınız mı?"),
            has_code(r'-n\s+1', incorrect_msg="`-n 1` ile 1 satır tutmayı seçtiniz mi?")     
        )
    )
)
Ex().success_msg("Harika! Komutları nasıl kolayca tekrarlayabileceğinizi görelim.")
```

---

## Bir komutu birçok kez nasıl tekrarlarım?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Shell değişkenleri, komutları birçok kez tekrarlayan **döngülerde** de kullanılır.
Bu komutu çalıştırırsak:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

şunu üretir:

```
gif
jpg
png
```

Döngüyle ilgili şunlara dikkat et:

1. Yapı `for` ...değişken... `in` ...liste... `; do` ...gövde... `; done` şeklindedir.
2. Döngünün işleyeceği şeylerin listesi (bu örnekte `gif`, `jpg` ve `png` sözcükleri).
3. Döngünün şu anda hangisini işlediğini takip eden değişken (bu örnekte `filetype`).
4. İşlemi yapan döngü gövdesi (bu örnekte `echo $filetype`).

Gövdenin, tıpkı diğer shell değişkenlerinde olduğu gibi, değişkenin değerini almak için sadece `filetype` yerine `$filetype` kullandığına dikkat et.
Ayrıca noktalı virgüllerin yerlerine de dikkat et:
ilki listenin ve `do` anahtar kelimesinin arasına gelir,
ikincisi ise gövdenin ve `done` anahtar kelimesinin arasına gelir.

`@instructions`
Döngüyü, şunları yazdıracak şekilde değiştir:

```
docx
odt
pdf
```

Lütfen döngü değişkeninin adı olarak `filetype` kullan.

`@hint`
Giriş metnindeki kod yapısını kullan, resim dosya türleri yerine belge dosya türlerini koy.

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
      has_code('for', incorrect_msg='`for` ifadesini çağırdınız mı?'),
      has_code('filetype', incorrect_msg='Döngü değişkeni olarak `filetype` kullandınız mı?'),
      has_code('in', incorrect_msg='Dosya türleri listesinden önce `in` kullandınız mı?'),
      has_code('docx odt pdf', incorrect_msg='`docx`, `odt` ve `pdf` üzerinde bu sırayla döngü yaptınız mı?'),
      has_code(r'pdf\s*;', incorrect_msg='Son döngü elemanından sonra noktalı virgül koydunuz mu?'),
      has_code(r';\s*do', incorrect_msg='İlk noktalı virgülden sonra `do` kullandınız mı?'),
      has_code('echo', incorrect_msg='`echo` ifadesini çağırdınız mı?'),
      has_code(r'\$filetype', incorrect_msg='`$filetype` ifadesini echo ile yazdırdınız mı?'),
      has_code(r'filetype\s*;', incorrect_msg='Döngü gövdesinden sonra noktalı virgül koydunuz mu?'),
      has_code('; done', incorrect_msg='`done` ifadesi ile bitirdiniz mi?')
    )
  )
)
Ex().success_msg("Döngü kullanımı mükemmel! Döngüler, aynı işlemi yüzlerce veya binlerce kez yapmak istediğinizde harikadır.")
```

---

## Bir komutu her dosya için bir kez nasıl tekrarlarım?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Döngüyü yazarken işlemek istediğin dosyaların adlarını elle yazabilirsin,
ancak genellikle joker karakterler kullanmak daha iyidir.
Konsolda bu döngüyü çalıştırmayı dene:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Şunu yazdırır:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

çünkü kabuk, döngüyü çalıştırmadan önce `seasonal/*.csv` ifadesini dört dosya adının listesine genişletir.

`@instructions`
Joker karakter ifadesini `people/*` olarak değiştir,
böylece döngü, sonekleri olsun ya da olmasın `people` dizinindeki dosyaların adlarını yazdırsın.
Lütfen döngü değişkeni adı olarak `filename` kullan.

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
      has_code('for', incorrect_msg='`for` ifadesini çağırdınız mı?'),
      has_code('filename', incorrect_msg='Döngü değişkeni olarak `filename` kullandınız mı?'),
      has_code('in', incorrect_msg='Dosya türleri listesinden önce `in` kullandınız mı?'),
      has_code('people/\*', incorrect_msg='`people/*` ile bir dosya listesi belirttiniz mi?'),
      has_code(r'people/\*\s*;', incorrect_msg='Dosya listesinden sonra noktalı virgül koydunuz mu?'),
      has_code(r';\s*do', incorrect_msg='İlk noktalı virgülden sonra `do` kullandınız mı?'),
      has_code('echo', incorrect_msg='`echo` ifadesini çağırdınız mı?'),
      has_code(r'\$filename', incorrect_msg='`$filename` ifadesini echo ile yazdırdınız mı?'),
      has_code(r'filename\s*;', incorrect_msg='Döngü gövdesinden sonra noktalı virgül koydunuz mu?'),
      has_code('; done', incorrect_msg='`done` ifadesi ile bitirdiniz mi?')
    )
  )
)
Ex().success_msg("Döngüsel döngü! Joker karakterler ve döngüler güçlü bir kombinasyon oluşturur.")
```

---

## Bir grup dosyanın adlarını nasıl kaydedebilirim?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

İnsanlar genellikle bir dosya adı listesini saklamak için joker karakter içeren bir ifadeyle bir değişken ayarlar.
Örneğin,
`datasets` değişkenini şöyle tanımlarsan:

```{shell}
datasets=seasonal/*.csv
```

sonrasında dosyaların adlarını şu şekilde görüntüleyebilirsin:

```{shell}
for filename in $datasets; do echo $filename; done
```

Bu, yazmayı azaltır ve hataları daha az olası hale getirir.

<hr>

Bu iki komutu ana dizininde çalıştırırsan,
kaç satır çıktı üretirler?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Hiçbiri: `files` ayrı bir satırda tanımlandığı için ikinci satırda bir değeri yoktur.
- Bir: "files" kelimesi.
- Dört: dört mevsimsel veri dosyasının adları.

`@hint`
Unutma: tek başına `X` sadece "X"'tir, `$X` ise `X` değişkeninin değeridir.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Hayır: bir değişkeni kullandığınız satırda tanımlamanız gerekmez."
err2 = "Hayır: bu örnek `files` değişkenini aynı kabukta tanımlar ve kullanır."
correct3 = "Doğru. Komut `for f in seasonal/*.csv; do echo $f; done` ile eşdeğerdir."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Bir değişkenin adı ve değeri

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Yaygın bir hata, bir değişken adından önce `$` koymayı unutmak.
Bunu yaptığında,
shell yazdığın adı kullanır,
uygun değişkenin değeri yerine.

Deneyimli kullanıcıların daha sık yaptığı bir hata ise değişken adını yanlış yazmaktır.
Örneğin,
`datasets` değişkenini şöyle tanımlarsan:

```{shell}
datasets=seasonal/*.csv
```

ve sonra şunu yazarsan:

```{shell}
echo $datsets
```

shell hiçbir şey yazdırmaz,
çünkü `datsets` (ikinci "a" olmadan) tanımlı değildir.

<hr>

Ev dizininde bu iki komutu çalıştırırsan,
hangi çıktı yazdırılır?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Yanıtlamadan önce döngünün ilk kısmını dikkatle oku.)

`@hint`
Unutma: tek başına `X` sadece "X" demektir, `$X` ise `X` değişkeninin değeridir.

`@possible_answers`
- [Tek satır: "files" sözcüğü.]
- Dört satır: dört mevsimsel veri dosyasının adları.
- Dört boş satır: `f` değişkenine bir değer atanmaz.

`@feedback`
- Doğru: döngü `$files` yerine `files` kullanıyor, bu yüzden listedeki öğe "files" sözcüğünün kendisi.
- Hayır: döngü `$files` yerine `files` kullanıyor, bu yüzden liste `files` değişkeninin açılımı yerine "files" sözcüğünden oluşuyor.
- Hayır: `f` değişkeni `for` döngüsü tarafından otomatik olarak tanımlanır.

---

## Tek bir döngüde birçok komutu nasıl çalıştırabilirim?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Dosya adlarını yazdırmak hata ayıklamak için yararlıdır,
amma velakin döngülerin asıl amacı birden çok dosyayla işlem yapmaktır.
Bu döngü, her veri dosyasının ikinci satırını yazdırır:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Daha önce gördüğün diğer döngülerle aynı yapıya sahiptir:
tek fark, gövdesinin tek bir komut yerine iki komuttan oluşan bir boru hattı (pipeline) olmasıdır.

`@instructions`
Her mevsimlik dosyada Temmuz 2017'den (`2017-07`) son girdiyi yazdıran bir döngü yaz. Şuna benzer bir çıktı üretmeli:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

ancak bunu mevsimlik dosyaların **her biri** için ayrı ayrı yapmalı. Lütfen döngü değişkeninin adı olarak `file` kullan ve örnekteki 'seasonal/winter.csv' yerine dosya listesi `seasonal/*.csv` üzerinde döngü kurmayı unutma.

`@hint`
Döngü gövdesi, talimatlarda gösterilen grep komutudur; sadece `seasonal/winter.csv` yerine `$file` kullanılır.

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
  has_code('for', incorrect_msg='`for` ifadesini çağırdınız mı?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Döngü değişkeni olarak `file` kullandınız mı?'),
      has_code('in', incorrect_msg='Dosya listesinden önce `in` kullandınız mı?'),
      has_code('seasonal/\*', incorrect_msg='`seasonal/*` ile bir dosya listesi belirttiniz mi?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Dosya listesinden sonra noktalı virgül koydunuz mu?'),
      has_code(r';\s*do', incorrect_msg='İlk noktalı virgülden sonra `do` kullandınız mı?'),
      has_code('grep', incorrect_msg='`grep` ifadesini çağırdınız mı?'),
      has_code('2017-07', incorrect_msg='`2017-07` ifadesini eşleştirdiniz mi?'),
      has_code(r'\$file', incorrect_msg='Döngü değişkeni adı olarak `$file` kullandınız mı?'),
      has_code(r'file\s*|', incorrect_msg='İkinci komutunuzu bağlamak için bir pipe kullandınız mı?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Her aramanın son girişini yazdırmak için `tail -n 1` kullandınız mı?'),
      has_code('; done', incorrect_msg='`done` ile bitirdiniz mi?')
    )
  )
)

Ex().success_msg("Döngüsel döngü! Joker karakterler ve döngüler güçlü bir kombinasyon oluşturur.")
```

---

## Dosya adlarında neden boşluk kullanmamalıyım?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Grafiksel bir dosya gezgini kullanırken dosyalara `July 2017.csv` gibi çok kelimeli adlar vermek kolay ve mantıklıdır.
Ancak bu, kabukta çalışırken sorun çıkarır.
Örneğin,
`July 2017.csv` dosyasını `2017 July data.csv` olarak yeniden adlandırmak istediğini varsayalım.
Şunu yazamazsın:

```{shell}
mv July 2017.csv 2017 July data.csv
```

çünkü bu, kabuğa sanki `July`, `2017.csv`, `2017` ve (yine) `July` adında
dört dosyayı `data.csv` adlı bir dizine taşımaya çalışıyormuşsun gibi görünür.
Bunun yerine,
dosya adlarını tırnak içine alman gerekir
ki kabuk her birini tek bir parametre olarak işlesin:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

`current.csv` ve adında boşluk olan `last year.csv` adlı iki dosyan varsa
ve şunu yazarsan:

```{shell}
rm current.csv last year.csv
```

ne olur:

`@hint`
Biri sana bu komutu gösterse ve hangi dosyaların var olduğunu bilmesen, ne olacağını düşünürdün?

`@possible_answers`
- Kabuk, `last` ve `year.csv` mevcut olmadığı için bir hata iletisi yazdırır.
- Kabuk `current.csv` dosyasını siler.
- [Yukarıdakilerin ikisi de.]
- Hiçbir şey.

`@feedback`
- Evet, ama hepsi bu değil.
- Evet, ama hepsi bu değil.
- Doğru. Dosya adlarının etrafına tek tırnak, `'`, ya da çift tırnak, `"`, koyabilirsin.
- Maalesef hayır.

---

## Tek bir döngüde nasıl birçok şey yapabilirim?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Şu ana kadar gördüğün döngülerin gövdesinde tek bir komut ya da tek bir ardışık düzen (pipeline) vardı,
amma velakin bir döngü istediğin kadar komut içerebilir.
Kabukta bir komutun nerede bittiğini ve sonrakinin nerede başladığını belirtmek için
bunları noktalı virgülle ayırmalısın:

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

Diyelim ki önceki döngüde `echo` ile `head` komutları arasındaki noktalı virgülü unuttun
ve kabuktan şunu çalıştırmasını istedin:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Kabuk ne yapar?

`@possible_answers`
- Bir hata mesajı yazdırır.
- Dört dosyanın her biri için bir satır yazdırır.
- `autumn.csv` (ilk dosya) için bir satır yazdırır.
- Her dosyanın son satırını yazdırır.

`@hint`
`echo` çıktısını `tail` komutuna pipe edebilirsin.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Hayır: döngü çalışacak, sadece mantıklı bir şey yapmayacak."
correct2 = "Evet: `echo` dosya adını iki kez içeren bir satır üretir, ardından `tail` bunu kopyalar."
err3 = "Hayır: döngü dört dosya adının her biri için bir kez çalışır."
err4 = "Hayır: `tail`'in girdisi, her dosya adı için `echo`'nun çıktısıdır."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

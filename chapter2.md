---
title: Verilerle çalışma
description: >-
  Önceki bölümde gördüğün komutlar, dosya sisteminde öğeleri taşımanı
  sağlıyordu. Bu bölüm, o dosyaların içindeki verilerle nasıl çalışacağını
  gösterecek. Kullanacağımız araçlar oldukça basit, ama sağlam yapı taşlarıdır.
lessons:
  - nb_of_exercises: 12
    title: Bir dosyanın içeriğini nasıl görüntüleyebilirim?
---

## Bir dosyanın içeriğini nasıl görüntüleyebilirim?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Dosyaları yeniden adlandırmadan veya silmeden önce,
içeriklerine bir göz atmak isteyebilirsin.
Bunu yapmanın en basit yolu `cat` komutudur;
bu komut, dosyaların içeriğini ekrana yazdırır.
(Adı "concatenate" kelimesinin kısaltmasıdır, yani "şeyleri birbirine eklemek",
çünkü verdiğin tüm dosyaları isim sırasıyla, art arda ekrana basar.)

```{shell}
cat agarwal.txt
```
```
name: Agarwal, Jasmine
position: RCT2
start: 2017-04-01
benefits: full
```

`@instructions`
`course.txt` dosyasının içeriğini ekrana yazdır.

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
    has_expr_output(incorrect_msg="Komutunuz doğru çıktıyı üretmedi. `cat` komutunu ve ardından `course.txt` dosyasının adını kullandınız mı?")
)
Ex().success_msg("Güzel! Bir dosyanın içeriğini görüntülemenin diğer yollarına bakalım.")
```

---

## Bir dosyanın içeriğini parça parça nasıl görebilirim?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Büyük dosyaları yazdırmak için `cat` kullanıp çıktıda kaydırma yapabilirsin,
amma genellikle çıktıyı **sayfalamak** daha pratiktir.
Bunu yapmak için kullanılan ilk komut `more` idi,
amma artık daha güçlü bir komut olan `less` tercih ediliyor.
(Unix dünyasında bu tür isimlendirme mizah sayılır.)
Bir dosyayı `less` ile açtığında,
çıktı ekranda bir seferde bir sayfa gösterilir;
aşağı inmek için boşluk tuşuna basabilir veya çıkmak için `q` yazabilirsin.

`less` komutuna birden fazla dosya adı verirsen,
sonraki dosyaya geçmek için `:n` (iki nokta üst üste ve küçük 'n') yazabilir,
öncekine dönmek için `:p` yazabilir
veya çıkmak için `:q` kullanabilirsin.

Not: `less` kullanan egzersizlerin çözümlerini görüntülersen,
sayfalamayı *kapatmak* için sonda fazladan bir komut göreceksin;
böylece çözümlerini verimli şekilde test edebiliyoruz.

`@instructions`
Bu iki dosyayı bu sırayla görmek için `less seasonal/spring.csv seasonal/summer.csv` komutunu kullan.
Aşağı inmek için boşluk tuşuna bas, ikinci dosyaya geçmek için `:n`, çıkmak için `:q` kullan.

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
                 incorrect_msg='`less` ve dosya adlarını kullanın. Unutmayın, `:n` sizi bir sonraki dosyaya taşır.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Bir dosyanın başına nasıl bakarım?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Veri bilimcilerin yeni bir veri kümesi aldığında ilk yaptığı şey,
hangi alanları içerdiğini ve bu alanların hangi değerlere sahip olduğunu anlamaktır.
Veri kümesi bir veritabanından ya da e-tablodan dışa aktarılmışsa,
çoğunlukla **virgülle ayrılmış değerler** (CSV) olarak saklanır.
İçeriğini hızlıca görmek için ilk birkaç satıra bakmak iyi bir yöntemdir.

Bunu kabukta `head` adlı bir komutla yapabiliriz.
Adının da ima ettiği gibi,
bir dosyanın ilk birkaç satırını yazdırır
(buradaki "birkaç" 10 demektir),
yani şu komut:

```{shell}
head seasonal/summer.csv
```

şunu gösterir:

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

Dosyada 10 satır yoksa `head` ne yapar?
(Öğrenmek için `people/agarwal.txt` dosyasının başına bakmak üzere kullan.)

`@possible_answers`
- Dosya çok kısa olduğu için bir hata iletisi yazdırır.
- Var olduğu kadar satırı gösterir.
- Toplamı 10'a tamamlamak için yeterli sayıda boş satır gösterir.

`@hint`
Yapabileceği en faydalı şey ne olurdu?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Yanlış: bu, yapabileceği en faydalı şey değil.",
                    "Doğru!",
                    "Yanlış: bu, sonunda bir sürü boş satır olan bir dosyadan ayırt edilmesi imkansız olurdu."])
```

---

## Daha az nasıl yazabilirim?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Kabukta (shell) işini hızlandıran güçlü araçlardan biri **sekme (tab) tamamlama**dır.
Bir dosya adını yazmaya başlayıp ardından tab tuşuna basarsan,
shell yolu otomatik tamamlamak için elinden geleni yapar.
Örneğin,
`sea` yazıp taba basarsan,
`seasonal/` dizin adını (sonunda eğik çizgiyle) doldurur.
Sonra `a` yazıp taba basarsan,
`seasonal/autumn.csv` yolunu tamamlar.

Eğer yol belirsizse,
örneğin `seasonal/s` gibi,
iki kez taba basmak olası seçeneklerin bir listesini gösterir.
Yolunu daha belirgin kılmak için bir iki karakter daha yazıp
ardından taba basman
ismin geri kalanını dolduracaktır.

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
Dosya adının tamamını yazmadan `head seasonal/autumn.csv` komutunu çalıştır.

`@hint`
Yolun gerektiği kadarını yaz, sonra taba bas ve tekrarla.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Denetleyici, komutunuzda doğru çıktıyı bulamadı. `seasonal/autumn.csv` üzerinde `head` çağırdığınızdan emin misiniz?")
)

```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Dosya adının tamamını yazmadan `head seasonal/spring.csv` komutunu çalıştır.

`@hint`
Yolun gerektiği kadarını yaz, sonra taba bas ve tekrarla.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Denetleyici, komutunuzda doğru çıktıyı bulamadı. `seasonal/spring.csv` üzerinde `head` komutunu çağırdığınızdan emin misiniz?")
)
Ex().success_msg("İyi iş! Sekme tamamlamayı kullanmaya alıştığınızda, bu size çok zaman kazandıracaktır!")
```

---

## Komutların ne yaptığını nasıl kontrol ederim?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Bir dosyanın ilk 10 satırına her zaman bakmak istemeyebilirsin,
bu yüzden kabuk, `head` komutunun davranışını
ona bir **komut satırı bayrağı** (kısaca "bayrak") vererek değiştirmeni sağlar.
Eğer şu komutu çalıştırırsan:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` dosyanın yalnızca ilk üç satırını gösterir.
`head -n 100` çalıştırırsan,
ilk 100 satırı gösterir (o kadar satır varsa tabii),
ve benzeri.

Bir bayrağın adı genellikle amacını belirtir
(örneğin, `-n` "satır **s**ayısı"nı ifade eder).
Komut bayraklarının her zaman `-` ve tek bir harf olması gerekmez,
amma bu yaygın kullanılan bir konvansiyondur.

Not: Tüm bayrakları dosya adlarından *önce* yazmak iyi bir stil olarak kabul edilir;
bu nedenle bu derste,
ancak bunu yapan yanıtları kabul ediyoruz.

`@instructions`
`seasonal` dizinindeki `winter.csv` dosyasının ilk 5 satırını görüntüle.

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
        has_expr_output(incorrect_msg="`head` komutunu `seasonal/winter.csv` dosyasında çağırdığınızdan emin misiniz?"),
        has_expr_output(strict=True, incorrect_msg="`-n 5` bayrağını kullandığınızdan emin misiniz?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "`-n 5` bayrağını kullandığınızdan emin misiniz?")
)
Ex().success_msg("Güzel! Bu teknikle, daha büyük metin dosyalarına göz atmak istediğinizde kabuğunuzun patlamasını önleyebilirsiniz.")
```

---

## Bir dizinin altındaki her şeyi nasıl listeleyebilirim?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Bir dizinin altında, ne kadar derine gömülü olursa olsun her şeyi görmek için,
`ls` komutuna `-R` bayrağını
("recursive" yani özyinelemeli) verebilirsin.
Ev dizininde `ls -R` kullanırsan,
aşağıdakine benzer bir çıktı görürsün:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Bu çıktı önce mevcut düzeydeki tüm dosya ve dizinleri,
sonra her alt dizindeki her şeyi,
ve bu şekilde devamını gösterir.

`@instructions`
Ne nedir daha kolay ayırt edebilmen için,
`ls` komutunun bir de `-F` bayrağı vardır; bu bayrak her dizin adının sonuna `/`,
her çalıştırılabilir programın sonuna `*` koyar.
İki bayrakla, `-R` ve `-F`, ve ev dizininin mutlak yoluyla `ls` komutunu çalıştırarak
içindeki her şeyi gör.
(Bayrakların sırası önemli değil, ancak dizin adı en sonda olmalı.)

`@hint`
Ev dizinini `~` veya `.` ya da mutlak yolu ile belirtebilirsin.

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
  has_expr_output(incorrect_msg='Ya `ls -R -F` ya da `ls -F -R` ve `/home/repl` yolunu kullanın.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Ya `ls -R -F` ya da `ls -F -R` ve `/home/repl` yolunu kullanın.')
)
Ex().success_msg("Oldukça güzel bir genel bakış, değil mi?")
```

---

## Bir komut için nasıl yardım alabilirim?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Komutların ne yaptığını öğrenmek için insanlar eskiden `man` komutunu ("manual"ın kısaltması) kullanırdı. Örneğin, `man head` komutu şu bilgileri getirir:

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

`man` otomatik olarak `less`'i çalıştırır, bu yüzden bilgileri sayfa sayfa görmek için boşluk tuşuna basman ve çıkmak için `:q` yazman gerekebilir.

`NAME` altındaki tek satırlık açıklama komutun ne yaptığını kısaca söyler, `SYNOPSIS` altındaki özet ise anladığı tüm bayrakları listeler. İsteğe bağlı olanlar köşeli parantez `[...]` içinde gösterilir, ya/ya da alternatifleri `|` ile ayrılır ve tekrar edilebilenler `...` ile gösterilir. Yani `head`'in kılavuz sayfası, satır sayısını `-n` ile ya da bayt sayısını `-c` ile verebileceğini ve istediğin sayıda dosya adı geçebileceğini anlatıyor.

Unix kılavuzunun sorunu, ne aradığını biliyor olmanı gerektirmesidir. Bilmiyorsan, [Stack Overflow](https://stackoverflow.com/) üzerinde arama yapabilir, DataCamp'in Slack kanallarında soru sorabilir ya da zaten bildiğin komutların `SEE ALSO` bölümlerine bakabilirsin.

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
`-n` bayrağıyla kullanılan sayının önüne `+` işareti koymanın ne yaptığını öğrenmek için `tail` komutunun kılavuz sayfasını oku. (Aşağı inmek için boşluk tuşuna basmayı ve/veya çıkmak için `q` yazmayı unutma.)

`@hint`
Unutma: `man`, "manual"ın kısaltmasıdır.

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='`man` ve komut adını kullanınız.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
`seasonal/spring.csv` dosyasının ilk altı satırı HARİÇ tümünü göstermek için `tail` komutunu `-n +7` bayrağıyla kullan.

`@hint`
Gösterilmesini istediğin satır sayısının önüne artı işareti '+' koy.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="`seasonal/spring.csv` dosyasını `tail` komutu ile çağırdığınızdan emin misiniz?"),
    has_expr_output(strict=True, incorrect_msg="`-n +7` bayrağını kullandığınızdan emin misiniz?")
)
```

---

## Bir dosyadan sütunları nasıl seçerim?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` ve `tail` bir metin dosyasından satır seçmene izin verir.
Sütun seçmek istiyorsan,
`cut` komutunu kullanabilirsin.
Birkaç seçeneği vardır (keşfetmek için `man cut` komutunu kullan),
amma en yaygını şu şekildedir:

```{shell}
cut -f 2-5,8 -d , values.csv
```

bu da şu anlama gelir:
"ayırıcı olarak virgül kullanarak 2'den 5'e kadar olan sütunları ve 8. sütunu seç".
`cut`, sütunları belirtmek için `-f` ("fields" anlamına gelir)
ve ayırıcıyı belirtmek için `-d` ("delimiter" anlamına gelir) kullanır.
İkincisini belirtmen gerekir çünkü bazı dosyalar sütunları ayırmak için boşluk, sekme veya iki nokta kullanabilir.

<hr>

`spring.csv` dosyasından ilk sütunu (tarihleri içeren) seçecek komut nedir?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Yukarıdakilerin her ikisi de.
- Yukarıdakilerin hiçbiri, çünkü `-f` mutlaka `-d`'den önce gelmelidir.

`@hint`
Bayrakların (flag) sırasının bir önemi yoktur.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Evet, ama bu hepsi değil', 'Evet, ama bu hepsi değil', 'Doğru! Bayraktan sonra bir boşluk eklemek iyi bir stildir, ancak zorunlu değildir.', 'Hayır, bayrak sırası önemli değil'])
```

---

## cut neyi yapamaz?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` basit mantıkla çalışan bir komuttur.
Özellikle de
tırnak içindeki dizeleri anlamaz.
Örneğin, dosyan şöyleyse:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

şu komut:

```{shell}
cut -f 2 -d , everyone.csv
```

şunu üretir:

```
Age
Ranjit"
Rupinder"
```

herkesin yaşını vermek yerine,
çünkü soyadı ile adı arasındaki virgülü sütun ayırıcı sanır.

<hr>

Şu satır üzerinde `cut -d : -f 2-4` komutunun çıktısı nedir:

```
first:second:third:
```

(Sondaki iki nokta üst üste işaretine dikkat et.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Yukarıdakilerin hiçbiri, çünkü dört alan yok.

`@hint`
Sondaki iki nokta üst üste işaretine dikkat et.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Hayır, daha fazlası var.', 'Hayır, daha fazlası var.', 'Doğru! Sondaki iki nokta üst üste dördüncü bir boş alan oluşturur.', 'Hayır, `cut` elinden gelenin en iyisini yapar.'])
```

---

## Komutları nasıl tekrar çalıştırırım?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Kabuk kullanmanın en büyük avantajlarından biri,
aynı şeyleri tekrar tekrar yapmayı kolaylaştırmasıdır.
Bir dizi komut çalıştırdıysan,
Yukarı ok tuşuna basarak bunlar arasında geriye doğru dolaşabilirsin.
Sol ve sağ ok tuşlarıyla ve silme tuşuyla komutları düzenleyebilirsin.
Enter’a bastığında düzenlediğin komut çalışır.

Daha da iyisi, `history` yakın zamanda çalıştırdığın komutların listesini yazdırır.
Her birinin başında, belirli bir komutu yeniden çalıştırmayı kolaylaştıran bir sıra numarası vardır:
Geçmişindeki 55. komutu yeniden çalıştırmak için `!55` yazman yeterli (bu kadar çok komutun varsa).
Bir komutu, ünlem işaretinden sonra komutun adını yazarak da yeniden çalıştırabilirsin;
örneğin `!head` veya `!cut`,
bu komutun en son kullanımını yeniden çalıştırır.

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
Ev dizininde `head summer.csv` komutunu çalıştır (bu başarısız olmalı).

`@hint`
Eşleşen bir dosya adı yoksa sekmeyle tamamlama çalışmaz.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="`head` ve bir dosya adı, `summer.csv` kullanın. Başarısız olursa endişelenmeyin. Olması gerekiyor.")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Dizini `seasonal` konumuna değiştir.

`@hint`
`cd` "change directory" (dizin değiştir) anlamına geldiğini unutma.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Geçerli çalışma dizininiz (bunu `pwd` ile öğrenebilirsiniz) `/home/repl` ise, `seasonal` klasörüne `cd seasonal` komutuyla geçebilirsiniz.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
`head` komutunu `!head` ile yeniden çalıştır.

`@hint`
`!` ile ardından gelen ifade arasında boşluk bırakma.

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
                        incorrect_msg='`head` komutunu tekrarlamak için `!head` kullanın.'),
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
Ne yaptığını görmek için `history` kullan.

`@hint`
`history` en son komutları sonda gösterir; böylece çalışması bittiğinde ekranında kalırlar.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Önceki komutların bir listesini almak için `history` komutunu bayraklar olmadan kullanın.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
`head` komutunu yine bir komut numarasının önüne `!` koyarak yeniden çalıştır.

`@hint`
`!` ile ardından gelen ifade arasında boşluk bırakma.

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
                        incorrect_msg='Geçmişten son `head` komutunu yeniden çalıştırmak için `!<bir_sayı>` kullandınız mı?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Tebrikler! Bir sonrakine geçelim!")
```

---

## Belirli değerleri içeren satırları nasıl seçebilirim?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` ve `tail` satırları seçer,
`cut` sütunları seçer,
`grep` ise satırları içerdiklerine göre seçer.
En basit haliyle,
`grep`, bir metin parçasını ve ardından bir veya daha fazla dosya adını alır
ve bu metni içeren satırların hepsini yazdırır.
Örneğin,
`grep bicuspid seasonal/winter.csv`
"bicuspid" içeren `winter.csv` satırlarını yazdırır.

`grep` ayrıca kalıpları da arayabilir;
bunları bir sonraki kursta inceleyeceğiz.
Şu anda daha önemli olan, `grep`'in yaygın bayraklarından bazılarıdır:

- `-c`: satırların kendisi yerine eşleşen satırların sayısını yazdır
- `-h`: birden çok dosyada ararken dosya adlarını yazdırma
- `-i`: büyük/küçük harfe duyarsız ol (ör. "Regression" ve "regression" eşleşir)
- `-l`: eşleşme içeren dosyaların adlarını yazdır, eşleşmeleri değil
- `-n`: eşleşen satırların satır numaralarını yazdır
- `-v`: eşleşmeyi tersine çevir, yani yalnızca eşleşmeyen satırları göster

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
Ev dizinindeyken tek bir komut çalıştırarak `seasonal/autumn.csv` içinde `molar` kelimesini içeren tüm satırların içeriğini yazdır.
Herhangi bir bayrak kullanma.

`@hint`
Aradığın kelimeyle ve içinde arama yapacağın dosya ad(lar)ıyla birlikte `grep` kullan.

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
      has_code("grep", incorrect_msg = "`grep` komutunu çağırdınız mı?"),
      has_code("molar", incorrect_msg = "`molar` kelimesini aradınız mı?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "`seasonal/autumn.csv` dosyasını aradınız mı?")
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
Eşleşmeyi tersine çevirerek `seasonal/spring.csv` içinde `molar` kelimesini içermeyen tüm satırları bul ve satır numaralarını göster.
Unutma, bayrakları dosya adları veya "molar" gibi arama terimlerinden önce koymak iyi bir stil kabul edilir.

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
      has_code("grep", incorrect_msg = "`grep` komutunu çağırdınız mı?"),
      has_code("-v", incorrect_msg = "`-v` ile eşleşmeyi tersine çevirdiniz mi?"),
      has_code("-n", incorrect_msg = "`-n` ile satır numaralarını gösterdiniz mi?"),
      has_code("molar", incorrect_msg = "`molar` kelimesini aradınız mı?"),
      has_code("seasonal/spring.csv", incorrect_msg = "`seasonal/spring.csv` dosyasını aradınız mı?")
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
Birlikte değerlendirildiğinde `autumn.csv` ve `winter.csv` içinde `incisor` kelimesini içeren kaç satır olduğunu say.
(Yine, ev dizininden tek bir komut çalıştır.)

`@hint`
Satırları saymak için `grep` ile `-c` kullanmayı unutma.

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
      has_code("grep", incorrect_msg = "`grep` komutunu çağırdınız mı?"),
      has_code("-c", incorrect_msg = "`-c` ile sayıları aldınız mı?"),
      has_code("incisor", incorrect_msg = "`incisor` için arama yaptınız mı?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "`seasonal/autumn.csv` dosyasında arama yaptınız mı?"),
      has_code("seasonal/winter.csv", incorrect_msg = "`seasonal/winter.csv` dosyasında arama yaptınız mı?")
    )
  )
)

```

---

## Veriyi her zaman metinmiş gibi ele almak neden güvenli değildir?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

`cut` için kılavuz sayfasının `SEE ALSO` bölümünde, verileri bölmek yerine birleştirmek için kullanılabilen `paste` adlı bir komuttan bahsedilir.

<hr>

`paste` için kılavuz sayfasını oku
ve ardından sonbahar ve kış veri dosyalarını virgülü ayırıcı olarak kullanarak
tek bir tabloda birleştirmek için `paste` komutunu çalıştır.
Veri analizi açısından çıktıda ne sorun var?

`@possible_answers`
- Sütun başlıkları tekrar ediyor.
- Son birkaç satırda sütun sayısı yanlış.
- `winter.csv` içindeki bazı veriler eksik.

`@hint`
`paste` çıktısını ayırıcı olarak virgül kullanıp `cut` ile kessen,
doğru cevabı üretir miydi?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Doğru, ancak bu mutlaka bir hata değildir.'
correct2 = 'Doğru: satırları sütunlarla birleştirmek başlangıçta yalnızca bir boş sütun oluşturur, iki tane değil.'
err3 = 'Hayır, tüm kış verileri orada.'
Ex().has_chosen(2, [err1, correct2, err3])
```

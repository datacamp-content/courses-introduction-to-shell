---
title: Araçları birleştirme
description: >-
  Unix kabuğunun asıl gücü tek tek komutlarda değil, yeni şeyler yapmak için ne
  kadar kolay birleştirilebildiklerinde yatar. Bu bölüm, istediğin veriyi seçmek
  için bu gücü nasıl kullanacağını gösterecek ve değerleri sıralamak ile
  yinelenenleri kaldırmak için komutları tanıtacak.
lessons:
  - nb_of_exercises: 12
    title: Bir komutun çıktısını bir dosyada nasıl saklayabilirim?
---

## Bir komutun çıktısını bir dosyada nasıl saklarım?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Şimdiye kadar gördüğün araçların hepsi girdi dosyalarının adını vermene izin veriyor.
Çoğunun çıktı dosyasının adını verme seçeneği yok, çünkü gerek duymuyorlar.
Bunun yerine,
**yönlendirme** kullanarak herhangi bir komutun çıktısını istediğin yere kaydedebilirsin.
Bu komutu çalıştırırsan:

```{shell}
head -n 5 seasonal/summer.csv
```

ekrana yazın verilerin ilk 5 satırını basar.
Bunun yerine şu komutu çalıştırırsan:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

ekranda hiçbir şey görünmez.
Bunun yerine,
`head` çıktısı `top.csv` adlı yeni bir dosyaya yazılır.
Bu dosyanın içeriğine `cat` ile bakabilirsin:

```{shell}
cat top.csv
```

Büyüktür işareti `>` kabuğa `head` çıktısını bir dosyaya yönlendirmesini söyler.
Bu işaret `head` komutunun bir parçası değildir;
aksine,
çıktı üreten her kabuk komutuyla çalışır.

`@instructions`
`tail` ile yönlendirmeyi birleştirerek `seasonal/winter.csv` dosyasının son 5 satırını `last.csv` adlı bir dosyaya kaydet.

`@hint`
Son 5 satırı almak için `tail -n 5` kullan.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "Satır `%s` `last.csv` dosyasında olmalı, ancak değil. `tail -n 5 seasonal/winter.csv` çıktısını `>` ile `last.csv` dosyasına yönlendirin."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` dosyasında çok fazla satır var. `tail` ile `-n 5` bayrağını kullandınız mı?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Güzel! Biraz daha pratik yapalım!")
```

---

## Bir komutun çıktısını girdi olarak nasıl kullanabilirim?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Diyelim ki bir dosyanın ortasındaki satırları almak istiyorsun.
Daha net olmak gerekirse,
veri dosyalarımızdan birinden 3-5. satırları almak istiyorsun.
İlk 5 satırı almak için `head` kullanarak başlayabilir,
bunu bir dosyaya yönlendirebilir
ve ardından son 3 satırı seçmek için `tail` kullanabilirsin:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Hızlı bir kontrol, bunun orijinal dosyamızın 3-5. satırları olduğunu doğrular,
çünkü ilk 5 satırın son 3 satırıdır.

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
`seasonal/winter.csv` dosyasının son iki satırını seç
ve bunları `bottom.csv` adlı bir dosyaya kaydet.

`@hint`
Satırları seçmek için `tail` ve `tail` çıktısını yönlendirmek için `>` kullan.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="`%s` satırı `bottom.csv` dosyasında olmalıdır, ancak değil. `tail -n 2 seasonal/winter.csv` çıktısını `>` ile `bottom.csv` dosyasına yönlendirin."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` dosyasında çok fazla satır var. `tail` ile `-n 2` bayrağını kullandınız mı?'),
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
Orijinal dosyanın sondan ikinci satırını almak için
`bottom.csv` dosyasından ilk satırı seç.

`@hint`
İstediğin satırı seçmek için `head` kullan.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="`bottom.csv` dosyasında bir sorun var. Onu değiştirmediğinizden emin olun!"),
    has_expr_output(strict=True, incorrect_msg="`bottom.csv` üzerinde `head` komutunu doğru kullandınız mı? `-n` bayrağını doğru kullandığınızdan emin olun.")
)

Ex().success_msg("Tebrikler. Komutları birleştirmenin daha iyi yollarını öğrenmek için bir sonraki alıştırmaya geçin.")                             

```

---

## Komutları birleştirmenin daha iyi bir yolu nedir?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Yönlendirme kullanarak komutları birleştirmenin iki sakıncası vardır:

1. Ortalıkta bir sürü ara dosya bırakır (örneğin `top.csv`).
2. Sonucu üretmek için kullandığın komutlar geçmişte birkaç satıra dağılmış olur.

Kabuk, bu iki sorunu aynı anda çözen başka bir araç sunar: **pipe** (boru).
Yine,
`head` komutunu çalıştırarak başla:

```{shell}
head -n 5 seasonal/summer.csv
```

`head` çıktısını bir dosyaya göndermek yerine,
dikey bir çizgi ekle ve dosya adı olmadan `tail` komutunu kullan:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Pipe sembolü, soldaki komutun çıktısını
sağdaki komut için girdi olarak kullanmasını kabuğa söyler.

`@instructions`
Virgülle ayrılmış `seasonal/summer.csv` dosyasının 2. sütunundaki tüm diş adlarını seçmek için `cut` kullan ve sonucu, ters eşleşmeyle başlık satırında geçen "Tooth" kelimesini hariç tutacak şekilde `grep`'e pipe ile aktar. *`cut` ve `grep` komutları sırasıyla Bölüm 2, egzersiz 8 ve 11'de ayrıntılı olarak ele alınmıştı.*

`@hint`
- Komutun ilk kısmı şu biçimdedir: `cut -d alan_ayırıcı -f sütun_numarası dosya_adı`.
- Komutun ikinci kısmı şu biçimdedir: `grep -v esleşecek_şey`.

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
    has_expr_output(incorrect_msg = '`cut -d , -f 2 seasonal/summer.csv` ifadesinin sonucunu `|` ile `grep -v Tooth` komutuna yönlendirdiniz mi?'),
    check_not(has_output("Tooth"), incorrect_msg = '`grep` kullanarak `"Tooth"` başlık satırını çıkardınız mı?')
)
Ex().success_msg("Mükemmel yönlendirme! Bu `|` operatörünü ilk kez kullanıyor olabilirsiniz, ancak kesinlikle son olmayacak!")
```

---

## Birçok komutu nasıl birleştiririm?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

İstediğin sayıda komutu art arda bağlayabilirsin.
Örneğin,
şu komut:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

şunları yapar:

1. bahar verilerinden ilk sütunu seçer;
2. "Date" sözcüğünü içeren başlık satırını kaldırır; ve
3. gerçek verilerin ilk 10 satırını seçer.

`@instructions`
Önceki egzersizde, `seasonal/summer.csv` dosyasının 2. sütunundan tüm diş adlarını seçmek için aşağıdaki komutu kullanmıştın:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Bu hattı (pipeline) bir `head` komutuyla genişlet ve yalnızca en ilk diş adını seç.

`@hint`
Talimatlardaki kodu kopyalayıp yapıştır, bir pipe ekle ve sonra `-n` bayrağıyla `head` komutunu çağır.

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
    has_output('^\s*canine\s*$', incorrect_msg = "`|` kullanarak bir `head` komutu ile boru hattını genişlettiniz mi? `-n` bayrağını doğru ayarladığınızdan emin olun."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "`|` kullanarak bir `head` komutu ile boru hattını genişlettiniz mi?")
)
Ex().success_msg("Neşeli zincirleme! Birkaç komutu bir araya getirerek güçlü veri işleme boru hatları oluşturabilirsiniz.")
```

---

## Bir dosyadaki kayıtları nasıl sayarım?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

`wc` komutu ("word count"ın kısaltması) bir dosyadaki **c**haracter (karakter), **w**ord (kelime) ve **l**ine (satır) sayılarını yazdırır.
Sırasıyla yalnızca bunlardan birini yazdırması için `-c`, `-w` veya `-l` kullanabilirsin.

`@instructions`
`seasonal/spring.csv` içinde Temmuz 2017 (`2017-07`) tarihine sahip kaç kayıt olduğunu say.
- Bunu yapmak için, satırları seçmek üzere kısmi bir tarihle `grep` kullan ve sonucu uygun bayrakla satırları sayması için `wc` komutuna borula.

`@hint`
- Tarih biçimini hatırlamak için `head seasonal/spring.csv` kullan.
- Komutun ilk kısmı `grep eslesecek_sey dosya_adi` biçimindedir.
- Borudan, `|`, sonra `wc` komutunu `-l` bayrağıyla çağır.

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
      has_code("grep", incorrect_msg = "`grep` komutunu çağırdınız mı?"),
      has_code("2017-07", incorrect_msg = "`2017-07` ifadesini aradınız mı?"),
      has_code("seasonal/spring.csv", incorrect_msg = "`seasonal/spring.csv` dosyasını aradınız mı?"),
      has_code("|", incorrect_msg = "`wc` komutuna `|` kullanarak yönlendirme yaptınız mı?"),      
      has_code("wc", incorrect_msg = "`wc` komutunu çağırdınız mı?"),
      has_code("-l", incorrect_msg = "`-l` ile satırları saydınız mı?")
    )
  )
)
Ex().success_msg("Dikkatli sayma! Ne kadar veriye sahip olduğunuzu belirlemek, herhangi bir veri analizinde harika bir ilk adımdır.")
```

---

## Bir seferde birçok dosyayı nasıl belirtebilirim?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

Çoğu kabuk (shell) komutu, birden fazla dosya adı verirsen birden fazla dosya üzerinde çalışır.
Örneğin,
bütün mevsimsel veri dosyalarının ilk sütununu tek seferde şöyle alabilirsin:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Ama bir sürü dosya adını tekrar tekrar yazmak iyi bir fikir değil:
zaman kaybettirir
ve er ya da geç ya bir dosyayı atlar ya da bir dosya adını iki kez yazarsın.
İşini kolaylaştırmak için,
kabuk **joker karakterler** kullanarak tek bir ifadeyle bir dosya listesi belirtmene izin verir.
En yaygın joker karakter `*`'tır,
ve "sıfır veya daha fazla karakterle eşleş" anlamına gelir.
Bunu kullanarak,
yukarıdaki `cut` komutunu şöyle kısaltabiliriz:

```{shell}
cut -d , -f 1 seasonal/*
```

ya da:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
`head` kullanarak hem `seasonal/spring.csv` hem de `seasonal/summer.csv` dosyalarının ilk üç satırını alacak tek bir komut yaz; toplamda altı satır veri olsun, ancak sonbahar veya kış verisi dosyalarından olmasın.
Dosya adlarını tek tek yazmak yerine bir joker karakter kullan.

`@hint`
- Komut şu biçimdedir: `head -n number_of_lines filename_pattern`.
- Örneğin, `a` dizinindeki, `b` ile başlayan dosyaları `a/b*` ile eşleştirebilirsin.

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
    has_expr_output(incorrect_msg = "`seasonal/spring.csv` ve `seasonal/summer.csv` dosyalarını seçmek için `seasonal/s*` kullanabilirsiniz. Her dosyanın yalnızca ilk üç satırını `-n` bayrağı ile dahil ettiğinizden emin olun!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "`seasonal/autumn.csv` dosyasının çıktısını dahil etmeyin. `seasonal/spring.csv` ve `seasonal/summer.csv` dosyalarını seçmek için `seasonal/s*` kullanabilirsiniz."),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "`seasonal/winter.csv` dosyasının çıktısını dahil etmeyin. `seasonal/spring.csv` ve `seasonal/summer.csv` dosyalarını seçmek için `seasonal/s*` kullanabilirsiniz.")
)
Ex().success_msg("Harika joker karakter çalışması! Dizin yüzlerce veya binlerce dosya içeriyorsa bu daha da önemli hale gelir.")
```

---

## Başka hangi joker karakterleri kullanabilirim?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Kabukta başka joker karakterler de var,
ancak daha az kullanılıyorlar:

- `?` tek bir karakteri eşleştirir; bu yüzden `201?.txt`, `2017.txt` veya `2018.txt` ile eşleşir ama `2017-01.txt` ile eşleşmez.
- `[...]` köşeli parantez içindeki karakterlerden herhangi birini (yalnızca bir tane) eşleştirir; bu yüzden `201[78].txt`, `2017.txt` veya `2018.txt` ile eşleşir ama `2016.txt` ile eşleşmez.
- `{...}` süslü parantez içindeki virgülle ayrılmış desenlerden herhangi biriyle eşleşir; bu yüzden `{*.txt, *.csv}`, adı `.txt` veya `.csv` ile biten herhangi bir dosyayla eşleşir ama adı `.pdf` ile biten dosyalarla eşleşmez.

<hr/>

Hangi ifade `singh.pdf` ve `johel.txt` ile eşleşir ama `sandhu.pdf` veya `sandhu.txt` ile eşleşmez?

`@hint`
Her ifadeyi sırayla her dosya adıyla eşleştir.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Hayır: `.pdf` ve `.txt` birer dosya adı değil.
- Hayır: bu, `sandhu.pdf` ile de eşleşir.
- Hayır: köşeli parantez içindeki ifade tüm kelimeleri değil, yalnızca tek bir karakteri eşleştirir.
- Doğru!

---

## Metin satırlarını nasıl sıralayabilirim?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Adından da anlaşılacağı gibi,
`sort` verileri sıralar.
Varsayılan olarak bunu artan alfabetik düzende yapar,
amab `-n` ve `-r` bayrakları çıktıyı sayısal olarak ve ters sırada sıralamak için kullanılabilir,
`-b` baştaki boşlukları yoksaymasını söyler
ve `-f` büyük/küçük harfleri eşitlemesini (yani, büyük/küçük harfe duyarsız olmasını) söyler.
Boru hatlarında genellikle istenmeyen kayıtları ayıklamak için `grep` kullanılır,
sonra kalan kayıtları sıraya koymak için `sort` uygulanır.

`@instructions`
`seasonal/summer.csv` dosyasının 2. sütunundaki tüm diş adlarını seçmek için `cut` ve `grep` birleşimini hatırlıyor musun?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Bu tariften yola çıkarak, diş adlarını `seasonal/winter.csv` (not `summer.csv`) dosyasında azalan alfabetik düzende sırala. Bunu yapmak için, boru hattını bir `sort` adımıyla genişlet.

`@hint`
Talimatlardaki komutu kopyalayıp yapıştır, dosya adını değiştir, bir pipe ekle ve ardından `sort` komutunu `-r` bayrağıyla çağır.

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
      has_code("cut", incorrect_msg = "`cut` komutunu çağırdınız mı?"),
      has_code("-d", incorrect_msg = "`-d` ile bir alan ayırıcı belirttiniz mi?"),
      has_code("seasonal/winter.csv", incorrect_msg = "`seasonal/winter.csv` dosyasından veri aldınız mı?"),
      has_code("|", incorrect_msg = "`cut`'tan `grep`'e ve `sort`'a `|` kullanarak veri aktardınız mı?"),      
      has_code("grep", incorrect_msg = "`grep` komutunu çağırdınız mı?"),
      has_code("-v", incorrect_msg = "`-v` ile eşleşmeyi tersine çevirdiniz mi?"),
      has_code("Tooth", incorrect_msg = "`Tooth` için arama yaptınız mı?"),
      has_code("sort", incorrect_msg = "`sort` komutunu çağırdınız mı?"),
      has_code("-r", incorrect_msg = "`-r` ile sıralama düzenini tersine çevirdiniz mi?")
    )
  )
)
Ex().success_msg("Sıralandı! `sort`'un birçok kullanımı vardır. Örneğin, `sort -n`'i `head`'e yönlendirmek size en büyük değerleri gösterir.")
```

---

## Yinelenen satırları nasıl kaldırabilirim?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

`sort` ile sıkça birlikte kullanılan başka bir komut da, yinelenen satırları kaldıran `uniq`'tir.
Daha net söylemek gerekirse,
bu komut yalnızca *bitişik* yinelenen satırları kaldırır.
Eğer bir dosya şunu içeriyorsa:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

`uniq` şu çıktıyı üretir:

```
2017-07-03
2017-08-03
```

ama şu içerikteyse:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

`uniq` dört satırın hepsini yazdırır.
Bunun nedeni `uniq` komutunun çok büyük dosyalarla çalışacak şekilde tasarlanmış olmasıdır.
Bir dosyadan bitişik olmayan yinelenen satırları kaldırmak için
tüm dosyayı bellekte tutması gerekir
(ya da en azından,
şimdiye kadar görülen tüm benzersiz satırları).
Sadece bitişik tekrarları kaldırarak
bellekte yalnızca en son benzersiz satırı tutması yeterlidir.

`@instructions`
Bir boru hattı (pipeline) yaz:

- `seasonal/winter.csv` dosyasının ikinci sütununu al,
- çıktıda yalnızca diş adları görünsün diye "Tooth" kelimesini kaldır,
- çıktıyı sırala ki aynı diş adına ait tüm tekrarlar bitişik olsun; ve
- her diş adını, kaç kez göründüğünü belirten bir sayımla birlikte yalnızca bir kez göster.

Boru hattının başlangıcı önceki egzersizle aynı:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Bunu bir `sort` komutuyla genişlet ve her benzersiz satırı kaç kez geçtiğiyle birlikte göstermek için `uniq -c` kullan; `uniq` ve `wc` kullanma.

`@hint`
Talimatlardaki komutu kopyalayıp yapıştır, bayraksız olarak `sort` ile pipe et, sonra tekrar `uniq` komutuna `-c` bayrağıyla pipe et.

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
                     incorrect_msg="Bu komutla başlamalısınız: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Şimdi bunu genişletin!"),
            has_code('\|\s+sort', incorrect_msg="Komutu `| sort` ile genişlettiniz mi?"),
            has_code('\|\s+uniq', incorrect_msg="Komutu `| uniq` ile genişlettiniz mi?"),
            has_code('-c', incorrect_msg="`-c` ile sayıları dahil ettiniz mi?")
        )
    )
)
Ex().success_msg("Harika! Bir boru hattı üzerinde bu kadar çalıştıktan sonra, sonucu saklamak güzel olmaz mıydı?")
```

---

## Bir borunun çıktısını nasıl kaydedebilirim?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Kabuk, borulanmış komutların çıktısını yeniden yönlendirmemize izin verir:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Ancak, `>` boru hattının sonunda yer almalıdır:
ortada kullanmaya çalışırsak, şöyle:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

bu durumda `cut`'ın tüm çıktısı `teeth-only.txt` dosyasına yazılır,
dolayısıyla `grep` için geriye hiçbir şey kalmaz
ve girdi gelmesini sonsuza kadar bekler.

<hr>

Peki ya yeniden yönlendirmeyi bir boru hattının en önüne koyarsak ne olur:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [Komutun çıktısı her zamanki gibi dosyaya yönlendirilir.]
- Kabuk bunu bir hata olarak bildirir.
- Kabuk girdi için sonsuza kadar bekler.

`@hint`
Bunu kabukta dene.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Doğru!', 'Hayır; kabuk aslında bunu çalıştırabilir.', 'Hayır; kabuk aslında bunu çalıştırabilir.'])
```

---

## Çalışan bir programı nasıl durdurabilirim?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Şimdiye kadar çalıştırdığın komutlar ve betikler hızlıca tamamlandı,
amabazı işler dakikalar, saatler, hatta günler sürebilir.
Ayrıca yanlışlıkla yeniden yönlendirmeyi bir ardışık düzenin ortasına koyup
takılmasına neden olabilirsin.
Bir programın çalışmaya devam etmesini istemiyorsan,
`Ctrl` + `C` tuşlayarak sonlandırabilirsin.
Bu, Unix dokümantasyonunda sıkça `^C` olarak yazılır;
'b'nin küçük harf olabileceğini unutma.

`@instructions`
Şu komutu çalıştır:

```{shell}
head
```

argümansız olarak (böylece asla gelmeyecek bir girdiyi bekleyecek)
ve ardından `Ctrl` + `C` tuşlayarak durdur.

`@hint`
Sadece head yaz, Enter’a bas ve çalışan programdan `Ctrl` + `C` ile çık.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="`head` ifadesini kullandınız mı?")
```

---

## Kapanış

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Kapanış olarak,
en kısa sezonluk veri dosyasında kaç kayıt olduğunu bulmak için bir işlem hattı (pipeline) kuracaksın.

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
Tüm sezonluk veri dosyalarındaki satır sayılarını listelemek için uygun parametrelerle `wc` kullan.
(Dosya adlarını tek tek yazmak yerine joker karakter kullan.)

`@hint`
Yalnızca satır sayılarını listelemek için `-l` ve dosya adlarını eşleştirmek için `*` kullan.

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
      has_code("wc", incorrect_msg = "`wc` komutunu çağırdınız mı?"),
      has_code("-l", incorrect_msg = "`-l` ile satır sayısını saydınız mı?"),
      has_code("seasonal/\*", incorrect_msg = "Tüm `seasonal/*` dosyalarından veri aldınız mı?")
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
Önceki komuta bir boru ile başka bir komut ekleyerek "total" kelimesini içeren satırı kaldır.

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
      has_code("wc", incorrect_msg = "`wc` komutunu çağırdınız mı?"),
      has_code("-l", incorrect_msg = "`-l` ile satır sayısını saydınız mı?"),
      has_code("seasonal/\*", incorrect_msg = "Tüm `seasonal/*` dosyalarından veri aldınız mı?"),
      has_code("|", incorrect_msg = "`wc`'den `grep`'e `|` kullanarak veri aktardınız mı?"),      
      has_code("grep", incorrect_msg = "`grep` komutunu çağırdınız mı?"),
      has_code("-v", incorrect_msg = "`-v` ile eşleşmeyi tersine çevirdiniz mi?"),
      has_code("total", incorrect_msg = "`total` için arama yaptınız mı?")
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
En az satır içeren dosyayı bulmak için iş hattına `sort -n` ve `head -n 1` kullanan iki aşama daha ekle.

`@hint`
- Sayısal sıralama için `sort`'un `-n` bayrağını kullan.
- Yalnızca 1 satır tutmak için `head`'in `-n` bayrağını kullan.

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
      has_code("wc", incorrect_msg = "`wc` komutunu çağırdınız mı?"),
      has_code("-l", incorrect_msg = "`-l` ile satır sayısını saydınız mı?"),
      has_code("seasonal/\*", incorrect_msg = "Tüm `seasonal/*` dosyalarından veri aldınız mı?"),
      has_code("|", incorrect_msg = "`wc`'den `grep`'e, `sort`'a ve `head`'e `|` kullanarak yönlendirdiniz mi?"),      
      has_code("grep", incorrect_msg = "`grep` komutunu çağırdınız mı?"),
      has_code("-v", incorrect_msg = "`-v` ile eşleşmeyi tersine çevirdiniz mi?"),
      has_code("total", incorrect_msg = "`total` için arama yaptınız mı?"),
      has_code("sort", incorrect_msg = "`sort` komutunu çağırdınız mı?"),
      has_code("-n", incorrect_msg = "Saklanacak satır sayısını `-n` ile belirttiniz mi?"),
      has_code("1", incorrect_msg = "`-n 1` ile saklanacak 1 satır belirttiniz mi?")
    )
  )
)
Ex().success_msg("Harika! Görünüşe göre en az satıra sahip dosya `autumn.csv`. Toplu işlem hakkında daha fazla bilgi edinmek için 4. bölüme koşun!")
```

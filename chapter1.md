---
title: Dosyalar ve dizinlerle çalışma
description: >-
  Bu bölüm, Unix kabuğuna kısa bir giriş niteliğindedir. Neredeyse 50 yıl sonra
  hâlâ neden kullanıldığını, aşina olabileceğin grafiksel araçlarla nasıl
  karşılaştırıldığını, kabukta nasıl gezineceğini ve dosya ile klasörleri nasıl
  oluşturup, düzenleyip, sileceğini öğreneceksin.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: 'Kabuk, masaüstü arayüzüyle nasıl karşılaştırılır?'
---

## Kabuk, masaüstü arayüzüyle nasıl karşılaştırılır?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Windows, Linux veya Mac OS gibi bir işletim sistemi özel bir tür programdır.
Bilgisayarın işlemcisini, sabit diskini ve ağ bağlantısını kontrol eder,
amma en önemli işi diğer programları çalıştırmaktır.

İnsanlar dijital olmadığından,
işletim sistemiyle etkileşim kurmak için bir arayüze ihtiyaç duyarlar.
Günümüzde en yaygını, tıklama ve çift tıklamaları dosyaları açma ve programları çalıştırma komutlarına çeviren grafik dosya gezginidir.
Bilgisayarların grafik ekranları olmadan önceyse,
insanlar **komut satırı kabuğu** adı verilen bir programa talimatları yazarak girerdi.
Her komut girildiğinde,
kabuk başka programlar çalıştırır,
çıktılarını insanın okuyabileceği biçimde yazdırır
ve ardından bir sonraki komutu almaya hazır olduğunu belirtmek için bir *istem* gösterir.
(Adı, bilgisayarın "dış kabuğu" olduğuna dair düşünceden gelir.)

Tıklayıp sürüklemek yerine komut yazmak ilk başta hantal görünebilir,
amma göreceğin gibi,
bilgisayardan ne yapmasını istediğini yazmaya başladığında,
eski komutları birleştirip yenilerini oluşturabilir
ve tekrarlayan işlemleri
yalnızca birkaç tuş vuruşuyla otomatikleştirebilirsin.

<hr>
Çoğu kişinin kullandığı grafik dosya gezgini ile komut satırı kabuğu arasındaki ilişki nedir?

`@hint`
Bir kullanıcının bir işletim sistemiyle yalnızca bir program aracılığıyla etkileşime girebileceğini unutma.

`@possible_answers`
- Dosya gezgini dosyaları görmeni ve düzenlemeni sağlar, kabuk ise programları çalıştırmanı sağlar.
- Dosya gezgini kabuğun üzerine inşa edilmiştir.
- Kabuk işletim sisteminin bir parçasıdır, dosya gezgini ise ayrı bir bileşendir.
- [Her ikisi de işletim sistemine komut vermek için kullanılan arayüzlerdir.]

`@feedback`
- Her ikisi de dosyaları görüntülemeni ve düzenlemeni ve programları çalıştırmanı sağlar.
- Grafik dosya gezginleri ve kabuk, aynı temel işletim sistemi işlevlerini çağırır.
- Kabuk ve dosya gezgini, kullanıcı komutlarını (yazılmış ya da tıklanmış) işletim sistemine yapılan çağrılara çeviren programlardır.
- Doğru! Her ikisi de kullanıcının komutlarını (ister yazılı ister tıklamayla) alır ve işletim sistemine gönderir.

---

## Neredeyim?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**Dosya sistemi**, dosya ve dizinleri (veya klasörleri) yönetir.
Her biri, dosya sisteminin **kök dizininden** nasıl ulaşılacağını gösteren bir **mutlak yol** ile tanımlanır:
`/home/repl`, `home` dizini içindeki `repl` dizinidir,
`/home/repl/course.txt` ise o dizindeki `course.txt` dosyasıdır,
ve tek başına `/` kök dizindir.

Dosya sisteminde nerede olduğunu öğrenmek için
`pwd` komutunu çalıştır.
(bu, "**p**rint **w**orking **d**irectory"nin kısaltmasıdır).
Bu komut, **geçerli çalışma dizininin** mutlak yolunu yazdırır;
kabuk varsayılan olarak komutları burada çalıştırır ve dosyaları burada arar.

<hr>
`pwd` komutunu çalıştır.
Şu anda neredesin?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix sistemleri genellikle tüm kullanıcıların ana dizinlerini `/home` altında konumlandırır.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Bu doğru yol değil."
correct = "Doğru - `/home/repl` içindesiniz."

Ex().has_chosen(3, [err, err, correct])
```

---

## Dosya ve dizinleri nasıl ayırt edebilirim?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` nerede olduğunu söyler.
Orada neler olduğunu görmek için
`ls` yaz ("**l**i**s**ting"in kısaltmasıdır) ve enter tuşuna bas.
Tek başına
`ls` geçerli dizininin içeriğini listeler
(`pwd` ile gördüğün dizin).
Eğer bazı dosya adları eklersen
`ls` onları listeler;
ve dizin adları eklersen
onların içeriğini listeler.
Örneğin
`ls /home/repl` başlangıç dizininde neler olduğunu gösterir
(genellikle **home dizini** olarak adlandırılır).

<hr>
`/home/repl/seasonal` dizinindeki dosyaları listelemek için `ls` komutunu uygun bir argümanla kullan
(bu dizin, mevsimlere göre ayrılmış şekilde, tarih bazında diş cerrahisi bilgilerini tutar).
Bu dosyalardan hangisi o dizinde *yoktur*?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
`ls` komutuna bir yol verirsen, o yolun içindekileri gösterir.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Bu dosya `seasonal` dizininde."
correct = "Doğru - bu dosya `seasonal` dizininde *değil*."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Dosya ve dizinleri başka nasıl tanıyabilirim?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Mutlak bir yol, enlem ve boylam gibidir: Nerede olursan ol aynı değeri taşır. **Göreli yol** ise bulunduğun yerden başlayarak bir konumu belirtir: "20 kilometre kuzey" demek gibi.

Örneklere bakalım:
- Eğer `/home/repl` dizinindeysen, **göreli** yol `seasonal`, **mutlak** yol `/home/repl/seasonal` ile aynı dizini belirtir. 
- Eğer `/home/repl/seasonal` dizinindeysen, **göreli** yol `winter.csv`, **mutlak** yol `/home/repl/seasonal/winter.csv` ile aynı dosyayı belirtir.

Kabuk, bir yolun mutlak mı göreli mi olduğuna ilk karakterine bakarak karar verir: `/` ile başlıyorsa mutlak yoldur. `/` ile başlamıyorsa göreli yoldur.

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
`/home/repl` dizinindesin. `/home/repl/course.txt` mutlak yoluna sahip dosyayı (ve yalnızca o dosyayı) listelemek için `ls` komutunu **göreli bir yol** ile kullan.

`@hint`
Çoğunlukla, bulunduğun konumun mutlak yolunu,
ulaşmak istediğin şeyin mutlak yolundan çıkararak
altındaki bir dosya veya dizine giden göreli yolu oluşturabilirsin.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "`ls` komutunu dosya listesini oluşturmak için çağırmadınız."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Komutunuz doğru dosya listesini oluşturmadı. `/home/repl/course.txt`'e göreli bir yol ile `ls` komutunu kullanın.")
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
`/home/repl` dizinindesin.
`/home/repl/seasonal/summer.csv` dosyasını (ve yalnızca o dosyayı) listelemek için
`ls` komutunu **göreli** bir yol ile kullan.

`@hint`
Göreli yollar başında '/' ile BAŞLAMAZ.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "`ls` komutunu dosya listesini oluşturmak için çağırmadınız."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Komutunuz doğru dosya listesini oluşturmadı. `/home/repl/seasonal/summer.csv` konumuna göreli bir yol izleyerek `ls` komutunu kullanın.")
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
`/home/repl` dizinindesin.
`/home/repl/people` dizininin içeriğini listelemek için
`ls` komutunu **göreli** bir yol ile kullan.

`@hint`
Göreli yollar başında '/' ile başlamaz.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "`ls` komutunu dosya listesini oluşturmak için çağırmadınız."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Komutunuz doğru dosya listesini oluşturmadı. `/home/repl/people`'a göreli bir yolun ardından `ls` kullanın.")
    )
)
Ex().success_msg("Tebrikler. Artık dosya ve dizinleri listelemeyi bildiğinize göre, dosya sisteminde nasıl hareket edebileceğinizi görelim!")
```

---

## Başka bir dizine nasıl geçerim?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Dosya gezgininde klasörlere çift tıklayarak nasıl gezinebiliyorsan,
dosyalar sisteminde de `cd` komutunu kullanarak dolaşabilirsin
("change directory" yani dizin değiştir anlamına gelir).

`cd seasonal` yazıp ardından `pwd` yazarsan,
kabuk artık `/home/repl/seasonal` içinde olduğunu söyler.
Sonra `ls` komutunu tek başına çalıştırırsan,
`/home/repl/seasonal` dizininin içeriğini gösterir,
çünkü artık oradasın.
Ev dizinine (`/home/repl`) dönmek istersen,
`cd /home/repl` komutunu kullanabilirsin.

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
Şu anda `/home/repl` konumundasın.
Göreli bir yol kullanarak `/home/repl/seasonal` dizinine geç.

`@hint`
`cd`'nin "change directory" anlamına geldiğini ve göreli yolların başında '/' olmadığını unutma.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Geçerli çalışma dizininiz (bunu `pwd` ile öğrenebilirsiniz) `/home/repl` ise, `cd seasonal` komutuyla `seasonal` klasörüne geçebilirsiniz.")
)
```

***

```yaml
type: ConsoleExercise
key: e69c8eac15
xp: 35
```

`@instructions`
Orada olduğunu kontrol etmek için `pwd` kullan.

`@hint`
Komutu girdikten sonra "enter" ya da "return" tuşuna basmayı unutma.

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
Bu dizinde neler olduğunu görmek için `ls` komutunu herhangi bir yol belirtmeden kullan.

`@hint`
Komuttan sonra "enter" ya da "return" tuşuna basmayı unutma.

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
      has_code('ls', incorrect_msg="Komutunuz doğru çıktıyı üretmedi. Geçerli dizinin içeriğini göstermek için `ls` komutunu herhangi bir yol belirtmeden kullandınız mı?")
    )
)

Ex().success_msg("Harika! Bu, alt dizinlere gitmekle ilgiliydi. Peki ya yukarı çıkmak? Hadi öğrenelim!")
```

---

## Bir dizin yukarı nasıl çıkarım?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

Bir dizinin **ebeveyni**, onun üstündeki dizindir.
Örneğin, `/home`, `/home/repl` dizininin ebeveynidir,
ve `/home/repl`, `/home/repl/seasonal` dizininin ebeveynidir.
Ebeveyn dizininin mutlak yolunu her zaman `cd` ve `ls` gibi komutlara verebilirsin.
Ancak çoğu zaman
özel yol olan `..`'dan
(boşluksuz iki nokta) "şu anda bulunduğum dizinin üstündeki dizin" anlamına geldiği gerçeğinden yararlanırsın.
Eğer `/home/repl/seasonal` içindeysen,
`cd ..` seni `/home/repl` dizinine çıkarır.
`cd ..` komutunu bir kez daha kullanırsan,
bu sefer `/home` dizinine geçersin.
Bir `cd ..` daha seni dosya sisteminin en tepesindeki *kök dizin* `/` konumuna getirir.
(`cd` ile `..` arasında boşluk bırakmayı unutma — bu tek bir dört harfli komut değil, bir komut ve bir yol.)

Tek başına bir nokta, `.`, her zaman "geçerli dizin" anlamına gelir,
dolayısıyla tek başına `ls` ile `ls .` aynı şeyi yapar,
`cd .` ise hiçbir etki yaratmaz
(çünkü şu anda bulunduğun dizine yeniden geçiş yapar).

Son özel yol ise `~` (tilde karakteri),
bu da "ev dizinin" anlamına gelir,
örneğin `/home/repl`.
Nerede olursan ol,
`ls ~` her zaman ev dizininin içeriğini listeler,
ve `cd ~` seni her zaman eve götürür.

<hr>
Eğer `/home/repl/seasonal` içindeysen,
`cd ~/../.` komutu seni nereye götürür?

`@hint`
Yolu, her seferinde bir dizin olacak şekilde takip et.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (kök dizin)

`@feedback`
- Hayır, ama tek başına `~` ya da `..` seni oraya götürürdü.
- Doğru! Yol, 'ev dizini', 'bir seviye yukarı', 'burada' anlamına geliyor.
- Hayır, ama bunu tek başına `.` yapar.
- Hayır, yolun son kısmı `..` ("yukarı" anlamına gelir) değil, `.` ("burada" anlamına gelir).

---

## Dosyaları nasıl kopyalayabilirim?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Çoğu zaman dosyaları kopyalamak,
başka dizinlere taşıyarak düzenlemek
ya da yeniden adlandırmak isteyeceksin.
Bunu yapmak için kullanabileceğin komutlardan biri `cp` ("copy"nin kısaltması).
Eğer `original.txt` mevcut bir dosyaysa,
o zaman:

```{shell}
cp original.txt duplicate.txt
```

`original.txt` dosyasının `duplicate.txt` adlı bir kopyasını oluşturur.
Eğer zaten `duplicate.txt` adında bir dosya varsa,
üzerine yazılır.
Eğer `cp` komutunun son parametresi mevcut bir dizinse,
o halde şu tür bir komut:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

*tüm* dosyaları o dizine kopyalar.

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
`seasonal/summer.csv` dosyasının bir kopyasını `backup` dizinine (bu da `/home/repl` içinde) oluştur
ve yeni dosyanın adını `summer.bck` yap.

`@hint`
Hedef dizinin adını ve kopyalanan dosyanın adını birleştirerek
yeni dosya için göreli bir yol oluştur.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` `backup` dizininde yok gibi görünüyor. `cp`'ye iki yol sağlayın: mevcut dosya (`seasonal/summer.csv`) ve hedef dosya (`backup/summer.bck`)."),
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
Geçerli çalışma dizinini (`/home/repl`) değiştirmeden,
`seasonal` dizinindeki `spring.csv` ve `summer.csv` dosyalarını `backup` dizinine kopyala.

`@hint`
Kopyalamak istediğin dosyaların adlarıyla `cp` komutunu kullan
ve *sonrasında* kopyalanacak dizinin adını yaz.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` dosya `backup` dizinine kopyalanmamış gibi görünüyor. `cp` komutuna iki dosya adı ve bir dizin adı sağlayın."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Dosyaları `{{dir}}` dizinindeyken kopyaladığınızdan emin olun! Oraya geri dönmek için `cd {{dir}}` komutunu kullanın."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("İyi iş. Dosyaları kopyalamanın yanı sıra, bir dizinden diğerine taşımayı da bilmeliyiz. Bir sonraki alıştırmada bunu öğrenin!")
```

---

## Bir dosyayı nasıl taşıyabilirim?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

`cp` bir dosyayı kopyalarken,
`mv` onu bir dizinden diğerine taşır;
sanki grafiksel bir dosya gezgininde sürüklemişsin gibi.
Parametrelerini `cp` ile aynı şekilde ele alır,
bu yüzden şu komut:

```{shell}
mv autumn.csv winter.csv ..
```

`autumn.csv` ve `winter.csv` dosyalarını, geçerli çalışma dizininden
bir seviye yukarıdaki üst dizine taşır
(çünkü `..` her zaman bulunduğun konumun bir üstündeki dizini ifade eder).

`@instructions`
`seasonal` ve `backup` alt dizinlerine sahip `/home/repl` içindesin.
Tek bir komutla, `spring.csv` ve `summer.csv` dosyalarını `seasonal` dizininden `backup` dizinine taşı.

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
backup_patt="`%s` dosyası `backup` dizininde değil. `mv` komutunu doğru kullandınız mı? `mv` komutuna iki dosya adı ve bir dizin adı parametre olarak verin."
seasonal_patt="`%s` dosyası hala `seasonal` dizininde. Dosyaları `cp` ile kopyalamak yerine `mv` ile taşıdığınızdan emin olun!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Tebrikler, bu kabuk eğitimine devam edelim!")
```

---

## Dosyaları nasıl yeniden adlandırabilirim?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` dosyaları yeniden adlandırmak için de kullanılabilir. Şunu çalıştırırsan:

```{shell}
mv course.txt old-course.txt
```

geçerli çalışma dizinindeki `course.txt` dosyası `old-course.txt` dosyasına "taşınır".
Bu, dosya gezginlerinin çalışma biçiminden farklıdır,
amma çoğu zaman kullanışlıdır.

Bir uyarı:
`tıpkı `cp` gibi,
`mv` de mevcut dosyaların üzerine yazar.
Örneğin,
`old-course.txt` adında bir dosyan zaten varsa,
yukarıda gösterilen komut onu `course.txt` içeriğiyle değiştirir.

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
`seasonal` dizinine gir.

`@hint`
`cd` "change directory" (dizini değiştir) anlamına gelir ve göreli yollar başında '/' ile başlamaz, unutma.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Geçerli çalışma dizininiz (bunu `pwd` ile öğrenebilirsiniz) `/home/repl` ise, `cd seasonal` komutuyla `seasonal` klasörüne geçebilirsiniz.")
)
```

***

```yaml
type: ConsoleExercise
key: ed5fe1df23
xp: 35
```

`@instructions`
`winter.csv` dosyasının adını `winter.csv.bck` olarak değiştir.

`@hint`
`mv` komutunu, önce dosyanın mevcut adı sonra vermek istediğin yeni adı gelecek şekilde kullan.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " `mv` komutunu iki argümanla kullanın: yeniden adlandırmak istediğiniz dosya (`winter.csv`) ve dosyanın yeni adı (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Dizinde `winter.csv.bck` bulmayı bekliyorduk." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Dizinde `winter.csv` dosyasını artık beklemiyorduk." + hint)
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
Her şeyin yolunda olduğunu kontrol etmek için `ls` komutunu çalıştır.

`@hint`
Komutu çalıştırmak için "enter" veya "return" tuşuna basmayı unutma.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Geçerli çalışma dizininizin içeriğini listelemek için `ls` kullandınız mı?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Komutunuz doğru dosya listesini oluşturmadı. Geçerli çalışma dizininizin içeriğini listelemek için `ls`'yi argümansız kullanın.")
    )
)
Ex().success_msg("Kopyalama, taşıma, yeniden adlandırma, hepsini çözdünüz! Sırada: dosyaları silmek var.")
```

---

## Dosyaları nasıl silebilirim?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Dosyaları kopyalayabilir ve yerlerini değiştirebiliriz;
silmek içinse
"remove"ın kısaltması olan `rm` komutunu kullanırız.
`tıpkı `cp` ve `mv` gibi,
`rm` komutuna istediğin kadar dosya adı verebilirsin, yani:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

hem `thesis.txt` hem de `backup/thesis-2017-08.txt` dosyalarını siler.

`rm` isminin söylediğini tam olarak ve anında yapar:
grafiksel dosya yöneticilerinin aksine,
kabukta çöp kutusu yoktur,
bu yüzden yukarıdaki komutu yazdığında,
tezin geri dönüşü olmayacak şekilde silinir.

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
Şu anda `/home/repl` dizinindesin.
`seasonal` dizinine gir.

`@hint`
`cd` komutunun "change directory" (dizini değiştir) anlamına geldiğini ve bağıl bir yolun başında '/' olmadığını unutma.

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
`autumn.csv` dosyasını sil.

`@hint`
`rm` komutunun "remove" (sil) anlamına geldiğini unutma.

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="`autumn.csv` dosyasının `seasonal` dizininde hâlâ bulunmasını beklemiyorduk. Kaldırmak istediğiniz dosyanın yolunu belirterek `rm` komutunu kullanın."),
    has_code('rm', incorrect_msg = 'Dosyayı taşımak yerine kaldırmak için `rm` kullanın.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Ana dizinine geri dön.

`@hint`
`cd` komutunu herhangi bir yol belirtmeden kullanırsan, seni ana dizinine götürür.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Ana dizine dönmek için `cd ..` veya `cd ~` komutunu kullanın.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Dizin değiştirmeden `seasonal/summer.csv` dosyasını sil.

`@hint`
`rm` komutunun "remove" (sil) anlamına geldiğini unutma.

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="`summer.csv` dosyasının `seasonal` dizininde hâlâ bulunmasını beklemiyorduk. Kaldırmak istediğiniz dosyanın yolunu belirterek `rm` komutunu kullanın."),
    has_code('rm', incorrect_msg = 'Dosyayı taşımak yerine kaldırmak için `rm` kullanın.')
)
Ex().success_msg("Etkileyici şeyler! Bir sonrakine geçelim!")
```

---

## Dizinleri nasıl oluşturup silebilirim?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv`, dizinlere dosyalarla aynı şekilde davranır:
örneğin, ev dizinindeyken `mv seasonal by-season` çalıştırırsan,
`mv`, `seasonal` dizininin adını `by-season` olarak değiştirir.
Ancak,
`rm` farklı çalışır.

Bir dizini `rm` ile silmeyi denersen,
kabuk bunu yapamayacağını söyleyen bir hata mesajı yazdırır;
bunun başlıca nedeni, yanlışlıkla içinde çalışmalarının olduğu koca bir dizini silmeni önlemektir.
Bunun yerine,
`rmdir` adlı ayrı bir komut kullanabilirsin.
Ek güvenlik için,
`rmdir` yalnızca dizin boşken çalışır;
yani bir dizini silmeden *önce* içindeki dosyaları silmelisin.
(Deneyimli kullanıcılar aynı etkiyi elde etmek için `rm` ile `-r` seçeneğini kullanabilir;
komut seçeneklerini bir sonraki bölümde tartışacağız.)

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
Dizin değiştirmeden,
`people` dizinindeki `agarwal.txt` dosyasını sil.

`@hint`
`rm` komutunun "remove" (kaldır) anlamına geldiğini ve bağıl bir yolun başında '/' olmadığını unutma.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` artık `/home/repl/people` dizininde olmamalıdır. `rm` komutunu doğru kullandınız mı?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = '`people` dizininde hala dosyalar var. Eğer sadece `agarwal.txt` dosyasını taşıdıysanız veya yeni dosyalar oluşturduysanız, hepsini silin.')
)

```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
`people` dizini artık boş olduğuna göre,
tek bir komutla onu sil.

`@hint`
`rm` yalnızca dosyalarda çalışır, bunu unutma.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "'people' dizini artık ana dizininizde olmamalıdır. Onu kaldırmak için `rmdir` komutunu kullanın!")
)

```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Bir dizin dosya değildir,
bu yüzden yeni (boş) bir dizin oluşturmak için
`mkdir directory_name` komutunu kullanmalısın.
Bu komutla, ev dizininin altında `yearly` adında yeni bir dizin oluştur.

`@hint`
Oluşturmak istediğin dizinin adıyla `mkdir` çalıştır.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Ev dizininizde `yearly` adlı bir dizin yok. Bir tane oluşturmak için `mkdir yearly` komutunu kullanın!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Artık `yearly` var olduğuna göre,
evin­den ayrılmadan `yearly` içinde `2017` adlı bir dizin daha oluştur.

`@hint`
Oluşturmak istediğin alt dizin için bağıl bir yol kullan.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="'/home/repl/yearly' dizininde bir '2017' dizini bulunamıyor. Bu dizini `yearly/2017` göreli yolunu kullanarak oluşturabilirsiniz.")
)
Ex().success_msg("Harika! Bu bölümü, bazı kavramlarını tekrarlayan bir alıştırma ile tamamlayalım!")
```

---

## Kapanış

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Veri analiz ederken sık sık ara dosyalar oluşturursun.
Bunları ana dizininde saklamak yerine
`/tmp` içine koyabilirsin;
insanlar ve programlar genelde kısa süreli ihtiyaç duydukları dosyaları burada tutar.
(Dikkat: `/tmp`, kök dizin `/` altında yer alır,
ev dizininin altında değildir.)
Bu kapanış egzersizi, bunu nasıl yapacağını gösterecek.

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
`cd` kullanarak `/tmp` içine git.

`@hint`
`cd` "change directory" (dizin değiştir) anlamına gelir ve mutlak bir yol '/' ile başlar, bunu unutma.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Yanlış dizindesiniz. Dizini `/tmp` olarak değiştirmek için `cd` komutunu kullanın.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Bir dizin adı yazmadan `/tmp` içeriğini listele.

`@hint`
`ls`'e neyi listeleyeceğini söylemezsen, geçerli dizinindeki içerikleri gösterir.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "`ls` komutunu dosya listesini oluşturmak için çağırmadınız."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Komutunuz doğru dosya listesini oluşturmadı. `ls` komutunu kullanın.")
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
`/tmp` içinde `scratch` adlı yeni bir dizin oluştur.

`@hint`
Dizin oluşturmak için `mkdir` kullan.

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
      has_code('mkdir +scratch', incorrect_msg="'/tmp' altında bir 'scratch' dizini bulunamıyor. `mkdir` komutunu doğru kullandığınızdan emin olun.")
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
`/home/repl/people/agarwal.txt` dosyasını `/tmp/scratch` içine taşı.
Ev dizinin için `~` kısayolunu ve ikincisi için mutlak yol yerine göreli bir yol kullanmanı öneririz.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="'/tmp/scratch' içinde 'agarwal.txt' bulunamıyor. İlk parametre olarak `~/people/agarwal.txt` ve ikinci olarak `scratch` ile `mv` kullanın.")
)
Ex().success_msg("Bu, Kabuk Girişine Giriş'in 1. Bölümünü tamamlar! Verileri manipüle etmeyi öğrenmek için bir sonraki bölüme geçin!")
```

---
title: Yeni araçlar oluşturma
description: >-
  Geçmiş, yalnızca birkaç tuşla işlemleri tekrarlamana; boru hatları ise mevcut
  komutları birleştirerek yenilerini oluşturmana olanak tanır. Bu bölümde, bir
  adım daha ileri gidip kendi komutlarını nasıl yaratacağını göreceksin.
lessons:
  - nb_of_exercises: 9
    title: Bir dosyayı nasıl düzenleyebilirim?
---

## Bir dosyayı nasıl düzenlerim?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix'in akıl karıştırıcı sayıda metin düzenleyicisi vardır.
Bu derste
Nano adlı basit bir düzenleyici kullanacağız.
`nano filename` yazarsan,
`filename` dosyasını düzenlemek için açar
(ve eğer yoksa oluşturur).
Ok tuşlarıyla dolaşabilirsin,
backspace ile karakter silebilirsin
ve kontrol tuşu kombinasyonlarıyla başka işlemler yapabilirsin:

- `Ctrl` + `K`: bir satırı siler.
- `Ctrl` + `U`: bir satırı geri getirir (undo).
- `Ctrl` + `O`: dosyayı kaydeder ('O', 'output' anlamına gelir). _Dosya adını onaylamak için Enter'a basman gerektiğini unutma!_
- `Ctrl` + `X`: düzenleyiciden çıkar.

`@instructions`
Ev dizininde yeni bir dosyayı düzenlemek için `nano names.txt` komutunu çalıştır
ve aşağıdaki dört satırı gir:

```
Lovelace
Hopper
Johnson
Wilson
```

Yazdıklarını kaydetmek için,
`Ctrl` + `O` ile dosyayı yazdır (kaydet),
sonra dosya adını onaylamak için Enter'a bas,
son olarak düzenleyiciden çıkmak için `Ctrl` + `X` tuşlarını kullan.

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
patt = "Dosya `names.txt` içinde `%s` satırını eklediniz mi? Dosyanızı güncellemek için tekrar `nano names.txt` kullanın. Kaydetmek için `Ctrl` + `O` ve çıkmak için `Ctrl` + `X` kullanın."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Tebrikler! Bir sonrakine geçelim!")
```

---

## Az önce yaptıklarımı nasıl kaydedebilirim?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Karmaşık bir analiz yaparken,
çoğu zaman kullandığın komutların kaydını tutmak istersin.
Bunu, daha önce gördüğün araçlarla yapabilirsin:

1. `history` çalıştır.
2. Çıktısını, kaydetmek istediğin son adım sayısına göre `tail -n 10` komutuna pipe et.
3. Bunu `figure-5.history` gibi isimlendirilmiş bir dosyaya yönlendir.

Bu yöntem, bir laboratuvar defterine not almaktan daha iyidir
çünkü hiçbir adımı atlamadığından emin olursun.
Ayrıca kabuğun temel fikrini de gösterir:
metin satırları üreten ve tüketen basit araçlar
çok çeşitli şekillerde birleştirilebilir
ve geniş bir yelpazedeki sorunları çözebilir.

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
`seasonal/spring.csv` ve `seasonal/summer.csv` dosyalarını ana dizinine kopyala.

`@hint`
Kopyalamak için `cp` kullan ve ana dizinine giden yol için kısayol olarak `~` yaz.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Gerekli dosyaları ana dizininize kopyalamak için `cp seasonal/s* ~` komutunu kullandınız mı?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Olağanüstü kayıt tutma! Herhangi bir komutu yanlış yazdıysanız, daha sonra `nano` kullanarak kayıt geçmişi dosyasını temizleyebilirsiniz.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
`grep` komutunu `-h` bayrağıyla (dosya adlarını yazdırmasını engellemek için)
ve `-v Tooth` ile (başlık satırıyla eşleşmeyen satırları seçmek için)
`spring.csv` ve `summer.csv` dosyalarındaki veri kayıtlarını bu sırayla seçmek üzere kullan
ve çıktıyı `temp.csv` dosyasına yönlendir.

`@hint`
Bayrakları dosya adlarından önce koy.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Girdi ve çıktıyı `>` ile `grep` komutunun `temp.csv` dosyasına yönlendirdiğinizden emin olun!"
msg2 = "`temp.csv` dosyasını doldurmak için `grep -h -v ___ ___ ___` (boşlukları doldurun) kullandınız mı?"
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
Son üç komutu bir dosyaya kaydetmek için `history` çıktısını `tail -n 3` komutuna pipe et
ve çıktıyı `steps.txt` dosyasına yönlendir.
(`history` komutunun kendisi de listede olacağı için
sadece iki yerine üç komutu kaydetmen gerekir.)

`@hint`
`>` ile yönlendirme, pipe'lanan komutlar dizisinin sonunda yer alır, bunu unutma.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Komutunuzun çıktısını `steps.txt` dosyasına yönlendirdiğinizden emin olun."
msg2="`steps.txt` dosyasını doldurmak için `history | tail ___ ___` (boşlukları doldurun) kullandınız mı?"
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
Ex().success_msg("Tebrikler! Bir üst seviyeye çıkalım!")
```

---

## Komutları daha sonra tekrar çalıştırmak için nasıl kaydedebilirim?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Şimdiye kadar kabuğu etkileşimli olarak kullandın.
Ama yazdığın komutlar sadece metin olduğundan,
onları kabuğun tekrar tekrar çalıştırması için dosyalara kaydedebilirsin.
Bu güçlü özelliği keşfetmeye başlamak için,
aşağıdaki komutu `headers.sh` adlı bir dosyaya koy:

```{shell}
head -n 1 seasonal/*.csv
```

Bu komut, `seasonal` dizinindeki her bir CSV dosyasının ilk satırını seçer.
Bu dosyayı oluşturduktan sonra,
şunu yazarak çalıştırabilirsin:

```{shell}
bash headers.sh
```

Bu, kabuğa (aslında `bash` adlı bir programdır)
`headers.sh` dosyasındaki komutları çalıştırmasını söyler
ve komutları doğrudan çalıştırmakla aynı çıktıyı üretir.

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
`dates.sh` adlı bir dosya oluşturmak için `nano dates.sh` kullan
ve şu komutu içersin:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

böylece `seasonal` içindeki tüm CSV dosyalarının ilk sütununu çıkar.

`@hint`
Gösterilen komutları dosyaya fazladan boş satır veya boşluk eklemeden koy.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "`cut -d , -f 1 seasonal/*.csv` satırını `dates.sh` dosyasına eklediniz mi? Dosyanızı güncellemek için tekrar `nano dates.sh` kullanın. Kaydetmek için `Ctrl` + `O` ve çıkmak için `Ctrl` + `X` kullanın."
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
`dates.sh` dosyasını çalıştırmak için `bash` kullan.

`@hint`
Dosyayı çalıştırmak için `bash filename` kullan.

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
      has_code("bash", incorrect_msg = '`bash` komutunu çağırdınız mı?'),
      has_code("dates.sh", incorrect_msg = '`dates.sh` dosyasını belirttiniz mi?')
    )
  )
)

```

---

## Boru hatlarını yeniden nasıl kullanabilirim?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Kabuk komutlarıyla dolu bir dosyaya ***kabuk betiği (shell script)** denir,
veya kısaca "betik". Betiklerin adlarının `.sh` ile bitmesi şart değildir,
amma bu derste hangi dosyaların betik olduğunu takip etmene yardım etmesi için
bu geleneği kullanacağız.

Betikler boru hatları da içerebilir.
Örneğin,
`all-dates.sh` şu satırı içeriyorsa:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

şu komut:

```{shell}
bash all-dates.sh > dates.out
```

mevsimsel veri dosyalarından benzersiz tarihleri çıkarır
ve bunları `dates.out` içine kaydeder.

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
Ev dizininde `teeth.sh` adlı bir dosya senin için hazırlandı ama bazı boşluklar içeriyor.
Nano ile dosyayı düzenle ve iki `____` yer tutucusunu
`seasonal/*.csv` ve `-c` ile değiştir ki bu betik `seasonal` dizinindeki CSV dosyalarında
her bir diş adının kaç kez göründüğünün sayımını yazdırsın.

`@hint`
Dosyayı düzenlemek için `nano teeth.sh` kullan.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="`teeth.sh` dosyasındaki komutun `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c` şeklinde okunabilmesi için boşlukları doğru bir şekilde değiştirdiniz mi? Gerekli değişiklikleri yapmak için tekrar `nano teeth.sh` kullanın."
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
`bash` kullanarak `teeth.sh` betiğini çalıştır ve çıktısını `>` ile `teeth.out` dosyasına yönlendir.

`@hint`
Unutma, `> teeth.out` çıktıyı üreten komuttan *sonra* gelmelidir.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="`bash teeth.sh` komutunun çıktısını `>` ile `teeth.out` dosyasına doğru bir şekilde yönlendirdiniz mi?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = '`bash` komutunu çağırdınız mı?'),
      has_code("bash\s+teeth.sh", incorrect_msg = '`teeth.sh` dosyasını çalıştırdınız mı?'),
      has_code(">\s+teeth.out", incorrect_msg = '`teeth.out` dosyasına yönlendirdiniz mi?')
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
Sonuçlarını incelemek için `cat teeth.out` çalıştır.

`@hint`
Unutma, bir dosya adının ilk birkaç harfini yazıp sekme tuşuna basarak otomatik tamamlayabilirsin.

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
      has_code("cat", incorrect_msg = '`cat` komutunu çağırdınız mı?'),
      has_code("teeth.out", incorrect_msg = '`teeth.out` dosyasını belirttiniz mi?')
    )
  )
)
Ex().success_msg("Güzel! Bu başlangıçta yapay gelebilir, ancak güzel olan şey, iş akışınızın parçalarını adım adım otomatikleştiriyor olmanızdır. Bir veri bilimci olarak gerçekten işe yarayan bir şey!")
```

---

## Dosya adlarını betiklere nasıl iletebilirim?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Belirli dosyaları işleyen bir betik, yaptıklarının kaydı için kullanışlıdır; ancak istediğin herhangi bir dosyayı işlemeni sağlayan bir betik çok daha kullanışlıdır.
Bunu desteklemek için,
`$@` (dolar işaretini hemen izleyen at işareti) adlı özel ifadeyi kullanarak
"betiğe verilen tüm komut satırı parametreleri"ni belirtebilirsin.

Örneğin, `unique-lines.sh` içinde `sort $@ | uniq` varsa ve şunu çalıştırırsan:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

kabuk `$@` ifadesini `seasonal/summer.csv` ile değiştirir ve tek dosyayı işler. Şunu çalıştırırsan:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

iki veri dosyasını işler ve bu böyle devam eder.

_Hatırlatma: Nano'da yazdıklarını kaydetmek için `Ctrl` + `O` tuşlarına bas, dosya adını onaylamak için Enter'a bas, ardından düzenleyiciden çıkmak için `Ctrl` + `X` tuşlarına bas._

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
`count-records.sh` betiğini Nano ile düzenle ve iki `____` yer tutucusunu sırasıyla `$@` ve `-l` (_harf olan_) ile doldur ki, bir veya daha fazla dosyadaki satır sayısını, her dosyanın ilk satırını hariç tutarak saysın.

`@hint`
* Dosya adını düzenlemek için `nano count-records.sh` kullan.
* Sayı bir değil, _harf_ olan `-l` seçeneğini belirttiğinden emin ol.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Boşlukları doğru bir şekilde değiştirerek `count-records.sh` komutunun `tail -q -n +2 $@ | wc -l` şeklinde okunmasını sağladınız mı? Gerekli değişiklikleri yapmak için tekrar `nano count-records.sh` kullanın."
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
`count-records.sh` betiğini `seasonal/*.csv` üzerinde çalıştır
ve çıktıyı `>` kullanarak `num-records.out` dosyasına yönlendir.

`@hint`
Çıktıyı yönlendirmek için `>` kullan.

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
      has_code("bash", incorrect_msg = '`bash` komutunu çağırdınız mı?'),
      has_code("bash\s+count-records.sh", incorrect_msg = '`count-records.sh` dosyasını çalıştırdınız mı?'),
      has_code("seasonal/\*", incorrect_msg = '`seasonal/*` ile işlenecek dosyaları belirttiniz mi?'),
      has_code(">\s+num-records.out", incorrect_msg = '`num-records.out` dosyasına yönlendirdiniz mi?')
    )
  )
)
Ex().success_msg("Tebrikler! Kabuk gücünüz sürekli genişliyor!")
```

---

## Tek bir argümanı nasıl işleyebilirim?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

`$@`'ın yanı sıra,
shell belirli komut satırı parametrelerine başvurmak için `$1`, `$2` gibi değişkenleri kullanmana izin verir.
Bunu, shell'inkinden daha basit veya daha doğal hissedilen komutlar yazmak için kullanabilirsin.
Örneğin,
kullanıcı birinci parametre olarak dosya adını, ikinci parametre olarak da sütunu verdiğinde
bir CSV dosyasından tek bir sütun seçen `column.sh` adlı bir betik oluşturabilirsin:

```{shell}
cut -d , -f $2 $1
```

ve ardından bunu şu şekilde çalıştırırsın:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Betikte iki parametrenin ters sırayla kullanıldığına dikkat et.

<hr>

`get-field.sh` betiğinin bir dosya adı,
seçilecek satırın numarası,
seçilecek sütunun numarasını alması
ve bir CSV dosyasından yalnızca o alanı yazdırması gerekiyor.
Örneğin:

```
bash get-field.sh seasonal/summer.csv 4 2
```

`seasonal/summer.csv` dosyasının 4. satırından 2. alanı seçmelidir.
Bunu yapmak için `get-field.sh` içine aşağıdaki komutlardan hangisi konulmalıdır?

`@hint`
Komut satırı parametrelerinin soldan sağa doğru numaralandırıldığını unutma.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Hayır: bu, dosya adını `head` ile seçilecek satır sayısı olarak kullanmaya çalışır.
- Doğru!
- Hayır: bu, sütun numarasını satır numarası ve tersini de tam tersi olarak kullanmaya çalışır.
- Hayır: bu, alan numarasını dosya adı ve tersini de dosya adı olarak kullanır.

---

## Bir kabuk betiği nasıl birçok şey yapabilir?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Şimdiye kadar kabuk betiklerimiz tek bir komut veya boru içeriyordu, ancak bir betik birden fazla komut satırı barındırabilir. Örneğin, veri dosyalarının en kısası ve en uzunu içinde kaç kayıt olduğunu, yani veri kümelerinin uzunluk aralığını söyleyen bir betik yazabilirsin.

Unutma: Nano'da "kopyala-yapıştır" yapmak için kopyalamak istediğin satıra git, `CTRL` + `K` ile satırı kes, ardından iki kopyasını yapıştırmak için `CTRL` + `U`'ya iki kez bas.

_Hatırlatma olarak, Nano'da yazdıklarını kaydetmek için `Ctrl` + `O` ile dosyayı yazdır, dosya adını onaylamak için Enter'a bas, ardından düzenleyiciden çıkmak için `Ctrl` + `X` tuşlarına bas._

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
Nano ile `range.sh` betiğini düzenle
ve iki `____` yer tutucusunu
`$@` ve `-v` ile değiştir
böylece komut satırında verilen tüm dosyaların adlarını ve satır sayılarını listelesin
tüm dosyaların toplam satır sayısını göstermeden.
(Dosyaların sütun başlıklarını çıkarmaya çalışma.)

`@hint`
Komut satırında verilen tüm dosyalardaki satırları saymak için `wc -l $@` kullan.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="`range.sh` dosyasındaki komutun `wc -l $@ | grep -v total` şeklinde okunabilmesi için boşlukları doğru bir şekilde değiştirdiniz mi? Gerekli değişiklikleri yapmak için tekrar `nano range.sh` kullanın."
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
Nano'yu tekrar kullanarak `range.sh` içindeki boru hattına sırasıyla `sort -n` ve `head -n 1` ekle,
ona verilen en kısa dosyanın adını ve satır sayısını göstermek için.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="`sort -n` ve `head -n 1` komutlarını `range.sh` dosyasına boru operatörleriyle eklediniz mi? Gerekli değişiklikleri yapmak için `nano range.sh` komutunu tekrar kullanın."
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
Yine Nano'yu kullanarak, dizindeki *en uzun* dosyanın adını ve kayıt sayısını da
en kısa olanla birlikte yazdırmak için `range.sh` dosyasına ikinci bir satır ekle.
Bu satır, daha önce yazdığın satırın aynısı olmalı,
amma `sort -n` yerine `sort -n -r` kullanılmalı.

`@hint`
İlk satırı kopyala ve sıralama düzenini değiştir.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="`range.sh` dosyasındaki ilk satırı koruyun: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="`range.sh` dosyasındaki ilk satırı kopyalayıp küçük bir değişiklik yaptınız mı? `sort -n` yerine `sort -n -r`!"
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
`seasonal` dizinindeki dosyalar üzerinde betiği çalıştır,
tüm dosyaları eşleştirmek için `seasonal/*.csv` kullan
ve çıktıyı `>` ile
ana dizinindeki `range.out` adlı dosyaya yönlendir.

`@hint`
Betikini çalıştırmak için `bash range.sh` kullan, dosyaları belirtmek için `seasonal/*.csv` yaz ve çıktıyı yönlendirmek için `> range.out` kullan.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="`bash range.sh seasonal/*.csv` komutunun çıktısını `>` ile `range.out` dosyasına doğru bir şekilde yönlendirdiniz mi?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = '`bash` komutunu çağırdınız mı?'),
has_code("bash\s+range.sh", incorrect_msg = '`range.sh` dosyasını çalıştırdınız mı?'),
has_code("seasonal/\*", incorrect_msg = '`seasonal/*` ile işlenecek dosyaları belirttiniz mi?'),
has_code(">\s+range.out", incorrect_msg = '`range.out` dosyasına yönlendirdiniz mi?')
)
)

Ex().success_msg("Her şey yolunda gidiyor. Döngü yazmayı öğrenmek için bir sonraki alıştırmaya geçin!")
```

---

## Kabuk betiğinde döngüleri nasıl yazarım?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Kabuk betikleri döngüler de içerebilir. Döngüleri noktalı virgülle yazabilir ya da daha okunaklı olması için noktalı virgül olmadan satırlara bölebilirsin:

```{shell}
# Her dosyanın ilk ve son veri kaydını yazdır.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Döngünün içindeki komutları girintilemek zorunda değilsin, ama böyle yapmak işleri daha anlaşılır kılar.)

Bu betiğin ilk satırı, betiğin ne yaptığını okura anlatan bir **yorum**dur. Yorumlar `#` karakteriyle başlar ve satırın sonuna kadar devam eder. Buradaki gibi kısa açıklamaları yazdığın her betiğe eklersen gelecekteki kendin sana teşekkür eder.

_Hatırlatma olarak, Nano'da yazdıklarını kaydetmek için dosyayı yazdırmak üzere `Ctrl` + `O` tuşlarına bas, sonra dosya adını onaylamak için Enter'a bas, ardından editörden çıkmak için `Ctrl` + `X` tuşlarına bas._

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
`date-range.sh` betiğindeki yer tutucuları
`$filename` (iki kez), `head` ve `tail` ile doldur
ki bir veya daha fazla dosyadan ilk ve son tarihi yazdırsın.

`@hint`
Döngü değişkeninin geçerli değerini almak için `$filename` kullanmayı unutma.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="`date-range.sh` dosyasında, döngüdeki %s satırını `%s` olacak şekilde değiştirdiniz mi? Değişiklik yapmak için `nano date-range.sh` kullanın."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('ilk', cmdpatt%'head')
msg2=msgpatt%('ikinci', cmdpatt%'tail')
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
Dört mevsimsel veri dosyasının tümünde `date-range.sh` betiğini çalıştır;
adlarını eşleştirmek için `seasonal/*.csv` kullan.

`@hint`
Joker ifade dizin adıyla başlamalı.

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
      has_code("bash", incorrect_msg = '`bash` komutunu çağırdınız mı?'),
      has_code("bash\s+date-range.sh", incorrect_msg = '`date-range.sh` dosyasını çalıştırdınız mı?'),
      has_code("seasonal/\*", incorrect_msg = '`seasonal/*` ile işlenecek dosyaları belirttiniz mi?')
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
Dört mevsimsel veri dosyasının tümünde `seasonal/*.csv` kullanarak `date-range.sh` betiğini çalıştır
ve çıktısını `sort` komutuna aktar; böylece betiklerinin Unix'in yerleşik komutları gibi kullanılabildiğini gör.

`@hint`
Az önce kullandığın aynı joker ifadeyi kullan.

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
      has_code("bash", incorrect_msg = '`bash` komutunu çağırdınız mı?'),
      has_code("bash\s+date-range.sh", incorrect_msg = '`date-range.sh` dosyasını çalıştırdınız mı?'),
      has_code("seasonal/\*", incorrect_msg = '`seasonal/*` ile işlenecek dosyaları belirttiniz mi?'),
      has_code("|", incorrect_msg = 'Komut dosyası çıktısını `sort` ile birleştirdiniz mi?'),
      has_code("sort", incorrect_msg = '`sort` komutunu çağırdınız mı?')
    )
  )
)
Ex().success_msg("Harika! Öğrendiğimiz tüm şeylerin ne kadar birleştirilebilir olduğuna dikkat edin.")
```

---

## Dosya adı vermezsem ne olur?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Kabuk betiklerinde (ve etkileşimli komutlarda) sık yapılan bir hata, dosya adlarını yanlış yere koymaktır.
Eğer şunu yazarsan:

```{shell}
tail -n 3
```

`tail` hiçbir dosya adı almadığı için
klavyeden girdi bekler.
Bu da şu anlama gelir: Eğer şunu yazarsan:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

`tail` gidip `somefile.txt` dosyasının son üç satırını yazdırır,
amma `head` bir dosya adı almadığından ve boru hattında onun önünde bir şey olmadığından
klavye girdisini sonsuza kadar bekler.

<hr>

Diyelim ki yanlışlıkla şunu yazdın:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Şimdi ne yapmalısın?

`@possible_answers`
- `head` zaman aşımına uğrasın diye 10 saniye bekle.
- `head`'e biraz girdi vermek için `somefile.txt` yazıp Enter'a bas.
- Çalışan `head` programını durdurmak için `Ctrl` + `C` kullan.

`@hint`
`head` bir dosya adı almazsa ve öncesinde (upstream) hiçbir şey yoksa ne yapar?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Hayır, komutlar zaman aşımına uğramayacak.'
a2 = 'Hayır, bu `head` komutuna işlemek için `somefile.txt` metnini verecek, ancak daha fazla girdi beklerken takılıp kalacaktır.'
a3 = "Evet! Çalışan bir programı durdurmak için `Ctrl` + `C` kullanmalısınız. Bu, bu giriş kursunu tamamlar! Daha fazla komut satırı aracı öğrenmekle ilgileniyorsanız, ücretsiz Git giriş kursumuzu şiddetle tavsiye ederiz!"
Ex().has_chosen(3, [a1, a2, a3])
```

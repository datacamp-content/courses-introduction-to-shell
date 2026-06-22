---
title: नए टूल बनाना
description: >-
  History आपको कुछ ही कीस्ट्रोक्स में काम दोहराने देती है, और pipes मौजूदा
  कमांड्स को जोड़कर नए समाधान बनाने में मदद करती हैं। इस चैप्टर में आप एक कदम
  आगे बढ़ेंगे और अपने खुद के नए कमांड्स बनाना सीखेंगे.
lessons:
  - nb_of_exercises: 9
    title: मैं किसी फाइल को कैसे एडिट कर सकता/सकती हूँ?
---

## मैं किसी फ़ाइल को कैसे एडिट कर सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix में टेक्स्ट एडिटर की किस्में इतनी ज़्यादा हैं कि चुनना मुश्किल हो सकता है.
इस कोर्स में हम एक आसान एडिटर Nano इस्तेमाल करेंगे.
यदि आप `nano filename` टाइप करते हैं,
तो यह `filename` को एडिट करने के लिए खोलेगा
(या अगर वह मौजूद नहीं है तो इसे बना देगा).
आप एरो कीज़ से इधर-उधर जा सकते हैं,
बैकस्पेस से अक्षर डिलीट कर सकते हैं,
और कंट्रोल-की कॉम्बिनेशन से अन्य ऑपरेशन कर सकते हैं:

- `Ctrl` + `K`: पूरी लाइन डिलीट करें.
- `Ctrl` + `U`: डिलीट की गई लाइन वापस लाएँ.
- `Ctrl` + `O`: फ़ाइल सेव करें ('O' का मतलब 'output'). _फ़ाइलनाम कन्फर्म करने के लिए आपको Enter भी दबाना होगा!_
- `Ctrl` + `X`: एडिटर से बाहर निकलें.

`@instructions`
अपने होम डायरेक्टरी में नई फ़ाइल एडिट करने के लिए `nano names.txt` चलाएँ
और नीचे दी गई चार पंक्तियाँ दर्ज करें:

```
Lovelace
Hopper
Johnson
Wilson
```

जो आपने लिखा है उसे सेव करने के लिए,
फ़ाइल लिखने (सेव) के लिए `Ctrl` + `O` टाइप करें,
फिर फ़ाइलनाम कन्फर्म करने के लिए Enter दबाएँ,
फिर एडिटर से बाहर निकलने के लिए `Ctrl` + `X` दबाएँ.

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
patt = "क्या आपने `names.txt` फ़ाइल में `%s` पंक्ति शामिल की है? अपनी फ़ाइल को अपडेट करने के लिए फिर से `nano names.txt` का उपयोग करें। सहेजने के लिए `Ctrl` + `O` और बाहर निकलने के लिए `Ctrl` + `X` का उपयोग करें।"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("बहुत बढ़िया! अगले पर चलते हैं!")
```

---

## मैंने अभी जो किया, उसे कैसे रिकॉर्ड कर सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

जब आप कोई जटिल विश्लेषण कर रहे हों,
तो आप अक्सर उपयोग किए गए commands का रिकॉर्ड रखना चाहेंगे।
आप यह उन tools से कर सकते हैं जिन्हें आप पहले देख चुके हैं:

1. `history` चलाएँ।
2. उसके आउटपुट को `tail -n 10` में pipe करें (या जितने हाल के steps आप सहेजना चाहें)।
3. उसे `figure-5.history` जैसे किसी फ़ाइल नाम में redirect करें।

यह लैब नोटबुक में चीजें लिखने से बेहतर है,
क्योंकि इसमें किसी भी step के छूट जाने की गुंजाइश नहीं रहती।
यह shell के केंद्रीय विचार को भी दर्शाता है:
ऐसे सरल tools जो टेक्स्ट की पंक्तियाँ बनाते और पढ़ते हैं,
उन्हें कई तरीकों से जोड़कर
विभिन्न प्रकार की समस्याएँ हल की जा सकती हैं।

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
फ़ाइलें `seasonal/spring.csv` और `seasonal/summer.csv` को अपने home directory में कॉपी करें।

`@hint`
कॉपी करने के लिए `cp` का उपयोग करें और अपने home directory के path के शॉर्टकट के रूप में `~` लिखें।

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="क्या आपने आवश्यक फ़ाइलों को अपनी होम डायरेक्टरी में कॉपी करने के लिए `cp seasonal/s* ~` का उपयोग किया है?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("उल्लेखनीय रिकॉर्ड-कीपिंग! यदि आपने कोई कमांड गलत टाइप किया है, तो आप हमेशा बाद में `nano` का उपयोग करके सेव्स हिस्ट्री फ़ाइल को साफ़ कर सकते हैं।")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
`grep` को `-h` flag के साथ उपयोग करें (ताकि यह filenames प्रिंट न करे)
और `-v Tooth` (ताकि वह header line से मेल खाने वाली पंक्तियों को छोड़ दे)
ताकि उसी क्रम में `spring.csv` और `summer.csv` से data records चुनें
और आउटपुट को `temp.csv` में redirect कर दें।

`@hint`
flags को filenames से पहले रखें।

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "सुनिश्चित करें कि आपने `grep` कमांड के आउटपुट को `>` के साथ `temp.csv` में पुनर्निर्देशित किया है!"
msg2 = "क्या आपने `grep -h -v ___ ___ ___` (रिक्त स्थान भरें) का उपयोग `temp.csv` को भरने के लिए किया है?"
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
`history` को `tail -n 3` में pipe करें
और आउटपुट को `steps.txt` में redirect करें
ताकि पिछली तीन commands एक फ़ाइल में सेव हो जाएँ।
(आपको केवल दो के बजाय तीन सेव करनी होंगी,
क्योंकि `history` command खुद भी सूची में होगी।)

`@hint`
याद रखें, `>` के साथ redirection piped commands की sequence के अंत में आता है।

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="सुनिश्चित करें कि अपने कमांड के आउटपुट को `steps.txt` में पुनर्निर्देशित करें।"
msg2="क्या आपने `history | tail ___ ___` (रिक्त स्थान भरें) का उपयोग `steps.txt` को भरने के लिए किया है?"
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
Ex().success_msg("बहुत बढ़िया! चलिए इसे और बेहतर बनाते हैं!")
```

---

## मैं कमांड्स को बाद में दोबारा चलाने के लिए कैसे सेव कर सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

अब तक आप शेल को इंटरैक्टिव तरीके से इस्तेमाल कर रहे हैं.
लेकिन आपने जो कमांड्स टाइप किए हैं, वे सिर्फ टेक्स्ट हैं,
इसलिए आप उन्हें फाइलों में सेव कर सकते हैं ताकि शेल उन्हें बार-बार चला सके.
इस शक्तिशाली क्षमता का पता लगाना शुरू करने के लिए,
निम्न कमांड को `headers.sh` नाम की एक फाइल में डालिए:

```{shell}
head -n 1 seasonal/*.csv
```

यह कमांड `seasonal` डायरेक्टरी में मौजूद हर CSV फाइल की पहली पंक्ति चुनती है.
जैसे ही आप यह फाइल बना लें,
आप इसे टाइप करके चला सकते हैं:

```{shell}
bash headers.sh
```

यह शेल को बताता है (जो कि `bash` नाम का एक प्रोग्राम है)
कि वह फाइल `headers.sh` में लिखी कमांड्स चलाए,
जिससे वही आउटपुट मिलता है जो कमांड्स को सीधे चलाने पर मिलता है.

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
`nano dates.sh` का उपयोग करके `dates.sh` नाम की फाइल बनाएँ
जिसमें यह कमांड हो:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

ताकि `seasonal` की सभी CSV फाइलों से पहली कॉलम निकाली जा सके.

`@hint`
दिए गए कमांड्स को बिना अतिरिक्त खाली लाइनों या स्पेसेज़ के फाइल में डालें.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "क्या आपने `dates.sh` फ़ाइल में `cut -d , -f 1 seasonal/*.csv` पंक्ति शामिल की है? अपने फ़ाइल को अपडेट करने के लिए फिर से `nano dates.sh` का उपयोग करें। सहेजने के लिए `Ctrl` + `O` और बाहर निकलने के लिए `Ctrl` + `X` का उपयोग करें।"
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
`bash` का उपयोग करके `dates.sh` फाइल चलाएँ.

`@hint`
फाइल चलाने के लिए `bash filename` का उपयोग करें.

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
      has_code("bash", incorrect_msg = 'क्या आपने `bash` को कॉल किया?'),
      has_code("dates.sh", incorrect_msg = 'क्या आपने `dates.sh` फ़ाइल निर्दिष्ट की?')
    )
  )
)

```

---

## मैं पाइप्स को दोबारा कैसे इस्तेमाल कर सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

शेल कमांड्स से भरी फ़ाइल को ***shell script** कहा जाता है,
या संक्षेप में सिर्फ़ "script" भी कहते हैं। स्क्रिप्ट्स के नाम का अंत `.sh` से होना ज़रूरी नहीं है,
लेकिन इस लेसन में हम वही परंपरा अपनाएँगे
ताकि आप यह ट्रैक रख सकें कि कौन-सी फ़ाइलें स्क्रिप्ट्स हैं।

स्क्रिप्ट्स में पाइप्स भी हो सकते हैं।
उदाहरण के लिए,
अगर `all-dates.sh` में यह लाइन हो:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

तो:

```{shell}
bash all-dates.sh > dates.out
```

सीज़नल डेटा फ़ाइलों से यूनिक तारीख़ें निकालेगा
और उन्हें `dates.out` में सेव करेगा।

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
आपके होम डायरेक्टरी में `teeth.sh` नाम की फ़ाइल आपके लिए तैयार है, लेकिन उसमें कुछ खाली जगहें हैं।
Nano का उपयोग करके फ़ाइल एडिट कीजिए और दो `____` placeholders को
`seasonal/*.csv` और `-c` से बदल दीजिए ताकि यह स्क्रिप्ट `seasonal` डायरेक्टरी की CSV फ़ाइलों में
हर दाँत के नाम के आने की संख्या की गिनती प्रिंट करे।

`@hint`
फ़ाइल एडिट करने के लिए `nano teeth.sh` चलाएँ।

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="क्या आपने रिक्त स्थानों को सही ढंग से प्रतिस्थापित किया है ताकि `teeth.sh` में कमांड `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c` पढ़े? आवश्यक परिवर्तन करने के लिए `nano teeth.sh` का पुनः उपयोग करें।"
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
`bash` का उपयोग करके `teeth.sh` चलाएँ और उसका आउटपुट `>` से रीडायरेक्ट करके `teeth.out` में भेजें।

`@hint`
याद रखिए, `> teeth.out` उस कमांड के *बाद* आना चाहिए जो आउटपुट बना रही है।

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="क्या आपने `bash teeth.sh` के परिणाम को `teeth.out` में `>` के साथ सही ढंग से पुनर्निर्देशित किया है?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'क्या आपने `bash` को कॉल किया?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'क्या आपने `teeth.sh` फ़ाइल चलाई?'),
      has_code(">\s+teeth.out", incorrect_msg = 'क्या आपने `teeth.out` फ़ाइल में पुनर्निर्देशित किया?')
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
अपने परिणाम देखने के लिए `cat teeth.out` चलाएँ।

`@hint`
याद रखिए, आप फ़ाइलनाम के शुरुआती कुछ अक्षर टाइप करके टैब key दबाएँ, तो ऑटो-कम्प्लीट हो जाएगा।

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
      has_code("cat", incorrect_msg = 'क्या आपने `cat` को कॉल किया?'),
      has_code("teeth.out", incorrect_msg = 'क्या आपने `teeth.out` फ़ाइल को निर्दिष्ट किया?')
    )
  )
)
Ex().success_msg("अच्छा! यह सब पहले थोड़ा बनावटी लग सकता है, लेकिन अच्छी बात यह है कि आप अपने कार्यप्रवाह के हिस्सों को चरण दर चरण स्वचालित कर रहे हैं। कुछ ऐसा जो एक डेटा वैज्ञानिक के रूप में वास्तव में काम आता है!")
```

---

## मैं फ़ाइलनामों को स्क्रिप्ट्स में कैसे पास कर सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

ऐसी स्क्रिप्ट जो कुछ खास फ़ाइलें प्रोसेस करे, यह दर्ज रखने के लिए उपयोगी है कि आपने क्या किया। लेकिन जो स्क्रिप्ट आप अपनी पसंद की कोई भी फ़ाइल प्रोसेस करने के लिए चला सकें, वह और ज्यादा उपयोगी होती है.
इसे सपोर्ट करने के लिए,
आप विशेष अभिव्यक्ति `$@` (डॉलर साइन के तुरंत बाद एट-साइन)
का उपयोग कर सकते हैं, जिसका अर्थ है "स्क्रिप्ट को दिए गए सभी कमांड-लाइन पैरामीटर".

उदाहरण के लिए, अगर `unique-lines.sh` में `sort $@ | uniq` है, तो जब आप यह चलाते हैं:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

तो शेल `$@` को `seasonal/summer.csv` से बदल देता है और एक फ़ाइल प्रोसेस होती है। अगर आप यह चलाते हैं:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

तो यह दो डेटा फ़ाइलें प्रोसेस करता है, और इसी तरह आगे भी.

_याद दिलाने के लिए, Nano में जो आपने लिखा है उसे सेव करने के लिए `Ctrl` + `O` दबाकर फ़ाइल लिखें, फिर फ़ाइलनाम कन्फर्म करने के लिए Enter दबाएँ, और फिर एडिटर से बाहर निकलने के लिए `Ctrl` + `X` दबाएँ._

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
Nano के साथ स्क्रिप्ट `count-records.sh` एडिट करें और दोनों `____` placeholders को क्रमशः `$@` और `-l` (_अक्षर_) से भरें ताकि यह एक या अधिक फ़ाइलों में लाइनों की संख्या गिने,
प्रत्येक फ़ाइल की पहली लाइन को छोड़कर.

`@hint`
* फ़ाइलनाम एडिट करने के लिए `nano count-records.sh` का उपयोग करें.
* सुनिश्चित करें कि आप संख्या एक नहीं, बल्कि _अक्षर_ `-l` दे रहे हैं.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="क्या आपने रिक्त स्थानों को सही ढंग से प्रतिस्थापित किया है ताकि `count-records.sh` में कमांड `tail -q -n +2 $@ | wc -l` पढ़े? आवश्यक परिवर्तन करने के लिए `nano count-records.sh` का फिर से उपयोग करें।"
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
`count-records.sh` को `seasonal/*.csv` पर चलाएँ
और आउटपुट को `num-records.out` में `>` का उपयोग करके रीडायरेक्ट करें.

`@hint`
आउटपुट को रीडायरेक्ट करने के लिए `>` का उपयोग करें.

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
      has_code("bash", incorrect_msg = 'क्या आपने `bash` को कॉल किया?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'क्या आपने `count-records.sh` फ़ाइल चलाई?'),
      has_code("seasonal/\*", incorrect_msg = 'क्या आपने `seasonal/*` के साथ प्रोसेस करने के लिए फ़ाइलों को निर्दिष्ट किया?'),
      has_code(">\s+num-records.out", incorrect_msg = 'क्या आपने `num-records.out` फ़ाइल में रीडायरेक्ट किया?')
    )
  )
)
Ex().success_msg("बहुत अच्छा काम! आपकी शेल शक्ति लगातार बढ़ रही है!")
```

---

## मैं एक single argument को कैसे प्रोसेस कर सकता/सकती हूँ?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

`$@` के अलावा,
shell आपको `$1`, `$2`, इत्यादि का उपयोग करके specific कमांड-लाइन पैरामीटर को संदर्भित करने देता है.
आप इसका उपयोग ऐसे कमांड लिखने के लिए कर सकते हैं जो shell के कमांड से अधिक सरल या प्राकृतिक लगें.
उदाहरण के लिए,
आप `column.sh` नाम की एक स्क्रिप्ट बना सकते हैं जो किसी CSV फ़ाइल से एक single कॉलम चुनती है
जब उपयोगकर्ता पहला पैरामीटर फ़ाइलनाम और दूसरा पैरामीटर कॉलम देता है:

```{shell}
cut -d , -f $2 $1
```

और फिर इसे इस तरह चलाएँ:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

ध्यान दें कि स्क्रिप्ट इन दो पैरामीटरों को उल्टे क्रम में उपयोग करती है.

<hr>

स्क्रिप्ट `get-field.sh` को एक फ़ाइलनाम लेना है,
चुनने के लिए पंक्ति (row) का नंबर लेना है,
चुनने के लिए कॉलम का नंबर लेना है,
और किसी CSV फ़ाइल से सिर्फ वही फ़ील्ड प्रिंट करना है.
उदाहरण के लिए:

```
bash get-field.sh seasonal/summer.csv 4 2
```

को `seasonal/summer.csv` की लाइन 4 के दूसरे फ़ील्ड को चुनना चाहिए.
निम्न में से कौन सा कमांड `get-field.sh` में डालना चाहिए ताकि यह काम हो?

`@hint`
याद रखें कि कमांड-लाइन पैरामीटर बाएँ से दाएँ क्रम में numbered होते हैं.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- नहीं: यह `head` के साथ चुनने के लिए लाइनों की संख्या के रूप में फ़ाइलनाम का उपयोग करने की कोशिश करेगा.
- सही!
- नहीं: यह कॉलम नंबर को लाइन नंबर और लाइन नंबर को कॉलम नंबर की तरह लेने की कोशिश करेगा.
- नहीं: यह फ़ील्ड नंबर को फ़ाइलनाम और फ़ाइलनाम को फ़ील्ड नंबर की तरह इस्तेमाल करेगा.

---

## एक ही शेल स्क्रिप्ट कई काम कैसे कर सकती है?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

अभी तक हमारी शेल स्क्रिप्टों में एक ही कमांड या पाइप रहा है, लेकिन एक स्क्रिप्ट में कमांड की कई पंक्तियाँ हो सकती हैं। उदाहरण के लिए, आप ऐसी स्क्रिप्ट बना सकते हैं जो बताए कि आपके डेटा फाइलों में सबसे छोटी और सबसे लंबी फाइल में कितने रिकॉर्ड हैं, यानी आपके डेटासेट्स की लंबाइयों की रेंज।

ध्यान दें कि Nano में "copy and paste" करने के लिए, जिस पंक्ति को आप कॉपी करना चाहते हैं उस पर जाएँ, उसे काटने के लिए `CTRL` + `K` दबाएँ, फिर उसकी दो प्रतियाँ चिपकाने के लिए `CTRL` + `U` दो बार दबाएँ।

_याद दिलाने के लिए, Nano में आपने जो लिखा है उसे सेव करने के लिए `Ctrl` + `O` दबाकर फाइल लिखें, फिर फ़ाइलनाम कन्फर्म करने के लिए Enter दबाएँ, और एडिटर से बाहर निकलने के लिए `Ctrl` + `X` दबाएँ._

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
Nano का उपयोग करके स्क्रिप्ट `range.sh` एडिट करें
और दो `____` प्लेसहोल्डर्स को
`$@` और `-v` से बदलें
ताकि यह कमांड लाइन पर दिए गए सभी फाइलों के नाम और उनकी पंक्तियों की संख्या लिस्ट करे,
और सभी फाइलों की कुल पंक्तियों की संख्या *न* दिखाए।
(फाइलों से कॉलम हेडर लाइनों को घटाने की कोशिश न करें।)

`@hint`
कमान्ड लाइन पर दिए गए सभी फाइलों की पंक्तियाँ गिनने के लिए `wc -l $@` का उपयोग करें।

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="क्या आपने रिक्त स्थानों को सही ढंग से प्रतिस्थापित किया है ताकि `range.sh` में कमांड `wc -l $@ | grep -v total` पढ़े? आवश्यक परिवर्तन करने के लिए `nano range.sh` का पुनः उपयोग करें।"
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
फिर से Nano का उपयोग करके पाइपलाइन में `sort -n` और `head -n 1` उसी क्रम में
`range.sh` में जोड़ें
ताकि इसे दी गई सबसे छोटी फाइल का नाम और लाइन काउंट दिखे।

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="क्या आपने `range.sh` फ़ाइल में पाइप्स के साथ `sort -n` और `head -n 1` जोड़ा है? आवश्यक परिवर्तन करने के लिए फिर से `nano range.sh` का उपयोग करें।"
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
फिर से Nano का उपयोग करते हुए, `range.sh` में दूसरी पंक्ति जोड़ें ताकि डायरेक्टरी में सबसे लंबी फाइल का नाम और रिकॉर्ड काउंट भी
सबसे छोटी के साथ प्रिंट हो।
यह पंक्ति आपकी पहले से लिखी पंक्ति की डुप्लिकेट होनी चाहिए,
पर `sort -n` की जगह `sort -n -r` के साथ।

`@hint`
पहली पंक्ति कॉपी करें और sorting का क्रम बदलें।

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="`range.sh` फ़ाइल में पहली पंक्ति रखें: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="क्या आपने `range.sh` में पहली पंक्ति को डुप्लिकेट किया है और एक छोटा बदलाव किया है? `sort -n` के बजाय `sort -n -r`!"
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
`seasonal` डायरेक्टरी की फाइलों पर स्क्रिप्ट चलाएँ
सारी फाइलें मैच करने के लिए `seasonal/*.csv` का उपयोग करें
और आउटपुट को `>` का उपयोग कर रीडायरेक्ट करके
अपने होम डायरेक्टरी में `range.out` नाम की फाइल में भेजें।

`@hint`
अपनी स्क्रिप्ट चलाने के लिए `bash range.sh` का उपयोग करें, फाइलें बताने के लिए `seasonal/*.csv` और आउटपुट रीडायरेक्ट करने के लिए `> range.out`।

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="क्या आपने `bash range.sh seasonal/*.csv` के परिणाम को `range.out` में `>` के साथ सही ढंग से पुनर्निर्देशित किया है?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'क्या आपने `bash` को कॉल किया?'),
has_code("bash\s+range.sh", incorrect_msg = 'क्या आपने `range.sh` फ़ाइल चलाई?'),
has_code("seasonal/\*", incorrect_msg = 'क्या आपने `seasonal/*` के साथ संसाधित करने के लिए फ़ाइलें निर्दिष्ट कीं?'),
has_code(">\s+range.out", incorrect_msg = 'क्या आपने `range.out` फ़ाइल में पुनर्निर्देशित किया?')
)
)

Ex().success_msg("यह अच्छी तरह से चल रहा है। अगले अभ्यास पर जाएं और लूप लिखने के बारे में जानें!")
```

---

## मैं शेल स्क्रिप्ट में लूप्स कैसे लिख सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shell स्क्रिप्ट्स में लूप्स भी हो सकते हैं। आप इन्हें सेमी-कोलन के साथ एक ही पंक्ति में लिख सकते हैं, या बेहतर पठनीयता के लिए सेमी-कोलन के बिना कई पंक्तियों में बाँट सकते हैं:

```{shell}
# प्रत्येक फ़ाइल के पहले और आखिरी डेटा रिकॉर्ड प्रिंट करें।
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(आपको लूप के अंदर कमांड्स को इंडेंट करना ज़रूरी नहीं है, लेकिन ऐसा करने से चीजें अधिक स्पष्ट हो जाती हैं.)

इस स्क्रिप्ट की पहली पंक्ति एक **comment** है, जो पढ़ने वालों को बताती है कि स्क्रिप्ट क्या करती है। Comments `#` करैक्टर से शुरू होते हैं और पंक्ति के अंत तक चलते हैं। आप भविष्य में खुद को धन्यवाद देंगे यदि आप हर स्क्रिप्ट में ऐसी संक्षिप्त व्याख्याएँ जोड़ेंगे, जैसा यहाँ दिखाया गया है।

_स्मरण के तौर पर, Nano में जो आपने लिखा है उसे सेव करने के लिए `Ctrl` + `O` दबाइए ताकि फ़ाइल लिखी जा सके, फिर फ़ाइलनाम की पुष्टि करने के लिए Enter दबाइए, और फिर एडिटर से बाहर निकलने के लिए `Ctrl` + `X` दबाइए._

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
स्क्रिप्ट `date-range.sh` में placeholders भरें — `$filename` (दो बार), `head`, और `tail` — ताकि यह एक या अधिक फ़ाइलों से पहली और आखिरी तारीख प्रिंट करे।

`@hint`
लूप वैरिएबल का वर्तमान मान पाने के लिए `$filename` का उपयोग करना न भूलें।

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="क्या आपने `date-range.sh` में लूप की %s पंक्ति को `%s` में बदल दिया है? परिवर्तन करने के लिए `nano date-range.sh` का उपयोग करें।"
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('पहली', cmdpatt%'head')
msg2=msgpatt%('दूसरी', cmdpatt%'tail')
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
`seasonal/*.csv` का उपयोग करके नामों से मिलान करें और सभी चार seasonal डेटा फ़ाइलों पर `date-range.sh` चलाएँ।

`@hint`
वाइल्डकार्ड अभिव्यक्ति डायरेक्टरी नाम से शुरू होनी चाहिए।

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
      has_code("bash", incorrect_msg = 'क्या आपने `bash` को कॉल किया?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'क्या आपने `date-range.sh` फ़ाइल चलाई?'),
      has_code("seasonal/\*", incorrect_msg = 'क्या आपने `seasonal/*` के साथ प्रोसेस करने के लिए फ़ाइलों को निर्दिष्ट किया?')
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
`seasonal/*.csv` का उपयोग करके नामों से मिलान करते हुए सभी चार seasonal डेटा फ़ाइलों पर `date-range.sh` चलाएँ,
और उसके आउटपुट को `sort` में पाइप करें ताकि आप देखें कि आपकी स्क्रिप्ट्स Unix के बिल्ट-इन कमांड्स की तरह ही इस्तेमाल की जा सकती हैं.

`@hint`
वही वाइल्डकार्ड अभिव्यक्ति उपयोग करें जो आपने पहले इस्तेमाल की थी।

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
      has_code("bash", incorrect_msg = 'क्या आपने `bash` को कॉल किया?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'क्या आपने `date-range.sh` फ़ाइल चलाई?'),
      has_code("seasonal/\*", incorrect_msg = 'क्या आपने `seasonal/*` के साथ प्रोसेस करने के लिए फाइलें निर्दिष्ट कीं?'),
      has_code("|", incorrect_msg = 'क्या आपने स्क्रिप्ट आउटपुट से `sort` के लिए पाइप किया?'),
      has_code("sort", incorrect_msg = 'क्या आपने `sort` को कॉल किया?')
    )
  )
)
Ex().success_msg("जादू! ध्यान दें कि हमने जो कुछ भी सीखा है वह कितना संयोज्य है।")
```

---

## अगर मैं फ़ाइलनाम न दूँ तो क्या होता है?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

शेल स्क्रिप्ट्स (और इंटरैक्टिव कमांड्स) में एक आम गलती फ़ाइलनामों को गलत जगह पर डालना है.
अगर आप टाइप करते हैं:

```{shell}
tail -n 3
```

तो चूँकि `tail` को कोई फ़ाइलनाम नहीं दिया गया है,
यह आपके कीबोर्ड से इनपुट पढ़ने का इंतज़ार करता है.
इसका मतलब है कि अगर आप टाइप करते हैं:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

तो `tail` आगे बढ़कर `somefile.txt` की आखिरी तीन पंक्तियाँ प्रिंट कर देता है,
लेकिन `head` हमेशा के लिए कीबोर्ड इनपुट का इंतज़ार करता रहता है,
क्योंकि उसे कोई फ़ाइलनाम नहीं दिया गया है और पाइपलाइन में उसके आगे कुछ भी नहीं है.

<hr>

मान लीजिए आपने गलती से टाइप कर दिया:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

अब आपको आगे क्या करना चाहिए?

`@possible_answers`
- `head` के टाइम आउट होने के लिए 10 सेकंड इंतज़ार करें.
- `somefile.txt` टाइप करें और Enter दबाएँ ताकि `head` को कुछ इनपुट मिल जाए.
- चल रहे `head` प्रोग्राम को रोकने के लिए `Ctrl` + `C` का उपयोग करें.

`@hint`
अगर `head` को न तो कोई फ़ाइलनाम दिया गया हो और न ही पाइपलाइन में उसके अपस्ट्रीम से कुछ आ रहा हो, तो वह क्या करता है?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'नहीं, कमांड्स का समय समाप्त नहीं होगा।'
a2 = 'नहीं, यह `head` को `somefile.txt` टेक्स्ट प्रोसेस करने के लिए देगा, लेकिन फिर यह और अधिक इनपुट की प्रतीक्षा में अटक जाएगा।'
a3 = "हाँ! आपको एक चल रहे प्रोग्राम को रोकने के लिए `Ctrl` + `C` का उपयोग करना चाहिए। यह इस प्रारंभिक पाठ्यक्रम का समापन करता है! यदि आप अधिक कमांड लाइन टूल्स सीखने में रुचि रखते हैं, तो हम नि:शुल्क गिट परिचय पाठ्यक्रम लेने की अत्यधिक सिफारिश करते हैं!"
Ex().has_chosen(3, [a1, a2, a3])
```

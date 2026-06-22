---
title: बैच प्रोसेसिंग
description: >-
  ज्यादातर शेल कमांड्स एक साथ कई फाइलों को प्रोसेस कर सकते हैं। यह चैप्टर आपको
  दिखाएगा कि आपकी अपनी पाइपलाइन्स भी ऐसा कैसे करें। इसी दौरान, आप देखेंगे कि
  जानकारी स्टोर करने के लिए शेल वैरिएबल्स का उपयोग कैसे करता है.
lessons:
  - nb_of_exercises: 10
    title: शेल जानकारी कैसे स्टोर करता है?
---

## शेल जानकारी कैसे स्टोर करता है?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

अन्य प्रोग्रामों की तरह, शेल जानकारी को वैरिएबल्स में स्टोर करता है.
इनमें से कुछ,
जिन्हें **environment variables** कहा जाता है,
हमेशा उपलब्ध रहते हैं.
एनवायरनमेंट वैरिएबल्स के नाम प्रायः बड़े अक्षरों (upper case) में लिखे जाते हैं,
और नीचे कुछ आमतौर पर इस्तेमाल होने वाले दिखाए गए हैं.

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | उपयोगकर्ता का होम डायरेक्टरी        | `/home/repl`          |
| `PWD `   | वर्तमान वर्किंग डायरेक्टरी          | `pwd` कमांड जैसा ही   |
| `SHELL`  | कौन-सा शेल प्रोग्राम उपयोग हो रहा है | `/bin/bash`           |
| `USER`   | उपयोगकर्ता की आईडी                  | `repl`                |

पूरी सूची (जो काफ़ी लंबी है) पाने के लिए,
आप शेल में `set` टाइप कर सकते हैं.

<hr>

`set` और `grep` को पाइप के साथ उपयोग करके `HISTFILESIZE` का मान दिखाएँ,
जो तय करता है कि आपकी कमांड हिस्ट्री में कितनी पुरानी कमांड्स स्टोर रहेंगी.
इसका मान क्या है?

`@possible_answers`
- 10
- 500
- [2000]
- वैरिएबल वहाँ नहीं है.

`@hint`
`set | grep HISTFILESIZE` का उपयोग करके वह लाइन निकालें जिसकी आपको ज़रूरत है.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "नहीं: शेल इससे अधिक इतिहास रिकॉर्ड करता है।"
err2 = "नहीं: शेल इससे अधिक इतिहास रिकॉर्ड करता है।"
correct3 = "सही: शेल इस प्रणाली पर डिफ़ॉल्ट रूप से 2000 पुराने कमांड सहेजता है।"
err4 = "नहीं: चर `HISTFILESIZE` वहाँ है।"
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## मैं वैरिएबल का मान कैसे प्रिंट कर सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

किसी वैरिएबल का मान पता करने का एक आसान तरीका `echo` कमांड चलाना है, जो अपने आर्ग्युमेंट्स को प्रिंट करती है। अगर आप लिखते हैं:

```{shell}
echo hello DataCamp!
```

तो आउटपुट होगा:

```
hello DataCamp!
```

यदि आप इसे इस तरह किसी वैरिएबल का मान प्रिंट करने के लिए इस्तेमाल करते हैं:

```{shell}
echo USER
```

तो यह वैरिएबल का नाम `USER` ही प्रिंट करेगा।

वैरिएबल का मान पाने के लिए, उसके आगे डॉलर साइन `$` लगाना ज़रूरी है। जैसे लिखें 

```{shell}
echo $USER
```

तो आउटपुट होगा:

```
repl
```

यह नियम हर जगह लागू होता है:
अगर वैरिएबल का नाम `X` है और उसका मान चाहिए,
तो आपको `$X` लिखना होगा।
(ऐसा इसलिए है ताकि शेल यह समझ सके कि आप "X नाम की फ़ाइल" कहना चाहते हैं
या "X नाम के वैरिएबल का मान".)

`@instructions`
वैरिएबल `OSTYPE` उस ऑपरेटिंग सिस्टम के प्रकार का नाम रखता है जिसे आप इस्तेमाल कर रहे हैं।
उसका मान `echo` से दिखाइए.

`@hint`
वैरिएबल `OSTYPE` के आगे `$` लगाकर `echo` चलाएँ।

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
            has_code('echo', incorrect_msg="क्या आपने `echo` को कॉल किया?"),
            has_code('OSTYPE', incorrect_msg="क्या आपने `OSTYPE` एनवायरनमेंट वेरिएबल को प्रिंट किया?"),
            has_code(r'\$OSTYPE', incorrect_msg="सुनिश्चित करें कि `OSTYPE` से पहले `$` लगाया गया है।")
        )
    )
)
Ex().success_msg("एनवायरनमेंट वेरिएबल्स का उत्कृष्ट इको! आप एक अच्छी शुरुआत कर रहे हैं। चलिए आगे बढ़ते हैं!")
```

---

## शेल और कैसे जानकारी सहेजता है?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

वैरिएबल का दूसरा प्रकार **shell variable** कहलाता है,
जो प्रोग्रामिंग भाषा में लोकल वैरिएबल जैसा होता है.

एक shell variable बनाने के लिए,
आप बस किसी नाम को कोई मान असाइन करते हैं:

```{shell}
training=seasonal/summer.csv
```

`=` चिन्ह के पहले या बाद में कोई स्पेस *बिना*.
एक बार ऐसा करने के बाद,
आप वैरिएबल का मान इस तरह जाँच सकते हैं:

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
`testing` नाम का वैरिएबल परिभाषित करें जिसका मान `seasonal/winter.csv` हो.

`@hint`
वैरिएबल के नाम और उसके मान के बीच स्पेस *नहीं* होना चाहिए.

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
        has_code('testing', incorrect_msg='क्या आपने `testing` नामक एक शेल वेरिएबल परिभाषित किया है?'),
        has_code('testing=', incorrect_msg='क्या आपने `testing` के तुरंत बाद, बिना किसी स्पेस के, `=` लिखा है?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='क्या आपने `testing` का मान `seasonal/winter.csv` पर सेट किया है?')
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
`head -n 1 SOMETHING` का उपयोग करके `seasonal/winter.csv` की पहली पंक्ति निकालें,
और फ़ाइल के नाम की जगह वैरिएबल `testing` के मान का उपयोग करें.

`@hint`
ध्यान रखें कि सिर्फ `testing` नहीं, बल्कि `$testing` इस्तेमाल करें
(वैरिएबल का मान लेने के लिए `$` ज़रूरी है).

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
    has_code(r'\$testing', incorrect_msg="क्या आपने शेल वेरिएबल को `$testing` का उपयोग करके संदर्भित किया?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="क्या आपने `head` को कॉल किया?"),
            has_code('-n', incorrect_msg="क्या आपने `-n` के साथ लाइनों की संख्या सीमित की?"),
            has_code(r'-n\s+1', incorrect_msg="क्या आपने `-n 1` के साथ 1 पंक्ति रखने का निर्णय लिया?")     
        )
    )
)
Ex().success_msg("उत्कृष्ट! आइए देखें कि आप कमांड को आसानी से कैसे दोहरा सकते हैं।")
```

---

## मैं एक कमांड को कई बार कैसे दोहराऊँ?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Shell वैरिएबल्स का उपयोग **loops** में भी होता है,
जो कमांड्स को कई बार चलाते हैं।
यदि हम यह कमांड चलाएँ:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

तो आउटपुट होगा:

```
gif
jpg
png
```

लूप के बारे में ये बातें ध्यान दें:

1. स्ट्रक्चर है `for` ...variable... `in` ...list... `; do` ...body... `; done`
2. उन चीज़ों की लिस्ट जिन्हें लूप प्रोसेस करेगा (हमारे उदाहरण में शब्द `gif`, `jpg`, और `png`).
3. वह वैरिएबल जो ट्रैक रखता है कि लूप अभी किस चीज़ को प्रोसेस कर रहा है (हमारे उदाहरण में `filetype`).
4. लूप का बॉडी जो प्रोसेसिंग करता है (हमारे उदाहरण में `echo $filetype`).

ध्यान दें कि बॉडी वैरिएबल का मान लेने के लिए `filetype` की बजाय `$filetype` का उपयोग करती है,
बिलकुल वैसे ही जैसे किसी अन्य shell वैरिएबल के साथ करते हैं।
यह भी देखें कि सेमी-कोलन कहाँ आते हैं:
पहला लिस्ट और कीवर्ड `do` के बीच आता है,
और दूसरा बॉडी और कीवर्ड `done` के बीच।

`@instructions`
लूप को ऐसे बदलें कि यह यह प्रिंट करे:

```
docx
odt
pdf
```

कृपया लूप वैरिएबल के नाम के रूप में `filetype` ही उपयोग करें।

`@hint`
प्रारंभिक टेक्स्ट में दी गई कोड स्ट्रक्चर का उपयोग करें, बस image फाइल टाइप्स की जगह document फाइल टाइप्स रख दें।

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
      has_code('for', incorrect_msg='क्या आपने `for` को कॉल किया?'),
      has_code('filetype', incorrect_msg='क्या आपने `filetype` को लूप वेरिएबल के रूप में उपयोग किया?'),
      has_code('in', incorrect_msg='क्या आपने फ़ाइल प्रकारों की सूची से पहले `in` का उपयोग किया?'),
      has_code('docx odt pdf', incorrect_msg='क्या आपने `docx`, `odt` और `pdf` को उसी क्रम में लूप किया?'),
      has_code(r'pdf\s*;', incorrect_msg='क्या आपने अंतिम लूप तत्व के बाद सेमी-कोलन डाला?'),
      has_code(r';\s*do', incorrect_msg='क्या आपने पहले सेमी-कोलन के बाद `do` का उपयोग किया?'),
      has_code('echo', incorrect_msg='क्या आपने `echo` को कॉल किया?'),
      has_code(r'\$filetype', incorrect_msg='क्या आपने `$filetype` को echo किया?'),
      has_code(r'filetype\s*;', incorrect_msg='क्या आपने लूप बॉडी के बाद सेमी-कोलन डाला?'),
      has_code('; done', incorrect_msg='क्या आपने `done` के साथ समाप्त किया?')
    )
  )
)
Ex().success_msg("लूपिंग के लिए प्रथम श्रेणी! यदि आप सैकड़ों या हजारों बार एक ही काम करना चाहते हैं तो लूप शानदार होते हैं।")
```

---

## मैं हर फ़ाइल के लिए एक कमांड को एक-एक बार कैसे दोहराऊँ?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

आप लूप लिखते समय जिन फ़ाइलों को प्रोसेस करना चाहते हैं उनके नाम हमेशा टाइप कर सकते हैं,
लेकिन आम तौर पर वाइल्डकार्ड का उपयोग करना बेहतर रहता है।
कंसोल में यह लूप चलाकर देखें:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

यह निम्नलिखित प्रिंट करता है:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

क्योंकि शेल `seasonal/*.csv` को लूप चलाने से पहले
चार फ़ाइलनामों की सूची में एक्सपैंड कर देता है।

`@instructions`
वाइल्डकार्ड अभिव्यक्ति को `people/*` में बदलें
ताकि लूप `people` डायरेक्टरी में मौजूद फ़ाइलों के नाम प्रिंट करे,
चाहे उनके पास कोई भी सफ़िक्स हो या न हो।
कृपया अपने लूप वैरिएबल का नाम `filename` ही रखें।

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
      has_code('for', incorrect_msg='क्या आपने `for` को कॉल किया?'),
      has_code('filename', incorrect_msg='क्या आपने `filename` को लूप वेरिएबल के रूप में उपयोग किया?'),
      has_code('in', incorrect_msg='क्या आपने फ़ाइल प्रकारों की सूची से पहले `in` का उपयोग किया?'),
      has_code('people/\*', incorrect_msg='क्या आपने `people/*` के साथ फ़ाइलों की सूची निर्दिष्ट की?'),
      has_code(r'people/\*\s*;', incorrect_msg='क्या आपने फ़ाइलों की सूची के बाद अर्धविराम लगाया?'),
      has_code(r';\s*do', incorrect_msg='क्या आपने पहले अर्धविराम के बाद `do` का उपयोग किया?'),
      has_code('echo', incorrect_msg='क्या आपने `echo` को कॉल किया?'),
      has_code(r'\$filename', incorrect_msg='क्या आपने `$filename` को echo किया?'),
      has_code(r'filename\s*;', incorrect_msg='क्या आपने लूप बॉडी के बाद अर्धविराम लगाया?'),
      has_code('; done', incorrect_msg='क्या आपने `done` के साथ समाप्त किया?')
    )
  )
)
Ex().success_msg("लूपी लूपिंग! वाइल्डकार्ड और लूप एक शक्तिशाली संयोजन बनाते हैं।")
```

---

## मैं फ़ाइलों के एक सेट के नाम कैसे रिकॉर्ड कर सकता/सकती हूँ?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

लोग अक्सर फ़ाइलनामों की सूची रिकॉर्ड करने के लिए एक वाइल्डकार्ड एक्सप्रेशन के साथ कोई वैरिएबल सेट करते हैं.
उदाहरण के लिए,
अगर आप `datasets` को इस तरह परिभाषित करते हैं:

```{shell}
datasets=seasonal/*.csv
```

तो आप बाद में फ़ाइलों के नाम इस तरह दिखा सकते हैं:

```{shell}
for filename in $datasets; do echo $filename; done
```

इससे टाइपिंग बचती है और गलती होने की संभावना कम होती है.

<hr>

अगर आप ये दो कमांड अपनी होम डायरेक्टरी में चलाते हैं,
तो वे कितनी पंक्तियों का आउटपुट प्रिंट करेंगे?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- कोई नहीं: क्योंकि `files` अलग पंक्ति में परिभाषित है, दूसरी पंक्ति में उसका कोई मान नहीं होगा.
- एक: शब्द "files".
- चार: सभी चार seasonal डेटा फ़ाइलों के नाम.

`@hint`
ध्यान रखें, अकेला `X` सिर्फ "X" है, जबकि `$X` वैरिएबल `X` का मान देता है.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "नहीं: आपको उसी पंक्ति में एक चर को परिभाषित करने की आवश्यकता नहीं है जिसमें आप इसका उपयोग करते हैं।"
err2 = "नहीं: इस उदाहरण में `files` चर को उसी शेल में परिभाषित और उपयोग किया गया है।"
correct3 = "सही। यह कमांड `for f in seasonal/*.csv; do echo $f; done` के समकक्ष है।"
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## वैरिएबल के नाम बनाम उसका मान

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

एक आम गलती है वैरिएबल के नाम से पहले `$` लगाना भूल जाना.
जब आप ऐसा करते हैं,
तो शेल उस वैरिएबल के मान के बजाय
आपके टाइप किए हुए नाम को ही इस्तेमाल करता है.

अनुभवी यूज़र्स भी एक सामान्य गलती करते हैं: वैरिएबल के नाम को गलत टाइप कर देना.
उदाहरण के लिए,
अगर आप `datasets` को इस तरह परिभाषित करें:

```{shell}
datasets=seasonal/*.csv
```

और फिर यह टाइप करें:

```{shell}
echo $datsets
```

तो शेल कुछ भी प्रिंट नहीं करता,
क्योंकि `datsets` (दूसरा "a" नहीं है) परिभाषित ही नहीं है.

<hr>

अगर आप अपने होम डायरेक्टरी में ये दो कमांड चलाएँ,
तो क्या आउटपुट प्रिंट होगा?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(उत्तर देने से पहले लूप के पहले हिस्से को ध्यान से पढ़ें.)

`@hint`
याद रखें, अकेला `X` सिर्फ "X" होता है, जबकि `$X` वैरिएबल `X` का मान देता है.

`@possible_answers`
- [एक लाइन: "files" शब्द.]
- चार लाइनें: सभी चार seasonal डेटा फ़ाइलों के नाम.
- चार खाली लाइनें: वैरिएबल `f` को कोई मान असाइन नहीं हुआ.

`@feedback`
- सही: लूप `$files` की जगह `files` का उपयोग करता है, इसलिए लिस्ट में सिर्फ "files" शब्द आता है.
- नहीं: लूप `$files` की जगह `files` का उपयोग करता है, इसलिए लिस्ट में `files` के विस्तार के बजाय "files" शब्द ही आता है.
- नहीं: वैरिएबल `f` अपने-आप `for` लूप द्वारा परिभाषित होता है.

---

## मैं एक ही लूप में कई कमांड कैसे चलाऊँ?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

फ़ाइलनाम प्रिंट करना डिबगिंग के लिए उपयोगी है,
लेकिन लूप का असली उद्देश्य कई फ़ाइलों पर काम करना है।
यह लूप हर डेटा फ़ाइल की दूसरी पंक्ति प्रिंट करता है:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

इसकी संरचना वैसी ही है जैसी आपने अन्य लूप्स में देखी है:
अंतर सिर्फ इतना है कि इसका बॉडी एक कमांड के बजाय दो कमांड की पाइपलाइन है.

`@instructions`
एक लूप लिखिए जो हर seasonal फ़ाइल में जुलाई 2017 (`2017-07`) की आख़िरी एंट्री प्रिंट करे. इसका आउटपुट इस तरह के कमांड जैसा होना चाहिए:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

लेकिन यह काम **हर** seasonal फ़ाइल के लिए अलग-अलग करे. कृपया लूप वैरिएबल का नाम `file` ही रखें, और `seasonal/*.csv` फ़ाइलों की सूची पर लूप चलाएँ (उदाहरण में दिए 'seasonal/winter.csv' की जगह).

`@hint`
लूप का बॉडी निर्देशों में दिखाए गए grep कमांड जैसा ही है, बस `seasonal/winter.csv` की जगह `$file` होना चाहिए.

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
  has_code('for', incorrect_msg='क्या आपने `for` को कॉल किया?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='क्या आपने लूप वेरिएबल के रूप में `file` का उपयोग किया?'),
      has_code('in', incorrect_msg='क्या आपने फ़ाइलों की सूची से पहले `in` का उपयोग किया?'),
      has_code('seasonal/\*', incorrect_msg='क्या आपने `seasonal/*` के साथ फ़ाइलों की सूची निर्दिष्ट की?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='क्या आपने फ़ाइलों की सूची के बाद सेमी-कोलन लगाया?'),
      has_code(r';\s*do', incorrect_msg='क्या आपने पहले सेमी-कोलन के बाद `do` का उपयोग किया?'),
      has_code('grep', incorrect_msg='क्या आपने `grep` को कॉल किया?'),
      has_code('2017-07', incorrect_msg='क्या आपने `2017-07` पर मिलान किया?'),
      has_code(r'\$file', incorrect_msg='क्या आपने लूप वेरिएबल के नाम के रूप में `$file` का उपयोग किया?'),
      has_code(r'file\s*|', incorrect_msg='क्या आपने अपनी दूसरी कमांड से कनेक्ट करने के लिए पाइप का उपयोग किया?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='क्या आपने अपनी दूसरी कमांड में प्रत्येक खोज की अंतिम प्रविष्टि को प्रिंट करने के लिए `tail -n 1` का उपयोग किया?'),
      has_code('; done', incorrect_msg='क्या आपने `done` के साथ समाप्त किया?')
    )
  )
)

Ex().success_msg("लूपी लूपिंग! वाइल्डकार्ड और लूप एक शक्तिशाली संयोजन बनाते हैं।")
```

---

## मुझे फाइलनामों में स्पेस क्यों नहीं रखने चाहिए?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

ग्राफिकल फाइल एक्सप्लोरर में काम करते समय `July 2017.csv` जैसे मल्टी-वर्ड नाम देना आसान और समझदारी भरा लगता है।
हालाँकि, शेल में काम करते समय यह समस्या पैदा करता है।
उदाहरण के लिए, मान लीजिए आप `July 2017.csv` का नाम बदलकर `2017 July data.csv` रखना चाहते हैं।
आप यह नहीं टाइप कर सकते:

```{shell}
mv July 2017.csv 2017 July data.csv
```

क्योंकि शेल को ऐसा लगता है मानो आप चार फाइलें `July`, `2017.csv`, `2017`, और `July` (दोबारा) को `data.csv` नाम की डायरेक्टरी में मूव करने की कोशिश कर रहे हों।
इसके बजाय, आपको फाइलों के नाम को क्वोट करना होगा ताकि शेल हर एक को एक ही पैरामीटर माने:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

यदि आपके पास `current.csv` और `last year.csv` (जिसके नाम में स्पेस है) नाम की दो फाइलें हों और आप टाइप करें:

```{shell}
rm current.csv last year.csv
```

तो क्या होगा:

`@hint`
यदि किसी ने आपको यह कमांड दिखाया हो और आपको यह न पता हो कि कौन-कौन से फाइल मौजूद हैं, तो आप क्या उम्मीद करेंगे कि क्या होने वाला है?

`@possible_answers`
- शेल एक एरर मैसेज प्रिंट करेगा क्योंकि `last` और `year.csv` मौजूद नहीं हैं।
- शेल `current.csv` को डिलीट कर देगा।
- [ऊपर की दोनों बातें सही हैं।]
- कुछ नहीं।

`@feedback`
- हाँ, लेकिन बस इतना ही नहीं।
- हाँ, लेकिन बस इतना ही नहीं।
- सही। आप फाइल नामों के चारों ओर सिंगल क्वोट `'` या डबल क्वोट `"` लगा सकते हैं।
- दुर्भाग्य से नहीं।

---

## मैं एक ही लूप में कई काम कैसे कर सकता/सकती हूँ?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

अब तक जिन लूप्स को आपने देखा है, उनकी बॉडी में एक ही कमांड या पाइपलाइन होती है,
लेकिन किसी लूप में कमांड्स की कोई भी संख्या हो सकती है.
शेल को यह बताने के लिए कि एक कमांड कहाँ खत्म होती है और अगली कहाँ शुरू,
उन्हें सेमी-कोलन से अलग करना पड़ता है:

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

मान लीजिए कि आप पिछले लूप में `echo` और `head` कमांड्स के बीच सेमी-कोलन लगाना भूल जाते हैं,
और शेल से यह चलाने के लिए कहते हैं:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

शेल क्या करेगा?

`@possible_answers`
- एक त्रुटि संदेश प्रिंट करेगा.
- चारों फाइलों में से प्रत्येक के लिए एक पंक्ति प्रिंट करेगा.
- `autumn.csv` (पहली फाइल) के लिए एक पंक्ति प्रिंट करेगा.
- प्रत्येक फाइल की आख़िरी पंक्ति प्रिंट करेगा.

`@hint`
आप `echo` के आउटपुट को `tail` में पाइप कर सकते हैं.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "नहीं: लूप चलेगा, यह बस कुछ समझदारी भरा नहीं करेगा।"
correct2 = "हाँ: `echo` एक पंक्ति उत्पन्न करता है जिसमें फ़ाइल का नाम दो बार शामिल होता है, जिसे `tail` फिर कॉपी करता है।"
err3 = "नहीं: लूप चार फ़ाइल नामों में से प्रत्येक के लिए एक बार चलता है।"
err4 = "नहीं: `tail` का इनपुट प्रत्येक फ़ाइल नाम के लिए `echo` का आउटपुट है।"
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

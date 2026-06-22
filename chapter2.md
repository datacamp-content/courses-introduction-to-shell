---
title: डेटा में बदलाव करना
description: >-
  पिछले चैप्टर के कमांड्स ने आपको फाइल सिस्टम में चीज़ों को इधर-उधर करने दिया।
  इस चैप्टर में आप सीखेंगे कि उन फाइलों के अंदर मौजूद डेटा के साथ कैसे काम करें।
  जिन टूल्स का हम उपयोग करेंगे वे सरल हैं, लेकिन वे मज़बूत बिल्डिंग ब्लॉक्स हैं.
lessons:
  - nb_of_exercises: 12
    title: मैं किसी फाइल की सामग्री कैसे देख सकता/सकती हूँ?
---

## मैं किसी फ़ाइल की सामग्री कैसे देख सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

फ़ाइलों का नाम बदलने या उन्हें डिलीट करने से पहले,
आप उनकी सामग्री एक नज़र देखना चाहेंगे।
इसे करने का सबसे आसान तरीका `cat` है,
जो बस फ़ाइलों की सामग्री स्क्रीन पर प्रिंट कर देता है।
(इसका नाम "concatenate" का संक्षिप्त रूप है, जिसका अर्थ है "चीजों को जोड़ना",
क्योंकि यह आपके द्वारा दिए गए सभी फ़ाइल नामों की सामग्री एक के बाद एक प्रिंट करता है.)

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
`course.txt` की सामग्री स्क्रीन पर प्रिंट करें.

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
    has_expr_output(incorrect_msg="आपका कमांड सही आउटपुट उत्पन्न नहीं कर सका। क्या आपने `cat` का उपयोग `course.txt` फ़ाइल के नाम के साथ किया है?")
)
Ex().success_msg("अच्छा! आइए फ़ाइल की सामग्री देखने के अन्य तरीकों पर नज़र डालें।")
```

---

## मैं किसी फ़ाइल की सामग्री को टुकड़ों में कैसे देख सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

आप बड़े फ़ाइलों को प्रिंट करने के लिए `cat` का उपयोग कर सकते हैं और फिर आउटपुट को स्क्रॉल कर सकते हैं,
लेकिन आमतौर पर आउटपुट को **page** करना ज़्यादा सुविधाजनक होता है।
इसके लिए मूल कमांड `more` थी,
लेकिन अब इसे एक अधिक शक्तिशाली कमांड `less` ने बदल दिया है।
(Unix दुनिया में इस तरह का नामकरण ही हास्य माना जाता है.)
जब आप किसी फ़ाइल पर `less` चलाते हैं,
तो एक समय में एक पेज दिखाया जाता है;
आप नीचे जाने के लिए स्पेसबार दबा सकते हैं या बाहर निकलने के लिए `q` टाइप करें।

अगर आप `less` को कई फ़ाइलों के नाम देते हैं,
तो अगली फ़ाइल पर जाने के लिए आप `:n` (कोलन और छोटा 'n') टाइप कर सकते हैं,
पिछली पर लौटने के लिए `:p`,
या बाहर निकलने के लिए `:q`।

नोट: यदि आप उन अभ्यासों के समाधान देखते हैं जो `less` का उपयोग करते हैं,
तो आप अंत में एक अतिरिक्त कमांड देखेंगे जो paging को *off* कर देता है,
ताकि हम आपके समाधानों का कुशलता से परीक्षण कर सकें।

`@instructions`
उन्हें उसी क्रम में देखने के लिए `less seasonal/spring.csv seasonal/summer.csv` चलाएँ।
नीचे जाने के लिए स्पेसबार दबाएँ, दूसरी फ़ाइल पर जाने के लिए `:n`, और बाहर निकलने के लिए `:q` दबाएँ।

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
                 incorrect_msg='`less` और फ़ाइल नामों का उपयोग करें। याद रखें कि `:n` आपको अगली फ़ाइल पर ले जाता है।'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## मैं फ़ाइल की शुरुआत कैसे देख सकता/सकती हूँ?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

जब किसी डेटा वैज्ञानिक को विश्लेषण के लिए नया डेटासेट मिलता है, तो वह सबसे पहले यह देखता/देखती है कि उसमें कौन से फ़ील्ड हैं और उन फ़ील्ड्स के मान क्या हैं.
अगर डेटासेट किसी डेटाबेस या स्प्रेडशीट से एक्सपोर्ट किया गया है,
तो उसे अक्सर **comma-separated values** (CSV) के रूप में सेव किया जाता है.
यह समझने का एक तेज़ तरीका है कि पहले कुछ पंक्तियाँ देखकर पता लगाया जाए कि इसमें क्या है.

हम शेल में यह काम `head` नाम के कमांड से कर सकते हैं.
जैसा कि नाम से स्पष्ट है,
यह किसी फ़ाइल की शुरुआती कुछ पंक्तियाँ प्रिंट करता है
(यहाँ "कुछ" का मतलब 10 है),
इसलिए यह कमांड:

```{shell}
head seasonal/summer.csv
```

यह दिखाता है:

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

अगर फ़ाइल में 10 पंक्तियाँ नहीं हैं तो `head` क्या करता है?
(पता लगाने के लिए, `people/agarwal.txt` की शुरुआत देखने में इसका उपयोग कीजिए.)

`@possible_answers`
- एक त्रुटि संदेश प्रिंट करेगा क्योंकि फ़ाइल बहुत छोटी है.
- जितनी पंक्तियाँ होंगी, उतनी ही दिखाएगा.
- कुल 10 करने के लिए पर्याप्त खाली पंक्तियाँ दिखाएगा.

`@hint`
यह उससे सबसे उपयोगी क्या कर सकता है?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["गलत: वह सबसे उपयोगी चीज़ नहीं है जो यह कर सकता है।",
                    "सही!",
                    "गलत: इसे उन फ़ाइलों से अलग करना असंभव होगा जो कई खाली लाइनों के साथ समाप्त होती हैं।"])
```

---

## मैं कम टाइप कैसे कर सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

शेल के शक्तिशाली टूल्स में से एक है **tab completion**.
यदि आप किसी फ़ाइल का नाम टाइप करना शुरू करें और फिर Tab कुंजी दबाएँ,
तो शेल पाथ को ऑटो-कम्प्लीट करने की पूरी कोशिश करेगा.
उदाहरण के लिए,
यदि आप `sea` टाइप करें और Tab दबाएँ,
तो यह डायरेक्टरी का नाम `seasonal/` भर देगा (अंत में स्लैश के साथ).
इसके बाद यदि आप `a` टाइप करें और Tab दबाएँ,
तो यह पाथ को `seasonal/autumn.csv` के रूप में पूरा कर देगा.

यदि पाथ अस्पष्ट है,
जैसे `seasonal/s`,
तो Tab दूसरी बार दबाने पर संभावित विकल्पों की सूची दिखेगी.
पाथ को और विशिष्ट बनाने के लिए एक-दो और अक्षर टाइप कीजिए
और फिर Tab दबाइए —
बाकी नाम अपने-आप भर जाएगा.

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
पूरा फ़ाइलनाम टाइप किए बिना `head seasonal/autumn.csv` चलाएँ.

`@hint`
पाथ का जितना भाग ज़रूरी हो उतना टाइप करें, फिर Tab दबाएँ, और दोहराएँ.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="चेकर आपके कमांड में सही आउटपुट नहीं ढूंढ सका। क्या आपने `seasonal/autumn.csv` पर `head` को कॉल किया?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
पूरा फ़ाइलनाम टाइप किए बिना `head seasonal/spring.csv` चलाएँ.

`@hint`
पाथ का जितना भाग ज़रूरी हो उतना टाइप करें, फिर Tab दबाएँ, और दोहराएँ.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="चेकर आपके कमांड में सही आउटपुट नहीं ढूंढ सका। क्या आप सुनिश्चित हैं कि आपने `seasonal/spring.csv` पर `head` कॉल किया?")
)
Ex().success_msg("अच्छा काम! एक बार जब आप टैब पूर्णता का उपयोग करने की आदत डाल लेते हैं, तो यह आपका बहुत समय बचाएगा!")
```

---

## मैं कमांड्स के व्यवहार को कैसे नियंत्रित कर सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

आप हर बार किसी फ़ाइल की पहली 10 पंक्तियाँ देखना नहीं चाहेंगे,
इसलिए शेल आपको `head` के व्यवहार को बदलने देता है
उसे **कमांड-लाइन फ़्लैग** (संक्षेप में "फ़्लैग") देकर।
यदि आप यह कमांड चलाते हैं:

```{shell}
head -n 3 seasonal/summer.csv
```

तो `head` फ़ाइल की सिर्फ पहली तीन पंक्तियाँ दिखाएगा।
यदि आप `head -n 100` चलाते हैं,
तो यह पहली 100 पंक्तियाँ दिखाएगा (मानते हुए कि उतनी पंक्तियाँ हैं),
और इसी तरह आगे।

किसी फ़्लैग का नाम आमतौर पर उसके उद्देश्य का संकेत देता है
(उदाहरण के लिए, `-n` का मतलब है "पंक्तियों की **संख्या**").
कमांड फ़्लैग हमेशा `-` के बाद एक ही अक्षर नहीं होते,
लेकिन यह व्यापक रूप से इस्तेमाल की जाने वाली परंपरा है।

नोट: अच्छा स्टाइल यह माना जाता है कि सभी फ़्लैग *किसी भी फ़ाइल नाम से पहले* रखे जाएँ,
इसलिए इस कोर्स में,
हम केवल वही उत्तर स्वीकार करते हैं जो ऐसा करते हैं।

`@instructions`
`seasonal` डायरेक्टरी में `winter.csv` की पहली 5 पंक्तियाँ दिखाएँ।

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
        has_expr_output(incorrect_msg="क्या आप सुनिश्चित हैं कि आप `seasonal/winter.csv` फ़ाइल पर `head` कॉल कर रहे हैं?"),
        has_expr_output(strict=True, incorrect_msg="क्या आप सुनिश्चित हैं कि आपने `-n 5` फ्लैग का उपयोग किया है?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "क्या आप सुनिश्चित हैं कि आपने `-n 5` फ्लैग का उपयोग किया है?")
)
Ex().success_msg("अच्छा! इस तकनीक के साथ, यदि आप बड़े टेक्स्ट फ़ाइलों को देखना चाहते हैं तो आप अपने शेल को फटने से बचा सकते हैं।")
```

---

## मैं किसी डायरेक्टरी के अंदर की सारी चीज़ें कैसे सूचीबद्ध कर सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

किसी डायरेक्टरी के नीचे मौजूद सब कुछ देखने के लिए,
चाहे वह कितनी भी गहराई में nested क्यों न हो,
आप `ls` को `-R` फ्लैग दे सकते हैं
(जिसका मतलब है "recursive").
अगर आप अपनी home डायरेक्टरी में `ls -R` चलाते हैं,
तो आपको कुछ ऐसा दिखाई देगा:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

यह पहले मौजूदा स्तर पर हर फ़ाइल और डायरेक्टरी दिखाता है,
फिर हर sub-directory के अंदर की चीज़ें,
और इसी तरह आगे.

`@instructions`
यह पहचानने में मदद के लिए कि क्या क्या है,
`ls` में एक और फ्लैग `-F` होता है जो हर डायरेक्टरी के नाम के बाद `/` लगाता है
और हर runnable प्रोग्राम के नाम के बाद `*`.
`ls` को दो फ्लैग `-R` और `-F` के साथ, और अपनी home डायरेक्टरी के absolute path के साथ चलाइए
ताकि आप उसमें मौजूद सब कुछ देख सकें.
(फ्लैग का क्रम मायने नहीं रखता, लेकिन डायरेक्टरी का नाम सबसे अंत में होना चाहिए.)

`@hint`
आपकी home डायरेक्टरी को `~` या `.` या उसके absolute path से बताया जा सकता है.

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
  has_expr_output(incorrect_msg='या तो `ls -R -F` या `ls -F -R` और पथ `/home/repl` का उपयोग करें।'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='या तो `ls -R -F` या `ls -F -R` और पथ `/home/repl` का उपयोग करें।')
)
Ex().success_msg('यह एक बहुत ही साफ-सुथरा अवलोकन है, है ना?')
```

---

## किसी कमांड की मदद कैसे पाएँ?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

यह जानने के लिए कि कमांड क्या करती हैं,
लोग पहले `man` कमांड का उपयोग करते थे
("manual" का संक्षिप्त रूप)।
उदाहरण के लिए,
`man head` कमांड यह जानकारी दिखाती है:

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

`man` अपने आप `less` चलाता है,
इसलिए जानकारी के पन्ने पलटने के लिए आपको स्पेसबार दबाना पड़ सकता है
और बाहर निकलने के लिए `:q` दबाना होगा।

`NAME` के नीचे दी गई एक-पंक्ति की परिभाषा संक्षेप में बताती है कि कमांड क्या करती है,
और `SYNOPSIS` के अंतर्गत सारांश में वे सभी flags सूचीबद्ध होते हैं जिन्हें यह समझता है।
जो भी वैकल्पिक है वह वर्ग कोष्ठकों `[...]` में दिखाया जाता है,
either/or विकल्पों को `|` से अलग किया जाता है,
और जिन चीज़ों को दोहराया जा सकता है उन्हें `...` से दिखाया जाता है,
इसलिए `head` के manual पेज से पता चलता है कि आप *या तो* `-n` के साथ लाइन काउंट दे सकते हैं
या `-c` के साथ बाइट काउंट,
और आप किसी भी संख्या में फ़ाइलनाम दे सकते हैं।

Unix मैनुअल की दिक्कत यह है कि आपको पता होना चाहिए कि आप क्या ढूँढ रहे हैं।
अगर नहीं पता,
तो आप [Stack Overflow](https://stackoverflow.com/) पर खोज सकते हैं,
DataCamp के Slack चैनलों पर प्रश्न पूछ सकते हैं,
या जिन कमांड्स को आप पहले से जानते हैं उनके `SEE ALSO` सेक्शन देख सकते हैं।

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
`tail` कमांड का manual पेज पढ़िए ताकि यह पता चले कि `-n` फ्लैग के साथ इस्तेमाल की गई संख्या के आगे `+` साइन लगाने से क्या होता है।
(नीचे जाने के लिए स्पेसबार दबाने और/या बाहर निकलने के लिए `q` टाइप करने को याद रखें।)

`@hint`
याद रखें: `man` "manual" का संक्षिप्त रूप है।

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='`man` और कमांड नाम का उपयोग करें।')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
`tail` को फ्लैग `-n +7` के साथ चलाइए ताकि `seasonal/spring.csv` की पहली छह पंक्तियों को छोड़कर बाकी सभी पंक्तियाँ दिखाई दें।

`@hint`
जितनी पंक्तियाँ दिखानी हैं, उनकी संख्या के आगे '+' साइन का उपयोग करें।

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="क्या आप `seasonal/spring.csv` पर `tail` का उपयोग कर रहे हैं?"),
    has_expr_output(strict=True, incorrect_msg="क्या आप सुनिश्चित हैं कि आपने `-n +7` फ्लैग का उपयोग किया?")
)

```

---

## मैं किसी फाइल से कॉलम कैसे चुन सकता/सकती हूँ?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` और `tail` आपको किसी टेक्स्ट फाइल से rows चुनने देते हैं.
यदि आप कॉलम चुनना चाहते हैं,
तो आप `cut` कमांड का उपयोग कर सकते हैं.
इसके कई विकल्प हैं (उन्हें देखने के लिए `man cut` चलाइए),
लेकिन सबसे आम उपयोग कुछ इस तरह होता है:

```{shell}
cut -f 2-5,8 -d , values.csv
```

जिसका अर्थ है:
"कॉलम 2 से 5 और कॉलम 8 चुनें,
कॉमा को सेपरेटर की तरह उपयोग करते हुए".
`cut` कॉलम बताने के लिए `-f` ("fields" का अर्थ) का उपयोग करता है
और सेपरेटर बताने के लिए `-d` ("delimiter" का अर्थ) का.
दूसरा विकल्प आपको इसलिए देना पड़ता है क्योंकि कुछ फाइलें कॉलम अलग करने के लिए स्पेस, टैब, या कॉलन का उपयोग कर सकती हैं.

<hr>

कौन-सा कमांड फाइल `spring.csv` से पहला कॉलम (जिसमें तारीखें हैं) चुनेगा?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- उपरोक्त में से कोई भी.
- उपरोक्त में से कोई नहीं, क्योंकि `-f` को `-d` से पहले आना चाहिए.

`@hint`
फ्लैग्स का क्रम मायने नहीं रखता।

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Yes, but that is not all', 'Yes, but that is not all', 'सही! ध्वज के बाद एक स्थान जोड़ना अच्छा शैली है, लेकिन अनिवार्य नहीं है।', 'नहीं, ध्वज का क्रम मायने नहीं रखता'])
```

---

## `cut` क्या नहीं कर सकता?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` एक सीधा-सादा कमांड है.
खासकर,
यह quoted strings नहीं समझता.
उदाहरण के लिए, अगर आपकी फ़ाइल है:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

तो:

```{shell}
cut -f 2 -d , everyone.csv
```

यह आउटपुट देगा:

```
Age
Ranjit"
Rupinder"
```

सबके age की बजाय,
क्योंकि यह आखिरी और पहले नाम के बीच के कॉमा को कॉलम सेपरेटर मानेगा.

<hr>

लाइन पर `cut -d : -f 2-4` का आउटपुट क्या होगा:

```
first:second:third:
```

(अंत में आने वाले कोलन पर ध्यान दें.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- उपरोक्त में से कोई नहीं, क्योंकि यहाँ चार फ़ील्ड नहीं हैं.

`@hint`
अंत में आने वाले कोलन पर ध्यान दें.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['नहीं, और भी है।', 'नहीं, और भी है।', 'सही! अंतिम कॉलन एक खाली चौथा फ़ील्ड बनाता है।', 'नहीं, `cut` अपनी पूरी कोशिश करता है।'])
```

---

## मैं कमांड्स दोबारा कैसे चला सकता/सकती हूँ?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

शेल का एक बड़ा फायदा यह है कि यह आपको काम दोहराना आसान बना देता है.
अगर आप कुछ कमांड्स चलाते हैं,
तो आप अप-ऐरो कुंजी दबाकर उन्हें पीछे की ओर स्क्रोल कर सकते हैं.
आप लेफ़्ट और राइट ऐरो कुंजियों और डिलीट कुंजी से उन्हें एडिट भी कर सकते हैं.
रिटर्न दबाने पर बदला हुआ कमांड चल जाएगा.

और भी अच्छा, `history` हाल ही में चलाए गए कमांड्स की सूची प्रिंट करता है.
हर कमांड के आगे एक सीरियल नंबर होता है ताकि किसी खास कमांड को फिर से चलाना आसान हो:
बस `!55` टाइप करें ताकि अपनी हिस्ट्री में 55वाँ कमांड दोबारा चलाएँ (अगर आपके पास इतने हों).
आप कमांड के नाम के आगे विस्मयादिबोधक चिह्न लगाकर भी उसे दोबारा चला सकते हैं,
जैसे `!head` या `!cut`,
जो उस कमांड के सबसे हाल के इस्तेमाल को फिर से चलाएगा.

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
अपने होम डायरेक्टरी में `head summer.csv` चलाएँ (जिसे फेल होना चाहिए).

`@hint`
अगर कोई मैच करता हुआ फ़ाइलनाम नहीं है तो टैब कम्प्लीशन काम नहीं करेगा.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="`head` और एक फ़ाइल नाम, `summer.csv` का उपयोग करें। यदि यह विफल हो जाता है तो चिंता न करें। यह होना चाहिए।")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
डायरेक्टरी बदलकर `seasonal` में जाएँ.

`@hint`
याद रखें कि `cd` का मतलब "change directory" होता है.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="यदि आपकी वर्तमान कार्य निर्देशिका (जिसे आप `pwd` के साथ पता कर सकते हैं) `/home/repl` है, तो आप `cd seasonal` के साथ `seasonal` फ़ोल्डर में जा सकते हैं।")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
`!head` का उपयोग करके `head` कमांड दोबारा चलाएँ.

`@hint`
`!` के बाद जो आता है उसके बीच में कोई स्पेस न टाइप करें.

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
                        incorrect_msg='`head` कमांड को दोहराने के लिए `!head` का उपयोग करें।'),
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
जो आपने किया है उसे देखने के लिए `history` का उपयोग करें.

`@hint`
ध्यान दें कि `history` सबसे हाल के कमांड्स को आख़िर में दिखाता है, ताकि इसके ख़त्म होने पर वे आपकी स्क्रीन पर ही रहें.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='पिछले आदेशों की सूची प्राप्त करने के लिए `history` का उपयोग बिना किसी फ्लैग के करें।')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
कमांड नंबर के साथ `!` लगाकर `head` फिर से चलाएँ.

`@hint`
`!` के बाद जो भी आए, उसके बीच में कोई स्पेस बिल्कुल न टाइप करें.

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
                        incorrect_msg='क्या आपने इतिहास से अंतिम `head` को पुनः चलाने के लिए `!<a_number>` का उपयोग किया है?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("शाबाश! अगले पर जाएं!")
```

---

## मैं खास मानों वाली पंक्तियाँ कैसे चुन सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` और `tail` पंक्तियाँ (rows) चुनते हैं,
`cut` कॉलम चुनता है,
और `grep` पंक्तियाँ उनके कंटेंट के आधार पर चुनता है.
सबसे सरल रूप में,
`grep` किसी टेक्स्ट के टुकड़े के बाद एक या अधिक फ़ाइलनाम लेता है
और उन फ़ाइलों की सभी पंक्तियाँ प्रिंट करता है जिनमें वह टेक्स्ट होता है.
उदाहरण के लिए,
`grep bicuspid seasonal/winter.csv`
`winter.csv` की वे पंक्तियाँ प्रिंट करता है जिनमें "bicuspid" होता है.

`grep` पैटर्न भी खोज सकता है;
हम उन्हें अगले कोर्स में देखेंगे.
अभी के लिए `grep` के कुछ आम फ्लैग अधिक महत्वपूर्ण हैं:

- `-c`: मिलान करने वाली पंक्तियों की बजाय उनकी गिनती प्रिंट करें
- `-h`: एक से अधिक फ़ाइलों में खोजते समय फ़ाइलों के नाम प्रिंट न करें
- `-i`: केस इग्नोर करें (जैसे, "Regression" और "regression" दोनों को मैच माने)
- `-l`: मैच की बजाय उन फ़ाइलों के नाम प्रिंट करें जिनमें मैच मिलते हैं
- `-n`: मिलान करने वाली पंक्तियों के लिए लाइन नंबर प्रिंट करें
- `-v`: मैच उल्टा करें, यानी सिर्फ वे पंक्तियाँ दिखाएँ जो मैच नहीं करतीं

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
अपने होम डायरेक्टरी में रहकर एक ही कमांड चलाकर `seasonal/autumn.csv` में `molar` शब्द वाली सभी पंक्तियों की सामग्री प्रिंट करें. कोई फ्लैग इस्तेमाल न करें.

`@hint`
`grep` का उपयोग उस शब्द और फ़ाइल/फ़ाइलों के नाम के साथ करें जिसमें आप खोजना चाहते हैं.

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
      has_code("grep", incorrect_msg = "क्या आपने `grep` को कॉल किया?"),
      has_code("molar", incorrect_msg = "क्या आपने `molar` को खोजा?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "क्या आपने `seasonal/autumn.csv` फ़ाइल को खोजा?")
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
मैच को उल्टा करें ताकि `seasonal/spring.csv` में वे सभी पंक्तियाँ मिलें जिनमें `molar` शब्द नहीं है, और उनके लाइन नंबर दिखाएँ.
याद रखें, अच्छा स्टाइल यह है कि सभी फ्लैग्स को अन्य मानों (जैसे फ़ाइलनाम या सर्च टर्म "molar") से पहले रखें.

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
      has_code("grep", incorrect_msg = "`grep` को कॉल किया क्या?"),
      has_code("-v", incorrect_msg = "`-v` के साथ मिलान को उल्टा किया क्या?"),
      has_code("-n", incorrect_msg = "`-n` के साथ पंक्ति संख्या दिखाई क्या?"),
      has_code("molar", incorrect_msg = "`molar` के लिए खोजा क्या?"),
      has_code("seasonal/spring.csv", incorrect_msg = "`seasonal/spring.csv` फ़ाइल को खोजा क्या?")
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
`autumn.csv` और `winter.csv` मिलाकर कितनी पंक्तियाँ `incisor` शब्द रखती हैं, उनकी गिनती करें.
(फिर से, अपने होम डायरेक्टरी से एक ही कमांड चलाएँ.)

`@hint`
पंक्तियों की गिनती के लिए `grep` के साथ `-c` का उपयोग करना याद रखें.

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
      has_code("grep", incorrect_msg = "क्या आपने `grep` को कॉल किया?"),
      has_code("-c", incorrect_msg = "क्या आपने `-c` के साथ गिनती प्राप्त की?"),
      has_code("incisor", incorrect_msg = "क्या आपने `incisor` के लिए खोज की?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "क्या आपने `seasonal/autumn.csv` फ़ाइल को खोजा?"),
      has_code("seasonal/winter.csv", incorrect_msg = "क्या आपने `seasonal/winter.csv` फ़ाइल को खोजा?")
    )
  )
)

```

---

## डेटा को हमेशा टेक्स्ट की तरह मानना सुरक्षित क्यों नहीं है?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

`cut` के मैनुअल पेज का `SEE ALSO` सेक्शन `paste` नाम के एक कमांड का ज़िक्र करता है,
जिसका उपयोग फाइलों को काटने के बजाय उन्हें जोड़ने के लिए किया जा सकता है।

<hr>

`paste` का मैनुअल पेज पढ़िए,
और फिर `paste` चलाकर autumn और winter की डेटा फाइलों को एक ही टेबल में
कॉमा को सेपरेटर की तरह इस्तेमाल करते हुए जोड़िए।
डेटा विश्लेषण (data analysis) के नज़रिए से आउटपुट में क्या समस्या है?

`@possible_answers`
- कॉलम हेडर दोहराए गए हैं।
- आखिरी कुछ पंक्तियों में कॉलमों की संख्या गलत है।
- `winter.csv` का कुछ डेटा गायब है।

`@hint`
यदि आप `paste` के आउटपुट को कॉमा को सेपरेटर बनाकर `cut` करें,
तो क्या वह सही उत्तर देगा?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'सही है, लेकिन यह आवश्यक रूप से एक त्रुटि नहीं है।'
correct2 = 'सही: कॉलम के साथ पंक्तियों को जोड़ने से शुरुआत में केवल एक खाली कॉलम बनता है, दो नहीं।'
err3 = 'नहीं, सभी शीतकालीन डेटा वहाँ है।'
Ex().has_chosen(2, [err1, correct2, err3])
```

---
title: टूल्स को मिलाकर उपयोग करना
description: >-
  Unix शेल की असली ताकत अलग-अलग कमांड्स में नहीं, बल्कि उन्हें नई चीज़ें करने के
  लिए आसानी से जोड़ने में है। यह चैप्टर आपको दिखाएगा कि मनचाहा डेटा चुनने के लिए
  इस ताकत का उपयोग कैसे करें, और वैल्यूज़ को sort करने तथा डुप्लिकेट्स हटाने के
  कमांड्स से परिचय कराएगा.
lessons:
  - nb_of_exercises: 12
    title: मैं किसी कमांड का आउटपुट फाइल में कैसे सहेज सकता/सकती हूँ?
---

## मैं किसी कमांड का आउटपुट फाइल में कैसे सहेज सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

अब तक आपने जिन भी टूल्स को देखा है, वे इनपुट फाइलों के नाम लेने देते हैं.
ज्यादातर में आउटपुट फाइल का नाम बताने का ऑप्शन नहीं होता, क्योंकि उसकी ज़रूरत नहीं पड़ती.
इसके बजाय,
आप **redirection** का उपयोग करके किसी भी कमांड का आउटपुट जहाँ चाहें सहेज सकते हैं.
अगर आप यह कमांड चलाते हैं:

```{shell}
head -n 5 seasonal/summer.csv
```

तो यह स्क्रीन पर summer डेटा की पहली 5 पंक्तियाँ प्रिंट करता है.
अगर आप इसकी जगह यह कमांड चलाते हैं:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

तो स्क्रीन पर कुछ नहीं दिखता.
इसके बजाय,
`head` का आउटपुट `top.csv` नाम की नई फाइल में डाल दिया जाता है.
आप `cat` का उपयोग करके उस फाइल की सामग्री देख सकते हैं:

```{shell}
cat top.csv
```

ग्रेटर-दैन साइन `>` शेल को बताता है कि `head` का आउटपुट एक फाइल में रीडायरेक्ट किया जाए.
यह `head` कमांड का हिस्सा नहीं है;
इसके बजाय,
यह हर उस शेल कमांड के साथ काम करता है जो आउटपुट बनाती है.

`@instructions`
`tail` को redirection के साथ मिलाइए और `seasonal/winter.csv` की आखिरी 5 पंक्तियाँ `last.csv` नाम की फाइल में सहेजिए.

`@hint`
आखिरी 5 पंक्तियाँ पाने के लिए `tail -n 5` का उपयोग करें.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "पंक्ति `%s` को फ़ाइल `last.csv` में होना चाहिए, लेकिन यह नहीं है। `tail -n 5 seasonal/winter.csv` के आउटपुट को `>` के साथ `last.csv` में रीडायरेक्ट करें।"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` में बहुत अधिक पंक्तियाँ हैं। क्या आपने `tail` के साथ `-n 5` फ्लैग का उपयोग किया?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("अच्छा! चलिए कुछ और अभ्यास करते हैं!")
```

---

## मैं किसी कमांड के आउटपुट को इनपुट के रूप में कैसे उपयोग कर सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

मान लीजिए आप किसी फ़ाइल के बीच की पंक्तियाँ निकालना चाहते हैं.
और विशेष रूप से,
मान लीजिए आप हमारी किसी डेटा फ़ाइल से पंक्तियाँ 3–5 लेना चाहते हैं.
आप `head` का उपयोग करके पहले 5 पंक्तियाँ निकालने से शुरू कर सकते हैं,
उसे एक फ़ाइल में रीडायरेक्ट करें,
और फिर `tail` का उपयोग करके आख़िरी 3 पंक्तियाँ चुनें:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

एक त्वरित जाँच से पुष्टि होती है कि ये हमारे मूल फ़ाइल की पंक्तियाँ 3–5 हैं,
क्योंकि ये पहले 5 में से आख़िरी 3 पंक्तियाँ हैं.

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
`seasonal/winter.csv` से आख़िरी दो पंक्तियाँ चुनें
और उन्हें `bottom.csv` नाम की फ़ाइल में सेव करें.

`@hint`
पंक्तियाँ चुनने के लिए `tail` का उपयोग करें और `tail` के आउटपुट को रीडायरेक्ट करने के लिए `>` का.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="पंक्ति `%s` फ़ाइल `bottom.csv` में होनी चाहिए, लेकिन यह नहीं है। `tail -n 2 seasonal/winter.csv` के आउटपुट को `>` के साथ `bottom.csv` में पुनर्निर्देशित करें।"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` में बहुत अधिक पंक्तियाँ हैं। क्या आपने `tail` के साथ `-n 2` फ्लैग का उपयोग किया?'),
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
मूल फ़ाइल की अंतिम से दूसरी पंक्ति पाने के लिए
`bottom.csv` से पहली पंक्ति चुनें.

`@hint`
वांछित पंक्ति चुनने के लिए `head` का उपयोग करें.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="`bottom.csv` फ़ाइल में कुछ गड़बड़ है। सुनिश्चित करें कि आपने इसे नहीं बदला है!"),
    has_expr_output(strict=True, incorrect_msg="क्या आपने `bottom.csv` पर `head` का सही उपयोग किया है? सुनिश्चित करें कि आपने `-n` फ्लैग का सही उपयोग किया है।")
)

Ex().success_msg("बहुत बढ़िया। अगले अभ्यास पर जाएं ताकि कमांड्स को संयोजित करने के बेहतर तरीकों के बारे में जान सकें।")                             

```

---

## कमांड्स को मिलाने का बेहतर तरीका क्या है?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

रीडायरेक्शन से कमांड्स को जोड़ने के दो नुकसान हैं:

1. बीच-बीच में बहुत सारी अस्थायी फाइलें बन जाती हैं (जैसे `top.csv`).
2. आपके अंतिम रिज़ल्ट को बनाने वाली कमांड्स हिस्ट्री में कई लाइनों पर बिखर जाती हैं.

शेल एक और टूल देता है जो इन दोनों समस्याओं को एक साथ हल करता है, जिसे **pipe** कहते हैं.
एक बार फिर,
`head` चलाकर शुरू कीजिए:

```{shell}
head -n 5 seasonal/summer.csv
```

`head` के आउटपुट को किसी फाइल में भेजने के बजाय,
एक वर्टिकल बार जोड़ें और `tail` कमांड को *बिना* किसी फ़ाइलनाम के चलाएँ:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

पाइप सिंबल शेल को बताता है कि बाएँ वाली कमांड का आउटपुट
दाएँ वाली कमांड के इनपुट के रूप में इस्तेमाल करना है.

`@instructions`
कॉमा-डिलिमिटेड फाइल `seasonal/summer.csv` के कॉलम 2 से सारे दाँतों के नाम चुनने के लिए `cut` का उपयोग करें, फिर रिज़ल्ट को पाइप करके उल्टी मैचिंग के साथ `grep` में भेजें ताकि "Tooth" शब्द वाली हेडर लाइन बाहर हो जाए. *`cut` और `grep` को क्रमशः अध्याय 2 के अभ्यास 8 और 11 में विस्तार से कवर किया गया था.*

`@hint`
- कमांड का पहला हिस्सा इस फ़ॉर्म में होता है: `cut -d field_delimiter -f column_number filename`.
- कमांड का दूसरा हिस्सा इस फ़ॉर्म में होता है: `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'क्या आपने `cut -d , -f 2 seasonal/summer.csv` के परिणाम को `grep -v Tooth` में `|` के साथ पाइप किया है?'),
    check_not(has_output("Tooth"), incorrect_msg = 'क्या आपने `grep` का उपयोग करके `"Tooth"` हेडर लाइन को बाहर रखा है?')
)
Ex().success_msg("सही पाइपिंग! यह पहली बार हो सकता है जब आपने `|` का उपयोग किया है, लेकिन यह निश्चित रूप से आखिरी नहीं है!")
```

---

## मैं कई कमांड्स को कैसे जोड़ सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

आप किसी भी संख्या में कमांड्स को चेन कर सकते/सकती हैं.
उदाहरण के लिए,
यह कमांड:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

यह करेगी:

1. spring डेटा से पहला कॉलम चुनेगी;
2. वह हेडर लाइन हटाएगी जिसमें "Date" शब्द है; और
3. वास्तविक डेटा की पहली 10 पंक्तियाँ चुनेगी।

`@instructions`
पिछले अभ्यास में, आपने `seasonal/summer.csv` की कॉलम 2 से सभी tooth नाम चुनने के लिए यह कमांड इस्तेमाल की थी:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

इस पाइपलाइन को `head` कमांड से बढ़ाइए ताकि केवल सबसे पहला tooth नाम ही चुना जाए।

`@hint`
निर्देशों में दिए गए कोड को कॉपी-पेस्ट करें, उसके बाद एक पाइप जोड़ें, फिर `-n` फ्लैग के साथ `head` कॉल करें।

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
    has_output('^\s*canine\s*$', incorrect_msg = "क्या आपने `|` का उपयोग करके पाइपलाइन को `head` कमांड के साथ विस्तारित किया है? सुनिश्चित करें कि आपने `-n` फ्लैग को सही ढंग से सेट किया है।"),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "क्या आपने `|` का उपयोग करके पाइपलाइन को `head` कमांड के साथ विस्तारित किया है?")
)
Ex().success_msg("उत्साहपूर्ण चेनिंग! कई कमांड्स को एक साथ चेन करके, आप शक्तिशाली डेटा मैनिपुलेशन पाइपलाइन्स बना सकते हैं।")
```

---

## मैं किसी फ़ाइल में रिकॉर्ड्स कैसे गिन सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

`wc` कमांड ("word count" का संक्षेप) किसी फ़ाइल में **c**haracters, **w**ords, और **l**ines की संख्या प्रिंट करती है.
आप इनमें से सिर्फ़ एक को प्रिंट कराने के लिए क्रमशः `-c`, `-w`, या `-l` का उपयोग कर सकते/सकती हैं.

`@instructions`
गिनें कि `seasonal/spring.csv` में कितने रिकॉर्ड्स की तिथियाँ July 2017 (`2017-07`) में हैं.
- इसके लिए `grep` के साथ आंशिक तारीख़ इस्तेमाल करके संबंधित लाइनों का चयन करें और इस परिणाम को पाइप करके `wc` में उपयुक्त फ्लैग के साथ भेजें ताकि लाइनों की गिनती हो सके.

`@hint`
- दिनांक का फ़ॉर्मेट याद करने के लिए `head seasonal/spring.csv` चलाएँ.
- कमांड का पहला हिस्सा इस रूप में होता है: `grep thing_to_match filename`.
- पाइप `|` के बाद `wc` को `-l` फ्लैग के साथ चलाएँ.

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
      has_code("grep", incorrect_msg = "क्या आपने `grep` को कॉल किया?"),
      has_code("2017-07", incorrect_msg = "क्या आपने `2017-07` को खोजा?"),
      has_code("seasonal/spring.csv", incorrect_msg = "क्या आपने `seasonal/spring.csv` फ़ाइल को खोजा?"),
      has_code("|", incorrect_msg = "क्या आपने `|` का उपयोग करके `wc` को पाइप किया?"),      
      has_code("wc", incorrect_msg = "क्या आपने `wc` को कॉल किया?"),
      has_code("-l", incorrect_msg = "क्या आपने `-l` के साथ लाइनों की गिनती की?")
    )
  )
)
Ex().success_msg("सावधानीपूर्वक गिनती! आपके पास कितना डेटा है, यह निर्धारित करना किसी भी डेटा विश्लेषण में पहला महत्वपूर्ण कदम है।")
```

---

## मैं एक साथ कई फाइलें कैसे निर्दिष्ट कर सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

अधिकांश शेल कमांड्स कई फाइलों पर काम कर लेते हैं अगर आप उन्हें कई फाइलनेम्स दें.
उदाहरण के लिए,
आप सभी seasonal डेटा फाइलों के पहले कॉलम एक साथ ऐसे निकाल सकते हैं:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

लेकिन कई फाइलों के नाम बार-बार टाइप करना अच्छा विचार नहीं है:
इसमें समय लगता है,
और जल्दी या देर आप कोई फाइल छोड़ देंगे या किसी फाइल का नाम दोहरा देंगे.
इसे आसान बनाने के लिए,
शेल आपको **वाइल्डकार्ड्स** इस्तेमाल करने देता है ताकि आप एक ही एक्सप्रेशन से फाइलों की लिस्ट दे सकें.
सबसे आम वाइल्डकार्ड `*` है,
जिसका मतलब है "शून्य या अधिक अक्षरों का मिलान".
इसे इस्तेमाल करके,
हम ऊपर दिए गए `cut` कमांड को छोटा करके यह लिख सकते हैं:

```{shell}
cut -d , -f 1 seasonal/*
```

या:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
`head` का उपयोग करते हुए एक ही कमांड लिखिए जो `seasonal/spring.csv` और `seasonal/summer.csv` दोनों से पहली तीन-तीन लाइनें निकाले — कुल मिलाकर छह लाइनें — लेकिन autumn या winter की डेटा फाइलों से नहीं.
फाइलों के पूरे नाम लिखने के बजाय एक वाइल्डकार्ड का उपयोग करें.

`@hint`
- कमांड का रूप `head -n number_of_lines filename_pattern` होता है.
- आप `a/b*` का उपयोग करके, उदाहरण के लिए, डायरेक्टरी `a` में `b` से शुरू होने वाली फाइलों को मैच कर सकते हैं.

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
    has_expr_output(incorrect_msg = "आप `seasonal/s*` का उपयोग `seasonal/spring.csv` और `seasonal/summer.csv` का चयन करने के लिए कर सकते हैं। सुनिश्चित करें कि प्रत्येक फ़ाइल की केवल पहली तीन पंक्तियाँ `-n` ध्वज के साथ शामिल हैं!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "कृपया `seasonal/autumn.csv` के लिए आउटपुट शामिल न करें। आप `seasonal/s*` का उपयोग `seasonal/spring.csv` और `seasonal/summer.csv` का चयन करने के लिए कर सकते हैं"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "कृपया `seasonal/winter.csv` के लिए आउटपुट शामिल न करें। आप `seasonal/s*` का उपयोग `seasonal/spring.csv` और `seasonal/summer.csv` का चयन करने के लिए कर सकते हैं")
)
Ex().success_msg("वाइल्ड वाइल्डकार्ड कार्य! यदि आपकी निर्देशिका में सैकड़ों या हजारों फ़ाइलें हैं, तो यह और भी महत्वपूर्ण हो जाता है।")
```

---

## और कौन-से वाइल्डकार्ड मैं इस्तेमाल कर सकता/सकती हूँ?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

शेल में कुछ और वाइल्डकार्ड भी होते हैं,
हालाँकि उनका इस्तेमाल कम होता है:

- `?` एक अकेले अक्षर से मैच करता है, इसलिए `201?.txt` `2017.txt` या `2018.txt` से मैच करेगा, लेकिन `2017-01.txt` से नहीं.
- `[...]` वर्ग कोष्ठकों के अंदर दिए किसी भी एक अक्षर से मैच करता है, इसलिए `201[78].txt` `2017.txt` या `2018.txt` से मैच करेगा, लेकिन `2016.txt` से नहीं.
- `{...}` कर्ली ब्रेसेज़ के अंदर कॉमा-सेपरेटेड किसी भी पैटर्न से मैच करता है, इसलिए `{*.txt, *.csv}` किसी भी फ़ाइल से मैच करेगा जिसका नाम `.txt` या `.csv` पर खत्म होता है, लेकिन उन फ़ाइलों से नहीं जिनका नाम `.pdf` पर खत्म होता है.

<hr/>

कौन-सी अभिव्यक्ति `singh.pdf` और `johel.txt` से मैच करेगी लेकिन `sandhu.pdf` या `sandhu.txt` से मैच नहीं करेगी?

`@hint`
हर फ़ाइल नाम पर बारी-बारी से हर अभिव्यक्ति को आज़माएँ और मिलान देखें.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- नहीं: `.pdf` और `.txt` फ़ाइलनाम नहीं हैं.
- नहीं: यह `sandhu.pdf` से भी मिल जाएगा.
- नहीं: वर्ग कोष्ठकों में दी गई अभिव्यक्ति केवल एक अक्षर से मेल खाती है, पूरे शब्दों से नहीं.
- सही!

---

## मैं टेक्स्ट की पंक्तियों को कैसे sort कर सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

जैसा कि इसके नाम से पता चलता है,
`sort` डेटा को क्रम में लगाता है.
डिफ़ॉल्ट रूप से यह आरोही वर्णानुक्रम में करता है,
लेकिन `-n` और `-r` फ़्लैग क्रमशः संख्यात्मक sort करने और आउटपुट के क्रम को उलटने के लिए उपयोग किए जा सकते हैं,
जबकि `-b` इसे शुरुआती खाली स्थानों को नज़रअंदाज़ करने के लिए कहता है
और `-f` इसे case **f**old करने (अर्थात् case-insensitive होने) के लिए कहता है.
पाइपलाइनें अक्सर अनचाहे रिकॉर्ड हटाने के लिए `grep` का उपयोग करती हैं
और फिर बचे हुए रिकॉर्ड को क्रम में लगाने के लिए `sort` का उपयोग करती हैं.

`@instructions`
क्या आपको `cut` और `grep` का संयोजन याद है जिससे `seasonal/summer.csv` की कॉलम 2 से सभी दाँतों के नाम चुने थे?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

इसी रेसिपी से शुरू करते हुए, `seasonal/winter.csv` (ना कि `summer.csv`) में दाँतों के नामों को अवरोही वर्णानुक्रम में sort करें. ऐसा करने के लिए, पाइपलाइन में `sort` का एक स्टेप जोड़ें.

`@hint`
निर्देशों में दी गई कमांड को कॉपी-पेस्ट करें, फ़ाइल का नाम बदलें, एक पाइप जोड़ें, फिर `sort` को `-r` फ़्लैग के साथ चलाएँ.

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
      has_code("cut", incorrect_msg = "क्या आपने `cut` को कॉल किया?"),
      has_code("-d", incorrect_msg = "क्या आपने `-d` के साथ एक फ़ील्ड डिलीमीटर निर्दिष्ट किया?"),
      has_code("seasonal/winter.csv", incorrect_msg = "क्या आपने `seasonal/winter.csv` फ़ाइल से डेटा प्राप्त किया?"),
      has_code("|", incorrect_msg = "क्या आपने `cut` से `grep` से `sort` तक `|` का उपयोग करके पाइप किया?"),      
      has_code("grep", incorrect_msg = "क्या आपने `grep` को कॉल किया?"),
      has_code("-v", incorrect_msg = "क्या आपने `-v` के साथ मैच को उल्टा किया?"),
      has_code("Tooth", incorrect_msg = "क्या आपने `Tooth` को खोजा?"),
      has_code("sort", incorrect_msg = "क्या आपने `sort` को कॉल किया?"),
      has_code("-r", incorrect_msg = "क्या आपने `-r` के साथ सॉर्ट ऑर्डर को उल्टा किया?")
    )
  )
)
Ex().success_msg("सॉर्ट किया गया! `sort` के कई उपयोग हैं। उदाहरण के लिए, `sort -n` को `head` के लिए पाइप करने से आपको सबसे बड़े मान दिखाई देते हैं।")
```

---

## मैं डुप्लिकेट लाइनों को कैसे हटाऊँ?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

`sort` के साथ अक्सर इस्तेमाल होने वाली एक और कमांड `uniq` है,
जिसका काम डुप्लिकेट लाइनों को हटाना है।
ज़्यादा सटीक रूप से कहें तो,
यह केवल पास-पास (adjacent) आई हुई डुप्लिकेट लाइनों को हटाती है।
अगर किसी फ़ाइल में यह हो:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

तो `uniq` यह आउटपुट देगी:

```
2017-07-03
2017-08-03
```

लेकिन अगर इसमें यह हो:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

तो `uniq` सारी चार लाइनें प्रिंट करेगी।
कारण यह है कि `uniq` बहुत बड़ी फ़ाइलों के साथ काम करने के लिए बनाई गई है।
यदि उसे फ़ाइल से दूर-दूर (non-adjacent) स्थित डुप्लिकेट लाइनों को हटाना हो,
तो उसे पूरी फ़ाइल मेमोरी में रखनी पड़ेगी
(या कम से कम,
अब तक देखी गई सारी यूनिक लाइनों को)।
सिर्फ़ पास-पास वाले डुप्लिकेट हटाने से
उसे मेमोरी में केवल सबसे हाल की यूनिक लाइन ही रखनी पड़ती है।

`@instructions`
एक पाइपलाइन लिखिए जो:

- `seasonal/winter.csv` की दूसरी कॉलम निकाले,
- आउटपुट में से "Tooth" शब्द हटाए ताकि केवल दाँतों के नाम दिखें,
- आउटपुट को sort करे ताकि किसी भी दाँत के नाम की सारी आवृत्तियाँ पास-पास आ जाएँ; और
- हर दाँत का नाम केवल एक बार उसके आने की गिनती के साथ दिखाए।

आपकी पाइपलाइन की शुरुआत पिछले अभ्यास जैसी ही है:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

इसे `sort` कमांड से बढ़ाइए, और `uniq -c` का उपयोग कीजिए ताकि प्रत्येक यूनिक लाइन उसके कुल काउंट के साथ दिखे, बजाय `uniq` और `wc` को साथ में इस्तेमाल करने के।

`@hint`
निर्देशों में दी गई कमांड को कॉपी-पेस्ट करें, बिना किसी फ़्लैग के `sort` को पाइप करें, फिर `uniq` को `-c` फ़्लैग के साथ दोबारा पाइप करें।

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
                     incorrect_msg="आपको इस कमांड से शुरू करना चाहिए: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`। अब इसे विस्तारित करें!"),
            has_code('\|\s+sort', incorrect_msg="क्या आपने कमांड को `| sort` के साथ विस्तारित किया है?"),
            has_code('\|\s+uniq', incorrect_msg="क्या आपने कमांड को `| uniq` के साथ विस्तारित किया है?"),
            has_code('-c', incorrect_msg="क्या आपने `-c` के साथ गिनती शामिल की है?")
        )
    )
)
Ex().success_msg("बहुत बढ़िया! पाइप पर इस सभी कार्य के बाद, क्या यह अच्छा नहीं होगा यदि हम परिणाम को संग्रहीत कर सकें?")
```

---

## Pipe का आउटपुट मैं कैसे सेव कर सकता/सकती हूँ?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Shell हमें piped commands की एक श्रृंखला के आउटपुट को redirect करने देता है:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

हालाँकि, `>` पाइपलाइन के अंत में ही होना चाहिए:
यदि हम इसे बीच में इस्तेमाल करने की कोशिश करें, इस तरह:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

तो `cut` का सारा आउटपुट `teeth-only.txt` में लिख दिया जाता है,
इसलिए `grep` के लिए कुछ भी नहीं बचता
और वह हमेशा के लिए इनपुट का इंतज़ार करता रहता है.

<hr>

क्या होता है अगर हम पाइपलाइन की शुरुआत में redirection लगा दें, जैसे:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [कमांड का आउटपुट सामान्य रूप से फ़ाइल में redirect हो जाता है.]
- Shell इसे एक त्रुटि के रूप में रिपोर्ट करता है.
- Shell हमेशा के लिए इनपुट का इंतज़ार करता रहता है.

`@hint`
Shell में इसे आज़माएँ.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['सही!', 'नहीं; शेल वास्तव में इसे निष्पादित कर सकता है।', 'नहीं; शेल वास्तव में इसे निष्पादित कर सकता है।'])
```

---

## मैं चल रहे प्रोग्राम को कैसे रोकूँ?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

अब तक आपने जो कमांड और स्क्रिप्ट चलाई हैं, वे सब जल्दी चल गईं,
लेकिन कुछ कामों में मिनटों, घंटों, या कभी-कभी दिनों तक का समय लग सकता है.
आप गलती से पाइपलाइन के बीच में रीडायरेक्शन भी लगा सकते हैं,
जिससे वह अटक सकती है.
अगर आप तय करें कि कोई प्रोग्राम आगे न चले,
तो आप `Ctrl` + `C` टाइप करके उसे खत्म कर सकते हैं.
Unix डॉक्यूमेंटेशन में इसे अक्सर `^C` लिखा जाता है;
ध्यान दें कि 'c' लोअर-केस हो सकता है.

`@instructions`
यह कमांड चलाएँ:

```{shell}
head
```

बिना किसी आर्ग्युमेंट के (ताकि यह ऐसे इनपुट का इंतज़ार करे जो कभी आएगा ही नहीं)
और फिर `Ctrl` + `C` टाइप करके इसे रोक दें.

`@hint`
बस head टाइप करें, Enter दबाएँ और चल रहे प्रोग्राम को `Ctrl` + `C` से बंद करें.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="क्या आपने `head` का उपयोग किया है?")
```

---

## समापन

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

समापन के लिए,
आप एक पाइपलाइन बनाएँगे ताकि यह पता चल सके कि मौसमी डेटा फाइलों में से सबसे छोटी फाइल में कितने रिकॉर्ड हैं.

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
सभी मौसमी डेटा फाइलों में लाइनों की संख्या सूचीबद्ध करने के लिए उपयुक्त पैरामीटरों के साथ `wc` का उपयोग करें.
(सभी फाइलनाम हाथ से टाइप करने के बजाय वाइल्डकार्ड का उपयोग करें.)

`@hint`
सिर्फ लाइनों की गणना दिखाने के लिए `-l` का उपयोग करें और फाइलनामों से मैच करने के लिए `*` का उपयोग करें.

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
      has_code("wc", incorrect_msg = "क्या आपने `wc` को कॉल किया?"),
      has_code("-l", incorrect_msg = "क्या आपने `-l` के साथ लाइनों की संख्या गिनी?"),
      has_code("seasonal/\*", incorrect_msg = "क्या आपने सभी `seasonal/*` फ़ाइलों से डेटा प्राप्त किया?")
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
पाइप का उपयोग करके पिछली कमांड में एक और कमांड जोड़ें ताकि "total" शब्द वाली लाइन हट जाए.

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
      has_code("wc", incorrect_msg = "क्या आपने `wc` को कॉल किया?"),
      has_code("-l", incorrect_msg = "क्या आपने `-l` के साथ लाइनों की संख्या गिनी?"),
      has_code("seasonal/\*", incorrect_msg = "क्या आपने सभी `seasonal/*` फाइलों से डेटा प्राप्त किया?"),
      has_code("|", incorrect_msg = "क्या आपने `wc` से `grep` तक पाइप का उपयोग `|` से किया?"),      
      has_code("grep", incorrect_msg = "क्या आपने `grep` को कॉल किया?"),
      has_code("-v", incorrect_msg = "क्या आपने `-v` के साथ मैच को उल्टा किया?"),
      has_code("total", incorrect_msg = "क्या आपने `total` को खोजा?")
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
पाइपलाइन में दो और चरण जोड़ें जो `sort -n` और `head -n 1` का उपयोग करके सबसे कम लाइनों वाली फाइल ढूँढें.

`@hint`
- संख्यात्मक रूप से sort करने के लिए `sort` का `-n` फ़्लैग उपयोग करें.
- केवल 1 लाइन रखने की सीमा तय करने के लिए `head` का `-n` फ़्लैग उपयोग करें.

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
      has_code("wc", incorrect_msg = "क्या आपने `wc` को कॉल किया?"),
      has_code("-l", incorrect_msg = "क्या आपने `-l` के साथ लाइनों की संख्या गिनी?"),
      has_code("seasonal/\*", incorrect_msg = "क्या आपने सभी `seasonal/*` फाइलों से डेटा प्राप्त किया?"),
      has_code("|", incorrect_msg = "क्या आपने `wc` से `grep` से `sort` से `head` तक पाइप किया `|` का उपयोग करते हुए?"),      
      has_code("grep", incorrect_msg = "क्या आपने `grep` को कॉल किया?"),
      has_code("-v", incorrect_msg = "क्या आपने `-v` के साथ मैच को उल्टा किया?"),
      has_code("total", incorrect_msg = "क्या आपने `total` के लिए खोज की?"),
      has_code("sort", incorrect_msg = "क्या आपने `sort` को कॉल किया?"),
      has_code("-n", incorrect_msg = "क्या आपने रखने के लिए लाइनों की संख्या को `-n` के साथ निर्दिष्ट किया?"),
      has_code("1", incorrect_msg = "क्या आपने `-n 1` के साथ 1 लाइन रखने के लिए निर्दिष्ट किया?")
    )
  )
)
Ex().success_msg("बहुत बढ़िया! यह पता चला कि `autumn.csv` वह फाइल है जिसमें सबसे कम लाइनें हैं। बैच प्रोसेसिंग के बारे में अधिक जानने के लिए अध्याय 4 पर जाएं!")
```

---
title: फाइलों और डायरेक्टरीज़ में बदलाव करना
description: >-
  यह चैप्टर Unix शेल का संक्षिप्त परिचय है। आप सीखेंगे कि लगभग 50 साल बाद भी यह
  आज क्यों उपयोग में है, यह आपके परिचित ग्राफिकल टूल्स से कैसे अलग है, शेल में
  कैसे नेविगेट करें, और फाइलों व फोल्डरों को बनाना, बदलना, और हटाना कैसे करें.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: शेल डेस्कटॉप इंटरफेस की तुलना में कैसी है?
---

## शेल की तुलना डेस्कटॉप इंटरफ़ेस से कैसे होती है?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Windows, Linux, या Mac OS जैसा ऑपरेटिंग सिस्टम एक विशेष प्रकार का प्रोग्राम होता है.
यह कंप्यूटर के प्रोसेसर, हार्ड ड्राइव, और नेटवर्क कनेक्शन को नियंत्रित करता है,
लेकिन इसका सबसे महत्वपूर्ण काम दूसरे प्रोग्राम चलाना है.

चूँकि इंसान डिजिटल नहीं हैं,
उन्हें ऑपरेटिंग सिस्टम से इंटरैक्ट करने के लिए एक इंटरफ़ेस चाहिए.
आजकल सबसे आम तरीका एक ग्राफिकल फाइल एक्सप्लोरर है,
जो क्लिक और डबल-क्लिक को फाइलें खोलने और प्रोग्राम चलाने के कमांड में बदल देता है.
कंप्यूटर्स के पास ग्राफिकल डिस्प्ले आने से पहले,
लोग एक **कमांड-लाइन शेल** नामक प्रोग्राम में निर्देश टाइप करते थे.
हर बार जब कोई कमांड दर्ज किया जाता है,
शेल कुछ अन्य प्रोग्राम चलाती है,
उनका आउटपुट मानव-पठनीय रूप में प्रिंट करती है,
और फिर अगला कमांड स्वीकार करने के लिए तैयार होने का संकेत देने हेतु एक *prompt* दिखाती है.
(इसका नाम इस विचार से आता है कि यह कंप्यूटर का "outer shell" है.)

क्लिक और ड्रैग करने की बजाय कमांड टाइप करना शुरुआत में भोंडा लग सकता है,
लेकिन जैसा आप देखेंगे,
जैसे ही आप स्पष्ट तौर पर बताते हैं कि आप कंप्यूटर से क्या कराना चाहते हैं,
आप पुराने कमांड को मिलाकर नए बना सकते हैं
और दोहराए जाने वाले कार्यों को
सिर्फ कुछ कीस्ट्रोक्स में ऑटोमेट कर सकते हैं.

<hr>
ज्यादातर लोग जिस ग्राफिकल फाइल एक्सप्लोरर का उपयोग करते हैं और कमांड-लाइन शेल के बीच क्या संबंध है?

`@hint`
याद रखें कि कोई उपयोगकर्ता किसी ऑपरेटिंग सिस्टम से केवल एक प्रोग्राम के माध्यम से ही इंटरैक्ट कर सकता है.

`@possible_answers`
- फाइल एक्सप्लोरर आपको फाइलें देखने और एडिट करने देता है, जबकि शेल आपको प्रोग्राम चलाने देती है.
- फाइल एक्सप्लोरर शेल के ऊपर बनाया गया है.
- शेल ऑपरेटिंग सिस्टम का हिस्सा है, जबकि फाइल एक्सप्लोरर अलग है.
- [दोनों ऑपरेटिंग सिस्टम को कमांड भेजने के इंटरफ़ेस हैं.]

`@feedback`
- दोनों आपको फाइलें देखने और एडिट करने तथा प्रोग्राम चलाने देते हैं.
- ग्राफिकल फाइल एक्सप्लोरर और शेल दोनों ही वही आंतरिक ऑपरेटिंग सिस्टम फंक्शन कॉल करते हैं.
- शेल और फाइल एक्सप्लोरर दोनों प्रोग्राम हैं जो उपयोगकर्ता के कमांड (टाइप किए गए या क्लिक किए गए) को ऑपरेटिंग सिस्टम कॉल में बदलते हैं.
- सही! दोनों उपयोगकर्ता के कमांड (चाहे टाइप किए गए हों या क्लिक किए गए) लेकर उन्हें ऑपरेटिंग सिस्टम को भेजते हैं.

---

## मैं कहाँ हूँ?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**फाइलसिस्टम** फाइलों और डायरेक्टरीज़ (या फोल्डर) को मैनेज करता है.
हर एक की पहचान एक **absolute path** से होती है,
जो दिखाता है कि फाइलसिस्टम की **root डायरेक्टरी** से वहाँ तक कैसे पहुँचा जाए:
`/home/repl` डायरेक्टरी `home` के अंदर की डायरेक्टरी `repl` है,
जबकि `/home/repl/course.txt` उसी डायरेक्टरी में फाइल `course.txt` है,
और अकेला `/` root डायरेक्टरी है.

यह जानने के लिए कि आप फाइलसिस्टम में अभी कहाँ हैं,
कमांड `pwd` चलाइए
(यह "**p**rint **w**orking **d**irectory" का संक्षेप है).
यह आपकी **current working directory** का absolute path प्रिंट करता है,
यही वह जगह है जहाँ शेल कमांड चलाता है और डिफ़ॉल्ट रूप से फाइलें ढूँढता है.

<hr>
`pwd` चलाइए.
आप अभी कहाँ हैं?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix सिस्टम आम तौर पर सभी उपयोगकर्ताओं की home डायरेक्टरीज़ को `/home` के अंदर रखते हैं.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "यह सही पथ नहीं है।"
correct = "सही - आप `/home/repl` में हैं।"

Ex().has_chosen(3, [err, err, correct])
```

---

## मैं फ़ाइलों और डायरेक्टरीज़ की पहचान कैसे करूँ?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` आपको बताता है कि आप कहाँ हैं.
यह जानने के लिए कि वहाँ क्या है,
`ls` टाइप करें (जो "**l**i**s**ting" का संक्षिप्त रूप है) और Enter दबाएँ.
अपने आप में,
`ls` आपकी current डायरेक्टरी की सामग्री सूचीबद्ध करता है
(वही जो `pwd` द्वारा दिखाई जाती है).
यदि आप कुछ फ़ाइलों के नाम जोड़ते हैं,
तो `ls` उन्हें सूचीबद्ध करेगा,
और यदि आप डायरेक्टरीज़ के नाम जोड़ते हैं,
तो यह उनकी सामग्री दिखाएगा.
उदाहरण के लिए,
`ls /home/repl` आपको आपकी starting डायरेक्टरी में क्या है, दिखाता है
(आम तौर पर इसे आपका **home directory** कहा जाता है).

<hr>
`ls` को उपयुक्त argument के साथ इस्तेमाल करके डायरेक्टरी `/home/repl/seasonal` में फ़ाइलों की सूची निकालें
(जिसमें तारीख के अनुसार, सीज़न के हिसाब से विभाजित, dental surgeries की जानकारी है).
इनमें से कौन-सी फ़ाइल उस डायरेक्टरी में नहीं है?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
यदि आप `ls` को कोई path देते हैं, तो यह उस path में क्या है, दिखाता है.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "वह फ़ाइल `seasonal` निर्देशिका में है।"
correct = "सही - वह फ़ाइल `seasonal` निर्देशिका में *नहीं* है।"

Ex().has_chosen(2, [err, correct, err, err])
```

---

## फाइलों और डायरेक्टरीज़ की पहचान और किन तरीकों से कर सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

एक absolute path latitude और longitude जैसा होता है: आप कहीं भी हों, उसका मान वही रहता है। इसके विपरीत, **relative path** आपकी मौजूदा लोकेशन से शुरू होकर जगह बताता है: जैसे कहना "20 किलोमीटर उत्तर"।

उदाहरण के लिए:
- अगर आप `/home/repl` डायरेक्टरी में हैं, तो **relative** path `seasonal` वही डायरेक्टरी बताता है जो **absolute** path `/home/repl/seasonal` है। 
- अगर आप `/home/repl/seasonal` डायरेक्टरी में हैं, तो **relative** path `winter.csv` वही फाइल बताता है जो **absolute** path `/home/repl/seasonal/winter.csv` है।

शेल पहले अक्षर को देखकर तय करता है कि path absolute है या relative: अगर यह `/` से शुरू होता है, तो absolute है। अगर यह `/` से शुरू *नहीं* होता, तो relative है।

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
आप `/home/repl` में हैं। `ls` को **relative path** के साथ चलाकर उस फाइल की लिस्ट दिखाइए जिसका absolute path `/home/repl/course.txt` है (और सिर्फ़ वही फाइल)।

`@hint`
अक्सर आप अपनी मौजूदा लोकेशन के absolute path को, जिस चीज़ का path चाहिए उसके absolute path से घटाकर, नीचे मौजूद किसी फाइल या डायरेक्टरी का relative path बना सकते हैं।

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "आपने फ़ाइल सूची उत्पन्न करने के लिए `ls` नहीं चलाया।"), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "आपकी कमांड ने सही फ़ाइल सूची उत्पन्न नहीं की। `/home/repl/course.txt` के सापेक्ष पथ के बाद `ls` का उपयोग करें।")
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
आप `/home/repl` में हैं。
`ls` को **relative** path के साथ चलाकर
फाइल `/home/repl/seasonal/summer.csv` की लिस्ट दिखाइए (और सिर्फ़ वही फाइल)।

`@hint`
Relative paths की शुरुआत शुरुआती '/' से *नहीं* होती।

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "आपने फ़ाइल सूची उत्पन्न करने के लिए `ls` नहीं बुलाया।"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "आपकी कमांड ने सही फ़ाइल सूची उत्पन्न नहीं की। `/home/repl/seasonal/summer.csv` के लिए सापेक्ष पथ के बाद `ls` का उपयोग करें।")
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
आप `/home/repl` में हैं。
`ls` को **relative** path के साथ चलाकर
डायरेक्टरी `/home/repl/people` की सामग्री की लिस्ट दिखाइए।

`@hint`
Relative paths की शुरुआत शुरुआती '/' से नहीं होती।

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "आपने फ़ाइल सूची उत्पन्न करने के लिए `ls` नहीं बुलाया।"), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "आपका कमांड सही फ़ाइल सूची उत्पन्न नहीं कर सका। `/home/repl/people` के सापेक्ष पथ के साथ `ls` का उपयोग करें।")
    )
)
Ex().success_msg("बहुत अच्छा किया। अब जब आप फ़ाइलों और निर्देशिकाओं की सूची के बारे में जानते हैं, तो आइए देखें कि आप फ़ाइल सिस्टम के चारों ओर कैसे घूम सकते हैं!")
```

---

## मैं किसी दूसरे डायरेक्टरी में कैसे जाऊँ?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

जिस तरह आप फ़ाइल ब्राउज़र में फ़ोल्डर पर डबल-क्लिक करके इधर-उधर जाते हैं,
उसी तरह आप फ़ाइलसिस्टम में `cd` कमांड का उपयोग करके भी जा सकते हैं
(जिसका मतलब है "change directory").

यदि आप `cd seasonal` टाइप करें और फिर `pwd` टाइप करें,
तो शेल बताएगा कि आप अब `/home/repl/seasonal` में हैं।
यदि आप उसके बाद केवल `ls` चलाएँ,
तो यह `/home/repl/seasonal` की सामग्री दिखाता है,
क्योंकि आप वहीं पर हैं।
यदि आप अपने होम डायरेक्टरी `/home/repl` पर वापस जाना चाहें,
तो आप `cd /home/repl` कमांड का उपयोग कर सकते हैं।

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
आप `/home/repl` में हैं.
relative path का उपयोग करके डायरेक्टरी बदलकर `/home/repl/seasonal` पर जाइए।

`@hint`
याद रखें कि `cd` का अर्थ "change directory" होता है और relative paths की शुरुआत आगे वाले '/' से नहीं होती।

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
key: e69c8eac15
xp: 35
```

`@instructions`
यह जाँचने के लिए `pwd` का उपयोग करें कि आप वहीं हैं।

`@hint`
कमांड दर्ज करने के बाद "enter" या "return" दबाना न भूलें।

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
उस डायरेक्टरी में क्या है यह देखने के लिए बिना किसी path के `ls` चलाएँ।

`@hint`
कमांड के बाद "enter" या "return" दबाना न भूलें।

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
      has_code('ls', incorrect_msg="आपके आदेश ने सही आउटपुट उत्पन्न नहीं किया। क्या आपने वर्तमान निर्देशिका की सामग्री दिखाने के लिए `ls` का उपयोग बिना किसी पथ के किया है?")
    )
)

Ex().success_msg("बहुत बढ़िया! यह उपनिर्देशिकाओं में नेविगेट करने के बारे में था। ऊपर की ओर बढ़ने के बारे में क्या? चलिए पता लगाते हैं!")
```

---

## मैं एक डायरेक्टरी ऊपर कैसे जा सकता/सकती हूँ?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

किसी डायरेक्टरी का **parent** वह डायरेक्टरी होती है जो उसके ऊपर होती है.
उदाहरण के लिए, `/home` `/home/repl` का parent है,
और `/home/repl` `/home/repl/seasonal` का parent है.
आप अपने parent डायरेक्टरी का absolute path हमेशा `cd` और `ls` जैसे कमांड्स को दे सकते हैं.
अधिकतर,
हालाँकि,
आप इस विशेष पथ `..` का फायदा उठाएँगे
(दो डॉट्स बिना स्पेस के), जिसका मतलब है "वह डायरेक्टरी जो मेरी मौजूदा डायरेक्टरी से ऊपर है".
अगर आप `/home/repl/seasonal` में हैं,
तो `cd ..` आपको `/home/repl` पर ले जाता है.
यदि आप फिर `cd ..` चलाते हैं,
तो आप `/home` में पहुँचते हैं.
एक और `cd ..` आपको *root डायरेक्टरी* `/` में ले जाता है,
जो फाइलसिस्टम का सबसे ऊपरी स्तर है.
(ध्यान रखें कि `cd` और `..` के बीच एक स्पेस रखें — यह एक कमांड और एक पाथ है, कोई एक चार-अक्षरी कमांड नहीं.)

अकेला एक डॉट, `.`, हमेशा "मौजूदा डायरेक्टरी" को दर्शाता है,
इसलिए अकेला `ls` और `ls .` एक ही काम करते हैं,
जबकि `cd .` का कोई असर नहीं होता
(क्योंकि यह आपको उसी डायरेक्टरी में ले जाता है जिसमें आप पहले से हैं).

आखिरी विशेष पथ `~` (टिल्डा कैरेक्टर) है,
जिसका मतलब है "आपकी home डायरेक्टरी",
जैसे `/home/repl`.
आप कहीं भी हों,
`ls ~` हमेशा आपकी home डायरेक्टरी की सामग्री दिखाएगा,
और `cd ~` आपको हमेशा home पर ले जाएगा.

<hr>
यदि आप `/home/repl/seasonal` में हैं,
तो `cd ~/../.` आपको कहाँ ले जाता है?

`@hint`
पथ को एक-एक डायरेक्टरी करके ट्रेस करें.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (root डायरेक्टरी)

`@feedback`
- नहीं, लेकिन अकेला `~` या `..` आपको वहाँ ले जाएगा.
- सही! यह पथ 'home डायरेक्टरी', 'एक स्तर ऊपर', 'यहीं' का मतलब देता है.
- नहीं, लेकिन अकेला `.` ऐसा कर देगा.
- नहीं, पथ का अंतिम भाग `.` है (अर्थ "यहीं") न कि `..` (अर्थ "ऊपर").

---

## मैं फाइलें कैसे कॉपी कर सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

अक्सर आपको फाइलें कॉपी करनी होंगी,
उन्हें व्यवस्थित करने के लिए दूसरी डायरेक्टरी में ले जाना होगा,
या उनके नाम बदलने होंगे.
इसे करने के लिए एक कमांड `cp` है, जो "copy" का छोटा रूप है.
अगर `original.txt` एक मौजूदा फाइल है,
तो:

```{shell}
cp original.txt duplicate.txt
```

`original.txt` की एक कॉपी बनती है जिसका नाम `duplicate.txt` होता है.
अगर `duplicate.txt` नाम की फाइल पहले से मौजूद है,
तो वह ओवरराइट हो जाती है.
अगर `cp` का आखिरी पैरामीटर कोई मौजूदा डायरेक्टरी है,
तो इस तरह का कमांड:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

उन सभी फाइलों को उस डायरेक्टरी में कॉपी कर देता है.

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
`seasonal/summer.csv` की एक कॉपी `backup` डायरेक्टरी (जो `/home/repl` में ही है) में बनाएँ,
और नई फाइल का नाम `summer.bck` रखें.

`@hint`
डेस्टिनेशन डायरेक्टरी के नाम और कॉपी की गई फाइल के नाम को जोड़कर
नए फाइल के लिए एक relative path बनाएँ.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` `backup` निर्देशिका में मौजूद नहीं प्रतीत होता है। `cp` को दो पथ प्रदान करें: मौजूदा फ़ाइल (`seasonal/summer.csv`) और गंतव्य फ़ाइल (`backup/summer.bck`)।"),
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
`seasonal` डायरेक्टरी से `spring.csv` और `summer.csv` को `backup` डायरेक्टरी में कॉपी करें,
और यह सब अपना current working directory (`/home/repl`) बदले बिना करें.

`@hint`
जिन फाइलों को आप कॉपी करना चाहते हैं उनके नामों के साथ `cp` का इस्तेमाल करें,
और उसके बाद जिस डायरेक्टरी में कॉपी करना है उसका नाम दें.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` प्रतीत नहीं होता कि इसे `backup` निर्देशिका में कॉपी किया गया है। `cp` को दो फ़ाइल नाम और एक निर्देशिका नाम प्रदान करें।"
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="सुनिश्चित करें कि आप `{{dir}}` में रहते हुए फ़ाइलों को कॉपी कर रहे हैं! वहां वापस जाने के लिए `cd {{dir}}` का उपयोग करें।"),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("अच्छा काम। कॉपी करने के अलावा, हमें एक निर्देशिका से दूसरी निर्देशिका में फ़ाइलों को स्थानांतरित करने में भी सक्षम होना चाहिए। इसके बारे में अगले अभ्यास में जानें!")
```

---

## मैं फ़ाइल को कैसे स्थानांतरित कर सकता/सकती हूँ?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

जहाँ `cp` किसी फ़ाइल की कॉपी बनाता है,
`mv` उसे एक डायरेक्टरी से दूसरी डायरेक्टरी में ले जाता है,
बिल्कुल वैसे ही जैसे आप उसे किसी ग्राफिकल फ़ाइल ब्राउज़र में ड्रैग करते हैं.
यह अपने पैरामीटर `cp` की ही तरह संभालता है,
इसलिए यह कमांड:

```{shell}
mv autumn.csv winter.csv ..
```

फ़ाइलें `autumn.csv` और `winter.csv` को मौजूदा वर्किंग डायरेक्टरी से
एक स्तर ऊपर उसकी पैरेंट डायरेक्टरी में ले जाती है
(क्योंकि `..` हमेशा आपकी वर्तमान लोकेशन से ऊपर वाली डायरेक्टरी को दर्शाता है).

`@instructions`
आप `/home/repl` में हैं, जिसमें `seasonal` और `backup` नाम की सब-डायरेक्टरीज़ हैं.
एक ही कमांड का उपयोग करके, `spring.csv` और `summer.csv` को `seasonal` से `backup` में ले जाएँ.

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
backup_patt="फ़ाइल `%s` `backup` निर्देशिका में नहीं है। क्या आपने `mv` का सही उपयोग किया है? `mv` के लिए दो फ़ाइल नाम और एक निर्देशिका को पैरामीटर के रूप में उपयोग करें।"
seasonal_patt="फ़ाइल `%s` अभी भी `seasonal` निर्देशिका में है। सुनिश्चित करें कि आप `mv` के साथ फ़ाइलों को स्थानांतरित कर रहे हैं न कि `cp` के साथ उन्हें कॉपी कर रहे हैं!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("बहुत अच्छा, चलिए इस शेल ट्रेन को जारी रखते हैं!")
```

---

## मैं फाइलों का नाम कैसे बदल सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` का इस्तेमाल फाइलों का नाम बदलने के लिए भी किया जा सकता है. अगर आप चलाते हैं:

```{shell}
mv course.txt old-course.txt
```

तो वर्तमान वर्किंग डायरेक्टरी में मौजूद `course.txt` फाइल "मूव" होकर `old-course.txt` नाम की फाइल बन जाती है.
यह तरीका फाइल ब्राउज़र से अलग है,
लेकिन अक्सर बहुत काम आता है.

एक चेतावनी:
बिलकुल `cp` की तरह,
`mv` भी मौजूदा फाइलों को ओवरराइट कर देगा.
यदि,
उदाहरण के लिए,
आपके पास पहले से `old-course.txt` नाम की फाइल है,
तो ऊपर दिया गया कमांड उसे `course.txt` की सामग्री से बदल देगा.

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
`seasonal` डायरेक्टरी में जाएँ.

`@hint`
याद रखें, `cd` का मतलब "change directory" होता है और relative paths की शुरुआत '/' से नहीं होती.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
फाइल `winter.csv` का नाम बदलकर `winter.csv.bck` करें.

`@hint`
`mv` को इसी क्रम में चलाएँ: पहले फाइल का मौजूदा नाम, फिर वह नया नाम जो आप देना चाहते हैं.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " `mv` का उपयोग दो तर्कों के साथ करें: वह फ़ाइल जिसे आप पुनः नामित करना चाहते हैं (`winter.csv`) और फ़ाइल का नया नाम (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="हम अपेक्षा कर रहे थे कि `winter.csv.bck` निर्देशिका में होगा।" + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="हम अब अपेक्षा नहीं कर रहे थे कि `winter.csv` निर्देशिका में होगा।" + hint)
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
पक्का करने के लिए `ls` चलाएँ कि सब ठीक से हुआ.

`@hint`
कमांड चलाने के लिए "enter" या "return" दबाना याद रखें.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="क्या आपने अपनी वर्तमान कार्यशील निर्देशिका की सामग्री को सूचीबद्ध करने के लिए `ls` का उपयोग किया है?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "आपके कमांड ने सही फ़ाइल सूची उत्पन्न नहीं की। अपनी वर्तमान कार्यशील निर्देशिका की सामग्री को सूचीबद्ध करने के लिए `ls` का उपयोग करें।")
    )
)
Ex().success_msg("कॉपी करना, स्थानांतरित करना, नाम बदलना, आपने सब कुछ समझ लिया है! अगला: फ़ाइलें हटाना।")
```

---

## मैं फाइलें कैसे डिलीट कर सकता/सकती हूँ?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

हम फाइलों को कॉपी कर सकते हैं और इधर-उधर मूव कर सकते हैं;
उन्हें डिलीट करने के लिए
हम `rm` का उपयोग करते हैं,
जिसका मतलब है "remove".
`cp` और `mv` की तरह ही,
आप `rm` को जितनी फाइलों के नाम देना चाहें दे सकते हैं, जैसे:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

यह कमांड `thesis.txt` और `backup/thesis-2017-08.txt` दोनों को हटा देता है।

`rm` बिल्कुल वही करता है जो इसका नाम बताता है,
और तुरन्त कर देता है:
ग्राफिकल फाइल ब्राउज़रों के विपरीत,
शेल में कोई ट्रैश कैन नहीं होता,
तो ऊपर दिया कमांड टाइप करते ही
आपका thesis हमेशा के लिए चला जाता है.

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
आप `/home/repl` में हैं।
`seasonal` डायरेक्टरी में जाएँ।

`@hint`
याद रखें, `cd` का मतलब "change directory" होता है और रिलेटिव पाथ की शुरुआत '/' से नहीं होती।

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
`autumn.csv` को हटा दें।

`@hint`
याद रखें, `rm` का मतलब "remove" होता है।

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="हमें उम्मीद नहीं थी कि `autumn.csv` अभी भी `seasonal` निर्देशिका में होगा। उस फ़ाइल को हटाने के लिए जिसका आप हटाना चाहते हैं, उसके पथ के साथ `rm` का उपयोग करें।"),
    has_code('rm', incorrect_msg = 'फ़ाइल को हटाने के लिए `rm` का उपयोग करें, बजाय इसे स्थानांतरित करने के।')
)

```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
वापस अपनी होम डायरेक्टरी में जाएँ।

`@hint`
अगर आप `cd` बिना किसी पाथ के चलाते हैं, तो यह आपको आपके होम पर ले जाता है।

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="`cd ..` या `cd ~` का उपयोग करके होम निर्देशिका पर लौटें।")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
बिना डायरेक्टरी बदले `seasonal/summer.csv` को डिलीट करें।

`@hint`
याद रखें, `rm` का मतलब "remove" होता है।

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="हमें उम्मीद नहीं थी कि `summer.csv` अभी भी `seasonal` निर्देशिका में होगा। उस फ़ाइल को हटाने के लिए `rm` का उपयोग करें जिसे आप हटाना चाहते हैं।"),
    has_code('rm', incorrect_msg = 'फ़ाइल को हटाने के लिए `rm` का उपयोग करें, बजाय इसे स्थानांतरित करने के।')
)
Ex().success_msg("प्रभावशाली कार्य! अगले पर चलते हैं!")
```

---

## मैं डायरेक्टरी कैसे बनाऊँ और मिटाऊँ?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` डायरेक्टरीज़ को वैसे ही ट्रीट करता है जैसे फाइलों को करता है:
यदि आप अपनी होम डायरेक्टरी में हैं और `mv seasonal by-season` चलाते हैं,
तो उदाहरण के लिए,
`mv` `seasonal` डायरेक्टरी का नाम बदलकर `by-season` कर देता है।
हालाँकि,
`rm` अलग तरह से काम करता है।

अगर आप किसी डायरेक्टरी पर `rm` चलाने की कोशिश करते हैं,
तो शेल एक एरर मैसेज प्रिंट करता है कि वह ऐसा नहीं कर सकता,
मुख्यतः इसलिए ताकि आप गलती से किसी पूरी डायरेक्टरी को न मिटा दें जिसमें आपका काम हो।
इसके बजाय,
आप `rmdir` नाम का अलग कमांड इस्तेमाल कर सकते हैं।
अतिरिक्त सुरक्षा के लिए,
यह तभी काम करता है जब डायरेक्टरी खाली हो,
इसलिए आपको डायरेक्टरी को मिटाने से *पहले* उसके अंदर की फाइलें हटानी होंगी।
(अनुभवी उपयोगकर्ता इसी प्रभाव के लिए `rm` के साथ `-r` ऑप्शन का उपयोग कर सकते हैं;
हम अगले अध्याय में कमांड ऑप्शन्स पर चर्चा करेंगे.)

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
डायरेक्टरी बदले बिना,
`people` डायरेक्टरी में मौजूद `agarwal.txt` फाइल को डिलीट करें।

`@hint`
याद रखें कि `rm` का अर्थ "remove" होता है और एक relative path की शुरुआत '/' से नहीं होती।

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` अब `/home/repl/people` में नहीं होना चाहिए। क्या आपने `rm` का सही उपयोग किया है?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = '`people` निर्देशिका में अभी भी फाइलें हैं। यदि आपने केवल `agarwal.txt` को स्थानांतरित किया है, या नई फाइलें बनाई हैं, तो उन्हें सभी हटा दें।')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
अब जबकि `people` डायरेक्टरी खाली है,
उसे एक ही कमांड से डिलीट करें।

`@hint`
ध्यान रखें कि `rm` केवल फाइलों पर काम करता है।

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "'people' निर्देशिका अब आपके होम निर्देशिका में नहीं होनी चाहिए। इसे हटाने के लिए `rmdir` का उपयोग करें!")
)

```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
क्योंकि डायरेक्टरी फाइल नहीं होती,
आपको नई (खाली) डायरेक्टरी बनाने के लिए `mkdir directory_name` कमांड का उपयोग करना होगा।
इस कमांड का उपयोग करके अपनी होम डायरेक्टरी के नीचे `yearly` नाम की नई डायरेक्टरी बनाएँ।

`@hint`
`mkdir` को उस डायरेक्टरी के नाम के साथ चलाएँ जिसे आप बनाना चाहते हैं।

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="आपकी होम डायरेक्टरी में `yearly` डायरेक्टरी नहीं है। इसे बनाने के लिए `mkdir yearly` का उपयोग करें!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
अब जब `yearly` मौजूद है,
अपनी होम डायरेक्टरी छोड़े *बिना* उसके अंदर `2017` नाम की एक और डायरेक्टरी बनाएँ।

`@hint`
जिस सब-डायरेक्टरी को आप बनाना चाहते हैं, उसके लिए relative path का उपयोग करें।

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="'/home/repl/yearly' में '2017' निर्देशिका नहीं मिल रही है। आप इस निर्देशिका को सापेक्ष पथ `yearly/2017` का उपयोग करके बना सकते हैं।")
)
Ex().success_msg("बहुत बढ़िया! आइए इस अध्याय को एक अभ्यास के साथ समाप्त करें जो इसके कुछ अवधारणाओं को दोहराता है!")
```

---

## समापन

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

डेटा का विश्लेषण करते समय आप अक्सर बीच-बीच में कुछ इंटरमीडिएट फाइलें बनाते हैं.
उन्हें अपने होम डायरेक्टरी में रखने के बजाय,
आप उन्हें `/tmp` में रख सकते हैं,
जहाँ लोग और प्रोग्राम आम तौर पर वे फाइलें रखते हैं जिनकी ज़रूरत थोड़ी देर के लिए ही होती है.
(ध्यान दें कि `/tmp` रूट डायरेक्टरी `/` के ठीक नीचे होता है,
आपके होम डायरेक्टरी के नीचे *नहीं*.)
यह समापन अभ्यास आपको ऐसा करना सिखाएगा.

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
`cd` का उपयोग करके `/tmp` में जाएँ.

`@hint`
याद रखें, `cd` का अर्थ "change directory" होता है और एक absolute path '/' से शुरू होता है.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'आप गलत निर्देशिका में हैं। `/tmp` निर्देशिका में बदलने के लिए `cd` का उपयोग करें।')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
बिना कोई डायरेक्टरी नाम टाइप किए `/tmp` की सामग्री सूचीबद्ध करें.

`@hint`
अगर आप `ls` को यह नहीं बताते कि क्या लिस्ट करना है, तो यह आपके current directory की सामग्री दिखाता है.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "आपने फ़ाइल सूची उत्पन्न करने के लिए `ls` नहीं बुलाया।"),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "आपकी कमांड ने सही फ़ाइल सूची उत्पन्न नहीं की। बिना `ls` का उपयोग करें।")
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
`/tmp` के अंदर `scratch` नाम की एक नई डायरेक्टरी बनाएँ.

`@hint`
डायरेक्टरी बनाने के लिए `mkdir` का उपयोग करें.

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
      has_code('mkdir +scratch', incorrect_msg="'/tmp' के अंतर्गत 'scratch' निर्देशिका नहीं मिल रही है। सुनिश्चित करें कि आपने `mkdir` का सही उपयोग किया है।")
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
`/home/repl/people/agarwal.txt` को `/tmp/scratch` में ले जाएँ.
हम सलाह देते हैं कि आप अपने होम डायरेक्टरी के लिए `~` शॉर्टकट और दूसरे पाथ के लिए absolute path की बजाय relative path का उपयोग करें.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="'/tmp/scratch' में 'agarwal.txt' नहीं मिल रहा है। पहले पैरामीटर के रूप में `~/people/agarwal.txt` और दूसरे के रूप में `scratch` का उपयोग करके `mv` का उपयोग करें।")
)
Ex().success_msg("यह शेल के परिचय के अध्याय 1 का समापन करता है! डेटा को संशोधित करने के बारे में अधिक जानने के लिए अगले अध्याय पर जाएं!")
```

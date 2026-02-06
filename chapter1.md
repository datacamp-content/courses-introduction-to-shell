---
title: Dateien und Verzeichnisse bearbeiten
description: >-
  Dieses Kapitel ist eine kurze Einführung in die Unix-shell. Du wirst erfahren,
  warum es nach fast 50 Jahren immer noch genutzt wird, wie es im Vergleich zu
  den dir vielleicht besser bekannten grafischen Tools abschneidet, wie du dich
  in der shell bewegst und wie du Dateien und Ordner erstellst, änderst und
  löschst.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Wie ist die shell im Vergleich zu einer Desktop-Oberfläche?
---

## Wie ist die shell im Vergleich zu einer Desktop-Oberfläche?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Ein Betriebssystem wie Windows, Linux oder Mac OS ist eine besondere Art von Programm.
Es steuert den Prozessor, die Festplatte und die Netzwerkverbindung des Computers.
Aber seine wichtigste Aufgabe ist, andere Programme zu starten.

Da Menschen nicht digital sind,
Sie brauchen eine Schnittstelle, um mit dem Betriebssystem zu interagieren.
Heutzutage ist der grafische Datei-Explorer am häufigsten.
das Klicks und Doppelklicks in Befehle zum Öffnen von Dateien und Ausführen von Programmen umwandelt.
Bevor Computer Bildschirme hatten,
allerdings
Die Leute haben Anweisungen in ein Programm namens **Befehlszeilen-Shell** eingegeben.
Jedes Mal, wenn ein Befehl eingegeben wird,
Die shell startet ein paar andere Programme,
druckt ihre Ausgabe in einer für Menschen lesbaren Form aus,
und zeigt dann eine *Eingabeaufforderung* an, um zu zeigen, dass es für den nächsten Befehl bereit ist.
(Der Name kommt von der Idee, dass es die „äußere Shell” des Computers ist.)

Das Tippen von Befehlen statt Klicken und Ziehen kann anfangs etwas umständlich sein,
aber wie du sehen wirst,
Sobald du anfängst zu erklären, was der Computer machen soll,
Du kannst alte Befehle kombinieren, um neue zu erstellen.
und wiederholte Vorgänge automatisieren
mit nur ein paar Tastenanschlägen.

<hr>
Was ist der Unterschied zwischen dem grafischen Datei-Explorer, den die meisten Leute benutzen, und der Befehlszeilen-Shell?

`@hint`
Denk dran, dass ein Benutzer nur über ein Programm mit einem Betriebssystem interagieren kann.

`@possible_answers`
- Mit dem Datei-Explorer kannst du Dateien anzeigen und bearbeiten, während du mit der shell Programme ausführen kannst.
- Der Datei-Explorer läuft auf der shell.
- Die shell ist Teil des Betriebssystems, während der Datei-Explorer separat ist.
- [Beide sind Schnittstellen, über die man Befehle an das Betriebssystem schicken kann.]

`@feedback`
- Mit beiden kannst du Dateien anzeigen und bearbeiten sowie Programme ausführen.
- Grafische Datei-Explorer und die shell nutzen beide die gleichen Funktionen des Betriebssystems.
- Die Shell und der Datei-Explorer sind Programme, die deine Befehle (eingegeben oder angeklickt) in Anweisungen an das Betriebssystem umwandeln.
- Richtig! Beide nehmen die Befehle vom Benutzer (egal ob getippt oder angeklickt) entgegen und schicken sie an das Betriebssystem.

---

## Wo bin ich?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

Das **Dateisystem** kümmert sich um Dateien und Verzeichnisse (oder Ordner).
Jeder wird durch einen **absoluten Pfad** identifiziert.
Das zeigt, wie du es vom **Stammverzeichnis** des Dateisystems aus erreichen kannst:
`/home/repl` Ist das Verzeichnis „ `repl` “ im Verzeichnis „ `home` “?
während „ `/home/repl/course.txt` “ eine Datei „ `course.txt` “ in diesem Verzeichnis ist,
und „ `/` “ allein ist das Stammverzeichnis.

Um herauszufinden, wo du dich im Dateisystem befindest,
den Befehl ausführen `pwd`
(Abkürzung für **„Arbeitsverzeichnis****drucken**“).
Das gibt den absoluten Pfad deines **aktuellen Arbeitsverzeichnisses** aus.
Hier führt die shell standardmäßig Befehle aus und sucht nach Dateien.

<hr>
Mach mal `pwd`.
Wo bist du gerade?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix-Systeme legen normalerweise die Home-Verzeichnisse aller Benutzer unter `/home` ab.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Das ist nicht der richtige Pfad."
correct = "Korrekt - Sie befinden sich in `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Wie kann ich Dateien und Verzeichnisse erkennen?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` sagt dir, wo du bist.
Um herauszufinden, was da ist,
Gib „ `ls` “ ein (das ist die Abkürzung für**„listing“**) und drück die Eingabetaste.
Für sich genommen
`ls` listet den Inhalt deines aktuellen Verzeichnisses auf
(das unter `pwd` angezeigt wird).
Wenn du die Namen einiger Dateien hinzufügst,
`ls` werde sie auflisten,
und wenn du die Namen der Verzeichnisse hinzufügst,
Es zeigt dir den Inhalt an.
Ein Beispiel:
`ls /home/repl` zeigt dir, was in deinem Startverzeichnis drin ist
(normalerweise als dein **Home-Verzeichnis** bezeichnet).

<hr>
Benutze `ls` mit dem richtigen Argument, um die Dateien im Verzeichnis `/home/repl/seasonal` aufzulisten.
(mit Infos zu Zahnarztterminen nach Datum, aufgeschlüsselt nach Jahreszeiten).
Welche dieser Dateien ist *nicht* in diesem Verzeichnis?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Wenn du „ `ls` “ einen Pfad gibst, zeigt es dir, was in diesem Pfad drin ist.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Diese Datei befindet sich im Verzeichnis `seasonal`."
correct = "Korrekt - diese Datei befindet sich *nicht* im Verzeichnis `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Wie kann ich sonst noch Dateien und Verzeichnisse erkennen?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Ein absoluter Pfad ist wie ein Längen- und Breitengrad: Er hat immer denselben Wert, egal wo du bist. Ein **relativer Pfad** hingegen gibt einen Ort an, der von deinem aktuellen Standort aus berechnet wird: Das ist so, als würde man sagen „20 Kilometer nördlich“.

Zum Beispiel:
- Wenn du im Verzeichnis „ `/home/repl` ” bist, zeigt der **relative** Pfad „ `seasonal` ” auf dasselbe Verzeichnis wie der **absolute** Pfad „ `/home/repl/seasonal` ”. 
- Wenn du im Verzeichnis „ `/home/repl/seasonal` ” bist, zeigt der **relative** Pfad „ `winter.csv` ” auf dieselbe Datei wie der **absolute** Pfad „ `/home/repl/seasonal/winter.csv` ”.

Die shell entscheidet anhand des ersten Zeichens, ob ein Pfad absolut oder relativ ist: Wenn es mit „ `/` “ anfängt, ist es absolut. Wenn es *nicht* mit `/` anfängt, ist es relativ.

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
Du bist in „ `/home/repl` “. Benutze „ `ls` “ mit einem **relativen Pfad**, um die Datei mit dem absoluten Pfad „ `/home/repl/course.txt` “ (und nur diese Datei) aufzulisten.

`@hint`
Du kannst oft den relativen Pfad zu einer Datei oder einem Verzeichnis unterhalb deines aktuellen Speicherorts erstellen.
indem du den absoluten Pfad deines aktuellen Standorts abziehst
vom absoluten Pfad des gewünschten Objekts.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Sie haben `ls` nicht aufgerufen, um die Dateiliste zu erstellen."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Ihr Befehl hat nicht die richtige Dateiliste erstellt. Verwenden Sie `ls` gefolgt von einem relativen Pfad zu `/home/repl/course.txt`.")
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
Du bist in „ `/home/repl` “.
Benutze `ls` mit einem **relativen** Pfad.
Die Datei „ `/home/repl/seasonal/summer.csv` “ (und nur diese Datei) auflisten.

`@hint`
Relative Pfade fangen *nicht* mit einem führenden '/' an.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Sie haben `ls` nicht aufgerufen, um die Dateiliste zu erstellen."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Ihr Befehl hat nicht die richtige Dateiliste erstellt. Verwenden Sie `ls` gefolgt von einem relativen Pfad zu `/home/repl/seasonal/summer.csv`.")
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
Du bist in „ `/home/repl` “.
Benutze `ls` mit einem **relativen** Pfad.
Um den Inhalt des Verzeichnisses „ `/home/repl/people` “ aufzulisten.

`@hint`
Relative Pfade fangen nicht mit einem führenden '/' an.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Sie haben `ls` nicht aufgerufen, um die Dateiliste zu erstellen."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Ihr Befehl hat nicht die richtige Dateiliste erstellt. Verwenden Sie `ls` gefolgt von einem relativen Pfad zu `/home/repl/people`.")
    )
)
Ex().success_msg("Gut gemacht. Jetzt, da Sie wissen, wie man Dateien und Verzeichnisse auflistet, sehen wir uns an, wie Sie sich im Dateisystem bewegen können!")

```

---

## Wie kann ich in ein anderes Verzeichnis wechseln?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Genauso wie du dich in einem Dateibrowser durch Doppelklicken auf Ordner bewegen kannst,
Du kannst dich mit dem Befehl im Dateisystem bewegen. `cd`
(was für „Verzeichnis wechseln“ steht).

Wenn du `cd seasonal` eingibst und dann `pwd` eingibst,
Die shell zeigt dir an, dass du dich jetzt in „ `/home/repl/seasonal` “ befindest.
Wenn du dann „ `ls` “ alleine ausführst,
Es zeigt dir den Inhalt von `/home/repl/seasonal`,
Weil du da bist.
Wenn du zurück zu deinem Home-Verzeichnis „ `/home/repl` “ willst,
Du kannst den Befehl „ `cd /home/repl` “ benutzen.

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
Du bist auf `/home/repl`/.
Wechsle mit einem relativen Pfad ins Verzeichnis „ `/home/repl/seasonal` “.

`@hint`
Denk dran, dass „ `cd` ” für „Verzeichnis wechseln” steht und dass relative Pfade nicht mit einem führenden „/” anfangen.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Wenn Ihr aktuelles Arbeitsverzeichnis (finden Sie mit `pwd` heraus) `/home/repl` ist, können Sie mit `cd seasonal` in den Ordner `seasonal` wechseln.")
)
```

***

```yaml
type: ConsoleExercise
key: e69c8eac15
xp: 35
```

`@instructions`
Schau mal auf `pwd` nach, ob du da bist.

`@hint`
Denk dran, nach der Eingabe des Befehls die Eingabetaste zu drücken.

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
Benutze „ `ls` “ ohne Pfade, um zu sehen, was in diesem Verzeichnis ist.

`@hint`
Denk dran, nach dem Befehl auf „Enter“ oder „Return“ zu drücken.

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
      has_code('ls', incorrect_msg="Ihr Befehl hat nicht die korrekte Ausgabe erzeugt. Haben Sie `ls` ohne Pfade verwendet, um den Inhalt des aktuellen Verzeichnisses anzuzeigen?")
    )
)

Ex().success_msg("Sauber! Hier ging es darum, in Unterverzeichnisse zu navigieren. Wie wäre es mit dem Aufstieg? Finden wir es heraus!")
```

---

## Wie kann ich ein Verzeichnis nach oben verschieben?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

Das **übergeordnete Verzeichnis** eines Verzeichnisses ist das Verzeichnis, das sich darüber befindet.
Zum Beispiel ist `/home` die übergeordnete Seite von `/home/repl`.
Und „ `/home/repl` “ ist die übergeordnete Seite von „ `/home/repl/seasonal` “.
Du kannst immer den absoluten Pfad deines übergeordneten Verzeichnisses für Befehle wie „ `cd` “ und „ `ls` “ angeben.
Oft
allerdings
Du wirst davon profitieren, dass der spezielle Pfad `..`
(zwei Punkte ohne Leerzeichen) heißt „das Verzeichnis über dem, in dem ich gerade bin“.
Wenn du in „ `/home/repl/seasonal` “ bist,
Dann geht man von `cd ..` zu `/home/repl`.
Wenn du `cd ..` nochmal benutzt,
Das bringt dich auf `/home`.
Noch ein „ `cd ..` “ bringt dich ins Stamm *ver* zeichnis „ `/` “.
Das ist die oberste Ebene des Dateisystems.
(Denk dran, zwischen „ `cd` ” und „ `..` ” ein Leerzeichen zu lassen – es ist ein Befehl und ein Pfad, kein einzelner vierstelliger Befehl.)

Ein einzelner Punkt allein, `.`, bedeutet immer „das aktuelle Verzeichnis“.
Also, „ `ls` “ allein und „ `ls .` “ machen dasselbe.
während „ `cd .` “ nichts macht
(weil du dadurch in das Verzeichnis kommst, in dem du gerade bist).

Ein letzter spezieller Pfad ist `~` (das Tilde-Zeichen),
was so viel heißt wie „dein Home-Verzeichnis“,
wie zum Beispiel `/home/repl`.
Egal, wo du bist,
`ls ~` zeigt immer den Inhalt deines Home-Verzeichnisses an,
und „ `cd ~` “ bringt dich immer nach Hause.

<hr>
Wenn du dich in `/home/repl/seasonal` befindest,
Wohin führt dich „cd ~/../.“?

`@hint`
Geh den Pfad Verzeichnis für Verzeichnis durch.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (das Stammverzeichnis)

`@feedback`
- Nein, aber entweder `~` oder `..` allein würde dich dorthin bringen.
- Richtig! Der Pfad bedeutet „Home-Verzeichnis“, „eine Ebene höher“, „hier“.
- Nein, aber „ `.` “ allein würde das schon erledigen.
- Nein, der letzte Teil des Pfades ist `.` (was „hier” bedeutet) und nicht `..` (was „oben” bedeutet).

---

## Wie kann ich Dateien kopieren?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Du wirst oft Dateien kopieren wollen,
Verschiebt sie in andere Ordner, um sie zu sortieren.
oder sie umbenennen.
Ein Befehl dafür ist „ `cp` “, was kurz für „copy“ (kopieren) steht.
Wenn „ `original.txt` “ schon existiert,
dann:

```{shell}
cp original.txt duplicate.txt
```

Erstellt eine Kopie von „ `original.txt` “ mit dem Namen „ `duplicate.txt` “.
Wenn es schon eine Datei namens „ `duplicate.txt` “ gab,
Es wird überschrieben.
Wenn der letzte Parameter von „ `cp` “ ein vorhandenes Verzeichnis ist,
dann ein Befehl wie:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

kopiert *alle* Dateien in dieses Verzeichnis.

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
Mach eine Kopie von „ `seasonal/summer.csv` ” im Verzeichnis „ `backup` ” (das du auch unter „ `/home/repl` ” findest).
Die neue Datei heißt jetzt „ `summer.bck` “.

`@hint`
Kombiniere den Namen des Zielverzeichnisses und den Namen der kopierten Datei.
einen relativen Pfad für die neue Datei erstellen.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` scheint nicht im Verzeichnis `backup` zu existieren. Geben Sie zwei Pfade an `cp` an: die vorhandene Datei (`seasonal/summer.csv`) und die Zieldatei (`backup/summer.bck`)."),
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
Kopier die Dateien „ `spring.csv` “ und „ `summer.csv` “ aus dem Verzeichnis „ `seasonal` “ in das Verzeichnis „ `backup` “.
*ohne* dein aktuelles Arbeitsverzeichnis zu ändern (`/home/repl`).

`@hint`
Benutze „ `cp` “ mit den Namen der Dateien, die du kopieren willst.
und *dann* den Namen des Verzeichnisses, in das sie kopiert werden sollen.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` scheint nicht in das `backup` Verzeichnis kopiert worden zu sein. Geben Sie zwei Dateinamen und einen Verzeichnisnamen an `cp` an."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Stellen Sie sicher, dass Sie die Dateien im Verzeichnis `{{dir}}` kopieren! Verwenden Sie `cd {{dir}}`, um dorthin zurück zu navigieren."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Gut gemacht. Neben dem Kopieren sollten wir auch in der Lage sein, Dateien von einem Verzeichnis in ein anderes zu verschieben. Lernen Sie mehr darüber in der nächsten Übung!")
```

---

## Wie kann ich eine Datei verschieben?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Während „ `cp` “ eine Datei kopiert,
`mv` verschiebt es von einem Verzeichnis in ein anderes,
Genau so, als hättest du es in einem grafischen Dateibrowser gezogen.
Es geht mit seinen Parametern genauso um wie `cp`,
also der Befehl:

```{shell}
mv autumn.csv winter.csv ..
```

verschiebt die Dateien „ `autumn.csv` “ und „ `winter.csv` “ aus dem aktuellen Arbeitsverzeichnis
eine Ebene höher zum übergeordneten Verzeichnis
(Weil `..` immer auf das Verzeichnis über deinem aktuellen Standort zeigt.)

`@instructions`
Du bist im Verzeichnis „ `/home/repl` ”, das die Unterverzeichnisse „ `seasonal` ” und „ `backup` ” hat.
Verschieb mit einem einzigen Befehl die Dateien „ `spring.csv` “ und „ `summer.csv` “ von „ `seasonal` “ nach „ `backup` “.

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
backup_patt="Die Datei `%s` befindet sich nicht im Verzeichnis `backup`. Haben Sie `mv` korrekt verwendet? Verwenden Sie zwei Dateinamen und ein Verzeichnis als Parameter für `mv`."
seasonal_patt="Die Datei `%s` befindet sich noch im Verzeichnis `seasonal`. Stellen Sie sicher, dass Sie die Dateien mit `mv` verschieben, anstatt sie mit `cp` zu kopieren!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Gut gemacht, lassen Sie uns diesen Shell-Zug weiterfahren!")
```

---

## Wie kann ich Dateien umbenennen?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` kann auch zum Umbenennen von Dateien verwendet werden. Wenn du ausführst:

```{shell}
mv course.txt old-course.txt
```

Dann wird die Datei „ `course.txt` ” im aktuellen Arbeitsverzeichnis nach „ `old-course.txt` ” verschoben.
Das ist anders als bei Dateibrowsern,
aber oft praktisch.

Eine Warnung:
Genau wie `cp`,
`mv` wird vorhandene Dateien überschreiben.
Wenn
zum Beispiel
Du hast schon eine Datei namens „ `old-course.txt` “,
Dann ersetzt der oben gezeigte Befehl das durch das, was in „ `course.txt` “ steht.

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
Geh ins Verzeichnis „ `seasonal` “.

`@hint`
Denk dran, dass „ `cd` ” für „Verzeichnis wechseln” steht und dass relative Pfade nicht mit einem führenden „/” anfangen.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Wenn Ihr aktuelles Arbeitsverzeichnis (finden Sie mit `pwd` heraus) `/home/repl` ist, können Sie mit `cd seasonal` in den Ordner `seasonal` wechseln.")
)
```

***

```yaml
type: ConsoleExercise
key: ed5fe1df23
xp: 35
```

`@instructions`
Benenne die Datei „ `winter.csv` ” in „ `winter.csv.bck` ” um.

`@hint`
Benutze „ `mv` “ mit dem aktuellen Namen der Datei und dem gewünschten Namen in dieser Reihenfolge.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Verwenden Sie `mv` mit zwei Argumenten: die Datei, die Sie umbenennen möchten (`winter.csv`), und den neuen Namen für die Datei (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Wir erwarteten, `winter.csv.bck` im Verzeichnis zu finden." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Wir erwarteten nicht mehr, `winter.csv` im Verzeichnis zu finden." + hint)
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
Mach mal „ `ls` “, um zu checken, ob alles geklappt hat.

`@hint`
Denk dran, auf „Enter“ oder „Return“ zu drücken, um den Befehl auszuführen.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Haben Sie `ls` verwendet, um den Inhalt Ihres aktuellen Arbeitsverzeichnisses aufzulisten?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Ihr Befehl hat nicht die korrekte Dateiliste erzeugt. Verwenden Sie `ls` ohne Argumente, um den Inhalt Ihres aktuellen Arbeitsverzeichnisses aufzulisten.")
    )
)
Ex().success_msg("Kopieren, verschieben, umbenennen, Sie haben alles im Griff! Als nächstes: Dateien löschen.")
```

---

## Wie kann ich Dateien löschen?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Wir können Dateien kopieren und verschieben;
um sie zu löschen,
Wir nutzen `rm`,
was für „entfernen“ steht.
Genau wie bei `cp` und `mv`,
Du kannst „ `rm` “ so viele Dateinamen übergeben, wie du willst, also:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

entfernt sowohl `thesis.txt` als auch `backup/thesis-2017-08.txt`

`rm` macht genau das, was der Name sagt,
und das geht echt schnell:
anders als grafische Dateibrowser,
The shell has no trash can.
Wenn du also den obigen Befehl eingibst,
Deine Abschlussarbeit ist endgültig weg.

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
Du bist in „ `/home/repl` “.
Geh ins Verzeichnis „ `seasonal` “.

`@hint`
Denk dran, dass „ `cd` ” für „Verzeichnis wechseln” steht und dass ein relativer Pfad nicht mit einem führenden „/” anfängt.

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
Entferne `autumn.csv`.

`@hint`
Denk dran, dass „ `rm` ” „entfernen” heißt.

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Wir haben nicht erwartet, dass `autumn.csv` noch im Verzeichnis `seasonal` ist. Verwenden Sie `rm` mit dem Pfad zu der Datei, die Sie entfernen möchten."),
    has_code('rm', incorrect_msg = 'Verwenden Sie `rm`, um die Datei zu entfernen, anstatt sie zu verschieben.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Geh zurück zu deinem Home-Verzeichnis.

`@hint`
Wenn du `cd` ohne Pfadangabe benutzt, kommst du auf die Startseite.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Verwenden Sie `cd ..` oder `cd ~`, um in das Home-Verzeichnis zurückzukehren.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Entferne „ `seasonal/summer.csv` “, ohne das Verzeichnis wieder zu ändern.

`@hint`
Denk dran, dass „ `rm` ” „entfernen” heißt.

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Wir haben nicht erwartet, dass `summer.csv` noch im Verzeichnis `seasonal` ist. Verwenden Sie `rm` mit dem Pfad zur Datei, die Sie entfernen möchten."),
    has_code('rm', incorrect_msg = 'Verwenden Sie `rm`, um die Datei zu entfernen, anstatt sie zu verschieben.')
)
Ex().success_msg("Beeindruckende Sache! Weiter zum nächsten!")
```

---

## Wie kann ich Verzeichnisse erstellen und löschen?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` behandelt Verzeichnisse genauso wie Dateien:
Wenn du in deinem Home-Verzeichnis bist und „ `mv seasonal by-season` “ ausführst,
zum Beispiel
`mv` Ändert den Namen des Verzeichnisses „ `seasonal` “ in „ `by-season` “.
Allerdings
`rm` funktioniert anders.

Wenn du versuchst, ein Verzeichnis zu `rm`,
Die shell zeigt 'ne Fehlermeldung an, dass sie das nicht machen kann.
Hauptsächlich, um zu verhindern, dass du aus Versehen ein ganzes Verzeichnis mit deiner Arbeit löschst.
Stattdessen
Du kannst einen separaten Befehl namens „ `rmdir` “ verwenden.
Für mehr Sicherheit
Es klappt nur, wenn das Verzeichnis leer ist.
Du musst also die Dateien in einem Verzeichnis löschen, *bevor* du das Verzeichnis löschst.
(Erfahrene Nutzer können die Option „ `-r` “ verwenden, um „ `rm` “ zu erreichen und so den gleichen Effekt zu erzielen.
Wir werden die Befehlsoptionen im nächsten Kapitel besprechen.)

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
Ohne das Verzeichnis zu wechseln,
Lösch die Datei „ `agarwal.txt` ” im Verzeichnis „ `people` ”.

`@hint`
Denk dran, dass „ `rm` ” „entfernen” heißt und dass ein relativer Pfad nicht mit einem führenden „/” anfängt.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` sollte nicht mehr in `/home/repl/people` sein. Hast du `rm` korrekt verwendet?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'Es gibt immer noch Dateien im Verzeichnis `people`. Wenn du `agarwal.txt` nur verschoben oder neue Dateien erstellt hast, lösche sie alle.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Jetzt, wo das Verzeichnis „ `people` “ leer ist,
Lös das mit einem einzigen Befehl.

`@hint`
Denk dran, dass „ `rm` “ nur bei Dateien funktioniert.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "Das Verzeichnis 'people' sollte nicht mehr in Ihrem Home-Verzeichnis sein. Verwenden Sie `rmdir`, um es zu entfernen!")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Da ein Verzeichnis keine Datei ist,
Du musst den Befehl verwenden `mkdir directory_name`
ein neues (leeres) Verzeichnis erstellen.
Benutz diesen Befehl, um ein neues Verzeichnis namens „ `yearly` ” unter deinem Home-Verzeichnis zu erstellen.

`@hint`
Mach mal „ `mkdir` “ mit dem Namen des Verzeichnisses, das du erstellen willst.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Es gibt kein `yearly` Verzeichnis in Ihrem Home-Verzeichnis. Verwenden Sie `mkdir yearly`, um eines zu erstellen!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Jetzt, wo es „ `yearly` “ gibt,
Mach ein weiteres Verzeichnis namens „ `2017` ” darin.
*ohne* dein Home-Verzeichnis zu verlassen.

`@hint`
Benutze einen relativen Pfad für das Unterverzeichnis, das du erstellen willst.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Kann das Verzeichnis '2017' in '/home/repl/yearly' nicht finden. Sie können dieses Verzeichnis mit dem relativen Pfad `yearly/2017` erstellen.")
)
Ex().success_msg("Cool! Lassen Sie uns dieses Kapitel mit einer Übung abschließen, die einige seiner Konzepte wiederholt!")
```

---

## Abschluss

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Bei der Datenanalyse wirst du oft Zwischendateien erstellen.
Speicher sie lieber nicht in deinem Home-Verzeichnis,
Du kannst sie auf `/tmp` hochladen.
Hier speichern Leute und Programme oft Dateien, die sie nur kurz brauchen.
(Beachte, dass „ `/tmp` ” direkt unter dem Stammverzeichnis „ `/` ” liegt.
*nicht* unter deinem Home-Verzeichnis.)
Diese Zusammenfassung zeigt dir, wie du das machst.

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
Geh auf `cd` und dann auf `/tmp`.

`@hint`
Denk dran, dass „ `cd` ” „Verzeichnis wechseln” heißt und dass ein absoluter Pfad mit einem „/” anfängt.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Sie befinden sich im falschen Verzeichnis. Verwenden Sie `cd`, um das Verzeichnis zu `/tmp` zu ändern.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Zeig den Inhalt von „ `/tmp` “ an, *ohne* einen Verzeichnisnamen einzugeben.

`@hint`
Wenn du `ls` nicht sagst, was es auflisten soll, zeigt es dir, was sich in deinem aktuellen Verzeichnis befindet.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Sie haben `ls` nicht aufgerufen, um die Dateiliste zu erstellen."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Ihr Befehl hat nicht die richtige Dateiliste erstellt. Verwenden Sie `ls` ohne `. ")
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
Mach ein neues Verzeichnis in „ `/tmp` ” namens „ `scratch` ”.

`@hint`
Benutze „ `mkdir` “, um Verzeichnisse zu erstellen.

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
      has_code('mkdir +scratch', incorrect_msg="Kann kein 'scratch'-Verzeichnis unter '/tmp' finden. Stellen Sie sicher, dass Sie `mkdir` korrekt verwenden.")
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
Verschieb „ `/home/repl/people/agarwal.txt` “ nach „ `/tmp/scratch` “.
Wir empfehlen dir, für dein Home-Verzeichnis die Verknüpfung „ `~` “ und für das zweite Verzeichnis einen relativen Pfad anstelle des absoluten Pfads zu verwenden.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Kann 'agarwal.txt' in '/tmp/scratch' nicht finden. Verwenden Sie `mv` mit `~/people/agarwal.txt` als ersten Parameter und `scratch` als zweiten.")
)
Ex().success_msg("Dies schließt Kapitel 1 der Einführung in die Shell ab! Eilen Sie zum nächsten Kapitel, um mehr über die Datenmanipulation zu erfahren!")
```

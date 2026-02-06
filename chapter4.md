---
title: Stapelverarbeitung
description: >-
  Die meisten shell-Befehle können mehrere Dateien gleichzeitig bearbeiten. In
  diesem Kapitel erfährst du, wie du deine eigenen Pipelines dafür einrichten
  kannst. Unterwegs wirst du sehen, wie die shell Variablen zum Speichern von
  Infos nutzt.
lessons:
  - nb_of_exercises: 10
    title: Wie speichert die shell Infos?
---

## Wie speichert die shell Infos?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Wie andere Programme auch, speichert die shell Infos in Variablen.
Einige davon,
genannt **Umgebungsvariablen**,
sind immer verfügbar.
Die Namen von Umgebungsvariablen werden normalerweise in Großbuchstaben geschrieben.
Ein paar der am häufigsten verwendeten sind unten aufgeführt.

| Variabel | Zweck                           | Wert                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | Benutzerverzeichnis             | `/home/repl`          |
| `PWD `   | Aktuelles Arbeitsverzeichnis         | Genau wie der Befehl „ `pwd` “ |
| `SHELL`  | Welches shell-Programm wird verwendet? | `/bin/bash`           |
| `USER`   | Benutzer-ID                         | `repl`                |

Um eine komplette Liste zu kriegen (die ziemlich lang ist),
Du kannst „ `set` “ in die shell eingeben.

<hr>

Benutze „ `set` “ und „ `grep` “ mit einem Pipe, um den Wert von „ `HISTFILESIZE` “ anzuzeigen.
das bestimmt, wie viele alte Befehle in deinem Befehlsverlauf gespeichert werden.
Was ist der Wert davon?

`@possible_answers`
- 10
- 500
- [2000]
- Die Variable ist nicht da.

`@hint`
Benutz „ `set | grep HISTFILESIZE` “, um die gewünschte Zeile zu finden.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nein: Die Shell speichert mehr Verlauf als das."
err2 = "Nein: Die Shell speichert mehr Verlauf als das."
correct3 = "Korrekt: Die Shell speichert standardmäßig 2000 alte Befehle auf diesem System."
err4 = "Nein: Die Variable `HISTFILESIZE` ist vorhanden."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Wie kann ich den Wert einer Variablen ausdrucken?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Eine einfachere Möglichkeit, den Wert einer Variablen zu finden, ist der Befehl „ `echo` “, der die Argumente ausgibt. Tippen

```{shell}
echo hello DataCamp!
```

Drucke

```
hello DataCamp!
```

Wenn du versuchst, damit den Wert einer Variablen so zu drucken:

```{shell}
echo USER
```

Es wird der Name der Variablen „ `USER` “ angezeigt.

Um den Wert der Variablen zu kriegen, musst du ein Dollarzeichen `$` davor setzen. Tippen 

```{shell}
echo $USER
```

Drucke

```
repl
```

Das gilt überall:
Um den Wert einer Variablen namens „ `X` “ zu bekommen,
Du musst `$X` schreiben.
(Damit kann die shell erkennen, ob du „eine Datei namens X” meinst.
oder „der Wert einer Variablen namens X“).

`@instructions`
Die Variable „ `OSTYPE` “ hat den Namen deines Betriebssystems.
Zeig den Wert mit „ `echo` “ an.

`@hint`
Ruf `echo` an, mit der Variablen `OSTYPE`, die mit `$` beginnt.

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
            has_code('echo', incorrect_msg="Haben Sie `echo` aufgerufen?"),
            has_code('OSTYPE', incorrect_msg="Haben Sie die Umgebungsvariable `OSTYPE` ausgegeben?"),
            has_code(r'\$OSTYPE', incorrect_msg="Stellen Sie sicher, dass `OSTYPE` mit einem `$` vorangestellt ist.")
        )
    )
)
Ex().success_msg("Ausgezeichnetes Echo der Umgebungsvariablen! Sie haben einen guten Start hingelegt. Machen wir weiter!")
```

---

## Wie speichert die shell noch Infos?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

Die andere Art von Variablen heißt **shell-Variable**.
Das ist so ähnlich wie eine lokale Variable in einer Programmiersprache.

Um eine shell-Variable zu erstellen,
Du gibst einfach einem Namen einen Wert:

```{shell}
training=seasonal/summer.csv
```

*ohne* Leerzeichen vor oder nach dem Zeichen „ `=` “.
Sobald du das erledigt hast,
Du kannst den Wert der Variablen mit folgendem Befehl überprüfen:

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
Mach mal 'ne Variable namens „ `testing` ” mit dem Wert „ `seasonal/winter.csv` ”.

`@hint`
Zwischen dem Namen der Variablen und ihrem Wert sollten *keine* Leerzeichen sein.

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
        has_code('testing', incorrect_msg='Haben Sie eine Shell-Variable namens `testing` definiert?'),
        has_code('testing=', incorrect_msg='Haben Sie `=` direkt nach testing geschrieben, ohne Leerzeichen?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Haben Sie den Wert von `testing` auf `seasonal/winter.csv` gesetzt?')
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
Benutze „ `head -n 1 SOMETHING` “, um die erste Zeile von `seasonal/winter.csv`
Verwende den Wert der Variablen „ `testing` “ anstelle des Dateinamens.

`@hint`
Denk dran, „ `$testing` “ zu benutzen, statt einfach nur `testing`
( `$` wird gebraucht, um den Wert der Variablen zu kriegen).

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
    has_code(r'\$testing', incorrect_msg="Haben Sie die Shell-Variable mit `$testing` referenziert?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Haben Sie `head` aufgerufen?"),
            has_code('-n', incorrect_msg="Haben Sie die Anzahl der Zeilen mit `-n` begrenzt?"),
            has_code(r'-n\s+1', incorrect_msg="Haben Sie sich entschieden, 1 Zeile mit `-n 1` zu behalten?")     
        )
    )
)
Ex().success_msg("Stellar! Mal sehen, wie Sie Befehle einfach wiederholen können.")

```

---

## Wie kann ich einen Befehl mehrmals wiederholen?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Shell-Variablen werden auch in **Schleifen** benutzt.
die Befehle oft wiederholen.
Wenn wir diesen Befehl ausführen:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

Es macht:

```
gif
jpg
png
```

Schau mal, hier sind ein paar Sachen, die du bei der Schleife beachten solltest:

1. Die Struktur ist wie folgt aufgebaut: `for`...variable... `in`...list... `; do`...body... `; done`
2. Die Liste der Sachen, die die Schleife bearbeiten soll (in unserem Fall die Wörter „ `gif` “, „ `jpg` “ und „ `png` “).
3. Die Variable, die verfolgt, welches Element gerade in der Schleife verarbeitet wird (in unserem Fall „ `filetype` “).
4. Der Teil der Schleife, der die Verarbeitung macht (in unserem Fall `echo $filetype`).

Beachte, dass der Body „ `$filetype` “ benutzt, um den Wert der Variablen zu bekommen, statt einfach „ `filetype` “.
genau wie bei jeder anderen shell-Variablen.
Achte auch darauf, wo die Semikolons hingehören:
Der erste steht zwischen der Liste und dem Schlüsselwort „ `do` “.
und das zweite kommt zwischen dem Hauptteil und dem Stichwort „ `done` “.

`@instructions`
Ändere die Schleife so, dass sie Folgendes ausgibt:

```
docx
odt
pdf
```

Bitte nimm „ `filetype` “ als Namen für die Schleifenvariable.

`@hint`
Benutz die Codestruktur aus dem Einführungstext und tausche die Bilddateiformate gegen Dokumentdateiformate aus.

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
      has_code('for', incorrect_msg='Haben Sie `for` aufgerufen?'),
      has_code('filetype', incorrect_msg='Haben Sie `filetype` als Schleifenvariable verwendet?'),
      has_code('in', incorrect_msg='Haben Sie `in` vor der Liste der Dateitypen verwendet?'),
      has_code('docx odt pdf', incorrect_msg='Haben Sie über `docx`, `odt` und `pdf` in dieser Reihenfolge iteriert?'),
      has_code(r'pdf\s*;', incorrect_msg='Haben Sie ein Semikolon nach dem letzten Schleifenelement gesetzt?'),
      has_code(r';\s*do', incorrect_msg='Haben Sie `do` nach dem ersten Semikolon verwendet?'),
      has_code('echo', incorrect_msg='Haben Sie `echo` aufgerufen?'),
      has_code(r'\$filetype', incorrect_msg='Haben Sie `$filetype` ausgegeben?'),
      has_code(r'filetype\s*;', incorrect_msg='Haben Sie ein Semikolon nach dem Schleifenkörper gesetzt?'),
      has_code('; done', incorrect_msg='Haben Sie mit `done` abgeschlossen?')
    )
  )
)
Ex().success_msg("Erstklassig für Schleifen! Schleifen sind genial, wenn Sie dasselbe Hunderte oder Tausende Male tun möchten.")

```

---

## Wie kann ich einen Befehl einmal für jede Datei wiederholen?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Du kannst beim Schreiben der Schleife immer die Namen der Dateien eingeben, die du bearbeiten willst.
Aber meistens ist es besser, Platzhalter zu benutzen.
Probier mal, diese Schleife in der Konsole auszuführen:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Es wird gedruckt:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

Weil die shell „ `seasonal/*.csv` “ zu einer Liste mit vier Dateinamen erweitert.
bevor die Schleife durchlaufen wird.

`@instructions`
Ändere den Platzhalterausdruck zu `people/*`
damit die Schleife die Namen der Dateien im Verzeichnis „ `people` “ ausgibt
egal, ob sie ein Suffix haben oder nicht.
Bitte nimm „ `filename` ” als Namen für deine Schleifenvariable.

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
      has_code('for', incorrect_msg='Haben Sie `for` aufgerufen?'),
      has_code('filename', incorrect_msg='Haben Sie `filename` als Schleifenvariable verwendet?'),
      has_code('in', incorrect_msg='Haben Sie `in` vor der Liste der Dateitypen verwendet?'),
      has_code('people/\*', incorrect_msg='Haben Sie eine Liste von Dateien mit `people/*` angegeben?'),
      has_code(r'people/\*\s*;', incorrect_msg='Haben Sie ein Semikolon nach der Liste der Dateien gesetzt?'),
      has_code(r';\s*do', incorrect_msg='Haben Sie `do` nach dem ersten Semikolon verwendet?'),
      has_code('echo', incorrect_msg='Haben Sie `echo` aufgerufen?'),
      has_code(r'\$filename', incorrect_msg='Haben Sie `$filename` ausgegeben?'),
      has_code(r'filename\s*;', incorrect_msg='Haben Sie ein Semikolon nach dem Schleifenkörper gesetzt?'),
      has_code('; done', incorrect_msg='Haben Sie mit `done` abgeschlossen?')
    )
  )
)
Ex().success_msg("Schleifen! Platzhalter und Schleifen sind eine mächtige Kombination.")

```

---

## Wie kann ich die Namen einer Reihe von Dateien aufzeichnen?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Leute setzen oft eine Variable mit einem Platzhalterausdruck, um eine Liste von Dateinamen zu speichern.
Ein Beispiel:
Wenn du „ `datasets` “ so definierst:

```{shell}
datasets=seasonal/*.csv
```

Du kannst die Dateinamen später mit folgendem Befehl anzeigen:

```{shell}
for filename in $datasets; do echo $filename; done
```

Das spart Tipparbeit und macht Fehler unwahrscheinlicher.

<hr>

Wenn du diese beiden Befehle in deinem Home-Verzeichnis ausführst,
Wie viele Zeilen werden sie ausgeben?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Keine: Weil „ `files` “ in einer separaten Zeile definiert ist, hat es in der zweiten Zeile keinen Wert.
- Erstens: das Wort „Dateien”.
- Viertens: die Namen aller vier saisonalen Datendateien.

`@hint`
Denk dran, dass „ `X` “ allein einfach „X“ ist, während „ `$X` “ der Wert der Variablen „ `X` “ ist.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nein: Sie müssen keine Variable in derselben Zeile definieren, in der Sie sie verwenden."
err2 = "Nein: Dieses Beispiel definiert und verwendet die Variable `files` in derselben Shell."
correct3 = "Korrekt. Der Befehl ist gleichbedeutend mit `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Der Name einer Variablen im Vergleich zu ihrem Wert

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Ein häufiger Fehler ist, dass man vergisst, vor dem Namen einer Variablen „ `$` “ zu schreiben.
Wenn du das machst,
Die shell benutzt den Namen, den du eingegeben hast.
anstatt den Wert dieser Variablen.

Ein häufiger Fehler bei erfahrenen Benutzern ist, den Namen der Variablen falsch zu tippen.
Ein Beispiel:
Wenn du „ `datasets` “ so definierst:

```{shell}
datasets=seasonal/*.csv
```

und gib dann Folgendes ein:

```{shell}
echo $datsets
```

Die shell gibt nichts aus.
Weil „ `datsets` “ (ohne das zweite „a“) nicht definiert ist.

<hr>

Wenn du diese beiden Befehle in deinem Home-Verzeichnis ausführen würdest,
Was würde da ausgegeben werden?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Lies dir den ersten Teil der Schleife genau durch, bevor du antwortest.)

`@hint`
Denk dran, dass „ `X` “ allein einfach „X“ ist, während „ `$X` “ der Wert der Variablen „ `X` “ ist.

`@possible_answers`
- [Eine Zeile: das Wort „Dateien”.]
- Vier Zeilen: die Namen aller vier saisonalen Datendateien.
- Vier Leerzeilen: Der Variablen `f` ist kein Wert zugewiesen.

`@feedback`
- Richtig: Die Schleife benutzt `files` statt `$files`, also besteht die Liste aus dem Wort „files”.
- Nein: Die Schleife nutzt `files` statt `$files`, also besteht die Liste aus dem Wort „files” und nicht aus der Erweiterung von `files`.
- Nein: Die Variable „ `f` “ wird automatisch durch die Schleife „ `for` “ definiert.

---

## Wie kann ich mehrere Befehle in einer einzigen Schleife ausführen?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Das Drucken von Dateinamen ist beim Debuggen echt praktisch.
Aber eigentlich sind Schleifen dafür da, um Sachen mit mehreren Dateien zu machen.
Diese Schleife gibt die zweite Zeile jeder Datendatei aus:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Es hat die gleiche Struktur wie die anderen Schleifen, die du schon kennst:
Der einzige Unterschied ist, dass sein Körper aus zwei Befehlen besteht statt aus einem einzigen.

`@instructions`
Schreib eine Schleife, die den letzten Eintrag aus Juli 2017 (`2017-07`) in jeder Saison-Datei ausgibt. Das Ergebnis sollte ungefähr so aussehen:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

aber für **_jede_** saisonale Datei separat. Benutz bitte „ `file` ” als Namen für die Schleifenvariable und denk dran, die Liste der Dateien „ `seasonal/*.csv` ” (_statt „seasonal/winter.csv” wie im Beispiel_) zu durchlaufen.

`@hint`
Der Schleifenkörper ist der in der Anleitung gezeigte Befehl „grep“, wobei „ `seasonal/winter.csv` “ durch „ `$file` “ ersetzt wurde.

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
  has_code('for', incorrect_msg='Haben Sie `for` aufgerufen?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Haben Sie `file` als Schleifenvariable verwendet?'),
      has_code('in', incorrect_msg='Haben Sie `in` vor der Liste der Dateien verwendet?'),
      has_code('seasonal/\*', incorrect_msg='Haben Sie eine Liste von Dateien mit `seasonal/*` angegeben?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Haben Sie ein Semikolon nach der Liste der Dateien gesetzt?'),
      has_code(r';\s*do', incorrect_msg='Haben Sie `do` nach dem ersten Semikolon verwendet?'),
      has_code('grep', incorrect_msg='Haben Sie `grep` aufgerufen?'),
      has_code('2017-07', incorrect_msg='Haben Sie auf `2017-07` abgeglichen?'),
      has_code(r'\$file', incorrect_msg='Haben Sie `$file` als Namen der Schleifenvariable verwendet?'),
      has_code(r'file\s*|', incorrect_msg='Haben Sie eine Pipe verwendet, um Ihren zweiten Befehl zu verbinden?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Haben Sie `tail -n 1` verwendet, um den letzten Eintrag jeder Suche in Ihrem zweiten Befehl auszugeben?'),
      has_code('; done', incorrect_msg='Haben Sie mit `done` abgeschlossen?')
    )
  )
)

Ex().success_msg("Schleifen! Platzhalter und Schleifen sind eine mächtige Kombination.")

```

---

## Warum sollte ich keine Leerzeichen in Dateinamen verwenden?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Es ist einfach und sinnvoll, Dateien Namen mit mehreren Wörtern zu geben, wie zum Beispiel `July 2017.csv`
wenn du einen grafischen Datei-Explorer benutzt.
Allerdings
Das macht Probleme, wenn du in der shell arbeitest.
Ein Beispiel:
Angenommen, du möchtest „ `July 2017.csv` “ in „ `2017 July data.csv` “ umbenennen.
Du kannst nicht eingeben:

```{shell}
mv July 2017.csv 2017 July data.csv
```

weil es für die Shell so aussieht, als ob du versuchst, etwas zu verschieben
vier Dateien namens „ `July` “, „ `2017.csv` “, „ `2017` “ und „ `July` “ (noch mal)
in ein Verzeichnis namens „ `data.csv` “.
Stattdessen
Du musst die Dateinamen angeben.
damit die shell jeden einzelnen als einen Parameter behandelt:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Wenn du zwei Dateien namens „ `current.csv` “ und „ `last year.csv`
(mit einem Leerzeichen im Namen)
und du gibst ein:

```{shell}
rm current.csv last year.csv
```

Was wird passieren:

`@hint`
Was würdest du denken, was passieren würde, wenn dir jemand den Befehl zeigen würde und du nicht wüsstest, welche Dateien es gibt?

`@possible_answers`
- The shell shows ' `last` ' because the files ' ' and ' `year.csv` ' do not exist.
- The shell deletes „ `current.csv` “.
- [Beides.]
- Nichts.

`@feedback`
- Ja, aber das ist noch nicht alles.
- Ja, aber das ist noch nicht alles.
- Richtig. Du kannst die Dateinamen in einfache Anführungszeichen ( `'`) oder doppelte Anführungszeichen ( `"`) setzen.
- Leider nicht.

---

## Wie kann ich mehrere Sachen in einer einzigen Schleife machen?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Die Schleifen, die du bisher gesehen hast, haben alle einen einzigen Befehl oder eine Pipeline in ihrem Hauptteil.
Aber eine Schleife kann beliebig viele Befehle haben.
Um der shell zu sagen, wo eins aufhört und das nächste anfängt,
Du musst sie mit Semikolons trennen:

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

Angenommen, du vergisst das Semikolon zwischen den Befehlen „ `echo` “ und „ `head` “ in der vorherigen Schleife,
damit du die shell aufforderst, Folgendes auszuführen:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Was macht die shell?

`@possible_answers`
- Druck eine Fehlermeldung aus.
- Druck eine Zeile für jede der vier Dateien.
- Druck eine Zeile für „ `autumn.csv` “ (die erste Datei).
- Druck die letzte Zeile jeder Datei aus.

`@hint`
Du kannst die Ausgabe von „ `echo` “ an „ `tail` “ weiterleiten.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Nein: Die Schleife wird ausgeführt, sie wird nur nichts Sinnvolles tun."
correct2 = "Ja: `echo` erzeugt eine Zeile, die den Dateinamen zweimal enthält, die `tail` dann kopiert."
err3 = "Nein: Die Schleife läuft einmal für jeden der vier Dateinamen."
err4 = "Nein: Die Eingabe von `tail` ist die Ausgabe von `echo` für jeden Dateinamen."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

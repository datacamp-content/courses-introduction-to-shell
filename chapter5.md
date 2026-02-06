---
title: Neue Tools entwickeln
description: >-
  Mit dem Befehl „History“ kannst du Sachen mit nur ein paar Tastenanschlägen
  wiederholen, und mit „Pipes“ kannst du vorhandene Befehle kombinieren, um neue
  zu erstellen. In diesem Kapitel lernst du, wie du noch einen Schritt
  weitergehst und deine eigenen neuen Befehle erstellst.
lessons:
  - nb_of_exercises: 9
    title: Wie kann ich eine Datei bearbeiten?
---

## Wie kann ich eine Datei bearbeiten?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix hat echt viele verschiedene Texteditoren.
Für diesen Kurs
Wir nehmen ein einfaches Programm namens Nano.
Wenn du `nano filename` eingibst,
Es öffnet sich „ `filename` “ zum Bearbeiten.
(oder mach's, falls es noch nicht da ist).
Du kannst dich mit den Pfeiltasten bewegen.
Zeichen mit der Rücktaste löschen,
und mach andere Sachen mit Tastenkombinationen:

- `Ctrl` `K`: Eine Zeile löschen.
- `Ctrl` `U`: Eine Zeile wiederherstellen.
- `Ctrl` + `O`: Speichere die Datei (das „O” steht für „Output”). _Du musst auch die Eingabetaste drücken, um den Dateinamen zu bestätigen!_
- `Ctrl` + `X`: Beende den Editor.

`@instructions`
Mach mal „ `nano names.txt` “, um eine neue Datei in deinem Home-Verzeichnis zu bearbeiten.
und gib die folgenden vier Zeilen ein:

```
Lovelace
Hopper
Johnson
Wilson
```

Um das, was du geschrieben hast, zu speichern,
Gib „ `Ctrl` “ + „ `O` “ ein, um die Datei zu speichern.
Dann drück die Eingabetaste, um den Dateinamen zu bestätigen.
Dann drück mal `Ctrl` + `X`, um den Editor zu verlassen.

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
patt = "Haben Sie die Zeile `%s` in die Datei `names.txt` eingefügt? Verwenden Sie `nano names.txt` erneut, um Ihre Datei zu aktualisieren. Verwenden Sie `Ctrl` + `O`, um zu speichern, und `Ctrl` + `X`, um zu beenden."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Gut gemacht! Weiter zum nächsten!")

```

---

## Wie kann ich aufzeichnen, was ich gerade gemacht habe?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Wenn du eine komplexe Analyse machst,
Du wirst oft die Befehle, die du benutzt hast, aufzeichnen wollen.
Du kannst das mit den Tools machen, die du schon kennst:

1. Mach mal ' `history`'.
2. Leite die Ausgabe an „ `tail -n 10` “ weiter (oder an so viele der letzten Schritte, wie du speichern möchtest).
3. Leite das in eine Datei um, die so was wie „ `figure-5.history` “ heißt.

Das ist besser, als Sachen in ein Laborheft zu schreiben.
weil garantiert keine Schritte übersehen werden.
Es zeigt auch die zentrale Idee der shell:
Einfache Tools, die Textzeilen erstellen und nutzen
kann auf viele verschiedene Arten kombiniert werden
um eine Vielzahl von Problemen zu lösen.

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
Kopier die Dateien „ `seasonal/spring.csv` “ und „ `seasonal/summer.csv` “ in dein Home-Verzeichnis.

`@hint`
Benutze „ `cp` “, um zu kopieren, und „ `~` “ als Abkürzung für den Pfad zu deinem Home-Verzeichnis.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Haben Sie `cp seasonal/s* ~` verwendet, um die erforderlichen Dateien in Ihr Home-Verzeichnis zu kopieren?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Bemerkenswerte Aufzeichnungen! Wenn Sie irgendwelche Befehle falsch eingegeben haben, können Sie immer `nano` verwenden, um die gespeicherte Verlaufdatei danach zu bereinigen.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Benutze „ `grep` “ mit dem Flag „ `-h` “ (damit keine Dateinamen ausgegeben werden).
und „ `-v Tooth` “ (um Zeilen auszuwählen, die *nicht* mit der Kopfzeile übereinstimmen)
Wähle die Datensätze von `spring.csv` und `summer.csv` in dieser Reihenfolge aus.
und leite die Ausgabe nach `temp.csv` weiter.

`@hint`
Setz die Flags vor die Dateinamen.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Stellen Sie sicher, dass Sie die Ausgabe des `grep`-Befehls mit `>` auf `temp.csv` umleiten!"
msg2 = "Haben Sie `grep -h -v ___ ___ ___` (füllen Sie die Lücken aus) verwendet, um `temp.csv` zu füllen?"
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
Leite die Pipe von „ `history` “ nach `tail -n 3`
und leite die Ausgabe um nach `steps.txt`
die letzten drei Befehle in einer Datei speichern.
Du musst drei statt nur zwei speichern.
Weil der Befehl „ `history` “ selbst in der Liste sein wird.

`@hint`
Denk dran, dass die Umleitung mit „ `>` “ am Ende der Reihe von Pipe-Befehlen kommt.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Stellen Sie sicher, dass Sie die Ausgabe Ihres Befehls in `steps.txt` umleiten."
msg2="Haben Sie `history | tail ___ ___` (füllen Sie die Lücken aus) verwendet, um `steps.txt` zu füllen?"
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
Ex().success_msg("Gut gemacht! Lassen Sie uns einen Schritt weiter gehen!")

```

---

## Wie kann ich Befehle speichern, um sie später wieder auszuführen?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Bisher hast du die shell interaktiv benutzt.
Aber da die Befehle, die du eingibst, nur Text sind,
Du kannst sie in Dateien speichern, damit die shell sie immer wieder ausführen kann.
Um diese mächtige Funktion zu entdecken,
Schreib den folgenden Befehl in eine Datei namens „ `headers.sh` “:

```{shell}
head -n 1 seasonal/*.csv
```

Dieser Befehl holt die erste Zeile aus jeder CSV-Datei im Verzeichnis „ `seasonal` “.
Sobald du diese Datei erstellt hast,
Du kannst es ausführen, indem du Folgendes eingibst:

```{shell}
bash headers.sh
```

Das sagt die shell (die einfach ein Programm namens „ `bash` “ ist),
die Befehle aus der Datei „ `headers.sh` “ ausführen,
was die gleiche Ausgabe liefert wie die direkte Ausführung der Befehle.

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
Benutze „ `nano dates.sh` “, um eine Datei namens `dates.sh`
die diesen Befehl enthält:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

Extrahier die erste Spalte aus allen CSV-Dateien im Ordner „ `seasonal` “.

`@hint`
Schreib die gezeigten Befehle in die Datei, ohne zusätzliche Leerzeilen oder Leerzeichen.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Haben Sie die Zeile `cut -d , -f 1 seasonal/*.csv` in die Datei `dates.sh` eingefügt? Verwenden Sie `nano dates.sh` erneut, um Ihre Datei zu aktualisieren. Verwenden Sie `Ctrl` + `O`, um zu speichern, und `Ctrl` + `X`, um zu beenden."
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
Benutze „ `bash` “, um die Datei „ `dates.sh` “ auszuführen.

`@hint`
Benutze „ `bash filename` “, um die Datei auszuführen.

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
      has_code("bash", incorrect_msg = 'Haben Sie `bash` aufgerufen?'),
      has_code("dates.sh", incorrect_msg = 'Haben Sie die Datei `dates.sh` angegeben?')
    )
  )
)
```

---

## Wie kann ich Rohre wiederverwenden?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Eine Datei voller shell-Befehle wird als**\*shell-Skript** bezeichnet.
oder manchmal auch einfach nur „Skript“ genannt. Skripte müssen nicht unbedingt Namen haben, die auf „ `.sh` “ enden.
Aber in dieser Lektion nehmen wir diese Konvention.
damit du besser sehen kannst, welche Dateien Skripte sind.

Skripte können auch Pipes haben.
Ein Beispiel:
Wenn die Datei „ `all-dates.sh` “ diese Zeile enthält:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

dann:

```{shell}
bash all-dates.sh > dates.out
```

Die eindeutigen Daten aus den saisonalen Datendateien extrahieren.
Speicher sie unter „ `dates.out` “.

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
In deinem Home-Verzeichnis wurde eine Datei namens „ `teeth.sh` ” für dich vorbereitet, die aber ein paar Leerstellen enthält.
Benutze Nano, um die Datei zu bearbeiten und die beiden Platzhalter „ `____` “ zu ersetzen.
mit `seasonal/*.csv` und `-c`, damit dieses Skript die Anzahl der
Anzahl der Vorkommen jedes Zahnnamens in den CSV-Dateien im Verzeichnis „ `seasonal` “.

`@hint`
Benutz „ `nano teeth.sh` “, um die Datei zu bearbeiten.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Haben Sie die Lücken richtig ersetzt, sodass der Befehl in `teeth.sh` `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c` lautet? Verwenden Sie `nano teeth.sh` erneut, um die erforderlichen Änderungen vorzunehmen."
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
Benutze „ `bash` “, um „ `teeth.sh` “ auszuführen, und „ `>` “, um die Ausgabe nach „ `teeth.out` “ umzuleiten.

`@hint`
Denk dran, dass „ `> teeth.out` “ *nach* dem Befehl kommen muss, der die Ausgabe erzeugt.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Haben Sie das Ergebnis von `bash teeth.sh` mit `>` korrekt auf `teeth.out` umgeleitet?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Haben Sie `bash` aufgerufen?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Haben Sie die Datei `teeth.sh` ausgeführt?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Haben Sie auf die Datei `teeth.out` umgeleitet?')
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
Mach mal „ `cat teeth.out` “, um deine Ergebnisse zu checken.

`@hint`
Denk dran, du kannst die ersten paar Zeichen eines Dateinamens eingeben und dann die Tabulatortaste drücken, um die automatische Vervollständigung zu nutzen.

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
      has_code("cat", incorrect_msg = 'Haben Sie `cat` aufgerufen?'),
      has_code("teeth.out", incorrect_msg = 'Haben Sie die Datei `teeth.out` angegeben?')
    )
  )
)
Ex().success_msg("Schön! Das mag anfangs alles gekünstelt wirken, aber das Schöne ist, dass Sie Teile Ihres Workflows Schritt für Schritt automatisieren. Etwas, das als Data Scientist wirklich praktisch ist!")
```

---

## Wie kann ich Dateinamen an Skripte übergeben?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Ein Skript, das bestimmte Dateien bearbeitet, ist praktisch, um zu zeigen, was du gemacht hast, aber eins, mit dem du alle Dateien bearbeiten kannst, die du willst, ist noch nützlicher.
Um das zu unterstützen,
Du kannst den speziellen Ausdruck „ `$@` “ (Dollarzeichen direkt gefolgt von einem At-Zeichen) verwenden.
bedeutet „alle Befehlszeilenparameter, die dem Skript übergeben werden“.

Wenn zum Beispiel `unique-lines.sh` den Link `sort $@ | uniq` enthält, passiert Folgendes, wenn du das hier ausführst:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

The shell replaces `$@` with `seasonal/summer.csv` and processes one file. Wenn du das hier ausführst:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

Es verarbeitet zwei Datendateien und so weiter.

_Nur zur Erinnerung: Um das, was du in Nano geschrieben hast, zu speichern, tippst du „ `Ctrl` “ + „ `O` “, um die Datei zu speichern, dann „Enter“, um den Dateinamen zu bestätigen, und dann „ `Ctrl` “ + „ `X` “, um den Editor zu verlassen._

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
Bearbeite das Skript „ `count-records.sh` “ mit Nano und fülle die beiden Platzhalter „ `____` “ aus.
mit „ `$@` “ und „ `-l` “ (_der Buchstabe_), damit die Anzahl der Zeilen in einer oder mehreren Dateien gezählt wird.
außer der ersten Zeile von jedem.

`@hint`
* Benutz „ `nano count-records.sh` “, um den Dateinamen zu ändern.
* Pass auf, dass du den _Buchstaben_ „ `-l` “ angibst und nicht die Zahl „1“.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Haben Sie die Leerstellen richtig ersetzt, sodass der Befehl in `count-records.sh` `tail -q -n +2 $@ | wc -l` lautet? Verwenden Sie `nano count-records.sh` erneut, um die erforderlichen Änderungen vorzunehmen."
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
`count-records.sh` ausführen auf `seasonal/*.csv`
und leite die Ausgabe mit `>` nach `num-records.out` um.

`@hint`
Benutze „ `>` “, um die Ausgabe umzuleiten.

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
      has_code("bash", incorrect_msg = 'Haben Sie `bash` aufgerufen?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Haben Sie die Datei `count-records.sh` ausgeführt?'),
      has_code("seasonal/\*", incorrect_msg = 'Haben Sie die zu verarbeitenden Dateien mit `seasonal/*` angegeben?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Haben Sie in die Datei `num-records.out` umgeleitet?')
    )
  )
)
Ex().success_msg("Gut gemacht! Ihre Shell-Fähigkeiten erweitern sich ständig!")
```

---

## Wie kann ich ein einzelnes Argument verarbeiten?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Genauso wie `$@`,
Mit der shell kannst du „ `$1` “, „ `$2` “ usw. benutzen, um bestimmte Befehlszeilenparameter zu referenzieren.
Damit kannst du Befehle schreiben, die sich einfacher oder natürlicher anfühlen als die der shell.
Ein Beispiel:
Du kannst ein Skript namens „ `column.sh` “ erstellen, das eine einzelne Spalte aus einer CSV-Datei auswählt.
wenn der Benutzer den Dateinamen als ersten Parameter und die Spalte als zweiten angibt:

```{shell}
cut -d , -f $2 $1
```

und dann mit folgendem Befehl ausführen:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Schau mal, wie das Skript die beiden Parameter in umgekehrter Reihenfolge benutzt.

<hr>

Das Skript „ `get-field.sh` “ soll einen Dateinamen nehmen,
die Nummer der Zeile, die du auswählen willst,
die Nummer der Spalte, die du auswählen willst,
und genau dieses Feld aus einer CSV-Datei ausdrucken.
Zum Beispiel:

```
bash get-field.sh seasonal/summer.csv 4 2
```

Du solltest das zweite Feld aus Zeile 4 von `seasonal/summer.csv` auswählen.
Welcher der folgenden Befehle sollte in „ `get-field.sh` “ eingegeben werden, um das zu machen?

`@hint`
Denk dran, dass die Befehlszeilenparameter von links nach rechts nummeriert sind.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- Nein: Das wird versuchen, den Dateinamen als Anzahl der mit \` `head`` auszuwählenden Zeilen zu verwenden.
- Richtig!
- Nein: Das würde versuchen, die Spaltennummer als Zeilennummer zu verwenden und umgekehrt.
- Nein: Dabei wird die Feldnummer als Dateiname verwendet und umgekehrt.

---

## Wie kann ein Shell-Skript mehrere Aufgaben erledigen?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Unsere shell-Skripte hatten bisher nur einen einzigen Befehl oder eine Pipe, aber ein Skript kann viele Befehlszeilen haben. Du kannst zum Beispiel eine Funktion erstellen, die dir sagt, wie viele Datensätze in der kürzesten und längsten deiner Datendateien sind, also den Bereich der Längen deiner Datensätze.

Hey, in Nano machst du das so: Geh zu der Zeile, die du kopieren willst, drück dann „ `CTRL` “ + „ `K` “, um die Zeile auszuschneiden, und dann zweimal „ `CTRL` “ + „ `U` “, um zwei Kopien davon einzufügen.

_Nur zur Erinnerung: Um das, was du in Nano geschrieben hast, zu speichern, tippst du „ `Ctrl` “ + „ `O` “, um die Datei zu speichern, dann „Enter“, um den Dateinamen zu bestätigen, und dann „ `Ctrl` “ + „ `X` “, um den Editor zu verlassen._

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
Benutze Nano, um das Skript zu bearbeiten. `range.sh`
und die beiden Platzhalter „ `____` “ ersetzen
mit `$@` und `-v`
damit die Namen und die Anzahl der Zeilen in allen Dateien aufgelistet werden, die in der Befehlszeile angegeben sind
*ohne* die Gesamtzahl der Zeilen in allen Dateien anzuzeigen.
(Versuch nicht, die Spaltenüberschriften aus den Dateien zu löschen.)

`@hint`
Benutze „ `wc -l $@` “, um die Zeilen in allen Dateien zu zählen, die in der Befehlszeile angegeben sind.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Haben Sie die Leerstellen richtig ersetzt, sodass der Befehl in `range.sh` `wc -l $@ | grep -v total` lautet? Verwenden Sie `nano range.sh` erneut, um die erforderlichen Änderungen vorzunehmen."
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
Benutze Nano nochmal, um `sort -n` und `head -n 1` in dieser Reihenfolge hinzuzufügen.
zur Pipeline in `range.sh`
Zeig den Namen und die Zeilenzahl der kürzesten Datei an, die du ihr gibst.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Haben Sie `sort -n` und `head -n 1` mit Pipes zur Datei `range.sh` hinzugefügt? Verwenden Sie `nano range.sh` erneut, um die erforderlichen Änderungen vorzunehmen."
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
Füge mit Nano eine zweite Zeile zu „ `range.sh` “ hinzu, um den Namen und die Anzahl der Datensätze von
die *längste* Datei im Verzeichnis *und auch* die kürzeste.
Diese Zeile sollte genau wie die, die du schon geschrieben hast, aussehen.
aber mit `sort -n -r` statt `sort -n`.

`@hint`
Kopiere die erste Zeile und ändere die Sortierreihenfolge.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Behalten Sie die erste Zeile in der Datei `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Haben Sie die erste Zeile in `range.sh` dupliziert und eine kleine Änderung vorgenommen? `sort -n -r` anstelle von `sort -n`!"
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
Mach das Skript mit den Dateien im Verzeichnis „ `seasonal` “
`seasonal/*.csv` verwenden, um alle Dateien zu finden
und die Ausgabe mit `>`
in eine Datei namens „ `range.out` “ in deinem Home-Verzeichnis.

`@hint`
Benutze „ `bash range.sh` “, um dein Skript auszuführen, „ `seasonal/*.csv` “, um Dateien anzugeben, und „ `> range.out` “, um die Ausgabe umzuleiten.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Haben Sie das Ergebnis von `bash range.sh seasonal/*.csv` korrekt mit `>` nach `range.out` umgeleitet?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Haben Sie `bash` aufgerufen?'),
has_code("bash\s+range.sh", incorrect_msg = 'Haben Sie die Datei `range.sh` ausgeführt?'),
has_code("seasonal/\*", incorrect_msg = 'Haben Sie die zu verarbeitenden Dateien mit `seasonal/*` angegeben?'),
has_code(">\s+range.out", incorrect_msg = 'Haben Sie die Ausgabe in die Datei `range.out` umgeleitet?')
)
)

Ex().success_msg("Das läuft gut. Gehen Sie zur nächsten Übung, um mehr über das Schreiben von Schleifen zu lernen!")

```

---

## Wie kann ich Schleifen in einem shell-Skript schreiben?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Shell-Skripte können auch Schleifen haben. Du kannst sie mit Semikolons schreiben oder ohne Semikolons über mehrere Zeilen aufteilen, damit sie besser lesbar sind:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do

    head -n 2 $filename | tail -n 1

    tail -n 1 $filename

done
```

(Du musst die Befehle innerhalb der Schleife nicht einrücken, aber das macht die Sache übersichtlicher.)

Die erste Zeile dieses Skripts ist ein **Kommentar**, der den Lesern erklärt, was das Skript macht. Kommentare fangen mit dem Zeichen „ `#` “ an und gehen bis zum Ende der Zeile. Dein zukünftiges Ich wird dir dankbar sein, wenn du zu jedem Skript, das du schreibst, kurze Erklärungen wie die hier gezeigte hinzufügst.

_Nur zur Erinnerung: Um das, was du in Nano geschrieben hast, zu speichern, tippst du „ `Ctrl` “ + „ `O` “, um die Datei zu speichern, dann „Enter“, um den Dateinamen zu bestätigen, und dann „ `Ctrl` “ + „ `X` “, um den Editor zu verlassen._

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
Füll die Platzhalter im Skript aus. `date-range.sh`
mit „ `$filename` “ (zweimal), „ `head` “ und `tail`
damit es das erste und letzte Datum aus einer oder mehreren Dateien ausdruckt.

`@hint`
Denk dran, „ `$filename` “ zu benutzen, um den aktuellen Wert der Schleifenvariablen zu kriegen.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="In `date-range.sh`, haben Sie die Zeile %s in der Schleife in `%s` geändert? Verwenden Sie `nano date-range.sh`, um Änderungen vorzunehmen."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('first', cmdpatt%'head')
msg2=msgpatt%('second', cmdpatt%'tail')
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
Führ „ `date-range.sh` “ auf allen vier saisonalen Datendateien aus.
mit `seasonal/*.csv`, um ihre Namen abzugleichen.

`@hint`
Der Platzhalterausdruck sollte mit dem Verzeichnisnamen anfangen.

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
      has_code("bash", incorrect_msg = 'Haben Sie `bash` aufgerufen?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Haben Sie die Datei `date-range.sh` ausgeführt?'),
      has_code("seasonal/\*", incorrect_msg = 'Haben Sie die zu verarbeitenden Dateien mit `seasonal/*` angegeben?')
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
Führ „ `date-range.sh` “ für alle vier saisonalen Datendateien aus und benutz „ `seasonal/*.csv` “, um ihre Namen anzupassen.
und leite die Ausgabe an „ `sort` “ weiter, um zu sehen, dass deine Skripte genau wie die integrierten Befehle von Unix verwendet werden können.

`@hint`
Benutze denselben Platzhalterausdruck wie vorher.

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
      has_code("bash", incorrect_msg = 'Haben Sie `bash` aufgerufen?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Haben Sie die Datei `date-range.sh` ausgeführt?'),
      has_code("seasonal/\*", incorrect_msg = 'Haben Sie die zu verarbeitenden Dateien mit `seasonal/*` angegeben?'),
      has_code("|", incorrect_msg = 'Haben Sie die Ausgabe des Skripts an `sort` weitergeleitet?'),
      has_code("sort", incorrect_msg = 'Haben Sie `sort` aufgerufen?')
    )
  )
)
Ex().success_msg("Magie! Beachten Sie, wie zusammensetzbar all die Dinge sind, die wir gelernt haben.")
```

---

## Was passiert, wenn ich keine Dateinamen angebe?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Ein häufiger Fehler in Shell-Skripten (und interaktiven Befehlen) ist, Dateinamen an der falschen Stelle zu setzen.
Wenn du eingibst:

```{shell}
tail -n 3
```

Da „ `tail` “ keine Dateinamen bekommen hat,
Es wartet darauf, was du über die Tastatur eingibst.
Das heißt, wenn du Folgendes eingibst:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Dann macht `tail` weiter und zeigt die letzten drei Zeilen von `somefile.txt` an.
Aber „ `head` “ wartet ewig auf eine Tastatureingabe.
Weil es keinen Dateinamen hat und nichts davor in der Pipeline ist.

<hr>

Angenommen, du tippst aus Versehen:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Was solltest du als Nächstes machen?

`@possible_answers`
- Warte 10 Sekunden, bis „ `head` “ abgelaufen ist.
- Gib „ `somefile.txt` “ ein und drück die Eingabetaste, um „ `head` “ ein paar Infos zu geben.
- Benutz „ `Ctrl` “ + „ `C` “, um das laufende Programm „ `head` “ zu stoppen.

`@hint`
Was macht „ `head` “, wenn es keinen Dateinamen hat und davor nichts steht?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'Nein, Befehle werden nicht ablaufen.'
a2 = 'Nein, das wird `head` den Text `somefile.txt` zur Verarbeitung geben, aber dann wird es hängen bleiben und auf weitere Eingaben warten.'
a3 = "Ja! Sie sollten `Ctrl` + `C` verwenden, um ein laufendes Programm zu stoppen. Damit ist dieser Einführungskurs abgeschlossen! Wenn Sie mehr über Kommandozeilen-Tools erfahren möchten, empfehlen wir Ihnen dringend, unseren kostenlosen Einführungskurs zu Git zu besuchen!"
Ex().has_chosen(3, [a1, a2, a3])
```

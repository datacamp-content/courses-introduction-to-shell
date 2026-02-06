---
title: Werkzeuge kombinieren
description: >-
  Die wahre Stärke der Unix-shell liegt nicht in den einzelnen Befehlen, sondern
  darin, wie einfach man sie kombinieren kann, um neue Sachen zu machen. In
  diesem Kapitel lernst du, wie du diese Funktion nutzen kannst, um die
  gewünschten Daten auszuwählen, und wir zeigen dir Befehle zum Sortieren von
  Werten und zum Entfernen von Duplikaten.
lessons:
  - nb_of_exercises: 12
    title: Wie kann ich die Ausgabe eines Befehls in einer Datei speichern?
---

## Wie kann ich die Ausgabe eines Befehls in einer Datei speichern?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Mit allen Tools, die du bisher gesehen hast, kannst du Eingabedateien benennen.
Die meisten haben keine Option zum Benennen einer Ausgabedatei, weil sie keine brauchen.
Stattdessen
Du kannst **die Umleitung** nutzen, um die Ausgabe eines beliebigen Befehls an einem beliebigen Ort zu speichern.
Wenn du diesen Befehl ausführst:

```{shell}
head -n 5 seasonal/summer.csv
```

Es zeigt die ersten 5 Zeilen der Sommerdaten auf dem Bildschirm an.
Wenn du stattdessen diesen Befehl ausführst:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

Auf dem Bildschirm wird nichts angezeigt.
Stattdessen
`head`Die Ausgabe wird in eine neue Datei namens „ `top.csv` “ gespeichert.
Du kannst dir den Inhalt dieser Datei mit „ `cat` “ anschauen:

```{shell}
cat top.csv
```

Das Größer-als-Zeichen `>` sagt der shell, dass sie die Ausgabe von `head` in eine Datei umleiten soll.
Das gehört nicht zum Befehl „ `head` “;
stattdessen
Es klappt mit jedem shell-Befehl, der was ausgibt.

`@instructions`
Kombiniere „ `tail` “ mit einer Umleitung, um die letzten 5 Zeilen von „ `seasonal/winter.csv` “ in einer Datei namens „ `last.csv` “ zu speichern.

`@hint`
Benutz „ `tail -n 5` “, um die letzten 5 Zeilen zu kriegen.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "Die Zeile `%s` sollte in der Datei `last.csv` sein, aber sie ist es nicht. Leite die Ausgabe von `tail -n 5 seasonal/winter.csv` mit `>` nach `last.csv` um."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` hat zu viele Zeilen. Hast du das Flag `-n 5` mit `tail` verwendet?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Gut gemacht! Lass uns noch ein bisschen üben!")

```

---

## Wie kann ich die Ausgabe eines Befehls als Eingabe nutzen?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Angenommen, du willst Zeilen aus der Mitte einer Datei holen.
Genauer gesagt,
Angenommen, du willst die Zeilen 3 bis 5 aus einer unserer Datendateien holen.
Du kannst mit „ `head` “ anfangen, um die ersten 5 Zeilen zu bekommen.
und leite das in eine Datei um,
und dann mit „ `tail` “ die letzten 3 auswählen:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Ein kurzer Check zeigt, dass es sich um die Zeilen 3-5 unserer Originaldatei handelt.
Weil es die letzten drei Zeilen der ersten fünf sind.

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
Wähle die letzten beiden Zeilen aus `seasonal/winter.csv`
Speicher sie in einer Datei namens „ `bottom.csv` “.

`@hint`
Benutze „ `tail` “, um Zeilen auszuwählen, und „ `>` “, um die Ausgabe von „ `tail` “ umzuleiten.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="Die Zeile `%s` sollte in der Datei `bottom.csv` sein, aber sie ist es nicht. Leiten Sie die Ausgabe von `tail -n 2 seasonal/winter.csv` mit `>` nach `bottom.csv` um."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` hat zu viele Zeilen. Haben Sie das Flag `-n 2` mit `tail` verwendet?'),
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
Wähle die erste Zeile aus `bottom.csv`
um die vorletzte Zeile der Originaldatei zu kriegen.

`@hint`
Benutz „ `head` “, um die gewünschte Zeile auszuwählen.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Mit der Datei `bottom.csv` stimmt etwas nicht. Stellen Sie sicher, dass Sie sie nicht ändern!"),
    has_expr_output(strict=True, incorrect_msg="Haben Sie `head` korrekt auf `bottom.csv` verwendet? Stellen Sie sicher, dass Sie das `-n` Flag korrekt verwenden.")
)

Ex().success_msg("Gut gemacht. Gehen Sie zur nächsten Übung, um bessere Möglichkeiten zum Kombinieren von Befehlen zu erfahren.")                             
```

---

## Wie kann man Befehle besser kombinieren?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Das Kombinieren von Befehlen mit Umleitungen hat zwei Nachteile:

1. Es bleiben viele Zwischendateien liegen (wie z. B. `top.csv`).
2. Die Befehle, die dein Endergebnis erzeugen, sind über mehrere Zeilen des Verlaufs verteilt.

The shell has another tool that solves both problems on one occasion: the **pipe**.
Noch mal,
Mach mal mit „ `head` “ los:

```{shell}
head -n 5 seasonal/summer.csv
```

Anstatt die Ausgabe von \` `head`` in eine Datei zu schreiben,
Füge einen senkrechten Strich und den Befehl „ `tail` “ *ohne* Dateinamen hinzu:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Das Pipe-Symbol sagt der shell, dass sie die Ausgabe des Befehls auf der linken Seite nehmen soll.
als Eingabe für den Befehl rechts.

`@instructions`
Benutz „ `cut` “, um alle Zahnnamen aus Spalte 2 der durch Kommas getrennten Datei „ `seasonal/summer.csv` “ auszuwählen, und leite das Ergebnis dann mit einer invertierten Übereinstimmung an „ `grep` “ weiter, um die Kopfzeile mit dem Wort „Tooth“ rauszulassen. *„`cut` “ und „ `grep` “ wurden in Kapitel 2, Übungen 8 und 11, ausführlich behandelt.*

`@hint`
- Der erste Teil des Befehls sieht so aus: `cut -d field_delimiter -f column_number filename`.
- Der zweite Teil des Befehls sieht so aus: `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'Haben Sie das Ergebnis von `cut -d , -f 2 seasonal/summer.csv` mit `|` in `grep -v Tooth` geleitet?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Haben Sie die Kopfzeile `"Tooth"` mit `grep` ausgeschlossen?')
)
Ex().success_msg("Perfektes Piping! Dies ist vielleicht das erste Mal, dass Sie `|` verwendet haben, aber es wird definitiv nicht das letzte Mal sein!")
```

---

## Wie kann ich mehrere Befehle kombinieren?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Du kannst beliebig viele Befehle miteinander verbinden.
Ein Beispiel:
dieser Befehl:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

wird:

1. Wähle die erste Spalte aus den Spring-Daten aus.
2. Entferne die Zeile mit dem Wort „Datum“ oben; und
3. Wähle die ersten 10 Zeilen der tatsächlichen Daten aus.

`@instructions`
In der letzten Übung hast du den folgenden Befehl benutzt, um alle Zahnnamen aus Spalte 2 von „ `seasonal/summer.csv` “ auszuwählen:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Erweitere diese Pipeline mit dem Befehl „ `head` “, um nur den allerersten Zahnnamen auszuwählen.

`@hint`
Kopier den Code aus der Anleitung, füge ein Pipe-Zeichen hinzu und ruf dann `head` mit dem Flag `-n` auf.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Haben Sie `|` verwendet, um die Pipeline mit einem `head`-Befehl zu erweitern? Stellen Sie sicher, dass das `-n`-Flag korrekt gesetzt ist."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Haben Sie `|` verwendet, um die Pipeline mit einem `head`-Befehl zu erweitern?")
)
Ex().success_msg("Fröhliches Verketten! Durch das Verketten mehrerer Befehle können Sie leistungsstarke Datenmanipulations-Pipelines erstellen.")

```

---

## Wie kann ich die Datensätze in einer Datei zählen?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Der Befehl „ `wc` “ (kurz für „word count“, also „Wortanzahl“) zeigt an, wie viele **Zeichen**, **Wörter**und **Zeilen**in einer Datei sind.
Du kannst es so einstellen, dass nur eines davon gedruckt wird, indem du „ `-c` “, „ `-w` “ oder „ `-l` “ verwendest.

`@instructions`
Zähl mal, wie viele Datensätze in „ `seasonal/spring.csv` “ Daten aus dem Juli 2017 haben (`2017-07`). 
- Dazu nimmst du „ `grep` “ mit einem Teil des Datums, um die Zeilen auszuwählen, und leitest das Ergebnis mit einem passenden Flag an „ `wc` “ weiter, um die Zeilen zu zählen.

`@hint`
- Benutz `head seasonal/spring.csv`, um dich an das Datumsformat zu erinnern.
- Der erste Teil des Befehls sieht so aus: `grep thing_to_match filename`.
- Nach dem Pipe-Befehl „ `|` “ rufst du „ `wc` “ mit dem Flag „ `-l` “ auf.

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
      has_code("grep", incorrect_msg = "Haben Sie `grep` aufgerufen?"),
      has_code("2017-07", incorrect_msg = "Haben Sie nach `2017-07` gesucht?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Haben Sie die Datei `seasonal/spring.csv` durchsucht?"),
      has_code("|", incorrect_msg = "Haben Sie mit `|` zu `wc` gepiped?"),      
      has_code("wc", incorrect_msg = "Haben Sie `wc` aufgerufen?"),
      has_code("-l", incorrect_msg = "Haben Sie Zeilen mit `-l` gezählt?")
    )
  )
)
Ex().success_msg("Sorgfältiges Zählen! Zu bestimmen, wie viele Daten Sie haben, ist ein großartiger erster Schritt in jeder Datenanalyse.")

```

---

## Wie kann ich mehrere Dateien auf einmal auswählen?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

Die meisten shell-Befehle funktionieren mit mehreren Dateien, wenn du ihnen mehrere Dateinamen gibst.
Ein Beispiel:
Du kannst die erste Spalte aus allen saisonalen Datendateien auf einmal so abrufen:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Aber die Namen vieler Dateien immer wieder einzugeben, ist echt nervig:
Es ist Zeitverschwendung.
und früher oder später wirst du entweder eine Datei vergessen oder einen Dateinamen wiederholen.
Um dein Leben besser zu machen,
Mit der shell kannst du **Platzhalter** verwenden, um mit einem einzigen Ausdruck eine Liste von Dateien anzugeben.
Der häufigste Platzhalter ist „ `*` “,
was so viel heißt wie „null oder mehr Zeichen übereinstimmen“.
Damit
Wir können den Befehl „ `cut` “ oben so verkürzen:

```{shell}
cut -d , -f 1 seasonal/*
```

oder:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Schreib einen einzigen Befehl mit `head`, um die ersten drei Zeilen aus `seasonal/spring.csv` und `seasonal/summer.csv` zu holen, also insgesamt sechs Zeilen Daten, aber *nicht* aus den Herbst- oder Winter-Datendateien.
Benutze einen Platzhalter, anstatt die Dateinamen komplett auszuschreiben.

`@hint`
- Der Befehl sieht so aus: `head -n number_of_lines filename_pattern`.
- Du kannst Dateien im Verzeichnis „ `a` ” abgleichen, die mit „ `b` ” anfangen, zum Beispiel mit „ `a/b*` ”.

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
    has_expr_output(incorrect_msg = "Sie können `seasonal/s*` verwenden, um `seasonal/spring.csv` und `seasonal/summer.csv` auszuwählen. Stellen Sie sicher, dass Sie nur die ersten drei Zeilen jeder Datei mit dem `-n`-Flag einbeziehen!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Schließen Sie die Ausgabe für `seasonal/autumn.csv` nicht ein. Sie können `seasonal/s*` verwenden, um `seasonal/spring.csv` und `seasonal/summer.csv` auszuwählen"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Schließen Sie die Ausgabe für `seasonal/winter.csv` nicht ein. Sie können `seasonal/s*` verwenden, um `seasonal/spring.csv` und `seasonal/summer.csv` auszuwählen")
)
Ex().success_msg("Wildes Wildcard-Arbeiten! Dies wird noch wichtiger, wenn Ihr Verzeichnis Hunderte oder Tausende von Dateien enthält.")

```

---

## Welche anderen Platzhalter kann ich verwenden?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

Die shell hat auch noch andere Platzhalter,
obwohl sie seltener benutzt werden:

- `?` passt zu einem einzelnen Zeichen, also passt „ `201?.txt` “ zu „ `2017.txt` “ oder „ `2018.txt` “, aber nicht zu „ `2017-01.txt` “.
- `[...]` passt zu jedem der Zeichen in den eckigen Klammern, also passt „ `201[78].txt` “ zu „ `2017.txt` “ oder „ `2018.txt` “, aber nicht zu „ `2016.txt` “.
- `{...}` passt zu jedem der durch Kommas getrennten Muster innerhalb der geschweiften Klammern, also passt „ `{*.txt, *.csv}` “ zu jeder Datei, deren Name auf „ `.txt` “ oder „ `.csv` “ endet, aber nicht zu Dateien, deren Namen auf „ `.pdf` “ enden.

<hr/>

Welcher Ausdruck würde zu `singh.pdf` und `johel.txt` passen, aber *nicht* zu `sandhu.pdf` oder `sandhu.txt`?

`@hint`
Vergleiche jeden Ausdruck nacheinander mit jedem Dateinamen.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Nein: „ `.pdf` “ und „ `.txt` “ sind keine Dateinamen.
- Nein: Das passt zu `sandhu.pdf`.
- Nein: Der Ausdruck in eckigen Klammern passt nur zu einem Zeichen, nicht zu ganzen Wörtern.
- Richtig!

---

## Wie kann ich Textzeilen sortieren?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Wie der Name schon sagt,
`sort` ordnet Daten.
Standardmäßig passiert das in aufsteigender alphabetischer Reihenfolge,
Aber die Optionen „ `-n` “ und „ `-r` “ kannst du nutzen, um die Ausgabe numerisch zu sortieren und die Reihenfolge umzudrehen.
während „ `-b` “ sagt, dass führende Leerzeichen ignoriert werden sollen
und „ `-f` “ sagt ihm, dass er die Groß-/Kleinschreibung **ignorieren**soll (also nicht darauf achten soll).
Pipelines nutzen oft „ `grep` “, um unerwünschte Datensätze loszuwerden.
und dann „ `sort` “, um die restlichen Datensätze zu sortieren.

`@instructions`
Erinnerst du dich an die Kombination von „ `cut` “ und „ `grep` “, um alle Zahnnamen aus Spalte 2 von „ `seasonal/summer.csv` “ auszuwählen?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Beginne mit diesem Rezept und sortiere die Namen der Zähne in „ `seasonal/winter.csv` “ (nicht „ `summer.csv` “) in absteigender alphabetischer Reihenfolge. Dazu musst du die Pipeline um einen Schritt „ `sort` “ erweitern.

`@hint`
Kopier den Befehl aus der Anleitung, änder den Dateinamen, häng ein Pipe-Zeichen an und ruf dann „ `sort` “ mit dem Flag „ `-r` “ auf.

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
      has_code("cut", incorrect_msg = "Haben Sie `cut` aufgerufen?"),
      has_code("-d", incorrect_msg = "Haben Sie einen Feldtrennzeichen mit `-d` angegeben?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Haben Sie Daten aus der Datei `seasonal/winter.csv` geholt?"),
      has_code("|", incorrect_msg = "Haben Sie von `cut` zu `grep` zu `sort` mit `|` gepiped?"),      
      has_code("grep", incorrect_msg = "Haben Sie `grep` aufgerufen?"),
      has_code("-v", incorrect_msg = "Haben Sie die Übereinstimmung mit `-v` invertiert?"),
      has_code("Tooth", incorrect_msg = "Haben Sie nach `Tooth` gesucht?"),
      has_code("sort", incorrect_msg = "Haben Sie `sort` aufgerufen?"),
      has_code("-r", incorrect_msg = "Haben Sie die Sortierreihenfolge mit `-r` umgekehrt?")
    )
  )
)
Ex().success_msg("Sortiert! `sort` hat viele Verwendungsmöglichkeiten. Zum Beispiel zeigt das Piping von `sort -n` zu `head` die größten Werte an.")

```

---

## Wie kann ich doppelte Zeilen löschen?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Ein weiterer Befehl, der oft mit „ `sort` “ zusammen benutzt wird, ist „ `uniq` “.
dessen Aufgabe es ist, doppelte Zeilen zu entfernen.
Genauer gesagt,
Es entfernt *benachbarte* doppelte Zeilen.
Wenn eine Datei Folgendes enthält:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

Dann wird „ `uniq` “ Folgendes erzeugen:

```
2017-07-03
2017-08-03
```

aber wenn es enthält:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

Dann wird „ `uniq` “ alle vier Zeilen ausgeben.
Der Grund dafür ist, dass „ `uniq` “ für die Arbeit mit sehr großen Dateien entwickelt wurde.
Um nicht benachbarte Zeilen aus einer Datei zu löschen,
Es müsste die ganze Datei im Speicher behalten.
(oder zumindest,
alle bisher gesehenen einzigartigen Linien).
Indem man nur benachbarte Duplikate entfernt,
Es muss nur die aktuellste eindeutige Zeile im Speicher behalten.

`@instructions`
Schreib eine Pipeline an:

- Hol die zweite Spalte von `seasonal/winter.csv`,
- Entfern das Wort „Tooth“ aus der Ausgabe, damit nur die Namen der Zähne angezeigt werden.
- Sortier die Ausgabe so, dass alle Vorkommen eines bestimmten Zahnnamens nebeneinander liegen; und
- Zeig jeden Zahnnamen einmal zusammen mit der Häufigkeit seines Vorkommens an.

Der Anfang deiner Pipeline ist derselbe wie in der vorherigen Übung:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Erweitere es mit dem Befehl „ `sort` “ und benutze „ `uniq -c` “, um eindeutige Zeilen mit einer Zählung ihrer Häufigkeit anzuzeigen, anstatt „ `uniq` “ und „ `wc` “ zu verwenden.

`@hint`
Kopier den Befehl aus der Anleitung, leite ihn ohne Flags an „ `sort` “ weiter und dann mit dem Flag „ `-c` “ an „ `uniq` “.

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
                     incorrect_msg="Sie sollten mit diesem Befehl beginnen: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Jetzt erweitern Sie ihn!"),
            has_code('\|\s+sort', incorrect_msg="Haben Sie den Befehl mit `| sort` erweitert?"),
            has_code('\|\s+uniq', incorrect_msg="Haben Sie den Befehl mit `| uniq` erweitert?"),
            has_code('-c', incorrect_msg="Haben Sie die Zählungen mit `-c` eingeschlossen?")
        )
    )
)
Ex().success_msg("Großartig! Nach all dieser Arbeit an einer Pipe wäre es schön, wenn wir das Ergebnis speichern könnten, oder?")

```

---

## Wie kann ich die Ausgabe einer Pipe speichern?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Mit der shell können wir die Ausgabe einer Reihe von Befehlen, die über die Pipe verbunden sind, umleiten:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Allerdings muss „ `>` “ am Ende der Pipeline stehen:
Wenn wir versuchen, es in der Mitte zu verwenden, etwa so:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

Dann wird die ganze Ausgabe von „ `cut` “ in „ `teeth-only.txt` “ geschrieben.
also gibt's nichts mehr für `grep`
und wartet ewig auf eine Eingabe.

<hr>

Was passiert, wenn wir die Umleitung wie folgt an den Anfang einer Pipeline setzen:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [Die Ausgabe des Befehls wird wie immer in die Datei umgeleitet.]
- Die shell meldet das als Fehler.
- Die shell wartet ewig auf Eingaben.

`@hint`
Probier's mal in der shell aus.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Richtig!', 'Nein; die Shell kann dies tatsächlich ausführen.', 'Nein; die Shell kann dies tatsächlich ausführen.'])
```

---

## Wie kann ich ein laufendes Programm beenden?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Die Befehle und Skripte, die du bisher ausgeführt hast, sind alle schnell gelaufen.
Aber manche Aufgaben dauern Minuten, Stunden oder sogar Tage, bis sie erledigt sind.
Du könntest auch aus Versehen eine Umleitung mitten in einer Pipeline einfügen,
was dazu führt, dass es sich aufhängt.
Wenn du nicht willst, dass ein Programm weiterläuft,
Du kannst „ `Ctrl` “ + „ `C` “ eingeben, um es zu beenden.
In der Unix-Dokumentation steht das oft so: „ `^C` “;
Beachte, dass das „c“ klein geschrieben werden kann.

`@instructions`
Mach den Befehl:

```{shell}
head
```

ohne Argumente (damit es auf eine Eingabe wartet, die nie kommt)
und dann hör auf, indem du `Ctrl` + `C` eingibst.

`@hint`
Einfach „head“ eingeben, die Eingabetaste drücken und das laufende Programm mit „ `Ctrl` + `C` “ beenden.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Haben Sie `head` verwendet?")
```

---

## Abschluss

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Zum Schluss noch mal zusammengefasst:
Du wirst eine Pipeline erstellen, um herauszufinden, wie viele Datensätze in der kürzesten der saisonalen Datendateien enthalten sind.

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
Benutze „ `wc` “ mit den richtigen Parametern, um die Anzahl der Zeilen in allen saisonalen Datendateien anzuzeigen.
Benutz einfach einen Platzhalter für die Dateinamen, statt sie alle von Hand einzugeben.

`@hint`
Benutze „ `-l` “, um nur die Zeilen aufzulisten, und „ `*` “, um Dateinamen zu finden.

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
      has_code("wc", incorrect_msg = "Haben Sie `wc` aufgerufen?"),
      has_code("-l", incorrect_msg = "Haben Sie die Anzahl der Zeilen mit `-l` gezählt?"),
      has_code("seasonal/\*", incorrect_msg = "Haben Sie Daten aus allen `seasonal/*` Dateien geholt?")
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
Füge dem vorherigen Befehl mit einer Pipe einen weiteren Befehl hinzu, um die Zeile mit dem Wort „total” zu löschen.

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
      has_code("wc", incorrect_msg = "Haben Sie `wc` aufgerufen?"),
      has_code("-l", incorrect_msg = "Haben Sie die Anzahl der Zeilen mit `-l` gezählt?"),
      has_code("seasonal/\*", incorrect_msg = "Haben Sie Daten aus allen `seasonal/*` Dateien geholt?"),
      has_code("|", incorrect_msg = "Haben Sie von `wc` zu `grep` mit `|` gepiped?"),      
      has_code("grep", incorrect_msg = "Haben Sie `grep` aufgerufen?"),
      has_code("-v", incorrect_msg = "Haben Sie die Übereinstimmung mit `-v` invertiert?"),
      has_code("total", incorrect_msg = "Haben Sie nach `total` gesucht?")
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
Füge der Pipeline zwei weitere Schritte hinzu, die `sort -n` und `head -n 1` nutzen, um die Datei mit den wenigsten Zeilen zu finden.

`@hint`
- Benutze das Flag „ `-n` ” von „ `sort` ”, um numerisch zu sortieren.
- Benutze das Flag „ `-n` ” von „ `head` ”, um nur eine Zeile zu behalten.

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
      has_code("wc", incorrect_msg = "Haben Sie `wc` aufgerufen?"),
      has_code("-l", incorrect_msg = "Haben Sie die Anzahl der Zeilen mit `-l` gezählt?"),
      has_code("seasonal/\*", incorrect_msg = "Haben Sie Daten aus allen `seasonal/*` Dateien geholt?"),
      has_code("|", incorrect_msg = "Haben Sie von `wc` zu `grep` zu `sort` zu `head` mit `|` gepiped?"),      
      has_code("grep", incorrect_msg = "Haben Sie `grep` aufgerufen?"),
      has_code("-v", incorrect_msg = "Haben Sie die Übereinstimmung mit `-v` invertiert?"),
      has_code("total", incorrect_msg = "Haben Sie nach `total` gesucht?"),
      has_code("sort", incorrect_msg = "Haben Sie `sort` aufgerufen?"),
      has_code("-n", incorrect_msg = "Haben Sie die Anzahl der zu behaltenden Zeilen mit `-n` angegeben?"),
      has_code("1", incorrect_msg = "Haben Sie 1 Zeile mit `-n 1` angegeben?")
    )
  )
)
Ex().success_msg("Großartig! Es stellt sich heraus, dass `autumn.csv` die Datei mit den wenigsten Zeilen ist. Eilen Sie zu Kapitel 4, um mehr über die Stapelverarbeitung zu erfahren!")

```

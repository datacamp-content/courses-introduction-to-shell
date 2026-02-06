---
title: Daten manipulieren
description: >-
  Mit den Befehlen, die du im letzten Kapitel gesehen hast, konntest du Sachen
  im Dateisystem verschieben. In diesem Kapitel lernst du, wie du mit den Daten
  in diesen Dateien umgehst. Die Tools, die wir benutzen werden, sind ziemlich
  einfach, aber solide Bausteine.
lessons:
  - nb_of_exercises: 12
    title: Wie kann ich den Inhalt einer Datei anzeigen?
---

## Wie kann ich den Inhalt einer Datei anzeigen?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Bevor du Dateien umbenennst oder löschst,
Du solltest dir vielleicht mal den Inhalt anschauen.
Am einfachsten geht das mit `cat`,
das einfach den Inhalt von Dateien auf dem Bildschirm anzeigt.
(Der Name ist die Kurzform von „concatenate“, was so viel heißt wie „Dinge miteinander verbinden“.
denn es druckt alle Dateien, die du ihm nennst, eine nach der anderen aus.)

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
Gib den Inhalt von „ `course.txt` “ auf dem Bildschirm aus.

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
    has_expr_output(incorrect_msg="Ihr Befehl hat nicht die richtige Ausgabe erzeugt. Haben Sie `cat` gefolgt vom Namen der Datei, `course.txt`, verwendet?")
)
Ex().success_msg("Gut gemacht! Schauen wir uns andere Möglichkeiten an, den Inhalt einer Datei anzuzeigen.")
```

---

## Wie kann ich den Inhalt einer Datei Stück für Stück anschauen?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Du kannst „ `cat` “ benutzen, um große Dateien auszudrucken und dann durch die Ausgabe zu scrollen.
Aber meistens ist es einfacher, die Ausgabe zu **paginieren**.
Der ursprüngliche Befehl dafür hieß „ `more` “.
Aber es wurde durch einen stärkeren Befehl namens „ `less` “ ersetzt.
(So was ist in der Unix-Welt als Witz gedacht.)
Wenn du eine Datei mit „ `less` “ öffnest,
Es wird immer nur eine Seite angezeigt.
Du kannst die Leertaste drücken, um weiterzublättern, oder „ `q` “ eingeben, um das Programm zu beenden.

Wenn du `less` die Namen mehrerer Dateien gibst,
Du kannst „ `:n` “ (Doppelpunkt und ein kleines „n“) eingeben, um zur nächsten Datei zu springen.
`:p` um zum vorherigen zurückzugehen,
Oder drück einfach auf „ `:q` “, um das Programm zu beenden.

Hinweis: Wenn du dir Lösungen zu Übungen anschaust, die `less` verwenden,
Am Ende siehst du einen zusätzlichen Befehl, der die Seitenaufteilung *deaktiviert*.
damit wir deine Lösungen effizient testen können.

`@instructions`
Benutze „ `less seasonal/spring.csv seasonal/summer.csv` “, um diese beiden Dateien in dieser Reihenfolge anzuzeigen.
Drück die Leertaste, um weiterzublättern, „ `:n` “, um zur zweiten Datei zu gehen, und „ `:q` “, um das Programm zu beenden.

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
                 incorrect_msg='Verwenden Sie `less` und die Dateinamen. Denken Sie daran, dass `:n` Sie zur nächsten Datei bringt.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Wie kann ich mir den Anfang einer Datei anschauen?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Das Erste, was die meisten Datenwissenschaftler machen, wenn sie einen neuen Datensatz zur Analyse bekommen, ist
Finde raus, welche Felder es hat und welche Werte diese Felder haben.
Wenn der Datensatz aus einer Datenbank oder einer Tabellenkalkulation exportiert wurde,
Es wird oft als **kommagetrennte Werte** (CSV) gespeichert.
Um schnell zu sehen, was drinsteht, schau dir einfach die ersten paar Zeilen an.

Das können wir in der shell mit dem Befehl „ `head` “ machen.
Wie der Name schon sagt,
Es druckt die ersten paar Zeilen einer Datei.
(wobei „ein paar“ 10 bedeutet),
also der Befehl:

```{shell}
head seasonal/summer.csv
```

displays:

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

Was macht „ `head` “, wenn die Datei nicht 10 Zeilen hat?
(Um das rauszufinden, schau dir einfach mal den oberen Teil von `people/agarwal.txt` an.)

`@possible_answers`
- Druck eine Fehlermeldung aus, weil die Datei zu kurz ist.
- Zeig so viele Zeilen an, wie es gibt.
- Zeig genug Leerzeilen an, damit es insgesamt 10 sind.

`@hint`
Was wäre das Nützlichste, was es tun könnte?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Falsch: Das ist nicht das Nützlichste, was es tun könnte.",
                    "Richtig!",
                    "Falsch: Das wäre nicht von einer Datei zu unterscheiden, die mit einer Menge leerer Zeilen endet."])
```

---

## Wie kann ich weniger tippen?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Eines der Power-Tools der shell ist **die Tab-Vervollständigung**.
Wenn du anfängst, den Namen einer Datei einzugeben, und dann die Tabulatortaste drückst,
Die shell wird versuchen, den Pfad automatisch zu vervollständigen.
Ein Beispiel:
Wenn du „ `sea` “ eingibst und die Tabulatortaste drückst,
Es wird der Verzeichnisname „ `seasonal/` “ (mit einem Schrägstrich am Ende) eingegeben.
Wenn du dann „ `a` “ eingibst und die Tabulatortaste drückst,
Der Pfad wird dann wie folgt vervollständigt: `seasonal/autumn.csv`.

Wenn der Pfad nicht eindeutig ist,
wie zum Beispiel `seasonal/s`,
Wenn du die Tabulatortaste noch mal drückst, bekommst du eine Liste mit Optionen.
Einfach ein oder zwei Zeichen mehr eingeben, um deinen Weg genauer zu machen.
und dann die Tabulatortaste drücken
wird den Rest des Namens ausfüllen.

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
Mach mal „ `head seasonal/autumn.csv` “, ohne den ganzen Dateinamen einzugeben.

`@hint`
Gib so viel vom Pfad ein, wie du brauchst, drück dann die Tabulatortaste und mach das Gleiche nochmal.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Der Prüfer konnte die richtige Ausgabe in Ihrem Befehl nicht finden. Sind Sie sicher, dass Sie `head` auf `seasonal/autumn.csv` aufgerufen haben?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Mach mal „ `head seasonal/spring.csv` “, ohne den ganzen Dateinamen einzugeben.

`@hint`
Gib so viel vom Pfad ein, wie du brauchst, drück dann die Tabulatortaste und mach das Gleiche nochmal.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Der Prüfer konnte die richtige Ausgabe in Ihrem Befehl nicht finden. Sind Sie sicher, dass Sie `head` auf `seasonal/spring.csv` angewendet haben?")
)
Ex().success_msg("Gute Arbeit! Sobald Sie sich an die Verwendung der Tab-Vervollständigung gewöhnt haben, wird sie Ihnen viel Zeit sparen!")
```

---

## Wie kann ich steuern, was Befehle machen?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Du wirst nicht immer die ersten 10 Zeilen einer Datei anschauen wollen,
Mit der shell kannst du also das Verhalten von `head` ändern.
indem du ihm ein **Befehlszeilenflag** (oder kurz „Flag“) gibst.
Wenn du den Befehl ausführst:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` zeigt nur die ersten drei Zeilen der Datei an.
Wenn du `head -n 100` ausführst,
Es werden die ersten 100 angezeigt (wenn es so viele gibt).
und so weiter.

Der Name einer Flagge sagt meistens was über ihren Zweck aus.
(Zum Beispiel soll „ `-n` “**„Anzahl**der Zeilen“ bedeuten.)
Befehlsflags müssen nicht unbedingt aus „ `-` “ gefolgt von einem einzelnen Buchstaben bestehen.
aber es ist eine weit verbreitete Konvention.

Hey, es ist cool, alle Flags *vor* den Dateinamen zu setzen,
Also in diesem Kurs
Wir akzeptieren nur Antworten, die das tun.

`@instructions`
Zeig die ersten 5 Zeilen von „ `winter.csv` ” im Verzeichnis „ `seasonal` ” an.

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
        has_expr_output(incorrect_msg="Bist du sicher, dass du `head` auf die Datei `seasonal/winter.csv` anwendest?"),
        has_expr_output(strict=True, incorrect_msg="Bist du sicher, dass du die Option `-n 5` verwendet hast?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Bist du sicher, dass du die Option `-n 5` verwendet hast?")
)
Ex().success_msg("Schön! Mit dieser Technik kannst du verhindern, dass deine Shell abstürzt, wenn du größere Textdateien ansehen möchtest.")
```

---

## Wie kann ich alles unterhalb eines Verzeichnisses auflisten?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Um alles unter einem Verzeichnis zu sehen,
egal wie tief es verschachtelt ist,
Du kannst `ls` die Flagge geben. `-R`
(was „rekursiv” heißt).
Wenn du „ `ls -R` “ in deinem Home-Verzeichnis benutzt,
Du wirst so was wie das hier sehen:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Hier siehst du alle Dateien und Verzeichnisse auf der aktuellen Ebene.
dann alles in jedem Unterverzeichnis,
und so weiter.

`@instructions`
Damit du weißt, was was ist,
`ls` hat noch eine weitere Option, nämlich ` `-F` \`, die nach dem Namen jedes Verzeichnisses die Angabe „ `/` “ ausgibt.
und ein „ `*` “ hinter dem Namen jedes ausführbaren Programms.
Führ „ `ls` “ mit den beiden Flags „ `-R` “ und „ `-F` “ sowie dem absoluten Pfad zu deinem Home-Verzeichnis aus.
um alles zu sehen, was drin ist.
(Die Reihenfolge der Flags ist egal, aber der Verzeichnisname muss am Ende stehen.)

`@hint`
Dein Home-Verzeichnis kannst du mit `~` oder `.` oder seinem absoluten Pfad angeben.

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
  has_expr_output(incorrect_msg='Verwenden Sie entweder `ls -R -F` oder `ls -F -R` und den Pfad `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Verwenden Sie entweder `ls -R -F` oder `ls -F -R` und den Pfad `/home/repl`.')
)
Ex().success_msg("Das ist doch ein ziemlich übersichtlicher Überblick, oder?")

```

---

## Wie kriege ich Hilfe zu einem Befehl?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Um herauszufinden, was Befehle machen,
Früher haben die Leute den Befehl „ `man` “ benutzt.
(Abkürzung für „Handbuch“).
Ein Beispiel:
Der Befehl „ `man head` “ zeigt diese Infos an:

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

`man` ruft automatisch `less` auf,
Du musst vielleicht die Leertaste drücken, um durch die Infos zu blättern.
und `:q`, um zu kündigen.

Die kurze Beschreibung unter „ `NAME` “ sagt dir kurz, was der Befehl macht.
und die Zusammenfassung unter „ `SYNOPSIS` “ zeigt alle Flags, die es versteht.
Alles, was optional ist, wird in eckigen Klammern angezeigt `[...]`,
Entweder-oder-Alternativen werden durch „ `|` “ getrennt.
und Sachen, die wiederholt werden können, werden durch „ `...` “ angezeigt,
Also, die Handbuchseite von \` `head`` sagt dir, dass du *entweder* eine Zeilenzahl mit `-n`
oder eine Byteanzahl mit `-c`,
und dass du ihm beliebig viele Dateinamen geben kannst.

Das Problem mit dem Unix-Handbuch ist, dass man wissen muss, wonach man sucht.
Wenn du das nicht tust,
Du kannst [Stack Overflow](https://stackoverflow.com/) durchsuchen,
Frag einfach auf den Slack-Kanälen von DataCamp nach.
oder schau dir die Abschnitte „ `SEE ALSO` “ der Befehle an, die du schon kennst.

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
Schau dir die Handbuchseite für den Befehl „ `tail` “ an, um mehr zu erfahren.
Was passiert, wenn man ein „ `+` “-Zeichen vor die Zahl setzt, die mit dem „ `-n` “-Flag verwendet wird?
(Denk dran, die Leertaste zu drücken, um weiterzublättern, und/oder „ `q` “ einzugeben, um das Programm zu beenden.)

`@hint`
Denk dran: „ `man` ” ist die Abkürzung für „manual” (Handbuch).

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Verwenden Sie `man` und den Befehlsnamen.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Benutze „ `tail` “ mit dem Flag „ `-n +7` “, um alle Zeilen *außer* den ersten sechs von „ `seasonal/spring.csv` “ anzuzeigen.

`@hint`
Setz ein Pluszeichen „+“ vor die Anzahl der Zeilen, die angezeigt werden sollen.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Rufen Sie `tail` auf `seasonal/spring.csv` auf?"),
    has_expr_output(strict=True, incorrect_msg="Sind Sie sicher, dass Sie die Flagge `-n +7` verwendet haben?")
)
```

---

## Wie kann ich Spalten aus einer Datei auswählen?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` und „ `tail` “ lassen dich Zeilen aus einer Textdatei auswählen.
Wenn du Spalten auswählen willst,
Du kannst den Befehl „ `cut` “ benutzen.
Es gibt ein paar Optionen (schau mal unter „ `man cut` “ nach, um sie zu entdecken).
aber am häufigsten ist so was wie:

```{shell}
cut -f 2-5,8 -d , values.csv
```

was bedeutet
Wähle die Spalten 2 bis 5 und die Spalte 8 aus.
Komma als Trennzeichen verwenden".
`cut` benutzt „ `-f` ” (was „Felder” heißt), um Spalten zu beschreiben
und „ `-d` “ (bedeutet „Trennzeichen“), um das Trennzeichen festzulegen.
Du musst das Letztere angeben, weil manche Dateien Leerzeichen, Tabulatoren oder Doppelpunkte zum Trennen von Spalten verwenden können.

<hr>

Welcher Befehl wählt die erste Spalte (mit den Datumsangaben) aus der Datei „ `spring.csv` “ aus?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Eins von den oben genannten.
- Keines von beiden, weil „ `-f` “ vor „ `-d` “ kommen muss.

`@hint`
Die Reihenfolge der Flaggen ist egal.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Ja, aber das ist nicht alles', 'Ja, aber das ist nicht alles', 'Korrekt! Ein Leerzeichen nach der Flagge hinzuzufügen ist guter Stil, aber nicht zwingend erforderlich.', 'Nein, die Reihenfolge der Flags spielt keine Rolle'])
```

---

## Was kann man nicht schneiden?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` ist ein simpler Befehl.
Insbesondere
Es versteht keine String-Quotierungen.
Wenn deine Datei zum Beispiel so aussieht:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

dann:

```{shell}
cut -f 2 -d , everyone.csv
```

wird produzieren:

```
Age
Ranjit"
Rupinder"
```

anstatt das Alter von allen,
Weil es denkt, dass das Komma zwischen Nachnamen und Vornamen ein Spaltentrennzeichen ist.

<hr>

Was gibt die Befehlszeile „ `cut -d : -f 2-4` “ in der folgenden Zeile aus:

```
first:second:third:
```

(Achte auf den Doppelpunkt am Ende.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Keines der oben genannten, weil es keine vier Felder gibt.

`@hint`
Pass auf den Doppelpunkt am Ende auf.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Nein, da ist mehr.', 'Nein, da ist mehr.', 'Korrekt! Der nachgestellte Doppelpunkt erzeugt ein viertes leeres Feld.', 'Nein, `cut` tut sein Bestes.'])
```

---

## Wie kann ich Befehle wiederholen?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Einer der größten Vorteile der shell ist, dass
Das macht es dir leicht, Sachen nochmal zu machen.
Wenn du ein paar Befehle ausführst,
Du kannst dann die Aufwärtspfeiltaste drücken, um sie wieder durchzugehen.
Du kannst sie auch mit den Pfeiltasten links und rechts und der Entf-Taste bearbeiten.
Wenn du die Eingabetaste drückst, wird der geänderte Befehl ausgeführt.

Noch besser: Mit „ `history` “ kannst du eine Liste der Befehle ausdrucken, die du zuletzt ausgeführt hast.
Jeder hat eine Seriennummer, damit man bestimmte Befehle einfach wiederholen kann:
Gib einfach „ `!55` “ ein, um den 55. Befehl in deinem Verlauf nochmal auszuführen (falls du so viele hast).
Du kannst einen Befehl auch nochmal ausführen, indem du ein Ausrufezeichen und dann den Namen des Befehls eingibst.
wie zum Beispiel `!head` oder `!cut`,
damit kannst du den letzten Befehl nochmal ausführen.

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
Mach mal „ `head summer.csv` ” in deinem Home-Verzeichnis (das sollte nicht klappen).

`@hint`
Die Tab-Vervollständigung klappt nicht, wenn es keinen passenden Dateinamen gibt.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Verwenden Sie `head` und einen Dateinamen, `summer.csv`. Machen Sie sich keine Sorgen, wenn es fehlschlägt. Es sollte so sein.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Wechsel zum Verzeichnis „ `seasonal` “.

`@hint`
Denk dran, dass „ `cd` ” „Verzeichnis wechseln” heißt.

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
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Mach den Befehl „ `head` “ nochmal mit „ `!head` “.

`@hint`
Schreib keine Leerzeichen zwischen „ `!` “ und dem, was danach kommt.

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
                        incorrect_msg='Verwenden Sie `!head`, um den `head`-Befehl zu wiederholen.'),
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
Schau mal mit „ `history` ” nach, was du gemacht hast.

`@hint`
Beachte, dass „ `history` “ die neuesten Befehle zuletzt anzeigt, sodass sie nach Abschluss der Ausführung auf deinem Bildschirm stehen bleiben.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Verwenden Sie `history` ohne Flags, um eine Liste der vorherigen Befehle zu erhalten.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Starte „ `head` “ nochmal mit „ `!` “ und gib dann eine Befehlsnummer ein.

`@hint`
Schreib *keine* Leerzeichen zwischen „ `!` “ und dem, was danach kommt.

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
                        incorrect_msg='Haben Sie `!<eine_Zahl>` verwendet, um das letzte `head` aus der Historie erneut auszuführen?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Gut gemacht! Weiter zum nächsten!")

```

---

## Wie kann ich Zeilen mit bestimmten Werten auswählen?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` und `tail` Zeilen auswählen,
`cut` wählt Spalten aus,
und „ `grep` “ wählt Zeilen nach ihrem Inhalt aus.
In der einfachsten Form
`grep` nimmt einen Text, gefolgt von einem oder mehreren Dateinamen
und druckt alle Zeilen in diesen Dateien aus, die diesen Text haben.
Ein Beispiel:
`grep bicuspid seasonal/winter.csv`
Druckt Zeilen aus „ `winter.csv` “, die „bicuspid“ enthalten.

`grep` kann auch nach Mustern suchen;
Wir werden uns damit im nächsten Kurs beschäftigen.
Was jetzt wichtiger ist, sind ein paar der häufigeren Flags von „ `grep` “:

- `-c`: Gib die Anzahl der übereinstimmenden Zeilen aus, nicht die Zeilen selbst.
- `-h`: Beim Suchen mehrerer Dateien die Dateinamen *nicht* anzeigen
- `-i`Groß-/Kleinschreibung ignorieren (z. B. „Regression” und „regression” als Übereinstimmungen behandeln)
- `-l`: Gib die Namen der Dateien aus, die Übereinstimmungen enthalten, nicht die Übereinstimmungen selbst.
- `-n`: Zeilennummern für übereinstimmende Zeilen drucken
- `-v`: Kehr die Übereinstimmung um, d. h. zeig nur Zeilen, die *nicht* übereinstimmen.

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
Druck den Inhalt aller Zeilen aus, die das Wort „ `molar` “ enthalten, in `seasonal/autumn.csv`
indem du einen einzigen Befehl in deinem Home-Verzeichnis ausführst. Benutz keine Flags.

`@hint`
Benutze „ `grep` “ mit dem Wort, das du suchst, und dem Namen der Datei(en), in der/denen du suchen willst.

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
      has_code("grep", incorrect_msg = "Haben Sie `grep` aufgerufen?"),
      has_code("molar", incorrect_msg = "Haben Sie nach `molar` gesucht?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Haben Sie die Datei `seasonal/autumn.csv` durchsucht?")
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
Kehr die Übereinstimmung um, um alle Zeilen zu finden, die das Wort „ `molar` ” in „ `seasonal/spring.csv` ” *nicht* haben, und zeig ihre Zeilennummern an.
Denk dran, es ist besser, alle Flags *vor* anderen Werten wie Dateinamen oder dem Suchbegriff „molar“ zu setzen.

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
      has_code("grep", incorrect_msg = "Haben Sie `grep` aufgerufen?"),
      has_code("-v", incorrect_msg = "Haben Sie die Übereinstimmung mit `-v` invertiert?"),
      has_code("-n", incorrect_msg = "Haben Sie die Zeilennummern mit `-n` angezeigt?"),
      has_code("molar", incorrect_msg = "Haben Sie nach `molar` gesucht?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Haben Sie die Datei `seasonal/spring.csv` durchsucht?")
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
Zähl mal, wie viele Zeilen das Wort „ `incisor` ” in „ `autumn.csv` ” und „ `winter.csv` ” zusammen vorkommt.
(Führ wieder einen einzigen Befehl von deinem Home-Verzeichnis aus.)

`@hint`
Denk dran, „ `-c` “ mit „ `grep` “ zu benutzen, um Zeilen zu zählen.

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
      has_code("grep", incorrect_msg = "Haben Sie `grep` aufgerufen?"),
      has_code("-c", incorrect_msg = "Haben Sie die Anzahl mit `-c` ermittelt?"),
      has_code("incisor", incorrect_msg = "Haben Sie nach `incisor` gesucht?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Haben Sie die Datei `seasonal/autumn.csv` durchsucht?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Haben Sie die Datei `seasonal/winter.csv` durchsucht?")
    )
  )
)
```

---

## Warum ist es nicht immer okay, Daten einfach als Text zu behandeln?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

Der Abschnitt „ `SEE ALSO` “ auf der Handbuchseite für „ `cut` “ erwähnt einen Befehl namens `paste`
das man nutzen kann, um Datendateien zusammenzufügen, anstatt sie zu zerschneiden.

<hr>

Schau dir mal die Handbuchseite für „ `paste` “ an.
und dann „ `paste` “ ausführen, um die Herbst- und Winterdatendateien in einer einzigen Tabelle zusammenzufassen
mit einem Komma als Trennzeichen.
Was stimmt mit den Ergebnissen aus Sicht der Datenanalyse nicht?

`@possible_answers`
- Die Spaltenüberschriften werden wiederholt.
- Die letzten paar Zeilen haben die falsche Anzahl an Spalten.
- Einige Daten von `winter.csv` fehlen.

`@hint`
Wenn du die Ausgabe von `paste` mit `cut` und Kommas als Trennzeichen ausgibst,
Würde das die richtige Antwort bringen?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Stimmt, aber es ist nicht unbedingt ein Fehler.'
correct2 = 'Korrekt: Das Zusammenfügen der Zeilen mit Spalten erzeugt nur eine leere Spalte am Anfang, nicht zwei.'
err3 = 'Nein, alle Winterdaten sind vorhanden.'
Ex().has_chosen(2, [err1, correct2, err3])
```

---
title: Elaborazione in batch
description: >-
  La maggior parte dei comandi della shell può elaborare molti file in una volta
  sola. Questo capitolo ti mostra come far sì che anche le tue pipeline lo
  facciano. Lungo il percorso, vedrai come la shell utilizza le variabili per
  memorizzare informazioni.
lessons:
  - nb_of_exercises: 10
    title: Come memorizza le informazioni la shell?
---

## Come memorizza le informazioni la shell?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Come altri programmi, la shell memorizza le informazioni in variabili.
Alcune di queste,
chiamate **variabili d'ambiente**,
sono sempre disponibili.
I nomi delle variabili d'ambiente sono convenzionalmente scritti in maiuscolo,
e qui sotto ne vedi alcune tra le più usate.

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | Directory home dell'utente        | `/home/repl`          |
| `PWD `   | Directory di lavoro corrente      | Uguale al comando `pwd` |
| `SHELL`  | Shell in uso                      | `/bin/bash`           |
| `USER`   | ID dell'utente                    | `repl`                |

Per ottenere l'elenco completo (piuttosto lungo),
puoi digitare `set` nella shell.

<hr>

Usa `set` e `grep` con una pipe per visualizzare il valore di `HISTFILESIZE`,
che determina quanti comandi passati vengono salvati nella cronologia.
Qual è il suo valore?

`@possible_answers`
- 10
- 500
- [2000]
- La variabile non è presente.

`@hint`
Usa `set | grep HISTFILESIZE` per ottenere la riga che ti serve.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "No: la shell registra più cronologia di così."
err2 = "No: la shell registra più cronologia di così."
correct3 = "Corretto: la shell salva 2000 vecchi comandi per impostazione predefinita su questo sistema."
err4 = "No: la variabile `HISTFILESIZE` è presente."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Come posso stampare il valore di una variabile?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Un modo più semplice per trovare il valore di una variabile è usare un comando chiamato `echo`, che stampa i suoi argomenti. Digitando

```{shell}
echo hello DataCamp!
```

stampa

```
hello DataCamp!
```

Se provi a usarlo per stampare il valore di una variabile in questo modo:

```{shell}
echo USER
```

stamperà il nome della variabile, `USER`.

Per ottenere il valore della variabile, devi mettere un simbolo del dollaro `$` davanti. Digitando 

```{shell}
echo $USER
```

stampa

```
repl
```

Questo vale ovunque:
per ottenere il valore di una variabile chiamata `X`,
devi scrivere `$X`.
(Serve perché la shell possa capire se intendi "un file chiamato X"
oppure "il valore di una variabile chiamata X".)

`@instructions`
La variabile `OSTYPE` contiene il nome del tipo di sistema operativo che stai usando.
Visualizza il suo valore usando `echo`.

`@hint`
Chiama `echo` con la variabile `OSTYPE` preceduta da `$`.

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
            has_code('echo', incorrect_msg="Hai chiamato `echo`?"),
            has_code('OSTYPE', incorrect_msg="Hai stampato la variabile d'ambiente `OSTYPE`?"),
            has_code(r'\$OSTYPE', incorrect_msg="Assicurati di anteporre `OSTYPE` con un `$`.")
        )
    )
)
Ex().success_msg("Eccellente eco delle variabili d'ambiente! Sei partito bene. Andiamo avanti!")
```

---

## In quali altri modi la shell memorizza le informazioni?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

L'altro tipo di variabile è chiamata **variabile della shell**,
che è simile a una variabile locale in un linguaggio di programmazione.

Per creare una variabile della shell,
ti basta assegnare un valore a un nome:

```{shell}
training=seasonal/summer.csv
```

*senza* spazi prima o dopo il segno `=`.
Dopo averlo fatto,
puoi verificare il valore della variabile con:

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
Definisci una variabile chiamata `testing` con valore `seasonal/winter.csv`.

`@hint`
Non ci devono essere spazi tra il nome della variabile e il suo valore.

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
        has_code('testing', incorrect_msg='Hai definito una variabile shell chiamata `testing`?'),
        has_code('testing=', incorrect_msg='Hai scritto `=` direttamente dopo testing, senza spazi?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Hai impostato il valore di `testing` su `seasonal/winter.csv`?')
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
Usa `head -n 1 QUALCOSA` per ottenere la prima riga da `seasonal/winter.csv`
usando il valore della variabile `testing` al posto del nome del file.

`@hint`
Ricorda di usare `$testing` e non solo `testing`
(il `$` serve per ottenere il valore della variabile).

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
    has_code(r'\$testing', incorrect_msg="Hai fatto riferimento alla variabile di shell usando `$testing`?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Hai chiamato `head`?"),
            has_code('-n', incorrect_msg="Hai limitato il numero di righe con `-n`?"),
            has_code(r'-n\s+1', incorrect_msg="Hai scelto di mantenere 1 riga con `-n 1`?")     
        )
    )
)
Ex().success_msg("Stellare! Vediamo come puoi ripetere i comandi facilmente.")
```

---

## Come posso ripetere un comando molte volte?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Le variabili della shell vengono usate anche nei **cicli**,
che ripetono i comandi molte volte.
Se eseguiamo questo comando:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

produce:

```
gif
jpg
png
```

Osserva questi aspetti del ciclo:

1. La struttura è `for` ...variabile... `in` ...lista... `; do` ...corpo... `; done`
2. La lista di elementi che il ciclo deve elaborare (nel nostro caso, le parole `gif`, `jpg` e `png`).
3. La variabile che tiene traccia dell'elemento che il ciclo sta elaborando al momento (nel nostro caso, `filetype`).
4. Il corpo del ciclo che esegue l'elaborazione (nel nostro caso, `echo $filetype`).

Nota che il corpo usa `$filetype` per ottenere il valore della variabile invece di usare semplicemente `filetype`,
proprio come avviene con qualsiasi altra variabile della shell.
Nota anche dove vanno i punti e virgola:
il primo è tra la lista e la parola chiave `do`,
e il secondo è tra il corpo e la parola chiave `done`.

`@instructions`
Modifica il ciclo in modo che stampi:

```
docx
odt
pdf
```

Usa `filetype` come nome della variabile del ciclo.

`@hint`
Usa la struttura del codice mostrata nel testo introduttivo, sostituendo i tipi di file immagine con tipi di file documento.

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
      has_code('for', incorrect_msg='Hai usato `for`?'),
      has_code('filetype', incorrect_msg='Hai usato `filetype` come variabile del ciclo?'),
      has_code('in', incorrect_msg='Hai usato `in` prima dell\'elenco dei tipi di file?'),
      has_code('docx odt pdf', incorrect_msg='Hai iterato su `docx`, `odt` e `pdf` in quell\'ordine?'),
      has_code(r'pdf\s*;', incorrect_msg='Hai messo un punto e virgola dopo l\'ultimo elemento del ciclo?'),
      has_code(r';\s*do', incorrect_msg='Hai usato `do` dopo il primo punto e virgola?'),
      has_code('echo', incorrect_msg='Hai usato `echo`?'),
      has_code(r'\$filetype', incorrect_msg='Hai usato `echo` su `$filetype`?'),
      has_code(r'filetype\s*;', incorrect_msg='Hai messo un punto e virgola dopo il corpo del ciclo?'),
      has_code('; done', incorrect_msg='Hai terminato con `done`?')
    )
  )
)
Ex().success_msg("Ottimo lavoro con i cicli! I cicli sono fantastici se vuoi fare la stessa cosa centinaia o migliaia di volte.")
```

---

## Come posso ripetere un comando una volta per ogni file?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Quando scrivi un ciclo puoi sempre digitare a mano i nomi dei file da elaborare,
ma di solito è meglio usare i caratteri jolly (wildcard).
Prova a eseguire questo ciclo nella console:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Stampa:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

perché la shell espande `seasonal/*.csv` in un elenco di quattro nomi di file
prima di eseguire il ciclo.

`@instructions`
Modifica l'espressione con caratteri jolly in `people/*`
così che il ciclo stampi i nomi dei file nella directory `people`
a prescindere dal suffisso che hanno o non hanno.
Usa `filename` come nome della variabile del ciclo.

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
      has_code('for', incorrect_msg='Hai usato `for`?'),
      has_code('filename', incorrect_msg='Hai usato `filename` come variabile del ciclo?'),
      has_code('in', incorrect_msg='Hai usato `in` prima dell\'elenco dei tipi di file?'),
      has_code('people/\*', incorrect_msg='Hai specificato un elenco di file con `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='Hai messo un punto e virgola dopo l\'elenco dei file?'),
      has_code(r';\s*do', incorrect_msg='Hai usato `do` dopo il primo punto e virgola?'),
      has_code('echo', incorrect_msg='Hai usato `echo`?'),
      has_code(r'\$filename', incorrect_msg='Hai usato `echo` con `$filename`?'),
      has_code(r'filename\s*;', incorrect_msg='Hai messo un punto e virgola dopo il corpo del ciclo?'),
      has_code('; done', incorrect_msg='Hai terminato con `done`?')
    )
  )
)
Ex().success_msg("Cicli a go-go! I caratteri jolly e i cicli sono una combinazione potente.")
```

---

## Come posso registrare i nomi di un insieme di file?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Spesso si assegna una variabile usando un'espressione con wildcard per memorizzare un elenco di nomi di file.
Per esempio,
se definisci `datasets` in questo modo:

```{shell}
datasets=seasonal/*.csv
```

puoi mostrare i nomi dei file più tardi usando:

```{shell}
for filename in $datasets; do echo $filename; done
```

Questo ti fa risparmiare battiture e riduce la probabilità di errori.

<hr>

Se esegui questi due comandi nella tua home directory,
quante righe di output stamperanno?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Nessuna: dato che `files` è definita su una riga separata, non ha valore nella seconda riga.
- Una: la parola "files".
- Quattro: i nomi di tutti e quattro i file di dati stagionali.

`@hint`
Ricorda che `X` da solo è solo "X", mentre `$X` è il valore della variabile `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "No: non devi definire una variabile sulla stessa riga in cui la usi."
err2 = "No: questo esempio definisce e utilizza la variabile `files` nello stesso shell."
correct3 = "Corretto. Il comando è equivalente a `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Il nome di una variabile vs il suo valore

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Un errore comune è dimenticare di usare `$` prima del nome di una variabile.
Quando succede,
la shell usa il nome che hai digitato
invece del valore di quella variabile.

Un errore ancora più comune tra gli utenti esperti è digitare male il nome della variabile.
Per esempio,
se definisci `datasets` così:

```{shell}
datasets=seasonal/*.csv
```

e poi digiti:

```{shell}
echo $datsets
```

la shell non stampa nulla,
perché `datsets` (senza la seconda "a") non è definita.

<hr>

Se eseguissi questi due comandi nella tua home directory,
quale output verrebbe stampato?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Leggi con attenzione la prima parte del ciclo prima di rispondere.)

`@hint`
Ricorda che `X` da solo è solo "X", mentre `$X` è il valore della variabile `X`.

`@possible_answers`
- [Una riga: la parola "files".]
- Quattro righe: i nomi di tutti e quattro i file di dati stagionali.
- Quattro righe vuote: alla variabile `f` non viene assegnato alcun valore.

`@feedback`
- Corretto: il ciclo usa `files` invece di `$files`, quindi l'elenco è costituito dalla parola "files".
- No: il ciclo usa `files` invece di `$files`, quindi l'elenco è costituito dalla parola "files" invece dell'espansione di `files`.
- No: la variabile `f` è definita automaticamente dal ciclo `for`.

---

## Come posso eseguire molti comandi in un unico ciclo?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Stampare i nomi dei file è utile per il debug,
ma il vero scopo dei cicli è fare operazioni su più file.
Questo ciclo stampa la seconda riga di ogni file di dati:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Ha la stessa struttura degli altri cicli che hai già visto:
la sola differenza è che il corpo è una pipeline di due comandi invece di un singolo comando.

`@instructions`
Scrivi un ciclo che stampi l’ultima voce di luglio 2017 (`2017-07`) in ogni file stagionale. Dovrebbe produrre un output simile a:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

ma per **_ogni_** file stagionale separatamente. Usa `file` come nome della variabile del ciclo e ricordati di iterare sulla lista di file `seasonal/*.csv` (_invece di 'seasonal/winter.csv' come nell'esempio_).

`@hint`
Il corpo del ciclo è il comando grep mostrato nelle istruzioni, con `seasonal/winter.csv` sostituito da `$file`.

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
  has_code('for', incorrect_msg='Hai usato `for`?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Hai usato `file` come variabile del ciclo?'),
      has_code('in', incorrect_msg='Hai usato `in` prima dell\'elenco di file?'),
      has_code('seasonal/\*', incorrect_msg='Hai specificato un elenco di file con `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Hai messo un punto e virgola dopo l\'elenco di file?'),
      has_code(r';\s*do', incorrect_msg='Hai usato `do` dopo il primo punto e virgola?'),
      has_code('grep', incorrect_msg='Hai usato `grep`?'),
      has_code('2017-07', incorrect_msg='Hai cercato `2017-07`?'),
      has_code(r'\$file', incorrect_msg='Hai usato `$file` come nome della variabile del ciclo?'),
      has_code(r'file\s*|', incorrect_msg='Hai usato una pipe per collegare il tuo secondo comando?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Hai usato `tail -n 1` per stampare l\'ultima voce di ogni ricerca nel tuo secondo comando?'),
      has_code('; done', incorrect_msg='Hai finito con `done`?')
    )
  )
)

Ex().success_msg("Cicli a go-go! I caratteri jolly e i cicli sono una combinazione potente.")
```

---

## Perché non dovrei usare spazi nei nomi dei file?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

È facile e sensato dare ai file nomi con più parole come `July 2017.csv`
quando usi un file explorer grafico.
Tuttavia,
questo crea problemi quando lavori nella shell.
Per esempio,
supponi di voler rinominare `July 2017.csv` in `2017 July data.csv`.
Non puoi digitare:

```{shell}
mv July 2017.csv 2017 July data.csv
```

perché alla shell sembrerà che tu stia cercando di spostare
quattro file chiamati `July`, `2017.csv`, `2017` e `July` (di nuovo)
in una directory chiamata `data.csv`.
Invece,
devi racchiudere tra virgolette i nomi dei file
così che la shell tratti ciascuno come un singolo parametro:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Se hai due file chiamati `current.csv` e `last year.csv`
(con uno spazio nel nome)
e digiti:

```{shell}
rm current.csv last year.csv
```

cosa succederà:

`@hint`
Cosa penseresti che stia per succedere se qualcuno ti mostrasse il comando e tu non sapessi quali file esistono?

`@possible_answers`
- La shell stamperà un messaggio di errore perché `last` e `year.csv` non esistono.
- La shell eliminerà `current.csv`.
- [Entrambe le precedenti.]
- Niente.

`@feedback`
- Sì, ma non è tutto.
- Sì, ma non è tutto.
- Corretto. Puoi usare apici singoli, `'`, o doppi apici, `"`, attorno ai nomi dei file.
- Purtroppo no.

---

## Come posso fare molte cose in un singolo ciclo?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

I cicli che hai visto finora hanno un solo comando o pipeline nel loro corpo,
ma un ciclo può contenere qualsiasi numero di comandi.
Per dire alla shell dove finisce un comando e inizia il successivo,
li devi separare con i punti e virgola:

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

Supponi di dimenticare il punto e virgola tra i comandi `echo` e `head` nel ciclo precedente,
così da chiedere alla shell di eseguire:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Cosa farà la shell?

`@possible_answers`
- Stampa un messaggio di errore.
- Stampa una riga per ciascuno dei quattro file.
- Stampa una riga per `autumn.csv` (il primo file).
- Stampa l'ultima riga di ciascun file.

`@hint`
Puoi inviare l'output di `echo` a `tail` tramite una pipe.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "No: il ciclo verrà eseguito, solo che non farà qualcosa di sensato."
correct2 = "Sì: `echo` produce una riga che include il nome del file due volte, che `tail` poi copia."
err3 = "No: il ciclo viene eseguito una volta per ognuno dei quattro nomi di file."
err4 = "No: l'input di `tail` è l'output di `echo` per ogni nome di file."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

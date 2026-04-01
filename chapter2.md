---
title: Manipolare i dati
description: >-
  I comandi che hai visto nel capitolo precedente ti permettevano di spostare
  elementi nel filesystem. In questo capitolo vedrai come lavorare con i dati
  contenuti in quei file. Gli strumenti che useremo sono piuttosto semplici, ma
  solidi mattoni di base.
lessons:
  - nb_of_exercises: 12
    title: Come posso visualizzare il contenuto di un file?
---

## Come posso visualizzare il contenuto di un file?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Prima di rinominare o eliminare file,
può esserti utile dare un'occhiata al loro contenuto.
Il modo più semplice è usare `cat`,
che stampa semplicemente il contenuto dei file sullo schermo.
(Il nome è l'abbreviazione di "concatenate", cioè "collegare le cose",
perché stampa tutti i file di cui fornisci i nomi, uno dopo l'altro.)

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
Stampa a schermo il contenuto di `course.txt`.

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
    has_expr_output(incorrect_msg="Il tuo comando non ha generato l'output corretto. Hai usato `cat` seguito dal nome del file, `course.txt`?")
)
Ex().success_msg("Ben fatto! Diamo un'occhiata ad altri modi per visualizzare il contenuto di un file.")
```

---

## Come posso visualizzare il contenuto di un file un pezzo alla volta?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Puoi usare `cat` per stampare file molto grandi e poi scorrere i risultati,
ma di solito è più comodo **sfogliare** l'output a pagine.
Il comando originale per farlo si chiamava `more`,
ma è stato superato da un comando più potente chiamato `less`.
(Questo tipo di denominazione è l'umorismo tipico del mondo Unix.)
Quando usi `less` su un file,
vedi una pagina alla volta;
puoi premere la barra spaziatrice per andare avanti o digitare `q` per uscire.

Se passi a `less` i nomi di più file,
puoi digitare `:n` (due punti e una 'n' minuscola) per andare al file successivo,
`:p` per tornare a quello precedente,
oppure `:q` per uscire.

Nota: Se guardi le soluzioni degli esercizi che usano `less`,
vedrai un comando extra alla fine che disattiva la paginazione
così possiamo testare le soluzioni in modo efficiente.

`@instructions`
Usa `less seasonal/spring.csv seasonal/summer.csv` per visualizzare quei due file in quell'ordine.
Premi la barra spaziatrice per andare avanti di pagina, `:n` per passare al secondo file e `:q` per uscire.

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
                 incorrect_msg='Usa `less` e i nomi dei file. Ricorda che `:n` ti sposta al file successivo.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Come posso vedere l'inizio di un file?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

La prima cosa che la maggior parte dei data scientist fa quando riceve un nuovo insieme di dati da analizzare è
capire quali campi contiene e quali valori hanno quei campi.
Se l'insieme di dati è stato esportato da un database o da un foglio di calcolo,
spesso sarà salvato come **valori separati da virgola** (CSV).
Un modo rapido per capire cosa contiene è guardare le prime righe.

Possiamo farlo nella shell usando un comando chiamato `head`.
Come suggerisce il nome,
stampa le prime righe di un file
(dove "alcune" significa 10),
quindi il comando:

```{shell}
head seasonal/summer.csv
```

mostra:

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

Cosa fa `head` se nel file non ci sono 10 righe?
(Per scoprirlo, usalo per guardare l'inizio di `people/agarwal.txt`.)

`@possible_answers`
- Stampa un messaggio di errore perché il file è troppo corto.
- Mostra tante righe quante ce ne sono.
- Mostra abbastanza righe vuote da arrivare a 10.

`@hint`
Qual è la cosa più utile che potrebbe fare?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Errato: non è la cosa più utile che potrebbe fare.",
                    "Corretto!",
                    "Errato: sarebbe impossibile distinguerlo da un file che termina con un sacco di righe vuote."])
```

---

## Come posso digitare meno?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Uno degli strumenti potenti della shell è il **completamento con tab**.
Se inizi a digitare il nome di un file e poi premi il tasto Tab,
la shell cercherà di completare automaticamente il percorso.
Per esempio,
se digiti `sea` e premi Tab,
riempirà il nome della directory con `seasonal/` (con lo slash finale).
Se poi digiti `a` e premi Tab,
completerà il percorso come `seasonal/autumn.csv`.

Se il percorso è ambiguo,
come `seasonal/s`,
premendo Tab una seconda volta verrà mostrato un elenco di possibilità.
Digitando un altro carattere o due per rendere il percorso più specifico
e poi premendo Tab
verrà completato il resto del nome.

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
Esegui `head seasonal/autumn.csv` senza digitare il nome del file per intero.

`@hint`
Digita quanto basta del percorso, poi premi Tab e ripeti.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Il checker non è riuscito a trovare l'output corretto nel tuo comando. Sei sicuro di aver chiamato `head` su `seasonal/autumn.csv`?")
)

```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Esegui `head seasonal/spring.csv` senza digitare il nome del file per intero.

`@hint`
Digita quanto basta del percorso, poi premi Tab e ripeti.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Il checker non è riuscito a trovare l'output corretto nel tuo comando. Sei sicuro di aver chiamato `head` su `seasonal/spring.csv`?")
)
Ex().success_msg("Ottimo lavoro! Una volta che ti abitui a usare il completamento con il tasto tab, ti farà risparmiare molto tempo!")
```

---

## Come posso controllare cosa fanno i comandi?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Non sempre vorrai vedere le prime 10 righe di un file,
quindi la shell ti permette di modificare il comportamento di `head`
passandogli un **flag da riga di comando** (o semplicemente "flag").
Se esegui il comando:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` mostrerà solo le prime tre righe del file.
Se esegui `head -n 100`,
mostrerà le prime 100 (se ce ne sono così tante),
e così via.

Il nome di un flag di solito indica il suo scopo
(per esempio, `-n` sta per "**n**umero di righe").
I flag dei comandi non devono per forza essere un `-` seguito da una singola lettera,
ma è una convenzione molto diffusa.

Nota: è considerata una buona pratica mettere tutti i flag *prima* dei nomi dei file,
quindi in questo corso
accettiamo solo risposte che seguono questa regola.

`@instructions`
Visualizza le prime 5 righe di `winter.csv` nella directory `seasonal`.

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
        has_expr_output(incorrect_msg="Sei sicuro di chiamare `head` sul file `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Sei sicuro di aver usato il flag `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Sei sicuro di aver usato il flag `-n 5`?")
)
Ex().success_msg("Ottimo! Con questa tecnica, puoi evitare che la tua shell esploda se vuoi dare un'occhiata a file di testo più grandi.")
```

---

## Come posso elencare tutto ciò che sta sotto una directory?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Per vedere tutto ciò che si trova sotto una directory,
indipendentemente da quanto sia annidato in profondità,
puoi passare a `ls` l'opzione `-R`
(che significa "ricorsivo").
Se usi `ls -R` nella tua home directory,
vedrai qualcosa del genere:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Questo mostra tutti i file e le directory al livello corrente,
poi tutto in ciascuna sotto-directory,
e così via.

`@instructions`
Per aiutarti a capire cosa è cosa,
`ls` ha un'altra opzione `-F` che stampa una `/` dopo il nome di ogni directory
e un `*` dopo il nome di ogni programma eseguibile.
Esegui `ls` con entrambe le opzioni, `-R` e `-F`, e il percorso assoluto della tua home directory
per vedere tutto ciò che contiene.
(L'ordine delle opzioni non importa, ma il nome della directory deve venire per ultimo.)

`@hint`
La tua home directory può essere indicata usando `~` oppure `.` o il suo percorso assoluto.

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
  has_expr_output(incorrect_msg='Usa `ls -R -F` oppure `ls -F -R` e il percorso `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Usa `ls -R -F` oppure `ls -F -R` e il percorso `/home/repl`.')
)
Ex().success_msg("È una panoramica piuttosto ordinata, vero?")
```

---

## Come posso ottenere aiuto per un comando?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Per scoprire cosa fanno i comandi, in passato si usava il comando `man` (abbreviazione di "manual"). Per esempio, il comando `man head` mostra queste informazioni:

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

`man` richiama automaticamente `less`, quindi potresti dover premere la barra spaziatrice per scorrere le informazioni e `:q` per uscire.

La descrizione su una riga sotto `NAME` ti dice brevemente cosa fa il comando, e il riepilogo sotto `SYNOPSIS` elenca tutte le opzioni che riconosce. Tutto ciò che è facoltativo è mostrato tra parentesi quadre `[...]`, le alternative sono separate da `|`, e gli elementi ripetibili sono indicati con `...`, quindi la pagina di manuale di `head` ti dice che puoi dare *o* un numero di righe con `-n` *oppure* un numero di byte con `-c`, e che puoi passare un qualsiasi numero di nomi di file.

Il problema del manuale Unix è che devi sapere cosa stai cercando. Se non lo sai, puoi cercare su [Stack Overflow](https://stackoverflow.com/), fare una domanda sui canali Slack di DataCamp oppure guardare le sezioni `SEE ALSO` dei comandi che già conosci.

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
Leggi la pagina di manuale del comando `tail` per scoprire cosa fa mettere un segno `+` davanti al numero usato con l'opzione `-n`. (Ricorda di premere la barra spaziatrice per andare avanti e/o digitare `q` per uscire.)

`@hint`
Ricorda: `man` è l'abbreviazione di "manual".

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Usa `man` e il nome del comando.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Usa `tail` con l'opzione `-n +7` per visualizzare tutte le righe tranne le prime sei di `seasonal/spring.csv`.

`@hint`
Usa un segno più '+' davanti al numero di righe che vuoi visualizzare.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Stai chiamando `tail` su `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Sei sicuro di aver usato il flag `-n +7`?")
)

```

---

## Come posso selezionare colonne da un file?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` e `tail` ti permettono di selezionare righe da un file di testo.
Se vuoi selezionare colonne,
puoi usare il comando `cut`.
Ha diverse opzioni (usa `man cut` per esplorarle),
ma la più comune è qualcosa del tipo:

```{shell}
cut -f 2-5,8 -d , values.csv
```

che significa
"seleziona le colonne dalla 2 alla 5 e la 8,
usando la virgola come separatore".
`cut` usa `-f` (sta per "fields") per specificare le colonne
e `-d` (sta per "delimiter") per specificare il separatore.
Devi specificare quest'ultimo perché alcuni file possono usare spazi, tabulazioni o due punti per separare le colonne.

<hr>

Quale comando selezionerà la prima colonna (che contiene le date) dal file `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Entrambe le opzioni.
- Nessuna delle due, perché `-f` deve venire prima di `-d`.

`@hint`
L'ordine dei flag non importa.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Sì, ma non è tutto', 'Sì, ma non è tutto', 'Corretto! Aggiungere uno spazio dopo il flag è una buona pratica, ma non è obbligatorio.', 'No, l\'ordine dei flag non importa'])
```

---

## Cosa non può fare cut?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` è un comando piuttosto basilare.
In particolare,
non capisce le stringhe tra virgolette.
Se, ad esempio, il tuo file è:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

allora:

```{shell}
cut -f 2 -d , everyone.csv
```

produrrà:

```
Age
Ranjit"
Rupinder"
```

invece dell'età di tutti,
perché considererà la virgola tra cognome e nome come separatore di colonna.

<hr>

Qual è l'output di `cut -d : -f 2-4` sulla riga:

```
first:second:third:
```

(Nota i due punti finali.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Nessuna delle precedenti, perché non ci sono quattro campi.

`@hint`
Fai attenzione ai due punti finali.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['No, c\'è di più.', 'No, c\'è di più.', 'Corretto! I due punti finali creano un quarto campo vuoto.', 'No, `cut` fa del suo meglio.'])
```

---

## Come posso ripetere i comandi?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Uno dei maggiori vantaggi dell'uso della shell è che
rende facile ripetere le operazioni.
Se esegui alcuni comandi,
puoi premere la freccia su per scorrere all'indietro tra quelli già usati.
Puoi anche usare le frecce sinistra e destra e il tasto cancella per modificarli.
Premere Invio eseguirà quindi il comando modificato.

Ancora meglio, `history` stampa l'elenco dei comandi eseguiti di recente.
Ognuno è preceduto da un numero progressivo per rendere facile rieseguire comandi specifici:
ti basta digitare `!55` per rieseguire il 55º comando nella tua cronologia (se ne hai così tanti).
Puoi anche rieseguire un comando digitando un punto esclamativo seguito dal nome del comando,
come `!head` o `!cut`,
che rieseguiranno l'uso più recente di quel comando.

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
Esegui `head summer.csv` nella tua home directory (dovrebbe fallire).

`@hint`
Il completamento con Tab non funziona se non c'è un nome file corrispondente.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Usa `head` e un nome di file, `summer.csv`. Non preoccuparti se fallisce. Dovrebbe.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Cambia directory in `seasonal`.

`@hint`
Ricorda che `cd` sta per "change directory".

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Se la tua directory di lavoro corrente (scoprila con `pwd`) è `/home/repl`, puoi spostarti nella cartella `seasonal` con `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Riesegui il comando `head` con `!head`.

`@hint`
Non inserire spazi tra `!` e ciò che segue.

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
                        incorrect_msg='Usa `!head` per ripetere il comando `head`.'),
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
Usa `history` per vedere cosa hai fatto.

`@hint`
Nota che `history` mostra per ultimi i comandi più recenti, così rimangono sullo schermo quando termina l'esecuzione.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Usa `history` senza flag per ottenere un elenco dei comandi precedenti.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Riesegui di nuovo `head` usando `!` seguito da un numero di comando.

`@hint`
Non inserire spazi tra `!` e ciò che segue.

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
                        incorrect_msg='Hai usato `!<un_numero>` per rieseguire l\'ultimo `head` dalla cronologia?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Ben fatto! Alla prossima!")
```

---

## Come posso selezionare le righe che contengono valori specifici?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` e `tail` selezionano le righe,
`cut` seleziona le colonne,
e `grep` seleziona le righe in base al loro contenuto.
Nella sua forma più semplice,
`grep` prende un frammento di testo seguito da uno o più nomi di file
e stampa tutte le righe in quei file che contengono quel testo.
Per esempio,
`grep bicuspid seasonal/winter.csv`
stampa le righe di `winter.csv` che contengono "bicuspid".

`grep` può anche cercare dei pattern;
esploreremo questi aspetti nel prossimo corso.
Quel che conta di più adesso sono alcune delle opzioni più comuni di `grep`:

- `-c`: stampa il conteggio delle righe corrispondenti invece delle righe stesse
- `-h`: *non* stampare i nomi dei file quando si cercano più file
- `-i`: ignora le maiuscole/minuscole (es., considera "Regression" e "regression" come corrispondenze)
- `-l`: stampa i nomi dei file che contengono corrispondenze, non le corrispondenze
- `-n`: stampa i numeri di riga per le righe corrispondenti
- `-v`: inverte la corrispondenza, cioè mostra solo le righe che *non* corrispondono

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
Stampa il contenuto di tutte le righe che contengono la parola `molar` in `seasonal/autumn.csv`
eseguendo un solo comando dalla tua home directory. Non usare alcuna opzione.

`@hint`
Usa `grep` con la parola che stai cercando e il nome del/dei file in cui cercare.

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
      has_code("grep", incorrect_msg = "Hai chiamato `grep`?"),
      has_code("molar", incorrect_msg = "Hai cercato `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Hai cercato il file `seasonal/autumn.csv`?")
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
Inverti la corrispondenza per trovare tutte le righe che *non* contengono la parola `molar` in `seasonal/spring.csv`, e mostra i loro numeri di riga.
Ricorda: è considerata una buona pratica mettere tutte le opzioni *prima* di altri valori come i nomi dei file o il termine di ricerca "molar".

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
      has_code("grep", incorrect_msg = "Hai usato `grep`?"),
      has_code("-v", incorrect_msg = "Hai invertito la corrispondenza con `-v`?"),
      has_code("-n", incorrect_msg = "Hai mostrato i numeri di riga con `-n`?"),
      has_code("molar", incorrect_msg = "Hai cercato `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Hai cercato nel file `seasonal/spring.csv`?")
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
Conta quante righe contengono la parola `incisor` in `autumn.csv` e `winter.csv` insieme.
(Anche in questo caso, esegui un solo comando dalla tua home directory.)

`@hint`
Ricorda di usare `-c` con `grep` per contare le righe.

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
      has_code("grep", incorrect_msg = "Hai usato `grep`?"),
      has_code("-c", incorrect_msg = "Hai ottenuto i conteggi con `-c`?"),
      has_code("incisor", incorrect_msg = "Hai cercato `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Hai cercato nel file `seasonal/autumn.csv`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Hai cercato nel file `seasonal/winter.csv`?")
    )
  )
)

```

---

## Perché non è sempre sicuro trattare i dati come testo?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

La sezione `SEE ALSO` della pagina di manuale di `cut` fa riferimento a un comando chiamato `paste`
che può essere usato per combinare file di dati invece di suddividerli.

<hr>

Leggi la pagina di manuale di `paste`,
poi esegui `paste` per combinare i file di dati di autumn e winter in un'unica tabella
usando la virgola come separatore.
Cosa non va nell'output dal punto di vista dell'analisi dei dati?

`@possible_answers`
- Le intestazioni di colonna sono ripetute.
- Le ultime righe hanno un numero di colonne errato.
- Alcuni dati di `winter.csv` mancano.

`@hint`
Se eseguissi `cut` sull'output di `paste` usando le virgole come separatore,
otterresti la risposta corretta?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Vero, ma non è necessariamente un errore.'
correct2 = 'Corretto: unire le righe con le colonne crea solo una colonna vuota all\'inizio, non due.'
err3 = 'No, tutti i dati invernali sono presenti.'
Ex().has_chosen(2, [err1, correct2, err3])
```

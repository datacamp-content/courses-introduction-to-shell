---
title: Gestire file e directory
description: >-
  Questo capitolo è una breve introduzione alla shell Unix. Scoprirai perché è
  ancora in uso dopo quasi 50 anni, come si confronta con gli strumenti grafici
  a cui potresti essere più abituato, come muoverti nella shell e come creare,
  modificare ed eliminare file e cartelle.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: In cosa la shell differisce da un'interfaccia desktop?
---

## Come si confronta la shell con un'interfaccia desktop?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Un sistema operativo come Windows, Linux o Mac OS è un tipo speciale di programma.
Controlla il processore del computer, il disco fisso e la connessione di rete,
ma il suo compito più importante è eseguire altri programmi.

Poiché gli esseri umani non sono digitali,
hanno bisogno di un'interfaccia per interagire con il sistema operativo.
Oggi la più comune è un file explorer grafico,
che traduce clic e doppi clic in comandi per aprire file ed eseguire programmi.
Prima che i computer avessero schermi grafici,
però,
le persone digitavano istruzioni in un programma chiamato **command-line shell**.
Ogni volta che si inserisce un comando,
la shell esegue altri programmi,
stampa il loro output in forma leggibile per le persone
e poi mostra un *prompt* per segnalare che è pronta ad accettare il comando successivo.
(Il nome viene dall'idea che sia il "guscio esterno" del computer.)

Digitare comandi invece di fare clic e trascinare può sembrare scomodo all'inizio,
ma come vedrai,
una volta che inizi a esplicitare ciò che vuoi che il computer faccia,
puoi combinare comandi esistenti per crearne di nuovi
e automatizzare operazioni ripetitive
con appena pochi tasti.

<hr>
Qual è la relazione tra il file explorer grafico che usano la maggior parte delle persone e la command-line shell?

`@hint`
Ricorda che un utente può interagire con un sistema operativo solo tramite un programma.

`@possible_answers`
- Il file explorer ti permette di visualizzare e modificare file, mentre la shell ti permette di eseguire programmi.
- Il file explorer è costruito sopra la shell.
- La shell fa parte del sistema operativo, mentre il file explorer è separato.
- [Sono entrambe interfacce per inviare comandi al sistema operativo.]

`@feedback`
- Entrambe ti permettono di visualizzare e modificare file ed eseguire programmi.
- I file explorer grafici e la shell richiamano le stesse funzioni di base del sistema operativo.
- La shell e il file explorer sono entrambi programmi che traducono i comandi dell'utente (digitati o cliccati) in chiamate al sistema operativo.
- Corretto! Entrambi prendono i comandi dell'utente (che siano digitati o cliccati) e li inviano al sistema operativo.

---

## Dove mi trovo?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

Il **filesystem** gestisce file e directory (o cartelle).
Ognuna è identificata da un **percorso assoluto**
che mostra come raggiungerla a partire dalla **directory radice** del filesystem:
`/home/repl` è la directory `repl` dentro la directory `home`,
mentre `/home/repl/course.txt` è il file `course.txt` in quella directory,
e `/` da solo è la directory radice.

Per scoprire dove ti trovi nel filesystem,
esegui il comando `pwd`
(abbreviazione di "**p**rint **w**orking **d**irectory").
Questo stampa il percorso assoluto della tua **directory di lavoro corrente**,
che è dove la shell esegue i comandi e cerca i file per impostazione predefinita.

<hr>
Esegui `pwd`.
Dove ti trovi in questo momento?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Nei sistemi Unix, in genere tutte le home directory degli utenti si trovano sotto `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Questo non è il percorso corretto."
correct = "Corretto - sei in `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Come posso distinguere file e directory?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` ti dice dove ti trovi.
Per vedere cosa c'è lì,
digita `ls` (abbreviazione di "**l**i**s**ting") e premi Invio.
Da solo,
`ls` elenca il contenuto della tua directory corrente
(quella visualizzata da `pwd`).
Se aggiungi i nomi di alcuni file,
`ls` li elenca,
e se aggiungi i nomi di directory,
ne elenca il contenuto.
Per esempio,
`ls /home/repl` mostra cosa c'è nella tua directory di partenza
(di solito chiamata **home directory**).

<hr>
Usa `ls` con un argomento appropriato per elencare i file nella directory `/home/repl/seasonal`
(che contiene informazioni sugli interventi dentistici per data, suddivise per stagione).
Quale di questi file *non* si trova in quella directory?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Se fornisci a `ls` un percorso, mostra cosa c'è in quel percorso.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Quel file è nella directory `seasonal`."
correct = "Corretto - quel file *non* è nella directory `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## In quali altri modi posso identificare file e directory?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Un percorso assoluto è come latitudine e longitudine: ha lo stesso valore ovunque tu sia. Un **percorso relativo**, invece, indica una posizione a partire da dove ti trovi: è come dire "20 chilometri a nord".

Per esempio:
- Se ti trovi nella directory `/home/repl`, il percorso **relativo** `seasonal` indica la stessa directory del percorso **assoluto** `/home/repl/seasonal`. 
- Se ti trovi nella directory `/home/repl/seasonal`, il percorso **relativo** `winter.csv` indica lo stesso file del percorso **assoluto** `/home/repl/seasonal/winter.csv`.

La shell decide se un percorso è assoluto o relativo guardando il primo carattere: se inizia con `/`, è assoluto. Se *non* inizia con `/`, è relativo.

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
Ti trovi in `/home/repl`. Usa `ls` con un **percorso relativo** per elencare il file che ha percorso assoluto `/home/repl/course.txt` (e solo quel file).

`@hint`
Spesso puoi costruire il percorso relativo a un file o a una directory sotto la tua posizione attuale
sottraendo il percorso assoluto della tua posizione corrente
dal percorso assoluto dell’elemento che vuoi raggiungere.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Non hai chiamato `ls` per generare l'elenco dei file."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Il tuo comando non ha generato l'elenco corretto dei file. Usa `ls` seguito da un percorso relativo a `/home/repl/course.txt`.")
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
Ti trovi in `/home/repl`.
Usa `ls` con un percorso **relativo**
per elencare il file `/home/repl/seasonal/summer.csv` (e solo quel file).

`@hint`
I percorsi relativi *non* iniziano con uno slash iniziale '/'.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Non hai chiamato `ls` per generare l'elenco dei file."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Il tuo comando non ha generato l'elenco corretto dei file. Usa `ls` seguito da un percorso relativo a `/home/repl/seasonal/summer.csv`.")
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
Ti trovi in `/home/repl`.
Usa `ls` con un percorso **relativo**
per elencare il contenuto della directory `/home/repl/people`.

`@hint`
I percorsi relativi non iniziano con uno slash iniziale '/'.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Non hai chiamato `ls` per generare l'elenco dei file."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Il tuo comando non ha generato l'elenco corretto dei file. Usa `ls` seguito da un percorso relativo a `/home/repl/people`.")
    )
)
Ex().success_msg("Ben fatto. Ora che sai come elencare file e directory, vediamo come puoi muoverti nel filesystem!")
```

---

## Come posso spostarmi in un'altra directory?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Così come nel file browser ti sposti facendo doppio clic sulle cartelle,
puoi muoverti nel filesystem usando il comando `cd`
(che sta per "change directory").

Se digiti `cd seasonal` e poi `pwd`,
ila shell ti dirà che ora sei in `/home/repl/seasonal`.
Se poi esegui `ls` da solo,
ti mostrerà il contenuto di `/home/repl/seasonal`,
perché è lì che ti trovi.
Se vuoi tornare alla tua home directory `/home/repl`,
puoi usare il comando `cd /home/repl`.

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
Sei in `/home/repl`/.
Spostati nella directory `/home/repl/seasonal` usando un percorso relativo.

`@hint`
Ricorda che `cd` sta per "change directory" e che i percorsi relativi non iniziano con la '/' iniziale.

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
key: e69c8eac15
xp: 35
```

`@instructions`
Usa `pwd` per verificare di essere lì.

`@hint`
Ricorda di premere "invio" o "return" dopo aver inserito il comando.

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
Usa `ls` senza specificare percorsi per vedere cosa c'è in quella directory.

`@hint`
Ricorda di premere "invio" o "return" dopo il comando.

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
      has_code('ls', incorrect_msg="Il tuo comando non ha generato l'output corretto. Hai usato `ls` senza percorsi per mostrare il contenuto della directory corrente?")
    )
)

Ex().success_msg("Ottimo! Questo riguardava la navigazione verso le sottodirectory. Che ne dici di spostarti verso l'alto? Scopriamolo!")
```

---

## Come posso salire di una directory?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

Il **genitore** di una directory è la directory al livello superiore.
Per esempio, `/home` è il genitore di `/home/repl`,
e `/home/repl` è il genitore di `/home/repl/seasonal`.
Puoi sempre fornire il percorso assoluto della tua directory genitore a comandi come `cd` e `ls`.
Più spesso,
però,
sfrutterai il fatto che il percorso speciale `..`
(due punti senza spazi) significa "la directory sopra a quella in cui mi trovo".
Se ti trovi in `/home/repl/seasonal`,
allora `cd ..` ti porta su a `/home/repl`.
Se usi di nuovo `cd ..`,
ti posiziona in `/home`.
Un altro `cd ..` ti porta nella *root directory* `/`,
che è la cima del filesystem.
(Ricorda di mettere uno spazio tra `cd` e `..`: è un comando e un percorso, non un unico comando di quattro lettere.)

Un singolo punto da solo, `.`, significa sempre "la directory corrente",
quindi `ls` da solo e `ls .` fanno la stessa cosa,
mentre `cd .` non ha effetto
(perché ti sposta nella directory in cui già ti trovi).

Un ultimo percorso speciale è `~` (il carattere tilde),
che significa "la tua directory home",
ad esempio `/home/repl`.
Indipendentemente da dove ti trovi,
`ls ~` elencherà sempre il contenuto della tua home directory,
e `cd ~` ti porterà sempre alla home.

<hr>
Se ti trovi in `/home/repl/seasonal`,
dove ti porta `cd ~/../.`?

`@hint`
Segui il percorso una directory alla volta.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (la root directory)

`@feedback`
- No, ma `~` o `..` da soli ti porterebbero lì.
- Corretto! Il percorso significa "directory home", "su di un livello", "qui".
- No, ma `.` da solo lo farebbe.
- No, l'ultima parte del percorso è `.` (che significa "qui") e non `..` (che significa "su").

---

## Come posso copiare i file?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Spesso vorrai copiare file,
spostarli in altre directory per organizzarli
o rinominarli.
Un comando per farlo è `cp`, abbreviazione di "copy".
Se `original.txt` è un file esistente,
allora:

```{shell}
cp original.txt duplicate.txt
```

crea una copia di `original.txt` chiamata `duplicate.txt`.
Se esiste già un file chiamato `duplicate.txt`,
viene sovrascritto.
Se l’ultimo parametro di `cp` è una directory esistente,
allora un comando come:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

copia *tutti* questi file in quella directory.

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
Crea una copia di `seasonal/summer.csv` nella directory `backup` (che si trova anche in `/home/repl`),
chiamando il nuovo file `summer.bck`.

`@hint`
Combina il nome della directory di destinazione e il nome del file copiato
per creare un percorso relativo per il nuovo file.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` non sembra esistere nella directory `backup`. Fornisci due percorsi a `cp`: il file esistente (`seasonal/summer.csv`) e il file di destinazione (`backup/summer.bck`)."),
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
Copia `spring.csv` e `summer.csv` dalla directory `seasonal` nella directory `backup`
*senza* cambiare la tua directory di lavoro corrente (`/home/repl`).

`@hint`
Usa `cp` con i nomi dei file che vuoi copiare
e *poi* il nome della directory in cui copiarli.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` non sembra essere stato copiato nella directory `backup`. Fornisci due nomi di file e un nome di directory a `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Assicurati di copiare i file mentre sei in `{{dir}}`! Usa `cd {{dir}}` per tornare lì."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Ottimo lavoro. Oltre a copiare, dovremmo anche essere in grado di spostare file da una directory all'altra. Scopri di più nel prossimo esercizio!")
```

---

## Come posso spostare un file?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Mentre `cp` copia un file,
`mv` lo sposta da una directory a un'altra,
proprio come se lo trascinassi in un file browser grafico.
Gestisce i parametri allo stesso modo di `cp`,
quindi il comando:

```{shell}
mv autumn.csv winter.csv ..
```

sposta i file `autumn.csv` e `winter.csv` dalla directory di lavoro corrente
su di un livello nella directory padre
(perché `..` fa sempre riferimento alla directory sopra la tua posizione attuale).

`@instructions`
Sei in `/home/repl`, che ha le sottodirectory `seasonal` e `backup`.
Usando un unico comando, sposta `spring.csv` e `summer.csv` da `seasonal` a `backup`.

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
backup_patt="Il file `%s` non è nella directory `backup`. Hai usato correttamente `mv`? Usa due nomi di file e una directory come parametri per `mv`."
seasonal_patt="Il file `%s` è ancora nella directory `seasonal`. Assicurati di spostare i file con `mv` piuttosto che copiarli con `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Ben fatto, continuiamo con questo treno di shell!")
```

---

## Come posso rinominare i file?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` può essere usato anche per rinominare i file. Se esegui:

```{shell}
mv course.txt old-course.txt
```

allora il file `course.txt` nella directory di lavoro corrente viene "spostato" nel file `old-course.txt`.
Questo è diverso da come funzionano i file browser,
ma spesso è molto comodo.

Una avvertenza:
proprio come `cp`,
`mv` sovrascrive i file esistenti.
Se,
per esempio,
hai già un file chiamato `old-course.txt`,
allora il comando mostrato sopra lo sostituirà con il contenuto di `course.txt`.

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
Entra nella directory `seasonal`.

`@hint`
Ricorda che `cd` sta per "change directory" e che i percorsi relativi non iniziano con una '/' iniziale.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
Rinomina il file `winter.csv` in `winter.csv.bck`.

`@hint`
Usa `mv` con il nome attuale del file e, nell’ordine, il nuovo nome che vuoi assegnargli.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Usa `mv` con due argomenti: il file che vuoi rinominare (`winter.csv`) e il nuovo nome per il file (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Ci aspettavamo di trovare `winter.csv.bck` nella directory." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Non ci aspettavamo più che `winter.csv` fosse nella directory." + hint)
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
Esegui `ls` per verificare che tutto abbia funzionato.

`@hint`
Ricordati di premere "invio" o "return" per eseguire il comando.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Hai usato `ls` per elencare il contenuto della tua directory di lavoro corrente?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Il tuo comando non ha generato l'elenco corretto dei file. Usa `ls` senza argomenti per elencare il contenuto della tua directory di lavoro corrente.")
    )
)
Ex().success_msg("Copiare, spostare, rinominare, hai capito tutto! Prossimo passo: eliminare i file.")
```

---

## Come posso eliminare i file?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Possiamo copiare i file e spostarli in giro;
per eliminarli,
si usa `rm`,
che sta per "remove".
Come per `cp` e `mv`,
puoi passare a `rm` i nomi di quanti file vuoi, quindi:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

rimuove sia `thesis.txt` sia `backup/thesis-2017-08.txt`

`rm` fa esattamente ciò che dice il suo nome,
e lo fa subito:
a differenza dei file browser grafici,
ila shell non ha un cestino,
quindi quando esegui il comando qui sopra,
la tua tesi sparisce per sempre.

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
Sei in `/home/repl`.
Entra nella directory `seasonal`.

`@hint`
Ricorda che `cd` sta per "change directory" e che un percorso relativo non inizia con uno '/' iniziale.

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
Elimina `autumn.csv`.

`@hint`
Ricorda che `rm` sta per "remove".

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Non ci aspettavamo che `autumn.csv` fosse ancora nella directory `seasonal`. Usa `rm` con il percorso del file che vuoi rimuovere."),
    has_code('rm', incorrect_msg = 'Usa `rm` per rimuovere il file, piuttosto che spostarlo.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Torna alla tua directory home.

`@hint`
Se usi `cd` senza alcun percorso, torni alla tua home.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Usa `cd ..` o `cd ~` per tornare alla directory home.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Elimina `seasonal/summer.csv` senza cambiare di nuovo directory.

`@hint`
Ricorda che `rm` sta per "remove".

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Non ci aspettavamo che `summer.csv` fosse ancora nella directory `seasonal`. Usa `rm` con il percorso del file che vuoi rimuovere."),
    has_code('rm', incorrect_msg = 'Usa `rm` per rimuovere il file, piuttosto che spostarlo.')
)
Ex().success_msg("Impressionante! Passiamo al prossimo!")
```

---

## Come posso creare ed eliminare directory?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` tratta le directory allo stesso modo dei file:
se ti trovi nella tua home e lanci `mv seasonal by-season`,
per esempio,
`mv` cambia il nome della directory `seasonal` in `by-season`.
Tuttavia,
`rm` funziona in modo diverso.

Se provi a usare `rm` su una directory,
ila shell stampa un messaggio di errore dicendo che non può farlo,
principalmente per evitare che tu elimini per sbaglio un'intera cartella piena di lavoro.
Al suo posto,
puoi usare un comando separato chiamato `rmdir`.
Per maggiore sicurezza,
funziona solo quando la directory è vuota,
quindi devi eliminare i file in una directory *prima* di eliminare la directory stessa.
(Gli utenti esperti possono usare l'opzione `-r` di `rm` per ottenere lo stesso effetto;
parleremo delle opzioni dei comandi nel prossimo capitolo.)

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
Senza cambiare directory,
elimina il file `agarwal.txt` nella directory `people`.

`@hint`
Ricorda che `rm` sta per "remove" e che un percorso relativo non inizia con uno '/' iniziale.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` non dovrebbe più essere in `/home/repl/people`. Hai usato `rm` correttamente?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'Ci sono ancora file nella directory `people`. Se hai semplicemente spostato `agarwal.txt`, o creato nuovi file, eliminali tutti.')
)

```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Ora che la directory `people` è vuota,
usa un unico comando per eliminarla.

`@hint`
Ricorda che `rm` funziona solo sui file.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "La directory 'people' non dovrebbe più essere nella tua home directory. Usa `rmdir` per rimuoverla!")
)

```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Poiché una directory non è un file,
devi usare il comando `mkdir directory_name`
per creare una nuova directory (vuota).
Usa questo comando per creare una nuova directory chiamata `yearly` sotto la tua home.

`@hint`
Esegui `mkdir` con il nome della directory che vuoi creare.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Non c'è la directory `yearly` nella tua home directory. Usa `mkdir yearly` per crearne una!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Ora che `yearly` esiste,
crea un'altra directory chiamata `2017` al suo interno
*senza* lasciare la tua home.

`@hint`
Usa un percorso relativo per la sotto-directory che vuoi creare.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Non riesco a trovare una directory '2017' in '/home/repl/yearly'. Puoi creare questa directory usando il percorso relativo `yearly/2017`.")
)
Ex().success_msg("Forte! Concludiamo questo capitolo con un esercizio che ripete alcuni dei suoi concetti!")
```

---

## Per concludere

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Quando analizzi i dati, spesso crei file intermedi.
Invece di salvarli nella tua home directory,
puoi metterli in `/tmp`,
che è il posto dove persone e programmi tengono i file che servono solo per poco tempo.
(Nota che `/tmp` si trova direttamente sotto la directory radice `/`,
*non* sotto la tua home directory.)
Questo esercizio di chiusura ti mostrerà come fare.

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
Usa `cd` per entrare in `/tmp`.

`@hint`
Ricorda che `cd` sta per "change directory" e che un percorso assoluto inizia con '/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Sei nella directory sbagliata. Usa `cd` per cambiare directory a `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Elenca il contenuto di `/tmp` *senza* digitare il nome di una directory.

`@hint`
Se non dici a `ls` cosa elencare, ti mostra il contenuto della directory corrente.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Non hai chiamato `ls` per generare l'elenco dei file."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Il tuo comando non ha generato l'elenco corretto dei file. Usa `ls` senza`.")
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
Crea una nuova directory dentro `/tmp` chiamata `scratch`.

`@hint`
Usa `mkdir` per creare directory.

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
      has_code('mkdir +scratch', incorrect_msg="Non riesco a trovare una directory 'scratch' sotto '/tmp'. Assicurati di usare `mkdir` correttamente.")
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
Sposta `/home/repl/people/agarwal.txt` in `/tmp/scratch`.
Ti suggeriamo di usare la scorciatoia `~` per la tua home directory e un percorso relativo per la seconda invece del percorso assoluto.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Non riesco a trovare 'agarwal.txt' in '/tmp/scratch'. Usa `mv` con `~/people/agarwal.txt` come primo parametro e `scratch` come secondo.")
)
Ex().success_msg("Questo conclude il Capitolo 1 di Introduzione alla Shell! Corri al prossimo capitolo per saperne di più sulla manipolazione dei dati!")
```

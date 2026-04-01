---
title: Creare nuovi strumenti
description: >-
  La cronologia ti permette di ripetere operazioni con poche battute, e le pipe
  ti consentono di combinare comandi esistenti per crearne di nuovi. In questo
  capitolo farai un passo oltre e vedrai come creare comandi tutti tuoi.
lessons:
  - nb_of_exercises: 9
    title: Come posso modificare un file?
---

## Come posso modificare un file?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix offre un'incredibile varietà di editor di testo.
In questo corso useremo un editor semplice chiamato Nano.
Se digiti `nano filename`,
aprirà `filename` per la modifica
(o lo creerà se non esiste già).
Puoi muoverti con i tasti freccia,
cancellare i caratteri con backspace
e fare altre operazioni con combinazioni di tasti Ctrl:

- `Ctrl` + `K`: elimina una riga.
- `Ctrl` + `U`: ripristina l'ultima riga eliminata.
- `Ctrl` + `O`: salva il file ("O" sta per "output"). _Dovrai anche premere Invio per confermare il nome del file!_
- `Ctrl` + `X`: esci dall'editor.

`@instructions`
Esegui `nano names.txt` per modificare un nuovo file nella tua home directory
e inserisci le quattro righe seguenti:

```
Lovelace
Hopper
Johnson
Wilson
```

Per salvare quello che hai scritto,
digita `Ctrl` + `O` per scrivere il file su disco,
poi Invio per confermare il nome del file,
quindi `Ctrl` + `X` per uscire dall'editor.

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
patt = "Hai incluso la riga `%s` nel file `names.txt`? Usa di nuovo `nano names.txt` per aggiornare il tuo file. Usa `Ctrl` + `O` per salvare e `Ctrl` + `X` per uscire."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("Ben fatto! Passiamo al prossimo!")
```

---

## Come posso registrare ciò che ho appena fatto?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Quando svolgi un'analisi complessa,
vorrai spesso tenere traccia dei comandi che hai usato.
Puoi farlo con gli strumenti che hai già visto:

1. Esegui `history`.
2. Collega il suo output a `tail -n 10` (o al numero di passaggi recenti che vuoi salvare).
3. Reindirizza il tutto in un file chiamato, per esempio, `figure-5.history`.

Questo è meglio che annotare tutto su un quaderno di laboratorio
perché ti garantisce di non saltare nessun passaggio.
Inoltre illustra l'idea centrale della shell:
strumenti semplici che producono e consumano righe di testo
possono essere combinati in molti modi diversi
per risolvere un'ampia gamma di problemi.

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
Copia i file `seasonal/spring.csv` e `seasonal/summer.csv` nella tua home directory.

`@hint`
Usa `cp` per copiare e `~` come scorciatoia per il percorso della tua home directory.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="Hai usato `cp seasonal/s* ~` per copiare i file richiesti nella tua directory home?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("Notevole tenuta dei registri! Se hai digitato male qualche comando, puoi sempre usare `nano` per ripulire il file della cronologia dei salvataggi in seguito.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Usa `grep` con il flag `-h` (per evitare che stampi i nomi dei file)
e `-v Tooth` (per selezionare le righe che NON corrispondono all'intestazione)
per selezionare i record dei dati da `spring.csv` e `summer.csv` in quest'ordine
e reindirizza l'output in `temp.csv`.

`@hint`
Metti i flag prima dei nomi dei file.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "Assicurati di reindirizzare l'output del comando `grep` a `temp.csv` con `>`!"
msg2 = "Hai usato `grep -h -v ___ ___ ___` (riempi gli spazi vuoti) per popolare `temp.csv`?"
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
Collega `history` a `tail -n 3`
e reindirizza l'output in `steps.txt`
per salvare gli ultimi tre comandi in un file.
(Devi salvarne tre invece di due soli
perché il comando `history` sarà presente nell'elenco.)

`@hint`
Ricorda che il reindirizzamento con `>` va alla fine della sequenza di comandi collegati con pipe.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Assicurati di reindirizzare l'output del tuo comando a `steps.txt`."
msg2="Hai usato `history | tail ___ ___` (riempi gli spazi vuoti) per popolare `steps.txt`?"
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
Ex().success_msg("Ben fatto! Facciamo un passo avanti!")
```

---

## Come posso salvare i comandi per rieseguirli più tardi?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Finora hai usato la shell in modo interattivo.
Ma dato che i comandi che digiti sono solo testo,
puoi salvarli in file che la shell può eseguire più e più volte.
Per iniziare a esplorare questa potente funzionalità,
metti il seguente comando in un file chiamato `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Questo comando seleziona la prima riga da ciascuno dei file CSV nella directory `seasonal`.
Dopo aver creato questo file,
puoi eseguirlo digitando:

```{shell}
bash headers.sh
```

Questo dice alla shell (che è semplicemente un programma chiamato `bash`)
di eseguire i comandi contenuti nel file `headers.sh`,
producendo lo stesso output che otterresti eseguendo i comandi direttamente.

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
Usa `nano dates.sh` per creare un file chiamato `dates.sh`
che contenga questo comando:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

per estrarre la prima colonna da tutti i file CSV in `seasonal`.

`@hint`
Inserisci i comandi mostrati nel file senza righe vuote o spazi aggiuntivi.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "Hai incluso la riga `cut -d , -f 1 seasonal/*.csv` nel file `dates.sh`? Usa di nuovo `nano dates.sh` per aggiornare il tuo file. Usa `Ctrl` + `O` per salvare e `Ctrl` + `X` per uscire."
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
Usa `bash` per eseguire il file `dates.sh`.

`@hint`
Usa `bash filename` per eseguire il file.

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
      has_code("bash", incorrect_msg = 'Hai chiamato `bash`?'),
      has_code("dates.sh", incorrect_msg = 'Hai specificato il file `dates.sh`?')
    )
  )
)

```

---

## Come posso riutilizzare le pipe?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Un file pieno di comandi della shell si chiama ***script della shell**,
o a volte semplicemente "script". Gli script non devono necessariamente avere nomi che finiscono in `.sh`,
ma in questa lezione useremo quella convenzione
per aiutarti a tenere traccia di quali file sono script.

Gli script possono anche contenere pipe.
Per esempio,
se `all-dates.sh` contiene questa riga:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

allora:

```{shell}
bash all-dates.sh > dates.out
```

estrarrà le date univoche dai file di dati stagionali
e le salverà in `dates.out`.

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
Nel tuo home directory è stato preparato un file `teeth.sh`, ma contiene alcuni spazi vuoti.
Usa Nano per modificare il file e sostituire i due segnaposto `____`
con `seasonal/*.csv` e `-c` in modo che questo script stampi il conteggio del
numero di volte in cui ogni nome di dente compare nei file CSV nella directory `seasonal`.

`@hint`
Usa `nano teeth.sh` per modificare il file.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="Hai sostituito correttamente gli spazi vuoti in modo che il comando in `teeth.sh` sia `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Usa di nuovo `nano teeth.sh` per apportare le modifiche necessarie."
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
Usa `bash` per eseguire `teeth.sh` e `>` per reindirizzare il suo output a `teeth.out`.

`@hint`
Ricorda che `> teeth.out` deve venire *dopo* il comando che produce l'output.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="Hai correttamente reindirizzato il risultato di `bash teeth.sh` a `teeth.out` con il `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = 'Hai chiamato `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = 'Hai eseguito il file `teeth.sh`?'),
      has_code(">\s+teeth.out", incorrect_msg = 'Hai reindirizzato al file `teeth.out`?')
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
Esegui `cat teeth.out` per ispezionare i risultati.

`@hint`
Ricorda: puoi digitare i primi caratteri di un nome file e poi premere il tasto tab per il completamento automatico.

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
      has_code("cat", incorrect_msg = 'Hai usato `cat`?'),
      has_code("teeth.out", incorrect_msg = 'Hai specificato il file `teeth.out`?')
    )
  )
)
Ex().success_msg("Ottimo! All'inizio tutto questo può sembrare artificioso, ma la cosa bella è che stai automatizzando parti del tuo flusso di lavoro passo dopo passo. Qualcosa che torna davvero utile come data scientist!")
```

---

## Come posso passare i nomi dei file agli script?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Uno script che elabora file specifici è utile come traccia di ciò che hai fatto, ma uno che ti permette di elaborare qualsiasi file desideri è ancora più utile.
Per supportare questo,
puoi usare l'espressione speciale `$@` (segno del dollaro immediatamente seguito dalla chiocciola)
per indicare "tutti i parametri da riga di comando passati allo script".

Per esempio, se `unique-lines.sh` contiene `sort $@ | uniq`, quando esegui:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

la shell sostituisce `$@` con `seasonal/summer.csv` ed elabora un file. Se esegui questo:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

elabora due file di dati, e così via.

_Promemoria: per salvare ciò che hai scritto in Nano, digita `Ctrl` + `O` per scrivere il file su disco, poi Invio per confermare il nome del file, quindi `Ctrl` + `X` per uscire dall'editor._

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
Modifica lo script `count-records.sh` con Nano e compila i due segnaposto `____`
con `$@` e `-l` (la _lettera_) rispettivamente, in modo che conti il numero di righe in uno o più file,
escludendo la prima riga di ciascuno.

`@hint`
* Usa `nano count-records.sh` per modificare il nome del file.
* Assicurati di specificare la _lettera_ `-l`, e non il numero uno.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="Hai sostituito correttamente gli spazi vuoti in modo che il comando in `count-records.sh` sia `tail -q -n +2 $@ | wc -l`? Usa di nuovo `nano count-records.sh` per apportare le modifiche necessarie."
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
Esegui `count-records.sh` su `seasonal/*.csv`
e reindirizza l'output a `num-records.out` usando `>`.

`@hint`
Usa `>` per reindirizzare l'output.

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
      has_code("bash", incorrect_msg = 'Hai chiamato `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = 'Hai eseguito il file `count-records.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Hai specificato i file da elaborare con `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = 'Hai reindirizzato al file `num-records.out`?')
    )
  )
)
Ex().success_msg("Ottimo lavoro! Il tuo potere con la shell è in continua espansione!")
```

---

## Come posso elaborare un singolo argomento?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Oltre a `$@`,
ila shell ti permette di usare `$1`, `$2` e così via per riferirti a specifici parametri della riga di comando.
Puoi sfruttarlo per scrivere comandi che risultano più semplici o naturali rispetto a quelli della shell.
Per esempio,
puoi creare uno script chiamato `column.sh` che seleziona una singola colonna da un file CSV
quando l’utente fornisce il nome del file come primo parametro e la colonna come secondo:

```{shell}
cut -d , -f $2 $1
```

per poi eseguirlo con:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Nota come lo script usi i due parametri in ordine inverso.

<hr>

Lo script `get-field.sh` dovrebbe ricevere un nome di file,
il numero della riga da selezionare,
il numero della colonna da selezionare,
e stampare solo quel campo da un file CSV.
Per esempio:

```
bash get-field.sh seasonal/summer.csv 4 2
```

dovrebbe selezionare il secondo campo dalla riga 4 di `seasonal/summer.csv`.
Quale dei seguenti comandi dovrebbe essere inserito in `get-field.sh` per farlo?

`@hint`
Ricorda che i parametri da riga di comando sono numerati da sinistra a destra.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- No: in questo modo proveresti a usare il nome del file come numero di righe da selezionare con `head`.
- Corretto!
- No: così proveresti a usare il numero di colonna come numero di riga e viceversa.
- No: così useresti il numero di campo come nome del file e viceversa.

---

## Come può uno script shell fare molte cose?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Finora i nostri script shell hanno avuto un solo comando o una pipe, ma uno script può contenere molte righe di comandi. Per esempio, puoi crearne uno che ti dica quanti record ci sono nel più corto e nel più lungo dei tuoi file di dati, cioè l’intervallo delle lunghezze dei tuoi dataset.

Nota che in Nano, per "copia e incolla" si va alla riga che vuoi copiare, si preme `CTRL` + `K` per tagliare la riga, poi `CTRL` + `U` due volte per incollarne due copie.

_Promemoria: per salvare ciò che hai scritto in Nano, digita `Ctrl` + `O` per scrivere il file su disco, poi Invio per confermare il nome del file, quindi `Ctrl` + `X` per uscire dall’editor._

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
Usa Nano per modificare lo script `range.sh`
e sostituisci i due segnaposto `____`
con `$@` e `-v`
in modo che elenchi i nomi e il numero di righe di tutti i file passati sulla riga di comando
*senza* mostrare il numero totale di righe di tutti i file.
(Non provare a sottrarre le righe di intestazione di colonna dai file.)

`@hint`
Usa `wc -l $@` per contare le righe in tutti i file passati sulla riga di comando.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="Hai sostituito correttamente gli spazi vuoti in modo che il comando in `range.sh` legga `wc -l $@ | grep -v total`? Usa di nuovo `nano range.sh` per apportare le modifiche necessarie."
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
Usa di nuovo Nano per aggiungere `sort -n` e `head -n 1` in quest’ordine
alla pipeline in `range.sh`
per visualizzare il nome e il conteggio righe del file più corto che gli viene passato.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="Hai aggiunto `sort -n` e `head -n 1` con le pipe al file `range.sh`? Usa di nuovo `nano range.sh` per fare le modifiche richieste."
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
Sempre con Nano, aggiungi una seconda riga a `range.sh` per stampare il nome e il numero di record del
file *più lungo* nella directory *oltre* a quello più corto.
Questa riga dovrebbe essere un duplicato di quella che hai già scritto,
ma con `sort -n -r` invece di `sort -n`.

`@hint`
Copia la prima riga e modifica l’ordinamento.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Mantieni la prima riga nel file `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="Hai duplicato la prima riga in `range.sh` e fatto una piccola modifica? `sort -n -r` invece di `sort -n`!"
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
Esegui lo script sui file nella directory `seasonal`
usando `seasonal/*.csv` per abbinare tutti i file
e reindirizza l’output usando `>`
in un file chiamato `range.out` nella tua home directory.

`@hint`
Usa `bash range.sh` per eseguire lo script, `seasonal/*.csv` per specificare i file e `> range.out` per reindirizzare l’output.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="Hai correttamente reindirizzato il risultato di `bash range.sh seasonal/*.csv` a `range.out` con il `>`?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = 'Hai chiamato `bash`?'),
has_code("bash\s+range.sh", incorrect_msg = 'Hai eseguito il file `range.sh`?'),
has_code("seasonal/\*", incorrect_msg = 'Hai specificato i file da elaborare con `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = 'Hai reindirizzato al file `range.out`?')
)
)

Ex().success_msg("Sta andando bene. Vai al prossimo esercizio per imparare a scrivere i loop!")
```

---

## Come posso scrivere dei loop in uno script di shell?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Gli script di shell possono contenere anche dei loop. Puoi scriverli usando i punti e virgola, oppure spezzarli su più righe senza punti e virgola per renderli più leggibili:

```{shell}
# Stampa il primo e l'ultimo record di dati di ogni file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(Non è obbligatorio rientrare i comandi dentro il loop, ma farlo rende tutto più chiaro.)

La prima riga di questo script è un **commento** che spiega a chi legge cosa fa lo script. I commenti iniziano con il carattere `#` e arrivano fino a fine riga. Il te stesso del futuro ti ringrazierà per aver aggiunto brevi spiegazioni come questa a ogni script che scrivi.

_Promemoria: per salvare quello che hai scritto in Nano, premi `Ctrl` + `O` per scrivere il file, poi Invio per confermare il nome del file, quindi `Ctrl` + `X` per uscire dall'editor._

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
Compila i segnaposto nello script `date-range.sh`
con `$filename` (due volte), `head` e `tail`
in modo che stampi la prima e l'ultima data da uno o più file.

`@hint`
Ricorda di usare `$filename` per ottenere il valore corrente della variabile del loop.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="In `date-range.sh`, hai cambiato la riga %s nel ciclo in `%s`? Usa `nano date-range.sh` per fare le modifiche."
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
Esegui `date-range.sh` su tutti e quattro i file di dati stagionali
usando `seasonal/*.csv` per corrispondere ai loro nomi.

`@hint`
L'espressione con il wildcard dovrebbe iniziare con il nome della directory.

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
      has_code("bash", incorrect_msg = 'Hai chiamato `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Hai eseguito il file `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Hai specificato i file da elaborare con `seasonal/*`?')
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
Esegui `date-range.sh` su tutti e quattro i file di dati stagionali usando `seasonal/*.csv` per corrispondere ai loro nomi,
e inoltra il suo output a `sort` per vedere che i tuoi script possono essere usati proprio come i comandi integrati di Unix.

`@hint`
Usa la stessa espressione con wildcard che hai usato prima.

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
      has_code("bash", incorrect_msg = 'Hai chiamato `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = 'Hai eseguito il file `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = 'Hai specificato i file da elaborare con `seasonal/*`?'),
      has_code("|", incorrect_msg = 'Hai usato la pipe dall\'output dello script a `sort`?'),
      has_code("sort", incorrect_msg = 'Hai chiamato `sort`?')
    )
  )
)
Ex().success_msg("Magico! Nota quanto siano componibili tutte le cose che abbiamo imparato.")
```

---

## Cosa succede se non fornisco nomi di file?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Un errore comune negli script della shell (e nei comandi interattivi) è mettere i nomi dei file nel posto sbagliato.
Se digiti:

```{shell}
tail -n 3
```

dato che `tail` non ha ricevuto alcun nome di file,
aspetta di leggere l'input dalla tastiera.
Questo significa che se digiti:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

allora `tail` stampa tranquillamente le ultime tre righe di `somefile.txt`,
ma `head` resta in attesa indefinitamente di input dalla tastiera,
perché non ha ricevuto un nome di file e non c'è nulla prima di lui nella pipeline.

<hr>

Supponi di digitare per errore:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

Cosa dovresti fare dopo?

`@possible_answers`
- Aspettare 10 secondi che `head` vada in timeout.
- Digitare `somefile.txt` e premere Invio per fornire a `head` un input.
- Usare `Ctrl` + `C` per interrompere il programma `head` in esecuzione.

`@hint`
Cosa fa `head` se non ha un nome file e non c'è nulla a monte nella pipeline?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'No, i comandi non andranno in timeout.'
a2 = 'No, questo darà a `head` il testo `somefile.txt` da elaborare, ma poi si bloccherà in attesa di ulteriori input.'
a3 = "Sì! Dovresti usare `Ctrl` + `C` per fermare un programma in esecuzione. Questo conclude questo corso introduttivo! Se sei interessato a imparare più strumenti da riga di comando, ti consigliamo vivamente di seguire il nostro corso introduttivo gratuito su Git!"
Ex().has_chosen(3, [a1, a2, a3])
```

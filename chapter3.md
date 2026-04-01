---
title: Combinare gli strumenti
description: >-
  La vera potenza della shell Unix non sta nei singoli comandi, ma nella
  facilità con cui possono essere combinati per fare cose nuove. In questo
  capitolo vedrai come sfruttare questa potenza per selezionare i dati che ti
  interessano e conoscerai comandi per ordinare i valori e rimuovere i
  duplicati.
lessons:
  - nb_of_exercises: 12
    title: Come posso salvare l'output di un comando in un file?
---

## Come posso salvare l'output di un comando in un file?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Tutti gli strumenti che hai visto finora ti permettono di indicare i file di input.
La maggior parte non ha un'opzione per nominare un file di output perché non ne ha bisogno.
Al suo posto,
puoi usare la **redirezione** per salvare l'output di qualsiasi comando dove vuoi.
Se esegui questo comando:

```{shell}
head -n 5 seasonal/summer.csv
```

stampa a schermo le prime 5 righe dei dati estivi.
Se invece esegui questo comando:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

non appare nulla sullo schermo.
Al contrario,
l'output di `head` viene messo in un nuovo file chiamato `top.csv`.
Puoi dare un'occhiata al contenuto di quel file usando `cat`:

```{shell}
cat top.csv
```

Il simbolo di maggiore `>` dice alla shell di redirezionare l'output di `head` in un file.
Non fa parte del comando `head`;
piuttosto,
funziona con qualsiasi comando della shell che produca output.

`@instructions`
Combina `tail` con la redirezione per salvare le ultime 5 righe di `seasonal/winter.csv` in un file chiamato `last.csv`.

`@hint`
Usa `tail -n 5` per ottenere le ultime 5 righe.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "La riga `%s` dovrebbe essere nel file `last.csv`, ma non c'è. Reindirizza l'output di `tail -n 5 seasonal/winter.csv` a `last.csv` con `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` ha troppe righe. Hai usato il flag `-n 5` con `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Ottimo! Facciamo un po' più di pratica!")
```

---

## Come posso usare l'output di un comando come input?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Supponi di voler estrarre delle righe dal centro di un file.
Più nello specifico,
supponi di voler ottenere le righe 3-5 da uno dei nostri file di dati.
Puoi iniziare usando `head` per prendere le prime 5 righe,
reindirizzarle a un file,
e poi usare `tail` per selezionare le ultime 3:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Un rapido controllo conferma che queste sono le righe 3-5 del file originale,
perché sono le ultime 3 righe delle prime 5.

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
Seleziona le ultime due righe da `seasonal/winter.csv`
e salvale in un file chiamato `bottom.csv`.

`@hint`
Usa `tail` per selezionare le righe e `>` per reindirizzare l'output di `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="La riga `%s` dovrebbe essere nel file `bottom.csv`, ma non lo è. Reindirizza l'output di `tail -n 2 seasonal/winter.csv` a `bottom.csv` con `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` ha troppe righe. Hai usato il flag `-n 2` con `tail`?'),
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
Seleziona la prima riga da `bottom.csv`
per ottenere la penultima riga del file originale.

`@hint`
Usa `head` per selezionare la riga che ti interessa.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="C'è qualcosa che non va nel file `bottom.csv`. Assicurati di non cambiarlo!"),
    has_expr_output(strict=True, incorrect_msg="Hai usato correttamente `head` su `bottom.csv`? Assicurati di usare correttamente il flag `-n`.")
)

Ex().success_msg("Ben fatto. Vai al prossimo esercizio per scoprire modi migliori per combinare i comandi.")                             

```

---

## Qual è un modo migliore per combinare i comandi?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Usare la redirezione per combinare i comandi ha due svantaggi:

1. Lascia in giro molti file intermedi (come `top.csv`).
2. I comandi per ottenere il risultato finale sono sparsi su diverse righe della cronologia.

La shell offre un altro strumento che risolve entrambi i problemi in una volta sola, chiamato **pipe**.
Ancora una volta,
inizia eseguendo `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

Invece di inviare l'output di `head` a un file,
aggiungi una barra verticale e il comando `tail` *senza* un nome file:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Il simbolo della pipe dice alla shell di usare l'output del comando a sinistra
come input per il comando a destra.

`@instructions`
Usa `cut` per selezionare tutti i nomi dei denti dalla colonna 2 del file delimitato da virgole `seasonal/summer.csv`, poi passa il risultato a `grep`, con una corrispondenza invertita, per escludere la riga di intestazione che contiene la parola "Tooth". *`cut` e `grep` sono stati trattati in dettaglio nel Capitolo 2, esercizi 8 e 11 rispettivamente.*

`@hint`
- La prima parte del comando ha la forma `cut -d field_delimiter -f column_number filename`.
- La seconda parte del comando ha la forma `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = 'Hai passato il risultato di `cut -d , -f 2 seasonal/summer.csv` in `grep -v Tooth` con `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Hai escluso la riga dell\'intestazione `"Tooth"` usando `grep`?')
)
Ex().success_msg("Piping perfetto! Questa potrebbe essere la prima volta che usi `|`, ma sicuramente non sarà l'ultima!")
```

---

## Come posso combinare molti comandi?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Puoi concatenare insieme qualsiasi numero di comandi.
Per esempio,
questo comando:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

fa quanto segue:

1. seleziona la prima colonna dai dati di spring;
2. rimuove la riga di intestazione che contiene la parola "Date"; e
3. seleziona le prime 10 righe di dati effettivi.

`@instructions`
Nell'esercizio precedente, hai usato il seguente comando per selezionare tutti i nomi dei denti dalla colonna 2 di `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Estendi questa pipeline con un comando `head` per selezionare solo il primissimo nome del dente.

`@hint`
Copia e incolla il codice nelle istruzioni, aggiungi una pipe e poi chiama `head` con l'opzione `-n`.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Hai usato `|` per estendere la pipeline con un comando `head`? Assicurati di impostare correttamente il flag `-n`."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Hai usato `|` per estendere la pipeline con un comando `head`?")
)
Ex().success_msg("Collegamento allegro! Collegando insieme diversi comandi, puoi costruire potenti pipeline di manipolazione dei dati.")
```

---

## Come posso contare i record in un file?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

Il comando `wc` (abbreviazione di "word count") stampa il numero di **c**aratteri, **p**arole e **r**ighe in un file.
Puoi fargli stampare solo uno di questi usando rispettivamente `-c`, `-w` o `-l`.

`@instructions`
Conta quanti record in `seasonal/spring.csv` hanno date a luglio 2017 (`2017-07`). 
- Per farlo, usa `grep` con una data parziale per selezionare le righe e manda questo risultato in pipe a `wc` con l'opzione appropriata per contare le righe.

`@hint`
- Usa `head seasonal/spring.csv` per ricordarti il formato delle date.
- La prima parte del comando ha la forma `grep cosa_da_cercare nomefile`.
- Dopo la pipe, `|`, richiama `wc` con l'opzione `-l`.

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
      has_code("grep", incorrect_msg = "Hai usato `grep`?"),
      has_code("2017-07", incorrect_msg = "Hai cercato `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Hai cercato nel file `seasonal/spring.csv`?"),
      has_code("|", incorrect_msg = "Hai usato la pipe verso `wc` usando `|`?"),      
      has_code("wc", incorrect_msg = "Hai usato `wc`?"),
      has_code("-l", incorrect_msg = "Hai contato le righe con `-l`?")
    )
  )
)
Ex().success_msg("Conto accurato! Determinare quanta dati hai è un ottimo primo passo in qualsiasi analisi dei dati.")
```

---

## Come posso specificare molti file in una volta sola?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

La maggior parte dei comandi della shell funziona su più file se fornisci più nomi di file.
Per esempio,
puoi ottenere la prima colonna da tutti i file di dati stagionali in una volta sola così:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Ma digitare i nomi di molti file più e più volte non è una buona idea:
fa perdere tempo
e prima o poi dimenticherai un file o ripeterai un nome.
Per semplificarti la vita,
la shell ti permette di usare i **caratteri jolly** per indicare un elenco di file con una singola espressione.
Il carattere jolly più comune è `*`,
che significa "corrisponde a zero o più caratteri".
Usandolo,
possiamo accorciare il comando `cut` qui sopra così:

```{shell}
cut -d , -f 1 seasonal/*
```

o così:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Scrivi un unico comando usando `head` per ottenere le prime tre righe sia da `seasonal/spring.csv` sia da `seasonal/summer.csv`, per un totale di sei righe di dati, ma non dai file di dati di autumn o winter.
Usa un carattere jolly invece di scrivere per intero i nomi dei file.

`@hint`
- Il comando ha la forma `head -n number_of_lines filename_pattern`.
- Per esempio, puoi selezionare i file nella directory `a` che iniziano con `b` usando `a/b*`.

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
    has_expr_output(incorrect_msg = "Puoi usare `seasonal/s*` per selezionare `seasonal/spring.csv` e `seasonal/summer.csv`. Assicurati di includere solo le prime tre righe di ciascun file con il flag `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "Non includere l'output per `seasonal/autumn.csv`. Puoi usare `seasonal/s*` per selezionare `seasonal/spring.csv` e `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "Non includere l'output per `seasonal/winter.csv`. Puoi usare `seasonal/s*` per selezionare `seasonal/spring.csv` e `seasonal/summer.csv`")
)
Ex().success_msg("Ottimo lavoro con i caratteri jolly! Questo diventa ancora più importante se la tua directory contiene centinaia o migliaia di file.")
```

---

## Quali altri caratteri jolly posso usare?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

La shell ha anche altri caratteri jolly,
anche se sono meno usati:

- `?` corrisponde a un singolo carattere, quindi `201?.txt` farà corrispondere `2017.txt` o `2018.txt`, ma non `2017-01.txt`.
- `[...]` fa corrispondere uno qualsiasi dei caratteri tra parentesi quadre, quindi `201[78].txt` corrisponde a `2017.txt` o `2018.txt`, ma non a `2016.txt`.
- `{...}` fa corrispondere uno qualsiasi dei pattern separati da virgola tra parentesi graffe, quindi `{*.txt, *.csv}` corrisponde a qualsiasi file il cui nome termina con `.txt` o `.csv`, ma non ai file i cui nomi terminano con `.pdf`.

<hr/>

Quale espressione farebbe corrispondere `singh.pdf` e `johel.txt` ma *non* `sandhu.pdf` o `sandhu.txt`?

`@hint`
Confronta ogni espressione con ciascun nome di file, uno alla volta.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- No: `.pdf` e `.txt` non sono nomi di file.
- No: questo corrisponderà a `sandhu.pdf`.
- No: l'espressione tra parentesi quadre fa corrispondere un solo carattere, non intere parole.
- Corretto!

---

## Come posso ordinare righe di testo?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Come suggerisce il nome,
`sort` mette i dati in ordine.
Per impostazione predefinita lo fa in ordine alfabetico crescente,
ma i flag `-n` e `-r` possono essere usati per ordinare numericamente e invertire l'ordine dell'output,
mentre `-b` gli dice di ignorare gli spazi iniziali
e `-f` gli dice di **f**ondere il maiuscolo/minuscolo (cioè, essere case-insensitive).
Le pipeline spesso usano `grep` per eliminare i record indesiderati
e poi `sort` per mettere in ordine quelli rimanenti.

`@instructions`
Ricordi la combinazione di `cut` e `grep` per selezionare tutti i nomi dei denti dalla colonna 2 di `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Partendo da questa ricetta, ordina i nomi dei denti in `seasonal/winter.csv` (non `summer.csv`) in ordine alfabetico decrescente. Per farlo, estendi la pipeline con uno step `sort`.

`@hint`
Copia e incolla il comando nelle istruzioni, cambia il nome del file, aggiungi una pipe, poi richiama `sort` con il flag `-r`.

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
      has_code("cut", incorrect_msg = "Hai chiamato `cut`?"),
      has_code("-d", incorrect_msg = "Hai specificato un delimitatore di campo con `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Hai ottenuto i dati dal file `seasonal/winter.csv`?"),
      has_code("|", incorrect_msg = "Hai usato la pipe da `cut` a `grep` a `sort` usando `|`?"),      
      has_code("grep", incorrect_msg = "Hai chiamato `grep`?"),
      has_code("-v", incorrect_msg = "Hai invertito la corrispondenza con `-v`?"),
      has_code("Tooth", incorrect_msg = "Hai cercato `Tooth`?"),
      has_code("sort", incorrect_msg = "Hai chiamato `sort`?"),
      has_code("-r", incorrect_msg = "Hai invertito l'ordine di ordinamento con `-r`?")
    )
  )
)
Ex().success_msg("Ordinato! `sort` ha molti usi. Per esempio, usare la pipe `sort -n` a `head` ti mostra i valori più grandi.")
```

---

## Come posso rimuovere le righe duplicate?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Un altro comando spesso usato insieme a `sort` è `uniq`,
il cui compito è rimuovere le righe duplicate.
Più nello specifico,
rimuove le righe duplicate *adiacenti*.
Se un file contiene:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

allora `uniq` produrrà:

```
2017-07-03
2017-08-03
```

ma se contiene:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

allora `uniq` stamperà tutte e quattro le righe.
Il motivo è che `uniq` è pensato per lavorare con file molto grandi.
Per rimuovere righe non adiacenti da un file,
dovrebbe tenere l'intero file in memoria
(o almeno
tutte le righe uniche viste finora).
Rimuovendo solo i duplicati adiacenti,
deve tenere in memoria solo l'ultima riga unica più recente.

`@instructions`
Scrivi una pipeline per:

- ottenere la seconda colonna da `seasonal/winter.csv`,
- rimuovere la parola "Tooth" dall'output in modo che vengano mostrati solo i nomi dei denti,
- ordinare l'output in modo che tutte le occorrenze di uno stesso nome di dente siano adiacenti; e
- visualizzare ogni nome di dente una sola volta insieme al conteggio di quante volte compare.

L'inizio della tua pipeline è lo stesso dell'esercizio precedente:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Estendila con un comando `sort` e usa `uniq -c` per visualizzare le righe uniche con il conteggio di quante volte ciascuna compare, invece di usare `uniq` e `wc`.

`@hint`
Copia e incolla il comando nelle istruzioni, fai una pipe a `sort` senza flag, poi fai di nuovo una pipe a `uniq` con il flag `-c`.

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
                     incorrect_msg="Dovresti iniziare con questo comando: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Ora estendilo!"),
            has_code('\|\s+sort', incorrect_msg="Hai esteso il comando con `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="Hai esteso il comando con `| uniq`?"),
            has_code('-c', incorrect_msg="Hai incluso i conteggi con `-c`?")
        )
    )
)
Ex().success_msg("Ottimo! Dopo tutto questo lavoro su una pipe, sarebbe bello se potessimo memorizzare il risultato, no?")
```

---

## Come posso salvare l'output di una pipe?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

La shell ci permette di reindirizzare l'output di una sequenza di comandi collegati tramite pipe:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Tuttavia, `>` deve comparire alla fine della pipeline:
se provi a usarlo in mezzo, così:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

allora tutto l'output di `cut` viene scritto in `teeth-only.txt`,
quindi non rimane nulla per `grep`
e questo resta in attesa all'infinito di qualche input.

<hr>

Cosa succede se mettiamo il reindirizzamento all'inizio di una pipeline come in:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [L'output del comando viene reindirizzato al file come al solito.]
- La shell segnala un errore.
- La shell resta in attesa di input all'infinito.

`@hint`
Provalo nella shell.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Corretto!', 'No; la shell può effettivamente eseguire questo.', 'No; la shell può effettivamente eseguire questo.'])
```

---

## Come posso interrompere un programma in esecuzione?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

I comandi e gli script che hai eseguito finora sono stati tutti rapidi,
ma alcuni compiti possono richiedere minuti, ore o persino giorni per concludersi.
Potresti anche inserire per errore una redirezione nel mezzo di una pipeline,
facendola bloccare.
Se decidi che non vuoi che un programma continui a funzionare,
puoi digitare `Ctrl` + `C` per terminarlo.
Nella documentazione Unix questo è spesso scritto `^C`;
nota che la “c” può essere minuscola.

`@instructions`
Esegui il comando:

```{shell}
head
```

senza argomenti (così rimarrà in attesa di un input che non arriverà mai)
e poi interrompilo digitando `Ctrl` + `C`.

`@hint`
Digita semplicemente head, premi Invio ed esci dal programma in esecuzione con `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Hai usato `head`?")
```

---

## Per concludere

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Per chiudere l'argomento,
costruirai una pipeline per scoprire quanti record ci sono nel più corto tra i file di dati stagionali.

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
Usa `wc` con i parametri appropriati per elencare il numero di righe in tutti i file di dati stagionali.
(Usa un jolly per i nomi dei file invece di digitarli tutti a mano.)

`@hint`
Usa `-l` per elencare solo le righe e `*` per far corrispondere i nomi dei file.

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
      has_code("wc", incorrect_msg = "Hai chiamato `wc`?"),
      has_code("-l", incorrect_msg = "Hai contato il numero di righe con `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Hai ottenuto i dati da tutti i file `seasonal/*`?")
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
Aggiungi un altro comando al precedente usando una pipe per rimuovere la riga contenente la parola "total".

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
      has_code("wc", incorrect_msg = "Hai chiamato `wc`?"),
      has_code("-l", incorrect_msg = "Hai contato il numero di righe con `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Hai ottenuto dati da tutti i file `seasonal/*`?"),
      has_code("|", incorrect_msg = "Hai usato la pipe da `wc` a `grep` usando `|`?"),      
      has_code("grep", incorrect_msg = "Hai chiamato `grep`?"),
      has_code("-v", incorrect_msg = "Hai invertito la corrispondenza con `-v`?"),
      has_code("total", incorrect_msg = "Hai cercato `total`?")
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
Aggiungi altre due fasi alla pipeline che usino `sort -n` e `head -n 1` per trovare il file con il minor numero di righe.

`@hint`
- Usa l'opzione `-n` di `sort` per ordinare numericamente.
- Usa l'opzione `-n` di `head` per limitarti a mantenere 1 riga.

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
      has_code("wc", incorrect_msg = "Hai chiamato `wc`?"),
      has_code("-l", incorrect_msg = "Hai contato il numero di righe con `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "Hai ottenuto i dati da tutti i file `seasonal/*`?"),
      has_code("|", incorrect_msg = "Hai usato la pipe da `wc` a `grep` a `sort` a `head` usando `|`?"),      
      has_code("grep", incorrect_msg = "Hai chiamato `grep`?"),
      has_code("-v", incorrect_msg = "Hai invertito la corrispondenza con `-v`?"),
      has_code("total", incorrect_msg = "Hai cercato `total`?"),
      has_code("sort", incorrect_msg = "Hai chiamato `sort`?"),
      has_code("-n", incorrect_msg = "Hai specificato il numero di righe da mantenere con `-n`?"),
      has_code("1", incorrect_msg = "Hai specificato 1 riga da mantenere con `-n 1`?")
    )
  )
)
Ex().success_msg("Ottimo! Si scopre che `autumn.csv` è il file con il minor numero di righe. Corri al capitolo 4 per saperne di più sull'elaborazione batch!")
```

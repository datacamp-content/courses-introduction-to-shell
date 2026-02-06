---
title: Tratamiento por lotes
description: >-
  La mayoría de los comandos del shell procesan muchos archivos a la vez. Este
  capítulo te muestra cómo hacer que tus propias canalizaciones lo hagan. De
  mientras, verás cómo el shell utiliza variables para almacenar información.
lessons:
  - nb_of_exercises: 10
    title: ¿Cómo almacena la información el shell?
---

## ¿Cómo almacena la información el shell?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Como otros programas, el shell almacena información en variables.
Algunas de ellas,
llamadas **variables de entorno**,
están disponibles siempre.
Los nombres de las variables de entorno se escriben convencionalmente en mayúsculas,
y a continuación se muestran algunas de las más utilizadas.

| Variable | Propósito                           | Valor                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | Directorio principal del usuario             | `/home/repl`          |
| `PWD `   | Directorio de trabajo actual         | Igual que el comando `pwd` |
| `SHELL`  | Qué programa shell se está utilizando | `/bin/bash`           |
| `USER`   | ID de usuario                         | `repl`                |

Para obtener una lista completa (que es bastante larga),
puedes escribir `set` en el intérprete de comandos.

<hr>

Utiliza `set` y `grep` con una canalización para mostrar el valor de `HISTFILESIZE`,
que determina cuántos comandos antiguos se almacenan en tu historial de comandos.
¿Cuál es su valor?

`@possible_answers`
- 10
- 500
- [2000]
- La variable no está ahí.

`@hint`
Utiliza `set | grep HISTFILESIZE` para obtener la línea que necesitas.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "No: el shell guarda más historial que eso."
err2 = "No: el shell guarda más historial que eso."
correct3 = "Correcto: el shell guarda 2000 comandos antiguos por defecto en este sistema."
err4 = "No: la variable `HISTFILESIZE` está ahí."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## ¿Cómo puedo imprimir el valor de una variable?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Una forma más sencilla de encontrar el valor de una variable es utilizar un comando llamado `echo`, que imprime sus argumentos. Si escribes

```{shell}
echo hello DataCamp!
```

se imprime

```
hello DataCamp!
```

Si intentas utilizarlo para imprimir el valor de una variable de este modo:

```{shell}
echo USER
```

imprimirá el nombre de la variable, `USER`.

Para obtener el valor de la variable, debes ponerle delante el signo de dólar `$`. Si escribes 

```{shell}
echo $USER
```

se imprime

```
repl
```

Esto es así en todas partes:
para obtener el valor de una variable llamada `X`,
debes escribir `$X`.
(Esto es para que el intérprete de comandos pueda saber si te refieres a "un archivo llamado X")
o "el valor de una variable llamada X").

`@instructions`
La variable `OSTYPE` contiene el nombre del tipo de sistema operativo que estás utilizando.
Muestra su valor utilizando `echo`.

`@hint`
Llama a `echo` con la variable `OSTYPE` precedida de `$`.

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
            has_code('echo', incorrect_msg="¿Llamaste a `echo`?"),
            has_code('OSTYPE', incorrect_msg="¿Imprimiste la variable de entorno `OSTYPE`?"),
            has_code(r'\$OSTYPE', incorrect_msg="Asegúrate de anteponer `$` a `OSTYPE`.")
        )
    )
)
Ex().success_msg("¡Excelente eco de variables de entorno! Vas por buen camino. ¡Sigamos adelante!")
```

---

## ¿De qué otra forma almacena información el shell?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

El otro tipo de variable se llama **shell variable**,
que es como una variable local en un lenguaje de programación.

Para crear una variable shell,
simplemente asignas un valor a un nombre:

```{shell}
training=seasonal/summer.csv
```

*sin* espacios antes ni después del signo `=`.
Una vez hecho esto,
puedes comprobar el valor de la variable con:

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
Define una variable llamada `testing` con el valor `seasonal/winter.csv`.

`@hint`
*No* debe haber espacios entre el nombre de la variable y su valor.

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
        has_code('testing', incorrect_msg='¿Definiste una variable de shell llamada `testing`?'),
        has_code('testing=', incorrect_msg='¿Escribiste `=` directamente después de testing, sin espacios?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='¿Asignaste el valor de `testing` a `seasonal/winter.csv`?')
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
Utiliza `head -n 1 SOMETHING` para obtener la primera línea de `seasonal/winter.csv`
utilizando el valor de la variable `testing` en lugar del nombre del archivo.

`@hint`
Recuerda utilizar `$testing` en lugar de `testing`
(el `$` es necesario para obtener el valor de la variable).

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
    has_code(r'\$testing', incorrect_msg="¿Referenciaste la variable del shell usando `$testing`?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="¿Llamaste a `head`?"),
            has_code('-n', incorrect_msg="¿Limitaste el número de líneas con `-n`?"),
            has_code(r'-n\s+1', incorrect_msg="¿Elegiste mantener 1 línea con `-n 1`?")     
        )
    )
)
Ex().success_msg("¡Estupendo! Veamos cómo puedes repetir comandos fácilmente.")
```

---

## ¿Cómo puedo repetir una orden muchas veces?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Las variables shell también se utilizan en **los bucles**,
que repiten comandos muchas veces.
Si ejecutamos este comando:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

que produce:

```
gif
jpg
png
```

Observa estos aspectos del bucle:

1. La estructura es `for`...variable... `in`...lista... `; do`...cuerpo... `; done`
2. La lista de acciones que debe procesar el bucle (en nuestro caso, las palabras `gif`, `jpg`, y `png`).
3. La variable que lleva la cuenta de qué está procesando actualmente el bucle (en nuestro caso, `filetype`).
4. El cuerpo del bucle que realiza el proceso (en nuestro caso, `echo $filetype`).

Observa que el cuerpo utiliza `$filetype` para obtener el valor de la variable en lugar de simplemente `filetype`,
como con cualquier otra variable del intérprete de comandos.
Fíjate también dónde van los puntos y comas:
la primera viene entre la lista y la palabra clave `do`,
y la segunda va entre el cuerpo y la palabra clave `done`.

`@instructions`
Modifica el bucle para que imprima:

```
docx
odt
pdf
```

Utiliza `filetype` como nombre de la variable de bucle.

`@hint`
Utiliza la estructura de código del texto introductorio, intercambiando los tipos de archivo de imagen por tipos de archivo de documento.

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
      has_code('for', incorrect_msg='¿Llamaste a `for`?'),
      has_code('filetype', incorrect_msg='¿Usaste `filetype` como la variable del bucle?'),
      has_code('in', incorrect_msg='¿Usaste `in` antes de la lista de tipos de archivo?'),
      has_code('docx odt pdf', incorrect_msg='¿Iteraste sobre `docx`, `odt` y `pdf` en ese orden?'),
      has_code(r'pdf\s*;', incorrect_msg='¿Pusiste un punto y coma después del último elemento del bucle?'),
      has_code(r';\s*do', incorrect_msg='¿Usaste `do` después del primer punto y coma?'),
      has_code('echo', incorrect_msg='¿Llamaste a `echo`?'),
      has_code(r'\$filetype', incorrect_msg='¿Mostraste `$filetype` con echo?'),
      has_code(r'filetype\s*;', incorrect_msg='¿Pusiste un punto y coma después del cuerpo del bucle?'),
      has_code('; done', incorrect_msg='¿Terminaste con `done`?')
    )
  )
)
Ex().success_msg("¡De primera para los bucles! Los bucles son brillantes si quieres hacer lo mismo cientos o miles de veces.")
```

---

## ¿Cómo puedo repetir un comando una vez para cada archivo?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Siempre puedes escribir los nombres de los archivos que quieres procesar al escribir el bucle,
pero suele ser mejor utilizar comodines.
Intenta ejecutar este bucle en la consola:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Imprime:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

porque el intérprete de comandos expande `seasonal/*.csv` para que sea una lista de cuatro nombres de archivo
antes de ejecutar el bucle.

`@instructions`
Modifica la expresión comodín por `people/*`
para que el bucle imprima los nombres de los archivos del directorio `people`
independientemente del sufijo que tengan o no.
Utiliza `filename` como nombre de tu variable de bucle.

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
      has_code('for', incorrect_msg='¿Llamaste a `for`?'),
      has_code('filename', incorrect_msg='¿Usaste `filename` como la variable del bucle?'),
      has_code('in', incorrect_msg='¿Usaste `in` antes de la lista de tipos de archivo?'),
      has_code('people/\*', incorrect_msg='¿Especificaste una lista de archivos con `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='¿Pusiste un punto y coma después de la lista de archivos?'),
      has_code(r';\s*do', incorrect_msg='¿Usaste `do` después del primer punto y coma?'),
      has_code('echo', incorrect_msg='¿Llamaste a `echo`?'),
      has_code(r'\$filename', incorrect_msg='¿Hiciste eco de `$filename`?'),
      has_code(r'filename\s*;', incorrect_msg='¿Pusiste un punto y coma después del cuerpo del bucle?'),
      has_code('; done', incorrect_msg='¿Terminaste con `done`?')
    )
  )
)
Ex().success_msg("¡Bucleando! Los comodines y los bucles son una combinación poderosa.")
```

---

## ¿Cómo puedo registrar los nombres de un conjunto de archivos?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

La gente suele establecer una variable utilizando una expresión comodín para registrar una lista de nombres de archivo.
Por ejemplo:
si defines `datasets` así:

```{shell}
datasets=seasonal/*.csv
```

puedes mostrar los nombres de los archivos más tarde utilizando:

```{shell}
for filename in $datasets; do echo $filename; done
```

Esto ahorra teclear y hace que los errores sean menos probables.

<hr>

Si ejecutas estos dos comandos en tu directorio principal,
¿cuántas líneas de salida imprimirán?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Ninguno: como `files` se define en una línea aparte, no tiene valor en la segunda línea.
- Uno: la palabra "files".
- Cuatro: los nombres de los cuatro archivos de datos estacionales.

`@hint`
Recuerda que `X` por sí solo es solo "X", mientras que `$X` es el valor de la variable `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "No: no tienes que definir una variable en la misma línea en la que la usas."
err2 = "No: este ejemplo define y usa la variable `files` en el mismo shell."
correct3 = "Correcto. El comando es equivalente a `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## El nombre de una variable frente a su valor

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Un error frecuente es olvidar utilizar `$` antes del nombre de una variable.
Cuando hagas esto
el shell utiliza el nombre que has escrito
en lugar del valor de esa variable.

Un error más común entre los usuarios experimentados es escribir mal el nombre de la variable.
Por ejemplo:
si defines `datasets` así:

```{shell}
datasets=seasonal/*.csv
```

y escribe:

```{shell}
echo $datsets
```

el shell no imprime nada,
porque `datsets` (sin la segunda "a") no está definido.

<hr>

Si ejecutaras estos dos comandos en tu directorio principal,
¿qué salida se imprimiría?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Lee atentamente la primera parte del bucle antes de responder).

`@hint`
Recuerda que `X` por sí solo es solo "X", mientras que `$X` es el valor de la variable `X`.

`@possible_answers`
- [Una línea: la palabra "files".]
- Cuatro líneas: los nombres de los cuatro archivos de datos estacionales.
- Cuatro líneas en blanco: a la variable `f` no se le asigna un valor.

`@feedback`
- Correcto: el bucle utiliza `files` en lugar de `$files`, por lo que la lista está formada por la palabra "files".
- No: el bucle utiliza `files` en lugar de `$files`, por lo que la lista consta de la palabra "files" en lugar de la expansión de `files`.
- No: la variable `f` la define automáticamente el bucle `for`.

---

## ¿Cómo puedo ejecutar muchos comandos en un solo bucle?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Imprimir los nombres de los archivos es útil para depurar,
pero el verdadero propósito de los bucles es realizar distintas acciones con varios archivos.
Este bucle imprime la segunda línea de cada archivo de datos:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Tiene la misma estructura que los otros bucles que ya has visto:
lo único que difiere es que su cuerpo es una cadena de dos comandos en lugar de un solo comando.

`@instructions`
Escribe un bucle que imprima la última entrada de julio de 2017 (`2017-07`) en cada archivo estacional. Debería producir una salida similar a:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

pero para **_cada_** archivo estacional por separado. Utiliza `file` como nombre de la variable de bucle, y recuerda recorrer la lista de archivos `seasonal/*.csv` _(en lugar de 'seasonal/winter.csv' como en el ejemplo_).

`@hint`
El cuerpo del bucle es el comando grep que se muestra en las instrucciones, con `seasonal/winter.csv` sustituido por `$file`.

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
  has_code('for', incorrect_msg='¿Llamaste a `for`?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='¿Usaste `file` como la variable del bucle?'),
      has_code('in', incorrect_msg='¿Usaste `in` antes de la lista de archivos?'),
      has_code('seasonal/\*', incorrect_msg='¿Especificaste una lista de archivos con `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='¿Pusiste un punto y coma después de la lista de archivos?'),
      has_code(r';\s*do', incorrect_msg='¿Usaste `do` después del primer punto y coma?'),
      has_code('grep', incorrect_msg='¿Llamaste a `grep`?'),
      has_code('2017-07', incorrect_msg='¿Coincidiste con `2017-07`?'),
      has_code(r'\$file', incorrect_msg='¿Usaste `$file` como el nombre de la variable del bucle?'),
      has_code(r'file\s*|', incorrect_msg='¿Usaste una tubería para conectar tu segundo comando?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='¿Usaste `tail -n 1` para imprimir la última entrada de cada búsqueda en tu segundo comando?'),
      has_code('; done', incorrect_msg='¿Terminaste con `done`?')
    )
  )
)

Ex().success_msg("¡Bucleando en bucles! Los comodines y los bucles son una combinación poderosa.")
```

---

## ¿Por qué no debo utilizar espacios en los nombres de archivo?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Es fácil y sensato dar a los archivos nombres de varias palabras como `July 2017.csv`
cuando utilices un explorador gráfico de archivos.
Sin embargo,
esto causa problemas cuando trabajas en el shell.
Por ejemplo:
supongamos que quieres cambiar el nombre de `July 2017.csv` por `2017 July data.csv`.
No puedes teclear:

```{shell}
mv July 2017.csv 2017 July data.csv
```

porque al shell le parece que intentas trasladar
cuatro archivos llamados `July`, `2017.csv`, `2017`, y `July` (otra vez)
a un directorio llamado `data.csv`.
En lugar de eso,
tienes que citar los nombres de los archivos
para que el intérprete de comandos trate cada uno de ellos como un único parámetro:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Si tienes dos archivos llamados `current.csv` y `last year.csv`
(con un espacio en su nombre)
y tecleas:

```{shell}
rm current.csv last year.csv
```

¿Qué ocurrirá?

`@hint`
¿Qué piensas que pasaría si alguien te enseñara el comando y no supieras qué archivos existen?

`@possible_answers`
- El intérprete de comandos imprimirá un mensaje de error porque `last` y `year.csv` no existen.
- El intérprete de comandos borrará `current.csv`.
- [Ambos.]
- Ninguno.

`@feedback`
- Sí, pero eso no es todo.
- Sí, pero eso no es todo.
- ¡Correcto! Puedes utilizar comillas simples, `'`, o dobles, `"`, alrededor de los nombres de archivo.
- Lamentablemente, no.

---

## ¿Cómo puedo realizar distintas acciones en un solo bucle?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Todos los bucles que has visto hasta ahora tienen una única orden o canalización en su cuerpo,
pero un bucle puede contener cualquier número de comandos.
Para decirle al shell dónde acaba uno y empieza el siguiente,
debes separarlos con punto y coma:

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

Supón que olvidas el punto y coma entre los comandos `echo` y `head` en el bucle anterior,
para que pidas al intérprete de comandos que se ejecute:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

¿Qué hará el shell?

`@possible_answers`
- Imprime un mensaje de error.
- Imprime una línea por cada uno de los cuatro archivos.
- Imprime una línea para `autumn.csv` (el primer archivo).
- Imprime la última línea de cada archivo.

`@hint`
Puedes canalizar la salida de `echo` a `tail`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "No: el bucle se ejecutará, solo que no hará algo sensato."
correct2 = "Sí: `echo` produce una línea que incluye el nombre del archivo dos veces, que `tail` luego copia."
err3 = "No: el bucle se ejecuta una vez por cada uno de los cuatro nombres de archivo."
err4 = "No: la entrada de `tail` es la salida de `echo` para cada nombre de archivo."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

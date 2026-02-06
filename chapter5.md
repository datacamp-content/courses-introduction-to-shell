---
title: Crear nuevas herramientas
description: >-
  El historial te permite repetir acciones con solo pulsar unas teclas, y las
  canalizaciones te permiten combinar comandos existentes para crear otros
  nuevos. En este capítulo, verás cómo ir un paso más allá y crear nuevos
  comandos propios.
lessons:
  - nb_of_exercises: 9
    title: ¿Cómo puedo editar un archivo?
---

## ¿Cómo puedo editar un archivo?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix tiene una desconcertante variedad de editores de texto.
Para este curso,
utilizaremos uno sencillo llamado Nano.
Si escribes `nano filename`,
se abrirá `filename` para editar
(o créalo si aún no existe).
Puedes moverte con las teclas de flecha,
borrar caracteres utilizando la tecla de retroceso,
y realizar otras operaciones con combinaciones de teclas de control:

- `Ctrl` + `K`: borra una línea.
- `Ctrl` + `U`: borra desde el cursor hasta el inicio de la línea.
- `Ctrl` + `O`: guarda el archivo ("O" significa "output", es decir, salida o resultado). _También tendrás que pulsar Intro para confirmar el nombre del archivo._
- `Ctrl` + `X`: salir del editor.

`@instructions`
Ejecuta `nano names.txt` para editar un nuevo archivo en tu directorio principal
e introduce las cuatro líneas siguientes:

```
Lovelace
Hopper
Johnson
Wilson
```

Para guardar lo que has escrito,
teclea `Ctrl` + `O` para escribir el archivo,
y luego Intro para confirmar el nombre del archivo,
y luego `Ctrl` + `X` para salir del editor.

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
patt = "¿Has incluido la línea `%s` en el archivo `names.txt`? Usa `nano names.txt` de nuevo para actualizar tu archivo. Usa `Ctrl` + `O` para guardar y `Ctrl` + `X` para salir."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("¡Bien hecho! ¡Vamos al siguiente!")
```

---

## ¿Cómo puedo grabar lo que acabo de hacer?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

Cuando realices un análisis complejo,
a menudo querrás llevar un registro de los comandos que has utilizado.
Puedes hacerlo con las herramientas que ya has visto:

1. Ejecuta `history`.
2. Canaliza su salida a `tail -n 10` (o al número de pasos recientes que quieras guardar).
3. Redirige eso a un archivo llamado algo así como `figure-5.history`.

Esto es mejor que tomar apuntes en un cuaderno de laboratorio
porque está garantizado que no se saltará ningún paso.
También ilustra la idea central del shell:
herramientas sencillas que producen y consumen líneas de texto
pueden combinarse de muchas maneras
para resolver una amplia gama de problemas.

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
Copia los archivos `seasonal/spring.csv` y `seasonal/summer.csv` en tu directorio principal.

`@hint`
Utiliza `cp` para copiar y `~` como acceso directo para la ruta a tu directorio principal.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="¿Has usado `cp seasonal/s* ~` para copiar los archivos requeridos a tu directorio personal?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("¡Impresionante mantenimiento de registros! Si escribiste mal algún comando, siempre puedes usar `nano` para limpiar el archivo de historial de guardados después.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
Utiliza `grep` con la marca `-h` (para que no imprima los nombres de los archivos).
y `-v Tooth` (para seleccionar las líneas que *no* coinciden con la línea de encabezado)
para seleccionar los registros de datos de `spring.csv` y `summer.csv` en ese orden
y redirige la salida a `temp.csv`.

`@hint`
Coloca las marcas antes de los nombres de archivo.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "¡Asegúrate de redirigir la salida del comando `grep` a `temp.csv` con `>`!"
msg2 = "¿Has usado `grep -h -v ___ ___ ___` (rellena los espacios) para llenar `temp.csv`?"
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
Introduce `history` en `tail -n 3`
y redirige la salida a `steps.txt`
para guardar los tres últimos comandos en un archivo.
(Tienes que guardar tres en lugar de solo dos
porque el propio comando `history` estará en la lista).

`@hint`
Recuerda que la redirección con `>` se produce al final de la secuencia de comandos canalizados.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="Asegúrate de redirigir la salida de tu comando a `steps.txt`."
msg2="¿Has usado `history | tail ___ ___` (rellena los espacios) para llenar `steps.txt`?"
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
Ex().success_msg("¡Bien hecho! ¡Vamos a subir el nivel!")
```

---

## ¿Cómo puedo guardar comandos para volver a ejecutarlos más tarde?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

Hasta ahora has utilizado el intérprete de comandos de forma interactiva.
Pero como los comandos que tecleas son solo texto,
puedes almacenarlos en archivos para que el shell los ejecute una y otra vez.
Para empezar a explorar esta potente capacidad,
pon el siguiente comando en un archivo llamado `headers.sh`:

```{shell}
head -n 1 seasonal/*.csv
```

Este comando selecciona la primera fila de cada uno de los archivos CSV del directorio `seasonal`.
Una vez que hayas creado este archivo,
puedes ejecutarlo escribiendo:

```{shell}
bash headers.sh
```

Esto le dice al shell (que no es más que un programa llamado `bash`)
que debe ejecutar los comandos contenidos en el archivo `headers.sh`,
que produce el mismo resultado que ejecutar los comandos directamente.

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
Utiliza `nano dates.sh` para crear un archivo llamado `dates.sh`
que contiene este comando:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

Extraer la primera columna de todos los archivos CSV en `seasonal`.

`@hint`
Introduce los comandos que se muestran en el archivo sin líneas en blanco ni espacios adicionales.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "¿Has incluido la línea `cut -d , -f 1 seasonal/*.csv` en el archivo `dates.sh`? Usa `nano dates.sh` de nuevo para actualizar tu archivo. Usa `Ctrl` + `O` para guardar y `Ctrl` + `X` para salir."
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
Utiliza `bash` para ejecutar el archivo `dates.sh`.

`@hint`
Utiliza `bash filename` para ejecutar el archivo.

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
      has_code("bash", incorrect_msg = '¿Llamaste a `bash`?'),
      has_code("dates.sh", incorrect_msg = '¿Especificaste el archivo `dates.sh`?')
    )
  )
)

```

---

## ¿Cómo puedo reutilizar las canalizaciones?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

Un archivo lleno de comandos del shell se llama**shell script**,
o a veces solo "script" para abreviar. Los scripts no tienen por qué tener nombres acabados en `.sh`,
pero esta lección utilizará esa convención
para ayudarte a controlar qué archivos son scripts.

Los scripts también pueden contener canalizaciones.
Por ejemplo:
si `all-dates.sh` contiene esta línea:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

entonces:

```{shell}
bash all-dates.sh > dates.out
```

extraerá las fechas únicas de los archivos de datos estacionales
y los guardará en `dates.out`.

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
Se ha preparado para ti un archivo `teeth.sh` en tu directorio principal, pero contiene algunos espacios en blanco.
Utiliza Nano para editar el archivo y sustituir los dos marcadores de posición `____`
con `seasonal/*.csv` y `-c` para que este script imprima un recuento del
Número de veces que aparece el nombre de cada diente en los archivos CSV del directorio `seasonal`.

`@hint`
Utiliza `nano teeth.sh` para editar el archivo.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="¿Has reemplazado los espacios correctamente para que el comando en `teeth.sh` sea `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`? Usa `nano teeth.sh` de nuevo para hacer los cambios necesarios."
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
Utiliza `bash` para ejecutar `teeth.sh` y `>` para redirigir su salida a `teeth.out`.

`@hint`
Recuerda que `> teeth.out` debe ir *después* del comando que produce la salida.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="¿Has redirigido correctamente el resultado de `bash teeth.sh` a `teeth.out` con el `>`?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = '¿Llamaste a `bash`?'),
      has_code("bash\s+teeth.sh", incorrect_msg = '¿Ejecutaste el archivo `teeth.sh`?'),
      has_code(">\s+teeth.out", incorrect_msg = '¿Redirigiste al archivo `teeth.out`?')
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
Ejecuta `cat teeth.out` para inspeccionar tus resultados.

`@hint`
Recuerda que puedes escribir los primeros caracteres de un nombre de archivo y luego pulsar el tabulador para autocompletar.

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
      has_code("cat", incorrect_msg = '¿Llamaste a `cat`?'),
      has_code("teeth.out", incorrect_msg = '¿Especificaste el archivo `teeth.out`?')
    )
  )
)
Ex().success_msg("¡Bien hecho! Todo esto puede parecer forzado al principio, pero lo bueno es que estás automatizando partes de tu flujo de trabajo paso a paso. ¡Algo que resulta muy útil como científico de datos!")
```

---

## ¿Cómo puedo pasar nombres de archivos a los scripts?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

Un script que procese archivos concretos es útil como registro de lo que hiciste, pero uno que te permita procesar los archivos que quieras es más útil.
Para hacerlo,
puedes utilizar la expresión especial `$@` (signo de dólar seguido inmediatamente del signo arroba)
que significa "todos los parámetros de la línea de comandos dados al script".

Por ejemplo, si `unique-lines.sh` contiene `sort $@ | uniq`, cuando ejecutes:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

el intérprete de comandos sustituye `$@` por `seasonal/summer.csv` y procesa un archivo. Si ejecutas esto:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

procesa dos archivos de datos, y así sucesivamente.

_Como recordatorio, para guardar lo que has escrito en Nano, escribe `Ctrl` + `O` para escribir el archivo, luego Intro para confirmar el nombre del archivo, y luego `Ctrl` + `X` para salir del editor._

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
Edita el script `count-records.sh` con Nano y rellena los dos marcadores de posición `____`
con `$@` y `-l` (_la letra_) respectivamente para que cuente el número de líneas de uno o varios archivos,
excluyendo la primera línea de cada uno.

`@hint`
* Utiliza `nano count-records.sh` para editar el nombre del archivo.
* Asegúrate de que estás especificando la _letra_ `-l`, y no el número uno.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="¿Has reemplazado los espacios en blanco correctamente para que el comando en `count-records.sh` sea `tail -q -n +2 $@ | wc -l`? Usa `nano count-records.sh` nuevamente para hacer los cambios necesarios."
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
Ejecuta `count-records.sh` en `seasonal/*.csv`
y redirige la salida a `num-records.out` utilizando `>`.

`@hint`
Utiliza `>` para redirigir la salida.

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
      has_code("bash", incorrect_msg = '¿Llamaste a `bash`?'),
      has_code("bash\s+count-records.sh", incorrect_msg = '¿Ejecutaste el archivo `count-records.sh`?'),
      has_code("seasonal/\*", incorrect_msg = '¿Especificaste los archivos a procesar con `seasonal/*`?'),
      has_code(">\s+num-records.out", incorrect_msg = '¿Redirigiste al archivo `num-records.out`?')
    )
  )
)
Ex().success_msg("¡Buen trabajo! ¡Tu poder con la terminal está en constante expansión!")
```

---

## ¿Cómo puedo procesar un único argumento?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

Así como `$@`,
el shell te permite utilizar `$1`, `$2`, etc. para referirte a parámetros específicos de la línea de comandos.
Puedes utilizarlo para escribir comandos que parezcan más sencillos o naturales que los del shell.
Por ejemplo:
Puedes crear un script llamado `column.sh` que seleccione una sola columna de un archivo CSV.
cuando el usuario proporciona el nombre del archivo como primer parámetro y la columna como segundo:

```{shell}
cut -d , -f $2 $1
```

y luego ejecutarlo utilizando:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

Observa cómo el script utiliza los dos parámetros en orden inverso.

<hr>

El script `get-field.sh` debe tomar un nombre de archivo,
el número de la fila a seleccionar,
el número de la columna a seleccionar,
e imprimir solo ese campo de un archivo CSV.
Por ejemplo:

```
bash get-field.sh seasonal/summer.csv 4 2
```

debe seleccionar el segundo campo de la línea 4 de `seasonal/summer.csv`.
¿Cuál de los siguientes comandos hay que poner en `get-field.sh` para hacerlo?

`@hint`
Recuerda que los parámetros de la línea de comandos se numeran de izquierda a derecha.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- No: que intentará utilizar el nombre del archivo como número de líneas a seleccionar con `head`.
- ¡Correcto!
- No: eso intentará utilizar el número de columna como número de línea y viceversa.
- No: eso utilizará el número de campo como nombre de archivo y viceversa.

---

## ¿Cómo puede un script de shell realizar distintas acciones?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

Hasta ahora, nuestros scripts de shell han tenido un único comando o canalización, pero un guión puede contener muchas líneas de comandos. Por ejemplo, puedes crear uno que te diga cuántos registros hay en el más corto y en el más largo de tus archivos de datos, es decir, el rango de longitudes de tus conjuntos de datos.

Ten en cuenta que en Nano, "copiar y pegar" se consigue navegando hasta la línea que quieres copiar, pulsando `CTRL` + `K` para cortar la línea, y luego `CTRL` + `U` dos veces para pegar dos copias de la misma.

_Como recordatorio, para guardar lo que has escrito en Nano, escribe `Ctrl` + `O` para escribir el archivo, luego Intro para confirmar el nombre del archivo, y luego `Ctrl` + `X` para salir del editor._

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
Utiliza Nano para editar el script `range.sh`
y sustituye los dos marcadores de posición `____`
con `$@` y `-v`
para que enumere los nombres y el número de líneas de todos los archivos indicados en la línea de comandos
*sin* mostrar el número total de líneas de todos los archivos.
(No intentes sustraer las líneas de encabezado de columna de los archivos).

`@hint`
Utiliza `wc -l $@` para contar las líneas de todos los archivos indicados en la línea de órdenes.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="¿Has reemplazado los espacios correctamente para que el comando en `range.sh` sea `wc -l $@ | grep -v total`? Usa `nano range.sh` de nuevo para hacer los cambios necesarios."
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
Vuelve a utilizar Nano para añadir `sort -n` y `head -n 1` en este orden
a la canalización en `range.sh`
para mostrar el nombre y el recuento de líneas del archivo más corto que se le haya dado.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="¿Has añadido `sort -n` y `head -n 1` con tuberías al archivo `range.sh`? Usa `nano range.sh` de nuevo para hacer los cambios necesarios."
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
De nuevo utilizando Nano, añade una segunda línea a `range.sh` para imprimir el nombre y el recuento de registros de
el archivo *más largo* del directorio, *así como* el más corto.
Esta línea debe ser un duplicado de la que ya has escrito,
pero con `sort -n -r` en lugar de `sort -n`.

`@hint`
Copia la primera línea y modifica el orden de clasificación.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="Mantén la primera línea en el archivo `range.sh`: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="¿Has duplicado la primera línea en `range.sh` y hecho un pequeño cambio? ¡`sort -n -r` en lugar de `sort -n`!"
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
Ejecuta el script en los archivos del directorio `seasonal`
utilizando `seasonal/*.csv` para hacer coincidir todos los archivos
y redirige la salida utilizando `>`
a un archivo llamado `range.out` en tu directorio principal.

`@hint`
Utiliza `bash range.sh` para ejecutar tu script, `seasonal/*.csv` para especificar archivos y `> range.out` para redirigir la salida.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="¿Has redirigido correctamente el resultado de `bash range.sh seasonal/*.csv` a `range.out` con el `>`?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = '¿Llamaste a `bash`?'),
has_code("bash\s+range.sh", incorrect_msg = '¿Ejecutaste el archivo `range.sh`?'),
has_code("seasonal/\*", incorrect_msg = '¿Especificaste los archivos a procesar con `seasonal/*`?'),
has_code(">\s+range.out", incorrect_msg = '¿Redirigiste al archivo `range.out`?')
)
)

Ex().success_msg("Esto va bien. ¡Dirígete al siguiente ejercicio para aprender sobre cómo escribir bucles!")
```

---

## ¿Cómo puedo escribir bucles en un script de shell?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

Los scripts de shell también pueden contener bucles. Puedes escribirlos utilizando puntos y comas, o dividirlos en líneas sin puntos y comas para hacerlos más legibles:

```{shell}
# Print the first and last data records of each file.
for filename in $@
do

    head -n 2 $filename | tail -n 1

    tail -n 1 $filename

done
```

(No tienes que sangrar los comandos dentro del bucle, pero si lo haces todo queda más claro).

La primera línea de este script es un **comentario** para indicar a los lectores lo que hace el script. Los comentarios empiezan con el carácter `#` y van hasta el final de la línea. Tu yo del futuro te agradecerá que añadas breves explicaciones como la que se muestra aquí a cada script que escribas.

_Como recordatorio, para guardar lo que has escrito en Nano, escribe `Ctrl` + `O` para escribir el archivo, luego Intro para confirmar el nombre del archivo, y luego `Ctrl` + `X` para salir del editor._

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
Rellena los marcadores de posición en el script `date-range.sh`
con `$filename` (dos veces), `head`, y `tail`
para que imprima la primera y la última fecha de uno o varios archivos.

`@hint`
Recuerda utilizar `$filename` para obtener el valor actual de la variable del bucle.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="En `date-range.sh`, ¿has cambiado la línea %s en el bucle para que sea `%s`? Usa `nano date-range.sh` para hacer cambios."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('primera', cmdpatt%'head')
msg2=msgpatt%('segunda', cmdpatt%'tail')
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
Ejecuta `date-range.sh` en los cuatro archivos de datos estacionales
utilizando `seasonal/*.csv` para hacer coincidir sus nombres.

`@hint`
La expresión comodín debe empezar por el nombre del directorio.

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
      has_code("bash", incorrect_msg = '¿Llamaste a `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = '¿Ejecutaste el archivo `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = '¿Especificaste los archivos a procesar con `seasonal/*`?')
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
Ejecuta `date-range.sh` en los cuatro archivos de datos estacionales utilizando `seasonal/*.csv` para que coincidan sus nombres,
y canaliza su salida a `sort` para comprobar que tus scripts se pueden utilizar igual que los comandos integrados de Unix.

`@hint`
Utiliza la misma expresión comodín que utilizaste antes.

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
      has_code("bash", incorrect_msg = '¿Llamaste a `bash`?'),
      has_code("bash\s+date-range.sh", incorrect_msg = '¿Ejecutaste el archivo `date-range.sh`?'),
      has_code("seasonal/\*", incorrect_msg = '¿Especificaste los archivos a procesar con `seasonal/*`?'),
      has_code("|", incorrect_msg = '¿Hiciste un pipe desde la salida del script a `sort`?'),
      has_code("sort", incorrect_msg = '¿Llamaste a `sort`?')
    )
  )
)
Ex().success_msg("¡Magia! Observa lo componibles que son todas las cosas que hemos aprendido.")
```

---

## ¿Qué ocurre si no proporciono los nombres de los archivos?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

Un error común en los scripts del shell (y en los comandos interactivos) es poner los nombres de los archivos en el lugar equivocado.
Si escribes:

```{shell}
tail -n 3
```

entonces, como `tail` no ha recibido ningún nombre de archivo,
espera a leer aquello que introduces con tu teclado.
Esto significa que si escribes:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

entonces `tail` sigue adelante e imprime las tres últimas líneas de `somefile.txt`,
pero `head` esperará eternamente la entrada del teclado,
ya que no se le ha dado un nombre de archivo y no hay nada por delante de él en la canalización.

<hr>

Supón que escribes accidentalmente:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

¿Qué debes hacer ahora?

`@possible_answers`
- Espera 10 segundos a que se agote el tiempo de espera de `head`.
- Escribe `somefile.txt` y pulsa Intro para dar entrada a `head`.
- Utiliza `Ctrl` + `C` para detener la ejecución del programa `head`.

`@hint`
¿Qué hace `head` si no tiene un nombre de archivo y no tiene ninguna dependencia upstream?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = 'No, los comandos no se agotarán.'
a2 = 'No, eso le dará a `head` el texto `somefile.txt` para procesar, pero luego se quedará esperando más entrada.'
a3 = "¡Sí! Deberías usar `Ctrl` + `C` para detener un programa en ejecución. ¡Esto concluye este curso introductorio! Si estás interesado en aprender más herramientas de línea de comandos, te recomendamos encarecidamente tomar nuestro curso introductorio gratuito de Git."
Ex().has_chosen(3, [a1, a2, a3])
```

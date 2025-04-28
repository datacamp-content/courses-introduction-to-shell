---
title: Combinar herramientas
description: >-
  El verdadero poder del shell Unix no reside en los comandos individuales, sino
  en lo fácil que es combinarlos para realizar acciones nuevas. Este capítulo te
  mostrará cómo utilizar este poder para seleccionar los datos que quieras, y
  presenta comandos para ordenar valores y eliminar duplicados.
lessons:
  - nb_of_exercises: 12
    title: ¿Cómo puedo almacenar la salida de un comando en un archivo?
---

## ¿Cómo puedo almacenar la salida de un comando en un archivo?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Todas las herramientas que has visto hasta ahora te permiten nombrar los archivos de entrada.
La mayoría no tienen la opción de dar un nombre al archivo de salida porque no lo necesitan.
En lugar de eso,
puedes utilizar **la redirección** para guardar la salida de cualquier comando donde quieras.
Si ejecutas este comando:

```{shell}
head -n 5 seasonal/summer.csv
```

imprime en la pantalla las 5 primeras líneas de los datos del verano.
Si ejecutas este comando en su lugar:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

no aparece nada en la pantalla.
En lugar de eso,
`head`se guarda en un nuevo archivo llamado `top.csv`.
Puedes echar un vistazo al contenido de ese archivo utilizando `cat`:

```{shell}
cat top.csv
```

El signo mayor que `>` indica al intérprete de comandos que redirija la salida de `head` a un archivo.
No forma parte del comando `head`;
en su lugar,
funciona con todos los comandos del shell que producen los resultados.

`@instructions`
Combina `tail` con la redirección para guardar las últimas 5 líneas de `seasonal/winter.csv` en un archivo llamado `last.csv`.

`@hint`
Utiliza `tail -n 5` para obtener las 5 últimas líneas.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "La línea `%s` debería estar en el archivo `last.csv`, pero no lo está. Redirige la salida de `tail -n 5 seasonal/winter.csv` a `last.csv` con `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` tiene demasiadas líneas. ¿Usaste la bandera `-n 5` con `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("¡Bien! ¡Vamos a practicar un poco más!")
```

---

## ¿Cómo puedo utilizar la salida de un comando como entrada?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Supón que quieres obtener líneas de la mitad de un archivo.
Más concretamente,
supongamos que quieres obtener las líneas 3-5 de uno de nuestros archivos de datos.
Puedes empezar utilizando `head` para obtener las 5 primeras líneas
y redirigirlo a un archivo,
y luego utiliza `tail` para seleccionar los 3 últimos:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Una comprobación rápida confirma que se trata de las líneas 3-5 de nuestro archivo original,
porque son las 3 últimas líneas de las 5 primeras.

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
Selecciona las dos últimas líneas de `seasonal/winter.csv`
y guárdalas en un archivo llamado `bottom.csv`.

`@hint`
Utiliza `tail` para seleccionar líneas y `>` para redirigir la salida de `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="La línea `%s` debería estar en el archivo `bottom.csv`, pero no lo está. Redirige la salida de `tail -n 2 seasonal/winter.csv` a `bottom.csv` con `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` tiene demasiadas líneas. ¿Usaste la bandera `-n 2` con `tail`?'),
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
Selecciona la primera línea de `bottom.csv`
para obtener la penúltima línea del archivo original.

`@hint`
Utiliza `head` para seleccionar la línea que quieras.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Hay algo mal con el archivo `bottom.csv`. ¡Asegúrate de no cambiarlo!"),
    has_expr_output(strict=True, incorrect_msg="¿Has usado `head` correctamente en `bottom.csv`? Asegúrate de usar el flag `-n` correctamente.")
)

Ex().success_msg("Bien hecho. Dirígete al siguiente ejercicio para descubrir mejores formas de combinar comandos.")                             

```

---

## ¿Cuál es la mejor forma de combinar comandos?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Utilizar la redirección para combinar comandos tiene dos inconvenientes:

1. Deja un montón de archivos intermedios por ahí (como `top.csv`).
2. Los comandos para producir tu resultado final están dispersos en varias líneas de la historia.

El shell proporciona otra herramienta que resuelve estos dos problemas a la vez, llamada **canalización**.
Una vez más,
empieza por ejecutar `head`:

```{shell}
head -n 5 seasonal/summer.csv
```

En lugar de enviar la salida de `head` a un archivo,
añade una barra vertical y el comando `tail` *sin* nombre de archivo:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

El símbolo de la canalización indica al shell que utilice la salida del comando de la izquierda
como entrada para el comando de la derecha.

`@instructions`
Utiliza `cut` para seleccionar todos los nombres "Tooth" de la columna 2 del archivo delimitado por comas `seasonal/summer.csv`, y luego pasa el resultado a `grep`, con una coincidencia invertida, para excluir la línea de encabezado que contiene la palabra "Tooth". *`cut` y `grep` se trataron en detalle en el capítulo 2, ejercicios 8 y 11 respectivamente.*

`@hint`
- La primera parte del comando tiene la forma `cut -d field_delimiter -f column_number filename`.
- La segunda parte del comando tiene la forma `grep -v thing_to_match`.

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
    has_expr_output(incorrect_msg = '¿Has canalizado el resultado de `cut -d , -f 2 seasonal/summer.csv` en `grep -v Tooth` con `|`?'),
    check_not(has_output("Tooth"), incorrect_msg = '¿Excluiste la línea de encabezado `"Tooth"` usando `grep`?')
)
Ex().success_msg("¡Piping perfecto! Puede que sea la primera vez que usas `|`, ¡pero definitivamente no será la última!")
```

---

## ¿Cómo puedo combinar varios comandos?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Puedes encadenar cualquier número de comandos.
Por ejemplo:
este comando:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

lo que hará es:

1. selecciona la primera columna de Spring Data;
2. eliminar la línea de encabezamiento que contiene la palabra "Date"; y
3. selecciona las 10 primeras líneas de datos reales.

`@instructions`
En el ejercicio anterior, utilizaste el siguiente comando para seleccionar todos los nombres de "Tooth" de la columna 2 de `seasonal/summer.csv`:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Amplía esta cadena con un comando `head` para seleccionar solo el primer nombre de "Tooth".

`@hint`
Copia y pega el código de las instrucciones, añade una canalización y, a continuación, llama a `head` con la marca `-n`.

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
    has_output('^\s*canine\s*$', incorrect_msg = "¿Has usado `|` para extender la tubería con un comando `head`? Asegúrate de establecer correctamente el indicador `-n`."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "¿Has usado `|` para extender la tubería con un comando `head`?")
)
Ex().success_msg("¡Encadenamiento alegre! Al encadenar varios comandos juntos, puedes construir potentes tuberías de manipulación de datos.")
```

---

## ¿Cómo puedo contar los registros de un archivo?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

El comando `wc` (abreviatura de "word count", es decir, "recuento de palabras") imprime el número de **caracteres**, **palabras** y **líneas** de un archivo.
Puedes hacer que imprima solo uno de ellos utilizando `-c`, `-w`, o `-l` respectivamente.

`@instructions`
Cuenta cuántos registros en `seasonal/spring.csv` tienen fechas en julio de 2017 (`2017-07`). 
- Para ello, utiliza `grep` con una fecha parcial para seleccionar las líneas y canaliza este resultado en `wc` con una marca adecuada para contar las líneas.

`@hint`
- Utiliza `head seasonal/spring.csv` para recordar el formato de la fecha.
- La primera parte del comando tiene la forma `grep thing_to_match filename`.
- Después de la canalización, `|`, llama a `wc` con la marca `-l`.

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
      has_code("grep", incorrect_msg = "¿Llamaste a `grep`?"),
      has_code("2017-07", incorrect_msg = "¿Buscaste `2017-07`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "¿Buscaste en el archivo `seasonal/spring.csv`?"),
      has_code("|", incorrect_msg = "¿Usaste `|` para canalizar a `wc`?"),      
      has_code("wc", incorrect_msg = "¿Llamaste a `wc`?"),
      has_code("-l", incorrect_msg = "¿Contaste líneas con `-l`?")
    )
  )
)
Ex().success_msg("¡Buen conteo! Determinar cuántos datos tienes es un gran primer paso en cualquier análisis de datos.")
```

---

## ¿Cómo puedo especificar muchos archivos a la vez?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

La mayoría de los comandos del shell funcionarán en varios archivos si les das varios nombres de archivo.
Por ejemplo:
puedes obtener la primera columna de todos los archivos de datos estacionales a la vez de la siguiente manera:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Pero escribir los nombres de muchos archivos una y otra vez es una mala idea:
pierde el tiempo,
y tarde o temprano omitirás un archivo o repetirás el nombre de un archivo.
Para facilitarte la vida,
el shell te permite utilizar **comodines** para especificar una lista de archivos con una sola expresión.
El comodín más común es `*`,
que significa "coincide con cero o más caracteres".
Al utilizarlo,
podemos acortar el comando `cut` anterior a esto:

```{shell}
cut -d , -f 1 seasonal/*
```

o:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Escribe un único comando utilizando `head` para obtener las tres primeras líneas tanto de `seasonal/spring.csv` como de `seasonal/summer.csv`, un total de seis líneas de datos, pero *no* de los archivos de datos de otoño o invierno.
Utiliza un comodín en lugar de escribir el nombre completo de los archivos.

`@hint`
- El comando tiene la forma `head -n number_of_lines filename_pattern`.
- Podrías hacer coincidir archivos del directorio `a`, empezando por `b`, utilizando `a/b*`, por ejemplo.

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
    has_expr_output(incorrect_msg = "Puedes usar `seasonal/s*` para seleccionar `seasonal/spring.csv` y `seasonal/summer.csv`. ¡Asegúrate de incluir solo las primeras tres líneas de cada archivo con la bandera `-n`!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "No incluyas la salida para `seasonal/autumn.csv`. Puedes usar `seasonal/s*` para seleccionar `seasonal/spring.csv` y `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "No incluyas la salida para `seasonal/winter.csv`. Puedes usar `seasonal/s*` para seleccionar `seasonal/spring.csv` y `seasonal/summer.csv`")
)
Ex().success_msg("¡Trabajo salvaje con comodines! Esto se vuelve aún más importante si tu directorio contiene cientos o miles de archivos.")
```

---

## ¿Qué otros comodines puedo utilizar?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

El intérprete de comandos también tiene otros comodines,
aunque su uso es menos frecuente:

- `?` coincide con un solo carácter, por lo que `201?.txt` coincidirá con `2017.txt` o `2018.txt`, pero no con `2017-01.txt`.
- `[...]` coincide con cualquiera de los caracteres dentro de los corchetes, por lo que `201[78].txt` coincide con `2017.txt` o `2018.txt`, pero no con `2016.txt`.
- `{...}` coincide con cualquiera de los patrones separados por comas dentro de las llaves, de modo que `{*.txt, *.csv}` coincide con cualquier archivo cuyo nombre termine en `.txt` o `.csv`, pero no con archivos cuyos nombres terminen en `.pdf`.

<hr/>

¿Qué expresión coincidiría con `singh.pdf` y `johel.txt` pero *no* con `sandhu.pdf` ni `sandhu.txt`?

`@hint`
Compara cada expresión con cada nombre de archivo sucesivamente.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- No: `.pdf` y `.txt` no son nombres de archivo.
- No: esto coincidirá con `sandhu.pdf`.
- No: la expresión entre corchetes solo coincide con un carácter, no con palabras completas.
- ¡Correcto!

---

## ¿Cómo puedo ordenar líneas de texto?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Como su nombre indica,
`sort` ordena los datos.
Por defecto lo hace en orden alfabético ascendente,
pero se pueden utilizar las marcas `-n` y `-r` para ordenar numéricamente e invertir el orden de su salida,
mientras que `-b` le dice que ignore los espacios en blanco a la izquierda
y `-f` le dice que **no**distinga entre mayúsculas y minúsculas.
Las canalizaciones suelen utilizar `grep` para deshacerse de los registros no deseados
y luego `sort` para poner en orden los registros restantes.

`@instructions`
¿Recuerdas la combinación de `cut` y `grep` para seleccionar todos los nombres de "Tooth" de la columna 2 de `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

A partir de esta receta, ordena los nombres de los dientes en `seasonal/winter.csv` (no `summer.csv`) en orden alfabético descendente. Para ello, amplía la canalización con un paso `sort`.

`@hint`
Copia y pega el comando en las instrucciones, cambia el nombre del archivo, añade una canalización y, a continuación, llama a `sort` con la marca `-r`.

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
      has_code("cut", incorrect_msg = "¿Llamaste a `cut`?"),
      has_code("-d", incorrect_msg = "¿Especificaste un delimitador de campo con `-d`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "¿Obtuviste datos del archivo `seasonal/winter.csv`?"),
      has_code("|", incorrect_msg = "¿Usaste `|` para canalizar de `cut` a `grep` a `sort`?"),      
      has_code("grep", incorrect_msg = "¿Llamaste a `grep`?"),
      has_code("-v", incorrect_msg = "¿Invertiste la coincidencia con `-v`?"),
      has_code("Tooth", incorrect_msg = "¿Buscaste `Tooth`?"),
      has_code("sort", incorrect_msg = "¿Llamaste a `sort`?"),
      has_code("-r", incorrect_msg = "¿Invertiste el orden de clasificación con `-r`?")
    )
  )
)
Ex().success_msg("¡Ordenado! `sort` tiene muchos usos. Por ejemplo, canalizar `sort -n` a `head` te muestra los valores más grandes.")
```

---

## ¿Cómo puedo eliminar las líneas duplicadas?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Otro comando que se utiliza a menudo con `sort` es `uniq`,
cuya función es eliminar las líneas duplicadas.
Más concretamente,
elimina las líneas duplicadas *adyacentes*.
Si un archivo contiene:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

entonces `uniq` producirá:

```
2017-07-03
2017-08-03
```

pero si contiene:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

entonces `uniq` imprimirá las cuatro líneas.
La razón es que `uniq` está hecho para trabajar con archivos muy grandes.
Para eliminar líneas no adyacentes de un archivo,
tendría que mantener todo el archivo en memoria
(o al menos,
todas las líneas únicas vistas hasta ahora).
Eliminando solo los duplicados adyacentes,
solo tiene que mantener en memoria la línea única más reciente.

`@instructions`
Escribe un conducto para:

- obtener la segunda columna de `seasonal/winter.csv`,
- eliminar la palabra "Tooth" de la salida para que solo se muestren los nombres de los dientes,
- ordenar la salida de modo que todas las apariciones de un nombre de diente concreto sean adyacentes; y
- mostrar cada nombre de "Tooth" una vez junto con un recuento de la frecuencia con la que se produce.

El inicio de tu canalización es el mismo que en el ejercicio anterior:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Amplíala con un comando `sort`, y utiliza `uniq -c` para mostrar líneas únicas con un recuento de la frecuencia con que se produce cada una, en lugar de utilizar `uniq` y `wc`.

`@hint`
Copia y pega el comando en las instrucciones, canaliza a `sort` sin marcas, y luego canaliza de nuevo a `uniq` con una marca `-c`.

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
                     incorrect_msg="Deberías comenzar con este comando: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. ¡Ahora extiéndelo!"),
            has_code('\|\s+sort', incorrect_msg="¿Has extendido el comando con `| sort`?"),
            has_code('\|\s+uniq', incorrect_msg="¿Has extendido el comando con `| uniq`?"),
            has_code('-c', incorrect_msg="¿Has incluido los conteos con `-c`?")
        )
    )
)
Ex().success_msg("¡Genial! Después de todo este trabajo en un pipe, sería bueno si pudiéramos almacenar el resultado, ¿no?")
```

---

## ¿Cómo puedo guardar la salida de una canalización?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

El intérprete de comandos nos permite redirigir la salida de una secuencia de comandos canalizados:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Sin embargo, `>` debe aparecer al final de la canalización:
si intentamos utilizarlo en el medio, así:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

entonces toda la salida de `cut` se escribe en `teeth-only.txt`,
así que no queda nada para `grep`
y espera eternamente alguna entrada.

<hr>

¿Qué ocurre si ponemos la redirección al principio de una canalización como en:

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [La salida del comando se redirige al archivo de la forma habitual.]
- El intérprete de comandos lo notifica como error.
- El intérprete de comandos se queda esperando la entrada.

`@hint`
Pruébalo en el shell.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['¡Correcto!', 'No; la shell en realidad puede ejecutar esto.', 'No; la shell en realidad puede ejecutar esto.'])
```

---

## ¿Cómo puedo detener un programa en ejecución?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Los comandos y scripts que has ejecutado hasta ahora se han ejecutado rápidamente,
pero algunas tareas tardarán minutos, horas o incluso días en completarse.
También puedes equivocarte al poner la redirección en medio de una canalización,
haciendo que se cuelgue.
Si decides que no quieres que un programa siga ejecutándose,
puedes teclear `Ctrl` + `C` para finalizarlo.
A menudo se escribe `^C` en la documentación de Unix;
ten en cuenta que la "c" puede ser minúscula.

`@instructions`
Ejecuta el comando:

```{shell}
head
```

sin argumentos (para que espere una entrada que nunca llegará)
y luego detenlo escribiendo `Ctrl` + `C`.

`@hint`
Simplemente escribe "head", pulsa Intro y sal del programa en ejecución con `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="¿Has usado `head`?")
```

---

## En resumen

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

En resumen,
construirás una canalización para averiguar cuántos registros hay en el más corto de los archivos de datos estacionales.

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
Utiliza `wc` con los parámetros adecuados para listar el número de líneas de todos los archivos de datos estacionales.
(Utiliza un comodín para los nombres de archivo en lugar de escribirlos todos a mano).

`@hint`
Utiliza `-l` para listar solo las líneas y `*` para los nombres de archivo.

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
      has_code("wc", incorrect_msg = "¿Llamaste a `wc`?"),
      has_code("-l", incorrect_msg = "¿Contaste el número de líneas con `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "¿Obtuviste datos de todos los archivos `seasonal/*`?")
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
Añade otro comando al anterior utilizando una canalización para eliminar la línea que contiene la palabra "total".

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
      has_code("wc", incorrect_msg = "¿Llamaste a `wc`?"),
      has_code("-l", incorrect_msg = "¿Contaste el número de líneas con `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "¿Obtuviste datos de todos los archivos `seasonal/*`?"),
      has_code("|", incorrect_msg = "¿Usaste `|` para canalizar de `wc` a `grep`?"),      
      has_code("grep", incorrect_msg = "¿Llamaste a `grep`?"),
      has_code("-v", incorrect_msg = "¿Invertiste la coincidencia con `-v`?"),
      has_code("total", incorrect_msg = "¿Buscaste `total`?")
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
Añade dos etapas más a la cadena que utilicen `sort -n` y `head -n 1` para encontrar el archivo que contenga menos líneas.

`@hint`
- Utiliza la marca `-n` de `sort` para ordenar numéricamente.
- Utiliza la marca `-n` de `head` para limitarte a mantener 1 línea.

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
      has_code("wc", incorrect_msg = "¿Llamaste a `wc`?"),
      has_code("-l", incorrect_msg = "¿Contaste el número de líneas con `-l`?"),
      has_code("seasonal/\*", incorrect_msg = "¿Obtuviste datos de todos los archivos `seasonal/*`?"),
      has_code("|", incorrect_msg = "¿Usaste `|` para canalizar de `wc` a `grep` a `sort` a `head`?"),      
      has_code("grep", incorrect_msg = "¿Llamaste a `grep`?"),
      has_code("-v", incorrect_msg = "¿Invertiste la coincidencia con `-v`?"),
      has_code("total", incorrect_msg = "¿Buscaste `total`?"),
      has_code("sort", incorrect_msg = "¿Llamaste a `sort`?"),
      has_code("-n", incorrect_msg = "¿Especificaste el número de líneas a mantener con `-n`?"),
      has_code("1", incorrect_msg = "¿Especificaste 1 línea a mantener con `-n 1`?")
    )
  )
)
Ex().success_msg("¡Genial! Resulta que `autumn.csv` es el archivo con menos líneas. ¡Apresúrate al capítulo 4 para aprender más sobre el procesamiento por lotes!")
```

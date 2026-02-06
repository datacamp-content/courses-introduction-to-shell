---
title: Manipular archivos y directorios
description: >-
  Este capítulo es una breve introducción al shell Unix. Aprenderás por qué se
  sigue utilizando después de casi 50 años, cómo se compara con las herramientas
  gráficas con las que puedes estar más familiarizado, cómo moverte por el shell
  y cómo crear, modificar y eliminar archivos y carpetas.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: ¿Cómo se compara el shell con una interfaz de escritorio?
---

## ¿Cómo se compara el shell con una interfaz de escritorio?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Un sistema operativo como Windows, Linux o Mac OS es un tipo especial de programa.
Controla el procesador, el disco duro y la conexión de red del ordenador,
pero su función más importante es ejecutar otros programas.

Puesto que los seres humanos no son digitales,
necesitan una interfaz para interactuar con el sistema operativo.
El más común hoy en día es un explorador gráfico de archivos,
que traduce los clics y dobles clics en órdenes para abrir archivos y ejecutar programas.
Antes de que los ordenadores tuvieran pantallas gráficas,
sin embargo,
la gente tecleaba instrucciones en un programa llamado **command-line shell**.
Cada vez que se introduce un comando,
el shell ejecuta otros programas,
imprime su salida de forma legible para el ser humano,
y luego muestra un *prompt* para indicar que está preparado para aceptar la siguiente orden.
(Su nombre proviene de la idea de que es la "outer shell" o "carcasa exterior" del ordenador).

Escribir comandos en lugar de hacer clic y arrastrar puede parecer torpe al principio,
pero como verás
una vez que empieces a explicar lo que quieres que haga el ordenador,
puedes combinar comandos antiguos para crear otros nuevos
y automatizar las operaciones repetitivas
con solo pulsar unas teclas.

<hr>
¿Qué relación hay entre el explorador gráfico de archivos que utiliza la mayoría de la gente y el shell de línea de comandos?

`@hint`
Recuerda que un usuario solo puede interactuar con un sistema operativo a través de un programa.

`@possible_answers`
- El explorador de archivos te permite ver y editar archivos, mientras que el intérprete de comandos te permite ejecutar programas.
- El explorador de archivos está construido sobre el shell.
- El shell o intérprete de comandos forma parte del sistema operativo, mientras que el explorador de archivos es independiente.
- [Ambas son interfaces para emitir órdenes al sistema operativo.]

`@feedback`
- Ambos te permiten ver y editar archivos y ejecutar programas.
- Tanto los exploradores gráficos de archivos como el shell llaman a las mismas funciones subyacentes del sistema operativo.
- Tanto el intérprete de comandos como el explorador de archivos son programas que traducen las órdenes del usuario (tecleadas o pulsadas) en llamadas al sistema operativo.
- ¡Correcto! Ambos toman las órdenes del usuario (ya sean tecleadas o pulsadas) y las envían al sistema operativo.

---

## ¿Dónde estoy?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

El **sistema de archivos** gestiona archivos y directorios (o carpetas).
Cada uno se identifica por una **ruta de acceso absoluta**
que muestra cómo llegar a él desde el **root directory o directorio raíz** del sistema de archivos:
`/home/repl` es el directorio `repl` en el directorio `home`,
mientras que `/home/repl/course.txt` es un archivo `course.txt` en ese directorio,
y `/` por sí solo es el directorio raíz.

Para saber en qué parte del sistema de archivos te encuentras,
ejecuta el comando `pwd`
(abreviatura de "**p**rint **w**orking **d**irectory").
Este devuelve la ruta de acceso absoluta de tu **directorio de trabajo actual**,
que es donde el shell ejecuta comandos y busca archivos por defecto.

<hr>
Ejecuta `pwd`.
¿Dónde estás ahora?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Los sistemas Unix suelen colocar los directorios personales de todos los usuarios debajo de `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Ese no es el camino correcto."
correct = "Correcto - estás en `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## ¿Cómo puedo identificar archivos y directorios?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` te dice dónde estás.
Para saber lo que hay,
escribe `ls` (que es la abreviatura de "**l**i**s**ting") y pulsa la tecla intro.
Por sí solo,
`ls` lista el contenido de tu directorio actual
(el que aparece en `pwd`).
Si añades los nombres de algunos archivos,
`ls` los enumerará,
y si añades los nombres de los directorios,
te mostrará su contenido.
Por ejemplo:
`ls /home/repl` te muestra lo que hay en tu directorio inicial
(normalmente llamado tu **home directory**).

<hr>
Utiliza `ls` con un argumento adecuado para listar los archivos del directorio `/home/repl/seasonal`.
(que contiene información sobre cirugías dentales por fecha, desglosadas por temporada).
¿Cuál de estos archivos *no* está en ese directorio?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Si le das a `ls` una ruta, te muestra lo que hay en esa ruta.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Ese archivo está en el directorio `seasonal`."
correct = "Correcto - ese archivo *no* está en el directorio `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## ¿De qué otra forma puedo identificar los archivos y directorios?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Una ruta de acceso absoluta es como una latitud y una longitud: tiene el mismo valor estés donde estés. Una **ruta de acceso relativa**, en cambio, especifica una ubicación a partir de donde te encuentras: es como decir "20 kilómetros al norte".

Como ejemplos:
- Si estás en el directorio `/home/repl`, la ruta **relativa** `seasonal` especifica el mismo directorio que la ruta **absoluta** `/home/repl/seasonal`. 
- Si estás en el directorio `/home/repl/seasonal`, la ruta **relativa** `winter.csv` especifica el mismo archivo que la ruta **absoluta** `/home/repl/seasonal/winter.csv`.

El shell decide si una ruta es absoluta o relativa fijándose en su primer carácter: Si empieza por `/`, es absoluta. Si *no* empieza por `/`, es relativa.

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
Estás en `/home/repl`. Utiliza `ls` con una **ruta de acceso relativa** para listar el archivo cuya ruta de acceso absoluta sea `/home/repl/course.txt` (y solo ese archivo).

`@hint`
A menudo puedes construir la ruta de acceso relativa a un archivo o directorio por debajo de tu ubicación actual
restando la ruta de acceso absoluta de tu ubicación actual
de la ruta de acceso absoluta de lo que quieras.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "No llamaste a `ls` para generar la lista de archivos."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Tu comando no generó la lista de archivos correcta. Usa `ls` seguido de una ruta relativa a `/home/repl/course.txt`.")
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
Estás en `/home/repl`.
Utiliza `ls` con una ruta **relativa**
para listar el archivo `/home/repl/seasonal/summer.csv` (y solo ese archivo).

`@hint`
Las rutas de acceso relativas *no* empiezan con una "/" inicial.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "No llamaste a `ls` para generar la lista de archivos."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Tu comando no generó la lista de archivos correcta. Usa `ls` seguido de una ruta relativa a `/home/repl/seasonal/summer.csv`.")
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
Estás en `/home/repl`.
Utiliza `ls` con una ruta **relativa**
para listar el contenido del directorio `/home/repl/people`.

`@hint`
Las rutas de acceso relativas no empiezan con una "/" inicial.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "No llamaste a `ls` para generar la lista de archivos."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Tu comando no generó la lista de archivos correcta. Usa `ls` seguido de una ruta relativa a `/home/repl/people`.")
    )
)
Ex().success_msg("Bien hecho. Ahora que sabes cómo listar archivos y directorios, ¡veamos cómo puedes moverte por el sistema de archivos!")
```

---

## ¿Cómo puedo moverme a otro directorio?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Igual que puedes moverte por un explorador de archivos haciendo doble clic en las carpetas,
puedes moverte por el sistema de archivos utilizando el comando `cd`
(que significa "change directory", es decir, "cambiar directorio").

Si escribes `cd seasonal` y luego escribes `pwd`,
el shell te dirá que ahora estás en `/home/repl/seasonal`.
Si luego ejecutas `ls` solo,
te muestra el contenido de `/home/repl/seasonal`,
porque ahí es donde estás tú.
Si quieres volver a tu directorio de inicio `/home/repl`,
puedes utilizar el comando `cd /home/repl`.

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
Estás en `/home/repl`/.
Cambia el directorio a `/home/repl/seasonal` utilizando una ruta de acceso relativa.

`@hint`
Recuerda que `cd` significa "cambiar de directorio" y que las rutas de acceso relativas no empiezan por un "/" inicial.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Si tu directorio de trabajo actual (descúbrelo con `pwd`) es `/home/repl`, puedes moverte a la carpeta `seasonal` con `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: e69c8eac15
xp: 35
```

`@instructions`
Utiliza `pwd` para comprobar que estás allí.

`@hint`
Recuerda pulsar "intro" o "retorno" después de introducir el comando.

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
Utiliza `ls` sin ninguna ruta para ver lo que hay en ese directorio.

`@hint`
Recuerda pulsar "intro" o "retorno" después del comando.

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
      has_code('ls', incorrect_msg="Tu comando no generó la salida correcta. ¿Has usado `ls` sin rutas para mostrar el contenido del directorio actual?")
    )
)

Ex().success_msg("¡Genial! Esto fue sobre navegar hacia subdirectorios. ¿Qué tal si subimos? ¡Vamos a descubrirlo!")
```

---

## ¿Cómo puedo ascender en un directorio?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

El **parent** de un directorio es el directorio que está por encima de él.
Por ejemplo, `/home` es el parent de `/home/repl`,
y `/home/repl` es el parent de `/home/repl/seasonal`.
Siempre puedes dar la ruta de acceso absoluta de tu directorio principal o parent a comandos como `cd` y `ls`.
Más a menudo,
sin embargo,
aprovecharás el hecho de que la ruta especial `..`
(dos puntos sin espacios) significa "el directorio situado encima del directorio en el que estoy actualmente".
Si estás en `/home/repl/seasonal`,
entonces `cd ..` te desplaza a `/home/repl`.
Si vuelves a utilizar `cd ..`,
te sitúa en `/home`.
Un `cd ..` más te sitúa en el *directorio raíz* `/`,
que es la parte superior del sistema de archivos.
(Recuerda poner un espacio entre `cd` y `..`: es un comando y una ruta, no un único comando de cuatro letras).

Un punto solo, `.`, siempre significa "el directorio actual",
así que `ls` por sí solo y `ls .` hacen lo mismo,
mientras que `cd .` no tiene ningún efecto
(porque te traslada al directorio en el que estás actualmente).

Una última ruta especial es `~` (el carácter tilde),
que significa "your home directory", es decir, "tu directorio principal",
como `/home/repl`.
No importa dónde estés,
`ls ~` siempre mostrará el contenido de tu directorio principal,
y `cd ~` siempre te llevará allí.

<hr>
Si estás en `/home/repl/seasonal`,
¿a dónde te lleva `cd ~/../.`?

`@hint`
Traza la ruta directorio a directorio.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (el directorio raíz)

`@feedback`
- No, pero `~` o `..` por sí solos te llevarían hasta allí.
- ¡Correcto! La ruta significa "directorio principal", "subir un nivel", "aquí".
- No, pero `.` por sí solo lo haría.
- No, la parte final de la ruta es `.` (que significa "aquí") y no `..` (que significa "subir").

---

## ¿Cómo puedo copiar archivos?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

A menudo querrás copiar archivos,
muévelos a otros directorios para organizarlos,
o cámbiales el nombre.
Un comando para hacerlo es `cp`, que es la abreviatura de "copy", es decir, "copiar".
Si `original.txt` es un archivo existente,
entonces:

```{shell}
cp original.txt duplicate.txt
```

crea una copia de `original.txt` llamada `duplicate.txt`.
Si ya existía un archivo llamado `duplicate.txt`,
se sobrescribe.
Si el último parámetro a `cp` es un directorio existente,
entonces un comando como:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

copia *todos* los archivos en ese directorio.

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
Haz una copia de `seasonal/summer.csv` en el directorio `backup` (que también está en `/home/repl`),
llamando al nuevo archivo `summer.bck`.

`@hint`
Combina el nombre del directorio de destino y el nombre del archivo copiado
para crear una ruta de acceso relativa para el nuevo archivo.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` no parece existir en el directorio `backup`. Proporciona dos rutas a `cp`: el archivo existente (`seasonal/summer.csv`) y el archivo de destino (`backup/summer.bck`)."),
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
Copia `spring.csv` y `summer.csv` del directorio `seasonal` al directorio `backup`
*sin* cambiar tu directorio de trabajo actual (`/home/repl`).

`@hint`
Utiliza `cp` con los nombres de los archivos que quieres copiar
y *a continuación* el nombre del directorio donde copiarlos.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` no parece haber sido copiado al directorio `backup`. Proporciona dos nombres de archivo y un nombre de directorio a `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="¡Asegúrate de copiar los archivos mientras estás en `{{dir}}`! Usa `cd {{dir}}` para navegar de regreso allí."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Buen trabajo. Además de copiar, también deberíamos poder mover archivos de un directorio a otro. ¡Aprende sobre esto en el siguiente ejercicio!")
```

---

## ¿Cómo puedo mover un archivo?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Mientras que `cp` copia un archivo,
`mv` lo mueve de un directorio a otro,
como si lo hubieras arrastrado en un explorador gráfico de archivos.
Gestiona sus parámetros del mismo modo que `cp`,
por lo que el comando:

```{shell}
mv autumn.csv winter.csv ..
```

mueve los archivos `autumn.csv` y `winter.csv` del directorio de trabajo actual
subir un nivel hasta su directorio principal o parent
(porque `..` siempre se refiere al directorio situado por encima de tu ubicación actual).

`@instructions`
Estás en `/home/repl`, que tiene los subdirectorios `seasonal` y `backup`.
Con un solo comando, mueve `spring.csv` y `summer.csv` de `seasonal` a `backup`.

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
backup_patt="El archivo `%s` no está en el directorio `backup`. ¿Has usado `mv` correctamente? Usa dos nombres de archivo y un directorio como parámetros para `mv`."
seasonal_patt="El archivo `%s` todavía está en el directorio `seasonal`. ¡Asegúrate de mover los archivos con `mv` en lugar de copiarlos con `cp`!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("¡Bien hecho, sigamos con este tren de shell!")
```

---

## ¿Cómo puedo cambiar el nombre de los archivos?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` también se puede utilizar para renombrar archivos. Si ejecutas:

```{shell}
mv course.txt old-course.txt
```

entonces el archivo `course.txt` del directorio de trabajo actual se traslada al archivo `old-course.txt`.
Esto es diferente de cómo funcionan los exploradores de archivos,
pero a menudo es útil.

Una advertencia:
igual que `cp`,
`mv` sobrescribirá los archivos existentes.
Si,
por ejemplo,
ya tienes un archivo llamado `old-course.txt`,
entonces el comando mostrado arriba lo sustituirá por lo que haya en `course.txt`.

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
Entra en el directorio `seasonal`.

`@hint`
Recuerda que `cd` significa "cambiar de directorio" y que las rutas de acceso relativas no empiezan por un "/" inicial.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Si tu directorio de trabajo actual (descúbrelo con `pwd`) es `/home/repl`, puedes moverte a la carpeta `seasonal` con `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: ed5fe1df23
xp: 35
```

`@instructions`
Cambia el nombre del archivo `winter.csv` por `winter.csv.bck`.

`@hint`
Utiliza `mv` con el nombre actual del archivo y el nombre que quieras que tenga en ese orden.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Usa `mv` con dos argumentos: el archivo que quieres renombrar (`winter.csv`) y el nuevo nombre para el archivo (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Esperábamos encontrar `winter.csv.bck` en el directorio." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Ya no esperábamos que `winter.csv` estuviera en el directorio." + hint)
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
Ejecuta `ls` para comprobar que todo haya funcionado.

`@hint`
Recuerda pulsar "intro" o "retorno" para ejecutar el comando.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="¿Has usado `ls` para listar el contenido de tu directorio de trabajo actual?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Tu comando no generó la lista de archivos correcta. Usa `ls` sin argumentos para listar el contenido de tu directorio de trabajo actual.")
    )
)
Ex().success_msg("¡Copiar, mover, renombrar, lo tienes todo resuelto! Lo siguiente: eliminar archivos.")
```

---

## ¿Cómo puedo borrar archivos?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Podemos copiar archivos y moverlos;
para borrarlos,
utilizamos `rm`,
que significa "remove", es decir, "eliminar".
Como con `cp` y `mv`,
puedes dar a `rm` los nombres de tantos archivos como quieras, así:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

elimina tanto `thesis.txt` como `backup/thesis-2017-08.txt`

`rm` hace exactamente lo que dice su nombre, eliminar,
y lo hace de forma definitiva:
a diferencia de los navegadores gráficos de archivos,
el shell no tiene papelera,
de modo que cuando escribas el comando anterior
tu tesis habrá desaparecido para siempre.

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
Estás en `/home/repl`.
Entra en el directorio `seasonal`.

`@hint`
Recuerda que `cd` significa "cambiar de directorio" y que una ruta de acceso relativa no empieza por '/'.

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
Recuerda que `rm` significa "eliminar".

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="No esperábamos que `autumn.csv` todavía estuviera en el directorio `seasonal`. Usa `rm` con la ruta al archivo que deseas eliminar."),
    has_code('rm', incorrect_msg = 'Usa `rm` para eliminar el archivo, en lugar de moverlo.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Vuelve a tu directorio principal.

`@hint`
Si utilizas `cd` sin ninguna ruta, te llevará al principal.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Usa `cd ..` o `cd ~` para volver al directorio principal.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Elimina `seasonal/summer.csv` sin volver a cambiar de directorio.

`@hint`
Recuerda que `rm` significa "eliminar".

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="No esperábamos que `summer.csv` todavía estuviera en el directorio `seasonal`. Usa `rm` con la ruta al archivo que deseas eliminar."),
    has_code('rm', incorrect_msg = 'Usa `rm` para eliminar el archivo, en lugar de moverlo.')
)
Ex().success_msg("¡Impresionante! ¡Vamos al siguiente!")
```

---

## ¿Cómo puedo crear y eliminar directorios?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` trata los directorios de la misma forma que los archivos:
si estás en tu directorio principal y ejecutas `mv seasonal by-season`,
por ejemplo,
`mv` cambia el nombre del directorio `seasonal` a `by-season`.
Sin embargo,
`rm` funciona de forma diferente.

Si intentas `rm` un directorio,
el intérprete de comandos imprime un mensaje de error diciéndote que no puede hacerlo,
principalmente para evitar que borres accidentalmente un directorio entero lleno de trabajo.
En lugar de eso,
puedes utilizar un comando independiente llamado `rmdir`.
Para mayor seguridad,
solo funciona cuando el directorio está vacío,
por lo que debes borrar los archivos de un directorio *antes* de borrar el directorio.
(Los usuarios experimentados pueden utilizar la opción `-r` en `rm` para conseguir el mismo efecto;
hablaremos de las opciones de los comandos en el próximo capítulo).

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
Sin cambiar de directorio,
borra el archivo `agarwal.txt` del directorio `people`.

`@hint`
Recuerda que `rm` significa "remove", es decir,"eliminar" y que una ruta de acceso relativa no empieza por "/".

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` ya no debería estar en `/home/repl/people`. ¿Has usado `rm` correctamente?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'Todavía hay archivos en el directorio `people`. Si simplemente moviste `agarwal.txt`, o creaste nuevos archivos, elimínalos todos.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Ahora que el directorio `people` está vacío,
utiliza un único comando para eliminarlo.

`@hint`
Recuerda que `rm` solo funciona con archivos.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "El directorio 'people' ya no debería estar en tu directorio personal. ¡Usa `rmdir` para eliminarlo!")
)

```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Puesto que un directorio no es un archivo,
debes utilizar el comando `mkdir directory_name`
para crear un nuevo directorio (vacío).
Utiliza este comando para crear un nuevo directorio llamado `yearly` bajo tu directorio principal.

`@hint`
Ejecuta `mkdir` con el nombre del directorio que quieras crear.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="No hay un directorio `yearly` en tu directorio personal. ¡Usa `mkdir yearly` para crear uno!")
)

```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Ahora que `yearly` existe,
crea dentro otro directorio llamado `2017`
*sin* salir de tu directorio principal.

`@hint`
Utiliza una ruta de acceso relativa para el subdirectorio que quieras crear.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="No se puede encontrar un directorio '2017' en '/home/repl/yearly'. Puedes crear este directorio usando la ruta relativa `yearly/2017`.")
)
Ex().success_msg("¡Genial! ¡Terminemos este capítulo con un ejercicio que repite algunos de sus conceptos!")
```

---

## En resumen

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

A menudo crearás archivos intermedios cuando analices datos.
En lugar de almacenarlos en tu directorio principal,
puedes ponerlos en `/tmp`,
que es donde los usuarios y los programas suelen guardar archivos que solo necesitan por poco tiempo.
(Ten en cuenta que `/tmp` está inmediatamente debajo del directorio raíz `/`,
*no* por debajo de tu directorio principal).
Este ejercicio de recapitulación te mostrará cómo hacerlo.

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
Utiliza `cd` para entrar en `/tmp`.

`@hint`
Recuerda que `cd` significa "change directory", es decir, "cambiar de directorio" y que una ruta de acceso absoluta empieza por '/'.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Estás en el directorio incorrecto. Usa `cd` para cambiar al directorio `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Lista el contenido de `/tmp` *sin* escribir el nombre del directorio.

`@hint`
Si no le dices a `ls` qué debe listar, te muestra lo que hay en tu directorio actual.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "No llamaste a `ls` para generar la lista de archivos."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Tu comando no generó la lista de archivos correcta. Usa `ls` sin nada más.")
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
Crea un nuevo directorio dentro de `/tmp` llamado `scratch`.

`@hint`
Utiliza `mkdir` para crear directorios.

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
      has_code('mkdir +scratch', incorrect_msg="No se puede encontrar un directorio 'scratch' bajo '/tmp'. Asegúrate de usar `mkdir` correctamente.")
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
Traslada `/home/repl/people/agarwal.txt` a `/tmp/scratch`.
Te sugerimos que utilices el acceso directo `~` para tu directorio principal y una ruta de acceso relativa para el segundo, en lugar de la ruta de acceso absoluta.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="No se puede encontrar 'agarwal.txt' en '/tmp/scratch'. Usa `mv` con `~/people/agarwal.txt` como el primer parámetro y `scratch` como el segundo.")
)
Ex().success_msg("¡Esto concluye el Capítulo 1 de Introducción a Shell! ¡Apúrate al siguiente capítulo para aprender más sobre cómo manipular datos!")
```

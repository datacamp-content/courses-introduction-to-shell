---
title: Traitement par lots
description: >-
  La plupart des commandes de l'invite peuvent traiter de nombreux fichiers à la
  fois. Ce chapitre vous montre comment faire en sorte que vos propres canaux de
  traitement fassent de même. Au passage, vous verrez comment l'invite utilise
  des variables pour stocker de l'information.
lessons:
  - nb_of_exercises: 10
    title: Comment l'invite stocke-t-elle l'information ?
---

## Comment le shell stocke-t-il l'information?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

Comme d'autres programmes, le shell stocke de l'information dans des variables.
Certaines d'entre elles,
appelées **variables d'environnement**,
sont toujours disponibles.
Par convention, on écrit les noms des variables d'environnement en majuscules,
et quelques-unes des plus courantes sont présentées ci-dessous.

| Variable | Rôle                               | Valeur                |
|----------|------------------------------------|-----------------------|
| `HOME`   | Répertoire personnel de l'utilisateur | `/home/repl`          |
| `PWD `   | Répertoire de travail courant      | Identique à la commande `pwd` |
| `SHELL`  | Programme de shell utilisé         | `/bin/bash`           |
| `USER`   | Identifiant de l'utilisateur       | `repl`                |

Pour obtenir la liste complète (assez longue),
vous pouvez taper `set` dans le shell.

<hr>

Utilisez `set` et `grep` avec un tuyau pour afficher la valeur de `HISTFILESIZE`,
qui détermine combien d'anciennes commandes sont conservées dans votre historique.
Quelle est sa valeur?

`@possible_answers`
- 10
- 500
- [2000]
- La variable n'y est pas.

`@hint`
Utilisez `set | grep HISTFILESIZE` pour obtenir la ligne recherchée.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Non : le shell enregistre plus d'historique que cela."
err2 = "Non : le shell enregistre plus d'historique que cela."
correct3 = "Correct : le shell enregistre 2000 anciennes commandes par défaut sur ce système."
err4 = "Non : la variable `HISTFILESIZE` est présente."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## Comment puis-je afficher la valeur d'une variable?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

Une façon plus simple d'obtenir la valeur d'une variable est d'utiliser la commande `echo`, qui affiche ses arguments. En tapant

```{shell}
echo hello DataCamp!
```

vous obtenez

```
hello DataCamp!
```

Si vous essayez de l'utiliser pour afficher la valeur d'une variable comme ceci :

```{shell}
echo USER
```

cela affichera le nom de la variable, `USER`.

Pour obtenir la valeur de la variable, vous devez placer un signe dollar `$` devant son nom. En tapant 

```{shell}
echo $USER
```

vous obtenez

```
repl
```

C'est vrai partout :
pour obtenir la valeur d'une variable appelée `X`,
vous devez écrire `$X`.
(C'est ainsi que le shell peut faire la différence entre « un fichier nommé X » et « la valeur d'une variable nommée X ».)

`@instructions`
La variable `OSTYPE` contient le nom du type de système d'exploitation que vous utilisez.
Affichez sa valeur avec `echo`.

`@hint`
Appelez `echo` avec la variable `OSTYPE` précédée de `$`.

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
            has_code('echo', incorrect_msg="Avez-vous appelé `echo` ?"),
            has_code('OSTYPE', incorrect_msg="Avez-vous imprimé la variable d'environnement `OSTYPE` ?"),
            has_code(r'\$OSTYPE', incorrect_msg="Assurez-vous de faire précéder `OSTYPE` par un `$`.")
        )
    )
)
Ex().success_msg("Excellente gestion de l'écho des variables d'environnement ! Vous êtes bien parti. Continuons !")
```

---

## Quelles autres façons la coquille enregistre-t-elle l'information?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

L'autre type de variable s'appelle une **variable de coquille** (shell),
qui ressemble à une variable locale dans un langage de programmation.

Pour créer une variable de coquille,
il suffit d'assigner une valeur à un nom :

```{shell}
training=seasonal/summer.csv
```

sans aucun espace avant ou après le signe `=`.
Une fois que c'est fait,
vous pouvez vérifier la valeur de la variable avec :

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
Définissez une variable appelée `testing` avec la valeur `seasonal/winter.csv`.

`@hint`
Il ne doit PAS y avoir d'espaces entre le nom de la variable et sa valeur.

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
        has_code('testing', incorrect_msg='Avez-vous défini une variable shell nommée `testing` ?'),
        has_code('testing=', incorrect_msg='Avez-vous écrit `=` directement après testing, sans espaces ?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='Avez-vous défini la valeur de `testing` à `seasonal/winter.csv` ?')
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
Utilisez `head -n 1 QUELQUECHOSE` pour obtenir la première ligne de `seasonal/winter.csv`
en utilisant la valeur de la variable `testing` plutôt que le nom du fichier.

`@hint`
N'oubliez pas d'utiliser `$testing` plutôt que seulement `testing`
(le `$` est nécessaire pour obtenir la valeur de la variable).

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
    has_code(r'\$testing', incorrect_msg="Avez-vous référencé la variable shell en utilisant `$testing` ?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="Avez-vous appelé `head` ?"),
            has_code('-n', incorrect_msg="Avez-vous limité le nombre de lignes avec `-n` ?"),
            has_code(r'-n\s+1', incorrect_msg="Avez-vous choisi de garder 1 ligne avec `-n 1` ?")     
        )
    )
)
Ex().success_msg("Stellaire ! Voyons comment vous pouvez répéter les commandes facilement.")
```

---

## Comment puis-je répéter une commande plusieurs fois?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Les variables du shell sont aussi utilisées dans des **boucles**,
qui répètent une commande plusieurs fois.
Si nous exécutons cette commande :

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

elle produit :

```
gif
jpg
png
```

Remarquez ces éléments à propos de la boucle :

1. La structure est `for` ...variable... `in` ...liste... `; do` ...corps... `; done`
2. La liste des éléments que la boucle doit traiter (dans notre cas, les mots `gif`, `jpg` et `png`).
3. La variable qui garde la trace de l'élément que la boucle est en train de traiter (dans notre cas, `filetype`).
4. Le corps de la boucle qui effectue le traitement (dans notre cas, `echo $filetype`).

Notez que le corps utilise `$filetype` pour obtenir la valeur de la variable plutôt que simplement `filetype`,
comme pour toute autre variable du shell.
Notez aussi où vont les points-virgules :
le premier se place entre la liste et le mot-clé `do`,
et le deuxième entre le corps et le mot-clé `done`.

`@instructions`
Modifiez la boucle pour qu'elle affiche :

```
docx
odt
pdf
```

Veuillez utiliser `filetype` comme nom de variable de boucle.

`@hint`
Utilisez la structure de code présentée dans le texte d'introduction, en remplaçant les types de fichiers image par des types de fichiers document.

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
      has_code('for', incorrect_msg='Avez-vous appelé `for`?'),
      has_code('filetype', incorrect_msg='Avez-vous utilisé `filetype` comme variable de boucle?'),
      has_code('in', incorrect_msg='Avez-vous utilisé `in` avant la liste des types de fichiers?'),
      has_code('docx odt pdf', incorrect_msg='Avez-vous bouclé sur `docx`, `odt` et `pdf` dans cet ordre?'),
      has_code(r'pdf\s*;', incorrect_msg='Avez-vous mis un point-virgule après le dernier élément de la boucle?'),
      has_code(r';\s*do', incorrect_msg='Avez-vous utilisé `do` après le premier point-virgule?'),
      has_code('echo', incorrect_msg='Avez-vous appelé `echo`?'),
      has_code(r'\$filetype', incorrect_msg='Avez-vous fait écho de `$filetype`?'),
      has_code(r'filetype\s*;', incorrect_msg='Avez-vous mis un point-virgule après le corps de la boucle?'),
      has_code('; done', incorrect_msg='Avez-vous terminé avec `done`?')
    )
  )
)
Ex().success_msg("Excellent pour les boucles! Les boucles sont brillantes si vous voulez faire la même chose des centaines ou des milliers de fois.")
```

---

## Comment puis-je répéter une commande une fois par fichier?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

Vous pouvez toujours taper les noms des fichiers à traiter au moment d'écrire la boucle,
mais il est généralement préférable d'utiliser des caractères génériques.
Essayez d'exécuter cette boucle dans la console :

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

Elle affiche :

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

parce que l'interpréteur développe `seasonal/*.csv` en une liste de quatre noms de fichiers
avant d'exécuter la boucle.

`@instructions`
Modifiez l'expression avec caractères génériques pour `people/*`
afin que la boucle affiche les noms des fichiers dans le répertoire `people`,
peu importe le suffixe qu'ils ont ou n'ont pas.
Veuillez utiliser `filename` comme nom de votre variable de boucle.

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
      has_code('for', incorrect_msg='Avez-vous appelé `for`?'),
      has_code('filename', incorrect_msg='Avez-vous utilisé `filename` comme variable de boucle?'),
      has_code('in', incorrect_msg='Avez-vous utilisé `in` avant la liste des types de fichiers?'),
      has_code('people/\*', incorrect_msg='Avez-vous spécifié une liste de fichiers avec `people/*`?'),
      has_code(r'people/\*\s*;', incorrect_msg='Avez-vous mis un point-virgule après la liste des fichiers?'),
      has_code(r';\s*do', incorrect_msg='Avez-vous utilisé `do` après le premier point-virgule?'),
      has_code('echo', incorrect_msg='Avez-vous appelé `echo`?'),
      has_code(r'\$filename', incorrect_msg='Avez-vous fait écho à `$filename`?'),
      has_code(r'filename\s*;', incorrect_msg='Avez-vous mis un point-virgule après le corps de la boucle?'),
      has_code('; done', incorrect_msg='Avez-vous terminé avec `done`?')
    )
  )
)
Ex().success_msg("Bouclage en boucle! Les jokers et les boucles forment une combinaison puissante.")
```

---

## Comment puis-je enregistrer les noms d'un ensemble de fichiers ?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

Les gens définissent souvent une variable à l'aide d'un caractère générique pour enregistrer une liste de noms de fichiers.
Par exemple,
si vous définissez `datasets` comme ceci :

```{shell}
datasets=seasonal/*.csv
```

vous pouvez afficher les noms des fichiers plus tard avec :

```{shell}
for filename in $datasets; do echo $filename; done
```

Cela vous évite de retaper et réduit les risques d'erreur.

<hr>

Si vous exécutez ces deux commandes dans votre répertoire personnel,
combien de lignes de sortie vont-elles afficher ?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- Aucune : comme `files` est défini sur une ligne distincte, il n'a aucune valeur dans la deuxième ligne.
- Une : le mot « files ».
- Quatre : les noms des quatre fichiers de données saisonnières.

`@hint`
Rappelez-vous que `X` tout seul est simplement « X », tandis que `$X` correspond à la valeur de la variable `X`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Non : vous n'avez pas à définir une variable sur la même ligne que vous l'utilisez."
err2 = "Non : cet exemple définit et utilise la variable `files` dans le même shell."
correct3 = "Correct. La commande est équivalente à `for f in seasonal/*.csv; do echo $f; done`."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## Nom d'une variable versus sa valeur

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

Une erreur fréquente est d'oublier de mettre `$` avant le nom d'une variable.
Quand cela arrive,
le shell utilise le nom que vous avez tapé
plutôt que la valeur de cette variable.

Une autre erreur courante chez les personnes expérimentées est de mal taper le nom de la variable.
Par exemple,
si vous définissez `datasets` ainsi :

```{shell}
datasets=seasonal/*.csv
```

et que vous tapez ensuite :

```{shell}
echo $datsets
```

le shell n'affiche rien,
car `datsets` (sans le deuxième « a ») n'est pas défini.

<hr>

Si vous exécutiez ces deux commandes dans votre répertoire personnel,
quelle sortie serait affichée ?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(Lisez attentivement la première partie de la boucle avant de répondre.)

`@hint`
Rappelez-vous que `X` tout seul est simplement « X », tandis que `$X` est la valeur de la variable `X`.

`@possible_answers`
- [Une ligne : le mot « files ».]
- Quatre lignes : les noms des quatre fichiers de données saisonnières.
- Quatre lignes vides : la variable `f` ne reçoit aucune valeur.

`@feedback`
- Exact : la boucle utilise `files` plutôt que `$files`, donc la liste contient le mot « files ».
- Non : la boucle utilise `files` plutôt que `$files`, donc la liste contient le mot « files » plutôt que le développement de `files`.
- Non : la variable `f` est définie automatiquement par la boucle `for`.

---

## Comment exécuter plusieurs commandes dans une seule boucle?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

Afficher les noms de fichiers est utile pour le débogage,
mais l'objectif réel des boucles est d'agir sur plusieurs fichiers.
Cette boucle affiche la deuxième ligne de chaque fichier de données :

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

Elle a la même structure que les autres boucles que vous avez déjà vues :
la seule différence est que son corps est un enchaînement (pipeline) de deux commandes plutôt qu'une seule.

`@instructions`
Écrivez une boucle qui affiche la dernière entrée de juillet 2017 (`2017-07`) dans chaque fichier seasonal. Elle devrait produire un résultat similaire à :

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

mais pour **_chaque_** fichier seasonal séparément. Veuillez utiliser `file` comme nom de variable de boucle, et n'oubliez pas d'itérer sur la liste de fichiers `seasonal/*.csv` (_plutôt que « seasonal/winter.csv » comme dans l'exemple_).

`@hint`
Le corps de la boucle est la commande grep indiquée dans les instructions, avec `seasonal/winter.csv` remplacé par `$file`.

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
  has_code('for', incorrect_msg='Avez-vous appelé `for`?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='Avez-vous utilisé `file` comme variable de boucle?'),
      has_code('in', incorrect_msg='Avez-vous utilisé `in` avant la liste des fichiers?'),
      has_code('seasonal/\*', incorrect_msg='Avez-vous spécifié une liste de fichiers avec `seasonal/*`?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='Avez-vous mis un point-virgule après la liste des fichiers?'),
      has_code(r';\s*do', incorrect_msg='Avez-vous utilisé `do` après le premier point-virgule?'),
      has_code('grep', incorrect_msg='Avez-vous appelé `grep`?'),
      has_code('2017-07', incorrect_msg='Avez-vous fait correspondre `2017-07`?'),
      has_code(r'\$file', incorrect_msg='Avez-vous utilisé `$file` comme nom de la variable de boucle?'),
      has_code(r'file\s*|', incorrect_msg='Avez-vous utilisé un pipe pour connecter votre deuxième commande?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='Avez-vous utilisé `tail -n 1` pour imprimer la dernière entrée de chaque recherche dans votre deuxième commande?'),
      has_code('; done', incorrect_msg='Avez-vous terminé avec `done`?')
    )
  )
)

Ex().success_msg("Bouclage en boucle! Les jokers et les boucles forment une combinaison puissante.")
```

---

## Pourquoi devrais-je éviter les espaces dans les noms de fichiers?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

Il est facile et logique de donner aux fichiers des noms à plusieurs mots comme `July 2017.csv`
quand vous utilisez un explorateur de fichiers graphique.
Cependant,
ça pose des problèmes lorsque vous travaillez dans l'interpréteur de commandes (shell).
Par exemple,
supposons que vous vouliez renommer `July 2017.csv` pour `2017 July data.csv`.
Vous ne pouvez pas taper :

```{shell}
mv July 2017.csv 2017 July data.csv
```

parce que le shell pensera que vous essayez de déplacer
quatre fichiers nommés `July`, `2017.csv`, `2017` et de nouveau `July`
dans un répertoire appelé `data.csv`.
À la place,
il faut mettre des guillemets autour des noms de fichiers
pour que le shell traite chacun comme un seul paramètre :

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

Si vous avez deux fichiers appelés `current.csv` et `last year.csv`
(avec un espace dans son nom)
et que vous tapez :

```{shell}
rm current.csv last year.csv
```

que va-t-il se passer :

`@hint`
Qu'est-ce que vous penseriez qu'il va se passer si quelqu'un vous montrait cette commande sans que vous sachiez quels fichiers existent?

`@possible_answers`
- Le shell affichera un message d'erreur parce que `last` et `year.csv` n'existent pas.
- Le shell supprimera `current.csv`.
- [Les deux ci-dessus.]
- Rien.

`@feedback`
- Oui, mais ce n'est pas tout.
- Oui, mais ce n'est pas tout.
- Correct. Vous pouvez entourer les noms de fichiers de guillemets simples, `'`, ou de guillemets doubles, `"`.
- Malheureusement non.

---

## Comment puis-je faire plusieurs choses dans une seule boucle?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

Les boucles que vous avez vues jusqu'ici n'ont qu'une seule commande ou qu'un seul tuyau (pipeline) dans leur corps,
mais une boucle peut contenir autant de commandes que nécessaire.
Pour indiquer au shell où une commande se termine et où la suivante commence,
vous devez les séparer par des points-virgules :

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

Supposons que vous oubliiez le point-virgule entre les commandes `echo` et `head` dans la boucle précédente,
et que vous demandiez donc au shell d'exécuter :

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

Que fera le shell?

`@possible_answers`
- Afficher un message d'erreur.
- Afficher une ligne pour chacun des quatre fichiers.
- Afficher une ligne pour `autumn.csv` (le premier fichier).
- Afficher la dernière ligne de chaque fichier.

`@hint`
Vous pouvez acheminer (pipe) la sortie de `echo` vers `tail`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "Non : la boucle s'exécutera, elle ne fera simplement pas quelque chose de sensé."
correct2 = "Oui : `echo` produit une ligne qui inclut le nom de fichier deux fois, que `tail` copie ensuite."
err3 = "Non : la boucle s'exécute une fois pour chacun des quatre noms de fichiers."
err4 = "Non : l'entrée de `tail` est la sortie de `echo` pour chaque nom de fichier."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

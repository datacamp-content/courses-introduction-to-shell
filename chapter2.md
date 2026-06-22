---
title: Manipuler des données
description: >-
  Les commandes vues au chapitre précédent vous permettaient de déplacer des
  éléments dans le système de fichiers. Ce chapitre vous montrera comment
  travailler avec les données contenues dans ces fichiers. Les outils que nous
  utiliserons sont assez simples, mais constituent des bases solides.
lessons:
  - nb_of_exercises: 12
    title: Comment afficher le contenu d'un fichier ?
---

## Comment puis-je afficher le contenu d'un fichier ?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Avant de renommer ou de supprimer des fichiers,
vous voudrez peut-être jeter un coup d'œil à leur contenu.
La façon la plus simple de le faire est d'utiliser `cat`,
qui affiche simplement le contenu des fichiers à l'écran.
(Son nom est l'abréviation de « concatenate », qui signifie « lier des éléments ensemble »,
car il affichera tous les fichiers dont vous fournissez le nom, l'un après l'autre.)

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
Affichez le contenu de `course.txt` à l'écran.

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
    has_expr_output(incorrect_msg="Votre commande n'a pas généré la bonne sortie. Avez-vous utilisé `cat` suivi du nom du fichier, `course.txt` ?")
)
Ex().success_msg("Bien ! Examinons d'autres façons de voir le contenu d'un fichier.")
```

---

## Comment puis-je afficher le contenu d'un fichier petit à petit?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Vous pouvez utiliser `cat` pour imprimer de gros fichiers puis faire défiler le **Résultat**,
mais il est généralement plus pratique de **feuilleter** l'affichage.
La première commande pour faire cela s'appelait `more`,
mais elle a été remplacée par une commande plus puissante appelée `less`.
(Ce genre de nommage tient lieu d'humour dans l'univers Unix.)
Quand vous lancez `less` sur un fichier,
une page s'affiche à la fois;
vous pouvez appuyer sur la barre d'espace pour descendre d'une page ou taper `q` pour quitter.

Si vous fournissez à `less` le nom de plusieurs fichiers,
vous pouvez taper `:n` (deux-points suivi d'un « n » minuscule) pour passer au fichier suivant,
`:p` pour revenir au précédent,
ou `:q` pour quitter.

Remarque : si vous affichez les solutions des exercices qui utilisent `less`,
vous verrez une commande supplémentaire à la fin qui désactive la pagination
afin que nous puissions évaluer vos solutions efficacement.

`@instructions`
Utilisez `less seasonal/spring.csv seasonal/summer.csv` pour afficher ces deux fichiers dans cet ordre.
Appuyez sur la barre d'espace pour descendre d'une page, `:n` pour passer au deuxième fichier et `:q` pour quitter.

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
                 incorrect_msg='Utilisez `less` et les noms de fichiers. N\'oubliez pas que `:n` vous déplace vers le fichier suivant.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Comment puis-je voir le début d'un fichier?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

La première chose que la plupart des scientifiques des données font lorsqu'on leur confie un nouveau jeu de données à analyser, c'est de déterminer quels champs il contient et quelles valeurs s'y trouvent.
Si le jeu de données a été exporté d'une base de données ou d'un tableur,
il sera souvent enregistré en **valeurs séparées par des virgules** (CSV).
Une façon rapide de comprendre ce qu'il contient est de regarder les premières lignes.

Nous pouvons le faire dans le shell avec une commande appelée `head`.
Comme son nom l'indique,
elle affiche les premières lignes d'un fichier
(où « quelques » signifie 10),
donc la commande :

```{shell}
head seasonal/summer.csv
```

affiche :

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

Que fait `head` s'il n'y a pas 10 lignes dans le fichier?
(Pour le savoir, utilisez-la pour voir le début de `people/agarwal.txt`.)

`@possible_answers`
- Afficher un message d'erreur parce que le fichier est trop court.
- Afficher autant de lignes qu'il y en a.
- Afficher suffisamment de lignes vides pour en avoir 10 au total.

`@hint`
Quelle serait la fonctionnalité la plus utile qu'il pourrait offrir?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Incorrect : ce n'est pas la chose la plus utile qu'il pourrait faire.",
                    "Correct !",
                    "Incorrect : cela serait impossible à distinguer d'un fichier qui se termine par un tas de lignes vides."])
```

---

## Comment puis-je taper moins?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

L'un des outils puissants de l'interpréteur de commandes est la **complétion par la touche de tabulation**.
Si vous commencez à taper le nom d'un fichier puis appuyez sur la touche Tab,
le shell tentera d'auto-compléter le chemin.
Par exemple,
si vous tapez `sea` et appuyez sur Tab,
il complétera le nom du répertoire par `seasonal/` (avec une barre oblique à la fin).
Si vous tapez ensuite `a` puis Tab,
il complétera le chemin en `seasonal/autumn.csv`.

Si le chemin est ambigu,
comme `seasonal/s`,
appuyer une deuxième fois sur Tab affichera une liste de possibilités.
Tapez un ou deux caractères de plus pour préciser votre chemin,
puis appuyez sur Tab :
le reste du nom sera complété.

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
Exécutez `head seasonal/autumn.csv` sans taper le nom de fichier au complet.

`@hint`
Tapez la portion nécessaire du chemin, puis appuyez sur Tab, et répétez au besoin.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Le vérificateur n'a pas pu trouver la bonne sortie dans votre commande. Êtes-vous sûr d'avoir appelé `head` sur `seasonal/autumn.csv` ?")
)

```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Exécutez `head seasonal/spring.csv` sans taper le nom de fichier au complet.

`@hint`
Tapez la portion nécessaire du chemin, puis appuyez sur Tab, et répétez au besoin.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Le vérificateur n'a pas pu trouver la bonne sortie dans votre commande. Êtes-vous sûr d'avoir appelé `head` sur `seasonal/spring.csv` ?")
)
Ex().success_msg("Bon travail ! Une fois que vous vous habituerez à utiliser la complétion par tabulation, cela vous fera gagner beaucoup de temps !")
```

---

## Comment puis-je contrôler ce que font les commandes ?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Vous ne voudrez pas toujours afficher les 10 premières lignes d'un fichier,
alors l'interpréteur de commandes vous permet de modifier le comportement de `head`
en lui donnant un **paramètre en ligne de commande** (ou simplement « paramètre »).
Si vous exécutez la commande :

```{shell}
head -n 3 seasonal/summer.csv
```

`head` n'affichera que les trois premières lignes du fichier.
Si vous exécutez `head -n 100`,
il affichera les 100 premières (en supposant qu'il y en ait autant),
et ainsi de suite.

Le nom d'un paramètre indique généralement son rôle
(par exemple, `-n` sert à préciser le « **n**ombre de lignes »).
Les paramètres de commande ne sont pas obligatoirement un `-` suivi d'une seule lettre,
mais c'est une convention très répandue.

Remarque : il est considéré de bonne pratique de placer tous les paramètres *avant* tout nom de fichier ;
dans ce cours,
nous n'acceptons que les réponses qui respectent cette règle.

`@instructions`
Affichez les 5 premières lignes de `winter.csv` dans le répertoire `seasonal`.

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
        has_expr_output(incorrect_msg="Êtes-vous sûr d'appeler `head` sur le fichier `seasonal/winter.csv` ?"),
        has_expr_output(strict=True, incorrect_msg="Êtes-vous sûr d'avoir utilisé le drapeau `-n 5` ?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Êtes-vous sûr d'avoir utilisé le drapeau `-n 5` ?")
)
Ex().success_msg("Bien ! Avec cette technique, vous pouvez éviter que votre shell ne plante si vous souhaitez jeter un œil à de plus gros fichiers texte.")
```

---

## Comment puis-je lister tout ce qu'un répertoire contient, y compris ses sous-répertoires?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Pour voir tout ce qu'un répertoire contient,
peu importe la profondeur d'imbrication,
vous pouvez donner à `ls` l'option `-R`
(qui signifie « récursif »).
Si vous utilisez `ls -R` dans votre répertoire personnel,
vous verrez quelque chose comme ceci :

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Cela affiche tous les fichiers et répertoires au niveau actuel,
puis tout ce qui se trouve dans chaque sous-répertoire,
et ainsi de suite.

`@instructions`
Pour vous aider à distinguer les éléments,
`ls` a une autre option `-F` qui affiche un `/` après le nom de chaque répertoire
et un `*` après le nom de chaque programme exécutable.
Exécutez `ls` avec les deux options, `-R` et `-F`, et le chemin absolu vers votre répertoire personnel
pour voir tout ce qu'il contient.
(L'ordre des options n'a pas d'importance, mais le nom du répertoire doit venir en dernier.)

`@hint`
Votre répertoire personnel peut être indiqué avec `~`, `.` ou avec son chemin absolu.

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
  has_expr_output(incorrect_msg='Utilisez soit `ls -R -F` soit `ls -F -R` et le chemin `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Utilisez soit `ls -R -F` soit `ls -F -R` et le chemin `/home/repl`.')
)
Ex().success_msg("C'est un aperçu assez soigné, n'est-ce pas ?")
```

---

## Comment obtenir de l'aide pour une commande ?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Pour savoir ce que font les commandes, on utilisait la commande `man` (abréviation de « manual »). Par exemple, la commande `man head` affiche les informations suivantes :

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

`man` lance automatiquement `less`, donc vous devrez peut‑être appuyer sur la barre d'espace pour faire défiler l'information et sur `:q` pour quitter.

La description d'une ligne sous `NAME` vous indique brièvement ce que fait la commande, et le résumé sous `SYNOPSIS` énumère tous les indicateurs (flags) pris en charge. Tout ce qui est facultatif est indiqué entre crochets `[...]`, les alternatives exclusives sont séparées par `|`, et ce qui peut être répété est indiqué par `...`. Ainsi, la page de manuel de `head` vous indique que vous pouvez soit donner un nombre de lignes avec `-n`, soit un nombre d'octets avec `-c`, et que vous pouvez lui fournir n'importe quel nombre de noms de fichiers.

Le problème avec le manuel Unix, c'est qu'il faut savoir ce que vous cherchez. Si ce n'est pas le cas, vous pouvez chercher sur [Stack Overflow](https://stackoverflow.com/), poser une question sur les canaux Slack de DataCamp, ou consulter les sections `SEE ALSO` des commandes que vous connaissez déjà.

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
Lisez la page de manuel de la commande `tail` pour découvrir ce que fait le fait de mettre un signe `+` devant le nombre utilisé avec l'indicateur `-n`. (N'oubliez pas d'appuyer sur la barre d'espace pour descendre et/ou de taper `q` pour quitter.)

`@hint`
Rappelez‑vous : `man` est l'abréviation de « manual ».

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Utilisez `man` et le nom de la commande.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Utilisez `tail` avec l'indicateur `-n +7` pour afficher toutes les lignes sauf les six premières de `seasonal/spring.csv`.

`@hint`
Utilisez un signe plus « + » devant le nombre de lignes que vous voulez afficher.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Appelez-vous `tail` sur `seasonal/spring.csv` ?"),
    has_expr_output(strict=True, incorrect_msg="Êtes-vous sûr d'avoir utilisé le drapeau `-n +7` ?")
)
```

---

## Comment puis-je sélectionner des colonnes dans un fichier ?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` et `tail` vous permettent de sélectionner des lignes dans un fichier texte.
Si vous voulez sélectionner des colonnes,
vous pouvez utiliser la commande `cut`.
Elle offre plusieurs options (utilisez `man cut` pour les explorer),
mais la plus courante ressemble à ceci :

```{shell}
cut -f 2-5,8 -d , values.csv
```

ce qui signifie :
« sélectionner les colonnes 2 à 5 ainsi que la colonne 8,
en utilisant la virgule comme séparateur ».
`cut` utilise `-f` (pour « fields », c'est-à-dire les champs) pour préciser les colonnes
et `-d` (pour « delimiter », c'est-à-dire le délimiteur) pour préciser le séparateur.
Vous devez préciser ce dernier, car certains fichiers peuvent utiliser des espaces, des tabulations ou des deux-points pour séparer les colonnes.

<hr>

Quelle commande sélectionnera la première colonne (qui contient les dates) du fichier `spring.csv` ?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- L'une ou l'autre des deux ci-dessus.
- Aucune des deux ci-dessus, car `-f` doit venir avant `-d`.

`@hint`
L'ordre des indicateurs (flags) n'a pas d'importance.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Oui, mais ce n\'est pas tout', 'Oui, mais ce n\'est pas tout', 'Correct ! Ajouter un espace après le drapeau est une bonne pratique, mais pas obligatoire.', 'Non, l\'ordre des drapeaux n\'a pas d\'importance'])
```

---

## Que ne peut pas faire cut?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` est une commande assez limitée.
Notamment,
elle ne comprend pas les chaînes entre guillemets.
Si, par exemple, votre fichier contient :

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

alors :

```{shell}
cut -f 2 -d , everyone.csv
```

produira :

```
Age
Ranjit"
Rupinder"
```

plutôt que l'âge de tout le monde,
car `cut` considérera la virgule entre le nom de famille et le prénom comme un séparateur de colonnes.

<hr>

Quelle est la sortie de `cut -d : -f 2-4` pour la ligne :

```
first:second:third:
```

(Remarquez les deux-points à la fin.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Aucune de ces réponses, car il n'y a pas quatre champs.

`@hint`
Portez attention aux deux-points à la fin.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Non, il y a plus.', 'Non, il y a plus.', 'Correct! Les deux-points à la fin créent un quatrième champ vide.', 'Non, `cut` fait de son mieux.'])
```

---

## Comment puis-je répéter des commandes?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

L'un des plus grands avantages de la ligne de commande, c'est qu'elle vous permet de refaire facilement les mêmes actions.
Si vous exécutez des commandes, vous pouvez ensuite appuyer sur la flèche vers le haut pour revenir en arrière dans l'historique.
Vous pouvez aussi utiliser les flèches gauche et droite ainsi que la touche d'effacement pour les modifier.
Appuyer sur Entrée exécutera alors la commande modifiée.

Encore mieux, `history` affiche la liste des commandes que vous avez exécutées récemment.
Chacune est précédée d'un numéro séquentiel pour faciliter leur réexécution :
il suffit de taper `!55` pour relancer la 55e commande de votre historique (si vous en avez autant).
Vous pouvez aussi relancer une commande en tapant un point d'exclamation suivi du nom de la commande,
par exemple `!head` ou `!cut`,
ce qui réexécutera l'utilisation la plus récente de cette commande.

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
Exécutez `head summer.csv` dans votre répertoire personnel (ce qui devrait échouer).

`@hint`
La complétion avec Tab ne fonctionne pas s'il n'y a aucun nom de fichier correspondant.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Utilisez `head` et un nom de fichier, `summer.csv`. Ne vous inquiétez pas si cela échoue. Cela devrait être le cas.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Changez de répertoire pour `seasonal`.

`@hint`
N'oubliez pas que `cd` signifie « changer de répertoire ».

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Si votre répertoire de travail actuel (vérifiez avec `pwd`) est `/home/repl`, vous pouvez accéder au dossier `seasonal` avec `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Relancez la commande `head` avec `!head`.

`@hint`
Ne tapez aucun espace entre `!` et ce qui suit.

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
                        incorrect_msg='Utilisez `!head` pour répéter la commande `head`.'),
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
Utilisez `history` pour voir ce que vous avez fait.

`@hint`
Remarquez que `history` affiche d'abord les plus anciennes commandes et les plus récentes à la fin, de sorte qu'elles restent à l'écran quand l'exécution se termine.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Utilisez `history` sans indicateurs pour obtenir une liste des commandes précédentes.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Relancez `head` de nouveau en utilisant `!` suivi d'un numéro de commande.

`@hint`
Ne tapez surtout pas d'espace entre `!` et ce qui suit.

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
                        incorrect_msg='Avez-vous utilisé `!<un_nombre>` pour relancer le dernier `head` de l\'historique ?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Bien joué ! Passons au suivant !")
```

---

## Comment puis-je sélectionner les lignes qui contiennent des valeurs précises?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` et `tail` sélectionnent des rangées,
`cut` sélectionne des colonnes,
et `grep` sélectionne des lignes selon leur contenu.
Dans sa forme la plus simple,
`grep` reçoit un bout de texte suivi d'un ou de plusieurs noms de fichiers
et affiche toutes les lignes de ces fichiers qui contiennent ce texte.
Par exemple,
`grep bicuspid seasonal/winter.csv`
affiche les lignes de `winter.csv` qui contiennent « bicuspid ».

`grep` peut aussi chercher des motifs ;
nous verrons cela dans le prochain cours.
Ce qui est plus important pour le moment, ce sont quelques options courantes de `grep` :

- `-c` : affiche le nombre de lignes correspondantes plutôt que les lignes elles-mêmes
- `-h` : n'affiche PAS les noms des fichiers lors de la recherche dans plusieurs fichiers
- `-i` : ignore la casse (p. ex., considère « Regression » et « regression » comme des correspondances)
- `-l` : affiche les noms des fichiers qui contiennent des correspondances, pas les correspondances elles-mêmes
- `-n` : affiche les numéros de ligne pour les lignes correspondantes
- `-v` : inverse la correspondance, c.-à-d. affiche seulement les lignes qui NE correspondent PAS

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
Affichez le contenu de toutes les lignes contenant le mot `molar` dans `seasonal/autumn.csv`
en exécutant une seule commande à partir de votre répertoire personnel. N'utilisez aucune option.

`@hint`
Utilisez `grep` avec le mot que vous cherchez et le nom du ou des fichiers dans lesquels chercher.

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
      has_code("grep", incorrect_msg = "Avez-vous appelé `grep` ?"),
      has_code("molar", incorrect_msg = "Avez-vous recherché `molar` ?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Avez-vous recherché le fichier `seasonal/autumn.csv` ?")
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
Inversez la correspondance pour trouver toutes les lignes qui ne contiennent PAS le mot `molar` dans `seasonal/spring.csv`, et affichez leurs numéros de ligne.
Rappelez-vous : c'est une bonne pratique de placer toutes les options avant les autres valeurs comme les noms de fichiers ou le terme de recherche « molar ».

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
      has_code("grep", incorrect_msg = "Avez-vous appelé `grep` ?"),
      has_code("-v", incorrect_msg = "Avez-vous inversé la correspondance avec `-v` ?"),
      has_code("-n", incorrect_msg = "Avez-vous affiché les numéros de ligne avec `-n` ?"),
      has_code("molar", incorrect_msg = "Avez-vous recherché `molar` ?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Avez-vous recherché dans le fichier `seasonal/spring.csv` ?")
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
Comptez combien de lignes contiennent le mot `incisor` dans `autumn.csv` et `winter.csv` combinés.
(Encore une fois, exécutez une seule commande à partir de votre répertoire personnel.)

`@hint`
N'oubliez pas d'utiliser `-c` avec `grep` pour compter les lignes.

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
      has_code("grep", incorrect_msg = "Avez-vous appelé `grep` ?"),
      has_code("-c", incorrect_msg = "Avez-vous obtenu des comptes avec `-c` ?"),
      has_code("incisor", incorrect_msg = "Avez-vous recherché `incisor` ?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Avez-vous recherché le fichier `seasonal/autumn.csv` ?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Avez-vous recherché le fichier `seasonal/winter.csv` ?")
    )
  )
)

```

---

## Pourquoi n'est-il pas toujours sécuritaire de traiter les données comme du texte?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

La section `SEE ALSO` de la page de manuel de `cut` renvoie à une commande appelée `paste`,
qui peut servir à combiner des fichiers de données au lieu de les découper.

<hr>

Consultez la page de manuel de `paste`,
puis exécutez `paste` pour combiner les fichiers de données d'automne et d'hiver dans un seul tableau
en utilisant la virgule comme séparateur.
Qu'est-ce qui cloche dans la sortie du point de vue de l'analyse de données?

`@possible_answers`
- Les en-têtes de colonnes sont répétés.
- Les dernières lignes n'ont pas le bon nombre de colonnes.
- Certaines données de `winter.csv` sont manquantes.

`@hint`
Si vous appliquez `cut` à la sortie de `paste` en utilisant des virgules comme séparateur,
est-ce que cela donnerait la bonne réponse?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Vrai, mais ce n\'est pas nécessairement une erreur.'
correct2 = 'Correct : joindre les lignes avec des colonnes crée seulement une colonne vide au début, pas deux.'
err3 = 'Non, toutes les données hivernales sont présentes.'
Ex().has_chosen(2, [err1, correct2, err3])
```

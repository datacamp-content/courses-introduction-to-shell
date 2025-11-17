---
title: Manipulation des données
description: >-
  Les commandes que vous avez vues dans le chapitre précédent vous permettent de
  déplacer des éléments dans le système de fichiers. Ce chapitre vous montrera
  comment utiliser les données contenues dans ces fichiers. Les outils que nous
  utiliserons sont relativement simples, mais constituent des éléments de base
  robustes.
lessons:
  - nb_of_exercises: 12
    title: "Comment afficher le contenu d’un fichier\_?"
---

## Comment afficher le contenu d’un fichier ?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Avant de renommer ou de supprimer des fichiers,
vous pouvez consulter leur contenu.
La manière la plus simple d’y parvenir est d’utiliser la commande `cat`,
qui se contente d’afficher le contenu des fichiers à l’écran.
(Son nom est l’abréviation de concaténer, qui signifie « relier des éléments entre eux »,
car elle affichera tous les fichiers dont vous lui donnez le nom, l’un après l’autre.)

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
Affichez le contenu de `course.txt` à l’écran.

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
Ex().success_msg("Bien ! Voyons d'autres façons de voir le contenu d'un fichier.")
```

---

## Comment visualiser le contenu d’un fichier morceau par morceau ?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Vous pouvez utiliser `cat` pour afficher des fichiers volumineux, puis faire défiler les résultats,
mais il est généralement plus pratique de **paginer** la sortie.
La commande d’origine pour ce faire était `more`,
mais elle a été remplacée par une commande plus puissante appelée `less`.
(Ce type de dénomination montre le sens de l’humour présent dans le monde Unix).
Lorsque vous appliquez `less` à un fichier,
une page est affichée à la fois.
Vous pouvez appuyer sur la barre d’espacement pour afficher la page suivante ou entrer `q` pour quitter.

Si vous passez les noms de plusieurs fichiers à la commande `less`,
vous pouvez taper `:n` (deux points et un « n » minuscule) pour passer au fichier suivant,
`:p` pour revenir au fichier précédent,
ou `:q` pour quitter.

Remarque : Si vous consultez les solutions des exercices qui utilisent `less`,
vous verrez une commande supplémentaire à la fin qui *désactive* la pagination
afin que nous puissions tester vos solutions de manière efficace.

`@instructions`
Utilisez `less seasonal/spring.csv seasonal/summer.csv` pour visualiser ces deux fichiers dans cet ordre.
Appuyez sur la barre d’espacement pour passer à la page suivante, sur `:n` pour passer au deuxième fichier et sur `:q` pour quitter.

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

## Comment consulter le début d’un fichier ?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

Après avoir reçu un nouvel ensemble de données à analyser, la plupart des scientifiques des données commencent par
déterminer les champs et les valeurs de ces champs.
Si le jeu de données a été exporté à partir d’une base de données ou d’une feuille de calcul,
Il sera souvent stocké sous forme de **valeurs séparées par des virgules** (CSV).
Un moyen rapide de savoir ce qu’il contient est de regarder les premières lignes.

Nous pouvons le faire dans le shell à l’aide de la commande `head`.
Comme nous le verrons bientôt,
elle affiche les premières lignes d’un fichier
(par défaut, les 10 premières).
Par conséquent, la commande :

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

Que fait la commande `head` si le fichier ne contient pas 10 lignes ?
(Pour le savoir, affichez les premières lignes de `people/agarwal.txt`.)

`@possible_answers`
- Afficher un message d’erreur car le fichier est trop court.
- Afficher autant de lignes que possible.
- Afficher des lignes vides pour compléter les 10.

`@hint`
Quelle est la chose la plus utile à faire ?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Incorrect : ce n'est pas la chose la plus utile qu'il pourrait faire.",
                    "Correct !",
                    "Incorrect : il serait impossible de le distinguer d'un fichier qui se termine par un tas de lignes vides."])
```

---

## Comment réduire la saisie manuelle ?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

L’un des outils puissants du shell est la **complétion par tabulation**.
Si vous commencez à taper le nom d’un fichier et que vous appuyez sur la touche de tabulation,
le shell fera de son mieux pour compléter automatiquement le chemin.
Par exemple,
si vous tapez `sea` et appuyez sur la touche de tabulation,
il complétera le nom du répertoire `seasonal/` (avec une barre oblique à la fin).
Si vous tapez ensuite `a` et appuyez sur la touche de tabulation,
il complétera le chemin `seasonal/autumn.csv`.

Si le chemin est ambigu,
comme `seasonal/s`,
appuyez une deuxième fois sur la touche tab pour afficher une liste de possibilités.
Tapez un ou deux caractères supplémentaires pour préciser votre chemin,
puis appuyez sur la touche de tabulation
pour compléter le nom.

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
Exécutez `head seasonal/autumn.csv` sans taper le nom complet du fichier.

`@hint`
Tapez autant que nécessaire, puis appuyez sur la touche de tabulation et répétez l’opération.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="Le vérificateur n'a pas trouvé la bonne sortie dans votre commande. Êtes-vous sûr d'avoir appelé `head` sur `seasonal/autumn.csv` ?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Exécutez `head seasonal/spring.csv` sans taper le nom complet du fichier.

`@hint`
Tapez autant que nécessaire, puis appuyez sur la touche de tabulation et répétez l’opération.

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

## Comment contrôler le comportement des commandes ?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Vous ne voudrez pas toujours consulter les 10 premières lignes d’un fichier.
Le shell vous permet donc de modifier le comportement de la commande `head`
en lui attribuant une **option de ligne de commande** (ou simplement « option »).
Si vous exécutez la commande :

```{shell}
head -n 3 seasonal/summer.csv
```

`head` n’affichera que les trois premières lignes du fichier.
Si vous exécutez `head -n 100`,
elle affichera les 100 premières lignes (en supposant qu’il y en ait autant),
ainsi de suite.

Le nom d’une option indique généralement son objectif
(par exemple, `-n` pour le nombre de lignes).
Les options de commande ne sont pas nécessairement un `-` suivi d’une seule lettre,
mais cette convention est largement utilisée.

Remarque : il convient de placer toutes les options *avant* les noms de fichiers.
Dans ce cours,
nous acceptons donc uniquement ce type de réponses.

`@instructions`
Affichez les 5 premières lignes du fichier `winter.csv` du répertoire `seasonal`.

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

## Comment répertorier tout ce qui se trouve sous un répertoire ?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Pour voir tout ce qui se trouve sous un répertoire,
quelle que soit la profondeur d’imbrication,
vous pouvez ajouter à `ls` l’option `-R`
(pour récursif).
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

Cette commande permet d’afficher tous les fichiers et répertoires du niveau actuel,
puis le contenu de chaque sous-répertoire,
ainsi de suite.

`@instructions`
Pour vous aider à identifier les différents éléments,
`ls` a une option `-F` qui affiche un `/` après le nom de chaque répertoire
et une `*` après le nom de chaque programme exécutable.
Exécutez `ls` avec deux options, `-R` et `-F`, et le chemin absolu de votre répertoire personnel
pour voir tout ce qu’il contient.
(L’ordre des options n’a pas d’importance, mais le nom du répertoire doit venir en dernier).

`@hint`
Votre répertoire personnel peut être spécifié en utilisant `~` ou `.` ou son chemin absolu.

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

## Comment obtenir de l’aide pour une commande ?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Pour connaître le fonctionnement des commandes,
vous pouvez utiliser la commande `man`
(pour manuel).
Par exemple,
la commande `man head` permet d’obtenir les informations suivantes :

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

`man` invoque automatiquement `less`.
Vous devrez donc peut-être appuyer sur la barre d’espacement pour parcourir les informations.
Appuyez sur `:q` pour quitter.

La description d’une ligne sous `NAME` vous indique brièvement ce que fait la commande
et le résumé sous `SYNOPSIS` liste toutes les options disponibles.
Les éléments facultatifs sont indiqués entre crochets `[...]`,
les éléments pouvant être utilisés l’un ou l’autre sont séparés par `|`
et les éléments qui peuvent être répétés sont indiqués par `...`.
Ainsi, la page de manuel de la commande `head` vous indique que vous pouvez donner *soit* un nombre de lignes avec `-n`,
soit un nombre d’octets avec `-c`,
et que vous pouvez lui donner autant de noms de fichiers que vous le souhaitez.

Le problème du manuel Unix est que vous devez savoir ce que vous recherchez.
Si vous ne le savez pas,
vous pouvez faire une recherche sur [Stack Overflow](https://stackoverflow.com/),
poser une question sur les canaux Slack de DataCamp,
ou consulter les sections `SEE ALSO` des commandes que vous connaissez déjà.

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
Lisez la page de manuel de la commande `tail` pour savoir ce que fait
le signe `+` devant le nombre utilisé avec l’option `-n`.
(N’oubliez pas d’appuyer sur la barre d’espacement pour passer à la page suivante ou de taper `q` pour quitter.)

`@hint`
Souvenez-vous que `man` est l’abréviation de manuel.

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
Utilisez la commande `tail` avec l’option `-n +7` pour afficher toutes les lignes, *à l’exception* des six premières, de `seasonal/spring.csv`.

`@hint`
Utilisez le signe « + » devant le nombre de lignes que vous souhaitez afficher.

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

## Comment sélectionner des colonnes dans un fichier ?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

Les commandes `head` et `tail` vous permettent de sélectionner des lignes dans un fichier texte.
Si vous souhaitez sélectionner des colonnes,
vous pouvez utiliser la commande `cut`.
Elle dispose de plusieurs options (utilisez `man cut` pour les explorer),
mais les plus courantes ressemblent à :

```{shell}
cut -f 2-5,8 -d , values.csv
```

ce qui signifie
« sélectionner les colonnes 2 à 5 et 8,
en utilisant la virgule comme séparateur ».
La commande `cut` utilise `-f` pour spécifier les colonnes
et `-d` pour spécifier le séparateur.
Vous devez spécifier le séparateur, car certains fichiers peuvent utiliser des espaces, des tabulations ou des deux-points pour séparer les colonnes.

<hr>

Quelle commande permet de sélectionner la première colonne (contenant des dates) du fichier `spring.csv` ?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- L’une ou l’autre.
- Aucune des deux, car `-f` doit précéder `-d`.

`@hint`
L’ordre des options n’a pas d'importance.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Oui, mais ce n\'est pas tout', 'Oui, mais ce n\'est pas tout', 'Correct ! Ajouter un espace après le drapeau est une bonne pratique, mais pas obligatoire.', 'Non, l\'ordre des drapeaux n\'a pas d\'importance'])
```

---

## Quelles sont les limitations de la commande cut ?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

La commande `cut` est simpliste.
En particulier,
elle ne comprend pas les chaînes de caractères entre guillemets.
Par exemple, si votre fichier est :

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

la commande :

```{shell}
cut -f 2 -d , everyone.csv
```

produira :

```
Age
Ranjit"
Rupinder"
```

plutôt que l’âge de chacun,
car elle pensera que la virgule entre le nom et le prénom est un séparateur de colonnes.

<hr>

Quelle est la sortie de `cut -d : -f 2-4` sur la ligne :

```
first:second:third:
```

(Notez les deux-points à la fin.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Aucune des trois, car la ligne ne contient pas quatre champs.

`@hint`
Faites attention aux deux-points à la fin.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Non, il y a plus.', 'Non, il y a plus.', 'Correct ! Les deux-points à la fin créent un quatrième champ vide.', 'Non, `cut` fait de son mieux.'])
```

---

## Comment répéter des commandes ?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

L’un des principaux avantages de l’utilisation du shell est qu’il
vous permet de répéter facilement des opérations.
Si vous exécutez plusieurs commandes,
vous pouvez ensuite appuyer sur la flèche vers le haut pour les faire défiler.
Vous pouvez également utiliser les flèches vers la gauche et vers la droite, ainsi que la touche de suppression pour les modifier.
Vous pouvez alors appuyer sur la touche Retour chariot pour exécuter la commande modifiée.

Mieux encore, la commande `history` affiche une liste des commandes que vous avez exécutées récemment.
Chacune d’entre elles est précédée d’un numéro de série afin de faciliter la ré-exécution de certaines commandes :
tapez simplement `!55` pour réexécuter la 55<sup>e </sup>commande de votre historique (si vous en avez autant).
Vous pouvez également réexécuter une commande en tapant un point d’exclamation suivi du nom de la commande,
par exemple `!head` ou `!cut`,
ce qui exécutera de nouveau la dernière utilisation de cette commande.

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
La complétion par tabulation ne fonctionnera pas s’il n’y a pas de nom de fichier correspondant.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Utilisez `head` et un nom de fichier, `summer.csv`. Ne vous inquiétez pas si cela échoue. Cela devrait.")
)

```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Passez au répertoire `seasonal`.

`@hint`
N’oubliez pas que `cd` signifie changer de répertoire.

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
Exécutez à nouveau la commande `head` avec `!head`.

`@hint`
Ne tapez pas d’espace entre `!` et ce qui suit.

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
Utilisez `history` pour examiner vos commande passées.

`@hint`
Notez que la commande `history` affiche les commandes les plus récentes en dernier, de sorte qu’elles restent affichées à l’écran après son exécution.

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
Exécutez à nouveau `head` en utilisant `!` suivi d’un numéro de commande.

`@hint`
Ne tapez *pas* d’espace entre `!` et ce qui suit.

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

## Comment sélectionner des lignes contenant des valeurs spécifiques ?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` et `tail` sélectionnent des lignes,
`cut` sélectionne des colonnes
et `grep` sélectionne les lignes en fonction de leur contenu.
Dans sa forme la plus simple,
`grep` prend une chaîne de caractères suivie d’un ou de plusieurs noms de fichiers
et affiche toutes les lignes de ces fichiers qui contiennent cette chaîne.
Par exemple,
`grep bicuspid seasonal/winter.csv`
affiche les lignes de `winter.csv` qui contiennent la chaîne « bicuspid ».

`grep` peut également rechercher des motifs.
Nous étudierons cela dans le prochain cours.
Ce qui est plus important pour l’instant, ce sont certaines des options les plus courantes de `grep` :

- `-c` : affiche le nombre de lignes correspondantes plutôt que les lignes elles-mêmes
- `-h` : n’affiche *pas* les noms des fichiers lors de la recherche de plusieurs fichiers
- `-i` : ignore la casse (par exemple, « Régression » et « régression » sont équivalents)
- `-l` : affiche les noms des fichiers qui contiennent des correspondances, et non les correspondances
- `-n` : affiche les numéros des lignes qui contiennent des correspondances
- `-v` : inverse la correspondance, c’est-à-dire n’affiche que les lignes *sans* correspondance

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
en exécutant une seule commande depuis votre répertoire personnel. N’utilisez aucune option.

`@hint`
Utilisez `grep` avec le mot que vous recherchez et le nom du ou des fichiers à rechercher.

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
Inversez la correspondance pour trouver toutes les lignes qui *ne contiennent pas* le mot `molar` dans `seasonal/spring.csv`, et affichez leur numéro de ligne.
Rappelez-vous qu’il convient de placer toutes les options *avant* les autres valeurs telles que les noms de fichiers ou le terme de recherche.

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
      has_code("seasonal/spring.csv", incorrect_msg = "Avez-vous recherché le fichier `seasonal/spring.csv` ?")
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
Comptez le nombre de lignes contenant le mot `incisor` dans `autumn.csv` et `winter.csv` combinés.
(Là encore, exécutez une seule commande à partir de votre répertoire personnel.)

`@hint`
N’oubliez pas d’utiliser `-c` avec `grep` pour compter les lignes.

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

## Pourquoi ne convient-il pas toujours de traiter les données comme du texte ?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

La section `SEE ALSO` de la page de manuel de la commande `cut` fait référence à une commande appelée `paste`,
qui peut être utilisée pour combiner des fichiers de données au lieu de les découper.

<hr>

Lisez la page de manuel de `paste`,
puis exécutez `paste` pour combiner les fichiers de données autumn et winter dans un seul tableau,
en utilisant une virgule comme séparateur.
Du point de vue de l’analyse des données, qu’est-ce qui ne va pas avec le résultat ?

`@possible_answers`
- Les en-têtes de colonne sont répétés.
- Les dernières lignes n’ont pas le bon nombre de colonnes.
- Certaines données de `winter.csv` sont manquantes.

`@hint`
Si vous exécutez `cut` sur la sortie de `paste` en utilisant des virgules comme séparateur,
obtiendrez-vous la bonne réponse ?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Vrai, mais ce n\'est pas nécessairement une erreur.'
correct2 = 'Correct : joindre les lignes avec des colonnes ne crée qu\'une seule colonne vide au début, pas deux.'
err3 = 'Non, toutes les données hivernales sont présentes.'
Ex().has_chosen(2, [err1, correct2, err3])
```

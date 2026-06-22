---
title: Combiner des outils
description: >-
  La véritable puissance de l'invite de commande Unix ne réside pas dans chaque
  commande prise isolément, mais dans la facilité avec laquelle on peut les
  combiner pour faire de nouvelles choses. Ce chapitre vous montrera comment
  exploiter cette puissance pour sélectionner les données voulues et présentera
  des commandes pour trier des valeurs et supprimer les doublons.
lessons:
  - nb_of_exercises: 12
    title: Comment enregistrer la sortie d'une commande dans un fichier ?
---

## Comment puis-je enregistrer la sortie d'une commande dans un fichier ?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

Tous les outils que vous avez vus jusqu'ici vous permettent de nommer des fichiers d'entrée.
La plupart n'offrent pas d'option pour nommer un fichier de sortie, parce qu'ils n'en ont pas besoin.
À la place,
vous pouvez utiliser la **redirection** pour enregistrer la sortie de n'importe quelle commande où vous voulez.
Si vous exécutez cette commande :

```{shell}
head -n 5 seasonal/summer.csv
```

elle affiche à l'écran les 5 premières lignes des données d'été.
Si vous exécutez plutôt cette commande :

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

rien ne s'affiche à l'écran.
À la place,
la sortie de `head` est envoyée dans un nouveau fichier nommé `top.csv`.
Vous pouvez jeter un coup d'œil au contenu de ce fichier avec `cat` :

```{shell}
cat top.csv
```

Le signe supérieur `>` indique à l'interpréteur de commandes de rediriger la sortie de `head` vers un fichier.
Ce n'est pas une partie de la commande `head` ;
au contraire,
il fonctionne avec toute commande de l'interpréteur qui produit une sortie.

`@instructions`
Combinez `tail` avec la redirection pour enregistrer les 5 dernières lignes de `seasonal/winter.csv` dans un fichier nommé `last.csv`.

`@hint`
Utilisez `tail -n 5` pour récupérer les 5 dernières lignes.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "La ligne `%s` devrait être dans le fichier `last.csv`, mais elle ne l'est pas. Redirigez la sortie de `tail -n 5 seasonal/winter.csv` vers `last.csv` avec `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv` a trop de lignes. Avez-vous utilisé le drapeau `-n 5` avec `tail`?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("Bien! Pratiquons encore un peu!")
```

---

## Comment puis-je utiliser la sortie d'une commande comme entrée?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

Supposons que vous vouliez extraire des lignes au milieu d'un fichier.
Plus précisément,
supposons que vous vouliez obtenir les lignes 3 à 5 d'un de nos fichiers de données.
Vous pouvez commencer par utiliser `head` pour obtenir les 5 premières lignes,
rediriger le tout vers un fichier,
puis utiliser `tail` pour sélectionner les 3 dernières :

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

Une vérification rapide confirme qu'il s'agit bien des lignes 3 à 5 de notre fichier original,
car ce sont les 3 dernières lignes des 5 premières.

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
Sélectionnez les deux dernières lignes de `seasonal/winter.csv`
et enregistrez-les dans un fichier nommé `bottom.csv`.

`@hint`
Utilisez `tail` pour sélectionner des lignes et `>` pour rediriger la sortie de `tail`.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="La ligne `%s` devrait être dans le fichier `bottom.csv`, mais elle ne l'est pas. Redirigez la sortie de `tail -n 2 seasonal/winter.csv` vers `bottom.csv` avec `>`."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv` a trop de lignes. Avez-vous utilisé le drapeau `-n 2` avec `tail`?'),
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
Sélectionnez la première ligne de `bottom.csv`
afin d'obtenir l'avant-dernière ligne du fichier original.

`@hint`
Utilisez `head` pour sélectionner la ligne voulue.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="Il y a quelque chose qui ne va pas avec le fichier `bottom.csv`. Assurez-vous de ne pas le modifier !"),
    has_expr_output(strict=True, incorrect_msg="Avez-vous utilisé `head` correctement sur `bottom.csv` ? Assurez-vous d'utiliser correctement le drapeau `-n`.")
)

Ex().success_msg("Bien joué. Passez à l'exercice suivant pour découvrir de meilleures façons de combiner les commandes.")                             

```

---

## Quelle est une meilleure façon de combiner des commandes ?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

Utiliser la redirection pour combiner des commandes a deux inconvénients :

1. Cela laisse traîner beaucoup de fichiers intermédiaires (comme `top.csv`).
2. Les commandes pour produire votre résultat final se retrouvent éparpillées sur plusieurs lignes d'historique.

L'interpréteur de commandes offre un autre outil qui règle ces deux problèmes à la fois : le **tube** (pipe).
Encore une fois,
commencez par exécuter `head` :

```{shell}
head -n 5 seasonal/summer.csv
```

Au lieu d'envoyer la sortie de `head` vers un fichier,
ajoutez une barre verticale et la commande `tail` *sans* nom de fichier :

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

Le symbole du tube indique à l'interpréteur d'utiliser la sortie de la commande à gauche
comme entrée de la commande à droite.

`@instructions`
Utilisez `cut` pour sélectionner tous les noms de dents à partir de la colonne 2 du fichier délimité par des virgules `seasonal/summer.csv`, puis acheminez le résultat vers `grep`, avec une correspondance inversée, pour exclure la ligne d'en-tête contenant le mot "Tooth". *`cut` et `grep` ont été abordés en détail au chapitre 2, exercices 8 et 11 respectivement.*

`@hint`
- La première partie de la commande a la forme `cut -d délimiteur_de_champ -f numéro_de_colonne nom_de_fichier`.
- La deuxième partie de la commande a la forme `grep -v élément_à_retrouver`.

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
    has_expr_output(incorrect_msg = 'Avez-vous redirigé le résultat de `cut -d , -f 2 seasonal/summer.csv` dans `grep -v Tooth` avec `|` ?'),
    check_not(has_output("Tooth"), incorrect_msg = 'Avez-vous exclu la ligne d\'en-tête `"Tooth"` en utilisant `grep` ?')
)
Ex().success_msg("Parfait enchaînement ! C'est peut-être la première fois que vous utilisez `|`, mais ce ne sera certainement pas la dernière !")
```

---

## Comment puis-je combiner plusieurs commandes?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

Vous pouvez enchaîner autant de commandes que vous voulez.
Par exemple,
cette commande :

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

va :

1. sélectionner la première colonne des données de printemps ;
2. retirer la ligne d'en-tête qui contient le mot « Date » ;
3. sélectionner les 10 premières lignes de données réelles.

`@instructions`
Dans l'exercice précédent, vous avez utilisé la commande suivante pour sélectionner tous les noms de dents depuis la colonne 2 de `seasonal/summer.csv` :

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

Prolongez ce traitement en ajoutant une commande `head` pour ne sélectionner que tout premier nom de dent.

`@hint`
Copiez-collez le code des instructions, ajoutez un tuyau (pipe), puis exécutez `head` avec l'option `-n`.

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
    has_output('^\s*canine\s*$', incorrect_msg = "Avez-vous utilisé `|` pour étendre le pipeline avec une commande `head` ? Assurez-vous de définir correctement le drapeau `-n`."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "Avez-vous utilisé `|` pour étendre le pipeline avec une commande `head` ?")
)
Ex().success_msg("Chaînage joyeux ! En enchaînant plusieurs commandes ensemble, vous pouvez construire des pipelines puissants de manipulation de données.")
```

---

## Comment puis-je compter les enregistrements dans un fichier ?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

La commande `wc` (pour « word count ») affiche le nombre de **c**aractères, de **m**ots et de **l**ignes dans un fichier.
Vous pouvez lui demander d'afficher seulement l'un de ces nombres avec respectivement `-c`, `-w` ou `-l`.

`@instructions`
Comptez combien d'enregistrements dans `seasonal/spring.csv` ont des dates en juillet 2017 (`2017-07`). 
- Pour ce faire, utilisez `grep` avec une date partielle pour sélectionner les lignes, puis transférez ce résultat vers `wc` à l'aide d'un tuyau et de l'option appropriée pour compter les lignes.

`@hint`
- Utilisez `head seasonal/spring.csv` pour vous rappeler le format de date.
- La première partie de la commande suit la forme `grep element_a_rechercher nom_de_fichier`.
- Après le tuyau, `|`, appelez `wc` avec l'option `-l`.

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
      has_code("grep", incorrect_msg = "Avez-vous appelé `grep` ?"),
      has_code("2017-07", incorrect_msg = "Avez-vous recherché `2017-07` ?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Avez-vous recherché dans le fichier `seasonal/spring.csv` ?"),
      has_code("|", incorrect_msg = "Avez-vous utilisé un pipe vers `wc` avec `|` ?"),      
      has_code("wc", incorrect_msg = "Avez-vous appelé `wc` ?"),
      has_code("-l", incorrect_msg = "Avez-vous compté les lignes avec `-l` ?")
    )
  )
)
Ex().success_msg("Comptage minutieux ! Déterminer la quantité de données que vous avez est une excellente première étape dans toute analyse de données.")
```

---

## Comment puis-je indiquer plusieurs fichiers à la fois?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

La plupart des commandes du shell fonctionnent sur plusieurs fichiers si vous leur fournissez plusieurs noms de fichier.
Par exemple,
vous pouvez obtenir la première colonne de tous les fichiers de données saisonniers en une seule fois comme ceci :

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

Mais retaper les noms de nombreux fichiers encore et encore n'est pas une bonne idée :
cela fait perdre du temps
et tôt ou tard, vous allez soit en oublier un, soit répéter le nom d'un fichier.
Pour vous simplifier la vie,
le shell vous permet d'utiliser des **caractères génériques** pour indiquer une liste de fichiers avec une seule expression.
Le caractère générique le plus courant est `*`,
qui signifie « faire correspondre zéro caractère ou plus ».
En l'utilisant,
nous pouvons raccourcir la commande `cut` ci‑dessus ainsi :

```{shell}
cut -d , -f 1 seasonal/*
```

ou :

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
Écrivez une seule commande avec `head` pour obtenir les trois premières lignes de `seasonal/spring.csv` et de `seasonal/summer.csv`, soit un total de six lignes de données, mais pas celles des fichiers d'automne ou d'hiver.
Utilisez un caractère générique plutôt que d'écrire les noms des fichiers au complet.

`@hint`
- La commande a la forme `head -n number_of_lines filename_pattern`.
- Vous pouvez faire correspondre des fichiers dans le répertoire `a` qui commencent par `b` en utilisant, par exemple, `a/b*`.

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
    has_expr_output(incorrect_msg = "Vous pouvez utiliser `seasonal/s*` pour sélectionner `seasonal/spring.csv` et `seasonal/summer.csv`. Assurez-vous d'inclure uniquement les trois premières lignes de chaque fichier avec le drapeau `-n` !"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "N'incluez pas la sortie pour `seasonal/autumn.csv`. Vous pouvez utiliser `seasonal/s*` pour sélectionner `seasonal/spring.csv` et `seasonal/summer.csv`"),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "N'incluez pas la sortie pour `seasonal/winter.csv`. Vous pouvez utiliser `seasonal/s*` pour sélectionner `seasonal/spring.csv` et `seasonal/summer.csv`")
)
Ex().success_msg("Travail de joker sauvage ! Cela devient encore plus important si votre répertoire contient des centaines ou des milliers de fichiers.")
```

---

## Quels autres caractères génériques puis-je utiliser?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

L'interpréteur de commandes propose aussi d'autres caractères génériques,
bien qu'ils soient moins utilisés :

- `?` correspond à un seul caractère, donc `201?.txt` fera correspondre `2017.txt` ou `2018.txt`, mais pas `2017-01.txt`.
- `[...]` correspond à l'un des caractères entre crochets, donc `201[78].txt` correspond à `2017.txt` ou `2018.txt`, mais pas à `2016.txt`.
- `{...}` correspond à l'un des motifs séparés par des virgules entre accolades, donc `{*.txt, *.csv}` correspond à tout fichier dont le nom se termine par `.txt` ou `.csv`, mais pas aux fichiers dont le nom se termine par `.pdf`.

<hr/>

Laquelle de ces expressions ferait correspondre `singh.pdf` et `johel.txt` mais pas `sandhu.pdf` ni `sandhu.txt`?

`@hint`
Faites correspondre chaque expression à chaque nom de fichier, l'un après l'autre.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- Non : `.pdf` et `.txt` ne sont pas des noms de fichiers.
- Non : cela fera correspondre `sandhu.pdf`.
- Non : l'expression entre crochets correspond à un seul caractère, pas à des mots entiers.
- Correct!

---

## Comment trier des lignes de texte?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

Comme son nom l'indique,
`sort` met les données en ordre.
Par défaut, il le fait en ordre alphabétique croissant,
mais les options `-n` et `-r` permettent de trier numériquement et d'inverser l'ordre de la sortie,
alors que `-b` lui indique d'ignorer les blancs initiaux
et `-f` lui indique de neutraliser la casse (c.-à-d. ignorer les majuscules/minuscules).
Les pipelines utilisent souvent `grep` pour éliminer les enregistrements indésirables,
puis `sort` pour mettre en ordre ceux qui restent.

`@instructions`
Vous vous rappelez de la combinaison de `cut` et `grep` pour sélectionner tous les noms de dents de la colonne 2 de `seasonal/summer.csv`?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

En partant de cette « recette », triez les noms de dents dans `seasonal/winter.csv` (et non `summer.csv`) en ordre alphabétique décroissant. Pour ce faire, prolongez le pipeline avec une étape `sort`.

`@hint`
Copiez-collez la commande des instructions, changez le nom de fichier, ajoutez un tuyau, puis appelez `sort` avec l'option `-r`.

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
      has_code("cut", incorrect_msg = "Avez-vous appelé `cut` ?"),
      has_code("-d", incorrect_msg = "Avez-vous spécifié un délimiteur de champ avec `-d` ?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Avez-vous obtenu des données du fichier `seasonal/winter.csv` ?"),
      has_code("|", incorrect_msg = "Avez-vous utilisé un pipe de `cut` à `grep` à `sort` en utilisant `|` ?"),      
      has_code("grep", incorrect_msg = "Avez-vous appelé `grep` ?"),
      has_code("-v", incorrect_msg = "Avez-vous inversé la correspondance avec `-v` ?"),
      has_code("Tooth", incorrect_msg = "Avez-vous recherché `Tooth` ?"),
      has_code("sort", incorrect_msg = "Avez-vous appelé `sort` ?"),
      has_code("-r", incorrect_msg = "Avez-vous inversé l'ordre de tri avec `-r` ?")
    )
  )
)
Ex().success_msg("Trié ! `sort` a de nombreuses utilisations. Par exemple, en utilisant un pipe de `sort -n` à `head`, vous affichez les plus grandes valeurs.")
```

---

## Comment puis-je enlever les lignes en double ?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

Une autre commande souvent utilisée avec `sort` est `uniq`,
dont le rôle est d'enlever les lignes dupliquées.
Plus précisément,
elle enlève les lignes en double qui sont *adjacentes*.
Si un fichier contient :

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

alors `uniq` produira :

```
2017-07-03
2017-08-03
```

mais s'il contient :

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

alors `uniq` affichera les quatre lignes.
La raison est que `uniq` est conçu pour fonctionner avec des fichiers très volumineux.
Pour enlever des lignes non adjacentes d'un fichier,
il devrait garder tout le fichier en mémoire
(ou du moins
toutes les lignes uniques vues jusqu'à présent).
En ne retirant que les doublons adjacents,
il n'a qu'à conserver en mémoire la ligne unique la plus récente.

`@instructions`
Écrivez un enchaînement de commandes pour :

- extraire la deuxième colonne de `seasonal/winter.csv`,
- enlever le mot « Tooth » de la sortie afin que seuls les noms de dents soient affichés,
- trier la sortie de façon à regrouper toutes les occurrences d'un même nom de dent ; et
- afficher chaque nom de dent une seule fois avec le nombre de fois où il apparaît.

Le début de votre tuyauterie est le même que dans l'exercice précédent :

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

Complétez-la avec une commande `sort`, et utilisez `uniq -c` pour afficher les lignes uniques avec un compteur du nombre d'occurrences de chacune, plutôt que d'utiliser `uniq` et `wc`.

`@hint`
Copiez-collez la commande des instructions, envoyez-la avec un tuyau vers `sort` sans indicateurs, puis à nouveau vers `uniq` avec l'indicateur `-c`.

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
                     incorrect_msg="Vous devriez commencer par cette commande : `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. Maintenant, étendez-la !"),
            has_code('\|\s+sort', incorrect_msg="Avez-vous étendu la commande avec `| sort` ?"),
            has_code('\|\s+uniq', incorrect_msg="Avez-vous étendu la commande avec `| uniq` ?"),
            has_code('-c', incorrect_msg="Avez-vous inclus les comptes avec `-c` ?")
        )
    )
)
Ex().success_msg("Super ! Après tout ce travail sur un pipe, ce serait bien si nous pouvions stocker le résultat, non ?")
```

---

## Comment puis-je enregistrer la sortie d'un tuyau (pipe) ?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

Le shell nous permet de rediriger la sortie d'une séquence de commandes enchaînées par un tuyau :

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

Cependant, `>` doit apparaître à la fin du pipeline :
si nous essayons de l'utiliser au milieu, comme ceci :

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

alors toute la sortie de `cut` est écrite dans `teeth-only.txt`,
il ne reste donc rien pour `grep`,
et celui-ci attend indéfiniment une entrée.

<hr>

Que se passe-t-il si nous plaçons la redirection au début d'un pipeline, comme dans :

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [La sortie de la commande est redirigée vers le fichier comme d'habitude.]
- Le shell signale une erreur.
- Le shell attend indéfiniment une entrée.

`@hint`
Essayez-le dans le shell.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['Correct!', 'Non; le shell peut en fait exécuter cela.', 'Non; le shell peut en fait exécuter cela.'])
```

---

## Comment puis-je arrêter un programme en cours d'exécution ?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

Les commandes et scripts que vous avez exécutés jusqu'ici se sont tous terminés rapidement,
mais certaines tâches peuvent prendre des minutes, des heures, voire des jours.
Il peut aussi arriver de placer par erreur une redirection au milieu d'un enchaînement de commandes (pipeline),
ce qui peut le faire bloquer.
Si vous décidez qu'un programme ne devrait plus continuer à s'exécuter,
vous pouvez taper `Ctrl` + `C` pour y mettre fin.
On écrit souvent `^C` dans la documentation Unix ;
notez que le « c » peut être en minuscule.

`@instructions`
Exécutez la commande :

```{shell}
head
```

sans argument (de façon à ce qu'elle attende une entrée qui ne viendra jamais),
puis arrêtez-la en tapant `Ctrl` + `C`.

`@hint`
Tapez simplement head, appuyez sur Entrée, puis quittez le programme en cours avec `Ctrl` + `C`.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="Avez-vous utilisé `head` ?")
```

---

## Pour conclure

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

Pour terminer,
vous allez créer un enchaînement de commandes (pipeline) pour déterminer combien d'enregistrements se trouvent dans le plus court des fichiers de données saisonniers.

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
Utilisez `wc` avec les paramètres appropriés pour afficher le nombre de lignes dans tous les fichiers de données saisonniers.
(Utilisez un caractère générique pour les noms de fichiers au lieu de les taper un par un.)

`@hint`
Utilisez `-l` pour n'afficher que le nombre de lignes et `*` pour faire correspondre les noms de fichiers.

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
      has_code("wc", incorrect_msg = "Avez-vous appelé `wc` ?"),
      has_code("-l", incorrect_msg = "Avez-vous compté le nombre de lignes avec `-l` ?"),
      has_code("seasonal/\*", incorrect_msg = "Avez-vous obtenu des données de tous les fichiers `seasonal/*` ?")
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
Ajoutez une autre commande à la précédente au moyen d'un tuyau (pipe) pour retirer la ligne contenant le mot « total ».

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
      has_code("wc", incorrect_msg = "Avez-vous appelé `wc` ?"),
      has_code("-l", incorrect_msg = "Avez-vous compté le nombre de lignes avec `-l` ?"),
      has_code("seasonal/\*", incorrect_msg = "Avez-vous obtenu des données de tous les fichiers `seasonal/*` ?"),
      has_code("|", incorrect_msg = "Avez-vous utilisé un pipe de `wc` à `grep` en utilisant `|` ?"),      
      has_code("grep", incorrect_msg = "Avez-vous appelé `grep` ?"),
      has_code("-v", incorrect_msg = "Avez-vous inversé la correspondance avec `-v` ?"),
      has_code("total", incorrect_msg = "Avez-vous recherché `total` ?")
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
Ajoutez deux autres étapes au pipeline qui utilisent `sort -n` et `head -n 1` pour trouver le fichier contenant le moins de lignes.

`@hint`
- Utilisez l'option `-n` de `sort` pour trier numériquement.
- Utilisez l'option `-n` de `head` pour limiter la sortie à 1 ligne.

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
      has_code("wc", incorrect_msg = "Avez-vous appelé `wc` ?"),
      has_code("-l", incorrect_msg = "Avez-vous compté le nombre de lignes avec `-l` ?"),
      has_code("seasonal/\*", incorrect_msg = "Avez-vous obtenu des données de tous les fichiers `seasonal/*` ?"),
      has_code("|", incorrect_msg = "Avez-vous utilisé `|` pour enchaîner `wc`, `grep`, `sort` et `head` ?"),      
      has_code("grep", incorrect_msg = "Avez-vous appelé `grep` ?"),
      has_code("-v", incorrect_msg = "Avez-vous inversé la correspondance avec `-v` ?"),
      has_code("total", incorrect_msg = "Avez-vous recherché `total` ?"),
      has_code("sort", incorrect_msg = "Avez-vous appelé `sort` ?"),
      has_code("-n", incorrect_msg = "Avez-vous spécifié le nombre de lignes à conserver avec `-n` ?"),
      has_code("1", incorrect_msg = "Avez-vous spécifié 1 ligne à conserver avec `-n 1` ?")
    )
  )
)
Ex().success_msg("Super ! Il s'avère que `autumn.csv` est le fichier avec le moins de lignes. Rendez-vous au chapitre 4 pour en savoir plus sur le traitement par lots !")
```

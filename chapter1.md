---
title: Manipuler des fichiers et des répertoires
description: >-
  Ce chapitre est une brève introduction à l'invite de commande Unix. Vous
  verrez pourquoi elle est toujours utilisée après près de 50 ans, en quoi elle
  se compare aux outils graphiques auxquels vous êtes peut-être plus habitué,
  comment vous déplacer dans l'invite, et comment créer, modifier et supprimer
  des fichiers et des dossiers.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: Comment l'invite se compare-t-elle à une interface de bureau ?
---

## Comment l'interpréteur de commandes se compare-t-il à une interface de bureau ?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Un système d'exploitation comme Windows, Linux ou macOS est un type particulier de programme.
Il contrôle le processeur de l'ordinateur, le disque dur et la connexion réseau,
mais son rôle le plus important est d'exécuter d'autres programmes.

Comme les êtres humains ne sont pas numériques,
ils ont besoin d'une interface pour interagir avec le système d'exploitation.
La plus courante de nos jours est un explorateur de fichiers graphique,
qui traduit les clics et les doubles clics en commandes pour ouvrir des fichiers et exécuter des programmes.
Avant que les ordinateurs n'aient des écrans graphiques,
cependant,
les gens tapaient des instructions dans un programme appelé **interpréteur de commandes (command-line shell)**.
Chaque fois qu'une commande est saisie,
l'interpréteur lance d'autres programmes,
affiche leurs résultats dans une forme lisible
puis présente une *invite* pour signaler qu'il est prêt à accepter la prochaine commande.
(Son nom vient de l'idée qu'il constitue la « coquille externe » de l'ordinateur.)

Taper des commandes plutôt que cliquer et déplacer peut sembler maladroit au début,
mais comme vous le verrez,
une fois que vous commencez à exprimer clairement ce que vous voulez que l'ordinateur fasse,
vous pouvez combiner d'anciennes commandes pour en créer de nouvelles
et automatiser des tâches répétitives
en quelques frappes seulement.

<hr>
Quel est le lien entre l'explorateur de fichiers graphique que la plupart des gens utilisent et l'interpréteur de commandes ?

`@hint`
Rappelez-vous qu'une personne utilisatrice ne peut interagir avec un système d'exploitation qu'au moyen d'un programme.

`@possible_answers`
- L'explorateur de fichiers vous permet d'afficher et de modifier des fichiers, tandis que l'interpréteur vous permet d'exécuter des programmes.
- L'explorateur de fichiers est construit au-dessus de l'interpréteur.
- L'interpréteur fait partie du système d'exploitation, tandis que l'explorateur de fichiers est séparé.
- [Ce sont deux interfaces permettant d'envoyer des commandes au système d'exploitation.]

`@feedback`
- Les deux permettent d'afficher et de modifier des fichiers et d'exécuter des programmes.
- Les explorateurs de fichiers graphiques et l'interpréteur de commandes invoquent les mêmes fonctions sous-jacentes du système d'exploitation.
- L'interpréteur de commandes et l'explorateur de fichiers sont tous deux des programmes qui traduisent les commandes de la personne utilisatrice (tapées au clavier ou cliquées) en appels au système d'exploitation.
- Exact ! Dans les deux cas, les commandes de la personne utilisatrice (qu'elles soient tapées ou cliquées) sont transmises au système d'exploitation.

---

## Où suis-je?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

Le **système de fichiers** gère les fichiers et les répertoires (ou dossiers).
Chacun est identifié par un **chemin absolu**
qui indique comment y accéder à partir du **répertoire racine** du système de fichiers :
`/home/repl` est le répertoire `repl` dans le répertoire `home`,
alors que `/home/repl/course.txt` est le fichier `course.txt` dans ce répertoire,
et `/` seul est le répertoire racine.

Pour savoir où vous êtes dans le système de fichiers,
exécutez la commande `pwd`
(raccourci de « **p**rint **w**orking **d**irectory », c'est-à-dire afficher le répertoire de travail).
Cette commande affiche le chemin absolu de votre **répertoire de travail actuel**,
qui est l'endroit où l'interpréteur exécute les commandes et cherche les fichiers par défaut.

<hr>
Exécutez `pwd`.
Où êtes-vous en ce moment?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Les systèmes Unix placent généralement tous les répertoires personnels des utilisateurs sous `/home`.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Ce n'est pas le bon chemin."
correct = "Correct - vous êtes dans `/home/repl`."

Ex().has_chosen(3, [err, err, correct])
```

---

## Comment puis-je distinguer les fichiers et les répertoires?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd` vous indique où vous êtes.
Pour voir ce qui s'y trouve,
tapez `ls` (abréviation de "**l**i**s**ting") et appuyez sur Entrée.
Utilisé seul,
`ls` affiche le contenu de votre répertoire actuel
(celui affiché par `pwd`).
Si vous ajoutez des noms de fichiers,
`ls` les énumérera,
et si vous ajoutez des noms de répertoires,
il listera leur contenu.
Par exemple,
`ls /home/repl` vous montre ce qu'il y a dans votre répertoire de départ
(généralement appelé votre **répertoire personnel**).

<hr>
Utilisez `ls` avec un argument approprié pour lister les fichiers du répertoire `/home/repl/seasonal`
(qui contient des renseignements sur les chirurgies dentaires par date, ventilés par saison).
Lequel de ces fichiers n'est *pas* dans ce répertoire?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
Si vous donnez un chemin à `ls`, il affiche ce qui se trouve à cet emplacement.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "Ce fichier se trouve dans le répertoire `seasonal`."
correct = "Correct - ce fichier ne se trouve *pas* dans le répertoire `seasonal`."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## Quelles autres façons puis-je utiliser pour repérer des fichiers et des répertoires?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

Un chemin absolu, c'est comme une latitude et une longitude : il a la même valeur peu importe où vous êtes. Un **chemin relatif**, lui, indique un emplacement à partir de l'endroit où vous vous trouvez : c'est comme dire « 20 kilomètres vers le nord ».

Par exemple :
- Si vous êtes dans le répertoire `/home/repl`, le chemin **relatif** `seasonal` désigne le même répertoire que le chemin **absolu** `/home/repl/seasonal`.
- Si vous êtes dans le répertoire `/home/repl/seasonal`, le chemin **relatif** `winter.csv` désigne le même fichier que le chemin **absolu** `/home/repl/seasonal/winter.csv`.

Le shell détermine si un chemin est absolu ou relatif en regardant son premier caractère : s'il commence par `/`, il est absolu. S'il ne commence **pas** par `/`, il est relatif.

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
Vous êtes dans `/home/repl`. Utilisez `ls` avec un **chemin relatif** pour lister le fichier dont le chemin absolu est `/home/repl/course.txt` (et seulement ce fichier).

`@hint`
Vous pouvez souvent construire le chemin relatif vers un fichier ou un répertoire situé sous votre emplacement actuel en soustrayant le chemin absolu de votre emplacement actuel du chemin absolu de l'élément voulu.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Vous n'avez pas appelé `ls` pour générer la liste des fichiers."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "Votre commande n'a pas généré la liste de fichiers correcte. Utilisez `ls` suivi d'un chemin relatif vers `/home/repl/course.txt`.")
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
Vous êtes dans `/home/repl`.
Utilisez `ls` avec un chemin **relatif**
pour lister le fichier `/home/repl/seasonal/summer.csv` (et seulement ce fichier).

`@hint`
Les chemins relatifs ne commencent **pas** par un « / » initial.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Vous n'avez pas appelé `ls` pour générer la liste des fichiers."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "Votre commande n'a pas généré la liste de fichiers correcte. Utilisez `ls` suivi d'un chemin relatif vers `/home/repl/seasonal/summer.csv`.")
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
Vous êtes dans `/home/repl`.
Utilisez `ls` avec un chemin **relatif**
pour lister le contenu du répertoire `/home/repl/people`.

`@hint`
Les chemins relatifs ne commencent pas par un « / » initial.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "Vous n'avez pas appelé `ls` pour générer la liste des fichiers."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "Votre commande n'a pas généré la liste correcte des fichiers. Utilisez `ls` suivi d'un chemin relatif vers `/home/repl/people`.")
    )
)
Ex().success_msg("Bien joué. Maintenant que vous savez comment lister les fichiers et les répertoires, voyons comment vous pouvez vous déplacer dans le système de fichiers !")
```

---

## Comment puis-je me déplacer vers un autre répertoire?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

Tout comme vous pouvez naviguer dans un explorateur de fichiers en double-cliquant sur des dossiers,
vous pouvez vous déplacer dans le système de fichiers avec la commande `cd`
(abréviation de « change directory », soit « changer de répertoire »).

Si vous tapez `cd seasonal` puis `pwd`,
le shell vous indiquera que vous êtes maintenant dans `/home/repl/seasonal`.
Si vous exécutez ensuite `ls` seul,
il vous montre le contenu de `/home/repl/seasonal`,
car c'est là où vous vous trouvez.
Si vous voulez revenir à votre répertoire personnel `/home/repl`,
vous pouvez utiliser la commande `cd /home/repl`.

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
Vous êtes dans `/home/repl`/.
Changez de répertoire vers `/home/repl/seasonal` en utilisant un chemin relatif.

`@hint`
Rappelez-vous que `cd` signifie « change directory » (changer de répertoire) et que les chemins relatifs ne commencent pas par un « / » initial.

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
key: e69c8eac15
xp: 35
```

`@instructions`
Utilisez `pwd` pour vérifier que vous y êtes.

`@hint`
N'oubliez pas d'appuyer sur « enter » ou « return » après avoir saisi la commande.

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
Utilisez `ls` sans indiquer de chemin pour voir ce que contient ce répertoire.

`@hint`
N'oubliez pas d'appuyer sur « enter » ou « return » après la commande.

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
      has_code('ls', incorrect_msg="Votre commande n'a pas généré la sortie correcte. Avez-vous utilisé `ls` sans chemins pour afficher le contenu du répertoire actuel ?")
    )
)

Ex().success_msg("Super ! Il s'agissait de naviguer vers des sous-répertoires. Qu'en est-il de remonter ? Découvrons-le !")
```

---

## Comment puis-je remonter d'un répertoire?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

Le **parent** d'un répertoire est le répertoire situé au-dessus de lui.
Par exemple, `/home` est le parent de `/home/repl`,
et `/home/repl` est le parent de `/home/repl/seasonal`.
Vous pouvez toujours donner le chemin absolu de votre répertoire parent à des commandes comme `cd` et `ls`.
Le plus souvent,
cependant,
vous profiterez du fait que le chemin spécial `..`
(deux points sans espace) signifie « le répertoire au-dessus de celui où je me trouve ».
Si vous êtes dans `/home/repl/seasonal`,
alors `cd ..` vous fait remonter à `/home/repl`.
Si vous utilisez `cd ..` encore une fois,
ça vous place dans `/home`.
Un autre `cd ..` vous amène au *répertoire racine* `/`,
qui est le tout en haut du système de fichiers.
(N'oubliez pas de mettre un espace entre `cd` et `..` — c'est une commande et un chemin, pas une seule commande de quatre lettres.)

Un seul point, `.`, signifie toujours « le répertoire courant »,
donc `ls` seul et `ls .` font la même chose,
tandis que `cd .` n'a aucun effet
(parce que cela vous déplace dans le répertoire où vous êtes déjà).

Un dernier chemin spécial est `~` (le caractère tilde),
qui signifie « votre répertoire personnel »,
comme `/home/repl`.
Peu importe où vous êtes,
`ls ~` listera toujours le contenu de votre répertoire personnel,
et `cd ~` vous ramènera toujours à la maison.

<hr>
Si vous êtes dans `/home/repl/seasonal`,
où vous amène `cd ~/../.`?

`@hint`
Suivez le chemin un répertoire à la fois.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (le répertoire racine)

`@feedback`
- Non, mais `~` ou `..` seul vous y amènerait.
- Correct! Le chemin signifie « répertoire personnel », « un niveau au-dessus », « ici ».
- Non, mais `.` seul ferait cela.
- Non, la dernière partie du chemin est `.` (qui veut dire « ici ») plutôt que `..` (qui veut dire « au-dessus »).

---

## Comment puis-je copier des fichiers ?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

Vous voudrez souvent copier des fichiers,
les déplacer dans d'autres répertoires pour les organiser
ou les renommer.
Une commande pour faire cela est `cp`, qui est l'abréviation de « copy ».
Si `original.txt` est un fichier existant,
alors :

```{shell}
cp original.txt duplicate.txt
```

crée une copie de `original.txt` nommée `duplicate.txt`.
S'il existait déjà un fichier nommé `duplicate.txt`,
il est remplacé.
Si le dernier paramètre de `cp` est un répertoire existant,
alors une commande comme :

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

copie *tous* les fichiers dans ce répertoire.

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
Faites une copie de `seasonal/summer.csv` dans le répertoire `backup` (qui se trouve aussi dans `/home/repl`),
en nommant le nouveau fichier `summer.bck`.

`@hint`
Combinez le nom du répertoire de destination et le nom du fichier copié
pour créer un chemin relatif vers le nouveau fichier.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` ne semble pas exister dans le répertoire `backup`. Fournissez deux chemins à `cp` : le fichier existant (`seasonal/summer.csv`) et le fichier de destination (`backup/summer.bck`)."),
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
Copiez `spring.csv` et `summer.csv` du répertoire `seasonal` vers le répertoire `backup`
sans changer votre répertoire de travail actuel (`/home/repl`).

`@hint`
Utilisez `cp` avec les noms des fichiers à copier
puis le nom du répertoire où les copier.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s` ne semble pas avoir été copié dans le répertoire `backup`. Fournissez deux noms de fichiers et un nom de répertoire à `cp`."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="Assurez-vous de copier les fichiers tout en étant dans `{{dir}}` ! Utilisez `cd {{dir}}` pour y retourner."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("Bon travail. En plus de copier, nous devrions également être capables de déplacer des fichiers d'un répertoire à un autre. Apprenez-en plus dans l'exercice suivant !")
```

---

## Comment puis-je déplacer un fichier?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

Alors que `cp` copie un fichier,
`mv` le déplace d'un répertoire à un autre,
comme si vous l'aviez glissé dans un explorateur de fichiers graphique.
Il gère ses paramètres de la même façon que `cp`,
donc la commande :

```{shell}
mv autumn.csv winter.csv ..
```

déplace les fichiers `autumn.csv` et `winter.csv` du répertoire de travail actuel
vers le niveau supérieur, soit son répertoire parent
(parce que `..` fait toujours référence au répertoire au-dessus de votre emplacement actuel).

`@instructions`
Vous êtes dans `/home/repl`, qui contient les sous-répertoires `seasonal` et `backup`.
En une seule commande, déplacez `spring.csv` et `summer.csv` de `seasonal` vers `backup`.

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
backup_patt="Le fichier `%s` n'est pas dans le répertoire `backup`. Avez-vous utilisé `mv` correctement ? Utilisez deux noms de fichiers et un répertoire comme paramètres pour `mv`."
seasonal_patt="Le fichier `%s` est toujours dans le répertoire `seasonal`. Assurez-vous de déplacer les fichiers avec `mv` plutôt que de les copier avec `cp` !"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("Bien joué, continuons sur cette lancée avec le shell !")
```

---

## Comment puis-je renommer des fichiers ?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv` peut aussi servir à renommer des fichiers. Si vous exécutez :

```{shell}
mv course.txt old-course.txt
```

alors le fichier `course.txt` dans le répertoire de travail actuel est « déplacé » vers le fichier `old-course.txt`.
Ce comportement diffère de celui des explorateurs de fichiers,
mais il est souvent très pratique.

Attention :
comme `cp`,
`mv` écrase les fichiers existants.
Si,
par exemple,
vous avez déjà un fichier nommé `old-course.txt`,
alors la commande ci-dessus le remplacera par le contenu de `course.txt`.

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
Allez dans le répertoire `seasonal`.

`@hint`
Rappelez-vous que `cd` signifie « changer de répertoire » et que les chemins relatifs ne commencent pas par un « / » initial.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
Renommez le fichier `winter.csv` en `winter.csv.bck`.

`@hint`
Utilisez `mv` avec, dans cet ordre, le nom actuel du fichier puis le nouveau nom souhaité.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " Utilisez `mv` avec deux arguments : le fichier que vous souhaitez renommer (`winter.csv`) et le nouveau nom pour le fichier (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="Nous nous attendions à trouver `winter.csv.bck` dans le répertoire." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="Nous ne nous attendions plus à ce que `winter.csv` soit dans le répertoire." + hint)
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
Exécutez `ls` pour vérifier que tout a bien fonctionné.

`@hint`
N'oubliez pas d'appuyer sur « enter » ou « return » pour exécuter la commande.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="Avez-vous utilisé `ls` pour lister le contenu de votre répertoire de travail actuel ?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "Votre commande n'a pas généré la liste de fichiers correcte. Utilisez `ls` sans arguments pour lister le contenu de votre répertoire de travail actuel.")
    )
)
Ex().success_msg("Copier, déplacer, renommer, vous avez tout compris ! Ensuite : supprimer des fichiers.")
```

---

## Comment puis-je supprimer des fichiers?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

Nous pouvons copier des fichiers et les déplacer;
pour les supprimer,
nous utilisons `rm`,
abréviation de « remove ».
Comme avec `cp` et `mv`,
vous pouvez donner à `rm` les noms de autant de fichiers que vous voulez, donc :

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

supprime à la fois `thesis.txt` et `backup/thesis-2017-08.txt`.

`rm` fait exactement ce que son nom indique,
et il le fait immédiatement :
contrairement aux gestionnaires de fichiers graphiques,
le shell n'a pas de corbeille ;
aussi, quand vous tapez la commande ci-dessus,
votre thèse est définitivement supprimée.

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
Vous êtes dans `/home/repl`.
Allez dans le répertoire `seasonal`.

`@hint`
Rappelez-vous que `cd` signifie « change directory » et qu'un chemin relatif ne commence pas par un « / ».

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
Supprimez `autumn.csv`.

`@hint`
Rappelez-vous que `rm` signifie « remove ».

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="Nous ne nous attendions pas à ce que `autumn.csv` soit encore dans le répertoire `seasonal`. Utilisez `rm` avec le chemin du fichier que vous souhaitez supprimer."),
    has_code('rm', incorrect_msg = 'Utilisez `rm` pour supprimer le fichier, plutôt que de le déplacer.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
Retournez à votre répertoire personnel.

`@hint`
Si vous utilisez `cd` sans chemin, vous retournez dans votre répertoire personnel.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="Utilisez `cd ..` ou `cd ~` pour revenir au répertoire personnel.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
Supprimez `seasonal/summer.csv` sans changer de répertoire de nouveau.

`@hint`
Rappelez-vous que `rm` signifie « remove ».

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="Nous ne nous attendions pas à ce que `summer.csv` soit encore dans le répertoire `seasonal`. Utilisez `rm` avec le chemin du fichier que vous souhaitez supprimer."),
    has_code('rm', incorrect_msg = 'Utilisez `rm` pour supprimer le fichier, plutôt que de le déplacer.')
)
Ex().success_msg("Impressionnant ! Passons au suivant !")
```

---

## Comment créer et supprimer des répertoires?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv` traite les répertoires de la même manière que les fichiers :
si vous êtes dans votre répertoire personnel et exécutez `mv seasonal by-season`,
par exemple,
`mv` change le nom du répertoire `seasonal` pour `by-season`.
Cependant,
`rm` fonctionne différemment.

Si vous essayez d'exécuter `rm` sur un répertoire,
le shell affiche un message d'erreur indiquant qu'il ne peut pas le faire,
principalement pour vous empêcher d'effacer par erreur un répertoire entier rempli de travail.
À la place,
vous pouvez utiliser une commande distincte appelée `rmdir`.
Par mesure de sécurité supplémentaire,
elle fonctionne seulement lorsque le répertoire est vide,
vous devez donc supprimer les fichiers d'un répertoire *avant* de supprimer le répertoire.
(Les utilisateurs chevronnés peuvent utiliser l'option `-r` de `rm` pour obtenir le même effet ;
nous aborderons les options de commande au prochain chapitre.)

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
Sans changer de répertoire,
supprimez le fichier `agarwal.txt` dans le répertoire `people`.

`@hint`
Rappelez-vous que `rm` signifie « remove » et qu'un chemin relatif ne commence pas par un « / ».

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt` ne devrait plus être dans `/home/repl/people`. Avez-vous utilisé `rm` correctement ?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = 'Il y a encore des fichiers dans le répertoire `people`. Si vous avez simplement déplacé `agarwal.txt`, ou créé de nouveaux fichiers, supprimez-les tous.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
Maintenant que le répertoire `people` est vide,
utilisez une seule commande pour le supprimer.

`@hint`
Rappelez-vous que `rm` ne fonctionne que sur les fichiers.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "Le répertoire 'people' ne devrait plus être dans votre répertoire personnel. Utilisez `rmdir` pour le supprimer !")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
Comme un répertoire n'est pas un fichier,
vous devez utiliser la commande `mkdir directory_name`
pour créer un nouveau répertoire (vide).
Utilisez cette commande pour créer un nouveau répertoire nommé `yearly` sous votre répertoire personnel.

`@hint`
Exécutez `mkdir` avec le nom du répertoire que vous voulez créer.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="Il n'y a pas de répertoire `yearly` dans votre répertoire personnel. Utilisez `mkdir yearly` pour en créer un !")
)

```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
Maintenant que `yearly` existe,
créez un autre répertoire nommé `2017` à l'intérieur,
*sans* quitter votre répertoire personnel.

`@hint`
Utilisez un chemin relatif pour le sous-répertoire que vous voulez créer.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="Impossible de trouver un répertoire '2017' dans '/home/repl/yearly'. Vous pouvez créer ce répertoire en utilisant le chemin relatif `yearly/2017`.")
)
Ex().success_msg("Cool ! Terminons ce chapitre par un exercice qui répète certains de ses concepts !")
```

---

## En conclusion

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

Il vous arrivera souvent de créer des fichiers intermédiaires lors de l'analyse de données.
Plutôt que de les enregistrer dans votre répertoire personnel,
vous pouvez les placer dans `/tmp`,
où les personnes et les programmes gardent souvent des fichiers dont ils n'ont besoin que brièvement.
(Notez que `/tmp` se trouve directement sous le répertoire racine `/`,
et non pas sous votre répertoire personnel.)
Cet exercice de conclusion vous montrera comment faire.

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
Utilisez `cd` pour aller dans `/tmp`.

`@hint`
Rappelez-vous que `cd` signifie « change directory » (changer de répertoire) et qu'un chemin absolu commence par « / ».

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = 'Vous êtes dans le mauvais répertoire. Utilisez `cd` pour changer de répertoire vers `/tmp`.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
Listez le contenu de `/tmp` sans saisir de nom de répertoire.

`@hint`
Si vous ne dites pas à `ls` quoi lister, il affiche le contenu de votre répertoire courant.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "Vous n'avez pas appelé `ls` pour générer la liste des fichiers."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "Votre commande n'a pas généré la liste correcte des fichiers. Utilisez `ls` sans rien d'autre.")
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
Créez un nouveau répertoire dans `/tmp` nommé `scratch`.

`@hint`
Utilisez `mkdir` pour créer des répertoires.

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
      has_code('mkdir +scratch', incorrect_msg="Impossible de trouver un répertoire 'scratch' sous '/tmp'. Assurez-vous d'utiliser correctement `mkdir`.")
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
Déplacez `/home/repl/people/agarwal.txt` vers `/tmp/scratch`.
Nous vous suggérons d'utiliser le raccourci `~` pour votre répertoire personnel et un chemin relatif pour le second plutôt que le chemin absolu.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="Impossible de trouver 'agarwal.txt' dans '/tmp/scratch'. Utilisez `mv` avec `~/people/agarwal.txt` comme premier paramètre et `scratch` comme second.")
)
Ex().success_msg("Cela conclut le Chapitre 1 de l'Introduction au Shell ! Passez rapidement au chapitre suivant pour en savoir plus sur la manipulation des données !")
```

---
title: Manipulação de dados
description: >-
  Os comandos que você viu no capítulo anterior permitiram que você movesse
  coisas no sistema de arquivos. Este capítulo mostrará como trabalhar com os
  dados nesses arquivos. As ferramentas que usaremos são bastante simples, mas
  são componentes básicos sólidos.
lessons:
  - nb_of_exercises: 12
    title: Como posso visualizar o conteúdo de um arquivo?
---

## Como posso visualizar o conteúdo de um arquivo?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

Antes de renomear ou excluir arquivos,
você pode querer inspecionar o conteúdo deles.
A maneira mais simples de fazer isso é com `cat`,
que apenas imprime o conteúdo dos arquivos na tela.
(Seu nome é a abreviação de "concatenar", que significa "unir coisas",
já que ele imprimirá todos os arquivos cujos nomes você fornecer, um após o outro).

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
Imprima o conteúdo de `course.txt` na tela.

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
    has_expr_output(incorrect_msg="Seu comando não gerou a saída correta. Você usou `cat` seguido pelo nome do arquivo, `course.txt`?")
)
Ex().success_msg("Legal! Vamos ver outras maneiras de visualizar o conteúdo de um arquivo.")
```

---

## Como posso visualizar o conteúdo de um arquivo, uma parte de cada vez?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

Você pode usar `cat` para imprimir arquivos grandes e, em seguida, percorrer a saída,
mas geralmente é mais conveniente **paginar** a saída.
O comando original para fazer isso se chamava `more` (mais),
mas ele foi substituído por um comando mais poderoso chamado `less`(menos).
(O povo do Unix acha graça nesse tipo de nomenclatura.)
Quando você usa `less` em um arquivo,
uma página é exibida por vez;
pode pressionar a barra de espaço para descer a página ou digitar `q` para sair.

Se você der os nomes de vários arquivos para o `less`,
pode digitar `:n` (dois pontos e um 'n' minúsculo) para ir para o próximo arquivo,
`:p` para voltar ao anterior,
ou `:q` para encerrar.

Observação: Se você visualizar as soluções dos exercícios que usam `less`,
verá um comando extra no final que *desativa* a paginação
para podermos testar as soluções com eficiência.

`@instructions`
Use `less seasonal/spring.csv seasonal/summer.csv` para visualizar esses dois arquivos nessa ordem.
Pressione a barra de espaço para descer a página, `:n` para ir para o segundo arquivo e `:q` para sair.

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
                 incorrect_msg='Use `less` e os nomes dos arquivos. Lembre-se de que `:n` move você para o próximo arquivo.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## Como posso ver o início de um arquivo?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

A primeira coisa que a maioria dos cientistas de dados faz quando recebe um novo conjunto de dados para analisar é
descobrir quais campos ele contém e quais os valores desses campos.
Se o conjunto de dados tiver sido exportado de um banco de dados ou planilha,
muitas vezes será armazenado como **valores separados por vírgulas** (CSV).
Uma maneira rápida de descobrir o que ele contém é observar as primeiras linhas.

Você pode fazer isso no shell usando um comando chamado `head` (cabeça).
Como o próprio nome sugere,
ele imprime as primeiras poucas linhas de um arquivo
(onde "poucas" significa 10),
portanto, o comando:

```{shell}
head seasonal/summer.csv
```

exibe:

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

O que o `head` faz se o arquivo não tiver 10 linhas?
(Para descobrir, use-o para ver o começo do arquivo `people/agarwal.txt`.)

`@possible_answers`
- Imprimir uma mensagem de erro porque o arquivo é muito curto.
- Exibir quantas linhas ele tiver.
- Exibir linhas em branco suficientes para completar o total de 10.

`@hint`
Qual é a coisa mais útil que ele poderia fazer?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["Incorreto: isso não é a coisa mais útil que poderia fazer.",
                    "Correto!",
                    "Incorreto: isso seria impossível de distinguir de um arquivo que terminasse com um monte de linhas em branco."])
```

---

## Como posso digitar menos?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

Uma das ferramentas poderosas do shell é o **preenchimento de tabulação**.
Se você começar a digitar o nome de um arquivo e depois pressionar a tecla tab,
o shell fará o possível para completar automaticamente o caminho.
Por exemplo:
se você digitar `sea` e pressionar a tecla tab,
ele preencherá o nome do diretório `seasonal/` (com uma barra à direita).
Se você digitar `a` e pressionar a tecla tab,
ele completará o caminho como `seasonal/autumn.csv`.

Se o caminho for ambíguo,
como `seasonal/s`,
pressionar tab de novo exibirá uma lista de possibilidades.
Digitar mais um ou dois caracteres para tornar seu caminho mais específico
e depois pressionar a tecla tab
preencherá o restante do nome.

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
Execute `head seasonal/autumn.csv` sem digitar o nome completo do arquivo.

`@hint`
Digite o caminho que você precisar, pressione a tecla tab e repita.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="O verificador não conseguiu encontrar a saída correta no seu comando. Você tem certeza de que chamou `head` em `seasonal/autumn.csv`?")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
Execute `head seasonal/spring.csv` sem digitar o nome completo do arquivo.

`@hint`
Digite o caminho que você precisar, pressione a tecla tab e repita.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="O verificador não conseguiu encontrar a saída correta no seu comando. Você tem certeza de que chamou `head` em `seasonal/spring.csv`?")
)
Ex().success_msg("Bom trabalho! Quando você se acostumar a usar a conclusão de tabulação, isso economizará muito do seu tempo!")
```

---

## Como posso controlar o que os comandos fazem?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

Você nem sempre vai querer ver as 10 primeiras linhas de um arquivo,
por isso, o shell permite que você altere o comportamento de `head`
dando a ele um **sinalizador de linha de comando** (ou apenas "sinalizador").
Se você executar o comando:

```{shell}
head -n 3 seasonal/summer.csv
```

`head` exibirá apenas as três primeiras linhas do arquivo.
Se você executar `head -n 100`,
ele exibirá as primeiras 100 (supondo que ele tenha essa quantidade),
e assim por diante.

O nome de um sinalizador geralmente indica sua finalidade
(por exemplo, `-n` serve para indicar "**n**úmero de linhas").
Os sinalizadores de comando não precisam ser um `-` seguido de uma única letra,
mas é uma convenção amplamente utilizada.

Observação: é considerado um bom estilo colocar todos os sinalizadores *antes* de qualquer nome de arquivo,
portanto, neste curso,
só aceitamos respostas que sigam esse estilo.

`@instructions`
Exiba as primeiras 5 linhas de `winter.csv` no diretório `seasonal`.

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
        has_expr_output(incorrect_msg="Você tem certeza de que está chamando `head` no arquivo `seasonal/winter.csv`?"),
        has_expr_output(strict=True, incorrect_msg="Você tem certeza de que usou a flag `-n 5`?")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "Você tem certeza de que usou a flag `-n 5`?")
)
Ex().success_msg("Legal! Com essa técnica, você pode evitar que seu shell trave se quiser dar uma olhada em arquivos de texto maiores.")
```

---

## Como posso listar tudo abaixo de um diretório?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

Para que você possa ver tudo o que está abaixo de um diretório,
independentemente da profundidade do aninhamento,
você pode usar o sinalizador `-R` com o `ls`
(que significa "recursivo").
Se você usar `ls -R` em seu diretório pessoal,
verá algo parecido com isto:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

Isso mostra todos os arquivos e diretórios no nível atual,
e depois tudo em cada subdiretório,
e assim por diante.

`@instructions`
Para ajudar você a saber o que é o quê,
`ls` tem outro sinalizador `-F` que imprime um `/` após o nome de cada diretório
e um `*` após o nome de cada programa executável.
Execute `ls` com os dois sinalizadores, `-R` e `-F`, e o caminho absoluto para o seu diretório pessoal
para ver tudo o que ele contém.
(A ordem dos sinalizadores não importa, mas o nome do diretório deve vir por último.)

`@hint`
Seu diretório pessoal pode ser especificado usando `~` ou `.` ou o caminho absoluto.

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
  has_expr_output(incorrect_msg='Use either `ls -R -F` or `ls -F -R` and the path `/home/repl`.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='Use either `ls -R -F` or `ls -F -R` and the path `/home/repl`.')
)
Ex().success_msg("Isso é uma visão geral bem legal, não é?")

```

---

## Como posso obter ajuda para um comando?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

Para saber o que os comandos fazem,
As pessoas costumavam usar o comando `man`
(abreviação de "manual").
Por exemplo:
O comando `man head` exibe essas informações:

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

`man` invoca automaticamente `less`,
Portanto, talvez você precise pressionar a barra de espaço para percorrer as informações
e `:q` para sair.

A descrição de uma linha em `NAME` informa brevemente o que o comando faz,
e o resumo em `SYNOPSIS` lista todos os sinalizadores que ele entende.
Tudo o que for opcional é mostrado entre colchetes `[...]`,
As alternativas "ou/ou" são separadas por `|`,
e as coisas que podem ser repetidas são mostradas com `...`,
Portanto, a página de manual referente ao `head` informa que você *pode* fornecer uma contagem de linhas com `-n`
ou uma contagem de bytes com `-c`,
e que você pode informar quantos nomes de arquivos quiser.

O problema com o manual do Unix é que você precisa saber o que está procurando.
Se não souber,
pode pesquisar no [Stack Overflow](https://stackoverflow.com/),
fazer uma pergunta nos canais do Slack do DataCamp,
ou consultar as seções `SEE ALSO` dos comandos que já conhece.

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
Leia a página do manual correspondente ao comando `tail` para descobrir
o que acontece se você colocar um sinal de `+` na frente do número usado com o sinalizador `-n`.
(Lembre-se de pressionar a barra de espaço para descer a página e/ou digitar `q` para sair).

`@hint`
Lembre-se: `man` é a abreviação de "manual".

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='Use `man` e o nome do comando.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
Use `tail` com o sinalizador `-n +7` para exibir todas as linhas de `seasonal/spring.csv`,* exceto* as seis primeiras.

`@hint`
Use o sinal de adição "+" antes do número de linhas que você deseja exibir.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="Você está chamando `tail` em `seasonal/spring.csv`?"),
    has_expr_output(strict=True, incorrect_msg="Você tem certeza de que usou a flag `-n +7`?")
)
```

---

## Como posso selecionar as colunas de um arquivo?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head` e `tail` permitem que você selecione linhas de um arquivo de texto.
Se você quiser selecionar colunas,
pode usar o comando `cut`.
Ele tem várias opções (use `man cut` para explorá-las),
mas o mais comum é algo como:

```{shell}
cut -f 2-5,8 -d , values.csv
```

que significa
"selecione as colunas de 2 até 5 e a coluna 8,
usando vírgula como separador".
`cut` usa `-f` (que significa "campos") para especificar colunas
e `-d` (que significa "delimitador") para especificar o separador.
Você precisa especificar o delimitador porque alguns arquivos podem usar espaços, tabulações ou dois pontos para separar colunas.

<hr>

Que comando seleciona a primeira coluna (contendo datas) do arquivo `spring.csv`?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- Qualquer uma das opções acima.
- Nenhuma das opções acima, porque `-f` deve vir antes de `-d`.

`@hint`
A ordem dos sinalizadores não importa.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Sim, mas isso não é tudo', 'Sim, mas isso não é tudo', 'Correto! Adicionar um espaço após a flag é um bom estilo, mas não é obrigatório.', 'Não, a ordem das flags não importa'])
```

---

## O que o cut não pode fazer?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut` é um comando simplório.
Especificamente,
ele não entende cadeias de caracteres entre aspas.
Por exemplo, se o seu arquivo for:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

então:

```{shell}
cut -f 2 -d , everyone.csv
```

ele produzirá:

```
Age
Ranjit"
Rupinder"
```

em vez da idade de cada um,
porque ele pensará que a vírgula entre o sobrenome e o nome é um separador de coluna.

<hr>

Qual é a saída de `cut -d : -f 2-4` na linha:

```
first:second:third:
```

(Observe os dois pontos no final.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- Nenhuma das opções acima, porque não há quatro campos.

`@hint`
Preste atenção aos dois pontos no final.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['Não, há mais.', 'Não, há mais.', 'Correto! O dois-pontos no final cria um quarto campo vazio.', 'Não, `cut` faz o melhor que pode.'])
```

---

## Como posso repetir comandos?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

Uma das maiores vantagens de usar o shell é que
é mais fácil repetir comandos.
Se você executar alguns comandos,
pode pressionar a tecla de seta para cima para executá-los novamente.
Você também pode usar as teclas de seta para a esquerda e para a direita e a tecla Delete para editá-los.
Ao pressionar enter, ele executará o comando modificado.

Melhor ainda, `history` imprimirá uma lista dos comandos que você executou recentemente.
Cada um deles é precedido por um número de série para facilitar a reexecução de comandos específicos:
basta digitar `!55` para executar novamente o 55º comando do seu histórico (se você tiver tantos assim).
Você também pode executar novamente um comando digitando um ponto de exclamação seguido do nome do comando,
como `!head` ou `!cut`,
que executará novamente a operação mais recente desse comando.

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
Execute `head summer.csv` em seu diretório pessoal (que deve falhar).

`@hint`
O preenchimento de tabulação não funcionará se não houver um nome de arquivo correspondente.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="Use `head` e um nome de arquivo, `summer.csv`. Não se preocupe se falhar. Deveria.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
Mude para o diretório `seasonal`.

`@hint`
Lembre-se de que `cd` significa "change directory" ((mudar de diretório).

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="Se o seu diretório de trabalho atual (descubra com `pwd`) é `/home/repl`, você pode mover para a pasta `seasonal` com `cd seasonal`.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
Execute novamente o comando `head` com `!head`.

`@hint`
Não digite nenhum espaço entre `!` e o que vem a seguir.

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
                        incorrect_msg='Use `!head` para repetir o comando `head`.'),
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
Use `history` para ver o que você fez.

`@hint`
Observe que `history` mostra os comandos mais recentes por último, para que eles permaneçam na tela quando a execução terminar.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='Use `history` sem flags para obter uma lista de comandos anteriores.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
Execute `head` novamente usando `!` seguido de um número de comando.

`@hint`
*Não* digite nenhum espaço entre `!` e o que vem a seguir.

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
                        incorrect_msg='Você usou `!<um_número>` para executar novamente o último `head` do histórico?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("Muito bem! Vamos para a próxima!")

```

---

## Como posso selecionar as linhas que contêm determinados valores?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head` e `tail` selecionam linhas,
`cut` seleciona colunas,
e `grep` seleciona as linhas de acordo com o que elas contêm.
Em sua forma mais simples,
`grep` recebe um texto seguido de um ou mais nomes de arquivos
e imprime todas as linhas dos arquivos que contêm esse texto.
Por exemplo:
`grep bicuspid seasonal/winter.csv`
imprime as linhas do arquivo `winter.csv` que contêm "bicuspid".

`grep` também pode pesquisar padrões;
Vamos explorá-los no próximo curso.
O que é mais importante neste momento são alguns dos sinalizadores mais comuns do `grep`:

- `-c`: imprime a contagem de linhas correspondentes em vez das próprias linhas
- `-h`*não* imprime os nomes dos arquivos ao pesquisar vários arquivos
- `-i`:não diferencia maiúsculas de minúsculas (por exemplo, trate "Regression" e "regression" como correspondências)
- `-l`: imprime os nomes dos arquivos que contêm correspondências, não as correspondências
- `-n`: imprime os números das linhas que têm correspondências
- `-v`: inverte a correspondência, ou seja, mostra apenas as linhas que *não* correspondem

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
Imprima o conteúdo de todas as linhas que contêm a palavra `molar` em `seasonal/autumn.csv`
executando um único comando em seu diretório pessoal. Não use nenhum sinalizador.

`@hint`
Use `grep` com a palavra que você está pesquisando e o nome do(s) arquivo(s) a ser(em) pesquisado(s).

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
      has_code("grep", incorrect_msg = "Você chamou `grep`?"),
      has_code("molar", incorrect_msg = "Você procurou por `molar`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Você procurou no arquivo `seasonal/autumn.csv`?")
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
Inverta a correspondência para encontrar todas as linhas que *não* contêm a palavra `molar` em `seasonal/spring.csv` e mostre os números das linhas.
Lembre-se de que é considerado um bom estilo colocar todos os sinalizadores *antes* dos outros valores, como nomes de arquivos ou o termo de pesquisa "molar".

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
      has_code("grep", incorrect_msg = "Você chamou `grep`?"),
      has_code("-v", incorrect_msg = "Você inverteu a correspondência com `-v`?"),
      has_code("-n", incorrect_msg = "Você mostrou os números das linhas com `-n`?"),
      has_code("molar", incorrect_msg = "Você procurou por `molar`?"),
      has_code("seasonal/spring.csv", incorrect_msg = "Você procurou no arquivo `seasonal/spring.csv`?")
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
Conte quantas linhas contêm a palavra `incisor` em `autumn.csv` e `winter.csv` combinados.
(Novamente, execute um único comando em seu diretório pessoal).

`@hint`
Lembre-se de usar `-c` com `grep` para contar as linhas.

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
      has_code("grep", incorrect_msg = "Você chamou `grep`?"),
      has_code("-c", incorrect_msg = "Você obteve contagens com `-c`?"),
      has_code("incisor", incorrect_msg = "Você procurou por `incisor`?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "Você procurou no arquivo `seasonal/autumn.csv`?"),
      has_code("seasonal/winter.csv", incorrect_msg = "Você procurou no arquivo `seasonal/winter.csv`?")
    )
  )
)
```

---

## Por que não é sempre seguro tratar dados como texto?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

A seção `SEE ALSO` da página do manual para `cut` faz referência a um comando chamado `paste`
que pode ser usado para combinar arquivos de dados em vez de cortá-los.

<hr>

Leia a página do manual para `paste`,
e, em seguida, execute `paste` para combinar os arquivos de dados de autumn e winter em uma única tabela
usando uma vírgula como separador.
O que há de errado com o resultado do ponto de vista da análise de dados?

`@possible_answers`
- Os cabeçalhos das colunas são repetidos.
- As últimas linhas têm o número errado de colunas.
- Estão faltando alguns dos dados de `winter.csv`.

`@hint`
Se você cortar (`cut`) a saída do colar (`paste`) usando vírgulas como separadores,
obteria a resposta certa?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = 'Verdadeiro, mas não é necessariamente um erro.'
correct2 = 'Correto: juntar as linhas com colunas cria apenas uma coluna vazia no início, não duas.'
err3 = 'Não, todos os dados de inverno estão lá.'
Ex().has_chosen(2, [err1, correct2, err3])
```

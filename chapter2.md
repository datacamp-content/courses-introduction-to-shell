---
title: 데이터 다루기
description: >-
  이전 장에서 본 명령은 파일 시스템에서 항목을 이동하는 방법을 보여줬습니다. 이번 장에서는 그 파일 속 데이터로 작업하는 방법을 알아봐요.
  우리가 사용할 도구는 비교적 단순하지만, 탄탄한 기본 구성 요소예요.
lessons:
  - nb_of_exercises: 12
    title: 파일의 내용을 어떻게 볼 수 있을까요?
---

## 파일의 내용을 어떻게 볼 수 있나요?

```yaml
type: ConsoleExercise
key: 8acc09ede3
xp: 100
```

파일 이름을 바꾸거나 삭제하기 전에,
먼저 파일 내용부터 확인하고 싶을 때가 있어요.
가장 간단한 방법은 `cat`을 사용하는 것입니다.
이 명령은 파일의 내용을 화면에 그대로 출력해요.
(이름은 "concatenate"의 줄임말로, "여러 항목을 이어 붙이다"라는 뜻입니다.
여러 파일 이름을 넘기면, 지정한 순서대로 차례차례 출력해 줍니다.)

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
`course.txt`의 내용을 화면에 출력하세요.

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
    has_expr_output(incorrect_msg="명령이 올바른 출력을 생성하지 않았습니다. `cat`을 사용하고 파일 이름 `course.txt`를 뒤에 붙였는지 확인해 보세요.")
)
Ex().success_msg("좋습니다! 파일 내용을 보는 다른 방법을 살펴보겠습니다.")
```

---

## 파일 내용을 한 조각씩 살펴보려면 어떻게 하나요?

```yaml
type: ConsoleExercise
key: d8a30a3f81
xp: 100
```

큰 파일을 출력하려면 `cat`을 사용하고 스크롤해도 되지만,
보통은 출력 결과를 **페이지로 나눠** 보는 게 더 편합니다.
이때 쓰던 원래 명령은 `more`였지만,
지금은 더 강력한 `less`가 그 자리를 대신했습니다.
(이런 작명은 Unix 세계에서 통하는 농담이에요.)
파일에 `less`를 사용하면
한 번에 한 페이지씩 표시되며,
스페이스바로 아래로 내려가고 `q`로 종료할 수 있어요.

`less`에 여러 파일 이름을 주면,
다음 파일로 이동할 때는 `:n`(콜론과 소문자 n),
이전 파일로 돌아갈 때는 `:p`,
종료할 때는 `:q`를 입력하면 됩니다.

참고: `less`를 사용하는 연습 문제의 해답을 보면,
페이징을 테스트에 방해되지 않게 *끄는* 추가 명령이 마지막에 나옵니다.
그래야 여러분의 답안을 효율적으로 채점할 수 있어요.

`@instructions`
`less seasonal/spring.csv seasonal/summer.csv`를 사용해 두 파일을 그 순서대로 보세요.
스페이스바로 아래로 내려가고, 두 번째 파일로 갈 때는 `:n`, 종료하려면 `:q`를 누르세요.

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
                 incorrect_msg='`less`와 파일 이름을 사용하십시오. `:n`을 사용하면 다음 파일로 이동합니다.'),
        has_code(r'\s*less\s+seasonal/summer\.csv\s+seasonal/spring\.csv\s*')
    )
)
```

---

## 파일의 시작 부분은 어떻게 볼 수 있나요?

```yaml
type: MultipleChoiceExercise
key: 82bdc9af65
lang: shell
xp: 50
skills:
  - 1
```

새로운 데이터셋을 받으면, 대부분의 데이터 과학자는 가장 먼저
어떤 필드가 있고 각 필드에 어떤 값이 들어 있는지 파악합니다.
데이터베이스나 스프레드시트에서 내보낸 데이터셋이라면
대개 **comma-separated values**(CSV) 형식으로 저장됩니다.
내용을 빠르게 파악하는 좋은 방법은 처음 몇 행을 확인하는 것입니다.

셸에서는 `head`라는 명령으로 이를 할 수 있습니다.
이름에서 알 수 있듯이,
파일의 처음 몇 줄을 출력합니다
(여기서 "몇"은 10줄을 의미합니다),
따라서 다음 명령을 실행하면:

```{shell}
head seasonal/summer.csv
```

다음과 같이 표시됩니다:

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

파일에 10줄이 없으면 `head`는 무엇을 할까요?
(직접 확인해 보려면 `people/agarwal.txt`의 앞부분을 확인해 보세요.)

`@possible_answers`
- 파일이 너무 짧다고 오류 메시지를 출력한다.
- 있는 줄 수만큼만 표시한다.
- 총 10줄이 되도록 빈 줄을 채워서 표시한다.

`@hint`
가장 유용하게 할 수 있는 일은 무엇일까요?

`@pre_exercise_code`
```{python}

```

`@sct`
```{shell}
Ex().has_chosen(2, ["틀렸습니다: 그것은 가장 유용한 작업이 아닙니다.",
                    "정답입니다!",
                    "틀렸습니다: 그것은 빈 줄로 끝나는 파일과 구별할 수 없을 것입니다."])
```

---

## 입력을 줄이려면 어떻게 하나요?

```yaml
type: BulletConsoleExercise
key: 0b7b8ca8f7
xp: 100
```

셸의 강력한 도구 중 하나는 **탭 완성(tab completion)**이에요.
파일 이름을 조금 입력한 뒤 탭 키를 누르면,
셸이 경로를 자동으로 완성해 줍니다.
예를 들어,
`sea`를 입력하고 탭을 누르면
디렉터리 이름 `seasonal/`(끝에 슬래시 포함)을 채워 넣어요.
그다음 `a`를 입력하고 다시 탭을 누르면
경로가 `seasonal/autumn.csv`로 완성됩니다.

경로가 모호한 경우,
예를 들어 `seasonal/s`처럼 입력했을 때는,
탭을 한 번 더 누르면 가능한 목록이 표시돼요.
경로를 더 구체적으로 만들기 위해 한두 글자를 더 입력한 다음
다시 탭을 누르면
나머지 이름이 자동으로 채워집니다.

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
전체 파일 이름을 모두 입력하지 않고 `head seasonal/autumn.csv`를 실행하세요.

`@hint`
필요한 만큼 경로를 입력한 뒤 탭을 누르고, 이 과정을 반복하세요.

`@solution`
```{shell}
head seasonal/autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="채점기가 명령어에서 올바른 출력을 찾을 수 없습니다. `seasonal/autumn.csv`에 대해 `head`를 호출했는지 확인하십시오.")
)
```

***

```yaml
type: ConsoleExercise
key: e249266733
xp: 50
```

`@instructions`
전체 파일 이름을 모두 입력하지 않고 `head seasonal/spring.csv`를 실행하세요.

`@hint`
필요한 만큼 경로를 입력한 뒤 탭을 누르고, 이 과정을 반복하세요.

`@solution`
```{shell}
head seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_expr_output(incorrect_msg="채점기가 명령어에서 올바른 출력을 찾을 수 없습니다. `seasonal/spring.csv`에 대해 `head`를 호출했는지 확인하십시오.")
)
Ex().success_msg("잘하셨습니다! 탭 완성 기능에 익숙해지면 많은 시간을 절약할 수 있습니다!")
```

---

## 명령의 동작을 어떻게 제어할 수 있나요?

```yaml
type: ConsoleExercise
key: 9eb608f6c9
xp: 100
```

항상 파일의 처음 10줄만 보고 싶지는 않을 수 있어요.
그래서 셸에서는 **명령줄 플래그**(간단히 "플래그")를 사용해 `head`의 동작을 바꿀 수 있게 해줍니다.
다음 명령을 실행하면:

```{shell}
head -n 3 seasonal/summer.csv
```

`head`는 파일의 처음 세 줄만 표시합니다.
`head -n 100`을 실행하면
(그만큼 줄이 있다면) 처음 100줄을 표시하고,
이와 같은 방식으로 동작해요.

플래그 이름은 보통 용도를 나타냅니다
(예를 들어 `-n`은 "줄의 **n**개 수"를 의미합니다).
명령 플래그가 꼭 `-` 다음에 한 글자여야 하는 것은 아니지만,
널리 쓰이는 관례입니다.

참고: 모든 플래그를 파일 이름보다 *앞*에 두는 것이 좋은 스타일로 여겨집니다.
따라서 이 강의에서는
그 규칙을 따른 답만 정답으로 인정합니다.

`@instructions`
`seasonal` 디렉터리의 `winter.csv`에서 처음 5줄을 표시하세요.

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
        has_expr_output(incorrect_msg="`seasonal/winter.csv` 파일에서 `head`를 호출했는지 확인하십시오."),
        has_expr_output(strict=True, incorrect_msg="`-n 5` 플래그를 사용했는지 확인하십시오.")
    ),
    check_not(has_output("2017-02-17,incisor"), incorrect_msg = "`-n 5` 플래그를 사용했는지 확인하십시오.")
)
Ex().success_msg("좋습니다! 이 기술을 사용하면 더 큰 텍스트 파일을 보고 싶을 때 셸이 중단되는 것을 방지할 수 있습니다.")
```

---

## 디렉터리 아래의 모든 항목을 어떻게 나열할 수 있나요?

```yaml
type: ConsoleExercise
key: f830d46419
xp: 100
```

디렉터리 아래에 있는 모든 항목을,
얼마나 깊게 중첩되어 있든 전부 보려면,
`ls`에 `-R` 플래그(“recursive”, 재귀적의 약자)를 주면 됩니다.
홈 디렉터리에서 `ls -R`을 사용하면
다음과 비슷한 결과를 볼 거예요:

```
backup          course.txt      people          seasonal

./backup:

./people:
agarwal.txt

./seasonal:
autumn.csv      spring.csv      summer.csv      winter.csv
```

이 출력은 현재 단계의 모든 파일과 디렉터리를 보여주고,
그다음 각 하위 디렉터리의 모든 항목을,
이와 같은 방식으로 계속 보여줍니다.

`@instructions`
무엇이 무엇인지 쉽게 구분할 수 있도록,
`ls`에는 이름 뒤에 디렉터리에는 `/`, 실행 가능한 프로그램에는 `*`를 붙여 출력하는 또 다른 플래그 `-F`가 있어요.
두 플래그 `-R`과 `-F`를 함께 사용하고,
홈 디렉터리의 절대 경로를 인자로 주어 그 안의 모든 내용을 확인해 보세요.
(플래그의 순서는 중요하지 않지만, 디렉터리 이름은 반드시 마지막에 와야 합니다.)

`@hint`
홈 디렉터리는 `~` 또는 `.` 또는 절대 경로로 지정할 수 있어요.

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
  has_expr_output(incorrect_msg='`ls -R -F` 또는 `ls -F -R`와 경로 `/home/repl`을 사용하십시오.'),
  has_expr_output(expr = "ls -R -F .", incorrect_msg='`ls -R -F` 또는 `ls -F -R`와 경로 `/home/repl`을 사용하십시오.')
)
Ex().success_msg('꽤 깔끔한 개요죠, 그렇지 않습니까?')
```

---

## 명령어에 대한 도움말은 어떻게 볼 수 있나요?

```yaml
type: BulletConsoleExercise
key: 7b90b8a7cd
xp: 100
```

명령어가 무엇을 하는지 알아볼 때는 예전에는 `man` 명령어(“manual”의 줄임말)를 자주 썼습니다.
예를 들어, `man head` 명령어를 실행하면 다음과 같은 정보가 나옵니다:

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

`man`은 자동으로 `less`를 호출하므로,
정보를 페이지별로 넘기려면 스페이스바를 누르고,
종료하려면 `:q`를 입력해야 할 수 있습니다.

`NAME` 아래의 한 줄 설명은 명령어가 무엇을 하는지 간단히 알려 주고,
`SYNOPSIS` 아래의 요약에는 해당 명령어가 인식하는 모든 플래그가 나열됩니다.
대괄호 `[...]` 안은 선택 사항을, 파이프 `|`는 선택지 중 하나를,
줄임표 `...`는 반복 가능함을 의미합니다.
따라서 `head`의 매뉴얼 페이지는 `-n`으로 줄 수를 지정하거나 `-c`로 바이트 수를 지정할 수 있으며,
파일 이름은 원하는 만큼 줄 수 있음을 알려 줍니다.

Unix 매뉴얼의 문제는 무엇을 찾아야 하는지 미리 알고 있어야 한다는 점입니다.
모르겠다면 [Stack Overflow](https://stackoverflow.com/)에서 검색하거나,
DataCamp의 Slack 채널에 질문하거나,
이미 아는 명령어의 `SEE ALSO` 섹션을 살펴보세요.

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
`tail` 명령어의 매뉴얼 페이지를 읽어,
`-n` 플래그에 사용하는 숫자 앞에 `+` 기호를 붙이면 무엇이 달라지는지 알아보세요.
(아래로 넘기려면 스페이스바, 종료하려면 `q`를 누르세요.)

`@hint`
기억하세요: `man`은 "manual"의 줄임말입니다.

`@solution`
```{shell}
# Run the following command *without* '| cat':
man tail | cat

```

`@sct`
```{python}
Ex().has_code(r'\s*man\s+tail.*', incorrect_msg='`man`과 명령어 이름을 사용하십시오.')
```

***

```yaml
type: ConsoleExercise
key: 6a07958ae0
xp: 50
```

`@instructions`
`tail`에 `-n +7` 플래그를 사용해 `seasonal/spring.csv`의 앞 여섯 줄을 제외한 나머지 모든 줄을 표시하세요.

`@hint`
표시하고 싶은 줄 수 앞에 플러스 기호 '+'를 붙이세요.

`@solution`
```{shell}
tail -n +7 seasonal/spring.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_output('2017-09-07,molar', incorrect_msg="`seasonal/spring.csv`에 대해 `tail`을 호출하고 있습니까?"),
    has_expr_output(strict=True, incorrect_msg="`-n +7` 플래그를 사용했는지 확인하셨습니까?")
)
```

---

## 파일에서 특정 열만 선택하려면 어떻게 하나요?

```yaml
type: MultipleChoiceExercise
key: 925e9d645a
xp: 50
```

`head`와 `tail`은 텍스트 파일에서 행을 선택할 수 있어요.
열을 선택하려면 `cut` 명령을 사용할 수 있어요.
여러 옵션이 있으며(자세한 내용은 `man cut`에서 확인하세요),
가장 흔한 사용 예는 다음과 같아요:

```{shell}
cut -f 2-5,8 -d , values.csv
```

이 명령은
"쉼표를 구분자로 사용하여,
2번부터 5번 열과 8번 열을 선택"한다는 뜻이에요.
`cut`은 열을 지정할 때 `-f`("fields"의 약자)를,
구분자를 지정할 때 `-d`("delimiter"의 약자)를 사용해요.
일부 파일은 열을 구분할 때 공백, 탭, 콜론 등을 사용할 수 있으므로, 구분자는 반드시 지정해야 해요.

<hr>

파일 `spring.csv`에서 첫 번째 열(날짜가 들어 있는 열)만 선택하려면 어떤 명령을 사용해야 하나요?

`@possible_answers`
- `cut -d , -f 1 seasonal/spring.csv`
- `cut -d, -f1 seasonal/spring.csv`
- 위의 둘 다.
- 둘 다 아님. `-f`가 반드시 `-d`보다 먼저 와야 해서요.

`@hint`
플래그의 순서는 중요하지 않아요.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['예, 그러나 그것이 전부는 아닙니다', '예, 그러나 그것이 전부는 아닙니다', '정답입니다! 플래그 뒤에 공백을 추가하는 것은 좋은 스타일이지만 필수는 아닙니다.', '아니요, 플래그 순서는 중요하지 않습니다'])
```

---

## cut으로는 무엇을 할 수 없을까요?

```yaml
type: MultipleChoiceExercise
key: b9bb10ae87
xp: 50
```

`cut`은 단순한 명령입니다.
특히,
따옴표로 묶인 문자열을 이해하지 못합니다.
예를 들어, 파일이 다음과 같다면:

```
Name,Age
"Johel,Ranjit",28
"Sharma,Rupinder",26
```

다음 명령은:

```{shell}
cut -f 2 -d , everyone.csv
```

다음과 같은 출력을 만듭니다:

```
Age
Ranjit"
Rupinder"
```

모든 사람의 나이를 출력하는 대신 이렇게 되는 이유는,
성(last name)과 이름(first name) 사이의 쉼표를 열 구분자로 인식하기 때문입니다.

<hr>

다음 줄에 대해 `cut -d : -f 2-4`의 출력은 무엇인가요?

```
first:second:third:
```

(마지막에 콜론이 있다는 점을 참고하세요.)

`@possible_answers`
- `second`
- `second:third`
- `second:third:`
- 위의 어느 것도 아님. 필드가 네 개가 아니기 때문임.

`@hint`
마지막에 오는 콜론에 주의하세요.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(3, ['아니요, 더 있습니다.', '아니요, 더 있습니다.', '정답입니다! 뒤에 오는 콜론은 네 번째 빈 필드를 만듭니다.', '아니요, `cut`은 최선을 다합니다.'])
```

---

## 명령을 반복하려면 어떻게 하나요?

```yaml
type: TabConsoleExercise
key: 32c0d30049
xp: 100
```

셸을 사용하면 같은 작업을 다시 수행하기가 매우 쉽다는 점이 큰 장점이에요.
몇 가지 명령을 실행한 다음, 위쪽 화살표 키를 눌러 이전에 실행한 명령들을 순서대로 돌아볼 수 있어요.
왼쪽/오른쪽 화살표 키와 Delete 키로 명령을 편집할 수도 있어요.
그 상태에서 Enter를 누르면 수정한 명령이 실행됩니다.

더 나아가, `history`는 최근에 실행한 명령 목록을 출력해 줍니다.
각 명령 앞에는 일련번호가 붙어 있어서 특정 명령을 다시 실행하기가 쉬워요:
예를 들어, `!55`를 입력하면 히스토리에서 55번째 명령이 다시 실행됩니다(그만큼의 기록이 있다면요).
또한 느낌표 뒤에 명령 이름을 붙여서 해당 명령의 가장 최근 실행을 다시 수행할 수도 있어요.
예를 들어 `!head`나 `!cut`처럼 입력하면 됩니다.

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
홈 디렉터리에서 `head summer.csv`를 실행하세요(실패해야 합니다).

`@hint`
일치하는 파일 이름이 없으면 탭 자동 완성은 동작하지 않아요.

`@solution`
```{shell}
head summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_code(r'\s*head\s+summer.csv\s*', incorrect_msg="`head`와 파일 이름 `summer.csv`를 사용하십시오. 실패하더라도 걱정하지 마십시오. 그래야 합니다.")
)
```

***

```yaml
type: ConsoleExercise
key: cba6bf99a5
xp: 20
```

`@instructions`
`seasonal` 디렉터리로 이동하세요.

`@hint`
`cd`는 "change directory"(디렉터리 변경)의 약자예요.

`@solution`
```{shell}
cd seasonal

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/home/repl/seasonal'),
  has_code('cd +seasonal', incorrect_msg="현재 작업 디렉토리(`pwd`로 확인)가 `/home/repl`인 경우, `cd seasonal`을 사용하여 `seasonal` 폴더로 이동할 수 있습니다.")
)
```

***

```yaml
type: ConsoleExercise
key: 74f5c8d2fc
xp: 20
```

`@instructions`
`!head`로 `head` 명령을 다시 실행하세요.

`@hint`
`!`와 그다음에 오는 것 사이에 공백을 넣지 마세요.

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
                        incorrect_msg='`!head`를 사용하여 `head` 명령을 반복하십시오.'),
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
`history`로 지금까지 수행한 작업을 확인하세요.

`@hint`
`history`는 가장 최근 명령을 마지막에 보여 주므로, 실행이 끝날 때 화면에 최근 항목이 남아요.

`@solution`
```{shell}
history

```

`@sct`
```{python}
Ex().has_code(r'history', incorrect_msg='이전 명령어 목록을 얻으려면 플래그 없이 `history`를 사용하십시오.')
```

***

```yaml
type: ConsoleExercise
key: 0629b2adf3
xp: 20
```

`@instructions`
명령 번호 뒤에 `!`를 붙여 `head`를 다시 실행하세요.

`@hint`
`!`와 그다음에 오는 것 사이에 공백을 절대 넣지 마세요.

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
                        incorrect_msg='`!<숫자>`를 사용하여 기록에서 마지막 `head` 명령을 다시 실행하셨나요?'),
        # The head cmd should appear twice, at positions 1 and 3, though this will change 
        # if the student typed a wrong answer.
        # Since we're also checking output, this should be niche enough to ignore.
        has_code(r'!3'),
        has_code(r'!1') 
    )
)
Ex().success_msg("잘하셨습니다! 다음으로 넘어가세요!")
```

---

## 특정 값을 포함하는 줄만 선택하려면 어떻게 하나요?

```yaml
type: BulletConsoleExercise
key: adf1516acf
xp: 100
```

`head`와 `tail`은 행을 선택하고,
`cut`은 열을 선택하며,
`grep`은 줄의 내용에 따라 줄을 선택합니다.
가장 간단한 형태로,
`grep`은 텍스트 조각과 그 뒤에 하나 이상의 파일 이름을 받아서
해당 텍스트를 포함하는 모든 줄을 출력합니다.
예를 들어,
`grep bicuspid seasonal/winter.csv`
은 "bicuspid"를 포함하는 `winter.csv`의 줄을 출력합니다.

`grep`은 패턴 검색도 할 수 있으며,
이는 다음 강의에서 살펴보겠습니다.
지금 더 중요한 것은 `grep`에서 자주 쓰는 플래그입니다:

- `-c`: 일치하는 줄 자체가 아니라 그 개수를 출력
- `-h`: 여러 파일을 검색할 때 파일 이름을 출력하지 않음
- `-i`: 대소문자를 구분하지 않음(예: "Regression"과 "regression"을 일치로 처리)
- `-l`: 일치한 내용이 아니라, 일치 항목을 포함한 파일 이름을 출력
- `-n`: 일치한 줄의 줄 번호를 출력
- `-v`: 일치를 뒤집어, 즉 일치하지 않는 줄만 표시

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
홈 디렉터리에서 단일 명령으로 `seasonal/autumn.csv`에서 `molar`라는 단어를 포함하는 모든 줄의 내용을 출력하세요. 플래그는 사용하지 마세요.

`@hint`
찾을 단어와 검색할 파일 이름을 함께 써서 `grep`을 사용하세요.

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
      has_code("grep", incorrect_msg = "`grep`을 호출하셨나요?"),
      has_code("molar", incorrect_msg = "`molar`를 검색하셨나요?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "`seasonal/autumn.csv` 파일을 검색하셨나요?")
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
일치를 반대로 해서 `seasonal/spring.csv`에서 `molar`라는 단어를 포함하지 않는 줄을 모두 찾고, 그 줄 번호를 표시하세요.
좋은 스타일로는 플래그를 파일 이름이나 검색어 "molar"보다 앞에 두는 것이 좋다는 점을 기억하세요.

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
      has_code("grep", incorrect_msg = "`grep`을 호출하셨나요?"),
      has_code("-v", incorrect_msg = "`-v`로 일치를 반전시키셨나요?"),
      has_code("-n", incorrect_msg = "`-n`으로 줄 번호를 표시하셨나요?"),
      has_code("molar", incorrect_msg = "`molar`를 검색하셨나요?"),
      has_code("seasonal/spring.csv", incorrect_msg = "`seasonal/spring.csv` 파일을 검색하셨나요?")
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
`autumn.csv`와 `winter.csv`를 합쳐서 `incisor`라는 단어를 포함하는 줄이 몇 개인지 세어 보세요.
(역시 홈 디렉터리에서 단일 명령으로 실행하세요.)

`@hint`
줄 수를 세려면 `grep`에 `-c`를 사용하세요.

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
      has_code("grep", incorrect_msg = "`grep`을 호출하셨나요?"),
      has_code("-c", incorrect_msg = "`-c`로 개수를 얻으셨나요?"),
      has_code("incisor", incorrect_msg = "`incisor`를 검색하셨나요?"),
      has_code("seasonal/autumn.csv", incorrect_msg = "`seasonal/autumn.csv` 파일을 검색하셨나요?"),
      has_code("seasonal/winter.csv", incorrect_msg = "`seasonal/winter.csv` 파일을 검색하셨나요?")
    )
  )
)
```

---

## 항상 데이터를 텍스트처럼 다루는 것이 안전하지 않은 이유는 무엇인가요?

```yaml
type: MultipleChoiceExercise
key: 11914639fc
xp: 50
```

`cut`의 매뉴얼 페이지 `SEE ALSO` 섹션에는 데이터를 잘라내는 대신 결합할 수 있는 `paste`라는 명령이 소개되어 있습니다.

<hr>

먼저 `paste`의 매뉴얼 페이지를 읽고,
그다음 가을과 겨울 데이터 파일을 쉼표를 구분 기호로 하여 단일 테이블로 결합하기 위해 `paste`를 실행해 보세요.
데이터 분석 관점에서 출력 결과의 문제점은 무엇인가요?

`@possible_answers`
- 열 헤더가 반복됩니다.
- 마지막 몇 행의 열 개수가 올바르지 않습니다.
- `winter.csv`의 일부 데이터가 누락되었습니다.

`@hint`
`paste`의 출력에 대해 구분 기호로 쉼표를 사용해 `cut`을 적용하면
올바른 답이 나올까요?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = '맞습니다만, 반드시 오류는 아닙니다.'
correct2 = '정답: 열과 함께 줄을 연결하면 시작 부분에 빈 열이 하나만 생성되고, 두 개는 아닙니다.'
err3 = '아니요, 모든 겨울 데이터가 있습니다.'
Ex().has_chosen(2, [err1, correct2, err3])
```

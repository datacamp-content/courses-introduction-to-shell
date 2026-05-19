---
title: 파일과 디렉터리 다루기
description: >-
  이 장은 Unix 셸에 대한 간단한 소개입니다. 셸이 거의 50년이 지난 지금까지도 사용되는 이유, 익숙한 그래픽 도구와의 비교, 셸에서
  이동하는 방법, 그리고 파일과 폴더를 생성·수정·삭제하는 방법을 배워요.
free_preview: true
lessons:
  - nb_of_exercises: 12
    title: 셸은 데스크톱 인터페이스와 어떻게 다를까요?
---

## 셸은 데스크톱 인터페이스와 어떻게 비교되나요?

```yaml
type: PureMultipleChoiceExercise
key: badd717ea4
xp: 50
```

Windows, Linux, Mac OS와 같은 운영체제는 특별한 종류의 프로그램입니다.
운영체제는 컴퓨터의 프로세서, 하드 드라이브, 네트워크 연결을 제어하지만,
가장 중요한 일은 다른 프로그램을 실행하는 것입니다.

사람은 디지털 존재가 아니므로
운영체제와 상호작용하려면 인터페이스가 필요합니다.
요즘 가장 흔한 방식은 그래픽 파일 탐색기로,
클릭과 더블 클릭을 파일 열기와 프로그램 실행 명령으로 변환해 줍니다.
그래픽 디스플레이가 도입되기 전에는
사람들이 **명령줄 셸**이라 불리는 프로그램에 지시를 입력했습니다.
명령을 입력할 때마다
셸은 다른 프로그램들을 실행하고,
그 출력 결과를 사람이 읽을 수 있는 형태로 보여 준 다음,
다음 명령을 받을 준비가 되었음을 알리는 *프롬프트*를 표시합니다.
(이름은 컴퓨터의 "바깥 껍데기", 즉 외부 인터페이스라는 개념에서 왔습니다.)

클릭과 드래그 대신 명령을 타이핑하는 방식은 처음에는 서툴게 느껴질 수 있지만,
보시다시피
컴퓨터에 시키고 싶은 일을 글자로 명확히 표현하기 시작하면
기존 명령을 조합해 새로운 작업을 만들고
반복 작업을 자동화할 수 있어요.
몇 번의 키 입력만으로도 가능합니다.

<hr>
대부분의 사람이 사용하는 그래픽 파일 탐색기와 명령줄 셸의 관계는 무엇인가요?

`@hint`
사용자는 프로그램을 통해서만 운영체제와 상호작용할 수 있다는 점을 기억하세요.

`@possible_answers`
- 파일 탐색기는 파일을 보고 편집하게 해 주고, 셸은 프로그램을 실행하게 해 줍니다.
- 파일 탐색기는 셸 위에 구축되었습니다.
- 셸은 운영체제의 일부이고, 파일 탐색기는 별개입니다.
- [둘 다 운영체제에 명령을 전달하기 위한 인터페이스입니다.]

`@feedback`
- 둘 다 파일을 보고 편집할 수 있고 프로그램을 실행할 수 있어요.
- 그래픽 파일 탐색기와 셸은 모두 동일한 하위 운영체제 기능을 호출해요.
- 셸과 파일 탐색기는 모두 사용자의 명령(입력하거나 클릭한 것)을 운영체제 호출로 변환하는 프로그램이에요.
- 정답입니다! 두 인터페이스 모두 사용자의 명령(입력이든 클릭이든)을 받아 운영체제로 전달해요.

---

## 나는 어디에 있을까요?

```yaml
type: MultipleChoiceExercise
key: 7c1481dbd3
xp: 50
```

**파일 시스템**은 파일과 디렉터리(또는 폴더)를 관리합니다.
각 항목은 파일 시스템의 **루트 디렉터리**에서부터 도달하는 방법을 보여 주는 **절대 경로**로 식별돼요:
`/home/repl`은 `home` 디렉터리 안의 `repl` 디렉터리이고,
`/home/repl/course.txt`는 그 디렉터리 안의 파일 `course.txt`이며,
`/` 자체는 루트 디렉터리입니다.

지금 파일 시스템에서 어디에 있는지 확인하려면
`pwd` 명령을 실행하세요
("**p**rint **w**orking **d**irectory"의 줄임말).
이 명령은 현재 **작업 디렉터리**의 절대 경로를 출력하며,
셸이 기본으로 명령을 실행하고 파일을 찾는 위치예요.

<hr>
`pwd`를 실행하세요.
지금 어디에 있나요?

`@possible_answers`
- `/home`
- `/repl`
- `/home/repl`

`@hint`
Unix 시스템에서는 보통 모든 사용자의 홈 디렉터리가 `/home` 아래에 위치해요.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "올바른 경로가 아닙니다."
correct = "정답입니다 - 당신은 `/home/repl`에 있습니다."

Ex().has_chosen(3, [err, err, correct])
```

---

## 파일과 디렉터리를 어떻게 구분하나요?

```yaml
type: MultipleChoiceExercise
key: f5b0499835
xp: 50
```

`pwd`는 현재 위치를 알려줍니다.
그 위치에 무엇이 있는지 보려면
`ls`("**l**i**s**ting"의 약자)를 입력하고 Enter 키를 누르세요.
`ls`만 입력하면
현재 디렉터리의 내용이 표시됩니다
(`pwd`가 보여 준 디렉터리).
파일 이름을 추가하면
`ls`가 그 파일들을 나열하고,
디렉터리 이름을 추가하면
그 디렉터리의 내용을 나열합니다.
예를 들어,
`ls /home/repl`은 시작 디렉터리에 무엇이 있는지 보여줍니다
(보통 **home 디렉터리**라고 부릅니다).

<hr>
`ls`에 적절한 인수를 사용해 디렉터리 `/home/repl/seasonal`의 파일 목록을 보세요
(이 디렉터리에는 계절별로 구분된 날짜별 치과 수술 정보가 들어 있습니다).
다음 중 이 디렉터리에 없는 파일은 어느 것인가요?

`@possible_answers`
- `autumn.csv`
- `fall.csv`
- `spring.csv`
- `winter.csv`

`@hint`
`ls`에 경로를 주면, 그 경로 안에 무엇이 있는지 보여줍니다.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err = "해당 파일은 `seasonal` 디렉토리에 있습니다."
correct = "정답입니다 - 해당 파일은 `seasonal` 디렉토리에 *없습니다*."

Ex().has_chosen(2, [err, correct, err, err])
```

---

## 파일과 디렉터리를 식별하는 다른 방법은 무엇인가요?

```yaml
type: BulletConsoleExercise
key: a766184b59
xp: 100
```

절대 경로는 위도와 경도처럼, 어디에 있든 값이 변하지 않습니다. 반면에 **상대 경로**는 현재 위치를 기준으로 한 위치를 지정합니다. 예를 들어 "북쪽으로 20킬로미터"처럼 말하는 것과 같습니다.

예를 들면 다음과 같습니다.
- 디렉터리 `/home/repl`에 있다면, **상대** 경로 `seasonal`은 **절대** 경로 `/home/repl/seasonal`과 같은 디렉터리를 가리킵니다. 
- 디렉터리 `/home/repl/seasonal`에 있다면, **상대** 경로 `winter.csv`는 **절대** 경로 `/home/repl/seasonal/winter.csv`와 같은 파일을 가리킵니다.

셸은 경로의 첫 글자를 보고 절대 경로인지 상대 경로인지 판단합니다. `/`로 시작하면 절대 경로이고, `/`로 시작하지 않으면 상대 경로입니다.

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
지금 위치는 `/home/repl`입니다. `ls`와 **상대 경로**를 사용해, 절대 경로가 `/home/repl/course.txt`인 그 파일만 목록으로 표시하세요.

`@hint`
현재 위치보다 아래에 있는 파일이나 디렉터리의 상대 경로는,
현재 위치의 절대 경로를 원하는 대상의 절대 경로에서
빼서 구할 수 있는 경우가 많습니다.

`@solution`
```{shell}
ls course.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "`ls`를 호출하여 파일 목록을 생성하지 않았습니다."), # to prevent `echo "course.txt"`
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +course.txt", incorrect_msg = "명령어가 올바른 파일 목록을 생성하지 않았습니다. `ls` 뒤에 `/home/repl/course.txt`의 상대 경로를 사용하십시오.")
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
지금 위치는 `/home/repl`입니다.
`ls`와 **상대** 경로를 사용해
파일 `/home/repl/seasonal/summer.csv`만 목록으로 표시하세요.

`@hint`
상대 경로는 맨 앞에 '/'로 시작하지 않습니다.

`@solution`
```{shell}
ls seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "`ls`를 호출하여 파일 목록을 생성하지 않았습니다."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +seasonal/summer.csv", incorrect_msg = "명령이 올바른 파일 목록을 생성하지 않았습니다. `ls` 뒤에 `/home/repl/seasonal/summer.csv`에 대한 상대 경로를 사용하십시오.")
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
지금 위치는 `/home/repl`입니다.
`ls`와 **상대** 경로를 사용해
디렉터리 `/home/repl/people`의 내용을 목록으로 표시하세요.

`@hint`
상대 경로는 맨 앞에 '/'로 시작하지 않습니다.

`@solution`
```{shell}
ls people

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/home/repl"),
    has_code("ls", incorrect_msg = "`ls`를 호출하여 파일 목록을 생성하지 않았습니다."), 
    check_correct(
      has_expr_output(strict=True),
      has_code("ls +people", incorrect_msg = "명령어가 올바른 파일 목록을 생성하지 않았습니다. `ls` 뒤에 `/home/repl/people`의 상대 경로를 사용하십시오.")
    )
)
Ex().success_msg("잘하셨습니다. 이제 파일 및 디렉토리 목록을 확인하는 방법을 알았으니, 파일 시스템을 이동하는 방법을 알아보겠습니다!")
```

---

## 다른 디렉터리로 어떻게 이동하나요?

```yaml
type: BulletConsoleExercise
key: dbdaec5610
xp: 100
```

파일 브라우저에서 폴더를 더블 클릭해 여기저기로 이동하듯이,
명령어 `cd`(“change directory”의 약자)를 사용해 파일시스템에서도 이동할 수 있어요.

`cd seasonal`을 입력한 다음 `pwd`를 입력하면,
현재 위치가 `/home/repl/seasonal`이라고 표시돼요.
그다음 `ls`만 실행하면,
현재 위치인 `/home/repl/seasonal`의 내용이 보입니다.
홈 디렉터리인 `/home/repl`로 돌아가려면,
`cd /home/repl` 명령을 사용하면 됩니다.

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
현재 위치는 `/home/repl`입니다.
상대 경로를 사용해 `/home/repl/seasonal`로 이동하세요.

`@hint`
`cd`는 "change directory"를 의미하고, 상대 경로는 앞에 '/'로 시작하지 않는다는 점을 기억하세요.

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
key: e69c8eac15
xp: 35
```

`@instructions`
`pwd`로 현재 위치를 확인하세요.

`@hint`
명령을 입력한 뒤에는 "enter" 또는 "return" 키를 누르세요.

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
경로를 지정하지 않고 `ls`를 사용해 해당 디렉터리의 내용을 확인하세요.

`@hint`
명령 뒤에는 "enter" 또는 "return" 키를 누르는 것을 잊지 마세요.

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
      has_code('ls', incorrect_msg="명령이 올바른 출력을 생성하지 않았습니다. 현재 디렉토리의 내용을 표시하기 위해 경로 없이 `ls`를 사용하셨나요?")
    )
)

Ex().success_msg("좋습니다! 이것은 하위 디렉토리로 이동하는 것에 관한 것이었습니다. 위로 이동하는 것은 어떨까요? 알아봅시다!")
```

---

## 상위 디렉터리로 어떻게 이동하나요?

```yaml
type: PureMultipleChoiceExercise
key: 09c717ef76
xp: 50
```

디렉터리의 **parent**는 그 디렉터리의 바로 위에 있는 디렉터리입니다.
예를 들어, `/home`은 `/home/repl`의 parent이고,
`/home/repl`은 `/home/repl/seasonal`의 parent예요.
`cd`나 `ls` 같은 명령에 parent 디렉터리의 절대 경로를 언제든지 전달할 수 있어요.
하지만 더 자주 쓰는 방법은,
특수 경로 `..`(공백 없이 점 두 개)가
"현재 위치에서 한 단계 위 디렉터리"를 뜻한다는 점을 활용하는 것입니다.
만약 현재 위치가 `/home/repl/seasonal`이라면,
`cd ..`는 `/home/repl`로 올라갑니다.
여기서 `cd ..`를 한 번 더 쓰면
`/home`으로 이동합니다.
한 번 더 `cd ..`를 쓰면 *루트 디렉터리* `/`에 도달하는데,
파일 시스템의 가장 꼭대기죠.
(`cd`와 `..` 사이에 공백을 꼭 넣으세요. 네 글자의 하나의 명령이 아니라, 명령과 경로를 구분해 써야 합니다.)

점 하나(`.`)는 항상 "현재 디렉터리"를 의미하므로,
`ls`만 입력하는 것과 `ls .`은 동일하고,
`cd .`는 아무 변화가 없습니다
(현재 있는 디렉터리로 다시 이동하기 때문이에요).

마지막 특수 경로는 `~`(틸드)로,
"사용자의 홈 디렉터리"(예: `/home/repl`)를 의미합니다.
어디에 있든지 간에,
`ls ~`는 항상 홈 디렉터리의 내용을 보여 주고,
`cd ~`는 항상 홈으로 이동합니다.

<hr>
현재 위치가 `/home/repl/seasonal`일 때,
`cd ~/../.`는 어디로 이동할까요?

`@hint`
디렉터리를 한 단계씩 따라가 보세요.

`@possible_answers`
- `/home/repl`
- [`/home`]
- `/home/repl/seasonal`
- `/` (the root directory)

`@feedback`
- 아닙니다. 하지만 `~` 또는 `..`만 단독으로 사용하면 그 위치로 이동해요.
- 정답이에요! 이 경로는 '홈 디렉터리', '한 단계 위', '현재 위치'를 의미해요.
- 아닙니다. 하지만 `.`만 단독으로 사용하면 그렇게 돼요.
- 아닙니다. 경로의 마지막 부분은 `..`("위로")가 아니라 `.`("여기")예요.

---

## 파일은 어떻게 복사하나요?

```yaml
type: BulletConsoleExercise
key: 832de9e74c
xp: 100
```

파일을 복사하거나,
다른 디렉터리로 옮겨서 정리하거나,
이름을 바꾸고 싶을 때가 자주 있어요.
이때 사용하는 명령 중 하나가 `cp`인데, "copy"의 약자입니다.
`original.txt`라는 파일이 이미 있다면,
다음 명령으로:

```{shell}
cp original.txt duplicate.txt
```

`original.txt`의 사본인 `duplicate.txt`가 만들어집니다.
이미 `duplicate.txt`라는 파일이 있었다면
그 파일은 덮어씁니다.
`cp`의 마지막 인자가 기존에 있는 디렉터리라면,
다음과 같은 명령은:

```{shell}
cp seasonal/autumn.csv seasonal/winter.csv backup
```

해당 파일들을 그 디렉터리에 모두 복사합니다.

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
`seasonal/summer.csv`의 사본을 `backup` 디렉터리에 만들고(이 디렉터리도 `/home/repl`에 있어요),
새 파일 이름은 `summer.bck`으로 하세요.

`@hint`
대상 디렉터리 이름과 복사할 파일 이름을 결합해
새 파일에 대한 상대 경로를 만드세요.

`@solution`
```{shell}
cp seasonal/summer.csv backup/summer.bck

```

`@sct`
```{python}
Ex().check_correct(
    check_file('/home/repl/backup/summer.bck', missing_msg="`summer.bck` 파일이 `backup` 디렉토리에 존재하지 않는 것 같습니다. `cp`에 두 개의 경로를 제공하십시오: 기존 파일 (`seasonal/summer.csv`)과 대상 파일 (`backup/summer.bck`)."),
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
현재 작업 디렉터리(`/home/repl`)를 변경하지 않고,
`seasonal` 디렉터리의 `spring.csv`와 `summer.csv`를 `backup` 디렉터리로 복사하세요.

`@hint`
`cp` 뒤에 복사할 파일들의 이름을 적고,
그 다음에 복사 대상 디렉터리 이름을 적으세요.

`@solution`
```{shell}
cp seasonal/spring.csv seasonal/summer.csv backup

```

`@sct`
```{python}
patt = "`%s`이(가) `backup` 디렉토리에 복사되지 않은 것 같습니다. `cp`에 두 개의 파일 이름과 디렉토리 이름을 제공하십시오."
Ex().multi(
    has_cwd('/home/repl', incorrect_msg="파일을 `{{dir}}`에서 복사했는지 확인하십시오! `cd {{dir}}`를 사용하여 그곳으로 다시 이동하십시오."),
    check_file('/home/repl/backup/spring.csv', missing_msg=patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=patt%'summer.csv')
)
Ex().success_msg("잘하셨습니다. 복사 외에도 파일을 한 디렉토리에서 다른 디렉토리로 이동할 수도 있어야 합니다. 다음 연습에서 이에 대해 알아보세요!")
```

---

## 파일을 어떻게 옮기나요?

```yaml
type: ConsoleExercise
key: 663a083a3c
xp: 100
```

`cp`가 파일을 복사한다면,
`mv`는 파일을 한 디렉터리에서 다른 디렉터리로 이동합니다.
그래픽 파일 브라우저에서 드래그하는 것과 같다고 보시면 됩니다.
매개변수 처리 방식은 `cp`와 동일하므로,
다음 명령은:

```{shell}
mv autumn.csv winter.csv ..
```

현재 작업 디렉터리에 있는 `autumn.csv`와 `winter.csv` 파일을
한 단계 위의 상위 디렉터리로 이동합니다
(왜냐하면 `..`은 항상 현재 위치의 상위 디렉터리를 가리키기 때문입니다).

`@instructions`
현재 위치는 `/home/repl`이며, 여기에 `seasonal`과 `backup` 하위 디렉터리가 있습니다.
하나의 명령으로 `seasonal`의 `spring.csv`와 `summer.csv`를 `backup`으로 이동하세요.

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
backup_patt="파일 `%s`이(가) `backup` 디렉토리에 없습니다. `mv`를 올바르게 사용하셨나요? `mv`의 매개변수로 두 개의 파일 이름과 디렉토리를 사용하세요."
seasonal_patt="파일 `%s`이(가) 여전히 `seasonal` 디렉토리에 있습니다. `cp`로 복사하는 대신 `mv`로 파일을 이동했는지 확인하세요!"
Ex().multi(
    check_file('/home/repl/backup/spring.csv', missing_msg=backup_patt%'spring.csv'),
    check_file('/home/repl/backup/summer.csv', missing_msg=backup_patt%'summer.csv'),
    check_not(check_file('/home/repl/seasonal/spring.csv'), incorrect_msg=seasonal_patt%'spring.csv'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg=seasonal_patt%'summer.csv')
)
Ex().success_msg("잘하셨습니다, 이 셸 훈련을 계속 이어가 봅시다!")
```

---

## 파일 이름은 어떻게 바꾸나요?

```yaml
type: BulletConsoleExercise
key: 001801a652
xp: 100
```

`mv`는 파일 이름을 바꾸는 데도 사용할 수 있어요. 다음을 실행하면:

```{shell}
mv course.txt old-course.txt
```

현재 작업 디렉터리에 있는 `course.txt` 파일이 `old-course.txt` 파일로 "이동"돼요.
파일 브라우저의 동작 방식과는 다르지만,
종종 아주 유용합니다.

주의할 점이 하나 있어요:
`cp`와 마찬가지로
`mv`는 기존 파일을 덮어씁니다.
예를 들어
이미 `old-course.txt`라는 파일이 있다면,
위 명령은 그 파일을 `course.txt`의 내용으로 교체합니다.

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
`seasonal` 디렉터리로 이동하세요.

`@hint`
`cd`는 "change directory"의 약자이며, 상대 경로는 선행 '/'로 시작하지 않는다는 점을 기억하세요.

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
key: ed5fe1df23
xp: 35
```

`@instructions`
파일 `winter.csv`의 이름을 `winter.csv.bck`로 바꾸세요.

`@hint`
현재 파일 이름과 바꾸려는 새 이름 순서로 `mv`를 사용하세요.

`@solution`
```{shell}
mv winter.csv winter.csv.bck

```

`@sct`
```{python}
hint = " `mv` 명령어를 두 개의 인수와 함께 사용하십시오: 이름을 바꾸고자 하는 파일 (`winter.csv`)과 파일의 새 이름 (`winter.csv.bck`)."
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    multi(
        check_file('/home/repl/seasonal/winter.csv.bck', missing_msg="디렉토리에서 `winter.csv.bck` 파일을 찾을 것으로 예상했습니다." + hint),
        check_not(check_file('/home/repl/seasonal/winter.csv'), incorrect_msg="디렉토리에서 더 이상 `winter.csv` 파일을 찾지 않을 것으로 예상했습니다." + hint)
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
모든 작업이 제대로 되었는지 확인하려면 `ls`를 실행하세요.

`@hint`
명령을 실행하려면 "enter" 또는 "return" 키를 누르는 것을 잊지 마세요.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    has_expr_output(incorrect_msg="현재 작업 디렉토리의 내용을 나열하기 위해 `ls`를 사용하셨습니까?")
)
Ex().multi(
    has_cwd("/home/repl/seasonal"),
    check_correct(
      has_expr_output(strict=True),
      has_code("ls", incorrect_msg = "명령어가 올바른 파일 목록을 생성하지 않았습니다. 인수 없이 `ls`를 사용하여 현재 작업 디렉토리의 내용을 나열하십시오.")
    )
)
Ex().success_msg("복사, 이동, 이름 변경, 모두 잘 해내셨습니다! 다음은 파일 삭제입니다.")
```

---

## 파일은 어떻게 삭제하나요?

```yaml
type: BulletConsoleExercise
key: '2734680614'
xp: 100
```

파일을 복사하고 옮길 수 있듯이,
삭제할 때는 `rm`을 사용해요.
`rm`은 "remove"의 줄임말입니다.
`cp`와 `mv`처럼,
`rm`에도 원하는 만큼 여러 파일 이름을 줄 수 있어요. 예를 들어:

```{shell}
rm thesis.txt backup/thesis-2017-08.txt
```

위 명령은 `thesis.txt`와 `backup/thesis-2017-08.txt`를 모두 삭제합니다.

`rm`은 이름 그대로 즉시 삭제를 수행해요.
그래픽 파일 브라우저와 달리
셸에는 휴지통이 없기 때문에,
위 명령을 입력하면
논문 파일은 완전히 사라집니다.

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
현재 위치는 `/home/repl`입니다.
`seasonal` 디렉터리로 이동하세요.

`@hint`
`cd`는 "change directory"의 줄임말이며, 상대 경로는 앞에 '/'로 시작하지 않는다는 점을 기억하세요.

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
`autumn.csv`를 삭제하세요.

`@hint`
`rm`은 "remove"의 줄임말이라는 것을 기억하세요.

`@solution`
```{shell}
rm autumn.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl/seasonal'),
    check_not(check_file('/home/repl/seasonal/autumn.csv'), incorrect_msg="`autumn.csv` 파일이 여전히 `seasonal` 디렉토리에 있을 것으로 예상하지 않았습니다. 제거하려는 파일의 경로와 함께 `rm`을 사용하십시오."),
    has_code('rm', incorrect_msg = '`rm`을 사용하여 파일을 제거하십시오. 파일을 이동하는 대신에.')
)
```

***

```yaml
type: ConsoleExercise
key: 09f2d105cd
xp: 25
```

`@instructions`
홈 디렉터리로 돌아가세요.

`@hint`
`cd`에 경로를 주지 않으면 홈 디렉터리로 이동합니다.

`@solution`
```{shell}
cd

```

`@sct`
```{python}
Ex().has_cwd('/home/repl', incorrect_msg="`cd ..` 또는 `cd ~`를 사용하여 홈 디렉토리로 돌아가십시오.")
```

***

```yaml
type: ConsoleExercise
key: 9eaf49744c
xp: 25
```

`@instructions`
디렉터리를 다시 변경하지 말고 `seasonal/summer.csv`를 삭제하세요.

`@hint`
`rm`은 "remove"의 줄임말이라는 것을 기억하세요.

`@solution`
```{shell}
rm seasonal/summer.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/seasonal/summer.csv'), incorrect_msg="`summer.csv` 파일이 여전히 `seasonal` 디렉토리에 있을 것으로 예상하지 않았습니다. 제거하려는 파일의 경로와 함께 `rm`을 사용하십시오."),
    has_code('rm', incorrect_msg = '`rm`을 사용하여 파일을 제거하십시오. 파일을 이동하지 마십시오.')
)
Ex().success_msg("대단합니다! 다음으로 넘어가겠습니다!")
```

---

## 디렉터리는 어떻게 만들고 삭제하나요?

```yaml
type: BulletConsoleExercise
key: 63e8fbd0c2
xp: 100
```

`mv`는 디렉터리를 파일과 동일하게 취급합니다.
예를 들어, 홈 디렉터리에 있을 때 `mv seasonal by-season`을 실행하면
`mv`는 `seasonal` 디렉터리의 이름을 `by-season`으로 바꿔요.
하지만 `rm`은 다르게 동작합니다.

디렉터리에 대해 `rm`을 시도하면,
셸은 그렇게 할 수 없다는 오류 메시지를 출력합니다.
주로 작업물이 가득한 디렉터리를 실수로 통째로 지우는 일을 막기 위해서예요.
대신 `rmdir`라는 별도의 명령을 사용할 수 있습니다.
안전성을 높이기 위해 이 명령은 디렉터리가 비어 있을 때만 동작하므로,
디렉터리를 지우기 전에 그 안의 파일을 먼저 삭제해야 합니다.
(숙련 사용자는 `rm`에 `-r` 옵션을 사용해 동일한 효과를 낼 수 있습니다.
명령 옵션은 다음 장에서 다루겠습니다.)

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
디렉터리를 이동하지 않고,
`people` 디렉터리 안의 `agarwal.txt` 파일을 삭제하세요.

`@hint`
`rm`은 "remove"의 약자이며, 상대 경로는 앞에 '/'로 시작하지 않는다는 점을 기억하세요.

`@solution`
```{shell}
rm people/agarwal.txt

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(check_file('/home/repl/people/agarwal.txt'), incorrect_msg="`agarwal.txt`는 더 이상 `/home/repl/people`에 없어야 합니다. `rm`을 올바르게 사용하셨나요?"),
    has_expr_output(expr = 'ls people', output = '', incorrect_msg = '`people` 디렉토리에 여전히 파일이 있습니다. `agarwal.txt`를 단순히 이동했거나 새 파일을 생성한 경우, 모두 삭제하십시오.')
)
```

***

```yaml
type: ConsoleExercise
key: 661633e531
xp: 25
```

`@instructions`
이제 `people` 디렉터리가 비었으니,
하나의 명령으로 해당 디렉터리를 삭제하세요.

`@hint`
`rm`은 파일에만 동작한다는 점을 기억하세요.

`@solution`
```{shell}
rmdir people

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_not(has_dir('/home/repl/people'),
              incorrect_msg = "'people' 디렉토리는 더 이상 홈 디렉토리에 없어야 합니다. `rmdir`을 사용하여 제거하십시오!")
)
```

***

```yaml
type: ConsoleExercise
key: 89f7ffc1da
xp: 25
```

`@instructions`
디렉터리는 파일이 아니므로,
새로운(빈) 디렉터리를 만들려면 `mkdir directory_name` 명령을 사용해야 합니다.
이 명령을 사용해 홈 디렉터리 아래에 `yearly`라는 새 디렉터리를 만드세요.

`@hint`
만들고자 하는 디렉터리 이름과 함께 `mkdir`를 실행하세요.

`@solution`
```{shell}
mkdir yearly

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly', msg="홈 디렉토리에 `yearly` 디렉토리가 없습니다. `mkdir yearly`를 사용하여 하나 만드세요!")
)
```

***

```yaml
type: ConsoleExercise
key: 013a5ff2dc
xp: 25
```

`@instructions`
이제 `yearly`가 존재하니,
홈 디렉터리를 떠나지 않은 상태에서
그 안에 `2017`이라는 디렉터리를 추가로 만드세요.

`@hint`
만들고자 하는 하위 디렉터리에 대해 상대 경로를 사용하세요.

`@solution`
```{shell}
mkdir yearly/2017

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    has_dir('/home/repl/yearly/2017',
            msg="'/home/repl/yearly'에 '2017' 디렉토리를 찾을 수 없습니다. 상대 경로 `yearly/2017`을 사용하여 이 디렉토리를 만들 수 있습니다.")
)
Ex().success_msg("멋집니다! 이 장의 개념을 반복하는 연습 문제로 이 장을 마무리해 봅시다!")
```

---

## 마무리

```yaml
type: BulletConsoleExercise
key: b1990e9a42
xp: 100
```

데이터를 분석할 때는 중간 결과 파일을 자주 만들게 됩니다.
이런 파일을 홈 디렉터리에 저장하는 대신,
잠시만 필요로 하는 파일을 자주 보관하는 `/tmp`에 두어도 됩니다.
(`/tmp`는 루트 디렉터리 `/` 바로 아래에 있으며,
여러분의 홈 디렉터리 아래가 *아닙니다*.)
이번 마무리 연습에서는 그 방법을 연습해 보겠습니다.

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
`cd`를 사용해 `/tmp`로 이동하세요.

`@hint`
`cd`는 "change directory"의 약자이고, 절대 경로는 '/'로 시작합니다.

`@solution`
```{shell}
cd /tmp

```

`@sct`
```{python}
Ex().check_correct(
  has_cwd('/tmp'),
  has_code('cd +/tmp', incorrect_msg = '잘못된 디렉토리에 있습니다. `cd`를 사용하여 `/tmp` 디렉토리로 변경하십시오.')
)
```

***

```yaml
type: ConsoleExercise
key: 7e6ada440d
xp: 25
```

`@instructions`
디렉터리 이름을 입력하지 않고 `/tmp`의 내용을 나열하세요.

`@hint`
`ls`에 무엇을 나열할지 지정하지 않으면, 현재 디렉터리의 내용을 보여줍니다.

`@solution`
```{shell}
ls

```

`@sct`
```{python}
Ex().multi(
    has_cwd("/tmp"),
    has_code("ls", incorrect_msg = "파일 목록을 생성하기 위해 `ls`를 호출하지 않았습니다."),
    check_correct(
      has_expr_output(strict=True),
      has_code("^\s*ls\s*$", incorrect_msg = "명령어가 올바른 파일 목록을 생성하지 않았습니다. `ls`를 사용하십시오.")
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
`/tmp` 안에 `scratch`라는 새 디렉터리를 만드세요.

`@hint`
디렉터리를 만들 때는 `mkdir`를 사용하세요.

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
      has_code('mkdir +scratch', incorrect_msg="'/tmp' 아래에 'scratch' 디렉토리를 찾을 수 없습니다. `mkdir`을(를) 올바르게 사용했는지 확인하십시오.")
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
`/home/repl/people/agarwal.txt`를 `/tmp/scratch`로 이동하세요.
홈 디렉터리에는 `~` 바로 가기를, 두 번째 경로에는 절대 경로 대신 상대 경로를 사용할 것을 권장합니다.

`@hint`


`@solution`
```{shell}
mv ~/people/agarwal.txt scratch

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/tmp'),
    check_file('/tmp/scratch/agarwal.txt', missing_msg="'/tmp/scratch'에 'agarwal.txt'를 찾을 수 없습니다. 첫 번째 매개변수로 `~/people/agarwal.txt`를 사용하고 두 번째로 `scratch`를 사용하여 `mv`를 사용하십시오.")
)
Ex().success_msg("셸 소개의 1장을 마칩니다! 데이터를 조작하는 방법을 더 배우기 위해 다음 장으로 서둘러 가십시오!")
```

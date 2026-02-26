---
title: 배치 처리
description: >-
  대부분의 셸 명령은 한 번에 여러 파일을 처리할 수 있어요. 이 장에서는 여러분이 만드는 파이프라인도 그렇게 동작하도록 하는 방법을
  보여드립니다. 그 과정에서 셸이 변수를 사용해 정보를 저장하는 방식도 살펴봐요.
lessons:
  - nb_of_exercises: 10
    title: 셸은 정보를 어떻게 저장하나요?
---

## 셸은 정보를 어떻게 저장하나요?

```yaml
type: MultipleChoiceExercise
key: e4d5f4adea
xp: 50
```

다른 프로그램과 마찬가지로 셸은 정보를 변수에 저장해요.
이 중 일부는 **환경 변수**라고 하며,
항상 사용할 수 있어요.
환경 변수의 이름은 관례적으로 대문자로 쓰며,
자주 사용하는 몇 가지는 아래에 나와 있어요.

| Variable | Purpose                           | Value                 |
|----------|-----------------------------------|-----------------------|
| `HOME`   | 사용자의 홈 디렉터리               | `/home/repl`          |
| `PWD `   | 현재 작업 디렉터리                  | `pwd` 명령과 동일     |
| `SHELL`  | 사용 중인 셸 프로그램               | `/bin/bash`           |
| `USER`   | 사용자의 ID                        | `repl`                |

전체 목록(꽤 깁니다)을 보려면
셸에서 `set`을 입력하면 돼요.

<hr>

파이프를 사용해 `set`과 `grep`으로 `HISTFILESIZE`의 값을 표시하세요.
이 값은 명령 기록에 이전 명령을 몇 개까지 저장할지 결정해요.
값이 얼마인가요?

`@possible_answers`
- 10
- 500
- [2000]
- The variable is not there.

`@hint`
원하는 줄을 얻으려면 `set | grep HISTFILESIZE`를 사용하세요.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "아닙니다: 셸은 그보다 더 많은 기록을 저장합니다."
err2 = "아닙니다: 셸은 그보다 더 많은 기록을 저장합니다."
correct3 = "정답입니다: 셸은 이 시스템에서 기본적으로 2000개의 이전 명령을 저장합니다."
err4 = "아닙니다: 변수 `HISTFILESIZE`가 있습니다."
Ex().has_chosen(3, [err1, err2, correct3, err4])
```

---

## 변수의 값을 어떻게 출력하나요?

```yaml
type: ConsoleExercise
key: afae0f33a7
xp: 100
```

변수의 값을 확인하는 더 간단한 방법은 인자를 출력하는 `echo` 명령을 사용하는 거예요. 다음을 입력하면

```{shell}
echo hello DataCamp!
```

다음이 출력돼요.

```
hello DataCamp!
```

만약 다음처럼 변수의 값을 출력하려고 하면:

```{shell}
echo USER
```

변수의 이름인 `USER`가 출력됩니다.

변수의 값을 얻으려면 앞에 달러 기호 `$`를 붙여야 해요. 다음을 입력하면 

```{shell}
echo $USER
```

다음이 출력돼요.

```
repl
```

이 규칙은 어디서나 같아요.
`X`라는 변수의 값을 얻으려면
`$X`라고 써야 합니다.
(이렇게 해야 셸이 "이름이 X인 파일"을 뜻하는지,
아니면 "X라는 변수의 값"을 뜻하는지 구분할 수 있어요.)

`@instructions`
변수 `OSTYPE`에는 사용 중인 운영 체제 유형의 이름이 들어 있습니다.
`echo`를 사용해 그 값을 출력하세요.

`@hint`
`$`를 변수 `OSTYPE` 앞에 붙여서 `echo`로 호출하세요.

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
            has_code('echo', incorrect_msg="`echo`를 호출하셨나요?"),
            has_code('OSTYPE', incorrect_msg="`OSTYPE` 환경 변수를 출력하셨나요?"),
            has_code(r'\$OSTYPE', incorrect_msg="`OSTYPE` 앞에 `$`를 붙이세요.")
        )
    )
)
Ex().success_msg("환경 변수를 훌륭하게 echo 하셨습니다! 좋은 출발입니다. 계속 진행해 봅시다!")
```

---

## 셸은 정보를 또 어떻게 저장하나요?

```yaml
type: BulletConsoleExercise
key: e925da48e4
xp: 100
```

다른 종류의 변수는 **셸 변수(shell variable)**라고 하며,
프로그래밍 언어의 지역 변수와 비슷합니다.

셸 변수를 만들려면
이름에 값을 할당하면 됩니다:

```{shell}
training=seasonal/summer.csv
```

`=` 기호 앞뒤에 공백이 없어야 합니다.
이렇게 하면 다음과 같이 변수의 값을 확인할 수 있습니다:

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
값이 `seasonal/winter.csv`인 `testing` 변수를 정의하세요.

`@hint`
변수 이름과 값 사이에는 공백이 있으면 안 됩니다.

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
        has_code('testing', incorrect_msg='`testing`이라는 셸 변수를 정의하셨습니까?'),
        has_code('testing=', incorrect_msg='테스트 후에 공백 없이 `=`를 바로 작성하셨습니까?'),
        has_code('=seasonal/winter\.csv', incorrect_msg='`testing`의 값을 `seasonal/winter.csv`로 설정하셨습니까?')
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
`head -n 1 SOMETHING`을 사용해 `seasonal/winter.csv`의 첫 번째 줄을 가져오되,
파일 이름 대신 변수 `testing`의 값을 사용하세요.

`@hint`
변수의 값을 가져오려면 `$`가 필요하므로, `testing`만 쓰지 말고 `$testing`을 사용하세요.

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
    has_code(r'\$testing', incorrect_msg="쉘 변수를 `$testing`으로 참조하셨습니까?"),
    check_correct(
        has_output('^Date,Tooth\s*$'),
        multi(
            has_code('head', incorrect_msg="`head`를 호출하셨습니까?"),
            has_code('-n', incorrect_msg="`-n`으로 줄 수를 제한하셨습니까?"),
            has_code(r'-n\s+1', incorrect_msg="`-n 1`로 1줄을 유지하도록 선택하셨습니까?")     
        )
    )
)
Ex().success_msg("훌륭합니다! 명령을 쉽게 반복하는 방법을 살펴보겠습니다.")
```

---

## 명령을 여러 번 반복하려면 어떻게 하나요?

```yaml
type: ConsoleExercise
key: 920d1887e3
xp: 100
```

Shell 변수는 **반복문(loops)**에도 쓰이며,
명령을 여러 번 반복 실행해요.
다음 명령을 실행해 보면:

```{shell}
for filetype in gif jpg png; do echo $filetype; done
```

다음과 같이 출력돼요:

```
gif
jpg
png
```

이 반복문에서 다음을 유의하세요:

1. 구조는 `for` ...변수... `in` ...목록... `; do` ...본문... `; done` 입니다.
2. 반복문이 처리할 항목의 목록이 있습니다(여기서는 `gif`, `jpg`, `png`).
3. 현재 어떤 항목을 처리 중인지 기록하는 변수(여기서는 `filetype`).
4. 실제 처리를 수행하는 반복문의 본문(여기서는 `echo $filetype`).

본문에서는 다른 shell 변수와 마찬가지로 변수 이름 `filetype`만 쓰지 않고
`$filetype`을 사용해 변수 값을 가져온다는 점에 주의하세요.
또한 세미콜론의 위치도 중요합니다:
첫 번째 세미콜론은 목록과 키워드 `do` 사이에,
두 번째는 본문과 키워드 `done` 사이에 옵니다.

`@instructions`
반복문을 수정하여 다음이 출력되도록 하세요:

```
docx
odt
pdf
```

반복문 변수 이름은 반드시 `filetype`을 사용하세요.

`@hint`
도입 텍스트에 나온 코드 구조를 그대로 쓰되, 이미지 파일 형식 대신 문서 파일 형식으로 바꿔 보세요.

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
      has_code('for', incorrect_msg='`for`를 호출하셨습니까?'),
      has_code('filetype', incorrect_msg='`filetype`을(를) 루프 변수로 사용하셨습니까?'),
      has_code('in', incorrect_msg='파일 형식 목록 앞에 `in`을 사용하셨습니까?'),
      has_code('docx odt pdf', incorrect_msg='`docx`, `odt`, `pdf`를 그 순서대로 반복하셨습니까?'),
      has_code(r'pdf\s*;', incorrect_msg='마지막 루프 요소 뒤에 세미콜론을 넣으셨습니까?'),
      has_code(r';\s*do', incorrect_msg='첫 번째 세미콜론 뒤에 `do`를 사용하셨습니까?'),
      has_code('echo', incorrect_msg='`echo`를 호출하셨습니까?'),
      has_code(r'\$filetype', incorrect_msg='`$filetype`을(를) echo 하셨습니까?'),
      has_code(r'filetype\s*;', incorrect_msg='루프 본문 뒤에 세미콜론을 넣으셨습니까?'),
      has_code('; done', incorrect_msg='`done`으로 끝내셨습니까?')
    )
  )
)
Ex().success_msg("반복문을 잘 사용하셨습니다! 반복문은 동일한 작업을 수백 번 또는 수천 번 수행하고자 할 때 매우 유용합니다.")
```

---

## 각 파일마다 한 번씩 명령을 반복하려면 어떻게 하나요?

```yaml
type: ConsoleExercise
key: 8468b70a71
xp: 100
```

반복문을 작성할 때 처리할 파일 이름을 직접 타이핑해도 되지만,
일반적으로는 와일드카드를 사용하는 것이 더 좋습니다.
콘솔에서 다음 반복문을 실행해 보세요:

```{shell}
for filename in seasonal/*.csv; do echo $filename; done
```

다음과 같이 출력돼요:

```
seasonal/autumn.csv
seasonal/spring.csv
seasonal/summer.csv
seasonal/winter.csv
```

이는 셸이 반복문을 실행하기 전에 `seasonal/*.csv`를 네 개의 파일 이름 목록으로 확장하기 때문입니다.

`@instructions`
와일드카드 표현식을 `people/*`로 바꿔서,
접미사가 있든 없든 관계없이 `people` 디렉터리의 파일 이름이 출력되도록 하세요.
반복문 변수 이름은 `filename`을 사용해 주세요.

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
      has_code('for', incorrect_msg='`for`를 호출하셨습니까?'),
      has_code('filename', incorrect_msg='반복 변수로 `filename`을 사용하셨습니까?'),
      has_code('in', incorrect_msg='파일 유형 목록 앞에 `in`을 사용하셨습니까?'),
      has_code('people/\*', incorrect_msg='`people/*`로 파일 목록을 지정하셨습니까?'),
      has_code(r'people/\*\s*;', incorrect_msg='파일 목록 뒤에 세미콜론을 넣으셨습니까?'),
      has_code(r';\s*do', incorrect_msg='첫 번째 세미콜론 뒤에 `do`를 사용하셨습니까?'),
      has_code('echo', incorrect_msg='`echo`를 호출하셨습니까?'),
      has_code(r'\$filename', incorrect_msg='`$filename`을 echo 하셨습니까?'),
      has_code(r'filename\s*;', incorrect_msg='반복문 본문 뒤에 세미콜론을 넣으셨습니까?'),
      has_code('; done', incorrect_msg='`done`으로 끝내셨습니까?')
    )
  )
)
Ex().success_msg("반복문과 와일드카드는 강력한 조합입니다.")
```

---

## 여러 파일 이름을 어떻게 기록해 둘 수 있나요?

```yaml
type: MultipleChoiceExercise
key: 153ca10317
xp: 50
```

사람들은 종종 와일드카드 표현식을 사용해 변수에 파일 이름 목록을 저장합니다.
예를 들어,
`datasets`를 다음과 같이 정의하면:

```{shell}
datasets=seasonal/*.csv
```

나중에 다음과 같이 파일 이름들을 표시할 수 있어요:

```{shell}
for filename in $datasets; do echo $filename; done
```

이렇게 하면 타이핑을 줄이고 실수도 줄일 수 있습니다.

<hr>

이 두 명령을 홈 디렉터리에서 실행하면,
출력은 몇 줄이 될까요?

```{shell}
files=seasonal/*.csv
for f in $files; do echo $f; done
```

`@possible_answers`
- 없음: `files`가 다른 줄에서 정의되었으므로, 두 번째 줄에서는 값이 없습니다.
- 한 줄: "files"라는 단어.
- 네 줄: 네 개의 계절별 데이터 파일 이름.

`@hint`
`X`만 그대로 쓰면 그냥 "X"이고, `$X`는 변수 `X`의 값이라는 점을 기억하세요.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "아니요: 변수를 사용하는 줄에 변수를 정의할 필요는 없습니다."
err2 = "아니요: 이 예제는 동일한 셸에서 변수 `files`를 정의하고 사용합니다."
correct3 = "정확합니다. 이 명령은 `for f in seasonal/*.csv; do echo $f; done`와 동일합니다."
Ex().has_chosen(3, [err1, err2, correct3])
```

---

## 변수의 이름과 값의 차이

```yaml
type: PureMultipleChoiceExercise
key: 4fcfb63c4f
xp: 50
```

변수 이름 앞에 `$`를 붙이는 것을 잊는 실수를 자주 해요.
이렇게 하면,
셸은 해당 변수의 값이 아니라
여러분이 입력한 이름 자체를 사용해요.

경험 많은 사용자에게 더 흔한 실수는 변수 이름을 잘못 입력하는 거예요.
예를 들어,
`datasets`를 이렇게 정의해 놓고:

```{shell}
datasets=seasonal/*.csv
```

다음처럼 입력하면:

```{shell}
echo $datsets
```

셸은 아무것도 출력하지 않아요.
두 번째 "a"가 빠진 `datsets`는 정의되어 있지 않기 때문이에요.

<hr>

홈 디렉터리에서 다음 두 명령을 실행한다면,
무엇이 출력될까요?

```{shell}
files=seasonal/*.csv
for f in files; do echo $f; done
```

(답하기 전에 루프의 첫 부분을 주의 깊게 읽어 보세요.)

`@hint`
`X`만 그대로 쓰면 그냥 "X"이고, `$X`는 변수 `X`의 값이에요.

`@possible_answers`
- [한 줄: "files"라는 단어.]
- 네 줄: 네 개의 계절 데이터 파일 이름 모두.
- 빈 줄 네 개: 변수 `f`에 값이 할당되지 않음.

`@feedback`
- 정답: 루프에서 `$files`가 아니라 `files`를 사용했으므로, 목록은 "files"라는 단어 하나로만 이루어져 있어요.
- 아니요: 루프에서 `$files`가 아니라 `files`를 사용했으므로, 목록은 `files`의 확장 결과가 아니라 "files"라는 단어로만 이루어져 있어요.
- 아니요: 변수 `f`는 `for` 루프에 의해 자동으로 정의돼요.

---

## 하나의 루프에서 많은 명령을 어떻게 실행하나요?

```yaml
type: ConsoleExercise
key: 39b5dcf81a
xp: 100
```

파일 이름을 출력하는 것은 디버깅에 유용하지만,
루프의 진짜 목적은 여러 파일을 한꺼번에 처리하는 것입니다.
다음 루프는 각 데이터 파일의 두 번째 줄을 출력합니다:

```{shell}
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
```

구조는 지금까지 본 다른 루프와 동일하고,
달라진 점은 본문이 단일 명령이 아니라 두 개의 명령을 파이프라인으로 연결했다는 것입니다.

`@instructions`
모든 계절 파일에서 2017년 7월(`2017-07`)의 마지막 항목을 출력하는 루프를 작성하세요. 출력은 다음과 유사해야 합니다:

```{shell}
grep 2017-07 seasonal/winter.csv | tail -n 1
```

하지만 계절 파일 각각에 대해 별도로 실행되어야 합니다. 루프 변수 이름은 반드시 `file`을 사용하고, 예시의 'seasonal/winter.csv'가 아니라 파일 목록 `seasonal/*.csv`를 순회하도록 하세요.

`@hint`
루프 본문은 지침에 나온 grep 명령에서 `seasonal/winter.csv`를 `$file`로 바꾼 것입니다.

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
  has_code('for', incorrect_msg='`for`를 호출하셨나요?'),
  check_correct(
    has_expr_output(),
    multi(
      has_code('file', incorrect_msg='루프 변수로 `file`을 사용하셨나요?'),
      has_code('in', incorrect_msg='파일 목록 앞에 `in`을 사용하셨나요?'),
      has_code('seasonal/\*', incorrect_msg='`seasonal/*`로 파일 목록을 지정하셨나요?'),
      has_code(r'seasonal\/\*\.csv\s*;', incorrect_msg='파일 목록 뒤에 세미콜론을 넣으셨나요?'),
      has_code(r';\s*do', incorrect_msg='첫 번째 세미콜론 뒤에 `do`를 사용하셨나요?'),
      has_code('grep', incorrect_msg='`grep`을 호출하셨나요?'),
      has_code('2017-07', incorrect_msg='`2017-07`을 매치하셨나요?'),
      has_code(r'\$file', incorrect_msg='루프 변수 이름으로 `$file`을 사용하셨나요?'),
      has_code(r'file\s*|', incorrect_msg='두 번째 명령을 연결하기 위해 파이프를 사용하셨나요?'),
      has_code(r'tail\s*-n\s*1', incorrect_msg='두 번째 명령에서 각 검색의 마지막 항목을 출력하기 위해 `tail -n 1`을 사용하셨나요?'),
      has_code('; done', incorrect_msg='`done`으로 끝내셨나요?')
    )
  )
)

Ex().success_msg("반복문을 잘 사용하셨습니다! 와일드카드와 반복문은 강력한 조합입니다.")
```

---

## 파일 이름에 공백을 쓰면 안 되는 이유는 무엇인가요?

```yaml
type: PureMultipleChoiceExercise
key: b974b7f45a
xp: 50
```

그래픽 파일 탐색기를 사용할 때는 `July 2017.csv`처럼 여러 단어로 된 파일 이름을 쓰는 것이 쉽고 합리적일 수 있어요.
하지만 셸에서 작업할 때는 문제가 됩니다.
예를 들어,
`July 2017.csv`의 이름을 `2017 July data.csv`로 바꾸고 싶다고 해봅시다.
다음처럼 입력할 수는 없어요:

```{shell}
mv July 2017.csv 2017 July data.csv
```

왜냐하면 셸은 이를 네 개의 파일 `July`, `2017.csv`, `2017`, 그리고 다시 `July`를
`data.csv`라는 디렉터리로 옮기려는 것으로 보기 때문입니다.
대신,
각 파일 이름을 따옴표로 감싸서
셸이 각각을 하나의 인자로 취급하도록 해야 해요:

```{shell}
mv 'July 2017.csv' '2017 July data.csv'
```

<hr>

`current.csv`와 `last year.csv`라는 두 파일이 있고
(둘 중 하나는 이름에 공백이 있음)
다음과 같이 입력하면:

```{shell}
rm current.csv last year.csv
```

무슨 일이 일어날까요:

`@hint`
누군가 이 명령을 보여줬는데, 어떤 파일이 있는지 모른다면 무엇이 일어날 거라고 예상하실 건가요?

`@possible_answers`
- 셸은 `last`와 `year.csv`가 존재하지 않기 때문에 오류 메시지를 출력해요.
- 셸은 `current.csv`를 삭제해요.
- [위 두 가지 모두.]
- 아무 일도 일어나지 않아요.

`@feedback`
- 맞아요, 하지만 그게 전부는 아니에요.
- 맞아요, 하지만 그게 전부는 아니에요.
- 정답입니다. 파일 이름은 작은따옴표 `'` 또는 큰따옴표 `"`로 감쌀 수 있어요.
- 아쉽지만 그렇지 않아요.

---

## 하나의 루프에서 여러 작업을 어떻게 처리하나요?

```yaml
type: MultipleChoiceExercise
key: f6d0530991
xp: 50
```

지금까지 본 루프의 본문에는 하나의 명령어나 파이프라인만 있었지만,
루프에는 원하는 만큼 많은 명령을 넣을 수 있어요.
쉘이 어디서 하나가 끝나고 다음이 시작되는지 알 수 있도록
세미콜론으로 구분해야 합니다:

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

이전 루프에서 `echo`와 `head` 명령 사이의 세미콜론을 빼먹어서,
다음과 같이 쉘에 실행하도록 요청했다고 가정해 봅시다:

```{shell}
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
```

쉘은 무엇을 할까요?

`@possible_answers`
- 오류 메시지를 출력합니다.
- 네 개의 파일 각각에 대해 한 줄씩 출력합니다.
- `autumn.csv`(첫 번째 파일)에 대한 한 줄만 출력합니다.
- 각 파일의 마지막 줄을 출력합니다.

`@hint`
`echo`의 출력을 `tail`로 파이프로 연결할 수 있어요.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
err1 = "아니요: 루프는 실행되지만, 의미 있는 작업을 수행하지는 않습니다."
correct2 = "예: `echo`는 파일 이름을 두 번 포함하는 한 줄을 생성하고, `tail`은 이를 복사합니다."
err3 = "아니요: 루프는 네 개의 파일 이름 각각에 대해 한 번씩 실행됩니다."
err4 = "아니요: `tail`의 입력은 각 파일 이름에 대한 `echo`의 출력입니다."
Ex().has_chosen(2, [err1, correct2, err3, err4])
```

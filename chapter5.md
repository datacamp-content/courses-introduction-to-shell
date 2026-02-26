---
title: 새로운 도구 만들기
description: >-
  히스토리는 몇 번의 키 입력만으로 작업을 반복할 수 있게 해주고, 파이프는 기존 명령을 조합해 새로운 기능을 만들어 줍니다. 이 장에서는 한
  단계 더 나아가 여러분만의 새 명령을 만드는 방법을 살펴봅니다.
lessons:
  - nb_of_exercises: 9
    title: 파일을 어떻게 편집하나요?
---

## 파일은 어떻게 편집하나요?

```yaml
type: ConsoleExercise
key: 39eee3cfc0
xp: 100
```

Unix에는 정말 다양한 텍스트 편집기가 있어 헷갈리기 쉽습니다.
이 강의에서는 Nano라는 간단한 편집기를 사용하겠습니다.
`nano filename`을 입력하면
편집을 위해 `filename`이 열립니다
(파일이 없으면 새로 만들어집니다).
화살표 키로 이동하고,
백스페이스로 문자 삭제를 할 수 있으며,
Ctrl 키 조합으로 다른 작업도 할 수 있습니다:

- `Ctrl` + `K`: 한 줄 삭제.
- `Ctrl` + `U`: 방금 삭제한 줄 복구.
- `Ctrl` + `O`: 파일 저장(‘O’는 ‘output’을 의미). _파일명을 확인하려면 Enter를 한 번 더 눌러야 합니다!_
- `Ctrl` + `X`: 편집기 종료.

`@instructions`
홈 디렉터리에서 새 파일을 편집하려면 `nano names.txt`를 실행하고,
다음 네 줄을 입력하세요:

```
Lovelace
Hopper
Johnson
Wilson
```

작성한 내용을 저장하려면,
`Ctrl` + `O`로 파일을 저장하고,
Enter로 파일명을 확인한 다음,
`Ctrl` + `X`로 편집기를 종료하세요.

`@hint`


`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/names.txt /home/repl
```

`@sct`
```{python}
patt = "파일 `names.txt`에 `%s` 줄을 포함시켰습니까? 파일을 업데이트하려면 `nano names.txt`를 다시 사용하십시오. 저장하려면 `Ctrl` + `O`를 사용하고 종료하려면 `Ctrl` + `X`를 사용하십시오."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/names.txt').multi(
        has_code(r'Lovelace', incorrect_msg=patt%'Lovelace'),
        has_code(r'Hopper', incorrect_msg=patt%'Hopper'),
        has_code(r'Johnson', incorrect_msg=patt%'Johnson'),
        has_code(r'Wilson', incorrect_msg=patt%'Wilson')
    )
)
Ex().success_msg("잘하셨습니다! 다음으로 넘어가겠습니다!")
```

---

## 방금 한 작업을 어떻게 기록하나요?

```yaml
type: BulletConsoleExercise
key: 80c3532985
xp: 100
```

복잡한 분석을 할 때는,
사용한 명령을 기록해 두고 싶을 때가 많습니다.
이미 배운 도구들만으로도 이를 할 수 있어요:

1. `history`를 실행하세요.
2. 그 출력을 `tail -n 10`에 파이프로 연결하세요(저장하고 싶은 최근 단계 수로 바꿔도 됩니다).
3. 그 결과를 `figure-5.history` 같은 이름의 파일로 리디렉션하세요.

이 방법은 실험 노트에 손으로 적는 것보다 좋습니다.
빠뜨린 단계 없이 모두 기록되기 때문이에요.
또한 셸의 핵심 아이디어를 잘 보여 줍니다:
텍스트 줄을 생성하고 소비하는 단순한 도구들을
다양한 방식으로 조합해
폭넓은 문제를 해결할 수 있다는 점입니다.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 144ca955ca
xp: 35
```

`@instructions`
`seasonal/spring.csv`와 `seasonal/summer.csv` 파일을 홈 디렉터리로 복사하세요.

`@hint`
`cp`로 복사하고, 홈 디렉터리 경로의 바로 가기로 `~`를 사용하세요.

`@solution`
```{shell}
cp seasonal/s* ~

```

`@sct`
```{python}
msg="`cp seasonal/s* ~` 명령어를 사용하여 필요한 파일을 홈 디렉토리로 복사하셨습니까?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/spring.csv', missing_msg=msg).\
        has_code(r'2017-01-25,wisdom', incorrect_msg=msg),
    check_file('/home/repl/summer.csv', missing_msg=msg).\
        has_code(r'2017-01-11,canine', incorrect_msg=msg)
)
Ex().success_msg("놀라운 기록 보관입니다! 명령어를 잘못 입력한 경우, 나중에 `nano`를 사용하여 저장 기록 파일을 정리할 수 있습니다.")
```

***

```yaml
type: ConsoleExercise
key: 09a432e4df
xp: 35
```

`@instructions`
`grep`을 사용할 때 `-h` 플래그(파일 이름 출력 방지)와
`-v Tooth`(헤더 줄과 일치하지 않는 줄만 선택)를 함께 사용해
그 순서대로 `spring.csv`와 `summer.csv`에서 데이터 레코드만 선택하고,
출력을 `temp.csv`로 리디렉션하세요.

`@hint`
플래그는 파일 이름보다 앞에 두세요.

`@solution`
```{shell}
grep -h -v Tooth spring.csv summer.csv > temp.csv

```

`@sct`
```{python}
msg1 = "출력을 `>`를 사용하여 `grep` 명령어의 결과를 `temp.csv`로 리다이렉트했는지 확인하세요!"
msg2 = "`grep -h -v ___ ___ ___` (빈칸을 채우세요)를 사용하여 `temp.csv`를 채웠는지 확인하세요?"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/temp.csv', missing_msg=msg1).multi(
        has_code(r'2017-08-04,canine', incorrect_msg=msg2),
        has_code(r'2017-03-14,incisor', incorrect_msg=msg2),
        has_code(r'2017-03-12,wisdom', incorrect_msg=msg2)
    )
)
```

***

```yaml
type: ConsoleExercise
key: c40348c1e5
xp: 30
```

`@instructions`
`history`를 `tail -n 3`에 파이프로 연결하고
출력을 `steps.txt`로 리디렉션해
마지막 세 개의 명령을 파일에 저장하세요.
(목록에 `history` 명령 자체도 포함되므로
두 개가 아니라 세 개를 저장해야 합니다.)

`@hint`
`>`로 리디렉션하는 부분은 파이프 명령들의 맨 끝에 둬야 합니다.

`@solution`
```{shell}
history | tail -n 3 > steps.txt

```

`@sct`
```{python}
msg1="명령어의 출력을 `steps.txt`로 리디렉션했는지 확인하세요."
msg2="`history | tail ___ ___` (빈칸을 채우세요)를 사용하여 `steps.txt`를 채웠는지 확인하세요."
Ex().multi(
    has_cwd('/home/repl'),
    # When run by the validator, solution3 doesn't pass, so including a has_code for that
    check_or(
        check_file('/home/repl/steps.txt', missing_msg=msg1).multi(
            has_code(r'\s+1\s+', incorrect_msg=msg2),
            has_code(r'\s+3\s+history', incorrect_msg=msg2)
        ),
        has_code(r'history\s+|\s+tail\s+-n\s+4\s+>\s+steps\.txt')
    )
)
Ex().success_msg("잘하셨습니다! 이제 한 단계 더 나아가 봅시다!")
```

---

## 나중에 다시 실행할 명령을 저장하려면 어떻게 하나요?

```yaml
type: BulletConsoleExercise
key: 4507a0dbd8
xp: 100
```

지금까지는 셸을 대화형으로 사용했어요.
하지만 입력한 명령은 결국 텍스트이므로,
파일에 저장해 셸이 여러 번 반복해서 실행하게 할 수 있습니다.
이 강력한 기능을 살펴보려면,
다음 명령을 `headers.sh`라는 파일에 넣어 보세요:

```{shell}
head -n 1 seasonal/*.csv
```

이 명령은 `seasonal` 디렉터리에 있는 각 CSV 파일에서 첫 번째 행을 선택합니다.
파일을 만들었으면,
다음과 같이 입력해 실행할 수 있어요:

```{shell}
bash headers.sh
```

이는 셸(정확히는 `bash`라는 프로그램)에게
`headers.sh` 파일에 들어 있는 명령을 실행하라고 지시하며,
명령을 직접 실행했을 때와 동일한 결과를 보여줍니다.

`@pre_exercise_code`
```{python}

```

***

```yaml
type: ConsoleExercise
key: 316ad2fec6
xp: 50
```

`@instructions`
`nano dates.sh`를 사용해 `dates.sh`라는 파일을 만들고,
다음 명령을 담아 두세요:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

이를 통해 `seasonal`의 모든 CSV 파일에서 첫 번째 열을 추출합니다.

`@hint`
여분의 빈 줄이나 공백 없이 보여 준 명령을 그대로 파일에 넣으세요.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/dates.sh ~

```

`@sct`
```{python}
msg = "파일 `dates.sh`에 `cut -d , -f 1 seasonal/*.csv` 줄을 포함하셨습니까? `nano dates.sh`를 다시 사용하여 파일을 업데이트하십시오. `Ctrl` + `O`를 사용하여 저장하고 `Ctrl` + `X`를 사용하여 종료하십시오."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/dates.sh').\
        has_code('cut -d *, *-f +1 +seasonal\/\*\.csv', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: 30a8fa953e
xp: 50
```

`@instructions`
`bash`를 사용해 `dates.sh` 파일을 실행하세요.

`@hint`
파일을 실행하려면 `bash filename`을 사용하세요.

`@solution`
```{shell}
bash dates.sh

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("bash", incorrect_msg = '`bash`를 호출하셨나요?'),
      has_code("dates.sh", incorrect_msg = '`dates.sh` 파일을 지정하셨나요?')
    )
  )
)

```

---

## 파이프를 재사용하려면 어떻게 하나요?

```yaml
type: BulletConsoleExercise
key: da13667750
xp: 100
```

셸 명령어를 가득 담은 파일을 ***셸 스크립트**라고 하고,
줄여서 그냥 "스크립트"라고도 해요. 스크립트의 파일명이 꼭 `.sh`로 끝나야 하는 것은 아니지만,
이 레슨에서는 어떤 파일이 스크립트인지 구분하기 쉽도록
그 관례를 따르겠습니다.

스크립트에는 파이프도 포함할 수 있어요.
예를 들어,
`all-dates.sh`에 다음 줄이 들어 있다면:

```{shell}
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
```

다음 명령은:

```{shell}
bash all-dates.sh > dates.out
```

계절별 데이터 파일에서 고유한 날짜를 추출해
`dates.out`에 저장합니다.

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/teeth-start.sh', 'teeth.sh')
```

***

```yaml
type: ConsoleExercise
key: 6fae90f320
xp: 35
```

`@instructions`
홈 디렉터리에 `teeth.sh` 파일이 준비되어 있지만, 일부가 비어 있어요.
Nano로 파일을 열어 두 개의 `____` 자리표시자를
`seasonal/*.csv`와 `-c`로 바꿔 주세요. 그러면 이 스크립트가 `seasonal` 디렉터리의 CSV 파일들에서
각 치아 이름이 나타나는 횟수를 집계해 출력합니다.

`@hint`
`nano teeth.sh`로 파일을 편집하세요.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/teeth.sh ~

```

`@sct`
```{python}
msg="`teeth.sh` 파일의 공백을 제대로 대체하여 명령어가 `cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c`로 읽히도록 하셨습니까? 필요한 변경을 위해 `nano teeth.sh`를 다시 사용하십시오."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/teeth.sh').\
        has_code(r'cut\s+-d\s+,\s+-f\s+2\s+seasonal/\*\.csv\s+\|\s+grep\s+-v\s+Tooth\s+\|\s+sort\s+\|\s+uniq\s+-c', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: dcfccb51e2
xp: 35
```

`@instructions`
`bash`로 `teeth.sh`를 실행하고, `>`를 사용해 출력을 `teeth.out`으로 리디렉션하세요.

`@hint`
`> teeth.out`은 출력을 만들어 내는 명령어 뒤에 와야 한다는 점을 기억하세요.

`@solution`
```{shell}
# We need to use 'cp' below to satisfy our automated tests.
# You should only use the last line that runs 'bash'.
cp /solutions/teeth.sh .
bash teeth.sh > teeth.out

```

`@sct`
```{python}
msg="`bash teeth.sh`의 결과를 `>`를 사용하여 `teeth.out`으로 올바르게 리디렉션하셨습니까?"
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/teeth.out').multi(
      has_code(r'31 canine', incorrect_msg=msg),
      has_code(r'17 wisdom', incorrect_msg=msg)
    ),
    multi(
      has_code("bash", incorrect_msg = '`bash`를 호출하셨습니까?'),
      has_code("bash\s+teeth.sh", incorrect_msg = '`teeth.sh` 파일을 실행하셨습니까?'),
      has_code(">\s+teeth.out", incorrect_msg = '`teeth.out` 파일로 리디렉션하셨습니까?')
    )
  )
)
```

***

```yaml
type: ConsoleExercise
key: c8c9a11e3c
xp: 30
```

`@instructions`
`cat teeth.out`을 실행해 결과를 확인하세요.

`@hint`
파일 이름의 몇 글자만 입력한 뒤 Tab 키를 눌러 자동 완성할 수 있다는 점을 기억하세요.

`@solution`
```{shell}
cat teeth.out

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("cat", incorrect_msg = '`cat`을 호출하셨나요?'),
      has_code("teeth.out", incorrect_msg = '`teeth.out` 파일을 지정하셨나요?')
    )
  )
)
Ex().success_msg("좋습니다! 처음에는 다소 인위적으로 느껴질 수 있지만, 좋은 점은 워크플로의 일부를 단계별로 자동화하고 있다는 것입니다. 데이터 과학자로서 매우 유용하게 쓰일 것입니다!")
```

---

## 스크립트에 파일 이름을 어떻게 전달하나요?

```yaml
type: BulletConsoleExercise
key: c2623b9c14
xp: 100
```

특정 파일을 처리하는 스크립트는 무엇을 했는지 기록으로 남길 수 있어 유용하지만, 원하는 어떤 파일이든 처리할 수 있는 스크립트가 더 유용합니다.
이를 위해 스크립트에 전달된 "모든 명령줄 매개변수"를 의미하는 특수 표현 `$@`(달러 기호 다음에 곧바로 at 기호)를 사용할 수 있습니다.

예를 들어, `unique-lines.sh`에 `sort $@ | uniq`가 들어 있다면 다음을 실행할 때:

```{shell}
bash unique-lines.sh seasonal/summer.csv
```

셸은 `$@`를 `seasonal/summer.csv`로 바꿔 하나의 파일을 처리합니다. 만약 다음을 실행하면:

```{shell}
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
```

두 개의 데이터 파일을 처리하게 됩니다. 이런 식으로 계속할 수 있어요.

_참고로, Nano에서 작성한 내용을 저장하려면 `Ctrl` + `O`로 파일을 저장하고, Enter로 파일 이름을 확인한 다음, `Ctrl` + `X`로 편집기를 종료하세요._

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/count-records-start.sh', 'count-records.sh')
```

***

```yaml
type: ConsoleExercise
key: 7a893623af
xp: 50
```

`@instructions`
Nano로 `count-records.sh` 스크립트를 열고 두 개의 `____` 자리표시자를 각각 `$@`와 `-l`(_영문자_)로 채워, 하나 이상의 파일에서 각 파일의 첫 줄을 제외하고 줄 수를 세도록 하세요.

`@hint`
* `nano count-records.sh`로 파일을 열어 수정하세요.
* 숫자 1이 아니라 _영문자_ `-l`을 지정했는지 확인하세요.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/count-records.sh ~

```

`@sct`
```{python}
msg="`count-records.sh` 파일의 명령어가 `tail -q -n +2 $@ | wc -l`로 제대로 수정되었습니까? 필요한 변경을 위해 `nano count-records.sh`를 다시 사용하십시오."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/count-records.sh').\
        has_code('tail\s+-q\s+-n\s+\+2\s+\$\@\s+\|\s+wc\s+-l', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: d0da324516
xp: 50
```

`@instructions`
`seasonal/*.csv`에 대해 `count-records.sh`를 실행하고, 출력은 `>`를 사용해 `num-records.out`으로 리디렉션하세요.

`@hint`
출력을 리디렉션하려면 `>`를 사용하세요.

`@solution`
```{shell}
bash count-records.sh seasonal/*.csv > num-records.out

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    check_file('/home/repl/num-records.out').has_code(r'92'),
    multi(
      has_code("bash", incorrect_msg = '`bash`를 호출하셨습니까?'),
      has_code("bash\s+count-records.sh", incorrect_msg = '`count-records.sh` 파일을 실행하셨습니까?'),
      has_code("seasonal/\*", incorrect_msg = '`seasonal/*`로 처리할 파일을 지정하셨습니까?'),
      has_code(">\s+num-records.out", incorrect_msg = '`num-records.out` 파일로 리디렉션하셨습니까?')
    )
  )
)
Ex().success_msg("잘하셨습니다! 당신의 셸 능력이 계속 확장되고 있습니다!")
```

---

## 단일 인수를 어떻게 처리할 수 있나요?

```yaml
type: PureMultipleChoiceExercise
key: 4092cb4cda
xp: 50
```

`$@`뿐만 아니라,
셸에서는 `$1`, `$2`처럼 특정 명령줄 매개변수를 가리킬 수 있어요.
이를 활용하면 셸 기본 문법보다 더 간단하고 자연스러운 느낌의 명령을 작성할 수 있습니다.
예를 들어,
사용자가 첫 번째 매개변수로 파일 이름을, 두 번째로 열 번호를 주면
CSV 파일에서 해당 열만 선택하는 `column.sh` 스크립트를 만들 수 있어요:

```{shell}
cut -d , -f $2 $1
```

그리고 다음처럼 실행합니다:

```{shell}
bash column.sh seasonal/autumn.csv 1
```

스크립트가 두 매개변수를 역순으로 사용한다는 점에 주목하세요.

<hr>

`get-field.sh` 스크립트는 파일 이름,
선택할 행 번호,
선택할 열 번호를 받아서
CSV 파일에서 해당 필드만 출력해야 합니다.
예를 들어:

```
bash get-field.sh seasonal/summer.csv 4 2
```

는 `seasonal/summer.csv`의 4번째 줄에서 두 번째 필드를 선택해야 합니다.
이를 위해 `get-field.sh`에는 다음 중 어떤 명령을 넣어야 할까요?

`@hint`
명령줄 매개변수는 왼쪽에서 오른쪽으로 번호가 매겨진다는 점을 기억하세요.

`@possible_answers`
- `head -n $1 $2 | tail -n 1 | cut -d , -f $3`
- [`head -n $2 $1 | tail -n 1 | cut -d , -f $3`]
- `head -n $3 $1 | tail -n 1 | cut -d , -f $2`
- `head -n $2 $3 | tail -n 1 | cut -d , -f $1`

`@feedback`
- 아니요: 그렇게 하면 파일 이름을 `head`로 선택할 줄 수로 잘못 사용하게 됩니다.
- 정답입니다!
- 아니요: 그렇게 하면 열 번호와 줄 번호를 서로 바꿔서 사용하게 됩니다.
- 아니요: 그렇게 하면 필드 번호를 파일 이름으로, 파일 이름을 필드 번호로 잘못 사용하게 됩니다.

---

## 하나의 셸 스크립트로 여러 작업을 하려면?

```yaml
type: TabConsoleExercise
key: 846bc70e9d
xp: 100
```

지금까지의 셸 스크립트는 하나의 명령어나 파이프만 사용했지만, 스크립트에는 여러 줄의 명령을 넣을 수 있어요. 예를 들어, 각 데이터 파일 중 가장 짧은 것과 가장 긴 것에 레코드가 몇 개인지, 즉 데이터셋 길이의 범위를 알려 주는 스크립트를 만들 수 있어요.

Nano에서 "복사/붙여넣기"는 원하는 줄로 이동해 `CTRL` + `K`로 해당 줄을 잘라낸 뒤, `CTRL` + `U`를 두 번 눌러 두 번 붙여넣기 하면 됩니다.

_참고로, Nano에서 작성한 내용을 저장하려면 `Ctrl` + `O`로 파일을 저장하고, Enter로 파일명을 확인한 다음, `Ctrl` + `X`로 편집기를 종료하세요._

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/range-start-1.sh', 'range.sh')
```

***

```yaml
type: ConsoleExercise
key: a1e55487fb
xp: 25
```

`@instructions`
Nano로 `range.sh` 스크립트를 편집하고,
두 개의 `____` 자리표시자를 `$@`와 `-v`로 바꿔서
명령줄에서 지정한 모든 파일의 이름과 줄 수를 나열하되,
모든 파일의 총 줄 수는 표시하지 않게 하세요.
(각 파일의 컬럼 헤더 줄은 빼려고 하지 마세요.)

`@hint`
명령줄에서 전달된 모든 파일의 줄 수를 세려면 `wc -l $@`를 사용하세요.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-1.sh range.sh

```

`@sct`
```{python}
msg="`range.sh` 파일의 명령어가 `wc -l $@ | grep -v total`로 읽히도록 공백을 제대로 대체하셨습니까? 필요한 변경을 위해 `nano range.sh`를 다시 사용하십시오."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').\
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: e8ece27fe7
xp: 25
```

`@instructions`
다시 Nano를 사용해 `range.sh`의 파이프라인에
`sort -n`과 `head -n 1`을 그 순서대로 추가하여
가장 짧은 파일의 이름과 줄 수를 표시하세요.

`@hint`


`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-2.sh range.sh

```

`@sct`
```{python}
msg="`sort -n`과 `head -n 1`을 파이프와 함께 `range.sh` 파일에 추가하셨습니까? `nano range.sh`를 다시 사용하여 필요한 변경을 하십시오."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').\
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total\s+\|\s+sort\s+-n\s+|\s+head\s+-n\s+1', incorrect_msg=msg)
)
```

***

```yaml
type: ConsoleExercise
key: a3b36a746e
xp: 25
```

`@instructions`
Nano를 계속 사용해 `range.sh`에 두 번째 줄을 추가하여,
디렉터리에서 가장 짧은 파일뿐 아니라
가장 긴 파일의 이름과 레코드 수도 출력하세요.
이 줄은 이미 작성한 줄을 그대로 복제하되,
`sort -n` 대신 `sort -n -r`을 사용해야 합니다.

`@hint`
첫 번째 줄을 복사한 다음 정렬 기준만 바꾸세요.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/range-3.sh range.sh

```

`@sct`
```{python}
msg1="`range.sh` 파일의 첫 번째 줄을 유지하십시오: `wc -l $@ | grep -v total | sort -n | head -n 1`"
msg2="`range.sh`의 첫 번째 줄을 복제하고 작은 변경을 하셨습니까? `sort -n` 대신 `sort -n -r`을 사용하세요!"
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/range.sh').multi(
        has_code("wc -l $@ | grep -v total | sort -n | head -n 1", fixed=True, incorrect_msg = msg1),
        has_code(r'wc\s+-l\s+\$@\s+\|\s+grep\s+-v\s+total\s+\|\s+sort\s+-n\s+-r\s+|\s+head\s+-n\s+1', incorrect_msg=msg2)
    )
)
```

***

```yaml
type: ConsoleExercise
key: cba93a77c3
xp: 25
```

`@instructions`
`seasonal` 디렉터리의 파일들에 대해 스크립트를 실행하세요.
모든 파일을 매칭하려면 `seasonal/*.csv`를 사용하고,
출력은 `>`를 사용해 홈 디렉터리의 `range.out` 파일로 리디렉션하세요.

`@hint`
스크립트 실행에는 `bash range.sh`, 파일 지정에는 `seasonal/*.csv`, 출력 리디렉션에는 `> range.out`을 사용하세요.

`@solution`
```{shell}
bash range.sh seasonal/*.csv > range.out

```

`@sct`
```{python}
msg="`bash range.sh seasonal/*.csv`의 결과를 `>`를 사용하여 `range.out`으로 올바르게 리디렉션하셨습니까?"
Ex().multi(
has_cwd('/home/repl'),
multi(
has_code("bash", incorrect_msg = '`bash`를 호출하셨습니까?'),
has_code("bash\s+range.sh", incorrect_msg = '`range.sh` 파일을 실행하셨습니까?'),
has_code("seasonal/\*", incorrect_msg = '`seasonal/*`로 처리할 파일을 지정하셨습니까?'),
has_code(">\s+range.out", incorrect_msg = '`range.out` 파일로 리디렉션하셨습니까?')
)
)

Ex().success_msg("잘하고 계십니다. 다음 연습으로 넘어가서 루프 작성에 대해 배워보세요!")
```

---

## 셸 스크립트에서 반복문은 어떻게 작성하나요?

```yaml
type: BulletConsoleExercise
key: 6be8ca6009
xp: 100
```

셸 스크립트에도 반복문을 넣을 수 있어요. 반복문은 세미콜론으로 한 줄에 쓸 수도 있고, 가독성을 높이기 위해 세미콜론 없이 줄을 나눠 쓸 수도 있습니다:

```{shell}
# 각 파일의 첫 번째와 마지막 데이터 레코드를 출력합니다.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```

(반복문 안의 명령을 들여쓰기할 필요는 없지만, 들여쓰면 더 이해하기 쉬워집니다.)

이 스크립트의 첫 줄은 스크립트가 무엇을 하는지 알려 주는 **주석**입니다. 주석은 `#` 문자로 시작해 줄 끝까지 이어집니다. 여기처럼 간단한 설명을 모든 스크립트에 덧붙여 두면, 미래의 여러분이 감사하게 될 거예요.

_참고로, Nano에서 작성한 내용을 저장하려면 `Ctrl` + `O`로 파일을 저장하고, Enter로 파일 이름을 확인한 뒤, `Ctrl` + `X`로 편집기를 종료하세요._

`@pre_exercise_code`
```{python}
import shutil
shutil.copyfile('/solutions/date-range-start.sh', '/home/repl/date-range.sh')
```

***

```yaml
type: ConsoleExercise
key: 8ca2adb6c4
xp: 35
```

`@instructions`
스크립트 `date-range.sh`의 플레이스홀더를
`$filename`(두 번), `head`, `tail`로 채워서
하나 이상의 파일에서 첫 번째 날짜와 마지막 날짜를 출력하도록 하세요.

`@hint`
반복 변수의 현재 값을 가져오려면 `$filename`을 사용해야 합니다.

`@solution`
```{shell}
# This solution uses `cp` instead of `nano`
# because our automated tests can't edit files interactively.
cp /solutions/date-range.sh date-range.sh

```

`@sct`
```{python}
msgpatt="`date-range.sh` 파일에서 루프의 %s 줄을 `%s`로 변경하셨습니까? 변경하려면 `nano date-range.sh`를 사용하십시오."
cmdpatt = 'cut -d , -f 1 $filename | grep -v Date | sort | %s -n 1'
msg1=msgpatt%('첫 번째', cmdpatt%'head')
msg2=msgpatt%('두 번째', cmdpatt%'tail')
patt='cut\s+-d\s+,\s+-f\s+1\s+\$filename\s+\|\s+grep\s+-v\s+Date\s+\|\s+sort\s+\|\s+%s\s+-n\s+1'
patt1 = patt%'head'
patt2 = patt%'tail'
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/date-range.sh').multi(
        has_code(patt1, incorrect_msg=msg1),
        has_code(patt2, incorrect_msg=msg2)
    )
)
```

***

```yaml
type: ConsoleExercise
key: ec1271356d
xp: 35
```

`@instructions`
`seasonal/*.csv`로 이름을 매칭하여
네 개의 계절별 데이터 파일 모두에 `date-range.sh`를 실행하세요.

`@hint`
와일드카드 표현식은 디렉터리 이름으로 시작해야 합니다.

`@solution`
```{shell}
bash date-range.sh seasonal/*.csv

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("bash", incorrect_msg = '`bash`를 호출하셨나요?'),
      has_code("bash\s+date-range.sh", incorrect_msg = '`date-range.sh` 파일을 실행하셨나요?'),
      has_code("seasonal/\*", incorrect_msg = '`seasonal/*`로 처리할 파일을 지정하셨나요?')
    )
  )
)

```

***

```yaml
type: ConsoleExercise
key: 0323c7d68d
xp: 30
```

`@instructions`
`seasonal/*.csv`로 이름을 매칭하여 네 개의 계절별 데이터 파일 모두에 `date-range.sh`를 실행하고,
출력을 `sort`로 파이프하여 여러분의 스크립트가 Unix의 기본 명령처럼 그대로 사용할 수 있음을 확인하세요.

`@hint`
앞에서 사용한 것과 동일한 와일드카드 표현식을 사용하세요.

`@solution`
```{shell}
bash date-range.sh seasonal/*.csv | sort

```

`@sct`
```{python}
Ex().multi(
  has_cwd('/home/repl'),
  check_correct(
    has_expr_output(),
    multi(
      has_code("bash", incorrect_msg = '`bash`를 호출하셨나요?'),
      has_code("bash\s+date-range.sh", incorrect_msg = '`date-range.sh` 파일을 실행하셨나요?'),
      has_code("seasonal/\*", incorrect_msg = '`seasonal/*`로 처리할 파일을 지정하셨나요?'),
      has_code("|", incorrect_msg = '스크립트 출력에서 `sort`로 파이프를 사용하셨나요?'),
      has_code("sort", incorrect_msg = '`sort`를 호출하셨나요?')
    )
  )
)
Ex().success_msg("마법입니다! 우리가 배운 모든 것들이 얼마나 조합 가능한지 주목하세요.")
```

---

## 파일 이름을 제공하지 않으면 어떻게 되나요?

```yaml
type: MultipleChoiceExercise
key: 8a162c4d54
xp: 50
```

셸 스크립트(또는 대화형 명령)에서 흔히 하는 실수는 파일 이름을 잘못된 위치에 넣는 것입니다.
다음과 같이 입력하면:

```{shell}
tail -n 3
```

`tail` 에게 아무 파일 이름도 주지 않았기 때문에,
키보드에서 입력이 오기를 기다립니다.
이는 다음과 같이 입력했을 때도 마찬가지입니다:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

`tail` 은 `somefile.txt` 의 마지막 세 줄을 출력하지만,
`head` 는 파일 이름을 받지 않았고 파이프라인의 앞에서도 아무 입력이 오지 않기 때문에
영원히 키보드 입력을 기다리게 됩니다.

<hr>

만약 실수로 다음과 같이 입력했다면:

```{shell}
head -n 5 | tail -n 3 somefile.txt
```

다음에 무엇을 해야 할까요?

`@possible_answers`
- `head` 가 타임아웃될 때까지 10초 기다린다.
- `somefile.txt` 를 입력하고 Enter 를 눌러 `head` 에 입력을 제공한다.
- 실행 중인 `head` 프로그램을 중지하려면 `Ctrl` + `C` 를 사용한다.

`@hint`
파일 이름이 없고, 파이프라인의 앞에서도 아무 입력이 오지 않을 때 `head` 는 무엇을 하나요?

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
a1 = '아니요, 명령어는 시간 초과되지 않습니다.'
a2 = '아니요, 그것은 `head`에게 `somefile.txt` 텍스트를 처리하도록 주지만, 더 많은 입력을 기다리며 멈출 것입니다.'
a3 = "네! 실행 중인 프로그램을 중지하려면 `Ctrl` + `C`를 사용해야 합니다. 이것으로 이 입문 과정을 마칩니다! 더 많은 명령줄 도구를 배우고 싶다면, 저희의 무료 Git 입문 과정을 강력히 추천합니다!"
Ex().has_chosen(3, [a1, a2, a3])
```

---
title: 도구 결합하기
description: >-
  Unix 셸의 진정한 힘은 개별 명령 자체가 아니라, 새 일을 하도록 손쉽게 조합할 수 있다는 데 있습니다. 이 장에서는 원하는 데이터를
  선택하는 방법을 배우고, 값을 정렬하고 중복을 제거하는 명령을 소개해요.
lessons:
  - nb_of_exercises: 12
    title: 명령의 출력을 파일에 어떻게 저장할 수 있을까요?
---

## 명령의 출력을 파일에 저장하려면 어떻게 하나요?

```yaml
type: ConsoleExercise
key: 07a427d50c
xp: 100
```

지금까지 살펴본 도구들은 모두 입력 파일 이름을 지정할 수 있었죠.
대부분은 출력 파일 이름을 지정하는 옵션이 없는데, 굳이 그럴 필요가 없기 때문입니다.
대신,
원하는 곳에 어떤 명령의 출력이든 저장할 수 있도록 **리디렉션(redirection)** 을 사용할 수 있어요.
다음 명령을 실행하면:

```{shell}
head -n 5 seasonal/summer.csv
```

여름 데이터의 처음 5줄이 화면에 출력됩니다.
대신 다음 명령을 실행하면:

```{shell}
head -n 5 seasonal/summer.csv > top.csv
```

화면에는 아무것도 나타나지 않습니다.
그 대신,
`head`의 출력이 `top.csv`라는 새 파일에 저장돼요.
그 파일의 내용을 `cat`으로 확인해 볼 수 있습니다:

```{shell}
cat top.csv
```

부등호 `>`는 셸에 `head`의 출력을 파일로 리디렉션하라고 지시합니다.
이는 `head` 명령의 일부가 아니며,
출력을 생성하는 모든 셸 명령에서 동일하게 동작합니다.

`@instructions`
`tail`과 리디렉션을 조합해 `seasonal/winter.csv`의 마지막 5줄을 `last.csv`라는 파일로 저장하세요.

`@hint`
마지막 5줄을 보려면 `tail -n 5`를 사용하세요.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
tail -n 5 seasonal/winter.csv > last.csv
```

`@sct`
```{python}
patt = "라인 `%s`은(는) 파일 `last.csv`에 있어야 하지만, 그렇지 않습니다. `tail -n 5 seasonal/winter.csv`의 출력을 `>`를 사용하여 `last.csv`로 리다이렉트하십시오."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/last.csv').multi(
        check_not(has_code('2017-07-01,incisor'), incorrect_msg='`last.csv`에 너무 많은 줄이 있습니다. `tail`에 `-n 5` 플래그를 사용하셨습니까?'),
        has_code('2017-07-17,canine', incorrect_msg=patt%'2017-07-17,canine'),
        has_code('2017-08-13,canine', incorrect_msg=patt%'2017-08-13,canine')
    )
)
Ex().success_msg("좋습니다! 더 연습해 봅시다!")
```

---

## 명령의 출력을 입력으로 사용할 수 있을까요?

```yaml
type: BulletConsoleExercise
key: f47d337593
xp: 100
```

파일 중간의 몇 줄만 가져오고 싶다고 해봅시다.
좀 더 구체적으로,
데이터 파일 중 하나에서 3~5번째 줄을 얻고 싶다고 합시다.
먼저 `head`로 처음 5줄을 가져와서
그 결과를 파일로 리다이렉트하고,
그다음 `tail`로 마지막 3줄을 선택할 수 있어요:

```{shell}
head -n 5 seasonal/winter.csv > top.csv
tail -n 3 top.csv
```

빠르게 확인해 보면, 이는 원본 파일의 3~5번째 줄이 맞습니다.
처음 5줄의 마지막 3줄이기 때문이죠.

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
`seasonal/winter.csv`에서 마지막 두 줄을 선택해
`bottom.csv`라는 파일로 저장하세요.

`@hint`
`tail`로 줄을 선택하고 `>`로 `tail`의 출력을 리다이렉트하세요.

`@solution`
```{shell}
tail -n 2 seasonal/winter.csv > bottom.csv

```

`@sct`
```{python}
patt="라인 `%s`은(는) 파일 `bottom.csv`에 있어야 하지만, 그렇지 않습니다. `tail -n 2 seasonal/winter.csv`의 출력을 `>`를 사용하여 `bottom.csv`로 리디렉션하십시오."
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').multi(
        check_not(has_code('2017-08-11,bicuspid'), incorrect_msg = '`bottom.csv`에 너무 많은 줄이 있습니다. `tail`에 `-n 2` 플래그를 사용하셨습니까?'),
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
원본 파일의 끝에서 두 번째 줄을 얻기 위해
`bottom.csv`에서 첫 번째 줄을 선택하세요.

`@hint`
원하는 줄을 선택하려면 `head`를 사용하세요.

`@solution`
```{shell}
head -n 1 bottom.csv

```

`@sct`
```{python}
Ex().multi(
    has_cwd('/home/repl'),
    check_file('/home/repl/bottom.csv').has_code('2017-08-11,wisdom', incorrect_msg="`bottom.csv` 파일에 문제가 있습니다. 변경하지 않았는지 확인하세요!"),
    has_expr_output(strict=True, incorrect_msg="`bottom.csv`에 `head`를 올바르게 사용하셨나요? `-n` 플래그를 올바르게 사용했는지 확인하세요.")
)

Ex().success_msg("잘하셨습니다. 다음 연습으로 넘어가 명령어를 결합하는 더 나은 방법에 대해 알아보세요.")                             

```

---

## 명령을 더 잘 결합하는 방법은 무엇일까요?

```yaml
type: ConsoleExercise
key: b36aea9a1e
xp: 100
```

리디렉션을 사용해 명령을 결합하면 두 가지 단점이 있어요:

1. 중간 파일이 많이 남아요(예: `top.csv`).
2. 최종 결과를 만드는 명령이 히스토리의 여러 줄에 흩어져요.

셸은 이 두 문제를 한 번에 해결하는 또 다른 도구인 **파이프**를 제공합니다.
다시 한 번,
먼저 `head`를 실행해 보세요:

```{shell}
head -n 5 seasonal/summer.csv
```

이번에는 `head`의 출력을 파일로 보내는 대신,
세로 막대기를 추가하고 파일 이름 없이 `tail` 명령을 붙이세요:

```{shell}
head -n 5 seasonal/summer.csv | tail -n 3
```

파이프 기호는 셸에 왼쪽 명령의 출력을
오른쪽 명령의 입력으로 사용하라고 알려줍니다.

`@instructions`
`cut`을 사용해 쉼표로 구분된 파일 `seasonal/summer.csv`의 2열에서 모든 치아 이름을 선택한 다음, 그 결과를 파이프로 `grep`에 전달하고 반전 매치를 사용해 "Tooth"라는 단어가 포함된 헤더 줄을 제외하세요. *`cut`과 `grep`은 각각 2장 연습 문제 8번과 11번에서 자세히 다뤘습니다.*

`@hint`
- 명령의 첫 번째 부분은 `cut -d field_delimiter -f column_number filename` 형태예요.
- 명령의 두 번째 부분은 `grep -v thing_to_match` 형태예요.

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
    has_expr_output(incorrect_msg = '`cut -d , -f 2 seasonal/summer.csv`의 결과를 `|`로 `grep -v Tooth`에 파이핑하셨나요?'),
    check_not(has_output("Tooth"), incorrect_msg = '`grep`을 사용하여 `"Tooth"` 헤더 라인을 제외하셨나요?')
)
Ex().success_msg("완벽한 파이핑입니다! 이번이 `|`를 처음 사용한 것일 수 있지만, 분명 마지막은 아닐 것입니다!")
```

---

## 여러 명령을 어떻게 결합할 수 있나요?

```yaml
type: ConsoleExercise
key: b8753881d6
xp: 100
```

원한다면 명령을 여러 개 이어서 연결할 수 있어요.
예를 들어, 다음 명령은:

```{shell}
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
```

다음을 수행합니다:

1. spring 데이터에서 첫 번째 열을 선택하고,
2. "Date"라는 단어가 들어 있는 헤더 줄을 제거하며,
3. 실제 데이터의 처음 10줄을 선택합니다.

`@instructions`
이전 연습 문제에서, `seasonal/summer.csv`의 2열에서 모든 치아 이름을 선택하기 위해 다음 명령을 사용했어요:

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

이 파이프라인에 `head` 명령을 이어 붙여, 맨 처음 치아 이름만 선택하도록 하세요.

`@hint`
지침의 코드를 복사해 붙여넣고, 파이프를 추가한 다음 `-n` 플래그와 함께 `head`를 호출하세요.

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
    has_output('^\s*canine\s*$', incorrect_msg = "`|`를 사용하여 파이프라인을 `head` 명령어로 확장하셨나요? `-n` 플래그를 올바르게 설정했는지 확인하세요."),
    # by coincidence, tail -n 1 returns the same as head -n 1, so check that head was called
    has_code("head", "`|`를 사용하여 파이프라인을 `head` 명령어로 확장하셨나요?")
)
Ex().success_msg("즐거운 체이닝! 여러 명령어를 함께 체이닝하여 강력한 데이터 조작 파이프라인을 구축할 수 있습니다.")
```

---

## 파일의 레코드 개수를 어떻게 셀 수 있을까요?

```yaml
type: ConsoleExercise
key: ae6a48d6aa
xp: 100
```

`wc` 명령은(“word count”의 약자) 파일의 **c**haracters(문자 수), **w**ords(단어 수), **l**ines(줄 수)를 출력합니다.
각각 하나만 출력하려면 `-c`, `-w`, `-l` 옵션을 사용하세요.

`@instructions`
`seasonal/spring.csv`에서 2017년 7월(`2017-07`) 날짜가 있는 레코드가 몇 개인지 세어 보세요.
- 이를 위해 부분 날짜를 사용해 `grep`으로 해당 줄을 선택하고, 그 결과를 파이프로 `wc`에 전달하여 적절한 플래그로 줄 수를 세세요.

`@hint`
- 날짜 형식을 다시 확인하려면 `head seasonal/spring.csv`를 사용하세요.
- 명령의 첫 부분은 `grep thing_to_match filename` 형태예요.
- 파이프 `|` 다음에는 줄 수를 세기 위해 `wc`에 `-l` 플래그를 사용하세요.

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
      has_code("grep", incorrect_msg = "`grep`을 호출하셨나요?"),
      has_code("2017-07", incorrect_msg = "`2017-07`을 검색하셨나요?"),
      has_code("seasonal/spring.csv", incorrect_msg = "`seasonal/spring.csv` 파일을 검색하셨나요?"),
      has_code("|", incorrect_msg = "`|`를 사용하여 `wc`로 파이프하셨나요?"),      
      has_code("wc", incorrect_msg = "`wc`를 호출하셨나요?"),
      has_code("-l", incorrect_msg = "`-l`로 줄 수를 세셨나요?")
    )
  )
)
Ex().success_msg("조심스럽게 세셨군요! 데이터 분석의 첫 번째 단계로 얼마나 많은 데이터를 가지고 있는지 확인하는 것은 훌륭한 시작입니다.")
```

---

## 여러 파일을 한 번에 지정하려면 어떻게 하나요?

```yaml
type: ConsoleExercise
key: 602d47e70c
xp: 100
```

대부분의 셸 명령은 여러 파일 이름을 주면 여러 파일에 대해 동작합니다.
예를 들어,
다음과 같이 해서 계절별 데이터 파일에서 첫 번째 열을 한 번에 가져올 수 있어요:

```{shell}
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
```

하지만 많은 파일 이름을 계속 타이핑하는 건 좋지 않아요.
시간을 낭비하고,
언젠가는 파일을 빼먹거나 이름을 중복해서 입력하게 되기 마련이죠.
좀 더 편리하게 작업할 수 있도록,
셸은 하나의 표현식으로 여러 파일을 지정할 수 있는 **와일드카드**를 제공합니다.
가장 흔한 와일드카드는 `*`로,
"문자가 0개 이상 일치"한다는 뜻이에요.
이를 사용하면,
위의 `cut` 명령을 이렇게 줄일 수 있습니다:

```{shell}
cut -d , -f 1 seasonal/*
```

또는 다음과 같이요:

```{shell}
cut -d , -f 1 seasonal/*.csv
```

`@instructions`
`head`를 사용해 `seasonal/spring.csv`와 `seasonal/summer.csv`에서 각각 처음 세 줄씩, 총 여섯 줄의 데이터를 가져오되, autumn과 winter 파일에서는 가져오지 않도록 단일 명령을 작성하세요.
파일 이름을 모두 쓰지 말고 와일드카드를 사용하세요.

`@hint`
- 명령의 형태는 `head -n number_of_lines filename_pattern`입니다.
- 예를 들어 `a` 디렉터리 안에서 `b`로 시작하는 파일을 맞추려면 `a/b*`를 사용할 수 있어요.

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
    has_expr_output(incorrect_msg = "`seasonal/s*`을 사용하여 `seasonal/spring.csv`와 `seasonal/summer.csv`를 선택할 수 있습니다. `-n` 플래그를 사용하여 각 파일의 처음 세 줄만 포함하도록 하세요!"),
    check_not(has_output('==> seasonal/autumn.csv <=='), incorrect_msg = "`seasonal/autumn.csv`의 출력을 포함하지 마세요. `seasonal/s*`을 사용하여 `seasonal/spring.csv`와 `seasonal/summer.csv`를 선택할 수 있습니다."),
    check_not(has_output('==> seasonal/winter.csv <=='), incorrect_msg = "`seasonal/winter.csv`의 출력을 포함하지 마세요. `seasonal/s*`을 사용하여 `seasonal/spring.csv`와 `seasonal/summer.csv`를 선택할 수 있습니다.")
)
Ex().success_msg("와일드카드 작업이 성공했습니다! 디렉토리에 수백 또는 수천 개의 파일이 포함된 경우 더욱 중요해집니다.")
```

---

## 다른 와일드카드는 무엇이 있나요?

```yaml
type: PureMultipleChoiceExercise
key: f8feeacd8c
xp: 50
```

셸에는 다른 와일드카드도 있지만,
자주 쓰이진 않습니다:

- `?`는 한 글자와 일치하므로 `201?.txt`는 `2017.txt`나 `2018.txt`와는 일치하지만 `2017-01.txt`와는 일치하지 않습니다.
- `[...]`는 대괄호 안의 문자 중 하나와 일치하므로 `201[78].txt`는 `2017.txt`나 `2018.txt`와는 일치하지만 `2016.txt`와는 일치하지 않습니다.
- `{...}`는 중괄호 안에 쉼표로 구분된 패턴 중 하나와 일치하므로 `{*.txt, *.csv}`는 이름이 `.txt` 또는 `.csv`로 끝나는 파일과는 일치하지만 `.pdf`로 끝나는 파일과는 일치하지 않습니다.

<hr/>

다음 중 어떤 표현식이 `singh.pdf`와 `johel.txt`에는 일치하지만 `sandhu.pdf`나 `sandhu.txt`에는 일치하지 않나요?

`@hint`
각 표현식을 파일 이름마다 차례로 적용해 보세요.

`@possible_answers`
- `[sj]*.{.pdf, .txt}`
- `{s*.pdf, j*.txt}`
- `[singh,johel]{*.pdf, *.txt}`
- [`{singh.pdf, j*.txt}`]

`@feedback`
- 아니요: `.pdf`와 `.txt`는 파일 이름이 아닙니다.
- 아니요: 이 표현식은 `sandhu.pdf`에도 매칭됩니다.
- 아니요: 대괄호 안의 표현식은 전체 단어가 아니라 문자 하나에만 매칭됩니다.
- 정답입니다!

---

## 텍스트 줄을 어떻게 정렬할 수 있나요?

```yaml
type: ConsoleExercise
key: f06d9e310e
xp: 100
```

이름에서 알 수 있듯이,
`sort`는 데이터를 정렬합니다.
기본값은 알파벳 오름차순이지만,
`-n`과 `-r` 플래그를 사용해 숫자 기준으로 정렬하고 출력 순서를 뒤집을 수 있습니다.
또한 `-b`는 앞쪽의 공백을 무시하도록 하고,
`-f`는 대소문자를 접어(**f**old) 처리해 대소문자 구분 없이 정렬하도록 합니다.
파이프라인에서는 원치 않는 레코드를 제거하기 위해 `grep`을 사용하고,
남은 레코드를 정렬하기 위해 `sort`를 이어서 사용하는 경우가 많습니다.

`@instructions`
`seasonal/summer.csv`의 2열에서 모든 치아 이름을 선택하기 위해 `cut`과 `grep`을 조합했던 방법을 기억하시나요?

```
cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
```

이 레시피에서 시작해, `seasonal/winter.csv`(즉, `summer.csv`가 아님)에서 치아 이름을 알파벳 내림차순으로 정렬하세요. 이를 위해 파이프라인에 `sort` 단계를 추가로 붙이세요.

`@hint`
지침에 나온 명령을 복사해 붙여넣고, 파일 이름을 바꾼 뒤 파이프를 추가하고, `-r` 플래그와 함께 `sort`를 호출하세요.

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
      has_code("cut", incorrect_msg = "`cut`을 호출하셨습니까?"),
      has_code("-d", incorrect_msg = "`-d`로 필드 구분자를 지정하셨습니까?"),
      has_code("seasonal/winter.csv", incorrect_msg = "`seasonal/winter.csv` 파일에서 데이터를 가져오셨습니까?"),
      has_code("|", incorrect_msg = "`|`를 사용하여 `cut`에서 `grep`으로, 그리고 `sort`로 파이프하셨습니까?"),      
      has_code("grep", incorrect_msg = "`grep`을 호출하셨습니까?"),
      has_code("-v", incorrect_msg = "`-v`로 매치를 반전시키셨습니까?"),
      has_code("Tooth", incorrect_msg = "`Tooth`를 검색하셨습니까?"),
      has_code("sort", incorrect_msg = "`sort`를 호출하셨습니까?"),
      has_code("-r", incorrect_msg = "`-r`로 정렬 순서를 반전시키셨습니까?")
    )
  )
)
Ex().success_msg("정렬되었습니다! `sort`는 다양한 용도로 사용됩니다. 예를 들어, `sort -n`을 `head`에 파이프하면 가장 큰 값을 보여줍니다.")
```

---

## 중복된 줄을 어떻게 제거하나요?

```yaml
type: ConsoleExercise
key: ed77aed337
xp: 100
```

종종 `sort`와 함께 사용하는 또 다른 명령은 `uniq`입니다.
`uniq`의 역할은 중복된 줄을 제거하는 것입니다.
좀 더 정확히 말하면,
서로 인접한 중복 줄을 제거합니다.
파일에 다음과 같이 있다면:

```
2017-07-03
2017-07-03
2017-08-03
2017-08-03
```

`uniq`는 다음을 출력합니다:

```
2017-07-03
2017-08-03
```

하지만 파일에 다음과 같이 있다면:

```
2017-07-03
2017-08-03
2017-07-03
2017-08-03
```

`uniq`는 네 줄 모두를 출력합니다.
그 이유는 `uniq`가 매우 큰 파일에서도 동작하도록 설계되었기 때문입니다.
인접하지 않은 중복 줄을 제거하려면
파일 전체를 메모리에 보관해야 하며
(적어도 지금까지 본 모든 고유한 줄은 보관해야 합니다).
인접한 중복만 제거하면
가장 최근의 고유한 한 줄만 메모리에 보관하면 됩니다.

`@instructions`
다음 작업을 수행하는 파이프라인을 작성하세요:

- `seasonal/winter.csv`에서 두 번째 열을 가져오고,
- 출력에서 "Tooth"라는 단어를 제거하여 치아 이름만 표시하고,
- 동일한 치아 이름이 서로 인접하도록 출력 결과를 정렬하며,
- 각 치아 이름이 몇 번 나타나는지 빈도와 함께 한 번씩만 표시합니다.

파이프라인의 시작은 이전 연습 문제와 같습니다:

```
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
```

여기에 `sort` 명령을 이어 붙이고, `uniq`와 `wc`를 사용하는 대신 `uniq -c`로 각 고유한 줄과 그 빈도를 함께 표시하세요.

`@hint`
지침에 나온 명령을 복사해 붙여넣고, 플래그 없이 `sort`로 파이프한 다음, 다시 `uniq`에 `-c` 플래그를 붙여 파이프하세요.

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
                     incorrect_msg="이 명령어로 시작해야 합니다: `cut -d , -f 2 seasonal/winter.csv | grep -v Tooth`. 이제 확장해 보세요!"),
            has_code('\|\s+sort', incorrect_msg="명령어를 `| sort`로 확장하셨나요?"),
            has_code('\|\s+uniq', incorrect_msg="명령어를 `| uniq`로 확장하셨나요?"),
            has_code('-c', incorrect_msg="`-c`로 개수를 포함하셨나요?")
        )
    )
)
Ex().success_msg("훌륭합니다! 파이프 작업을 마친 후, 결과를 저장할 수 있다면 좋지 않을까요?")
```

---

## 파이프의 출력은 어떻게 저장하나요?

```yaml
type: MultipleChoiceExercise
key: 4115aa25b2
xp: 50
```

셸에서는 파이프로 연결한 명령의 출력을 리디렉션할 수 있어요:

```{shell}
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
```

하지만 `>`는 파이프라인의 끝에만 올 수 있어요.
중간에 이렇게 쓰면:

```{shell}
cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
```

`cut`의 모든 출력이 `teeth-only.txt`에 기록되어
`grep`이 받을 내용이 없어지고,
입력을 기다리며 영원히 멈춰 있게 됩니다.

<hr>

다음처럼 파이프라인의 맨 앞에 리디렉션을 두면 어떻게 될까요?

```{shell}
> result.txt head -n 3 seasonal/winter.csv
```

`@possible_answers`
- [명령의 출력이 평소처럼 파일로 리디렉션됩니다.]
- 셸이 오류로 보고합니다.
- 셸이 입력을 영원히 기다립니다.

`@hint`
셸에서 직접 실행해 보세요.

`@pre_exercise_code`
```{python}

```

`@sct`
```{python}
Ex().has_chosen(1, ['정답입니다!', '아닙니다; 셸은 실제로 이것을 실행할 수 있습니다.', '아닙니다; 셸은 실제로 이것을 실행할 수 있습니다.'])
```

---

## 실행 중인 프로그램을 어떻게 중지하나요?

```yaml
type: ConsoleExercise
key: d1694dbdcd
xp: 100
```

지금까지 실행한 명령과 스크립트는 모두 빠르게 끝났지만,
일부 작업은 몇 분, 몇 시간, 심지어 며칠이 걸릴 수도 있어요.
또한 파이프라인 중간에 리디렉션을 잘못 넣어
프로그램이 멈춘 상태가 될 수도 있습니다.
계속 실행되길 원하지 않는다고 판단하면
`Ctrl` + `C`를 눌러 종료할 수 있어요.
이는 Unix 문서에서 종종 `^C`로 표기되며,
여기서 'c'는 소문자여도 됩니다.

`@instructions`
다음 명령을 실행하세요:

```{shell}
head
```

인자를 주지 않아(그래서 입력을 무한히 기다리게 하고)
그다음 `Ctrl` + `C`를 눌러 중지하세요.

`@hint`
간단히 head를 입력하고 Enter를 누른 다음, 실행 중인 프로그램을 `Ctrl` + `C`로 종료하세요.

`@pre_exercise_code`
```{python}

```

`@solution`
```{shell}
# Simply type head, hit Enter and exit the running program with `Ctrl` + `C`.
```

`@sct`
```{python}
Ex().has_code(r'\s*head\s*', fixed=False, incorrect_msg="`head`를 사용하셨나요?")
```

---

## 마무리

```yaml
type: BulletConsoleExercise
key: 659d3caa48
xp: 100
```

이제 정리해 보겠습니다.
계절별 데이터 파일 중 가장 짧은 파일에 레코드가 몇 개인지 찾는 파이프라인을 만들어 보세요.

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
적절한 매개변수와 함께 `wc`를 사용해 모든 계절별 데이터 파일의 줄 수를 나열하세요.
(파일명을 일일이 입력하지 말고 와일드카드를 사용하세요.)

`@hint`
`-l`을 사용해 줄 수만 표시하고, `*`로 파일명을 매치하세요.

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
      has_code("wc", incorrect_msg = "`wc`를 호출하셨나요?"),
      has_code("-l", incorrect_msg = "`-l`로 줄 수를 세셨나요?"),
      has_code("seasonal/\*", incorrect_msg = "모든 `seasonal/*` 파일에서 데이터를 가져오셨나요?")
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
파이프를 사용해 이전 명령에 다른 명령을 추가하여 "total"이라는 단어가 들어 있는 줄을 제거하세요.

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
      has_code("wc", incorrect_msg = "`wc`를 호출하셨나요?"),
      has_code("-l", incorrect_msg = "`-l`로 줄 수를 세셨나요?"),
      has_code("seasonal/\*", incorrect_msg = "모든 `seasonal/*` 파일에서 데이터를 가져오셨나요?"),
      has_code("|", incorrect_msg = "`|`를 사용하여 `wc`에서 `grep`으로 파이프하셨나요?"),      
      has_code("grep", incorrect_msg = "`grep`을 호출하셨나요?"),
      has_code("-v", incorrect_msg = "`-v`로 일치를 반전시키셨나요?"),
      has_code("total", incorrect_msg = "`total`을 검색하셨나요?")
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
`sort -n`과 `head -n 1`을 사용하는 단계를 두 개 더 추가하여 줄 수가 가장 적은 파일을 찾으세요.

`@hint`
- 숫자 기준으로 정렬하려면 `sort`의 `-n` 플래그를 사용하세요.
- 한 줄만 남기려면 `head`의 `-n` 플래그를 사용해 1로 제한하세요.

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
      has_code("wc", incorrect_msg = "`wc`를 호출하셨나요?"),
      has_code("-l", incorrect_msg = "`-l`로 줄 수를 세셨나요?"),
      has_code("seasonal/\*", incorrect_msg = "모든 `seasonal/*` 파일에서 데이터를 가져오셨나요?"),
      has_code("|", incorrect_msg = "`|`를 사용하여 `wc`에서 `grep`으로, `sort`로, `head`로 파이프하셨나요?"),      
      has_code("grep", incorrect_msg = "`grep`을 호출하셨나요?"),
      has_code("-v", incorrect_msg = "`-v`로 매치를 반전시키셨나요?"),
      has_code("total", incorrect_msg = "`total`을 검색하셨나요?"),
      has_code("sort", incorrect_msg = "`sort`를 호출하셨나요?"),
      has_code("-n", incorrect_msg = "`-n`으로 유지할 줄 수를 지정하셨나요?"),
      has_code("1", incorrect_msg = "`-n 1`로 1줄을 유지하도록 지정하셨나요?")
    )
  )
)
Ex().success_msg("훌륭합니다! `autumn.csv`가 가장 적은 줄 수를 가진 파일로 밝혀졌습니다. 배치 처리에 대해 더 알아보려면 4장을 서둘러 보세요!")
```

# Assigment Number...: 8
# Student Name.......: 오동건
# File Name..........: hw8_오동건
# Program Description: 함수를 정의하고 활용하는 방법을 익히고 패키지와 모듈을 불러오는 법을 익히는 과제입니다.

import datetime
# datetime 모듈을 불러왔다.

now = datetime.datetime.now()
# now 변수를 만들었다. 또한 모듈을 불러왔기 때문에 함수 앞에 모듈을 넣었다. 

print(now.strftime('%Y-%m-%d %H:%M:%S'))
# strtf함수를 사용해서 정해진 서식에 맞춰 현재 시간이 출력될 수 있게 했다.

import calendar
# calendar 모듈을 불러왔다.
print(calendar.isleap(2050))
# isleap함수를 이용해서 2050년의 윤년여부를 출력했다.

print(calendar.weekday(2050,7,7))
# weekday함수를 이용해서 2050년 7월 7일이 몇 요일인지를 출력했다.

from collections import Counter

# 모듈과 함수를 불러왔다.

def vowel(seq):
    cnt = Counter()
# 함수를 정의하고 입력된 문장에서 모음 개수만을 세기 위해 첫번째 for문을 만들었다.    
    for vo in seq.lower():
# 영어는 대/소문자를 구별하므로 모든 스펠링을 소문자로 바꿔서 모음임에도 불구하고 대문자여서 카운트 되지 않는 것을 막았다. 
        if vo in 'aeiou':
            cnt[vo] += 1
    for i in 'aeoiu':
            print('The number of {}: {}'.format(i,cnt[i]))
# 수행예시처럼 표현하기 위해 두번째 포문을 만들었다.

    return(seq.replace(cnt.most_common(1)[0][0],cnt.most_common(1)[0][0].upper()))
# most_common 메소드를 이용해 문자열에서 가장 많이 나타난 모음과 빈도를 찾았다.
# 그리고 인덱싱을 통해 모음만 선택했고, replace 메소드를 통해 소문자를 대문자로 바꿨다.                                              


print(vowel('The regret after not doing something is bigger than that of doing something.'))
# 주어진 문장을 함수에 입력하고 그 결과를 출력했다.

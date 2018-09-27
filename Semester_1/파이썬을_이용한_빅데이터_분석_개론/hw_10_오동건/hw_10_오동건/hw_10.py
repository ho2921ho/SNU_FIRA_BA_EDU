# Assigment Number...: 10
# Student Name.......: 오동건
# File Name..........: hw10_오동건
# Program Description: 파일을 열고 자료를 처리하는 법을 익히는 과제입니다. 

import string

strip = string.whitespace + string.punctuation
# 불필요한 부분을 지우기 위해 strip 변수를 정의했다.
# 본 과제는 화이트 스페이스만 지우면 되기 때문에 불필요한 부분일 수 있지만, 복습차원에서 해봤다.


lines = open('subway.txt', mode = 'r', encoding = 'utf-8-sig').readlines()
# lines 변수를 각 행을 문자열 자료형 값으로 가지는 리스트로 만들기 위해 readlines() 메소드를 이용했다.
# 구글링 결과, 문서 앞에 \ufeff를 지우기 위해서 코딩 방식을 utf-8-sig로 했다.


subway_data = []
# 딕셔너리 자료형을 리스트에 담기 위해 빈 리스트를 생성했다. 

for words in lines:
    if words == lines[0]:
        continue
    words = words.split(',')
    subway_data.append({lines[0].split(',')[index].strip(strip) : word.strip(strip)
                        for index, word in enumerate(words)})

# for문을 통해 가사 리스트에서 각 행을 뽑아왔다.
# 첫번째 행은 딕셔너리의 키 값이 되는 항목이므로if문으로 제외시켰다.
# for문을 통해 뽑아온 각 행을 split 메소드를 통해 ,를 기준으로 구분하여 업데이트 했다.
# 딕셔너리 축약식을 통해 딕셔너리를 생성하고 append()메소드를 통해 subway_data를 업데이트 했다.

## 딕셔너리 축약식을 사용한 방법은 다음과 같다.
# 1. 딕셔너리 키는 첫번째 행으로 고정시키기 위해, lines[0].split(',')로 두었고 index의 변화에 따라 참조되는 키 값이 변화될 수 있게 했다.
# 2. 딕셔너리 값은 words에서 한 개씩 순차적으로 뽑아와서 키 값과 대응 될 수 있게 했다.
# 3. 딕셔너리 축약식에서 index 값이 반드시 필요하므로 enmerate 함수를 사용해서 축약식을 정의했다.
# 4. 키와 값의 화이트스페이스를 지우기 위해 미리 만들어 놓은 strip 변수를 strip 메소드에 넣었다. 

#==================원하는 정보에 접근한 결과=========================
    
# 목요일의 하차 정보만 모은 목록
search_list = []
for search_data in subway_data:
    if search_data.get('요일') == '목' and search_data.get('구분') == '하차':
        search_list.append(search_data)
print(search_list)

# 8시 ~ 9시 승차인원이 1500명 이상인 날짜의 목록
search_list = []
for search_data in subway_data:
    if int(search_data.get('8')) > 1500 and search_data.get('구분') == '승차':
        # 딕셔너리의 값은 문자열 자료형이기 때문에 비교연산자를 사용하기 위해 int()를 사용해 자료형을 바꿔주었다. 
        search_list.append(search_data.get('날짜'))
print(search_list)

# 날짜가 3의 배수인 날짜 중 7시에서 8시 승차인원은 짝수인 날들의 정보를 모은 목록
search_list = []
for search_data in subway_data:
    if int(search_data.get('날짜')) % 3 == 0 and int(search_data.get('7')) % 2 == 0 and search_data.get('구분') == '승차':
        # 배수임을 확인하기 위해 % 연산자를 사용해 나머지 값이 0인지를 확인했다. 
        search_list.append(search_data)
print(search_list)

# Assigment Number...: 2
# Student Name.......: 오동건
# File Name..........: hw2_오동건
# Program Description: 문자열 자료형의 변수를 생성하고 슬라이싱하는 방법을 배우는 과제입니다. 

cellphone = 'Samsung Galaxy7'
# cellphone 변수를 만들고, 이 변수가 참조하는 값을 문자열 자료형으로 저장하기 위해''를 사용했다.
print(cellphone)
# 변수를 출력하기 위해 print 함수를 사용했다.
company = cellphone[:7]
# company 변수를 생성하기 위해, 분할 연산자 []를 사용했다. 인덱싱이 0부터 시작하기 때문에 start 자리를 생략 했고 6까지 포함되어야 하기 때문에 7을 넣어 7번째 앞인 6까지 4 인덱싱을 할 수 있게 했다. 
print(company)
# 변수를 출력하기 위해 print 함수를 사용했다.
model = cellphone[8:]
# model 변수를 분할 연산자 []를 사용했다. 또한 인덱싱이 8부터 시작하기 때문에 start에 8을 넣었고 end를 생략해여 문자열의 마지막 대상까지 추출했다.
print(model)
# 변수를 출력하기 위해 print 함수를 사용했다.
print(type(company))
# 자료형을 출력하기 위해 type함수를 적용하고  print 함수를 사용했다.
print(type(model))
# 자료형을 출력하기 위해 type함수를 적용하고  print 함수를 사용했다.
print('It had been that way for days and days.\n And then, just before the lunch bell rang, he walked into our\nclass room.\n Stepped through that door white and softly as the snow.')
# \n을 사용하여 줄바꿈을 했다. 각 문장의 시작이 한 칸 씩 들여쓰여져 있기 때문에 \n을 쓰고 스페이스를 추가했다. 또한 예시에서 class room부분에서 줄바꿈이 되어있으므로 \n을 추가했다.

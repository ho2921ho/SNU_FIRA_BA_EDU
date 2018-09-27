# Assigment Number...: 3
# Student Name.......: 오동건
# File Name..........: hw3_오동건
# Program Description: 문자열 서식을 활용하고 리스트와 튜플을 생성하고 활용하는 방법을 익힌다. 

price = 30000
VAT = 15
pay = int(price*(1+VAT/100))
# VAT 값이 %가 아니기 때문에 100으로 나눠주었고 총 비용은 세금과 음식가격을 더한 값임을 고려하여 pay 식을 구했다.
print('스테이크의 원래 가격은 {0} 원입니다. 하지만 VAT가 {1}%로, 계산하셔야 할\n가격은 {2} 원입니다.'.format(price, VAT, pay))
# {}를 사용해 대체 필드를 생성했고 {}안에 위치전달인자의 인덱스를 차례대로 넣었다.  
s = '@^TrEat EvEryonE yOu meet likE you tO be treated.$%'
s = s.strip('@^$%')
# 특수문자를 제거하기 위해 strip 메소드를 사용했고 s에 재할당 했다. 
s = s.capitalize()
# 첫 글자만 제외하고 나머지 글자를 소문자로 바꾸기 위해 capitalize 메소드를 사용했고 s에 재할당 했다.
print(s)
numbers = (2,18,26,89,45,39,14)
# 튜플을 만들기 위해 튜플 연산자 ()를 사용했다.
print(numbers)    
print(len(numbers))
# 튜플의 길이를 구하기 위해 len 함수를 사용했다. 
fruit = ['apple','orange','strawberry','pear','kiwi']
# 리스트를 만들기 위해 리스트 연산자 []를 사용했다. 
print(fruit)
fruit_sub = fruit[:3]
# 리스트의 첫 세 요소를 슬라이싱하기 위해 []를 사용했다.
# 세번째 요소의 인덱스가 2이기 때문에 []안에 3을 넣어 3 바로 앞의 인덱스인 2까지 슬라이싱이 될 수 있게 했다.
# 슬라이싱한 리스트를 fruit_sub 변수에 할당했다. 
print(fruit_sub)

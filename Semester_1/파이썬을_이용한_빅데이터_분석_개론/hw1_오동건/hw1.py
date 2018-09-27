
# Assigment Number...: 1
# Student Name.......: 오동건
# File Name..........: hw1_오동건
# Program Description: 이것은 기본적인 자료형 함수를 활용하는 법을 익히는 과제입니다.

season = input('What is your favorite season? ')
# 가장 좋아하는 계절을 입력 받을 수 있게 input 함수를 사용했다.
# 질문을 출력하기 위해 'What is your favorite season? '를 input 함수의 인자에 넣었다.
# input 함수의 변수는 계절을 뜻하는 영문 season를 사용했다.  
print(season)
# 사용자가 입력한 값을 출력하기 위해 print 함수를 사용했다.
date = input('Which date were you born? ')
# 태어날 날짜를 입력 받을 수 있게 input 함수를 사용했다.
# 질문을 출력하기 위해 'Which date were you born? '를 input 함수의 인자에 넣었다.
# input 함수의 변수는 날짜를 뜻하는 영문 date를 사용했다.
print(type(date))
# date의 자료형을 알기위해 type 함수를 사용했다.
# 출력하기 위해 print 함수를 사용했다.
# input 함수의 리턴 값이 문자열임을 확인할 수 있었다. 
print(type(float(date)))
# date의 자료형을 실수로 바꾸기 위해 float 함수를 사용했다.
# 자료형을 알기위해 type 함수를 사용했다.
# 출력하기 위해 print 함수를 사용했다.
print('My favorite season is', season+'.', 'I was born on the', str(date)+'th.')
# 사용자가 좋아하는 계절과 태어난 날짜를 한 문장에 출력하는 코드를 작성하기 위해 print 함수를 사용했다.
# season을 ','로 문자열과 구분하여, 문자열과 한칸을 띄우고 변수로 출력될 수 있게 하였다.
# season과 '.' 이 붙어서 출력될 수 있도록, '+' 기호를 사용하여 '.'문자열과 붙였다.
# date를 ','로 문자열과 구분하여, 문자열과 한칸을 띄우고 변수로 출력될 수 있게 하였다.
# date를 '.'과 붙어서 출력될 수 있도록 '+' 기호를 사용했다.
# 또한 '+' 기호를 사용하려면 자료형이 동일해야하기 때문에 date의 자료형을 float에서 string으로 변환했다.

# Assigment Number...: 9
# Student Name.......: 오동건
# File Name..........: hw9_오동건
# Program Description: csv파일을 불러오고 txt파일을 파싱하는 방법을 익히는 과제입니다.

cars = open('cars.csv', mode = 'r', encoding = 'utf-8')
# 파일을 읽었다.
for line in cars:
    print(line)
# for문을 사용해 각 행을 출력했다.
cars.close()
# read 모드는 선택사항이지만, 습관화 해두라고 하셔서 해봤다. 
cars = open('cars.csv', mode = 'r', encoding = 'utf-8')
# 파일을 읽었다.

cars_list = [] 
# 리스트에 요소를 담기위해 빈 리스트를 만들었다. 
for row in cars:
    row = row.split(',')
# 행을 ','로 나누기 위해 split 메소드를 사용했고 구분자로 ,를 입력했다.
# 그 결과를 다시 row 변수에 업데이트 했다.
    cars_list.append(tuple(row))
# append 메소드를 이용해 리스트에 항목을 넣었다.
# split 메소드는 리스트를 반환하기 때문에 tuple로 변환하기 위해 tuple 생성자를 이용했다
print(cars_list)
# list를 출력했다. 
cars.close()

My_way = open('My way.txt', mode = 'r', encoding = 'utf-8')

for line in My_way:
    print(line)
# for문을 사용해 각 행을 출력했다.
My_way.close()

My_way = open('My way.txt', mode = 'r', encoding = 'utf-8')

My_way_list = []
# 리스트에 요소를 담기위해 빈 리스트를 만들었다. 
for row in My_way:
    My_way_list.append(row)
# append 메소드를 이용해 리스트에 항목을 넣었다.
print(My_way_list[2])
# 3번째 행을 출력하기 위해 인덱스 값으로 2를 넣었다. 
My_way.close()


My_way = open('My way.txt', mode = 'a', encoding = 'utf-8')
# 파일에 문장을 추가하기 위해 mode = 'a'를 설정했다. 

My_way.write('\nI\'ll state mt case, of which i\'m certain')
# write 메소드를 이용해 문장을 추가했다.
# 또한 주어진 데이터에서 마지막 문장에 Wn이 없었기 때문에 Wn을 넣어 줄바꿈을 했다.(과제를 하면서 바뀐걸 수 도 있지만, 결과값을 출력했을 때 예시처럼 보이기 위해 설정했다.)
My_way.close()

My_way = open('My way.txt', mode = 'r', encoding = 'utf-8')
# 파일을 읽어왔다.
print(My_way.read())
# 결과를 출력했다. 


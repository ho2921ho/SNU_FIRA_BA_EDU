# Assigment Number...: 4
# Student Name.......: 오동건
# File Name..........: hw4_오동건
# Program Description: 제어문을 활용하는 방법을 익히는 과제입니다.  


식당1 = dict( 상호 = 'A', 메뉴 =  '피자', 가격 = int(20000) )
식당2 = dict( 상호 = 'B', 메뉴 =  '치킨', 가격 = int(18000) )
식당3 = dict( 상호 = 'C', 메뉴 =  '짜장면', 가격 = int(5000) )
식당4 = dict( 상호 = 'D', 메뉴 =  '초밥', 가격 = int(15000) )
식당5 = dict( 상호 = 'E', 메뉴 =  '치킨', 가격 = int(23000) )
식당6 = dict( 상호 = 'F', 메뉴 =  '족발', 가격 = int(30000) )

# 각 식당마다 하나의 dict 자료형을 만들었다.
# 제시된 표의 각 열마다 key와 value로 하여 쌍으로 묶었다.
# 가격 key에 해당하는 value의 자료형을 inter로 지정했했다.
# 다른 key들은 ''를 사용해 자료형을 문자열로 지정했다.

restaurnat_list = [식당1, 식당2, 식당3, 식당4, 식당5, 식당6]

# 모든 식당을 원소로 같는 리스트를 만들기 위해 []를 사용했다.


want_to_eat = input('먹고 싶은 음식을 입력하세요:')

# input함수를 사용해 변수를 입력할 수 있게 했다.

i = 0

L = []

while i < len(restaurnat_list):
        L.append(restaurnat_list[i]['메뉴'])
        i += 1

# while 문을 사용하여 메뉴 리스트를 만들었다. 
# 레스토랑 리스트의 길이만큼 반복문이 실행되게 만들었다.
# 빈 리스트를 생성해놓고 반복문을 통해 리스트에 항목이 추가될 수 있게 했다.

j = 0

while want_to_eat in L:
    if j < len(restaurnat_list):
        if want_to_eat in restaurnat_list[j].get('메뉴'):
            print('식당 {}, 가격 {}원'.format(restaurnat_list[j].get('상호'),restaurnat_list[j].get('가격')))
        j += 1
    else:
        break
    
else:
    print('결과가 없습니다.')
    

# 메뉴리스트를 활용하여 두번째 while문을 만들었다.
# 입력 받은 값이 메뉴 리스트에 없을 경우.
# False가 되어 반복문이 실행되지 않고 else로 넘어가게 했다.
# 입력 받은 값이 메뉴 리스트에 있을 경우,
# True가 되어 무한루프가 된다. 하지만 if를 이용해서 조건을 설정하여
# 레스토랑 리스트의 길이를 초과하면 break로 넘어가게되고 무한루프가 종료된다. 

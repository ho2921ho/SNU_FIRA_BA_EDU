# Assigment Number...: 6
# Student Name.......: 오동건
# File Name..........: hw6_오동건
# Program Description: 새로운 함수를 정의하는 법을 익히고 람다함수를 익히는 과제입니다.


# 삼각형 면적 함수

def area_triangle(h,w):
    return 0.5*(h*w)
# 함수 생성을 위해 def를 썼고 함수이름과 인수를 설정했다.
# 결과값으로 삼각형의 면적을 반환하기 위해 리턴값에 0.5*(h*w)을 널었다.

print(area_triangle(h = 10, w = 15))
# 인수에 키워드 전달인자를 사용해 h = 10, w = 15를 넣었다.


# 두 점 사이의 거리 함수

def distance(a,b):
    d = 0
    for i in (0,1):
        d = (d + (a[i] - b[i])**2)
    return(d**0.5)

# 두점 사이의 거리 연산을 구하기 위해 포문을 이용했다. 
# for문은 두번 반복되는데, 이는 이차원 상의 점의 사이의 거리를 구하기 위함이다.
# d 변수를 생성하고 초기 값에 0을 넣었다. 그리고 for문이 실행될 때 마다 인덱스값이 달라지게 하여
# (a[i] - b[i])**2의 값을 구하였고 이를 다시 d 값으로 업데이트 하는 방식으로 연산을 구했다.
# 하지만 구한 결과인 d는 점 사이의 거리를 제곱한 값이므로 **0.5를 사용하여 제곱근을 구해 리턴 값으로 설정했다.
print(distance(a = (1,2),b = (5,7)))


# 재귀함수

def count(n):
    if n == 0:
        return 'zero!!'
       
    else:
        print(n)
        return count(n-1)

print(count(n=5))

# n == 0이 참일 경우, if문이 실행되어 zero!!가 반환될 수 있게했다.
# 문제에서는 zero!!를 출력하는 함수를 만들라고 했는데, 결과값의 예시에서는 if문이 실행되고 none이 반환되지 않은 것으로 보아
# return을 사용해야할 것 같아서 그렇게 했다. 
# 반면 그렇지 않은 경우는 n을 출력하고 다시 count 함수를 호출하여 n-1값으로 다시 함수가 실행되게끔 했다.

# 람다함수


area_traiangle_id = lambda h,w: 0.5*(h*w)


print(area_traiangle_id(10,15))

# 첫번째 문제와 동일한 논리를 사용했고 다만 람다함수 같은 경우, 일반적으로 위치 매개변수인 점을 고려하여 위치 전달인자를 사용했다.

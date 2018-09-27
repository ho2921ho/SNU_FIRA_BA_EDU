## a,b,c 정수 비교

a = int(input('Enter a: '))
b = int(input('Enter b: '))
c = int(input('Enter c: '))


# max 함수를 이용

print((a+b+c) - max([a,b,c]))

# if-else문 이용
    
if b < a and c < a:
    print(b+c)

elif a < b and c < b:
    print(a+c)

elif a < c and b < c:
    print(a+b)

# for문 이용


maxValue = [a,b,c][0]

for i in range(1, len([a,b,c])):
    if maxValue < [a,b,c][i]:
        maxValue = [a,b,c][i]
print((a+b+c)-(maxValue))


## 도시 면적 구하기

city = input('Enter the name of the city: ')


if city == 'Seoul':
    size = 605

elif city == 'New York':
    size = 789

elif city == 'Beijing':
    size = 16808

else:
    size = 'Unknown'

print('The size of {} is {}'.format(city,size))


## 계승 계산

# for 문 이용
import math

for i in range(0,10):
	print(math.factorial(i))

# while 문 이용

i = 0

while i < 10:
    print(math.factorial(i))
    i += 1
    

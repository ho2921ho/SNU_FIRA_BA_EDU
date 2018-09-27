
while True:
    
    try:
        i = int(input('임의의 양의 정수를 입력하세요:'))
        if type(i) == int and 1 < i :

            for j in range(2,i+1):
                find = 0
                if i % j != 0 :
                    continue
            
                elif i == j:
                    print('이 숫자는 소수입니다')
                    find = 1


                elif i % j == 0:
                    print('{}X{} = {}'.format(j,int(i/j),i))
                    print('이 숫자는 소수가 아닙니다.')
                    break                    

            if find == 1:
                break
         

        else:
             raise ValueError

    except ValueError:
        print(' 1보다 큰 양의 정수를 입력하세요.')

    

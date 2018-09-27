6월 21일 수업
oddcount 홀수의 갯수를 계산. 
?함수 함수의 역할을 말해준다. 
벡터와 행렬
벡터[]인덱스를 할 때 쓴다. b서 빼라는 의미이다. 각각 11번째와 10번째를 뺀 값을 넣어라. 
행렬, 1:10, byrow = T로 써야 가로로 원소들이 배열된다.
seed를 설정하라는 말은 난수표에서 같은 열에서 읽는 것 결국 똑같은 결과를 만들고 싶을 때 하는 것이다. 
x=1:10
subset(x, x>5)
x = matrix(c(7,10,5,2), nr=2)
x %*% x; 3*x
행렬 합
y=matrix(2:5, nc=2)
x+y

행렬 원소 추출
x=matrix(c(2,4,4,1,0,0,1,1,2), nr=3)
x
x(1,2:3)
x[1,2:3]
x[,1:2]
x[-1,]
자연수로 이루어진 임의의 행렬에서 7의 배수의 갯수를 구하는 함수를 구현하세요.c

for=
x=1:100
x=matrix(c(1), nr =6)
x=x[x%%7==0]

set.seed(2)
x=matrix(sample(1:100,20), nr=5)
seven=funtion(y)(q=7%%)
X=C(F,M,M,M,I,M,F,F,F)
g=c('F','M','M','M','I','M','F','F','F')
g
ifelse(x=='M', 1, ifeslse(x=='F', 2, 3))

RSiteSearch('ifelse')
f.index=(g=='F')
M.index=(g=='M')
?iris
data(iris)능
str(iris)
summary(iris)

# R 플롯 그리기
plot(iris$Sepal.Length)
plot(iris$Petal.Length)

x,y 의 값 설정
plot(x=iris$Sepal.Length, y=iris$Petal.Length)
plot(iris$Sepal.Length, iris$Petal.Length, xlim=c(2,10), ylim=c(0,8))

x,y 이름 설정.
plot(x=iris$Sepal.Length, y=iris$Petal.Length, xlab="s", ylab="p")

그래프 제목

그래프 점 크기
cex=점크기를 조절 가느

그래프 점 색깔.
rplot pch  col
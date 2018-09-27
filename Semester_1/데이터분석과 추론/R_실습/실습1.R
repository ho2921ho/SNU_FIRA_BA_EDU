#R 함수 - 홀수 갯수 세기
oddcount <- function(x) {
  k <- 0 # assign 0 to k
  for (n in x) {
    if (n %% 2 == 1) k <- k+1 # %% is the modulo operator
  }
  return(k)
}

oddcount(c(1:4, 5, 7))


#벡터
x=1:12
x=x[c(1:9, 12, 11, 10)]
x
x=x[c(-11, -10)]
x

#행렬
x=matrix(1:10, ncol=5, byrow=T)
x
x[7]=100
x+1:3

#벡터 필터링
x=1:10
x
x[x%%2==0]

#벡터 필터링
x=1:10
subset(x, x>5)
x[x>5]

#행렬의 곱
x = matrix(c(7,10,5,2),nr=2)
x %*% x
3*x

##행렬의 합

y=matrix(2:5, nc=2)
x+y
y=matrix(1:6, nr=3)
x+y


##행렬 인덱싱
x = matrix(c(2, 4, 4,1, 0,0, 1, 1,2), nr=3)
x[1,2:3]


##행렬 인덱싱
x[,1:2]
x[-1,]


























#연습문제 답
set.seed(2)
x=matrix(sample(1:100, 20), nr=5)
seven=function(y){
  q=y%%7
  return(sum(q==0))
}














#연습문제 2 답
g=c("M", "F", "F", "I", "M", "M", "F")
g
ifelse(g=="M", 1, ifelse(g=="F", 2, 3))



















#연습문제 2 
f.index=(g=="F")
m.index=(g=="M")
g[f.index]="M"
g[m.index]="F"
g

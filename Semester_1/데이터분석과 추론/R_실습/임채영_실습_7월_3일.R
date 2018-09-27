#기술통계

#이산형
#막대그래프
?VADeaths

barplot(VADeaths, beside = TRUE,col = c("lightblue", "mistyrose", "lightcyan","lavender", "cornsilk"),legend = rownames(VADeaths), ylim = c(0, 100))
title(main = "Death Rates in Virginia", font.main = 4)

#원그래프
pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
names(pie.sales) <- c("Blueberry", "Cherry","Apple", "Boston Cream", "Other", "Vanilla Cream")

#기본
pie(pie.sales)
title(main = "Sales", font.main = 4)

#원그래프 크기, 방향
pie(pie.sales, radius=1, clockwise=T)
title(main = "Sales", font.main = 4)

  
#연속형
#히스토그램
data("faithful")
x<-faithful$eruptions
hist(x)
# 아무것도 안하면 디폴트 값이 출력.

hist(x, breaks=20)
hist(x, breaks=20, freq=FALSE)
# 가장 중요한 것은 x축을 어떻게 나누느냐! 계급구간의 중요성

#계급구간 길이의 중요
par(mfrow=c(1,2))
# 반드시 기억. 그래프를 나타내는 창옵션. 그래프 두개를 비교하기 위해서 필수. 
edge1<-seq(from=1,to=6,by=0.4)
edge2<-seq(from=1,to=6,by=1)
hist(x,breaks=edge1,freq=F,xlim=c(0,6),ylim=c(0,0.6),main="h=0.4")
hist(x,breaks=edge2,freq=F,xlim=c(0,6),ylim=c(0,0.6),main="h=1")

# 또 너무 많이 자르면 중간중간에 데이터가 비어서 안 좋다. 적당한 모양을 잡아내는 게 중요하다. 


#줄기-잎 그림
stem(faithful$eruptions)

#산점도
plot(iris$Petal.Length,iris$Petal.Width,xlab='Sepal.Length',
     ylab='Sepal.Width',cex.lab=1,cex.axis=1,type='n',cex=2)
# 타입이 n이라는 것은 이런식으로 그래프를 그릴거긴한데, 출력은 하지 말라는 뜻.
points(iris$Petal.Length[iris$Species=='setosa'],
       iris$Petal.Width[iris$Species=='setosa'],col='red',lwd=2)
# lwd는 점의 크기 같은거?
points(iris$Petal.Length[iris$Species=='versicolor'],
       iris$Petal.Width[iris$Species=='versicolor'],col='blue',lwd=2)
points(iris$Petal.Length[iris$Species=='virginica'],
       iris$Petal.Width[iris$Species=='virginica'],col='green',lwd=2)

#기술통계
# 거의 항상 쓰는 것이다. 
#평균 분산
n=length(faithful$eruptions)
sum((faithful$eruptions-mean(faithful$eruptions))^{2})/(n-1)
var(faithful$eruptions)

sqrt(var(faithful$eruptions))
?sqrt
#  루트 구나 ㅎㅎ 
sd(faithful$eruptions)

#분위수
pquant=quantile(faithful$eruptions,probs=c(0.25,0.5,0.75))
# 데어커 넣고, 구하고자 하는 분위수를 넣는다. 
pquant
pquant[3]-pquant[1]
IQR(faithful$eruptions)

max(faithful$eruptions)-min(faithful$eruptions)
rfaithful=range(faithful$eruptions)
rfaithful[2]-rfaithful[1]

#outlier detection
iqr.val=IQR(faithful$eruptions)
c(pquant[1]-1.5*iqr.val, pquant[3] +1.5*iqr.val)
# 이범위 안에 있는 것은 아웃 라이어가 아니다. 
faithful$eruptions[faithful$eruptions > pquant[3] +1.5*iqr.val]
faithful$eruptions[faithful$eruptions < pquant[1] -1.5*iqr.val]
# 이범위안에 없는 것은 아웃라이어가 된다. 확인 결과 없다. numeric = 0
summary(faithful$eruptions)
# 데이터가 있을 때 가장 처음에 하면 좋다.

#Boxplot
par(mfrow=c(1,2))
boxplot(faithful$eruptions,main='Eruptions')
boxplot(faithful$waiting,main='Waiting')
# 지금 까지의 모든 것을 해주는 것. 

#왜도, 첨도
#왜도는 바깥에 쏠려있는 애들이 얼마나 있는지? 
xvec=seq(0.01,0.99,0.01)
par(mfrow=c(1,2))
plot(xvec,dbeta(xvec,2,5),type='l',lwd=2,xlab='',ylab='')
plot(xvec,dbeta(xvec,7,2),type='l',lwd=2,xlab='',ylab='')
# 베타분포는 한 쪽으로 쏠린 분포라는 것만 알고 있쟈. type l의 의미는 line을 그리라는 것.
# 위는 이론적. 아래는 실제
x1= rbeta(1000, 2, 5)
x2= rbeta(1000, 7, 2)
# rbeta : 베타분포 2,5에서 1000개를 뽑쟈 이런 의미. 즉 위의 그래프의 왼쪽 꺼의 확률밀도함수에 1000개를 뽑은 것.
(sum((x1-mean(x1))^3)/length(x1))/(var(x1))^{3/2}
(sum((x2-mean(x2))^3)/length(x2))/(var(x2))^{3/2}
## 첨도# 꼬리가 두꺼운 정도를 파악하는 것. 
par(mfrow=c(1,1))
xvec=seq(-4,4,0.01)
plot(xvec,dnorm(xvec,0,1),type='l',lwd=2,xlab='',ylab='', main="Normal and t-distribution")
lines(xvec,dt(xvec,2),type='l',lwd=2,lty=2, col='red')
# t 분포가 정규분포보다 첨도가 크다. 
x1= rt(1000, 2)
(sum((x1-mean(x1))^4)/length(x1))/(var(x1))^{2} -3
# 3을 뺴주는 이유는 표준정규분포의 첨도가 3이라서..

#이변량
x= faithful$eruptions; y= faithful$waiting
cov(x,y)/(sd(x)*sd(y))
cor(x,y)
plot(x,y,xlab='',ylab='')

#원그래프에 숫자 표시
piepercent<- round(100*pie.sales/sum(pie.sales), 1)
pie(x=pie.sales, labels=piepercent,col=rainbow(length(pie.sales)))
title(main = "Sales", font.main = 4)
legend('topright', names(pie.sales), cex = 0.7, fill=rainbow(length(pie.sales))) 
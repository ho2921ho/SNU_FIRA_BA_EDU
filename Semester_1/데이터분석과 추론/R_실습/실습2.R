
#Iris 데이터
?iris
data(iris)
str(iris)
summary(iris)

#R plot 그리기
plot(iris$Sepal.Length)
plot(iris$Petal.Length)

#x, y 값 설정
plot(x=iris$Sepal.Length, y=iris$Petal.Length)
plot(iris$Sepal.Length, iris$Petal.Length)
plot(iris$Sepal.Length, iris$Petal.Length, xlim=c(2, 10), ylim=c(0, 8))

#x축, y축 이름
plot(x=iris$Sepal.Length, y=iris$Petal.Length, xlab="Sepal Length", ylab="Petal Length")

#그래프 제목
plot(x=iris$Sepal.Length, y=iris$Petal.Length, xlab="Sepal Length", ylab="Petal Length", main="Iris Sepal-Petal Length")

#그래프 점 크기
plot(iris$Sepal.Length, cex=0.5)
plot(iris$Sepal.Length, cex=2)

#그래프 점 모양
plot(iris$Sepal.Length, cex=1.5, pch=16)
plot(iris$Sepal.Length, cex=1.5, pch=18)

#그래프 점 색깔
plot(iris$Sepal.Length, cex=1, pch=16, col=2)

#그래프 타입
plot(iris$Sepal.Length, cex=1, pch=16, type='l')

#그래프 창 설정
oldpar=par()
par(mfrow=c(2,2))
plot(iris$Petal.Width, ylab="", main="Petal Length")
plot(iris$Sepal.Length, type='l', ylab="", main="Petal Length")
plot(iris$Sepal.Length, col=2, type='l', lty=2, ylab="", main="Petal Length")
plot(iris$Petal.Width, lwd=3, type='l', lty=3, ylab="", main="Petal Length")

#같이 그리기
plot(x=iris$Sepal.Length, y=iris$Sepal.Width, xlab="Sepal Length", ylab="Sepal Width", pch=16)
points(iris$Petal.Length, iris$Petal.Width, col=2)
lines(iris$Petal.Length, iris$Petal.Width, col=3)


#범례 표시하기
plot(x=iris$Sepal.Length, y=iris$Sepal.Width, xlab="Sepal Length", ylab="Sepal Width", pch=16)
points(iris$Petal.Length, iris$Petal.Width, col=2)
legend('bottomright', legend=c("Sepal", "Petal"), pch=c(16, 1), col=1:2)


#히스토그램
hist(iris$Sepal.Length)
hist(iris$Sepal.Length, breaks=20)


#막대그래프
iris.mean=tapply(iris$Sepal.Length, iris$Species, mean)
barplot(iris.mean)



#연습문제
xrange=range(c(iris$Sepal.Length, iris$Petal.Length))
yrange=range(c(iris$Sepal.Width, iris$Petal.Width))
plot(x=iris$Sepal.Length, y=iris$Sepal.Width, xlab="Length", ylab="Width", pch=16, xlim=xrange, ylim=yrange, main="Iris")
points(iris$Petal.Length, iris$Petal.Width, col=2, pch=17)
legend('topleft', legend=c("Petal", "Sepal"), pch=c(17, 16), col=2:1)







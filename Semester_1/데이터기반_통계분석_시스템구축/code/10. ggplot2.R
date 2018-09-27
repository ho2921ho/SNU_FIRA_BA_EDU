# 7월 17일 수업.

rm(list = ls()); gc(reset = T)

# ----------------------
if(!require(ggplot2)){install.packages("ggplot2"); library(ggplot2)}
if(!require(reshape2)){install.packages("reshape2"); library(reshape2)}
if(!require(dplyr)){install.packages("dplyr"); library(dplyr)}

# ----------------------
head(msleep[,c(3, 6 ,11)])

# ----------------------
ggplot(data = msleep, aes(x = bodywt, y = sleep_total)) + geom_point()

# ----------------------
ggplot(data = msleep, aes(x = log(bodywt), y = sleep_total)) + geom_point()
# log를 사용해 체중의 스케일을 줄여줘서 그래프가 더 잘 보이게 한다. 

# ----------------------
scatterplot = ggplot(data = msleep, 
                     aes(x = log(bodywt), y = sleep_total, col = vore)) + 
  geom_point()
scatterplot

# ----------------------
scatterplot = ggplot(data = msleep, 
                     aes(x = log(bodywt), y = sleep_total, col = vore)) + 
  geom_point() + facet_grid(~vore)
scatterplot

# ----------------------
ggplot(data = msleep, aes(x = bodywt, y = sleep_total))
# 데이터를 탐색해서 자동으로 축 범위를 지정해서 그래프 캔버스를 만든다. 
# ----------------------
ggplot(data = msleep, aes(x = bodywt, y = sleep_total)) + geom_point()
# geom_point()함수를 사용해 데이터를 점으로 표현한다. 
# ----------------------
ggplot(data = msleep, aes(x = log(bodywt), y = sleep_total)) + geom_point()
# 앞서 만들어진 그래프가 0,0쪽으로 향해가는? 볼록한? 친구니깐 체중을 log값으로 변환!
# 라벨도 자동으로 달린다. 
# ----------------------
scatterplot = ggplot(data = msleep, 
                     aes(x = log(bodywt), y = sleep_total, col = vore)) + 
  geom_point()
# scatterplot 변수에 gg 플롯을 저장! 그리고 col를 설정! vore은 백터값을 이용해서 컬러를 구분하라는 의미. 종별로 구분이 된다. 
# 여기까지하면 저장만 되고 프린트는 안됌.
scatterplot
# 여기서 프린트!
#  복잡한 것을 미리 만들어 놓고 추가할 수 있는 장점?이 있다. 아직 실감이 안가네..

# ----------------------
scatterplot1 = ggplot(data = msleep, 
                      aes(x = log(bodywt), y = sleep_total, col = vore)) + 
  geom_point() + facet_grid(~vore)
# 앞선 그래프가 가시성이 좋지 않아서 따로따로 그려보자!. 예전에는 mflow 이런서 설정했는데... 여기서는 facet_gird를 사용해서 
# 기준에 따라 나눌 수 있다. ()은 (로우,컬럼)을 둔다. 여기서 의미는 행에서는 아무런 조건을 정하지 않고 열에서는 vore값에 따라
# 패널을 생성하고 따로 그림을 그리겠다는 의미... 
# 행을 쓰려면 vore.?? 을 찍는데....
scatterplot1

# ----------------------
Scatterplot <- scatterplot + geom_point(size = 5) + 
# 점의 크기도 늘릴 수 있다. 
xlab('Log Body Weight') +  ylab("Total Hours Sleep") +
# 라벨 이름과 타이틀도 바꿀 수 있다. 
  ggtitle('Some Sleep Data')
Scatterplot

##### 포유동물의 종류에 따라 수면시간을 비교하자. 
# ----------------------
stripchart <- ggplot(msleep, aes(x = vore, y = sleep_total)) + geom_point()
# x축을 체중에서 종으로 바꾼 결과! 종별로 수면시간이 얼마나 차이가 나는지? 그런 것들을 확인 가능.
stripchart
# 문제! 겹쳐있는 점들을 확인할 수 가 없다 ㅠㅠ 다음에서 해결!
# ----------------------
stripchart <- ggplot(msleep, aes(x = vore, y = sleep_total, col = vore)) + 
  geom_jitter(position =  position_jitter(width = 0.2), size = 5, alpha = 0.5)
# 색깔을 종에 따라 나뉜뒤. geo,_jitter 함수를 쓴 것 > 점을 좌우로 벌려주고 투명도를 조절함으로써 많이 겹쳐있는 것을 알게해준다.
# position는 랜덤하게 흔드는 범위, 알파는 투명도!
stripchart
# 예뻐지긴 했지만... 더 좋은 그림이 있다!!
# ----------------------
dane <- data.frame(mylevels=c(1,2,5,9), myvalues=c(2, 5, 3, 4))
# 라인을 만들어 줄 무언가?를 미르 만들어 놓는다.
head(dane)

# ----------------------
ggplot(dane, aes(x=factor(mylevels), y=myvalues)) + geom_line(group = 1) + 
  geom_point(size=3)
# 그룹 = 1이란 말 의미는 점이 4개고  1,1,1,1 간격으로 나뉜 점들이 같은 그룹이다라는 의미?
# 1,1,1,2로 바꿔서 그려보자!
ggplot(dane, aes(x=factor(mylevels), y=myvalues)) + geom_line(group = c(1,1,1,2)) + 
  geom_point(size=3)
# 즉! 선을 누구랑 연결 시켜주는 지를 결정하는 것이 그룹의 역할!

#### 시계열 데이터를 geom_lines로 표현해보자.
# ----------------------
data(economics)
data(presidential)
head(economics)
str(economics)
str(presidential)
# 실업률이 집권당에 따라 어떻게 변하가는 지를 보여주고 싶다!
# ----------------------
ggplot(economics, aes(date, unemploy)) + geom_line()
# 디폴크가 그룹 = 1 임을 확인 가능. 
# 그냥 시계열 데이터, 시간에 따라 실업률 변화를 확인 가능.
# 집권당에 따른 변동을 표현!
# ----------------------
presidential = subset(presidential, start > economics$date[1])
ggplot(economics) + geom_rect(aes(xmin = start,xmax = end, fill = party), 
                              ymin = -Inf, ymax = Inf, data = presidential) +
# 사각형의 범위를 설정하고 xmin은 fill은 색을 채우는 변수이고 party 항목으로 색을 구분했다. 
    geom_line(aes(date, unemploy), data = economics)

# 환률 변동과 주가의 변화 등등 어떤 상황에서 시계열을 패턴이 어떤지를 확인할 수 있다.
# 이 그림은 두개로 구성.
# 시계열 자료와 사각형.
#  geom_rect 사각형을 표현.
# 이벤트 스터디에 활용 가능합니당 ㅎㅎ 
# ----------------------
if(!require(datasets)){install.packages("datasets"); library(datasets)}
data(airquality)
plot(airquality$Ozone, type = 'l')

# ----------------------
aq_trim <- airquality[which(airquality$Month == 7 |
                              airquality$Month == 8 |
                              airquality$Month == 9), ]
aq_trim$Month <- factor(aq_trim$Month,labels = c("July", "August", "September"))
# 7월, 8, 9 월이 날짜별로 정렬된 시계열이 만들어진다. 
# ----------------------
ggplot(aq_trim, aes(x = Day, y = Ozone, size = Wind, fill = Temp)) +
  # x는 날짜, y는 오존, 점의 크기는 바람의 세기, 점의 컬러는 그날의 온도!로 변수를 설정, color는 선의 컬러입니다.
  geom_point(shape = 21) +   ggtitle("Air Quality in New York by Day") +
# 기본은 지옴 포인트, shape에따라 잘 안그려 질 스동?  타이틀 붙이고
    labs(x = "Day of the month", y = "Ozone (ppb)") +
  scale_x_continuous(breaks = seq(1, 31, 5))
# 아래쪽에 그리드를 설정해주는 것. 즉 1~31을 5씩 띄어서 그리드를 표현 해주겠다. 
#바람이 약해지면 오존의 농도가 높아지는 것을 확인할 수 있고 기온이 높을 수록 오염이 심해지는 것을 쌈빡하게 확인가능. 
## 처음에는 기껏해야 2차원이었는데 ㅠㅠ 이제 겁나 많이 표현가능하게 되었당 ㅎㅎ 와인데이터에 응용해보자 주말에....

# ----------------------
festival.data <- read.table(file = 'C:/Users/renz/Desktop/R_전종준/data/DownloadFestival.dat', sep = '\t', header = T)
head(festival.data)
# 성별에 따른 만족도?
# ----------------------
Day1Histogram <- ggplot(data = festival.data, aes( x= day1))
                # 팩터를 축으로 입력하면 택터변수가 지정이되어있어야한다. 그런데, day1,2,3가 day의 레벨들...
                # 그렇게 만들어진 데이터 포맷을 롱포맷? 지지를 쓰기 위해서 레벨별로 변수를 정렬해야한다. 
                # 와이드를 롱으로 바꿔야한다. melt 이용가능. 
festival.data.stack <- melt(festival.data, id= c('ticknumb','gender'))
## 뒤에 다시 나온다. 
Day1Histogram
#
Day1Histogram + geom_histogram()
# geom 히스토 그램으로 그림을 그릴 수 있다. 히스토 그램은 빈도를 세는 것이기 때문에 x축만 알려주면 된다. 
# 회색이 디폴트.

# ----------------------
Day1Histogram + geom_histogram(color = 'royalblue1', fill = 'royalblue2')

# ----------------------
Day1Histogram + geom_histogram(color = 'royalblue1', fill = 'royalblue2', 
                               binwidth  = 0.05)
# binwidth는 막대의 크기. 

# ----------------------
Day1Histogram + geom_histogram(binwidth = 0.2, aes( y = ..density..), 
                               color= 'royalblue3', fill = 'yellow', bins = 35) 

# 밀도를 표현하고 싶을 때는... y축에 직접 지정해야 합니다.!! ..<>.. <>라는 내부오브젝트를 가져와서 y로 쓰겠다.
# density는 내부변수! 
# ----------------------
Day1Histogram +geom_histogram(binwidth = 0.1, aes(y=..density..), 
                              color="black", 
                              fill="lightblue") + geom_density(alpha=.2, fill="#FF6666") 
# 선으로 이어서 그리고 싶을 떄...
## 이 테크닉을 이용해서 날짜별, 성별 만족도를 비교!

# ----------------------
festival.data.stack <- melt(festival.data, id = c('ticknumb', 'gender'))
# ggplot에 적합한 형태로 데이터 변환. 
colnames(festival.data.stack)[3:4] <- c('day', 'score')
# 새로운 열 이름을 생성. 
head(festival.data.stack)
# ----------------------
Histogram.3day2 <- ggplot( data = festival.data.stack, aes(x = score)) + 
  geom_histogram(binwidth = 0.4, color= 'black', fill = 'yellow') + 
  labs( x = 'Score', y = 'Counts')
Histogram.3day2

# ----------------------
Histogram.3day2 + facet_grid(~gender)
# 여성이 많이 온 것을 확인 가능. 
# ----------------------
Histogram.3day2 + facet_grid(gender~day)
# 정수의 분포를 비교하기 위해...gender가행으로, day가 열로.. 
## 문제! 데이터의 흩어짐을 표현하기 힘들다.y축을 빈도로 바꿔보자!!!
# ----------------------
Histogram.3day2 <- ggplot( data = festival.data.stack, aes(x = score,
                                                           y = ..density..)) + 
  geom_histogram(binwidth = 0.4, color= 'black', fill = 'yellow') + 
  labs( x = 'Score', y = 'Counts')
Histogram.3day2

# ----------------------
Histogram.3day2 + facet_grid(~gender)
# 사각형의 면적은 동일 , 절대적인 인원은 비교 불가능 하지만, 점수의 분포를 비교할 수 있다. 
# 여성이 높게 주고. 점수의 산포는 여성이 더 크다. 

# ----------------------
Histogram.3day2 + facet_grid(gender~day)
# 무엇을 이야기 할 수 있을까?
# 시간에 따라 왜도된다는 것을 뽑아내고 싶었다는 좋은 자료이다.
# 그러나 평균과 분산에 대해서만 이야기 하고 싶다면 별로.
# 왜냐면 히스토그램은 너무 많은 정보를 준다. 그래서 박스 플롯을 그려서 단순하게 표현해보자.

# ----------------------
Scatterplot <- ggplot(data = festival.data.stack, aes(x = gender, y = score, color = gender)) + 
  geom_point(position = 'jitter') + facet_grid(~day)
# 지옴 포인트의 포지션에 지터를 넣어서 표현도 가능. 
Scatterplot
# 3날에 대해 각각의 변화를 표현. 더 분명한 정보는 사람이 줄어든다는 점? 별로 안 좋네 ㅠㅠ

# ----------------------
Scatterplot + scale_color_manual(values = c('darkorange', 'darkorchid4'))

# ----------------------
Scatterplot + geom_boxplot(alpha = 0.1, color= 'black', fill = 'orange')
# 그럼 박스 플롯을 그려보자.





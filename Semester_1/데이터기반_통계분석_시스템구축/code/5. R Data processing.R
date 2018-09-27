
데이터 수집 > 전처리 > 모형화 및 적합 > 결과 해석, 시각화 
전처리: 분석단위, 관측치 정의, 
데이터를 어떻게 분석할 지에 따라 관측치가 다르게 정의되고 전처리 방법도 달라진다. 

학습목표: 전처리 방법을 배

rm(list = ls()); gc(reset = T)

# -----------------------------------
y3w

# -----------------------------------
# 데이터 열 추출
names(surveys)
surveys[,c(5,6,9)]
# 뭘하는 지 모르는 단점이 있다. 그리고 모든 데이터가 그런 것도 아니다. 
# 그래서 아래처럼 한다.

match(c("plot_id", "species_id", "weight"),  names(surveys))
# 원하는 열의 위치를 알려준다.  
surveys[, match(c("plot_id", "species_id", "weight"),  names(surveys)) ]
# match 펑션을 통해 원하는 열의 위치를 인덱싱을 할 수 있다. 
# 근데 좀 복잡하다. 더 좋은 방법도 있다.
# -----------------------------------

surveys[,c("plot_id", "species_id", "weight") ]
## 바로 데이터 프레임에서 열의 이름을 바로 참조할 수 있다! 

# -----------------------------------
surveys[c("plot_id", "species_id", "weight")]

### 더 좋은 방법은 데이터 프레임이 리스트라는 특성을 이용해서 위와 같이 해도 동일한 결과를 얻을 수 있다. 

# -----------------------------------
# 데이터 행 추출
# surveys 데이터에서 값이 1995인 데이터만 추출하고 싶을 때.
# 필터링을 이용한 방법.
surveys$year == 1995
# T,F 값을 만든다. 
surveys[surveys$year == 1995, ]
# 값이 1995인 행만 추출할 수 있다.
head(surveys[surveys$year == 1995, ])

# -----------------------------------
# 행을 추출하면서 필요한 열만 살펴보고 싶을 때. 
surveys[surveys$weight<5, c("species_id", "sex", "weight")]원
# 불린식이 NA가 출력되고, 아래와 차이가 생긴다.
surveys[which(surveys$weight<5), c("species_id", "sex", "weight")]
# 여기서는 NA가 생략된다. 위 보다 행의 개수가 적어진다. which함수는 T값만 반환.

# -----------------------------------
# 새로운 열을 만들고 싶을 떄.
surveys_ex <- surveys
# 원본을 살리기 위한 방법.
surveys_ex$weight_kg <- surveys_ex$weight/1000
# 새로운 열을 정의.
surveys_ex <- surveys_ex[!is.na(surveys_ex$weight_kg),] 
# NA를 제외하는 방법. 행을 필터링하면된다. NA가 아닌거만 트루로하면된다. is.na는 ()값이 NA 트루 없으면 거짓 하지만
# 우리가 원하는 것은 NA일때 거짓이 되어야하므로 NA 값일 때를 제외하고 인덱싱을 할 수 있으므로 !를 붙여준다.

# -----------------------------------
# SEX별로 weight의 평균 계산.
u = unique(surveys$sex)
# 유일한 값을 확인하는 함수 unique를 통해 성별이 뭐있는지를 확인 가능
length(u)
# 길이가 3이 나온다는 것은 남녀 이외에 다른게 있다는 뜻.
class(surveys$sex)
# factor면 levels 함수를 이용해서 level의 갯수를 바로 구할 수 있다. 유니크 함수 안사용해도.
levels(surveys$sex)

# -----------------------------------
mean( surveys$weight[surveys$sex == u[1]], na.rm = T )
# 미싱 데이터의 평균, 가장 안쪽 부터 보자. 불린식을 만들어서 인덱싱. na.rm은 weight의 NA를 빼고 계산하라는 뜻.
mean( surveys$weight[surveys$sex == u[2]], na.rm = T )
mean( surveys$weight[surveys$sex == u[3]], na.rm = T )

# 위의 것을 간단하게 할 수 있는 함수들
# by 함ㅅ
a = by( data = surveys$weight, INDICES =  surveys$sex, 
    FUN  = mean, na.rm = TRUE)
# gerneral한 함수. data에는 벡터가 들어가고 INDICE는 data와 써진 벡터와 길이가 같은 벡터가 들어가야한다. 
# FUN은 input == data. 다른 옵션은 뒤에 둔다. 아웃풋은 리스트 형태가 된다. 수
unlist(a)
# 리트를 지우고 array로 데이터 변환??? 무슨 말이지.
class(a)

# 함수 = by기능 + 복수개 사용 가능 + 인덱스 번호까지 반환.
b = aggregate(formula = weight ~ sex, data = surveys,
          FUN = mean, na.rm = TRUE)
# weight를 분석할 건데. sex의 레벨별로 분석할 것이다. 이란 의미
## 같은 결과를 얻을 수 있는데, 더 좋은 점은 복수개를 사용할 수 있고 특징한 인덱스를 만들수 있다. by는 인덱스를 만들어야한다.

# -----------------------------------
aggregate(formula = weight ~ sex + species_id, 
          data = surveys, FUN = mean, na.rm = TRUE)

# -----------------------------------
table(surveys$sex)
table(surveys$sex, surveys$plot_id)
a = c(10,5,3,7)
order(a)
# 제일 작은 값이 3번째있고 가장 큰 값이 1번째 있다는 뜻을 가진 값을 반환. 
# 이걸 다시 a에 인덱싱하면 정렬이 가능!
# 큰 값부터 하고 싶ㅍ으면 decreasing 옵션을 사용하면 된다. 
a[order(a)]
sort(a)
# 이렇게도 할 수 있는데, 우리가 할 수 있는 것은 재할당?

# -----------------------------------
surveys[order(surveys$plot_id),]
# 플롯아이디 중에 가장 작은 행이 첫번쨰로 정렬. 즉 오름차 순으로 데이터가 정렬된다. 
# month를 내림차순으로 정렬하고 plot_id로 오름차순으로 정렬하고 싶은 경우. month 정렬을 유지하고 싶을 때. 
tmp <- surveys 
tmp <- tmp[order(tmp$plot_id),]
tmp <- tmp[order(tmp$month, decreasing = TRUE),]
head(tmp)
# R은 엑셀과 거꾸로 해야한다. 유지하고 싶은 것을 가장 마지막에.

# -----------------------------------
### 다 귀찮다!! 좋은 패키지가 있음ㅋ
# dplyr
# 장점 읽기가 쉽고 빠르다. 
if (!require(dplyr)) { install.packages("dplyr") ; library(dplyr) }

# -----------------------------------
select(.data = surveys, plot_id, species_id, weight)
# 열을 골라주는 함수 select
a = surveys %>% select( plot_id, species_id, weight) %>% head()
# %>% 파이프라인 연산자. 장점은 읽기가 쉽다.? 그 데이터를 셀렉트로 선택을 한다음에 머리를 본다. ???
# 데이터 전처리에서 중요한 이유는 많은 사람들이 작없하기 때문에 코드의 통일성이 중요하다. 
a
# -----------------------------------
# 행을 선택하는 함수 filter

filter(.data = surveys, year == 1995) %>% head()
filter(.data = surveys, year >= 1995 & weight > 20) %>% head()
filter(.data = surveys, year >= 1995 , weight > 20) %>% head()
# &또는 ,를 통해 복합연산이 가능! 
filter(.data = surveys, year >= 1995 , weight > 20) %>% head(2)
# 첫 두줄만 보고 싶을 때는 head에 2를 넣어준다.

# -----------------------------------
surveys %>%
  filter( !is.na(weight) ) %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight) %>% head()
# %>% 처리한 결과를 다음 코드에 넘겨서 그걸 참조한다는 뜻. 

# -----------------------------------
# 한번에 여러개의 컬럼을 추가하고자 할 때. 
surveys_ex <- surveys %>% filter( !is.na(surveys$weight)) %>%
  mutate(weight_kg = weight / 1000) 
# mutate(열의 이름, 열에 대한 연산)

# -----------------------------------
# 그룹별로 작업을 하고 싶을 때.
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
# group_by와 summarize 함수 이용.
# 성별로 묶고. 요약을 하자. 목적에 따라 각각의 함수의 옵션을 사용하면 된다. 
# summarize(mean_weight = mean(weight, na.rm = TRUE)), mean_weight이란 변수를 만들 것이고 그 것은 , 다음의 계산을 따른다.

# -----------------------------------
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

# -----------------------------------
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            var_weight = var(weight),
            min_weight = min(weight),
            max_weight = max(weight)) %>%
  print(n = 5)

# 복수의 통계량을 한번에 계산할 수 있다.
# print(n=)은 왜인는겨? head와 같은 개념..
# -----------------------------------
# 개수를 셀 떄.
surveys %>%
  group_by(sex) %>%
  tally()

surveys %>%
  group_by(plot_id, sex) %>%
  tally()

# -----------------------------------
# 정렬을 하고 싶을 떄.
surveys %>% arrange(month, plot_id) %>% head()
# month가 정렬된 상태에서 plor을 정렬. 앞의 예시와 동일한 값 반환.
# -----------------------------------
surveys %>% arrange(desc(month), plot_id) %>% head()


# 기타 질문 사항. 
# 위 패키지는 데이터 프레임만 활용할 수 있다. 그래서 as.dot 뭐기시로 매트릭스를 데이터 프레임으로 변환해서 해야한다. 
# 그런데 대부분 이런 작업을 위한 데이터는 데이터 프레임이다. 크게 상관안해도 되는 부분인듯.
# -----------------------------------

# 데어터 format의 종류
# wide vs long
# wide는 참조가 쉽다. 그러나 컬럼에 어떤 데이터가 들어가야할 지 구조화가 미리 되어 있어야 한다.
# long은 데이터 구조에 대한 고려가 필요없다. 새로운 데이터 필드 즉 새로운 열이 추가되더라도 데이터가 안 바뀐다. 가변적이고 많은 데이터를 저장하기 적합. 
# 데이터 분석시 함수가 요구하는 데이터 포맷이 다를 수 있다. 애널리스트에 사용되는 경우, 대부분 와이드 포맷.
# 그러나 비쥬얼라이즈는 롱 포맷을 이용한다.
# 그래서 포맷 변환을 알아둘 필요가 있다. > reshape2 패키지 이용!

if (!require(dplyr)) { install.packages("dplyr") ; library(dplyr) }
if (!require(reshape2)) { install.packages("reshape2") ; library(reshape2) }

head(airquality, n = 3)

head(melt(airquality), n = 3)
# melt: long으로 변환 함수

# -----------------------------------
names(airquality) <-  tolower(names(airquality))
melt(data = airquality) %>% head(n=3)

# -----------------------------------
names(airquality) <-  tolower(names(airquality))
aql <- melt(data = airquality, id.vars= c("month","day"))
head(aql, n = 3)
# melt를 사용할 때는 식별자를 통해서 모양을 결정할 수 있다. 데이터를 구분하는 단위를 표시할 수 있다.
# -----------------------------------
aql <- melt(airquality, id.vars = c("month", "day"),
            variable.name = "climate_variable", 
            value.name = "climate_value")
head(aql, n = 3)
# 이름도 바꿀 수 있다. 

# -----------------------------------
# dcast, wide 변환 함수.
aqw <- dcast(aql, month + day ~ climate_variable, 
             value.var ="climate_value") 

aqw

dcast(aql, month ~ climate_variable, fun.aggregate = mean, 
      na.rm = TRUE, margins  = TRUE) %>% head(n=3)
### 이해가 잘 안되네.. 다시해보기!!





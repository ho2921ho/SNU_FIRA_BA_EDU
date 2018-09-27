library(tidyr)
library(dplyr)
library(OpenMx)
library(ggplot2)
library(broom)
options(scipen = 999)

data(twinData)
head(twinData)
help("twinData")
twinData <- as_tibble(twinData)
attach(twinData)

## 8. 
# facet grid 
twinData %>% ggplot(mapping = aes(ht1, ht2)) + 
  geom_point() +
  facet_grid(cohort ~ zygosity)

# find significant similarity in ht1 amd ht2

a <-twinData %>% 
  group_by(cohort,zygosity) %>%  
  do(tidy( cor.test(~ ht1 + ht2, alternative = "greater" , data = . ))) 
a$similarity = ifelse(a$conf.low > 0.5, "True", "False")

# adding color
twinData = left_join(twinData, select(a, similarity))
twinData %>% ggplot(mapping = aes(ht1, ht2, color = similarity)) + 
  geom_point() +
  facet_grid(cohort ~ zygosity)

# opinion
# 연령에 상관없이 일란성 쌍둥이의 경우 키의 상관관계가 0.5 이상일 경우가 95퍼센트 신뢰 구간에서 유의하다. 
# 하지만 이란성 쌍둥의 경우는 그렇지 않다.
# 이를 통해 일란성 쌍둥이는 서로의 키에 높은 상관관계를 갖는 반면, 
# 이란성 쌍둥이는 일란성에 비해 낮은 상관관계를 가짐을 확인할 수 있다. 

## 9.
# facet gird 
twinData %>% ggplot(mapping = aes(wt1, wt2)) + 
  geom_point() +
  facet_grid(cohort ~ zygosity)

# find significant similarity in wt1 amd wt2
a <-twinData %>% 
  group_by(cohort,zygosity) %>%  
  do(tidy(cor.test(~ wt1 + wt2, alternative = "greater" , data = . ))) 

a$similarity = ifelse(a$conf.low > 0.5, "True", "False")

# adding color
twinData = left_join(twinData, select(a, similarity))
twinData %>% ggplot(mapping = aes(wt1, wt2, color = similarity)) + 
  geom_point() +
  facet_grid(cohort ~ zygosity)

# opinion
# 체중 또한 키와 마찬가지로 일란성 일때, 쌍둥이들 간의 유의미한 상관관계가 있다. 

## 10
# facet gird 
gatherd_twinData <- twinData %>% gather(order, height, ht1, ht2)
gatherd_twinData %>% ggplot(mapping = aes(order, height)) + 
  geom_boxplot() +
  facet_grid(cohort ~ zygosity)

## 11
# opinion
# 박스 플롯을 보면 먼저 태어난 쌍둥이가 더 크다는 증거는 없다. 
# 따라서 ht1이 ht2보다 높다는 가설은 받아드릴 수 없다. 
# 다만 이성 쌍생아(DZOS)의 경우 ht1과 ht2가 차이가 있어 보이는데, 이는 
# ht1과 ht2가 출생순서가 아니라 성별이기 때문이다. 

## 12-1
# opinion
# 쌍둥이는 서로 독립인 두 모집단에서 추출된 표본이 아니므로 독립이표본은 부적절하다. 
# 쌍둥이와 같은 서로 독립이 아닌 두 표본을 비교하기 위해서는 대응비교를 해야한다. 

## 12-2
b <-twinData %>%
  group_by(cohort,zygosity) %>%
  do(tidy(t.test(.$ht1,.$ht2, paired = T)))

b$difference = ifelse(b$p.value < 0.05, "True", "False")

## 12-3
#adding color
gatherd_twinData = left_join(gatherd_twinData, select(b, difference))
gatherd_twinData %>% ggplot(mapping = aes(order, height, color= difference)) + 
                geom_boxplot() +
                facet_grid(cohort ~ zygosity)


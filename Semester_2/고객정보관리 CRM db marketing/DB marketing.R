### Question 1
## 1. 데이터 설정.
library(readxl) ; library(dplyr)
rd <- read_excel(path = "mailorder.xls")
est.set <- rd[1:2000,] ; val.set <- rd[2001:4000,]

## 3. Baseline = 0.064
set.seed(1) ; Base_sample = sample_n(val.set, 500)
Baseline = mean(Base_sample$purchase)
print(Baseline)
## Question2... 0.152
# 1. 2X2X2 RFM 범주 설정.
est.set$R2 <- cut(est.set$recency, c(0,12,max(est.set$recency)),labels = c("2","1")) 
est.set$F2 <- cut(est.set$frequency, c(0,3,max(est.set$frequency)+1),right = F,labels = c("1","2"))
est.set$M2 <- cut(est.set$monetary, c(0,209,max(est.set$monetary)+1),right = F,labels = c("1","2"))

# 2. 구매 확률이 높은 범주를 확인.
RFM2 <- est.set %>% group_by(R2,F2,M2) %>% 
  summarize(prob_purchase_RPM2 = mean(purchase)) %>% arrange(desc(prob_purchase_RPM2))

# 3. 검정셋의 구매비율... 0.152
val.set$R2 <- cut(val.set$recency, c(0,12,max(val.set$recency)),labels = c("2","1")) 
val.set$F2 <- cut(val.set$frequency, c(0,3,max(val.set$frequency)+1),right = F,labels = c("1","2"))
val.set$M2 <- cut(val.set$monetary, c(0,209,max(val.set$monetary)+1),right = F,labels = c("1","2"))
high_RFM2 <- val.set %>% left_join(RFM2) %>% arrange(desc(prob_purchase_RPM2)) %>% head(500)
mean(high_RFM2$purchase)

## Question3 
# 1. 5X5X5 RFM 범주 설정... 0.124
est.set$R5 <- cut(est.set$recency, c(0,4,8,12,16,max(est.set$recency)),labels = c("5","4","3","2","1")) 
est.set$F5 <- cut(est.set$frequency, c(0,1.5,2,5,9,max(est.set$frequency)),labels = c("1","2","3","4","5")) 
est.set$M5 <- cut(est.set$monetary, c(0,113,181,242,299,max(est.set$monetary)),labels = c("1","2","3","4","5"))

# 2. 구매 확률이 높은 범주를 확인. 
RFM5 <- est.set %>% group_by(R5,F5,M5) %>% 
  summarize(prob_purchase_RPM5 = mean(purchase)) %>% arrange(desc(prob_purchase_RPM5))

# 3. 검정셋의 구매 비율.. 0.124

val.set$R5 <- cut(val.set$recency, c(0,4,8,12,16,max(val.set$recency)),labels = c("5","4","3","2","1")) 
val.set$F5 <- cut(val.set$frequency, c(0,1.5,2,5,9,max(val.set$frequency)),labels = c("1","2","3","4","5")) 
val.set$M5 <- cut(val.set$monetary, c(0,113,181,242,299,max(val.set$monetary)),labels = c("1","2","3","4","5"))
high_RFM5 <- val.set %>% left_join(RFM5) %>% arrange(desc(prob_purchase_RPM5)) %>% head(500)
mean(high_RFM5$purchase)

## Question 4...0.16

# 1. 모델 추정.
lm.fit = lm(purchase ~ recency + frequency + monetary, data = est.set)

# 2. 검정셋의 구매비율.. 0.16
high_lm <- sort(predict(lm.fit,val.set), decreasing = T)[1:500]
index <- attr(high_lm,"names")
mean(val.set[index,]$purchase)

## Question 5...0.184

# 1. 모델 추정.
glm.fit = glm(purchase ~ gender+ recency + frequency/duration, data = est.set, family = binomial)

vif(glm.fit)
# 2. 훈련셋의 구매비율.. 0.17
hi_glm_est <- sort(predict(glm.fit,est.set), decreasing = T)[1:500]
index_est <- attr(hi_glm_est,"names")
mean(est.set[index_est,]$purchase)

# 3. 검정셋의 구매비율..0.184
high_glm_val <- sort(predict(glm.fit,val.set), decreasing = T)[1:500]
index_val <- attr(high_glm_val,"names")
mean(val.set[index_val,]$purchase)

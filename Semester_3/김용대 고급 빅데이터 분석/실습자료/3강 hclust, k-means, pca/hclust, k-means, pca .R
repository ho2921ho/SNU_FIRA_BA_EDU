rm(list=ls());gc()

## Cereals data
setwd("C:/Users/renz/Desktop/고급 빅데이터 분석/실습자료/ch2_lab")
cereals = read.csv("cereals.csv",header=T)
names(cereals)
summary(cereals)

################################################

# 변수 설명
# name: 시리얼 이름
# mfr: 시리얼 제조사
# type: cold or hot
# calories: 1회 제공량 당 칼로리
# protein: 단백질 함량 (g)
# fat: 지방 함량 (g)
# sodium: 소금 함량 (mg)
# fiber: 식이섬유 함량 (g)
# carbo: 복합 탄수화물 함량 (g)
# sugars: 설탕 함량 (g)
# potass: 칼륨 함량 (mg)
# vitamins: FDA 기춘치 대비 비타민, 미네랄 함량 (%)
# shelf: 진열대 위치 (바닥부터 1,2,3층)
# weight: 1회 제공량 당 무게 (oz)
# cups: 1회 제공량 당 컵 단위 (eg. 1.5컵)
# rating: 소비자 조사에 의한 시리얼 평점

################################################

dim(cereals)

## 필요한 자료 선택
# 사용할 변수: 칼로리, 단백질, 지방, 소금, 식이섬유, 복합 탄수화물, 설탕, 칼륨, 비타민 (9개)

cereals = cereals[, c("name","calories","protein","fat","sodium","fiber","carbo","sugars","potass","vitamins")]
dim(cereals)

## missing value가 있는 자료는 삭제
cereals[!complete.cases(cereals),] #na.omit(cereals)
## complete.cases 완전한 행을 찾아주는 함수. 
cereals = cereals[complete.cases(cereals),]
dim(cereals)
length(which(is.na(cereals)))


rownames(cereals) = cereals[,"name"]
## 로우네임을 1,2,3,4,~~~ 이런거 대신 시리얼 이름으로 바꾼 것. 
cereals = cereals[,-1]
head(cereals,6)



#---- 2-2. 계층적 군집분석(p.60)

## 산포도 확인
plot(cereals)

##- 계층적 군집분석

# 거리 측도 : 유클리디안, Minkowski, Maximum
# Linkage : single, complete, centroid, average

#k1=3
dist.E =dist(cereals)
## 디폴트는 유클리디안으로, 다양한 방법도 사용할 수 있다. 
## 분석할 때는 거리를 계산하기 전에 자료를 표준화하는 것이 좋다. 
## scale 함수? 

# (1) Euclidean dist., complete <- default option

cluster.EC = hclust(dist.E) 
plot(cluster.EC, main="Euclidean, complete", cex=1)

# (2) Euclidean dist., single linkage

cluster.ES = hclust(dist.E, method="single")
plot(cluster.ES, main="Euclidean, single")

## 작은 군집이 우선적으로 나뉘는 효과?

# (3) Euclidean dist., average linkage

cluster.EA = hclust(dist.E, method="average")
plot(cluster.EA, main="Euclidean, average")


## 군집 분할(할당)
clusters = cutree(cluster.EC, k=2:6) #군집 수 조절

### 군집을 2~6씩으로 설정해 놓고 그 결과를 반환. 
head(clusters)
clusters = cutree(cluster.EC, h=100) #덴드로그램의 높이 조절
clusters[1:10]


# 덴드로그램에서 할당
plot(cluster.EC, main="Euclidean, complete")
groups = cutree(cluster.EC, h=100)
head(groups,20)
rect.hclust(cluster.EC, h=100, border="red")

plot(cluster.EC, main="Euclidean, complete")
groups = cutree(cluster.EC, k=4) 
head(groups,20)
rect.hclust(cluster.EC, k=4, border="red") # draw denrogram with red borders around the k1 clusters


## 군집 내 비교 (k=4) using Euclidean dist. and complete linkage

for (i in 1:4){
  cat(i,'- th cluster \n')
  tmp = rbind(round(colMeans(cereals[which(groups==i),]), 3),
              round(diag(cov(cereals[which(groups==i),])), 3)); rownames(tmp) = c("Mean","Var")
  print(tmp)
}
table(groups)


# linkage 에 따른 군집할당 결과 비교

Clu.Ave = cutree(cluster.EA, k=4)
Clu.Sig = cutree(cluster.ES, k=4)
Clu.Com = cutree(cluster.EC, k=4)

table(Clu.Ave, Clu.Sig)
table(Clu.Ave, Clu.Com)
table(Clu.Sig, Clu.Com)



#--- 2-3. K-means 군집분석(p.73)


# K-means 결과
library(cluster)
cluster.K4 = kmeans(cereals, centers=4)
cluster.K4

plot(cereals, col=cluster.K4$cluster) #k-means


# 초기값에 따른 군집분석의 차이
set.seed(1)
cluster1= kmeans(cereals, centers=4)
set.seed(2)
cluster2= kmeans(cereals, centers=4)

table(cluster1$cluster, cluster2$cluster)
## 군집의 숫자가 의미를 갖는 것은 아니기 때문에, 해석 주의! 
cluster1$centers
cluster2$centers


## 군집 수 K 정하기
### tot.withiness 군집내 거리의 합. 
### 군집이 늘어날 수록 군집내 거리의 합이 줄어드는 이유는?  군집내 거리이기 때문! 군집간의 거리로 착각함...
wss <- vector(length=15)
for (i in 1:15) wss[i] = kmeans(cereals,centers=i, nstart = 10)$tot.withinss
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares",
     main = "Total within SS for varying K") 

#--- 2-1. 다차원 척도분석(p.10)

cmds = cmdscale(dist.E, k = 2)
## k = 차원의 수, 
head(cmds)
plot(cmds, xlab = "coord 1", ylab = "coord 2", main = "MDS", type = "n")
text(cmds, labels = rownames(cmds), cex=.8)




#--- 다차원 척도법을 이용한 군집분석 시각화(p.81)
k1 = 4

groups = cutree(cluster.EC, k=k1)
plot(cmds, xlab = "coord 1", ylab = "coord 2", main = "MDS", type = "n")
text(cmds, labels = rownames(cmds), cex=.8, col=groups)

groups = cutree(cluster.ES, k=k1)
plot(cmds, xlab = "coord 1", ylab = "coord 2", main = "MDS", type = "n")
text(cmds, labels = rownames(cmds), cex=.8, col=groups)

groups = cutree(cluster.EA, k=k1)
plot(cmds, xlab = "coord 1", ylab = "coord 2", main = "MDS", type = "n")
text(cmds, labels = rownames(cmds), cex=.8, col=groups)

plot(cmds, xlab = "coord 1", ylab = "coord 2", main = "MDS", type = "n")
text(cmds, labels = rownames(cmds), cex=.8, col=cluster.K4$cluster)
## k-means 



#--- PCA 를 이용한 군집분석 시각화(p.78)
# PCA : 차원 축소 방법중 하나. 자료의 분산을 고유값 분해
pca <- princomp(cereals, cor=T)

groups = cutree(cluster.EC, k=k1)
plot(pca$scores[,1:2], xlab = "coord 1", ylab = "coord 2", main = "PCA", type = "n")
text(pca$scores[,1:2], labels = rownames(pca$scores), cex=.8, col=groups)

groups = cutree(cluster.ES, k=k1)
plot(pca$scores[,1:2], xlab = "coord 1", ylab = "coord 2", main = "PCA", type = "n")
text(pca$scores[,1:2], labels = rownames(pca$scores), cex=.8, col=groups)

groups = cutree(cluster.EA, k=k1)
plot(pca$scores[,1:2], xlab = "coord 1", ylab = "coord 2", main = "PCA", type = "n")
text(pca$scores[,1:2], labels = rownames(pca$scores), cex=.8, col=groups)

plot(pca$scores[,1:2], xlab = "coord 1", ylab = "coord 2", main = "PCA", type = "n")
text(pca$scores[,1:2], labels = rownames(pca$scores), cex=.8, col=cluster.K4$cluster)

## 주성분을 3차원으로 바라보자.
library(rgl)
text3d(pca$scores[,1:3],texts = rownames(cereals),xlab = "coord 1", ylab = "coord 2", main = "PCA", type = "n",col=groups)

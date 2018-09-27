rm(list = ls()); gc(reset = T)

# ---------------------------
if(!require(networkD3)){install.packages("networkD3"); library(networkD3)}
if(!require(igraph)){install.packages("igraph"); library(igraph)}
if(!require(reshape2)){install.packages("reshape2"); library(reshape2)}

# ---------------------------
src <- c("A", "A", "A", "A",
         "B", "B", "C", "C", "D")
target <- c("B", "C", "D", "J",
            "E", "F", "G", "H", "I")
networkData <- data.frame(src, target)
head(networkData)

# ---------------------------
networkD3::simpleNetwork(networkData, fontSize = 15, zoom = T)

# ---------------------------
data(MisLinks)
head(MisLinks)

data(MisNodes)
head(MisNodes)

# ---------------------------
forceNetwork(Links = MisLinks, Nodes = MisNodes,
             Source = "source", Target = "target",
             Value = "value", NodeID = "name", arrows = T, 
             Group = "group", opacity = 0.8, zoom = TRUE)

# ---------------------------
sankeyNetwork(Links = MisLinks, Nodes = MisNodes,
              Source = "source", Target = "target",
              Value = "value", NodeID = "name",
              fontSize = 12, nodeWidth = 18)

# --------------------------- setwd 위치지정은 교육자료에서는 "???"로 표기 되어 있습니다.
if(!require(data.table)){install.packages("data.table"); 
  library(data.table)}
if(!require(dplyr)){install.packages("dplyr"); library(dplyr)}

setwd("C:/Users/renz/Desktop/R_전종준/data") # dataset이 존재하는 library지정
load("data_list.Rdata")

# ---------------------------
barplot(table(data_list$date))

barplot(table(data_list$date))
word.df = as.data.frame(data_list$data)
word.df = dcast(word.df,word~date,value.var = "count")
word.df = cbind(word.df,sum = rowSums(word.df[-1]))
word_order = order(word.df[6],decreasing = T)
print(word_order)
str(word_order)
head(word.df[,],10)
vec=c(5,1,3)
order(vec)

# ---------------------------
conf_result = data_list$conf_data
head(conf_result)
mean_conf = apply(conf_result[,2:4],1,mean) 
# 평균을 구하기 위해 어플라이 함수를 사용한다. (array, margin = 1이면 행별로 2면 열별로 적용한다.)
head(mean_conf)
conf_result$increasing_rate = conf_result[,5] / mean_conf
head(conf_result$increasing_rate)

attach(conf_result)
# $를 생략하고도 쓸 수 있게 하는 기능을 한다. 
text_conf = conf_result[c(which(is.finite(increasing_rate) & increasing_rate > 20), which(mean_conf > 0.3)),]
# 이름을 달아주려는 것. 어느 기준을 충족하는 친구들의...
loc_conf = mean_conf[c(which(is.finite(increasing_rate) & increasing_rate > 20), which(mean_conf > 0.3))]
# 위치를 저장하려는 목적. 

# ---------------------------
plot(mean_conf, conf_result$increasing_rate, ylim = c(-0.5, 27),
     xlim = c(-0.005, 0.5))
text(loc_conf + 0.03, text_conf$increasing_rate,
     labels = text_conf$word, cex = 1, pos = 3)
# 이부분 잘 해석이/...
abline(h = 1, col = 'red')
# 이선 위에 있으면 2017년에 중요해진 친구들. 비율이 1보다 크니깐!! 오른 쪽에 있을 수록 전체적으로 중요한 것!
# 0쪽으로 몰려 있는데. 이런 걸 그릴 때는 로그 스케일로 그려주면 좋다. 로그를 취하면 쫙 퍼진다. 그렇지만 0인 값은 그려지지 않는다. 그래서 작은 상수를 더 한다. 

# ---------------------------
doc_list = data_list$n_gram
uniq_words = unique(do.call('c',doc_list))
occur_vec_list = lapply(doc_list, function(x) uniq_words %in% x)
# lappy(array, 함수) 함수에 조건에 따라 array를 변화시켜준다. 
dtm_mat = do.call('rbind', occur_vec_list)
# occur_vec_list는 현재, [(),(),() 이런 형태인데 do.call을 써서 ()를 하나씩 불러온다음에 rbind를헤서 dtm_mat에 집어 넣는다.]
#                                                                                                   파이썬은 변수 지정? for문
head[dtm_mat]

colnames(dtm_mat) = uniq_words
# dtm_mat에는 열이름이 없는 상태니깐 uniq_words(백터)로 불러와서 대응시킨다.
# ---------------------------
refined_dtm_mat = dtm_mat[, colSums(dtm_mat) != 0]
refined_dtm_mat = refined_dtm_mat[rowSums(refined_dtm_mat) != 0,]
# 필요없는 것을 조건을 줘서 걸러내는 과정. 조건에 맞는 것만 인데싱되서 참조된다.  
# ---------------------------
cooccur_mat = t(refined_dtm_mat) %*% refined_dtm_mat
cooccur_mat[1:4, 1:4]
# 연관성의 강도를 파악하기 위해 행열의 곱을 이용하는 과정.
# ---------------------------
# 방법 1
inx = diag(cooccur_mat) >= 150
cooccur_plot_mat1 = cooccur_mat[inx, inx]

# 방법 2
idx = which(conf_result$increasing_rate[
  which(is.finite(conf_result$increasing_rate))] >= 5)
cooccur_plot_mat2 = cooccur_mat[idx, idx]
# 불필요한 부분을 지우는 과정. 

# ---------------------------
g = graph.adjacency(cooccur_plot_mat1, weighted = T, mode = 'undirected')
g = simplify(g)

wc = cluster_walktrap(g)
members = membership(wc)
network_list = igraph_to_networkD3(g, group = members)

# 패키지를 사용하기 위한 데이터 전처리 과정.

# ---------------------------
sankeyNetwork(Links = network_list$links, Nodes = network_list$nodes,
              Source = "source", Target = "target", 
              Value = "value", NodeID = "name",
              units = "TWh", fontSize = 18, nodeWidth = 30)

# ---------------------------
if(!require(circlize)){install.packages("circlize"); library(circlize)}
name=c(3,10,10,3,6,7,8,3,6,1,2,2,6,10,2,3,3,10,4,5,9,10)
feature=paste("feature ", c(1,1,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5),
              sep="")
dat <- data.frame(name,feature)
dat <- table(name, feature)
head(dat,4)

# ---------------------------
chordDiagram(as.data.frame(dat), transparency = 0.5)

# ---------------------------
install.packages("devtools")
if(!require(chorddiag)){devtools::install_github("mattflor/chorddiag"); 
  library(chorddiag)}
if(!require(RColorBrewer)){install.packages("RColorBrewer"); 
  library(RColorBrewer)}

doc_list = data_list$n_gram
table_list = lapply(doc_list, table)[1:100]
table_name = unique(unlist(do.call("c", doc_list[1:100] )))
names(table_list) = paste0("doc_", 1:100)

table_list = lapply(table_list, function(x){
    word_table = rep(0, length = length(uniq_words))
    word_table = ifelse(uniq_words %in% names(x), x, 0)  
  }
)

table_list = do.call("rbind", table_list)

refined_table_list = t(table_list[, apply(table_list, 2, sum) != 0])
rownames(refined_table_list) = table_name
groupColors <- brewer.pal(3, "Set3")

chorddiag(refined_table_list
          , groupColors = groupColors,  type = "bipartite", tickInterval = 3
          ,groupnameFontsize = 15)






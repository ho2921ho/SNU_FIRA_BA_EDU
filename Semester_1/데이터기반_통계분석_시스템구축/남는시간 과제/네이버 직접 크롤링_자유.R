library(rvest)
if(!require(rvest)){install.packages('rvest') ; library(rvest)}
if(!require(httr)){install.packages("httr"); library(httr)}
library(KoNLP)
useSejongDic()
library(Rfacebook)
library(KoNLP)
library(wordcloud2)
library(yaml)
library(devtools)
library(RSelenium) 
library(rvest) 
library(httr)

## 2017년도 1월 ~ 6월

query = '직장인%20남성%20\"남는시간\"'

url_2017 = paste0('https://search.naver.com/search.naver?date_from=20170101&date_option=8&date_to=20170630&dup_remove=1&nso=p%3Afrom20170101to20170630&post_blogurl=&post_blogurl_without=&query=',query,'&sm=tab_pge&srchby=all&st=sim&where=post&start=')

url_2018 = paste0('https://search.naver.com/search.naver?date_from=20180101&date_option=8&date_to=20180630&dup_remove=1&nso=p%3Afrom20180101to20180630&post_blogurl=&post_blogurl_without=&query=',query,'&sm=tab_pge&srchby=all&st=sim&where=post&start=')


### 크롤링 
end_num = 1000
display_num = 100
start_point = seq(1,end_num,10)
print(start_point)

final_data = NULL
for(i in start_point){
  print(i)
  date_time<-Sys.time()
  while((as.numeric(Sys.time()) - as.numeric(date_time))<0.06)
    url = paste0(url_2017,i)
  html_blog = read_html(x = url, encoding = 'UTF-8')
  title = html_blog %>% html_nodes("a[class='sh_blog_title _sp_each_url _sp_each_title']") %>% html_attr(name = "title") %>% data.frame(stringsAsFactors = F)
  description = html_blog %>% html_nodes('.sh_blog_passage') %>% html_text() %>% data.frame(stringsAsFactors = F)
  temp_data = rbind(title,description)
  final_data = rbind(final_data,temp_data)
  cat(i, "\n")
}

str(final_data)
### 데이터 정제
final_data = data.frame(final_data, stringsAsFactors = F)

final_data$. = gsub('\n|\t|<.*?>|&quot;',' ',final_data$.)
final_data$. = gsub('[^가-힣]',' ',final_data$.)
final_data$. = gsub(' +',' ',final_data$.)

### 명사 뽑기
library(KoNLP)
newdic=data.frame(V1=c("투잡","스마트폰","알바","체크인","투어","힐링","52"),"ncn")
mergeUserDic(newdic)
nouns_2017=KoNLP::extractNoun(final_data$.)
nouns_2017[1:5]

nouns_2017 = unlist(nouns_2017)
nouns_2017 = data.frame(nouns_2017, stringsAsFactors = F)

### 키워드 개수 세기
library(dplyr)
keyword_count = nouns_2017 %>% count(nouns_2017)

keyword_count_2017 = keyword_count

## 2018년도 1월 ~ 6월

### 크롤링 

final_data = NULL
for(i in start_point){
  print(i)
  date_time<-Sys.time()
  while((as.numeric(Sys.time()) - as.numeric(date_time))<0.06)
    url = paste0(url_2018,i)
  html_blog = read_html(x = url, encoding = 'UTF-8')
  title = html_blog %>% html_nodes("a[class='sh_blog_title _sp_each_url _sp_each_title']") %>% html_attr(name = "title") %>% data.frame(stringsAsFactors = F)
  description = html_blog %>% html_nodes('.sh_blog_passage') %>% html_text() %>% data.frame(stringsAsFactors = F)
  temp_data = rbind(title,description)
  final_data = rbind(final_data,temp_data)
  cat(i, "\n")
}

str(final_data)
### 데이터 정제
final_data = data.frame(final_data, stringsAsFactors = F)

final_data$. = gsub('\n|\t|<.*?>|&quot;',' ',final_data$.)
final_data$. = gsub('[^가-힣]',' ',final_data$.)
final_data$. = gsub(' +',' ',final_data$.)

### 명사 뽑기
library(KoNLP)
newdic=data.frame(V1=c("투잡","스마트폰","알바","체크인","투어","힐링","52"),"ncn")
mergeUserDic(newdic)
nouns_2018=KoNLP::extractNoun(final_data$.)


nouns_2018 = unlist(nouns_2018)
nouns_2018 = data.frame(nouns_2018, stringsAsFactors = F)

### 키워드 개수 세기
library(dplyr)
keyword_count = nouns_2018 %>% count(nouns_2018)
keyword_count_2018 = keyword_count


## 필요없는 항목 제거
keyword_count_2017_filtered = filter(.data = keyword_count_2017, n >1, nouns_2017 != '',nouns_2017 != ' ')
keyword_count_2018_filtered = filter(.data = keyword_count_2018, n >1, nouns_2018 != '')

## 키워드 사전 만들기
keyword_dict = unique(c(keyword_count_2017_filtered$nouns_2017,keyword_count_2018_filtered$nouns_2018))
keyword_dict = keyword_dict[order(keyword_dict)]
keyword_dict = data.frame(keyword_dict, stringsAsFactors = F)
colnames(keyword_dict) = 'keyword'
colnames(keyword_count_2017_filtered) = c('keyword','n_17')
colnames(keyword_count_2018_filtered) = c('keyword','n_18')

## confiden 값으로 변환 
# 남은시간과 관련이 있는 글에서 나타난 특정 단어수 / 남은시간과 관련이 있는 문서에서 나타난 총 단어수 
keyword_count_2017_filtered$n_17 = as.numeric(keyword_count_2017_filtered$n_17)
keyword_count_2017_filtered$conf_2017 = keyword_count_2017_filtered$n_17/sum(keyword_count_2017_filtered$n_17)

keyword_count_2018_filtered$n_18 = as.numeric(keyword_count_2018_filtered$n_18)
keyword_count_2018_filtered$conf_2018 = keyword_count_2018_filtered$n_18/sum(keyword_count_2018_filtered$n_18)

colnames(keyword_count_2017_filtered) = c('keyword','n_17','conf_2017')
colnames(keyword_count_2018_filtered) = c('keyword','n_18','conf_2018')

# 두 데이터 합치기
final_data = merge(keyword_dict,keyword_count_2017_filtered,by = 'keyword', all = T)
final_data = merge(final_data,keyword_count_2018_filtered,by = 'keyword', all = T)

# 결측치 처리
colnames(final_data)
str(final_data)

final_data[ ,c(2,3,4,5)][is.na(final_data[, c(2,3,4,5)])] <- 0

# '무의미한데 수치가 높게 나오는 값 제거
final_data = data.frame(final_data, stringsAsFactors = F)
final_data = final_data[final_data$keyword != '남', ]

# confidence 그림 그리기


final_data$increasing_rate = final_data[,5] / final_data[,3]
final_data$decreasing_rate = final_data[,3] / final_data[,5]


attach(final_data)
# $를 생략하고도 쓸 수 있게 하는 기능을 한다. 
text_conf = final_data[c(which(is.finite(increasing_rate) & increasing_rate > 3), which(is.finite(decreasing_rate) & decreasing_rate > 4)),]
str(text_conf)
text_conf$keyword
loc_conf = decreasing_rate[c(which(is.finite(increasing_rate) & increasing_rate > 5), which(is.finite(decreasing_rate) & decreasing_rate > 5))][1]
# 위치를 저장하려는 목적. 
text_conf$keyword
# ---------------------------
plot(final_data$decreasing_rate, final_data$increasing_rate, ylim = c(0, 10),
     xlim = c(0, 10), ylab = 'increasing in 2018', xlab = 'decreasing in 2018', main = 'Keyword Ratio 2018 and 2017')

text(2, 7.5,
     labels = '아르바이트,직장인', cex = 1, pos = 3)
# 남편
text(0.9,5.5, 
     labels = '남편', cex = 1, pos = 3)
# 인천공항, 직장인
text(1.8, 4.8,
     labels = '인천공항, 집안', cex = 1, pos = 3)

# 이벤트
text(5, 0.2,
     labels ='이벤트', cex = 1, pos = 3)
# 사회복지사
text(6.3, 0.8,
     labels = '사회복지사', cex = 1, pos = 3)
# 서비스
text(7.5, 0.2,
     labels = '서비스', cex = 1, pos = 3)

# 이부분 잘 해석이/...
abline(a = 0, b = 1, col = 'red')
# 이선 위에 있으면 2017년에 중요해진 친구들. 비율이 1보다 크니깐!! 오른 쪽에 있을 수록 전체적으로 중요한 것!
# 0쪽으로 몰려 있는데. 이런 걸 그릴 때는 로그 스케일로 그려주면 좋다. 로그를 취하면 쫙 퍼진다. 그렇지만 0인 값은 그려지지 않는다. 그래서


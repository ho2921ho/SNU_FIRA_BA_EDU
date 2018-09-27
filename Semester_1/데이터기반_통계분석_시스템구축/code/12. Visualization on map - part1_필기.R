# 7월  17일 
# 지도 그리기가 어렵다. 잘 그리기가 어려워.. 구면 좌표를 평면에 옯기려다 보니까.. 
# 일단은 무시하고 그려보자.

rm(list = ls()); gc(reset = T)

# -----------------------------
if(!require(maps)){install.packages("maps") ;library(maps)}
if(!require(mapdata)){install.packages("mapdata") ;library(mapdata)}

# -----------------------------
par(mfrow = c(1,2))
map(database = "usa")
map(database = "county") ## county map을 이용, 자세한 USA map을 그릴 수 있음

# -----------------------------
map(database = 'world', region = 'South Korea')
# world2Hires에서 보다 높은 자세한 map을 그릴 수 있음
map('world2Hires', 'South Korea') 
# 이거 보다 더 자세한 데이터 베이스가 있다. 도로. 통신망 등도 있다. 
# -----------------------------
data(us.cities)
head(us.cities)

# -----------------------------
map('world', fill = TRUE, col = rainbow(30))

# -----------------------------
map('world', fill = TRUE, col = rainbow(30))

# -----------------------------
## 7월 19일
data(unemp) # unemployed rate data
data(county.fips) # county fips data
# 폴리곤에 대응되는 아이디를 관리, 어떤 그룹이 누구인가를 알려준다. 
# 이 순서대로 그려진다라는 점~ 맵에서 폴리곤을 그리는 순서. 
# 맵폴리곤을 색칠을 하고 싶을 떄, 실업률을 기준으로 하고 싶다면, 1001번은 9.7프로이기 때문에 거기에 해당하는 색깔을 칠하고 싶다.
# 그래서 여기에 색을 붙여야한다. 
head(unemp,3)
head(county.fips,3)
str(unemp)
# -----------------------------
unemp$colorBuckets <- cut(unemp$unemp, 
                                     c(0, 2, 4, 6, 8, 10, 100))
# 색을 붙이기 위한 과정. 처음에 할 일은 범주형 변수 처럼 구간을 만든다. 0~2, 2~4, 4~6, ...이런식! cut이라는 함수로 레벨을 쉽게 만들수 있다.
# 데이터 타입은 벡터이다. 
colorsmatched <- unemp$colorBuckets[match(county.fips$fips, unemp$fips)]
# 순서를 정하는 작업? 매치펑션이 해준다...벡터변수가 원래는 unemp를 기준으로 정렬되어 있었는데. 이작업을 통해 county.fips로 재정렬된다.
# 폴리곤을 그리는 순서가 county를 따르기 때문에 이걸 기준으로 매치를 해줘야한다. 
# -----------------------------

colors = c("#F1EEF6","#D4B9DA","#C994C7","#DF65B0","#DD1C77","#980043")
# 팔레트를 만들었다. 첫번째는 레벨 1번 0~2사이의 실업률. 다음도 마찬가지...
if(!require(mapproj)){install.packages("mapproj") ;library(mapproj)}
map("county", col = colors[colorsmatched], fill = TRUE,
        resolution = 0, lty = 0, projection = "polyconic")

# gg map 도 가능한데, 수치화된 지도 데이터를 다룰 때는 전통적인 방법이 우위.
# -----------------------------
colors = c("#F1EEF6","#D4B9DA","#C994C7","#DF65B0","#DD1C77","#980043")
map("county", col = colors[colorsmatched], fill = TRUE,
    resolution = 0, lty = 0, projection = "polyconic")

# -----------------------------
map("county", col = colors[colorsmatched], fill = TRUE,
    resolution = 0, lty = 0, projection = "polyconic")
map("state", col = "white", fill = FALSE, add = TRUE, lty = 1,
    lwd = 0.2,projection = "polyconic")
# 경게선을 하얀석으로 그리는 법.
title("unemployment by county, 2009")

# -----------------------------
colors = c("#F1EEF6","#D4B9DA","#C994C7","#DF65B0","#DD1C77","#980043")
colorsmatched <- unemp$colorBuckets[match(county.fips$fips, unemp$fips)]
map("county", col = colors[colorsmatched], fill = TRUE,
    resolution = 0, lty = 0, projection = "polyconic")
map("state", col = "white", fill = FALSE, add = TRUE, lty = 1,
    lwd = 0.2,projection = "polyconic")
title("unemployment by county, 2009")

# -----------------------------
if(!require(dplyr)){install.packages("dplyr") ;library(dplyr)}
if(!require(ggplot2)){install.packages("ggplot2") ;library(ggplot2)}

wm <- ggplot2::map_data('world')
# world 데이터 내의 group 항목이 그리는 순서. order 점을 그리는 순서.
head(wm, n = 30)
# aruba를 파란선을 그리고 싶으면 group 1을 blue로 하면된다. 
# 섬나라는 group이 여러개. 폴리곤 별로 다른 색을 지정하면 같은 나라가 여러개의 다른 폴리곤으로 구성되있을 수 있기 떄문에 서로 다른 색으로 칠해질 수 있다. 
# 같은 색을 칠하려면 나라를 기준으로 색을 만들어야 한다. 
wm %>% dplyr::select(region) %>% unique()%>%head()

# -----------------------------
# 한국지도를 그려보자.
ur <- wm %>% dplyr::select(region)%>%unique()
nrow(ur)
grep( "Korea", ur$region )
ur$region[c(185)]

# -----------------------------
map("world", ur$region[c(42,116,185)],fill = T,
    col = "blue")
# 색을 어떻게 구분할까? 색을 칠해지는 단위는 여전히 폴리곤! 색을 나누기 위해서는...
wmr <- wm %>% filter(wm$region == "South Korea" | wm$region == "North Korea")
wmr
wmn <-wm %>% filter(wm$region == "North Korea")
wmn
unique(wmn$group)
map("world", ur$region[c(125,185)],fill = T,
    col = c(rep("blue",11),rep('pink',2)))
# 지도 다루는 것은 손이 많이가요 ㅠ
# 패키지가 있을듯 함요. 
# 맵이라는 패키지를 통해 새로운 함수를 짜는 것? 
# -----------------------------
## draw pi chart...

if(!require(mapplots)){install.packages("mapplots") ;library(mapplots)}
if(!require(ggmap)){install.packages("ggmap") ;library(ggmap)}
if(!require(mapdata)){install.packages("mapdata") ;library(mapdata)}

map('worldHires', 'South Korea')
seoul_loc = geocode('Gwangju')
busan_loc = geocode('Busan')
add.pie(z=1:2,labels = c('a','b'), 
        x = seoul_loc$lon, y = seoul_loc$lat, radius = 0.5)
add.pie(z=4:3,labels = c('a','b'),
        x = busan_loc$lon, y = busan_loc$lat, radius = 0.5)


















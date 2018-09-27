rm(list = ls()); gc(reset = T)

# -------------------------------------------
if(!require(OpenStreetMap)){install.packages("OpenStreetMap"); library(OpenStreetMap)}
if(!require(ggplot2)){install.packages("ggplot2"); library(ggplot2)}

# -------------------------------------------
map = OpenStreetMap::openmap(upperLeft = c(43, 119), lowerRight = c(33, 134),
                             type = 'bing')
plot(map)

# -------------------------------------------
map = openmap(upperLeft = c(43, 119), lowerRight = c(33, 134),
              type = 'bing')
plot(map)

# -------------------------------------------
par(mfrow = c(1,2))
map = openmap(upperLeft = c(43, 119), lowerRight = c(33, 134),
              type = 'bing')
autoplot(map)
# ggplot 내의 함수. x,,y축의 좌표계를 확인 가능. 

# -------------------------------------------
nm = c("osm", "mapbox", "stamen-toner", 
       "stamen-watercolor", "esri", "esri-topo", 
       "nps", "apple-iphoto", "osm-public-transport")
# 맵 타입을 가리키는 특성. 
par(mfrow=c(3,3),  mar=c(0, 0, 0, 0), oma=c(0, 0, 0, 0))
# par 함수에서 옵션의 의미를 찾아볼 수 있다. 
for(i in 1:length(nm)){
  map <- openmap(c(43,119),
                 c(33,134),
                 minNumTiles = 3,
                 type = nm[i])
  plot(map, xlab = paste(nm[i]))
}

par(mfrow = c(1, 1))
# -------------------------------------------
map1 <- openmap(c(43.46,119.94),
                c(33.22,133.98))
plot(map1) 
abline(h = 38, col = 'blue')
abline(h = 4500000, col = 'blue')
# 좌표계가 다르기 때문에 38은 아무것도 안된다. 
# 지도에 이미지를 추가하고 싶다면...
# 위경도 좌표계로 치환 하거나 추가하고자 하는 이미지를 이 맵의 좌표계로 치환.

# -------------------------------------------
str(map1)
# 그림이 어떤 속성을 가지고 있는 지 살펴보자. 
# list라 되어 있고. title, bbox 두개의 체인으로 이루어져 있다.
# bbox는 또 두개의 체인을 가지고 있다. p1, p2
#   .. .. ..$ p1: num [1:2] 13351660 5382253
# .. .. ..$ p2: num [1:2] 14914585 3924542
# 박스의 양쪽 끝을 잡아주는 정보...
# $ projection:Formal class 'CRS' [package "sp"] with 1 slot
#             > 다른 패키지에서 정의된 리스트
#.. .. .. ..@ projargs: chr "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"
#          > 좌표계를 어떻게 바꿔는지..중요!
# -------------------------------------------
map1$tiles[[1]]$projection
# 
map1$tiles
# -------------------------------------------
if(!require(sp)){install.packages("sp"); library(sp)}
map_p <- openproj(map1, projection = CRS("+proj=longlat"))
# 좌표계를 바꿔주는 함수. CRS 함수를 이용!
str(map_p)
# 좌표계 설정 방법이 바뀐 것을 확인 가능합니다! ㅎㅎ
# -------------------------------------------
plot(map_p)
plot(map_p)
abline(h = 38, col = 'blue')
# -------------------------------------------
# 다양한 좌표계 설정 방법이 있다. 
map_p <- openproj(map1, projection = 
                    CRS("+proj=utm +zone=52N + datum=WGS84"))
# +는 좌표계를 설명하기 위한 옵션을 추가한다는 의미. 
# utm 좌표설정, zone 52N에서 프로젝션하겠다. datum = WGS84 데이터를 사용하겠다. 
plot(map_p)
abline(h = 38, col = 'blue')

# -------------------------------------------
# 점들을 생성해서 연결하는 방식으로 선을 그려보자!
a  <-data.frame(lon =  seq(100,140,by = 0.1),
                lat =  38)
# 점을 찍자! coor~함수를 사용해서 숫자를 좌표계로 변환하자!
sp::coordinates(a) = ~ lon + lat
# :: 한정자. 없어도 된다. 
str(a)
# a의 class가 바뀐 것을 확인할 수 있다. 
a@coords

# -------------------------------------------
sp::proj4string(a) = "+proj=longlat"
#a@proj4string  = CRS("+proj=longlat")
# 만들어진 좌표 숫자에 좌표계 설정방식을 알려준다.
# 위경도 좌표계에서 의미를 가지는 점들을 생성했습니다.
str(a)
# 남은 일은 좌표계 설정!
# -------------------------------------------
a_tf = spTransform(a,  CRS("+proj=utm +zone=52N + datum=WGS84"))
# spTransform, 좌표계 설정을 바꿔주는 기능?

str(a_tf)

# -------------------------------------------
plot(map_p)
points(a_tf@coords[,1], a_tf@coords[,2], type = 'l', col = 'blue')

# -------------------------------------------
if(!require(mapplots)){install.packages("mapplots"); library(mapplots)}

map = openmap(upperLeft = c(43, 119),lowerRight = c(33, 134))
seoul_loc = geocode('Seoul')
coordinates(seoul_loc) = ~lon + lat
proj4string(seoul_loc) = "+proj=longlat +datum=WGS84" 
seoul_loc_Tf = spTransform(seoul_loc,
                           CRS(as.character(map$tiles[[1]]$projection)))
plot(map)
add.pie(z=1:2,labels = c('a','b'),
        x = seoul_loc_Tf@coords[1],
        y = seoul_loc_Tf@coords[2], radius = 100000)

# -------------------------------------------
## 자세하게 안함요.
if(!require(ggmap)){install.packages("ggmap"); library(ggmap)}
if(!require(mapplots)){install.packages("mapplots"); library(mapplots)}
if(!require(OpenStreetMap)){install.packages("OpenStreetMap"); library(OpenStreetMap)}

map = openmap( upperLeft = c(43, 119), lowerRight = c(33, 134),type = 'bing') # upperLeft lowerRight option
seoul_loc = geocode('Seoul')
coordinates(seoul_loc) = ~lon + lat
proj4string(seoul_loc) <- "+proj=longlat +datum=WGS84"
seoul_loc_Tf <- spTransform(seoul_loc, CRS(as.character(map$tiles[[1]]$projection)))
plot(map)
add.pie(z=1:2,labels = c('a','b'), x = seoul_loc_Tf@coords[1], y = seoul_loc_Tf@coords[2], radius = 100000)

# -------------------------------------------
if(!require(ggmap)){install.packages("ggmap"); library(ggmap)}

# -------------------------------------------
data(crime)
head(crime, 2)

# -------------------------------------------
# 데이터가 2차원일 경우, 유용한 방법.
# 산불 데이터도 이런 방식 분석이 유용.
violent_crimes = subset(crime,
                        offense != "auto theft" & 
                          offense != "theft" & 
                          offense != "burglary")
violent_crimes$offense <- factor(violent_crimes$offense,
                                 levels = c("robbery", "aggravated assault", "rape", "murder"))
violent_crimes = subset(violent_crimes,
                        -95.39681 <= lon & lon <= -95.34188 &
                          29.73631 <= lat & lat <=  29.78400)

# -------------------------------------------
HoustonMap = qmap("houston", zoom = 14,
                  color = "bw", legend = "topleft")
# 데이터를 하나의 팔레트로 사용!
HoustonMap + geom_point(aes(x = lon, y = lat,
                            colour = offense, size = offense),
                        data = violent_crimes)
# geom_point 로 점을 찍는다.
# 산불 좌표도 똑같이 그릴 수 있다.
# -------------------------------------------
HoustonMap +
  geom_point(aes(x = lon, y = lat,
                 colour = offense, size = offense),
             data = violent_crimes) +
  geom_density2d(aes(x = lon, y = lat), size = 0.2 , bins = 4, 
                 data = violent_crimes)
# 2차원 상에서 확률밀도함수?를 그리는 것. bins가 중요하다. 축방향으로 몇개의 칸을 만들건지...


# -------------------------------------------
HoustonMap +
  geom_point(aes(x = lon, y = lat,
                 colour = offense, size = offense),
             data = violent_crimes) +
  geom_density2d(aes(x = lon, y = lat), size = 0.2 , bins = 4, 
                 data = violent_crimes) +
  stat_density2d(aes(x = lon, y = lat,
                     fill = ..level..,  alpha = ..level..),
                 # level에 따라 색을 칠하는다는 것. ..density와 같은 개념!
                 size = 2 , bins = 4,
                 data = violent_crimes,geom = "polygon")

# -------------------------------------------

setwd("C:/Users/renz/Desktop/R_전종준/data")
load('airport.Rdata')
head(airport_krjp)

# -------------------------------------------
head(link_krjp)

# -------------------------------------------
map = ggmap(get_googlemap(center = c(lon=134, lat=36),
                          zoom = 5, maptype='roadmap', color='bw'))
map + geom_line(data=link_krjp,aes(x=lon,y=lat,group=group), 
                col='grey10',alpha=0.05) + 
  geom_point(data=airport_krjp[complete.cases(airport_krjp),],
             aes(x=lon,y=lat, size=Freq), colour='black',alpha=0.5) + 
  scale_size(range=c(0,15))


# -------------------------------------------
if (!require(sp)) {install.packages('sp'); library(sp)}
if (!require(gstat)) {install.packages('gstat'); library(gstat)}
if (!require(automap)) {install.packages('automap'); library(automap)}
if (!require(rgdal)) {install.packages('rgdal'); library(rgdal)}
if (!require(e1071)) {install.packages('e1071'); library(e1071)}
if (!require(dplyr)) {install.packages('dplyr'); library(dplyr)}
if (!require(lattice)) {install.packages('lattice'); library(lattice)}
if (!require(viridis)) {install.packages('viridis'); library(viridis)}

# -------------------------------------------
## 미세먼지 분석.
seoul032823 <- read.csv ("seoul032823.csv")
head(seoul032823)

# 관측소에서 측정된 미세먼지 수치가 기록
# 위치가 변하지 않는다는 점에서 범죄데이터가 다름
# 중요한 것은 특정위치에서 어떤 값이 나왔는지가 중요.
# 그래서 빈도 보다는 값 자체가 중요.
# 알고 싶은 것은 경기도 지역의 미세먼지 농도를 추정하는 것!
# 그러나 알 수 있는 지역은 관측지점 뿐ㅜㅜ 그래서 빈 곳을 채우는 작업을 할 것이고 
# 이럿을 공간내사? spatial interporation? 이라고 합니다~
# 2차원 공간에서는 크래깅? 아리는 방법을 이용한다고 합니다. 
# 이제 이 친구를 지도좌표로 바꾸고 격자로 바꿔서 크래킹하고 다시 지도 좌표계로 변환하고 ...등등 의 많이 작업이 필요합니다.
# 패키지 수만 봐도...겁나 많네여.. 근데 사실 하나의 패키지로 할 수 있데요 근데 차근차근 보여줄려구..
# -------------------------------------------
skorea <- raster::getData(name ="GADM", country= "KOR", level=2)
skorea <- readRDS("KOR_adm2.rds")
head(skorea,2)

# -------------------------------------------
class(skorea)
head(skorea@polygons[[1]]@Polygons[[1]]@coords, 3)

# -------------------------------------------
if (!require(broom)) {install.packages('broom'); library(broom)}

skorea <- broom::tidy(skorea)
#tidy를 통해 데이터를 와이드 포맷, 데이터 프레임으로  변환. 
class(skorea)
head(skorea,3)

# -------------------------------------------
ggplot() + geom_map(data= skorea, map= skorea,
                    aes(map_id=id,group=group),fill=NA, colour="black") +
  geom_point(data=seoul032823, aes(LON, LAT, col = PM10),alpha=0.7) +
  # 우리가 다른데이터를 쓰고 싶을 떄 바꿀 부분!
    labs(title= "PM10 Concentration in Seoul Area at South Korea",
       x="Longitude", y= "Latitude", size="PM10(microgm/m3)")
# 작동이 안돼... ㅠㅠㅠㅜㅠㅜ
# -------------------------------------------
class(seoul032823)
coordinates(seoul032823) <- ~LON+LAT
class(seoul032823)

# -------------------------------------------
# 그리드를 만들어 주는 부분.
LON.range <- c(126.5, 127.5)
LAT.range <- c(37, 38)
seoul032823.grid <- expand.grid(
  LON = seq(from = LON.range[1], to = LON.range[2], by = 0.01),
  LAT = seq(from = LAT.range[1], to = LAT.range[2], by = 0.01))
# -------------------------------------------
plot(seoul032823.grid)
points(seoul032823, pch= 16,col="red")
# 측정소의 위치가 표현된다. 
# 하나의 숫자.
# -------------------------------------------
coordinates(seoul032823.grid)<- ~LON+LAT ## sp class
# 좌표계로 구혀
gridded(seoul032823.grid)<- T
plot(seoul032823.grid)
points(seoul032823, pch= 16,col="red")

# -------------------------------------------
if(!require(automap)){install.packages("autoKrige"); library(automap)}

seoul032823_OK <- autoKrige(formula = PM10~1,
                           # formula가 중요. pm10이 반응변수 이걸 예측하겠다. 설명변수는 따로 없고 그냥 상수항만! 바람의 방향, 온도등의 요인을 사용하고 싶으면 그걸 ㅁ반영가능.
                            input_data = seoul032823,
                            # training data? # 다양한 설명변수의 효과를 고려한 크리밍이 가능!
                            # 빨간색 점. 이 점은 해당 위치
                            new_data = seoul032823.grid )
                            # test data?

# -------------------------------------------

head(seoul032823_OK$krige_output@coords, 2)

head(seoul032823_OK$krige_output@data$var1.pred,2)
# 서로짝이 된다. 뒤에 것이 예측값. 
# -------------------------------------------
myPoints <- data.frame(seoul032823)

myKorea <- data.frame(skorea)
myKrige <- data.frame(seoul032823_OK$krige_output@coords, 
                      pred = seoul032823_OK$krige_output@data$var1.pred)   
# 두짝을 맞춰서 데이터 프레임
# -------------------------------------------
if(!require(viridis)){install.packages("viridis"); library(viridis)}
# 색칠 패키지

ggplot()+ theme_minimal() +
  geom_tile(data = myKrige, aes(x= LON, y= LAT, fill = pred)) +
  # 뭔가 생긴다. myKrige에는 위경도의 격자좌표와 격자에 대응되는 pm10값이 들어있다. 가장중요한 부분.
  geom_map(data= myKorea, map= myKorea, aes(map_id=id,group=group),
           fill=NA, colour="black") +
  # 지도를 덧 입히기
  coord_cartesian(xlim= LON.range ,ylim= LAT.range) +
  labs(title= "PM10 Concentration in Seoul Area at South Korea",
       x="Longitude", y= "Latitude")+
  theme(title= element_text(hjust = 0.5,vjust = 1,face= c("bold")))+
  scale_fill_viridis(option="magma")

## 다른 데이터를 적용하기 위해서는 포인트데이터 그 빨간 점 찍은 부분. 그리드 범위 설정 등등 이 중요합니다. 오토 그리즈애서 포뮬라 등등


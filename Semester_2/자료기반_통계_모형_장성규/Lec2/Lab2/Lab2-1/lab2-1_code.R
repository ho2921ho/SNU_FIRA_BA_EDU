#####################################################################################
#                 Visualizing historical baby names via ggplot2                     #
#                                   2018.08.14                                      #
#                   Instructor : Sungkyu Jung, TA : Boyoung Kim                     #
#                                                                                   #
#####################################################################################



#--- 1. Introduction

#install.packages("mdsr")

library(mdsr)
library(babynames)

head(babynames)

BabynamesDist <- make_babynames_dist()

head(BabynamesDist, 2)
#n : 출생수
#alive_prob : 2014년까지 생존확률
#count_thousands : 출생수 (단위 : 1000명)
#age_today : 2014년의 나이
#est_alive_today : 2014년에 생존수 추정값



#--- 2. Re-creating Figure 3.21
joseph <- BabynamesDist %>% filter(name == "Joseph", sex == "M") #해당 조건을 만족하는 자료만 추출.

# initial ggplot2 object
name_plot <- ggplot(data = joseph, aes(x = year)) #aes : 색상, 크기 등 외적 요소

# add the bars
name_plot <- name_plot +
  geom_bar(stat = "identity", aes(y = count_thousands * alive_prob), #  "
                                  # y값으로 데이터에 있는 값이 아니라 변형한 값을 쓰려면 identity옵션을 넣어야 하는 듯?
           fill = "#b2d7e9", colour = "white") #adds bars, geom : 점,선,모양 등 기하학적 요소

# the black line
name_plot <- name_plot + geom_line(aes(y = count_thousands), size = 2)  #add black line

# add the labels
name_plot <- name_plot +
  ylab("Number of People (thousands)") + xlab(NULL) #add labels

# computes the median year
library(Hmisc) 
median_yob <-
  with(joseph, wtd.quantile(year, est_alive_today, probs = 0.5)) # wtd.quantile이 핵심함수.
  # with 자료,계산, 자료에서 계산을 해서 값을 주는 함수?
median_yob

# overplot a single bar in a darker shade of blue
name_plot <- name_plot +
  geom_bar(stat = "identity", colour = "white", fill = "#008fd5",
           aes(y = ifelse(year == median_yob, est_alive_today / 1000, 0)))
                                # 1975년에만 bar를 그리고 나머지는 안그려지는 효과.

# contain many contextual elements
name_plot +
  ggtitle("Age Distribution of American Boys Named Joseph") +
  geom_text(x = 1935, y = 40, label = "Number of Josephs\nborn each year") +
  geom_text(x = 1915, y = 13, label =
              "Number of Josephs\nborn each year\nestimated to be alive\non 1/1/2014",
            colour = "#b2d7e9") +
  geom_text(x = 2003, y = 40,
            label = "The median\nliving Joseph\nis 37 years old",
            colour = "darkgray") +
  geom_curve(x = 1995, xend = 1974, y = 40, yend = 24,
             arrow = arrow(length = unit(0.3,"cm")), curvature = 0.5) + ylim(0, 42)
                            # 화살표의 길이.        # 화살표의 각도 



#--- 3. Re-using name_plot

# obtain an analogous plot for another name
Josephine <- filter(BabynamesDist, name == "Josephine" & sex == "F")
name_plot %+% Josephine
          # 그대로 사용할 수 있다 
# compare the gender breakdown for a few of the most common of these
many_names_plot <- name_plot + facet_grid(name ~ sex)
mnp <- many_names_plot %+% filter(BabynamesDist, name %in%
                                    c("Jessie", "Marion", "Jackie"))
mnp

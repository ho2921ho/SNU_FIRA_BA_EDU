library(rvest)

## 2017년도 1월 ~ 6월
url_2017 = 'https://search.naver.com/search.naver?date_from=20170101&date_option=8&date_to=20170630&dup_remove=1&nso=p%3Afrom20180101to20180630&post_blogurl=&post_blogurl_without=&query=%22%EB%82%A8%EB%8A%94%EC%8B%9C%EA%B0%84%22&sm=tab_pge&srchby=all&st=sim&where=post&start='

end_num = 1000
display_num = 100
start_point = seq(1,end_num,display_num)

final_dat = NULL
for(i in 1:length(start_point))
{
  # request xml format
  url = paste0('https://openapi.naver.com/v1/search/blog.xml?query=',query,'&display=',display_num,'&start=',start_point[i],'&sort=sim')
  #option header
  url_body = read_xml(GET(url, header), encoding = "UTF-8")
  title = url_body %>% xml_nodes('item title') %>% xml_text()
  bloggername = url_body %>% xml_nodes('item bloggername') %>% xml_text()
  postdate = url_body %>% xml_nodes('postdate') %>% xml_text()
  link = url_body %>% xml_nodes('item link') %>% xml_text()
  description = url_body %>% xml_nodes('item description') %>% html_text()
  temp_dat = cbind(title, bloggername, postdate, link, description)
  final_dat = rbind(final_dat, temp_dat)
  cat(i, '\n')
}
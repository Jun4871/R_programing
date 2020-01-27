dirname <- "linux_master_2"
dir.create(dirname)
for (page_num in 1:3) {
  defualt_url <- "https://www.comcbt.com/xe/index.php?mid=r2&page="
  lm_2_url <- paste0(defualt_url,page_num)
}

library(rvest)

lm_2_html <- read_html(lm_2_url)

# 해당 Table css 
lm_2_table <- lm_2_html %>% 
  html_nodes(".bd_lst.bd_tb_lst.bd_tb")

# 각 리스트의 href 읽어오기 
lm_2_file_url <- lm_2_table %>% 
  html_nodes(".title") %>% 
  html_node("a") %>% 
  html_attr("href")

# 첫 1~3 줄은 필요 없는 내용이므로 없앰
lm_2_file_url <- lm_2_file_url[-(1:3)]



library(dplyr)


news_url <- "https://search.naver.com/search.naver?where=news&sm=tab_jum&query=%EB%A7%88%EC%9D%B4%ED%81%B4%EC%9E%AD%EC%8A%A8"



news_url_list <- news_url %>% 
  read_html %>% 
  html_nodes(".news.mynews.section._prs_nws") %>% 
  html_nodes("._sp_each_url") %>% 
  html_attr("href")


news_url_list

for(i in news_url_list) {
  i %>%
    read_html() %>% 
    html_nodes("#articeBody.article_body.font1.size3") %>% 
    html_text() %>% 
    str_replace_all("\\W"," ")
}

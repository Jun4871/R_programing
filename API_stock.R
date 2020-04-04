YG <- read.csv("200327YG.csv", header = T, fileEncoding = "euc-kr")

summary(YG)

 url <- "http://ecos.bok.or.kr/api/KeyStatisticList/9FSKNYP5LDM3UIRCKR85/json/kr/1/10/"

# https://opendart.fss.or.kr/api/list.json?crtfc_key={API_KEY}&bgn_de={시작날짜}&end_de={종료날짜}&pblntf_ty={공시유형}&corp_cls={법인구분}&corp_cls=Y&page_no=1&page_count=10


library(glue)
library(jsonlite)
library(tidyverse)
service_key <- "6ea81dcf951118e206c11b8393b1de6066508ecb"
url <- glue("https://opendart.fss.or.kr/api/list.json?crtfc_key={service_key}&bgn_de=20200117&end_de=20200117&page_no=1&page_count=1000")

url <- glue("https://opendart.fss.or.kr/api/list.json?crtfc_key={service_key}&bgn_de=20200117&end_de=20200117&pblntf_ty=C&corp_cls=K&page_no=1&page_count=10")
df <- fromJSON(url)

df <- df$list %>%
  as_tibble()

df

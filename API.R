library(glue)
library(jsonlite)
library(tidyverse)
service_key <- "6ea81dcf951118e206c11b8393b1de6066508ecb"
url <- glue("https://opendart.fss.or.kr/api/list.json?crtfc_key={service_key}&page_no=1&page_count=1000")

df <- fromJSON(url)

df <- df$list %>% 
  as_tibble()

df

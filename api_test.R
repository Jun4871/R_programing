library(httr)
library(tidyverse)
library(jsonlite)
library(readxl)
library(stringr)
library(DT)
library(purrr)
library(XML)
library(glue)
library(lubridate)

api_key <- "535843476a72756436335542567058"

# 20191201 ~ 20200213 데이터 붙히기

date_start <- ymd("20191201")
date_end <- ymd("20200213")

date_index <- 1:(date_end - date_start)

date_key <- (date_start + date_index) %>% 
  str_replace_all("-","")


# 
total_df <- data.frame()
for(i in date_key) {
  api_url <- glue("http://openapi.seoul.go.kr:8088/{api_key}/xml/CardSubwayStatsNew/1/1000/{i}")
  print(api_url)
  api_df <- xmlToDataFrame(api_url)
  
  api_df <- api_df[-c(1,2), -c(1,2,3)]
  
  total_df <- rbind(total_df,api_df)
}

head(api_df)

# 
total_df <- map_dfr(date_key, function(x) {
  api_url <- glue("http://openapi.seoul.go.kr:8088/{api_key}/xml/CardSubwayStatsNew/1/1000/{x}")

  api_df <- xmlToDataFrame(api_url)
  
  api_df <- api_df[-c(1,2), -c(1,2,3)]
})




unique(total_df$USE_DT)

dim(api_df)

# 
# 
# api_url <- glue("http://openapi.seoul.go.kr:8088/{api_key}/xml/CardSubwayStatsNew/1/1000/20191201")
# 
# 
# # paste0("http://openapi.seoul.go.kr:8088/",api_key,"/xml/CardSubwayStatsNew/1/5/20151101")
# 
# # XML to Data.frame
# api_df <- xmlToDataFrame(api_url)
# 
# api_df <- api_df[-c(1,2), -c(1,2,3)]
# 
# 
# 
# 
# head(api_df)
# 
# 
# map_dfr

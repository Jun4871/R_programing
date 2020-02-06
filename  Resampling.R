web_page_data <- read.csv("web_page_data.csv")
str(web_page_data)

ggplot(web_page_data = session_time, aes(x = Page, y = time)) + geom_boxplot(0.7025,1.9925)
rm(list=ls())

summary(web_page_data)



dim(web_page_data)


web_page_data$Time <-data.frame(web_page_data$Time)
session_time <- web_page_data$Time

ggplot(session_time, aes(x = Page, y = time)) + geom_boxplot()

Page <- web_page_data$Page

sd

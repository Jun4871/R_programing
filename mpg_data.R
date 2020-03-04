library(ggplot2)

mpg

mpg$total <- (mpg$cty + mpg$hwy) / 2

mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")

head(mpg)

table(mpg$test)

qplot(mpg$test)

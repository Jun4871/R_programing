sp500_px <- read.csv("sp500_px.csv")
sp500_sym <- read.csv("sp500_sym.csv")
etfs <- sp500_px[row.names(sp500_px) > "2012-07-01",sp500_sym[sp500_sym$sector =="etf", "symbol"]]
library(corrplot)
corrplot(cor(etfs), method = "ellipse")
##### 산점도
plot(sp500_sym$sector_label == "telecom$" & "telecom$VZ", xlab = "T", ylab = "VZ")



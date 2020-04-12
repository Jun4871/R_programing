sp500_px <- read.csv("sp500_px.csv", header = T, stringsAsFactors = FALSE)
sp500_sym <- read.csv("sp500_sym.csv", header = T, stringsAsFactors = FALSE)

str(sp500_px)
summary(sp500_px)

str(sp500_sym)
etfs <- sp500_px[row.names(sp500_px) > "2012-07-01", sp500_sym[sp500_sym$sector == 'etf', 'symbol']]

library(corrplot)

corrplot(cor(etfs), method = "ellipse")

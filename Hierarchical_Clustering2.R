sym1 <- c('GOOGL', 'AMZN', 'AAPL', 'MSFT', 'CSCO', 'INTC', 'CVX',
          'XOM', 'SLB', 'COP', 'JPM', 'WFC', 'USB', 'AXP',
          'WMT', 'TGT', 'HD', 'COST')
df <- t(sp500_px[row.names(sp500_px)>= '2011-01-01', sym1])
d <- dist(df)
hcl <- hclust(d)


plot(hcl)

cutree(hcl, k=4)

library(mclust)
df <- sp500_px[row.names(sp500_px)>= '2011-01-01', c('XOM', 'CVX')]
mcl <- Mclust(df)
summary(mcl)

cluster <- factor(predict(mcl)$classification)
ggplot(data=df, aes(x = XOM, y=CVX, color=cluster, shape = cluster)) +
  geom_point(alpha =.8)

summary(mcl, parameters=TRUE)$mean
summary(mcl, parameters = TRUE)$variance

plot(mcl, what='BIC', ask=FALSE)

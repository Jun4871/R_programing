df <- sp500_px[row.names(sp500_px)>='2011-01-01', c('XOM', 'CVX')]
km <- kmeans(df, centers = 4)
df$cluster <- factor(km$cluster)
head(df)

centoers <- data.frame(cluster = factor(1:4), km$centers)
centoers


ggplot(data=df, aes(x=XOM, y=CVX, color=cluster, shape = cluster)) +
  geom_point(alpha=.3)+
  geom_point(data=centoers, aes(x=XOM, y=CVX), size = 3, stroke=2)

syms <- c( 'AAPL', 'MSFT', 'CSCO', 'INTC', 'CVX', 'XOM', 'SLB', 'COP',
           'JPM', 'WFC', 'USB', 'AXP', 'WMT', 'TGT', 'HD', 'COST')
df <- sp500_px[row.names(sp500_px)>= '2011-01-01', syms]
km <- kmeans(df, centers = 5, nstart = 10)

km$size

centers <- as.data.frame(t(centers))
names(centers) <- paste("Cluster", 1:5)


pct_var <- data.frame(pct_var =0,
                      num_clusters =2:14)
totalss <- kmeans(df, centers =14, nstart=50, iter.max = 100)$totss
for(i in 2:14){
  pct_var[i-1, 'pct_var'] <- kmeans(df, centers=i, nstart=50, iter.max = 100)$betweenss/totalss}

  
syms <- c('AMZN', 'GOOGL','AAPL', 'MSFT', 'CSCO', 'INTC', 'CVX',
         'XOM', 'SLB', 'COP', 'JPM', 'WFC', 'USB', 'AXP',
         'WMT', 'TGT', 'HD', 'COST')


top_sp1 <- sp500_px[row.names(sp500_px)>= '2005-01-01', syms]
sp_pca1 <- princomp(top_sp1)
screeplot(sp_pca1)

round(sp_pca1$loadings[,1:2],3)

x = defaults[1:5, c('dti', 'payment_inc_ratio', 'home_', 'purpose')]
x


library(cluster)
daisy(x, metric = 'gower')

df <- defaults[sample(nrow(defaults), 250),
               c('dti', 'payment_inc_ratio', 'home_', 'purpose')]
d = daisy(df, metric = 'gower')
hcl <- hclust(d)
dnd <- as.dendrogram(hcl)
plot(dnd, leaflab = 'none')


dnd_cut <- cut(dnd, h=.5)
df[labels(dnd_cut$lower[[1]]),]

df <- model.matrix(~ -1 + dti + payment_inc_ratio + home_ + pub_rec_zero, data = defaults)
df0 <- scale(df)
km0 <- kmeans(df0, centers = 4, nstart = 10)
centers0 <- scale(km0$centers, center = FALSE,
                  scale = 1/attr(df0, 'scaled:scale'))
scale(centers0, center = -attr(df0, 'scaled:center'), scale = F)

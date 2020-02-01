sp500_px <- read.csv("sp500_px.csv")
oil_px <- sp500_px[,c('CVX', 'XOM')]
pca <- princomp(oil_px)
pca$loadings



#sp500_sym <- read.csv("sp500_sym.csv")
#etfs <- sp500_px[row.names(sp500_px)>"2012-07-01",
#                 sp500_sym[sp500_sym$sector=="eft", 'symbol']]
#library(corrplot)
#corrplot(cor(etfs), method = "ellipse")

loadings <- pca$loadings
ggplot(data=oil_px, aes(x=CVX, y=XOM)) +
  geom_point(alpha=.3) +
  stat_ellipse(type='norm', level = .99) +
  geom_abline(intercept = 0, slope = loadings[2,1]/loadings[1,1]) +
  geom_abline(intercept = 0, slope = loadings[2,2]/loadings[1,2])


syms <- c('AAPL', 'MSFT', 'CSCO', 'INTC', 'CVX', 'XOM',
          'SLB', 'COP', 'JPM', 'WFC', 'USB', 'AXP', 'WMT', 'TGT', 'HD', 'COST')
top_sp <- sp500_px[row.names(sp500_px)>='2005-01-01',syms]
sp_pca <- princomp(top_sp)
screeplot(sp_pca)

##?? 
library(tidyr)
loadings <- sp_pca$loadings[,1:5]
loadings <- row.names(loadings)
loadings <- gather(loadings, "Component", "Weight", -Symbol)
ggplot(loadings, aes(x=Symbol, y=Weight)) +
  geom_bar(stat = 'identity') +
  facet_grid(Component ~., scales = 'free_y')


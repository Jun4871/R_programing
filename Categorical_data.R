defaults <- read.csv("loan_data.csv")

df <- defaults[, c('loan_amnt', 'annual_inc', 'revol_bal', 'open_acc',
                   'dti', 'revol_util')]
km <- kmeans(df, centers=4, nstart=10)
centers <- data.frame(size=km$size, km$centers)
round(centers, digits = 2)

df0 <- scale(df)
km0 <- kmeans(df0, centers=4, nstart=10)
centers0 <- scale(km0$centers, center=FALSE,
                  scale = 1/attr(df0, 'scaled:scale'))
centers0 <- scale(centers0, center = -attr(df0, 'scaled:center'), scale=F)
data.frame(size=km0$size, centers0)

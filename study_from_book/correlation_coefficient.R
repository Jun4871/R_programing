qqplot(runif(1000, min=1, max = 10), 1:10)

cor(iris$Sepal.Width, iris$Sepal.Length)

cor(iris[,1:4])


symnum(cor(iris[,1:4]))
install.packages("corrgram")
library(corrgram)
corrgram(iris, upper.panel = panel.conf)

cor(1:10, 1:10)
cor(1:10, 1:10*2)

x = 1:10
y= x^3
cor(x,y)

x <- c(3, 4, 5, 3, 2, 1, 7, 5)
rank(sort(x))


(m <- matrix(c(1:10, (1:10)^2), ncol = 2))
cor(m, method = "spearman")

cor(m, method = "pearson")
  
cor(c(1,2,3,4,5), c(1,0,3,4,5), method = "kendall")

cor.test(c(1,2,3,4,5), c(1,0,3,4,5), method ="pearson")

cor.test(c(1,2,3,4,5), c(1,0,3,4,5), method ="spearman")
  
cor.test(c(1,2,3,4,5), c(1,0,3,4,5), method ="kendall")

num_index <- sapply(iris, is.numeric)
iris[,num_index]

# 평균
# mean
mean(iris$Sepal.Length)

mean(iris$Petal.Length)
mean(iris[,3])

# 표준편차
# sd
sd(iris$Sepal.Length)
sd(iris[,1])

cbind(as.data.frame(scale(iris[1:4])), iris$Species)

x <- 1:10 
y <- x + runif(10, min = -.5, max = .5)
z <- x + y + runif(10, min = -10, max = .10)
(data <- data.frame(x,y,z))

pr <- princomp(data)
summary(pr)

pr$scores[, 1:2]

(all <- factor(c(paste0(LETTERS, "0"), paste0(LETTERS,"1"))))

(data <- data.frame(lvl = all, value = rnorm(length(all))))

library(randomForest)
m <- randomForest(value ~ lvl, data=data)
m

(x <- data.frame(lvl = factor(c("A", "B", "A", "A", "C")),
                 value = c(1,2,3,4,5)))

model.matrix(~ lvl, data = x)[, -1]

iris_na <- iris
iris_na[c(10,20,25,40,32),3] <- NA             
iris_na[c(33,100,123),1] <- NA
iris_na[!complete.cases(iris_na),]

iris_na[is.na(iris_na$Sepal.Length),]

mapply(median, iris_na[1:4], na.rm =TRUE)

install.packages("DMwR")

library(DMwR)
iris_na[!complete.cases(iris_na),]

knnImputation(iris_na[1:4])[c(10,20,25,32,33,40,100,123),]

install.packages("mlbench")
library(caret)
library(mlbench)
data("Soybean")
nearZeroVar(Soybean, saveMetrics = TRUE)

nearZeroVar(Soybean)
Soybean_2 <- Soybean[,2 -nearZeroVar(Soybean)]
Soybean_2

library(mlbench)
library(caret)
data("Vehicle")
findCorrelation(cor(subset(Vehicle, select = -c(Class))))
                
cor(subset(Vehicle, select = -c(Class)))[c(3, 8, 11, 7, 9, 2), c(3, 8, 11, 7, 9, 2)]

Vehicle_2 <- Vehicle[, -c(3,8,11,7,9,2)]


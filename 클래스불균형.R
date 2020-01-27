library(mlbench)
data(BreastCancer)
table(BreastCancer$Class)

x <- upSample(subset(BreastCancer, select=-Class), BreastCancer$Class)
table(BreastCancer$Class)
table(x$Class)

NROW(x)
NROW(unique(x))
library(rpart)
library(party)
data <- subset(BreastCancer, select=-Id)
parts <- createDataPartition(data$Class, p=.8)  
data.train <- data[parts$Resample1,]
data.test <- data[-parts$Resample1, ]
m <- rpart(Class ~., data=data.train)
confusionMatrix(data.test$Class,predict(m, newdata=data.test, type="class"))



data.up.train <- upSample(subset(data.train, select=-Class),
                            data.train$Class)
m <- rpart(Class ~., data=data.up.train)
confusionMatrix(data.test$Class,
                predict(m, newdata=data.test, type="class"))

data(iris)
data <- iris[, c(1, 2, 5)]
data$Species <- factor(ifelse(data$Species == "setosa","rare","common"))
table(data$Species)

library(DMwR)
library(SMOTE)
newData <- SMOTE(Species ~ ., data, perc.over = 600, perc.under=100)
table(newData$Species)

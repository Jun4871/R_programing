str(mtcars)
summary(mtcars)

boxplot(mtcars[, 8:11])

mlmData <- lm(mpg ~ cyl + disp + hp + drat + wt + qsec, data = mtcars)

mlmData

summary(mlmData)

par(mfrow = c(2,2))
plot(mlmData)

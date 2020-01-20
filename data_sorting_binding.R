split(iris, iris$Species)

lapply(split(iris$Sepal.Length, iris$Species), mean)

subset(iris, Species == "setosa")

subset(iris, Species == "setosa" & Sepal.Length > 5.0)

subset(iris, select = c(Sepal.Length, Species))

subset(iris, select = -c(Sepal.Length, Species))

iris[,!names(iris) %in% c("Sepal.Length", "Species")]


x <- data.frame(name= c("a","b","c"), math = c(1,2,3))
y <- data.frame(name= c("c","b","a"), english= c(4,5,6))
merge(x,y)

cbind(x,y)

x <- data.frame(name = c ("a","b","c"),
                math = c(1,2,3))
y <- data.frame(name = c ("a","b","d"),
                english = c(4,5,6))
merge(x,y)
merge(x,y, all=TRUE)


x <- c(20, 11, 33, 50, 47)
sort(x)
sort(x, decreasing = TRUE)
x

x <- c(20, 11, 33, 50, 47)
order(x, decreasing = TRUE)

iris[order(iris$Sepal.Length, iris$Petal.Length),]


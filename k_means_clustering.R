
k_means_iris <- iris[,1:4]

clusters <- kmeans(k_means_iris,3)

table(clusters$cluster,iris$Species)

plot(k_means_iris[c("Petal.Length","Petal.Width")],
     col = clusters$cluster, pch = c(15,16,17)[as.numeric(clusters$cluster)])

points(clusters$centers[,c("Petal.Length","Petal.Width")],col = 1:3, pch = 8, cex =2)


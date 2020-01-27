data1 <- iris$Sepal.Length
data2 <- iris$Sepal.Width
data3 <- iris$Petal.Length
data4 <- iris$Petal.Width
plot(data1)

plot(data1, pch=20)

plot(data1, pch=20, cex=0.5)

plot(data1, pch=20, cex=0.5, type="l")
plot(data1, pch=20, cex=0.5, type="l", xlab="x", ylab="y")
plot(data1, pch=20, cex=0.5, type="l", xlab="x", ylab="y", main="Plot study")
plot(data1, pch=20, cex=0.5, type="l", xlab="x", ylab="y",main = "Plot study");abline(h=5,col="red")
plot(data1, pch=20, cex=0.5, type="l", xlab="x", ylab="y",main ="plot study");abline(v=50,col="red")
plot(x=data4, y=data3, pch=20, cex=0.5, type="p", xlab="x", ylab="y",main ="plot study");abline(lm(data3 ~ data4),col="red")
plot(x=data4, y=data3, pch=20, cex=0.5, type="p", xlab="x", ylab="y",main ="plot study");abline(lm(data3 ~ data4),lty=3,col="red")
par(mfrow=c(1,4))
plot(data1, pch=20, cex=1, type="p", xlab ="x", ylab = "y", main = "Sepal.Length")
plot(data2, pch=20, cex=1, type="p", xlab ="x", ylab = "y", main = "Sepal.Width")
plot(data3, pch=20, cex=1, type="p", xlab ="x", ylab = "y", main = "Petal.Length")
plot(data4, pch=20, cex=1, type="p", xlab ="x", ylab = "y", main = "Petal.Width")

plot(data1, pch=20, cex=1, type="p", xlab ="x", ylab = "y", main = "Sepal.Length")
par(new=T)
plot(data3, pch=20, cex=1, type="p", xlab ="x", ylab = "y", main = "Petal.Length", col="red")


colors(gray60)
plot(data1, pch=20, cex=0.5, type="l", xlab="x", ylab="y",main = "plot study")+abline(a=4.5,b=0.02,col="red")
par(mfrow=c(1,4))
plot(data1, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main="Sepal.Length")
plot(data2, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main="Sepal.Width")
plot(data3, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main="Petal.Length")
plot(data4, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main="Petal.Width")


plot(data1, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main="Sepal.Length")
par(new=TRUE)
plot(data3, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main="Petal.Length", col="red")

plot(data1, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main="",ylim = c(1,7.5))
par(new=T)
plot(data3, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main="",col="red", ylim = c(1,7.5))

png("plot down.png",width = 950, height = 650,unit="px")
par(mfrow=c(1,1))
plot(data1, pch=20, cex=1, type="p",
     xlab="X ", ylab="y ", main="",
     ylim=c(1,7.5))
par(new=TRUE)
plot(data3, pch=20, cex=1, type="p",
     xlab="X ", ylab="y ", main=" ", col="red",
     ylim=c(1,7.5))
dev.off()

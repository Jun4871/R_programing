
library(ggplot2)
qplot( data = mpg, x = hwy )

qplot( data = mpg, x = hwy, y = hwy, geom = "line" )

qplot(data = data = mpg, x = drv, y = hwy, geom = "boxplot")

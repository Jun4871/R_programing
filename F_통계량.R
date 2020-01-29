install.packages("lmPerm")
library(lmPerm)

four_sessions <- read.csv("four_sessions.csv")
summary(aovp(Time ~ Page, data = four_sessions))


summary(aov(Time ~ Page, data = four_sessions))

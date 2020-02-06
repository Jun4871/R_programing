clicks <- read.csv("imanishi_data.csv")
chisq.test(clicks, simulate.p.value = TRUE)

chisq.test(clicks, simulate.p.value = FALSE)


str(clicks)
sum(is.na(clicks))


dim(clicks)
summary(clicks)


fisher.test(clicks)


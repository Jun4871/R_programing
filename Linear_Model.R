head(diamonds)

lmDiamond <- lm(price ~ carat, data = diamonds)

summary(lmDiamond)

par(mfrow <- c(2,2))
plot(lmDiamond)













































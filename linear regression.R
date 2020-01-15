# 선형회귀  (linear regression analysis)

data(cars)

plot(cars)

# linear model
# lm() 함수
# lm("종속변수" ~ "독립변수", data)
# 종속변수 = 쉽게 말해서 Y
# 독립변순 = 쉽게 말해서 X

str(cars)
summary(cars)
sum(is.na(cars))
head(cars)

lm(dist ~ speed, cars)

# intercept
# 절편을 의미

# speed
# 기울기를 의미
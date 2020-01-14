# tidyveret 의 dplyr

library(tidyverse)

iris
summary(iris)

# 종별 평균값 

iris_setosa <- iris[which(iris$Species == "setosa"),]

mean(iris_setosa$Sepal.Length)
mean(iris_setosa$Sepal.Width)

for(i in 1:4) {
  print(mean(iris_setosa[,i]))
}


# %>%  = of 


iris %>% 
  group_by(Species) %>% 
  summarise(Sepal.Width = mean(Sepal.Width))

iris %>% 
  group_by(Species) %>% 
  summarise(sum = sum(Sepal.Width))


# hflights
library(hflights)
# install.packages("hflights")
# -> 항공데이터를 가지고 있는 패키지이다. 

iris_5_index <- iris[,1] > 5
# -> iris의 첫번째 컬럼이 5보다 큰 경우에 대한 명제


# iris_5_index 헁으 true / false
iris[iris_5_index,]

iris_6_index <- iris[,2] > 3
iris[iris_6_index,]

iris_double_index <- iris_5_index & iris_6_index
iris[iris_double_index,]

# in dplyr
iris %>% 
  filter(Sepal.Length > 5)

# 논리 연산자 

# TRUE , FALSE
# & == and
# | == or


TRUE & TRUE
TRUE & FALSE

TRUE | TRUE
TRUE | FALSE

# 1학년, 남자
# 1학년 이면서(and) 남자
# 1학년 또는 남자


iris %>% 
  filter(Sepal.Length > 5 & Sepal.Width > 3)

head(iris)
tail(iris)

iris %>% 
  filter(Petal.Length > 5 & Petal.Width > 2)

iris %>%
  filter(Petal.Length > 5 | Petal.Width > 2)


## select 
iris %>%
  filter(Petal.Length > 5 | Petal.Width > 2) %>% 
  select(Petal.Length,Petal.Width)

iris %>%
  filter(Petal.Length > 5 | Petal.Width > 2) %>%
  select(Petal.Length, Petal.Width, Species)


## arrange 
iris %>%
  filter(Petal.Length > 5 | Petal.Width > 2) %>%
  select(Petal.Length, Petal.Width, Species) %>% 
  arrange(Petal.Length)

iris %>%
  filter(Petal.Length > 5 | Petal.Width > 2) %>%
  select(Petal.Length, Petal.Width, Species) %>% 
  arrange(desc(Petal.Length))


iris %>%
  filter(Petal.Length > 5 | Petal.Width > 2) %>%
  select(Petal.Length, Petal.Width, Species) %>%
  arrange(Petal.Length)

## mutate
iris %>%
  filter(Petal.Length > 5 | Petal.Width > 2) %>%
  mutate(sum = Petal.Length + Petal.Width) %>% 
  select(Petal.Length, Petal.Width, Species,sum ) %>%
  arrange(Petal.Length)


iris %>% 
  filter(Petal.Length > 5 | Petal.Width > 2) %>%
  mutate(sum = Petal.Length + Petal.Width) %>%
  select(Petal.Length, Petal.Width, Species, sum) %>%
  arrange(Petal.Length)


## more than 
# Petal.Length 이 5보다 크고, Petal.Width가 2보다 크고
# Petal.Length 와 Petal.Width를 더한 컬럼을 sum이라 하자.
# Species별 Petal.Length, Petal.Width, sum의 평균을 구해서 

iris %>%
  filter(Petal.Length > 5 & Petal.Width > 2) %>%
  mutate(sum = Petal.Length + Petal.Width) %>%
  group_by(Species) %>% 
  summarise(petal_length_mean = mean(Petal.Length),
            petal_width_mean = mean(Petal.Width),
            sum_mean = mean(sum))


## more than 
# sepal.Length 이 5보다 크고, sepal.Width가 2보다 크고
# sepal.Length 와 sepal.Width를 더한 컬럼을 total_sum이라 하자.
# Species별 sepal.Length, sepal.Width, total_sum의 합계을 구해서

iris %>%
  filter(Sepal.Length > 5 & Sepal.Width > 2) %>%
  mutate(total_sum = Sepal.Length + Sepal.Width) %>%
  group_by(Species) %>% 
  summarise(spedies_sum = sum(Sepal.Length) , 
            spedies_width = sum(Sepal.Width),
            spedies_s = sum(total_sum))


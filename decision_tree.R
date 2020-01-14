library(rpart)
library(rpart.plot)
library(caret)
library(e1071)

# train/test set

plot(cars)
# training set
# 모델을 만드는데 필요한 데이터 

# 1:100
# 70% 트레이닝, 30% 테스트 
# 7:3, 8:2, 7.5:2.5

# data 생성
df <- iris

## sample (무작위 추출)
sample(1:100, 70)
sample(1:nrow(df),nrow(df)*0.7)
sample(1:150,105)

## sort(정렬)
sort(sample(1:100, 70))

# setdiff (집합에 있어서 빼기)
setdiff(1:10,4:5)

# test set
# 모델을 평가 하는데 필요
# train/test sampling
training_sampling <- sort(sample(1:nrow(df),nrow(df)*0.7))
test_sampling <- setdiff(1:nrow(df), training_sampling)

# nrow, ncol
# nrow = number of row
# ncol = number of column

## traing_set, test_set
training_set <- df[training_sampling,]
test_set <- df[test_sampling,]

# 데이터 파악
plot(iris)

# 의사결정나무 모델 사용
# rpart()
# rpart("종속변수" ~ "독립변수", data)
# . = all
# rpart_m <- rpart(Species ~ . , data = training_set)
rpart_m <- rpart(Species ~ Petal.Length + Petal.Width , data = training_set)
rpart_m

# rpart모델 시각화(rpart 기본 패키지)
plot(rpart_m, margin=.2)
text(rpart_m, cex=1.5)

# rpart.plot 사용한 시각화
prp(rpart_m, type=4, extra=2, digits=3)




# 이 모델이 잘 적합 되었나 확인 
# fitted
rpart_f <- predict(rpart_m, type="class")
table(rpart_f, training_set$Species)


# 이 모델을 test셋에다가 했을때 어떤 결과를 나타내는가
rpart_p <- predict(rpart_m, newdata=test_set, type = "class")

table(rpart_p, test_set$Species)
sum(rpart_p == test_set$Species) / nrow(test_set)



# EDA(Exploratory Data Analysis) 
# iris 데이터 불러 오기
iris

## 데이터 파악
str(iris)

# 데이터의 성질 변경 (문자화)
iris$Species
as.character(iris$Species)

## 데이터 요약
summary(iris)

## NA 확인
sum(is.na(iris))

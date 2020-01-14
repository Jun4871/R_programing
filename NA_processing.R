iris_2 <- iris


iris_2[5:7,c(1,3)] <- NA

## NA 확인

is.na(iris_2)

sum(is.na(iris_2))

## 결측치 제거 하는 대표적인 방법 2가지

# 1. 결측치 제거
na.omit(iris_2)

# 2. 평균으로 대치
iris_2$Sepal.Length[5:7] <- mean(iris_2$Sepal.Length, na.rm=TRUE)

# 3. feature(컬럼) 제거
iris_2[5:150,c(1,3)] <- NA
iris_2 <- iris_2[,c(2,4,5)]
# Support Vector Meachin

library(kernlab)
library(caret)

df <- iris


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


# ksvm() 함수
# ksvm(종속변수 ~ 독립변수, data = df)

svm_m <- ksvm(Species ~ Petal.Length + Petal.Width, data = training_set)

svm_p <- predict(svm_m, newdata = test_set)



confusionMatrix(svm_p, test_set$Species)



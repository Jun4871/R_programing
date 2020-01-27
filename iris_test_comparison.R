library(nnet) # Logistic regression, Neural Network
library(rpart) # Decision Tree
library(randomForest) # Random Forest
library(dplyr)
library(caret) # Confusion Matrix
library(DT) # Data visualize
library(class) # KNN
library(ggvis) # Data visualize
library(kernlab) # Support Vector Machine


iris %>% 
  ggvis(~Petal.Length, ~Petal.Width, fill = ~factor(Species)) %>%
  layer_points()
str(iris)
summary(iris)
# data 생성
df <- iris

# seed값 설정
set.seed(919)

# train/test sampling
training_sampling <- sort(sample(1:nrow(df), nrow(df) * 0.7 ))
test_sampling <- setdiff(1:nrow(df),training_sampling)

# traning_set, test_set
training_set <- df[training_sampling,]
test_set <- df[test_sampling,]
multi_logit_m <- multinom(Species ~ Petal.Length + Petal.Width, data = training_set)
multi_logit_p <- predict(multi_logit_m, newdata = test_set, type = "class")
rpart_m <- rpart(Species ~ Petal.Length + Petal.Width, data = training_set)

rpart_p <- predict(rpart_m, newdata = test_set, type = "class")

rf_m <- randomForest(Species ~ Petal.Length + Petal.Width, data = training_set)

rf_p <- predict(rf_m, newdata = test_set, type = "class")
nnet_m <- nnet(Species ~ Petal.Length + Petal.Width , data = training_set, size = 3)
nnet_p <- predict(nnet_m, newdata = test_set, type = "class")
svm_m <- ksvm(Species ~ Petal.Length + Petal.Width , data = training_set)

svm_p <- predict(svm_m, newdata = test_set)
#정규화함수
normalizer <- function(x) {
  return_value <- (x - min(x)) / (max(x) - min(x))
  return(return_value)
}

normal_iris <- sapply(iris[,1:4] , normalizer) %>% 
  as.data.frame()

# data 생성
df <- cbind(normal_iris, "Species" = iris[,5])

# train/test sampling
# training_sampling <- sort(sample(1:nrow(df), nrow(df) * 0.7 ))
# test_sampling <- setdiff(1:nrow(df),training_sampling)

# traning_set, test_set
training_set <- df[training_sampling,]
test_set <- df[test_sampling,]

training_set_unlable <- training_set[,1:4]
training_set_lable <- training_set[,5]


test_set_unlable <- test_set[,1:4]
test_set_lable <- test_set[,5]

knn_p <- knn(train = training_set_unlable, test = test_set_unlable, cl = training_set_lable, k = 3)

model_list <- cbind(
  as.character(multi_logit_p), 
  as.character(rpart_p), 
  as.character(rf_p),
  as.character(nnet_p),
  as.character(svm_p),
  as.character(knn_p)) %>%
  as.data.frame()

# str(model_list)

total_model_accuracy <- data.frame()
for (model in model_list[,1:ncol(model_list)]) {
  model_cm <- confusionMatrix(model, test_set$Species)
  model_cm_class <- model_cm$byClass %>% as.data.frame()
  model_accuracy <- model_cm_class$`Balanced Accuracy`
  total_model_accuracy <- rbind(total_model_accuracy, model_accuracy)
}



colnames(total_model_accuracy) <- levels(test_set$Species)

rownames(total_model_accuracy) <- c("Logistic Regression", "Decision Tree", "Random Forest", "Neural Network", "Support Vector Machine", "KNN")
datatable(total_model_accuracy)


install.packages("xgboost")
library(xgboost)
loan3000 <- read.csv("loan3000.csv")
predictors <- data.matrix(loan3000[, c('borrower_score',
                                       'payment_inc_ratio')])
label <- as.numeric(loan3000[, 'outcome'])-1
xgb <- xgboost(data = predictors, label = label, 
               objective = "binary:logistic",
               params = list(subsample=.63, eta=0.1), nrounds=100)

pred <- predict(xgb, newdata = predictors)
xgb_df <- cbind(loan3000, pred_default=pred>.5, prob_default=pred)
ggplot(data = xgb_df, aes(x=borrower_score, y=payment_inc_ratio,
                          color=pred_default, shape=pred_default))+
  geom_point(alpha=.6, size=2)


predictors <- data.matrix(loan_data[, -which(names(loan_data) %in% 'outcome')])
label <- as.numeric(loan_data$outcome)-1
test_idx <- sample(nrow(loan_data), 10000)
xgb_default <- xgboost(data = predictors[-test_idx,],
                       label = label[-test_idx],
                       objective = "binary:logistic", nrounds = 250)
pred_default <- predict(xgb_default, predictors[test_idx,])
error_default <- abs(label[test_idx] - pred_default) > 0.5
xgb_default$evaluation_log[250,]
mean(error_default)
#####
xgb_penalty <- xgboost(data = predictors[-test_idx,],
                      label = label[-test_idx],
                      params = list(eta=.1, subsample=.63, lamda=1000),
                      objective ="binary:logistic", nrounds = 250)
pred_penalty <- predict(xgb_penalty, predictors[test_idx,])
error_penalty <- abs(label[test_idx]- pred_penalty) > 0.5
xgb_penalty$evaluation_log[250,]
mean(error_penalty)
###

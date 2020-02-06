N <- nrow(loan_data)
fold_number <- sample(1:5, N, replace = TRUE)
params <- data.frame(eta = rep(c(.1, .5, .9), 3),
                     max_depth = rep(c(3, 6, 12), rep(3,3)))


error <- matrix(0, nrow = 9, ncol = 5)
for (i in 1:nrow(params)){
  for (k in 1:5) {
    fold_idx <- (1:N)[fold_number == k]
    xgb <- xgboost(data = predictors[-fold_idx,], label = label[-fold_idx],
                   params = list(eta = params[i, 'eta'],
                                 max_depth = params[i, 'max_depth']),
                   objective = "binary:logistic", nrounds = 100, verbose = 0)
    pred <- predict(xgb, predictors[fold_idx,])
    error[i,k] <- mean(abs(label[fold_idx]-pred) >= 0.5)}}


avg_error <- 100 * rowMeans(error)
cbind(params, avg_error)


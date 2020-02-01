library(rpart)
loan_data <- read.csv("loan_data.csv")
loan_tree <- rpart(outcome ~ borrower_score + payment_inc_ratio, data = loan_data, control = rpart.control(cp=.005))
plot(loan_tree, uniform = TRUE, margin = .05)
text(loan_tree)


library(randomForest)
loan3000 <- read.csv("loan3000.csv")
rf <- randomForest(outcome ~ borrower_score + payment_inc_ratio,
                   data = loan3000)

error_df = data.frame(error_rate = rf$err.rate[,'OOB'],
                      num_trees = 1:rf$ntree)
ggplot(error_df, aes(x=num_trees, y=error_rate)) +
  geom_line()


library(ggplot2)

pred <- predict(loan_lda)
scale_shap

rf_all <- randomForest(outcome ~ ., data = loan_data, importance = TRUE)

varImpPlot(rf_all, type = 1)
varImpPlot(rf_all, type = 2)

## 여기는 제외해서 commit 해야함 
session_time <- read.csv("web_page_data.csv")
ggplot(session_time, aes(x=Page, y= Time)) +
  geom_boxplot()
mean_a <- mean(session_time[session_time['Page']=='Page A', 'Time'])
mean_b <- mean(session_time[session_time['Page']=='Page B', 'Time'])
mean_b - mean_a

perm_fun <- function(x, n1, n2)
{
  n <- n1 + n2
  idx_b <- sample(1:n,n1)
  idx_a <- setdiff(1:n, idx_b)
  mean_diff <- mean(x[idx_b]) - mean(x[idx_a])
  return(mean_diff)
}

perm_diffs <- rep(0, 1000)
for(i in 1:1000)
perm_diffs[i] = perm_fun(session_time[,'Time'], 21, 15)  
hist(perm_diffs, xlab = 'Session time differences (in seconds)')
abline(v= mean_b - mean_a)

t.test(Time ~ Page, data = session_time, alternative = 'less')

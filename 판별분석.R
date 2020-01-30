install.packages("MASS")
library(MASS)
loan3000 <- read.csv("loan_data.csv")
loan_lda <- lda(outcome ~ borrower_score + payment_inc_ratio, data = loan3000)
loan_lda$scaling


pred <- predict(loan_lda)
head(pred$posterior)


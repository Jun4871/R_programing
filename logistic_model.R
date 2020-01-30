logistic_model 
loan_data <- read.csv("loan_data.csv")
logistic_model <-glm(formula = outcome ~ payment_inc_ratio + purpose_ + home_ + emp_len_ + borrower_score, family ="binomial", data = loan_data )
pred <- predict(logistic_model)
summary(pred)

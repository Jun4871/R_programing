install.packages("klaR")
library(klaR)
loan_data<-read.csv("loan_data.csv")
naive_model <- NaiveBayes(outcome ~ purpose_ + home_ + emp_len_, data =na.omit(loan_data))

naive_model$tables



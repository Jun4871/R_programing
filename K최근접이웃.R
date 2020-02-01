install.packages("FNN")
library(FNN)
loan200 <-read.csv("loan200.csv")
newloan <- loan200[1, 2:3, drop = FALSE]
knn_pred <- knn(train = loan200[-1, 2:3], test = newloan,cl = loan200[-1,1], k=20 )
knn_pred == 'paid off'
###### 표준화 그러나 안됨
loan_df <- model.matrix(~ -1 + payment_inc_ratio + dti + revol_bal + revol_util, data = loan_data)
knn_pred <- knn(train = loan_df, test = newloan, cl= outcome, k=5)

## KNN을 통한 피처 엔지니어링
loan_data <- read.csv("loan_data.csv")
borrow_df <- model.matrix(~ -1 + dti + revol_bal + revol_util + open_acc + 
                            delinq_2yrs_zero + pub_rec_zero, data=loan_data)
borrow_knn <- knn(borrow_df, test=borrow_df, cl=loan_data[, 'outcome'], 
                  prob = TRUE, k=10)
prob <- attr(borrow_knn, "prob")
borrow_feature <- ifelse(borrow_knn == 'default', prob, 1-prob)
summary(borrow_feature)

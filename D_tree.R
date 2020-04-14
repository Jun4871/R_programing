df <- iris
train_df <- df[c(1:35, 51:85, 101:135),]
test_df <- df[c(36:50, 86:100, 136:150),]

str(train_df)

str(test_df)

install.packages("tree")

library(tree)

tree_df <- tree(Species ~., data=train_df)

tree_df

summary(tree_df)

plot(tree_df)
text(tree_df)

library(caret)

library(e1071)

pred_tree <- predict(tree_df, test_df, type = "class")

confusionMatrix(pred_tree, test_df$Species)

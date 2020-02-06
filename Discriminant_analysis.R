install.packages("MASS")
library(MASS)
loan3000 <- read.csv("loan_data.csv")
loan_lda <- lda(outcome ~ borrower_score + payment_inc_ratio, data = loan3000)
loan_lda$scaling


pred <- predict(loan_lda)
head(pred$posterior)

install.packages("ggplot")
install.packages("geom")
library(ggplot)
library(geom)
geom_pi

lda_df <- cbind(loan3000, prob_default = pred$posterior[, 'default'])
ggplot2(data = lda_df,
        aes( x=borrower_score, y=payment_inc_ratio, color=prob_default)) +
  geom_point(alpha=.6) +
  scale_color_gradient2(low='white',high='blue') +
  geom_line(data=lda_df0, col = 'green', size=2, alpha= .8)

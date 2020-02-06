table(c("a","b","b","b","c","c","d"))


d <- data.frame(x=c("1","2","2","1"),
                y=c("A","B","A","B"),
                num = c(3,5,8,7))
xt  <- (xtabs(num ~ x + y, data = d))

(d2 <- data.frame(x=c("A","A","A","B","B")))
(xtabs(~x, d2))


xt

margin.table(xt,2)

margin.table(xt)


xt
prop.table(xt,1)
prop.table(xt,2)
prop.table(xt)

install.packages("MASS::servey")
library(MASS)
data(survey)
str(servey)


library(MASS)
data(survey)
str(survey)

head(survey[c("Sex","Exer")])

xtabs(~Sex + Exer, data = survey)

chisq.test(xtabs(~ Sex + Exer, data=survey))


xtabs(~ W.Hnd + Clap, data = survey)

chisq.test(xtabs(~ W.Hnd + Clap, data = survey))

fisher.test(xtabs(~ W.Hnd + Clap, data = survey))

performance <-
  matrix(c(794,86,150,570),
         nrow = 2,
         dimnames = list(
           "1st Survey" = c("Approve", "Disapprove"),
           "2nd Survey" = c("Approve", "Disapprove")))
performance
mcnemar.test(performance)

binom.test(86, 86+150, .5)

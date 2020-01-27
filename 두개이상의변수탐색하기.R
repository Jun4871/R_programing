kc_tax <- read.csv("kc_tax.csv")
library(tidyverse)
kc_tax0 <- subset(kc_tax, TaxAssessedValue < 750000 & SqFtTotLiving > 100 & SqFtTotLiving <3500)
nrow(kc_tax0)


#kc_tax0 %>% filter()
s#tr(kc_tax0)

ggplot(kc_tax0, (aes( x = SqFtTotLiving, y = TaxAssessedValue ))) +
stat_binhex(colour = "white") +
theme_bw() +
scale_fill_gradient(low ="white", high = "red") +
labs(x="Finished Square Feet", y = "Tax Assessed Value")

ggplot(kc_tax0, aes(SqFtTotLiving, TaxAssessedValue )) +
  theme_bw() +
  geom_point( alpha = 0.1) +
  geom_density2d(colour = "blue") +
  labs(x="Finished Square Feet", y = "Tax Assessed Value")
#######

install.packages("descr")
lc_loans<-read_csv("lc_loans.csv")
library(descr)  
x_tab <- CrossTable(lc_loans$grade, lc_loans$status,
                     prop.c=FALSE, prop.chisq=FALSE, prop.t=FALSE)


x_tab 
###########

library(tidyverse)
airline_stats<-read_csv("airline_stats.csv") 
boxplot(pct_carrier_delay ~ airline, data = airline_stats, ylim=c(0, 50))


ggplot(data = airline_stats, aes(airline, pct_carrier_delay))+
  ylim(0, 50) +
  geom_violin()  +
  labs(x="", y="Daily % of Delayed Flights")
str(airline_stats)



ggplot(subset(kc_tax0, ZipCode %in% c(98188, 98105, 98108, 98126)),
       aes(x = SqFtTotLiving, y = TaxAssessedValue))+
       stat_binhex(colour = "white")+
         theme_bw()+
         scale_fill_gradient(low = "white", high = "blue")+
         labs(x = "Finished Square Feet", y = "Tax Assessed Value" )+
         facet_wrap("ZipCode")

kc_tax0 <- read.csv("kc_tax.csv")
library(tidyverse)
# kc_tax0 <- subset(kc_tax, TaxAssessedValue < 750000 & SpFtTotLiving > 100 & SqFtTotLiving<3500)

kc_tax0 %>% filter()

str(kc_tax0)

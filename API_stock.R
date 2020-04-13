ecars <- read.csv("cars.csv", header = T, stringsAsFactors = FALSE, fileEncoding = "euc-kr")

summary(ecars)

str(ecars)

df_add <- as.data.frame(ecars[, 14])
names(df_add) <- c("address")

df_add

df_add <- subset(df_add, subset = (address != ''))

str(df_add)

df_add$address <- as.character(df_add$address)

spamD <- read.table("spamD.tsv", header = TRUE, sep = "\t")

spamTrain <- subset(spamD, spamD$rgroup>=10)

spamTest <- subset(spamD, spamD$rgroup<10)

spamVars <- setdiff(colnames(spamD), list("rgroup", "spam"))

spamFormula <- as.formula(paste('spam == "spam"',
                                paste(spamVars, collapse = "+"), sep = "~"))


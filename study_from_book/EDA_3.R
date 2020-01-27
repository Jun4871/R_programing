state <- read.csv("state.csv")
mean(state[["Population"]])
mean(state[["Population"]], trim = 0.1)
median(state[["Population"]])


weighted.mean(state[["Murder.Rate"]], w = state [["Population"]])

library("matrixStats")
weightedMedian(state[["Murder.Rate"]], w=state[["Population"]])

sum_to_n <- function(n) {
  sum <- 0
  for (i in 1:n) {
    sum <- sum + i
  }
  return(sum)
}
system.time(sum_to_n(10000))
system.time(sum_to_n(100000))
system.time(sum_to_n(1000000))

x <- matrix(1:(10000*10000), ncol = 10000)
system.time(save(x, file = "x.RData"))


add_one <- function(val) {
  return(val + 1)
}

add_one_to_vec <- function(x) {
  for (i in seq_along(x)) {
    x[i] <- add_one(x[i])
  }
  return(x)
}

Rprof("add_one_out")
x <- add_one_to_vec(1:1000000)
head(x)
Rprof(NULL)

summaryRprof("add_one_out")

summaryRprof("add_one_out")$by.self

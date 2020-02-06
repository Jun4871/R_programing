perm_fun <- function(x, n1, n2)
{
  n <- n1 + n2
  idx_b <- sample(1:n, n1)
  idx_a <- setdiff(1:n, idx_b)
  mean_diff <- mean(x[idx_b]) - mean(x[idx_a])
  return(mean_diff)
}


obs_pct_diff <- 100*(200/23739 - 182/22588)
conversion <- c(rep(0, 45945), rep(1, 382))
perm_diffs <- rep(0,100)
for(i in 1:1000)
  perm_diffs[i] = 100*perm_fun(conversion, 23739, 22588)
hist(perm_diffs, xlab = 'Conversion rate (percent)', main ='')
abline(v = obs_pct_diff, lty = 2, lwd= 1.5)
text(" Observed\n differnce", x = obs_pct_diff, y=par()$usr[4]-20, adj=0)

mean(perm_diffs > obs_pct_diff)

prop.test(x = c(200,182), n=c(23739,22588), alternative = "greater")

state <- read.csv("state.csv")
quantile(state[["Murder.Rate"]], p = c(.05, .25, .5, .75, .95))
boxplot(state[["Population"]]/1000000, ylab = "Population(millions)")
breaks <- seq(from = min(state[["Population"]]),
              to=max(state[["Population"]]), length = 11)
pop_freq <- cut(state[["Population"]], breaks = breaks,
                right = TRUE, include.lowest = TRUE)
table(pop_freq)
hist(state[["Population"]], breaks = breaks)
hist(state[["Murder.Rate"]], freq = FALSE)
lines(density(state[["Murder.Rate"]]), lwd = 3, col= "blue")

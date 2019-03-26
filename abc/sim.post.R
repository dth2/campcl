library("methods")
suppressMessages(library("EpiABC"))
suppressMessages(library("EpiModel"))

x <- readRDS(file = "data/abc.wave9.rda")

plot(density(x$cwave$tab_param))

par(mfrow = c(1,2))
plot(density(x$cwave$tab_param[, 1]))
plot(density(x$cwave$tab_param[, 2]))

library(MASS)
kde1 <- kde2d(x$cwave$tab_param[,1], x$cwave$tab_param[,2], n = x$cwave$k_acc)
par(mar = c(3,3,2,1), mgp = c(2,1,0), mfrow = c(1,1))
image(kde1, col = heat.colors(100), ylab = "Recovery Rate",
      xlab = "Infection Probability")

kde1.max <- kde1$z == max(kde1$z)
kde1.row <- which.max(rowSums(kde1.max))
kde1.col <- which.max(colSums(kde1.max))
bestfit1 <- c(kde1$x[kde1.row], kde1$y[kde1.col])
bestfit1
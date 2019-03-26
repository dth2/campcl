
library("methods")
suppressMessages(library("EpiModel"))
suppressMessages(library("EpiModelHIV"))

setwd("/homes/dth2/Campcl/scenarios")

load("refit/est/fit_adj.rda")

for (i in 1:4){
est[[i]]$fit$newnetworks <- est[[i]]$fit$newnetwork <- est[[i]]$fit$sample <- NULL
}


save(est, file = "/homes/dth2/Campcl/scenarios/abc/est.rda")
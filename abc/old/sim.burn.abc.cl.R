
rm(list = ls())
library("methods")
library("EpiModelHIV")
library("doParallel")
library("foreach")
library("EasyABC")

#system("hyak:/gscratch/csde/deven/Camp/scenarios")


f <- function(x) {

  set.seed(x[1])

  suppressMessages(library("EpiModelHIV"))

  load("est/fit.rda")
  load("est/nwstats.rda")
  #load("~/Campcl/scenarios/est/fit.rda")
  #load("~/Campcl/scenarios/est/nwstats.rda")
  
  param <- param_cl(nwstats = st,

                     ai.pers.scale = x[2],
                     ai.asmm.scale = x[3],
                     cond.asmm.BB.prob = x[4],
                     cond.asmm.BW.prob = x[4],
                     cond.asmm.WW.prob = x[4])

  init <- init_cl(nwstats = st,
                  prev.B = 0.18,
                  prev.W = 0.18,
                  prev.asmm = 0.045)

  control <- control_cl(simno = 1,
                         nsteps = 7000,
                         nsims = 1, ncores = 1,
                         verbose = FALSE)

  sim <- netsim(est, param, init, control)

  df <- tail(as.data.frame(sim), 156)

  prev.msm <- mean(df$i.prev.msm)
  prev.age18 <- mean(df$i.prev.age18)

  out <- c(prev.msm, prev.age18)

  return(out)
}

priors <- list(c("unif", 1.0, 2.0),
               c("unif", 4.0, 11.0),
               c("unif", 0.01, 0.4))


targets <- c(.283, 0.07)

( nsim <- as.numeric(Sys.getenv("NSIM")) )
( pacc <- as.numeric(Sys.getenv("PACC")) )

a <- ABC_sequential(method = "Lenormand",
                    model = f,
                    prior = priors,
                    nb_simul = nsim,
                    summary_stat_target = targets,
                    p_acc_min = pacc,
                    progress_bar = TRUE,
                    n_cluster = 16,
                    use_seed = TRUE,
                    verbose = FALSE)

fn <- paste0("data/clR.", pacc*100, "pct.", nsim, "sim.rda")
save(a, file = fn)

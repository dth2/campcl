
library("methods")
suppressMessages(library("EpiABC"))
suppressMessages(library("EpiModel"))
suppressMessages(library("EpiModelHIV"))
setwd("/homes/dth2/Campcl/scenarios/abc")



# Main Model Fx -----------------------------------------------------------

myfunc <- function(x) {
  
  set.seed(x[1])
  require(EpiModelHIV)
  load("est/est.rda")
  load("est/nwstats.rda")
  
  param <- param_cl(nwstats = st, ai.inst.scale = x[2], ai.asmm.scale = x[3],
                    cond.asmm.BB.prob = x[4], cond.asmm.BW.prob = x[4], cond.asmm.WW.prob = x[4])
  init <- init_cl(nwstats = st, prev.B = 0.18, prev.W = 0.18, prev.asmm = 0.045)
  control <- control_cl(nsteps = 300, nsims = 1,verbose = FALSE)
  mod <- netsim(est, param, init, control)
  df <- tail(as.data.frame(mod), control$nsteps/10)
  
  prev.msm <- mean(df$i.prev.msm)
  prev.age18 <- mean(df$i.prev.age18)
  
  out <- c(prev.msm, prev.age18)
  
  return(out)
}

# ABC Priors and Target Stats ---------------------------------------------

priors <- list(c("unif", 1.0, 10.0),
               c("unif", 1.0, 10.0),
               c("unif", 0.001, 0.5))

##SET REAL TARGETS
prev.targ <- c(.30, 0.055)

# Run ABC Prep ------------------------------------------------------------

prep <- abc_smc_prep(model = myfunc,
                     prior = priors,
                     nsims = 500,
                     summary_stat_target = prev.targ,
                     ncores = 16,
                     alpha = 0.2)
prep
saveRDS(prep, file = "data/abc.prep.rda")

#debugonce(sbatch_master_abc)
sbatch_master_abc(prep,
                  master.file = "master.sh",
                  nwaves = 10, ckpt = TRUE)

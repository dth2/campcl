#!/bin/bash


#qsub -q batch -m ae -v NSIM=10,PACC=0.10 runsim.burn.abc.cl.sh
#qsub -q batch -m ae -v NSIM=10,PACC=0.20 runsim.burn.abc.cl.sh
#qsub -q batch -m ae -v NSIM=10,PACC=0.30 runsim.burn.abc.cl.sh
qsub -q batch -m ae -v NSIM=8,PACC=0.10 runsim.burn.abc.cl.sh
qsub -q batch -m ae -v NSIM=8,PACC=0.20 runsim.burn.abc.cl.sh
qsub -q batch -m ae -v NSIM=8,PACC=0.30 runsim.burn.abc.cl.sh
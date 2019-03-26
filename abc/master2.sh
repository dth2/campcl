#!/bin/bash

sbatch -p ckpt -A csde-ckpt --array=1-3 --job-name=wave0 --export=ALL,wave=0  --ntasks-per-node=8 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-2 --job-name=wave1 --export=ALL,wave=1 --depend=afterany:$(squeue --noheader --format %i --name wave0) --ntasks-per-node=8 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-2 --job-name=wave2 --export=ALL,wave=2 --depend=afterany:$(squeue --noheader --format %i --name wave1) --ntasks-per-node=8 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-2 --job-name=wave3 --export=ALL,wave=3 --depend=afterany:$(squeue --noheader --format %i --name wave2) --ntasks-per-node=8 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-2 --job-name=wave4 --export=ALL,wave=4 --depend=afterany:$(squeue --noheader --format %i --name wave3) --ntasks-per-node=8 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-2 --job-name=wave5 --export=ALL,wave=5 --depend=afterany:$(squeue --noheader --format %i --name wave4) --ntasks-per-node=8 --mem=55G --time=1:00:00 runsim.sh

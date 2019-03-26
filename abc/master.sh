#!/bin/bash

sbatch -p ckpt -A csde-ckpt --array=1-32 --job-name=wave0 --export=ALL,wave=0  --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave1 --export=ALL,wave=1 --depend=afterany:$(squeue --noheader --format %i --name wave0) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave2 --export=ALL,wave=2 --depend=afterany:$(squeue --noheader --format %i --name wave1) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave3 --export=ALL,wave=3 --depend=afterany:$(squeue --noheader --format %i --name wave2) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave4 --export=ALL,wave=4 --depend=afterany:$(squeue --noheader --format %i --name wave3) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave5 --export=ALL,wave=5 --depend=afterany:$(squeue --noheader --format %i --name wave4) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave6 --export=ALL,wave=6 --depend=afterany:$(squeue --noheader --format %i --name wave5) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave7 --export=ALL,wave=7 --depend=afterany:$(squeue --noheader --format %i --name wave6) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave8 --export=ALL,wave=8 --depend=afterany:$(squeue --noheader --format %i --name wave7) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave9 --export=ALL,wave=9 --depend=afterany:$(squeue --noheader --format %i --name wave8) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh
sbatch -p ckpt -A csde-ckpt --array=1-25 --job-name=wave10 --export=ALL,wave=10 --depend=afterany:$(squeue --noheader --format %i --name wave9) --ntasks-per-node=16 --mem=55G --time=1:00:00 runsim.sh

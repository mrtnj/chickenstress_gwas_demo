#!/bin/bash

## Run genome scan with GEMMA

cd gwas

gemma -bfile f2 \
      -k output/f2.sXX.txt \
      -c ../data/plink/sex_covariate.txt \
      -lmm 4 \
      -o f2
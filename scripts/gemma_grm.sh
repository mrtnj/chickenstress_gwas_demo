#!/bin/bash

## Construct genomic relationship matrix with GEMMA

cd gwas

gemma -bfile f2 \
      -gk 2 \
      -o f2

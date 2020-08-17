#!/bin/bash

## Convert plink text file to binary file for GEMMA

if [ ! -d gwas ]; then
    mkdir gwas
fi

plink --file data/plink/f2 \
      --make-bed \
      --out gwas/f2
# Demo of genome-wide association for ChickenStress workshop 2020-08-25


## Simulated data

* data/ -- Directory with simulated data

* R/simulate_data.R -- Simulation code to generate the data


## (Minimal) soundness check of the data

* Rmd/qc.Rmd -- quick check of genotype and phenotype data


## GWAS with GEMMA

* scripts/set_tool_paths.sh -- Set paths for GEMMA (specific to my computer; not needed if you have paths set)

* scripts/gemma_grm.sh -- Construct genomic relationship matrix

* scripts/gemma_gwas.sh -- Run GWAS


## GWAS results

* Rmd/gwas.Rmd -- Make a Manhattan and quantile-quantile plot


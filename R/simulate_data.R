
## Generate a simple simulated GWAS dataset to analyse

library(AlphaSimR)


## Create founders from two populations that split 100 generations ago

founder_population <- runMacs(nChr = 20,
                              nInd = 20,
                              split = 100)


## Set up a quantitative trait and a SNP chip

simparam <- SimParam$new(founder_population)
simparam$addTraitA(5)
simparam$setGender("yes_sys")
simparam$addSnpChip(1000)


## Cross the founders to get an F1 and F2

founders <- newPop(founder_population,
                   simParam = simparam)

f1 <- c(randCross2(males = founders[1:10],
                   females = founders[11:20],
                   nCrosses = 10,
                   nProgeny = 10,
                   simParam = simparam),
        randCross2(males = founders[11:20],
                   females = founders[1:10],
                   nCrosses = 10,
                   nProgeny = 10,
                   simParam = simparam))

f2 <- randCross2(males = f1,
                 females = f1,
                 nCrosses = 100,
                 nProgeny = 10,
                 simParam = simparam)


## Add trait values

## Aim for a heritability of 0.6 after accounting for sex

varG_f2 <- as.numeric(varG(f2))
varE_f2 <- varG_f2 / 0.6 - varG_f2

f2_pheno <- setPheno(f2, varE = varE_f2,
                     simParam = simparam)

## Add a sex effect

f2_pheno@pheno[, 1] <- f2_pheno@pheno[,1] + 
    as.numeric(f2_pheno@gender == "M") * as.numeric(varP(f2_pheno)) / 0.25



## Write out data


## Plink data and covar file for GEMMA

writePlink(pop = f2_pheno,
           baseName = "data/plink/f2",
           simParam = simparam)


covar <- model.matrix(~ f2@gender)

write.table(covar,
            file = "data/plink/sex_covariate.txt",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE,
            sep = "\t")


## Text data for exploration

combined <- c(founders,
              f1,
              f2_pheno)

ped <- data.frame(id = combined@id,
                  father = combined@father,
                  mother = combined@mother,
                  sex = combined@gender,
                  population = c(rep("founder1", 10),
                                 rep("founder2", 10),
                                 rep("F1", f1@nInd),
                                 rep("F2", f2@nInd)),
                  stringsAsFactors = FALSE)

geno <- data.frame(id = combined@id,
                   pullSnpGeno(combined,
                               simParam = simparam))


pheno <- data.frame(id = combined@id,
                    trait = combined@pheno[1],
                    stringsAsFactors = FALSE)


write.table(ped,
            file = "data/txt/ped.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)

write.table(geno,
            file = "data/txt/geno.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)

write.table(pheno,
            file = "data/txt/pheno.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)




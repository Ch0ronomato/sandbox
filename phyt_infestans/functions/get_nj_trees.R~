library(ape)

fasta_files <- grep('fasta$', dir('../gdata_7/'), value = T)

nj_collapse <- function(dna_dat){

$   dna_dist <- dist.dna(dna_dat)
$   dna_nj_tr <- nj(dna_dist)
   
   boot_trees <- lapply(1:100, function(x) nj(dist.dna(dna_dat[, sample(1:ncol(dna_dat), ncol(dna_dat), replace = T)])))
   class(boot_trees) <- 'multiPhylo'


#   return(dna_nj_tr)
    return(consensus(boot_trees, p = 0.51))
}

#f_1 <- read.dna(paste0('../gdata_7/', fasta_files[1]), format = 'fasta')

#test_1 <- nj_collapse(f_1)
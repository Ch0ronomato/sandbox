library(ape)
library(phangorn)

for(i in dir('functions', pattern = 'R$')){
      print(paste('load', i))
  source(paste0('functions/', i))
}


fasta_files <- grep('.FASTA$', dir(), value = T)

trees_poly <- list()

for(i in 1:length(fasta_files)){
  f_temp <- read.dna(fasta_files[i], format = 'fasta')
#  di_temp <- as.matrix(dist.hamming(phyDat(f_temp)))
#  di_vec <- sum(di_temp[lower.tri(di_temp)] == 0)
  di_temp <- dist.hamming(phyDat(f_temp))
  nj_temp <- nj(di_temp)

  if(sum(nj_temp$edge.length == 0) < 25){
    nj_poly <- nj_collapse(f_temp)
    trees_poly[[length(trees_poly) + 1]] <- nj_poly
    names(trees_poly)[length(trees_poly)] <- fasta_files[i]
  }else{
    next
  }
  
}

class(trees_poly) <- 'multiPhylo'

write.tree(trees_poly, file = 'filtered_br_poly.trees', tree.names = T)

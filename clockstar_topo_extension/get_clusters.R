library(phangorn)
library(ClockstaR2)


# STEPS FOR CLOCKSTAR T
# Estimate trees for all data sets. Save them in a file and in a list-> get_topo_trees with options for nj and ml in the future
# get distance between all pairs of trees
# Run gap clustering with clara


# get trees

files.path <- 'sim_k_2/'

fasta.names <- paste0(files.path, grep('.fasta', dir(files.path), value = T))

nj_trees <- list()

for(i in 1:length(fasta.names)){

      print(paste('running', fasta.names[i]))

      seq_temp <- phyDat(read.dna(fasta.names[i], format = 'fasta'))
      dist_temp <- tryCatch(dist.ml(seq_temp), error = function(x) return('error estimating distance'))
      if(is.character(dist_temp)){
        next
      }else{
         nj_temp <- NJ(dist_temp)
	 plot(nj_temp, edge.width = 2)
	 nj_trees[[i]] <- nj_temp
      }
}

names(nj_trees) <- gsub('[.]fasta', '', fasta.names)
names(nj_trees) <- gsub('^.+/', '', names(nj_trees))
class(nj_trees) <- 'multiPhylo'


topo.matrix <- function (tree.list){
    d.mat <- matrix(NA, nrow = length(tree.list), ncol = length(tree.list))
    rownames(d.mat) <- names(tree.list)
    colnames(d.mat) <- names(tree.list)
    print('Estimating tree distances')
    if(length(tree.list) > 3){
      for(i in 2:length(tree.list)){
        dist_temp <- sapply(tree.list[1:i-1], function(x) dist.topo(x, tree.list[[i]], method = 'PH85'), USE.NAMES = F)
	d.mat[i, 1:length(dist_temp)] <- dist_temp
	#print(length(dist_temp))
      }

     }else if (length(tree.list) <= 3){
        stop("The number of gene trees is <= 3. ClockstaR requires at least gene 4 trees")
    }
    # MODIFY THE OUTPUT TO PRINT AN OBJECT OF THE SAME CLASS AND STRUCTURE AS 
    return(d.mat)
}

dist_test <- topo.matrix(nj_trees) / nrow(nj_trees[[1]]$edge)
hist(dist_test, breaks = 100, col = 3)


mds_test <- cmdscale(as.dist(dist_test), k = 2, eig = F)

clust_1 <- clusGap(mds_test, clara, B = 10, K.max = 50)
pm1 <- pam(mds_test, k = 2)	  
plot(mds_test, pch = 20, col = pm1$clustering, cex = 2)
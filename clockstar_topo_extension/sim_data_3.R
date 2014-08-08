library(phangorn)
library(TreeSim)

# Simulate trees
# simulate genes
# Estimates trees
# Recover topology clusters

# Try on complete mammalian data set

# 1. three 'gene trees'  two pacemakers per gene tree, different rates for all genes

set.seed(6137525)
tr_sim_1 <- sim.bd.taxa.age(n = 20, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 100, mrca = FALSE)[[1]]
tr_sim_1$edge.length <- tr_sim_1$edge.length * (100 / max(branching.times(tr_sim_1)) )

set.seed(666)
tr_sim_2 <- rNNI(tr_sim_1, moves = 5)
tr_sim_2$edge.length <- tr_sim_2$edge.length * (100 / max(branching.times(tr_sim_2)) )

set.seed(777)
tr_sim_3 <- rNNI(tr_sim_2, moves = 5)
tr_sim_3$edge.length <- tr_sim_3$edge.length * (100 / max(branching.times(tr_sim_3)) )

# simulating four pacemkers. Two per tree

pm1 <- rlnorm(n = 38, log(0.001), 0.5)
pm2 <- rlnorm(n = 38, log(0.001), 0.5)
pm3 <- rlnorm(n = 38, log(0.001), 0.5)
pm4 <- rlnorm(n = 38, log(0.001), 0.5)
pm5 <- rlnorm(n = 38, log(0.001), 0.5)
pm6 <- rlnorm(n = 38, log(0.001), 0.5)

pms <- list(pm1, pm2, pm3, pm4, pm5, pm6)

if(T){
par(mfrow = c(2, 3))
tr_sim_1_pm1 <- tr_sim_1
tr_sim_1_pm1$edge.length <- tr_sim_1_pm1$edge.length * pm1
plot(tr_sim_1_pm1, edge.width = 2, cex = 1.5)

tr_sim_1_pm2 <- tr_sim_1
tr_sim_1_pm2$edge.length <- tr_sim_1_pm2$edge.length * pm2
plot(tr_sim_1_pm2, edge.width = 2, cex = 1.5)

tr_sim_2_pm3 <- tr_sim_2
tr_sim_2_pm3$edge.length <- tr_sim_2_pm3$edge.length * pm3
plot(tr_sim_2_pm3, edge.width = 2, cex = 1.5)

tr_sim_2_pm4 <- tr_sim_2
tr_sim_2_pm4$edge.length <- tr_sim_2_pm4$edge.length * pm4
plot(tr_sim_2_pm4, edge.width = 2, cex = 1.5)

tr_sim_3_pm5 <- tr_sim_3
tr_sim_3_pm5$edge.length <- tr_sim_3_pm5$edge.length * pm5
plot(tr_sim_3_pm5, edge.width = 2, cex = 1.5)

tr_sim_3_pm6 <- tr_sim_3
tr_sim_3_pm6$edge.length <- tr_sim_3_pm6$edge.length * pm6
plot(tr_sim_3_pm6, edge.width = 2, cex = 1.5)

}

pms_subst_trees <- list(tr_sim_1_pm1, tr_sim_1_pm2, tr_sim_2_pm3, tr_sim_2_pm4, tr_sim_3_pm5, tr_sim_3_pm6) 
names(pms_subst_trees) <- c('tr_sim_1_pm1', 'tr_sim_1_pm2', 'tr_sim_2_pm3', 'tr_sim_2_pm4', 'tr_sim_3_pm5', 'tr_sim_3_pm6')

for(i in 1:length(pms_subst_trees)){
  write.tree(pms_subst_trees[[i]], file = paste0('sim_k_3/', names(pms_subst_trees)[i], '.tree'))
}



set.seed(1234)

pm.sets <- sample(1:6, 100, replace = T)
blens_mean <- vector()
segsites <- vector()

for(i in 1:100){
  tr_temp <- pms_subst_trees[[pm.sets[i]]]
  tr_temp$edge.length <- abs(tr_temp$edge.length + rnorm(38, 0, 0.002) + rnorm(1, 0, 0.002))
  blens_mean[i] <- mean(tr_temp$edge.length)
  dat_temp <- as.DNAbin(simSeq(tr_temp, l = 500))
  segsites[i] <- length(seg.sites(dat_temp))
  write.dna(dat_temp, file = paste0('sim_k_3/seq_pm', pm.sets[i], '_', i, '.fasta'), format = 'fasta', nbcol = -1, colsep = '')
  print(paste('sim', i, segsites[i] / 500, blens_mean[i]))
  plot(tr_temp)

}


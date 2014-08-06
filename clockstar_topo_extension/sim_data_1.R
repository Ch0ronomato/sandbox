library(phangorn)
library(TreeSim)

# Simulate trees
# simulate genes
# Estimates trees
# Recover clusters

# Try on full mammalian data set

# 1. One species three tree pacemakers, different rates for all genes

set.seed(123864)
tr_sim_1 <- sim.bd.taxa.age(n = 10, numbsim = 1, lambda = 0.5, mu = 0.0, frac = 1, age = 100, mrca = FALSE)[[1]]
tr_sim_1$edge.length <- tr_sim_1$edge.length * (10 / max(branching.times(tr_sim_1)) )

#plot(tr_sim_1, edge.width = 3, cex = 2)

pm1 <- rlnorm(n = 18, log(0.005), 0.7)
pm2 <- rlnorm(n = 18, log(0.005), 0.7)
pm3 <- rlnorm(n = 18, log(0.005), 0.7)
pms <- list(pm1, pm2, pm3)

if(F){
par(mfrow = c(1, 3))
tr_sim_1_pm1 <- tr_sim_1
tr_sim_1_pm1$edge.length <- tr_sim_1_pm1$edge.length * pm1
plot(tr_sim_1_pm1)

tr_sim_1_pm2 <- tr_sim_1
tr_sim_1_pm2$edge.length <- tr_sim_1_pm2$edge.length * pm2
plot(tr_sim_1_pm2)

tr_sim_1_pm3 <- tr_sim_1
tr_sim_1_pm3$edge.length <- tr_sim_1_pm3$edge.length * pm3
plot(tr_sim_1_pm3)
}


#system('mkdir sim_k_1')

set.seed(1234)
pm.sets <- sample(1:3, 100, replace = T)

blens_mean <- vector()
segsites <- vector()

for(i in 1:100){
      tr_temp <- tr_sim_1
      tr_temp$edge.length <- abs((tr_temp$edge.length * pms[[pm.sets[i]]])  + rnorm(18, 0, 0.002))
      dat_temp <- as.DNAbin(simSeq(tr_temp, l = 500))
      write.dna(dat_temp, file = paste0('sim_k_1/seq_pm', pm.sets[[i]], '_', i, '.fasta'), format = 'fasta', nbcol = -1, colsep = '')
      plot(tr_temp, edge.width = 2)
      blens_mean[i] <- mean(tr_temp$edge.length)
      segsites[i] <- length(seg.sites(dat_temp)) / 500
}

write.tree(tr_sim_1, file= 'sim_k_1/species_tr.tree')


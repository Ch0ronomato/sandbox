library(doParallel)
cl <- makeCluster(5)

registerDoParallel(cl)

wow <- foreach(i = 1:3) %dopar% sqrt(i)

# test clust

data <- data.frame(x = c(rnorm(1000), rnorm(1000, 5), rnorm(1000, 10)), y = c(rnorm(1000), rnorm(1000, 5), rnorm(1000, 10)))

library(cluster)

clust1 <- foreach(i=1:50, .combine = cbind) %dopar% cluster::clara(data, k = i, pamLike = T)$silinfo$avg.width

stopCluster(cl)
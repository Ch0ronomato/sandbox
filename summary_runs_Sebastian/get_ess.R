library(coda)
f_out <- mcmc(read.table('mcmc.txt', head = T, as.is = T))
burnin_remove <- ceiling(nrow(f_out) * 0.1):nrow(f_out)
ess_params <- sapply(2:ncol(f_out), function(x) effectiveSize(f_out[burnin_remove, x]))
mean_params <- sapply(2:ncol(f_out), function(x) mean(f_out[burnin_remove, x]))
high_hpd <- sapply(2:ncol(f_out), function(x) quantile(f_out[burnin_remove, x], 0.975))
low_hpd <- sapply(2:ncol(f_out), function(x) quantile(f_out[burnin_remove, x], 0.025))

out_ess <- data.frame(parameter = colnames(f_out)[2:ncol(f_out)], ESS = ess_params, mean = mean_params, high_hpd = high_hpd, low_hpd = low_hpd)

f_name <- paste0(gsub('/.+/', '',  getwd()), '_summary.txt')

write.table(out_ess, file = f_name, row.names = F)


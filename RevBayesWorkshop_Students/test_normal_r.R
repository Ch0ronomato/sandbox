
data_obs <- rnorm(100, 10, 3)

likelihood <- function(params){
     return(sum(log10(dnorm(data_obs, params[1], params[2]))))
}

likelihood_2 <- function(params){
     return(sum(log10(dexp(data_obs, params[1]))))
}



prior <- function(params){
      mu_prior <- dnorm(params[1], 0, 100)
      sd_prior <- dexp(params[2])
      return(log10(mu_prior * sd_prior))
}

posterior <- function(params){
     return(likelihood(params) + prior(params))
}

proposal <- function(params){
   return(c(rnorm(1, mean = params[1], sd = 0.5), abs(rnorm(1, mean = params[2], sd = 0.5))))
}

mcmc <- function(start_vals, it = 1000){
      start_vals <- c(1, 1)
      it <- 1000

     chain <- matrix(NA, nrow = it, ncol = 6)
     colnames(chain) <- c('step', 'likelihood', 'prior', 'posterior', 'mu', 'sd')
     chain[1, ] <- c(1, likelihood(start_vals), prior(start_vals), posterior(start_vals), start_vals[1], start_vals[2])
     for(i in 2:it){
       step_move <- proposal(chain[i - 1, 5:6])
       pr_accept <- exp(posterior(step_move) - posterior(chain[i - 1, 5:6]))
       if(runif(1) < pr_accept){
         chain[i, ] <- c(i, likelihood(step_move), prior(step_move), posterior(step_move), step_move[1], step_move[2])
       }else{
         chain[i, ] <- c(i, chain[i-1, 2:6])
       }
     }
     return(chain)
}

test_1 <- mcmc(c(1, 1), it = 100)

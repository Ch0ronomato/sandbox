
#data_obs <- abs(rnorm(1000, 100, 20))
#data_obs <- rexp(1000, rate = 1/50)
data_obs <- runif(1000, 0, 100)

# Likelihood function for normal dist model
likelihood_1 <- function(params){
     return(sum(log10(dnorm(data_obs, params[1], params[2]))))
}


# Likeklihood function for exponential model
likelihood_2 <- function(params){
     return(sum(log10(dexp(data_obs, 1 / params[1]))))
}

likelihood <- list(likelihood_1, likelihood_2)

# Priors for each of the models
prior_1 <- function(params){
      mu_prior <- dnorm(params[1], 50, 100)
      sd_prior <- dexp(params[2])
      return(log10(mu_prior * sd_prior))
}

prior_2 <- function(params){
      m_prior <- dnorm(params[1], 0, 100)
      return(log10(m_prior))
}

prior <- list(prior_1, prior_2)

# posterior functions
posterior <- function(params, model_i){
     return(likelihood[[model_i]](params) + prior[[model_i]](params))
}

# Same proposal function. Note that we don't need a parameter for the model because the move is a draw from a lognormal distribution
proposal <- function(params){
#   return(c(sample(c(1, 2), p = c(0.5, 0.5), size = 1), abs(rnorm(1, mean = params[2], sd = 0.5)), abs(rnorm(1, mean = params[3], sd = 0.5))))
   return(c( sample(c(1, 2), p = c(0.5, 0.5), size = 1), abs(rnorm(1, mean = params[2], sd = 1)), abs(rnorm(1, mean = params[3], sd = 1))))

}



#mcmc <- function(start_vals, it = 1000){
      start_vals <- c(1, 1, 1)
      it <- 10000

     chain <- matrix(NA, nrow = it, ncol = 7)
     colnames(chain) <- c('step', 'likelihood', 'prior', 'posterior', 'mean', 'sd', 'model')
     chain[1, ] <- c(1, likelihood[[start_vals[1]]](start_vals[2:3]), prior[[start_vals[1]]](start_vals[2:3]), posterior(start_vals[2:3], start_vals[1]), start_vals[2], start_vals[3], start_vals[1])

     for(i in 2:it){
       step_move <- proposal(chain[i - 1, c(7, 5, 6) ])
print(step_move)
       pr_accept <- (posterior(step_move[2:3], step_move[1]) - posterior(chain[i - 1, 5:6], chain[i - 1, 7]))
       if(log(runif(1)) < pr_accept || is.nan(pr_accept) ){
         chain[i, ] <- c(i, likelihood[[step_move[1]]](step_move[2:3]), prior[[step_move[1]]](step_move[2:3]), posterior(step_move[2:3], step_move[1]), step_move[2], step_move[3], step_move[1])
       }else{
         chain[i, ] <- c(i, chain[i-1, 2:7])
       }
print(chain[i, ])
     }
#     return(chain)
#}

#test_1 <- mcmc(c(1, 1, 1), it = 10000)

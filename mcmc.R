library(coda)
set.seed(18002262)
x <- rnorm(1000, 10, 2)

# mean of x = m1 + m2	

# The likelihood of the mean depends on two parameters, m1 and m2. These are non identifiable because any combination would match the mean
likelihood <- function(param) {
    m1.model <- param[1]
    m2.model <- param[2]
    single.likelihoods <- dnorm(x, mean = m1.model + m2.model, sd = 2, log = T)
    #single.likelihoods <- dnorm(x, mean = m1.model, sd = 2, log = T) #uncomment to check for single parameter esimate with increasing amount of data
    sum.likelihoods <- sum(single.likelihoods)
    return(sum.likelihoods)
}

prior <- function(param) {
    m1.param <- param[1]
    m2.param <- param[2]
    # Some very uninformative priors
    m1.prior <- dnorm(m1.param, 10,2,  log = T) # Unless a prior is informative, the values will drift, even with infinite data...
    m2.prior <- dunif(m2.param, -100, 100, log = T)
    #return(m1.prior )#+ m2.prior)
    return(m1.prior + m2.prior)
}

proposal.function <- function(param) {
    return(c(rnorm(1, mean = param[1], sd = 0.5), rnorm(1, mean = param[2], sd = 0.5)))
}

posterior <- function(param) {
    return(likelihood(param) + prior(param))
}

mcmc_bayesian <- function(startvals, iterations = 50000) {
    chain <- matrix(NA, nrow = iterations, ncol = 5)
    colnames(chain) <- c("m1", "m2", "likelihood", "posterior", "prior")
    chain[1, ] <- c(startvals, likelihood(startvals), posterior(startvals), 
        prior(startvals))
    for (i in 2:iterations) {
        # Uncomment the line bellow to print the progress of the MCMC on screen
#         print(paste('iteration', i , 'of', iterations, 'the parameters are', paste(chain[i-1, ], collapse = ' ')))
        proposal <- proposal.function(chain[i - 1, 1:2])
        prob.accept <- exp(posterior(proposal) - posterior(chain[i - 1, 1:2]))
        if (runif(1) < prob.accept) {
            chain[i, ] <- c(proposal, likelihood(proposal), posterior(proposal), 
                prior(proposal))
        } else {
            chain[i, ] <- chain[i - 1, ]
        }
    }
    return(chain)
}

ch1 <- mcmc_bayesian(startvals = c(30, -20), iterations = 50000)

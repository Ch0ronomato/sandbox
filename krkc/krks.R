
kr.kc <- function(seq){
   #Define the different AA types in a list
   #A1: Electrically + charged side chain
   #A2: Electrically - charged side chain
   #B: Polar side chains
   #C: Special cases
   #D: Hydrophobic side chains

    require(phangorn)
    aa_types <- matrix(NA, 21, 2)
    aa_types[, 1] <- c('r', 'h', 'k', 'd', 'e', 's', 't', 'n', 'q', 'c', 'u', 'g', 'p', 'a', 'v', 'i', 'l', 'm', 'f', 'y', 'w')
    aa_types[, 2] <- c(rep('A1', 3), rep('A2', 2), rep('B', 4), rep('C', 4), rep('D', 8))

    # seq can be a phydat object that can be converted to a character matrix
    s <- as.character(seq)
    if(!is.matrix(s)) stop('I cannot convert the data to a matrix. aborting')
    kr <- 0
    kc <- 0

    for(i in 1:ncol(s)){
        uni_sites <- unique(s[, i])
        uni_sites <- uni_sites[which(uni_sites != '-')]
        if(length(uni_sites) == 1) next
        s_types <- vector()
        for(u in uni_sites){
            s_types <-  c(s_types, aa_types[u == aa_types[, 1], 2])# because it can only belong to one aa type
        }
        if(length(unique(s_types)) == 1){
            kc <- kc + 1
        }else{
            kr <- kr + 1
        }
    }

    if(kc == 0){
        warning('division by zero, returning NA')
        return(NA)
    }else{
        return(kr/kc)
    }

}

# To use:
#dat <- read.phyDat('simulated_aa.fasta', format = 'fasta', type = 'AA')
#kr.kc(dat)

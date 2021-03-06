length2 <- function(design, with.blocks=FALSE, J=FALSE){
    ## function to calculate number of generalized words of length 3
    ## according to Xu and Wu 2001 Annals
    
    ## it might be helpful to locate non-zeros
    ## this is so far not done
    n <- nrow(design)
    if (!(is.data.frame(design) | is.matrix(design))) stop("design must be a data frame or a matrix")
    if (is.matrix(design)) design <- as.data.frame(design)
    if (!"design" %in% class(design)){ 
        for (i in 1:ncol(design)){ 
            design[,i] <- factor(design[,i])
            contrasts(design[,i]) <- "contr.XuWu"
        }
        nlevels <- sapply(as.list(design), function(obj) nlevels(obj))
        ##names(nlevels) <- colnames(design)
        fo <- formula("~.", data=design)
        }
    else {
        di <- design.info(design)
        nlevels <- di$nlevels
        if (is.null(nlevels)){
            if (length(grep("FrF2",di$type))>0 | length(grep("pb",di$type))>0 )
                nlevels <- rep(2,length(di$factor.name))
        }
        ## orthogonal contrasts
        design <- change.contr(design, "contr.XuWu")
    
        ## if blocked and requested, accomodate blocks
        if (with.blocks & !is.null(di$block.name)){
          if (!is.factor(design[[di$block.name]])) design[[di$block.name]] <- factor(design[[di$block.name]])
          contrasts(design[[di$block.name]]) <- "contr.XuWu"
          fo <- formula(paste("~",paste(c(di$block.name,names(di$factor.names)),collapse="+")), data=design)
          nlevels <- c(di$nblocks,nlevels)
        }
        else
          fo <- formula(paste("~",paste(names(di$factor.names),collapse="+")), data=design)
        }

    ## create model matrix
    
    mm <- model.matrix(fo,design)
    ## store column allocation to factors
    zuord <- attr(mm, "assign")
    ## no longer necessary, already done by contr.XuWu
    ## --> works for imbalanced designs as well
    ## normalize columns to Euclidean norm sqrt(n)
    ## mm <- sqrt(n)*mm %*% diag(1/sqrt(colSums(mm^2)))
    ## remove intercept column
    mm <- mm[,-1]
    zuord <- zuord[-1]
    ##colnames(mm) <- zuord   ## takes too long
    nfac <- max(zuord)
    if (nfac < 2) return(0)

    ## 2fi columns
    ## store all in one matrix, faster but requires large matrix
    paare <- nchoosek(nfac, 2)
    anz <- 0
    for (i in 1:ncol(paare))
       anz <- anz+prod(nlevels[paare[,i,drop=FALSE]]-1)
    vec2 <- rep(NA, anz)
    ## names(vec2) <- rep("sp",length(vec2))   ## takes too long

    zaehl <- 1   ## column accessor

    for (i in 1:(nfac - 1)){
     icols <- which(zuord==i)
      for (j in (i+1):(nfac)){
        jcols <- which(zuord==j)
          for (a in icols){
           for (b in jcols){
              vec2[zaehl] <- sum(mm[,a]*mm[,b])
              ##names(vec2)[zaehl] <- paste(i,j,k,sep=":")
              zaehl <- zaehl+1
           }}
       }
    }
    if (J) {
        names(vec2) <- unlist(apply(paare,2,function(obj) rep(paste((1:nfac)[obj],collapse=":"), prod(nlevels[obj]-1))) )
        return(abs(vec2)/n)
        }
    else 
    sum(vec2^2)/(n^2)
}
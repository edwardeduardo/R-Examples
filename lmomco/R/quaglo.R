"quaglo" <-
function(f,para,paracheck=TRUE) {
    if(! check.fs(f)) return()
    if(paracheck == TRUE) {
      if(! are.parglo.valid(para)) return()
    }
    XI <- para$para[1]
    A  <- para$para[2]
    K  <- para$para[3]

    ops <- options(warn=-1)
    Y <- log(f/(1-f))
    options(ops)

    ZERO <-  sqrt(.Machine$double.eps) # following Tony Ladson, March 2016
    if(abs(K) > ZERO) Y <- (1-exp(-K*Y))/K # following Tony Ladson, March 2016
    x <- XI + A*Y

    x[f == 0 & K < 0] <- XI+A/K
    x[f == 1 & K > 0] <- XI+A/K
    names(x) <- NULL
    return(x)
}


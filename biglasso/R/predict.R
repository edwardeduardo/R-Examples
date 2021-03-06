predict.biglasso <- function(object, X, row.idx = 1:nrow(X), 
                             type = c("link", "response", "class", 
                                    "coefficients", "vars", "nvars"),
                             lambda, which = 1:length(object$lambda), ...) {
  type <- match.arg(type)
  beta <- coef.biglasso(object, lambda=lambda, which=which, drop=FALSE)
  if (type=="coefficients") return(beta)
  if (class(object)[1]=="biglasso") {
    alpha <- beta[1,]
    beta <- beta[-1,,drop=FALSE]
  }
  
  if (type=="nvars") return(apply(beta!=0,2,sum))
  if (type=="vars") return(drop(apply(beta!=0, 2, FUN=which)))

  if (!inherits(X, 'big.matrix')) {
    stop("X must be a big.matrix object.")
  }
  
  beta.T <- as(beta, "dgTMatrix") 
  temp <- .Call("get_eta", X@address, as.integer(row.idx-1), beta, beta.T@i, 
                beta.T@j, PACKAGE = 'biglasso')
  eta <- sweep(temp, 2, alpha, "+")
 
  if (type=="link" || object$family=="gaussian") return(drop(eta))
  resp <- switch(object$family,
                 binomial = exp(eta)/(1+exp(eta)),
                 poisson = exp(eta))
  if (type=="response") return(drop(resp))
  if (type=="class") {
    if (object$family=="binomial") {
      return(drop(1*(eta>0)))
    } else {
      stop("type='class' can only be used with family='binomial'")
    }
  }
}

coef.biglasso <- function(object, lambda, which = 1:length(object$lambda), drop = TRUE, ...) {
  if (!missing(lambda)) {
    ind <- approx(object$lambda,seq(object$lambda),lambda)$y
    l <- floor(ind)
    r <- ceiling(ind)
    w <- ind %% 1
    beta <- (1-w)*object$beta[,l,drop=FALSE] + w*object$beta[,r,drop=FALSE]
    colnames(beta) <- round(lambda,4)
  }
  else beta <- object$beta[,which,drop=FALSE]
  if (drop) return(drop(beta)) else return(beta)
}

## predict cv.biglasso
predict.cv.biglasso <- function(object, X, row.idx = 1:nrow(X),
                                type = c("link","response","class",
                                       "coefficients","vars","nvars"), 
                                lambda = object$lambda.min,
                                which = object$min, ...) {
  type <- match.arg(type)
  predict.biglasso(object$fit, X = X, row.idx = row.idx, type = type, 
                   lambda = lambda, which = which, ...)
}

coef.cv.biglasso <- function(object, lambda = object$lambda.min, which = object$min, ...) {
  coef.biglasso(object$fit, lambda = lambda, which = which, ...)
}

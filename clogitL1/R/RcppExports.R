# This file was generated by Rcpp::compileAttributes
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

clogitl1_c <- function(n, m, Xmat, yvec, switchIter, numLambda, minLambda, alpha) {
    .Call('clogitL1_clogitl1_c', PACKAGE = 'clogitL1', n, m, Xmat, yvec, switchIter, numLambda, minLambda, alpha)
}

clogitl1CV_c <- function(n, m, Xmat, yvec, lambdas, keepvec, alpha) {
    .Call('clogitL1_clogitl1CV_c', PACKAGE = 'clogitL1', n, m, Xmat, yvec, lambdas, keepvec, alpha)
}


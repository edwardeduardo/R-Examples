# Generated by autofun (0.0.0.9000): do not edit by hand!!!
# Please edit source code in R-autofun/check-first-chain.R
.check_first_chain<-function(...){
expression(if (i == 1) {
  x <- round(n_accept / c(n_pts * schedule$chain.length), 2)
  if (x < schedule$initial.acceptance) {
    cat("\nlow temperature: ", round(x * 100, 2), "% of acceptance in the 1st chain\n", sep = "")
    break
  } else {
    cat("\n", round(x * 100, 2), "% of acceptance in the 1st chain\n", sep = "")
  }
})
}


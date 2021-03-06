plot.GPCE.quad <- function(x,...) {
  ylim = c(0, 1)
  if (!is.null(x$Sensitivity)) {
    p <- x$Args$InputDim
    pch = c(21, 24)
    nodeplot(matrix(x$Sensitivity$S,ncol=p), xlim = c(1, p + 1), ylim = ylim, pch = pch[1],...)
    nodeplot(matrix(x$Sensitivity$ST,ncol=p), xlim = c(1, p + 1), ylim = ylim, labels = FALSE,
             pch = pch[2], at = (1:p)+.3, add = TRUE,...)
    legend(x = "topright", legend = c("main effect", "total effect"), pch = pch)
    
    S <- rbind(x$Sensitivity$S, x$Sensitivity$ST - x$Sensitivity$S)
    colnames(S) <- paste("X", 1:p, sep = "")
    bar.col <- c("white","grey")
    barplot(S, ylim = ylim, col = bar.col)
    legend("topright", c("main effect", "interactions"), fill = bar.col)    
  }
}

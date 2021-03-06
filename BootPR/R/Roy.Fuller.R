Roy.Fuller <-
function(x,p,h,type)
{
x<-as.matrix(x)
if (type=="const")
M <- FFuller(x,p,h)
if (type=="const+trend")
M <- FFullerT(x,p,h)
rownames(M$coef) <- ARnames(p,type); colnames(M$coef) <- "coefficients"
colnames(M$forecast) <- "forecasts"; rownames(M$forecast) <- paste("h",1:h,sep="")
return(list(coef=M$coef,resid=M$resid,forecast=M$forecast))
}

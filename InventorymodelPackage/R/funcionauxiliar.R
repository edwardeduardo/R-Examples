funcionauxiliar <-
function(permute,costes){
n<-max(permute)
if (is.vector(permute)==T){
phi<-c()
for (i in 1:n){
cj<-0;aux<-0
pred<-sort(permute[1:which(permute==i)-1],decreasing=F)
if (length(pred)==0) pred<-0
aux<-sort(union(pred,i),decreasing=F)
suma=0;suma1=0
for (k in 1:length(aux)){suma<-suma+aux[k]*10^(length(aux)-k)}
for (k in 1:length(pred)){suma1<-suma1+pred[k]*10^(length(pred)-k)}
cj<-cj+costes[which(costes[,n+1]==suma),n+2]-costes[which(costes[,n+1]==suma1),n+2]
phi[i]<-cj/2
}
}
if(is.vector(permute)==F){
phi<-c()
for (i in 1:n){
cj<-0
for (j in 1:nrow(permute)){
aux<-0
pred<-sort(permute[j,1:which(permute[j,]==i)-1],decreasing=F)
if (length(pred)==0) pred<-0
aux<-sort(union(pred,i),decreasing=F)
suma=0;suma1=0
for (k in 1:length(aux)){suma<-suma+aux[k]*10^(length(aux)-k)}
for (k in 1:length(pred)){suma1<-suma1+pred[k]*10^(length(pred)-k)}
cj<-cj+costes[which(costes[,n+1]==suma),n+2]-costes[which(costes[,n+1]==suma1),n+2]
}
phi[i]<-cj/(2*nrow(permute))
}
}
return(phi)}

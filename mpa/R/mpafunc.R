#---------------------------------------------------
#funciones necesarias para la clasificaci�n

#funci�n "contar.si" es igual a la de Excel
contar.si<-function(x, n)
{
  j <- 0
  for(i in 1:(length(x))){if(x[i]==n) j <- j+1}
  j}
#funci�n "reemplazar.si" todos los que sean iguales
#a n dentro de un vector los reemplaza por p
reemplazar.si<-function(x, n, p)
{
  for(i in 1:(length(x))){if(x[i]==n) x[i] <- p}
  x}
#----------------------------------------------------

#clasificaci�n
#funci�n de clasificaci�n MPA
#Par�metros: E: matriz de asociaciones
#            tmax: m�ximo de palabras por grupo
#            nombres: vector de palabras clave
mpa<-function(E, tmax=7, palabras=NULL)
{
  m <- nrow(E)                           
  n <- (m-1)*m/2        #n es el n�mero de parejas
#extracci�n de la triangular superior de E en un vector
  Evec <- E[1,2:m]      #Evec: vector que contendr� la triangular superior de E
  for(i in 2:(m-1)){
    Evec <- c(Evec,E[i,(i+1):m])
  }
#creaci�n de la matriz de sub�ndices, dos columnas que registran 
#las parejas de palabras (i, j) a la que se le asociar� una entrada de Evec
  ind <- c(0,0)
  for(i in 1:(m-1)){
    for(j in (i+1):m){
      if(E[i,j]!=0) ind <- rbind(ind, c(i, j))
  }}
  ind <- as.matrix(ind[2:nrow(ind),1:2])
  Evec <- Evec[Evec!=0]
#creaci�n de la nueva matriz Enuevo, en columnas: sub�ndices, coef. de asoc y su rango
  Enuevo <- cbind(ind,Evec,rank(Evec,ties.method=c("first"))) # se calcula el rango para poder ordenar las asociaciones
#Eord: reorganizaci�n de los coeficientes de forma decreciente
  Eord <- c(0,0,0,0)
  for(j in 0:(length(Evec)-1)){
    for(i in 1:length(Evec)){
      if(Enuevo[i,4]==(length(Evec)-j))
        Eord <- rbind(Eord,Enuevo[i,1:4])
  }}
  Eord <- Eord[2:(length(Evec)+1),1:4]
#clasificaci�n
    clases <- rep(0,times=m)  # clases es el vector que identificar� la clase a la cual pertenece cada palabra
  for(i in 1:length(Evec)){          # i recorrer� cada pareja dentro de Eord
    if(Eord[i,3]!=0){     # primero se asegura que la sociaci�n entre dos palabras no es nula
      
      if(clases[Eord[i,1]]==0 && clases[Eord[i,2]]==0){       # si las dos palabras de la pareja tienen clase cero
        clases[Eord[i,1]] <- max(clases)+1                      # significa que conforma una nueva clase
        clases[Eord[i,2]] <- max(clases)+1}                     # e.d. max(clases)+1
      
      if(clases[Eord[i,1]]==0 && (contar.si(clases,clases[Eord[i,2]])<tmax)){  # si una de las palabras tiene clase cero 
        clases[Eord[i,1]] <- clases[Eord[i,2]]}                                # y la otra palabra pertenece a una clase
                                                                               # cuyo tama�o es menor a tmax
      if(clases[Eord[i,2]]==0 && (contar.si(clases,clases[Eord[i,1]])<tmax)){  # entonces a la palabra de clase cero
        clases[Eord[i,2]] <- clases[Eord[i,1]]}                                # se le asigna la clase existente 
      
      if((contar.si(clases,clases[Eord[i,1]])+contar.si(clases,clases[Eord[i,2]]))<=tmax){          # cuando las dos palabras de la pareja ya pertenecen 
        clases <- reemplazar.si(clases,clases[Eord[i,1]],min(clases[Eord[i,1]],clases[Eord[i,2]]))  # a una clase diferente de cero y la suma del n�mero 
        clases <- reemplazar.si(clases,clases[Eord[i,2]],min(clases[Eord[i,1]],clases[Eord[i,2]]))}  # de palabras de cada clase es menor que tmax entonces
                                                                                                    # todas las palabras quedan en una sola clase, la menor
    }                                                                                               
  }
   
#c�lculo del tama�o, la densidad y la centralidad de cada clase
  Cluster <- seq(1:(max(clases)))                      #Cluster: vector que identifica cada clase existente
  Nombre <- rep(0,times=(length(Cluster)))             #Nombre: vector que contendr� el nombre de cada clase
  size <- rep(0,times=(length(Cluster)))             #size: vector que contendr� los tama�os de las clases
  Densidad <- rep(0,times=(length(Cluster)))           #Densidad: vector que contendr� la densidad de cada clase
  Centralidad <- rep(0,times=(length(Cluster)))        #Centralidad:             "        centralidad     "
  
  for(i in 1:(max(clases))){                         # i recorrer� cada clase
    
    pal.dentro <- seq(1:m)                             # pal.dentro: secuencia desde 1 hasta m, m�s adelante s�lo contendr� las palabras de la clase i
    npal.dentro <- contar.si(clases,i)                 # npal.dentro: n�mero de palabras de la clase i
    if(npal.dentro!=0){
      # la siguiente instrucci�n le coloca NA a las palabras que en pal.dentro no pertenecen a la clase i
      pal.dentro <- ifelse(clases==i, pal.dentro, NA)     # si la palabra no pertenece a la clase i
                                                        # se le asigna NA
        
      size[i] <- npal.dentro                         # se registra en size el n�mero de palabras de la clase i
    
      E1 <- E[!is.na(pal.dentro),!is.na(pal.dentro)]                                # E1, submatriz de E con s�lo las asociaciones de la clase i
      if(npal.dentro>1) E1 <- E1-diag(1,nrow(E1),nrow(E1))                          # para poder promediar las asociaciones, se debe quitar los 1's
      if(npal.dentro>1) Densidad[i] <- mean(ifelse(E1==0,NA,E1),na.rm=TRUE)         # de la diagonal de E1, al hacer los
										    #promedios se ignoran los NA's
    
      #asignaci�n del nombre del cluster
      nom <- 0
      if(!is.null(palabras)){
        suma <- rowSums(E1, na.rm=TRUE)                       # suma: vector de sumas de relaciones internas de la clase i
        pal <- palabras[!is.na(pal.dentro)]                
        nom <- pal[suma==max(suma)]                        # nom: vector que contiene a las palabras que tienen suma de asociaciones m�xima
        Nombre[i] <- nom[1]}                               # por defecto se elige la primera palabra de las que tienen la suma m�xima
                                                      
    
      E2 <- E[is.na(pal.dentro),!is.na(pal.dentro)]        # E2, submatriz de E con las asociaciones externas de E
      cen <- mean(ifelse(E2==0,NA,E2),na.rm=TRUE)          # nuevamente para calcular el promedio se ignoran los NA's
      if(!is.nan(cen)) Centralidad[i] <- cen
      else Centralidad[i] <- 0                                                                         
    }                          
  }
  Cluster <- Cluster[size!=0]
  Densidad <- Densidad[size!=0]
  Centralidad <- Centralidad[size!=0]
  Nombre <- Nombre[size!=0]
  size <- size[size!=0]
  
  cluster1 <- c(1:length(Cluster))
  for(i in 1:length(Cluster)) clases <- reemplazar.si(clases, Cluster[i], cluster1[i])
  
  Cluster <- cluster1
    
    # MPA: lista que contiene las clases, su tama�o, su densidad y centralidad
    if(!is.null(palabras))
      MPA <- list(Clases=clases,Nombres=Nombre,Resumen=cbind(Cluster,size,Densidad,Centralidad))
    else
      MPA <- list(Clases=clases,Resumen=cbind(Cluster,size,Densidad,Centralidad))
  MPA                                                                                       
} #fin de la funci�n

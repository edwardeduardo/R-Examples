`distance.test` <-
function(position,dist.marq){

# ATTENTION: il faut fixer un nombre d�cimales pour les valeurs � comparer 
#Arrondi des vecteurs dist.marq et position
dist.marq=round(dist.marq,5) 
position=round(position,5)

#valeurs de position rang�es par ordre croissant
position=sort(position)

#Cr�ation de la liste des positions de test par rapport au d�but du chromosome et rang�es par intervalle [marque;marque+1]
inter	=	list() 

for (i in 1:(length(dist.marq)-1)){
     inter[[i]]=dist.marq[i]
     inter[[length(dist.marq)-1]]=c(dist.marq[length(dist.marq)-1],dist.marq[length(dist.marq)])
}

inter

interval=inter



  for (i in 1:length(position))
   {
     for (j in 1:(length(inter)-1))
      {
	if ((min(interval[[j]]) < position[i])
	&(position[i] < min(interval[[j+1]]))) {
	interval[[j]] = round(sort(union(interval[[j]],position[i])),5)
	}
      }

      for (j in length(inter))
      {
	if ((min(interval[[j]]) < position[i])
	&(position[i] < max(interval[[j]]))) {
	interval[[j]] = round(sort(union(interval[[j]],position[i])),5)
	}
      }

   } 

interval 


}


#crear lista 3.2

#1 Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista

?list

#formar lista 

personajes<- c("arbol","camino","flor","fuente")

la_matriz<-matrix(c(1,2,3,4),ncol = 2,nrow=2,byrow=TRUE)

df_l<-data.frame(edad=c(15,20,25,30),nombre=c("David","Camilo","Franco","Marco"),fuma=c(TRUE,FALSE,FALSE,TRUE))

#crear lista

mi_lista<-list(per=personajes,mat=la_matriz,dat=df_l)


#Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.

#se va a utilizar "mi_lista" como lista base, y de esta se va a acceder a los elemetos

mi_lista$dat

mi_lista$per

#Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.

#a la lista "mi_lista" se le va a gregar un elemto al final

#crear vector del 1 al 15

vec<-(1:15)

mi_lista<-list(per=personajes,dat=df_l,mat=la_matriz,vec=vec)

mi_lista

mi_lista$vec

#seleccionar segun pocision elemnto dentro de la lista "mi_lista"

mi_lista[[2]]

#crear 2 listas dentro de la lista "mi_lista"

animal<-list(orden="carnivoros",familia="felinos",nombre="lince")

animal

valores<-list(a=1:4,b=rnorm(10),c=rnorm(20,mean = 1),d=rnorm(100,5))

valores

lapply(valores,mean)

append(animal,valores)

mi_lista$fucion_lista<-append(animal,valores)

mi_lista

#desenlistar una lista (lista a vector)

unlist(animal)

#crear lista con distintos data.frame y acceder a cada uno

#vectors sobre pelicula de Shrek

nombre<-c("shrek","shrek 2","shrek 3","shrek 4")

puntuacion<-c(7.9,7.2,6.1,6.3)

posterior_2005<-c(FALSE,FALSE,FALSE,TRUE)

peliculas_df<-data.frame(nombre,
                         
                         puntuacion,
                         
                         posterior_2005)

peliculas_df

#vectores sobre mis Datos

edad <- c(22, 34, 29, 25, 30, 33, 31, 27, 25, 25)

tiempo <- c(14.21, 10.36, 11.89, 13.81, 12.03, 10.99, 12.48, 13.37, 12.29, 11.92)

sexo <- c("M","H","H","M","M","H","M","M","H","H")

misDatos <- data.frame(edad,tiempo,sexo)

misDatos

#creacion lista con df

lista_df<- list('shrek'=peliculas_df,'datos'=misDatos)

lista_df

lista_df$shrek

lista_df$datos

#contar elementos de una lista

length(lista_df)

lengths(lista_df)

#de matriz a lista

matriz <- matrix(1:9, nrow = 3)

matriz

as.list(matriz)

# Escriba un programa R para asignar NULL a un elemento de lista dado.

lista_df[['misDatos']][2,3]

#lista=s vector(E:+15)

abcdario_E<-c('E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S')

s_lista<-list(abcdario_E)

s_lista

#13Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.

lista_df

length(edad)

length(nombre)

#14 Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)

?setdiff

setdiff(animal,valores)
#Taller 1
#Fecha 19-08-2024
#Integrantes:
#Rosa Hidalgo
#Macarena Gaete

#1 Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

v1= c(1:10)
v2= c(1i,2i,3i,4i,5i,6i,7i,8i,9i,10i)
v3= rep(TRUE,10)
v4= c('a','b','c','d','e','f','g','h','i','j')


#2 Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.

a1 = c(1:5)
a2 = c(1:5)
a1+a2


#3 Escriba un programa en R para encontrar la suma, la media y el producto de un vector con 10 elementos.
v5= c(1,2,3,4,5,6,7,8,9,10)
sum(v5)
prod(v5)
mean(v5)

#4 Escriba un programa R para encontrar la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.
v8 = c(1,2,3,4,5,6,7,NA,NA,NA)
class(v8)
length(v8)
sum(v8,na.rm=TRUE)
mean(v8,na.rm=TRUE)
prod(v8,na.rm=TRUE)



#5 Escriba un programa en R ordenar un vector con 8 elementos en orden ascendente y descendente.
v9 = c(8,4,5,7,1,6,9,3,2)
sort(v9)
sort(v9,decreasing = TRUE)

#6 Escriba un programa R para probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

v10= c(1,2,5,25,35,32)
v10==5


#7 Escriba un programa R para encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos.
v11= c(1,2,9,4,5,6,7,8,3,10)
r2 = sort(v11,decreasing= TRUE)
r2[2]

#8 Escriba un programa en R para encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos.
n= 4
r2 = sort(v11,decreasing = TRUE)
r2[4]


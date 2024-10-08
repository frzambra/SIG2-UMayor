#Solucion Taller 1
#Fecha: 26-08-2024
#Integrantes:
#Sebastian_Castillo


#Vectores

#1. Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

#vector numerico
v1<-1:10
class(v1)
length(v1)


#Vector caracter 

v2<-c('a','b','c','d','e','f','g','h','i','j')
class(v2)
length(v2)


#vector lógico

v3<-rep(TRUE,10)
class(v3)
length(v3)

#2. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.

#La suma de vectores es elemento a elemento

v4<-c(9,5,3,2,7)
v4<-as.integer(v4)
v5<-rep(1,5)
v5<-as.integer(v5)

v6<-v4+v5

class(v6)
typeof(v6)
#3. Escriba un programa en R para encontrar la suma, la media y el producto de un vector con 10 elementos.

#Ver funciones: mean, sum y proud

v7<-c(10,20,30,40,50,60,70,80,90,100)
sum(v7)

#promedio de vector v7
mean(v7)

#promedio del vector v7
sum(v7)/length(v7)

#producto del vector v7
prod(v7)

#4. Escriba un programa R para encontrar la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

v8<-c(1,2,3,4,5,6,7,NA,NA,NA)
class(v8)
length(v8)

sum(v8,na.rm=TRUE)

#5. Escriba un programa en R para ordenar un vector con 8 elementos en orden ascendente y descendente.
#ver funcion 'sort'

v9<-c(8,1,5,6,3,2,7,4)

#asendente
sort(v9)

#desendente
sort(v9,decreasing=TRUE)

#6. Escriba un programa R para probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

v10<-c(1,2,5,25,35)
v10==5

#7.Escriba un programa R para encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos.

v11<-c(10,5,1,4,8,5,2,1,7,9)
r2<-sort(v11,decreasing=TRUE)
r2[2]

#indexacion
v11[5]


#con otro vector

q<-c(10,5,1,4,8,5,2,1,7,9) #vector aleatorio
q2<-sort(q,decreasing=TRUE) #ordenada de mayor a mejor
q2[2] #extrae el segundo elemento de q2

#8. Escriba un programa en R para encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos.

n<-5 #n-esimo, lo puedo cambiar de acuerdo a necesidad
v11<-c(10,5,1,4,8,5,2,1,7,9)
r2<-sort(v11,decreasing=TRUE)
r2[n]

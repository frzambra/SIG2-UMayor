#taller 1 19/08 Valentina Aguayo-Vicente Barra 
#vectores

#1: Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.
 
#numericos 
v1 <-c(20:30)
v1
class(v1)
length(v1)

#Logicos
v2 <-c <- rep(TRUE, 10)
v2
class(v2)
length(v2)

#caracter
v3 <- c('n','m','b','v','c','x','z','ñ','l','h')
v3
class(v3)
length(v3)

#complejo
v4 <- c(1+2i, 2+3i, 3+4i, 4+5i, 5+6i, 6+7i, 7+8i, 8+9i, 9+10i)
v4
class(v4)
length(v4)      


#enteros 
v5 <-c(1L,22L,3L,4L,5L,6L,7L,8L,9L,10L)
v5
class(v5)
length(v5)

#2 Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.
#suma de vetores 
v6<-c(5:10)
v6
v7<-c(15:20)
v7
v6+v7

#3 Escriba un programa en R para encontrar la suma, la media y el producto de un vector con 10 elementos.
 
v1
sum(v1)


mean(v1)



prod(v1)

#5 Ordenar un vector con ocho elementos en orden ascendente y descendente.

Vtr7 <- c(54,53,68,34,10,21,57,90)
sort(Vtr7)
sort(Vtr7, decreasing = TRUE)

#6 Probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico

Vtr8 <- c(1,2,5,25,35,32)
Vtr8 == 5

#7 Encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos

Vtr9 <- c(22,33,44,11,88,45,87,56,26,96)
sort(Vtr9)
Vtr9 <- sort(Vtr9, decreasing = TRUE)
Vtr9 [2]

#Encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos

Vtr10 <- 33:42
n <- 9
Vtr10[n]




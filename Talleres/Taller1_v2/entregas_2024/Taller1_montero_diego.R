#taller 1
#26 de agosto

#integrantes
#Diego Montero, Bastian Quinteros

#ejercicio 1 
#Escriba un programa en R para crear un vector de un tipo y una longitud específicos. 
#Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

#numerico
v1 <- 1:10
v1
length(v1)
class(v1)

#caracter
v2 <- c("a","b","c","d","e","f","g","h","i","j")
length(v2)
class(v2)

#logico
v3 <- c(TRUE,FALSE,TRUE,TRUE,FALSE,TRUE,FALSE,FALSE,FALSE,TRUE)
v3 <- rep(TRUE,10)

class(v3)
length(v3)

#complejo

v4 <- c(5+2i,10-1i,5+3i,8-4i,30+2i,2-10i,1+1i,1+2i,1+8i,1+9i)
v4

class(v4)
length(v4)

#ejercicio 2
#Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.

v5 <- c(9,4,8,1,0)
v5 <- as.integer(v5)
v6 <- seq(5)

v5 + v6
typeof(v5 + v6)

#ejercicio 3
#Escriba un programa en R para encontrar la suma, la media y el producto de un vector con 10 elementos.

v7 <- 1:10
v7

length(v7)
sum(v7)
mean(v7)
prod(v7)


#ejercicio 4
#Escriba un programa R para encontrar la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

v8 <- c(1,2,3,NA,5,2,8,NA,0,NA)
v8
class(v8)
length(v8)
sum(v8, na.rm = TRUE)

#ejercicio 5
#Escriba un programa en R para ordenar un vector con 8 elementos en orden ascendente y descendente.

v9 <- c(1,0,2,3,7,8,9,4)
v9
sort(v9)
sort(v9,decreasing = TRUE)

#ejercico 6
#Escriba un programa R para probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

v10 <- c(1,2,5,25,35,32)
v10
v10 ==5

#ejercicio 7
#Escriba un programa R para encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos

v11 <- seq(1,19,2)  #secuencia de 10 numeros
v11

s1 <- sort(v11,decreasing = TRUE)  #ordena de mayor a menor
s1
s1[2]  #arroja el segundo numero

#ejercicio 8
#Escriba un programa en R para encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos.

v12 <- c(10,40,41,35,23,67,0,2,8,16)

s2 <- sort(v12) #ordena de menor a mayor
s2
s2[9]



#ejercicio 9
#Escriba un programa en R para convertir la(s) columna(s) dada(s) de el data.frame iris en un vector.

data.frame(iris)
d1 <- data.frame
?data.frame
data.frame
data.frame(stringsAsFactors = TRUE)
d1

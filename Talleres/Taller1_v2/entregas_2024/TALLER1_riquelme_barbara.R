#SOLUCIÓN TALLER 1
#FECHA: 26-08-2024
#INTEGRANTES: Noelia Araya, Bárbara Riquelme


#1. Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

#vector numérico

v1<-c(1:10)
class(v1)
length(v1)

#vector complejo

v2<-c(1+2i,2+3i,3+4i,4-5i,-5-6i,6+7i,7+8i,8+9i,9-10i,-10-11i)
class(v2)
length(v2)

#vector lógico

v3<-c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
class(v3)
length(v3)

#vector caracteres

v4<-c('q','w','e','r','d','y','u','i','o','p')
class(v4)
length(v4)


#2. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.

v5 <- c(1, 2, 3, 4, 5)
typeof(v5)
v5<-as.integer(v5)
typeof(v5)

v6 <- c(1, 1, 1, 1, 1)
typeof(v6)
v6<-as.integer(v6)
typeof(v6)

v7 <- v5+v6
v7
length(v7)
typeof(v7)


#3. Escriba un programa en R para encontrar la suma, la media y el producto de un vector con 10 elementos.

v8 <- 1:10
v8
length(v8)
sum(v8) #suma
mean(v8) #promedio
prod(v8) #producto


#4. Escriba un programa R para encontrar la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

v9<-c(1, 2, 3, 4, 5, 6, 7, NA, NA, NA)
length(v9)
sum(v9, na.rm=TRUE)
mean(v9, na.rm = TRUE)
prod(v9, na.rm = TRUE)


#5. Escriba un programa en R para ordenar un vector con 8 elementos en orden ascendente y descendente.

v10 <- c(5, 8, 1, 9, 2, 3, 6, 4)
sort(v10) #ascendente
sort(v10, decreasing = TRUE) #descendente 


#6. Escriba un programa R para probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

v11 <- c(1, 2, 5, 25, 35, 32)
v11 == 5


#7 Escriba un programa R para encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos.

v12 <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
length(v12)
r1<-sort(v12, decreasing = TRUE) #orden de mayor a menor de v12
r1
r1[2] #extrae el 2do valor de r1


#8. Escriba un programa en R para encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos.

v13 <- c(23, 51, 11, 19, 25, 45, 90, 33, 26, 91)
length(v13)
r2<-sort(v13, decreasing = TRUE) #ordena v13 de mayor a menor
r2
r2[4] #extrae el 4to número de r2


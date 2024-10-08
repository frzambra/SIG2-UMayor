#Solucion Taller 1
#Fecha: 26-08-2024
#Ximena Aco Vera

#Vectores 
#1. Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

#Vector numerico
v1 <- 1:10
class(v1)
length(v1)

#Vector tipo caracter 
v2 <- c('rosa','azul','morado','amarillo','naranja','rojo','cafe','verde','lila','turquesa')
class(v2)
length(v2)

#Vector tipo complejo 
v3 <- c(16+4i,18+3i,20+8i,40+5i,32+7i,44-2i,65-9i,32-2i,55-6i,24-7i)
class(v3)
length(v3)


#2. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.

vv1<- c(2,4,6,8,10)
vv1 <- as.integer(vv1)
vv2 <- c(10,8,6,4,2)
vv2 <- as.integer(vv2)
vv1+vv2
class(vv1+vv2)
typeof(vv1+vv2)
length(vv1+vv2)


#3. Escriba un programa en R para encontrar la suma, la media y el producto de un vector con 10 elementos.

v4 <- c(1,2,3,4,5,6,7,8,9,10)
length(v4)
#media del vector v4
mean(v4)

#suma del vector v4
sum(v4)

#producto del vector v4
prod(v4)


#4. Escriba un programa R para encontrar la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

v5 <- c(13,11,NA,9,NA,7,NA,5,3,1)
class(v5)
length(v5)
#suma del vector v5
sum(v5, na.rm = TRUE)

#media del vector v5
mean(v5, na.rm=TRUE)

#producto del vector v5
prod(v5, na.rm=TRUE)


#5. Escriba un programa en R para ordenar un vector con 8 elementos en orden ascendente y descendente.

v6 <- c(5,8,2,9,1,7,3,4)
sort(v6,decreasing =FALSE)
sort(v6,decreasing=TRUE)
length(v6)


#6. Escriba un programa R para probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

v7 <- c(1,2,5,25,35,32)
v7 == 5


#7. Escriba un programa R para encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos.

v8 <- c(14,15,16,17,18,19,20,22,24,26)
length(v8)
r2 <- sort(v8, decreasing =TRUE)
r2[2]

#indexacion
v8[2]


#8. Escriba un programa en R para encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos.

n <- 6
v8 <- c(14,15,16,17,18,19,20,22,24,26)
length(v8)
r2 <- sort(v8, decreasing =TRUE)
r2[6]

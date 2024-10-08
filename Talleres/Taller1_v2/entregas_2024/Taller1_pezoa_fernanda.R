#Taller 1
#Fecha: 26-agosto
#Integrantes: 
Fernanda Pezoa
Constanza Ramírez

#1. Crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

#Vector numérico con 10 elementos
v1 <- 1:10
v1
class(v1)
length(v1)

#Vector complejo con 10 elementos
v2 <- c(1+2i,1i,9-3i+4i,8-6i,1-9i,3+12i,2i,1i,7+2i,1)
v2

#Vector lógico con 10 elementos
v3 <- rep(TRUE,10)
v3

#Vector de carácter con 10 elementos
v4 <- c('a', 'c', 'o', 't', '9', 'i', 'e', 'p', 'f', '1')
v4

#2. Sumar dos vectores de tipo entero y longitud 5.

v5 <- c(2, 4, 6, 3, 2)
v5
v6 <- c(7, 3, 2, 6, 7)
v6
v5 + v6

#3. Calcular la suma, la media y el producto de un vector con 10 elementos.

v7 <- 1:10
v7
sum(v7)
mean(v7)
prod(v7)

#4. Calcular la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

v8 <- c(1, 2, 3, NA, 5, 10, NA, 9, 10, NA)
v8 
sum(v8)
sum(v8,na.rm = TRUE)
mean(v8)  
mean(v8,na.rm = TRUE)
prod(v8)
prod(v8,na.rm = TRUE)

#5. Ordenar un vector con ocho elementos en orden ascendente y descendente.

v9 <- c(1, 2, 3, 4, 5, 6, 7, 8)
v9
sort(v9,decreasing = FALSE)
sort(v9,decreasing = TRUE)

#6. Probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

v10 <- c(1,2,5,25,35,32)
v10
v10 == 5

#7. Encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos.

v11 <- c(20,14,6,8,2,12,18,16,4,10)
v11
sort(v11)
v11 <- sort(v11,decreasing = TRUE)
v11[2]

#8. Encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos.

v12 <- c(1:10)
v12
n <- 5
v12[n]


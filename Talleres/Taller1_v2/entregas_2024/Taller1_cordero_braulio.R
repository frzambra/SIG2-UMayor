#1. Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.
#Vector tipo numerico
v1 <- seq(from=1, to=10, by=1)
length(v1)
class(v1)
#Vector tipo complejo
v2 <- c(1+2i,1i,9-3i,4+4i,8-6i,1-9i,3+12i,2i,1i,5i)
length(v2)
class(v2)
#Vector tipo logico
v3 <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
length(v3)
class(v3)
#Vector tipo de caracteres
v4 <- c('a','b','c','d','e','f','g','h','i','j')
length(v4)
class(v4)
#2. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.
vv1 <- 1L:5L
class(vv1)
vv2 <- 5L:1L
class(vv2)
vv3 <- vv1+vv2
length(vv3)
#3. Calcular la suma, la media y el producto de un vector con 10 elementos.
v5 <- 1:10
sum(v5) #suma
mean(v5) #media
prod(v5) #producto
#4. Calcular la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.
v6 <- c(1, NA, 3, 4, 5, NA, NA, 8, 9, 10)
sum(v6, na.rm = TRUE) #suma
mean(v6, na.rm = TRUE ) #media
prod(v6, na.rm = TRUE ) #producto
#5. Escriba un programa en R para ordenar un vector con 8 elementos en orden ascendente y descendente 
vv4 <- c(8,5,3,7,6,2,1,4) 
orden_ascendente <- sort(vv4)
print(orden_ascendente)
orden_descendente <- sort(vv4, decreasing = TRUE)
print(orden_descendente)
#6. Escriba un programa en R para probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 especifico.
vv5 <- c(1, 2, 5, 25, 35, 32)
vv5 == 5
class(vv5)
#7. Escriba un programa R para encontrar el segundo valor mas alto en un vector numerico dado que contiene 10 elementos
vv6 <- c(1, 4, 2, 3, 7, 8, 9, 5, 10, 6)
sort(vv6, decreasing = TRUE)
vv6 <-  sort(vv6, decreasing = TRUE)
vv6[2]
#8. Encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos. 
vv7 <- 1:10
n <- 10
vv7[n]

# Taller 1 
# Fecha 19 de agosto
# Integrantes : Victoria alvarado y Vicente Zúñiga 

# 1) Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

V1 <- seq(from =1,to = 10, by = 1)
length(V1)
class(V1)


V2 <- c(1+2i, 4+25i, 2+5i,9+2i,2+3i,1+8i,10+45i+24+2i,12+5i,24+3i,45+2i)
length(V2)
class(V2)

V3 <-c(TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE)
length(V3)
class(V3)

V4 <- c('a','a','a','a','a','a','a','a','a','a')
length(V4)
class(V4)

# 2) Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.

V5 <- 1L:5L
V6 <- 1L:5L
V7 <- (V5+V6)
class(V7)
length(V7)

# 3) Calcular la suma, la media y el producto de un vector con 10 elementos.

V8 <- c(1,2,3,4,5,6,7,8,9,10)

sum(V8)
mean(V8)
prod(V8)
length(V8)
class(V8)

# 4) Calcular la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

V9 <- c(10,20,NA,40,50,NA,70,80,NA,100)

sum(V9,na.rm = TRUE)
mean(V9,na.rm = TRUE)
prod(V9,na.rm = TRUE)
length(V9)
class(V9)

# 5) Ordenar un vector con ocho elementos en orden ascendente y descendente.

V10 <- c(9,3,2,5,10,7,6,1)
sort(V10,decreasing = TRUE)
sort(V10,decreasing = FALSE)
length(V10)
class(V10)

# 6) Probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

V11 <- c(1,2,5,25,35,32)

V11 == 5


# 7) Encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos.

V12 <- c(1,2,3,4,5,6,7,8,9,10)

V12 <- sort(V12,decreasing = TRUE)
V12 [2]
length(V12)

# 8) Encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos. 

V13 <- 1:10
n <- 9 
V13 [n]
length(V13)

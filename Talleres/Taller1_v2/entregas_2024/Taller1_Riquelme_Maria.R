#Taller 1
# Fecha: 19 de agosto 2024
# Nombre: Maria Jose Riquelme

# 1. Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

v1 <- 1:10
class(v1)
length(v1)


a <- c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE)
class(a)
length(a)

g <- c('A', 'B', 'C', 'D', 'E','F', 'G', 'H', 'I','J')
class(g)
length(g)

# 2. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.

j <- 1:5
k <- 5:1
j
k
j+k

# 3. Escriba un programa en R para encontrar la suma, la media y el producto de un vector con 10 elementos.

e <- 1:10
e
sum(e)
mean(e)
prod(e)

# 4. Escriba un programa R para encontrar la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

vv1 <- c(1,2,3,4,NA,5,6,NA,7,NA)
vv1
length(vv1)

sum(vv1,na.rm = TRUE)
mean(vv1, na.rm= TRUE)
prod(vv1, na.rm = TRUE)

# 5. Escriba un programa en R para ordenar un vector con 8 elementos en orden ascendente y descendente.
r <- c(1:8)
sort(r)
sort(r, decreasing = TRUE)

# 6. Escriba un programa R para probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

r <- c(1,2,5,25,35,32)
r==5

# 7. Escriba un programa R para encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos.

p <- c(1,8,10,12,14,15,16,20,22,23)
length(p)
sort(p, decreasing = TRUE)[2]
# 8. Escriba un programa en R para encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos.

o <- c(23, 4, 5, 6, 60, 30, 50, 40, 44, 32)
n <- 5
length(o)
o[n]
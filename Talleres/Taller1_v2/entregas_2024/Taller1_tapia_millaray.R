# Solución Taller 1
# Fecha: 26-08-2024
# Integrantes:
  # Paz_Mayo
  # Millaray_Tapia

#1. Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

# Vector numeric
v1 <- c(1,2,3,4,5,6,7,8,9,10)
class(v1)
length(v1)

# Vector Complejo
v2 <- c(1+3i,2+3i,3+3i,4+3i,5+3i,6+3i,7+3i,8+3i,9+3i,10+3i)
class(v2)
length(v2)

# Vector Logico
v3 <- c(TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE)
class(v3)
length(v3)

# Vector Character
v4 <- c('a','b','c','d','e','f','g','h','i','j')
class(v4)
length(v4)


#2. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.

# Entero
v5 <- c(1,2,3,4,5)
class(v5)
v6 <- as.integer(v5)
class(v6)

v7 <- c(seq(1,10,2))
class(v7)
length(v7)
v8 <- as.integer(v7)
class(v8)

v9 <- v6+v8
class(v9)

#3. Escriba un programa en R para encontrar la suma, la media y el producto de un vector con 10 elementos.

v10 <- c(1,2,3,4,5,6,7,8,9,10)

#suma
sum(v10)

#media
median(v10)

#producto
prod(v10)

# 4. Escriba un programa R para encontrar la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

v11 <- c(1,2,3,4,5,6,7,NA,NA,NA)
class(v11)
length(v11)

sum(v11,na.rm = TRUE)

# 5. Escriba un programa en R para ordenar un vector con 8 elementos en orden ascendente y descendente.

v12 <- c(4,2,6,3,7,5,1,8)

# Ascendente
sort(v12)

# Desendente
sort(v12, decreasing = TRUE)


# 6. Escriba un programa R para probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

v13 <- c(1,2,5,15,35,32)
v13
v13 == 5


# 7. Escriba un programa R para encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos.

v14 <- c(1,2,3,4,5,6,7,8,9,10)
r1 <- sort(v14, decreasing = TRUE)

r1[2]


# 8. Escriba un programa en R para encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos.

n <- 8
v15 <- c(5,3,7,1,9,2,8,4,6,10)
r2 <- sort(v15)
r2[n]


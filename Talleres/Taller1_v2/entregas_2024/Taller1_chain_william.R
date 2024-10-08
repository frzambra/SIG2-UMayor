setwd("C:/Users/olfue/OneDrive/Documentos/R_cosas/R_clases/")

# TALLER 1
# FECHA: 26 DE AGOSTO
# INTEGRANTES:
# ANDRES MARTIN
# WILLIAM CHAIN

# 1) Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10

#Vector numerico
vector_numeric <- c(1:10)
print(vector_numeric)

#Vector complejo
vector_complex <- complex(real = 1:10, imaginary = 10:1)
print(vector_complex)

#Vector logico
vector_logico <- vector("logical", 10)
print(vector_logico)


# 2) Sumar dos vectores de tipo entero y longitud 5
v1 <- c(2, 4, 6, 8, 10)
v2 <- c(1, 3, 5, 7, 9)
suma_v <- v1+v2


# 3) Calcular la suma, la media y el producto de un vector con 10 elementos
v3 <- c(v1, v2)
sum(v3) #suma de los elementos de v3
mean(v3) #promedio de los elementos de v3
prod(v3) #producto (multiplicación) de todos los elementos de v3


# 4) Calcular la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos NA
v4 <- c(6, 2, NA, NA, 7, 5, NA, 3, 1, 8)
sum(v4, na.rm = TRUE)
mean(v4, na.rm = TRUE)
prod(v4, na.rm = TRUE)


# 5) Ordenar un vector con ocho elementos en orden ascendente y descendente
v5 <- c(56, 29, 4, 9, 16, 37, 5, 83)
sort(v5, decreasing = TRUE)


# 6) Probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico
v6 <- c(1, 2, 5, 25, 35, 32)
v6 == 5


# 7) Encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos
print(v3)
sort(v3, decreasing = TRUE)
v3[10]


# 8) Encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos
n <- 3
v3[n]

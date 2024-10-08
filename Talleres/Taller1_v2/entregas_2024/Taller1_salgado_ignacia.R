# TALLER 1 
# Fecha: 19 Agosto 2024
# Integrantes:
# Integrante 1 Ignacia Salgado
# Integrante 2 Barbara Pereira

# Vectores
# 1. Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

x <- vector("numeric", 10)
class(x)
length(x)

c <- vector("complex", 10)
class(x)
length(x)

L <- vector("logical", 10)
class(x)
length(x)

character <- vector("character", 10)
class(x)
length(x)

# 2. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 5.

x <- c(1,2,3,4,5)
y <- c(6,7,8,9,10)
x
y  
x+y

#3. Calcular la suma, la media y el producto de un vector con 10 elementos. Ayuda: revisar las funciones mean, sum y prod.

v <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
suma <- sum(v)
media <- mean(v)
producto <- prod(v)
cat("Suma:", suma, "\n")
cat("Media:", media, "\n")
cat("Producto:", producto, "\n")

# 4. Calcular la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

v1 <- c(2, 4, NA, 8, 10, NA, 14, NA, 18, 20)
suma <- sum(v1, na.rm = TRUE)
media <- mean(v1, na.rm = TRUE)
producto <- prod(v1, na.rm = TRUE)
cat("Suma:", suma, "\n")
cat("Media:", media, "\n")
cat("Producto:", producto, "\n")

#5. Ordenar un vector con ocho elementos en orden ascendente y descendente. Ayuda: revisar la función sort

vector1 <- c(25, 7, 18, 3, 42, 11, 9, 30)
orden_ascendente <- sort(vector1)
orden_descendente <- sort(vector1, decreasing = TRUE)
cat("Vector1 en orden ascendente:", orden_ascendente, "\n")
cat("Vector1 en orden descendente:", orden_descendente, "\n")

#6. Probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico. Ayuda: Probar con operadores lógicos.

vector <- c(1, 2, 5, 25, 35, 32)
contiene_cinco <- vector == 5
cat("El vector contiene el elemento 5:", any(contiene_cinco), "\n")

#7. Encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos. Ayuda: Ver la función sort. El operador [] permite extraer un elemento de un vector

v2 <- c(15, 8, 23, 42, 5, 37, 12, 29, 31, 9)
vector_ordenado <- sort(v2, decreasing = TRUE)
segundo_mas_alto <- vector_ordenado[2]
cat("El segundo valor más alto en el vector es:", segundo_mas_alto, "\n")

#8. Encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos. Ayuda: Probar con la función sort

v3 <- 1:10
n <- 4 
vector_ordenado <- sort(v3)
enesimo_valor_mas_alto <- vector_ordenado[n]
cat("El", n, "ésimo valor más alto en el vector es:", enesimo_valor_mas_alto, "\n")
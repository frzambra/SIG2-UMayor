# Taller 2
# Data.frames <- cada fila corresponde a una observacion y cada columna a una variable 

# 3.1 (1)
df <- data.frame()

#(2)
v1 <- letters[1:5]
#letters pre objeto de R que tiene disponible el abecedario 
v2 <- month.abb[1:5]
v3 <- c(TRUE,FALSE,FALSE,TRUE,TRUE)
v4 <- 1:5

df2 <- data.frame(letras=v1,meses=v2,logico=v3,numeros=v4)

str(df2)
df2

#(3)
df2$meses

df2[,"meses"]

df2[,2]
#distintos tipos de columnas como escribirla

#(4)
df <- iris[1:5,1:5]
df <- iris[1:5.]
df

df3 <- df[c(3,5),c(1,3)]
df3

#(5)
df$Species

df[,5]

#para eliminar una variable por nombre usamos NULL
df$Species <- NULL

df

#(6)
iris$nueva_variable <- 1:150
names(iris)
str(iris)

#(7) 
data <- data.frame(
  Nombre = c("Juan", "Ana", "Luis", "María", "Pedro"),
  Edad = c(25, 30, 22, 28, 35),
  Puntuacion = c(80, 95, 70, 88, 92)
)

print("Data.frame original:")
print(data)

data_ordenado <- data[order(data$Edad, data$Puntuacion), ]

print("Data.frame ordenado:")
print(data_ordenado)


#(8)
dataframe1 <- data.frame(ID = 1:5, Nombre = c("Juan", "Ana", "Luis", "María", "Pedro"))
dataframe2 <- data.frame(ID = 3:7, Puntuacion = c(80, 95, 70, 88, 92))

union_interna <- merge(dataframe1, dataframe2, by = "ID", all = FALSE)

union_externa <- merge(dataframe1, dataframe2, by = "ID", all = TRUE)

union_izquierda <- merge(dataframe1, dataframe2, by = "ID", all.x = TRUE)

union_derecha <- merge(dataframe1, dataframe2, by = "ID", all.y = TRUE)

print("Unión Interna:")
print(union_interna)

print("Unión Externa:")
print(union_externa)

print("Unión Izquierda:")
print(union_izquierda)

print("Unión Derecha:")
print(union_derecha)


#(9)
data <- data.frame(
  A = c(1, 2, NA, 4, 5),
  B = c(NA, 2, 3, NA, 5),
  C = c(1, 2, 3, 4, NA)
)

data_sin_na <- data

data_sin_na[is.na(data_sin_na)] <- 3

print(data_sin_na)

#(10)
data <- data.frame(
  Nombre = c("Juan", "Ana", "Luis"),
  Edad = c(25, 30, 22),
  Puntuacion_Matematicas = c(80, 95, 70)
)

print("Data.frame original:")
print(data)

nuevos_nombres <- c("NombreCompleto", "Anios", "PuntuacionMatematicas")
colnames(data) <- nuevos_nombres

print("Data.frame con nuevos nombres de columna:")
print(data)

#11
dataframe1 <- data.frame(
  ID = 1:5,
  Nombre = c("Juan", "Ana", "Luis", "María", "Pedro")
)

dataframe2 <- data.frame(
  ID = 3:7,
  Nombre = c("Luis", "María", "Carlos", "Sofía", "Elena")
)

filas_no_comunes <- setdiff(dataframe1, dataframe2)

print("Filas en dataframe1 que no están en dataframe2:")
print(filas_no_comunes)

#12
dataframe1 <- data.frame(
  ID = 1:5,
  Nombre = c("Juan", "Ana", "Luis", "María", "Pedro")
)

dataframe2 <- data.frame(
  ID = 3:7,
  Nombre = c("Luis", "María", "Carlos", "Sofía", "Elena")
)

elementos_comunes <- intersect(dataframe1$ID, dataframe2$ID)

print("Elementos comunes en dataframe1 y dataframe2:")
print(elementos_comunes)

#13
dataframe1 <- data.frame(
  ID = 1:5,
  Nombre = c("Juan", "Ana", "Luis", "María", "Pedro")
)

dataframe2 <- data.frame(
  ID = 3:7,
  Nombre = c("Luis", "María", "Carlos", "Sofía", "Elena")
)

elementos_unicos_df1 <- unique(dataframe1$ID)

elementos_unicos_df2 <- unique(dataframe2$ID)

elementos_comunes_unicos <- union(
  intersect(elementos_unicos_df1, dataframe2$ID),
  intersect(elementos_unicos_df2, dataframe1$ID)
)

print("Elementos comunes que aparecen solo una vez:")
print(elementos_comunes_unicos)

#14
data <- data.frame(
  ID = 1:5,
  Nombre = c("Juan", "Ana", "Luis", NA, "Pedro"),
  Edad = c(25, 30, NA, NA, 35)
)

columna <- "Edad"
na_count <- sum(is.na(data[, columna]))

cat("Número de valores NA en la columna", columna, ":", na_count, "\n")

#15
vector1 <- c("A", "B", "C", "A", "D")
vector2 <- c(1, 2, 3, 2, 4)

data <- data.frame(Vector1 = vector1, Vector2 = vector2)

elementos_duplicados <- data[duplicated(data) | duplicated(data, fromLast = TRUE), ]

cat("Elementos duplicados en el data.frame:\n")
print(elementos_duplicados)

filas_unicas <- subset(data, !duplicated(data) & !duplicated(data, fromLast = TRUE))

cat("\nFilas únicas en el data.frame:\n")
print(filas_unicas)

#16
data(airquality)

cat("Conjunto de datos original:\n")
print(head(airquality))

airquality <- airquality[, !(names(airquality) %in% c("Solar.R", "Wind"))]

cat("\nConjunto de datos después de eliminar 'Solar.R' y 'Wind':\n")
print(head(airquality))

#17
data(airquality)

if (is.data.frame(airquality)) {
  cat("Sí, 'airquality' es un marco de datos.\n")
} else {
  cat("'airquality' no es un marco de datos.\n")
}

airquality_ordenado <- airquality[order(airquality$Month, airquality$Day), ]

cat("\nConjunto de datos 'airquality' ordenado:\n")
print(head(airquality_ordenado))

#3.2 Listas
#(1)
# Crear un vector
mi_vector <- c(1, 2, 3, 4)

# Crear una matriz
mi_matriz <- matrix(1:6, nrow = 2)

# Crear otra lista con elementos
mi_otra_lista <- list("Manzana", 5, c("Rojo", "Verde"))

# Crear una lista que contenga los elementos anteriores y asignar nombres
mi_lista <- list(MiVector = mi_vector, MiMatriz = mi_matriz, MiOtraLista = mi_otra_lista)

# Imprimir la lista con nombres de elementos
print(mi_lista)

#2
# Crear un vector
mi_vector <- c(1, 2, 3, 4)

# Crear una matriz
mi_matriz <- matrix(1:6, nrow = 2)

# Crear otra lista con elementos
mi_otra_lista <- list("Manzana", 5, c("Rojo", "Verde"))

# Crear una lista que contenga los elementos anteriores y asignar nombres
mi_lista <- list(MiVector = mi_vector, MiMatriz = mi_matriz, MiOtraLista = mi_otra_lista)

# Acceder al primer elemento de la lista
primer_elemento <- mi_lista[[1]]

# Acceder al segundo elemento de la lista
segundo_elemento <- mi_lista[[2]]

# Imprimir los elementos accedidos
cat("Primer elemento de la lista:\n")
print(primer_elemento)

cat("\nSegundo elemento de la lista:\n")
print(segundo_elemento)

#3
# Crear un vector
mi_vector <- c(1, 2, 3, 4)

# Crear una matriz
mi_matriz <- matrix(1:6, nrow = 2)

# Crear otra lista con elementos
mi_otra_lista <- list("Manzana", 5, c("Rojo", "Verde"))

# Crear una lista que contenga los elementos anteriores
mi_lista <- list(MiVector = mi_vector, MiMatriz = mi_matriz, MiOtraLista = mi_otra_lista)

# Imprimir la lista original
cat("Lista original:\n")
print(mi_lista)

# Agregar un elemento al final de la lista utilizando la función c()
nuevo_elemento <- "Nuevo elemento"
mi_lista <- c(mi_lista, NuevoElemento = nuevo_elemento)

# Imprimir la lista actualizada
cat("\nLista después de agregar un elemento usando c():\n")
print(mi_lista)

# Crear una nueva lista con el elemento a agregar
nuevo_elemento_2 <- "Otro nuevo elemento"
mi_lista <- append(mi_lista, list(NuevoElemento2 = nuevo_elemento_2))

# Imprimir la lista actualizada
cat("\nLista después de agregar un elemento usando append():\n")
print(mi_lista)

#4
# Crear una lista anidada
mi_lista_anidada <- list(
  uno = c(1, 2, 3),
  dos = list(
    a = "Manzana",
    b = "Banana"
  ),
  tres = matrix(1:6, nrow = 2)
)

# Seleccionar el segundo elemento de la lista anidada
segundo_elemento <- mi_lista_anidada$dos

# Imprimir el segundo elemento
cat("Segundo elemento de la lista anidada:\n")
print(segundo_elemento)

#5
# Crear dos listas
lista1 <- list(a = 1, b = 2, c = 3)
lista2 <- list(d = 4, e = 5, f = 6)

# Fusionar las dos listas en una lista única
lista_fusionada <- c(lista1, lista2)

# Imprimir la lista fusionada
cat("Lista fusionada:\n")
print(lista_fusionada)

#6
# Crear una lista
mi_lista <- list(a = 1, b = 2, c = 3)

# Convertir la lista en un vector
mi_vector <- unlist(mi_lista)

# Imprimir el vector resultante
cat("Vector resultante:\n")
print(mi_vector)

#7
# Crear un data.frame de ejemplo
dataframe1 <- data.frame(
  Nombre = c("Juan", "Ana", "Luis"),
  Edad = c(25, 30, 22)
)

# Crear otro data.frame de ejemplo
dataframe2 <- data.frame(
  Nombre = c("María", "Pedro", "Sofía"),
  Edad = c(28, 35, 29)
)

# Crear una lista de data.frames
lista_dataframes <- list(Dataframe1 = dataframe1, Dataframe2 = dataframe2)

# Acceder al primer data.frame de la lista
primer_dataframe <- lista_dataframes[[1]]

# Imprimir el primer data.frame
cat("Primer data.frame de la lista:\n")
print(primer_dataframe)

# Acceder al segundo data.frame de la lista
segundo_dataframe <- lista_dataframes[[2]]

# Imprimir el segundo data.frame
cat("\nSegundo data.frame de la lista:\n")
print(segundo_dataframe)

#8
# Crear una lista de ejemplo
mi_lista <- list(1, "Hola", c(2, 4, 6), data.frame(x = 1:3, y = c("A", "B", "C")))

# Contar el número de objetos en la lista
numero_de_objetos <- length(mi_lista)

# Imprimir el número de objetos
cat("Número de objetos en la lista:", numero_de_objetos, "\n")

#9
# Crear una matriz de ejemplo
mi_matriz <- matrix(1:6, nrow = 2)

# Convertir la matriz en una lista
mi_lista <- as.list(mi_matriz)

# Imprimir la lista resultante
cat("Lista resultante:\n")
print(mi_lista)

#10
# Crear una lista de ejemplo
mi_lista <- list(a = 1, b = 2, c = 3)

# Asignar NULL a un elemento de la lista usando [[]]
mi_lista[['b']] <- NULL

# Imprimir la lista actualizada
cat("Lista después de asignar NULL a 'b':\n")
print(mi_lista)

# Crear otra lista de ejemplo
mi_lista2 <- list(x = "Manzana", y = "Banana", z = "Cereza")

# Asignar NULL a un elemento de la lista usando $
mi_lista2$y <- NULL

# Imprimir la segunda lista actualizada
cat("\nSegunda lista después de asignar NULL a 'y':\n")
print(mi_lista2)

#11
# Crear una lista con una secuencia de letras mayúsculas
s <- list(LETTERS[5:19])

# Imprimir la lista
cat("Lista de letras mayúsculas:\n")
print(s)

#12
# Crear una lista de ejemplo
mi_lista <- list(1, 2, 3)

# Asignar nuevos nombres "a", "b" y "c" a los elementos de la lista
names(mi_lista) <- c("a", "b", "c")

# Imprimir la lista con los nuevos nombres
cat("Lista con nuevos nombres:\n")
print(mi_lista)

#13
# Crear una lista de ejemplo con tres vectores
mi_lista <- list(c(1, 2, 3), c(4, 5, 6), c(7, 8, 9))

# Obtener la longitud de los dos primeros vectores
longitud_vector1 <- length(mi_lista[[1]])
longitud_vector2 <- length(mi_lista[[2]])

# Imprimir la longitud de los vectores
cat("Longitud del primer vector:", longitud_vector1, "\n")
cat("Longitud del segundo vector:", longitud_vector2, "\n")

#14
# Crear dos listas de ejemplo
lista1 <- list(1, 2, 3, 4, 5)
lista2 <- list(3, 4, 6, 7, 8)

# Encontrar elementos en lista1 que no están en lista2
elementos_no_comunes <- setdiff(lista1, lista2)

# Imprimir los elementos no comunes
cat("Elementos en lista1 que no están en lista2:\n")
print(elementos_no_comunes)

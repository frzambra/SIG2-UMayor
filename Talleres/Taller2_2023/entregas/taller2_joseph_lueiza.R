#TALLER 2

#Integrantes:
#Ignacio Varela
#Joshep Lueiza


#1 Escriba un programa en R para crear un data.frame vacío.
df <- data.frame() # en las columnas estan las variables, en las filas estan las observaciones
df
class(df)

#2 Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.

v1 <- letters[1:5] # es un objeto pre almacenado, viene por defecto
v2 <- month.abb[1:5]
v2
v3 <- c(TRUE,FALSE,FALSE,TRUE,FALSE) #TODOS DEBEN TENER LA MISMA CANTIDAD DE ELEMENTOS
v3
v4 <- 1:5

df2 <- data.frame(letters=v1,
                  meses= v2,
                  logico=v3,
                  numero=v4)

str(df2) # nos dice el n° de variables y observaciones

v1
v2

#3 Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.

#como extraer la columna F


df2$meses  # para encontrar una columna especifica
df2[,'meses']  #[fila,columna]
df2[,2]   # nos extrae la columna 2
class(df2['meses']) #para saber que tipo de objeto del elemento



#4 Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.

df <- iris [1:10,1:5]  # extraer solamente un cuadro de filas y columnas
df

df <- iris[1:5,1:5]
df
df2<- df[c(3,5),c(1,3)]# ingresando un vector se obtiene las filas y columnas pedidas

df2


#5 Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.

df$Species # es lo mismo que la INDEXACIÓN DE df['Species]  y df[,$] 

df$Species <- NULL # PARA ANULAR 'Species'
df
df[,c('Sepal.Length','Petal.Length')] <- NULL
df
str(df)

df[-c(2,5),]


#6 Escriba un programa en R para agregar una nueva columna en un marco de datos determinado.

iris$le <- 1:150  #para agregar variables(columnas)
str(iris)
names(iris)
iris$le
head(iris$le)
str(iris$le)


#7 Escriba un programa en R para ordenar un data.frame dado por varias columnas.


df1 <- data.frame(
  ID = c(1, 2, 3, 4, 5),
  Nombre = c("Juan", "María", "Pedro", "Ana", "Luis")
)
df1
df2 <- data.frame(
  ID = c(2, 3, 4, 6, 7),
  Ciudad = c("Nueva York", "París", "Londres", "Tokio", "Roma")
)
df2

#interna
union_interna <- merge(df1, df2, by = "ID")
union_interna
#externa
externa <- merge(df1, df2, by = "ID", all = TRUE)
externa

#izquierda
izquierda <- merge(df1, df2, by = "ID", all.x = TRUE)
izquierda

#derecha
derecha <- merge(df1, df2, by = "ID", all.y = TRUE)
derecha


#9 Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.
datitaframe <- data.frame(
  A = c(1, 2, NA, NA, 5),
  B = c(NA, 3, 3, NA, 6),
  C = c(1, NA, 3, 4, 5)
)

df <- data.frame(ID= c(1,2,3), name='pedro','juan','diego')
df

df <- iris
df

#10 Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.
df <- data.frame(
  Nombre = c("HECTOR", "JOSHEP", "BASTIAN"),
  Edad = c(10, 30, 40),
  Puntuación = c(33, 90, 35)
)

df
nuevos_nombres <- c("NombreCompleto", "Años", "notas")
colnames(df) <- nuevos_nombres  #para cambiar modificar nombres de columnas
df

#11 Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)

dfone <- data.frame(
  ID = c(1, 2, 3, 4, 5),
  Nombre = c("Juan", "María", "Luis", "Ana", "Pedro")
)
dfone
dftwo <- data.frame(
  ID = c(3, 4, 6),
  Nombre = c("Luis", "Ana", "Carlos")
)
dftwo

filas_distintas <- setdiff(df1, df2)  #para encontrar la diferencia de dos dataframes

filas_distintas


#12 Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)

df1 <- data.frame(
  ID = c(1, 2, 3, 4, 5),
  Nombre = c("Juan", "María", "Pedro", "Ana", "Luis")
)

df2 <- data.frame(
  ID = c(2, 3, 4, 6, 7),
  Ciudad = c("Nueva York", "París", "Londres", "Tokio", "Roma")
)
df2
# Extraer la columna "ID" como vectores
vector1 <- df1$ID
vector1
vector2 <- df2$ID
vector2

#13 Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)

elementos_comunes_una_vez <- union(intersect(df1$ID, df2$ID), intersect(df2$ID, df1$ID))
elementos_comunes_una_vez


#14 Escriba un programa R para contar el número de valores NA en una columna de data.frames.
data_NA <- data.frame(
  Columna1 = c(1, 2, 3, NA, 5),
  Columna2 = c(NA, 2, NA, 4, 5)
)

#para saber el nº de na 
num_na <- sum(is.na(data_NA$Columna1))
num_na



#15 Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)

vector55 <- c(1, 2, 3, 4, 8, 7)
vector55
vector56 <- c("A", "B", "C", "D", "E", "f")
vector56

df <- data.frame(vector55 = vector55, Vector56 = vector56)  #para combinar dos dataframes
df

elementos_duplicados <- df[duplicated(df) | duplicated(df, fromLast = TRUE), ] #para encontrar elementos multiplicados del dataframe # se usa  "|" para decir "y"
elementos_duplicados
filas_unicas <- df[!duplicated(df) & !duplicated(df, fromLast = TRUE), ]
filas_unicas




#16 Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.

data(airquality)
airquality

# Eliminar las variables 'Solar.R' y 'Wind'
airquality_rem <- airquality[, !(names(airquality) %in% c('Solar.R', 'Wind'))]

airquality_rem



#17 Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)

data(airquality)
airquality


# Comprobar si "airquality" es un marco de datos
if (is.data.frame(airquality)) {
  print("airquality es un marco de datos.")
} else {
 "airquality no es un marco de datos."
}

# Ordenado primera y segunda columna
airquality_ordenado <- airquality[order(airquality$Ozone, airquality$Solar.R), ]
airquality_ordenado




# 3.2 Listas



#1 Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.

vector <- c(1, 2, 3, 4)

#matriz
matriz <- matrix(1:8, nrow = 4, ncol = 4)
matriz

#lista
lista <- list(a = "Taller1", b = "Taller2", c = "Taller3")
lista

# Lista con asignacion de nombre
mi_lista <- list(vector = vector, matriz = matriz, otra_lista = lista)
mi_lista


#2 Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.

vector <- c(3, 6, 9)
vector

mi_matriz <- matrix(1:6, nrow = 2)
mi_matriz

lista2 <- list("A", "B", "C")
lista2
mi_lista_principal <- list(vector = vector, matriz = mi_matriz, otra_lista = lista2)

names(mi_lista_principal) <- c("MiVector", "MiMatriz", "MiOtraLista")
mi_lista_principal


primer_elemento <- mi_lista_principal$MiVector
primer_elemento

segundo_elemento <- mi_lista_principal$MiMatriz
segundo_elemento




#3 Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.

vector <- c(1, 2, 3, 4)

#matriz
matriz <- matrix(1:8, nrow = 4, ncol = 4)
matriz

#lista
lista <- list(a = "Taller1", b = "Taller2", c = "Taller3")
lista

# Lista con asignacion de nombre
mi_lista <- list(vector = vector, matriz = matriz, otra_lista = lista)
mi_lista

elemento_agregado <- "nuevo"
mi_lista <- c(mi_lista, elemento_agregado)
mi_lista



#4 Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.

lista_anidada <- list(
  lista_externa_1 = list("F", "E", "S"),
  lista_externa_2 = list(3, 5, 7)
)


segundo_elemento <- lista_anidada$lista_externa_2[[2]]
segundo_elemento

#5 Escriba un programa R para fusionar dos listas dadas en una lista.

lista1 <- list(a = 1, b = 2, c = 3)
lista1
lista2 <- list(d = 4, e = 5, f = 6)
lista2

#Fusión
lista_com <- c(lista1, lista2)
lista_com

#6 Escriba un programa en R para convertir una lista dada en vector.
lista6 <- list(1, 2, 3, 4, 5)


vectorlista6 <- unlist(lista6) #para convetir una lista en vector
vectorlista6

#7 Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.

df1 <- data.frame(
  Nombre = c("MARIO", "PEDRO", "VARELA"),
  Edad = c(42, 24, 99)
)
df1

df2 <- data.frame(
  Producto = c("Lechugas", "Limones", "Berengenas"),
  Precio = c(1.1, 1.8, 1.9)
)
df2

# Crear una lista que contenga los data.frames
lista_dataframes <- list(df1, df2)
lista_dataframes

# Acceder a cada data.frame en la lista
primer_data_frame <- lista_dataframes[[1]]
segundo_data_frame <- lista_dataframes[[2]]
primer_data_frame
segundo_data_frame

#8 Escriba un programa R para contar el número de objetos en una lista dada.


lista8 <- list(1, 1, "v", "v", TRUE, TRUE)
lista8
n_obj <- length(lista8)  # se usa length para saber el numero de objetos
n_obj


#9 Escriba un programa en R para convertir una matriz dada en una lista.

matriz9 <- matrix(1:6, nrow = 2, ncol =6)
matriz9
# matriz a lista
lista9 <- as.list(mi_matriz)
lista9


#10 Escriba un programa R para asignar NULL a un elemento de lista dado.

lista10 <- list(a = 1, b = 2, c = 3)
lista10
lista10$c <- NULL
lista10

#11 Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.


secuencia_letras <- LETTERS 
secuencia_letras

letras_seleccionadas <- secuencia_letras[5:19]



Lista5a19 <- list(letras = letras_seleccionadas)
Lista5a19


#12 Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.

lista12 <- list(x= 1, y= 2, z= 3)
lista12

newname <- c("a", "b", "c")
names(lista12) <- newname #para asignar, colocar nuevos nombres a las variables se usa name
lista12

#13 Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.


lista13 <- list(vector1 = c(1, 2, 3, 4, 5, 6), vector2 = c(4, 5, 6, 7), vector3 = c(7, 8, 9))
lista13

#longitud
longitud_vector1 <- length(lista13[[1]])    #length para obtener la longitud
longitud_vector2 <- length(lista13[[2]])
longitud_vector1 
longitud_vector2

#14 Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)

lista14 <- list(1, 2, 3, 4, 5)
lista15 <- list(3, 4, 5, 6, 7)

# Encontrar los elementos que están en lista1 pero no en lista2
elementosdif <- setdiff(lista14, lista15) #setdiff para encontrar elementos de una lista dada que no estan en otra
elementosdif

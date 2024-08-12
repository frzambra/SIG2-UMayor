#Taller 2
#Constanza Araya

#DATA FRAME
#1.Escriba un programa en R para crear un data.frame vacío.
df<-data.frame()
class(df)
df

#2.Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.
v1<-letters[1:5]
v2<-month.abb[1:5]
v3<-c(TRUE,FALSE,FALSE,TRUE,TRUE)
v4<-1:5
df2<-data.frame(letras=v1,meses=v2,logico=v3,numeros=v4)
df2
str(df2)

#3Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.
df2$meses
df2[,"meses"]

#4Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.
df<-iris[1:5,1:5]
df
df[c(3,5),c(1,3)]

#5Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.

#tres maneras de hacer lo mimo con indexacion
df$Sepal.Length
df[,"Species"]
df[,5]
#para eliminar una variable por nombre usamos NULL
df$Species<-NULL
df[,c("Sepal.Lenght","Petal.length")]<-NULL
df
str(df)

#6Escriba un programa en R para agregar una nueva columna en un marco de datos determinado.
iris$nueva_variable<-1:150
str(iris)
cbind(iris,nueva_variable=1:150)


#7Escriba un programa en R para ordenar un data.frame dado por varias columnas.
edad <- c(22, 34, 29, 25, 30, 33, 31, 27, 25, 25)
tiempo <- c(14.21, 10.36, 11.89, 13.81, 12.03, 10.99, 12.48, 13.37, 12.29, 11.92)
sexo <- c("M","H","H","M","M","H","M","M","H","H")
misDatos <- data.frame(edad,tiempo,sexo)
misDatos

set.seed(61)

#8.Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.

set.seed(61)

empleado_id <- 1:10
empleado_nombre <- c("camila", "sebastian", "constanza", "giseth", "Jack",
                     "Jacob", "Mary", "Kate", "Jacqueline", "Ingrid")
empleado_salario <- round(rnorm(10, mean = 1500, sd = 200))
empleado_edad <- round(rnorm(10, mean = 50, sd = 8))
empleado_puesto <- c("Profesor", "Ing.", "Administrativo", rep("Técnico", 7))


df_1 <- data.frame(id = empleado_id[1:8], nombre = empleado_nombre[1:8],
                   salario_mensual = empleado_salario[1:8])
df_2 <- data.frame(id = empleado_id[-5], nombre = empleado_nombre[-5],
                   edad = empleado_edad[-5], cargo = empleado_puesto[-5])
#df1 nombre y salario mensual
#df1 nombre, edad y cargo.

df_1
df_2
merge(x = df_1, y = df_2)
merge(x = df_1, y = df_2, by = c("id", "nombre")) #otra forma


#9.Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.
empresa <-  c("A", "B", NA, NA, "C", "D", NA, NA )
df<-data.frame(empresa)
df 
is.na(empresa)
empresa 
#pendiente

df <- data.frame(col1 = c(1,NA,3), col2 = c(NA,2,5))
df
df[is.na(df)] <- NA
df

#10.Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.

grupos<- factor(c("G1", "G1", "G2", "G2"))
altura<-c(1.67,1.65,1.68, 1.57)
pesos<- c(56,62,68,54)
df<-data.frame(pesos,altura,grupos)

df
colnames(df) <- c('UNO', 'DOS', 'TRES')
df

#11.Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)



dfa <- data.frame(ID = 1:5,Nombre = c("Toyota", "Nissan", "Peugeot", "Audi", "Mercedes"))

dfb <- data.frame(ID = 3:7,Nombre = c("Toyota", "Chevrolet", "Hyundai", "Mercedes", "Kia"))

filas_no_comunes <- setdiff(dfa, dfb)

print("Filas en dataframe1 que no están en dataframe2:")
print(filas_no_comunes)



#12.Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)

dfa <- data.frame(ID = 1:5,Nombre = c("Toyota", "Nissan", "Peugeot", "Audi", "Mercedes"))

dfb <- data.frame(ID = 3:7,Nombre = c("Toyota", "Chevrolet", "Hyundai", "Mercedes", "Kia"))

elementos_comunes <- intersect(dfa$ID, dfb$ID)

print("Elementos comunes en dataframe1 y dataframe2:")
print(elementos_comunes)


#13.Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)

dfa <- data.frame(ID = 1:5,Nombre = c("Toyota", "Nissan", "Peugeot", "Audi", "Mercedes"))

dfb <- data.frame(ID = 3:7,Nombre = c("Toyota", "Chevrolet", "Hyundai", "Mercedes", "Kia"))


elementos_unicos_dfa <- unique(dfa$ID)

elementos_unicos_dfb <- unique(dfb$ID)

elementos_comunes_unicos <- union(intersect(elementos_unicos_dfa, dfb$ID),intersect(elementos_unicos_dfa,dfa$ID))

print("Elementos comunes que aparecen solo una vez:")
print(elementos_comunes_unicos)



#14.Escriba un programa R para contar el número de valores NA en una columna de data.frames.
# Crear  listas 
data_NA <- data.frame(
  Columna1 = c(1, 2, 3, NA, 5,NA,NA),
  Columna2 = c(NA, 2, NA, 4, 5,6,7))

#para saber el nº de na 
num_na <- sum(is.na(data_NA$Columna1))
num_na



#15.Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)

vector1 <- c("A", "B", "C", "A", "D")
vector2 <- c(1, 2, 3, 2, 4)

data <- data.frame(Vector1 = vector1, Vector2 = vector2)

elementos_duplicados <- data[duplicated(data) | duplicated(data, fromLast = TRUE), ]

cat("Elementos duplicados en el data.frame:\n")
print(elementos_duplicados)

filas_unicas <- subset(data, !duplicated(data) & !duplicated(data, fromLast = TRUE))

cat("\nFilas únicas en el data.frame:\n")
print(filas_unicas)

#16.Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.

data(airquality)

cat("Conjunto de datos original:\n")
print(head(airquality))

airquality <- airquality[, !(names(airquality) %in% c("Solar.R", "Wind"))]

cat("\nConjunto de datos después de eliminar 'Solar.R' y 'Wind':\n")
print(head(airquality))



#17.Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)

data(airquality)

if (is.data.frame(airquality)) {
  cat("Sí, 'airquality' es un marco de datos.\n")
} else {
  cat("'airquality' no es un marco de datos.\n")
}

airquality_ordenado <- airquality[order(airquality$Month, airquality$Day), ]

cat("\nConjunto de datos 'airquality' ordenado:\n")
print(head(airquality_ordenado))


#LISTAS

#1Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.
mi_vector <- c(1, 2, 3, 4)

# Crear una matriz
mi_matriz <- matrix(1:6, nrow = 2)

# Crear otra lista con elementos
mi_otra_lista <- list("mazda", 5, c("Audi", "Mercedes"))

# Crear una lista que contenga los elementos anteriores y asignar nombres
mi_lista <- list(MiVector = mi_vector, MiMatriz = mi_matriz, MiOtraLista = mi_otra_lista)

# Imprimir la lista con nombres de elementos
print(mi_lista)

# Imprimir la lista con nombres de elementos
print(mi_lista)

#2Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.
x <- c(45, 12, 56, 14, 16)
y <- list("Coche", "Bicicleta")
z <- matrix(1:12, ncol = 4)

# Creando una lista
mi_lista <- list(x, y, z)
mi_lista

mi_lista_nombres <- list("Vector" = x, "Lista" = y, "Matriz" = z)
mi_lista_nombres

# Primer elemento de la lista
mi_lista[1]

# Segundo elemento de la lista
mi_lista[2]

#3Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.
x <- c(45, 12, 56, 14, 16)
y <- list("Coche", "Bicicleta")
z <- matrix(1:12, ncol = 4)

# Creando una lista
mi_lista <- list(x, y, z)
mi_lista

mi_lista_nombres <- list("Vector" = x, "Lista" = y, "Matriz" = z)
mi_lista_nombres

#Agregar un elemento al final de la lista 
mi_lista[[4]] <- data.frame(X = c(8, 5, 3), Y = c(7, 9, 1))
mi_lista
#4Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.
mi_lista_anidada <- list( uno = c(1, 2, 3), dos = list( a = "Manzana", b = "Banana"), tres = matrix(1:6, nrow = 2))

# Seleccionar el segundo elemento de la lista anidada
segundo_elemento <- mi_lista_anidada$dos

# Imprimir el segundo elemento
cat("Segundo elemento de la lista anidada:\n")
print(segundo_elemento)

#5Escriba un programa R para fusionar dos listas dadas en una lista.
listaA <- list(a = 1, b = 2, c = 3)
listaB <- list(d = 4, e = 5, f = 6)

# Fusionar las dos listas en una lista única
lista_fusionada <- c(listaA, listaB)

# Imprimir la lista fusionada
cat("Lista fusionada:\n")
print(lista_fusionada)
#6Escriba un programa en R para convertir una lista dada en vector.
# Crear una lista
mi_lista <- list(a = 70, b = 28, c = 36)
mi_lista
# Convertir la lista en un vector
mi_vector <- unlist(mi_lista)

# Imprimir el vector resultante
cat("Vector resultante:\n")
print(mi_vector)
#7Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.
dataframe1 <- data.frame(Nombre = c("Audi", "Kia", "Chevrolet"),Año = c(2012, 2020, 2023))
dataframe2 <- data.frame( Nombre = c("Peugeot", "Suzuki", "Toyota"),Año = c(2018, 2014, 2021))
lista_dataframes <- list(Dataframe1 = dataframe1, Dataframe2 = dataframe2)
lista_dataframes[1]
lista_dataframes[2]
#8Escriba un programa R para contar el número de objetos en una lista dada.
x <- c(45, 12, 56, 14, 16)
y <- list("Coche", "Bicicleta")
z <- matrix(1:12, ncol = 4)

# Creando una lista
mi_lista <- list(x, y, z)
mi_lista

# contar los eleemntos de la lista
length(mi_lista)
#9Escriba un programa en R para convertir una matriz dada en una lista.
m<-matrix(1:10,ncol = 2)
m
as.list(m)
#10Escriba un programa R para asignar NULL a un elemento de lista dado.
m<-list(a=1,b=2,c=3)
m
m$b<-"NULL"
m

#11Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.
l<-LETTERS[5:20]
s<-as.list(l)
s

#12Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.
x <- c(45, 12, 56, 14, 16)
y <- c(43, 13, 53, 13, 13)
z <- c(47, 17, 57, 17, 17)

# Creando una lista
mi_lista <- list(x, y, z)
mi_lista

mi_lista_nombres <- list("a" = x, "b" = y, "c" = z)
mi_lista_nombres

#13Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.
mi_lista <- list(c(90, 20, 30,50,70), c(45, 53, 62,80), c(7, 8, 9))
longitudvector1 <- length(mi_lista[[1]])
longitudvector1 
longitudvector2 <- length(mi_lista[[2]])
longitudvector2 

#14Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)
r<-list(c(1,3,6,7,9))
r2<-list(c(2,4,6,8,10))
elementosnocomunes<-setdiff(r,r2)
elementosnocomunes
#
A <- list(1, 2, 3, 4, 5,19,11)
B <- list(3, 4, 6, 7, 8,19)


elementosnocomunes <- setdiff(A, B)
elementosnocomunes

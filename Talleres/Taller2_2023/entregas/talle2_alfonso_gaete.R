#1Escriba un programa en R para crear un data.frame vacío.

df<- data.frame()
class(df)
df

#2Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.

v1<-letters[1:5]
v2<-month.abb[1:5]
v3<-c(TRUE,FALSE,FALSE,TRUE,TRUE)
v4<-1:5

df2<-data.frame(letras=v1,
           meses=v2,
           logico= v3,
           numeros=v4)
df2

str(df2)


#3Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.

df2$meses
df2[,'meses']
df2[,2]

#4Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.

df<- iris[1:5,1:5]
df<- iris[1:5,]

df[c(3,5),c(1,3)]

#5Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.

df$Species
df[ ,'species']
df[,5]

#para eliminiar una variable por nombre usamos NULL

especies<-df$Species
df$species<-NULL

df
df[,c('sepal.length','petal.lenght')]<-NULL
df
str(df)

#6 Escriba un programa en R para agregar una nueva columna en un marco de datos determinado.

iris$nueva_variable<-1:150

#segunda forma

cbind(iris,nueva_variable=1:150)
names(iris)
str(iris)

#7Escriba un programa en R para ordenar un data.frame dado por varias columnas.

c1<-c(3,5,9,1)
c2<-c(4,6,2,7)
c3<-c( 'A', 'B', 'C', 'D')
df<-data.frame(c1,c2,c3)

orden<-order(df$c1, df$c2, df$c3)

dforden<-df[orden,]

dforden

#8Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.

df10 <- data.frame(ID = c(1, 2, 3, 4),
                  Nombre = c("Alice", "Bob", "Charlie", "David"))

df20 <- data.frame(ID = c(2, 3, 5, 6),
                  Edad = c(25, 30, 22, 28))

ui<- merge(df10, df20, by = "ID")

ue <- merge(df10, df20, by = "ID", all = TRUE)

uiz <- merge(df10, df20, by = "ID", all.x = TRUE)

ude <- merge(df10, df20, by = "ID", all.y = TRUE)

ui

ue

uiz

ude



#9Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.

df<- data.frame(
  a=c(1,2,NA,4),
  b=c(NA,2,3,4),
  c=c(1,2,3,NA)
)

df[is.na(df)]<-3

df

#10Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.

df<-data.frame(
  Na1=c(1,2,3),
  Na2=c(4,5,6),
  Na3=c(7,8,9)
)

Nn<-c("Nn1","Nn2","Nn3")
`colnames`(df)<-Nn

df

#11Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff

df1<-data.frame(
  ID=c(1,2,3,4,5),
  Nombre=c("alonso","bastian","isidora","flo","javi")
)

df2<-data.frame(
  ID=c(6,4,8),
  Nombre=c("bruno","flo","alonso")
)

fqf<-setdiff(df1$ID,df2$ID)

fqf

fqf2<-setdiff(df1$Nombre,df2$Nombre)

fqf2


#12Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)

EC<-(intersect(df1$ID,df2$ID))
print(EC)
EC2<-(intersect(df1$Nombre,df2$Nombre))

EC2

#13Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)

elementosunicosdf1 <- df1[!duplicated(df1$ID) & !duplicated(df1$ID, fromLast = TRUE), ]

elementosunicosdf2 <- df2[!duplicated(df2$ID) & !duplicated(df2$ID, fromLast = TRUE), ]


elementoscomunes <- intersect(elementosunicosdf1$ID, elementosunicosdf2$ID)

elementoscomunes

df1
df2
#14Escriba un programa R para contar el número de valores NA en una columna de data.frames.

datos<- data.frame (
  ID=1:5,
  Edad=c(25,30,NA,22,NA),
  Nota=c(80, 75, 90, NA, 88)
  )

columna <- "Edad"

conteo_na <- sum(is.na(datos[, columna]))
cat("Número de valores NA en la columna", columna, ":", conteo_na, "\n")

#15 Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)

v5 <- c("A", "B", "C", "A", "D")
v6 <- c(1, 2, 3, 1, 4)

df5 <- data.frame(C1 = v5, C2 = v6)

df5

dupli <- df5[duplicated(df5) | duplicated(df5, fromLast = TRUE), ]

dupli

uni <- df5[!duplicated(df5) & !duplicated(df5, fromLast = TRUE), ]

uni

#16 Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.

data(airquality)

airquality

airquality <- airquality[, !(names(airquality) %in% c('Solar.R', 'Wind'))]

airquality

#17 Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)

data(airquality)

if (is.data.frame(airquality)) {
  cat("airquality es un marco de datos.\n")
} else {
  cat("airquality no es un marco de datos.\n")
}

airquality <- airquality[complete.cases(airquality[, c("Ozone", "Solar.R")]), ]

airquality <- airquality[order(airquality$Ozone, airquality$Solar.R), ]


airquality


##3.2.Listas
#1.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.
vector <- c("A","B","C")
matriz <-matrix(56:63, nrow = 2, ncol = 4)
lista<-list(vector,matriz)
lista
names(lista)<-c("vector","matriz") 


#2.Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.
lista2 <- list(uno = "Primero", dos = "Segundo", tres = "Tercero")
lista2

lista3<- list(Vector=vector, Matriz=matriz, Lista=lista2)
lista3

primerelemento <- lista3[[1]]
primerelemento

segundoelemento <- lista3[[2]]
segundoelemento

#3.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.

nuevoelemento <- "Elemento"
lista3 <- c(lista3, nuevoelemento)
lista3

#4.Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.
listaanidada <- list(
  uno = c(1, 2, 3),
  dos = matrix(4:11, nrow = 4, ncol = 2),
  tres = list(a = "Jugo", b = "Vaso")
)

listaanidada

segundoelemento2 <- listaanidada[[2]]
segundoelemento2


#5.Escriba un programa R para fusionar dos listas dadas en una lista.
listafusionada <- c(listaanidada, lista3)
listafusionada

#6.Escriba un programa en R para convertir una lista dada en vector.
listaenvector<- unlist(lista3)
listaenvector

#7.Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.
dtfm <- data.frame(Alumno = c("Isidora", "Florencia", "Gastón"),
                   Nota = c(65, 61, 70))

dtfm2 <- data.frame(Alumno = c("Constanza", "Zho", "Tomás"),
                    Nota = c(40, 56,39))
listadedtfm <- list(PrimerDataFrame = dtfm, SegundoDataFrame = dtfm2)
listadedtfm

primerdataframe <-listadedtfm[[1]]
primerdataframe


segundodataframe <-listadedtfm[[2]]
segundodataframe


#8.Escriba un programa R para contar el número de objetos en una lista dada.
nobjetos <- length(listadedtfm)
nobjetos

#9.Escriba un programa en R para convertir una matriz dada en una lista.

matriz
Matrizenlista<- as.list(matriz)
Matrizenlista

#10.Escriba un programa R para asignar NULL a un elemento de lista dado.
listaanidada
listaanidada$dos<-NULL
listaanidada

#11.Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.
letrasmayusculas <- LETTERS[5:19]
s <- list(letras = letrasmayusculas)
s

#12.Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.

listanueva <- list(uno = 1, dos = "Banana", tres = matrix(1:4, nrow = 2))
listanueva 
names(listanueva) <- c("a", "b", "c")


#13.Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.
Lista4 <- list(v1 = c(1, 2, 3, 4, 5),
               v2 = c(6, 7, 8),
               v3 = c(9, 10, 11, 12))

longitudv1 <- length(Lista4[[1]])
longitudv1

longitudv2 <- length(Lista4[[2]])
longitudv2

#14.Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)

lista
lista2
elementosfaltantes <- setdiff(names(lista), names(lista2))
elementosfaltantes











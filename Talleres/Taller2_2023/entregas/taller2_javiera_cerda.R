#Taller 2
#Integrantes:
#Javiera Cerda
#Jadeline Arratia 
#Fecha: 8 septiembre 


#3.1 DATA.FRAME

#1.Escriba un programa en R para crear un data.frame vacío.

df <- data.frame()
class(df)
df

#2.Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.

#se crean cuatro vectores y luego el data frame
v1 <- letters[1:5]
v2 <- month.abb [1:5]
v3 <- c (TRUE,FALSE,FALSE, TRUE, TRUE)
v4 <- 1:5

df2 <- data.frame(letras= v1, meses=v2, logico=v3, numeros =v4)

str(df2)

#Apuntes:
#month.abb:meses del año abreviados
#[]inexando las primeras 5 letras 
#si hay un valor que no esta disponible, se asigna como NA
#str funciona para vectores, matrices, data frame, etc (para cualquier objeto)

#3.Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.

#Hay tres formas de las que se puede hacer:
df2$meses

df2[,"meses"]

df2[,2]


#4.Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.

#crear un data.frame con sub-muestra del data.frame iris que considere las 5 primeras filas y las 5 primeras columnas.Creamos un data.frame dado 
df <- iris[1:5, 1:5]
df

df<- iris[1:5,]
df

#quedando como resultado:
df[c(3,5),c(1,3)]


#5.Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.

#tres maneras de inexar:

df$Species
df [, "Species"]
df [,5]

#para eliminar una variable por nombre usamos NULL 

df$Species <- NULL
df

#se puede eliminar mas de una variable 
df [,c("Sepal.Length", "Petal.Length")] <- NULL
df


#6.Escriba un programa en R para agregar una nueva columna en un data.frame determinado.

iris$nueva_variable <- 1:150
names(iris)
str(iris)


#7.Escriba un programa en R para ordenar un data.frame dado por varias columnas.

#¿sera valido?
?order
df2
order <- df2[order("df2$letras", "df2$meses", "df2$logico", "df2$numeros"),]
order

#respuesta oficial:
iris[order(iris$Sepal.Length,iris$Species),]

#8.Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.

#teniendo en cuenta lo siguiente según el manual:
#all=false (union interna)
#all=true (union externa)
#all.x=true (union izq)
#all.y=true (union derech)

df1 <- data.frame(Peso = c(45,52,47,47), Sexo = c("F", "F", "F", "F"))
df1

df3 <- data.frame(Peso = c(49, 47, 51,52), Edad  = c (30,25,45,67))
df3

#usaremos funcion merge 
?merge
interna <- merge(df1, df3, by = "Peso", all = FALSE)
interna
externa <- merge(df1, df3, by = "Peso", all = TRUE)
externa
izquierda <- merge(df1, df3, by="Peso", all.x = TRUE)
izquierda
derecha <- merge(df1, df3, by= "Peso", all.y = TRUE)
derecha


#o tambien:

df1 = data.frame(ID = c(1,2),
                 X1 = c('a1','a2'))

df2 = data.frame(ID = c(2,3),
                 X2 = c('b1','b2'))
df1
df2

# Unión por la izquierda
resultizq = merge(df1, df2, by = "ID", all.x = TRUE)
resultizq

# Unión por la derecha

resultderech = merge(df1, df2, by = "ID", all.y = TRUE)
resultderech

#Unión interna ")

resultinter = merge(df1, df2, by = "ID", all = FALSE)
resultinter

#Union externa 

resultexter = merge(df1,df2, by = "ID", all = TRUE)
resultexter

?merge

#9.Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.

#se crea un data frame, se ejecuta con valores NA y luego se usa funcion is.na para asignarle el valor de 3 los NA.
df4 <- data.frame("Vuelo" = c(406,NA, 509), "Retraso min."= c(15, 10, NA))
df4

df4[is.na(df4)] <- 3
df4

#profesor indica:
df <- data.frame(col1 = c(1,NA,3), col2 = c(NA,2,5))
df
df[is.na(df)] <- NA
df

#10.Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.

#se ocupa un data frame ya creado anteriormente y se cambia los nombres de la columna gracias a la funcion "names".
df2
names(df2)[names(df2)== "letras"] <- "Abecedario"
names(df2)[names(df2)== "logico"] <- "¿True or False?"
df2

#11.Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)

df1
df3
?setdiff

filas <- setdiff(df1, df3)
filas

#12.Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)

#se eligeron dos data frames creados y gracias a la funcion intersect se sabe aquellos elementos presentes en ambos data frames
?intersect
df1
df3
presentes <- intersect(df1$Peso, df3$Peso)
presentes


#13.Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)

#se eligen dos data frames ya creados, "comunes" seran los elementos que son comunes y "una vez" aquellos elementos que se encuentran solo una vez en ambos data frames.
?union
df1
df3
comunes <- intersect(df1$Peso, df3$Peso)
unavez <- union(setdiff(df1$Peso,comunes), setdiff(df3$Peso, comunes))
comunes
unavez


#14.Escriba un programa R para contar el número de valores NA en una columna de data.frames.

#¿podria funcionar la funcion is.na junto a sum? para contar todos los valores de NA que se encuentren en una columnda del dara.frames

contar <- sum(is.na(df4$Vuelo))
contar

#15.Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)

?duplicated
#duplicated(x, incomparables = FALSE,fromLast = FALSE, nmax = NA, ...)

#mediante dos vectores nuevos creados, se creó un data frame, y gracias a la funcion "duplicated" nos muestra los elementos duplicados y las filas unicas que son de ese data frame (df5)

r1 <- c (14, 19,14,20)
r1
r2 <- month.name [1:4]
r2

df5 <- data.frame(Fechas=r1, Cumpleaños=r2 )
df5

duplicados <- df5 [duplicated(df5), ]
duplicados

filasunicas <- df5 [!duplicated(df5), ]
filasunicas

#16.Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.

airquality
#Variables: ozone, solar.r, wind, temp, month y day, deberia quedar; ozone, temp, month y day 

Sinvariables <- airquality[, !(names(airquality) %in% c("Solar.R", "Wind"))]
Sinvariables

#17.Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)

#¿marco de datos = data.frame? is.data.frame 
?is.data.frame
?order
#order(..., na.last = TRUE, decreasing = FALSE,method = c("auto", "shell", "radix"))

airquality
marcodatos <- is.data.frame(airquality)
marcodatos
#Sí es un marco de datos

ordenado <- order(airquality$Ozone, airquality$Solar.R)
marcodatos <- airquality[marcodatos, ]
marcodatos





#3.2 LISTAS

#1.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.

#lista con vector, matriz y nombres asignados
v1 <- c(1:5)
m1 <- matrix(1:10, nrow = 5, ncol = 2)
l1 <- list(e = "enero",f = "febrero", m = "marzo")
lista <- list(ID = v1, Numeros = m1, Meses= l1)
lista

#2.Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.

primer <- lista$ID
primer

segundo<- lista$Numeros
segundo

#3.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.

lista
nuevo <- "Elemento al final"
lista <- append(lista, list(nuevo = "Elemento al final"))
lista

#4.Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.

l <- list(1:10,list(1,2,3))
l  
l[[2]][2]

l[[2]] #accede al segundo elemento de la lista
l[[2]][2] #accede al segundo elemento de la lista y al segundo elemento de la lista anidada

#5.Escriba un programa R para fusionar dos listas dadas en una lista.

#profesor indica: "Se refiere a unir dos listas. Por ejemplo una lista que tiene 2 elementos con otra que tiene tres elementos, dará como resultado una lista con cinco elementos".

lista6 <- list("Juan espejo", "Providencia", "Gran avenida")
lista6
lista7 <- list(345,670,120)
lista7
fusionar <- c(lista6, lista7)
fusionar

#6.Escriba un programa en R para convertir una lista dada en vector.

?unlist
#an R object, typically a list or vector.
lista1 <- list(Edad= 15, Nombre= "Marcelo", Altura= 165)
v <- unlist(lista1)
v
class(v)

#7.Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.

#creacion de data.frames 

id <- 1:6
sexo <- c('F','F','F','F','M','M')
df <- data.frame(id,sexo)
df

m2 <- month.abb [1:6]
tf <- c (TRUE,FALSE,FALSE, TRUE, TRUE, FALSE)
df1 <- data.frame(m2,tf)
df1

listadf <- list(DataFramePrimero =df, DataFrameSegundo =df1)
listadf

#8.Escriba un programa R para contar el número de objetos en una lista dada.

#uso de funcion lenght para saber el numero de objetos de la lista

lista1 <- list(Edad= 15, Nombre= "Marcelo", Altura= 165)
objetos <- length(lista1)
objetos

#9.Escriba un programa en R para convertir una matriz dada en una lista.

#Una lista que cada elemento de la lista corresponda a cada columna. Ver la función split (?split)

?as.list
m1 <- matrix(1:10, nrow = 5, ncol = 2)
m1
lista3 <- as.list(m1)
lista3

?split
m1
lista8 <- split(m1,1:nrow(m1))
lista8


#10.Escriba un programa R para asignar NULL a un elemento de lista dado.

lista1 <- list(Edad= 15, Nombre= "Marcelo",Altura= 165)
lista1
lista1[["Edad"]] <- NULL
lista1

#11.Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.

#se genera que la secuencia empiece con la e, se usa "for" con los siguientes argumentos: for (variable in vector) 

s <- as.list(LETTERS[5:19])
s

#12.Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.

#uso de funcion "names", para asignar nuevos nombres

l <- list(c(1,3,5),'a',TRUE)
l
names(l) <- c("a", "b", "c")
names(l)

#13.Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.

#se creó una lista, para obtener la longitud use funcion "lenght", y en corchetes ya que se habla de vectores y lista.

lista5 <- list(c(Edad= 15, 16, 19, 19), c(Legal = "NO","NO","SI", "SI"), c(Genero = "Fem", "Mas", "Fem", "Fem"))
lista5

lv1 <- length(lista5[[1]])
lv1

lv2 <- length(lista5[[2]])
lv2


#14.Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)

#seleccioné listas que no tienen mucho en comun, por ende, da como resultado que muestra casi toda la lista.
lista
lista5

elementos <- setdiff(lista,lista5)
elementos


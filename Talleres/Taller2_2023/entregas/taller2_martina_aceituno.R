#taller 2 Martina Aceituno y Esperanza baeza
#3.1 data frame
#1 Escriba un programa en R para crear un data.frame vacío.
#data.frame crea un data.frame 
df<-data.frame()
#muestra el contenido del data.frame
class(df)
df
#2 Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.
v1<-letters[1:5]
v2<-month.abb[1:5]
v3<-c(TRUE,FALSE,FALSE,TRUE,TRUE)
v4<-1:5

# se crea un data.frame a con los 4 vectores anteriores
df2 <- data.frame(letras= v1, meses = v2, logico = v3, numeros = v4)
str(df2)

#3 Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.
# Para extraer la columna "meses" se utiliza el nombre de la columna y $
df2$meses
str(df2)

#4 Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.
df<-iris[1:5, ]
# se extrae la fila 3 y 5 con las columnas 1 y 3 indexando
df4<-df[c(3,5),c(1,3)]
df4
#5 Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.
#utilizamos $ para indexar el data.frame
df$Species
#para eliminar una variable por nombre usamos NULL
df$Species<-NULL

#6 Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.
iris$nueva_variable<-1:150
names(iris)
str(iris)

#7 Escriba un programa en R para ordenar un data.frame dado por varias columnas.
# Ordenar el data.frame por columnas tomando logico y numeros
logico_numeros<-df2[order(df2$logico, df2$numeros), ]
logico_numeros

#8Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.

# se crean dos data.frames de ejemplo
data1<- data.frame(ID = c(5,4,3,2), Valor1 = c(1,2,3,4))
data2 <- data.frame(ID = c(3,4,5,6), Valor2 = c(5,6,7,8))

# Para generar una fusion interna se ocupa ID junto con la funcion merge que une 
union_interna <- merge(data1, data2, by = "ID", all = FALSE)

# Unión externa
union_externa <- merge(data1, data2, by = "ID", all = TRUE)

# Unión izquierda donde la x es la variable considerando (x,y)
union_izquierda <- merge(data1, data2, by = "ID", all.x = TRUE)

# Unión derecha 
union_derecha <- merge(data1, data2, by = "ID", all.y = TRUE)

#9 Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.
# Crear un data.frame de ejemplo con valores NA
df1 <- data.frame(col1 = c(1,NA,3), col2 = c(NA,2,5))
# Se reemplazan los valores NA con 3 con la funcion is.na
df1[is.na(df1)] <- NA
df1

#10 Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.
# Crear un data.frame de ejemplo
datosjugadores <- data.frame(Nombre = c("Roberto", "Luisa", "Benjamin"),Edad = c(29, 55, 20),Puntuacion_Matematicas = c(70, 35, 55),Puntuacion_Historia = c(38, 70, 45))
datosjugadores
#colnames nos entrega solo los nombres de las columnas
colnames(datosjugadores)

# Para ambiar los nombres de columna se le asignan nuevos en este caso se reemplazo la columna Nombre por Nombre y apellido
colnames(datosjugadores) <- c("Nombreyapellido", "Edad", "Matematicas", "Historia")
datosjugadores

(colnames(datosjugadores))
datosjugadores

#11Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)
data1 <- data.frame(letras = letters[1:3],numeros = 1:3,meses = month.name[1:3])
#duplico el data.frame 1 y se lo asignmo al objeto data2
data2 <- data1

#se hace un cambio para que hayan diferencias entre los data.frames cambiando january por enero y A por a
data2[1,'letras'] <- "A"
data2[1,'meses'] <- 'enero'
data2
data1

#setdiff devuelve las variables (columnas que son diferentes)
setdiff(data1,data2)

#Si se quieren comparar que elementos son diferentes entre las variables se debe hacer
setdiff(data1$letras,data2$letras)
setdiff(data1$meses,data2$meses)

#12 Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)
# ocupamos el mismo data.frame
data1<- data.frame(ID = c(5,4,3,2), Valor1 = c(1,2,3,4))
data2 <- data.frame(ID = c(3,4,5,6), Valor2 = c(5,6,7,8))

# Con intersect encontramos los elementos que están presentes en los dos data.frames
n <- intersect(data1$ID, data2$ID)

# separamos los elementos comunes en data1
o <- data1[data1$ID %in% n, ]
o
#13 Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)
# Juntamos los elementos de los dos data.frames usando la funcion union
dx <- data.frame(letras = letters[1:3],numeros = 1:3,meses = month.name[1:3])
dt <- data.frame(jugadores = letters[1:3],puntos= 1:3,tiempo = month.abb[1:3])

# Con union encontramos elementos comunes
dxdt <- union(dx$Valor, dt$Valor)

# Con table contamos la frecuencia de cada elemento en los data frame
fdx <- table(dx$Valor)
fdt <- table(dt$Valor)

# Filtrar elementos que aparecen solo una vez y son comunes
fdxdt <- dxdt[(fdx[dxdt] == 1) & (fdt[dxdt] == 1)]

#14 Escriba un programa R para contar el número de valores NA en una columna de data.frames.

df1 <- data.frame(col1 = c(1,NA,3), col2 = c(NA,2,5))

# Nombre de la columna en la que deseas contar NA
contar <- "Valor"

# Contar el número de valores NA en la columna especificada usando sum, una funcion que se debe usar con is.na ya que hay valores NA
cna<- sum(is.na(df1[[contar]]))

#15 Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)

v1<-letters[1:5]
v2<-month.abb[1:5]

# Hacemos un dataframe a partir de los 2 vectores anetriores
v1v2 <- data.frame(Columna1 = v1, Columna2 = v2)

# Mostrar las filas duplicadas con la funcion duplicated
dupli <- v1v2[duplicated(v1v2) | duplicated(v1v2, fromLast = TRUE), ]

# y mostrar las filas unicas filtando con %
funicas<- v1v2[!duplicated(v1v2) & !duplicated(v1v2, fromLast = TRUE), ]

#16 Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.
# Se llama a el conjunto de datos airquality
data(airquality)

# Para eliminar usamos subset 
calidad_aire <- subset(airquality, select = -c(Solar.R, Wind))

#17 Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)

data(airquality)

# Ordenar el dataframe por la primera y segunda columna osea Ozone y luego Solar.R utilizando la funcion order
calidadaire_ordenado <- airquality[order(airquality$Ozone, airquality$Solar.R), ]

#3.2 Listas

#1.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.
v<- c(1, 2, 3, 4, 5)
mx<-matrix(1:9,nrow=3)
l<-list(6, 7, 8, 9, 10)
lp <- list( "Vector" = v, "Matriz" = mx, "Lista" = l)
lp
#2.Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.
v<- c(1, 2, 3, 4, 5)
m<- matrix(1:9, nrow = 3)
l<- list(a = "rosa", b = "naranjo", c = "calipso")
l2 <- list( "Vector" = v, "Matriz" = m, "Lista" = l)

e1<- l2[[1]]
e2<- l2[[2]]
e1
e2

#3.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.

v<- c(1, 2, 3, 4, 5)
m<- matrix(1:9, nrow = 3)
l<- list(a = "circulo", b = "triangulo", c = "cuadrado")
l2 <- list( "Vector" = v, "Matriz" = m, "Lista" = l)
l2

ne<- "agregado"
l2<- append(l2, list("agregado" = ne))
l2

#4.Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.
l1<- list(1:10,list(a1 = "Primero", a2 = "Segundo", a3 = "Tercero"))

a2 <- l1[[2]][2]

a2
#5.Escriba un programa R para fusionar dos listas dadas en una lista.

l1 <- list(a = 1, b = 2, c = 3)
l2 <- list(d = 4, e = 5, f = 6)

# Fusionar las dos listas en una sola
l3<- c(l1, l2)
l3

#6.Escriba un programa en R para convertir una lista dada en vector.
l<- list(a = 1, b = 2, c = 3, d = 4)

v<- unlist(l)

#7.Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.

df1 <- data.frame(Nombre = c("Juan", "Ana", "Carlos"), Edad = c(30, 25, 35))

df2 <- data.frame(Nombre = c("María", "Luis", "Laura"), Edad = c(28, 40, 27))

ldf<- list(df1, df2)

dfp<- ldf[[1]]

dfs<- ldf[[2]]

dfp
dfs
#8.Escriba un programa R para contar el número de objetos en una lista dada.
l<- list(1, "Hola", c(2, 4, 6), data.frame(a = 1:3, b = 4:6))

obj<- length(l)
obj

#9.Escriba un programa en R para convertir una matriz dada en una lista.
m <- matrix(1:9, nrow = 3)

l<- as.list(m)
l

#10.Escriba un programa R para asignar NULL a un elemento de lista dado.
l<- list(a = 1, b = "Hola", c = 3.14)

l$b <- NULL

l

#11.Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.

s <- list()

letra<- "E"

# sec 15 letras
for (i in 1:15) {s[[i]] <- letra
letra <- intToUtf8(utf8ToInt(letra) + 1)
}

s

#12.Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.
l<- list(x = 1, y = 2, z = 3)

nn <- c("a", "b", "c")
names(l) <- nn

l

#13.Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.
l <- list(vector1 = c(1, 2, 3), vector2 = c(4, 5, 6), vector3 = c(7, 8, 9))

# Obtener la longitud de los dos primeros vectores
lv1<- length(l[[1]])
lv2<- length(l[[2]])

lv1
lv2

#14.Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)
# Crear dos listas de ejemplo
l1 <- list(1, 2, 3, 4, 5)
l2<- list(3, 4, 6, 7, 8)

encontrar <- l1[!unlist(l1) %in% unlist(l2)]

encontrar
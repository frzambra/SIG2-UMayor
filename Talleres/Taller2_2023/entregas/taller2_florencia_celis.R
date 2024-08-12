#taller 2 
#integrantes: Jonathan Hernandez y Florencia Celis 

#data frame 

#1.Escriba un programa en R para crear un data.frame vacío.
df<- data.frame()
class(df)
df
#2.Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.

v1<-letters[1:5]
v1
v2<-month.abb[1:5]
v2
v3<- c(TRUE,FALSE,FALSE,TRUE,TRUE)
v3
v4<-1:5
v4

df2 <-data.frame(letra = v1, meses = v2, logico = v3, numero = v4)
df2
str(df2)
#3.Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.

df2$meses
df2[,'meses']
#4.Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.

#crear un data.frame con sub muestra del data.frame iris que considere las 5 primeraas filas y las 5 primeras columnas 
df<- iris[1:5,1:5]
df
df[c(3,5),c(1,3)]

#5.Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.
#formas de indexar
df$Species
df[,'Species']
de[,5]

#para eliminar una variable por nombre usamos NULL
especies<- df$Species
df$Species<-NULL
df
df[,c('Sepal.Length','Petal.Length')]<-NULL
df
str(df)
#6. Escriba un programa en R para agregar una nueva columna en un marco de datos determinado.
#para agregar variables y columnas 
iris$nueva_variable<-1:150
cbind(iris,nueva_variable=1:150)
names(iris)
str(iris)

#7.Escriba un programa en R para ordenar un data.frame dado por varias columnas.
f<- c(3,2,8,9,6)
f1<- c(6,7,8,9,10)
f2<- c('jose','paula','cristofer','felipe','isidora')

df<- data.frame(f,f1,f2)
df

data_ordenado <- order(df$f1, df$f2,df$f)
data_ordenado
dor<- df[data_ordenado,]
dor
print(dor)

#8.Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.
?merge

df1 <- data.frame(ID = c(1, 2, 3, 4, 5), Nombre = c("Juan", "María","Carlos", "Luisa", "Pedro"))
df1

df2 <- data.frame(ID = c(3, 4, 5, 6, 7),Edad = c(15, 40, 22, 28, 85))
df2

interna <- merge(df1, df2, by = "ID", all = FALSE)
interna

externa <- merge(df1, df2, by = "ID", all = TRUE)
externa

izquierda <- merge(df1, df2, by = "ID", all.x = TRUE)
izquierda

derecha <- merge(df1, df2, by = "ID", all.y = TRUE)
derecha




#9.Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.

a<- c(2,NA,NA,6)
a2<- c(4,9,NA,5)

df<- data.frame(a,a2)
df
df[is.na(df)]<-3
df

#10.Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.

new_name<-c('valores','datos')
names(df)<- new_names
df

#11.Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)

?setdiff

h1<- c(1,0,4,7)
h2<- c(0,1,0,1)

df<-data.frame(h1,h2)
df

t1<-c(4,6,8,1)
t2<-c(9,4,5,2)

df1<- data.frame(t1,t2)
df1

filas_faltantes<- setdiff(df,df1)
print(filas_faltantes)

#12.Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)
?intersect

df3<- intersect(df$h2,df1$t2)
df3

#13.Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)
?union 

df4<- union(df$h1,df1$t1)
df4

#14.Escriba un programa R para contar el número de valores NA en una columna de data.frames.

columna1<- c(2,NA,NA,6)
columna2<- c(4,9,NA,5)

df<- data.frame(columna1,columna2)
df

valores_na <- sum(is.na(df$columna1))
valores_na

#15.Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)
?duplicated

v1<- c(8,6,4,2)
v2<- c(1,3,5,7)

dataf<- data.frame(columna1= v1, columna2 = v2)
dataf

elemntos_dup <- dataf[duplicated(dataf), ]
elemntos_dup

filas_unicas <- dataf[!duplicated(dataf), ]
filas_unicas

#16.Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.
data(airquality)
print("Conjunto de datos original:")
head(airquality)
sin_variables <- subset(airquality, select = -c(Solar.R, Wind))
sin_variables

#17.Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)

?order

data("airquality")
df5<- is.data.frame(airquality)
df5

airquality_ordenado <- airquality[order(airquality$Month, airquality$Day), ]
airquality_ordenado

#listas

#1.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.

vector<- c(4,2,3,6)
vector

matriz<- matrix(1:9,nrow = 3,ncol = 3)
matriz

lista <- list(ciudad, poblacion, temperaturas)
lista

ciudad <-c("Nueva York")
ciudad
poblacion <- c(8500000)
poblacion
temperaturas <- c(34, 18, 33, 12, 22)
temperaturas
  
#lista
lista2<- list(vector,matriz,lista)
lista2            

names(lista2)<- c ('Mivector', 'Mimatriz', 'Milista')
lista2

#2.Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.

lista2<- list(vector,matriz,lista)
lista2  
names(lista2)<- c ('Mivector', 'Mimatriz', 'Milista')
lista2

primer_elemento<- lista2[[1]]
primer_elemento

segundo_elemento<- lista2[[2]]
segundo_elemento

#3.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.

lista2<- list(vector,matriz,lista)
lista2  
names(lista2)<- c ('Mivector', 'Mimatriz', 'Milista')
lista2

nuevo_elemento<- c(9,8,4,5)

lista2 <- append(lista2, list(nuevoelemento = nuevo_elemento))
lista2

#4.Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.

lista_anidada <- list(Elemento1 = "A",Elemento2 = list(Subelemento1 = 1, Subelemento2 = 2, Subelemento3 = 3),  Elemento3 = "B")

lista_anidada
segundo_elemento <- lista_anidada$Elemento2
segundo_elemento

#5.Escriba un programa R para fusionar dos listas dadas en una lista.

lista_fusionada<-c(lista2,lista_anidada)
lista_fusionada

#6.Escriba un programa en R para convertir una lista dada en vector.
lista3 <- list(a = 1, b = 2, c = 3)
lista3
mi_vector <- unlist(lista3)
mi_vector

#7.Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.

f<- c(2,6,0,7)
f
f1<- c('pancho', 'camila', 'lucifer', 'cruella')
f1

df<- data.frame(f,f1)
df

j<- c(5,9,1,4)
j
j1<- c('vicente', 'daniel','samantha', 'josefa')
j1

df2<- data.frame(j,j1)
df2

lista_dataframe<- list(df,df2)
lista_dataframe

primer_dataframe<- lista_dataframe[[1]]
primer_dataframe

segundo_dataframe<- lista_dataframe[[2]]
segundo_dataframe

#8.Escriba un programa R para contar el número de objetos en una lista dada.
lista3 <- list(a = 4, b = 2, c = 10, d = "Hola", e ='cerdito')
lista3

numero_de_objetos <- length(lista3)
numero_de_objetos

#9.Escriba un programa en R para convertir una matriz dada en una lista.
matriz<- matrix(1:9,nrow = 3,ncol = 3)
matriz

lista4<- as.list(matriz)
lista4

#10.Escriba un programa R para asignar NULL a un elemento de lista dado.
lista3 <- list(a = 4, b = 2, c = 10, d = "Hola", e ='cerdito')
lista3

lista3$c<-NULL
lista3

#11 Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.

#Crear una secuencia de letras mayúsculas comenzando desde 'E'
s<- as.list(LETTERS[5:19])
s

#12 Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.
#Crear una lista
p <- list('primero','segundo',22)
p
names(p)<-c("a" , "b" , "c")
names(p)

#13 Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.

#Crear una lista con vectores
ml <- list( vector1= c(1, 2, 3, 4, 5),vector2 = c(10, 20, 30, 40))

ml
#Obtener la longitud de los dos primeros vectores
lv1<- length(ml[[1]])

lv1

lv2<- length(ml[[2]])
lv2

#14 Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada.

#Definir las dos listas
l1 <- list("a", "b", "c", "d", "e")
l2 <- list("c", "e", "f", "g")

#Encontrar elementos en lista1 que no están en lista2
df<- setdiff(l1, l2)
df

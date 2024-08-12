#Taller 2

#INTEGRANTES: Tomás Gougain, Andoni Targarona

#-------------------------------------------------------#

# DATA.FRAMES

#1. Escriba un programa en R para crear un data.frame vacío.
df<-data.frame()
df

#2. Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.

#vectores
v1<-letters[1:5]
v2<-month.abb[1:5]
v3<-c(TRUE,FALSE,FALSE,TRUE,TRUE)
v4<-1:5

#data.frame
df2<-data.frame(letras=v1, meses=v2, logico=v3, numeros=v4)
df2

#3. Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.

extraer<-df2[,'meses']
extraer

#4. Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.

df<-iris[1:5,]
df

#extraer
extraer2<-iris[c(3,5),c(1,3)]
extraer2

#5. Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.

df<-iris[1:5,]
df

colnames(df)

#eliminar
df['Species']<-NULL
df['Petal.Width']<-NULL
df

#6. Escriba un programa en R para agregar una nueva columna en un data.frame determinado.

iris$nueva_variable<-1:150
names(iris)
str(iris)

#7. Escriba un programa en R para ordenar un data.frame dado por varias columnas.

v1<-letters[1:5]
var1=c(1, 3, 3, 4, 5)
var2=c(7, 7, 8, 3, 2)

df6<-data.frame(var1=c(1, 3, 3, 4, 5),var2=c(7, 7, 8, 3, 2),var3=v1)
df6

#ordenar
df6 [order(df6$var2,df6$var1),]


#8. Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.

#data frames
ID<-c(1:3)
X1<-c('a1','b1','c1')
X2<-c('a2','b2','c2')
df1<-data.frame(ID,X1,X2)
df1

ID<-c(4:6)
X3<-c('a3','b3','c3')
X4<-c('a4','b4','c4')
df2<-data.frame(ID,X3,X4)
df2

#fusion interna
int<-merge(df1,df2,by='ID',all=TRUE)
int

#fusion externa
ext<-merge(df1,df2,by='ID',all = TRUE)
ext

#fusion izquierda
izq<-merge(df1,df2,by='ID',all.x = TRUE)
izq

#fusion derecha
der<-merge(df1,df2,by='ID',all.y = TRUE)
der

#9. Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.

a=1:6
b=c(1,NA,NA,NA,5,6)
df<-data.frame(a,b)
df

#reemplazar
df[is.na(df)]<-3
df

#10. Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.

colnames(iris)

#reemplazar
colnames(iris)<-c('Longitud.Sepalo','Ancho.Sepalo','Longitud.Petalo','Ancho.Petalo','Especie')

#nuevas columnas
iris

#11. Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)

#data frames
verduras<-c('Tomate','Lechuga','Pepino','Zanahoria')
precio<-c(100,200,400,500)
df1<-data.frame(verduras,precio)
df1

verduras<-c('Zapallo','Betarraga','Tomate','Pepino')
precio<-c(700,1500,100,400)
df2<-data.frame(verduras,precio)
df2

#encontrar las diferencias
setdiff(df1$precio,df2$precio)
setdiff(df1$verduras,df2$verduras)

#12.Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados.

#programa
intersect(df1$verduras,df2$verduras)
intersect(df1$precio,df2$precio)

#13. Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados.

#programa
union(df1$precio,df2$precio)
union(df1$verduras,df2$verduras)

#14. Escriba un programa R para contar el número de valores NA en una columna de data.frames.

#data frame
id <- 1:5

nombres <- c('Paula','Valentina','Tomas','Camila','Carlo')

genero <- c(NA,NA,'Hombre','Mujer',NA)

rut<-c('12.361.445-3','17.212.967-2','21.039.666-k','20.351.519-1','22.452.676-3')

direccion<-c('Avenida Cordillera Sur 123, Santiago, Región Metropolitana','Calle Huemul 456, Concepción, Región del Biobío','Pasaje Lago Azul 789, Puerto Montt, Región de Los Lagos','Camino Alerce Milenario 101, Valdivia, Región de Los Ríos','Calle Viñedo Rojo 234, La Serena, Región de Coquimbo')

profesion<-c('Promotora','Biologa marina','Boxeador','Tarotista','Gendarme')

df3 <- data.frame(id,nombres,genero,rut,direccion,profesion)
df3

#contar NA columna
contar<-sum(is.na(genero))
contar

#contar NA data.frame
contar<-sum(is.na(df3))
contar

#15. Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame.

#crear data frame con vectores
v1 <- c(1, 2, 3, 4, 5, 2)
v1
v2 <- c("A", "B", "C", "D", "E", "B")
v2

df <- data.frame(Columna1 = v1, Columna2 = v2)
df

#mostrar duplicados
duplicados<- df[duplicated(df), ]
duplicados

#mostrar filas unicas
unique(df)

#16. Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.

airquality

#eliminar
airquality$Solar.R=NULL
airquality$Wind=NULL

#mostar data frame sin las variables
airquality

#17. Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna.

#mostrar data.frame
airquality

#es un data.frame?
is.data.frame(airquality)

#ordenar primera y segunda columna
airquality<-airquality[order(airquality$Ozone,airquality$Solar.R),]
airquality

#-------------------------------------------------------#

#LISTAS

#1. Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.

#vector
v<-c(1:9)

#matriz
m<-matrix(1:9,nrow=3,ncol=3,byrow=TRUE)
rownames(m)<-c('x','y','z')
colnames(m)<-c('x','y','z')

#lista
l<-list('Naranjas',15,TRUE)

#lista general
l1<-list(Vector=v,Matriz=m,Lista=l)

#mostar lista
l1

#2. Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.

#vector
v<-c(1,2,3,2,5,6)

#matriz
m<-matrix(1:9,nrow=3,ncol=3,byrow=TRUE)
rownames(m)<-c('x','y','z')
colnames(m)<-c('x','y','z')

#lista
l<-list('Autos',32,NA)

#lista general
l1<-list(Vector=v,Matriz=m,Lista=l)

#mostar lista
l1

#FALTA ACCEDER AL PRIMER Y SEGUNDO ELEMENTO

#3. Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.

#vector
v<-c(1,2,3,2,5,6)

#matriz
m<-matrix(1:9,nrow=3,ncol=3,byrow=TRUE)
rownames(m)<-c('x','y','z')
colnames(m)<-c('x','y','z')

#lista
l<-list('Autos',32,NA)

#lista general
l1<-list(Vector=v,Matriz=m,Lista=l)
l1

#nuevo elemento
a<-'Manzana'

l1[[length(l1)+1]]<-a
l1

#4.Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.

#lista
lista <- list(1:5,list(1,6,3,4,5))

#segundo elemento lista anidada
lista[[2]][2]

#5. Escriba un programa R para fusionar dos listas dadas en una lista.

lista<-list(1,3,4,2,1)
lista2<-list(6,4,6,7,3)

lista
lista2

#fusionar
c(lista,lista2)

#Otro ejemplo

lista1<-list(1,2,3)
lista2<-list("a","b","c")

#fusionar
fusion<-c(lista1,lista2)
fusion

#6. Escriba un programa en R para convertir una lista dada en vector.

lista1<-list(1,2,3)

#convertir en vector
x<-as.vector(lista1)
x

#comprobar
is.vector(x)

#7. Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.

#data.frames
verduras<-c('Tomate','Lechuga','Pepino','Zanahoria')
precio<-c(100,200,400,500)
df1<-data.frame(verduras,precio)
df1

verduras<-c('Zapallo','Betarraga','Pimenton','Repollo')
precio<-c(700,1500,750,900)
df2<-data.frame(verduras,precio)
df2

#lista
lista<-list(df1,df2)
lista

#acceder a data.frames
acceder<-lista[[1]]
acceder

acceder2<-lista[[2]]
acceder2

#8. Escriba un programa R para contar el número de objetos en una lista dada.

lista<-list(1,2,3,5,5,4,3,6,7,9)
lista

#numero de objetos
length(lista)

#9. Escriba un programa en R para convertir una matriz dada en una lista.

#matriz
matriz<-matrix(1:20,nrow = 5,ncol = 4)
matriz

#covertir a lista
lista<-as.list(matriz)
lista

#comprobar
is.list(lista)

#10. Escriba un programa R para asignar NULL a un elemento de lista dado.

lista<-list(1,3,4,5,5,4,3,6,7,9)
lista

#asignar NULL
lista[2]<-NULL
lista

length(lista)

#otro ejemplo
list(a=1,b=3,c=4,d=5,e=5,f=4,g=3,h=6,i=7,j=9)
lista<-list(a=1,b=3,c=4,d=5,e=5,f=4,g=3,h=6,i=7,j=9)
lista

lista[5]<-NULL
lista

#11. Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.

#secuencia
letras_mayusculas<-LETTERS[5:19]

#lista s
s<-list(letras_mayusculas)

s

#12. Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.

lista<-list(1,2,3)
lista

#nuevos nombres
nuevos_nombres<-names(lista)<-c('a','b','c')
lista

#13. Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.

#vectores
v1<-c(1,2,3,4)
v2<-c(5,6,7,8,9)
v3<-c(10,11,12,13)

#lista
lista<-list(v1,v2,v3)
lista

#obtener longitud dos primeros vectores
length(lista[[1]])
length(lista[[2]])

#14. Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)

lista1<-list(1:5)
lista1

lista2<-list(3:7)
lista2

#encontrar elementos distintos
x<-setdiff(lista1[[1]],lista2[[1]])
x


#------------------------FIN----------------------------#



## DATA.FRAMES

#1. Escriba un programa en R para crear un data.frame vacío.

# a qué se refiere con vacío? Que no tenga argumentos
a<-data.frame()
class(a)
a

#clases
df<- data.frame()
class(df)
df

#2. Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.

a<- c(1:4)
b<-c('a', 'b', 'c', 'd')
c<-c(1:4)
d<- c('b','c','h','e')
data.frame(a, b, c,d)

#en clases
#deben tener todos la misma cant. de elementos
v1<- letters[1:5] #si hay un valor que falta indico NA
v2<- month.abb[1:5] #meses del año abreviados.
v3<-1:5
v4<-c(TRUE,FALSE,FALSE,TRUE, TRUE)

df2<-data.frame(Letras=v1, Meses=v2, Lógico=v4, Números=v3)
df2
str(df2) #muestra info reducida, resumen de la estructura del data.frame (sirve para otras funciones)


#3. Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.

s<-data.frame(a, b, c, d)
s$d

#clases
df2$Meses
df2[,'Meses']
df2[,2] #indexación por el índice de la columna.

#4. Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.

columna1<-1:12
columna2<- seq(from=5, to=30, by=5)
columna3<- rev(a)
data<-data.frame(columna1,columna2,columna3)
data
data[1] #columa 1
data$columna1 #columna 1
data[3] #columna 3
data['3',] #fila 3
data ['5',] #fila 5
data[3,1] #fila 3 con columna 1
data[5,3] #fila 5 con columna 3.

#clases
df<-iris[1:5, 1:5] #cree el data.frame que considera las primeras 5 filas y columnas para resolver el ejercicio
df3<- df[c(3,5), c(1,3)] #crea una submuestra
df3
class(df3)


#5. Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.

data2<-select(data, -columna1, -columna3) #sirve para eliminar más de una columna a la vez.
data2


df4<- select(df2, -Meses) #(probando con el ejercicio de clases)
df4

data$columna2<-NULL #asignar el valor NULL para la columna que se quiere eliminar.
data

install.packages("dplyr") # Instalar paquete de manipulación de dataframes
library(dplyr)
data2<-select(data, -columna1) #otra forma.
data2

#clases
df$Species <- NULL
df[,c('Sepal.Lenght', 'Petal.Lenght')]<- NULL
df
df[-2,] #para eliminar una fila.

#6. Escriba un programa en R para agregar una nueva columna en un data.frame determinado.

iris$nueva_variable <- 1:150 #para agregar variables (columnas)
names(iris)
str (iris)

cbind(iris, nueva_variable=1:150)

#7. Escriba un programa en R para ordenar un data.frame dado por varias columnas.

mtcars #data.frame de autos.
mtcars[with(mtcars, order(gear)),] #orden ascendente.

df[with(df, order(Petal.Length)), ]
df[with(df, order(-Petal.Length)), ] #orden descendente.

#clases
iris[order(iris$Sepal.Length,iris$Species),]

#8. Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.

Nombre <- c('Amber', 'Fiorella', 'Emilia')
Edad<-c(18,6,20)
Numeros<-seq(3,9,3)
data_frame1<- data.frame(Nombre, Edad, Numeros) #primer data.frame
data_frame1

Nombre <-c('Amber', 'Emily', 'Fiorella', 'Paula', 'Emilia')
Edad<-c(18,20,6,5,20)
data_frame2<- data.frame(Nombre, Edad)
data_frame2 #segundo data.frame

merge(x = data_frame1, y = data_frame2) #Inner join (union interna) #unir dadat.frame en R, solo une los que tiene en comun.
merge(x = data_frame1, y = data_frame2, by = c("Nombre", "Edad"))   # Equivalente


merge(x = data_frame1, y = data_frame2, all=TRUE) #FULL(OUTER) JOIN (union externa).

merge(x = data_frame1, y = data_frame2, all.x=TRUE) #UNION POR IZQUIERDA.
merge(x = data_frame2, y = data_frame1, all.x=TRUE)

merge(x = data_frame1, y = data_frame2, all.y=TRUE) #union por derecha
merge(x = data_frame2, y = data_frame1, all.y=TRUE)

#clases
df1 = data.frame(ID = c(1,2), X1 = c('a1','a2'))

df2 = data.frame(ID = c(2,3), X2 = c('b1','b2'))
# Unión por la izquierda

result = merge(df1, df2, by = "ID", all.x = TRUE)

# Unión por la derecha

result = merge(df1, df2, by = "ID", all.y = TRUE)

#Unión interna 

result = merge(df1, df2, by = "ID", all = TRUE)


#9. Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.

Edad<-c(10,NA,NA,NA,11,18,20,NA)
Persona<-1:8
datos<-data.frame(Persona, Edad)
datos

datos <- datos %>% mutate(Edad = replace(Edad, which(is.na(Edad)), 3)) #remplazar NA
datos

#clases
df <- data.frame(col1 = c(1,NA,3), col2 = c(NA,2,5))
df[is.na(df)] <- NA #no me da.

#10. Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.

iris 
iris %>% rename(Especie=Species, Sepalo=Sepal.Length)

# Crear el DataFrame que usaremos para practicar (ejemplo)
df <- data.frame (jugador = c ('a', 'b', 'c', 'd', 'e'),
                  posición = c ('G', 'F', 'F', 'G', 'G'),
                  puntos = c (12, 15, 19, 22, 32),
                  rebotes = c (5, 7, 7, 12, 11))


df #ver data.frame
df %>% rename (PuntosMarcados = puntos, Rebotes2 = rebotes) # cambiar el nombre de la columna 'puntos' y 'rebotes'

#11. Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)

?setdiff

df1<-data.frame(Letras=letters[1:5], Números=1:5, Meses=month.abb[1:5])
df1

df2<-df1
df2[1,'Letras']<- 'H'
df2[3,'Meses']<- 'Marzo'
df2

setdiff(df1,df2) #indica las variables (columnas) que son diferentes.
setdiff(df1$Letras,df2$Letras) #compara que elementos sin diferentes entre las variables.
setdiff(df1$Meses,df2$Meses)


setdiff(df2,df1) #indica las variables (columnas) que son diferentes.
setdiff(df2$Letras,df1$Letras) #compara que elementos sin diferentes entre las variables.
setdiff(df2$Meses,df1$Meses)

#12. Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)

?intersect #La “intersección” representa los elementos que los dos objetos tienen en común. La función intersect() solo devolverá las filas que tengan los mismos valores en cada columna entre los dos marcos de datos. También se puede usar la función length() con la función intersect() para simplemente encontrar el número de filas que los dos marcos de datos tienen en común: " length(dplyr::intersect(df1, df2))"

data_frame1<- data.frame(Especie=c('Araucaria', 'Araucaria','Peumo','Hualo', 'Quila'), Número=c(1,4,6,8,9))
data_frame1

data_frame2<-data.frame(Especie=c('Peumo', 'Hualo', 'Hualo', 'Hualo', 'Hualo'), Número=c(6,5,5,2,5))
data_frame2


intersect(data_frame1, data_frame2)


#13. Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)

?union
?merge
data_frame1<- data.frame(Especie=c('Araucaria','Peumo','Hualo'), Número=c(1,4,6))
data_frame1

data_frame2<-data.frame(Especie=c('Quila', 'Roble', 'Hualo'), Número=c(6,5,6))
data_frame2

merge(data_frame1, data_frame2)

#14. Escriba un programa R para contar el número de valores NA en una columna de data.frames.

Alumno<-1:10
Estado<-c('Pendiente', 'Aprobado', 'Pendiente', NA, NA, NA, 'Reprobado', NA, 'Reprobado', NA)
datos<-data.frame(Alumno, Estado)
datos
apply(X= is.na(datos), MARGIN=2, FUN=sum) #MARGIN=2 es para contar por columna, mientras que MARGIN=1 es para contar por filas.

apply(X= is.na(datos), MARGIN=1, FUN=sum) #cuenta por fila.


#15. Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)

?duplicated

df<- data.frame(Valor1=c(1:2, 1:4),Valor2=letters[c(1:2, 1:4)])
df

duplicated(df)

#16. Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.

airquality
a<- airquality
head(a)
df<-select(a, -Solar.R, -Wind)
f<-head(df)
f

#17. Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un data.frame o no? Ordene todo el data.frame por la primera y segunda columna. (ver ?order)

f
class(f)
?order
df_ordenado<-f[order(f$Ozone, f$Temp),]
df_ordenado


## LISTAS


#1. Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.

m<- matrix(1:9, nrow=3, ncol=3) #matriz
v<- c('auto', 'bus') #vector
l<-list(1:6) #lista
l_recursiva<- list(l, v, m)
l_recursiva
l_nombres<-list(Lista=l, Vector=v, Matriz=m) #asiganr nombre a los elem. de la lista
l_nombres

#2. Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.

v<-c('a','b','c') #vector
m<- matrix(1:6, nrow=3, ncol=2) #matriz
lista<- list(1:10) #lista
nomb_l_rec<- list(Vector=v, Matriz=m, Lista=lista) #nombre de los elem.
l_rec<-list(v,m,lista) #Crear lista solicitada.
nomb_l_rec
nomb_l_rec['Vector'] #profesor pide el vector o la lista?
nomb_l_rec['Matriz'] #segundo elemento de la lista.
nomb_l_rec[[1]] #accede al primer elemento de la lista.
nomb_l_rec[[2]] #accede al segundo elemento de la lista.
#se puede acceder a amabos elementos de la lista a la vez?

#3. Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.


my_list<- list(Vector=c(1:3), Matriz=matrix(1:4, nrow=2, ncol=2), Lista=list(1:5))

my_list[[4]] <- data.frame(X = c(8, 5, 3), Y = c(7, 9, 1)) #el 4 es por el siguiente índice de la lista

my_list[[length(my_list) + 1]] <- data.frame(X = c('a','b','c'), Y = c(7, 9, 1)) #esto es el equivalente pero para el caso de n elementos.
my_list

#4. Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.

lista_anidada<-list(my_list, nomb_l_rec)
lista_anidada
lista_anidada[[2]][2]
lista_anidada[[2]][1] #accedio al segundo elemento (nomb_l_rec) y al primer elemento de esta lista.

#5. Escriba un programa R para fusionar dos listas dadas en una lista.

list(my_list, nomb_l_rec)
append(my_list, nomb_l_rec) #Se puede unir dos o más listas. Para ello es util las funciones append, c o do.call. Al combinar las listas de esta manera, los elementos de la segunda lista se agregarán al final de la primera lista.

c(my_list, nomb_l_rec) # Equivalente

#6. Escriba un programa en R para convertir una lista dada en vector.

lsta<- list(Caracter=c('a','f','c'), Vector=c(1:5)) #crear lista.
lsta
unlist(lsta, use.names=FALSE) #convertir lista a vector.

#7. Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.


a<- c(1:4)
b<-c('a', 'b', 'c', 'd')
d<- c('b','c','h','e')
df1<- data.frame(a, b,d) #data.frame 1

df2<-data.frame(Letras=letters[1:3] , Meses=month.abb[1:3] , Lógico=c(TRUE,FALSE,FALSE)) #data.frame 2

df3<-iris[1:5, 1:5] #data.frame 3
df3

list_df<- list(df1, df2, df3) #crear lista de data.frame.

#acceder a cada data.frame de la lista
list_df[[1]] #acceso a df1.
list_df[[2]] #acceso a df2
list_df[[3]] #acceso a df3.

#8. Escriba un programa R para contar el número de objetos en una lista dada.

#La longitud de una lista corresponde al número de objetos dentro de la lista.
length(list_df) #numero de elementos de la lista de data.frame.
length(list_df[[3]]) #numero de objetos dentro de la lista df3. Para esto hay que primero extraer o indexar el elemento correspondiente (en este caso 3 por df3)

#9. Escriba un programa en R para convertir una matriz dada en una lista.

m<-matrix(1:6, nrow=3, ncol=2)
m
as.list(m) #crea cada elemento de la matriz como elemento de la lista.
split(m,col(m)) #de la matriz m creó dos elementos en la lista correspondiente a las 2 columnas de la matriz.

#10. Escriba un programa R para asignar NULL a un elemento de lista dado.

l1<-list(Vector=(1:5), Letras=letters[1:3], Caracter= c('a'))
l1
l1[[2]]<- NULL #esto es para borrar un elemento?
l1

#11. Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.

toupper(letters) #convertir de minúsculas a mayúsculas.
LETTERS #letras en mayúscula.
LETTERS[5:19]
s<- list(LETTERS[5:19])
s

#12. Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.

my_list<-list(a=df1, b=df2, c=df3) #utilize lista de data.frame.
my_list

#13. Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.


k<-list(V1=1:6, V2=c('a','b','c'), V3=1:10)
length(k[[1]]) #longitud v1.
length(k[[2]]) #longitud v2.

#14. Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)

k
k2<-list(V1=1:6, v2=1:3)
setdiff(k,k2)
setdiff(k2,k)

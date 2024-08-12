#Taller 2
#Integrantes: Belén Urrea Coa

################################# D A T A        F R A M E S ###################

#Ejercicio 1: Escriba un programa en R para crear un data.frame vacío.
#Se creo un vector con un numero especifico de "NA", en este caso seria 1000  valores de "NA" . Luego se crea el data frame con el vector llamado vacio

Vacio <- rep(NA, 1000)
Data00 <- data.frame(Vacio)
Data00

# Ejercicio 2 : Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.
#usaremos el data.frame predeterminado letters 

v1 <- letters[1:5]
v2 <- month.abb[1:5]
v3 <- c(TRUE, FALSE, TRUE, FALSE, TRUE)
v4 <- 1:5
Data1 <- data.frame('Letras' = v1, 'Meses' = v2, 'Valor Logico' = v3, 'Secuencia' = v4) 
Data1  


#Ejercio 3: Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.
#[comentario: despues de crear el data.frame, hay que indexar en esta misma]
#A continuacion el codigo
Data1$Meses


#Ejercio 4  : Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.
#A continuacion el codigo (se usará el data.frame iris)
df <- iris[1:5, 1:5]
df 



#Ejercicio 5:  Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.
# A continuacion el codigo

df$Species <- NULL


#Ejercicio 6:  Escriba un programa en R para agregar una nueva columna en un data.frame determinado.
#A continuacion el codigo
iris$nueva_variable <- 1:150
str(iris)
iris

#Ejercicio 7:  Escriba un programa en R para ordenar un data.frame dado por varias columnas #Creamos dos vectores para el data frame 
a1 <- c('i', 'd', 'c', 'a')
a2 <- c(10, 22, 8, 45)


#Se creo el data frame 
Data_frame2 <- data.frame(a1,a2)

#y luego se  creo otro nuevo vector donde se utilizo la funcion order para ordenar la columna a2 
orden <- order(Data_frame2$a2)
df_ord <- Data_frame2[orden,]
df_ord




#Ejercicio 8: Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.
#A continuación el código
#Primero se crearon los vectores para ambos data frame, que se les nombro como data frame 2 y 3      

v5 <- c('Alejandro' , 'Catalina', 'Celeste')
v6 <- c(25, 20, 21)
Data2 <- data.frame('Nombre' = v5, 'Edad' = v6 )

v7 <- c('Ing. comercial', 'Ing. medioambiental', 'Veterinaria')
v8 <- c('Francisco Cortes 146', 'Av. Pajaritos 9922', 'Las madreselvas 960')


Data3 <- data.frame('Profesion'= v7, 'Direccion'= v8)
Data3
Data2

Data_new1 <- Data1[1:3,]
Data_new1

Data4 <- cbind(Data1, Data2)


merge(x = Data2, y = Data3)
merge(x = Data2, y = Data3, by = c("id", "nombre"))

#Ejercicio 9 :  Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.
# A continuacion el codigo: 

Vacio <- rep(NA, 1000)
Data00 <- data.frame(Vacio)
Data00

Data00 <- data.frame(Vacio) + 3
Vacio2 <- (3,1000)
Data00 <- data.frame(Vacio2) 
Data00


#10 Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.
#Se usara el Data frame del ejercicio 2, llamado  
Data1
colnames(Data1)
colnames(Data1) <- c('letters', 'Month', 'T/F', 'Seq')
Data1


#Ejercicio 11: Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)
#El primer paso a realizar, será crear dos data frame, con las variables parecidas 
equipo <- c('A','B','C','D')
conferencia <- c('Oeste', 'Oeste', 'Este', 'Este')
puntos <- c(88, 97, 94, 104)

df1 <- data.frame (equipo = c ('A', 'B', 'C', 'D'),
                    conferencia = c ('Oeste', 'Oeste', 'Este', 'Este'),
                    puntos = c (88, 97, 94, 104))
df1

equipo2 <- c('A', 'B', 'C', 'D')
conferencia2 <- c('Oeste', 'Oeste', 'Este', 'Este')
puntos2 <- c(88, 97, 98, 99)


df2 <- data.frame (equipo = c ('A', 'B', 'C', 'D'),
                     conferencia = c ('Oeste', 'Oeste', 'Este', 'Este'),
                     puntos = c (88, 97, 98, 99))
df2
#Luego de haber completado los data frame, se utiliza la funcion setdiff que nos ayudara a encontrar diferencias en la columnas de puntos o equipo...
setdiff (df1 $ puntos, df2 $ puntos)
setdiff(df1 $equipo, df2 $equipo)

# Ejercicio 12: Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)
#Se usará la funcion intersect, el cual arrojara los vectores que son iguales en ambos data frame. En este ejemplo utilizaremos df1 y df2 del ejercicio anterior(11) . 
intersect(df1,df2)




# Ejercicio 13:  Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)
#Primero se realizo dos data frame, de los cuales ciertos elementos van hacer iguales
DAT1 <- data.frame(animales=c('Lagarto', 'Loica', 'Elefante'), Clase=c('Reptil', 'Ave', 'Mamifero'))
DAT1

DAT2 <- data.frame(animales=c('Sapo', 'Bandurria', 'Elefante'), Clase=c('Anfibio', 'Ave', 'Mamifero'))
DAT2
#Una vez terminados los dataframes, se utiliza la funcion merge que nos ayudara a encontrar similitudes entre ambos dataframes, arrojando esta misma similitud
merge(DAT1,DAT2)


#Ejercicio 14:  Escriba un programa R para contar el número de valores NA en una columna de data.frames.
#Creamos el Data frame incluyendo Na
Numeracion <- 1:8
Arboles <- c('Tepa', 'Lenga', 'Rauli', NA , NA ,NA, 'Coihue', NA )
Clasificacion <- data.frame(Arboles, Numeracion)
Clasificacion

#Apply es una funcion que ayuda a contar las NA tanto por columnas al referirse MARGIN=2 y por filas al decir que MARGIN=1
apply(X=is.na(Clasificacion),MARGIN = 2,FUN = sum)
apply(X=is.na(Clasificacion),MARGIN = 1,FUN = sum)



#Ejercicio 15:  Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)
#Creamos un data frame en  base a dos vectores donde el argumento se repita
df <- data.frame(Valor1=c(1:2, 1:4), Valor2=letters[c(1:2, 1:4)])
df
#Luego usamos la funcion duplicated para duplicar...
duplicated(df)


#16 Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.
airquality
#Lo primero que hacemos es aignarle un nombre al data frame, en este caso se llamara AIR
AIR <- airquality
#Luego, llamando AIR anularemos las columnas ‘Solar.R’ y ‘Wind’
AIR$Solar.R <- NULL
AIR$Wind <- NULL
AIR
#17 Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)
airquality #la primera colmuna es Ozone y la segunda es Solar.R
QUA <- airquality

orden <- order(airquality$Ozone)
QUA_ord <- QUA[orden,]
QUA_ord

orden <- order(QUA_ord$Solar.R)
QUA_ord2 <- QUA[orden,]
QUA_ord2

orden <- order(Data_frame2$a2)
df_ord <- Data_frame2[orden,]
df_ord



########################### L I S T A S ####################################
#Ejercicio 1: 
#Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.
#Creamos el primer vector, que luego se utilizara para la creacion de la matriz
A <- 1:3
A
m <- matrix(1:4,ncol = 2, nrow = 2, byrow = FALSE)
m

B <- sum(1:1000)
l1 <- list(Data2, B)
l2 <- list(A, m, l1)
l2

l3 <- list("VECTOR" = A ,"MATRIZ" = m , "LISTA" = l1)
l3

#2Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.
#Se creo otra lista donde se le agrega el nombre a cada elemento de la lista
l3 <- list("VECTOR" = A ,"MATRIZ" = m , "LISTA" = l1)
l3


#Ejercicio 3 : Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.

l4 <- list(A, m ,l2)
l4[[length(l4)+1]] <- c(1,2,3)
l4

#Ejercicio 4 : Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.
#Se ingresa al segundo elemento de la lista anidada, que en este caso es el tercer elemento
l4[[3]][[2]]

#Ejercicio 5 : Escriba un programa R para fusionar dos listas dadas en una lista.
#A continuacion se crea el vector l5 donde se unira con c las listas l3 y l4
l5 <- c(l3,l4)
l5
#Ejercicio 6 : Escriba un programa en R para convertir una lista dada en vector.
unlist(l1)
unlist

#7Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.
Data2 <- data.frame(v7, v8)
Data2

l6 <- list(Data1, Data2)
l6[1]
l6[2]



#Ejercicio 8: Escriba un programa R para contar el número de objetos en una lista dada.
length(l3)

#Ejercicio 9: Escriba un programa en R para convertir una matriz dada en una lista.
#Primero se creara una matriz de 3x4 llamada mat 
mat = matrix(c(1:12),nrow = 3, ncol = 4,byrow = TRUE)
mat
colnames(mat) <- c("Uno", "Dos", "Tres", "Cuatro")
mat
#Una vez lista la matriz, se hara uso de la funcion unlist, la cual convertirá la matriz en una lista priorizando el orden desde las columnas. Sin embargo, dado que no especifica en el enunciado, tambien haremos uso de una segunda función que priorizara el orden desde las filas.
unlist(as.list(mat))
unlist(as.list(t(mat)))


#Ejercicio 10: Escriba un programa R para asignar NULL a un elemento de lista dado.
#Para este ejercicio usaremos la lista 3 del ejercicio 1, asiganandole al elemento lista "NULL", quedando anulada en otras palabras  
l3
l3$LISTA <- NULL
l3
#Ejercicio 11 : Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.
#Para este ejercicio utilizaremos el vector letters, el cual indexaremos las primeras 19 letras. Luego indexaremos las 4 primeras letras para que el vector incie desde la letra 'E' 

letters
L <- letters[1:19]
L
Let <- L[c(-1:-4)]
Let
#Una vez listo el vector, usaremos la funcion toupper para transformaremos en mayusculas
toupper(Let)

#Una vez listo el vector, lo transformaremos en una lista llamada s como se indica en el enunciado 
Letras_list <- list(Let)
Letras_list

#Ejercicio 12:  Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.
#En este ejercicio usaremos el vector del ejercicio anterior, lo indexaremos en 3 partes, de modo que la lista contenga tres elementos
q1 <- Let[c(1:5)]
q1
q2 <- Let[c(6:10)]
q2
q3 <- Let[c(11:15)]
q3
#Luego de haber indexado el vector en tres partes, nombraremos cada elemento de la lista con las letras “a”, “b” y “c”
Letras <- list('a'= q1,'b'=q2, 'c'=q3)
Letras
#Ejercicio 13:  Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.
#Se hace uso de la funcion length, la cual contara la longitud de los elementos 1 y 2 de la lista del ejercicio anterior
length(Letras[[1]])
length(Letras[[2]])

#Ejercicio 14: Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada.
#Para este ejercicio crearemos algunos vectores que contengan alguna pequeña diferencia, que luego nos serviran para la creacion de las listas 
v9 <- c(12,23,25,78,89)
v10 <- c(12,23,24,78,89)
M1 <- matrix(1:6, nrow = 3,ncol = 2, byrow = FALSE)
M2 <- matrix(1:6, nrow = 3,ncol = 2, byrow = FALSE)
#Ahora crearemos dos listas con los vectores que se crearon
C1 <- list(v9,M1)
C2 <- list(v10,M2)
#Luego usaremos la funcion setdiff que nos ayudara a encontrar los elementos diferentes en las listas...
setdiff(C1,C2)

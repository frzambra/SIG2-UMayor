# 1 Escriba un programa en R para crear un data.frame vacío.
df <- data.frame()
df
# 2 Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.
v1 <-letters[1:5]
v2 <- month.abb[1:5]
v3 <- c(TRUE,FALSE,TRUE,FALSE,TRUE)
v4 <- 5:1
df2 <-data.frame(letras=v1,meses=v2,logico=v3,numeros=v4)
df2
# 3 Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.
df2[,"meses"]
df2$meses
df2[,2]
# 4 Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.
df<-iris[1:5,1:5]
df
df[c(3,5),c(1,3)]
# 5 Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.
df$Species <-NULL
df[,c("Sepal.Length","Petal.Length")] <- NULL
df
# 6 Escriba un programa en R para agregar una nueva columna en un marco de datos determinado.
iris$nueva_variable <- 1:150
str(iris)
iris
# 7 Escriba un programa en R para ordenar un data.frame dado por varias columnas.
mtcars
mtcars[with(mtcars, order(-gear, mpg)), ]
# 8 Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.
empleado_id <- 1:10
empleado_nombre <- c("Andrew", "Susan", "John", "Joe", "Jack",
                     "Jacob", "Mary", "Kate", "Jacqueline", "Ivy")
empleado_salario <- round(rnorm(10, mean = 1500, sd = 200))
empleado_edad <- round(rnorm(10, mean = 50, sd = 8))
empleado_puesto <- c("CTO", "CFO", "Administrativo", rep("Técnico", 7))
df_1 <- data.frame(id = empleado_id[1:8], nombre = empleado_nombre[1:8],
                   salario_mensual = empleado_salario[1:8])
df_1
df_2 <- data.frame(id = empleado_id[-5], nombre = empleado_nombre[-5],
                   edad = empleado_edad[-5], puesto = empleado_puesto[-5])
df_2
q <-merge(df_1,df_2)
q1 <-merge(df_1,df_2,all = TRUE)
merge(df_1,df_2,all.x = TRUE)
merge(df_1,df_2,all.y = TRUE)
# 9 Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.
q1
q1[is.na(q1)]<-3
q1
#10 Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.
c1 <- c("apodo")
c2 <-c("Nombres")
colnames(q1) <- c(c1,c2)
q1
#11 Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)
nu<- 1:12
month.name
df1 <-data.frame(nu,month.name)
df1
me <- 13:24
df2 <-data.frame(me,month.name)
df2
setdiff(df1,df2)
# 12 Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)
intersect(df1,df2)
#13 Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)
union(df1,df2)
?union
# 14 Escriba un programa R para contar el número de valores NA en una columna de data.frames.
j<- c(4,5,NA,8,NA,3,NA,23,21,NA)
e <- letters[1:10]
df6 <- data.frame(j,e)
df6
sum(is.na(df6))
# 15 Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)
df6 <-data.frame(j,e)
duplicated(df6)
#16 Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.
airquality
airquality[,c("Solar.R","Wind")]<-NULL
airquality
#17 Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)
class(airquality)
airquality[with(airquality, order(Ozone,Temp)), ]
## Listas
# 1 Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.
we <-C(1:8)
ew <-matrix(we,4,2,byrow =F)
ewe <-list(we,ew)
list(we,ew,ewe)
# 2 Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.
num <- 1:10
let <- c(letters [1:10])
list1 <-list("numeros"=num,"letras"=let,"lista"=ewe)
list1
list1["numeros"]
list1["letras"]
# 3 Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.
list1[[4]] <-data.frame(df2)
list1
# 4 Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.
list2 <-list(list1,ewe)
list2
list2[[2]][[2]]
# 5 Escriba un programa R para fusionar dos listas dadas en una lista.
x <- 1:5
y <- letters[1:5]
z <-df2
list3 <-c(x,y,z)
list3
list4 <-c(list2,list3)
list4
# 6 Escriba un programa en R para convertir una lista dada en vector.
unlist(ewe)
# 7 Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.
l4 <-list(df,df1,airquality)
l4
l4[1]
l4[2]
l4[3]
# 8 Escriba un programa R para contar el número de objetos en una lista dada.
length(list3)
# 9 Escriba un programa en R para convertir una matriz dada en una lista.
as.list(ew)
# 10 Escriba un programa R para asignar NULL a un elemento de lista dado.

list1 ["numeros"] <- NULL
list1
# 11 Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.
s <- list(LETTERS [1:15])
s
# 12 Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.
names(list3) <- c("a", "b", "c")
list3
#13 Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.
length(list3[1])
length(list3[2])
#14 Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)

a<-1:10
li<-list(a)
c<-2:11
lis<-list(c)

ll<-setdiff(lis,li)
ll

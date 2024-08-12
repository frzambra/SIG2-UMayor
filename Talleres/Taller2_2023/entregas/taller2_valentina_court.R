#Solcuion taller 2 
#integrantes: Camila Urrutia y Valentina Court 
#3.1 Data.Frames
#1.Escriba un programa en R para crear un data.frame vacío.

df <- data.frame()
class (df)
df

#2.Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.

v1 <- letters [1:5] 
v2 <- month.abb [1:5]
v3 <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
v4 <- 1:5

df2 <- data.frame (letras = v1, meses = v2, logico = v3, numeros = v4)

str(df2)
df2

#3.Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.

df2$meses
     
#4.Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.

#crear un data,frame con sub-muestra del dataa.frame iris que considere las 5 primeras filas y las 5 primeras columnas.

df <- iris[1:5,1:5]

df

df3 <- df [c(3,5),c(1,3)]
df3


#5.Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.

df$Species <- NULL
df [,c("Sepal.Length","Petal.Length")] <- NULL
df

#6.Escriba un programa en R para agregar una nueva columna en un data.frame determinado.

iris$nueva_variable <- 1:150 #o cbind(iris, nueva_variable=1:150)
names(iris)
str(iris)


#7.Escriba un programa en R para ordenar un data.frame dado por varias columnas.


mtcars

mtcars[with(mtcars, order(-disp)),]


#8.Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.

jugadores_id <- 1:10
jugador_nombre <- c("Andrew", "Susan", "John", "Joe", "Jack",
                     "Jacob", "Mary", "Kate", "Jacqueline", "Ivy")
jugador_salario <- round(rnorm(10, mean = 1500, sd = 200))
jugador_edad <- round(rnorm(10, mean = 50, sd = 8))
jugador_puesto <- c("armador", "libero", "defensa", rep("rematador", 7))
df_1 <- data.frame(id = jugadores_id[1:8], nombre = jugador_nombre[1:8],
                   salario_mensual = jugador_salario[1:8])
df_1
df_2 <- data.frame(id = jugadores_id[-5], nombre = jugador_nombre[-5],
                   edad = jugador_edad[-5], puesto = jugador_puesto[-5])
df_2
q <-merge(df_1,df_2)
q1 <-merge(df_1,df_2,all = TRUE)
merge(df_1,df_2,all.x = TRUE)
merge(df_1,df_2,all.y = TRUE)


#9.Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.

df9 <- data.frame(col1= c(1, 3, 5, NA, 8, 10), col2 =c(NA, NA, 9, NA,5,6)) 
df9 [is.na(df9)] <-3
df9

#10.Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.

colnames(faithful) 
colnames(faithful) <-c("erupciones", "tiempo de espera")
faithful


#11.Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)

a <- data.frame(equipo = 1:8, puntos = c (88, 98, 94, 105, 995, 3608, 567, 4645 ))
a

b <- data.frame (equipo = 1:8,
                 puntos = c (88, 97, 94, 104, 995, 3600, 567, 4645))
b
setdiff(a$puntos,b$puntos)


#12.Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)

intersect(a$puntos,b$puntos)
intersect(a$equipo,b$equipo)

#13.Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)


union(a$puntos,b$puntos) 
union(a$equipo,b$equipo)

#14.Escriba un programa R para contar el número de valores NA en una columna de data.frames.
df14 <- data.frame(col1= c(1, 3, 5, NA, 8, 10), col2 =c(NA, NA, 9, NA,5,6))
df14.2<- is.na(df14)
sum(df14.2)

#15.Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)

j1 <- c(1,5,9,3,7,11,17,19)
j2 <- c(1,6,9,8,2,16,17,20)
df15 <- data.frame(x1=j1,x2=j2)
df15

df15dup <- df15[duplicated(df15),]
df15dup

#16.Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.


 airquality$Solar.R <- NULL  
 airquality$Wind <- NULL
airquality
  
#17.Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)

str(airquality) #si corresponde a un data.frame
?order

airquality[do.call(order, airquality),]
airquality <- airquality[order(airquality$Ozone,airquality$Temp),]


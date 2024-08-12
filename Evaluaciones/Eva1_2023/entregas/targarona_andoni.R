#Nombre: Andoni Targarona

#Parte 1

#1. (5pts) Cree los siguientes objetos de tipo vector

exVec1 <- c(-45, 3, 7, -39, 36)
exVec2 <- c(-46, -27, -22, -48, -21)
exVec3 <- seq(-5,5,by=0.5)

exVec1
exVec2
exVec3

#2. (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado <- c(exVec1,exVec2)
exVec_resultado

#3. (5pts) Usando indexación con paréntesis cuadrado:

#Devuelva el 3er elemento del vector exVec1

exVec1[3]

#Devuelva todo menos el 2do y 3er elemento en exVec2

exVec2[c(1,4,5)]

#4.(15pts) Use funciones u operadores de relación para:

#(3pts) Mostrar la cantidad de elementos de cada uno de los vectores creados arriba.

length(exVec1)
length(exVec2)
length(exVec3)

#(3pts) determinar la suma de elementos en el vector exVec1.

sum(exVec1)

#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)

prom <- mean(exVec2)
prom

#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

prom2 <- sum(na.omit(exVec2))/length(na.omit(exVec2))
prom2

#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos

prom==prom2

#(10pts) Explique que hace la siguiente operación e indique ¿por qué?

rnorm(6) + rnorm(2)

#rnorm crea una distribucion normal de numeros aleatorios con media 0 y desviación estándar 1. Al colocar en numero 6 en el parentésis se le dice al programa que entregue 6 valores aleatorios.

#(10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

#Vector númerico
(1:6)

#Vector lógico
c(TRUE,FALSE,FALSE,TRUE)

#Vector complejo
c(1i+2+1i+3+1i)

#Vector de caracter
c('a,b,c,d,e,f')

#7. (10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars.

log <- c(TRUE,NA,FALSE,TRUE,NA,TRUE)
mat <- matrix(1:9,nrow = 3,ncol=3)
dat <- data.frame(mtcars)

list(log,mat,dat)

#8. (15 pts) Muestre tres formas de indexar la primera columna del data.frame airquality

data.frame(airquality)

#1
airquality['Ozone']

#2
airquality$Ozone

#3
substr(airquality$Ozone,1,153)

#9. (10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.

m <- matrix(1:9,3)
m
#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

#El primer código tiene el valor 'drop=TRUE' lo que elimina las columnas menos la primera, y convierte la matriz en un vector. En cambio el segundo código extrae la primera columna, manteniendo las dimensiones de la matriz, y por ende, no deja de ser una.

#10. (10pts) Haga una union por por columna de las matrices m1 y m2.

m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)

cbind(m1,m2)

#11.(24pts) Respecto del data.frame USArrests que vienen incorporados en R, realice lo siguiente:

#(6pts) Cree un nuevo data.frame de nombre USArrest2 que tenga las columnas Murder, UrbanPop y Rape. Hágalo de dos maneras diferentes

USArrests

Murder<-(c(USArrests$Murder))
UrbanPop<-(c(USArrests$UrbanPop))
Rape<-(c(USArrests$Rape))

USArrests2 <- data.frame(Murder,UrbanPop,Rape)
USArrests2

#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

nueva_col <- (1:50)

USArrests2 <- as.data.frame(cbind(nueva_col,Murder,UrbanPop,Rape))
USArrests2

#(6pts) Cree un nuevo data.frame USArrest3 en el que estén solo las filas 40, 21, 9, 8, 24. Hágalo de dos maneras diferentes.

#Forma 1
USArrests3 <- USArrests2[c(40,21,9,8,24),]
USArrests3

#Forma 2
y <- USArrests2[c(40,21,9,8,24),]

USArrests3 <- y
USArrests3

#(6pts) Cree un nuevo data.frame USArrest4 en el que estén las filas que cumplen la condición Murder menor o igual a 8.

x <- USArrests2$Murder<=8

USArrests4 <- USArrests2[x,]
USArrests4 

#(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

#Vector númerico
n <- (1:5)

#Vector lógico
l <- c(TRUE,FALSE,FALSE,TRUE,TRUE)

#Vector de caracter
ca <- c('a,b,c,d,e')

data.frame(n,ca,l)

#(25pts) Para los siguientes ejercicios utilice el data.frame USArrests

#Use funciones para mostrar:
  
#(5pts) la estructura del set de datos

str(USArrests)

#(5pts) el número de columnas y de filas del set de datos

length(colnames(USArrests))
length(rownames(USArrests))

#(5pts) el nombre de las columnas del set de datos

colnames(USArrests)

#(5pts) el encabezado del set de datos


#(5pts) los últimos seis elementos del set de datos

USArrests[c(46,47,48,49,50),]

#(15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?

#Los data frame no pueden almacear datos geometricos como vectores, en cambio la clase sf puede almacenar distintos tipos de geometria.

#Parte 2

#(50pts) Con el archivo que se encuentra en formato CSV :

#(10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data

ema<-read.csv('datosr/data_1/datos_ema_49.csv')
ema

#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).

summary(ema)

#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.

#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.

a<-ema$fecha_hora
b<-ema$humed_rel_promedio
c<-ema$veloc_max_viento

data.frame(a,b,c)


  
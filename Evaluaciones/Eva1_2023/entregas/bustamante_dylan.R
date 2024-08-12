#1. (5pts) Cree los siguientes objetos de tipo vector

exVec1 <- c(-34,16, 38, -19, -40)
exVec1
exVec2 <- c(-38, 34, 37, -27, -3)
exVec2
exVec3 <- seq(-5, 5, by=0.5)
exVec3

#2. (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado <- c(exVec1,exVec2)
exVec_resultado

#3. (5pts) Usando indexación con paréntesis cuadrado:
#  devuelva el 3er elemento del vector exVec1
#  devuelva todo menos el 2do y 3er elemento en exVec2

exVec1 [3]

exVec2 [c(1, 4, 5)]


#4. Use funciones u operadores de relación para:
#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length (exVec1)
length (exVec2)
length (exVec3)
length (exVec_resultado)
#(3pts) determinar la suma de elementos en el vector exVec1.

exVec1 <- c(-34,16, 38, -19, -40)
exVec1
sum(exVec1)

#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)

mean(exVec2, na.rm = TRUE)
?mean
#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

sum(exVec2)
length(exVec2)
na.omit(exVec2)
mean(exVec2)

#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos

mean(exVec2)
mean(exVec2, na.rm = TRUE)


# 5. Explique que hace la siguiente operación e indique ¿por qué?, rnorm(6) + rnorm(2)
# rnorm esta creando una curva de campana de una distribución normal aleatoria en el cual el 6 y el 2 son 2 vectores asignados a esos numeros y se estan sumando.

rnorm(6) + rnorm(2)
rnorm(6)
rnorm(2)



#6.(10pts)Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

# Integer
x<- c(1L,2L,3L)
x
class(x)

# Numeric
z <- c(1,2,3)
z
class(z)

# Logical
k <- c(TRUE,FALSE,FALSE)
class(k)

# Character
ñ <- c("Dylan","Javiera")
ñ
class(ñ)

#complex
y<-c(25+50i, 10i, 1+2i)
y
class(y)


#7.(10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
l <- list(e1 = c(TRUE,TRUE,FALSE),
          e2 = matrix(1:9,3),
          df = list(mtcars))
l



#8.(15 pts) Muestre tres formas de indexar la primera columna del data.frame USArrests

data.frame <- data.frame(USArrests)
data.frame

ncol(USArrests)

USArrests["Murder"]
USArrests$Murder



#9.Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.

m <- matrix(1:9,3)
m
#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]
?drop

# RESPUESTA : en la matriz codigo 1 se indexo solo la primera columna con sus valores pero en codigo 2 se mostro los mismos valores pero con su columna y fila, ya que drop elimina las dimensiones de una matriz que tiene un solo nivel.

#10.Haga una union por columna de las matrices m1 y m2.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)

m3 <- union(m1,m2)
m3

# data frame AIRQUALITY
# 11.(24pts) Respecto del data.frame airquality que vienen incorporados en R, realice lo siguiente:

  data.frame <- (airquality)
airquality

  #(6pts) Cree un nuevo data.frame de nombre airquality2 que tenga las columnas Ozone, Temp y Month. Hágalo de dos maneras diferentes.

airquality2 <- (airquality)
airquality2


  #(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

nueva_col <- airquality2[1:153,]
nueva_col

 #(6pts) Cree un nuevo data.frame airquality3 en el que estén solo las filas 111, 90, 41, 87, 23. Hágalo de dos maneras diferentes.



 #(6pts) Cree un nuevo data.frame airquality4 en el que estén las filas que cumplen la condición Solar.R mayores a 200


#12. (10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.


# Numeric
z <- c(1,2,3,4,5)
z

# Logical
k <- c(TRUE,FALSE,FALSE,TRUE,TRUE)

# Character
ñ <- c("Dylan","Javiera","Pedro","Juan","Diego")
ñ


z <- 1:5
ñ <- c("Dylan","Javiera","Pedro","Juan","Diego")
k <- c(TRUE,FALSE,FALSE,TRUE,TRUE)


df <- data.frame(numeros = z,
                 letras = ñ,
                 logicos = k)
                 
df


#13 .Para los siguientes ejercicios utilice el data.frame airquality
airquality
#Use funciones para mostrar:
  
#(5pts) la estructura del set de datos
str(airquality)

#(5pts) el número de columnas y de filas del set de datos
ncol(airquality)
nrow(airquality)
dim(airquality)

#(5pts) el nombre de las columnas del set de datos
colnames(airquality)

#(5pts) el encabezado del set de datos
head(airquality)

#(5pts) los últimos seis elementos del set de datos
tail(airquality)

#14. (15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?

#RESPUESTA: los objetos sf son extensiones del data.frame que se le agrega por asi decir una base de datos al data.frame que no la tiene instalada por lo cual tenemos que instalar el paquete sf para poder ocupar sus funciones entre otras cosas y data.frame es una estructura de datos con dos dimensiones en la cual se puede guardar datos de distintos tipos en columnas.


#Parte 2: Manejo de archivos
#(50pts) Con el archivo que se encuentra en formato CSV :
 
 
#(10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
data <- read.csv('data/datos_ema_309.csv')
data

#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).

str(data)

#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.



#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.


#(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.


#parte 2 de 2 
#(80pts) Con el archivo que se encuentra en formato Geopackage:
 
#(10pts) Cargue el archivo en R y asígnelo al objeto geo.
install.packages(geopackages)
                 
                 
#(10pts) ¿Qué clase de objeto es geo?

class(geo)

#(10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.

#(10pts) ¿Cuántas variables y observaciones tiene geo?
  
#(20pts) Haga un mapa en donde se muestre la variación de la variable comuna.

#(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.














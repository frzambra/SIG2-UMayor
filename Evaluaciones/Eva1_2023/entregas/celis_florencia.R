#prueba tipo 3 Nombre: florencia celis 
#1.
exVec1<- c(-3, 45, 41, 31, -40)
exVec1
exVec2<- c(44, NA, -30, 39, 22)
exVec2
exVec3<- seq(-5, 5,0.5)
exVec3
#2.Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
exVec_resultado<- c(exVec1,exVec2)
exVec_resultado

#3 
exVec1<- c(-3, 45, 41, 31, -40)
exVec1[3]
elemento3<- exVec1[3]
elemento3
#devuelva todo menos el 2do y 3er elemento en exVec2
exVec2<- c(44, NA, -30, 39, 22)
exVec2[-c(2,3)]

#4.1- mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
v1<- length(exVec1)
v1
v2<- length(exVec2)
v2
v3<- length(exVec3)
v3
#2-determinar la suma de elementos en el vector exVec1.
sum1<- sum(exVec1)
sum1
sum2<- sum(exVec2, na.rm = TRUE)
sum2
sum3<- sum(exVec3)
sum3
#3-determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
promedio<- mean(exVec2,na.rm = TRUE )
promedio
#4-calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
exVec2_sin_na<- na.omit(exVec2)
exVec2_sin_na
promedio2 <- sum(exVec2_sin_na) / length(exVec2_sin_na)
promedio2
#muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
print(promedio<- mean(exVec2,na.rm = TRUE ))
print(promedio2 <- sum(exVec2_sin_na) / length(exVec2_sin_na))

#5.Explique que hace la siguiente operación e indique ¿por qué?
rnorm(6) + rnorm(2)
#lo que realiza esta operacion es calcular la distribucion normal, suma la distribucion normal aleatoria con 6 observaciones y la distribucion normal aleatoria con 2 observaciones.

#6. Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
vectornumerico<- c(1,2,3,4,5)
vectornumerico

vectorcomplejo<- vector("complex",5)
vectorcomplejo

vectorlogico<- vector("logical",5)
vectorlogico

vectorcaracter <- c("a","b","c","d","e")
vectorcaracter

#7.De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars

vector<- vector("logical",4)
vector
matriz<-matrix(1:9, ncol = 3,nrow = 3)
matriz
dataframez<-head(mtcars)
dataframez

list(vector,matriz,dataframez)

#8. Muestre tres formas de indexar la primera columna del data.frame airquality
head(airquality)
airquality$Ozone
airquality[,1]


#9.Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
m <- matrix(1:9,3)
m
#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]
#la diferencia de los resultados de las dos matrices, es que en el codigo 2 al utilizar drop = false evita la simplificación del resultado a un vector, por lo que , mantiene la estructura de la matriz.

#10.Haga una union por por columna de las matrices m1 y m2.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m1
m2 <- matrix(1:sample(seq(9,18,3),1),3)
m2
cbind(m1,m2)

#11.(24pts) Respecto del data.frame airquality que vienen incorporados en R, realice lo siguiente:
#Cargar el conjunto de datos airquality

data(airquality)
#1- Cree un nuevo data.frame de nombre airquality2 que tenga las columnas Wind, Month y Solar.R. Hágalo de dos maneras diferentes.
#forma 1
airquality2_1 <- airquality[, c("Wind", "Month", "Solar.R")]
airquality2_1
#forma2
airquiality2_2<- subset(airquality, select = c(Wind, Month, Solar.R))
airquiality2_2

#2- Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

airquality$nueva_col <- 1:nrow(airquality)
airquality$nueva_col
#3-Cree un nuevo data.frame airquality3 en el que estén solo las filas 56, 29, 31, 27, 147. Hágalo de dos maneras diferentes.
#Forma 1
filas_seleccionadas <- c(56, 29, 31, 27, 147)
airquality3_1 <- airquality[filas_seleccionadas, ]

# Forma 2
airquality3_2 <- airquality[c(56, 29, 31, 27, 147), ]

#4-Cree un nuevo data.frame airquality4 en el que estén las filas que cumplen la condición Solar.R mayores a 200

airquality4 <- subset(airquality, Solar.R > 200)

#12. De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.
numerico<- c(5,4,3,2,1)
caracter<-c("a","b","c","d","e")
logico<- vector("logical",5)
dt<- data.frame(numerico,caracter,logico)
dt

#13.Para los siguientes ejercicios utilice el data.frame airquality
head(airquality)
#1-la estructura del set de datos
str(airquality)
#2- el número de columnas y de filas del set de datos
dim(airquality)
#3- el nombre de las columnas del set de datos
colnames(airquality)
#4- el encabezado del set de datos
head(airquality)
#5-los últimos seis elementos del set de datos
tail(airquality)

#14. ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?
# la diferencia entre un objeto de clase de data.frame y uno de clase contiene al menos una geometría que incluye puntos, líneas o polígonos, un Sistema de referencia de coordenadas y atributos asociados a cada elemento geográfico, a diferencia de un objeto de data frame son solo datos alfanumericos. 


#1.Con el archivo que se encuentra en formato CSV :
#1- Cargue el archivo en formato CSV en R y asignelo al objeto data
data <- read.csv('data/datos_ema_203.csv', stringsAsFactors = FALSE)
data
#2-De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)
#3- Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
promedio_humedad <- mean(data$humed_rel_promedio, na.rm = TRUE)
promedio_humedad
mayores_promedio <- data[data$humed_rel_promedio > promedio_humedad, ]
mayores_promedio

#4-Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.

variables_seleccionadas <- mayores_promedio[, c("fecha_hora", "humed_rel_promedio", "veloc_max_viento")]
variables_seleccionadas
#5-Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.
write.csv(variables_seleccionadas, file = "datos_21.csv", row.names = FALSE, fileEncoding = "latin1")


#2. Con el archivo que se encuentra en formato Geopackage:
install.packages("sf")
library(sf)
#1-Cargue el archivo en R y asígnelo al objeto geo.
geo<-read_sf('data/region_Los lagos.gpkg')
geo<- setwd
#2- ¿Qué clase de objeto es geo?
class(geo)
#3-Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
#4-¿Cuántas variables y observaciones tiene geo?
#5- Haga un mapa en donde se muestre la variación de la variable comuna.
#6- Seleccione todas las estaciones que pertenecen a la institución INIA.
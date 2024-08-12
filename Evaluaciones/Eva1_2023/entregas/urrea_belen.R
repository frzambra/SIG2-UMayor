################## Evaluación 1 de SIG 
#######################################   P A R T E    1 ###################################################
# 1 (5pts) Cree los siguientes objetos de tipo vector
exVec1 <- c(4, -45, -4, -31, -32)
exVec2 <- c(21, 4, 17, 43, 12)
exVec3 <- seq(from=-5.0,to=5.0,by=0.5)

# Ejercicio 2 (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
exVec_resultado <- c(exVec1, exVec2)
exVec_resultado

# Ejercicio 3 (5pts) Usando indexación con paréntesis cuadrado:
#devuelva el 3er elemento del vector exVec1
#devuelva todo menos el 2do y 3er elemento en exVec2
exVec1[3]
exVec2[c(1,4,5)]

#Ejercicio 4 (15pts) Use funciones u operadores de relación para:
#mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)
length(exVec2)
length(exVec3)
#determinar la suma de elementos en el vector exVec1.
sum(exVec1)
#determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
exVec2_promedio <- c(mean(exVec2), na.rm= FALSE) #no considerando NA
exVec2_promedio

exVec2_promedio <- c(mean(exVec2), na.rm=TRUE) #Consideranco NA en el calculo
exVec2_promedio
#calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
#muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
Prom1 <- sum(exVec2)
Prom2 <- length(exVec2)
Prom3 <- c(Prom1/Prom2)
Prom3

#muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
exVec2_promedio == Prom3

#Ejercicio 5 Explique que hace la siguiente operación e indique ¿por qué?
rnorm(6) + rnorm(2)
#La siguiente funcion esta ostrando la suma de rnom,  una funcion que realiza una distribucion normal, el 6 del parentesis quiere decir que la desviacion extandar es de 6, y en el caso de rnorm(2) la desviacion es de 2. 

#Ejercicio 6 Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
#Existen tres tipos de vectores; numerico, cadena de texto y valor logico 

vec_numeric <- c(25, 4, 17, 47, 14)
vec_tex <- c("cadena", "de", "texto")
vec_log <- c(TRUE, FALSE,TRUE,FALSE,FALSE)


# Ejercicio 7 De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
vec_log #usaremos vec_log como vector logico
MA1 <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
MA1     
Data_frame1 <- head(mtcars)

Lista1 <- list(vec_log, MA1, Data_frame1)
Lista1

# Ejercicio 8 Muestre tres formas de indexar la primera columna del data.frame USArrests
USArrests[,1]
USArrests$Murder

#########################################Revisar ############################
index <- which(USArrests$Murder == "Murder")
USArrests[index, 1 ]


#Ejercicio 9 Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
m <- matrix(1:9,3)
m
#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]
#La diferencia de este resulado es que en el codigo 1 al indexar el resultado te lo regresa como vector, es decir, pierde su fomra coo matriz ya que estamos indexando una columna. En el caso del segundo codigo, al realizar la indexación no se pierde la estructura de la columna. 

# Ejercicio 10 Haga una union por por columna de las matrices m1 y m2. 
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)
cbind(m1,m2)           #para la union se uso la funcion cbind 


# Ejercicio 11 Respecto del data.frame mtcars que vienen incorporados en R, realice lo siguiente:
#Cree un nuevo data.frame de nombre mtcars2 que tenga las columnas drat, qsec y carb. Hágalo de dos maneras diferentes.
DRAT <- mtcars$drat
QSEC <- mtcars$qsec
CARB <- mtcars$carb
mtcars2 <- data.frame(DRAT, QSEC, CARB)                      #Forma 1
mtcars2 

mtcars_2 <- data.frame(mtcars[c(5,7,11)])                    #Forma 2, el vector es mtcars_2

#Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
mtcars_2$nueva_col <- (1:32)
mtcars_2

#Cree un nuevo data.frame mtcars3 en el que estén solo las filas 18, 12, 14, 10, 2. Hágalo de dos maneras diferentes.
mtcars3 <- data.frame(mtcars[c(18, 12, 14, 10, 2),])
mtcars3

#Cree un nuevo data.frame mtcars4 en el que estén las filas que cumplen la condición mpg menores a 21
mtcars4 <- mtcars[mtcars$mpg < 21, ]

# Ejercicio 12  De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

vec_1 <- c(25, 32, 17, 43, 19)
vec_2 <- c("A", "B", "C", "D", "E")
vec_3 <- c(TRUE, FALSE,TRUE,FALSE,FALSE)

data12 <- data.frame(vec_1, vec_2, vec_3)
data12
colnames(data12) <- c('Numeros', 'Caracteres', 'Logicos')
data12

# Ejercicio 13 Para los siguientes ejercicios utilice el data.frame mtcars. Use funciones para mostrar:
#la estructura del set de datos
str(mtcars)
#el número de columnas y de filas del set de datos
dim(mtcars)
#el nombre de las columnas del set de datos
colnames(mtcars)
#el encabezado del set de datos
head(mtcars)
#los últimos seis elementos del set de datos
tail(mtcars)

# Ejercicio 14 ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?
#La diferencia entre un objeto data frame y uno sf, es que el 'data frame' puede contener varios columnas con diferentes tipos de datos , tant carcateres, logicos y numericos. En el caso de 'sf' este puede describir la geometria y los atributos de la entidad.


############################################# P A R T E     2 ###########################################
#Ejercicio 1 Con el archivo que se encuentra en formato CSV 
#Cargue el archivo en formato CSV en R y asignelo al objeto data
data <- read.csv('data/datos_ema_126.csv')
data

#De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)

#Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
Prom_HM <- mean(data$humed_rel_promedio)
Obs_HM <- data[data$humed_rel_promedio > Prom_HM, ]

#Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.
Obs_HM <- data[,c(2,5,8)]
Obs_HM

#Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.
Obs_HM
write.csv2(Obs_HM,'datos_21.csv')

# Ejercicio 2 Con el archivo que se encuentra en formato Geopackage
#Cargue el archivo en R y asígnelo al objeto geo.
install.packages('sf')
library(sf)
geo <- st_read('data/region_Coquimbo.gpkg')
 
#¿Qué clase de objeto es geo?
#La clase de objeto que es geo es sf. Esto se sabe por usar la funcion class
class(geo)

#Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
#Geo contiene 55 geometrias de tipo punto. Esto se sabe al agudar la variable puedes abrirla desde el Global Environment y se puede ver todos los datos que contiene o usando la funcion str(geo).

#¿Cuántas variables y observaciones tiene geo?
#Geo tiene 55 observaciones y 7 variables, esto se obtiene por medio de la funcion str
str(geo) 

#Haga un mapa en donde se muestre la variación de la variable comuna.
geo$comuna
plot(geo$comuna)

#Seleccione todas las estaciones que pertenecen a la institución INIA.
INIA <- geo[geo$institucion == "INIA" , ]
INIA

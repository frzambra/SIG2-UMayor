#PRUEBA PARCIAL 1 
#INTEGRANTE: Javiera Cerda
#FECHA: 6/10

#Parte 1: Estructuras y manipulación de datos en R

#1. (5pts) Cree los siguientes objetos de tipo vector
#exVec1 con los números: 4, -45, -4, -31, -32
#exVec2 con los números: 21, 4, 17, 43, 12
#exVec3 con la sequencia -5 a 5 cada 0.5 (ej, -5.0, -4.5, -4.0, y así hasta 5.0)


exVec1 <- c(4, -45, -4, -31, -32)
exVec2 <- c(21,4,17,43,12)
?seq
seq(from=-5, to=5, by=0.5)
exVec3 <- seq(from=-5, to=5, by=0.5)


#2. (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado <- c(exVec1, exVec2)
exVec_resultado


#3. (5pts) Usando indexación con paréntesis cuadrado:
#devuelva el 3er elemento del vector exVec1
#devuelva todo menos el 2do y 3er elemento en exVec2

exVec1
exVec1[3]

exVec2
exVec2[-c(2, 3)]


#4.(15pts) Use funciones u operadores de relación para:

#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)
length(exVec2)
length(exVec3)
length(exVec_resultado)

#(3pts) determinar la suma de elementos en el vector exVec1. 

exVec1 <- c(4, -45, -4, -31, -32)
sum(exVec1) 

#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)

?mean
prom_exVec2 <- mean(exVec2, na.rm = TRUE)

#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

sum <- sum(exVec2)
length<- length(exVec2)
?na.omit
prom_exVec2 <- sum/length
resultado <- na.omit(prom_exVec2)

#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos

prom_exVec2 == resultado

#5. (10pts) Explique que hace la siguiente operación e indique ¿por qué?
#rnorm(6) + rnorm(2)

?rnorm
rnorm(6)+rnorm(2)
#Primero que todo, rnorm crea valores aleatorios  aleatorios para una distribución normal, en donde, por defecto viene con un promedio de 0 y una desviacion estandar de 1. Por lo que esta sacando la distribucion normal del tipo de dato numeric 6 y la distribucion de normal del tipo 2, en donde se suman, simepre entregando valores aleatorios. 

#6. (10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

#Primero que todo, un vector es colección de uno o más datos del mismo tipo y podemos tener dos tipos en R; Vectores atomicos y listas. 
# Los Vectores atómicos: son homogéneos, es decir, tienen que almacenar el mismo tipo de elementos, o todos son numericos, o todos logicos y asi). Tenemos seis tipos dentro de éste; logicos, integer, double, character, complex, and raw. Se debe destacar que los vectores tipo integer y double son conocidos como vectores numericos.

#Mientras que, las istas o tambien llamadas vectores recursivos porque puede contener otras listas, son hetereogéneos, es decir, pueden tener difernetes tipos de datos. 


#Cabe destacar que los NA (valores faltantes, not available) pueden estar en vectores numéricos, de carácter, fecha y hora y lógico, no rompen la homogeneidad


#7. (10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars



l <- list(vector <- c(TRUE, FALSE),
          matrix (1:9, nrow = 3, ncol = 3),
          data.frame(mtcars))
l

#8.(15 pts) Muestre tres formas de indexar la primera columna del data.frame USArrests

data.frame(USArrests)

#Técnicas de indexación con which, %in% y match (no sirve en este caso)

#Forma 1: indexacion de la primera columna con corchetes y el número de columna
forma_1 <- USArrests[, 1]
forma_1

#Forma 2: indexacion de la primera columna con $ 
forma_2 <- USArrests$Murder
forma_2

#Forma 2: indexación de la primera columna con corchetes 
# Indexar la primera columna usando notación de corchetes con comillas
forma_3 <- USArrests["Murder"]
forma_3


#9. (10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.

m <- matrix(1:9,3)
m

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]


?matrix
#en ambos casos contamos con una matriz de 9 elementos, con 3 filas, y se solicita que se extraiga la primera columna, sin embargo, la aplicacion del drop=false viene dado ya que al devolver filas o columnas individuales, la salida será un vector, entonces, si esto no es lo que desea hacer o se quiere evitar esta situacion, se usa el drop = FALSE.



#10. (10pts) Haga una union por por columna de las matrices m1 y m2.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)

?cbind
cbind(m1, m2)

#11.(24pts) Respecto del data.frame mtcars que vienen incorporados en R, realice lo siguiente:
#(6pts) Cree un nuevo data.frame de nombre mtcars2 que tenga las columnas drat, qsec y carb. Hágalo de dos maneras diferentes.

data.frame(mtcars)

#forma 1: indicandole a el nuevo data.frame mtcars el nombre de las columnas
mtcars2 <- mtcars[c("drat", "qsec", "carb")]
mtcars2
names(mtcars2)

#forma 2: indicandole a el nuevo data.frame mtcars el nombre de las columnas
mtcars2 <- mtcars[, c ("drat", "qsec", "carb")] 
mtcars2
colnames(mtcars2)

#en ambos casos se comprueba que el nombre de las columnas es el correcto gracias a la funcion names o colnames

#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

# se llama a mtcars2, y a traves del $ se le otorga una nueva columna, llamada "nueva_col", luego, se toman valores de 1 hasta el numero de filas (nrow) del data.frame 

?nrow
nrow(data.frame(mtcars2))
mtcars2$nueva_col <- 1:nrow (data.frame(mtcars2))
mtcars2

#(6pts) Cree un nuevo data.frame mtcars3 en el que estén solo las filas 18, 12, 14, 10, 2. Hágalo de dos maneras diferentes.

#filas: 18, 12, 14, 10 y 2 
rownames(mtcars)
#nombres de fila:
#2: "Mazda RX4 Wag"
#10:"Merc 280"
#12: "Merc 450SE"   
#14: "Merc 450SLC"  
#18: "Fiat 128" 

#forma 1: 
?subset
mtcars3 <- subset(mtcars, row.names(mtcars) %in% c(18, 12, 14, 10, 2))
mtcars3

#forma 2 
mtcars3 <- mtcars[c(18,12,14,10,2), ]
mtcars3

#(6pts) Cree un nuevo data.frame mtcars4 en el que estén las filas que cumplen la condición mpg menores a 21

mtcars4 <- subset(mtcars, mpg < 21)
mtcars4

#12.(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado

v_num <- c(4, 2 , 3.5 , 7, 8)
v_charac <- c("JAVIERA", "FRANCISCO", "BARBARA", "JACQUELINE", "BASTIAN")
v_log <- c(TRUE, FALSE, FALSE, TRUE, FALSE)

df <- data.frame(numerico = v_num, 
                 character = v_charac, 
                 logical = v_log)
df


#13.(25pts) Para los siguientes ejercicios utilice el data.frame mtcars

#Use funciones para mostrar:
  
#(5pts) la estructura del set de datos
data.frame(mtcars)
str(mtcars)

#(5pts) el número de columnas y de filas del set de datos
?ncol
?nrow

num_fila <- nrow(mtcars)
fila

num_columna <- ncol(mtcars)
columna

#(5pts) el nombre de las columnas del set de datos
?colnames
?names

nom_columna <- colnames(mtcars)
nom_columna

#(5pts) el encabezado del set de datos
?head
head(mtcars)

#(5pts) los últimos seis elementos del set de datos
?tail
tail(mtcars, 6)

#14. (15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?

#data.frame: estructura de datos,  para almacenar información en filas y columnas, tiene dimensiones, se utiliza para datos no espaciales y tablas de datos, además, cada columna puede contener diferentes tipos de datos (numéricos, caracteres, lógicos, etc.).
# sf: este tipo de objeto por el contrario, si utiliza datos espaciales e   información geoespacial (puntos, líneas y polígonos), incluyendo coordenadas espaciales que representan la ubicación geográfica.Nos sirve para mapear 




#Parte 2: Manejo de archivos
#Datos: Descargue los archivos desde este link

#1. (50pts) Con el archivo que se encuentra en formato CSV :


#(10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
getwd()

read.csv("data/datos_ema_126.csv")
data <- read.csv ("data/datos_ema_126.csv")

#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)

#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
data$humed_rel_promedio
mean(data$humed_rel_promedio)
obs_mayores <- data$humed_rel_promedio > mean(data$humed_rel_promedio)
obs_mayores

#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.
fecha_hora <- data$fecha_hora
humed_rel_promedio <- data$humed_rel_promedio
veloc_max_viento <- data$veloc_max_viento

#(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.

?write.csv 
write.csv(data, "datos_21.csv")


#2. (80pts) Con el archivo que se encuentra en formato Geopackage:

#(10pts) Cargue el archivo en R y asígnelo al objeto geo.
install.packages("sf")
install.packages("tibble")
library(sf)
geo <- read_sf("data/region_Coquimbo.gpkg")
geo <- st_read("data/region_Coquimbo.gpkg")

#(10pts) ¿Qué clase de objeto es geo?
#es un data.frame
class(geo)

#(10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.

str(geo)
#tipo de geometriua 
st_geometry_type(geo)
#cantidad de geometrias 
length(geo)

#(10pts) ¿Cuántas variables y observaciones tiene geo?
#55 obs y 7 variables 

#(20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
geo$comuna

plot(geo["comuna"])


#(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA

estaciones <- geo[geo$institucion == "INIA", ]
estaciones


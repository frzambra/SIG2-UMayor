#(5pts) Cree los siguientes objetos de tipo vector
#exVec1 con los números: 4, -45, -4, -31, -32
#exVec2 con los números: 21, 4, 17, 43, 12
#exVec3 con la sequencia -5 a 5 cada 0.5 (ej, -5.0, -4.5, -4.0, y así hasta 5.0)

exvec <- c(4, -45, -4, -31, -32)
exvec2 <- c(21, 4, 17, 43, 12)
exvec3 <- seq(from = -5, to = 5, by = 0.5)

#(5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado <- c(exvec,  exvec2)

#(5pts) Usando indexación con paréntesis cuadrado:
#devuelva el 3er elemento del vector exVec1
#devuelva todo menos el 2do y 3er elemento en exVec2

exvec[3]
exvec2[c(1,4:5)]

#(15pts) Use funciones u operadores de relación para:
#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exvec)
length(exvec2)
length(exvec3)

#(3pts) determinar la suma de elementos en el vector exVec1.

sum(exvec)

#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
promedio1 <- mean(exvec2, na.rm = TRUE)

#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

suma <- sum(exvec2, na.rm = TRUE)
divisor <- length(na.omit(exvec2))
promedio2 <- as.numeric(suma/divisor)

#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
promedio1 %in% promedio2

#(10pts) Explique que hace la siguiente operación e indique ¿por qué? rnorm(6) + rnorm(2)
?rnorm
rnorm(6) generará 6 números aleatorios de una distribución normal estándar
rnorm(2) generará otros 2 números aleatorios de una distribución normal estándar.
rnorm(6) + rnorm(2) generará dos conjuntos de números aleatorios, uno con 6 números y otro con 2 números resultando en la suma de los dos conjuntos de numeros (elemento por elemento)

#Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
#Seis tipos: logicos, integer, double, character, complex, and raw. Vectores tipo integer y double son conocidos como vectores numericos.

#vectores numericos
x <- 1 
class(x)

#vectores caracter
y <- "ayuda"
class(y)

#Vectores logicos
z <- TRUE
class(z)

#Vectores complex
c1<-c(1+2i, 4i, 3+6i)
class(c1)

#(10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars

vector_logico <- c(TRUE, FALSE, TRUE, FALSE)
matriz <- matrix(1:9, nrow = 3)
data_frame <- data.frame(mtcars)
mi_lista <- list(vector_logico, matriz, data_frame)

#(15 pts) Muestre tres formas de indexar la primera columna del data.frame USArrests

USArrests[,1]
USArrests[,"Murder"]
USArrests$Murder

#####(10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
#m <- matrix(1:9,3)
#codigo 1
#m[,1]
#codigo 2
#m[,1,drop = FALSE]
m <- matrix(1:9,3)
#El código 1 extrae la primera columna de la matriz m como un vector en lugar de mantener la estructura de matriz resultando en un vector unidimensional
m[,1,drop = FALSE]
#El código 2, da resultado seguirá siendo una matriz de una sola columna, incluso si esa columna contiene solo un elemento
#drop = FALSE se utiliza para evitar la reducción de la estructura de la matriz cuando se extrae una sola columna.

#(10pts) Haga una union por por columna de las matrices m1 y m2.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)
cbind(m1,m2)

#(24pts) Respecto del data.frame mtcars que vienen incorporados en R, realice lo siguiente:
#(6pts) Cree un nuevo data.frame de nombre mtcars2 que tenga las columnas drat, qsec y carb. Hágalo de dos maneras diferentes.
mtcars
mtcars2 <- mtcars[,c("drat","qsec", "carb")]
mtcars2 <- mtcars[,c(5,7,11)]

#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

mtcars$nueva_col <- 1:nrow(mtcars)
mtcars

#(6pts) Cree un nuevo data.frame mtcars3 en el que estén solo las filas 18, 12, 14, 10, 2. Hágalo de dos maneras diferentes.

mtcars3 <- mtcars[c("Fiat 128","Merc 450SE", "Merc 450SLC", "Merc 280", "Mazda RX4 Wag"),]
mtcars3 <- mtcars[c(18, 12, 14, 10, 2),]

####(6pts) Cree un nuevo data.frame mtcars4 en el que estén las filas que cumplen la condición mpg menores a 21
mtcars4 <- mtcars[mtcars$mpg < 21, ]

# (10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

v1<- c(1, 2, 3, 4, 5)
v2 <- c("a", "b", "c", "d", "e")
v3 <- c(TRUE, FALSE, TRUE, FALSE, TRUE)
dt <- data.frame(numeros = v1, caracteres = v2, logicos = v3)

#(25pts) Para los siguientes ejercicios utilice el data.frame mtcars                             
#(5pts) la estructura del set de datos
str(mtcars)
#(5pts) el número de columnas y de filas del set de datos
dim(mtcars)
#(5pts) el nombre de las columnas del set de datos
colnames(mtcars)
#(5pts) el encabezado del set de datos
rownames(mtcars)
#(5pts) los últimos seis elementos del set de datos
tail(mtcars)

#(15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?

#Un data.frame es una estructura de datos que puede contener cualquier tipo de datos, en cambio un objeto de clase sf está específicamente diseñado para manejar datos espaciales con funciones para realizar operaciones espaciales y análisis geoespaciales.

#2 Parte 2: Manejo de archivos
#(50pts) Con el archivo que se encuentra en formato CSV :
#(10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data

data <- read.csv ("data2/datos_ema_126.csv")

#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)

#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.

data$humed_rel_promedio
promedio<-mean(data$humed_rel_promedio)
mayores<-data$humed_rel_promedio[data$humed_rel_promedio>promedio]


#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.

fechahora <- data$fecha_hora
humedadrelativa <- data$humed_rel_promedio
velocidadviento <- data$veloc_max_viento


#(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.

df <- data.frame(fechahora,humedadrelativa,velocidadviento)

#(80pts) Con el archivo que se encuentra en formato Geopackage:
install.packages('sf')
install.packages('tibble')
library(sf)

#(10pts) Cargue el archivo en R y asígnelo al objeto geo.
geo <-  read_sf('data2/region_Coquimbo.gpkg')

#(10pts) ¿Qué clase de objeto es geo?
class(geo)

#(10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
summary(geo)
#punto y 55 geomtrias

#(10pts) ¿Cuántas variables y observaciones tiene geo?
str(geo)
# 55 observaciones y 7 variables 

#(20pts) Haga un mapa en donde se muestre la variación de la variable comuna.

#(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.
etsaciones <- geo$institucion

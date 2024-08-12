#Primera prueba Parcial, 06 de octubre.
#Camila Fern?ndez Carrasco.

#(5pts) Cree los siguientes objetos de tipo vector


exVec1<- c(-3,45,41,31,-40)
exVec2<-c(44,NA,-30,39,22)
exVec3<-seq(from=-5,to=0.5,by=0.5)

#(5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una s?la linea). Muestre el resultado.

exVec_resultado <-c(exVec1,exVec2)

#(5pts) Usando indexaci?n con par?ntesis cuadrado:
#devuelva el 3er elemento del vector exVec1
#devuelva todo menos el 2do y 3er elemento en exVec2.

exVec1[3]

a<-exVec2[1]
b<-exVec2[4]
c<-exVec2[5]
extraer<-c(a,b,c)

sort(exVec1,decreasing = TRUE)[3]

#(15pts) Use funciones u operadores de relaci?n para:
#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.


length(exVec1)
length(exVec2)
length(exVec3)

#(3pts) determinar la suma de elementos en el vector exVec1.
sum(exVec1)

#(3pts) determinar el promedio del vector exVec2 usando la funci?n mean (nota: revisar el argumento na.rm de la funci?n mean)

v2<-mean(is.na(exVec2))

#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

# utilizare el vector v2 sin los NA y lo llamare v3
v3<-mean(is.na(exVec2))

#
promedio_v3 <- sum(v3) / length(v3)

# Mostrar el promedio
print(promedio_v3)



#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos

v2%in%v3

#5.(10pts) Explique que hace la siguiente operaci?n e indique ?por qu??
rnorm(6) + rnorm(2)

hist(rnorm(6) + rnorm(2))
#respuesta: el resultado de rnorm(6) + rnorm(2) ser? un nuevo vector con 6 elementos donde cada elemento es la suma de un n?mero aleatorio generado por rnorm(6) y un n?mero aleatorio generado por rnorm(2). Como resultado, obtendr?s un vector de 6 n?meros aleatorios que siguen una distribuci?n normal, pero con par?metros que pueden diferir de la distribuci?n est?ndar debido a la suma.


#6.(10pts) Cu?les son los tipos de vectores en R, de un ejemplo de cada caso.

#respuesta:vector, doble numerico,logico, carcater,factor, complejo, lista, entero

#7.(10pts) De un ejemplo de una lista que contenga como primer elemento un vector l?gico, como segundo una matriz 3x3, y como tercer el data.frame mtcars

# Crear un vector l?gico
vector_logico <- c(TRUE, FALSE, TRUE, TRUE, FALSE)

# Crear una matriz 3x3
matriz <- matrix(1:9, nrow = 3)

# Crear una lista que contenga los elementos
mi_lista <- list(vector_logico = vector_logico,  matriz = matriz,mtcars = mtcars)

# Verificar la estructura de la lista
str(mi_lista)



#8.(15 pts) Muestre tres formas de indexar la primera columna del data.frame airquality

data.frame(airquality)
dimnames(airquality)
#primera columna es Ozone.
primera_columna <- airquality$Ozone #llamando por columna con $
primera_columna <- airquality[[1]] #indexando con numero
primera_columna <- airquality["Ozone"] #indexando con caracter o nombre

#(10 pts) Se?ale cu?l es la diferencia en el resultado de los dos c?digos que se aplican a la matriz m.

m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]


#respuesta:la diferencia principal es que el c?digo 1 te dar? un vector 1D como resultado, mientras que el c?digo 2 te dar? una matriz 2D con una sola columna. La opci?n drop = FALSE en el c?digo 2 evita la reducci?n de la dimensi?n de la matriz original.


#(10pts) Haga una union por por columna de las matrices m1 y m2.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)

# Unir las matrices por columna
resultado <- cbind(m1, m2)

# Mostrar el resultado
print(resultado)

#11.(24pts) Respecto del data.frame airquality que vienen incorporados en R, realice lo siguiente:
#(6pts) Cree un nuevo data.frame de nombre airquality2 que tenga las columnas Wind, Month y Solar.R. H?galo de dos maneras diferentes.

# Crear airquality2 seleccionando las columnas Wind, Month y Solar.R
airquality2 <- airquality[c("Wind", "Month", "Solar.R")]

# Crear airquality2 especificando las columnas en data.frame()
airquality2 <- data.frame(Wind = airquality$Wind, Month = airquality$Month, Solar.R = airquality$Solar.R)




#(6pts) Agregue una nueva columna "nueva_col" la que debe contener los valores de 1 hasta el n?mero de filas del data.frame.
# Obtener el n?mero de filas del data.frame

num_filas <- nrow(airquality2)
dim(airquality2)
# Crear una nueva columna "nueva_col" con valores de 1 hasta el n?mero de filas

airquality2$nueva_col <- 1:num_filas

#(6pts) Cree un nuevo data.frame airquality3 en el que est?n solo las filas 56, 29, 31, 27, 147. H?galo de dos maneras diferentes.

# Crear airquality3 seleccionando las filas 56, 29, 31, 27 y 147
filas_seleccionadas <- c(56, 29, 31, 27, 147)
airquality3 <- airquality[filas_seleccionadas, ]

# Crear con funci?n subset
filas_seleccionadas <- c(56, 29, 31, 27, 147)
airquality3 <- subset(airquality, rownames(airquality) %in% filas_seleccionadas)


#(6pts) Cree un nuevo data.frame airquality4 en el que est?n las filas que cumplen la condici?n Solar.R mayores a 200

# Crear airquality4 con las filas donde Solar.R > 200
airquality4 <- subset(airquality, Solar.R > 200)

#12.(10pts) De un ejemplo de un vector num?rico, caracter y l?gico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.


vector_numerico <- c(1, 2, 3, 4, 5)

vector_caracter <- c("Audi", "Mercedez", "Ferrari", "Toyota", "Nissan")

vector_logico <- c(TRUE, FALSE, TRUE, FALSE, TRUE)

mi_data_frame <- data.frame(numeros = vector_numerico,caracteres = vector_caracter,logicos = vector_logico)

print(mi_data_frame)


#13.(25pts) Para los siguientes ejercicios utilice el data.frame airquality

#Use funciones para mostrar:
  
#(5pts) la estructura del set de datos

#resumen de datos
str(airquality)

# Mostrar las primeras filas del conjunto de datos airquality
head(airquality)

#(5pts) el n?mero de columnas y de filas del set de datos

dim(airquality)
#(5pts) el nombre de las columnas del set de datos

colnames(airquality)
dimnames(airquality)
#(5pts) el encabezado del set de datos

head(airquality)
names(airquality)
#(5pts) los ?ltimos seis elementos del set de datos
tail(airquality)

#14.?Cu?l es la diferencia entre un objeto de clase data.frame y uno de clase sf?
#respuesta:

#En resumen, la principal diferencia radica en la estructura de los datos, los data.frame: son adecuados para datos tabulares y datos  estad?sticas, mientras que los objetos sf son para vectoriales como datos geoespaciales y espaciales, lo que los hace m?s adecuados para el an?lisis y visualizaci?n de los sistema de informacion geogr?fica.


                     #######PARTE2 MANEJOS DE ARCHIVOS#####


#1(50pts) Con el archivo que se encuentra en formato CSV :

# instalar paquete readr
install.packages("readr")
# cargar paquete readr
library(readr)
 # (10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data

data<-read.csv("data_3/datos_ema_203.csv")
#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observacione).

str(data)

#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
colnames(data)
dim(data)
data$humed_rel_promedio
promedio<-mean(data$humed_rel_promedio)
mayores<-data$humed_rel_promedio[data$humed_rel_promedio>promedio]


#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.
fechahora <- data$fecha_hora
humedadrelativa <- data$humed_rel_promedio
velocidadviento <- data$veloc_max_viento


#(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con #2.formato CSV ("datos_21.csv") con configuraci?n latina.

data.frame(mayores,fechahora,humedadrelativa,velocidadviento)

#(80pts) Con el archivo que se encuentra en formato Geopackage:

install.packages("sf")
install.packages("tibble")
library(sf)
?read_sf
 # (10pts) Cargue el archivo en R y as?gnelo al objeto geo.

geo<-read_sf("data_3/region_Los Lagos.gpkg")

#(10pts) ?Qu? clase de objeto es geo?
class(geo)

#(10pts) Indique el tipo de geometr?a y la cantidad de geometrias que tiene geo.
plot(geo)
geo$geom
summary(geo)
#geometris son 22 y todas de puntos

#(10pts) ?Cu?ntas variables y observaciones tiene geo?
str(geo)
summary(geo)
dim(geo)
dimnames(geo)
#(20pts) Haga un mapa en donde se muestre la variaci?n de la variable comuna.

comuna <- geo[,4]
plot(comuna)
#(20pts) Seleccione todas las estaciones que pertenecen a la instituci?n INIA.
inia<-geo$institucion=="INIA"

extraerina<-geo[inia,]
comuna <- extraerina$comuna
plot(comuna)



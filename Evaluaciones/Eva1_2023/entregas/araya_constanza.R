#1(5pts) Cree los siguientes objetos de tipo vector
(exvec1<-c(-45, 3, 7, -39, 36))
(exvec2<-c(46, -27, -22, -48, -21))
(exvec3<-seq(from=-5,to=5,by=0.5))

#2(5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
(exVec_resultado<-c(exvec1,exvec2))


#3(5pts) Usando indexación con paréntesis cuadrado:
#devuelva el 3er elemento del vector exVec1
#devuelva todo menos el 2do y 3er elemento en exVec2
(tercer<-exvec1[3])
(todo<-exvec2[c(1,4,5)])

#4(15pts) Use funciones u operadores de relación para:
#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
#(3pts) determinar la suma de elementos en el vector exVec1.
#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
length(exvec1)
length(exvec2)
length(exvec3)

sum(exvec1)

promedio_1<-mean(exvec2, na.rm=TRUE)

sumar1 <- sum(exvec2, na.rm = TRUE)
divisor <- length(na.omit(exvec2))
(promedio_2 <- as.numeric(sumar1/divisor))

promedio_1 %in% promedio_2


#5(10pts) Explique que hace la siguiente operación e indique ¿por qué?
rnorm(6) + rnorm(2)
#Crea valores aleatorios para una distribucion normal deacuerdo a los parametros indicados, el cual se crean 6 valores y 2 valores de distribucion normal. 

#610pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
#numeric= numerico
v1<-c(1,2,3,4)
class(v1)
#logical= caracteres logicos
v2<-c(TRUE,FALSE,TRUE,FALSE)
class(v2)
#Character= caracter o palabras
v3<-c("casa","auto","avion","hlicoptero")
class(v3)
#Complex= numeros complejos
v4 <- 3 - 2i
class(v4)
#7(10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
vector_logico1 <- c(TRUE, FALSE, TRUE, FALSE)
matriz_1 <- matrix(1:9, nrow = 3)
data_frame <- data.frame(mtcars)
(mi_lista <- list(vector_logico1, matriz_1, data_frame))

#8(15 pts) Muestre tres formas de indexar la primera columna del data.frame airquality
airquality
(m1<-airquality[,1])
(m2<-airquality[,"Ozone"])
(m3<-airquality$Ozone)

#9(10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]
# el codigo uno extrae de la matriz en forma de columna al indexardando el resultado en fila y el cogido 2 extrae de la matriz completla al utilizar drop en falso

#10(10pts) Haga una union por por columna de las matrices m1 y m2.
(m1 <- matrix(1:sample(seq(9,18,3),1),3))
(m2 <- matrix(1:sample(seq(9,18,3),1),3))
##no se pueden unir, ya que al utilizar el codigo SEQ se generamn distintas secuencias en los vectores, por ende quedando matrices de distinto tamaño haciendo que estos no se puedan unir (genera un error)

#11(24pts) Respecto del data.frame USArrests que vienen incorporados en R, realice lo siguiente:
#(6pts) Cree un nuevo data.frame de nombre USArrest2 que tenga las columnas Murder, UrbanPop y Rape. Hágalo de dos maneras diferentes.
USArrests
(usarrets2<-USArrests[,c(Murder,Urbanpop,Rape)])
3(usarrets2<-USArrests[,c(1,3,4)])
#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
USArrests$nueva_col <- 1:nrow(USArrests)
USArrests
#(6pts) Cree un nuevo data.frame USArrest3 en el que estén solo las filas 40, 21, 9, 8, 24. Hágalo de dos maneras diferentes.
(usarrest3<-USArrests[c(40,21,9,8,24),])
(usarrest3<-USArrests[c("South Carolina","Massachusetts","Florida","Delaware","Mississippi"),])
#(6pts) Cree un nuevo data.frame USArrest4 en el que estén las filas que cumplen la condición Murder menor o igual a8
(usarrets4<-USArrests[USArrests$Murder<=8,])

#12(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.
numeros<-c(1,2,3,4,5)
caracter<-c("camion","helicoptero","Avion","bicicleta","patin")
logicos<-c(TRUE,FALSE,TRUE,FALSE,TRUE)
data_frame1<- data.frame(numeros,caracter,logicos)

#13(25pts) Para los siguientes ejercicios utilice el data.frame USArrests
#Use funciones para mostrar:
#(5pts) la estructura del set de datos
str(USArrests)
#(5pts) el número de columnas y de filas del set de datos
dim(USArrests)
#(5pts) el nombre de las columnas del set de datos
colnames(USArrests)
#(5pts) el encabezado del set de datos
rownames(USArrests)
#(5pts) los últimos seis elementos del set de datos
tail(usa)

#14(15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?
## el data frame es una estructura de datos de dos dimensiones y es utilizada para el analisis de datos, en cambio el sf guarda geometrias incluyendo lineas, punto y poligono, asociado a atributos de cada elemnto geografico


install.packages("sf")
library(sf)
install.packages("tible")
#1(50pts) Con el archivo que se encuentra en formato CSV :
#(10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
data<-read.csv("data/datos_ema_49.csv")
#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)
#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
(m1<-mean(data$humed_rel_promedio))
humedad<- data[data$humed_rel_promedio>m1,]
#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.
(seleccion<-humedad[,c("fecha_hora","humed_rel_promedio","veloc_max_viento")])
#(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.
datos_21.csv<-write.csv2(seleccion,"seleccion")

#2(80pts) Con el archivo que se encuentra en formato Geopackage:
#(10pts) Cargue el archivo en R y asígnelo al objeto geo.
geo<-st_read("data/region_Atacama.gpkg")

#(10pts) ¿Qué clase de objeto es geo?
class(geo)

#(10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
summary(geo)

#(10pts) ¿Cuántas variables y observaciones tiene geo?
str(geo)

#(20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
plot(geo[,"comuna"])

#(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.
(INIA<-geo[geo$institucion=="INIA",])
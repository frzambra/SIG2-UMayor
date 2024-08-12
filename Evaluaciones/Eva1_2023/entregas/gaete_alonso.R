#prueba1tipo2
#Nombre: Alonso Gaete

#1Cree los siguientes objetos de tipo vector

exVec1<-c(4, -45, -4, -31, -32) 
exVec2<-c(21, 4, 17, 43, 12)
exVec3<-seq(from=-5, to=5, by=(0.5))
    
 
#2 Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado<-c(exVec1,exVec2)
exVec_resultado

#3 Usando indexación con paréntesis cuadrado:

#devuelva el 3er elemento del vector exVec1

exVec1[3]

#devuelva todo menos el 2do y 3er elemento en exVec2

exVec2[-c(2,3)]

#4Use funciones u operadores de relación para:

#mostrar la cantidad de elementos de cada uno de los vectores creados arriba.

length(exVec1)
length(exVec2)
length(exVec3)

#determinar la suma de elementos en el vector exVec1.

sum(exVec1)

#determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)

Promedio_v2<-mean(exVec2,na.rm=FALSE)
Promedio_v2
#calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

sum(exVec2,na.rm=FALSE)
length(exVec2)

prom_exVec2<-sum(exVec2,na.rm=FALSE)/length(exVec2)
prom_exVec2

#muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos

Promedio_v2==prom_exVec2

#5Explique que hace la siguiente operación e indique ¿por qué? rnorm(6) + rnorm(2)

#genera numeros aleatorios de acuerdo con una distribucion normal y luego suma los resultados, rnorm(6) genera una secuencia de 6 numeros y rnorm(2) secuencia de 2, poruqe? para generar mayor variabilidad que generar solo 6 valores o solo 2 valores dadno asi una mayor dispersion.


#6Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

integer

x<-c(1L,2L,3L,4L,5L,6L)
x

numeric

z<-c(1.3, pi, exp(1))
z

logical

m<-c(TRUE,FALSE,FALSE,TRUE)
m

character

p1<-c("Luis", "María", "José")
p1

complex

c1<-c(1+2i, 4i, 3+6i)
c1

#7 De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars

df<-data.frame(mtcars)
df

matriz<- matrix(1:9,3,3)
matriz

lista<-list(m,matriz,df)
lista

#8 Muestre tres formas de indexar la primera columna del data.frame USArrests

dfu<-data.frame(USArrests)

USArrests$Ozone
USArrests["Ozone"]
USArrests[,1]


#9Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.

m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

#el codigo uno tiene una forma mas simplificada para dar el resultado, mientraz que el segundo arroja una matriz de una sola columna

#10Haga una union por por columna de las matrices m1 y m2.

m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)

cbind(m1,m2)

#11Respecto del data.frame mtcars que vienen incorporados en R, realice lo siguiente:

#11.1Cree un nuevo data.frame de nombre mtcars2 que tenga las columnas drat, qsec y carb. Hágalo de dos maneras diferentes.

#forma1
dfmtcars2<-mtcars[,c("drat","qsec","carb")]
dfmtcars2

#forma2
dfmtcars2<-mtcars[,c(5,7,11)]
dfmtcars2


#11.2Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

dfmtcars2$nueva_col<-1:32
dfmtcars2

#11.3Cree un nuevo data.frame mtcars3 en el que estén solo las filas 18, 12, 14, 10, 2. Hágalo de dos maneras diferentes.

#Forma1

dfmtcars3<-data.frame(mtcars)

dfmtcars3<-dfmtcars2[c(18,12,14,10,2),]
dfmtcars3

#Forma2

dfmtcars3<-dfmtcars2[c("Fiat 128","Merc 450SE","Merc 450SLC","Merc 280","Mazda RX4 Wag"),]
dfmtcars3


#11.4Cree un nuevo data.frame mtcars4 en el que estén las filas que cumplen la condición mpg menores a 21

condicion<-21
cumple<-mtcars$mpg<-condicion

dfmtcars4<- data.frame(mtcars[cumple,"mpg"])
dfmtcars4
class(dfmtcars4)

#12De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

VN2<-1:5
VC2<-c("a","i","b","m","f")
VL<-c(FALSE,TRUE,TRUE,FALSE,TRUE)

DF12<-data.frame(numeros=VN2,
                 caracteres=VC2,
                 Logico=VL)

DF12

#13Para los siguientes ejercicios utilice el data.frame mtcars

#13.1 la estructura del set de datos

data(mtcars)
str(mtcars)

#13.2 el número de columnas y de filas del set de datos

nrow(mtcars)
ncol(mtcars)

#13.3el nombre de las columnas del set de datos

colnames(mtcars)

#13.4el encabezado del set de datos

head(mtcars)

#13.5los últimos seis elementos del set de datos

tail(mtcars)


#14¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?

#la diferencia entre un objeto de clase data frame y uno de clase sf  radica en su uso y capacidad de manejar datos tabulares versus datos geoespaciales. cada uno se adapta a un proposito especifico en el analisis de R dependiendo de si se trata de datos convencionales o datos relacionados con ubicacion geografica. para manejar datos tabulares es mejor el data frame, para datos geoespaciales es mejor el sf incluyendo la representacion de geometrias(puntos, lineas y poligonos).

#PARTE 2

install.packages("sf")
library(sf)

#1Con el archivo que se encuentra en formato CSV

#1.1Cargue el archivo en formato CSV en R y asignelo al objeto data

data<-read.csv("datos_ema_126.csv")

#1.2De un resumen de la estructura de los datos de data (clase, variables, observaciones).

str(data)

#1.3Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.

posicion_mayores_prom<-data$humed_rel_promedio>mean(data$humed_rel_promedio)

obs_mayores_prom<-data[posicion_mayores_prom,]
obs_mayores_prom


#1.4Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.

obs_mayores_prom2<-data[posicion_mayores_prom,c("humed_rel_promedio", "fecha_hora","veloc_max_viento")]

obs_mayores_prom2

#1.5 Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.

#2Con el archivo que se encuentra en formato Geopackage:

#2.1Cargue el archivo en R y asígnelo al objeto geo.

install.packages('tibble')
library(sf)

geo<-read_sf("region_Coquimbo.gpkg")

#2.2¿Qué clase de objeto es geo?

class(geo)
#es clase sf

#2.3 Indique el tipo de geometría y la cantidad de geometrias que tiene geo.

str(geo)

#tiene geometria tipo punto y tiene una cantidad de 55 geometrias

#2.4¿Cuántas variables y observaciones tiene geo?

#tiene 55 observaciones y 7 varaibles

#2.5Haga un mapa en donde se muestre la variación de la variable comuna.

plot(geo["comuna"])

#2.6Seleccione todas las estaciones que pertenecen a la institución INIA.

INIA<-geo$institucion=="INIA"
Estaciones_INIA<-geo[INIA,]
Estaciones_INIA
































#Prueba1:Tipo1
#Nombre:Isidora Vásquez

#1.Cree los siguientes objetos de tipo vector
exVec1<- c(-45, 3, 7, -39, 36)
exVec2<-c( -46, -27, -22, -48, -21)
exVec3<- seq(from=-5,to=5,by= (0.5))

#2.Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado<-c(exVec1,exVec2)
exVec_resultado

#3.Usando indexación con paréntesis cuadrado
#3.1.devuelva el 3er elemento del vector exVec1
exVec1[3]
#3.2.devuelva todo menos el 2do y 3er elemento en exVec2
exVec2[-c(2,3)]

#4.Use funciones u operadores de relación para
#4.1. mostrar la cantidad de elementos de cada uno de los vectores creados arriba

length(exVec1)
length(exVec2)
length(exVec3)
length(exVec_resultado)

#4.2.determinar la suma de elementos en el vector exVec1.
sum(exVec1)

#4.3. determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
prom_vector2<-mean(exVec2,na.rm = FALSE)

#4.4.calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

sum(exVec2,na.rm=FALSE)
length(exVec2)

prom_exVec2<-sum(exVec2,na.rm=FALSE)/length(exVec2)
prom_exVec2

#4.5.muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
prom_vector2==prom_exVec2

#5.Explique que hace la siguiente operación e indique ¿por qué?rnorm(6) + rnorm(2)
#R/La operación suma dos distribuciones normales. Especificamente suma una distribucion normal aleatoria con 6 observaciones y una distribucion normal aleatoria con 2 observaciones.  

#6.Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
#Existen 4 tipos de vectores: numerico,complejo, logico y de caracteres
#ejemplo numerico:
vector_num<-1:6
#ejemplo coplejo
vector_com<-c(1i, 2+1i, 3+1i, 4+1i, 5+1i, 6+1i)
#ejempplo logico
vector_log<-c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
#ejemplo caracteres
vector_car<-c("a", "b", "c" ,"d", "e", "f")


#7. De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars.
dataframe<-data.frame(mtcars)
dataframe

matriz<-matrix(1:9,3,3)
matriz

lista<-list(vector_log,matriz,dataframe)
lista


#8.Muestre tres formas de indexar la primera columna del data.frame airquality
data.frame(airquality)

airquality$Ozone
airquality["Ozone"]
airquality[,1]

#9.Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
m <- matrix(1:9,3)

#codigo 1
m[,1]

class(m[,1])
#codigo 2
m[,1,drop = FALSE]
class(m[,1,drop = FALSE])

#La diferencia que existe el cogigo 1 simplifica automaticamente el resultado a un vector, mientras que el segundo codigo mantiene el resultado como matriz, por el uso del drop=FALSE 

#10.Haga una union por por columna de las matrices m1 y m2.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)
cbind(m1,m2)

#11. Respecto del data.frame USArrests que vienen incorporados en R, realice lo siguiente:
#11.1. Cree un nuevo data.frame de nombre USArrest2 que tenga las columnas Murder, UrbanPop y Rape. Hágalo de dos maneras diferentes.

USArrests
#forma1
USArrest2<-USArrests[,c("Murder","UrbanPop","Rape")]
USArrest2

#forma2
USArrest2<-USArrests[,c(1,3,4)]
USArrest2

#11.2.Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

USArrest2$nueva_col<-1:50
USArrest2

#11.3.ree un nuevo data.frame USArrest3 en el que estén solo las filas 40, 21, 9, 8, 24. Hágalo de dos maneras diferentes.

#forma1

USArrest3<-USArrest2[c(40,21,9,8,24),]
USArrest3

#forma2
USArrest3<-USArrest2[c("South Carolina","Massachusetts","Florida","Delaware","Mississippi"),]
USArrest3

#11.4.Cree un nuevo data.frame USArrest4 en el que estén las filas que cumplen la condición Murder menor o igual a 8
condicion<-8
Sicumplen<-USArrests$Murder<=condicion

USArrest4<-data.frame(USArrests[Sicumplen,"Murder"])
USArrest4
class(USArrest4)

#12.De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.
vector_num2<-1:5
vector_car2<-c("a","b","c","d","e")
vector_log2<-c(FALSE,TRUE,TRUE,TRUE,FALSE)

df<-data.frame(numeros = vector_num2,
           caracteres = vector_car2,
           logico = vector_log2)
df

#13. Para los siguientes ejercicios utilice el data.frame USArrests
#13.1.la estructura del set de datos
str(USArrests)
#13.2. el número de columnas y de filas del set de datos
#R/Tiene 4 columnas y 50 filas
#13.3.el nombre de las columnas del set de datos
colnames(USArrests)

#13.4. el encabezado del set de datos
head(USArrests)

#13.5.los últimos seis elementos del set de datos
tail(USArrests)

#14.¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?
#R/Radica en su uso, ya que sf se utiliza para datos vectoriales(datosgeoespaciales). En cambio el data frame se usa mas para analisis estadisticos

#PARTE 2¡¡¡¡¡¡¡¡¡¡¡¡¡
install.packages("sf")
library(sf)
#1.Con el archivo que se encuentra en formato CSV :
#1.1.Cargue el archivo en formato CSV en R y asignelo al objeto data
data<-read.csv("datos_ema_49.csv")
#1.2.De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)
#1.3.Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
posicion_mayores_prom<-data$humed_rel_promedio>mean(data$humed_rel_promedio)

obs_mayores_prom<-data[posicion_mayores_prom,]
obs_mayores_prom

#1.4.Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.

obs_mayores_prom2<-data[posicion_mayores_prom,c("humed_rel_promedio", "fecha_hora","veloc_max_viento")]
obs_mayores_prom2

#1.5.Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.

write.csv2(obs_mayores_prom2,"datos_21.csv")
comprobacion2<-read.csv2("datos_21.csv")

#2. Con el archivo que se encuentra en formato Geopackage:
#2.1.Cargue el archivo en R y asígnelo al objeto geo.
install.packages('tibble')
library(sf)
geo<-read_sf("region_Atacama.gpkg")
st_read("region_Atacama.gpkg")
#2.2.¿Qué clase de objeto es geo?
#R/Es de clase "sf"
class(geo)

#2.3.Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
str(geo)
#R/Tiene 14 geometrias de tipo punto 

#2.4.¿Cuántas variables y observaciones tiene geo?
#R/tiene 14 observaciones y 6 variables

#2.5.Haga un mapa en donde se muestre la variación de la variable comuna.
plot(geo["comuna"])

#2.6.Seleccione todas las estaciones que pertenecen a la institución INIA.

INIA<-geo$institucion=="INIA"
Estaciones_INIA<-geo[INIA,]
Estaciones_INIA


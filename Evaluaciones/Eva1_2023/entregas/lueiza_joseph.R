#EVALUACION TIPO 5 JOSHEP LUEIZA OSSES  

#1-Cree los siguientes objetos de tipo vector
#exVec1 con los números: -34, 16, 38, -19, -40

exVec1<- c(-34, 16, 38, -19, -40)

#exVec2 con los números: -38, 34, 37, -27, -3

exVec2<- c(-38, 34, 37, -27, -3)

#exVec3 con la sequencia -5 a 5 cada 0.5 (ej, -5.0, -4.5, -4.0, y así hasta 5.0)
exVec3<- c(-5.0,-4.5,-4.0,-3.5,-3.0,-2.5,-2.0,-1.5,-1.0,-0.5,0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)

#2 (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
exVec_resultado<- c(exVec1,exVec2)

#3Usando indexación con paréntesis cuadrado:
#devuelva el 3er elemento del vector exVec1

tercerel<-exVec1[3]

#devuelva todo menos el 2do y 3er elemento en exVec2
wr2<- exVec2[-2]
wr3<- exVec2[-3]

# Use funciones u operadores de relación para:
# mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)
length(exVec2)
length(exVec3)

#determinar la suma de elementos en el vector exVec1.

sum(exVec1)


#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)

mean(exVec2)

# calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

suma<- sum(exVec2)
prome <- length(exVec2)
resultado<- suma/prome


#muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos

compro<- (mean==resultado)

#5 Explique que hace la siguiente operación e indique ¿por qué?

rnorm(6)+rnorm(2)
# esta operacion nos generara un vector de 6 elementos que tendra una combinacion aleatoria de ambas rnorm,que siguen una distribución normal estándar, pero con algunos valores repetidos. El resultado será una muestra aleatoria de 6 números, donde algunos de estos números pueden tener valores iguales debido a la repetición de rnorm(2) 




#6Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

#numerico
numerico<- c(1,2,3,4,5,6)
class(numerico)

#character 

tipocharac<- c('alfa','omega','beta')
class(tipocharac)

#logico 
rtt<- c(TRUE,FALSE,FALSE)
class(rtt)

#7De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
rtt<- c(TRUE,FALSE,FALSE)
alfa<- matrix(3,3,3)
dff<- data.frame(mtcars)

lista<-list(rtt,alfa,dff)


#8(15 pts) Muestre tres formas de indexar la primera columna del data.frame USArrests
data.frame(USArrests)

dfin<- USArrests[,1]


primer_columna <- USArrests[, 1]
primer_columna <- USArrests[, 1]
primer_columna <- USArrests[[1]]

primer_columna <- USArrests$Murder

  
  
  
  
#9(10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.  

M <- matrix(1:9,3)
  #CONTIENE LOS VALORES DEL 1 AL 9 EN 3 FILAS Y 3 COLUMNAS 
#codigo 1
m[,1] #NOS MUESTRA LOS RESULTADOS INDEXADOS DE LA ATRIZ m, CON LOS VALORES DE SOLO LA PRIMERA FILA 
  
#codigo 2
m[,1,drop =TRUE] #NOS ENTREGA LA INDEXACION PERO AL AGREGAR DROP=TRUE NOS ENTREGA LA PRIMERA COLUMNA Y NO LA PRIMERA FILA YA QUE POR DEFECTO DROP VIENE EN FALSE 


#10 (10pts) Haga una union por columna de las matrices m1 y m2
  

m1 <- matrix(1:sample(seq(9, 18, 3), 1), 3)
m2 <- matrix(1:sample(seq(9, 18, 3), 1), 3)

resultadom1m2 <- cbind(m1, m2)



#11 Respecto del data.frame airquality que vienen incorporados en R, realice lo siguiente:
  
#Cree un nuevo data.frame de nombre airquality2 que tenga las columnas Ozone, Temp y Month. Hágalo de dos maneras diferentes.
#forma1

data.frame(airquality)
  
Ozone<- airquality$Ozone  
Temp<- airquality$Temp
Month<-airquality$Month

airquality2<- data.frame(Ozone,Temp,Month)

#forma2

data.frame(airquality$Ozone,airquality$Temp,airquality$Month)
  
  
#Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
  
airquality$nueva_variable <- 1:153

cbind(airquality,nueva_variable =1:153)

#(6pts) Cree un nuevo data.frame airquality3 en el que estén solo las filas 111, 90, 41, 87, 23. Hágalo de dos maneras diferentes.
           
# Método 1: Usando el operador de índice [ ] con un vector de filas
filas_seleccionadas <- c(111, 90, 41, 87, 23)
airquality3 <- airquality[filas_seleccionadas, ]
airquality3

filas_seleccionadas <- c(111, 90, 41, 87, 23)
airquality3 <- subset(airquality, rownames(airquality) %in% filas_seleccionadas)
airquality3

# Cree un nuevo data.frame airquality4 en el que estén las filas que cumplen la condición Solar.R mayores a 200

airquality4 <- airquality[airquality$Solar.R > 200, ]


condicion<- airquality$Solar.R>200


data.frame(condicion)

#13 Para los siguientes ejercicios utilice el data.frame airquality
           
#la estructura del set de datos           

str(airquality)         
           
#el número de columnas y de filas del set de datos
dim(airquality) 
nrow(airquality)
ncol(airquality)
#el nombre de las columnas del set de datos
colnames(airquality)

# el encabezado del set de datos
head(airquality)
           
# los últimos seis elementos del set de datos
tail(airquality)
           
#Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?
#respuesta: uno de tipo sf contiene puntos lineas o poligonos y tiene un CRS y atributos para cada elemento, minetras que un data.frame son estructuras de datos de solo  dos dimensiones  que contienen datos de diferentes tipos.

           
           
           
           
           
           
           
           
           
           
#Parte 2: Manejo de archivos
#Cargue el archivo en formato CSV en R y asignelo al objeto data_info

data_info <- read.csv2('data/datos_ema_309.csv')

#De un resumen de la estructura de los datos de data (clase, variables, observaciones)
summary(data_info)
str(data_info)
#Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.

summary(data_info)




# Con el archivo que se encuentra en formato Geopackage:
# Cargue el archivo en R y asígnelo al objeto geo.

install.packages('sf')
install.packages('tibble')

geo <- read_sf('geo/region_OHiggins.gpkg')
library(sf)

#¿Qué clase de objeto es geo? 
#Indique el tipo de geometría y la cantidad de geometrias que tiene
#¿Cuántas variables y observaciones tiene geo?
class(geo) #"sf"         "tbl_df"     "tbl"        "data.frame"
summary(geo)
length(geo)
# tiene 4 variables con 49 obrservaciones cada una, todas de tipo character 
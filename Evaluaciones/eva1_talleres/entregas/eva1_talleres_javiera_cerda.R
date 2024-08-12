#EVALUACION 1
#INTEGRANTE: JAVIERA CERDA
#FECHA: 15/09
#Escriba un script en R que permita realizar lo siguiente:
  

#1.(2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.


#obtener la ruta de trabajo (para que entre informacion, nos devuelve la carpeta en la que trabajamos)
getwd()

read.csv2("data/metadata_estaciones_agrometAPI.csv")
data_info <- read.csv2 ("data/metadata_estaciones_agrometAPI.csv")

#2.(2pt) Cuál es el nombre de las columnas de data_info

names(data_info)

#otambien
colnames(data_info)



#3.(2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

id <- 2
r <- data_info$ema == id
data_info[r,]


#4.(2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2("data/2.csv")
data


#5.(2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de cada variable.

#dim entrega la dimension del objeto (numero de filas, numero de columnas)
dim(data)
class(data)
class(data$station_id)
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)
class(data$humed_rel_promedio)
#etc..., para no continuar se puede usar str

#resumen con estructura con str:

str(data)

#funciones para inspeccionar filas:
#para mostrar las 6 ultimas filas: tail(data)
#para mostrar las primeras 6 filas: head(data)
#nrow:numero de filas 
#ncol:numero de columnas 


#6.(2pt) Haga un resumen estadístico de todas las variables que contiene data.

#summary es una funcion que entrega un resumen estadistico de cada variable deñ data.frame
summary(data)


#7.(3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.

#esto indica que el data.frame tiene observaciones entre este rango 
range(data$fecha_hora)

#pregunta parentesis 
class(data$fecha_hora)


#8.(4pt) Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

#primera opcion
fechahra <- data$fecha_hora
temp_aire <- data$temp_promedio_aire
temp_min <- data$temp_minima
temp_max <- data$temp_maxima

data_temp <- data.frame(fechahra,temp_aire,temp_min, temp_max)
data_temp


#segunda opcion 
data_temp <- data[ ,c(2,3,9,10)]


#tercera opcion

data_temp <- data [ ,c("fecha_hora", "temp_promedio_aire", "temp_minima", "temp_maxima")]
data_temp

#9.(4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.

#forma 1
fecha <- substr(x=data_temp$fecha_hora, start = 1, stop = 7)
data_temp2 <- cbind(data_temp,fecha)
enero <- "2021-01"
l <- data_temp2$fecha == enero
data_temp_enero <- data_temp2[1, ]
View(data_temp_enero)


#solucion verdadera:
fecha <- substr (x=data_temp$fecha_hora, start = 1, stop = 7)
data_temp_enero2 <- data_temp [fecha == "2021-01", ]
View(data_temp_enero2)
data_temp_enero2

#10.(2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.

#na.rm:TRUE indica que no apareceran los NA 

#Temperatura maxima sin considerar los NA 
max(data_temp_enero2$temp_maxima, na.rm = TRUE)

#Temperatura minima sin considerar los NA 
min(data_temp_enero2$temp_minima, na.rm = TRUE)

##Temperatura promedio sin considerar los NA 
mean(data_temp_enero2$temp_promedio_aire, na.rm = TRUE)


#11.(5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.

#Funcion COR: permite crear una matriz de correlacion 
?cor
cor(data_temp[, 2:4], use = "complete.obs")


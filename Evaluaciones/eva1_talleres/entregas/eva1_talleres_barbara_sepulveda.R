#evaluacion1
#integrante : BARBARA SEPULVEDA
#Fecha : 15 septiembre


# 1-Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.
read.csv2("data/metadata_estaciones_agrometAPI.csv")
data_info <- read.csv2("data/metadata_estaciones_agrometAPI.csv")


#2-Cuál es el nombre de las columnas de data_info
names(data_info)
colnames(data_info)

#3-Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

id <-16
r <-data_info$ema==id
data_info[r, ]
#4-Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2('data/16.csv')

#5-Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.

dim(data)
class(data)
class(data$station_id)  #a q tipo de dato es la columna
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)
# un resumen de la estrutura de str
str(data)
head(data) #muestra primeras 6 filas de data frame
tail(data) #muestra ultimas 6 filas de observacion data frame
ncol(data) #nmero de columnas
nrow(data) #numero de filas
dim(data)  #filas y columnas

#6 Haga un resumen estadístico de todas las variables que contiene data.

summary(data) #entrega un resumen estadistico de cada variable del data.frame


#7 Indique entre que rango de fechas se encuentran las observaciones del objeto data.

range(data$fecha_hora) #entrega maximo y minimo, un rango,fecha y hora entrega dato caracter


#8 Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

#forma 1
fecha <- data$fecha_hora
temp_min <- data$temp_minima
temp_max <- data$temp_maxima
temp_air <- data$temp_promedio_aire

data_temp <- data.frame(fecha,temp_air,temp_max,temp_min)

#forma 2
data_temp <- data[,c(2,3,9,10)]
#forma 3
data_temp <- data [,c('fecha_hora','temp_promedio_aire','temp_minima','temp_maxima')]

#9 Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.

#para extraer cadena de texto se utiliza substr
#which - cuales

#forma 1

fecha <- substr(x=data_temp$fecha_hora,start = 1, stop = 7)

data_temp_2 <-cbind(data_temp,fecha)

enero <-"2021.01"

l <- data_temp_2$fecha == enero

data_temp_enero <- data_temp_2[l,]

View(data_temp_enero)

#forma 2

data_tem <- data[,c('fecha_hora', 'temp_promedio_aire', 'temp_minima', 'temp_maxima')]
data_tem


fecha <- substr(x=data_tem$fecha_hora, start = 1, stop = 7)

fecha
data_temp_enero2 <- data_tem[fecha == "2021-01",]
data_temp_enero2
View(data_temp_enero2)


#10 Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.
max(data_temp_enero2$temp_maxima)

#TEMPERATURA PROMEDIO
mean(data_temp_enero2$temp_maxima, na.rm =TRUE)  
#TEMPERATURA MAX
max(data_temp_enero2$temp_maxima, na.rm =TRUE)
#TEMPERATURA MIN
min(data_temp_enero2$temp_maxima, na.rm =TRUE)

V <- c (1,2,3,NA)
max(v, na.rm = TRUE)

#11 Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.

?cor
cor(data_temp[,2:4],use = 'complete.obs')



# 1. Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.

#obtener ruta de trabajo
getwd()

data_info <- read.csv2('data/metadata_estaciones_agrometAPI.csv')
data_info

# 2. Cuál es el nombre de las columnas de data_info
names(data_info)
colnames(data_info)


#3. Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

id <- 44
r <- data_info$ema == id
data_info[r,]

#forma 2
r <- data_info$ema %in% id
data_info[r,]


#4. Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2('data/44.csv')

# 5. Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.

# dim entrega numero de filas y columnas
dim(data)
class(data)
class(data$station_id)
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)
#... 13 veces

#un resumen de la estructura con str
str(data)

#head muestra las primeras 6 filas
head(data)
#tail muestra las ultimas 6 filas
tail(data)
#nrow muestras solo filas
nrow(data)
#ncol muestra columnas 
ncol(data)


#6. Haga un resumen estadístico de todas las variables que contiene data.

#summary funcion que entrega un resumen de cada variable del data.frame
summary(data)

#7. Indique entre que rango de fechas se encuentran las observaciones del objeto data.
range(data$fecha_hora)

#8.Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

fecha <- c(data$fecha_hora)
temp_air <- c (data$temp_promedio_aire)
temp_min <- c (data$temp_minima)
temp_max <- c (data$temp_maxima)

data_temp <- data.frame(fecha,temp_air,temp_min,temp_max)
data_temp

#foma 2
data_temp <- data[,c(2,3,9,10)]
data_temp

#forma 3
data_temp <- data[,c('fecha_hora','temp_promedio_aire','temp_minima','temp_maxima')]
data_temp

#9. Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.
#forma1
fecha <- substr(x=data_temp$fecha_hora,start = 1, stop = 7)
data_temp_2 <- cbind(data_temp,fecha)
enero <- "2021-01"
l <- data_temp_2$fecha == enero
data_temp_ <- data_temp[1,]

#forma2
fecha <- substr(x=data_temp$fecha_hora,start=1, stop=7)
data_temp_enero2 <- data_temp[fecha=="2021-01",]

#10. Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.

max(data_temp_enero2$temp_maxima,na.rm=TRUE)
min(data_temp_enero2$temp_minima,na.rm=TRUE)
mean(data_temp_enero2$temp_promedio_aire,na.rm=TRUE)

#11. Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.
cor(data_temp[,2:4],use="complete.obs")




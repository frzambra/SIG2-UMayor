#1.Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.
getwd()

data_info <- read.csv2('data/Estaciones.csv')
data_info

#2. Cuál es el nombre de las columnas de data_info
colnames(data_info)

#3. Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.
id <- 24 
data_info[23,]
#segunda forma 
r<-data_info$ema%in%id
r
data_info[r,]

#4. Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2('data/24.csv')
data

#5.Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de cada variable.
dim(data)
class(data)
class(data$station_id)
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)

#resumen 
str(data)

#funciones para inspeccionar 
head(data)
tail(data)
dim(data)
nrow(data)
ncol(data)

#6.Haga un resumen estadístico de todas las variables que contiene data.

summary(data) #funcion que entrega un resumen estadistico de cada variabe 

#7. Indique entre que rango de fechas se encuentran las observaciones del objeto data.

range(data$fecha_hora)

#pregunta parentesis 
class(data$fecha_hora)
as.POSIXct(data$fecha_hora,'')

#8. Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

fecha<-data$fecha_hora
temp_air <- data$temp_promedio_aire
temp_min <- data$temp_minima
temp_max <- data$temp_maxima
 
data_temp<- data.frame(fecha,temp_air,temp_min,temp_max)
data_temp

#forma 2 
data_temp <- data[,c(2,3,9,10)]
data_temp

#9.Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.
fecha<- substr(x=data_temp$fecha_hora, start = 1, stop=10)
fecha

data_temp_2<- cbind(data_temp,fecha)
data_temp_2

enero<- "2021-01"
enero
l<- data_temp_2$fecha== enero
l
data_temp_enero<-data_temp[1,]
data_temp_enero
#10.Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.
max(data_temp_enero$temp_maxima, na.rm = TRUE)
min(data_temp_enero$temp_minima,na.rm = TRUE)
mean(data_temp_enero$temp_promedio_aire, na.rm = TRUE) #na.rm para considerar o no Na

#11.Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.
cor(data_temp[,2:4], use='complete.obs')

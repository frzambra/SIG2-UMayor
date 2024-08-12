#1 (2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.

data_info<- read.csv2('metadata_estaciones_agrometAPI.csv')

#2 (2pt) Cuál es el nombre de las columnas de data_info
names(data_info)
colnames(data_info)

#3 (2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

id<-24
r<-data_info$ema==id
data_info[r, ]

#forma para tomar dos estaciones 
r<-data_info$ema%in%id
data_info[r, ]

#4 (2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data<- read.csv2('24.csv')


#5 (2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.

#dim entrega la dimension del objeto
dim(data)
class(data)

class(data$station_id)
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)

#un resumen de las estructuras con str
str(data)

#funciones para inpeccionar
#head es para saber las primeras 6 filas
head(data)

#tail es para saber las ultimas 6 filas
tail(data)

#dim entrega numero de filas y columnas
dim(data)

#nrow numero de filas
nrow(data)

#ncol numero de columnas
ncol(data)

#6 (2pt) Haga un resumen estadístico de todas las variables que contiene data.

#summary entrega un resumen estadistico de cada variable del data.frame
summary(data)


#7(3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.

range(data$fecha_hora)

#preguntas parentesis, de caracter se transforma a tipo fecha y hora
class(data$fecha_hora)
as.POSIXct(data$fecha_hora,"")

#8 (4pt) Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

fecha<-data$fecha_hora
temp_air<-data$temp_promedio_aire
temp_min<-data$temp_minima
temp_max<-data$temp_maxima

data_temp<-data.frame(fecha,temp_air,temp_min,temp_max)

#forma 2
data_temp<-data[,c(2,3,9,10)]

#forma 3
data_temp<-data[,c('fecha_hora','temp_promedio_aire', 'temp_minima','temp_maxima')]

#9 (4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.

fecha<-substr(x=data_temp$fecha_hora,start=1,stop=7)
data_temp_2<-cbind(data_temp,fecha)
enero<-"2021-01"
l<-data_temp_2$fecha==enero
data_temp_enero<-data_temp_2[1,]

View(data_temp_enero)

#forma 2
fecha<- substr(x=data_temp$fecha_hora,start = 1,stop = 7)
data_temp_enero2<-data_temp[fecha=="2021-01",]

View(data_temp_enero2)

#10 (2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.

#calcular la temperatura maxima sin considerr los NA
max(data_temp_enero2$temp_maxima,na.rm=TRUE)

#calcular la temperatura minima sin considerar los NA
min(data_temp_enero2$temp_minima,na.rm = TRUE)

#calcula el promedio sin considerar los NA
mean(data_temp_enero2$temp_promedio_aire,na.rm=TRUE)


#ejemplo de vector numerico con un NA
v<-c(1,2,3,NA)
max(v)
max(v, na.rm=TRUE)

#11 (5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.

cor(data_temp_2[,2:4],use='complete.obs')


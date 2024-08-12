#EVALUACION 1

#Nombre: Andoni Targarona

#1. (2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.

getwd()

data_info<-read.csv2('Datos R/metadata_estaciones_agrometAPI.csv')
data_info

#2.(2pt) Cuál es el nombre de las columnas de data_info

names(data_info)
colnames(data_info)

#3. (2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

id<-24

#forma 1
r<-data_info$ema==id

data_info[r,]

#forma 2
id<-c(50,25)

r<-data_info$ema %in% id

data_info[r,]

#4. (2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data<-read.csv2('Datos R/archivos_csv_por_estacion/archivos_por_estacion/24.csv')

data

#5. (2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de cada variable.

class(data)
dim(data)

#forma 1
class(data$station_id)
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)
class(data$humed_rel_promedio)
class(data$presion_atmosferica)
class(data$radiacion_solar_max)
class(data$veloc_max_viento)
class(data$temp_minima)
class(data$temp_maxima)

#forma 2 (mas resumido)
str(data)

#6.(2pt) Haga un resumen estadístico de todas las variables que contiene data.

summary(data)

#7. (3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.

range(data$fecha_hora)

#8. (4pt) Cree un objeto data_temp en el que se guarde un subconjunto del objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

data_temp<-data.frame(data$fecha_hora,data$temp_promedio_aire,data$temp_minima,data$temp_maxima)

data_temp

names(data_temp)
             
#9. (4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.

#forma 1
fecha<-substr(x=data_temp$data.fecha_hora,start=1,stop=7)

data_temp_2<-cbind(data_temp,fecha)

enero<-"2021-01"

l<-data_temp_2$fecha==enero

data_temp_enero<-data_temp[l,]

View(data_temp_enero)

#forma2
fecha<-substr(x=data_temp$data.fecha_hora,start=1,stop=7)
data_temp_enero2<-data_temp[fecha=="2021-01",]

View(data_temp_enero2)

#10. (2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.

#promedio
mean(data_temp_enero2$data.temp_promedio_aire,na.rm=TRUE)

#maximo
max(data_temp_enero2$data.temp_maxima,na.rm=TRUE)

#minimo
min(data_temp_enero2$data.temp_minima,na.rm=TRUE)

#11. (5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.

cor(data_temp[,2:4],use='complete.obs')


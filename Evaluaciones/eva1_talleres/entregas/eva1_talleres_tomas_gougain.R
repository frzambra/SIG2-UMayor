#1 (2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.

#obtener ruta de trabajo
getwd()


data_info<-read.csv2('data/metadata_estaciones_agrometAPI.csv')

#2 (2pt) Cuál es el nombre de las columnas de data_info

colnames(data_info)
names(data_info)

#3 (2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

id<-48

#Forma 1
r<-data_info$ema==id
data_info[r,]

#Forma 2
r<- data_info$ema%in% id
data_info[r,]

#4 (2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2('data/48.csv')

#5 (2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de cada variable.

dim(data)
class(data)
class(data$station_id)
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)
... 

# un resumen de la estructura con str (hacer la 5 rápido)
str(data)
str

#6 (2pt) Haga un resumen estadístico de todas las variables que contiene data.

summary(data)

#programación capricho mío jajajaja
plot(density(na.omit(data$temp_promedio_aire)))


#7 (3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.

range(data$fecha_hora)



#8 (4pt) Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

#forma 1

fecha <- c (data$fecha_hora)
temp_air <- c (data$temp_promedio_aire)
temp_min <- c (data$temp_minima)
temp_max <- c (data$temp_maxima)

# forma 2 

data_temp <- data.frame(fecha, temp_air, temp_min, temp_max)

data_temp <- data [,c (2,3,9,10)]


#9 (4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.

fecha <-substr(x<-data_temp$fecha_hora,start = 1, stop=7)

data_temp_2 <- cbind(data_temp, fecha)  

enero<- "2021-01"

t<- data_temp_2$fecha ==enero

data_temp_enero <- data_temp_2 [t,]

data_temp_2


#10 (2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.

# na.rm sirve para indicar si los NA se consideran en el programa

min(data_temp_2$temp_minima, na.rm = TRUE)
max(data_temp_2$temp_maxima,na.rm = TRUE)
mean(data_temp_2$temp_promedio_aire, na.rm = TRUE)


#11 (5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.

cor(data_temp[,2:4],use = 'complete.obs')

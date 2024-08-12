#Evaluación 1 talleres
#Isidora Vásquez


#1.Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.

getwd()
data_info <- read.csv2('metadata_estaciones_agrometAPI.csv')
data_info


#2.Cuál es el nombre de las columnas de data_info

colnames(data_info)

#3.Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

ID <-44
ID

data_info[43,]  

#4.Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2('44.csv')
data

#5.Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.

str(data)

#6.Haga un resumen estadístico de todas las variables que contiene data.

summary(data) 

#7.Indique entre que rango de fechas se encuentran las observaciones del objeto data.

range(data$fecha_hora)

#8.Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

fecha <- data$fecha_hora
temp_air <- data$temp_promedio_aire
temp_min <- data$temp_minima
temp_max <- data$temp_maxima
data_temp <- data.frame(fecha,temp_air,temp_min,temp_max)
data_temp

#9.Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.

fecha1 <- substr(x=data_temp$fecha,start = 1,stop = 7)
data_temp_2 <- cbind(data_temp,fecha)
enero <- "2021-01"
l <- data_temp_2$fecha == enero
l
data_temp_enero <- data_temp_2[1,]
data_temp_enero
View(data_temp_enero)

#10.Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.

max(data_temp_enero$temp_max, na.rm = TRUE)
min(data_temp_enero$temp_min, na.rm = TRUE)
mean(data_temp_enero$temp_air, na.rm = TRUE)

#11. Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.

cor(data_temp[,2:4], use = 'complete.obs')



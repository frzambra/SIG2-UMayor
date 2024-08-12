#1. Cargue en Rel archivo metada_estaciones_Agro y asignelo al objeto data_info.
#obtener la ruta del trabajo
getwd()
data_info<-read.csv2('data/estaciones.csv')

#2. cual es el nombre de las columnas de data_info
names(data_info)
colnames(data_info)

#3. selesccione de data_info la estacion que se le asigno en el campus virtual. Indique el nombre, comuna, region, latid y longitud de la estacion.
id<- 8
data_info$ema==id
data_info[8,]



#4.(2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data<- read.csv2('data/8.csv')
#5. (2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.
dim(data)
class(data)
class(data$station_id)
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)
...

#3 un resumen de la estructura str
str(data)
head(data) #6 primeras filas del data.frame
tail(data) #6 ultimas filas del data.frame
dim(data) #muestra numero fila y columnas
nrow(data) #numero de filas
ncol(data) #numero de columnas

#6.  Haga un resumen estadístico de todas las variables que contiene data.
?summary #funcion que esntrega un resumen estadistico de 
summary(data)
plot(density(data$temp_promedio_aire))

#7.  Indique entre que rango de fechas se encuentran las observaciones del objeto data.
range(data$fecha_hora)
class(data$fecha_hora)
as.POSIXct(data$fecha_hora,)

#8.Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.
fecha<-(data$fecha_hora)
temp_air<- data$temp_promedio_aire
temp_min<- data$temp_minima
temp_max<-data$temp_maxima
data_temp<-data.frame(fecha,temp_air,temp_min,temp_max)
data_temp

#9. Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.
fecha<- substr(x=data_temp$fecha,start = 1,stop = 7)
data_temp_2<- cbind(data_temp,fecha)
enero <- "2021-01"
l<- data_temp_2$fecha==enero
data_temp_2[l,]

#forma 2 
fecha <- substr(x=data_temp$fecha,start=1,stop = 7)
data_temp_enero2 <- data_temp[fecha=="2021-01",]
View(data_temp_enero2)

#10. Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.
min(data_temp_enero2$temp_min, na.rm = TRUE)
max(data_temp_enero2$temp_max,na.rm = TRUE)
mean(data_temp_enero2$temp_air,na.rm = TRUE)

#11. Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.
?cor
cor(data_temp[,2:4],use='complete.obs')

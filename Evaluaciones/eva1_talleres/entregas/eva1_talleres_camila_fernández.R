getwd()
#camila Fernandez 15-sep taller evaluacion
#Escriba un script en R que permita realizar lo siguiente:
  
  #1.(2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.
data_info<- read.csv2("Data/metadata_estaciones_agrometAPI.csv")
read.csv2("Data/metadata_estaciones_agrometAPI.csv")

#2.(2pt) Cuál es el nombre de las columnas de data_info
names(data_info)
colnames(data_info)
#3.(2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.
id <-48
r<-data_info$ema==id
data_info[r,]

#forma2
id<- c(25,40) #ejemplo para seleciionas mas de una estacion
r<- data_info$ema %in% id
data_info[r,]


#4.(2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data<- read.csv2("Data/48.csv")


#5.(2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de cada variable.
length(data) #cantidad de variables me entrega
dim(data) #dimension filas y columnas
class(data)
class(data$station_id)#extrae la columna y pregunta la clase de esa columna
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)

#resumen de la estructura  de los datos (int=entero)
str(data)

head(data) #muestra solo las primeras 6 filas para mostrar
tail(data) #6 ultimas filas

nrow(data) #filas
ncol(data) #columnas

#6.(2pt) Haga un resumen estadístico de todas las variables que contiene data.

summary(data) #resumen estadistico de cada variable.

#7.(3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.

range(data$fecha_hora)
#pregunta parentesis
 class(data$fecha_hora)
  as.POSIXct(data$fecha_hora) #vector lo transforma  de caracter en un tipo de dato fecha y hora
 
#8.(4pt) Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.
  
  
  fecha <- data$fecha_hora
  temp_aire<-data$temp_promedio_aire
  temp_min<-data$temp_minima
  temp_max<-data$temp_maxima
  
  data_temp<-data.frame(fecha,temp_aire,temp_min,temp_max)
  
  #forma 2
  data_temp<-data[,c(2,3,9,10)] #poiscion de las columnas que quiero entregar
  #forma 3
  data_temp<-data[,c("fecha_hora","temp_promedio_aire","temp_minima","temp_maxima")]

#9.(4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 
  
 
   fecha<- substr(x=data_temp$fecha_hora,start=1,stop=7) #extraiga entre el primero y el septimo
  data_temp_2 <-cbind (data_temp,fecha) #se juntaron columnas
  enero<- "2021-01" #meses que quiero consultar
  l<-data_temp_2$fecha==enero #indexa para preguntar cual tiene enero, todas las filas del mes de enero
  data_temp_enero<- data_temp_2[l,] #indexar l
summary(data_temp_enero) 
View(data_temp_enero)

#otraopcicion mas corta
#forma 2 
data_temp <- data[,c(2,3,9,10)]
fecha <- substr(x= data_temp$fecha_hora, start = 1, stop = 7)
data_temp_enero2 <- data_temp[fecha == "2021-01",]

  
  
#10.(2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.


max(data_temp_enero2$temp_maxima)
mean(data_temp_enero2$temp_promedio_aire, na.rm = TRUE)
max(data_temp_enero2$temp_maxima, na.rm = TRUE)
min(data_temp_enero2$temp_minima, na.rm = TRUE)



#11.(5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.

cor(data_temp[,2:4], use="complete.obs") # correlacionar dos variables, utiliza las filas completas.
  
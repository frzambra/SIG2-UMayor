#1° (2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.
 
#obtener la ruta de trabajo
getwd(
)
data_info <- read.csv2('data/metadata_estaciones_agrometAPI.csv')

read.csv2('data/metadata_estaciones_agrometAPI.csv')








#2° (2pt) Cuál es el nombre de las columnas de data_info

names(data_info)
colnames(data_info)

#3° (2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

id <- 28  #ema= estación 28   # el n° del lado izquierdo en el console es la posición del elemento
r <- data_info$ema == id # para obtener la fila y sus datos
r

data_info[r,]


# forma 2
id <- c(25,50) # para selccionar más de 1 estación
r <- data_info$ema %in% id
data_info[r,]

#4° (2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2('data/28.csv')

read.csv2('data/28.csv')


#5° (2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.


dim(data) #entrega la dimension del objeto, numero de filas y columnas
class(data)
class(data$station_id) # para cada variable

str(data) # resumen de la estructura de un data.frame
head(data) # head sirve para mostrar las 6 primeras filas
tail(data) # muestran las 6 ultimas filas
dim(data) # [filas, columnas]
nrow(data) # muestra el numero de filas
ncol(data) # muestra el numero de columnas = numero de variables




#6° (2pt) Haga un resumen estadístico de todas las variables que contiene data.


summary(data)
#NA DATOS NO DISPONIBLES

plot(density(x = na.omit))

#7° (3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.


range(data$fecha_hora)
class(data$fecha_hora)
as.POSIXct(data$fecha_hora, "%y-%e-%d") #para transformar el tipo de dato guardado en la variable
class(data$fecha_hora)
#8° (4pt) Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

fecha <- data$fecha_hora
temp_air <- data$temp_promedio_aire
temp_min <- data$temp_minima
temp_max <- data$temp_maxima

data_temp <- data.frame(fecha, temp_air,temp_min,temp_max)
data_temp

#forma 2
data_temp <- data[,c(2.3,9,10)]
data_temp

#forma 3
data_temp <- data[,c('fecha_hora', 'temp_promedio_aire', 'temp_minima', 'temp_maxima')]
data_temp

#9° (4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.
data_temp_enero <- 
fecha <- substr(x=data_temp$fecha_hora, start = 1, stop = 7)

data_temp2 <- cbind(data_temp, fecha)
enero <- "2021-01"
1 <- data_temp2$fecha == enero
data_temp_enero

#forma 2

data_tem <- data[,c('fecha_hora', 'temp_promedio_aire', 'temp_minima', 'temp_maxima')]
data_tem

fecha <- substr(x=data_tem$fecha_hora, start = 1, stop = 7)
fecha
data_temp_enero2 <- data_tem[fecha == "2021-01",]
data_temp_enero2
View(data_temp_enero2)


#10° (2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.
#TEMPERATURA PROMEDIO
mean(data_temp_enero2$temp_maxima, na.rm =TRUE)  #na.rm sirve para saber si se consideran o no los NA, los NA estan considerados
#TEMPERATURA MAX
max(data_temp_enero2$temp_maxima, na.rm =TRUE)
#TEMPERATURA MIN
min(data_temp_enero2$temp_maxima, na.rm =TRUE)


v <- c(1,2,3,NA)
max(v, na.rm =TRUE) # los NA se emplean cuando se considera verdadero el argumento, ESTA RESETEADO COMO FALSO 


#11° (5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.


?cor

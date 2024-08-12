# 1. (2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.

#obtener ruta de trabajo
getwd()

data_info <-read.csv2("metadata_estaciones_agrometAPI.csv")


# 2.Cuál es el nombre de las columnas de data_info
names(data_info)
colnames(data_info)

# 3.Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

#forma 1 , sirve para 1 estación
id <- 2

r <-data_info$ema == id

data_info[r,]


#forma 2, permite para más estaciones 

r <- data_info$ema %in% id

data_info[r,]


# 4. Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2("2.csv")
data

# 5.Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.

#hacer resumen por separado 

dim(data)
class(data)
class(data$station_id)
class(data$fecha_hora)
class(data$temp_promedio_aire)
class(data$precipitacion_horaria)

# un resumen de la estructura con str, todo al tiro 

str(data)
#funciones para inspeccionar, head inspeccionar lsa primeras 6 filas, las ultimas 6 filas (tail).
head(data)
tail(data)

# 6. Haga un resumen estadístico de todas las variables que contiene data.

# summary hace un resumen estadistico de cada variabble

summary(data)



# 7. Indique entre que rango de fechas se encuentran las observaciones del objeto data.

#range entrega el rango entre el maximo y el minimo de algo por ejemplo (fecha_hora)

range(data$fecha_hora)

# pregunta parentesis

class(data$fecha_hora)

#8. Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.


# forma 1 , posicion de las columnas
data_temp <- data[,c(2,3,9,10)]


# forma 2
data_temp <- data[,c("fecha_hora","temp_promedio_aire","temp_minima","temp_maxima")]
data_temp



# 9. Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.


#seleccionar solo la fecha de la cadena de texto de fecha_hora

fecha <- substr(x=data_temp$fecha_hora,start = 1, stop = 7)
data_temp_2 <- cbind(data_temp,fecha)
enero <- "2021-01"
l <- data_temp_2$fecha == enero
data_temp_enero <- data_temp[1,]

View(data_temp_enero)

# forma2, poco mas corta

fecha <- substr(x=data_temp$fecha_hora,start = 1, stop = 7)

data_temp_enero2 <- data_temp[fecha == "2021-01",]
View(data_temp_enero2)


# 10. Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.

# na.rm true no considera los NA 
#calcula la temperatura maxima sin considerar los NA
max(data_temp_enero2$temp_maxima, na.rm = TRUE)
#calcula la temperatura minima sin considerar los NA
min(data_temp_enero2$temp_maxima, na.rm = TRUE)
#calcula la temperatura promedio sin considerar los NA
mean(data_temp_enero2$temp_maxima, na.rm = TRUE)

#ejemplo con un vectorpr numerico con un NA
v <- c(1,2,3,NA)
max(v)
# setear como verdadero, para que no concidere NA 
max(v, na.rm = TRUE)


# 11.  Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.


#funcion cor permite crear una matriz de correlación

cor(data_temp[,2:4],use = "complete.obs")

names(data_temp)

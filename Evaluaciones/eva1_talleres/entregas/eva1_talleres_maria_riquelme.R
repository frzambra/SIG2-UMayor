# Nombre: Maria Riquelme

#1. (2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.

# Obtener la ruta de trabajo

data_info <- read.csv2("data/metadata_estaciones_agrometAPI.csv")

#2. (2pt) Cual es el nombre de las columnas de data_info.
names(data_info)
colnames(data_info)

#3. (2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longuitud de la estación.

id <- 32

#forma 1 

r <- data_info$ema == id

data_info[r,]

ide <- 
#forma 2 

r <- data_info$ema %in% id

data_info[r,]


# 4 (2pt)Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2("data/32.csv")

# 5. (2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.

dim(data)
class(data$station_id)
class(data$fecha_hora)
class(data$tem_promedio_aire)
class(data$precipitacion_horaria)

# un resumen de la estructura con str
str(data)

# funciones pra inspeccionar las primeras 6 filas (head) y las ultimas seis filas (tail)

head(data)
tail(data)
dim(data)
nrow(data)
ncol(data)

# 6. (2pt) Haga un resumen estadístico de todas las variables que contiene data.

summary(data) #sumary función que entrega un resumen estadistico de cada variable del data.frame

# 7. (3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.

range(data$fecha_hora)

# pregunta parentesis

class(data$fecha_hora)
as.POSIXct(data$fecha_hora,"%y-%m-%dT%HH:%MM:%SSZ")

as.POSIXct(data$fecha_hora,tz = "America/Santiago")

# 8. (4pt) Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

fecha <- data$fecha_hora
temp_air <- data$temp_promedio_aire
temp_min <- data$temp_minima
temp_max <- data$temp_maxima

data_temp<- data.frame(fecha,temp_air,temp_min,temp_max)
data_temp

# forma 2

data_temp <- data [,c(2,3,9,10)]

# forma 3

data_temp <- data[, c("fecha_hora","temp_promedio_aire","temp_minima","temp_maxima")]

# 9. (4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.

fecha <- substr(x=data_temp$fecha_hora,start = 1,stop =7)

data_temp_2 <- cbind(data_temp,fecha)
enero <- "2021-01"

l <- data_temp_2$fecha == enero

data_temp_enero <- data_temp[1,]

#forma 2, un poco más corta

fecha <- substr(x=data_temp$fecha_hora,start = 1, stop = 7)
data_temp_enero2 <- data_temp[fecha == "2021-01",]

View(data_temp_enero2)

# 10. (2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.

# calcular la temperatura maxima sin considerar los NA
max(data_temp_enero2$temp_maxima, na.rm = TRUE)

# calcular la temperatura minima sin considerar los NA
min(data_temp_enero2$temp_maxima,na.rm = TRUE)

# calcular el promedio sin considerar los NA
mean(data_temp_enero2$temp_promedio_aire, na.rm = TRUE)

#ejemplo con un vectorpr numerico con un NA
v <- c(1,2,3,NA)
max(v)
max(v, na.rm = TRUE)

# 11. (5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.
cor(data_temp[,2:4],use = "complete.obs")


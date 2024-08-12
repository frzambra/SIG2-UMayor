################Evaluacion 1 Talleres 
#Belen Urrea Coa  



#Ejercicio 1 : (2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info. #Obtener la ruta de trabajo 
getwd() #(me dice desde donde estoy trabajando)

data_info <- read.csv2('data/metadata_estaciones_agrometAPI.csv')
read.csv2('data/metadata_estaciones_agrometAPI.csv')


#Ejercicio 2 : 2pt) Cuál es el nombre de las columnas de data_info
names(data_info)
colnames(data_info)


#Ejercicio 3 :  (2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.
#Para este ejercicio hay dos formas de hacerlo. A continucion la primera forma: 
id <- 12 
r <- data_info$ema==id
data_info[r,]

#Seguda forma para realizar el ejercicio , que es para seleccionar mas de 1 estacion
r <- data_info$ema %in% id 
data_info[r,]



#Ejercicio 4 :  (2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

data <- read.csv2('data/12.csv')
data


#Ejercicio 5 :  (2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.
#Dim me entrega la dimension del objeto, parte or filas y despues por columnas. 
dim(data) #numero de filas y columnas 

class(data)
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
class(data$direccion_del_viento).......

#Una forma abreviada de hacer este procedimiento es usando la fuincion str , en vez de preguntar por cada columna u objeto
str(data)
#Existen algunas funciones que me ayudaran a ispeccionar las 6 primeras filas y las 6 ultimas filas (orden respectivamente)
head(data) # 6 primeras 
tail(data) #6 ultimas 

#Ejercicio 6 :  (2pt) Haga un resumen estadístico de todas las variables que contiene data.
summary(data) 


# Ejercicio 7: (3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.
range(data$fecha_hora)

#
#Pregunta parentesis 
#¿Que tipo de dato entrega fecha y hora? Es de tipo character , por lo tanto no puedo hacer operaciones con esta columna, por lo tanto se debe transformar 
#as..posixct me va a transformar de carcater a un tipo de fecha y hora 
as.POSIXct(data$fecha_hora,"")
#


# Ejercicio 8: (4pt) Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.
fecha <- data$fecha_hora
temp_air <- data$temp_promedio_aire
temp_min <- data$temp_minima
temp_max <- data$temp_maxima

data_temp <- data.frame(fecha, temp_air, temp_min, temp_max)
 
#opcion 2 (forma más abreviada, que vale más puntos)
data_temp <- data[,c(2,3,9,10)]
data_temp
#Opcion 3 
data_temp <- data[,c('fecha_hora', 'temp_promedio_aire', 'temp_minima', 'temp_maxima')]
data_temp

# Ejercicio 9: (4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.
#La funcion substr ayuda a cortar las cadenas de texto, en este caso le digo que me extraiga entre el primero y el septimo 
fecha <- substr(x=data_temp$fecha_hora, start = 1 , stop = 7)
data_temp_2 <- cbind(data_temp, fecha)
enero <- "2021-01"
l <- data_temp_2$fecha == enero
data_temp_enero <- data_temp_2[1,]

#Opcion 2 de resolucion 
fecha <- substr(x=data_temp$fecha_hora, start = 1 , stop = 7)
data_temp_enero2 <- data_temp[fecha == "2021-01",]



#Ejercicio 10: (2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.
#Calcula la temperatura axima sin considerar los NA 
max(data_temp_enero2$temp_maxima, na.rm = TRUE)

#Calcula la temp minima sin conderar NA
min(data_temp_enero2$temp_minima, na.rm= TRUE)

#
mean(data_temp_enero2$temp_promedio_aire, na.rm = TRUE)


#######ejemplo con un veCtor numerico con un NA 
v <- c(1,2,3,NA)
max(v)
max(v, na.rm = TRUE) #AL colocar na.rm = true, significa que no debe considerar NA 


#Ejercicio 11:(5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.

data_temp
cor(data_temp[,2:4], use='complete.obs')
#COMENTARIO: use='complete.obs' , significa que los NA no seran considerados para el calculo 

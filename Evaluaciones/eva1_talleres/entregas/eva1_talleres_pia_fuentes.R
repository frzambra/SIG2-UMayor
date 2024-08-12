#Pia Fuentes.

#1. (2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.

#verificar la ruta del directorio de trabajo.
getwd() #Tiene que ser una ruta de una carpeta que contenga la carpeta data, en donde estan los archivos de trabajo. Cree la carpeta en rstudio en el panel misc.


#Asignar el archivo metadata_estaciones_agrometAPI.csv a data_info
data_info <- read.csv2('data/metadata_estaciones_agrometAPI.csv')
read.csv2('data/metadata_estaciones_agrometAPI.csv')

#PREGUNTA: ¿Por qué no me funciona desde los archivos del computador?

#2. (2pt) ¿Cuál es el nombre de las columnas de data_info?

class(data_info)
names(data_info)
colnames(data_info)

#3. (2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

#Debe utilizar la estacion con código ema = 44.
#Hay dos formas de resolverlo.

id<- 44

#1
r <- data_info$ema==id
r
data_info[r,]

#2 para realizar el ejercicio , que es para seleccionar mas de 1 estacion
r <- data_info$ema %in% id  #Asignar un data frame con valores lógicos, donde TRUE es cuando la variable de ema es igual al id
data_info[r,]

#4. (2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.
#Asignar el archivo 44.csv al objeto data
data <- read.csv2('/cloud/project/data/archivos_por_estacion/44.csv')
data

#preguntar por qué no me fucniona solo colocando 'data'

#5. (2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.

#forma rápida.
str(data) #Indica un resumen de la estructura de data y saber qué clases de variables tiene. 

#Para ver las 6 primeras filas y las 6 ultimas filas.
head(data) # 6 primeras 
tail(data) #6 ultimas 

dim(data) #Para saber sólo la dimensión del data.frame
nrow(data) #Para saber sólo el número de filas
ncol(data) #Para saber sólo el número de columnas

#forma larga seria con la función class() para cada uno. Ej:
class(data)
class(data$station_id)
class(data$fecha_hora)

#6. (2pt) Haga un resumen estadístico de todas las variables que contiene data.

summary(data) #Entrega un resumen estadístico
plot(density(na.omit(data$temp_promedio_aire))) #ejemplo de gráfico


#7. (3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.

range(data$fecha_hora)

class(data$fecha_hora) #Es una columna de clase character


#Pregunta hipotetica.
#¿Que tipo de dato entrega fecha y hora? Character, así que no se puede hacer operaciones con esta columna. Se debe transformar con la fucnión as.POSIXct para pasar de charcater a un dato tipo fecha y hora.
as.POSIXct(data$fecha_hora,"")


#8. (4pt) Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.

#1. Utiliza los indices (la mejor forma).
data
data_temp <- data[,c(2,3,9,10)]
data_temp

#2. Utiliza los nombres.
data_temp <- data[,c("fecha_hora","temp_promedio_aire","temp_minima","temp_maxima")] 
data_temp


#9. (4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.

#Función 'substr' par acortar las cadenas de texto. Seleccionar sólo el texto "año-mes" de la cadena de texto de fecha_hora y asignarlo al objeto fecha
fecha <- substr(x=data_temp$fecha_hora,start=1,stop=7)

data_temp2 <- cbind(data_temp,fecha) #unir el objeto fecha como una columna adicional a data_temp

enero <- "2021-01" #Asignar la fecha deseada al objeto enero

l <- data_temp2$fecha == enero #Preguntar qué valores de la columna fecha son iguales a enero y asignar el resultado al objeto l2

(data_temp_enero <- data_temp2[l,]) #Indexar las filas que cumplan condición de que su fecha sea igual a "2021-01"
View(data_temp_enero)


#La forma resumida o más facil de hacer todos los pasos anteriores:
data_temp_enero2 <- data_temp[fecha=="2021-01",]
View(data_temp_enero2) #Genera el mismo resultado, pero sin tener que crear una nueva columna


#10. (2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.

#No considerar NA. 
summary(data_temp_enero) #calcular todos los valores simultaneamente.

#Paso a paso.
#Tmax
max(data_temp_enero2$temp_maxima, na.rm = TRUE) #'na-rm=TRUE' para no considerar NA.

#Tmin
min(data_temp_enero2$temp_minima, na.rm = TRUE)

#Promedio
mean(data_temp_enero2$temp_promedio_aire, na.rm = TRUE)


#11. (5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.


plot(data_temp) #diagrama de correlación 
?cor
data_temp
cor(data_temp[,2:4], use='complete.obs')#" use='complete.obs' " , significa que los NA no se considern para el cálculo.

